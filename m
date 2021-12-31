Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB85848212F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 02:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242460AbhLaBJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 20:09:19 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:40918 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242444AbhLaBJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 20:09:18 -0500
Received: by mail-il1-f198.google.com with SMTP id n3-20020a056e021ba300b002b53500c8feso11001737ili.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 17:09:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=m4S5d2HYQT/0xBsCJOQIhNsszSQGmKNk053SShH2rOU=;
        b=uJaq12/mrZMc9pqlKtrULPb+RfsgzSl9+1RJMl/4KO1m1jGEbIeouJtXuAu6SjoyVi
         gxrhjt+pxElj142NJatZM31JSrI0AFt/CY+ZwqaY8lAyFKiHIZqYUYKX2NOgcnIhnxQq
         VfdiOK/JII5J/c/2pPln7eBfJCi6AOnF1KBlNkZwWUles84ZyLl5UK+526OugoXbqg+/
         SbaMpeC+55wl8GNLdvgIEUToet+ktAaNwjCG2yo9SAp5zbgodQY9Y9F/RWjsiqEBVGdk
         zgC1DlLSytWxU+9XkeIw78TZxW/5iWw6MAP5RyBOhxOA6sDy2CIivW7r1ZejNB9wAmmO
         OJmA==
X-Gm-Message-State: AOAM532U43wFgrXtpY/d8p7gn7tGlRcAtrNRv5q8Z6vuQ3VUjZ0TH/M9
        ldHIMqeNat+0Y/v1CiFO1Kbz4TiZa/oS9RIf6mCULyjH9fbU
X-Google-Smtp-Source: ABdhPJydONTuEgKSfRig3Y69x5CIusox6dbi5+KwMRRudWcCKVTq0Y7glXYb3V27UBXK1xtXPGThgm0o8mYA8CWVzsNu/QUO2LXm
MIME-Version: 1.0
X-Received: by 2002:a05:6602:29c2:: with SMTP id z2mr14953545ioq.196.1640912958052;
 Thu, 30 Dec 2021 17:09:18 -0800 (PST)
Date:   Thu, 30 Dec 2021 17:09:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8dd4e05d466d166@google.com>
Subject: [syzbot] possible deadlock in blkdev_get_by_dev
From:   syzbot <syzbot+a1db28a5dacdaf16ffde@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fc74e0a40e4f Linux 5.16-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d0e97eb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a86c22260afac2f
dashboard link: https://syzkaller.appspot.com/bug?extid=a1db28a5dacdaf16ffde
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a1db28a5dacdaf16ffde@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.16.0-rc7-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.1/13014 is trying to acquire lock:
ffff88801b64d918 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev.part.0+0x40e/0xc70 block/bdev.c:817

but task is already holding lock:
ffffffff8ba51e28 (system_transition_mutex/1){+.+.}-{3:3}, at: software_resume.part.0+0x19/0x1f0 kernel/power/hibernate.c:934

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (system_transition_mutex/1){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:607 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:740
       software_resume.part.0+0x19/0x1f0 kernel/power/hibernate.c:934
       software_resume kernel/power/hibernate.c:86 [inline]
       resume_store+0x161/0x190 kernel/power/hibernate.c:1181
       kobj_attr_store+0x50/0x80 lib/kobject.c:856
       sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:136
       kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
       call_write_iter include/linux/fs.h:2162 [inline]
       new_sync_write+0x429/0x660 fs/read_write.c:503
       vfs_write+0x7cd/0xae0 fs/read_write.c:590
       ksys_write+0x12d/0x250 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #6 (&of->mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:607 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:740
       kernfs_seq_start+0x4b/0x260 fs/kernfs/file.c:112
       seq_read_iter+0x2c6/0x1280 fs/seq_file.c:225
       kernfs_fop_read_iter+0x44f/0x5f0 fs/kernfs/file.c:241
       call_read_iter include/linux/fs.h:2156 [inline]
       new_sync_read+0x421/0x6e0 fs/read_write.c:400
       vfs_read+0x35c/0x600 fs/read_write.c:481
       ksys_read+0x12d/0x250 fs/read_write.c:619
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #5 (&p->lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:607 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:740
       seq_read_iter+0xdf/0x1280 fs/seq_file.c:182
       call_read_iter include/linux/fs.h:2156 [inline]
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

-> #4 (sb_writers#3){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1810 [inline]
       sb_start_write include/linux/fs.h:1880 [inline]
       file_start_write include/linux/fs.h:3008 [inline]
       lo_write_bvec drivers/block/loop.c:242 [inline]
       lo_write_simple drivers/block/loop.c:265 [inline]
       do_req_filebacked drivers/block/loop.c:494 [inline]
       loop_handle_cmd drivers/block/loop.c:1857 [inline]
       loop_process_work+0x1499/0x1db0 drivers/block/loop.c:1897
       process_one_work+0x9b2/0x1660 kernel/workqueue.c:2298
       worker_thread+0x65d/0x1130 kernel/workqueue.c:2445
       kthread+0x405/0x4f0 kernel/kthread.c:327
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #3 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
       process_one_work+0x921/0x1660 kernel/workqueue.c:2274
       worker_thread+0x65d/0x1130 kernel/workqueue.c:2445
       kthread+0x405/0x4f0 kernel/kthread.c:327
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #2 ((wq_completion)loop4){+.+.}-{0:0}:
       flush_workqueue+0x110/0x13a0 kernel/workqueue.c:2818
       drain_workqueue+0x1a5/0x3c0 kernel/workqueue.c:2983
       destroy_workqueue+0x71/0x800 kernel/workqueue.c:4420
       __loop_clr_fd+0x1de/0x1070 drivers/block/loop.c:1124
       lo_release+0x1ac/0x1f0 drivers/block/loop.c:1761
       blkdev_put_whole block/bdev.c:694 [inline]
       blkdev_put+0x2de/0x950 block/bdev.c:957
       deactivate_locked_super+0x94/0x160 fs/super.c:335
       deactivate_super+0xad/0xd0 fs/super.c:366
       cleanup_mnt+0x3a2/0x540 fs/namespace.c:1137
       task_work_run+0xdd/0x1a0 kernel/task_work.c:164
       tracehook_notify_resume include/linux/tracehook.h:189 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
       exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
       __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
       syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
       do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #1 (&lo->lo_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:607 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:740
       lo_open+0x75/0x120 drivers/block/loop.c:1733
       blkdev_get_whole+0x99/0x2d0 block/bdev.c:671
       blkdev_get_by_dev.part.0+0x5c6/0xc70 block/bdev.c:826
       blkdev_get_by_dev+0x6b/0x80 block/bdev.c:860
       blkdev_open+0x154/0x2e0 block/fops.c:501
       do_dentry_open+0x4b9/0x1240 fs/open.c:822
       do_open fs/namei.c:3426 [inline]
       path_openat+0x1cad/0x2750 fs/namei.c:3559
       do_filp_open+0x1aa/0x400 fs/namei.c:3586
       do_sys_openat2+0x16d/0x4d0 fs/open.c:1212
       do_sys_open fs/open.c:1228 [inline]
       __do_sys_openat fs/open.c:1244 [inline]
       __se_sys_openat fs/open.c:1239 [inline]
       __x64_sys_openat+0x13f/0x1f0 fs/open.c:1239
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (&disk->open_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3063 [inline]
       check_prevs_add kernel/locking/lockdep.c:3186 [inline]
       validate_chain kernel/locking/lockdep.c:3801 [inline]
       __lock_acquire+0x2a2c/0x5470 kernel/locking/lockdep.c:5027
       lock_acquire kernel/locking/lockdep.c:5637 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
       __mutex_lock_common kernel/locking/mutex.c:607 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:740
       blkdev_get_by_dev.part.0+0x40e/0xc70 block/bdev.c:817
       blkdev_get_by_dev+0x6b/0x80 block/bdev.c:860
       swsusp_check+0x97/0x2f0 kernel/power/swap.c:1520
       software_resume.part.0+0x102/0x1f0 kernel/power/hibernate.c:979
       software_resume kernel/power/hibernate.c:86 [inline]
       resume_store+0x161/0x190 kernel/power/hibernate.c:1181
       kobj_attr_store+0x50/0x80 lib/kobject.c:856
       sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:136
       kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
       call_write_iter include/linux/fs.h:2162 [inline]
       new_sync_write+0x429/0x660 fs/read_write.c:503
       vfs_write+0x7cd/0xae0 fs/read_write.c:590
       ksys_write+0x12d/0x250 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

Chain exists of:
  &disk->open_mutex --> &of->mutex --> system_transition_mutex/1

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(system_transition_mutex/1);
                               lock(&of->mutex);
                               lock(system_transition_mutex/1);
  lock(&disk->open_mutex);

 *** DEADLOCK ***

5 locks held by syz-executor.1/13014:
 #0: ffff888021bff9f0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:1034
 #1: ffff888022bf0460 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12d/0x250 fs/read_write.c:643
 #2: ffff888073515888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x287/0x500 fs/kernfs/file.c:287
 #3: ffff888011918830 (kn->active#782){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2ab/0x500 fs/kernfs/file.c:288
 #4: ffffffff8ba51e28 (system_transition_mutex/1){+.+.}-{3:3}, at: software_resume.part.0+0x19/0x1f0 kernel/power/hibernate.c:934

stack backtrace:
CPU: 0 PID: 13014 Comm: syz-executor.1 Not tainted 5.16.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2143
 check_prev_add kernel/locking/lockdep.c:3063 [inline]
 check_prevs_add kernel/locking/lockdep.c:3186 [inline]
 validate_chain kernel/locking/lockdep.c:3801 [inline]
 __lock_acquire+0x2a2c/0x5470 kernel/locking/lockdep.c:5027
 lock_acquire kernel/locking/lockdep.c:5637 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
 __mutex_lock_common kernel/locking/mutex.c:607 [inline]
 __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:740
 blkdev_get_by_dev.part.0+0x40e/0xc70 block/bdev.c:817
 blkdev_get_by_dev+0x6b/0x80 block/bdev.c:860
 swsusp_check+0x97/0x2f0 kernel/power/swap.c:1520
 software_resume.part.0+0x102/0x1f0 kernel/power/hibernate.c:979
 software_resume kernel/power/hibernate.c:86 [inline]
 resume_store+0x161/0x190 kernel/power/hibernate.c:1181
 kobj_attr_store+0x50/0x80 lib/kobject.c:856
 sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:136
 kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
 call_write_iter include/linux/fs.h:2162 [inline]
 new_sync_write+0x429/0x660 fs/read_write.c:503
 vfs_write+0x7cd/0xae0 fs/read_write.c:590
 ksys_write+0x12d/0x250 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7eff8b85ae99
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007eff8a1d0168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007eff8b96df60 RCX: 00007eff8b85ae99
RDX: 0000000000000012 RSI: 0000000020000080 RDI: 0000000000000004
RBP: 00007eff8b8b4ff1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff843e579f R14: 00007eff8a1d0300 R15: 0000000000022000
 </TASK>
PM: Image not found (code -22)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
