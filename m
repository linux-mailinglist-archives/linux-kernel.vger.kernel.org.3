Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026F7551244
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbiFTINp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239730AbiFTINd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:13:33 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44979A467
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:13:30 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id i2-20020a056e021d0200b002d8ff49e7c4so2976363ila.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9ywDEso0dQZcglSpzFj/mt9efOmvvmhNQfcEW/85dMI=;
        b=6luaufhf4Yb2a/nS9ZikQa8+8YeKi1NFaYYnOV4LBHhpQW4X5MZpFKFrRaysgD+CKc
         N/xKqH0kqEsAQOQ6AX+3iDsd4/6EixoLxdNBPGAsXCMjhsTRM+Af2w7nsWhfYDcHJvw/
         TOoKtEvcUuwPuCIkej2fKFZYo19Gusur5W3/97Ag7otJMpf5yl/saNV4w0yllkYUHl1g
         T8GC1K1fJDREgi+MWRYwWkIN5IMb7MHf0mPyKcMEOfsjZxcpl/sxDM06k7oauVG1dxED
         L2qkXrvs9RciSFlASWPrkK4jIpt+M8iBIpbqyeRMTUGoctC3OWWmQCE6xnnFQfvgk75P
         deZw==
X-Gm-Message-State: AJIora/h0Ms1kl4GdsXqnSDC7oxyEQbpAhIOvxkkUuUH7r2KMajXIN92
        sn28Hh6fKYY4rtnBu8nVDhSyN9Nb31aIsIc4Je/dFaQJ9Lqt
X-Google-Smtp-Source: AGRyM1vQ2Kzp9ibANk2E6+AdQKZU4mfee24UKOGtvBvW0rCeru0G9qq4QAoTrItBfymsmhjlMhJMgiI3NFhMSYkrWmC1IJ8XKNGF
MIME-Version: 1.0
X-Received: by 2002:a92:c909:0:b0:2d9:1e8f:276c with SMTP id
 t9-20020a92c909000000b002d91e8f276cmr419529ilp.305.1655712809905; Mon, 20 Jun
 2022 01:13:29 -0700 (PDT)
Date:   Mon, 20 Jun 2022 01:13:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e2769d05e1dcadd0@google.com>
Subject: [syzbot] WARNING: suspicious RCU usage in atomic_notifier_call_chain
From:   syzbot <syzbot+3333557f53051744538d@syzkaller.appspotmail.com>
To:     bigeasy@linutronix.de, bp@suse.de, dmitry.osipenko@collabora.com,
        linux-kernel@vger.kernel.org, mirq-linux@rere.qmqm.pl,
        rafael.j.wysocki@intel.com, syzkaller-bugs@googlegroups.com,
        vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    07dc787be231 Add linux-next specific files for 20220617
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13f4d5d8080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2512136c9b01d87
dashboard link: https://syzkaller.appspot.com/bug?extid=3333557f53051744538d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3333557f53051744538d@syzkaller.appspotmail.com

 arch_call_rest_init+0xf/0x14 init/main.c:886
 start_kernel+0x473/0x494 init/main.c:1142
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
=============================
WARNING: suspicious RCU usage
5.19.0-rc2-next-20220617-syzkaller #0 Not tainted
-----------------------------
include/linux/rcupdate.h:707 rcu_read_lock() used illegally while idle!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
1 lock held by swapper/0/0:
 #0: ffffffff8bd87780 (rcu_read_lock){....}-{1:2}, at: atomic_notifier_call_chain+0x0/0x180 kernel/notifier.c:455

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc2-next-20220617-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 rcu_read_lock include/linux/rcupdate.h:707 [inline]
 atomic_notifier_call_chain+0x112/0x180 kernel/notifier.c:224
 panic+0x35f/0x64a kernel/panic.c:316
 __warn.cold+0x1ea/0x2cd kernel/panic.c:627
 report_bug+0x1bc/0x210 lib/bug.c:198
 handle_bug+0x3c/0x60 arch/x86/kernel/traps.c:316
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:336
 asm_exc_invalid_op+0x1b/0x20 arch/x86/include/asm/idtentry.h:568
RIP: 0010:ct_idle_exit+0x34/0x40 kernel/context_tracking.c:335
Code: 00 02 00 00 31 ff 48 89 de 0f 1f 44 00 00 48 85 db 75 12 0f 1f 44 00 00 5b be 03 00 00 00 31 ff e9 01 fe ff ff 0f 1f 44 00 00 <0f> 0b eb e5 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 41 89 f4 55
RSP: 0018:ffffffff8ba07d90 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
RDX: ffffffff8babc980 RSI: 0000000000000200 RDI: 0000000000000000
RBP: ffffffff8c7c0200 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 cpuidle_enter_state+0x6f7/0xc80 drivers/cpuidle/cpuidle.c:240
 cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:352
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x3e8/0x590 kernel/sched/idle.c:303
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
 rest_init+0x169/0x270 init/main.c:729
 arch_call_rest_init+0xf/0x14 init/main.c:886
 start_kernel+0x473/0x494 init/main.c:1142
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
Kernel Offset: disabled

=============================
WARNING: suspicious RCU usage
5.19.0-rc2-next-20220617-syzkaller #0 Not tainted
-----------------------------
include/linux/rcupdate.h:735 rcu_read_unlock() used illegally while idle!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
1 lock held by swapper/0/0:
 #0: ffffffff8bd87780 (rcu_read_lock){....}-{1:2}, at: atomic_notifier_call_chain+0x0/0x180 kernel/notifier.c:455

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc2-next-20220617-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 rcu_read_unlock include/linux/rcupdate.h:735 [inline]
 atomic_notifier_call_chain+0x175/0x180 kernel/notifier.c:226
 panic+0x35f/0x64a kernel/panic.c:316
 __warn.cold+0x1ea/0x2cd kernel/panic.c:627
 report_bug+0x1bc/0x210 lib/bug.c:198
 handle_bug+0x3c/0x60 arch/x86/kernel/traps.c:316
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:336
 asm_exc_invalid_op+0x1b/0x20 arch/x86/include/asm/idtentry.h:568
RIP: 0010:ct_idle_exit+0x34/0x40 kernel/context_tracking.c:335
Code: 00 02 00 00 31 ff 48 89 de 0f 1f 44 00 00 48 85 db 75 12 0f 1f 44 00 00 5b be 03 00 00 00 31 ff e9 01 fe ff ff 0f 1f 44 00 00 <0f> 0b eb e5 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 41 89 f4 55
RSP: 0018:ffffffff8ba07d90 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
RDX: ffffffff8babc980 RSI: 0000000000000200 RDI: 0000000000000000
RBP: ffffffff8c7c0200 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 cpuidle_enter_state+0x6f7/0xc80 drivers/cpuidle/cpuidle.c:240
 cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:352
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x3e8/0x590 kernel/sched/idle.c:303
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
 rest_init+0x169/0x270 init/main.c:729
 arch_call_rest_init+0xf/0x14 init/main.c:886
 start_kernel+0x473/0x494 init/main.c:1142
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>

=============================
WARNING: suspicious RCU usage
5.19.0-rc2-next-20220617-syzkaller #0 Not tainted
-----------------------------
include/linux/rcupdate.h:707 rcu_read_lock() used illegally while idle!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
1 lock held by swapper/0/0:
 #0: ffffffff8bd87780 (rcu_read_lock){....}-{1:2}, at: kmsg_dump+0x0/0x260 kernel/printk/printk.c:3982

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc2-next-20220617-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 rcu_read_lock include/linux/rcupdate.h:707 [inline]
 kmsg_dump+0x1c8/0x260 kernel/printk/printk.c:4122
 panic+0x36e/0x64a kernel/panic.c:320
 __warn.cold+0x1ea/0x2cd kernel/panic.c:627
 report_bug+0x1bc/0x210 lib/bug.c:198
 handle_bug+0x3c/0x60 arch/x86/kernel/traps.c:316
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:336
 asm_exc_invalid_op+0x1b/0x20 arch/x86/include/asm/idtentry.h:568
RIP: 0010:ct_idle_exit+0x34/0x40 kernel/context_tracking.c:335
Code: 00 02 00 00 31 ff 48 89 de 0f 1f 44 00 00 48 85 db 75 12 0f 1f 44 00 00 5b be 03 00 00 00 31 ff e9 01 fe ff ff 0f 1f 44 00 00 <0f> 0b eb e5 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 41 89 f4 55
RSP: 0018:ffffffff8ba07d90 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
RDX: ffffffff8babc980 RSI: 0000000000000200 RDI: 0000000000000000
RBP: ffffffff8c7c0200 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 cpuidle_enter_state+0x6f7/0xc80 drivers/cpuidle/cpuidle.c:240
 cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:352
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x3e8/0x590 kernel/sched/idle.c:303
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
 rest_init+0x169/0x270 init/main.c:729
 arch_call_rest_init+0xf/0x14 init/main.c:886
 start_kernel+0x473/0x494 init/main.c:1142
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>

=============================
WARNING: suspicious RCU usage
5.19.0-rc2-next-20220617-syzkaller #0 Not tainted
-----------------------------
include/linux/rcupdate.h:735 rcu_read_unlock() used illegally while idle!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
1 lock held by swapper/0/0:
 #0: ffffffff8bd87780 (rcu_read_lock){....}-{1:2}, at: kmsg_dump+0x0/0x260 kernel/printk/printk.c:3982

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc2-next-20220617-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 rcu_read_unlock include/linux/rcupdate.h:735 [inline]
 kmsg_dump+0x22b/0x260 kernel/printk/printk.c:4140
 panic+0x36e/0x64a kernel/panic.c:320
 __warn.cold+0x1ea/0x2cd kernel/panic.c:627
 report_bug+0x1bc/0x210 lib/bug.c:198
 handle_bug+0x3c/0x60 arch/x86/kernel/traps.c:316
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:336
 asm_exc_invalid_op+0x1b/0x20 arch/x86/include/asm/idtentry.h:568
RIP: 0010:ct_idle_exit+0x34/0x40 kernel/context_tracking.c:335
Code: 00 02 00 00 31 ff 48 89 de 0f 1f 44 00 00 48 85 db 75 12 0f 1f 44 00 00 5b be 03 00 00 00 31 ff e9 01 fe ff ff 0f 1f 44 00 00 <0f> 0b eb e5 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 41 89 f4 55
RSP: 0018:ffffffff8ba07d90 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
RDX: ffffffff8babc980 RSI: 0000000000000200 RDI: 0000000000000000
RBP: ffffffff8c7c0200 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 cpuidle_enter_state+0x6f7/0xc80 drivers/cpuidle/cpuidle.c:240
 cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:352
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x3e8/0x590 kernel/sched/idle.c:303
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
 rest_init+0x169/0x270 init/main.c:729
 arch_call_rest_init+0xf/0x14 init/main.c:886
 start_kernel+0x473/0x494 init/main.c:1142
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
