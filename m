Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3C0582777
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbiG0NQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiG0NQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:16:23 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603873135E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:16:13 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id w7-20020a5d9607000000b0067c6030dfb8so5990192iol.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tDUmOqIspC2Qvnq1P0H65YAAKFcajj2fjV10PGnXz5U=;
        b=68AaybWkrSKvV1Ld5TsFfb2j/Fqj8b+Lwehy8sUqXhmmmUUN2OHR3ymad+qMSdav35
         VnR6nJ/O0VI+hKP7Sp7/F19Oqb/GLdAhBPeqpSALO1q5+1PUMYghb1HqHvObLd7hhrMi
         8C5nRBHeNzEy1P2q9MeBPqZiOcnbYjAfNMQz+Oxb/rGFLR0jnDBspGvDvKXMhxDqjOoh
         JqTf0CPVB9RIIJJHCcv2z7p9sZZsIBL2SqNhCUnzLy56YWY8wLdz6uVEEIiZ+zCifRXu
         9P9e8SH9PSPZCL8ivj1Tffs/nJZE6PRuIQweIyW0nnOlmdrQmTg21uPDM29tN/Rb7N1c
         ObPA==
X-Gm-Message-State: AJIora8RaqVXZ4YlqswwtnTLnSYPS0ZwYvJR/iEy5IeaP8CbP7pDR1JG
        pmOFwK2uqnmFhhK+c21LhxFQ6xyg5zTjr259ecWN+rhQQkND
X-Google-Smtp-Source: AGRyM1v7dH7vrbUgkHlJfMxcQOBrnLeI+Qt2GozQxrNU9IQ+vhyPW42IOWKh10bjRTyVdvhF6PE1P5SsOwUGgpJ3UiGCmrEMU93u
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2f03:b0:678:9c7c:97a5 with SMTP id
 q3-20020a0566022f0300b006789c7c97a5mr7599111iow.32.1658927772722; Wed, 27 Jul
 2022 06:16:12 -0700 (PDT)
Date:   Wed, 27 Jul 2022 06:16:12 -0700
In-Reply-To: <20220727130039.287-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000099eac805e4c9384a@google.com>
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
	(detected by 0, t=12253 jiffies, g=10185, q=161)
rcu: All QSes seen, last rcu_preempt kthread activity 12253 (4294958683-4294946430), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 12253 jiffies! g10185 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
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
NMI backtrace for cpu 0
CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.13.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Workqueue: events_power_efficient toggle_allocation_gate
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_check_gp_kthread_starvation.cold+0x1cc/0x1d1 kernel/rcu/tree_stall.h:478
 print_other_cpu_stall kernel/rcu/tree_stall.h:583 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:708 [inline]
 rcu_pending kernel/rcu/tree.c:3911 [inline]
 rcu_sched_clock_irq+0x1d46/0x2080 kernel/rcu/tree.c:2649
 update_process_times+0x16d/0x200 kernel/time/timer.c:1796
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:226
 tick_sched_timer+0x1b0/0x2d0 kernel/time/tick-sched.c:1374
 __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
 __hrtimer_run_queues+0x1c0/0xe40 kernel/time/hrtimer.c:1601
 hrtimer_interrupt+0x330/0xa00 kernel/time/hrtimer.c:1663
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1089 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x540 arch/x86/kernel/apic/apic.c:1106
 sysvec_apic_timer_interrupt+0x40/0xc0 arch/x86/kernel/apic/apic.c:1100
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:647
RIP: 0010:arch_safe_halt arch/x86/include/asm/irqflags.h:90 [inline]
RIP: 0010:kvm_wait arch/x86/kernel/kvm.c:888 [inline]
RIP: 0010:kvm_wait+0xb2/0x100 arch/x86/kernel/kvm.c:871
Code: 89 74 24 0c 48 89 3c 24 e8 3b 2c 48 00 8b 74 24 0c 48 8b 3c 24 eb 82 e8 5c 31 48 00 e9 07 00 00 00 0f 00 2d 90 10 36 08 fb f4 <eb> 98 e9 07 00 00 00 0f 00 2d 80 10 36 08 f4 eb bf 89 74 24 0c 48
RSP: 0018:ffffc90000007d88 EFLAGS: 00000206
RAX: 000000000003c406 RBX: 0000000000000000 RCX: 1ffffffff1f4ddb2
RDX: 0000000000000000 RSI: 0000000000000102 RDI: 0000000000000000
RBP: ffff8880301d08f0 R08: 0000000000000001 R09: ffffffff8fa2895f
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: ffffed100603a11e R14: 0000000000000001 R15: ffff8880b9c36400
 pv_wait arch/x86/include/asm/paravirt.h:597 [inline]
 pv_wait_head_or_lock kernel/locking/qspinlock_paravirt.h:470 [inline]
 __pv_queued_spin_lock_slowpath+0x8b8/0xb40 kernel/locking/qspinlock.c:508
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:585 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:85 [inline]
 do_raw_spin_lock+0x200/0x2b0 kernel/locking/spinlock_debug.c:113
 spin_lock include/linux/spinlock.h:354 [inline]
 net_tx_action+0x4c5/0xec0 net/core/dev.c:5050
 __do_softirq+0x29b/0x9f6 kernel/softirq.c:559
 invoke_softirq kernel/softirq.c:433 [inline]
 __irq_exit_rcu+0x136/0x200 kernel/softirq.c:637
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1100
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:647
RIP: 0010:__sanitizer_cov_trace_const_cmp4+0x6b/0x70 kernel/kcov.c:286
Code: 00 00 00 48 39 fe 72 22 44 89 c6 48 83 c2 01 48 89 4c 38 f0 48 c7 44 38 e0 05 00 00 00 48 89 74 38 e8 4e 89 54 c8 20 48 89 10 <c3> 0f 1f 40 00 49 89 f8 bf 03 00 00 00 4c 8b 14 24 48 89 f1 65 48
RSP: 0018:ffffc90000ca79f0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff8880b9d3aaa0 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffff888011b50000 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff8169a046 R11: 0000000000000000 R12: ffffed10173a7555
R13: 0000000000000001 R14: ffff8880b9d3aaa8 R15: 0000000000000001
 csd_lock_wait kernel/smp.c:440 [inline]
 smp_call_function_many_cond+0x476/0xc20 kernel/smp.c:967
 on_each_cpu_cond_mask+0x56/0xa0 kernel/smp.c:1133
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:929 [inline]
 text_poke_bp_batch+0x1b3/0x560 arch/x86/kernel/alternative.c:1114
 text_poke_flush arch/x86/kernel/alternative.c:1268 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:1265 [inline]
 text_poke_finish+0x16/0x30 arch/x86/kernel/alternative.c:1275
 arch_jump_label_transform_apply+0x13/0x20 arch/x86/kernel/jump_label.c:122
 jump_label_update+0x1da/0x400 kernel/jump_label.c:825
 static_key_enable_cpuslocked+0x1b1/0x260 kernel/jump_label.c:177
 static_key_enable+0x16/0x20 kernel/jump_label.c:190
 toggle_allocation_gate mm/kfence/core.c:623 [inline]
 toggle_allocation_gate+0x100/0x390 mm/kfence/core.c:615
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2276
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2422
 kthread+0x3b1/0x4a0 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


Tested on:

commit:         d6765985 Revert "be2net: disable bh with spin_lock in ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14c25202080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d43f3e8616689bf
dashboard link: https://syzkaller.appspot.com/bug?extid=3ba0493d523d007b3819
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1408beee080000

