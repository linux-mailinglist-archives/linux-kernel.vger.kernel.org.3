Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009374E20A9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 07:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344623AbiCUGof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 02:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344619AbiCUGod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 02:44:33 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7960213D1B
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 23:43:08 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id o14-20020a92d38e000000b002c7f344af18so4051828ilo.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 23:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=JWO04V+T1MZbLUUaVMVYDlWCtYCYmo+qfjhv2Mvi/yE=;
        b=t2GTGUVktVqiJhbyOjBkhEakZK6fkEOCaMHtt59vpDXoSG0kLP2rS2fURrJa1XUj1m
         HAf07tFMbLjoegPb77ZvUhBje2BDZXzTg/NmYCYVGppgMwaozFAutGToyqqY17EUf9NJ
         /UtDaonegqa1v3p6yfB9pW34teH8H1em08EDDuwm1c2XClGOglimPTXaC2NY8Tg+P5iX
         6hUoTkNyb/mfcfghshGf9n9PEqPUX+/EfSYJGittqcSwUdNSnQOZiEEfCIUPWHCNTgcd
         vr7tXTHt9VaP2D766D3Jkc1hcCw5mt2puAaJvF8kWEJ5S/fJt07KjKgjwAcrWMJgG2XG
         jn2Q==
X-Gm-Message-State: AOAM532E8k7qcD2xoFBG7x/4My8qx6/tf8C/3MXtP+BCnWJvGGE4LNtG
        Q7I9gQX7XDhI9STeYaWpbJ6gA5R16viCNBZrrTy+nQrqsCRM
X-Google-Smtp-Source: ABdhPJx/APm27uMjtMqLUvK2XP3uRKmJwvBq+cyEYy7OEvvusEWVF6OAqejCwfHKdi+ci5QV27ywaXiBC64GM7ukgA+8gmTKNPlU
MIME-Version: 1.0
X-Received: by 2002:a92:c546:0:b0:2c8:1cdf:7ae5 with SMTP id
 a6-20020a92c546000000b002c81cdf7ae5mr3079116ilj.257.1647844987883; Sun, 20
 Mar 2022 23:43:07 -0700 (PDT)
Date:   Sun, 20 Mar 2022 23:43:07 -0700
In-Reply-To: <20220321063053.2877-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025daf805dab4cfe6@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in gc_worker (3)
From:   syzbot <syzbot+eec403943a2a2455adaa@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: soft lockup in smp_call_function

watchdog: BUG: soft lockup - CPU#0 stuck for 143s! [kworker/u4:5:1244]
Modules linked in:
irq event stamp: 595274
hardirqs last  enabled at (595273): [<ffffffff89600c02>] asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
hardirqs last disabled at (595274): [<ffffffff894c14ab>] sysvec_apic_timer_interrupt+0xb/0xc0 arch/x86/kernel/apic/apic.c:1097
softirqs last  enabled at (588534): [<ffffffff81474343>] invoke_softirq kernel/softirq.c:432 [inline]
softirqs last  enabled at (588534): [<ffffffff81474343>] __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637
softirqs last disabled at (588525): [<ffffffff81474343>] invoke_softirq kernel/softirq.c:432 [inline]
softirqs last disabled at (588525): [<ffffffff81474343>] __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637
CPU: 0 PID: 1244 Comm: kworker/u4:5 Not tainted 5.17.0-syzkaller-00083-gf443e374ae13-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:__sanitizer_cov_trace_pc+0x5c/0x60 kernel/kcov.c:210
Code: 82 80 15 00 00 83 f8 02 75 20 48 8b 8a 88 15 00 00 8b 92 84 15 00 00 48 8b 01 48 83 c0 01 48 39 c2 76 07 48 89 34 c1 48 89 01 <c3> 0f 1f 00 41 55 41 54 49 89 fc 55 48 bd eb 83 b5 80 46 86 c8 61
RSP: 0018:ffffc90005a3f9e8 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffff8880b9d3fec0 RCX: 0000000000000000
RDX: ffff88801cf21d00 RSI: ffffffff816d3654 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff816d367a R11: 0000000000000000 R12: ffffed10173a7fd9
R13: 0000000000000001 R14: ffff8880b9d3fec8 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe833fd960 CR3: 000000000b88e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rep_nop arch/x86/include/asm/vdso/processor.h:13 [inline]
 cpu_relax arch/x86/include/asm/vdso/processor.h:18 [inline]
 csd_lock_wait kernel/smp.c:440 [inline]
 smp_call_function_many_cond+0x4e4/0xc90 kernel/smp.c:969
 on_each_cpu_cond_mask+0x56/0xa0 kernel/smp.c:1135
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:1112 [inline]
 text_poke_bp_batch+0x21d/0x6f0 arch/x86/kernel/alternative.c:1300
 text_poke_flush arch/x86/kernel/alternative.c:1470 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:1467 [inline]
 text_poke_finish+0x16/0x30 arch/x86/kernel/alternative.c:1477
 arch_jump_label_transform_apply+0x13/0x20 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x32f/0x410 kernel/jump_label.c:830
 static_key_enable_cpuslocked+0x1b1/0x260 kernel/jump_label.c:177
 static_key_enable+0x16/0x20 kernel/jump_label.c:190
 toggle_allocation_gate mm/kfence/core.c:735 [inline]
 toggle_allocation_gate+0x100/0x390 mm/kfence/core.c:727
 process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
 worker_thread+0x657/0x1110 kernel/workqueue.c:2454
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 4081 Comm: syz-executor201 Not tainted 5.17.0-syzkaller-00083-gf443e374ae13-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:_raw_spin_lock_irqsave+0x3/0x50 kernel/locking/spinlock.c:161
Code: 31 d2 31 f6 e8 fe 9b 0e f8 48 89 ef 58 5d e9 04 0f 0f f8 e8 bf 0a 30 f8 eb c9 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 41 54 55 <48> 89 fd 9c 41 5c fa 41 f7 c4 00 02 00 00 75 36 bf 01 00 00 00 e8
RSP: 0018:ffffc90000dc0d40 EFLAGS: 00000002
RAX: 0000000000001399 RBX: 0000000000058308 RCX: 0000000000000000
RDX: 61c8864680b583eb RSI: ffffffff89ae6860 RDI: ffffffff906f8610
RBP: ffffffff906f8608 R08: ffffffff906f8610 R09: 0000000000000001
R10: ffffffff81681c55 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffffff89ae6860 R14: 1ffff920001b81ad R15: ffff888140782b40
FS:  0000555555b0b300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000600 CR3: 000000001e6c1000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 debug_object_deactivate lib/debugobjects.c:735 [inline]
 debug_object_deactivate+0x101/0x300 lib/debugobjects.c:723
 debug_hrtimer_deactivate kernel/time/hrtimer.c:425 [inline]
 debug_deactivate kernel/time/hrtimer.c:481 [inline]
 __run_hrtimer kernel/time/hrtimer.c:1653 [inline]
 __hrtimer_run_queues+0x3f8/0xe50 kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1103
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:194
Code: 74 24 10 e8 6a 92 0e f8 48 89 ef e8 c2 10 0f f8 81 e3 00 02 00 00 75 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> 73 c8 01 f8 65 8b 05 9c 76 b3 76 85 c0 74 0a 5b 5d c3 e8 b0 04
RSP: 0018:ffffc9000289f1e8 EFLAGS: 00000206
RAX: 0000000000000012 RBX: 0000000000000200 RCX: 1ffffffff2001bce
RDX: 0000000000000000 RSI: 0000000000000202 RDI: 0000000000000001
RBP: ffff888140782ae8 R08: 0000000000000001 R09: ffffffff8ffc5a07
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
R13: ffff888140782ae8 R14: 0000000000000246 R15: ffff888140782800
 spin_unlock_irqrestore include/linux/spinlock.h:404 [inline]
 taprio_change+0x2f0c/0x4050 net/sched/sch_taprio.c:1606
 taprio_init+0x52e/0x670 net/sched/sch_taprio.c:1738
 qdisc_create.constprop.0+0x44a/0x10f0 net/sched/sch_api.c:1253
 tc_modify_qdisc+0x4c5/0x1a00 net/sched/sch_api.c:1660
 rtnetlink_rcv_msg+0x413/0xb80 net/core/rtnetlink.c:5596
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2494
 netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
 netlink_unicast+0x539/0x7e0 net/netlink/af_netlink.c:1343
 netlink_sendmsg+0x904/0xe00 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:705 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:725
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2413
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2467
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2496
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f5f768be729
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe833c99c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f5f768be729
RDX: 0000000000000000 RSI: 00000000200007c0 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00007ffe833c99f0 R09: 00007ffe833c99f0
R10: 00007ffe833c99f0 R11: 0000000000000246 R12: 00007ffe833c99ec
R13: 00007ffe833c9a00 R14: 00007ffe833c9a40 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	80 15 00 00 83 f8 02 	adcb   $0x2,-0x77d0000(%rip)        # 0xf8830007
   7:	75 20                	jne    0x29
   9:	48 8b 8a 88 15 00 00 	mov    0x1588(%rdx),%rcx
  10:	8b 92 84 15 00 00    	mov    0x1584(%rdx),%edx
  16:	48 8b 01             	mov    (%rcx),%rax
  19:	48 83 c0 01          	add    $0x1,%rax
  1d:	48 39 c2             	cmp    %rax,%rdx
  20:	76 07                	jbe    0x29
  22:	48 89 34 c1          	mov    %rsi,(%rcx,%rax,8)
  26:	48 89 01             	mov    %rax,(%rcx)
* 29:	c3                   	retq <-- trapping instruction
  2a:	0f 1f 00             	nopl   (%rax)
  2d:	41 55                	push   %r13
  2f:	41 54                	push   %r12
  31:	49 89 fc             	mov    %rdi,%r12
  34:	55                   	push   %rbp
  35:	48 bd eb 83 b5 80 46 	movabs $0x61c8864680b583eb,%rbp
  3c:	86 c8 61


Tested on:

commit:         f443e374 Linux 5.17
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=157ae133700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=19ca6f72fd444749
dashboard link: https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e78333700000

