Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58019464496
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 02:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241107AbhLABkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 20:40:47 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:45698 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhLABkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 20:40:43 -0500
Received: by mail-il1-f199.google.com with SMTP id x6-20020a056e021ca600b002a15324045fso25196882ill.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:37:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=orSAmNqdXZ6x29cKNHa0T7Li2CMMhPAHcHkTNXIEeus=;
        b=qprrlJQxZHMPpGdJK7nbc0gUxmsCXRMIp/Aaa0BkXSdm+NHVRZz2Mxs9Wf9deVkEk4
         vwxa3L4TjNiM2f+kHYlX1wCQ2HVpAYuuDXmAygnYRN2hstdXaosKTXkSsmffYLJWNQ/V
         Z+1aEJbZWO0mwPCqrIZmnv8mWDAErztg6ZtO4MiBk00kOW3CGdXeWdr1JGlhk0EQYSfI
         Ac/RIuJhxRifaCdC1AIrCqMz2VuQNC7/itRI2/0bpnSAejxSW+dt4zCnyycrqeFmzzRB
         dCD0l3SOry0IHJmk4lGfShzv6/phMMZEbbLzBO4iFTz5ILb8zoNetNv48rmX+//pAxG0
         6O1A==
X-Gm-Message-State: AOAM533AkvtYk+e6WfK43nScrv04txG77uRMPYu0FNtko1tAi1gGB+Xw
        vsv1NIAtnL49hItE1UBDnjAShFNv0b45fyT4JMjOi40xOm9b
X-Google-Smtp-Source: ABdhPJzbFhbepN2bXc2Frmt3i/CSNXxO8ulnC3ajIbwyxV0DEhMtDsxFqmYUclh8LyLkEzSWeLb91LyVgIbZyYV9Yk7w/rjw5WXh
MIME-Version: 1.0
X-Received: by 2002:a5d:9ec2:: with SMTP id a2mr5025753ioe.44.1638322642888;
 Tue, 30 Nov 2021 17:37:22 -0800 (PST)
Date:   Tue, 30 Nov 2021 17:37:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000282bf005d20bb7fa@google.com>
Subject: [syzbot] possible deadlock in tty_buffer_flush (2)
From:   syzbot <syzbot+5f26531f88fda38af28c@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d58071a8a76d Linux 5.16-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=161e3691b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=171728a464c05f2b
dashboard link: https://syzkaller.appspot.com/bug?extid=5f26531f88fda38af28c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5f26531f88fda38af28c@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.16.0-rc3-syzkaller #0 Not tainted
------------------------------------------------------
kworker/1:16/12546 is trying to acquire lock:
ffff88801147d0b8 (&buf->lock){+.+.}-{3:3}, at: tty_buffer_flush+0x76/0x2b0 drivers/tty/tty_buffer.c:229

but task is already holding lock:
ffffffff8bb70640 (console_lock){+.+.}-{0:0}, at: vc_SAK+0x10/0x310 drivers/tty/vt/vt_ioctl.c:982

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (console_lock){+.+.}-{0:0}:
       console_lock+0x47/0x80 kernel/printk/printk.c:2524
       con_flush_chars drivers/tty/vt/vt.c:3365 [inline]
       con_flush_chars+0x35/0x90 drivers/tty/vt/vt.c:3357
       n_tty_write+0xbe5/0xfd0 drivers/tty/n_tty.c:2305
       do_tty_write drivers/tty/tty_io.c:1038 [inline]
       file_tty_write.constprop.0+0x526/0x910 drivers/tty/tty_io.c:1110
       call_write_iter include/linux/fs.h:2162 [inline]
       new_sync_write+0x429/0x660 fs/read_write.c:503
       vfs_write+0x7cd/0xae0 fs/read_write.c:590
       ksys_write+0x12d/0x250 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #1 (&tty->termios_rwsem){++++}-{3:3}:
       down_write+0x90/0x150 kernel/locking/rwsem.c:1523
       n_tty_flush_buffer+0x1d/0x230 drivers/tty/n_tty.c:369
       tty_buffer_flush+0x1f0/0x2b0 drivers/tty/tty_buffer.c:240
       tty_ldisc_flush+0x66/0xe0 drivers/tty/tty_ldisc.c:400
       tty_port_close_start.part.0+0x22c/0x550 drivers/tty/tty_port.c:602
       tty_port_close_start drivers/tty/tty_port.c:646 [inline]
       tty_port_close+0x46/0x170 drivers/tty/tty_port.c:639
       uart_close+0x83/0x210 drivers/tty/serial/serial_core.c:1545
       tty_release+0x45e/0x1200 drivers/tty/tty_io.c:1771
       __fput+0x286/0x9f0 fs/file_table.c:280
       task_work_run+0xdd/0x1a0 kernel/task_work.c:164
       tracehook_notify_resume include/linux/tracehook.h:189 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
       exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
       __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
       syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
       do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (&buf->lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3063 [inline]
       check_prevs_add kernel/locking/lockdep.c:3186 [inline]
       validate_chain kernel/locking/lockdep.c:3801 [inline]
       __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5027
       lock_acquire kernel/locking/lockdep.c:5637 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
       __mutex_lock_common kernel/locking/mutex.c:607 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:740
       tty_buffer_flush+0x76/0x2b0 drivers/tty/tty_buffer.c:229
       tty_ldisc_flush+0x66/0xe0 drivers/tty/tty_ldisc.c:400
       __do_SAK.part.0+0xd5/0x390 drivers/tty/tty_io.c:3046
       __do_SAK+0x1b/0x30 drivers/tty/tty_io.c:3039
       vc_SAK+0x7c/0x310 drivers/tty/vt/vt_ioctl.c:992
       process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
       worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
       kthread+0x405/0x4f0 kernel/kthread.c:327
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

other info that might help us debug this:

Chain exists of:
  &buf->lock --> &tty->termios_rwsem --> console_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(console_lock);
                               lock(&tty->termios_rwsem);
                               lock(console_lock);
  lock(&buf->lock);

 *** DEADLOCK ***

4 locks held by kworker/1:16/12546:
 #0: ffff888010c67d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888010c67d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888010c67d38 ((wq_completion)events){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff888010c67d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888010c67d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888010c67d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269
 #1: ffffc90002997db0 ((work_completion)(&vc_cons[currcons].SAK_work)){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
 #2: ffffffff8bb70640 (console_lock){+.+.}-{0:0}, at: vc_SAK+0x10/0x310 drivers/tty/vt/vt_ioctl.c:982
 #3: ffff88806ce96098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref drivers/tty/tty_ldisc.c:273 [inline]
 #3: ffff88806ce96098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_flush+0x18/0xe0 drivers/tty/tty_ldisc.c:398

stack backtrace:
CPU: 1 PID: 12546 Comm: kworker/1:16 Not tainted 5.16.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events vc_SAK
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2143
 check_prev_add kernel/locking/lockdep.c:3063 [inline]
 check_prevs_add kernel/locking/lockdep.c:3186 [inline]
 validate_chain kernel/locking/lockdep.c:3801 [inline]
 __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5027
 lock_acquire kernel/locking/lockdep.c:5637 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
 __mutex_lock_common kernel/locking/mutex.c:607 [inline]
 __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:740
 tty_buffer_flush+0x76/0x2b0 drivers/tty/tty_buffer.c:229
 tty_ldisc_flush+0x66/0xe0 drivers/tty/tty_ldisc.c:400
 __do_SAK.part.0+0xd5/0x390 drivers/tty/tty_io.c:3046
 __do_SAK+0x1b/0x30 drivers/tty/tty_io.c:3039
 vc_SAK+0x7c/0x310 drivers/tty/vt/vt_ioctl.c:992
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
tty tty1: SAK: killed process 6450 (agetty): by session
tty tty1: SAK: killed process 6450 (agetty): by controlling tty


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
