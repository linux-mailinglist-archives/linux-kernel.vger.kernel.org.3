Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4428C4DB795
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 18:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349264AbiCPRus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 13:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357632AbiCPRup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 13:50:45 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5656AA64
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 10:49:29 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 846074B53; Wed, 16 Mar 2022 13:49:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 846074B53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1647452968;
        bh=sFHpqIOSkD8FjP4sq3ErDK4hq8AV7bjjU23FVf7YXbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UFy0wU1R+6Rnzg6N9NHNqjLeeErgrJL4ONkgri657KRAGUnHmrR+JkR03CFFmIvlS
         ESdwAn0jUW2UyV1V6rtDunAriqPKLegFy+KSJWoOs3HZfzggVa4NAH6mDdDRMSc6bp
         NzVXKU7V05WpsgdSxQYK4j+493z8gLWmJINSawJI=
Date:   Wed, 16 Mar 2022 13:49:28 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: failure to boot after dc6e0818bc9a "sched/cpuacct: Optimize away
 RCU read lock"
Message-ID: <20220316174928.GB16511@fieldses.org>
References: <20220316174324.GA16511@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316174324.GA16511@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 01:43:24PM -0400, bfields wrote:
> One of my test VMs has been failing to boot linux-next recently.  I
> finally got around to a bisect this morning, and it landed on the below.
> 
> What other information would be useful to debug this?

Oh, also, I should have noticed the RCU warnings on the console:

=============================
WARNING: suspicious RCU usage
5.17.0-rc5-00050-gdc6e0818bc9a #2134 Not tainted
-----------------------------
include/linux/cgroup.h:494 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 1, debug_locks = 1
2 locks held by swapper/0/1:
 #0: ffffffff850bed60 (console_lock){+.+.}-{0:0}, at: _printk+0x96/0xb2
 #1: ffff88806d4377d8 (&rq->__lock){-...}-{2:2}, at: scheduler_tick+0xa0/0x790

stack backtrace:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc5-00050-gdc6e0818bc9a #2134
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
Call Trace:
 <IRQ>
 dump_stack_lvl+0x45/0x59
 cpuacct_charge+0x248/0x300
 update_curr+0x338/0x870
 ? lock_is_held_type+0xd7/0x130
 task_tick_fair+0x77/0x810
 ? lock_is_held_type+0xd7/0x130
 scheduler_tick+0x210/0x790
 ? irq_work_single+0x16a/0x230
 update_process_times+0x119/0x170
 tick_periodic+0x56/0x1e0
 tick_handle_periodic+0x3b/0xa0
 __sysvec_apic_timer_interrupt+0x188/0x5a0
 sysvec_apic_timer_interrupt+0x89/0xc0
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20
RIP: 0010:console_unlock+0x681/0x850
Code: 08 e9 aa fc ff ff 48 c7 c6 0d a3 2c 81 48 c7 c7 60 e9 d3 84 e8 90 cb fe ff e8 9b 26 00 00 48 83 7c 24 10 00 0f 85 64 01 00 00 <8b> 54 24 30 85 d2 0f 84 d2 fa ff ff 31 d2 be a0 0a 00 00 48 c7 c7
RSP: 0000:ffff88800775fc88 EFLAGS: 00000202
RAX: 0000000000000119 RBX: ffff88800775fce0 RCX: 1ffffffff0d0d232
RDX: 0000000000000000 RSI: ffffffff8426aa20 RDI: ffffffff844e4c60
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff86868ba7
R10: fffffbfff0d0d174 R11: 0000000000000001 R12: 0000000000000000
R13: ffffffff854cb968 R14: 0000000000000000 R15: dffffc0000000000
 ? console_unlock+0x7ea/0x850
 ? devkmsg_read+0x640/0x640
 ? lock_acquire+0x1b6/0x4b0
 ? _printk+0x96/0xb2
 vprintk_emit+0xf0/0x2c0
 _printk+0x96/0xb2
 ? pm_suspend.cold+0x4dd/0x4dd
 ? cblist_init_generic+0x3af/0x530
 rcu_init_tasks_generic+0x71/0x15e
 kernel_init_freeable+0x17c/0x3e0
 ? rest_init+0x2d0/0x2d0
 kernel_init+0x19/0x140
 ret_from_fork+0x22/0x30
 </TASK>

Full console output follows.

--b.

Linux version 5.17.0-rc5-00050-gdc6e0818bc9a (bfields@patate.fieldses.org) (gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9), GNU ld version 2.37-10.fc35) #2134 SMP PREEMPT Wed Mar 16 12:55:40 EDT 2022
Command line: BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.17.0-rc5-00050-gdc6e0818bc9a root=/dev/mapper/fedora-root ro resume=/dev/mapper/fedora-swap rd.lvm.lv=fedora/root rd.lvm.lv=fedora/swap console=ttyS0,38400n8 consoleblank=0
x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
signal: max sigframe size: 1776
BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
BIOS-e820: [mem 0x0000000000100000-0x000000007ffd7fff] usable
BIOS-e820: [mem 0x000000007ffd8000-0x000000007fffffff] reserved
BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
NX (Execute Disable) protection: active
SMBIOS 2.8 present.
DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
tsc: Fast TSC calibration using PIT
tsc: Detected 3591.671 MHz processor
last_pfn = 0x7ffd8 max_arch_pfn = 0x400000000
x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
found SMP MP-table at [mem 0x000f5a80-0x000f5a8f]
RAMDISK: [mem 0x346ce000-0x3635efff]
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x00000000000F57F0 000014 (v00 BOCHS )
ACPI: RSDT 0x000000007FFE1902 000030 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: FACP 0x000000007FFE17D6 000074 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: DSDT 0x000000007FFE0040 001796 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: FACS 0x000000007FFE0000 000040
ACPI: APIC 0x000000007FFE184A 000090 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: WAET 0x000000007FFE18DA 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: Reserving FACP table memory at [mem 0x7ffe17d6-0x7ffe1849]
ACPI: Reserving DSDT table memory at [mem 0x7ffe0040-0x7ffe17d5]
ACPI: Reserving FACS table memory at [mem 0x7ffe0000-0x7ffe003f]
ACPI: Reserving APIC table memory at [mem 0x7ffe184a-0x7ffe18d9]
ACPI: Reserving WAET table memory at [mem 0x7ffe18da-0x7ffe1901]
Zone ranges:
  DMA      [mem 0x0000000000001000-0x0000000000ffffff]
  DMA32    [mem 0x0000000001000000-0x000000007ffd7fff]
  Normal   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000001000-0x000000000009efff]
  node   0: [mem 0x0000000000100000-0x000000007ffd7fff]
Initmem setup node 0 [mem 0x0000000000001000-0x000000007ffd7fff]
On node 0, zone DMA: 1 pages in unavailable ranges
On node 0, zone DMA: 97 pages in unavailable ranges
On node 0, zone DMA32: 40 pages in unavailable ranges
kasan: KernelAddressSanitizer initialized
ACPI: PM-Timer IO Port: 0x608
ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
ACPI: Using ACPI (MADT) for SMP configuration information
TSC deadline timer available
smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[mem 0x80000000-0xfeffbfff] available for PCI devices
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4 nr_node_ids:1
percpu: Embedded 66 pages/cpu s232272 r8192 d29872 u524288
Built 1 zonelists, mobility grouping on.  Total pages: 516824
Kernel command line: BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.17.0-rc5-00050-gdc6e0818bc9a root=/dev/mapper/fedora-root ro resume=/dev/mapper/fedora-swap rd.lvm.lv=fedora/root rd.lvm.lv=fedora/swap console=ttyS0,38400n8 consoleblank=0
Unknown kernel command line parameters "BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.17.0-rc5-00050-gdc6e0818bc9a resume=/dev/mapper/fedora-swap", will be passed to user space.
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
mem auto-init: stack:off, heap alloc:off, heap free:off
Stack Depot allocating hash table with memblock_alloc
Memory: 1652304K/2096600K available (49169K kernel code, 11732K rwdata, 9356K rodata, 2088K init, 15176K bss, 444040K reserved, 0K cma-reserved)
Kernel/User page tables isolation: enabled
ftrace: allocating 48495 entries in 190 pages
ftrace: allocated 190 pages with 6 groups
Dynamic Preempt: full
Running RCU self tests
rcu: Preemptible hierarchical RCU implementation.
rcu: 	RCU lockdep checking is enabled.
rcu: 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
	Trampoline variant of Tasks RCU enabled.
	Rude variant of Tasks RCU enabled.
	Tracing variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
NR_IRQS: 4352, nr_irqs: 72, preallocated irqs: 16
random: get_random_bytes called from start_kernel+0x1ef/0x384 with crng_init=0
Console: colour VGA+ 80x25
printk: console [ttyS0] enabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8192
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     32768
... MAX_LOCKDEP_CHAINS:      65536
... CHAINHASH_SIZE:          32768
 memory used by lock dependency info: 6365 kB
 memory used for stack traces: 4224 kB
 per task-struct memory footprint: 1920 bytes
ACPI: Core revision 20211217
APIC: Switch to symmetric I/O mode setup
clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x33c5978b159, max_idle_ns: 440795383616 ns
Calibrating delay loop (skipped), value calculated using timer frequency.. 7183.34 BogoMIPS (lpj=14366684)
pid_max: default: 32768 minimum: 301
LSM: Security Framework initializing
SELinux:  Initializing.
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
Spectre V2 : Mitigation: Full generic retpoline
Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
Spectre V2 : Enabling Restricted Speculation for firmware calls
Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
Speculative Store Bypass: Vulnerable
SRBDS: Unknown: Dependent on hypervisor status
MDS: Vulnerable: Clear CPU buffers attempted, no microcode
Freeing SMP alternatives memory: 44K
smpboot: CPU0: Intel Core Processor (Haswell, no TSX, IBRS) (family: 0x6, model: 0x3c, stepping: 0x1)
cblist_init_generic: Setting adjustable number of callback queues.
cblist_init_generic: Setting shift to 2 and lim to 1.
cblist_init_generic: Setting shift to 2 and lim to 1.

=============================
WARNING: suspicious RCU usage
5.17.0-rc5-00050-gdc6e0818bc9a #2134 Not tainted
-----------------------------
include/linux/cgroup.h:494 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 1, debug_locks = 1
2 locks held by swapper/0/1:
 #0: ffffffff850bed60 (console_lock){+.+.}-{0:0}, at: _printk+0x96/0xb2
 #1: ffff88806d4377d8 (&rq->__lock){-...}-{2:2}, at: scheduler_tick+0xa0/0x790

stack backtrace:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc5-00050-gdc6e0818bc9a #2134
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
Call Trace:
 <IRQ>
 dump_stack_lvl+0x45/0x59
 cpuacct_charge+0x248/0x300
 update_curr+0x338/0x870
 ? lock_is_held_type+0xd7/0x130
 task_tick_fair+0x77/0x810
 ? lock_is_held_type+0xd7/0x130
 scheduler_tick+0x210/0x790
 ? irq_work_single+0x16a/0x230
 update_process_times+0x119/0x170
 tick_periodic+0x56/0x1e0
 tick_handle_periodic+0x3b/0xa0
 __sysvec_apic_timer_interrupt+0x188/0x5a0
 sysvec_apic_timer_interrupt+0x89/0xc0
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20
RIP: 0010:console_unlock+0x681/0x850
Code: 08 e9 aa fc ff ff 48 c7 c6 0d a3 2c 81 48 c7 c7 60 e9 d3 84 e8 90 cb fe ff e8 9b 26 00 00 48 83 7c 24 10 00 0f 85 64 01 00 00 <8b> 54 24 30 85 d2 0f 84 d2 fa ff ff 31 d2 be a0 0a 00 00 48 c7 c7
RSP: 0000:ffff88800775fc88 EFLAGS: 00000202
RAX: 0000000000000119 RBX: ffff88800775fce0 RCX: 1ffffffff0d0d232
RDX: 0000000000000000 RSI: ffffffff8426aa20 RDI: ffffffff844e4c60
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff86868ba7
R10: fffffbfff0d0d174 R11: 0000000000000001 R12: 0000000000000000
R13: ffffffff854cb968 R14: 0000000000000000 R15: dffffc0000000000
 ? console_unlock+0x7ea/0x850
 ? devkmsg_read+0x640/0x640
 ? lock_acquire+0x1b6/0x4b0
 ? _printk+0x96/0xb2
 vprintk_emit+0xf0/0x2c0
 _printk+0x96/0xb2
 ? pm_suspend.cold+0x4dd/0x4dd
 ? cblist_init_generic+0x3af/0x530
 rcu_init_tasks_generic+0x71/0x15e
 kernel_init_freeable+0x17c/0x3e0
 ? rest_init+0x2d0/0x2d0
 kernel_init+0x19/0x140
 ret_from_fork+0x22/0x30
 </TASK>

=============================
WARNING: suspicious RCU usage
5.17.0-rc5-00050-gdc6e0818bc9a #2134 Not tainted
-----------------------------
include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 1, debug_locks = 1
2 locks held by swapper/0/1:
 #0: ffffffff850bed60 (console_lock){+.+.}-{0:0}, at: _printk+0x96/0xb2
 #1: ffff88806d4377d8 (&rq->__lock){-...}-{2:2}, at: scheduler_tick+0xa0/0x790

stack backtrace:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc5-00050-gdc6e0818bc9a #2134
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
Call Trace:
 <IRQ>
 dump_stack_lvl+0x45/0x59
 update_curr+0x634/0x870
 ? lock_is_held_type+0xd7/0x130
 task_tick_fair+0x77/0x810
 ? lock_is_held_type+0xd7/0x130
 scheduler_tick+0x210/0x790
 ? irq_work_single+0x16a/0x230
 update_process_times+0x119/0x170
 tick_periodic+0x56/0x1e0
 tick_handle_periodic+0x3b/0xa0
 __sysvec_apic_timer_interrupt+0x188/0x5a0
 sysvec_apic_timer_interrupt+0x89/0xc0
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20
RIP: 0010:console_unlock+0x681/0x850
Code: 08 e9 aa fc ff ff 48 c7 c6 0d a3 2c 81 48 c7 c7 60 e9 d3 84 e8 90 cb fe ff e8 9b 26 00 00 48 83 7c 24 10 00 0f 85 64 01 00 00 <8b> 54 24 30 85 d2 0f 84 d2 fa ff ff 31 d2 be a0 0a 00 00 48 c7 c7
RSP: 0000:ffff88800775fc88 EFLAGS: 00000202
RAX: 0000000000000119 RBX: ffff88800775fce0 RCX: 1ffffffff0d0d232
RDX: 0000000000000000 RSI: ffffffff8426aa20 RDI: ffffffff844e4c60
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff86868ba7
R10: fffffbfff0d0d174 R11: 0000000000000001 R12: 0000000000000000
R13: ffffffff854cb968 R14: 0000000000000000 R15: dffffc0000000000
 ? console_unlock+0x7ea/0x850
 ? devkmsg_read+0x640/0x640
 ? lock_acquire+0x1b6/0x4b0
 ? _printk+0x96/0xb2
 vprintk_emit+0xf0/0x2c0
 _printk+0x96/0xb2
 ? pm_suspend.cold+0x4dd/0x4dd
 ? cblist_init_generic+0x3af/0x530
 rcu_init_tasks_generic+0x71/0x15e
 kernel_init_freeable+0x17c/0x3e0
 ? rest_init+0x2d0/0x2d0
 kernel_init+0x19/0x140
 ret_from_fork+0x22/0x30
 </TASK>
cblist_init_generic: Setting shift to 2 and lim to 1.
Running RCU-tasks wait API self tests
Performance Events: unsupported p6 CPU model 60 no PMU driver, software events only.
rcu: Hierarchical SRCU implementation.

=============================
WARNING: suspicious RCU usage
5.17.0-rc5-00050-gdc6e0818bc9a #2134 Not tainted
-----------------------------
include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 1, debug_locks = 1
1 lock held by migration/0/15:
 #0: ffff88806d4377d8 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x1d4/0x2280

stack backtrace:
CPU: 0 PID: 15 Comm: migration/0 Not tainted 5.17.0-rc5-00050-gdc6e0818bc9a #2134
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
Stopper: 0x0 <- 0x0
Call Trace:
 <TASK>
 dump_stack_lvl+0x45/0x59
 put_prev_task_stop+0x48e/0x640
 ? balance_rt+0x2b3/0x3e0
 __schedule+0x1146/0x2280
 ? io_schedule_timeout+0x190/0x190
 ? lockdep_hardirqs_on_prepare+0x17b/0x400
 ? _raw_spin_unlock_irqrestore+0x2d/0x50
 ? smpboot_thread_fn+0x6b/0x8c0
 schedule+0xe0/0x270
 ? ikconfig_read_current+0x30/0x30
 smpboot_thread_fn+0x253/0x8c0
 ? smpboot_register_percpu_thread+0x320/0x320
 kthread+0x29f/0x340
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x22/0x30
 </TASK>
NMI watchdog: Perf NMI watchdog permanently disabled
smp: Bringing up secondary CPUs ...
x86: Booting SMP configuration:
.... node  #0, CPUs:      #1
smpboot: CPU 1 Converting physical 0 to logical die 1
 #2
smpboot: CPU 2 Converting physical 0 to logical die 2
Callback from call_rcu_tasks_trace() invoked.
Callback from call_rcu_tasks_rude() invoked.
 #3
smpboot: CPU 3 Converting physical 0 to logical die 3
smp: Brought up 1 node, 4 CPUs
smpboot: Max logical packages: 4
smpboot: Total of 4 processors activated (28894.81 BogoMIPS)
devtmpfs: initialized
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
futex hash table entries: 1024 (order: 5, 131072 bytes, linear)
NET: Registered PF_NETLINK/PF_ROUTE protocol family
audit: initializing netlink subsys (disabled)
Callback from call_rcu_tasks() invoked.
audit: type=2000 audit(1647449881.440:1): state=initialized audit_enabled=0 res=1
thermal_sys: Registered thermal governor 'step_wise'
thermal_sys: Registered thermal governor 'user_space'
cpuidle: using governor ladder
PCI: Using configuration type 1 for base access
kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
cryptd: max_cpu_qlen set to 1000
raid6: avx2x4   gen() 34895 MB/s
raid6: avx2x2   gen() 33100 MB/s
raid6: avx2x1   gen() 25416 MB/s
raid6: using algorithm avx2x4 gen() 34895 MB/s
raid6: .... xor() 13503 MB/s, rmw enabled
raid6: using avx2x2 recovery algorithm
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: Added _OSI(Linux-Dell-Video)
ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
ACPI: 1 ACPI AML tables successfully acquired and loaded
ACPI: Interpreter enabled
ACPI: PM: (supports S0 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
ACPI: Enabled 2 GPEs in block 00 to 0F
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments HPX-Type3]
acpi PNP0A03:00: PCIe port services disabled; not requesting _OSC control
acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: root bus resource [mem 0x80000000-0xfebfffff window]
pci_bus 0000:00: root bus resource [mem 0x100000000-0x17fffffff window]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
pci 0000:00:01.1: reg 0x20: [io  0xc2e0-0xc2ef]
pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
pci 0000:00:02.0: [1b36:0100] type 00 class 0x030000
pci 0000:00:02.0: reg 0x10: [mem 0xf4000000-0xf7ffffff]
pci 0000:00:02.0: reg 0x14: [mem 0xf8000000-0xfbffffff]
pci 0000:00:02.0: reg 0x18: [mem 0xfc054000-0xfc055fff]
pci 0000:00:02.0: reg 0x1c: [io  0xc200-0xc21f]
pci 0000:00:02.0: reg 0x30: [mem 0xfc040000-0xfc04ffff pref]
pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
pci 0000:00:03.0: [1af4:1000] type 00 class 0x020000
pci 0000:00:03.0: reg 0x10: [io  0xc220-0xc23f]
pci 0000:00:03.0: reg 0x14: [mem 0xfc056000-0xfc056fff]
pci 0000:00:03.0: reg 0x20: [mem 0xfebd4000-0xfebd7fff 64bit pref]
pci 0000:00:03.0: reg 0x30: [mem 0xfc000000-0xfc03ffff pref]
pci 0000:00:04.0: [8086:2668] type 00 class 0x040300
pci 0000:00:04.0: reg 0x10: [mem 0xfc050000-0xfc053fff]
pci 0000:00:05.0: [8086:2934] type 00 class 0x0c0300
pci 0000:00:05.0: reg 0x20: [io  0xc240-0xc25f]
pci 0000:00:05.1: [8086:2935] type 00 class 0x0c0300
pci 0000:00:05.1: reg 0x20: [io  0xc260-0xc27f]
pci 0000:00:05.2: [8086:2936] type 00 class 0x0c0300
pci 0000:00:05.2: reg 0x20: [io  0xc280-0xc29f]
pci 0000:00:05.7: [8086:293a] type 00 class 0x0c0320
pci 0000:00:05.7: reg 0x10: [mem 0xfc057000-0xfc057fff]
pci 0000:00:06.0: [1af4:1003] type 00 class 0x078000
pci 0000:00:06.0: reg 0x10: [io  0xc000-0xc03f]
pci 0000:00:06.0: reg 0x14: [mem 0xfc058000-0xfc058fff]
pci 0000:00:06.0: reg 0x20: [mem 0xfebd8000-0xfebdbfff 64bit pref]
pci 0000:00:07.0: [1af4:1001] type 00 class 0x010000
pci 0000:00:07.0: reg 0x10: [io  0xc040-0xc07f]
pci 0000:00:07.0: reg 0x14: [mem 0xfc059000-0xfc059fff]
pci 0000:00:07.0: reg 0x20: [mem 0xfebdc000-0xfebdffff 64bit pref]
pci 0000:00:08.0: [1af4:1002] type 00 class 0x00ff00
pci 0000:00:08.0: reg 0x10: [io  0xc2a0-0xc2bf]
pci 0000:00:08.0: reg 0x20: [mem 0xfebe0000-0xfebe3fff 64bit pref]
pci 0000:00:09.0: [1af4:1005] type 00 class 0x00ff00
pci 0000:00:09.0: reg 0x10: [io  0xc2c0-0xc2df]
pci 0000:00:09.0: reg 0x20: [mem 0xfebe4000-0xfebe7fff 64bit pref]
pci 0000:00:0a.0: [1af4:1001] type 00 class 0x010000
pci 0000:00:0a.0: reg 0x10: [io  0xc080-0xc0bf]
pci 0000:00:0a.0: reg 0x14: [mem 0xfc05a000-0xfc05afff]
pci 0000:00:0a.0: reg 0x20: [mem 0xfebe8000-0xfebebfff 64bit pref]
pci 0000:00:0b.0: [1af4:1001] type 00 class 0x010000
pci 0000:00:0b.0: reg 0x10: [io  0xc0c0-0xc0ff]
pci 0000:00:0b.0: reg 0x14: [mem 0xfc05b000-0xfc05bfff]
pci 0000:00:0b.0: reg 0x20: [mem 0xfebec000-0xfebeffff 64bit pref]
pci 0000:00:0c.0: [1af4:1001] type 00 class 0x010000
pci 0000:00:0c.0: reg 0x10: [io  0xc100-0xc13f]
pci 0000:00:0c.0: reg 0x14: [mem 0xfc05c000-0xfc05cfff]
pci 0000:00:0c.0: reg 0x20: [mem 0xfebf0000-0xfebf3fff 64bit pref]
pci 0000:00:0d.0: [1af4:1001] type 00 class 0x010000
pci 0000:00:0d.0: reg 0x10: [io  0xc140-0xc17f]
pci 0000:00:0d.0: reg 0x14: [mem 0xfc05d000-0xfc05dfff]
pci 0000:00:0d.0: reg 0x20: [mem 0xfebf4000-0xfebf7fff 64bit pref]
pci 0000:00:0e.0: [1af4:1001] type 00 class 0x010000
pci 0000:00:0e.0: reg 0x10: [io  0xc180-0xc1bf]
pci 0000:00:0e.0: reg 0x14: [mem 0xfc05e000-0xfc05efff]
pci 0000:00:0e.0: reg 0x20: [mem 0xfebf8000-0xfebfbfff 64bit pref]
pci 0000:00:0f.0: [1af4:1001] type 00 class 0x010000
pci 0000:00:0f.0: reg 0x10: [io  0xc1c0-0xc1ff]
pci 0000:00:0f.0: reg 0x14: [mem 0xfc05f000-0xfc05ffff]
pci 0000:00:0f.0: reg 0x20: [mem 0xfebfc000-0xfebfffff 64bit pref]
ACPI: PCI: Interrupt link LNKA configured for IRQ 10
ACPI: PCI: Interrupt link LNKB configured for IRQ 10
ACPI: PCI: Interrupt link LNKC configured for IRQ 11
ACPI: PCI: Interrupt link LNKD configured for IRQ 11
ACPI: PCI: Interrupt link LNKS configured for IRQ 9
pci 0000:00:02.0: vgaarb: setting as boot VGA device
pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
pci 0000:00:02.0: vgaarb: bridge control possible
vgaarb: loaded
SCSI subsystem initialized
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
PTP clock support registered
EDAC MC: Ver: 3.0.0
Advanced Linux Sound Architecture Driver Initialized.
PCI: Using ACPI for IRQ routing
clocksource: Switched to clocksource tsc-early
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
FS-Cache: Loaded
CacheFiles: Loaded
pnp: PnP ACPI init
pnp: PnP ACPI: found 5 devices
clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
NET: Registered PF_INET protocol family
IP idents hash table entries: 32768 (order: 6, 262144 bytes, linear)
tcp_listen_portaddr_hash hash table entries: 1024 (order: 4, 81920 bytes, linear)
TCP established hash table entries: 16384 (order: 5, 131072 bytes, linear)
TCP bind hash table entries: 16384 (order: 8, 1179648 bytes, linear)
TCP: Hash tables configured (established 16384 bind 16384)
UDP hash table entries: 1024 (order: 5, 163840 bytes, linear)
UDP-Lite hash table entries: 1024 (order: 5, 163840 bytes, linear)
NET: Registered PF_UNIX/PF_LOCAL protocol family
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: resource 7 [mem 0x80000000-0xfebfffff window]
pci_bus 0000:00: resource 8 [mem 0x100000000-0x17fffffff window]
pci 0000:00:01.0: PIIX3: Enabling Passive Release
pci 0000:00:00.0: Limiting direct PCI/PCI transfers
pci 0000:00:01.0: Activating ISA DMA hang workarounds
ACPI: \_SB_.LNKA: Enabled at IRQ 10
pci 0000:00:05.0: quirk_usb_early_handoff+0x0/0xa70 took 1972834 usecs
ACPI: \_SB_.LNKB: Enabled at IRQ 11
pci 0000:00:05.1: quirk_usb_early_handoff+0x0/0xa70 took 1981210 usecs
ACPI: \_SB_.LNKC: Enabled at IRQ 11
pci 0000:00:05.2: quirk_usb_early_handoff+0x0/0xa70 took 1999352 usecs
ACPI: \_SB_.LNKD: Enabled at IRQ 10
pci 0000:00:05.7: quirk_usb_early_handoff+0x0/0xa70 took 1996418 usecs
PCI: CLS 0 bytes, default 64
Trying to unpack rootfs image as initramfs...
Initialise system trusted keyrings
workingset: timestamp_bits=62 max_order=19 bucket_order=0
DLM installed
Key type cifs.idmap registered
fuse: init (API version 7.36)
SGI XFS with ACLs, security attributes, no debug enabled
ocfs2: Registered cluster interface o2cb
ocfs2: Registered cluster interface user
OCFS2 User DLM kernel interface loaded
gfs2: GFS2 installed
xor: automatically using best checksumming function   avx       
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
io scheduler mq-deadline registered
io scheduler kyber registered
test_string_helpers: Running tests...
cryptomgr_test (95) used greatest stack depth: 30160 bytes left
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: button: Power Button [PWRF]
Freeing initrd memory: 29252K
kworker/u8:3 (119) used greatest stack depth: 28520 bytes left
kworker/u8:2 (114) used greatest stack depth: 28272 bytes left
tsc: Refined TSC clocksource calibration: 3591.584 MHz
clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x33c545180c2, max_idle_ns: 440795274720 ns
clocksource: Switched to clocksource tsc
kworker/u8:2 (278) used greatest stack depth: 28048 bytes left
kworker/u8:2 (303) used greatest stack depth: 27216 bytes left
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
00:00: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
Non-volatile memory driver v1.3
Linux agpgart interface v0.103
ACPI: bus type drm_connector registered
brd: module loaded
loop: module loaded
virtio_blk virtio2: [vda] 16777216 512-byte logical blocks (8.59 GB/8.00 GiB)
 vda: vda1 vda2
virtio_blk virtio5: [vdb] 10485760 512-byte logical blocks (5.37 GB/5.00 GiB)
virtio_blk virtio6: [vdc] 10485760 512-byte logical blocks (5.37 GB/5.00 GiB)
virtio_blk virtio7: [vdd] 10485760 512-byte logical blocks (5.37 GB/5.00 GiB)
virtio_blk virtio8: [vde] 10485760 512-byte logical blocks (5.37 GB/5.00 GiB)
virtio_blk virtio9: [vdf] 41943040 512-byte logical blocks (21.5 GB/20.0 GiB)
virtio_blk virtio10: [vdg] 20971520 512-byte logical blocks (10.7 GB/10.0 GiB)
 vdg:
zram: Added device: zram0
scsi host0: ata_piix
scsi host1: ata_piix
ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc2e0 irq 14
ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc2e8 irq 15
tun: Universal TUN/TAP device driver, 1.6
e1000: Intel(R) PRO/1000 Network Driver
e1000: Copyright (c) 1999-2006 Intel Corporation.
e1000e: Intel(R) PRO/1000 Network Driver
e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
PPP generic driver version 2.4.2
aoe: AoE v85 initialised.
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ata1: found unknown device (class 0)
ata1.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
scsi 0:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
sr 0:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
cdrom: Uniform CD-ROM driver Revision: 3.20
sr 0:0:0:0: Attached scsi generic sg0 type 5
ehci-pci 0000:00:05.7: EHCI Host Controller
ehci-pci 0000:00:05.7: new USB bus registered, assigned bus number 1
ehci-pci 0000:00:05.7: irq 10, io mem 0xfc057000
ehci-pci 0000:00:05.7: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
uhci_hcd: USB Universal Host Controller Interface driver
usb 1-1: new high-speed USB device number 2 using ehci-pci
uhci_hcd 0000:00:05.0: UHCI Host Controller
uhci_hcd 0000:00:05.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:05.0: irq 10, io port 0x0000c240
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:05.1: UHCI Host Controller
uhci_hcd 0000:00:05.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:05.1: irq 11, io port 0x0000c260
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:05.2: UHCI Host Controller
uhci_hcd 0000:00:05.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:05.2: irq 11, io port 0x0000c280
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usbcore: registered new interface driver usblp
usbcore: registered new interface driver usb-storage
i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mousedev: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
input: PC Speaker as /devices/platform/pcspkr/input/input4
device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initialised: dm-devel@redhat.com
device-mapper: multipath round-robin: version 1.2.0 loaded
intel_pstate: CPU model not supported
input: QEMU QEMU USB Tablet as /devices/pci0000:00/0000:00:05.7/usb1/1-1/1-1:1.0/0003:0627:0001.0001/input/input5
hid-generic 0003:0627:0001.0001: input: USB HID v0.01 Mouse [QEMU QEMU USB Tablet] on usb-0000:00:05.7-1/input0
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
netem: version 1.3
NET: Registered PF_INET6 protocol family
Segment Routing with IPv6
In-situ OAM (IOAM) with IPv6
sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
NET: Registered PF_PACKET protocol family
NET: Registered PF_KEY protocol family
sctp: Hash tables configured (bind 32/56)
Key type dns_resolver registered
IPI shorthand broadcast: enabled
AVX2 version of gcm_enc/dec engaged.
AES CTR mode by8 optimization enabled
sched_clock: Marking stable (28096270726, 82668394)->(28303532526, -124593406)
Loading compiled-in X.509 certificates
debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
Btrfs loaded, crc32c=crc32c-intel, zoned=no, fsverity=no
ima: No TPM chip found, activating TPM-bypass!
ima: Allocated hash algorithm: sha1
ima: No architecture policies found
ALSA device list:
  #0: Virtual MIDI Card 1
Freeing unused kernel image (initmem) memory: 2088K
Write protecting the kernel read-only data: 61440k
Freeing unused kernel image (text/rodata gap) memory: 2028K
Freeing unused kernel image (rodata/data gap) memory: 884K
Run /init as init process
systemd[1]: systemd v246.13-1.fc33 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=unified)
systemd[1]: Detected virtualization kvm.
systemd[1]: Detected architecture x86-64.
systemd[1]: Running in initial RAM disk.

Welcome to 
