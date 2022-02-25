Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20474C3CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 05:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbiBYEBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 23:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbiBYEBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 23:01:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C755235316
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 20:00:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3676B82B05
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1D4C340E7;
        Fri, 25 Feb 2022 04:00:36 +0000 (UTC)
Date:   Thu, 24 Feb 2022 23:00:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Strange output on the console
Message-ID: <20220224230035.36547137@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/QNi0EY+Vf4Gh.2NbIHExy.Y"
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/QNi0EY+Vf4Gh.2NbIHExy.Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


I've been noticing that my tests have been spitting out strange output on
the console. It would happen at boot up and then clear up. It looks like
something screwed up with the serial timing.

Attached is a dmesg of one of my test runs as an example.

I've noticed this on both 32 bit and 64 bit x86.

I haven't had time to look deeper into this, but I figured I let you know
about it.

And it always seems to happen right after:

  Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled

Maybe this is a serial issue and not a printk one? :-/

-- Steve


--MP_/QNi0EY+Vf4Gh.2NbIHExy.Y
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=strange.txt

Linux version 5.17.0-rc1-test+ (rostedt@mammoth) (gcc (Debian 11.2.0-14) 11.2.0, GNU ld (GNU Binutils for Debian) 2.37.90.20220123) #2 SMP PREEMPT Thu Feb 24 22:47:34 EST 2022
x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
signal: max sigframe size: 1760
BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000000-0x000000000009d7ff] usable
BIOS-e820: [mem 0x000000000009d800-0x000000000009ffff] reserved
BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
BIOS-e820: [mem 0x0000000000100000-0x00000000c69e4fff] usable
BIOS-e820: [mem 0x00000000c69e5000-0x00000000c69ebfff] ACPI NVS
BIOS-e820: [mem 0x00000000c69ec000-0x00000000c6e2efff] usable
BIOS-e820: [mem 0x00000000c6e2f000-0x00000000c73bffff] reserved
BIOS-e820: [mem 0x00000000c73c0000-0x00000000d8da2fff] usable
BIOS-e820: [mem 0x00000000d8da3000-0x00000000d8e3afff] reserved
BIOS-e820: [mem 0x00000000d8e3b000-0x00000000d8e94fff] usable
BIOS-e820: [mem 0x00000000d8e95000-0x00000000d8fc7fff] ACPI NVS
BIOS-e820: [mem 0x00000000d8fc8000-0x00000000d9ffefff] reserved
BIOS-e820: [mem 0x00000000d9fff000-0x00000000d9ffffff] usable
BIOS-e820: [mem 0x00000000db000000-0x00000000df1fffff] reserved
BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
BIOS-e820: [mem 0x0000000100000000-0x000000021edfffff] usable
printk: debug: ignoring loglevel setting.
printk: bootconsole [earlyser0] enabled
NX (Execute Disable) protection: active
SMBIOS 2.8 present.
DMI: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
tsc: Fast TSC calibration using PIT
tsc: Detected 3400.121 MHz processor
e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
e820: remove [mem 0x000a0000-0x000fffff] usable
last_pfn = 0x21ee00 max_arch_pfn = 0x1000000
x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
total RAM covered: 8094M
Found optimal setting for mtrr clean up
 gran_size: 64K 	chunk_size: 128M 	num_reg: 9  	lose cover RAM: 0G
e820: update [mem 0xdb000000-0xffffffff] usable ==> reserved
found SMP MP-table at [mem 0x000fd770-0x000fd77f]
initial memory mapped: [mem 0x00000000-0x025fffff]
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x00000000000F04A0 000024 (v02 ALASKA)
ACPI: XSDT 0x00000000D8F99080 00007C (v01 ALASKA A M I    01072009 AMI  00010013)
ACPI: FACP 0x00000000D8FA6AD0 00010C (v05 ALASKA A M I    01072009 AMI  00010013)
ACPI: DSDT 0x00000000D8F99190 00D940 (v02 ALASKA A M I    00000034 INTL 20120711)
ACPI: FACS 0x00000000D8FC7F80 000040
ACPI: APIC 0x00000000D8FA6BE0 000072 (v03 ALASKA A M I    01072009 AMI  00010013)
ACPI: FPDT 0x00000000D8FA6C58 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
ACPI: SSDT 0x00000000D8FA6CA0 000539 (v01 PmRef  Cpu0Ist  00003000 INTL 20120711)
ACPI: SSDT 0x00000000D8FA71E0 000AD8 (v01 PmRef  CpuPm    00003000 INTL 20120711)
ACPI: MCFG 0x00000000D8FA7CB8 00003C (v01 ALASKA A M I    01072009 MSFT 00000097)
ACPI: HPET 0x00000000D8FA7CF8 000038 (v01 ALASKA A M I    01072009 AMI. 00000005)
ACPI: SSDT 0x00000000D8FA7D30 00036D (v01 SataRe SataTabl 00001000 INTL 20120711)
ACPI: SSDT 0x00000000D8FA80A0 0034E1 (v01 SaSsdt SaSsdt   00003000 INTL 20091112)
ACPI: ASF! 0x00000000D8FAB588 0000A5 (v32 INTEL   HCG     00000001 TFSM 000F4240)
ACPI: SSDT 0x00000000D8FAB630 000A26 (v01 Intel_ IsctTabl 00001000 INTL 20120711)
ACPI: Reserving FACP table memory at [mem 0xd8fa6ad0-0xd8fa6bdb]
ACPI: Reserving DSDT table memory at [mem 0xd8f99190-0xd8fa6acf]
ACPI: Reserving FACS table memory at [mem 0xd8fc7f80-0xd8fc7fbf]
ACPI: Reserving APIC table memory at [mem 0xd8fa6be0-0xd8fa6c51]
ACPI: Reserving FPDT table memory at [mem 0xd8fa6c58-0xd8fa6c9b]
ACPI: Reserving SSDT table memory at [mem 0xd8fa6ca0-0xd8fa71d8]
ACPI: Reserving SSDT table memory at [mem 0xd8fa71e0-0xd8fa7cb7]
ACPI: Reserving MCFG table memory at [mem 0xd8fa7cb8-0xd8fa7cf3]
ACPI: Reserving HPET table memory at [mem 0xd8fa7cf8-0xd8fa7d2f]
ACPI: Reserving SSDT table memory at [mem 0xd8fa7d30-0xd8fa809c]
ACPI: Reserving SSDT table memory at [mem 0xd8fa80a0-0xd8fab580]
ACPI: Reserving ASF! table memory at [mem 0xd8fab588-0xd8fab62c]
ACPI: Reserving SSDT table memory at [mem 0xd8fab630-0xd8fac055]
7800MB HIGHMEM available.
885MB LOWMEM available.
  mapped low ram: 0 - 375fe000
  low ram: 0 - 375fe000
Reserving 256MB of memory at 256MB for crashkernel (System RAM: 8054MB)
Zone ranges:
  DMA      [mem 0x0000000000001000-0x0000000000ffffff]
  Normal   [mem 0x0000000001000000-0x00000000375fdfff]
  HighMem  [mem 0x00000000375fe000-0x000000021edfffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000001000-0x000000000009cfff]
  node   0: [mem 0x0000000000100000-0x00000000c69e4fff]
  node   0: [mem 0x00000000c69ec000-0x00000000c6e2efff]
  node   0: [mem 0x00000000c73c0000-0x00000000d8da2fff]
  node   0: [mem 0x00000000d8e3b000-0x00000000d8e94fff]
  node   0: [mem 0x00000000d9fff000-0x00000000d9ffffff]
  node   0: [mem 0x0000000100000000-0x000000021edfffff]
Initmem setup node 0 [mem 0x0000000000001000-0x000000021edfffff]
On node 0, zone DMA: 1 pages in unavailable ranges
On node 0, zone DMA: 99 pages in unavailable ranges
On node 0, zone HighMem: 7 pages in unavailable ranges
On node 0, zone HighMem: 1425 pages in unavailable ranges
On node 0, zone HighMem: 152 pages in unavailable ranges
On node 0, zone HighMem: 4458 pages in unavailable ranges
On node 0, zone HighMem: 155648 pages in unavailable ranges
Using APIC driver default
Reserving Intel graphics memory at [mem 0xdb200000-0xdf1fffff]
ACPI: PM-Timer IO Port: 0x1808
ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a701 base: 0xfed00000
[Firmware Bug]: TSC_DEADLINE disabled due to Errata; please update microcode to version: 0x22 (or later)
smpboot: Allowing 4 CPUs, 0 hotplug CPUs
PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
PM: hibernation: Registered nosave memory: [mem 0x0009d000-0x0009dfff]
PM: hibernation: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
PM: hibernation: Registered nosave memory: [mem 0xc69e5000-0xc69ebfff]
PM: hibernation: Registered nosave memory: [mem 0xc6e2f000-0xc73bffff]
PM: hibernation: Registered nosave memory: [mem 0xd8da3000-0xd8e3afff]
PM: hibernation: Registered nosave memory: [mem 0xd8e95000-0xd8fc7fff]
PM: hibernation: Registered nosave memory: [mem 0xd8fc8000-0xd9ffefff]
PM: hibernation: Registered nosave memory: [mem 0xda000000-0xdaffffff]
PM: hibernation: Registered nosave memory: [mem 0xdb000000-0xdf1fffff]
PM: hibernation: Registered nosave memory: [mem 0xdf200000-0xf7ffffff]
PM: hibernation: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
PM: hibernation: Registered nosave memory: [mem 0xfc000000-0xfebfffff]
PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
PM: hibernation: Registered nosave memory: [mem 0xfed00000-0xfed03fff]
PM: hibernation: Registered nosave memory: [mem 0xfed04000-0xfed1bfff]
PM: hibernation: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfedfffff]
PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
[mem 0xdf200000-0xf7ffffff] available for PCI devices
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4 nr_node_ids:1
percpu: Embedded 352 pages/cpu s1411636 r0 d30156 u1441792
pcpu-alloc: s1411636 r0 d30156 u1441792 alloc=352*4096
pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
Built 1 zonelists, mobility grouping on.  Total pages: 2060054
Kernel command line: ro root=/dev/sda6 console=ttyS0,115200 ignore_loglevel selinux=0 earlyprintk=ttyS0,115200 ftrace=dummy crashkernel=256M
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
mem auto-init: stack:off, heap alloc:off, heap free:off
Initializing HighMem for node 0 (000375fe:0021ee00)
Initializing Movable for node 0 (00000000:00000000)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
Memory: 7812188K/8247304K available (11861K kernel code, 2065K rwdata, 6364K rodata, 2296K init, 7536K bss, 435116K reserved, 0K cma-reserved, 7340448K highmem)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
ODEBUG: selftest passed
Kernel/User page tables isolation: enabled

************************************************************
** WARNING! WARNING! WARNING! WARNING! WARNING! WARNING!  **
**                                                        **
** You are using 32-bit PTI on a 64-bit PCID-capable CPU. **
** Your performance will increase dramatically if you     **
** switch to a 64-bit kernel!                             **
**                                                        **
** WARNING! WARNING! WARNING! WARNING! WARNING! WARNING!  **
************************************************************
ftrace: allocating 61079 entries in 120 pages
ftrace: allocated 120 pages with 4 groups
trace event string verifier disabled
Dynamic Preempt: voluntary
Running RCU self tests
rcu: Preemptible hierarchical RCU implementation.
rcu: 	RCU lockdep checking is enabled.
rcu: 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
rcu: 	RCU callback double-/use-after-free debug is enabled.
	Trampoline variant of Tasks RCU enabled.
	Rude variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
NR_IRQS: 2304, nr_irqs: 456, preallocated irqs: 16
random: get_random_bytes called from start_kernel+0x451/0x5ef with crng_init=0
Console: colour VGA+ 80x25
printk: console [ttyS0] enabled
printk: console [ttyS0] enabled
printk: bootconsole [earlyser0] disabled
printk: bootconsole [earlyser0] disabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8192
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     32768
... MAX_LOCKDEP_CHAINS:      65536
... CHAINHASH_SIZE:          32768
 memory used by lock dependency info: 4061 kB
 memory used for stack traces: 2112 kB
 per task-struct memory footprint: 2112 bytes
------------------------
| Locking API testsuite:
----------------------------------------------------------------------------
                                 | spin |wlock |rlock |mutex | wsem | rsem |rtmutex
  --------------------------------------------------------------------------
                     A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                    double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                  initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
  --------------------------------------------------------------------------
              recursive read-lock:             |  ok  |             |  ok  |
           recursive read-lock #2:             |  ok  |             |  ok  |
            mixed read-write-lock:             |  ok  |             |  ok  |
            mixed write-read-lock:             |  ok  |             |  ok  |
  mixed read-lock/lock-write ABBA:             |  ok  |             |  ok  |
   mixed read-lock/lock-read ABBA:             |  ok  |             |  ok  |
 mixed write-lock/lock-write ABBA:             |  ok  |             |  ok  |
  chain cached mixed R-L/L-W ABBA:             |  ok  |
         rlock W1R2/W2R3/W3R1/123:             |  ok  |
         rlock W1R2/W2R3/W3R1/132:             |  ok  |
         rlock W1R2/W2R3/W3R1/213:             |  ok  |
         rlock W1R2/W2R3/W3R1/231:             |  ok  |
         rlock W1R2/W2R3/W3R1/312:             |  ok  |
         rlock W1R2/W2R3/W3R1/321:             |  ok  |
         rlock W1W2/R2R3/W3R1/123:             |  ok  |
         rlock W1W2/R2R3/W3R1/132:             |  ok  |
         rlock W1W2/R2R3/W3R1/213:             |  ok  |
         rlock W1W2/R2R3/W3R1/231:             |  ok  |
         rlock W1W2/R2R3/W3R1/312:             |  ok  |
         rlock W1W2/R2R3/W3R1/321:             |  ok  |
         rlock W1W2/R2R3/R3W1/123:             |  ok  |
         rlock W1W2/R2R3/R3W1/132:             |  ok  |
         rlock W1W2/R2R3/R3W1/213:             |  ok  |
         rlock W1W2/R2R3/R3W1/231:             |  ok  |
         rlock W1W2/R2R3/R3W1/312:             |  ok  |
         rlock W1W2/R2R3/R3W1/321:             |  ok  |
         rlock W1R2/R2R3/W3W1/123:             |  ok  |
         rlock W1R2/R2R3/W3W1/132:             |  ok  |
         rlock W1R2/R2R3/W3W1/213:             |  ok  |
         rlock W1R2/R2R3/W3W1/231:             |  ok  |
         rlock W1R2/R2R3/W3W1/312:             |  ok  |
         rlock W1R2/R2R3/W3W1/321:             |  ok  |
  --------------------------------------------------------------------------
     hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
       sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
       sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
         hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
         soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
         hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
         soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
      hard-irq read-recursion/123:      |  ok  |  ok  |
      soft-irq read-recursion/123:      |  ok  |  ok  |
      hard-irq read-recursion/132:      |  ok  |  ok  |
      soft-irq read-recursion/132:      |  ok  |  ok  |
      hard-irq read-recursion/213:      |  ok  |  ok  |
      soft-irq read-recursion/213:      |  ok  |  ok  |
      hard-irq read-recursion/231:      |  ok  |  ok  |
      soft-irq read-recursion/231:      |  ok  |  ok  |
      hard-irq read-recursion/312:      |  ok  |  ok  |
      soft-irq read-recursion/312:      |  ok  |  ok  |
      hard-irq read-recursion/321:      |  ok  |  ok  |
      soft-irq read-recursion/321:      |  ok  |  ok  |
   hard-irq read-recursion #2/123:      |  ok  |  ok  |
   soft-irq read-recursion #2/123:      |  ok  |  ok  |
   hard-irq read-recursion #2/132:      |  ok  |  ok  |
   soft-irq read-recursion #2/132:      |  ok  |  ok  |
   hard-irq read-recursion #2/213:      |  ok  |  ok  |
   soft-irq read-recursion #2/213:      |  ok  |  ok  |
   hard-irq read-recursion #2/231:      |  ok  |  ok  |
   soft-irq read-recursion #2/231:      |  ok  |  ok  |
   hard-irq read-recursion #2/312:      |  ok  |  ok  |
   soft-irq read-recursion #2/312:      |  ok  |  ok  |
   hard-irq read-recursion #2/321:      |  ok  |  ok  |
   soft-irq read-recursion #2/321:      |  ok  |  ok  |
   hard-irq read-recursion #3/123:      |  ok  |  ok  |
   soft-irq read-recursion #3/123:      |  ok  |  ok  |
   hard-irq read-recursion #3/132:      |  ok  |  ok  |
   soft-irq read-recursion #3/132:      |  ok  |  ok  |
   hard-irq read-recursion #3/213:      |  ok  |  ok  |
   soft-irq read-recursion #3/213:      |  ok  |  ok  |
   hard-irq read-recursion #3/231:      |  ok  |  ok  |
   soft-irq read-recursion #3/231:      |  ok  |  ok  |
   hard-irq read-recursion #3/312:      |  ok  |  ok  |
   soft-irq read-recursion #3/312:      |  ok  |  ok  |
   hard-irq read-recursion #3/321:      |  ok  |  ok  |
   soft-irq read-recursion #3/321:      |  ok  |  ok  |
  --------------------------------------------------------------------------
  | Wound/wait tests |
  ---------------------
                  ww api failures:  ok  |  ok  |  ok  |
               ww contexts mixing:  ok  |  ok  |
             finishing ww context:  ok  |  ok  |  ok  |  ok  |
               locking mismatches:  ok  |  ok  |  ok  |
                 EDEADLK handling:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
           spinlock nest unlocked:  ok  |
               spinlock nest test:  ok  |
  -----------------------------------------------------
                                 |block | try  |context|
  -----------------------------------------------------
                          context:  ok  |  ok  |  ok  |
                              try:  ok  |  ok  |  ok  |
                            block:  ok  |  ok  |  ok  |
                         spinlock:  ok  |  ok  |  ok  |
  --------------------------------------------------------------------------
  | queued read lock tests |
  ---------------------------
      hardirq read-lock/lock-read:  ok  |
      hardirq lock-read/read-lock:  ok  |
                hardirq inversion:  ok  |
  --------------------
  | fs_reclaim tests |
  --------------------
                  correct nesting:  ok  |
                    wrong nesting:  ok  |
                protected nesting:  ok  |
  --------------------------------------------------------------------------
  | local_lock tests |
  ---------------------
          local_lock inversion  2:  ok  |
          local_lock inversion 3A:  ok  |
          local_lock inversion 3B:  ok  |
      hardirq_unsafe_softirq_safe:  ok  |
-------------------------------------------------------
Good, all 358 testcases passed! |
---------------------------------
ACPI: Core revision 20211217
clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
APIC: Switch to symmetric I/O mode setup
spurious 8259A interrupt: IRQ7.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x3102c0847f4, max_idle_ns: 440795202126 ns
Calibrating delay loop (skipped), value calculated using timer frequency.. 6800.24 BogoMIPS (lpj=3400121)
pid_max: default: 32768 minimum: 301
LSM: Security Framework initializing
Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
CPU0: Thermal monitoring enabled (TM1)
process: using mwait in idle threads
Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
Spectre V2 : Mitigation: Full generic retpoline
Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
Speculative Store Bypass: Vulnerable
SRBDS: Vulnerable: No microcode
MDS: Vulnerable: Clear CPU buffers attempted, no microcode
Freeing SMP alternatives memory: 20K
smpboot: CPU0: Intel(R) Core(TM) i3-4130 CPU @ 3.40GHz (family: 0x6, model: 0x3c, stepping: 0x3)
cblist_init_generic: Setting adjustable number of callback queues.
cblist_init_generic: Setting shift to 2 and lim to 1.
cblist_init_generic: Setting shift to 2 and lim to 1.
Running RCU-tasks wait API self tests
Performance Events: PEBS fmt2+, Haswell events, 16-deep LBR, full-width counters, Intel PMU driver.
... version:                3
... bit width:              48
... generic registers:      4
... value mask:             0000ffffffffffff
... max period:             00007fffffffffff
... fixed-purpose events:   3
... event mask:             000000070000000f
rcu: Hierarchical SRCU implementation.
NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
smp: Bringing up secondary CPUs ...
x86: Booting SMP configuration:
.... node  #0, CPUs:      #1 #2
MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
 #3
smp: Brought up 1 node, 4 CPUs
smpboot: Max logical packages: 1
smpboot: Total of 4 processors activated (27200.96 BogoMIPS)
devtmpfs: initialized
ACPI: PM: Registering ACPI NVS region [mem 0xc69e5000-0xc69ebfff] (28672 bytes)
ACPI: PM: Registering ACPI NVS region [mem 0xd8e95000-0xd8fc7fff] (1257472 bytes)
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
Running postponed tracer tests:
Testing tracer function: 
Callback from call_rcu_tasks_rude() invoked.
Callback from call_rcu_tasks() invoked.
PASSED
Testing dynamic ftrace: PASSED
Testing dynamic ftrace ops #1: 
(1 0 1 0 0) 
(1 1 2 0 0) 
(2 1 3 0 14723669) 
(2 2 4 0 14732133) 
(3 2 4 0 15147316) 
(3 3 5 0 15160132) PASSED
Testing dynamic ftrace ops #2: 
(1 0 1 14682970 0) 
(1 1 2 14704466 0) 
(2 1 3 1 708) 
(2 2 4 11497 12135) 
(3 2 4 427437 425205) 
(3 3 5 439502 437211) PASSED
Testing ftrace recursion: PASSED
Testing ftrace recursion safe: PASSED
Testing ftrace regs: PASSED
Testing tracer nop: PASSED
Testing tracer irqsoff: PASSED
Testing tracer wakeup: PASSED
Testing tracer wakeup_rt: PASSED
Testing tracer wakeup_dl: PASSED
PM: RTC time: 03:49:10, date: 2022-02-25
NET: Registered PF_NETLINK/PF_ROUTE protocol family
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(1645760947.995:1): state=initialized audit_enabled=0 res=1
thermal_sys: Registered thermal governor 'step_wise'
thermal_sys: Registered thermal governor 'user_space'
cpuidle: using governor ladder
cpuidle: using governor menu
ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
PCI: Using MMCONFIG for extended config space
PCI: Using configuration type 1 for base access
core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: Added _OSI(Linux-Dell-Video)
ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
ACPI: 6 ACPI AML tables successfully acquired and loaded
ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0x00000000C2C42400 0003D3 (v01 PmRef  Cpu0Cst  00003001 INTL 20120711)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0x00000000C2F3A800 0005AA (v01 PmRef  ApIst    00003000 INTL 20120711)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0x00000000C248FC00 000119 (v01 PmRef  ApCst    00003000 INTL 20120711)
ACPI: Interpreter enabled
ACPI: PM: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
ACPI: Enabled 9 GPEs in block 00 to 3F
ACPI: PM: Power Resource [FN00]
ACPI: PM: Power Resource [FN01]
ACPI: PM: Power Resource [FN02]
ACPI: PM: Power Resource [FN03]
ACPI: PM: Power Resource [FN04]
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug PME]
acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability LTR]
acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000e7fff window]
pci_bus 0000:00: root bus resource [mem 0xdf200000-0xfeafffff window]
pci_bus 0000:00: root bus resource [bus 00-3e]
pci 0000:00:00.0: [8086:0c00] type 00 class 0x060000
pci 0000:00:02.0: [8086:041e] type 00 class 0x030000
pci 0000:00:02.0: reg 0x10: [mem 0xf7800000-0xf7bfffff 64bit]
pci 0000:00:02.0: reg 0x18: [mem 0xe0000000-0xefffffff 64bit pref]
pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
pci 0000:00:03.0: [8086:0c0c] type 00 class 0x040300
pci 0000:00:03.0: reg 0x10: [mem 0xf7d14000-0xf7d17fff 64bit]
pci 0000:00:14.0: [8086:8c31] type 00 class 0x0c0330
pci 0000:00:14.0: reg 0x10: [mem 0xf7d00000-0xf7d0ffff 64bit]
pci 0000:00:14.0: PME# supported from D3hot D3cold
pci 0000:00:16.0: [8086:8c3a] type 00 class 0x078000
pci 0000:00:16.0: reg 0x10: [mem 0xf7d1e000-0xf7d1e00f 64bit]
pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1a.0: [8086:8c2d] type 00 class 0x0c0320
pci 0000:00:1a.0: reg 0x10: [mem 0xf7d1c000-0xf7d1c3ff]
pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1b.0: [8086:8c20] type 00 class 0x040300
pci 0000:00:1b.0: reg 0x10: [mem 0xf7d10000-0xf7d13fff 64bit]
pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.0: [8086:8c10] type 01 class 0x060400
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.4: [8086:8c18] type 01 class 0x060400
pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.0: [8086:8c26] type 00 class 0x0c0320
pci 0000:00:1d.0: reg 0x10: [mem 0xf7d1b000-0xf7d1b3ff]
pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1f.0: [8086:8c4a] type 00 class 0x060100
pci 0000:00:1f.2: [8086:8c02] type 00 class 0x010601
pci 0000:00:1f.2: reg 0x10: [io  0xf0b0-0xf0b7]
pci 0000:00:1f.2: reg 0x14: [io  0xf0a0-0xf0a3]
pci 0000:00:1f.2: reg 0x18: [io  0xf090-0xf097]
pci 0000:00:1f.2: reg 0x1c: [io  0xf080-0xf083]
pci 0000:00:1f.2: reg 0x20: [io  0xf060-0xf07f]
pci 0000:00:1f.2: reg 0x24: [mem 0xf7d1a000-0xf7d1a7ff]
pci 0000:00:1f.2: PME# supported from D3hot
pci 0000:00:1f.3: [8086:8c22] type 00 class 0x0c0500
pci 0000:00:1f.3: reg 0x10: [mem 0xf7d19000-0xf7d190ff 64bit]
pci 0000:00:1f.3: reg 0x20: [io  0xf040-0xf05f]
acpiphp: Slot [1] registered
pci 0000:00:1c.0: PCI bridge to [bus 01]
pci 0000:02:00.0: [10ec:8168] type 00 class 0x020000
pci 0000:02:00.0: reg 0x10: [io  0xe000-0xe0ff]
pci 0000:02:00.0: reg 0x18: [mem 0xf7c00000-0xf7c00fff 64bit]
pci 0000:02:00.0: reg 0x20: [mem 0xf0000000-0xf0003fff 64bit pref]
pci 0000:02:00.0: supports D1 D2
pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:1c.4: PCI bridge to [bus 02]
pci 0000:00:1c.4:   bridge window [io  0xe000-0xefff]
pci 0000:00:1c.4:   bridge window [mem 0xf7c00000-0xf7cfffff]
pci 0000:00:1c.4:   bridge window [mem 0xf0000000-0xf00fffff 64bit pref]
pci_bus 0000:00: on NUMA node 0
ACPI: PCI: Interrupt link LNKA configured for IRQ 11
ACPI: PCI: Interrupt link LNKB configured for IRQ 0
ACPI: PCI: Interrupt link LNKB disabled
ACPI: PCI: Interrupt link LNKC configured for IRQ 10
ACPI: PCI: Interrupt link LNKD configured for IRQ 10
ACPI: PCI: Interrupt link LNKE configured for IRQ 0
ACPI: PCI: Interrupt link LNKE disabled
ACPI: PCI: Interrupt link LNKF configured for IRQ 0
ACPI: PCI: Interrupt link LNKF disabled
ACPI: PCI: Interrupt link LNKG configured for IRQ 3
ACPI: PCI: Interrupt link LNKH configured for IRQ 11
pci 0000:00:02.0: vgaarb: setting as boot VGA device
pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
pci 0000:00:02.0: vgaarb: bridge control possible
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
mc: Linux media interface: v0.10
videodev: Linux video capture interface: v2.00
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
PTP clock support registered
EDAC MC: Ver: 3.0.0
Advanced Linux Sound Architecture Driver Initialized.
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
NetLabel:  unlabeled traffic allowed by default
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
e820: reserve RAM buffer [mem 0x0009d800-0x0009ffff]
e820: reserve RAM buffer [mem 0xc69e5000-0xc7ffffff]
e820: reserve RAM buffer [mem 0xc6e2f000-0xc7ffffff]
e820: reserve RAM buffer [mem 0xd8da3000-0xdbffffff]
e820: reserve RAM buffer [mem 0xd8e95000-0xdbffffff]
e820: reserve RAM buffer [mem 0xda000000-0xdbffffff]
e820: reserve RAM buffer [mem 0x21ee00000-0x21fffffff]
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
hpet0: 8 comparators, 64-bit 14.318180 MHz counter
clocksource: Switched to clocksource tsc-early
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
pnp: PnP ACPI init
system 00:00: [mem 0xfed40000-0xfed44fff] has been reserved
system 00:01: [io  0x0680-0x069f] has been reserved
system 00:01: [io  0xffff] has been reserved
system 00:01: [io  0xffff] has been reserved
system 00:01: [io  0xffff] has been reserved
system 00:01: [io  0x1c00-0x1cfe] has been reserved
system 00:01: [io  0x1d00-0x1dfe] has been reserved
system 00:01: [io  0x1e00-0x1efe] has been reserved
system 00:01: [io  0x1f00-0x1ffe] has been reserved
system 00:01: [io  0x1800-0x18fe] has been reserved
system 00:01: [io  0x164e-0x164f] has been reserved
system 00:03: [io  0x1854-0x1857] has been reserved
system 00:04: [io  0x0a00-0x0a0f] has been reserved
system 00:04: [io  0x0a10-0x0a1f] has been reserved
pnp 00:05: [dma 0 disabled]
pnp 00:06: [dma 0 disabled]
system 00:07: [io  0x04d0-0x04d1] has been reserved
system 00:08: [mem 0xfed1c000-0xfed1ffff] has been reserved
system 00:08: [mem 0xfed10000-0xfed17fff] has been reserved
system 00:08: [mem 0xfed18000-0xfed18fff] has been reserved
system 00:08: [mem 0xfed19000-0xfed19fff] has been reserved
system 00:08: [mem 0xf8000000-0xfbffffff] has been reserved
system 00:08: [mem 0xfed20000-0xfed3ffff] has been reserved
system 00:08: [mem 0xfed90000-0xfed93fff] has been reserved
system 00:08: [mem 0xfed45000-0xfed8ffff] has been reserved
system 00:08: [mem 0xff000000-0xffffffff] has been reserved
system 00:08: [mem 0xfee00000-0xfeefffff] could not be reserved
system 00:08: [mem 0xf7fdf000-0xf7fdffff] has been reserved
system 00:08: [mem 0xf7fe0000-0xf7feffff] has been reserved
pnp: PnP ACPI: found 9 devices
clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
NET: Registered PF_INET protocol family
IP idents hash table entries: 16384 (order: 5, 131072 bytes, linear)
tcp_listen_portaddr_hash hash table entries: 512 (order: 2, 26624 bytes, linear)
TCP established hash table entries: 8192 (order: 3, 32768 bytes, linear)
TCP bind hash table entries: 8192 (order: 6, 393216 bytes, linear)
TCP: Hash tables configured (established 8192 bind 8192)
UDP hash table entries: 512 (order: 3, 57344 bytes, linear)
UDP-Lite hash table entries: 512 (order: 3, 57344 bytes, linear)
NET: Registered PF_UNIX/PF_LOCAL protocol family
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align 100000
pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] to [bus 01] add_size 200000 add_align 100000
PCI: Removing E820 reservations from host bridge windows
pci 0000:00:1c.0: BAR 14: assigned [mem 0xdf200000-0xdf3fffff]
pci 0000:00:1c.0: BAR 15: assigned [mem 0xdf400000-0xdf5fffff 64bit pref]
pci 0000:00:1c.0: BAR 13: assigned [io  0x2000-0x2fff]
pci 0000:00:1c.0: PCI bridge to [bus 01]
pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
pci 0000:00:1c.0:   bridge window [mem 0xdf200000-0xdf3fffff]
pci 0000:00:1c.0:   bridge window [mem 0xdf400000-0xdf5fffff 64bit pref]
pci 0000:00:1c.4: PCI bridge to [bus 02]
pci 0000:00:1c.4:   bridge window [io  0xe000-0xefff]
pci 0000:00:1c.4:   bridge window [mem 0xf7c00000-0xf7cfffff]
pci 0000:00:1c.4:   bridge window [mem 0xf0000000-0xf00fffff 64bit pref]
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000e7fff window]
pci_bus 0000:00: resource 8 [mem 0xdf200000-0xfeafffff window]
pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
pci_bus 0000:01: resource 1 [mem 0xdf200000-0xdf3fffff]
pci_bus 0000:01: resource 2 [mem 0xdf400000-0xdf5fffff 64bit pref]
pci_bus 0000:02: resource 0 [io  0xe000-0xefff]
pci_bus 0000:02: resource 1 [mem 0xf7c00000-0xf7cfffff]
pci_bus 0000:02: resource 2 [mem 0xf0000000-0xf00fffff 64bit pref]
pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
pci 0000:00:14.0: CONFIG_USB_XHCI_HCD is turned off, defaulting to EHCI.
pci 0000:00:14.0: USB 3.0 devices will work at USB 2.0 speeds.
pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0x5ac took 12850 usecs
PCI: CLS 64 bytes, default 64
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
software IO TLB: mapped [mem 0x000000002ebd9000-0x0000000032bd9000] (64MB)
RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
RAPL PMU: hw unit of domain package 2^-14 Joules
RAPL PMU: hw unit of domain dram 2^-14 Joules
RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
workingset: timestamp_bits=30 max_order=21 bucket_order=0
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
nfs4filelayout_init: NFSv4 File Layout Driver Registering...
nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
bounce: pool size: 64 pages
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
io scheduler mq-deadline registered
io scheduler kyber registered
VIA Graphics Integration Chipset framebuffer 2.4 initializing
input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
ACPI: button: Power Button [PWRB]
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
ACPI: button: Power Button [PWRF]
Monitor-Mwait will be used to enter C-1 state
Monitor-Mwait will be used to enter C-2 state
ACPI: \_PR_.CPU0: Found 2 idle states
ACPI: \_PR_.CPU1: Found 2 idle states
ACPI: \_PR_.CPU2: Found 2 idle states
ACPI: \_PR_.CPU3: Found 2 idle states
thermal LNXTHERM:00: registered as thermal_zone0
ACPI: thermal: Thermal Zone [TZ00] (28 C)
thermal LNXTHERM:01: registered as thermal_zone1
ACPI: thermal: Thermal Zone [TZ01] (30 C)
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
0SI 15Nto
LgtAsri[dnei00ieC nm
i:0eom:Soce
[ad000Ade s:ii SSLtbueludAis002h00 1)ASrPn
Ars004h00 7ARrPn
Aas003h00 1)Ans003h00 7AOrPn
Aas002h00 1)Ais002h00 7A rPn
loeuifr yLCa.a02a020tpa02nsss0sas s s saa D4rqamD4rqaYaYa
aYelP er n.eI keyt or0.e'tr:.gb4r0.e c]SareS0tCeECee0: e0:usee::te0:oe0:t0ueBidcuNB:==udttunc1hurN1h0 h2oe0: e0:usee0:te0:oe0:t0uNBidcuwB:==uPttuac1hueN1h0 h:ooS1nDoHCeu:iteugresi:SomSoo
r:Rmr:rcrssl2(r:a  ei00tti 0spi2eli saiusaiOta =6iOtl=tisoodeoDsiebhdre.daotidi:te
hDniugre
uHcierapuire-uire-uire-uire-d:irsNtPoK_omsxrm ceInosMk982ratRgfse0doossca0ru/tsea0t0sea0(0sca0_s_a01s_a0s_a0csea0=sca0arttiI mp0rin mp0rin mp0riI mp0rin m/:aCcnm iI s0.niH  00pi001fiI v/u1iH op0rin re0/iI Fc0di  dc0diH h/:au hcguehcgaTualaluala W8 a:6i(aTASxairacrs:-A1Qs:]erxacrDis0c sAccs0rA5Qstccs:]bc s ]is:] s[]nhs u  dPdu:  00h1 h0oue dPdu   00h: h:o 1s >s ]dueuvitn i0c::fy0sncetuueS ib
uwSstrh:Sh. 
u1 esu4 d,,0u: nubu d.u:uI.iTrd1c0215phe: Uyet3:niArd1rp0/-0ni rd1li:-.5uh0: Uvn 90uiArd1c0215phe: UuaG]:tiIrd1c0215phr: UuaG]:tfC  e ey ey4 iy0 ev sv  e te
 le
 ey ey  e tdoC
  e py ey8 wy4 tv ev  e te
 le
 ny zy de tdoC  e dy cy ny sv ev de te  e ny iy ee tdoC  e ey ey8 ty3 tv sv ae se
  e
 ly zy ee tdoRAERe TeiKTeiT iT c TecTecKTec TecKT ceTecT cTvcaTncTec
T c
T e Tve:TtfcTvfcTertTvrrTellTtllTel:TnlyTnsKTesOTeq
TvqTt6xTn6nT rKTtrOTeu:TeuyT cOTvc T iTe6cT 6OTe6OTt6KTe6:Te6iTe6aTn6oTe6tT 6:Tt6eTeeT bTtg TvgKTvsTtsTnuTeu TvuT f
T fTtf
TvqOTvq TegTegKT reTtrsT r_TnrrTehtTehKTehOT hKTvh:TehOT h:Sao,tsuptedOTeh:Tvh T hOTnhKTth:Tnh:Teh:TvhKTeh:Tth:Tvh:TthTthOT hTthTeh_T h_OTth_
Tnh_Teh:T c
TvcTvcTtcTnnTtqKTeqOTvq TvqaTvqmTeq_T qeT qsT qrTeq:T q:T q Ttu T uKTeiKTesT sT cTni
TviT tT ttT trTvt
T tTemT m T m:TnmTemT a TeaOTnaOT a:TndTedTedTvdTvdTvreTvrlTersT r:TnrKTer
Tvr
TerT rT rT rT rtTtr TtqTeqT r:TvrOTnvrTnvrTnvuTv_sTv_eT _eT _eT _:TtwtTtoT o
T oTnktTvkvTesTvv_Ttv_T utTeu
Ttt
TtwOTnuTemTemTvmT mTvmTenKTnm TnmTtmTepKTvp:Tvp:TtprT pOTvpOT pTepTvp
Tee
TeeTvla
Tel:T _pTe_f Tvm
Tei TengTta:TtkTnrTvc:TnmtTv_KTe_OT _dTn_lTe_lTe_nT _n
Tt_eTn_aT _:Tt_rTn_eTe_eTe_sTt_aT _lTtrnTtrkT ruTnr:T ruTtsTt_rTn_:Te__Te_
Tv_eTv_TveKTtrTeeoTvaTteOTtaTv_pTt_uT _p
T _rTe_rTn_rTn_aT _sT _t:Tn_ Tv_nTv_aTn_aKTn_a:TnarTea:TeacTe_OTe_tTv_OTe_tTn_eTtio
Tvi_Tti:T inTtinTvioTnisTvlsTnitT o:Tei:Tnc
TtisTtikTeiiTtiT i T iKTeiTeiKT ioT ioTnioTtioTnidTtlcT ilTv_dTt_ Tt_ Tv_:T _ Tt_eTe_ Tv_:T _iTe_
Tn_T _nT _ T _ T _KT aKTvn TemKTensTeekT e TeekTvoOTnc:TenT sOTnctTemT m Tem T mtTnmgTem TvmKTvmKTemT tTtteTtteTetnTtt:TettTvt
T tpTetrTvtTetnTetnT taTttTtt
TntiTet_TetkT t:TetyTvt:TntaTttTet TeteTvtnTntnTvtnT teT teTettTettKTeteTttnTnteTttaTttaTetKTttOTet:TvtnTvtltTntw Tnt:T tOTvt_Tnt:TvtKTntnT tsTvtsTttsTttsTttosTvtotTtt:TntrTntOTet T ttTvtKT tKT teTnttTettTntaTntdTttaT taTeteT tTtt TttrTntlTvt:TetkT tTtttTnteTttOTetkTvtsTeteT tlTttoTntoTetpTvtpTetsTvtvTvteTntOTet
TttTetsTetsTntsTetKT t TttiTttT tnT tOTnt_TttrTtttTntKTetOTtteTnt:T tKTttpTvdoT dxTvdnTtd TedtTedoTvdiTedaTedT d Ttd:TedtTtd TeddTvdKTediTndgTednTtdgTtd TedKT snTesTtsOTesKTnstTvsOTvsTnsKTvs:Tts:TesTvs:Tns Tes T sdTts TtsoTesOTtslTesnTesKTesOTns
TnsTesOT s T sKTesOT sKTvsOTtsTtsKTtsT sKTesTesKT sKTesOT siT stTnsaTvsaTesKTnsOT s
TesKTnsT s TvsKTeslT sOTesT sKTtseTnseTvs_Tts_T sOTes TnsOT s T spTespTesdTesdTeseTtseTeseTt_rTe_rTv_oTes:T s:Tes:TnfwOTvfrKT fwT frTefpuTefpKTefpTvf:TnsOTvsOTnsoTvs Tvs TvsTtssTnsT sKTesTnsTvsTtsoTesmTnsgTesiTeslTtsTvsKTnsTvsOTtsT s_Tnsu
TnsuT sOTtsTvsT sTtsTns
TvsTesT sT sTesoTesTesT sTvsTtsT stTestT soTesxTnsaT snTvscTes
TesTns
T sT sOT sTes Tts TesKTts
TesaTesKTtstTnslT sTvseTesKTts T sOTes:TvseTns
TnssT stTtsoTvsnTnsOTtsOTtsTnsoTesOTvsKTtskT sT s T s
TesOTvsT s
T s
T sOTesTvs T sTvs_KTesdT soTnsoTts TesndTvs
TesOTtslTtsKTnsdTesKT smTtsmTvseT seTvsOTtsKTvsKT sOTes:TtspTesdT sdTescTesnTns TesKTvs TnsKTesTes_Tvs_Tvs_Tvs:Tts_Tns_TtsoTvsrTesnT slTesnT sTnsTes
TesKTvs:Tes TnsOTesTvs TnsOTesOTesKTts:TvsmTns:Tes Tts_Tns_TvsdT sdTtsuTes
TesrTtseT lKTeoTeoKTeoTeoTtoTeoT oKTvogTnoeT oOTvo:TtoTnoTeoKTno T oOTeo:Tvo:TebKTnbTtb
TnpT iT aTtiTeiTek_T k:T klTnk
TtkpT kTnk:TvkOTnkOTekeTvkTeklT k
TtktTekTektTvkTnkeTekTvgaTvgaTngi TegiTngnOTegnTngcTng TtgoTegeTegOTnaTeaTetKTntrTetOTndsTvdsTeb
TvesTexoTnxTedeTtmeTemuTtmOTtdaTndiTndeTndbTvd T dKTed:TtdeTnd T dTvdOT 1 Te1eT 1:Tv1 TetnTv1T 1eTe1bTe1eT 1OTn1:Te1 Tn1eTn1Tv1sTt1fTe1uTe1eTt1rTe1KTv1
Tv1KTt1eTvtfTvtiTvteTetvKTetsTvtwTntwTetTnttTet:TnteT t_Tvt_Tev
TvvTvxTvt TvteTeteTvtTvt:T t T goT geTtgeTegmTvg_TvgsTng Ttg
TegnTvgaT geTtgrTegcTvgKTvgOTevTea:TvarTna:TeaiTea TeaT aTesTestTtsdTnseT ssTtcnTtcsTecOT c
TvcTtc TvcT atTtaTna_TtaeT a TeadTea Tta
TeaKTnaOTeatTea:Tea_TeatT a_Tta_TeatTva_TtaTea:T ayTvayT aOTnaT aKTeaKTtaOTnaTnanTeaiTtatTnaTeaTei T i:TeiOTei Tti:TviTniTviyTeieT iTncKTec Tec TvcKTncTeclTec TecOTecTnc
Tnc
TncTncT cTvcTncT bT bTebTtbTe2
Tv2Tn2:Tt2 TelTelTvmrTemOTemKTne TeeTveeTerTen:T mTt_Te_ Te_
TepT _TeuTepTtxKTex T x
TtxTexOTexKTtx:T xdT xTexTedoTndaTeaKTtaOTeaTnirTeieTtioTeirTti TeiTniTniTni
TtiTni
Tni
T bOTepTvpTnpaTvpsTepOTtp TvpTtp:T p_TeerT eeTtcmT c:TtpTvtlTvtOTet
TtteTtpxTeptTet T tTntlT teTtpnT prTetTtt Tvt
TetuTvtT t:TvbiTenTvrTnvtTnvotTtvoTevoTev
Tvv
TntTecTecTncT ctTnceTtc:Ttc:TncdTeceT c:Tnc TvchTeceT c:TecrTtcaTecOTecOTecrTecOTecOT cT c:TncTncKTvcTvc T c TvcTvcOTncKTec
TncKTncTecsTecOTecrT cT cTecTecT cOTtcTvcOTecKTec
Tva
TncTecT _uTe_aT rTnr
Tnr
Ter Ter Tnr T r T rTerKTer
TerOT rTtrTvreTtrrT rnTtrtTvrTnrT c:TvcnT cOTecoTecOTnc:TechTnc TvcOTvc Tvc Tec
T ceTncrTeceTvcOTeceT c T cTtcOTec
T cKTec Tec T c:Ttc TncOTecKTvcKTecT c:TtcTtc:TncOTec Tec:TvcpTecnTvcTtcTec:TvcsTnc:Tec:TecKTvc:T cOTecT cpT cpTtcOTnc T cOTec
TecsTecOTvcTnc:T c TtcT clTtc TecoTvceTncaT ckTvcdT cTecOTeceTnciTvcuTvcaT cfT cT c T c:T cKT c
TecTec TncTtc Rs tTts
Tes
TtsTvsT sT sTnsTvsTnsTvsTtsTtsTnsTesTesOTvslTvsTesTesTtsTvsTesTtsTvsT sTesTns
TvsTesT sOTesTvs
TesTvs
TtsTes
TesOT sTnsTesTtsTesTesT sTtsTesTesTesTtsTtsKTnsKTesOTvsT sTesOTes T sTvs
Tns
TvsTnsTvsTesTnsTnsOTesTnsTestTnsTts Tns
Tns
T s TtsTvssTesTtsTes Tes
TvsTesT sOTvs
TesT sTesT s TvsTnsTnsT sTns:TesKTvsKRt sT tReatcR  T iKTviTgiTec TecTncKTvc T cKT ceT cTgcTncaT cT c
Tec
T e Tee:TgfcTgfcTvrtTvrrTellTellTnl:TelyTesKTesOTnq
TeqTe6xTn6nTerKTerOTnu:TeuyTvcOTec TeiTe6cTv6OTg6OTg6KTe6:Te6iT 6aTe6oT 6tTv6:Te6eT eT bTng T gKTesTesT uTgu TeuTnf
TnfTvf
TnqOTnq TegTggKTereTersTer_T rrTehtTehKTghOTehKTgh:T hOTeh:Teh:Tvh TehOTnhKTeh:Teh:Tgh:T hKTeh:Tvh:Teh:TnhTvhOTvhT hTvh_Tgh_OTeh_
Tgh_Tgh:T c
TncTncTecTenTvqKTnqOT q TeqaTeqmTvq_TgqeT qsT qrTeq:Teq:Teq Tnu TguKTeiKTnsTesTgcTvi
TeiTetTettTvtrTnt
TgtT mTvm Tem:TvmTnmT a TnaOT aOT a:T dTndTgdTgdTedTereT rlTersTgr:TvrKTnr
Tvr
TnrTerTgrTnrTertTgr TvqTeqTnr:TerOTgvrT vrTvvuTe_sTv_eTe_eTv_eTv_:TewtTvoTeo
TnoTvktTnkvTesTev_T v_T utTvu
Tet
TvwOTvuTvmTemTnmTemT mTnnKTvm TgmTemTepKT p:Tep:TeprTepOTnpOTvpTvpTep
Tee
T eTvla
Tel:T _pTe_f Tnm
Tni TengTva:TekT rTgc:TemtTe_KTv_OTg_dTe_lTv_lT _nTg_n
Tg_eT _aTv_:Te_rTe_eT _eTe_sTe_aTn_lTernTerkTeruT r:TvruTvsTe_rTn_:T __T _
T _eTv_TeeKTerTgeoTeaTgeOTvaTe_pT _uTe_p
Tv_rTv_rTn_rT _aTv_sTe_t:Tn_ T _nTg_aT _aKTe_a:TearTea:T acTv_OTn_tTn_OTe_tTe_eTeio
Tvi_Tei:TeinTvinTgioTeisTelsTeitTeo:T i:Tvc
TvisTvikTniiT iTei TeiKT iT iKT ioTnioTeioTnioTeidTelcTeilTg_dTv_ Tg_ T _:Tv_ Tg_eTg_ T _:Tv_iTv_
Tg_Te_nTe_ Te_ Tv_KTnaKTgn TvmKTensTeekTee TeekTeoOTec:TenTvsOTnctTvmTvm Tem TvmtTvmgT m TvmKTemKTgmTetTeteTnteTetnT t:TvttTvt
TetpTgtrTvtTgtnT tnTetaTetTvt
TvtiTet_TetkTet:TetyTvt:TntaTvtTvt TgteT tnTntnTntnTvteTeteT ttTvttKTeteTetnTnteTetaTgtaTvtKTvtOTgt:TntnTetltTetw Tgt:TntOTet_Tnt:TntKTgtnTgtsTvtsT tsTgtsTetosTvtotTgt:TetrTetOTnt TettTetKTttKTeteTvttTettTetaTvtdTetaTntaT teTetTnt TvtrTgtlTvt:TgtkTgtTettTnteTetOTetkTetsTnteTvtlTetoTntoT tpTetpTvtsTntvTgteTgtOTnt
T tTntsTetsTetsT tKTet TntiT tTetnTetOTet_T trTettTetKTvtOT teTvt:TvtKTetpTedoTgdxTgdnTvd TedtTedoTvdiTndaTndTed Ted:T dtTed TgddTedKTediTedgTednT dgTed TedKTnsnTvsTgsOTesKTestTgsOT sT sKTvs:Tgs:TgsTns:Tns Tgs TgsdTvs TvsoTvsOTeslTvsnT sKTesOT s
T sT sOTes TesKTesOTesKTesOTnsTesKTesTesKTgsTesKTnsKTesOTesiTestTesaTvsaTgsKTnsOTgs
TnsKTgsTes TvsKTeslTnsOTgsTgsKTgseTeseTes_Tes_TvsOTvs TesOTvs T spT spTesdTnsdTvseTeseT seT _rT _rTn_oTes:Tns:Tvs:TgfwOTvfrKTefwTnfrTgfpuT fpKT fpTef:TesOTesOTvsoTgs Tvs TesTvssT sTnsKT sTnsT sTesoT smTesgT siT slTesTvsKTnsTesOTesTes_Tesu
TgsuTesOTesT sTesTnsT s
TgsTvsTvsTvsTesoTnsTnsTvsTvsTesT stTvstTesoTesxTesaTnsnT scTgs
TgsTes
TesTvsOTnsTes T s TesKTgs
TesaT sKTnstT slTesTnseTvsKTes T sOTes:TeseTes
TnssTestTvsoTesnTesOTnsOTesTesoTgsOTnsKTeskTvsTes Tes
TgsOTesTvs
Tes
TvsOT sTes TesTes_KTnsdT soT soT s TnsndTvs
TesOTeslTvsKTgsdTesKTvsmTvsmTeseTgseTvsOT sKT sKTnsOTes:TvspTesdT sdTescTesnTes TesKTes TgsKTvsTvs_Tgs_T s_Tvs:T s_Tes_TgsoT srT snTvslTesnTgsTesT s
TgsKTvs:Tes TvsOTvsTvs TnsOTnsOTesKT s:TvsmTgs:Tvs Tes_T s_T sdTesdTesuTes
TnsrTgseTnlKTeoTeoKT oTvoTeoTgoT oKTvogTnoeTeoOT o:TeoTnoTvoKTvo TgoOTeo:Teo:TvbKTgbTvb
TvpTniTvaT iT iTgk_Tvk:TgklT k
TvkpTnkT k:TekOTekOTekeTekTgklTnk
TgktTnkTektTekT keTgkTegaTggaTvgi T giTegnOTegnTegcTvg TggoT geTegOTeaTvaTvtKTetrTetOTgdsTndsT b
TeesTvxoTnxTgdeTemeTvmuTvmOTvdaTvdiTedeTvdbTnd T dKTgd:TvdeT d TvdTvdOTe1 Tg1eTe1:Te1 T tnT 1Te1eT 1bTn1eTe1OTg1:Te1 Te1eTg1Te1sT 1fTn1uTe1eTg1rTn1KTg1
Tg1KT 1eT tfTgtiTvteTgtvKT tsTetwT twTvtTettTet:T teTgt_Tvt_T v
T vT xTgt TeteTeteT tTvt:Tet T goTngeTggeTvgmTng_T gsTeg Teg
TngnTegaTegeT grT gcT gKTvgOTnvTna:TearTna:TgaiTea TeaT aTvsTgstTnsdTeseT ssTvcnTncsTecOTec
TecTec T cTeatTeaT a_TnaeTva T adTna T a
TvaKTeaOT atT a:T a_TeatTea_Tea_TnatTna_TgaTna:TnayTeayT aOTeaT aKTeaKTeaOTeaTeanTeaiTvatTeaT aTvi T i:TeiOTei T i:TeiTviT iyTeieTeiT cKTvc Tec TecKTncT clTec TvcOTvcTgc
Tvc
TvcTvcTvcT cTecTgbTgbT bTnbT 2
Te2Te2:Tv2 TelT lTemrT mOTemKTne TeeTneeTerTen:TvmTe_Tv_ Te_
TepTg_T uT pTexKTex T x
T xTvxOTnxKTvx:TexdTexTexTndoTvdaTgaKTeaOTgaT irTvieT ioTeirTvi T iTniTgiTvi
TeiTgi
Tei
T bOTgpTnpTepaTepsTvpOT p TepTep:Tvp_TeerTveeTncmTnc:TepTvtlTvtOTnt
TvteTepxTvptTet TntTntlTeteTvpnT prTetTet Tgt
TgtuTetTet:TvbiTnnTgrTvvtTevotTvvoTnvoTev
Tnv
TetTecTecTvcT ctTvceTec:T c:T cdT ceTec:Tec TgchTeceTvc:TgcrTecaTecOTecOT crTecOTecOT cTec:TgcT cKTecT c Tec TncTvcOT cKTvc
TecKTecTvcsTecOTecrTecTecTecTecTecOTecT cOTgcKT c
Tga
TvcTvcTn_uTe_aTgrT r
Ter
Ter T r Ter Ter TerTnrKTvr
T rOTerT rTereTvrrTvrnTertTerTvrT c:TecnTncOTecoT cOTnc:TvchT c T cOTvc Tgc Tnc
TeceTecrTnceTncOTeceTvc TncTvcOTvc
TvcKTgc Tec Tvc:T c TncOT cKTncKTecTnc:TvcTec:TvcOTec T c:T cpTecnT cT cT c:TvcsTgc:Tvc:TncKT c:TvcOTecTncpTecpT cOTvc T cOTgc
TecsTncOTvcTec:Tnc T cTnclTec TecoTnceTecaTvckTvcdTvcTecOT ceTgciTecuTecaT cfTecTvc T c:TvcKT c
TgcTvc TncTvc R  tTvs
T s
TvsTgsTesTesTgsTvsTvsTesTesTesTesTesTesOT slTvsTgsTesTesT sTesTgsTgsTesTesTns
TesTvsTnsOT sTes
T sTvs
TesTns
TnsOTesT sTgsT sT sTvsT sTnsTesT sTesT sTvsKTnsKT sOTnsTgsTgsOT s TesTvs
Tes
T sTesT sTnsTnsT sOT sTgsTvstTesTns Tgs
Tgs
Tns TgsTessTvsTvsTgs Tes
TnsT sTvsOTes
T sTnsTesTns TvsTvsTesTesTvs:TgsKTnsKRt sTlt^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[ATaitoscic nitahi tuPiet mfba Ae:   aD nCt AH0 nP0md: Waiting for all devices to be available before autodetect
md: If you don't use raid, use raid=noautodetect
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT4-fs (sda6): mounted filesystem with ordered data mode. Quota mode: none.
VFS: Mounted root (ext4 filesystem) readonly on device 8:6.
devtmpfs: mounted
Freeing unused kernel image (initmem) memory: 2296K
Write protecting kernel text and read-only data: 18228k
NX-protecting the kernel data: 12712k
rodata_test: all tests were successful
Run /sbin/init as init process
  with arguments:
    /sbin/init
  with environment:
    HOME=/
    TERM=linux
random: init: uninitialized urandom read (12 bytes read)
^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[Arandom: crng init done
mount: mount point /proc/bus/usb does not exist
		Welcome to Fedora 
		Press 'I' to enter interactive startup.
readahead-collector: starting
Starting udev: udev: starting version 153
udevd (2741): /proc/2741/oom_adj is deprecated, please use /proc/2741/oom_score_adj instead.
parport_pc 00:06: reported by Plug and Play ACPI
parport0: PC-style at 0x378, irq 5 [PCSPP(,...)]
ppdev: user-space parallel port driver
udevd-work[2961]: error opening ATTR{/sys/devices/system/cpu/cpu0/online} for writing: Permission denied

r8169 0000:02:00.0 eth6: renamed from eth0
[  OK  ]
Setting hostname mitest:  [  OK  ]
Setting up Logical Volume Management:   1 logical volume(s) in volume group "vg00" now active
  3 logical volume(s) in volume group "fedora" now active
[  OK  ]
Checking filesystems
Checking all file systems.
[/sbin/fsck.ext4 (1) -- /] fsck.ext4 -a /dev/sda6 
/dev/sda6: clean, 246793/1313280 files, 4526866/5242880 blocks
[  OK  ]
Remounting root filesystem in read-write mode:  EXT4-fs (sda6): re-mounted. Quota mode: none.
[  OK  ]
Mounting local filesystems:  EXT4-fs (dm-0): warning: maximal mount count reached, running e2fsck is recommended
EXT4-fs (dm-0): mounted filesystem with ordered data mode. Quota mode: none.
EXT4-fs (sda1): mounted filesystem with ordered data mode. Quota mode: none.
[  OK  ]
Enabling local filesystem quotas:  [  OK  ]
Enabling /etc/fstab swaps:  [  OK  ]
Entering non-interactive startup
Starting monitoring for VG fedora:   3 logical volume(s) in volume group "fedora" monitored
[  OK  ]
Starting monitoring for VG vg00:   1 logical volume(s) in volume group "vg00" monitored
[  OK  ]
ip6tables: Applying firewall rules: WARNING: Deprecated config file /etc/modprobe.conf, all config files belong into /etc/modprobe.d/.
FATAL: Module ip6_tables not found.
ip6tables-restore v1.4.7: ip6tables-restore: unable to initialize table 'filter'

Error occurred at line: 3
Try `ip6tables-restore -h' or 'ip6tables-restore --help' for more information.
[FAILED]
iptables: Applying firewall rules: [  OK  ]
Starting portreserve: [  OK  ]
Starting system logger: [  OK  ]
Starting cpuspeed: [  OK  ]
Starting irqbalance: [  OK  ]
Starting rpcbind: [  OK  ]
Starting mdmonitor: [  OK  ]
Detected /etc/kdump.conf or /boot/vmlinuz-test change
Rebuilding /boot/initrd-test-kdump.img
No module ata_generic found for kernel 5.17.0-rc1-test+, aborting.
Failed to run mkdumprd
Starting kdump:[FAILED]
Starting system message bus: [  OK  ]
Setting network parameters... [  OK  ]
Starting NetworkManager daemon: [  OK  ]
Starting Avahi daemon... [  OK  ]
r8169 0000:02:00.0: Direct firmware load for rtl_nic/rtl8168g-2.fw failed with error -2
r8169 0000:02:00.0: Unable to load firmware rtl_nic/rtl8168g-2.fw (-2)
Generic FE-GE Realtek PHY r8169-0-200:00: attached PHY driver (mii_bus:phy_addr=r8169-0-200:00, irq=MAC)
Starting NFS statd: r8169 0000:02:00.0 eth6: Link is Down
[  OK  ]
Starting RPC idmapd: WARNING: Deprecated config file /etc/modprobe.conf, all config files belong into /etc/modprobe.d/.
WARNING: Deprecated config file /etc/modprobe.conf, all config files belong into /etc/modprobe.d/.
FATAL: Module sunrpc not found.
FATAL: Error running install command for sunrpc
Error: RPC MTAB does not exist.
Starting cups: [  OK  ]
Starting HAL daemon: [  OK  ]
Retrigger failed udev events[  OK  ]
Starting PC/SC smart card daemon (pcscd): [  OK  ]
Enabling Bluetooth devices:
Starting sshd: [  OK  ]
Starting ntpd: [  OK  ]
r8169 0000:02:00.0 eth6: Link is Up - 1Gbps/Full - flow control rx/tx
Starting sendmail: [  OK  ]
Starting sm-client: [  OK  ]
Starting abrt daemon: [  OK  ]
Starting console mouse services: [  OK  ]
Starting crond: [  OK  ]
Starting atd: [  OK  ][  OK  ]

Fedora release 13 (Goddard)
Kernel 5.17.0-rc1-test+ on an i686 (/dev/ttyS0)

mitest login: i915 0000:00:02.0: [drm] *ERROR* uncleared pch fifo underrun on pch transcoder A
i915 0000:00:02.0: [drm] *ERROR* PCH transcoder A FIFO underrun

--MP_/QNi0EY+Vf4Gh.2NbIHExy.Y--
