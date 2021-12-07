Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2D946C40B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 20:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbhLGT7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 14:59:09 -0500
Received: from foss.arm.com ([217.140.110.172]:40222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhLGT7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 14:59:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 119CC1063;
        Tue,  7 Dec 2021 11:55:37 -0800 (PST)
Received: from [192.168.122.166] (U203867.austin.arm.com [10.118.30.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4F2D3F73B;
        Tue,  7 Dec 2021 11:55:36 -0800 (PST)
Message-ID: <4a6a3e59-ac73-e1f9-aef5-912f6eb09393@arm.com>
Date:   Tue, 7 Dec 2021 13:54:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Mark Rutland <mark.rutland@arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Subject: HYPVER-V/arm64 guest on win11/8cx based laptop dead hang
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been trying to validate fedora as a hyper-V guest on a QC 8cx based 
laptop (lenvovo 5g) running the latest public Win11 builds and 
5.15/5.16rc3.

The linux guest gets as far as the point where the kernel prints 
"Freeing unused kernel memory:" and hangs (sysrq then won't respond to 
dump stacks/etc). Passing rodata=off gets it past the point where it 
updates the pagetables. If the hyper-v storage drivers are built in, it 
will hang shortly after discovering the disk. Building the disk driver 
as module, or blacklisting storvsc_drv_init, will then get it far enough 
to start systemd/or drop to bash at some of the early rd.break points, 
but the system will hang long before it tries to pivot to the rootfs 
(sometimes even if the storsvc isn't loaded with 5.15). I've pulled 
various knobs, including reducing it to a single core, defconfig+hyperV, 
CONFIG_DEBUG_VIRTUAL, looking for a config that reproduces what I 
understand was that out of tree versions of the HYPER-V patches were 
working on this hardware. I'm also fairly sure that other people are 
seeing a similar problem with the merged set on similar hardware 
platforms (window on arm laptops).

So, the rodata hint makes me think there might be something going on 
with the host, but I don't have a good way to debug 
windows+hyper-v+guest. Any suggestions? Has anyone else had any luck 
running mainline + defconfig as a hyper-v guest? What hardware + .config?

Below I've pasted the defconfig with HYPERV+drivers enabled, and 
DEBUG_VIRTUAL log. The test_debug_virtual_init() splat is AFAIK just the 
testing code to assure that DEBUG_VIRTUAL is working and not related to 
this.



Thanks,


[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x51df804e]
[    0.000000] Linux version 5.16.0-rc3-00227-g5f58da2befa5-dirty 
(jlinton@uriel.jhome.net) (aarch64-linux-gn 
 
                           u-gcc (GCC) 11.2.1 20210728 (Red Hat Cross 
11.2.1-1), GNU ld version 2.37-2.fc35) #124 SMP PREEMPT Mon Dec 6 
 
                                                  15:14:42 CST 2021
[    0.000000] earlycon: pl11 at MMIO 0x00000000effec000 (options '')
[    0.000000] printk: bootconsole [pl11] enabled
[    0.000000] efi: EFI v2.70 by EDK II
[    0.000000] efi: ACPI=0x7fffa000 ACPI 2.0=0x7fffa014 
SMBIOS=0x7ffd6000 SMBIOS 3.0=0x7ffd4000 MEMATTR=0x7f2 
 
                                     2fa98 RNG=0x7ffdaa18 
MEMRESERVE=0x7ebe0118
[    0.000000] efi: seeding entropy pool
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000000007FFFA014 000024 (v02 VRTUAL)
[    0.000000] ACPI: XSDT 0x000000007FFF90E8 00005C (v01 VRTUAL MICROSFT 
00000001 MSFT 00000001)
[    0.000000] ACPI: FACP 0x000000007FFF7000 000114 (v06 VRTUAL MICROSFT 
00000001 MSFT 00000001)
[    0.000000] ACPI: DSDT 0x000000007EE29000 01DEAD (v02 MSFTVM DSDT01 
00000001 MSFT 05000000)
[    0.000000] ACPI: DBG2 0x000000007FFF8000 000072 (v00 VRTUAL MICROSFT 
00000001 MSFT 00000001)
[    0.000000] ACPI: GTDT 0x000000007FFF6000 000060 (v02 VRTUAL MICROSFT 
00000001 MSFT 00000001)
[    0.000000] ACPI: OEM0 0x000000007FFF5000 000064 (v01 VRTUAL MICROSFT 
00000001 MSFT 00000001)
[    0.000000] ACPI: APIC 0x000000007FFF4000 000094 (v04 VRTUAL MICROSFT 
00000001 MSFT 00000001)
[    0.000000] ACPI: SRAT 0x000000007FFF3000 000222 (v03 VRTUAL MICROSFT 
00000001 MSFT 00000001)
[    0.000000] ACPI: BGRT 0x000000007ECAD000 000038 (v01 VRTUAL MICROSFT 
00000001 MSFT 00000001)
[    0.000000] NUMA: Failed to initialise from firmware
[    0.000000] NUMA: Faking a node at [mem 
0x0000000000000000-0x000000007fffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x7fb99b80-0x7fb9bfff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x000000007fffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000007eef1fff]
[    0.000000]   node   0: [mem 0x000000007eef2000-0x000000007ef1afff]
[    0.000000]   node   0: [mem 0x000000007ef1b000-0x000000007ff9afff]
[    0.000000]   node   0: [mem 0x000000007ff9b000-0x000000007fff2fff]
[    0.000000]   node   0: [mem 0x000000007fff3000-0x000000007fffafff]
[    0.000000]   node   0: [mem 0x000000007fffb000-0x000000007fffefff]
[    0.000000]   node   0: [mem 0x000000007ffff000-0x000000007fffffff]
[    0.000000] Initmem setup node 0 [mem 
0x0000000000000000-0x000000007fffffff]
[    0.000000] cma: Reserved 32 MiB at 0x000000007a400000
[    0.000000] psci: probing for conduit method from ACPI.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v65535.65535
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x0 -> Node -1
[    0.000000] percpu: Embedded 20 pages/cpu s41304 r8192 d32424 u81920
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: Hardware dirty bit management
[    0.000000] CPU features: kernel page table isolation forced ON by KASLR
[    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
[    0.000000] CPU features: detected: ARM erratum 1418040
[    0.000000] CPU features: detected: ARM errata 1165522, 1319367, or 
1530923
[    0.000000] Fallback order for Node 0: 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 516096
[    0.000000] Policy zone: DMA
[    0.000000] Kernel command line: 
BOOT_IMAGE=(hd0,gpt2)/vmlinuz-5.16.0-rc3-00227-g5f58da2befa5-dirty 
root=U 
 
UID=0d83e51c-61e5-4fa0-921e-7c09d23f20b2 ro console=ttyAMA0 
earlycon=pl011,0xeffec000
[    0.000000] Unknown kernel command line parameters 
"BOOT_IMAGE=(hd0,gpt2)/vmlinuz-5.16.0-rc3-00227-g5f58da 
 
                                       2befa5-dirty", will be passed to 
user space.
[    0.000000] Dentry cache hash table entries: 262144 (order: 9, 
2097152 bytes, linear)
[    0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048576 
bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 1962588K/2097152K available (16000K kernel code, 
3208K rwdata, 8572K rodata, 6528K ini 
 
                     t, 506K bss, 101796K reserved, 32768K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=256 to 
nr_cpu_ids=1.
[    0.000000]  Trampoline variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay 
is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: 32 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: 16 PPIs implemented
[    0.000000] GICv3: CPU0: found redistributor 0 region 
0:0x00000000effee000
[    0.000000] ITS: No ITS available, not enabling LPIs
[    0.000000] random: get_random_bytes called from 
start_kernel+0x474/0x65c with crng_init=0
[    0.000000] arch_timer: Enabling local workaround for ARM erratum 1418040
[    0.000000] arch_timer: cp15 timer(s) running at 19.20MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff 
max_cycles: 0x46d987e47, max_idle_ns: 44 
 
                        0795202767 ns
[    0.000002] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps 
every 4398046511078ns
[    0.016282] Console: colour dummy device 80x25
[    0.022744] ACPI: Core revision 20210930
[    0.026778] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 38.40 BogoMIPS (lpj 
 
                     =76800)
[    0.041476] pid_max: default: 32768 minimum: 301
[    0.046764] LSM: Security Framework initializing
[    0.051349] Mount-cache hash table entries: 4096 (order: 3, 32768 
bytes, linear)
[    0.060072] Mountpoint-cache hash table entries: 4096 (order: 3, 
32768 bytes, linear)
[    0.067755] ACPI PPTT: No PPTT table found, CPU and cache topology 
may be inaccurate
[    0.075599] Hyper-V: privilege flags low 0x2e7f, high 0x3a8030, hints 
0xe, misc 0x31e1
[    0.089579] Hyper-V: Host Build 10.0.22000.348-0-0
[    0.094531] rcu: Hierarchical SRCU implementation.
[    0.099039] Remapping and enabling EFI services.
[    0.103406] smp: Bringing up secondary CPUs ...
[    0.109560] smp: Brought up 1 node, 1 CPU
[    0.116676] SMP: Total of 1 processors activated.
[    0.123397] CPU features: detected: 32-bit EL0 Support
[    0.131677] CPU features: detected: CRC32 instructions
[    0.139229] CPU features: detected: RCpc load-acquire (LDAPR)
[    0.144902] CPU features: detected: LSE atomic instructions
[    0.150395] CPU features: detected: Privileged Access Never
[    0.247689] CPU: All CPU(s) started at EL1
[    0.253059] alternatives: patching kernel code
[    0.260741] devtmpfs: initialized
[    0.265165] KASLR enabled
[    0.268410] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 7645041785100000 n 
 
                           s
[    0.281974] futex hash table entries: 256 (order: 2, 16384 bytes, linear)
[    0.294603] pinctrl core: initialized pinctrl subsystem
[    0.300286] SMBIOS 3.1.0 present.
[    0.303373] DMI: Microsoft Corporation Virtual Machine/Virtual 
Machine, BIOS Hyper-V UEFI Release v4.1 05/ 
 
                           05/2021
[    0.314662] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.325930] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic 
allocations
[    0.333165] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for 
atomic allocations
[    0.340378] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for 
atomic allocations
[    0.347972] audit: initializing netlink subsys (disabled)
[    0.353509] thermal_sys: Registered thermal governor 'step_wise'
[    0.353511] thermal_sys: Registered thermal governor 'power_allocator'
[    0.360226] audit: type=2000 audit(0.000:1): state=initialized 
audit_enabled=0 res=1
[    0.380658] cpuidle: using governor menu
[    0.384624] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.395882] ASID allocator initialised with 32768 entries
[    0.405332] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.419589] Serial: AMBA PL011 UART driver
[    0.427426] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.438122] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[    0.450480] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.460162] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    0.470358] ACPI: Added _OSI(Module Device)
[    0.477765] ACPI: Added _OSI(Processor Device)
[    0.485113] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.492020] ACPI: Added _OSI(Processor Aggregator Device)
[    0.500495] ACPI: Added _OSI(Linux-Dell-Video)
[    0.508510] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.517245] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.531613] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.538104] ACPI: Interpreter enabled
[    0.541721] ACPI: Using GIC for interrupt routing
[    0.548623] ARMH0011:00: ttyAMA0 at MMIO 0xeffec000 (irq = 12, , and 
a few of the modules built into the kernel.base_baud = 0) is a SBSA
[    0.556676] printk: console [ttyAMA0] enabled
[    0.556676] printk: console [ttyAMA0] enabled
[    0.566252] printk: bootconsole [pl11] disabled
[    0.566252] printk: bootconsole [pl11] disabled
[    0.581421] ARMH0011:01: ttyAMA1 at MMIO 0xeffeb000 (irq = 13, 
base_baud = 0) is a SBSA
[    0.593131] iommu: Default domain type: Translated
[    0.599067] iommu: DMA domain TLB invalidation policy: strict mode
[    0.607651] vgaarb: loaded
[    0.611464] SCSI subsystem initialized
[    0.616524] ACPI: bus type USB registered
[    0.621833] usbcore: registered new interface driver usbfs
[    0.628691] usbcore: registered new interface driver hub
[    0.635836] usbcore: registered new device driver usb
[    0.642709] pps_core: LinuxPPS API ver. 1 registered
[    0.649160] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 
Rodolfo Giometti <giometti@linux.it>
[    0.664520] PTP clock support registered
[    0.670339] EDAC MC: Ver: 3.0.0
[    0.674802] Registered efivars operations
[    0.681590] hv_vmbus: Vmbus version:5.2
[    0.686807] No ACPI PMU IRQ for CPU0
[    0.691739] FPGA manager framework
[    0.696417] Advanced Linux Sound Architecture Driver Initialized.
[    0.705177] clocksource: Switched to clocksource arch_sys_counter
[    0.713247] VFS: Disk quotas dquot_6.6.0
[    0.718501] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 
bytes)
[    0.727772] pnp: PnP ACPI init
[    0.732497] pnp: PnP ACPI: found 0 devices
[    0.741744] NET: Registered PF_INET protocol family
[    0.748432] IP idents hash table entries: 32768 (order: 6, 262144 
bytes, linear)
[    0.758990] tcp_listen_portaddr_hash hash table entries: 1024 (order: 
2, 16384 bytes, linear)
[    0.770341] TCP established hash table entries: 16384 (order: 5, 
131072 bytes, linear)
[    0.782219] TCP bind hash table entries: 16384 (order: 6, 262144 
bytes, linear)
[    0.792038] TCP: Hash tables configured (established 16384 bind 16384)
[    0.800627] UDP hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.810027] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes, 
linear)
[    0.820687] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.829334] RPC: Registered named UNIX socket transport module.
[    0.838095] RPC: Registered udp transport module.
[    0.844639] RPC: Registered tcp transport module.
[    0.850732] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.859894] PCI: CLS 0 bytes, default 64
[    0.867493] Unpacking initramfs...
[    1.213569] Freeing initrd memory: 26056K
[    1.216812] hw perfevents: enabled with armv8_pmuv3_0 PMU driver, 1 
counters available
[    1.224221] kvm [1]: HYP mode not available
[    1.227506] Initialise system trusted keyrings
[    1.232575] workingset: timestamp_bits=42 max_order=19 bucket_order=0
[    1.240942] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    1.245063] NFS: Registering the id_resolver key type
[    1.248442] Key type id_resolver registered
[    1.251261] Key type id_legacy registered
[    1.256460] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    1.265219] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver 
Registering...
[    1.273934] SGI XFS with security attributes, no debug enabled
[    1.282442] 9p: Installing v9fs 9p2000 file system support
[    1.303102] Key type asymmetric registered
[    1.307672] Asymmetric key parser 'x509' registered
[    1.314468] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 245)
[    1.322951] io scheduler mq-deadline registered
[    1.329099] io scheduler kyber registered
[    1.334598] ------------[ cut here ]------------
[    1.340493] virt_to_phys used for non-linear address: 
(____ptrval____) (0xffff800010000000)
[    1.351463] WARNING: CPU: 0 PID: 1 at arch/arm64/mm/physaddr.c:12 
__virt_to_phys+0x60/0x80
[    1.362245] Modules linked in:
[    1.365965] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 
5.16.0-rc3-00227-g5f58da2befa5-dirty #124
[    1.376981] Hardware name: Microsoft Corporation Virtual 
Machine/Virtual Machine, BIOS Hyper-V UEFI Releas 
 
                                 e v4.1 05/05/2021
[    1.392549] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[    1.402597] pc : __virt_to_phys+0x60/0x80
[    1.408227] lr : __virt_to_phys+0x60/0x80
[    1.414162] sp : ffff80001000bd60
[    1.419307] x29: ffff80001000bd60 x28: 0000000000000000 x27: 
ffffad018d0804d0
[    1.430135] x26: ffffad018d141060 x25: ffffad018d141078 x24: 
ffffad018d066b50
[    1.439554] x23: ffffad018da09000 x22: 0000000000000000 x21: 
ffff1d6d00070000
[    1.449135] x20: ffffad018da54000 x19: ffff800010000000 x18: 
ffffffffffffffff
[    1.460536] x17: 666678302820295f x16: 5f5f5f6c61767274 x15: 
705f5f5f5f28203a
[    1.468301] x14: 7373657264646120 x13: ffffad018d702be8 x12: 
0000000000000255
[    1.477384] x11: 00000000000000c7 x10: ffffad018d702be8 x9 : 
ffffad018d702be8
[    1.485506] x8 : 00000000ffffefff x7 : ffffad018d75abe8 x6 : 
ffffad018d75abe8
[    1.494659] x5 : 000000000000bff4 x4 : 0000000000000000 x3 : 
0000000000000000
[    1.504277] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 
ffff1d6d00070000
[    1.512957] Call trace:
[    1.515954]  __virt_to_phys+0x60/0x80
[    1.521089]  test_debug_virtual_init+0x38/0xc0
[    1.527086]  do_one_initcall+0x50/0x1b0
[    1.532272]  kernel_init_freeable+0x20c/0x290
[    1.538281]  kernel_init+0x28/0x130
[    1.542407]  ret_from_fork+0x10/0x20
[    1.546507] ---[ end trace ad31c885a0530684 ]---
[    1.551787] PA: 0xffffd2feb5200000 for VA: 0xffff800010000000
[    1.559102] PA: 0x00000000011b9080 for VA: 0xffff1d6d011b9080
[    1.568298] ACPI: AC: AC Adapter [AC1] (on-line)
[    1.574905] ACPI: battery: Slot [BAT1] (battery present)
[    1.581058] EINJ: EINJ table not found.
[    1.590918] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.599946] SuperH (H)SCI(F) driver initialized
[    1.605482] msm_serial: driver initialized
[    1.611575] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    1.619978] loop: module loaded
[    1.623803] megasas: 07.719.03.00-rc1
[    1.628174] hv_vmbus: registering driver hv_storvsc
[    1.634014] SPI driver mtd_dataflash has no spi_device_id for atmel,at45
[    1.642351] SPI driver mtd_dataflash has no spi_device_id for 
atmel,dataflash
[    1.653658] libphy: Fixed MDIO Bus: probed
[    1.658746] tun: Universal TUN/TAP device driver, 1.6
[    1.664868] thunder_xcv, ver 1.0
[    1.668359] thunder_bgx, ver 1.0
[    1.671835] nicpf, ver 1.0
[    1.675111] hclge is initializing
[    1.678966] hns3: Hisilicon Ethernet Network Driver for Hip08 Family 
- version
[    1.688459] hns3: Copyright (c) 2017 Huawei Corporation.
[    1.695815] e1000: Intel(R) PRO/1000 Network Driver
[    1.701072] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    1.708856] e1000e: Intel(R) PRO/1000 Network Driver
[    1.715099] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.721267] igb: Intel(R) Gigabit Ethernet Network Driver
[    1.728309] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.735589] igbvf: Intel(R) Gigabit Virtual Function Network Driver
[    1.743664] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    1.749171] sky2: driver version 1.30
[    1.752706] scsi host0: storvsc_host_t
[    1.756402] VFIO - User Level meta-driver version: 0.3
[    1.761424] scsi 0:0:0:0: Direct-Access     Msft     Virtual Disk 
1.0  PQ: 0 ANSI: 5
[    1.768898] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.774913] ehci-pci: EHCI PCI platform driver
[    1.779033] ehci-platform: EHCI generic platform driver
[    1.784014] ehci-orion: EHCI orion driver
[    1.787827] ehci-exynos: EHCI Exynos driver
[    1.792644] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.798261] ohci-pci: OHCI PCI platform driver
[    1.802397] ohci-platform: OHCI generic platform driver
[    1.807507] ohci-exynos: OHCI Exynos driver
[    1.811479] usbcore: registered new interface driver usb-storage
[    1.817135] hv_vmbus: registering driver hyperv_keyboard
[    1.822559] sd 0:0:0:0: [sda] 41943040 512-byte logical blocks: (21.5 
GB/20.0 GiB)
[    1.829035] input: AT Translated Set 2 keyboard as 
/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0004:00/VMBUS:00/d 
 
 
34b2567-b9b6-42b9-8778-0a4ec0b955bf/serio0/input/input0
[    1.844322] rtc-efi rtc-efi.0: registered as rtc0
[    1.848802] rtc-efi rtc-efi.0: setting system clock to 
2021-12-07T19:25:15 UTC (1638905115)
[    1.858623] i2c_dev: i2c /dev entries driver
[    1.864400] sd 0:0:0:0: [sda] Write Protect is off
[    1.868888] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    1.875876] sdhci: Secure Digital Host Controller Interface driver
[    1.880540] sdhci: Copyright(c) Pierre Ossman
[    1.883822] Synopsys Designware Multimedia Card Interface Driver
[    1.887970] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.891991] ledtrig-cpu: registered to indicate activity on CPUs
[    1.896303] efifb: probing for efifb
[    1.898935] efifb: framebuffer at 0xe0000000, using 3072k, total 3072k
[    1.903716] efifb: mode is 1024x768x32, linelength=4096, pages=1
[    1.911559] efifb: scrolling: redraw
[    1.916366] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.927411] Console: switching to colour frame buffer device 128x48
[    1.932939] fb0: EFI VGA frame buffer device
[    1.940854] pstore: Registered efi as persistent store backend
[    1.945196] SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
[    1.949762] usbcore: registered new interface driver usbhid
[    1.953502] usbhid: USB HID core driver
[    1.956786] NET: Registered PF_PACKET protocol family
[    1.960497] 9pnet: Installing 9P2000 support
[    1.964283] Key type dns_resolver registered
[    1.967977] Loading compiled-in X.509 certificates
[    1.971671] pstore: Using crash dump compression: deflate
[    1.979335] ALSA device list:
[    1.981369]   No soundcards found.









