Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAB9574F61
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239806AbiGNNjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiGNNjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:39:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E1B4958D;
        Thu, 14 Jul 2022 06:39:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 994FE1CE2;
        Thu, 14 Jul 2022 06:39:50 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.26.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F9283F73D;
        Thu, 14 Jul 2022 06:39:48 -0700 (PDT)
Date:   Thu, 14 Jul 2022 14:39:40 +0100
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
Message-ID: <YtAcW9DRrdun/pW9@FVFF77S0Q05N.cambridge.arm.com>
References: <CA+G9fYtOX-6=f70FA5PuDVA=kX=2L4spXKXS8=LHkUphafXowg@mail.gmail.com>
 <Ys1g8PH4M2W7Z50U@sirena.org.uk>
 <CA+G9fYu7mJ6X3_xhboODP_cjABE4QTJCON_NMduQ60x4Z7N78Q@mail.gmail.com>
 <Ys/9TSV5muvKXN6W@FVFF77S0Q05N>
 <YtABEDylGJkYLXrJ@sirena.org.uk>
 <YtASzuHo1MXe5LJH@FVFF77S0Q05N.cambridge.arm.com>
 <YtAU1AHLLgK/v7RP@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtAU1AHLLgK/v7RP@FVFF77S0Q05N.cambridge.arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 02:06:28PM +0100, Mark Rutland wrote:
 
> ... and I've just reproduced the issue by running the script from a different
> directory, since apprarently the semihosting interface just grabs the file from
> the current directory.
> 
> I'm pretty sure this means that *something* is clobbering the Image early on
> during boot, and the semihisting loading happens to refresh it.

I had a go with my own kernel built from my arm64/traps/rework branch:
  
  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/traps/rework

... and Naresh's config:

  https://builds.tuxbuild.com/2BnQMpJj3kDTJXoCwd2pY5gW9CN/config

When *only* using the initial loading into memory, that blows up in stackdepot
and with a subsequent bogus pointer dereference (full log below), and when
loaded via semihosting that just works. Note that my kernel is based on the
arm64 for-next/core branch, which itself is based on v5.19-rc3.

My failing kernel Image is ~47M, as is Naresh's original Image. When using
smaller Images (as large as 43M so far), I don't see any issues.

I also note that if I enable KASAN_OUTLINE, the kernel is so big that it
clobbers the DTB, and cannot be booted. So this looks liek a problem with tha
arbitrary placement / limits chosen for U-Boot being too small, and this is not
a kernel bug.

Naresh, please can you fix your boot flow before reporting any further issues?
This sort of corruption will manifest in a number of ways, and we need to rule
that out for any other bug reports.

Thanks,
Mark.

---->8----

[mark@lakrids:~]% telnet localhost 5000
Trying ::1...
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
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
smh_open: ERROR fd -1 for file 'Image'
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
Moving Image from 0x80080000 to 0x80200000, end=83120000
## Flattened Device Tree blob at 86000000
   Booting using the fdt blob at 0x86000000
   Using Device Tree in place at 0000000086000000, end 0000000086005fff

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd0f0]
[    0.000000] Linux version 5.19.0-rc3-00132-g647529cd3b65 (mark@lakrids) (aarch64-linux-gcc (GCC) 11.3.0, GNU ld (GNU Binutils) 2.38) #1 SMP PREEMPT Thu Jul 14 14:21:33 BST 2022
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
[    0.000000] percpu: Embedded 30 pages/cpu s82792 r8192 d31896 u122880
[    0.000000] pcpu-alloc: s82792 r8192 d31896 u122880 alloc=30*4096
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
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at lib/stackdepot.c:181 stack_depot_early_init+0x10/0xb4
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.19.0-rc3-00132-g647529cd3b65 #1
[    0.000000] Hardware name: FVP Base RevC (DT)
[    0.000000] pstate: 400000c9 (nZcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.000000] pc : stack_depot_early_init+0x10/0xb4
[    0.000000] lr : start_kernel+0x450/0x744
[    0.000000] sp : ffffd7c5d5d63e30
[    0.000000] x29: ffffd7c5d5d63e30 x28: 0000000082090010 x27: ffffd7c5d5000398
[    0.000000] x26: ffffd7c5d5000398 x25: 0000000000000000 x24: ffff6d4b3f7e42ce
[    0.000000] x23: ffff6d4b3f7e42c0 x22: ffffd7c5d5d6e9c0 x21: ffffd7c5d5115318
[    0.000000] x20: ffffd7c5d622b000 x19: ffffd7c5d5115318 x18: ffffffffffffffff
[    0.000000] x17: 2c73657479622032 x16: 353137393032202c x15: ffffd7c655d63b17
[    0.000000] x14: 0000000000000000 x13: 66666f3a65657266 x12: 2070616568202c66
[    0.000000] x11: 666f3a636f6c6c61 x10: ffffd7c5d5dea850 x9 : ffffd7c5d5d92850
[    0.000000] x8 : 00000000ffffefff x7 : ffffd7c5d5dea850 x6 : 0000000000000000
[    0.000000] x5 : 000000000000bff4 x4 : 0000000000000000 x3 : 0000000000000000
[    0.000000] x2 : 000000000000006d x1 : ffffd7c5d5d79e00 x0 : ffffd7c5d5380000
[    0.000000] Call trace:
[    0.000000]  stack_depot_early_init+0x10/0xb4
[    0.000000]  __primary_switched+0xb8/0xc0
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] software IO TLB: mapped [mem 0x00000000f9000000-0x00000000fd000000] (64MB)
[    0.000000] Memory: 3947600K/4177920K available (19968K kernel code, 4882K rwdata, 11156K rodata, 11072K init, 951K bss, 197552K reserved, 32768K cma-reserved)
[    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] ftrace: allocating 65020 entries in 254 pages
[    0.000000] ftrace: allocated 254 pages with 7 groups
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
[    0.000000] ITS@0x000000002f020000: allocated 8192 Devices @8801f0000 (indirect, esz 8, psz 64K, shr 1)
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
[    0.000997] random: crng init done
[    0.001966] Console: colour dummy device 80x25
[    0.002703] Calibrating delay loop (skipped), value calculated using timer frequency.. 200.00 BogoMIPS (lpj=400000)
[    0.002952] pid_max: default: 32768 minimum: 301
[    0.003952] LSM: Security Framework initializing
[    0.004052] LSM: security= is ignored because it is superseded by lsm=
[    0.004208] Unable to handle kernel paging request at virtual address 0000000004000000
[    0.004382] Mem abort info:
[    0.004468]   ESR = 0x0000000096000004
[    0.004587]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.004752]   SET = 0, FnV = 0
[    0.004852]   EA = 0, S1PTW = 0
[    0.004997]   FSC = 0x04: level 0 translation fault
[    0.005152] Data abort info:
[    0.005252]   ISV = 0, ISS = 0x00000004
[    0.005352]   CM = 0, WnR = 0
[    0.005488] [0000000004000000] user address but active_mm is swapper
[    0.005596] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    0.005652] Modules linked in:
[    0.005816] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.19.0-rc3-00132-g647529cd3b65 #1
[    0.005952] Hardware name: FVP Base RevC (DT)
[    0.006030] pstate: 80000009 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.006152] pc : __pi_strlen+0x14/0x150
[    0.006252] lr : kstrdup+0x34/0xa4
[    0.006352] sp : ffffd7c5d5d63d60
[    0.006389] x29: ffffd7c5d5d63d60 x28: 0000000082090010 x27: ffffd7c5d514c000
[    0.006552] x26: ffffd7c5d5000398 x25: 0000000000000000 x24: 2200000004000000
[    0.006811] x23: ffffd7c5d4fb4df8 x22: ffffd7c5d54a8db8 x21: b09ad7c5d52b951c
[    0.006985] x20: 2200000004000000 x19: 0000000000000cc0 x18: ffffffffffffffff
[    0.007158] x17: 000000000000003f x16: 000000000000000b x15: ffffd7c655d63ae7
[    0.007372] x14: 0000000000000000 x13: 3d6d736c20796220 x12: 6465646573726570
[    0.007552] x11: 7573207369207469 x10: ffffd7c5d5dea850 x9 : ffffd7c5d52b951c
[    0.007765] x8 : 0101010101010101 x7 : ffffd7c5d5dea850 x6 : 0000000000000000
[    0.007952] x5 : 000000000000bff4 x4 : 0000000000000000 x3 : 0000000003000001
[    0.008112] x2 : 0000000000000000 x1 : 0000000000000cc0 x0 : 2200000004000000
[    0.008286] Call trace:
[    0.008373]  __pi_strlen+0x14/0x150
[    0.008460]  ordered_lsm_parse+0xa4/0x27c
[    0.008601]  security_init+0xdc/0x2c4
[    0.008720]  start_kernel+0x6cc/0x744
[    0.008852]  __primary_switched+0xb8/0xc0
[    0.009011] Code: 92402c04 b200c3e8 f13fc09f 5400088c (a9400c02)
[    0.009067] ---[ end trace 0000000000000000 ]---
[    0.009240] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.009352] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
