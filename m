Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8407646E4B1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbhLIJAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:00:08 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:51740 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbhLII77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:59:59 -0500
Received: by mail-il1-f199.google.com with SMTP id l2-20020a056e021aa200b002a281027bb8so6479813ilv.18
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 00:56:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=tfDywDKtSF0CybDoWRcPaSPgfvTSCrBOzqNeaMLbsqc=;
        b=V8fwkY2W9Rd08GVltv9ATvkZoASTpOsvUe2OhmEalZTo1TOqvBaO74dB+BMQYvDC1P
         3eDUackp7royLy3HjhrvmgHPaVjZFmjAjN6fU8D2QLzrrjfJt9LSXv8LiVOCJzG7d6wx
         YRkXZwhaWIyrYxftQ0ll0TIWWm86jsrLqOd8EoTLbLON62IqK8RI6Rjn2A5a04FBoNlS
         KOAJRgPXB6bFQWgA+0V1zb/XqJpiRiGSErPZIyIgL/8HWoOOWMKmMeOI/oG14kuzwahY
         gssfJMkeOMVsBoSs/yO85+GX1NngC9Ybi0d8tyqdOWLwVEIn5RuXWHSyAtx2JppCILlb
         cG1Q==
X-Gm-Message-State: AOAM530G1LX3VjkhHFPRuUQvCZVhFbCGHvMSWPrnzaCLp2lx/Ct1nL+p
        leELS0qtRvtVFFE+CXnE2Xx/mgFY23WDxu8U5y4qqGfP6ZYu
X-Google-Smtp-Source: ABdhPJzYuNK2MN9qEbnI8xNRalYWGoHYRDobXR+4XOh6+7Kpy/4LTfAci8CL2q+ybxb/kAU1zAcXNuR0O1fLwBaIshvONQHBIMHJ
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4091:: with SMTP id m17mr7005935jam.41.1639040186496;
 Thu, 09 Dec 2021 00:56:26 -0800 (PST)
Date:   Thu, 09 Dec 2021 00:56:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000016ba8905d2b2c8a5@google.com>
Subject: [syzbot] INFO: rcu detected stall in gc_worker (2)
From:   syzbot <syzbot+70c4a3a8fe7f7e1af947@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, luto@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2a987e65025e Merge tag 'perf-tools-fixes-for-v5.16-2021-12..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=114fe575b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d5e878e3399b6cc
dashboard link: https://syzkaller.appspot.com/bug?extid=70c4a3a8fe7f7e1af947
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128048b9b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ceddadb00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+70c4a3a8fe7f7e1af947@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P2968/1:b..l
	(detected by 1, t=10502 jiffies, g=6713, q=51)
task:kworker/0:3     state:R  running task     stack:27024 pid: 2968 ppid:     2 flags:0x00004000
Workqueue: events_power_efficient gc_worker
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xb72/0x1460 kernel/sched/core.c:6253
 preempt_schedule_irq+0xf7/0x1c0 kernel/sched/core.c:6668
 irqentry_exit+0x56/0x90 kernel/entry/common.c:425
 asm_sysvec_apic_timer_interrupt+0x12/0x20
RIP: 0010:lock_acquire+0x45/0x4d0 kernel/locking/lockdep.c:5605
Code: 41 89 f6 48 89 fb 65 48 8b 04 25 28 00 00 00 48 89 84 24 00 01 00 00 49 bf 00 00 00 00 00 fc ff df 48 c7 44 24 40 b3 8a b5 41 <48> c7 44 24 48 b2 5c 3e 8c 48 c7 44 24 50 30 f8 65 81 4c 8d 6c 24
RSP: 0018:ffffc900027ffa40 EFLAGS: 00000282
RAX: 4d6d62c65d03e900 RBX: ffffffff8cb1dd00 RCX: 0000000000000002
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8cb1dd00
RBP: ffffc900027ffb98 R08: 0000000000000000 R09: 0000000000000000
R10: fffffbfff1bfd1b6 R11: 0000000000000000 R12: 0000000000000002
R13: ffff888022a40918 R14: 0000000000000000 R15: dffffc0000000000
 rcu_lock_acquire+0x2a/0x30 include/linux/rcupdate.h:268
 rcu_read_lock include/linux/rcupdate.h:688 [inline]
 gc_worker+0x111/0xbb0 net/netfilter/nf_conntrack_core.c:1439
 process_one_work+0x853/0x1140 kernel/workqueue.c:2298
 worker_thread+0xac1/0x1320 kernel/workqueue.c:2445
 kthread+0x468/0x490 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30
 </TASK>
rcu: rcu_preempt kthread starved for 10502 jiffies! g6713 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:26576 pid:   14 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xb72/0x1460 kernel/sched/core.c:6253
 preempt_schedule_common kernel/sched/core.c:6419 [inline]
 preempt_schedule+0x14d/0x190 kernel/sched/core.c:6444
 preempt_schedule_thunk+0x16/0x18
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock_irqrestore+0x128/0x130 kernel/locking/spinlock.c:194
 prepare_to_swait_event+0x322/0x340 kernel/sched/swait.c:120
 rcu_gp_fqs_loop+0x216/0x770 kernel/rcu/tree.c:1955
 rcu_gp_kthread+0xa5/0x350 kernel/rcu/tree.c:2128
 kthread+0x468/0x490 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
NMI backtrace for cpu 1
CPU: 1 PID: 6553 Comm: syz-executor945 Not tainted 5.16.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x45f/0x490 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x16a/0x280 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_check_gp_kthread_starvation+0x1ff/0x270 kernel/rcu/tree_stall.h:481
 print_other_cpu_stall kernel/rcu/tree_stall.h:586 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:729 [inline]
 rcu_pending kernel/rcu/tree.c:3878 [inline]
 rcu_sched_clock_irq+0x23d5/0x2bc0 kernel/rcu/tree.c:2597
 update_process_times+0x197/0x200 kernel/time/timer.c:1785
 tick_sched_handle kernel/time/tick-sched.c:226 [inline]
 tick_sched_timer+0x27d/0x420 kernel/time/tick-sched.c:1428
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 __hrtimer_run_queues+0x4cb/0xa60 kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0x3b3/0x1040 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
 __sysvec_apic_timer_interrupt+0xf9/0x270 arch/x86/kernel/apic/apic.c:1103
 sysvec_apic_timer_interrupt+0x8c/0xb0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x60 kernel/kcov.c:196
Code: 84 00 00 00 00 00 0f 1f 40 00 be 0d 00 00 00 48 c7 c7 20 af b5 8c e8 8f c7 4b 00 c3 cc cc cc cc cc cc cc cc cc cc cc cc cc cc <48> 8b 04 24 65 48 8b 0c 25 c0 6f 02 00 65 8b 15 34 d8 7d 7e f7 c2
RSP: 0000:ffffc900027af718 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 000000000527b200 RCX: 1ffff920004f5f3b
RDX: ffff88801fedd700 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900027af910 R08: ffffffff81ae7f47 R09: fffff9400032db5f
R10: fffff9400032db5f R11: 0000000000000000 R12: 000000000527b200
R13: ffffea000196daf4 R14: 0000000000000005 R15: 0000000000000000
 filemap_read+0xefc/0x10f0 mm/filemap.c:2712
 call_read_iter include/linux/fs.h:2156 [inline]
 generic_file_splice_read+0x482/0x760 fs/splice.c:311
 do_splice_to fs/splice.c:796 [inline]
 splice_direct_to_actor+0x45f/0xd00 fs/splice.c:870
 do_splice_direct+0x291/0x3e0 fs/splice.c:979
 do_sendfile+0x6fe/0x1040 fs/read_write.c:1245
 __do_sys_sendfile64 fs/read_write.c:1310 [inline]
 __se_sys_sendfile64+0x171/0x1d0 fs/read_write.c:1296
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fba2f2d9169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd26096738 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007fba2f2d9169
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 00008400fffffffb R11: 0000000000000246 R12: 000000000007bd28
R13: 00007ffd2609674c R14: 00007ffd26096760 R15: 00007ffd26096750
 </TASK>
----------------
Code disassembly (best guess):
   0:	41 89 f6             	mov    %esi,%r14d
   3:	48 89 fb             	mov    %rdi,%rbx
   6:	65 48 8b 04 25 28 00 	mov    %gs:0x28,%rax
   d:	00 00
   f:	48 89 84 24 00 01 00 	mov    %rax,0x100(%rsp)
  16:	00
  17:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
  1e:	fc ff df
  21:	48 c7 44 24 40 b3 8a 	movq   $0x41b58ab3,0x40(%rsp)
  28:	b5 41
* 2a:	48 c7 44 24 48 b2 5c 	movq   $0xffffffff8c3e5cb2,0x48(%rsp) <-- trapping instruction
  31:	3e 8c
  33:	48 c7 44 24 50 30 f8 	movq   $0xffffffff8165f830,0x50(%rsp)
  3a:	65 81
  3c:	4c                   	rex.WR
  3d:	8d                   	.byte 0x8d
  3e:	6c                   	insb   (%dx),%es:(%rdi)
  3f:	24                   	.byte 0x24


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
