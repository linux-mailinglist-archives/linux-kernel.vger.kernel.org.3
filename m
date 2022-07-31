Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC0F585E58
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 11:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbiGaJxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 05:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiGaJxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 05:53:14 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BD21208F
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 02:53:13 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id z17-20020a921a51000000b002ddff313ab2so4492699ill.12
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 02:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=xrZO3RqvZcAg6WQvrKuP/dMDeLx2y1YDe0jGY57o98I=;
        b=KXpww6BDUlb6Ol1RsqXsdOTgY5dADgyi40wxO78SCbIUFNqdxT+HXcne//hxhdaOpn
         qkEQJc7hBaa+Pqq8SzDgqkAFzF2Ry4+0wV1RHQBv7kXOABPVcvMF+wEHphs3GDOznLY9
         SSQ4eVYtjr11ttHDIq8FhmCL0Bt0frMEHXpNHGMWp2olAh9GaF4xZoby9T/JGS1QIo9I
         E1LltyVyC+bJ9/c19jN5046BQAtGpbgQSIgR1Y6v8BEPo68ffp21aKCdevdIFsw0p0iE
         8nfhfVdrb5+26sjWQGOkzG5QVmETXcezwyFYJDy4ActRnV9E3TWmCdtUTN/BGbz9dCf1
         WPmg==
X-Gm-Message-State: AJIora9/637y7oSVCGJaQmIevXMseMWXB96jLCgUKaC8hQxCn4AjjDaX
        /7dFruai4Zsmsnr/EB/+/9EjbfwOuFTN+vj49DxzTzXeexe+
X-Google-Smtp-Source: AGRyM1vMhwWJU3PqXwFatkDu+fp1NG9KCXgQq2GnQK+urHKDYmHBU50J3Cytj/9mmx9zXlWCgSxPIFudxQYdVG2Kxkb5AH6qtbJ5
MIME-Version: 1.0
X-Received: by 2002:a92:ce81:0:b0:2dc:fbec:d023 with SMTP id
 r1-20020a92ce81000000b002dcfbecd023mr4198738ilo.155.1659261192953; Sun, 31
 Jul 2022 02:53:12 -0700 (PDT)
Date:   Sun, 31 Jul 2022 02:53:12 -0700
In-Reply-To: <20220731093631.791-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fee77f05e516d97b@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in __hrtimer_run_queues
From:   syzbot <syzbot+de9526ade17c659d8336@syzkaller.appspotmail.com>
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
INFO: rcu detected stall in addrconf_rs_timer

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-...!: (1 GPs behind) idle=7ee/1/0x4000000000000000 softirq=10587/10593 fqs=0 
	(t=10501 jiffies g=12037 q=817)
rcu: rcu_preempt kthread starved for 10502 jiffies! g12037 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28888 pid:   13 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4327 [inline]
 __schedule+0x90c/0x21a0 kernel/sched/core.c:5078
 schedule+0xcf/0x270 kernel/sched/core.c:5157
 schedule_timeout+0x148/0x250 kernel/time/timer.c:1878
 rcu_gp_fqs_loop kernel/rcu/tree.c:1940 [inline]
 rcu_gp_kthread+0xbbe/0x1d70 kernel/rcu/tree.c:2113
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
NMI backtrace for cpu 1
CPU: 1 PID: 6327 Comm: syz-executor.5 Not tainted 5.11.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_dump_cpu_stacks+0x1f4/0x230 kernel/rcu/tree_stall.h:337
 print_cpu_stall kernel/rcu/tree_stall.h:569 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:643 [inline]
 rcu_pending kernel/rcu/tree.c:3751 [inline]
 rcu_sched_clock_irq.cold+0x48e/0xedf kernel/rcu/tree.c:2580
 update_process_times+0x16d/0x200 kernel/time/timer.c:1782
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:226
 tick_sched_timer+0x1b0/0x2d0 kernel/time/tick-sched.c:1369
 __run_hrtimer kernel/time/hrtimer.c:1521 [inline]
 __hrtimer_run_queues+0x68d/0xea0 kernel/time/hrtimer.c:1588
 hrtimer_interrupt+0x334/0x940 kernel/time/hrtimer.c:1650
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1089 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x540 arch/x86/kernel/apic/apic.c:1106
 run_sysvec_on_irqstack_cond arch/x86/include/asm/irq_stack.h:91 [inline]
 sysvec_apic_timer_interrupt+0x48/0x100 arch/x86/kernel/apic/apic.c:1100
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:629
RIP: 0010:ndisc_send_skb+0x150/0x1750 net/ipv6/ndisc.c:475
Code: 00 0f 85 b8 14 00 00 4c 8b b9 98 05 00 00 48 ba 00 00 00 00 00 fc ff df 49 8d bf 08 0d 00 00 48 89 fe 48 c1 ee 03 80 3c 16 00 <0f> 85 77 14 00 00 49 8b 87 08 0d 00 00 48 ba 00 00 00 00 00 fc ff
RSP: 0018:ffffc90000db0aa0 EFLAGS: 00000246
RAX: ffff88803d517790 RBX: ffffc90000db0ce0 RCX: ffff88803acf0000
RDX: dffffc0000000000 RSI: 1ffff11004ff7cc9 RDI: ffff888027fbe648
RBP: ffffc90000db0c40 R08: 0000000000000000 R09: ffff88803c69ac47
R10: ffffffff87b1bfba R11: 0000000000000020 R12: ffff88803d517780
R13: 0000000000000000 R14: 0000000000000000 R15: ffff888027fbd940
 ndisc_send_rs+0x12e/0x700 net/ipv6/ndisc.c:702
 addrconf_rs_timer+0x3f2/0x820 net/ipv6/addrconf.c:3875
 call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1417
 expire_timers kernel/time/timer.c:1462 [inline]
 __run_timers.part.0+0x67c/0xa50 kernel/time/timer.c:1731
 __run_timers kernel/time/timer.c:1712 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1744
 __do_softirq+0x29b/0x9f6 kernel/softirq.c:343
 asm_call_irq_on_stack+0xf/0x20
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
 do_softirq_own_stack+0xaa/0xd0 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:226 [inline]
 __irq_exit_rcu kernel/softirq.c:420 [inline]
 irq_exit_rcu+0x134/0x200 kernel/softirq.c:432
 sysvec_apic_timer_interrupt+0x4d/0x100 arch/x86/kernel/apic/apic.c:1100
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:629
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:169 [inline]
RIP: 0010:_raw_spin_unlock_irq+0x25/0x40 kernel/locking/spinlock.c:199
Code: 0f 1f 44 00 00 55 48 8b 74 24 08 48 89 fd 48 83 c7 18 e8 5e e7 5b f8 48 89 ef e8 06 9c 5c f8 e8 f1 bf 7b f8 fb bf 01 00 00 00 <e8> 46 a3 50 f8 65 8b 05 3f 09 05 77 85 c0 74 02 5d c3 e8 cb 5e 03
RSP: 0018:ffffc9000180fc58 EFLAGS: 00000206
RAX: 00000000000000d7 RBX: 0000000000000001 RCX: 1ffffffff1a06a29
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
RBP: ffff8880b9f34c40 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8178a698 R11: 0000000000000000 R12: ffff8880b9f34c40
R13: ffff88801cbbb780 R14: 0000000000000000 R15: ffff888021123780
 finish_lock_switch kernel/sched/core.c:4079 [inline]
 finish_task_switch.isra.0+0x158/0x7e0 kernel/sched/core.c:4196
 context_switch kernel/sched/core.c:4330 [inline]
 __schedule+0x914/0x21a0 kernel/sched/core.c:5078
 preempt_schedule_common+0x45/0xc0 kernel/sched/core.c:5238
 preempt_schedule_thunk+0x16/0x18 arch/x86/entry/thunk_64.S:35
 __raw_spin_unlock include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock+0x36/0x40 kernel/locking/spinlock.c:183
 spin_unlock include/linux/spinlock.h:394 [inline]
 setfl fs/fcntl.c:81 [inline]
 do_fcntl+0x6da/0x1070 fs/fcntl.c:347
 __do_sys_fcntl fs/fcntl.c:463 [inline]
 __se_sys_fcntl fs/fcntl.c:448 [inline]
 __x64_sys_fcntl+0x165/0x1e0 fs/fcntl.c:448
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x465d99
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff3a2a3a188 EFLAGS: 00000246 ORIG_RAX: 0000000000000048
RAX: ffffffffffffffda RBX: 000000000056bf60 RCX: 0000000000465d99
RDX: 0000000000042000 RSI: 0000000000000004 RDI: 0000000000000003
RBP: 00000000004bcf27 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf60
R13: 00007fff0360150f R14: 00007ff3a2a3a300 R15: 0000000000022000
On CPU1 hrtimer tick_sched_timer took more than 4 ticks


Tested on:

commit:         f40ddce8 Linux 5.11
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=139e281e080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3565439810a4d2e5
dashboard link: https://syzkaller.appspot.com/bug?extid=de9526ade17c659d8336
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16cd4ed2080000

