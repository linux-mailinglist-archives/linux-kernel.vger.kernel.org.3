Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243B158373E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 04:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbiG1C7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 22:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiG1C7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:59:09 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A3C58B7A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 19:59:08 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id a20-20020a5d9594000000b0067c9f95d592so182473ioo.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 19:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=xCisPgX9+vcLOJrMqLiV4k3yGnlStFXGK7eF5gU1Cwc=;
        b=YR7QOb3r6gmNbQcI0me/0hvCAd5qBcRdq0roWa3jImdjlBgWQMm4veWfzH+BLqJYJW
         0OCQeAczLW2mPC/kY5MRdFQiGHvdIjoP1CLXPz4QurPPeQEvtkecBDT+IAZVisgseeHg
         X3WkmUO9k2NxCcDeDYx/MOUez3lHEauC0YewysuexpjzF2tc3qe3PPm+dwCaf+Th5t09
         XYZ2zZNv/394ttj+zBs9GUPJeP/b8eMnwBgYVJBZG4/4kYS3cxOB/5q1bFMv6HxsqUnZ
         Hr2aoP8rZx+JRAUkt3v0EkRKIrJwxUJQpblFGGdcYKk5JcRHtB+t91le4oeI47VfySXr
         NpTg==
X-Gm-Message-State: AJIora/8RktG4tvrOZWV8J6vwaT/M8lgDOW7nNbFc5VfHv1PqbLTC34i
        F/3ImZY+MNgFg0bBWF6JAk/xxAJ1AGL6HGTmNLcN+VI3EEzH
X-Google-Smtp-Source: AGRyM1tRsdoML92fQ4zl2V6KM3QXqtKs6r5UkA8IyhODtoBDw/akwF1mUs1xDfqDZx4L3ho0rxgVD/OrhUO7yYtTdyE53+oWb7D0
MIME-Version: 1.0
X-Received: by 2002:a92:c984:0:b0:2dd:eacf:da3c with SMTP id
 y4-20020a92c984000000b002ddeacfda3cmr857734iln.245.1658977147501; Wed, 27 Jul
 2022 19:59:07 -0700 (PDT)
Date:   Wed, 27 Jul 2022 19:59:07 -0700
In-Reply-To: <20220728024623.492-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009142ac05e4d4b761@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in net_tx_action
From:   syzbot <syzbot+3ba0493d523d007b3819@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in smp_call_function

hrtimer: interrupt took 6731213 ns
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
	(detected by 1, t=16762 jiffies, g=9593, q=459)
rcu: All QSes seen, last rcu_preempt kthread activity 15495 (4294962574-4294947079), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 15495 jiffies! g9593 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28800 pid:   14 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4339 [inline]
 __schedule+0x916/0x23e0 kernel/sched/core.c:5147
 schedule+0xcf/0x270 kernel/sched/core.c:5226
 schedule_timeout+0x14a/0x250 kernel/time/timer.c:1892
 rcu_gp_fqs_loop kernel/rcu/tree.c:2004 [inline]
 rcu_gp_kthread+0xd07/0x2300 kernel/rcu/tree.c:2177
 kthread+0x3b1/0x4a0 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
rcu: Stack dump where RCU GP kthread last ran:
NMI backtrace for cpu 1
CPU: 1 PID: 25 Comm: kworker/u4:1 Not tainted 5.13.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_check_gp_kthread_starvation.cold+0x1cc/0x1d1 kernel/rcu/tree_stall.h:480
 print_other_cpu_stall kernel/rcu/tree_stall.h:585 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:710 [inline]
 rcu_pending kernel/rcu/tree.c:3911 [inline]
 rcu_sched_clock_irq+0x2079/0x20e0 kernel/rcu/tree.c:2649
 update_process_times+0x16d/0x200 kernel/time/timer.c:1796
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:226
 tick_sched_timer+0x1b0/0x2d0 kernel/time/tick-sched.c:1374
 __run_hrtimer kernel/time/hrtimer.c:1583 [inline]
 __hrtimer_run_queues+0x1c0/0xe40 kernel/time/hrtimer.c:1647
 hrtimer_interrupt+0x330/0xa00 kernel/time/hrtimer.c:1709
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1089 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x540 arch/x86/kernel/apic/apic.c:1106
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1100
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:647
RIP: 0010:csd_lock_wait kernel/smp.c:440 [inline]
RIP: 0010:smp_call_function_many_cond+0x452/0xc20 kernel/smp.c:967
Code: 0b 00 85 ed 74 4d 48 b8 00 00 00 00 00 fc ff df 4d 89 f4 4c 89 f5 49 c1 ec 03 83 e5 07 49 01 c4 83 c5 03 e8 e0 39 0b 00 f3 90 <41> 0f b6 04 24 40 38 c5 7c 08 84 c0 0f 85 33 06 00 00 8b 43 08 31
RSP: 0018:ffffc90000dfef48 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffff8880b9c3bee0 RCX: 0000000000000000
RDX: ffff8880157c1c40 RSI: ffffffff8169a180 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff8169a1a6 R11: 0000000000000000 R12: ffffed10173877dd
R13: 0000000000000000 R14: ffff8880b9c3bee8 R15: 0000000000000001
 on_each_cpu_cond_mask+0x56/0xa0 kernel/smp.c:1133
 __flush_tlb_multi arch/x86/include/asm/paravirt.h:87 [inline]
 flush_tlb_multi arch/x86/mm/tlb.c:862 [inline]
 flush_tlb_mm_range+0x1d8/0x230 arch/x86/mm/tlb.c:948
 flush_tlb_page arch/x86/include/asm/tlbflush.h:239 [inline]
 ptep_clear_flush+0x12b/0x160 mm/pgtable-generic.c:97
 page_mkclean_one+0x4d1/0xa80 mm/rmap.c:934
 rmap_walk_file+0x397/0x860 mm/rmap.c:1951
 rmap_walk+0x105/0x190 mm/rmap.c:1969
 page_mkclean+0x21c/0x2b0 mm/rmap.c:1002
 clear_page_dirty_for_io+0x31c/0xa10 mm/page-writeback.c:2698
 mpage_submit_page+0x80/0x2a0 fs/ext4/inode.c:2080
 mpage_map_and_submit_buffers fs/ext4/inode.c:2348 [inline]
 mpage_map_and_submit_extent fs/ext4/inode.c:2487 [inline]
 ext4_writepages+0x24c1/0x3b70 fs/ext4/inode.c:2800
 do_writepages+0xec/0x290 mm/page-writeback.c:2352
 __writeback_single_inode+0x126/0xfd0 fs/fs-writeback.c:1467
 writeback_sb_inodes+0x53d/0xef0 fs/fs-writeback.c:1732
 __writeback_inodes_wb+0xc6/0x280 fs/fs-writeback.c:1801
 wb_writeback+0x814/0xc40 fs/fs-writeback.c:1907
 wb_check_old_data_flush fs/fs-writeback.c:2009 [inline]
 wb_do_writeback fs/fs-writeback.c:2062 [inline]
 wb_workfn+0x891/0x12d0 fs/fs-writeback.c:2091
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2276
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2422
 kthread+0x3b1/0x4a0 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


Tested on:

commit:         d6765985 Revert "be2net: disable bh with spin_lock in ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=143f08d2080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d43f3e8616689bf
dashboard link: https://syzkaller.appspot.com/bug?extid=3ba0493d523d007b3819
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f00172080000

