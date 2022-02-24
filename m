Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA7E4C2063
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 01:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245144AbiBXAJl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Feb 2022 19:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245143AbiBXAJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 19:09:39 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE3D5F26D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:09:08 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id o8-20020a056e0214c800b002bc2f9cffffso358475ilk.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:09:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:content-transfer-encoding;
        bh=x8iw6GnwDHIRnugpKTBVBlbpNe1zQoH0LsZOhQmt6Ik=;
        b=nz0N6Qvh+RqNBnUGP5kHu8KlPb8Rn0DoiWGqQvnBAr5MzHJWhvxAkkIR29jftYyHGe
         0FjXgmAvNqJY3uPHpGe0yfka/eKcir8IA4cmojZd8ykDmXIDRpImna1NeVro3ay46I+S
         Sdu1qd+wwQ55BPCd9sxAm3yf7DbF2aaqwlS14Gozen6vbGf6F2XoTPWCk0RH09+RWEha
         c37nopRlyeDbiIWXCdLWOMFYYB/v6nsH/ESAFQ/oh1g4K+OAJez/DcXFcZczDZ74bueI
         qQzusfBcUpvU8dwkLDl22OHgvQKz43BmzEFDUKC2sjXZ2MBdcyPpBF0ma+k3iFlQ5J6+
         pFTg==
X-Gm-Message-State: AOAM530fDRxyCh9fKAhKxVnEq+LarHKVs3B/W/OJuHR9Rfj2tLGagaHg
        wCBahSLZtTxdvMY/LzJOpSEXUOwN8utbvrjXaEduQ+TvBiUD
X-Google-Smtp-Source: ABdhPJxipYxflrSNLfO/KcbxZVS+mQo6v6uhZqZwOrNaDzSTKWejQV0Dn64w+d5wix8zdA6Ce5IQI7Zukhq83TVSVWfQuhwndNr9
MIME-Version: 1.0
X-Received: by 2002:a6b:e90d:0:b0:641:562e:de7f with SMTP id
 u13-20020a6be90d000000b00641562ede7fmr130178iof.30.1645661347467; Wed, 23 Feb
 2022 16:09:07 -0800 (PST)
Date:   Wed, 23 Feb 2022 16:09:07 -0800
In-Reply-To: <20220223233323.2104-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000095b0805d8b8642e@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in dev_uevent
From:   syzbot <syzbot+348b571beb5eeb70a582@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, hdanton@sina.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

rved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000][    T0] printk: bootconsole [earlyser0] enabled
[    0.000000][    T0] ERROR: earlyprintk= earlyser already used
[    0.000000][    T0] ERROR: earlyprintk= earlyser already used
[    0.000000][    T0] **********************************************************
[    0.000000][    T0] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    0.000000][    T0] **                                                      **
[    0.000000][    T0] ** This system shows unhashed kernel memory addresses   **
[    0.000000][    T0] ** via the console, logs, and other interfaces. This    **
[    0.000000][    T0] ** might reduce the security of your system.            **
[    0.000000][    T0] **                                                      **
[    0.000000][    T0] ** If you see this message and you are not debugging    **
[    0.000000][    T0] ** the kernel, report this immediately to your system   **
[    0.000000][    T0] ** administrator!                                       **
[    0.000000][    T0] **                                                      **
[    0.000000][    T0] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    0.000000][    T0] **********************************************************
[    0.000000][    T0] Malformed early option 'vsyscall'
[    0.000000][    T0] nopcid: PCID feature disabled
[    0.000000][    T0] NX (Execute Disable) protection: active
[    0.000000][    T0] SMBIOS 2.8 present.
[    0.000000][    T0] DMI: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
[    0.000000][    T0] Hypervisor detected: KVM
[    0.000000][    T0] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000010][    T0] kvm-clock: using sched offset of 4841464710 cycles
[    0.006420][    T0] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.028208][    T0] tsc: Detected 2299.998 MHz processor
[    0.044676][    T0] last_pfn = 0x7ffdd max_arch_pfn = 0x400000000
[    0.052048][    T0] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.077664][    T0] found SMP MP-table at [mem 0x000f5c80-0x000f5c8f]
[    0.085099][    T0] Using GB pages for direct mapping
[    0.092737][    T0] ACPI: Early table checksum verification disabled
[    0.099989][    T0] ACPI: RSDP 0x00000000000F5AD0 000014 (v00 BOCHS )
[    0.107558][    T0] ACPI: RSDT 0x000000007FFE1F5B 000044 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
[    0.118624][    T0] ACPI: FACP 0x000000007FFE17ED 0000F4 (v03 BOCHS  BXPCFACP 00000001 BXPC 00000001)
[    0.129324][    T0] ACPI: DSDT 0x000000007FFDF040 0027AD (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
[    0.140350][    T0] ACPI: FACS 0x000000007FFDF000 000040
[    0.147131][    T0] ACPI: APIC 0x000000007FFE18E1 0000B0 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
[    0.158068][    T0] ACPI: HPET 0x000000007FFE1991 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
[    0.169790][    T0] ACPI: SRAT 0x000000007FFE19C9 000150 (v01 BOCHS  BXPCSRAT 00000001 BXPC 00000001)
[    0.183784][    T0] ACPI: MCFG 0x000000007FFE1B19 00003C (v01 BOCHS  BXPCMCFG 00000001 BXPC 00000001)
[    0.196240][    T0] ACPI: SSDT 0x000000007FFE1B55 0002FE (v01 BOCHS  NVDIMM   00000001 BXPC 00000001)
[    0.206910][    T0] ACPI: NFIT 0x000000007FFE1E53 0000E0 (v01 BOCHS  BXPCNFIT 00000001 BXPC 00000001)
[    0.217984][    T0] ACPI: WAET 0x000000007FFE1F33 000028 (v01 BOCHS  BXPCWAET 00000001 BXPC 00000001)
[    0.228680][    T0] ACPI: Reserving FACP table memory at [mem 0x7ffe17ed-0x7ffe18e0]
[    0.237870][    T0] ACPI: Reserving DSDT table memory at [mem 0x7ffdf040-0x7ffe17ec]
[    0.247060][    T0] ACPI: Reserving FACS table memory at [mem 0x7ffdf000-0x7ffdf03f]
[    0.256685][    T0] ACPI: Reserving APIC table memory at [mem 0x7ffe18e1-0x7ffe1990]
[    0.267278][    T0] ACPI: Reserving HPET table memory at [mem 0x7ffe1991-0x7ffe19c8]
[    0.278047][    T0] ACPI: Reserving SRAT table memory at [mem 0x7ffe19c9-0x7ffe1b18]
[    0.288568][    T0] ACPI: Reserving MCFG table memory at [mem 0x7ffe1b19-0x7ffe1b54]
[    0.298508][    T0] ACPI: Reserving SSDT table memory at [mem 0x7ffe1b55-0x7ffe1e52]
[    0.308970][    T0] ACPI: Reserving NFIT table memory at [mem 0x7ffe1e53-0x7ffe1f32]
[    0.318669][    T0] ACPI: Reserving WAET table memory at [mem 0x7ffe1f33-0x7ffe1f5a]
[    0.330876][    T0] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.339042][    T0] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.345474][    T0] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.353247][    T0] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.359480][    T0] SRAT: PXM 0 -> APIC 0x04 -> Node 0
[    0.365721][    T0] SRAT: PXM 0 -> APIC 0x05 -> Node 0
[    0.371884][    T0] SRAT: PXM 0 -> APIC 0x06 -> Node 0
[    0.377522][    T0] SRAT: PXM 0 -> APIC 0x07 -> Node 0
[    0.384813][    T0] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
[    0.395457][    T0] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0x7fffffff]
[    0.404488][    T0] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x103ffffff] non-volatile
[    0.415659][    T0] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x57fffffff] hotplug
[    0.425295][    T0] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0x7ffdcfff] -> [mem 0x00000000-0x7ffdcfff]
[    0.441264][    T0] Faking node 0 at [mem 0x0000000000000000-0x000000003fffffff] (1024MB)
[    0.452382][    T0] Faking node 1 at [mem 0x0000000040000000-0x000000007ffdcfff] (1023MB)
[    0.463520][    T0] NODE_DATA(0) allocated [mem 0x3fffa000-0x3fffffff]
[    0.495102][    T0] NODE_DATA(1) allocated [mem 0x7ffd6000-0x7ffdbfff]
[    0.624260][    T0] Zone ranges:
[    0.628554][    T0]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.637027][    T0]   DMA32    [mem 0x0000000001000000-0x000000007ffdcfff]
[    0.645022][    T0]   Normal   empty
[    0.649211][    T0]   Device   empty
[    0.653388][    T0] Movable zone start for each node
[    0.659134][    T0] Early memory node ranges
[    0.663919][    T0]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.671093][    T0]   node   0: [mem 0x0000000000100000-0x000000003fffffff]
[    0.680263][    T0]   node   1: [mem 0x0000000040000000-0x000000007ffdcfff]
[    0.688146][    T0] Initmem setup node 0 [mem 0x0000000000001000-0x000000003fffffff]
[    0.698201][    T0] Initmem setup node 1 [mem 0x0000000040000000-0x000000007ffdcfff]
[    0.707121][    T0] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.707294][    T0] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.736554][    T0] On node 1, zone DMA32: 35 pages in unavailable ranges
[    3.577677][    T0] kasan: KernelAddressSanitizer initialized
[    3.600915][    T0] ACPI: PM-Timer IO Port: 0x608
[    3.606813][    T0] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    3.615468][    T0] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    3.625828][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    3.634874][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    3.644347][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    3.654081][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    3.662744][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    3.671805][    T0] ACPI: Using ACPI (MADT) for SMP configuration information
[    3.679827][    T0] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    3.686796][    T0] TSC deadline timer available
[    3.693129][    T0] smpboot: Allowing 8 CPUs, 4 hotplug CPUs
[    3.702252][    T0] kvm-guest: KVM setup pv remote TLB flush
[    3.710588][    T0] kvm-guest: setup PV sched yield
[    3.716883][    T0] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    3.729141][    T0] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    3.739780][    T0] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    3.750742][    T0] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    3.761917][    T0] [mem 0xc0000000-0xfed1bfff] available for PCI devices
[    3.771441][    T0] Booting paravirtualized kernel on KVM
[    3.778731][    T0] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    3.868892][    T0] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:2
[    3.941088][    T0] percpu: Embedded 69 pages/cpu s243080 r8192 d31352 u1048576
[    3.949787][    T0] kvm-guest: PV spinlocks enabled
[    3.955248][    T0] PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, linear)
[    3.965589][    T0] Fallback order for Node 0: 0 1 
[    3.971703][    T0] Fallback order for Node 1: 1 0 
[    3.977643][    T0] Built 2 zonelists, mobility grouping on.  Total pages: 515805
[    3.985125][    T0] Policy zone: DMA32
[    3.988942][    T0] Kernel command line: earlyprintk=serial net.ifnames=0 sysctl.kernel.hung_task_all_cpu_backtrace=1 ima_policy=tcb nf-conntrack-ftp.ports=20000 nf-conntrack-tftp.ports=20000 nf-conntrack-sip.ports=20000 nf-conntrack-irc.ports=20000 nf-conntrack-sane.ports=20000 binder.debug_mask=0 rcupdate.rcu_expedited=1 no_hash_pointers page_owner=on sysctl.vm.nr_hugepages=4 sysctl.vm.nr_overcommit_hugepages=4 secretmem.enable=1 root=/dev/sda console=ttyS0 vsyscall=native numa=fake=2 kvm-intel.nested=1 spec_store_bypass_disable=prctl nopcid vivid.n_devs=16 vivid.multiplanar=1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2 netrom.nr_ndevs=16 rose.rose_ndevs=16 dummy_hcd.num=8 watchdog_thresh=55 workqueue.watchdog_thresh=140 sysctl.net.core.netdev_unregister_timeout_secs=140 panic_on_warn=1 root=/dev/sda console=ttyS0 root=/dev/sda1
[    4.080347][    T0] Unknown kernel command line parameters "spec_store_bypass_disable=prctl", will be passed to user space.
[    4.099480][    T0] mem auto-init: stack:off, heap alloc:on, heap free:off
[    4.106489][    T0] Stack Depot allocating hash table with memblock_alloc
[    4.704849][    T0] Memory: 1433552K/2096620K available (139293K kernel code, 34169K rwdata, 29628K rodata, 4580K init, 25004K bss, 662812K reserved, 0K cma-reserved)
[    4.729067][    T0] Dynamic Preempt: full
[    4.735024][    T0] Running RCU self tests
[    4.739495][    T0] rcu: Preemptible hierarchical RCU implementation.
[    4.746547][    T0] rcu: 	RCU lockdep checking is enabled.
[    4.754211][    T0] rcu: 	RCU callback double-/use-after-free debug is enabled.
[    4.764303][    T0] rcu: 	RCU debug extended QS entry/exit.
[    4.770362][    T0] 	All grace periods are expedited (rcu_expedited).
[    4.777690][    T0] 	Trampoline variant of Tasks RCU enabled.
[    4.784681][    T0] 	Tracing variant of Tasks RCU enabled.
[    4.792455][    T0] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    4.870793][    T0] NR_IRQS: 4352, nr_irqs: 488, preallocated irqs: 16
[    4.881707][    T0] kfence: initialized - using 2097152 bytes for 255 objects at 0xffff88807ea00000-0xffff88807ec00000
[    4.895844][    T0] random: crng init done (trusting CPU's manufacturer)
[    4.979384][    T0] Console: colour VGA+ 80x25
[    4.984343][    T0] printk: console [ttyS0] enabled
[    4.984343][    T0] printk: console [ttyS0] enabled
[    4.998450][    T0] printk: bootconsole [earlyser0] disabled
[    4.998450][    T0] printk: bootconsole [earlyser0] disabled
[    5.013775][    T0] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    5.024328][    T0] ... MAX_LOCKDEP_SUBCLASSES:  8
[    5.029407][    T0] ... MAX_LOCK_DEPTH:          48
[    5.035102][    T0] ... MAX_LOCKDEP_KEYS:        8192
[    5.041645][    T0] ... CLASSHASH_SIZE:          4096
[    5.048831][    T0] ... MAX_LOCKDEP_ENTRIES:     65536
[    5.054594][    T0] ... MAX_LOCKDEP_CHAINS:      131072
[    5.061737][    T0] ... CHAINHASH_SIZE:          65536
[    5.068445][    T0]  memory used by lock dependency info: 11129 kB
[    5.076520][    T0]  memory used for stack traces: 8320 kB
[    5.082878][    T0]  per task-struct memory footprint: 1920 bytes
[    5.090267][    T0] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    5.103237][    T0] ACPI: Core revision 20211217
[    5.111931][    T0] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    5.124702][    T0] APIC: Switch to symmetric I/O mode setup
[    5.130900][    T0] kvm-guest: setup PV IPIs
[    5.152566][    T0] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    5.159998][    T0] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x212733415c7, max_idle_ns: 440795236380 ns
[    5.172074][    T0] Calibrating delay loop (skipped) preset value.. 4599.99 BogoMIPS (lpj=22999980)
[    5.182060][    T0] pid_max: default: 32768 minimum: 301
[    5.193619][    T0] LSM: Security Framework initializing
[    5.202508][    T0] landlock: Up and running.
[    5.207072][    T0] Yama: becoming mindful.
[    5.212453][    T0] TOMOYO Linux initialized
[    5.217819][    T0] SELinux:  Initializing.
[    5.232263][    T0] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, vmalloc)
[    5.247309][    T0] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, vmalloc)
[    5.252395][    T0] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, vmalloc)
[    5.262162][    T0] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, vmalloc)
[    5.278290][    T0] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    5.283030][    T0] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    5.292049][    T0] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    5.298386][    T0] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    5.302119][    T0] Spectre V2 : Spectre mitigation: kernel not compiled with retpoline; no mitigation available!
[    5.302195][    T0] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    5.322102][    T0] MDS: Mitigation: Clear CPU buffers
[    5.336209][    T0] Freeing SMP alternatives memory: 108K
[    5.344907][    T1] smpboot: CPU0: Intel(R) Xeon(R) CPU @ 2.30GHz (family: 0x6, model: 0x3f, stepping: 0x0)
[    5.356906][    T1] cblist_init_generic: Setting adjustable number of callback queues.
[    5.362324][    T1] cblist_init_generic: Setting shift to 3 and lim to 1.
[    5.371420][    T1] cblist_init_generic: Setting shift to 3 and lim to 1.
[    5.372853][    T1] Running RCU-tasks wait API self tests
[    5.492569][    T1] Performance Events: unsupported p6 CPU model 63 no PMU driver, software events only.
[    5.504091][    T1] rcu: Hierarchical SRCU implementation.
[    5.512259][   T13] Callback from call_rcu_tasks_trace() invoked.
[    5.529324][    T1] NMI watchdog: Perf NMI watchdog permanently disabled
[    5.535930][    T1] smp: Bringing up secondary CPUs ...
[    5.555151][    T1] x86: Booting SMP configuration:
[    5.562217][    T1] .... node  #0, CPUs:      #1
[    5.575083][    T1] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    5.591084][    T1]  #2
[    5.608423][    T1]  #3
[    5.615274][    T1] smp: Brought up 2 nodes, 4 CPUs
[    5.622164][    T1] smpboot: Max logical packages: 2
[    5.631031][    T1] smpboot: Total of 4 processors activated (18399.98 BogoMIPS)
[    5.712169][   T12] Callback from call_rcu_tasks() invoked.
[    5.777513][    T1] allocated 25165824 bytes of page_ext
[    5.782961][    T1] Node 0, zone      DMA: page owner found early allocated 0 pages
[    5.804037][    T1] Node 0, zone    DMA32: page owner found early allocated 6294 pages
[    5.814579][    T1] Node 1, zone    DMA32: page owner found early allocated 3897 pages
[    5.824873][    T1] devtmpfs: initialized
[    5.833339][    T1] x86/mm: Memory block size: 128MB
[    5.878831][    T1] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    5.882775][    T1] futex hash table entries: 2048 (order: 6, 262144 bytes, vmalloc)


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=103b5402700000


Tested on:

commit:         4f12b742 Merge tag 'nfs-for-5.17-3' of git://git.linux..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6a069ed94a1ed1d
dashboard link: https://syzkaller.appspot.com/bug?extid=348b571beb5eeb70a582
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=123231fe700000

