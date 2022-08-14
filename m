Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EC9591EDD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 09:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiHNHMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 03:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiHNHMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 03:12:13 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C3A186F0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 00:12:09 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id l20-20020a056e02067400b002dfa7256498so3238868ilt.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 00:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=8wUgf5VDZx6wwjppMLyY/XN1brlbBrMGA7VneT5DXvU=;
        b=10HFeF1JNBYpGzHbwubLUrlArfa8hrMDENH8SMdKTF3VUevcXl/bCvnoaizO16L1f2
         ijHsGsTfu6URMMZ8Kt6UZ4My0r0zAAGv/9+g2krfG4tY8OvlSsWfSl4xwCx1r6y9f1VH
         N/saLRkOdqtRRXF53aQm1Lgd9uM8OEHU8nrZ3RYUkIaYZdTEjec7DmaAhUavErWx/Ug6
         CfdLe8XNtkfnRsIa9Cu7P4V6OGpsSBH9zA42PQQYqs6Zv02sSsVrDG/IZh5DFHCHdEI8
         h4OGAWXv0lVQxk+rgZjJH+blk9qq26NA/XH05gVvnC09Oaj6IPcHH4CyxzDqdg/gzvvw
         bGqA==
X-Gm-Message-State: ACgBeo0NUwpTPLYAKTmBHP28KIft/V29ppb9jnx3aHRIy6GNyExwX6O5
        DZOsfCqiwBogqYOkEYgdMXI3f1QcZMlaMcqSv15sxakeozXD
X-Google-Smtp-Source: AA6agR72xvbcneZb9y/NGpj+xea2mPkb7C4Oo9NDJXzx9v+bLYLBV2p4+KRaf0jhhSxQXqwfiSWMDHwHpmg7Era4dqUWkYof+FaE
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14c5:b0:343:4296:3d28 with SMTP id
 l5-20020a05663814c500b0034342963d28mr5202129jak.36.1660461128957; Sun, 14 Aug
 2022 00:12:08 -0700 (PDT)
Date:   Sun, 14 Aug 2022 00:12:08 -0700
In-Reply-To: <20220814035942.832-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c143f005e62e3bb8@google.com>
Subject: Re: [syzbot] INFO: task hung in __generic_file_fsync (3)
From:   syzbot <syzbot+ed920a72fd23eb735158@syzkaller.appspotmail.com>
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
INFO: task hung in fat_setattr

INFO: task syz-executor.2:4217 blocked for more than 143 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:25912 pid: 4217 ppid:  4084 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5178 [inline]
 __schedule+0xa00/0x4c10 kernel/sched/core.c:6490
 schedule+0xda/0x1b0 kernel/sched/core.c:6566
 inode_dio_wait+0x174/0x1f0 fs/inode.c:2383
 fat_setattr+0x3de/0x13c0 fs/fat/file.c:509
 notify_change+0xcd0/0x1440 fs/attr.c:418
 do_truncate+0x13c/0x200 fs/open.c:65
 do_sys_ftruncate+0x536/0x730 fs/open.c:193
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f48c7289209
RSP: 002b:00007f48c84d4168 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 00007f48c739bf60 RCX: 00007f48c7289209
RDX: 0000000000000000 RSI: 00000000010099b8 RDI: 0000000000000004
RBP: 00007f48c72e3161 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd50179e6f R14: 00007f48c84d4300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.2:4218 blocked for more than 143 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:26600 pid: 4218 ppid:  4084 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5178 [inline]
 __schedule+0xa00/0x4c10 kernel/sched/core.c:6490
 schedule+0xda/0x1b0 kernel/sched/core.c:6566
 rwsem_down_write_slowpath+0x697/0x11e0 kernel/locking/rwsem.c:1182
 __down_write_common kernel/locking/rwsem.c:1297 [inline]
 __down_write_common kernel/locking/rwsem.c:1294 [inline]
 __down_write kernel/locking/rwsem.c:1306 [inline]
 down_write+0x135/0x150 kernel/locking/rwsem.c:1553
 inode_lock include/linux/fs.h:761 [inline]
 generic_file_write_iter+0x8a/0x220 mm/filemap.c:3901
 call_write_iter include/linux/fs.h:2188 [inline]
 aio_write+0x34a/0x7a0 fs/aio.c:1603
 __io_submit_one fs/aio.c:1975 [inline]
 io_submit_one+0xf9c/0x1c70 fs/aio.c:2022
 __do_sys_io_submit fs/aio.c:2081 [inline]
 __se_sys_io_submit fs/aio.c:2051 [inline]
 __x64_sys_io_submit+0x18c/0x330 fs/aio.c:2051
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f48c7289209
RSP: 002b:00007f48c84aa168 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007f48c739c030 RCX: 00007f48c7289209
RDX: 0000000020000540 RSI: 0000000000001801 RDI: 00007f48c84ab000
RBP: 00007f48c72e3161 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd50179e6f R14: 00007f48c84aa300 R15: 0000000000022000
 </TASK>
INFO: task dio/loop2:4221 blocked for more than 143 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:dio/loop2       state:D stack:28888 pid: 4221 ppid:     2 flags:0x00004000
Workqueue: dio/loop2 dio_aio_complete_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5178 [inline]
 __schedule+0xa00/0x4c10 kernel/sched/core.c:6490
 schedule+0xda/0x1b0 kernel/sched/core.c:6566
 rwsem_down_write_slowpath+0x697/0x11e0 kernel/locking/rwsem.c:1182
 __down_write_common kernel/locking/rwsem.c:1297 [inline]
 __down_write_common kernel/locking/rwsem.c:1294 [inline]
 __down_write kernel/locking/rwsem.c:1306 [inline]
 down_write+0x135/0x150 kernel/locking/rwsem.c:1553
 inode_lock include/linux/fs.h:761 [inline]
 __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
 fat_file_fsync+0x73/0x200 fs/fat/file.c:191
 vfs_fsync_range+0x13a/0x220 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2862 [inline]
 dio_complete+0x733/0x9a0 fs/direct-io.c:310
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 process_scheduled_works kernel/workqueue.c:2352 [inline]
 rescuer_thread+0x5a0/0xcf0 kernel/workqueue.c:2543
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/0:0/6:
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900000b7da8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880693223b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880693223b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8bd86870 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8bd86570 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
3 locks held by kworker/0:1/14:
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90000137da8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880693223b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880693223b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:0/22:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900001c7da8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:1/26:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90000a1fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
1 lock held by khungtaskd/28:
 #0: ffffffff8bd873c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6492
3 locks held by kworker/1:2/139:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000295fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:3/2930:
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000b197da8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880693223b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880693223b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
2 locks held by getty/3279:
 #0: ffff88814a6cb098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002d162e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xe50/0x13c0 drivers/tty/n_tty.c:2124
3 locks held by kworker/1:3/3618:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000307fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:4/3619:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000309fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:5/3621:
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000315fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880693223b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880693223b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:5/4124:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000376fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:6/4125:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000377fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:7/4132:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000378fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:8/4186:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900038bfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:9/4187:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900038cfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:10/4188:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900038dfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:11/4189:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900038efda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:12/4190:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900038ffda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:13/4191:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000390fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:14/4192:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000391fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:15/4193:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000392fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:16/4194:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000393fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:17/4195:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000394fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:18/4196:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000395fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:19/4197:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000396fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:20/4198:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000397fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:21/4199:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000398fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:22/4200:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000399fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:23/4201:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900039afda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:24/4202:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900039bfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:25/4203:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900039cfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:26/4204:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900039dfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:27/4205:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900039efda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:28/4206:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900039ffda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:29/4207:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003a0fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:30/4208:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003a1fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:31/4209:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003a2fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:32/4210:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003a3fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:33/4211:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003a4fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:34/4212:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003a5fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:35/4213:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003a6fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
2 locks held by syz-executor.2/4217:
 #0: ffff88807ed60460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 #0: ffff88807ed60460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 #1: ffff88806ae99d10 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #1: ffff88806ae99d10 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: do_truncate+0x12a/0x200 fs/open.c:63
1 lock held by syz-executor.2/4218:
 #0: ffff88806ae99d10 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #0: ffff88806ae99d10 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: generic_file_write_iter+0x8a/0x220 mm/filemap.c:3901
3 locks held by dio/loop2/4221:
 #0: ffff88801834d938 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88801834d938 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88801834d938 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88801834d938 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88801834d938 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88801834d938 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003adfd58 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806ae99d10 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806ae99d10 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:7/4222:
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000382fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880693223b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880693223b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:36/4651:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90004c17da8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:37/4652:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90005127da8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:38/4709:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90005537da8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:39/4741:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90005717da8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:23/4881:
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90005b1fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880693223b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880693223b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
2 locks held by syz-executor.3/4897:
 #0: ffff88806a6d0460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 #0: ffff88806a6d0460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 #1: ffff8880693223b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #1: ffff8880693223b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: do_truncate+0x12a/0x200 fs/open.c:63
1 lock held by syz-executor.3/4901:
 #0: ffff8880693223b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #0: ffff8880693223b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: generic_file_write_iter+0x8a/0x220 mm/filemap.c:3901
3 locks held by dio/loop3/4906:
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888078cc0938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000a10fd58 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880693223b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880693223b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
2 locks held by syz-executor.1/5051:
 #0: ffff888077b46460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 #0: ffff888077b46460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 #1: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #1: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: do_truncate+0x12a/0x200 fs/open.c:63
1 lock held by syz-executor.1/5056:
 #0: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #0: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: generic_file_write_iter+0x8a/0x220 mm/filemap.c:3901
3 locks held by dio/loop1/5057:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000a6dfd58 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:40/5063:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000a86fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff8880668623b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:41/5064:
 #0: ffff8880211a9538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set a

Tested on:

commit:         200e340f Merge tag 'pull-work.dcache' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12ee336b080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a3f4d6985d3164cd
dashboard link: https://syzkaller.appspot.com/bug?extid=ed920a72fd23eb735158
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1606594b080000

