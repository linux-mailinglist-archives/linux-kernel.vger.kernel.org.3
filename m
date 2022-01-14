Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C58448E723
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239693AbiANJJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:09:18 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:52133 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239644AbiANJJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:09:17 -0500
Received: by mail-il1-f200.google.com with SMTP id d8-20020a056e02214800b002b766d01bf5so5746442ilv.18
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 01:09:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=grHxCRd7/fDYY0i9cGDsjoRzJRJ5aOkbW3ALA1psZtI=;
        b=SnHJrHKhSp5Rk87gupTIB0ZuFMapdHte4mM3FRH8SGKNd9hZSZPPbZeKyQHbhWUfNw
         WQMjlKesp3IOwTM/R2W9MxExACf2rv+5QIYBfFDwuNvIKEdxWJ0dhbV1efd6s9cZy6e+
         kuqTfGHxT2JP6hi3+UHB9zAhU+o04N41hlH2zW/HDathsL57Z9QdqRW2f5WXmFaogCzN
         /V3RD65U0PIwPcwA/1WwAygPUr6d+29j8IuJ97zDD5QxT0GMIfM/L2FwkjJstzC0QGz+
         0Gl4g60uOkwReTiVwr8O/RcAQ1RpH81jGALKywsDQaianN8jnkwqwuPTmohcKXZqOgjv
         OuUQ==
X-Gm-Message-State: AOAM533tSK5RrNwoTnzABbHOwggk1+yDgi64ugxcNkOh5991yHhf9r1h
        28+ud7cOtTm+8Qh6MQ8VCpHYLI32j654HNKktAeiOQSlWsZf
X-Google-Smtp-Source: ABdhPJzrtzL3KtaKjcbS2baa8Qd4awayCo48Py4S2a3t1Oj2zYk/kDJec2Lpeaz7tQ2eeoftXXRshiw/OHvPgFXiLmNUMwVJAmyC
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3c6:: with SMTP id g6mr3954432iov.213.1642151356982;
 Fri, 14 Jan 2022 01:09:16 -0800 (PST)
Date:   Fri, 14 Jan 2022 01:09:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004cede805d58728c3@google.com>
Subject: [syzbot] possible deadlock in f2fs_write_checkpoint
From:   syzbot <syzbot+0b9cadf5fc45a98a5083@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    57c149e506d5 Add linux-next specific files for 20220110
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15cb8b77b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f1cca5543ac6349
dashboard link: https://syzkaller.appspot.com/bug?extid=0b9cadf5fc45a98a5083
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0b9cadf5fc45a98a5083@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
5.16.0-rc8-next-20220110-syzkaller #0 Not tainted
--------------------------------------------
f2fs_ckpt-7:2/4139 is trying to acquire lock:
ffff88807c598390 (&sem->internal_rwsem#2){+.+.}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2149 [inline]
ffff88807c598390 (&sem->internal_rwsem#2){+.+.}-{3:3}, at: f2fs_write_checkpoint+0x535/0x5d00 fs/f2fs/checkpoint.c:1615

but task is already holding lock:
ffff88807c599338 (&sem->internal_rwsem#2){+.+.}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2149 [inline]
ffff88807c599338 (&sem->internal_rwsem#2){+.+.}-{3:3}, at: __write_checkpoint_sync fs/f2fs/checkpoint.c:1744 [inline]
ffff88807c599338 (&sem->internal_rwsem#2){+.+.}-{3:3}, at: __checkpoint_and_complete_reqs+0xdd/0x360 fs/f2fs/checkpoint.c:1764

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&sem->internal_rwsem#2);
  lock(&sem->internal_rwsem#2);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

1 lock held by f2fs_ckpt-7:2/4139:
 #0: ffff88807c599338 (&sem->internal_rwsem#2){+.+.}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2149 [inline]
 #0: ffff88807c599338 (&sem->internal_rwsem#2){+.+.}-{3:3}, at: __write_checkpoint_sync fs/f2fs/checkpoint.c:1744 [inline]
 #0: ffff88807c599338 (&sem->internal_rwsem#2){+.+.}-{3:3}, at: __checkpoint_and_complete_reqs+0xdd/0x360 fs/f2fs/checkpoint.c:1764

stack backtrace:
CPU: 0 PID: 4139 Comm: f2fs_ckpt-7:2 Not tainted 5.16.0-rc8-next-20220110-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_deadlock_bug kernel/locking/lockdep.c:2956 [inline]
 check_deadlock kernel/locking/lockdep.c:2999 [inline]
 validate_chain kernel/locking/lockdep.c:3788 [inline]
 __lock_acquire.cold+0x149/0x3ab kernel/locking/lockdep.c:5027
 lock_acquire kernel/locking/lockdep.c:5639 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
 down_write+0x90/0x150 kernel/locking/rwsem.c:1514
 f2fs_down_write fs/f2fs/f2fs.h:2149 [inline]
 f2fs_write_checkpoint+0x535/0x5d00 fs/f2fs/checkpoint.c:1615
 __write_checkpoint_sync fs/f2fs/checkpoint.c:1745 [inline]
 __checkpoint_and_complete_reqs+0xea/0x360 fs/f2fs/checkpoint.c:1764
 issue_checkpoint_thread+0xdf/0x250 fs/f2fs/checkpoint.c:1795
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
