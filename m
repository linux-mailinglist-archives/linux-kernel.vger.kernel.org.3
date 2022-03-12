Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3EB4D7001
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 17:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbiCLQ0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 11:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiCLQ0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 11:26:24 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AFFD5DFB
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 08:25:19 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id y3-20020a056602178300b00645d25c30c1so8849257iox.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 08:25:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=s69sBY0YmWld1QXUobweaIATy6/L04+3j5hZjNIITHc=;
        b=0wGzu/tSOdEMgc3W+/cOBeAA+Wo/C/xJDYTIErnm4nydiNbidhURHbLC+2uN782zmo
         L7zcGaxvO96PR+a8Xq+Sy3O+O6ZnBYamZhnVrWaslR7T05C9l1cAP1uYt1HCZhsnT/1p
         GLNg9jI8K4e4ftFJuzVnlgEvro8U/1BqzssXpWtkt+b7Mb2rkpMQZvjU2gea0Q11x+mR
         /4AxoHrYJ70/w227JEMpwTf4d9Smhz1UOO8YUVf23sBJ+motP+5QkZalExeHyWaRazSG
         xbcf9WY7dF4uUzoIb99o+INcLQNtMuBRsfLq0ZCGfVVCMHeAkDaKYA+GN6xi9Pp/bTOe
         n0oQ==
X-Gm-Message-State: AOAM531pTge/CFwCfAl4TdRAYblnXOMQgzzB2H2WSxReokOovqWz6Up3
        lkxFltCP5b4+u0V/cDmHaTIZQEC8zTBNJ4pOZarjpG1zaxDs
X-Google-Smtp-Source: ABdhPJw/xOD1AsolB+yJ0mduQe6Dl+L263aG73NuzQXWoIvmuKc2jtPhO+aWmKw+UXSBv7cqHyH6EPVvO2/4nSrLqxrcA44wOIYR
MIME-Version: 1.0
X-Received: by 2002:a5d:8d1a:0:b0:633:283d:8959 with SMTP id
 p26-20020a5d8d1a000000b00633283d8959mr12025954ioj.80.1647102318460; Sat, 12
 Mar 2022 08:25:18 -0800 (PST)
Date:   Sat, 12 Mar 2022 08:25:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000099c4ca05da07e42f@google.com>
Subject: [syzbot] possible deadlock in blkdev_put (3)
From:   syzbot <syzbot+6479585dfd4dedd3f7e1@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    68453767131a ARM: Spectre-BHB: provide empty stub for non-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17bd4709700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=16438642a37fea1
dashboard link: https://syzkaller.appspot.com/bug?extid=6479585dfd4dedd3f7e1
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6479585dfd4dedd3f7e1@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.17.0-rc7-syzkaller-00227-g68453767131a #0 Not tainted
------------------------------------------------------
udevd/6428 is trying to acquire lock:
ffff88801d66a938 ((wq_completion)loop3){+.+.}-{0:0}, at: flush_workqueue+0x172/0x16b0 kernel/workqueue.c:2827

but task is already holding lock:
ffff88801ab90918 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0xf8/0x7a0 block/bdev.c:902

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #6 (&disk->open_mutex){+.+.}-{3:3}:
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5639
       __mutex_lock_common+0x1d5/0x2590 kernel/locking/mutex.c:600
       __mutex_lock kernel/locking/mutex.c:733 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:785
       blkdev_get_by_dev+0x169/0xd70 block/bdev.c:804
       swsusp_check+0xb0/0x3f0 kernel/power/swap.c:1526
       software_resume+0xc8/0x3d0 kernel/power/hibernate.c:979
       resume_store+0xdc/0x120 kernel/power/hibernate.c:1181
       kernfs_fop_write_iter+0x3b6/0x510 fs/kernfs/file.c:296
       call_write_iter include/linux/fs.h:2074 [inline]
       new_sync_write fs/read_write.c:503 [inline]
       vfs_write+0xb11/0xe90 fs/read_write.c:590
       ksys_write+0x18f/0x2c0 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #5 (system_transition_mutex/1){+.+.}-{3:3}:
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5639
       __mutex_lock_common+0x1d5/0x2590 kernel/locking/mutex.c:600
       __mutex_lock kernel/locking/mutex.c:733 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:785
       software_resume+0x7a/0x3d0 kernel/power/hibernate.c:934
       resume_store+0xdc/0x120 kernel/power/hibernate.c:1181
       kernfs_fop_write_iter+0x3b6/0x510 fs/kernfs/file.c:296
       call_write_iter include/linux/fs.h:2074 [inline]
       new_sync_write fs/read_write.c:503 [inline]
       vfs_write+0xb11/0xe90 fs/read_write.c:590
       ksys_write+0x18f/0x2c0 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #4 (&of->mutex){+.+.}-{3:3}:
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5639
       __mutex_lock_common+0x1d5/0x2590 kernel/locking/mutex.c:600
       __mutex_lock kernel/locking/mutex.c:733 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:785
       kernfs_seq_start+0x50/0x3b0 fs/kernfs/file.c:112
       seq_read_iter+0x3cd/0xd30 fs/seq_file.c:225
       call_read_iter include/linux/fs.h:2068 [inline]
       new_sync_read fs/read_write.c:400 [inline]
       vfs_read+0xaf9/0xe60 fs/read_write.c:481
       ksys_read+0x18f/0x2c0 fs/read_write.c:619
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #3 (&p->lock){+.+.}-{3:3}:
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5639
       __mutex_lock_common+0x1d5/0x2590 kernel/locking/mutex.c:600
       __mutex_lock kernel/locking/mutex.c:733 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:785
       seq_read_iter+0xad/0xd30 fs/seq_file.c:182
       call_read_iter include/linux/fs.h:2068 [inline]
       generic_file_splice_read+0x482/0x760 fs/splice.c:311
       do_splice_to fs/splice.c:796 [inline]
       splice_direct_to_actor+0x45f/0xd00 fs/splice.c:870
       do_splice_direct+0x291/0x3e0 fs/splice.c:979
       do_sendfile+0x6fe/0x1040 fs/read_write.c:1245
       __do_sys_sendfile64 fs/read_write.c:1310 [inline]
       __se_sys_sendfile64+0x171/0x1d0 fs/read_write.c:1296
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #2 (sb_writers#3){.+.+}-{0:0}:
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5639
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1722 [inline]
       sb_start_write include/linux/fs.h:1792 [inline]
       file_start_write include/linux/fs.h:2937 [inline]
       lo_write_bvec drivers/block/loop.c:243 [inline]
       lo_write_simple drivers/block/loop.c:266 [inline]
       do_req_filebacked drivers/block/loop.c:495 [inline]
       loop_handle_cmd drivers/block/loop.c:1852 [inline]
       loop_process_work+0x167f/0x22b0 drivers/block/loop.c:1892
       process_one_work+0x86c/0x1190 kernel/workqueue.c:2307
       worker_thread+0xab1/0x1300 kernel/workqueue.c:2454
       kthread+0x2a3/0x2d0 kernel/kthread.c:377
       ret_from_fork+0x1f/0x30

-> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5639
       process_one_work+0x83c/0x1190 kernel/workqueue.c:2283
       worker_thread+0xab1/0x1300 kernel/workqueue.c:2454
       kthread+0x2a3/0x2d0 kernel/kthread.c:377
       ret_from_fork+0x1f/0x30

-> #0 ((wq_completion)loop3){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3063 [inline]
       check_prevs_add kernel/locking/lockdep.c:3186 [inline]
       validate_chain+0x1dfb/0x8250 kernel/locking/lockdep.c:3801
       __lock_acquire+0x1382/0x2b00 kernel/locking/lockdep.c:5027
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5639
       flush_workqueue+0x18e/0x16b0 kernel/workqueue.c:2827
       drain_workqueue+0xc3/0x3a0 kernel/workqueue.c:2992
       destroy_workqueue+0x7d/0xed0 kernel/workqueue.c:4429
       __loop_clr_fd+0x1bd/0x980 drivers/block/loop.c:1124
       blkdev_put+0x5a7/0x7a0
       blkdev_close+0x58/0x80 block/fops.c:517
       __fput+0x3fc/0x870 fs/file_table.c:317
       task_work_run+0x146/0x1c0 kernel/task_work.c:164
       tracehook_notify_resume include/linux/tracehook.h:188 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
       exit_to_user_mode_prepare+0x209/0x220 kernel/entry/common.c:207
       __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
       syscall_exit_to_user_mode+0x2e/0x70 kernel/entry/common.c:300
       do_syscall_64+0x53/0xd0 arch/x86/entry/common.c:86
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

1 lock held by udevd/6428:
 #0: ffff88801ab90918 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0xf8/0x7a0 block/bdev.c:902

stack backtrace:
CPU: 0 PID: 6428 Comm: udevd Not tainted 5.17.0-rc7-syzkaller-00227-g68453767131a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106
 check_noncircular+0x2f9/0x3b0 kernel/locking/lockdep.c:2143
 check_prev_add kernel/locking/lockdep.c:3063 [inline]
 check_prevs_add kernel/locking/lockdep.c:3186 [inline]
 validate_chain+0x1dfb/0x8250 kernel/locking/lockdep.c:3801
 __lock_acquire+0x1382/0x2b00 kernel/locking/lockdep.c:5027
 lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5639
 flush_workqueue+0x18e/0x16b0 kernel/workqueue.c:2827
 drain_workqueue+0xc3/0x3a0 kernel/workqueue.c:2992
 destroy_workqueue+0x7d/0xed0 kernel/workqueue.c:4429
 __loop_clr_fd+0x1bd/0x980 drivers/block/loop.c:1124
 blkdev_put+0x5a7/0x7a0
 blkdev_close+0x58/0x80 block/fops.c:517
 __fput+0x3fc/0x870 fs/file_table.c:317
 task_work_run+0x146/0x1c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x209/0x220 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x2e/0x70 kernel/entry/common.c:300
 do_syscall_64+0x53/0xd0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f3819885fc3
Code: 48 ff ff ff b8 ff ff ff ff e9 3e ff ff ff 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8
RSP: 002b:00007ffc29e6f138 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 00007f381972e6a8 RCX: 00007f3819885fc3
RDX: 000000000000001c RSI: 00007ffc29e6e938 RDI: 0000000000000008
RBP: 000055f83c052190 R08: 0000000000000007 R09: 000055f83c057f00
R10: 00007f3819914fc0 R11: 0000000000000246 R12: 0000000000000002
R13: 000055f83c04c1b0 R14: 0000000000000008 R15: 000055f83c028910
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
