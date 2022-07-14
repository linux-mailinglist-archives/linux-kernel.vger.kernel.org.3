Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8931D574928
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbiGNJhZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Jul 2022 05:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbiGNJhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:37:24 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E793342F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:37:23 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id f11-20020a056e02168b00b002dc8abbf7f9so815516ila.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=WFr8N/EOSmpJftgydqWTgWKBCIxK/qqg2SGca5b7/a0=;
        b=HUir2mpjEFZcbBGttGeTEcSXdkE99p5I7Se/hHKa7+GkDxVaBaYurJFzMnvRKYGHYv
         iEaHRx/Ao3snRmCvGKg4suLViVKJSgkIz/h0y4ndai0rZgPMmuCrzJIINmUaRJKkym5K
         CwXqcGLvsmLl3rYUHz5bx2zT5XjF3OEdHADvB6vI7W+W42fWLwSFCHVW7gps1ILzws+i
         mVsUiSVwZRqi5McxvuOCi6raMVWhVHvC3lJ8UDsbF4ynZ2ocj42LnbvY4cuNgs2O4VU9
         CblT9BN0nn0+CFEiTLBxzqkIIPl/J1nP/8D16xtsnaAtp3iU26x20mlgf7u7c8gLUci1
         oWVQ==
X-Gm-Message-State: AJIora/jVfY1EPPJwQXnzORgSY1Fd2L0VGwneEePwIBPQ8EH5tvRsZvp
        bzGZV5inOE6q7wJ1F4Q3WJLb98g05rlZhzKvtu0fbsuCk3j5
X-Google-Smtp-Source: AGRyM1sxKJjXTj4UWFLpmqINTljIveX51rI2INVvyAcfGFllt4JljMPZ63V8JFmC4qfytTKGfBRdfnZRa/QQCTAJM5EWQJDzPCdw
MIME-Version: 1.0
X-Received: by 2002:a05:6638:419a:b0:341:3eac:e467 with SMTP id
 az26-20020a056638419a00b003413eace467mr936227jab.101.1657791442807; Thu, 14
 Jul 2022 02:37:22 -0700 (PDT)
Date:   Thu, 14 Jul 2022 02:37:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f74bf05e3c0a6f0@google.com>
Subject: [syzbot] linux-next boot error: kernel panic: swiotlb_init_remap:
 nslabs = NUM too small
From:   syzbot <syzbot+99f6c2141b62e707578c@syzkaller.appspotmail.com>
To:     hch@infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4662b7adea50 Add linux-next specific files for 20220713
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17a1c5c8080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91e2c45190556e73
dashboard link: https://syzkaller.appspot.com/bug?extid=99f6c2141b62e707578c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+99f6c2141b62e707578c@syzkaller.appspotmail.com

NODE_DATA(0) allocated [mem 0x13fffa000-0x13fffffff]
NODE_DATA(1) allocated [mem 0x23fff7000-0x23fffcfff]
Zone ranges:
  DMA      [mem 0x0000000000001000-0x0000000000ffffff]
  DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
  Normal   [mem 0x0000000100000000-0x000000023fffffff]
  Device   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000001000-0x000000000009efff]
  node   0: [mem 0x0000000000100000-0x00000000bfffcfff]
  node   0: [mem 0x0000000100000000-0x000000013fffffff]
  node   1: [mem 0x0000000140000000-0x000000023fffffff]
Initmem setup node 0 [mem 0x0000000000001000-0x000000013fffffff]
Initmem setup node 1 [mem 0x0000000140000000-0x000000023fffffff]
On node 0, zone DMA: 1 pages in unavailable ranges
On node 0, zone DMA: 97 pages in unavailable ranges
On node 0, zone Normal: 3 pages in unavailable ranges
kasan: KernelAddressSanitizer initialized
ACPI: PM-Timer IO Port: 0xb008
ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
ACPI: Using ACPI (MADT) for SMP configuration information
smpboot: Allowing 2 CPUs, 0 hotplug CPUs
PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
PM: hibernation: Registered nosave memory: [mem 0xbfffd000-0xbfffffff]
PM: hibernation: Registered nosave memory: [mem 0xc0000000-0xfffbbfff]
PM: hibernation: Registered nosave memory: [mem 0xfffbc000-0xffffffff]
[mem 0xc0000000-0xfffbbfff] available for PCI devices
Booting paravirtualized kernel on KVM
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:2 nr_node_ids:2
percpu: Embedded 69 pages/cpu s243848 r8192 d30584 u1048576
kvm-guest: PV spinlocks enabled
PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, linear)
Fallback order for Node 0: 0 1 
Fallback order for Node 1: 1 0 
Built 2 zonelists, mobility grouping on.  Total pages: 2064125
Policy zone: Normal
Kernel command line: earlyprintk=serial net.ifnames=0 sysctl.kernel.hung_task_all_cpu_backtrace=1 ima_policy=tcb nf-conntrack-ftp.ports=20000 nf-conntrack-tftp.ports=20000 nf-conntrack-sip.ports=20000 nf-conntrack-irc.ports=20000 nf-conntrack-sane.ports=20000 binder.debug_mask=0 rcupdate.rcu_expedited=1 no_hash_pointers page_owner=on sysctl.vm.nr_hugepages=4 sysctl.vm.nr_overcommit_hugepages=4 secretmem.enable=1 sysctl.max_rcu_stall_to_panic=1 msr.allow_writes=off root=/dev/sda console=ttyS0 vsyscall=native numa=fake=2 kvm-intel.nested=1 spec_store_bypass_disable=prctl nopcid vivid.n_devs=16 vivid.multiplanar=1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2 netrom.nr_ndevs=16 rose.rose_ndevs=16 dummy_hcd.num=8 smp.csd_lock_timeout=100000 watchdog_thresh=55 workqueue.watchdog_thresh=140 sysctl.net.core.netdev_unregister_timeout_secs=140 panic_on_warn=1 BOOT_IMAGE=/boot/bzImage root=/dev/sda1 console=ttyS0
Unknown kernel command line parameters "spec_store_bypass_disable=prctl BOOT_IMAGE=/boot/bzImage", will be passed to user space.
mem auto-init: stack:off, heap alloc:on, heap free:off
stackdepot hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
Kernel panic - not syncing: swiotlb_init_remap: nslabs = 0 too small
CPU: 0 PID: 0 Comm: swapper Not tainted 5.19.0-rc6-next-20220713-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 panic+0x2c8/0x627 kernel/panic.c:274
 swiotlb_init_remap+0x60/0x7e kernel/dma/swiotlb.c:306
 mem_init+0x18/0x351 arch/x86/mm/init_64.c:1332
 mm_init+0xa1/0xc9 init/main.c:843
 start_kernel+0x18e/0x494 init/main.c:990
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
