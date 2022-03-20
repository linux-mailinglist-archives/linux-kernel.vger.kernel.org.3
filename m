Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5517F4E1B63
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 13:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244971AbiCTMDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 08:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242916AbiCTMDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 08:03:46 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C8B20F70
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 05:02:23 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id k10-20020a5d91ca000000b006414a00b160so8631437ior.18
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 05:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2Htu79DAF0Z3VKJOAnt5px/PvuS1hndUGXXYC/3cTaI=;
        b=63QFKdBhcrUIJBTq7fc2FrshEpBYEn+qbpQTfH0zUgDciH22iLGN75gHs29i1rS/mP
         /bRbJHqRFRnm2+EPWW/PdsDct7I+6QTNfFL0mppoOXtkMaDqGceAB1zUvQIAS1wxF93q
         C3RtWv7eqz9F8znf998XsfyQvrlLgtFlx1eydvlcoIqCBROHPVmXvGklKbllq3rjOBDD
         OlYe13/Vy7WN/B+2EoZQjLpbZ3CJFknlRVr9dfsERdnbsS1CtBFVv6kqO058XlnsL5Dn
         w3daocfSVDBMgiHkUzYticWSVSO0hNc3gFTkNhUxfMoC7D7hLkTWUa1qn5uZYlWujJIF
         oR9w==
X-Gm-Message-State: AOAM531K6Iy1fXlpwdVtTDBK1iTyVXgN5I0GHkHFSXhSV7dAbJ+9G811
        AvWMAYHbdGMpSm+D+YcYNtCixF0yhWu+udOuT1g92HM4vXtm
X-Google-Smtp-Source: ABdhPJxrjWgBP1sgiuOFT/Hn0NL9pmgWcfe4ZqepPTkT5UpNigMGZGULVS7WfMmASM4gXYILZ7BrHVtPSJzxtHokDQtjku+96KiI
MIME-Version: 1.0
X-Received: by 2002:a05:6638:34a4:b0:31a:8383:3002 with SMTP id
 t36-20020a05663834a400b0031a83833002mr4921110jal.96.1647777743125; Sun, 20
 Mar 2022 05:02:23 -0700 (PDT)
Date:   Sun, 20 Mar 2022 05:02:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c439a05daa527cb@google.com>
Subject: [syzbot] INFO: rcu detected stall in gc_worker (3)
From:   syzbot <syzbot+eec403943a2a2455adaa@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
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

syzbot found the following issue on:

HEAD commit:    91265a6da44d Add linux-next specific files for 20220303
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=157605d5700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=617f79440a35673a
dashboard link: https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143195d9700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170736a9700000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=141bc691700000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=161bc691700000
console output: https://syzkaller.appspot.com/x/log.txt?x=121bc691700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eec403943a2a2455adaa@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (1 GPs behind) idle=a59/1/0x4000000000000000 softirq=5468/5472 fqs=5 
	(detected by 1, t=10502 jiffies, g=4825, q=140)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 3644 Comm: kworker/0:1 Not tainted 5.17.0-rc6-next-20220303-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_power_efficient gc_worker
RIP: 0010:hlock_class kernel/locking/lockdep.c:240 [inline]
RIP: 0010:__lock_acquire+0x1460/0x56c0 kernel/locking/lockdep.c:5056
Code: 0f b7 db be 08 00 00 00 48 89 d8 48 c1 f8 06 48 8d 3c c5 80 59 01 90 e8 fe 54 67 00 48 0f a3 1d f6 ed a3 0e 0f 83 2c 06 00 00 <48> 8d 1c 5b 48 c1 e3 06 48 81 c3 a0 5d 01 90 48 8d 7b 40 48 b8 00
RSP: 0018:ffffc90000007be0 EFLAGS: 00000047
RAX: 0000000000000001 RBX: 0000000000000029 RCX: ffffffff815d6b82
RDX: fffffbfff2002b31 RSI: 0000000000000008 RDI: ffffffff90015980
RBP: ffff88801bc4a842 R08: 0000000000000000 R09: ffffffff90015987
R10: fffffbfff2002b30 R11: 0000000000000001 R12: ffff88801bc4a820
R13: ffff88801bc49d40 R14: 0000000000000001 R15: 3d0b7b89c89fff91
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000600 CR3: 0000000076bbe000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 lock_acquire kernel/locking/lockdep.c:5672 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5637
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0x32/0x50 kernel/locking/spinlock.c:170
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x243/0xe50 kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1103
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:27 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:166 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x60 kernel/kcov.c:200
Code: 48 89 ef 5d e9 51 f3 4a 00 5d be 03 00 00 00 e9 96 96 74 02 66 0f 1f 44 00 00 48 8b be b0 01 00 00 e8 b4 ff ff ff 31 c0 c3 90 <65> 8b 05 29 49 89 7e 89 c1 48 8b 34 24 81 e1 00 01 00 00 65 48 8b
RSP: 0018:ffffc90003ccfc30 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
RDX: ffff88801bc49d40 RSI: ffffffff87821df7 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff90015a17
R10: ffffffff87821ded R11: 0000000000000001 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000040000 R15: 0000000000040000
 __seqprop_spinlock_sequence include/linux/seqlock.h:277 [inline]
 nf_conntrack_get_ht include/net/netfilter/nf_conntrack.h:331 [inline]
 gc_worker+0x24d/0x12b0 net/netfilter/nf_conntrack_core.c:1441
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.570 msecs
rcu: rcu_preempt kthread starved for 10492 jiffies! g4825 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28752 pid:   16 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5043 [inline]
 __schedule+0xa94/0x4910 kernel/sched/core.c:6352
 schedule+0xd2/0x1f0 kernel/sched/core.c:6424
 schedule_timeout+0x14a/0x2a0 kernel/time/timer.c:1881
 rcu_gp_fqs_loop+0x186/0x810 kernel/rcu/tree.c:1999
 rcu_gp_kthread+0x1de/0x320 kernel/rcu/tree.c:2172
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
NMI backtrace for cpu 1
CPU: 1 PID: 45 Comm: kworker/u4:2 Not tainted 5.17.0-rc6-next-20220303-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound toggle_allocation_gate
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1e6/0x230 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_check_gp_kthread_starvation.cold+0x1fb/0x200 kernel/rcu/tree_stall.h:516
 print_other_cpu_stall kernel/rcu/tree_stall.h:621 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:767 [inline]
 rcu_pending kernel/rcu/tree.c:3960 [inline]
 rcu_sched_clock_irq+0x21ae/0x22a0 kernel/rcu/tree.c:2660
 update_process_times+0x16d/0x200 kernel/time/timer.c:1785
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:243
 tick_sched_timer+0xee/0x120 kernel/time/tick-sched.c:1473
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 __hrtimer_run_queues+0x1c0/0xe50 kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1103
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:check_kcov_mode+0xf/0x40 kernel/kcov.c:166
Code: 7c 24 08 e8 b3 9b 4b 00 e9 61 fd ff ff cc cc cc cc cc cc cc cc cc cc cc cc cc cc 65 8b 05 79 4d 89 7e 89 c2 81 e2 00 01 00 00 <a9> 00 01 ff 00 74 10 31 c0 85 d2 74 15 8b 96 ac 15 00 00 85 d2 74
RSP: 0018:ffffc90000b679c8 EFLAGS: 00000246
RAX: 0000000000000001 RBX: ffff8880b9c42380 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffff888016df8000 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff816d99aa R11: 0000000000000000 R12: ffffed1017388471
R13: 0000000000000000 R14: ffff8880b9c42388 R15: 0000000000000001
 write_comp_data kernel/kcov.c:221 [inline]
 __sanitizer_cov_trace_const_cmp4+0x1c/0x70 kernel/kcov.c:287
 csd_lock_wait kernel/smp.c:443 [inline]
 smp_call_function_many_cond+0x50a/0xc90 kernel/smp.c:972
 on_each_cpu_cond_mask+0x56/0xa0 kernel/smp.c:1138
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:1146 [inline]
 text_poke_bp_batch+0x3e9/0x6b0 arch/x86/kernel/alternative.c:1387
 text_poke_flush arch/x86/kernel/alternative.c:1504 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:1501 [inline]
 text_poke_finish+0x16/0x30 arch/x86/kernel/alternative.c:1511
 arch_jump_label_transform_apply+0x13/0x20 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x32f/0x410 kernel/jump_label.c:830
 static_key_enable_cpuslocked+0x1b1/0x260 kernel/jump_label.c:177
 static_key_enable+0x16/0x20 kernel/jump_label.c:190
 toggle_allocation_gate mm/kfence/core.c:735 [inline]
 toggle_allocation_gate+0x100/0x390 mm/kfence/core.c:727
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
----------------
Code disassembly (best guess):
   0:	0f b7 db             	movzwl %bx,%ebx
   3:	be 08 00 00 00       	mov    $0x8,%esi
   8:	48 89 d8             	mov    %rbx,%rax
   b:	48 c1 f8 06          	sar    $0x6,%rax
   f:	48 8d 3c c5 80 59 01 	lea    -0x6ffea680(,%rax,8),%rdi
  16:	90
  17:	e8 fe 54 67 00       	callq  0x67551a
  1c:	48 0f a3 1d f6 ed a3 	bt     %rbx,0xea3edf6(%rip)        # 0xea3ee1a
  23:	0e
  24:	0f 83 2c 06 00 00    	jae    0x656
* 2a:	48 8d 1c 5b          	lea    (%rbx,%rbx,2),%rbx <-- trapping instruction
  2e:	48 c1 e3 06          	shl    $0x6,%rbx
  32:	48 81 c3 a0 5d 01 90 	add    $0xffffffff90015da0,%rbx
  39:	48 8d 7b 40          	lea    0x40(%rbx),%rdi
  3d:	48                   	rex.W
  3e:	b8                   	.byte 0xb8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
