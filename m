Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CE554F0DA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 07:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380225AbiFQF6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 01:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379746AbiFQF6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 01:58:21 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E80224F1E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 22:58:20 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id n12-20020a92260c000000b002d3c9fc68d6so2086390ile.19
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 22:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/v8fISD0GkdjCRoQr4EGjH3d8HHv0OQwuaFNwQ8Ad1E=;
        b=t7o9cIpUIX8a8Rmqp1yYnYnOPlgCxmsA5AYRwJTyGk83DdURS+9c1+XnCdwCh0Zxcg
         3ZFp1al5Cz/aNNVi20qyVwAXZTnfTQRcmNy5YH+Fw7/gN/ZGFyhtTAsGHQLSI+JbIy1W
         aFHYuJAIKA1jFNkb/k6PQ0rdwbyy7SPYni9tl8Bo4WdSNumnc+MBZmDywExKSuheCkr9
         SFQsQUU/d4+7N/x/1Z6Wh86z6B0BfGepEFyGTpWS0x3j2v0XpJsqbqA7AYo7TL5MeDz1
         9fmCeXhRF0+sQoDjr9TZMqpHITP3FvRnZk5vZ4FSEQRnxRhxT2v7fNXMVSVMDb0LkdT9
         0Vrg==
X-Gm-Message-State: AJIora+fCF8dIBGf4omOF46RoAt8FUevIvJL0D3fKExNg5PrP+zln853
        6GuaVaJENZv+R/YAsSnxL7pc2ESkITqdigXA+QYfV5gm7PRz
X-Google-Smtp-Source: AGRyM1sMMnyGyNJmMP9S14AfWrnM+S+rsnkpqdmyOe7ZEZSmNJxf43tlmRjfUcS52We5MeOhzfxSbC7ZmAgI1Pg3KMuGNN1iasA1
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3395:b0:331:8023:d565 with SMTP id
 h21-20020a056638339500b003318023d565mr4465642jav.12.1655445499946; Thu, 16
 Jun 2022 22:58:19 -0700 (PDT)
Date:   Thu, 16 Jun 2022 22:58:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f82cf305e19e70e6@google.com>
Subject: [syzbot] WARNING in ct_idle_exit
From:   syzbot <syzbot+d9bf4b9035073dc73df9@syzkaller.appspotmail.com>
To:     frederic@kernel.org, linux-kernel@vger.kernel.org,
        paulmck@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    c6d7e3b385f1 Add linux-next specific files for 20220616
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=120e19a7f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d495405e4a98620
dashboard link: https://syzkaller.appspot.com/bug?extid=d9bf4b9035073dc73df9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d9bf4b9035073dc73df9@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 0 at kernel/context_tracking.c:335 ct_idle_exit+0x34/0x40 kernel/context_tracking.c:335

=============================
WARNING: suspicious RCU usage
5.19.0-rc2-next-20220616-syzkaller #0 Not tainted
-----------------------------
include/trace/events/lock.h:24 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
no locks held by swapper/1/0.

stack backtrace:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.19.0-rc2-next-20220616-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 trace_lock_acquire include/trace/events/lock.h:24 [inline]
 lock_acquire.cold+0x1f/0x40 kernel/locking/lockdep.c:5636
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 down_trylock+0xe/0x60 kernel/locking/semaphore.c:139
 __down_trylock_console_sem+0xfb/0x120 kernel/printk/printk.c:276
 console_trylock+0x13/0xd0 kernel/printk/printk.c:2731
 console_trylock_spinning kernel/printk/printk.c:2003 [inline]
 vprintk_emit+0x127/0x680 kernel/printk/printk.c:2403
 vprintk+0x80/0x90 kernel/printk/printk_safe.c:52
 _printk+0xba/0xed kernel/printk/printk.c:2425
 __warn+0x91/0x190 kernel/panic.c:611
 report_bug+0x1bc/0x210 lib/bug.c:198
 handle_bug+0x3c/0x60 arch/x86/kernel/traps.c:316
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:336
 asm_exc_invalid_op+0x1b/0x20 arch/x86/include/asm/idtentry.h:568
RIP: 0010:ct_idle_exit+0x34/0x40 kernel/context_tracking.c:335
Code: 00 02 00 00 31 ff 48 89 de 0f 1f 44 00 00 48 85 db 75 12 0f 1f 44 00 00 5b be 03 00 00 00 31 ff e9 01 fe ff ff 0f 1f 44 00 00 <0f> 0b eb e5 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 41 89 f4 55
RSP: 0018:ffffc90000187d78 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
RDX: ffff888011aaba80 RSI: 0000000000000200 RDI: 0000000000000000
RBP: ffffffff8c7bf520 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 cpuidle_enter_state+0x6f7/0xc80 drivers/cpuidle/cpuidle.c:240
 cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:352
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x3e8/0x590 kernel/sched/idle.c:303
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
 start_secondary+0x21d/0x2b0 arch/x86/kernel/smpboot.c:266
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>

=============================
WARNING: suspicious RCU usage
5.19.0-rc2-next-20220616-syzkaller #0 Not tainted
-----------------------------
include/trace/events/lock.h:69 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
1 lock held by swapper/1/0:
 #0: ffffffff8bd75ed8 ((console_sem).lock){....}-{2:2}, at: down_trylock+0xe/0x60 kernel/locking/semaphore.c:139

stack backtrace:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.19.0-rc2-next-20220616-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release.cold+0x1f/0x4e kernel/locking/lockdep.c:5676
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:149 [inline]
 _raw_spin_unlock_irqrestore+0x16/0x70 kernel/locking/spinlock.c:194
 down_trylock+0x45/0x60 kernel/locking/semaphore.c:143
 __down_trylock_console_sem+0xfb/0x120 kernel/printk/printk.c:276
 console_trylock+0x13/0xd0 kernel/printk/printk.c:2731
 console_trylock_spinning kernel/printk/printk.c:2003 [inline]
 vprintk_emit+0x127/0x680 kernel/printk/printk.c:2403
 vprintk+0x80/0x90 kernel/printk/printk_safe.c:52
 _printk+0xba/0xed kernel/printk/printk.c:2425
 __warn+0x91/0x190 kernel/panic.c:611
 report_bug+0x1bc/0x210 lib/bug.c:198
 handle_bug+0x3c/0x60 arch/x86/kernel/traps.c:316
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:336
 asm_exc_invalid_op+0x1b/0x20 arch/x86/include/asm/idtentry.h:568
RIP: 0010:ct_idle_exit+0x34/0x40 kernel/context_tracking.c:335
Code: 00 02 00 00 31 ff 48 89 de 0f 1f 44 00 00 48 85 db 75 12 0f 1f 44 00 00 5b be 03 00 00 00 31 ff e9 01 fe ff ff 0f 1f 44 00 00 <0f> 0b eb e5 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 41 89 f4 55
RSP: 0018:ffffc90000187d78 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
RDX: ffff888011aaba80 RSI: 0000000000000200 RDI: 0000000000000000
RBP: ffffffff8c7bf520 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 cpuidle_enter_state+0x6f7/0xc80 drivers/cpuidle/cpuidle.c:240
 cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:352
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x3e8/0x590 kernel/sched/idle.c:303
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
 start_secondary+0x21d/0x2b0 arch/x86/kernel/smpboot.c:266
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.19.0-rc2-next-20220616-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:ct_idle_exit+0x34/0x40 kernel/context_tracking.c:335
Code: 00 02 00 00 31 ff 48 89 de 0f 1f 44 00 00 48 85 db 75 12 0f 1f 44 00 00 5b be 03 00 00 00 31 ff e9 01 fe ff ff 0f 1f 44 00 00 <0f> 0b eb e5 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 41 89 f4 55
RSP: 0018:ffffc90000187d78 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
RDX: ffff888011aaba80 RSI: 0000000000000200 RDI: 0000000000000000
RBP: ffffffff8c7bf520 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00060eda0 CR3: 000000001d18f000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 cpuidle_enter_state+0x6f7/0xc80 drivers/cpuidle/cpuidle.c:240
 cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:352
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x3e8/0x590 kernel/sched/idle.c:303
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
 start_secondary+0x21d/0x2b0 arch/x86/kernel/smpboot.c:266
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
