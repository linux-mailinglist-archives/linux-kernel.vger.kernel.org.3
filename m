Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F5B4720F4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 07:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhLMGIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 01:08:25 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:56849 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhLMGIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 01:08:24 -0500
Received: by mail-io1-f70.google.com with SMTP id r199-20020a6b2bd0000000b005e234972ddfso14512649ior.23
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 22:08:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bTbtKuf24erNE2L1Zy6cq2jRuyZsTh9x4mxZYFZUvrg=;
        b=WV7Q33oLbsxBY+VQQOvYEG43pBB9RwAhNxvIC1mWrpEUvOStvGI31oCCdRtPtJWrMC
         DySe7oGLnKQl95hSeZcFY5oJs933BK1lP9TDgvOrgVAQHhb92iKyDrVgKN2W8n7pUhB6
         6dt2FjlxqfFugJpV30Mgt4wQILeREGss0TmqzJJv11efkO4zivA+O1+sdy7MtMKmnIqU
         eHVQA/ZqOMkIS0ZmmJlsbVaNP38cg7WFrMZOrKSe+y/DJqdVzliwoXjqjNZ3D3NXeRGz
         6qS6fzlrIS4vrAvGdOH5RIuy2f6iAt4gXol253O7AqesHdB8SJuM4/GAxXB2J5GfA8C3
         pZ2w==
X-Gm-Message-State: AOAM532NDv5LMsiTVr8Q4eLRAVYO3isbnut8poIWPI0uNjfcPCPufVT3
        eB1MihKrA1g7KmBB2vy5Hl5SFOX1ssf97C619e9zm69AmlSd
X-Google-Smtp-Source: ABdhPJx4gUGs/puQx9ShXALxml8Bc1nQhvR6daoxWLXs9fdLsqu85y1sd775abtURVvuPjrYrByh5ubIlz5jhcdTgABCgz95Nj2J
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a08:: with SMTP id s8mr31906136ild.309.1639375704212;
 Sun, 12 Dec 2021 22:08:24 -0800 (PST)
Date:   Sun, 12 Dec 2021 22:08:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080c88305d300e67f@google.com>
Subject: [syzbot] possible deadlock in io_worker_cancel_cb
From:   syzbot <syzbot+b18b8be69df33a3918e9@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, haoxu@linux.alibaba.com,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a763d5a5abd6 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b900bab00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d5e878e3399b6cc
dashboard link: https://syzkaller.appspot.com/bug?extid=b18b8be69df33a3918e9
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143f7551b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f56825b00000

The issue was bisected to:

commit 71a85387546e50b1a37b0fa45dadcae3bfb35cf6
Author: Jens Axboe <axboe@kernel.dk>
Date:   Fri Dec 10 15:29:30 2021 +0000

    io-wq: check for wq exit after adding new worker task_work

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17a634bab00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=146634bab00000
console output: https://syzkaller.appspot.com/x/log.txt?x=106634bab00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b18b8be69df33a3918e9@syzkaller.appspotmail.com
Fixes: 71a85387546e ("io-wq: check for wq exit after adding new worker task_work")

============================================
WARNING: possible recursive locking detected
5.16.0-rc4-syzkaller #0 Not tainted
--------------------------------------------
iou-wrk-6468/6471 is trying to acquire lock:
ffff88801aa98018 (&wqe->lock){+.+.}-{2:2}, at: io_worker_cancel_cb+0xb7/0x210 fs/io-wq.c:187

but task is already holding lock:
ffff88801aa98018 (&wqe->lock){+.+.}-{2:2}, at: io_wq_worker_sleeping+0xb6/0x140 fs/io-wq.c:700

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&wqe->lock);
  lock(&wqe->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

1 lock held by iou-wrk-6468/6471:
 #0: ffff88801aa98018 (&wqe->lock){+.+.}-{2:2}, at: io_wq_worker_sleeping+0xb6/0x140 fs/io-wq.c:700

stack backtrace:
CPU: 1 PID: 6471 Comm: iou-wrk-6468 Not tainted 5.16.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106
 print_deadlock_bug kernel/locking/lockdep.c:2956 [inline]
 check_deadlock kernel/locking/lockdep.c:2999 [inline]
 validate_chain+0x5984/0x8240 kernel/locking/lockdep.c:3788
 __lock_acquire+0x1382/0x2b00 kernel/locking/lockdep.c:5027
 lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 io_worker_cancel_cb+0xb7/0x210 fs/io-wq.c:187
 io_wq_cancel_tw_create fs/io-wq.c:1220 [inline]
 io_queue_worker_create+0x3cf/0x4c0 fs/io-wq.c:372
 io_wq_worker_sleeping+0xbe/0x140 fs/io-wq.c:701
 sched_submit_work kernel/sched/core.c:6295 [inline]
 schedule+0x67/0x1f0 kernel/sched/core.c:6323
 schedule_timeout+0xac/0x300 kernel/time/timer.c:1857
 wait_woken+0xca/0x1b0 kernel/sched/wait.c:460
 unix_msg_wait_data net/unix/unix_bpf.c:32 [inline]
 unix_bpf_recvmsg+0x7f9/0xe20 net/unix/unix_bpf.c:77
 unix_stream_recvmsg+0x214/0x2c0 net/unix/af_unix.c:2832
 sock_recvmsg_nosec net/socket.c:944 [inline]
 sock_recvmsg net/socket.c:962 [inline]
 sock_read_iter+0x3a7/0x4d0 net/socket.c:1035
 call_read_iter include/linux/fs.h:2156 [inline]
 io_iter_do_read fs/io_uring.c:3501 [inline]
 io_read fs/io_uring.c:3558 [inline]
 io_issue_sqe+0x144c/0x9590 fs/io_uring.c:6671
 io_wq_submit_work+0x2d8/0x790 fs/io_uring.c:6836
 io_worker_handle_work+0x808/0xdd0 fs/io-wq.c:574
 io_wqe_worker+0x395/0x870 fs/io-wq.c:630
 ret_from_fork+0x1f/0x30
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
