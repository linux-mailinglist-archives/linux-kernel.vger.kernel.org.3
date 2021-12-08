Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79CA46CCCE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 06:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhLHFIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 00:08:50 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:42594 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhLHFIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 00:08:49 -0500
Received: by mail-io1-f71.google.com with SMTP id k125-20020a6bba83000000b005e7a312f86dso1569351iof.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 21:05:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=t/a2vUiotzqqgjMJvwYSkM0MlwqccHzkT5S+jPOz1Uc=;
        b=xPAnoRq7tdA4YY655ibZ0ErSLcW8tKmJbxP95wL+PAi8q7b4svBeNiJcYkO2kg5z8j
         6CSpol9DpAgX2bu1hqat9WqhXxPEwAW6y1HZJ35La91EY/VAuf8rwiuCHoX56iu94uvI
         Bv8DXjKLulZt3YzXOX3mZLSKheACHqGu0q6oecEOB8sSupPNPHqOe7T6nMRlrFx9Ht/z
         WECaHCVBypvUxJDYGGs6t11cUxJ06xNwCjYDxncaVJ6QZCRdtl18esHLaB/ZsT3cJWzR
         87wOSvPkHlVgwRNFPlbANIluPUra2NL0+Pm9rKcdMKxVPvcKC29o4c4/ZpSREInNITYp
         AJDw==
X-Gm-Message-State: AOAM533zwBpvs4hyBuMlStTQA3XJt/7WiFxWjnmlcXlIRralCRdzBfJN
        LNVaVVLC6ynmM+I/MKcl+/Cb4HeanT90cbGeFMnUlCmGDeHy
X-Google-Smtp-Source: ABdhPJzsynK9xcyIHbDj8sgxe9i9xmDWyeXIkjU4BI+2jkT8BGNW2oGfAMtwdT5ZaQmBMCgxmnWRqAZ6Gz0J6Ai2N1gurX8fIiyk
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1906:: with SMTP id w6mr4228685ilu.192.1638939917936;
 Tue, 07 Dec 2021 21:05:17 -0800 (PST)
Date:   Tue, 07 Dec 2021 21:05:17 -0800
In-Reply-To: <0000000000007f2f5405d1bfe618@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009debe105d29b6fb4@google.com>
Subject: Re: [syzbot] possible deadlock in blkdev_put (2)
From:   syzbot <syzbot+643e4ce4b6ad1347d372@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    04fe99a8d936 Add linux-next specific files for 20211207
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1315e2b9b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4589399873466942
dashboard link: https://syzkaller.appspot.com/bug?extid=643e4ce4b6ad1347d372
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11bb96ceb00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ad1badb00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+643e4ce4b6ad1347d372@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.16.0-rc4-next-20211207-syzkaller #0 Not tainted
------------------------------------------------------
systemd-udevd/7081 is trying to acquire lock:
ffff88802358c938 ((wq_completion)loop3){+.+.}-{0:0}, at: flush_workqueue+0xe1/0x15b0 kernel/workqueue.c:2835

but task is already holding lock:
ffff88801a57a118 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0x99/0x980 block/bdev.c:907

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #6 (&disk->open_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:607 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:740
       blkdev_get_by_dev.part.0+0x40e/0xc70 block/bdev.c:809
       blkdev_get_by_dev+0x6b/0x80 block/bdev.c:852
       swsusp_check+0x97/0x2f0 kernel/power/swap.c:1520
       software_resume.part.0+0x102/0x1f0 kernel/power/hibernate.c:979
       software_resume kernel/power/hibernate.c:86 [inline]
       resume_store+0x161/0x190 kernel/power/hibernate.c:1181
       kobj_attr_store+0x50/0x80 lib/kobject.c:856
       sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:136
       kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
       call_write_iter include/linux/fs.h:2079 [inline]
       new_sync_write+0x429/0x660 fs/read_write.c:503
       vfs_write+0x7cd/0xae0 fs/read_write.c:590
       ksys_write+0x12d/0x250 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #5 (system_transition_mutex/1){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:607 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:740
       software_resume.part.0+0x19/0x1f0 kernel/power/hibernate.c:934
       software_resume kernel/power/hibernate.c:86 [inline]
       resume_store+0x161/0x190 kernel/power/hibernate.c:1181
       kobj_attr_store+0x50/0x80 lib/kobject.c:856
       sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:136
       kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
       call_write_iter include/linux/fs.h:2079 [inline]
       new_sync_write+0x429/0x660 fs/read_write.c:503
       vfs_write+0x7cd/0xae0 fs/read_write.c:590
       ksys_write+0x12d/0x250 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #4 (&of->mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:607 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:740
       kernfs_seq_start+0x4b/0x260 fs/kernfs/file.c:112
       seq_read_iter+0x2c7/0x1240 fs/seq_file.c:225
       kernfs_fop_read_iter+0x44f/0x5f0 fs/kernfs/file.c:241
       call_read_iter include/linux/fs.h:2073 [inline]
       new_sync_read+0x421/0x6e0 fs/read_write.c:400
       vfs_read+0x35c/0x600 fs/read_write.c:481
       ksys_read+0x12d/0x250 fs/read_write.c:619
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #3 (&p->lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:607 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:740
       seq_read_iter+0xdf/0x1240 fs/seq_file.c:182
       call_read_iter include/linux/fs.h:2073 [inline]
       generic_file_splice_read+0x453/0x6d0 fs/splice.c:311
       do_splice_to+0x1bf/0x250 fs/splice.c:796
       splice_direct_to_actor+0x2c2/0x8c0 fs/splice.c:870
       do_splice_direct+0x1b3/0x280 fs/splice.c:979
       do_sendfile+0xaf2/0x1250 fs/read_write.c:1245
       __do_sys_sendfile64 fs/read_write.c:1310 [inline]
       __se_sys_sendfile64 fs/read_write.c:1296 [inline]
       __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1296
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #2 (sb_writers#3){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1727 [inline]
       sb_start_write include/linux/fs.h:1797 [inline]
       file_start_write include/linux/fs.h:2942 [inline]
       lo_write_bvec drivers/block/loop.c:242 [inline]
       lo_write_simple drivers/block/loop.c:265 [inline]
       do_req_filebacked drivers/block/loop.c:494 [inline]
       loop_handle_cmd drivers/block/loop.c:1846 [inline]
       loop_process_work+0x1499/0x1db0 drivers/block/loop.c:1886
       process_one_work+0x9b2/0x1690 kernel/workqueue.c:2318
       worker_thread+0x658/0x11f0 kernel/workqueue.c:2465
       kthread+0x405/0x4f0 kernel/kthread.c:345
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
       process_one_work+0x921/0x1690 kernel/workqueue.c:2294
       worker_thread+0x658/0x11f0 kernel/workqueue.c:2465
       kthread+0x405/0x4f0 kernel/kthread.c:345
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #0 ((wq_completion)loop3){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3063 [inline]
       check_prevs_add kernel/locking/lockdep.c:3186 [inline]
       validate_chain kernel/locking/lockdep.c:3801 [inline]
       __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5027
       lock_acquire kernel/locking/lockdep.c:5637 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
       flush_workqueue+0x110/0x15b0 kernel/workqueue.c:2838
       drain_workqueue+0x1a5/0x3c0 kernel/workqueue.c:3003
       destroy_workqueue+0x71/0x800 kernel/workqueue.c:4440
       __loop_clr_fd+0x1ab/0xe20 drivers/block/loop.c:1118
       lo_release+0x1ac/0x1f0 drivers/block/loop.c:1750
       blkdev_put_whole block/bdev.c:694 [inline]
       blkdev_put+0x2de/0x980 block/bdev.c:949
       blkdev_close+0x6a/0x80 block/fops.c:516
       __fput+0x286/0x9f0 fs/file_table.c:311
       task_work_run+0xdd/0x1a0 kernel/task_work.c:164
       tracehook_notify_resume include/linux/tracehook.h:189 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
       exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
       __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
       syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
       do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

Chain exists of:
  (wq_completion)loop3 --> system_transition_mutex/1 --> &disk->open_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&disk->open_mutex);
                               lock(system_transition_mutex/1);
                               lock(&disk->open_mutex);
  lock((wq_completion)loop3);

 *** DEADLOCK ***

1 lock held by systemd-udevd/7081:
 #0: ffff88801a57a118 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0x99/0x980 block/bdev.c:907

stack backtrace:
CPU: 1 PID: 7081 Comm: systemd-udevd Not tainted 5.16.0-rc4-next-20211207-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
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
 flush_workqueue+0x110/0x15b0 kernel/workqueue.c:2838
 drain_workqueue+0x1a5/0x3c0 kernel/workqueue.c:3003
 destroy_workqueue+0x71/0x800 kernel/workqueue.c:4440
 __loop_clr_fd+0x1ab/0xe20 drivers/block/loop.c:1118
 lo_release+0x1ac/0x1f0 drivers/block/loop.c:1750
 blkdev_put_whole block/bdev.c:694 [inline]
 blkdev_put+0x2de/0x980 block/bdev.c:949
 blkdev_close+0x6a/0x80 block/fops.c:516
 __fput+0x286/0x9f0 fs/file_table.c:311
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f5387c2b270
Code: 73 01 c3 48 8b 0d 38 7d 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 59 c1 20 00 00 75 10 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ee fb ff ff 48 89 04 24
RSP: 002b:00007ffce06abcb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000007 RCX: 00007f5387c2b270
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
RBP: 00007f5388ae5710 R08: 00005621f86a7af0 R09: 00005621f86b5700
R10: 00007f5388ae58c0 R11: 0000000000000246 R12: 0000000000000000
R13: 00005621f86a3e40 R14: 0000000000000003 R15: 000000000000000e
 </TASK>
I/O error, dev loop2, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
I/O error, dev loop2, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
I/O error, dev loop2, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
Buffer I/O error on dev loop2, logical block 0, async page read
I/O error, dev loop3, sector 1 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
Buffer I/O error on dev loop3, logical block 1, async page read
I/O error, dev loop3, sector 1 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
Buffer I/O error on dev loop3, logical block 1, async page read

