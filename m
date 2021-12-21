Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7A947C371
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 17:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbhLUQEX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Dec 2021 11:04:23 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:34469 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238660AbhLUQEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:04:22 -0500
Received: by mail-io1-f69.google.com with SMTP id i20-20020a0566022c9400b005ec5bb1e85eso9342933iow.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 08:04:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=B7ofwDRF176RFrj1i0N0iVlkMv49GpCZUmBDMRIGB7k=;
        b=Dlsxbb0zDOEe5yfj7A7Q0ppdCP5AzEEZkk6i4qqGW21aTziPKYcwIF8rXEIBJpwBly
         x06NbygdK46l/oGbpAXhKQH8FGLxQpVFzjQpTb6crKHlpm/lt0bDzL+e70xSaP1cb/hb
         b8MQxJpaEheJ86XRN9vy2kPKYDxUTOQczIJSTmDEhHlvmO3dctOxgPSy5QdhXzrsdSjl
         tZbkcR/EpzxJde9UfTI8ecKMXUtkxusQrrVQeAmYUhG+B6dZDbcgxIm56hJyV0V9FsC2
         htCEsw2ZB/VXwmy4xF1c1Y6Qx7hh1pviyPuoi+DcnwERPoGEKUe2nfbgHJvLBJTpEiRd
         4/IQ==
X-Gm-Message-State: AOAM532WbPjRHfdeiGqnJPfp5RsEg/2Of22XcN1B6/+1dtg8551OekaD
        /y2GJLoGbZi+R/4AOqWfus5QwaWAbydr1GRufS4jbwRbU0qU
X-Google-Smtp-Source: ABdhPJw+QvFNWR/v/AlpN4cXNXucI7hYd6afsgiTKrKWsVO1hhux68TYutZCzU9WvcGcaRFOSPDgPOdgtqfw9fHQu0Zfww1vrv/6
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2688:: with SMTP id o8mr354357jat.118.1640102662148;
 Tue, 21 Dec 2021 08:04:22 -0800 (PST)
Date:   Tue, 21 Dec 2021 08:04:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000929af305d3aa2864@google.com>
Subject: [syzbot] linux-next boot error: WARNING in sched_init
From:   syzbot <syzbot+7b9f3876a92c5b3116c4@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2850c2311ef4 Add linux-next specific files for 20211221
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11db7399b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c5fd30becd44062
dashboard link: https://syzkaller.appspot.com/bug?extid=7b9f3876a92c5b3116c4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7b9f3876a92c5b3116c4@syzkaller.appspotmail.com

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
percpu: Embedded 69 pages/cpu s242952 r8192 d31480 u1048576
kvm-guest: stealtime: cpu 0, msr b9c27440
kvm-guest: PV spinlocks enabled
PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, linear)
Fallback order for Node 0: 0 1 
Fallback order for Node 1: 1 0 
Built 2 zonelists, mobility grouping on.  Total pages: 2064125
Policy zone: Normal
Kernel command line: earlyprintk=serial net.ifnames=0 sysctl.kernel.hung_task_all_cpu_backtrace=1 ima_policy=tcb nf-conntrack-ftp.ports=20000 nf-conntrack-tftp.ports=20000 nf-conntrack-sip.ports=20000 nf-conntrack-irc.ports=20000 nf-conntrack-sane.ports=20000 binder.debug_mask=0 rcupdate.rcu_expedited=1 no_hash_pointers page_owner=on sysctl.vm.nr_hugepages=4 sysctl.vm.nr_overcommit_hugepages=4 secretmem.enable=1 root=/dev/sda console=ttyS0 vsyscall=native numa=fake=2 kvm-intel.nested=1 spec_store_bypass_disable=prctl nopcid vivid.n_devs=16 vivid.multiplanar=1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2 netrom.nr_ndevs=16 rose.rose_ndevs=16 dummy_hcd.num=8 watchdog_thresh=55 workqueue.watchdog_thresh=140 sysctl.net.core.netdev_unregister_timeout_secs=140 panic_on_warn=1 BOOT_IMAGE=/boot/bzImage root=/dev/sda1 console=ttyS0
Unknown kernel command line parameters "spec_store_bypass_disable=prctl BOOT_IMAGE=/boot/bzImage", will be passed to user space.
mem auto-init: stack:off, heap alloc:on, heap free:off
Stack Depot allocating hash table with memblock_alloc
Memory: 6842036K/8388204K available (139293K kernel code, 34117K rwdata, 29684K rodata, 4556K init, 25096K bss, 1545912K reserved, 0K cma-reserved)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=2
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:9469 sched_init+0xcc3/0xd8d kernel/sched/core.c:9469
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 5.16.0-rc6-next-20211221-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:sched_init+0xcc3/0xd8d kernel/sched/core.c:9469
Code: ff 05 86 95 f3 fc 65 48 8b 2c 25 00 70 02 00 48 c7 c7 c0 27 cb 8b 48 89 ee e8 5e 82 5d f2 48 89 ef e8 b6 7d 76 f2 84 c0 74 02 <0f> 0b e8 2b db 7e fa 89 c6 65 48 8b 3c 25 00 70 02 00 e8 a6 eb ff
RSP: 0000:ffffffff8b807ee0 EFLAGS: 00010002
RAX: 0000000000000001 RBX: 0000000000400000 RCX: 0000000000000000
RDX: ffffffff8b8bc6c0 RSI: ffffffff814e1225 RDI: ffffffff8b8bcd58
RBP: ffffffff8b8bc6c0 R08: 0000000000000002 R09: 0000000000000000
R10: fffffbfff1895c20 R11: ffffffff81000108 R12: 0000000000000008
R13: 0000000000000003 R14: ffff8880b9d3a698 R15: 000000000007a120
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000b88e000 CR4: 00000000000406b0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 start_kernel+0x198/0x49b init/main.c:1000
 secondary_startup_64_no_verify+0xc3/0xcb
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
