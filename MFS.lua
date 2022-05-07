local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

local maps = game.Workspace.Maps
local Table = {};
local character = game.Players.LocalPlayer.Character
for Index, Value in ipairs(maps:GetChildren()) do
   table.insert(Table, Value.Name)
end

local mobs = game.Workspace.Maps["Gothic City"].EnemyFolder
local TableB = {};

for Index, Value in ipairs(mobs:GetChildren()) do
   table.insert(TableB, Value.Name)
end


local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
wait(1)
vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)


getgenv().autoClick = false;
getgenv().autoArena = false;
getgenv().autoBuy = false;
getgenv().caca = false;
getgenv().autoFarm = false;

local Window = Library.CreateLib("I ❤ Men", "BloodTheme")

local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("stuff")
Section:NewToggle("auto click", "ToggleInfo", function(state)
    getgenv().autoClick = state
    if state then
        autoClick();
    end
end)

    function autoClick()
        spawn(function()
            while getgenv().autoClick == true do
                game:GetService("ReplicatedStorage").Remotes.HeroRemotes.AttackClick:InvokeServer()
                wait(0.01)
            end    
        end)
    end
Section:NewDropdown("Select Egg", "nil", {unpack(Table)}, function(currentOption)
    function autoBuy()
        spawn(function()
            while getgenv().autoBuy == true do
                game:GetService("ReplicatedStorage").Remotes.InventoryRemotes.HeroRoll:InvokeServer(currentOption)
                wait(0.3)
            end    
        end)
    end 
end)
Section:NewToggle("Auto Egg", "ToggleInfo", function(state)
    getgenv().autoBuy = state
    if state then
        autoBuy();
    end
end)
local TabB = Window:NewTab("Arena")
local SectionB = TabB:NewSection("auto arena - (disable auto farm)")
SectionB:NewToggle("auto arena (last map)", "ToggleInfo", function(stateb)
    getgenv().autoArena = stateb
    if stateb then
        autoArena(); --Teleports you into the arena
        wait(2)
        local indicator = game.Workspace.Arenas["Gothic City"].IntermissionTimer.TimerGui.TextLabel
        arenafarm();
        while match.Value > 0 do
            wait(0.1)
            for _,v in next, (game.Workspace.Arenas["Gothic City"].ArenaEnemies:GetChildren()) do
                if not v.Dead.Value then
                    game:GetService("ReplicatedStorage").Remotes.HeroRemotes.AttackEnemy:FireServer(v)
                    character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                    break
                end 
            end 
        end     
    end
end)

SectionB:NewToggle("ARENA FARM - REJOIN to disable", "ToggleInfo", function(statec)
    getgenv().caca = statec
    if statec then
        local match = game.Workspace.Arenas.MatchTimer
        while true do
            wait(0.1)
            while match.Value > 0 do
                wait(0.1)
                for _,v in next, (game.Workspace.Arenas["Gothic City"].ArenaEnemies:GetChildren()) do
                   if not v.Dead.Value then
                        wait(2)
                        game:GetService("ReplicatedStorage").Remotes.HeroRemotes.AttackEnemy:FireServer(v)
                        character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                        break
                    end 
                end 
            end
        end
    else
        return
    end
end)

local Uis = game:GetService("UserInputService")
Uis.InputBegan:Connect(function(input, index)
    if input.KeyCode == Enum.KeyCode.LeftControl then
        Library:ToggleUI()
    end
end)


local aopen = game.Workspace.Arenas.ArenaOpen
function autoArena()
    spawn(function()
        while getgenv().autoArena == true do
			wait(0.1)
			if aopen.Value == true then				
				game:GetService("ReplicatedStorage").Remotes.ArenaRemotes.JoinArena:InvokeServer()
				wait(0.3)
				game:GetService("ReplicatedStorage").Remotes.LocationRemotes.RespawnRequest:FireServer()
                wait(2)
            end
		end
    end)
end
local match = game.Workspace.Arenas.MatchTimer
function arenafarm()
    spawn(function()
        while getgenv().autoArena == true do
            wait(0.1)
            local indicator = game.Workspace.Arenas["Gothic City"].IntermissionTimer.TimerGui.TextLabel
            while indicator.Text == "STARTS IN 00:00" do
                wait(0.1)
                for _,v in next, (game.Workspace.Arenas["Gothic City"].ArenaEnemies:GetChildren()) do
                    if not v.Dead.Value then
                        game:GetService("ReplicatedStorage").Remotes.HeroRemotes.AttackEnemy:FireServer(v)
                        character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                        break
                    end 
                end 
            end
            while match.Value > 0 do
                wait(0.1)
                for _,v in next, (game.Workspace.Arenas["Gothic City"].ArenaEnemies:GetChildren()) do
                    if not v.Dead.Value then
                        game:GetService("ReplicatedStorage").Remotes.HeroRemotes.AttackEnemy:FireServer(v)
                        character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                        break
                    end 
                end 
            end
        end
    end)
end

local Tab3 = Window:NewTab("Farm")
local Section3 = Tab3:NewSection("farming (disable it for auto arena)")
Section3:NewDropdown("Select Mob", "nil", {unpack(TableB)}, function(currentOption)
    function autoFarm()
        spawn(function()
            while getgenv().autoFarm == true do
                game:GetService("ReplicatedStorage").Remotes.HeroRemotes.AttackEnemy:FireServer(mobs:FindFirstChild(currentOption))
                wait(0.3)
                if statet then
                    character.HumanoidRootPart.CFrame = mobs:FindFirstChild(currentOption).HumanoidRootPart.CFrame
                end
            end   
        end)
    end 
end)
Section3:NewToggle("Auto Farm", "ToggleInfo", function(state)
    getgenv().autoFarm = state
    if state then
        autoFarm();
    end
end)
