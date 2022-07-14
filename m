Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAF2574BF1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238773AbiGNL0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238779AbiGNL01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:26:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 424F259277;
        Thu, 14 Jul 2022 04:26:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A569B139F;
        Thu, 14 Jul 2022 04:26:14 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.85.183])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 328C83F792;
        Thu, 14 Jul 2022 04:26:12 -0700 (PDT)
Date:   Thu, 14 Jul 2022 12:26:05 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: FVP: kernel BUG at arch/arm64/kernel/traps.c:497 - Internal
 error: Oops - BUG: 0
Message-ID: <Ys/9TSV5muvKXN6W@FVFF77S0Q05N>
References: <CA+G9fYtOX-6=f70FA5PuDVA=kX=2L4spXKXS8=LHkUphafXowg@mail.gmail.com>
 <Ys1g8PH4M2W7Z50U@sirena.org.uk>
 <CA+G9fYu7mJ6X3_xhboODP_cjABE4QTJCON_NMduQ60x4Z7N78Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYu7mJ6X3_xhboODP_cjABE4QTJCON_NMduQ60x4Z7N78Q@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 01:07:32AM +0530, Naresh Kamboju wrote:
 
> Here I am providing the available data.
> Let me know what I am missing here, so that I will update my setup.
> Thanks in advance.
> 
> Fast Models 11.17.21 (Feb 16 2022)
> 
> https://storage.tuxboot.com/fvp-aemva/tf-bl1.bin
> https://storage.tuxboot.com/fvp-aemva/fvp-base-revc.dtb
> https://storage.tuxboot.com/fvp-aemva/fip-uboot.bin
> https://builds.tuxbuild.com/2BnQMpJj3kDTJXoCwd2pY5gW9CN/Image.gz
> https://builds.tuxbuild.com/2BnQMpJj3kDTJXoCwd2pY5gW9CN/modules.tar.xz

I had a go with these files...

> /opt/model/FVP_AEMvA/models/Linux64_GCC-9.3/FVP_Base_RevC-2xAEMvA
>   --plugin /opt/model/FVP_AEMvA/plugins/Linux64_GCC-9.3/ScalableVectorExtension.so
>   --data cluster0.cpu0=/tuxrun-r4_1075p-lava-1/fvp-base-revc.dtb@0x86000000
>   --data cluster0.cpu0=/tuxrun-r4_1075p-lava-1/Image@0x80080000
>    -C pctl.startup=0.0.0.0
>    -C bp.secure_memory=0
>    -C cluster0.NUM_CORES=4
>    -C cluster1.NUM_CORES=4
>    -C cache_state_modelled=0
>    -C bp.smsc_91c111.enabled=true
>    -C bp.pl011_uart0.untimed_fifos=1
>    -C bp.pl011_uart0.unbuffered_output=1
>    -C bp.secureflashloader.fname='/tuxrun-r4_1075p-lava-1/tf-bl1.bin'
>    -C bp.flashloader0.fname='/tuxrun-r4_1075p-lava-1/fip-uboot.bin'
>    -C bp.ve_sysregs.mmbSiteDefault=0
>    -C bp.ve_sysregs.exit_on_shutdown=1
>    -C bp.virtioblockdevice.image_path='/tuxrun-r4_1075p-lava-1/https___storage.lkft.org_rootfs_oe-sumo_20220219_juno_rpb-console-image-lkft-juno-20220219023239.rootfs.ext4'
>    -C pci.pcidevice0.bus=0xFF
>    -C pci.pcidevice1.bus=0xFF
>    -C cluster0.has_large_system_ext=1
>    -C cluster1.has_large_system_ext=1
>    -C cluster0.has_16k_granule=1
>    -C cluster1.has_16k_granule=1
>    -C cluster0.has_branch_target_exception=1
>    -C cluster1.has_branch_target_exception=1
>    -C cluster0.has_rndr=1
>    -C cluster1.has_rndr=1
>    -C cluster0.has_arm_v8-1=1
>    -C cluster1.has_arm_v8-1=1
>    -C cluster0.has_arm_v8-2=1
>    -C cluster1.has_arm_v8-2=1
>    -C cluster0.has_arm_v8-3=1
>    -C cluster1.has_arm_v8-3=1
>    -C cluster0.has_arm_v8-4=1
>    -C cluster1.has_arm_v8-4=1
>    -C cluster0.has_arm_v8-5=1
>    -C cluster1.has_arm_v8-5=1
>    -C cluster0.has_arm_v8-6=1
>    -C cluster1.has_arm_v8-6=1

... and this command line (modulo paths, and providing my own bogus rootfs) ...

... and this boots as far as loading userspace on a couple of models I've tried
it on (though the latest internal model I have doesn't like the PCI options).

I note that your log has:

| Hit any key to stop autoboot:  1  0 
| smh_open: ERROR fd -1 for file 'boot.img'
| smh_open: ERROR fd -1 for file 'Image'
| smh_open: ERROR fd -1 for file 'devtree.dtb'
| smh_open: ERROR fd -1 for file 'ramdisk.img'

... whereas mine has:

| Hit any key to stop autoboot:  0   
| smh_open: ERROR fd -1 for file 'boot.img'
| loaded file Image from 80080000 to 82F299FF, 02EA9A00 bytes
| smh_open: ERROR fd -1 for file 'devtree.dtb'
| smh_open: ERROR fd -1 for file 'ramdisk.img'
| fdt - flattened device tree utility commands

... and I wonder if that has something to do with it, given it appears that
your Image is corrupted somehow.

Full log below.

Thanks,
Mark.

---->8----

NOTICE:  Booting Trusted Firmware
NOTICE:  BL1: v2.5(debug):v2.5
NOTICE:  BL1: Built : 09:39:44, Apr  8 2022
INFO:    BL1: RAM 0x4035000 - 0x403c000
INFO:    Loading image id=31 at address 0x4001010
INFO:    Image id=31 loaded: 0x4001010 - 0x40011e8
INFO:    FCONF: Config file with image ID:31 loaded at address = 0x4001010
INFO:    Loading image id=24 at address 0x4001300
INFO:    Image id=24 loaded: 0x4001300 - 0x400156c
INFO:    FCONF: Config file with image ID:24 loaded at address = 0x4001300
INFO:    BL1: Loading BL2
INFO:    Loading image id=1 at address 0x4022000
INFO:    Image id=1 loaded: 0x4022000 - 0x402a779
NOTICE:  BL1: Booting BL2
INFO:    Entry point address = 0x4022000
INFO:    SPSR = 0x3c5
INFO:    FCONF: Reading FW_CONFIG firmware configuration file from: 0x4001010
INFO:    FCONF: Reading firmware configuration information for: dyn_cfg
INFO:    FCONF: Reading TB_FW firmware configuration file from: 0x4001300
NOTICE:  BL2: v2.5(debug):v2.5
NOTICE:  BL2: Built : 08:01:44, May  2 2022
INFO:    BL2: Doing platform setup
INFO:    Configuring TrustZone Controller
INFO:    Total 4 regions set.
INFO:    BL2: Loading image id 3
INFO:    Loading image id=3 at address 0x4003000
INFO:    Image id=3 loaded: 0x4003000 - 0x401623c
INFO:    BL2: Loading image id 23
INFO:    Loading image id=23 at address 0x82000000
INFO:    Image id=23 loaded: 0x82000000 - 0x82002348
INFO:    BL2: Loading image id 25
INFO:    Loading image id=25 at address 0x4001300
INFO:    Image id=25 loaded: 0x4001300 - 0x4001348
INFO:    BL2: Loading image id 5
INFO:    Loading image id=5 at address 0x88000000
INFO:    Image id=5 loaded: 0x88000000 - 0x8807fb28
INFO:    BL2: Loading image id 27
INFO:    Loading image id=27 at address 0x80000000
INFO:    Image id=27 loaded: 0x80000000 - 0x80000048
NOTICE:  BL1: Booting BL31
INFO:    Entry point address = 0x4003000
INFO:    SPSR = 0x3cd
INFO:    FCONF: Reading HW_CONFIG firmware configuration file from: 0x82000000
INFO:    FCONF: Reading firmware configuration information for: cpu_timer
INFO:    FCONF: Reading firmware configuration information for: uart_config
INFO:    FCONF: Reading firmware configuration information for: topology
INFO:    FCONF: Reading firmware configuration information for: gicv3_config
NOTICE:  BL31: v2.5(debug):v2.5
NOTICE:  BL31: Built : 08:01:44, May  2 2022
INFO:    GICv3 with legacy support detected.
INFO:    ARM GICv3 driver initialized in EL3
INFO:    Maximum SPI INTID supported: 255
INFO:    BL31: Initializing runtime services
INFO:    BL31: Preparing for EL3 exit to normal world
INFO:    Entry point address = 0x88000000
INFO:    SPSR = 0x3c9


U-Boot 2021.04-dirty (May 02 2022 - 08:04:14 +0000) vexpress_aemv8a

DRAM:  4 GiB
Flash: 64 MiB
*** Warning - bad CRC, using default environment

In:    serial_pl01x
Out:   serial_pl01x
Err:   serial_pl01x
Net:   SMC91111-0
Hit any key to stop autoboot:  0 
smh_open: ERROR fd -1 for file 'boot.img'
loaded file Image from 80080000 to 82F299FF, 02EA9A00 bytes
smh_open: ERROR fd -1 for file 'devtree.dtb'
smh_open: ERROR fd -1 for file 'ramdisk.img'
fdt - flattened device tree utility commands

Usage:
fdt addr [-c]  <addr> [<length>]   - Set the [control] fdt location to <addr>
fdt move   <fdt> <newaddr> <length> - Copy the fdt to <addr> and make it active
fdt resize [<extrasize>]            - Resize fdt to size + padding to 4k addr + some optional <extrasize> if needed
fdt print  <path> [<prop>]          - Recursive print starting at <path>
fdt list   <path> [<prop>]          - Print one level starting at <path>
fdt get value <var> <path> <prop>   - Get <property> and store in <var>
fdt get name <var> <path> <index>   - Get name of node <index> and store in <var>
fdt get addr <var> <path> <prop>    - Get start address of <property> and store in <var>
fdt get size <var> <path> [<prop>]  - Get size of [<property>] or num nodes and store in <var>
fdt set    <path> <prop> [<val>]    - Set <property> [to <val>]
fdt mknode <path> <node>            - Create a new node after <path>
fdt rm     <path> [<prop>]          - Delete the node or <property>
fdt header [get <var> <member>]     - Display header info
                                      get - get header member <member> and store it in <var>
fdt bootcpu <id>                    - Set boot cpuid
fdt memory <addr> <size>            - Add/Update memory node
fdt rsvmem print                    - Show current mem reserves
fdt rsvmem add <addr> <size>        - Add a mem reserve
fdt rsvmem delete <index>           - Delete a mem reserves
fdt chosen [<start> <end>]          - Add/update the /chosen branch in the tree
                                        <start>/<end> - initrd start/end addr
NOTE: Dereference aliases by omitting the leading '/', e.g. fdt print ethernet0.
Moving Image from 0x80080000 to 0x80200000, end=831a0000
## Flattened Device Tree blob at 86000000
   Booting using the fdt blob at 0x86000000
   Using Device Tree in place at 0000000086000000, end 0000000086005fff

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd0f0]
[    0.000000] Linux version 5.19.0-rc6-next-20220711 (tuxmake@tuxmake) (aarch64-linux-gnu-gcc (Debian 11.3.0-3) 11.3.0, GNU ld (GNU Binutils for Debian) 2.38) #1 SMP PREEMPT @1657539508
[    0.000000] Machine model: FVP Base RevC
[    0.000000] earlycon: pl11 at MMIO 0x000000001c090000 (options '')
[    0.000000] printk: bootconsole [pl11] enabled
[    0.000000] efi: UEFI not found.
[    0.000000] Reserved memory: created DMA memory pool at 0x0000000018000000, size 8 MiB
[    0.000000] OF: reserved mem: initialized node vram@18000000, compatible id shared-dma-pool
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000080000000-0x00000008ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x8ff7f6b40-0x8ff7f8fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000008ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000feffffff]
[    0.000000]   node   0: [mem 0x0000000880000000-0x00000008ffffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000008ffffffff]
[    0.000000] On node 0, zone Normal: 4096 pages in unavailable ranges
[    0.000000] cma: Reserved 32 MiB at 0x00000000fd000000
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.2
[    0.000000] percpu: Embedded 30 pages/cpu s82856 r8192 d31832 u122880
[    0.000000] pcpu-alloc: s82856 r8192 d31832 u122880 alloc=30*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7 
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: detected: Branch Target Identification
[    0.000000] CPU features: detected: Address authentication (IMP DEF algorithm)
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: Virtualization Host Extensions
[    0.000000] CPU features: detected: Hardware dirty bit management
[    0.000000] alternatives: patching kernel code
[    0.000000] Fallback order for Node 0: 0 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1028096
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: console=ttyAMA0 earlycon=pl011,0x1c090000 root=/dev/vda rw ip=dhcp debug user_debug=31 loglevel=9
[    0.000000] Unknown kernel command line parameters "user_debug=31", will be passed to user space.
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: mapped [mem 0x00000000f9000000-0x00000000fd000000] (64MB)
[    0.000000] Memory: 3947088K/4177920K available (20288K kernel code, 4902K rwdata, 11308K rodata, 11136K init, 955K bss, 198064K reserved, 32768K cma-reserved)
[    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] ftrace: allocating 65660 entries in 257 pages
[    0.000000] ftrace: allocated 257 pages with 2 groups
[    0.000000] trace event string verifier disabled
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=8.
[    0.000000]  Trampoline variant of Tasks RCU enabled.
[    0.000000]  Rude variant of Tasks RCU enabled.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 224 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: GICv3 features: 16 PPIs
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x000000002f100000
[    0.000000] ITS [mem 0x2f020000-0x2f03ffff]
[    0.000000] ITS@0x000000002f020000: allocated 8192 Devices @8800f0000 (indirect, esz 8, psz 64K, shr 1)
[    0.000000] ITS@0x000000002f020000: allocated 8192 Virtual CPUs @880200000 (indirect, esz 8, psz 64K, shr 1)
[    0.000000] ITS@0x000000002f020000: allocated 8192 Interrupt Collections @880210000 (flat, esz 8, psz 64K, shr 1)
[    0.000000] GICv3: using LPI property table @0x0000000880220000
[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000000880230000
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
[    0.000000] timer_sp804: timer clock not found: -517
[    0.000000] timer_sp804: arm,sp804 clock not found: -2
[    0.000000] Failed to initialize '/bus@8000000/motherboard-bus/iofpga-bus@300000000/timer@110000': -22
[    0.000000] timer_sp804: timer clock not found: -517
[    0.000000] timer_sp804: arm,sp804 clock not found: -2
[    0.000000] Failed to initialize '/bus@8000000/motherboard-bus/iofpga-bus@300000000/timer@120000': -22
[    0.000000] arch_timer: cp15 timer(s) running at 100.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0x1ffffffffffffff max_cycles: 0x171024e7e0, max_idle_ns: 440795205315 ns
[    0.000000] sched_clock: 57 bits at 100MHz, resolution 10ns, wraps every 4398046511100ns
[    0.000987] random: crng init done
[    0.002028] Console: colour dummy device 80x25
[    0.002722] Calibrating delay loop (skipped), value calculated using timer frequency.. 200.00 BogoMIPS (lpj=400000)
[    0.002896] pid_max: default: 32768 minimum: 301
[    0.003932] LSM: Security Framework initializing
[    0.004751] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.004915] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.012987] cacheinfo: Unable to detect cache hierarchy for CPU 0

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd0f0]
[    0.000000] Linux version 5.19.0-rc6-next-20220711 (tuxmake@tuxmake) (aarch64-linux-gnu-gcc (Debian 11.3.0-3) 11.3.0, GNU ld (GNU Binutils for Debian) 2.38) #1 SMP PREEMPT @1657539508
[    0.000000] Machine model: FVP Base RevC
[    0.000000] earlycon: pl11 at MMIO 0x000000001c090000 (options '')
[    0.000000] printk: bootconsole [pl11] enabled
[    0.000000] efi: UEFI not found.
[    0.000000] Reserved memory: created DMA memory pool at 0x0000000018000000, size 8 MiB
[    0.000000] OF: reserved mem: initialized node vram@18000000, compatible id shared-dma-pool
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000080000000-0x00000008ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x8ff7f6b40-0x8ff7f8fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000008ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000feffffff]
[    0.000000]   node   0: [mem 0x0000000880000000-0x00000008ffffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000008ffffffff]
[    0.000000] On node 0, zone Normal: 4096 pages in unavailable ranges
[    0.000000] cma: Reserved 32 MiB at 0x00000000fd000000
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.2
[    0.000000] percpu: Embedded 30 pages/cpu s82856 r8192 d31832 u122880
[    0.000000] pcpu-alloc: s82856 r8192 d31832 u122880 alloc=30*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7 
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: detected: Branch Target Identification
[    0.000000] CPU features: detected: Address authentication (IMP DEF algorithm)
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: Virtualization Host Extensions
[    0.000000] CPU features: detected: Hardware dirty bit management
[    0.000000] alternatives: patching kernel code
[    0.000000] Fallback order for Node 0: 0 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1028096
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: console=ttyAMA0 earlycon=pl011,0x1c090000 root=/dev/vda rw ip=dhcp debug user_debug=31 loglevel=9
[    0.000000] Unknown kernel command line parameters "user_debug=31", will be passed to user space.
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: mapped [mem 0x00000000f9000000-0x00000000fd000000] (64MB)
[    0.000000] Memory: 3947088K/4177920K available (20288K kernel code, 4902K rwdata, 11308K rodata, 11136K init, 955K bss, 198064K reserved, 32768K cma-reserved)
[    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] ftrace: allocating 65660 entries in 257 pages
[    0.000000] ftrace: allocated 257 pages with 2 groups
[    0.000000] trace event string verifier disabled
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=8.
[    0.000000]  Trampoline variant of Tasks RCU enabled.
[    0.000000]  Rude variant of Tasks RCU enabled.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 224 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: GICv3 features: 16 PPIs
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x000000002f100000
[    0.000000] ITS [mem 0x2f020000-0x2f03ffff]
[    0.000000] ITS@0x000000002f020000: allocated 8192 Devices @8800f0000 (indirect, esz 8, psz 64K, shr 1)
[    0.000000] ITS@0x000000002f020000: allocated 8192 Virtual CPUs @880200000 (indirect, esz 8, psz 64K, shr 1)
[    0.000000] ITS@0x000000002f020000: allocated 8192 Interrupt Collections @880210000 (flat, esz 8, psz 64K, shr 1)
[    0.000000] GICv3: using LPI property table @0x0000000880220000
[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000000880230000
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
[    0.000000] timer_sp804: timer clock not found: -517
[    0.000000] timer_sp804: arm,sp804 clock not found: -2
[    0.000000] Failed to initialize '/bus@8000000/motherboard-bus/iofpga-bus@300000000/timer@110000': -22
[    0.000000] timer_sp804: timer clock not found: -517
[    0.000000] timer_sp804: arm,sp804 clock not found: -2
[    0.000000] Failed to initialize '/bus@8000000/motherboard-bus/iofpga-bus@300000000/timer@120000': -22
[    0.000000] arch_timer: cp15 timer(s) running at 100.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0x1ffffffffffffff max_cycles: 0x171024e7e0, max_idle_ns: 440795205315 ns
[    0.000000] sched_clock: 57 bits at 100MHz, resolution 10ns, wraps every 4398046511100ns
[    0.000987] random: crng init done
[    0.002028] Console: colour dummy device 80x25
[    0.002722] Calibrating delay loop (skipped), value calculated using timer frequency.. 200.00 BogoMIPS (lpj=400000)
[    0.002896] pid_max: default: 32768 minimum: 301
[    0.003932] LSM: Security Framework initializing
[    0.004751] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.004915] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.012987] cacheinfo: Unable to detect cache hierarchy for CPU 0
rly cacheinfo failed, ret = -2
[    0.023200] cblist_init_generic: Setting adjustable number of callback queues.
[    0.023287] cblist_init_generic: Setting shift to 3 and lim to 1.
[    0.024657] cblist_init_generic: Setting shift to 3 and lim to 1.
[    0.025804] cblist_init_generic: Setting shift to 3 and lim to 1.
[    0.028508] rcu: Hierarchical SRCU implementation.
[    0.028590] rcu:     Max phase no-delay instances is 1000.
[    0.042289] Platform MSI: msi-controller@2f020000 domain created
[    0.043253] PCI/MSI: /interrupt-controller@2f000000/msi-controller@2f020000 domain created
[    0.044400] fsl-mc MSI: msi-controller@2f020000 domain created
[    0.052095] EFI services will not be available.
[    0.057507] smp: Bringing up secondary CPUs ...
[    0.064187] Detected PIPT I-cache on CPU1
[    0.064287] GICv3: CPU1: found redistributor 100 region 0:0x000000002f120000
[    0.064416] GICv3: CPU1: using allocated LPI pending table @0x0000000880240000
[    0.064503] CPU1: Booted secondary processor 0x0000000100 [0x410fd0f0]
[    0.072587] Detected PIPT I-cache on CPU2
[    0.072687] GICv3: CPU2: found redistributor 200 region 0:0x000000002f140000
[    0.072787] GICv3: CPU2: using allocated LPI pending table @0x0000000880250000
[    0.072920] CPU2: Booted secondary processor 0x0000000200 [0x410fd0f0]
[    0.081187] Detected PIPT I-cache on CPU3
[    0.081336] GICv3: CPU3: found redistributor 300 region 0:0x000000002f160000
[    0.081423] GICv3: CPU3: using allocated LPI pending table @0x0000000880260000
[    0.081510] CPU3: Booted secondary processor 0x0000000300 [0x410fd0f0]
[    0.089787] Detected PIPT I-cache on CPU4
[    0.089887] GICv3: CPU4: found redistributor 10000 region 0:0x000000002f180000
[    0.089987] GICv3: CPU4: using allocated LPI pending table @0x0000000880270000
[    0.090100] CPU4: Booted secondary processor 0x0000010000 [0x410fd0f0]
[    0.098387] Detected PIPT I-cache on CPU5
[    0.098604] GICv3: CPU5: found redistributor 10100 region 0:0x000000002f1a0000
[    0.098604] GICv3: CPU5: using allocated LPI pending table @0x0000000880280000
[    0.098795] CPU5: Booted secondary processor 0x0000010100 [0x410fd0f0]
[    0.106987] Detected PIPT I-cache on CPU6
[    0.107194] GICv3: CPU6: found redistributor 10200 region 0:0x000000002f1c0000
[    0.107194] GICv3: CPU6: using allocated LPI pending table @0x0000000880290000
[    0.107397] CPU6: Booted secondary processor 0x0000010200 [0x410fd0f0]
[    0.115787] Detected PIPT I-cache on CPU7
[    0.115916] GICv3: CPU7: found redistributor 10300 region 0:0x000000002f1e0000
[    0.115998] GICv3: CPU7: using allocated LPI pending table @0x00000008802a0000
[    0.116131] CPU7: Booted secondary processor 0x0000010300 [0x410fd0f0]
[    0.117520] smp: Brought up 1 node, 8 CPUs
[    0.119411] SMP: Total of 8 processors activated.
[    0.119516] CPU features: detected: 32-bit EL0 Support
[    0.119602] CPU features: detected: 32-bit EL1 Support
[    0.119787] CPU features: detected: ARMv8.4 Translation Table Level
[    0.119930] CPU features: detected: Data cache clean to the PoU not required for I/D coherence
[    0.120094] CPU features: detected: Common not Private translations
[    0.120210] CPU features: detected: CRC32 instructions
[    0.120340] CPU features: detected: E0PD
[    0.120504] CPU features: detected: Enhanced Counter Virtualization
[    0.120644] CPU features: detected: Generic authentication (IMP DEF algorithm)
[    0.120790] CPU features: detected: RCpc load-acquire (LDAPR)
[    0.120887] CPU features: detected: LSE atomic instructions
[    0.120991] CPU features: detected: Privileged Access Never
[    0.121487] CPU features: detected: RAS Extension Support
[    0.121687] CPU features: detected: Random Number Generator
[    0.121815] CPU features: detected: Speculation barrier (SB)
[    0.121945] CPU features: detected: Stage-2 Force Write-Back
[    0.122087] CPU features: detected: TLB range maintenance instructions
[    0.122224] CPU features: detected: Scalable Vector Extension
[    0.413387] SVE: maximum available vector length 64 bytes per vector
[    0.413495] SVE: default vector length 64 bytes per vector
[    0.429916] CPU features: No Cache Writeback Granule information, assuming 128
[    0.429998] CPU: All CPU(s) started at EL2
[    0.449360] devtmpfs: initialized
[    0.476187] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.476487] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.484387] pinctrl core: initialized pinctrl subsystem
[    0.499687] DMI not present or invalid.
[    0.504431] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.522219] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allocations
[    0.524887] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.529787] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.530387] audit: initializing netlink subsys (disabled)
[    0.532024] audit: type=2000 audit(0.516:1): state=initialized audit_enabled=0 res=1
[    0.540094] thermal_sys: Registered thermal governor 'step_wise'
[    0.540187] thermal_sys: Registered thermal governor 'power_allocator'
[    0.541087] cpuidle: using governor menu
[    0.543087] hw-breakpoint: found 16 breakpoint and 16 watchpoint registers.
[    0.544787] ASID allocator initialised with 65536 entries
[    0.562220] Serial: AMBA PL011 UART driver
[    0.736803] 1c090000.serial: ttyAMA0 at MMIO 0x1c090000 (irq = 16, base_baud = 0) is a PL011 rev2
[    0.737087] printk: console [ttyAMA0] enabled
[    0.737087] printk: console [ttyAMA0] enabled
[    0.737287] printk: bootconsole [pl11] disabled
[    0.737287] printk: bootconsole [pl11] disabled
[    0.750633] 1c0a0000.serial: ttyAMA1 at MMIO 0x1c0a0000 (irq = 17, base_baud = 0) is a PL011 rev2
[    0.763687] 1c0b0000.serial: ttyAMA2 at MMIO 0x1c0b0000 (irq = 18, base_baud = 0) is a PL011 rev2
[    0.777422] 1c0c0000.serial: ttyAMA3 at MMIO 0x1c0c0000 (irq = 19, base_baud = 0) is a PL011 rev2
[    0.896905] platform panel: Fixing up cyclic dependency with 1c1f0000.clcd
[    0.916987] KASLR disabled due to lack of seed
[    1.031487] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    1.031687] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    1.031787] HugeTLB: registered 32.0 MiB page size, pre-allocated 0 pages
[    1.031987] HugeTLB: 508 KiB vmemmap can be freed for a 32.0 MiB page
[    1.032094] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    1.032287] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    1.032487] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 pages
[    1.032615] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
[    1.043251] cryptd: max_cpu_qlen set to 1000
[    1.058039] ACPI: Interpreter disabled.
[    1.093094] iommu: Default domain type: Translated 
[    1.093187] iommu: DMA domain TLB invalidation policy: strict mode 
[    1.095887] SCSI subsystem initialized
[    1.097487] libata version 3.00 loaded.
[    1.099887] usbcore: registered new interface driver usbfs
[    1.100287] usbcore: registered new interface driver hub
[    1.101087] usbcore: registered new device driver usb
[    1.111837] mc: Linux media interface: v0.10
[    1.112087] videodev: Linux video capture interface: v2.00
[    1.112555] pps_core: LinuxPPS API ver. 1 registered
[    1.112687] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.112887] PTP clock support registered
[    1.114587] EDAC MC: Ver: 3.0.0
[    1.131177] FPGA manager framework
[    1.131987] Advanced Linux Sound Architecture Driver Initialized.
[    1.137887] vgaarb: loaded
[    1.141187] clocksource: Switched to clocksource arch_sys_counter
[    1.144887] VFS: Disk quotas dquot_6.6.0
[    1.145764] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.148587] pnp: PnP ACPI: disabled
[    1.214887] NET: Registered PF_INET protocol family
[    1.215887] IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    1.270194] tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes, linear)
[    1.270687] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    1.270887] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    1.273987] TCP bind hash table entries: 32768 (order: 7, 524288 bytes, linear)
[    1.277487] TCP: Hash tables configured (established 32768 bind 32768)
[    1.279187] MPTCP token hash table entries: 4096 (order: 4, 98304 bytes, linear)
[    1.280087] UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    1.280901] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    1.282687] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    1.286487] RPC: Registered named UNIX socket transport module.
[    1.286717] RPC: Registered udp transport module.
[    1.286787] RPC: Registered tcp transport module.
[    1.287017] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.287187] PCI: CLS 0 bytes, default 64
[    1.298087] hw perfevents: enabled with armv8_pmuv3 PMU driver, 9 counters available
[    1.300234] kvm [1]: IPA Size Limit: 40 bits
[    1.300524] kvm [1]: vgic-v2@2c02f000
[    1.300911] kvm [1]: GIC system register CPU interface enabled
[    1.303347] kvm [1]: vgic interrupt IRQ9
[    1.305968] kvm [1]: VHE mode initialized successfully
[    1.322087] Initialise system trusted keyrings
[    1.323663] workingset: timestamp_bits=42 max_order=20 bucket_order=0
[    1.389687] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    1.395425] NFS: Registering the id_resolver key type
[    1.395741] Key type id_resolver registered
[    1.395787] Key type id_legacy registered
[    1.396817] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    1.396887] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    1.398187] 9p: Installing v9fs 9p2000 file system support
[    1.403781] jitterentropy: Initialization failed with host not compliant with requirements: 2
[    1.403945] NET: Registered PF_ALG protocol family
[    1.404387] xor: measuring software checksum speed
[    1.450187]    8regs           :   216 MB/sec
[    1.494323]    32regs          :   225 MB/sec
[    1.558176]    arm64_neon      :   154 MB/sec
[    1.558287] xor: using function: 32regs (225 MB/sec)
[    1.558487] Key type asymmetric registered
[    1.558609] Asymmetric key parser 'x509' registered
[    1.559287] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 244)
[    1.559487] io scheduler mq-deadline registered
[    1.559592] io scheduler kyber registered
[    1.770087] EINJ: ACPI disabled.
[    2.060589] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.100787] SuperH (H)SCI(F) driver initialized
[    2.107387] msm_serial: driver initialized
[    2.126643] arm-smmu-v3 2b400000.iommu: ias 48-bit, oas 48-bit (features 0x00041fef)
[    2.134587] arm-smmu-v3 2b400000.iommu: allocated 65536 entries for cmdq
[    2.136391] arm-smmu-v3 2b400000.iommu: allocated 32768 entries for evtq
[    2.149687] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    2.228317] loop: module loaded
[    2.228987] virtio_blk virtio0: 1/0/0 default/read/poll queues
[    2.236087] virtio_blk virtio0: [vda] 1228800 512-byte logical blocks (629 MB/600 MiB)
[    2.257733] basic-mmio-gpio: Failed to locate of_node [id: -2]
[    2.267135] basic-mmio-gpio: Failed to locate of_node [id: -2]
[    2.276487] basic-mmio-gpio: Failed to locate of_node [id: -2]
[    2.487287] megasas: 07.719.03.00-rc1
[    2.511987] physmap-flash 8000000.flash: physmap platform flash device: [mem 0x08000000-0x0bffffff]
[    2.512240] 8000000.flash: Found 2 x16 devices at 0x0 in 32-bit bank. Manufacturer ID 0x000089 Chip ID 0x000018
[    2.512487] Intel/Sharp Extended Query Table at 0x0031
[    2.512665] Intel/Sharp Extended Query Table at 0x0031
[    2.512829] Using buffer write method
[    2.512926] erase region 0: offset=0x0,size=0x40000,blocks=256
[    2.513287] physmap-flash 8000000.flash: physmap platform flash device: [mem 0x0c000000-0x0fffffff]
[    2.513587] 8000000.flash: Found 2 x16 devices at 0x0 in 32-bit bank. Manufacturer ID 0x000089 Chip ID 0x000018
[    2.513787] Intel/Sharp Extended Query Table at 0x0031
[    2.513887] Intel/Sharp Extended Query Table at 0x0031
[    2.514130] Using buffer write method
[    2.514287] erase region 0: offset=0x0,size=0x40000,blocks=256
[    2.514487] Concatenating MTD devices:
[    2.514616] (0): "8000000.flash"
[    2.514687] (1): "8000000.flash"
[    2.514887] into device "8000000.flash"
[    2.642493] virtio_net: probe of virtio2 failed with error -2
[    2.655587] thunder_xcv, ver 1.0
[    2.656010] thunder_bgx, ver 1.0
[    2.656531] nicpf, ver 1.0
[    2.678831] hns3: Hisilicon Ethernet Network Driver for Hip08 Family - version
[    2.679005] hns3: Copyright (c) 2017 Huawei Corporation.
[    2.679487] hclge is initializing
[    2.679767] e1000: Intel(R) PRO/1000 Network Driver
[    2.679887] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    2.680422] e1000e: Intel(R) PRO/1000 Network Driver
[    2.680567] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    2.681001] igb: Intel(R) Gigabit Ethernet Network Driver
[    2.681241] igb: Copyright (c) 2007-2014 Intel Corporation.
[    2.681687] igbvf: Intel(R) Gigabit Virtual Function Network Driver
[    2.681868] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    2.687877] sky2: driver version 1.30
[    2.688290] QLogic FastLinQ 4xxxx Core Module qed
[    2.688387] qede init: QLogic FastLinQ 4xxxx Ethernet Driver qede
[    2.698035] smc91x 1a000000.ethernet (unnamed net_device) (uninitialized): smc91x: IOADDR 0000000046731890 doesn't match configuration (300).
[    2.698287] smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@fluxnic.net>
[    3.165887] smc91x 1a000000.ethernet eth0: SMC91C11xFD (rev 1) at 0000000046731890 IRQ 28
[    3.166087] 
[    3.166223] smc91x 1a000000.ethernet eth0: Ethernet addr: 00:02:f7:ef:96:ba
[    3.178187] usbcore: registered new interface driver asix
[    3.178687] usbcore: registered new interface driver ax88179_178a
[    3.180087] VFIO - User Level meta-driver version: 0.3
[    3.212385] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.212587] ehci-pci: EHCI PCI platform driver
[    3.213087] ehci-platform: EHCI generic platform driver
[    3.215187] ehci-orion: EHCI orion driver
[    3.217087] ehci-exynos: EHCI Exynos driver
[    3.218987] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    3.219240] ohci-pci: OHCI PCI platform driver
[    3.219587] ohci-platform: OHCI generic platform driver
[    3.221687] ohci-exynos: OHCI Exynos driver
[    3.230520] usbcore: registered new interface driver usb-storage
[    3.296788] rtc-pl031 1c170000.rtc: registered as rtc0
[    3.297187] rtc-pl031 1c170000.rtc: setting system clock to 2022-07-14T11:07:56 UTC (1657796876)
[    3.308187] i2c_dev: i2c /dev entries driver
[    3.390687] sp805-wdt 1c0f0000.wdt: registration successful
[    3.452393] mmci-pl18x 1c050000.mmci: Got CD GPIO
[    3.452928] mmci-pl18x 1c050000.mmci: Got WP GPIO
[    3.458294] mmci-pl18x 1c050000.mmci: mmc0: PL180 manf 41 rev0 at 0x1c050000 irq 33,34 (pio)
[    3.486842] sdhci: Secure Digital Host Controller Interface driver
[    3.487188] sdhci: Copyright(c) Pierre Ossman
[    3.499787] Synopsys Designware Multimedia Card Interface Driver
[    3.518087] sdhci-pltfm: SDHCI platform and OF driver helper
[    3.553047] ledtrig-cpu: registered to indicate activity on CPUs
[    3.584587] input: AT Raw Set 2 keyboard as /devices/platform/bus@8000000/bus@8000000:motherboard-bus/bus@8000000:motherboard-bus:iofpga-bus@300000000/1c060000.kmi/serio0/input/input0
[    3.593687] SMCCC: SOC_ID: ID = jep106:043b:0000 Revision = 0x00000002
[    3.635387] usbcore: registered new interface driver usbhid
[    3.635487] usbhid: USB HID core driver
[    3.689187]  cs_system_cfg: CoreSight Configuration manager initialised
[    3.761587] NET: Registered PF_INET6 protocol family
[    3.772579] Segment Routing with IPv6
[    3.772838] In-situ OAM (IOAM) with IPv6
[    3.773487] NET: Registered PF_PACKET protocol family
[    3.774987] 9pnet: Installing 9P2000 support
[    3.781939] Key type dns_resolver registered
[    3.795687] registered taskstats version 1
[    3.796093] Loading compiled-in X.509 certificates
[    3.963535] pci-host-generic 40000000.pci: host bridge /pci@40000000 ranges:
[    3.964087] pci-host-generic 40000000.pci:      MEM 0x0050000000..0x005fffffff -> 0x0050000000
[    3.965087] pci-host-generic 40000000.pci: ECAM at [mem 0x40000000-0x4fffffff] for [bus 00-01]
[    3.966387] pci-host-generic 40000000.pci: PCI host bridge to bus 0000:00
[    3.966587] pci_bus 0000:00: root bus resource [bus 00-01]
[    3.966787] pci_bus 0000:00: root bus resource [mem 0x50000000-0x5fffffff]
[    3.967368] pci 0000:00:00.0: [1af4:1001] type 00 class 0x018000
[    3.967812] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00000fff]
[    3.968187] pci 0000:00:00.0: reg 0x18: [mem 0x00000000-0x00000fff]
[    3.968687] pci 0000:00:00.0: reg 0x20: [mem 0x00000000-0x00000fff]
[    3.969187] pci 0000:00:00.0: enabling Extended Tags
[    3.970589] pci 0000:00:00.0: PME# supported from D3hot
[    3.974387] pci 0000:00:02.0: [1af4:1001] type 00 class 0x018000
[    3.974887] pci 0000:00:02.0: reg 0x10: [mem 0x00000000-0x00000fff]
[    3.975361] pci 0000:00:02.0: reg 0x18: [mem 0x00000000-0x00000fff]
[    3.975787] pci 0000:00:02.0: reg 0x20: [mem 0x00000000-0x00000fff]
[    3.976305] pci 0000:00:02.0: enabling Extended Tags
[    3.977687] pci 0000:00:02.0: PME# supported from D3hot
[    3.981087] pci 0000:00:03.0: [0abc:aced] type 00 class 0x010601
[    3.981721] pci 0000:00:03.0: reg 0x10: [mem 0x00000000-0x00001fff]
[    3.982049] pci 0000:00:03.0: reg 0x14: [mem 0x00000000-0x00001fff]
[    3.982287] pci 0000:00:03.0: reg 0x18: [mem 0x00000000-0x00000fff]
[    3.982650] pci 0000:00:03.0: reg 0x1c: [mem 0x00000000-0x00001fff]
[    3.982987] pci 0000:00:03.0: reg 0x20: [mem 0x00000000-0x00000fff]
[    3.983287] pci 0000:00:03.0: reg 0x24: [mem 0x00000000-0x00001fff]
[    3.984424] pci 0000:00:03.0: PME# supported from D3hot
[    3.993287] pci 0000:00:03.0: BAR 0: assigned [mem 0x50000000-0x50001fff]
[    3.993587] pci 0000:00:03.0: BAR 1: assigned [mem 0x50002000-0x50003fff]
[    3.993845] pci 0000:00:03.0: BAR 3: assigned [mem 0x50004000-0x50005fff]
[    3.994104] pci 0000:00:03.0: BAR 5: assigned [mem 0x50006000-0x50007fff]
[    3.994354] pci 0000:00:00.0: BAR 0: assigned [mem 0x50008000-0x50008fff]
[    3.994587] pci 0000:00:00.0: BAR 2: assigned [mem 0x50009000-0x50009fff]
[    3.994787] pci 0000:00:00.0: BAR 4: assigned [mem 0x5000a000-0x5000afff]
[    3.995135] pci 0000:00:02.0: BAR 0: assigned [mem 0x5000b000-0x5000bfff]
[    3.995387] pci 0000:00:02.0: BAR 2: assigned [mem 0x5000c000-0x5000cfff]
[    3.995587] pci 0000:00:02.0: BAR 4: assigned [mem 0x5000d000-0x5000dfff]
[    3.995887] pci 0000:00:03.0: BAR 2: assigned [mem 0x5000e000-0x5000efff]
[    3.996139] pci 0000:00:03.0: BAR 4: assigned [mem 0x5000f000-0x5000ffff]
[    4.001887] virtio-pci 0000:00:00.0: Adding to iommu group 0
[    4.004003] virtio-pci 0000:00:00.0: enabling device (0000 -> 0002)
[    4.004343] virtio-pci 0000:00:00.0: virtio_pci: leaving for legacy driver
[    4.005587] virtio_blk virtio3: 1/0/0 default/read/poll queues
[    4.010087] virtio_blk virtio3: [vdb] 0 512-byte logical blocks (0 B/0 B)
[    4.023606] virtio-pci 0000:00:02.0: Adding to iommu group 1
[    4.025428] virtio-pci 0000:00:02.0: enabling device (0000 -> 0002)
[    4.025794] virtio-pci 0000:00:02.0: virtio_pci: leaving for legacy driver
[    4.026903] virtio_blk virtio4: 1/0/0 default/read/poll queues
[    4.031187] virtio_blk virtio4: [vdc] 0 512-byte logical blocks (0 B/0 B)
[    4.044604] ahci 0000:00:03.0: Adding to iommu group 2
[    4.046387] ahci 0000:00:03.0: version 3.0
[    4.046587] ahci 0000:00:03.0: enabling device (0000 -> 0002)
[    4.048687] ahci 0000:00:03.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
[    4.048943] ahci 0000:00:03.0: flags: 64bit ncq only 
[    4.056319] scsi host0: ahci
[    4.058890] ata1: SATA max UDMA/133 abar m8192@0x50006000 port 0x50006100 irq 41
[    4.373387] ata1: SATA link down (SStatus 0 SControl 300)
[    5.848187] input: PS/2 Generic Mouse as /devices/platform/bus@8000000/bus@8000000:motherboard-bus/bus@8000000:motherboard-bus:iofpga-bus@300000000/1c070000.kmi/serio1/input/input2
[    5.988597] smc91x 1a000000.ethernet eth0: link up, 10Mbps, half-duplex, lpa 0x0000
[    6.013287] Sending DHCP requests ...... timed out!
[   93.935687] IP-Config: Reopening network devices...
[   94.027787] smc91x 1a000000.ethernet eth0: link up, 10Mbps, half-duplex, lpa 0x0000
[   94.049376] Sending DHCP requests .
[   94.965287] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   96.209387] ..... timed out!
[  168.362347] IP-Config: Auto-configuration of network failed
[  168.364256] ALSA device list:
[  168.364387]   No soundcards found.
[  168.365752] uart-pl011 1c090000.serial: no DMA platform data
[  168.407391] EXT4-fs (vda): recovery complete
[  168.408287] EXT4-fs (vda): mounted filesystem with ordered data mode. Quota mode: none.
[  168.408693] VFS: Mounted root (ext4 filesystem) on device 254:0.
[  168.409907] devtmpfs: mounted
[  168.586400] Freeing unused kernel memory: 11136K
[  168.587788] Run /sbin/init as init process
[  168.587951]   with arguments:
[  168.588048]     /sbin/init
[  168.588211]   with environment:
[  168.588328]     HOME=/
[  168.588472]     TERM=linux
[  168.588587]     user_debug=31
[  168.726448] request_module: kmod_concurrent_max (0) close to 0 (max_modprobes: 50), for module binfmt-464c, throttling...
[  173.813587] request_module: modprobe binfmt-464c cannot be processed, kmod busy with 50 threads for more than 5 seconds now
[  173.867187] Starting init: /sbin/init exists but couldn't execute it (error -8)
[  173.867487] Run /etc/init as init process
[  173.867620]   with arguments:
[  173.867745]     /etc/init
[  173.867887]   with environment:
[  173.867991]     HOME=/
[  173.868140]     TERM=linux
[  173.868236]     user_debug=31
[  173.870136] Run /bin/init as init process
[  173.870284]   with arguments:
[  173.870396]     /bin/init
[  173.870530]   with environment:
[  173.870657]     HOME=/
[  173.870787]     TERM=linux
[  173.870940]     user_debug=31
[  173.871787] Run /bin/sh as init process
[  173.871923]   with arguments:
[  173.872045]     /bin/sh
[  173.872187]   with environment:
[  173.872305]     HOME=/
[  173.872414]     TERM=linux
[  173.872587]     user_debug=31
[  173.951087] request_module: kmod_concurrent_max (0) close to 0 (max_modprobes: 50), for module binfmt-464c, throttling...
[  179.189622] request_module: modprobe binfmt-464c cannot be processed, kmod busy with 50 threads for more than 5 seconds now
[  179.242205] Starting init: /bin/sh exists but couldn't execute it (error -8)
[  179.242516] Kernel panic - not syncing: No working init found.  Try passing init= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance.
[  179.242687] CPU: 6 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc6-next-20220711 #1
[  179.242812] Hardware name: FVP Base RevC (DT)
[  179.242899] Call trace:
[  179.242976]  dump_backtrace+0xe8/0x130
[  179.243089]  show_stack+0x24/0x60
[  179.243187]  dump_stack_lvl+0x8c/0xb8
[  179.243287]  dump_stack+0x18/0x34
[  179.243420]  panic+0x188/0x38c
[  179.243507]  kernel_init+0x13c/0x140
[  179.243663]  ret_from_fork+0x10/0x20
[  179.243787] SMP: stopping secondary CPUs
[  179.243987] Kernel Offset: disabled
[  179.244027] CPU features: 0x0000,0002002d,f9a59dcf
[  179.244114] Memory Limit: none
[  179.244201] ---[ end Kernel panic - not syncing: No working init found.  Try passing init= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance. ]---
