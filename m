Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C415835FD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 02:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbiG1A1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 20:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiG1A1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 20:27:14 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893D851436
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 17:27:08 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id z2-20020a056e02088200b002dc4022c15fso272403ils.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 17:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+X/eaN9dDXHI4RvFIoPuFLYmspfbPTET/XGjO4+q/e8=;
        b=vCgiyyZXvGu+UPKZEcOcNcPu+2GX0/PpvEY38te8+ycoFAL35hX7HYSM+5qB5I0Mp8
         k2o8PU7l1eyRA6vX5brktuEVTvRG4JzxLARe77ZhxQbH7r1lt73xrCOCQVhTqWWWUCcC
         6p9AHoWnWxqr6SOv0jyU2hZKu8VZnx+PfhP8iweifsu0iVKQMk99zlCEYqbiLmumKGFR
         J2R1RG+K90H9kDdOD51mb/DXiL/KtD+GA2qHvaHy70kyu2Br7M945MgSnqH8m8x1DQaV
         q2Rsnn7XlmhpMhTEPLAkRc3sizdw83mi967CMQWKe1rcPyYErnIETSeU+BGG/W9bGqMR
         Lxag==
X-Gm-Message-State: AJIora/3T+CLHeZ6ge8RfDTUcrzRuUtNiexG1nbDjk6WLuJXkf2MWyyp
        AK9+tf4brb7hnOQmouICO9q0h3wrwd00YfuN693j7kfGaLQ4
X-Google-Smtp-Source: AGRyM1u8IKYrKyS74Q+f5frpMWabP12byeiV/GJ4Za5+ItHzIRVtZ7/O7s9MIPjWhF3jgLJ0kxfjmtdDGe6ZoRPcetfoO9WVgHy1
MIME-Version: 1.0
X-Received: by 2002:a92:c56a:0:b0:2dd:8248:1eab with SMTP id
 b10-20020a92c56a000000b002dd82481eabmr4921183ilj.27.1658968027936; Wed, 27
 Jul 2022 17:27:07 -0700 (PDT)
Date:   Wed, 27 Jul 2022 17:27:07 -0700
In-Reply-To: <20220728001258.311-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ffbf5205e4d297e0@google.com>
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
INFO: rcu detected stall in tc_modify_qdisc

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-...!: (11 ticks this GP) idle=1ba/1/0x4000000000000000 softirq=8504/8504 fqs=0 
	(t=13199 jiffies g=9753 q=157)
rcu: rcu_preempt kthread timer wakeup didn't happen for 13198 jiffies! g9753 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: 	Possible timer handling issue on cpu=1 timer-softirq=2661
rcu: rcu_preempt kthread starved for 13199 jiffies! g9753 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:29480 pid:   14 ppid:     2 flags:0x00004000
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
CPU: 1 PID: 5948 Comm: syz-executor.0 Not tainted 5.13.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_check_gp_kthread_starvation.cold+0x1cc/0x1d1 kernel/rcu/tree_stall.h:480
 print_cpu_stall kernel/rcu/tree_stall.h:624 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:701 [inline]
 rcu_pending kernel/rcu/tree.c:3911 [inline]
 rcu_sched_clock_irq.cold+0x9a/0x747 kernel/rcu/tree.c:2649
 update_process_times+0x16d/0x200 kernel/time/timer.c:1796
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:226
 tick_sched_timer+0x1b0/0x2d0 kernel/time/tick-sched.c:1374
 __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
 __hrtimer_run_queues+0x1c0/0xe40 kernel/time/hrtimer.c:1601
 hrtimer_interrupt+0x330/0xa00 kernel/time/hrtimer.c:1663
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1089 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x540 arch/x86/kernel/apic/apic.c:1106
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1100
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:647
RIP: 0010:check_kcov_mode kernel/kcov.c:163 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x7/0x60 kernel/kcov.c:197
Code: ff ff b9 ff ff ff ff ba 08 00 00 00 4d 8b 03 48 0f bd ca 49 8b 45 00 48 63 c9 e9 64 ff ff ff 0f 1f 40 00 65 8b 05 59 15 8d 7e <89> c1 48 8b 34 24 81 e1 00 01 00 00 65 48 8b 14 25 00 f0 01 00 a9
RSP: 0018:ffffc900018af270 EFLAGS: 00000202
RAX: 0000000000000201 RBX: ffff8880157ca340 RCX: 0000000000000000
RDX: 0000000000000202 RSI: 0000000000000202 RDI: 0000000000000001
RBP: ffff8880b9c26580 R08: 0000000000000001 R09: ffffffff8fa2895f
R10: 0000000000000001 R11: 0000000000000000 R12: 00000000ffffffff
R13: 0000000000000246 R14: ffff8880b9c26580 R15: dffffc0000000000
 hrtimer_try_to_cancel+0x36/0x1e0 kernel/time/hrtimer.c:1180
 hrtimer_cancel+0x13/0x40 kernel/time/hrtimer.c:1295
 taprio_reset+0x72/0x280 net/sched/sch_taprio.c:1656
 qdisc_reset+0xdb/0x730 net/sched/sch_generic.c:951
 dev_reset_queue+0x92/0x120 net/sched/sch_generic.c:1202
 netdev_for_each_tx_queue include/linux/netdevice.h:2337 [inline]
 dev_deactivate_many+0x551/0xc30 net/sched/sch_generic.c:1267
 dev_deactivate+0xe9/0x1b0 net/sched/sch_generic.c:1290
 qdisc_graft+0xdc1/0x1260 net/sched/sch_api.c:1055
 tc_modify_qdisc+0xb5a/0x1a50 net/sched/sch_api.c:1674
 rtnetlink_rcv_msg+0x44e/0xad0 net/core/rtnetlink.c:5566
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2504
 netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1340
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1929
 sock_sendmsg_nosec net/socket.c:654 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:674
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2337
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2391
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2420
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665d9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f74e9479188 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665d9
RDX: 0000000000000000 RSI: 00000000200007c0 RDI: 0000000000000004
RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffe32f717ef R14: 00007f74e9479300 R15: 0000000000022000
NMI backtrace for cpu 1
CPU: 1 PID: 5948 Comm: syz-executor.0 Not tainted 5.13.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_dump_cpu_stacks+0x25e/0x3f0 kernel/rcu/tree_stall.h:343
 print_cpu_stall kernel/rcu/tree_stall.h:626 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:701 [inline]
 rcu_pending kernel/rcu/tree.c:3911 [inline]
 rcu_sched_clock_irq.cold+0x9f/0x747 kernel/rcu/tree.c:2649
 update_process_times+0x16d/0x200 kernel/time/timer.c:1796
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:226
 tick_sched_timer+0x1b0/0x2d0 kernel/time/tick-sched.c:1374
 __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
 __hrtimer_run_queues+0x1c0/0xe40 kernel/time/hrtimer.c:1601
 hrtimer_interrupt+0x330/0xa00 kernel/time/hrtimer.c:1663
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1089 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x540 arch/x86/kernel/apic/apic.c:1106
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1100
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:647
RIP: 0010:check_kcov_mode kernel/kcov.c:163 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x7/0x60 kernel/kcov.c:197
Code: ff ff b9 ff ff ff ff ba 08 00 00 00 4d 8b 03 48 0f bd ca 49 8b 45 00 48 63 c9 e9 64 ff ff ff 0f 1f 40 00 65 8b 05 59 15 8d 7e <89> c1 48 8b 34 24 81 e1 00 01 00 00 65 48 8b 14 25 00 f0 01 00 a9
RSP: 0018:ffffc900018af270 EFLAGS: 00000202
RAX: 0000000000000201 RBX: ffff8880157ca340 RCX: 0000000000000000
RDX: 0000000000000202 RSI: 0000000000000202 RDI: 0000000000000001
RBP: ffff8880b9c26580 R08: 0000000000000001 R09: ffffffff8fa2895f
R10: 0000000000000001 R11: 0000000000000000 R12: 00000000ffffffff
R13: 0000000000000246 R14: ffff8880b9c26580 R15: dffffc0000000000
 hrtimer_try_to_cancel+0x36/0x1e0 kernel/time/hrtimer.c:1180
 hrtimer_cancel+0x13/0x40 kernel/time/hrtimer.c:1295
 taprio_reset+0x72/0x280 net/sched/sch_taprio.c:1656
 qdisc_reset+0xdb/0x730 net/sched/sch_generic.c:951
 dev_reset_queue+0x92/0x120 net/sched/sch_generic.c:1202
 netdev_for_each_tx_queue include/linux/netdevice.h:2337 [inline]
 dev_deactivate_many+0x551/0xc30 net/sched/sch_generic.c:1267
 dev_deactivate+0xe9/0x1b0 net/sched/sch_generic.c:1290
 qdisc_graft+0xdc1/0x1260 net/sched/sch_api.c:1055
 tc_modify_qdisc+0xb5a/0x1a50 net/sched/sch_api.c:1674
 rtnetlink_rcv_msg+0x44e/0xad0 net/core/rtnetlink.c:5566
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2504
 netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1340
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1929
 sock_sendmsg_nosec net/socket.c:654 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:674
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2337
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2391
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2420
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665d9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f74e9479188 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665d9
RDX: 0000000000000000 RSI: 00000000200007c0 RDI: 0000000000000004
RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffe32f717ef R14: 00007f74e9479300 R15: 0000000000022000


Tested on:

commit:         d6765985 Revert "be2net: disable bh with spin_lock in ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=174b2102080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d43f3e8616689bf
dashboard link: https://syzkaller.appspot.com/bug?extid=3ba0493d523d007b3819
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1648beee080000

