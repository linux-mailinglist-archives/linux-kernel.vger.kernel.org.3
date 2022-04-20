Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5F4508565
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377494AbiDTKDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377495AbiDTKDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:03:25 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536B83F318
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:00:33 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id l2-20020a056e0212e200b002cc235e7488so595360iln.21
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NuMJFaN/tuN5msi//LVAfmhcWDCzrafOzikhw8nF8H8=;
        b=wDax7nb/8Ywmw26eW4hOkEvJ97p55XB3WJc+e6sBMvvxbUGFDWQWBQoQ/LbL27Vx2F
         MK/hVgYmsHWKww7SQe7tIsA2rj7Vfg2/u7Vw6pbtpNR6cBREFvuYH0syYmF/+3icZ3yn
         CgeHMRbXI2WnjvUwoTn7Z3vxSXZycvjS7h8hKhO4mpMdWwQVryKE/rYHxEc8kyZXdK3/
         cqtPcr4zdbWcs6I8qS0BbE3BApU9oorGeV9oD9a8K50Puynw0YXNGureHwO1gaSYDEPx
         daiistH7US/QcT34DmzzSxKJku8Vmr/hSRRBOmmtOw1YqKR8lc23qxBcNgHJ0RyMLhJX
         4+XQ==
X-Gm-Message-State: AOAM533eeEzjMvg1CczGRkzyd3Y9XTNHZT30HCDgdxmNXs3Ex2TEnR8f
        D97NmIAsTcTsdXn0ZeeqOiUCorEC+VeoRqUsbTQp8CH/+iCy
X-Google-Smtp-Source: ABdhPJwOvtnWn0yqKUpPHiJDtFrabRFJqwryKPHVhcMyAeURtE5+kBJLIwru1nJz/4alVuUrMf++ohg3rCiAPnCgUwndiPyonkTK
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2e05:b0:657:28bd:ca2c with SMTP id
 o5-20020a0566022e0500b0065728bdca2cmr170391iow.210.1650448832554; Wed, 20 Apr
 2022 03:00:32 -0700 (PDT)
Date:   Wed, 20 Apr 2022 03:00:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000626ce805dd13108c@google.com>
Subject: [syzbot] possible deadlock in io_disarm_next
From:   syzbot <syzbot+57e67273f92d7f5f1931@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

syzbot found the following issue on:

HEAD commit:    634de1db0e9b Add linux-next specific files for 20220419
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10c92db8f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbd6f9b0a89865b0
dashboard link: https://syzkaller.appspot.com/bug?extid=57e67273f92d7f5f1931
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a02f68f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=138e3008f00000

The issue was bisected to:

commit 78bfbdd1a4977df1dded20f9783a6ec174e67ef8
Author: Pavel Begunkov <asml.silence@gmail.com>
Date:   Fri Apr 15 21:08:23 2022 +0000

    io_uring: kill io_put_req_deferred()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13039c0cf00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10839c0cf00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17039c0cf00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+57e67273f92d7f5f1931@syzkaller.appspotmail.com
Fixes: 78bfbdd1a497 ("io_uring: kill io_put_req_deferred()")

============================================
WARNING: possible recursive locking detected
5.18.0-rc3-next-20220419-syzkaller #0 Not tainted
--------------------------------------------
syz-executor162/3588 is trying to acquire lock:
ffff888011a453d8 (&ctx->timeout_lock){....}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:379 [inline]
ffff888011a453d8 (&ctx->timeout_lock){....}-{2:2}, at: io_disarm_next+0x545/0xaa0 fs/io_uring.c:2452

but task is already holding lock:
ffff888011a453d8 (&ctx->timeout_lock){....}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:379 [inline]
ffff888011a453d8 (&ctx->timeout_lock){....}-{2:2}, at: io_kill_timeouts+0x4c/0x227 fs/io_uring.c:10432

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&ctx->timeout_lock);
  lock(&ctx->timeout_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz-executor162/3588:
 #0: ffff888011a45398 (&ctx->completion_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:354 [inline]
 #0: ffff888011a45398 (&ctx->completion_lock){+.+.}-{2:2}, at: io_kill_timeouts+0x38/0x227 fs/io_uring.c:10431
 #1: ffff888011a453d8 (&ctx->timeout_lock){....}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:379 [inline]
 #1: ffff888011a453d8 (&ctx->timeout_lock){....}-{2:2}, at: io_kill_timeouts+0x4c/0x227 fs/io_uring.c:10432

stack backtrace:
CPU: 1 PID: 3588 Comm: syz-executor162 Not tainted 5.18.0-rc3-next-20220419-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_deadlock_bug kernel/locking/lockdep.c:2988 [inline]
 check_deadlock kernel/locking/lockdep.c:3031 [inline]
 validate_chain kernel/locking/lockdep.c:3816 [inline]
 __lock_acquire.cold+0x1f5/0x3b4 kernel/locking/lockdep.c:5053
 lock_acquire kernel/locking/lockdep.c:5665 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5630
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0x32/0x50 kernel/locking/spinlock.c:170
 spin_lock_irq include/linux/spinlock.h:379 [inline]
 io_disarm_next+0x545/0xaa0 fs/io_uring.c:2452
 __io_req_complete_post+0x794/0xd90 fs/io_uring.c:2200
 io_kill_timeout fs/io_uring.c:1815 [inline]
 io_kill_timeout+0x210/0x21d fs/io_uring.c:1803
 io_kill_timeouts+0xe2/0x227 fs/io_uring.c:10435
 io_ring_ctx_wait_and_kill+0x1eb/0x360 fs/io_uring.c:10462
 io_uring_release+0x42/0x46 fs/io_uring.c:10483
 __fput+0x277/0x9d0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 exit_task_work include/linux/task_work.h:37 [inline]
 do_exit+0xaff/0x2a00 kernel/exit.c:796
 do_group_exit+0xd2/0x2f0 kernel/exit.c:926
 __do_sys_exit_group kernel/exit.c:937 [inline]
 __se_sys_exit_group kernel/exit.c:935 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:935
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f786cb8ccb9
Code: Unable to access opcode bytes at RIP 0x7f786cb8cc8f.
RSP: 002b:00007ffcf6b5b088 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f786cc01350 RCX: 00007f786cb8ccb9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f786cc01350
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
