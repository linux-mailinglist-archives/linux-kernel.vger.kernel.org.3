Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356065839C5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 09:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbiG1HqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 03:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbiG1HqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 03:46:19 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F7361105
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 00:46:18 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id d6-20020a056e020be600b002dcc7977592so846788ilu.17
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 00:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QENFiaom95YXkBTwXdB0cIRb1TB2At9pqqwqWohjkQo=;
        b=VhVSVXbeEZQoI0Ty1OprfttTkdmS+wHeTQz4sjMFu+0RE6HuhmOaaKnYZuba+iFFz/
         n8I5fl8OlK6lqUbVSLrQ1bQvCzUGhYkhj4bbBAGo/SdjJOvQMKPn3nF86KwqQ6iAA9bG
         +jXY3xdKfiNz5NLWySOq455NfQb0vI2w3jHXPLXXN31WgVnF9mGpa5sZ0pJjs5rcUNuE
         EnQOKLWZhwxjDop01QUdKRBdiJ8NwVaglMwz6ryM6KazxS338Oilqj/4PjOwTemCHy1s
         5T9NdKUp2kyTJE1ZhdImLz7HDwr4SnS/3pst1ncZpTdb3i00SvD2cNwvfEvY5DUtZ7b7
         QTHQ==
X-Gm-Message-State: AJIora+ooizJ0MshQsV3ywWtO9HIc5G9Tv5j2+L3EpKmvaxy4LXpPLSQ
        +E+ZjaxtUhN2oaFobPMEkfyHMIqu6Kf4xa2YFqxI4WEvQL4O
X-Google-Smtp-Source: AGRyM1vLjqmxXTG/og80gpB0Yi3+KkUwCuSW3+Ieb3RSRnEs5M253lmmdyZjho0FATFItcVAXPR+1AmRAcBU9j4BzD+ckGS7fuzI
MIME-Version: 1.0
X-Received: by 2002:a05:6638:41a0:b0:33f:f7e4:c3eb with SMTP id
 az32-20020a05663841a000b0033ff7e4c3ebmr10528537jab.82.1658994377678; Thu, 28
 Jul 2022 00:46:17 -0700 (PDT)
Date:   Thu, 28 Jul 2022 00:46:17 -0700
In-Reply-To: <20220728073322.731-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000090e87205e4d8ba49@google.com>
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
INFO: rcu detected stall in net_tx_action

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (1 GPs behind) idle=a16/1/0x4000000000000000 softirq=8550/8551 fqs=1 
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1):
	(detected by 1, t=10843 jiffies, g=10157, q=515)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 13 Comm: ksoftirqd/0 Not tainted 5.14.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
RIP: 0010:__lock_acquire+0xc1e/0x54a0 kernel/locking/lockdep.c:5003
Code: 80 3c 02 00 0f 85 75 45 00 00 48 83 7b 40 00 0f 84 c6 0c 00 00 0f b7 44 24 10 8b 4c 24 40 8b 5c 24 50 c1 e0 0d 66 0b 44 24 08 <98> 2b 44 24 60 33 44 24 58 89 c2 29 c1 01 d8 c1 c2 06 31 ca 41 89
RSP: 0018:ffffc90000007ba0 EFLAGS: 00000006
RAX: 0000000000004028 RBX: 00000000fffffffe RCX: 00000000ffffffff
RDX: 1ffffffff1f97760 RSI: 0000000000000008 RDI: ffffffff8fcbbb00
RBP: 0000000000000002 R08: 0000000000000000 R09: ffffffff8fcb98a7
R10: fffffbfff1f97314 R11: 0000000000000000 R12: ffff888010a60a40
R13: ffff888010a60000 R14: 0000000000000001 R15: 96c8533605eb7aa2
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000051e370 CR3: 000000000b68e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 lock_acquire kernel/locking/lockdep.c:5625 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
 rcu_lock_acquire include/linux/rcupdate.h:267 [inline]
 rcu_read_lock include/linux/rcupdate.h:687 [inline]
 advance_sched+0x4a5/0x9a0 net/sched/sch_taprio.c:763
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 __hrtimer_run_queues+0x609/0xe50 kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1089 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1106
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1100
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:arch_safe_halt arch/x86/include/asm/irqflags.h:90 [inline]
RIP: 0010:kvm_wait arch/x86/kernel/kvm.c:888 [inline]
RIP: 0010:kvm_wait+0xaf/0xf0 arch/x86/kernel/kvm.c:871
Code: 10 c3 c3 89 74 24 0c 48 89 3c 24 e8 9b b6 48 00 8b 74 24 0c 48 8b 3c 24 eb 82 e8 ac bb 48 00 eb 07 0f 00 2d d3 c5 55 08 fb f4 <eb> 9b eb 07 0f 00 2d c6 c5 55 08 f4 eb c5 89 74 24 0c 48 89 3c 24
RSP: 0018:ffffc90000d27c80 EFLAGS: 00000206
RAX: 0000000000052272 RBX: 0000000000000000 RCX: 1ffffffff1f9ff22
RDX: 0000000000000000 RSI: 0000000000000101 RDI: 0000000000000000
RBP: ffff88802150a8f0 R08: 0000000000000001 R09: ffffffff8fcb995f
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: ffffed10042a151e R14: 0000000000000001 R15: ffff8880b9c36880
 pv_wait arch/x86/include/asm/paravirt.h:597 [inline]
 pv_wait_head_or_lock kernel/locking/qspinlock_paravirt.h:470 [inline]
 __pv_queued_spin_lock_slowpath+0x8b8/0xb40 kernel/locking/qspinlock.c:508
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:585 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:85 [inline]
 do_raw_spin_lock+0x200/0x2b0 kernel/locking/spinlock_debug.c:113
 spin_lock include/linux/spinlock.h:354 [inline]
 net_tx_action+0x3d8/0xdc0 net/core/dev.c:5083
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 run_ksoftirqd kernel/softirq.c:920 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:912
 smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
task:udevd           state:R  running task     stack:26800 pid: 4876 ppid:     1 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:4681 [inline]
 __schedule+0x93a/0x26f0 kernel/sched/core.c:5938
 preempt_schedule_common+0x45/0xc0 kernel/sched/core.c:6098
 preempt_schedule_thunk+0x16/0x18 arch/x86/entry/thunk_64.S:35
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:161 [inline]
 _raw_spin_unlock_irqrestore+0x57/0x70 kernel/locking/spinlock.c:191
 spin_unlock_irqrestore include/linux/spinlock.h:409 [inline]
 __wake_up_common_lock+0xde/0x130 kernel/sched/wait.c:140
 sock_def_readable+0xec/0x4e0 net/core/sock.c:3015
 __netlink_sendskb net/netlink/af_netlink.c:1261 [inline]
 netlink_sendskb net/netlink/af_netlink.c:1267 [inline]
 netlink_unicast+0x6d1/0x7d0 net/netlink/af_netlink.c:1355
 netlink_sendmsg+0x86d/0xdb0 net/netlink/af_netlink.c:1929
 sock_sendmsg_nosec net/socket.c:703 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:723
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2392
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2446
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2475
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f2ca7a61163
RSP: 002b:00007ffe2cbdf988 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 000055833d861d50 RCX: 00007f2ca7a61163
RDX: 0000000000000000 RSI: 00007ffe2cbdf998 RDI: 0000000000000004
RBP: 000055833d88a300 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000020 R11: 0000000000000246 R12: 0000000000000000
R13: 00000000000000a6 R14: 0000000000000000 R15: 0000000000000000
rcu: rcu_preempt kthread timer wakeup didn't happen for 10820 jiffies! g10157 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: 	Possible timer handling issue on cpu=1 timer-softirq=3021
rcu: rcu_preempt kthread starved for 10821 jiffies! g10157 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:29544 pid:   14 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4681 [inline]
 __schedule+0x93a/0x26f0 kernel/sched/core.c:5938
 schedule+0xd3/0x270 kernel/sched/core.c:6017
 schedule_timeout+0x14a/0x2a0 kernel/time/timer.c:1881
 rcu_gp_fqs_loop kernel/rcu/tree.c:1996 [inline]
 rcu_gp_kthread+0xd34/0x1980 kernel/rcu/tree.c:2169
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
rcu: Stack dump where RCU GP kthread last ran:
NMI backtrace for cpu 1
CPU: 1 PID: 6025 Comm: syz-executor.0 Not tainted 5.14.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_check_gp_kthread_starvation.cold+0x1d1/0x1d6 kernel/rcu/tree_stall.h:481
 print_other_cpu_stall kernel/rcu/tree_stall.h:586 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:711 [inline]
 rcu_pending kernel/rcu/tree.c:3922 [inline]
 rcu_sched_clock_irq+0x1ee0/0x2190 kernel/rcu/tree.c:2641
 update_process_times+0x16d/0x200 kernel/time/timer.c:1785
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:226
 tick_sched_timer+0x1b0/0x2d0 kernel/time/tick-sched.c:1421
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 __hrtimer_run_queues+0x1c0/0xe50 kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1089 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1106
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1100
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:161 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:191
Code: 74 24 10 e8 0a 0d 2e f8 48 89 ef e8 b2 82 2e f8 81 e3 00 02 00 00 75 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> 73 60 22 f8 65 8b 05 7c d8 d4 76 85 c0 74 0a 5b 5d c3 e8 40 ca
RSP: 0018:ffffc90001f6f260 EFLAGS: 00000206
RAX: 0000000000000002 RBX: 0000000000000200 RCX: 1ffffffff1f9ff22
RDX: 0000000000000000 RSI: 0000000000000202 RDI: 0000000000000001
RBP: ffff8880b9c263c0 R08: 0000000000000001 R09: ffffffff8fcb995f
R10: 0000000000000001 R11: 0000000000000000 R12: 00000000ffffffff
R13: 0000000000000246 R14: ffff8880b9c265c0 R15: dffffc0000000000
 unlock_hrtimer_base kernel/time/hrtimer.c:1017 [inline]
 hrtimer_try_to_cancel kernel/time/hrtimer.c:1336 [inline]
 hrtimer_try_to_cancel+0x14e/0x1e0 kernel/time/hrtimer.c:1316
 hrtimer_cancel+0x13/0x40 kernel/time/hrtimer.c:1443
 taprio_reset+0x72/0x280 net/sched/sch_taprio.c:1622
 qdisc_reset+0xdb/0x730 net/sched/sch_generic.c:977
 dev_reset_queue+0x92/0x130 net/sched/sch_generic.c:1228
 netdev_for_each_tx_queue include/linux/netdevice.h:2337 [inline]
 dev_deactivate_many+0x51c/0xc40 net/sched/sch_generic.c:1294
 dev_deactivate+0xe9/0x1b0 net/sched/sch_generic.c:1317
 qdisc_graft+0xdac/0x1260 net/sched/sch_api.c:1055
 tc_modify_qdisc+0xba4/0x1a60 net/sched/sch_api.c:1674
 rtnetlink_rcv_msg+0x413/0xb80 net/core/rtnetlink.c:5574
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2504
 netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1340
 netlink_sendmsg+0x86d/0xdb0 net/netlink/af_netlink.c:1929
 sock_sendmsg_nosec net/socket.c:703 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:723
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2392
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2446
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2475
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665d9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2cc6289188 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665d9
RDX: 0000000000000000 RSI: 00000000200007c0 RDI: 0000000000000004
RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffede22787f R14: 00007f2cc6289300 R15: 0000000000022000


Tested on:

commit:         f80e2148 hrtimer: Unbreak hrtimer_force_reprogram()
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10e6b35a080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=31eef52c6517a0c2
dashboard link: https://syzkaller.appspot.com/bug?extid=3ba0493d523d007b3819
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=136e177e080000

