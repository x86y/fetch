Sp ← ((⊢-˜+`×¬)∘=⊔⊢)
Read ← (@+10) Sp {1⊑•Sh "cat"‿𝕩}
Col ← {∾⟨@+27,"[38;5;",•Repr𝕨,"m",𝕩,@+27,"[0m"⟩} # credit: dzaima

os ← ⊑{∨´"PRETTY_NAME"⍷𝕩}¨⊸/ •file.Lines "/etc/os-release"
os ↩ •BQN 1⊑'='Sp os
ker ← 2⊑' 'Sp ⊑ 1 Read "/proc/version"
cpu ← 1⊑':'Sp⊑{∨´"model name"⍷𝕩}¨⊸/ Read "/proc/cpuinfo"

mem ← Read "/proc/meminfo"
memtotal ← ⊑{∨´"MemTotal"⍷𝕩}¨⊸/  mem
memtotal ↩ ⌈ (•BQN ¯2⊑' 'Sp 1⊑':'Sp memtotal) ÷ 1024⋆2
memused  ← ⊑{∨´"MemAvailable"⍷𝕩}¨⊸/  mem
memused  ↩ memtotal - ⌈ (•BQN ¯2⊑' 'Sp 1⊑':'Sp memused) ÷ 1024⋆2

uptime ← •BQN {(∧`∾(<" ")≠𝕩)⊸/𝕩} ⊑ Read "/proc/uptime"
hrs‿mins ← uptime ÷ 60⋆2+↕2

pkgs ← ≠∾ •file.List¨(<"/var/db/pkg/")∾¨•file.List "/var/db/pkg"

•Out∘∾¨ [
  <(123  Col "OS           ")‿os,
  <(200  Col "Kernel       ")‿ker,
  <(150  Col  "CPU         ")‿cpu,
  <(180  Col "Memory       ")‿(•Fmt memused)‿"/"‿(•Fmt memtotal)‿" GBs",
  <(140  Col "Uptime       ")‿(•Fmt ⌊hrs)‿"h "‿(•Fmt ⌈mins×60)‿"m",
  <(5    Col "Packages     ")‿(•Fmt pkgs)‿" (emerge)",
]
