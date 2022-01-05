Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D062B485627
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 16:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241656AbiAEPpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 10:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241650AbiAEPpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 10:45:38 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD799C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 07:45:37 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id m21so164883707edc.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 07:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=sB5D4dtGiv6CejvVLEYs5nTusWfE8ETSRvq1Ve6PHCI=;
        b=lGi8L7U8Y0C6b7vh+RlLgRW4gLkuxYEUzE8rdz56A7B7ove1xZcB4X/qlpq1sATHD3
         LWcyyXhvPsl+v3o6T5oOczMA50++PDCgE6tz7OB+s+9IR6ooYt7NqzBuoaytRw24n2Ly
         7UDxRmo7X+wda/2fg2RS4lQgAdlK4B8bNrpGZk4iszmpVoexeygrI01Lmegi54bGqBCR
         F6LDhKL+TmPBHqhILa/xr1RdnkTp3aKxZcOCHZF9Dg2BEe7bzlqYkQfnB9ECebKV1fdu
         TtaqXcGXLZJhLfL9nXqxuBiHGvplmMiWdIR/Ur0IvRdm7HBncg3JaN8QchlN3EGPnE66
         RgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sB5D4dtGiv6CejvVLEYs5nTusWfE8ETSRvq1Ve6PHCI=;
        b=puGqvBTqmDaygXNCnimjV06ddFFcAc/kzajY6dTG4seQS9uyFiCjxNZKg/zY916Ct0
         KsqW7mAfLdnuKHuPis+tV7oDXYkfkOlGa49IxgY53riI3nodIT8XJf4SfN6x6N9I14YG
         t1CvsKSxf9dRuJH4A1BuMl+AGkl4oWhZ8YXIaDAzOvvRu1Wml1HRaluZjhoK0+TGetxH
         FMb1GlfLCiqXHBPhu36IYTzg0mBfza6k8i2d1ZdU1bLb08yi4JKVJxbKfBKZVcxnm2T/
         gseLtkliAmZFGjO3umILsBqk2wK/6gBdZLwS74IuFfQFmkCzd2g1TDcbnO64Esob72h2
         BdPQ==
X-Gm-Message-State: AOAM533JcZ7/6zzIQebyQZy2g+XZ9kmmuRpCKUySBZPXekTV21tTPlav
        SztIm6jDAbB8B4Xh/krk720VtlxJJZDdfDymGNc=
X-Google-Smtp-Source: ABdhPJyNltOgbnpGhfDe/lxvdIsvuijLXa1NiTimi+zWXro8QTpKa+mZoEFRMiKIKx/W8VJgAa8VR0Et2fuoIYpCbNk=
X-Received: by 2002:a17:907:7256:: with SMTP id ds22mr43273766ejc.556.1641397536290;
 Wed, 05 Jan 2022 07:45:36 -0800 (PST)
MIME-Version: 1.0
From:   "Sabri N. Ferreiro" <snferreiro1@gmail.com>
Date:   Wed, 5 Jan 2022 23:45:24 +0800
Message-ID: <CAKG+3NQgD6K07-1feXzPy=YZUHfEBS0w2D2JRazCc0UC6++DmQ@mail.gmail.com>
Subject: INFO: rcu detected stall in stack_trace_save
To:     Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Cc:     mosesfonscqf75@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When using Syzkaller to fuzz the Linux kernel, it triggers the following crash.

HEAD commit: a7904a538933 Linux 5.16-rc6
git tree: upstream
console output:
https://docs.google.com/document/d/1CeOHXK07uAJbzcKN7tb9FCt8BIBgrAC1EKx7jDJe_CQ/view
kernel config: https://docs.google.com/document/d/1w94kqQ4ZSIE6BW-5WIhqp4_Zh7XTPH57L5OF2Xb6O6o/view

If you fix this issue, please add the following tag to the commit:
Reported-by:  Yuheng Shen <mosesfonscqf75@gmail.com>

Sorry for my lack of this crash reproducer, I hope the symbolic report
will help you.

RAX: 0000000000000000 RBX: ffff88810f62f6f0 RCX: ffffffff9b677838
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88810f62f702
RBP: ffff8881019698c0 R08: 0000000000000001 R09: ffff888133450da3
R10: ffffed102668a1b4 R11: 0000000000000001 R12: dffffc0000000000
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
R13: ffff8881019698c2 R14: ffffed1021ec5ee0 R15: 000000000000000c
rcu: 0-....: (1 GPs behind) idle=b55/1/0x4000000000000000
softirq=89695/89700 fqs=4237
(detected by 3, t=21002 jiffies, g=110645, q=63240)
Sending NMI from CPU 3 to CPUs 0:
 mapping_get_entry root/fuzz/kernel/5.16/mm/filemap.c:1843 [inline]
 __filemap_get_folio+0x116/0x670 root/fuzz/kernel/5.16/mm/filemap.c:1905
NMI backtrace for cpu 0
CPU: 0 PID: 497 Comm: syz-executor.11 Not tainted 5.16.0-rc6 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:arch_atomic_try_cmpxchg
root/fuzz/kernel/5.16/./arch/x86/include/asm/atomic.h:202 [inline]
RIP: 0010:atomic_try_cmpxchg_acquire
root/fuzz/kernel/5.16/./include/linux/atomic/atomic-instrumented.h:513
[inline]
RIP: 0010:queued_spin_lock
root/fuzz/kernel/5.16/./include/asm-generic/qspinlock.h:82 [inline]
RIP: 0010:do_raw_spin_lock
root/fuzz/kernel/5.16/./include/linux/spinlock.h:185 [inline]
RIP: 0010:__raw_spin_lock
root/fuzz/kernel/5.16/./include/linux/spinlock_api_smp.h:134 [inline]
RIP: 0010:_raw_spin_lock+0x90/0xd0
root/fuzz/kernel/5.16/kernel/locking/spinlock.c:154
Code: c7 44 24 20 00 00 00 00 e8 5d b3 d2 fd be 04 00 00 00 48 8d 7c
24 20 e8 4e b3 d2 fd ba 01 00 00 00 8b 44 24 20 f0 0f b1 55 00 <75> 29
48 b8 00 00 00 00 00 fc ff df 48 c7 04 03 00 00 00 00 48 8b
RSP: 0018:ffff8881f72090d0 EFLAGS: 00000046
RAX: 0000000000000000 RBX: 1ffff1103ee4121a RCX: ffffffff9d0e0282
RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffff8881f72090f0
RBP: ffffffff9ee9e980 R08: 0000000000000001 R09: ffff8881f72090f3
R10: ffffed103ee4121e R11: 0000000000000001 R12: ffff8881f72091a0
R13: 000000000000f487 R14: 000000000000f487 R15: ffff8881f7209330
FS:  0000555556d33940(0000) GS:ffff8881f7200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555556d3d078 CR3: 000000010627c000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 console_lock_spinning_enable
root/fuzz/kernel/5.16/kernel/printk/printk.c:1776 [inline]
 console_unlock+0x28e/0x8e0 root/fuzz/kernel/5.16/kernel/printk/printk.c:2708
 vprintk_emit+0xf8/0x230 root/fuzz/kernel/5.16/kernel/printk/printk.c:2245
 vprintk+0x69/0x80 root/fuzz/kernel/5.16/kernel/printk/printk_safe.c:50
 _printk+0xba/0xed root/fuzz/kernel/5.16/kernel/printk/printk.c:2266
 printk_stack_address
root/fuzz/kernel/5.16/arch/x86/kernel/dumpstack.c:72 [inline]
 show_trace_log_lvl+0x263/0x2ca
root/fuzz/kernel/5.16/arch/x86/kernel/dumpstack.c:282
 ex_handler_wrmsr_unsafe root/fuzz/kernel/5.16/arch/x86/mm/extable.c:87 [inline]
 fixup_exception+0x3bb/0x690 root/fuzz/kernel/5.16/arch/x86/mm/extable.c:150
 __exc_general_protection
root/fuzz/kernel/5.16/arch/x86/kernel/traps.c:601 [inline]
 exc_general_protection+0xed/0x2e0
root/fuzz/kernel/5.16/arch/x86/kernel/traps.c:562
 asm_exc_general_protection+0x1e/0x30
root/fuzz/kernel/5.16/./arch/x86/include/asm/idtentry.h:562
RIP: 0010:__wrmsr
root/fuzz/kernel/5.16/./arch/x86/include/asm/msr.h:103 [inline]
RIP: 0010:native_write_msr
root/fuzz/kernel/5.16/./arch/x86/include/asm/msr.h:160 [inline]
RIP: 0010:wrmsrl root/fuzz/kernel/5.16/./arch/x86/include/asm/msr.h:281 [inline]
RIP: 0010:x86_pmu_disable_event
root/fuzz/kernel/5.16/arch/x86/events/amd/../perf_event.h:1138
[inline]
RIP: 0010:amd_pmu_disable_event+0x83/0x280
root/fuzz/kernel/5.16/arch/x86/events/amd/core.c:639
Code: 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 e0 01
00 00 48 8b ab 78 01 00 00 4c 89 e2 44 89 e0 48 c1 ea 20 89 e9 <0f> 30
66 90 e8 34 4a 38 00 e8 2f 4a 38 00 48 8d bb 94 01 00 00 48
RSP: 0018:ffff8881f7209650 EFLAGS: 00010016
RAX: 0000000000130076 RBX: ffff88810ccbe9c0 RCX: 00000000c0010204
RDX: 0000000000000100 RSI: ffffffff9d607480 RDI: ffff88810ccbeb38
RBP: 00000000c0010204 R08: 0000000000000000 R09: ffff8881f72219e7
R10: ffffed103ee4433c R11: 0000000000000001 R12: 0000010000130076
R13: 0000000000000002 R14: ffff8881f72217e0 R15: ffff88810ccbeb4c
 x86_pmu_stop+0x11b/0x320 root/fuzz/kernel/5.16/arch/x86/events/core.c:1597
 perf_adjust_freq_unthr_context
root/fuzz/kernel/5.16/kernel/events/core.c:4089 [inline]
 perf_event_task_tick+0x4ba/0xb20
root/fuzz/kernel/5.16/kernel/events/core.c:4216
 scheduler_tick+0x145/0x2e0 root/fuzz/kernel/5.16/kernel/sched/core.c:5253
 update_process_times+0x165/0x1d0 root/fuzz/kernel/5.16/kernel/time/timer.c:1790
 tick_sched_handle+0x10f/0x150
root/fuzz/kernel/5.16/kernel/time/tick-sched.c:226
 tick_sched_timer+0x163/0x1c0
root/fuzz/kernel/5.16/kernel/time/tick-sched.c:1428
 __run_hrtimer root/fuzz/kernel/5.16/kernel/time/hrtimer.c:1685 [inline]
 __hrtimer_run_queues+0x3bd/0x810
root/fuzz/kernel/5.16/kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0x2f3/0x700 root/fuzz/kernel/5.16/kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt
root/fuzz/kernel/5.16/arch/x86/kernel/apic/apic.c:1086 [inline]
 __sysvec_apic_timer_interrupt+0x114/0x360
root/fuzz/kernel/5.16/arch/x86/kernel/apic/apic.c:1103
 sysvec_apic_timer_interrupt+0x3b/0xc0
root/fuzz/kernel/5.16/arch/x86/kernel/apic/apic.c:1097
 asm_sysvec_apic_timer_interrupt+0x12/0x20
root/fuzz/kernel/5.16/./arch/x86/include/asm/idtentry.h:638
RIP: 0010:on_stack
root/fuzz/kernel/5.16/./arch/x86/include/asm/stacktrace.h:56 [inline]
RIP: 0010:__unwind_start
root/fuzz/kernel/5.16/arch/x86/kernel/unwind_orc.c:710 [inline]
RIP: 0010:__unwind_start+0x51f/0x790
root/fuzz/kernel/5.16/arch/x86/kernel/unwind_orc.c:637
Code: 8e 18 01 00 00 41 8b 07 85 c0 0f 84 91 fd ff ff 41 80 7d 00 00
0f 85 0f 01 00 00 41 80 3c 24 00 49 8b 47 08 0f 85 0e 01 00 00 <49> 8b
57 10 48 39 c3 72 b3 48 39 d3 73 ae 48 8d 4b 08 48 39 ca 72
RSP: 0018:ffff8881f7209a58 EFLAGS: 00000246
RAX: ffff8881f7202000 RBX: ffff8881f7209b40 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: ffff8881f7209a78 RDI: 0000000000000001
RBP: dffffc0000000000 R08: ffffffff9e823b6e R09: ffffffff9e823b72
R10: ffffed103ee41362 R11: 000000000002c03e R12: ffffed103ee41357
R13: ffffed103ee41356 R14: ffff8881f7209af0 R15: ffff8881f7209aa8
 unwind_start root/fuzz/kernel/5.16/./arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0x5f/0xf0 root/fuzz/kernel/5.16/arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x8c/0xc0 root/fuzz/kernel/5.16/kernel/stacktrace.c:122
 kasan_save_stack+0x1e/0x50 root/fuzz/kernel/5.16/mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 root/fuzz/kernel/5.16/mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 root/fuzz/kernel/5.16/mm/kasan/generic.c:370
 ____kasan_slab_free root/fuzz/kernel/5.16/mm/kasan/common.c:366 [inline]
 ____kasan_slab_free root/fuzz/kernel/5.16/mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xeb/0x120 root/fuzz/kernel/5.16/mm/kasan/common.c:374
 kasan_slab_free root/fuzz/kernel/5.16/./include/linux/kasan.h:235 [inline]
 slab_free_hook root/fuzz/kernel/5.16/mm/slub.c:1723 [inline]
 slab_free_freelist_hook root/fuzz/kernel/5.16/mm/slub.c:1749 [inline]
 slab_free root/fuzz/kernel/5.16/mm/slub.c:3513 [inline]
 kmem_cache_free+0x84/0x290 root/fuzz/kernel/5.16/mm/slub.c:3530
 rcu_do_batch root/fuzz/kernel/5.16/kernel/rcu/tree.c:2506 [inline]
 rcu_core+0x56e/0x1780 root/fuzz/kernel/5.16/kernel/rcu/tree.c:2741
 __do_softirq+0x1a5/0x5a8 root/fuzz/kernel/5.16/kernel/softirq.c:558
 invoke_softirq root/fuzz/kernel/5.16/kernel/softirq.c:432 [inline]
 __irq_exit_rcu root/fuzz/kernel/5.16/kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xc0/0x170 root/fuzz/kernel/5.16/kernel/softirq.c:649
 sysvec_apic_timer_interrupt+0x8e/0xc0
root/fuzz/kernel/5.16/arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20
root/fuzz/kernel/5.16/./arch/x86/include/asm/idtentry.h:638
RIP: 0010:xas_load+0x9a/0x1a0 root/fuzz/kernel/5.16/lib/xarray.c:238
Code: 00 76 db e8 28 20 52 ff 41 0f b6 06 49 8d 6d fe 84 c0 74 06 0f
8e b1 00 00 00 48 89 e8 0f b6 53 10 48 c1 e8 03 42 0f b6 04 20 <84> c0
74 06 0f 8e df 00 00 00 44 0f b6 7d 00 44 38 fa 77 a0 e8 ed
RSP: 0018:ffff88810f62f638 EFLAGS: 00000216
RAX: 0000000000000000 RBX: ffff88810f62f6f0 RCX: ffffffff9b677838
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88810f62f702
RBP: ffff8881019698c0 R08: 0000000000000001 R09: ffff888133450da3
R10: ffffed102668a1b4 R11: 0000000000000001 R12: dffffc0000000000
R13: ffff8881019698c2 R14: ffffed1021ec5ee0 R15: 000000000000000c
 mapping_get_entry root/fuzz/kernel/5.16/mm/filemap.c:1843 [inline]
 __filemap_get_folio+0x116/0x670 root/fuzz/kernel/5.16/mm/filemap.c:1905
 pagecache_get_page+0x28/0x100 root/fuzz/kernel/5.16/mm/folio-compat.c:125
 find_get_page_flags
root/fuzz/kernel/5.16/./include/linux/pagemap.h:445 [inline]
 __find_get_block_slow root/fuzz/kernel/5.16/fs/buffer.c:202 [inline]
 __find_get_block root/fuzz/kernel/5.16/fs/buffer.c:1308 [inline]
 __find_get_block+0x32e/0x7a0 root/fuzz/kernel/5.16/fs/buffer.c:1302
 __getblk_gfp+0x28/0x70 root/fuzz/kernel/5.16/fs/buffer.c:1330
 sb_getblk root/fuzz/kernel/5.16/./include/linux/buffer_head.h:327 [inline]
 ext4_getblk+0x1aa/0x5f0 root/fuzz/kernel/5.16/fs/ext4/inode.c:854
 ext4_bread+0x29/0x170 root/fuzz/kernel/5.16/fs/ext4/inode.c:900
 __ext4_read_dirblock+0x30/0xd30 root/fuzz/kernel/5.16/fs/ext4/namei.c:116
 htree_dirblock_to_tree+0x185/0xb30 root/fuzz/kernel/5.16/fs/ext4/namei.c:1028
 ext4_htree_fill_tree+0x2e1/0xb20 root/fuzz/kernel/5.16/fs/ext4/namei.c:1160
 ext4_dx_readdir root/fuzz/kernel/5.16/fs/ext4/dir.c:598 [inline]
 ext4_readdir+0x148a/0x28d0 root/fuzz/kernel/5.16/fs/ext4/dir.c:142
 iterate_dir+0x4d3/0x640 root/fuzz/kernel/5.16/fs/readdir.c:65
 __do_sys_getdents64 root/fuzz/kernel/5.16/fs/readdir.c:369 [inline]
 __se_sys_getdents64 root/fuzz/kernel/5.16/fs/readdir.c:354 [inline]
 __x64_sys_getdents64+0x12f/0x270 root/fuzz/kernel/5.16/fs/readdir.c:354
 do_syscall_x64 root/fuzz/kernel/5.16/arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3b/0x90 root/fuzz/kernel/5.16/arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f107ef3584b
Code: eb b5 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 48 81
fa ff ff ff 7f b8 ff ff ff 7f 48 0f 47 d0 b8 d9 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 05 c3 0f 1f 40 00 48 c7 c2 bc ff ff ff f7 d8
RSP: 002b:00007ffebf4b1e28 EFLAGS: 00000293 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 0000555556d35070 RCX: 00007f107ef3584b
RDX: 0000000000008000 RSI: 0000555556d35070 RDI: 0000000000000003
RBP: ffffffffffffffbc R08: 0000000000000030 R09: 000000000000007c
R10: 00007f107f001520 R11: 0000000000000293 R12: 0000555556d35044
R13: 0000000000000016 R14: 0000555556d35040 R15: 00007ffebf4b2ff0
 </TASK>
