# Script generador de web simplificado
$OutputFile = "index.html"
$RootFolder = "content"

# Cabecera HTML simple
$Header = "<!DOCTYPE html>
<html lang='es'>
<head>
    <meta charset='UTF-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
    <title>Laboratorio Web</title>
    <style>
        body { font-family: sans-serif; background-color: #f0f2f5; padding: 20px; }
        header { text-align: center; margin-bottom: 30px; }
        .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; }
        .card { background: white; padding: 20px; border-radius: 8px; border-top: 5px solid #0366d6; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .card h2 { color: #0366d6; border-bottom: 1px solid #eee; padding-bottom: 10px; margin-top: 0; }
        .file-link { display: block; padding: 8px 0; color: #333; text-decoration: none; border-bottom: 1px dashed #eee; }
        .file-link:hover { color: #0366d6; background-color: #f6f8fa; padding-left: 5px; }
    </style>
</head>
<body>
    <header>
        <h1>Inventario de Practicas Web</h1>
    </header>
    <div class='grid'>"

$BodyContent = ""

# Verificamos que la carpeta content existe
if (Test-Path ".\$RootFolder") {
    $Folders = Get-ChildItem -Path ".\$RootFolder" -Directory

    ForEach ($Folder in $Folders) {
        $BodyContent += "<div class='card'>"
        # Usamos concatenacion simple para evitar errores
        $BodyContent += "<h2>CARPETA: " + $Folder.Name + "</h2>"
        
        $HtmlFiles = Get-ChildItem -Path $Folder.FullName -Filter *.html
        
        If ($HtmlFiles.Count -eq 0) {
            $BodyContent += "<small style='color:red'>Vacio (Sin HTML)</small>"
        } Else {
            ForEach ($File in $HtmlFiles) {
                # Ruta web
                $WebPath = "$RootFolder/$($Folder.Name)/$($File.Name)"
                $BodyContent += "<a href='$WebPath' class='file-link'>$($File.Name)</a>"
            }
        }
        $BodyContent += "</div>"
    }
} else {
    Write-Host "ERROR: No encuentro la carpeta 'content'. Revisa que la hayas creado." -ForegroundColor Red
}

$Footer = "</div><footer style='text-align:center; margin-top:40px; color:#999'>Generado automaticamente</footer></body></html>"

# Guardar archivo
$FinalHTML = $Header + $BodyContent + $Footer
$FinalHTML | Out-File -FilePath $OutputFile -Encoding utf8

Write-Host "EXITO: Web generada correctamente. Abre el archivo index.html" -ForegroundColor Green