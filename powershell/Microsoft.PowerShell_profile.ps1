Add-Type -Path "C:\\Users\\nickvd\\Documents\\WindowsPowerShell\\Colorful.Console.dll" | Out-Null
Add-Type -AssemblyName System.Drawing

function prompt {
    $origLastExitCode = $LASTEXITCODE
    
    $curPath = $ExecutionContext.SessionState.Path.CurrentLocation.Path
    $curPath = $curPath.Replace($HOME, "~")
    
    [Colorful.Console]::WriteFormatted(([Environment]::UserName),[System.Drawing.Color]::DarkOrange)
    [Colorful.Console]::Write("@")
    [Colorful.Console]::WriteFormatted([System.Net.Dns]::GetHostName().ToLower(), [System.Drawing.Color]::Gold)
    [Colorful.Console]::Write("(win): ")
    [Colorful.Console]::WriteFormatted($curPath, [System.Drawing.Color]::DarkGreen)
    Write-VcsStatus
    Write-Host ""
    $LASTEXITCODE = $origLastExitCode   
    "$('$' * ($nestedPromptLevel + 1)) "
}

Import-Module z
Import-Module posh-git

$global:GitPromptSettings.BranchAheadStatusForegroundColor = [System.ConsoleColor]::Cyan
$global:GitPromptSettings.BeforeForegroundColor = [System.ConsoleColor]::White
$global:GitPromptSettings.BeforeText = ' on '
$global:GitPromptSettings.AfterText  = ''

Start-SshAgent -Quiet

Set-Alias Ssh-Agent "$env:ProgramFiles\git\usr\bin\ssh-agent.exe"
Set-Alias Ssh-Add "$env:ProgramFiles\git\usr\bin\ssh-add.exe"

Set-Alias g git
Set-Alias which Get-Command

# Functions
$PROFILEPATH = ($PROFILE | Split-Path)
. $PROFILEPATH/sudo.ps1
. $PROFILEPATH/Get-Uptime.ps1