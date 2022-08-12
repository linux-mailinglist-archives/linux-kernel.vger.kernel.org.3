Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A357F5911A6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239008AbiHLNlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbiHLNlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:41:14 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7C95C9C1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:41:11 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id z9-20020a056e02088900b002e35dba878cso565438ils.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=G7I/Lexj55NQ3jiruS3LsN9iEcs6N2cqMczmUbd1nXY=;
        b=Dn2fJXnMURNiHWp2GXI74dS6sT2fH1hnoqUekIxy5ic5L4QVpATpDkPY7Ikhmk/e+Q
         U3UwXk9jIWjW/KibrXhVMoPFFuvUI3Bp82XSpBGeFcBQFDky2/tLI4fkPQg+i02clGTD
         /QIuLPpbkrbtVGYaP37qt/ffeieZlQOG+OIQILCpNL4NmNdZuSaY1GmjPR3iW9V61zBb
         7uftnPmVI8GJgk1+ySvz9l1785RU3kSycYDPCQOn29UOKw2yp/wy4w56jNuTmgnQag0h
         3MyIeSf4baBv7Rp8CrQV1mfuUggkpXugFfXaaAs4doBwkSucWRSxfKHbM0kBiGfV/m3J
         rTKA==
X-Gm-Message-State: ACgBeo0xIRw58eqOSV2dvfpcp38j/xs6IXZ4YuJ3yzUBfJDK/OhmWZbC
        BRVVaaA8vBXPk4+W5xo5Rnf1r+HtcVZGBNOyOrm0R8rsbGR1
X-Google-Smtp-Source: AA6agR6pRYj1i3egDPlZCM4SQQuKZ9iD/IRTvkCQdUwnizYGgXHSXX1XKcRwVz2lsiFASPtvBPoiZUKuPhvYuxoXnrmXMDSar53Q
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2601:b0:343:4507:d624 with SMTP id
 m1-20020a056638260100b003434507d624mr1966301jat.269.1660311671066; Fri, 12
 Aug 2022 06:41:11 -0700 (PDT)
Date:   Fri, 12 Aug 2022 06:41:11 -0700
In-Reply-To: <20220812112034.2871-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ed50305e60b6f1c@google.com>
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

INFO: task syz-executor.5:4192 blocked for more than 143 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:25792 pid: 4192 ppid:  4077 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5178 [inline]
 __schedule+0xa00/0x4c10 kernel/sched/core.c:6490
 schedule+0xda/0x1b0 kernel/sched/core.c:6566
 __inode_dio_wait fs/inode.c:2381 [inline]
 inode_dio_wait+0x22a/0x270 fs/inode.c:2399
 fat_setattr+0x3de/0x13c0 fs/fat/file.c:509
 notify_change+0xcd0/0x1440 fs/attr.c:418
 do_truncate+0x13c/0x200 fs/open.c:65
 do_sys_ftruncate+0x536/0x730 fs/open.c:193
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f28df889209
RSP: 002b:00007f28e0a57168 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 00007f28df99bf60 RCX: 00007f28df889209
RDX: 0000000000000000 RSI: 00000000010099b8 RDI: 0000000000000004
RBP: 00007f28df8e3161 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffee5fd54ef R14: 00007f28e0a57300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.5:4194 blocked for more than 144 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:26536 pid: 4194 ppid:  4077 flags:0x00000004
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
 inode_lock include/linux/fs.h:760 [inline]
 generic_file_write_iter+0x8a/0x220 mm/filemap.c:3901
 call_write_iter include/linux/fs.h:2187 [inline]
 aio_write+0x34a/0x7a0 fs/aio.c:1603
 __io_submit_one fs/aio.c:1975 [inline]
 io_submit_one+0xf9c/0x1c70 fs/aio.c:2022
 __do_sys_io_submit fs/aio.c:2081 [inline]
 __se_sys_io_submit fs/aio.c:2051 [inline]
 __x64_sys_io_submit+0x18c/0x330 fs/aio.c:2051
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f28df889209
RSP: 002b:00007f28e0a2d168 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007f28df99c030 RCX: 00007f28df889209
RDX: 0000000020000540 RSI: 0000000000001801 RDI: 00007f28e0a2e000
RBP: 00007f28df8e3161 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffee5fd54ef R14: 00007f28e0a2d300 R15: 0000000000022000
 </TASK>
INFO: task dio/loop5:4196 blocked for more than 144 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:dio/loop5       state:D stack:28888 pid: 4196 ppid:     2 flags:0x00004000
Workqueue: dio/loop5 dio_aio_complete_work
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
 inode_lock include/linux/fs.h:760 [inline]
 __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
 fat_file_fsync+0x73/0x200 fs/fat/file.c:191
 vfs_fsync_range+0x13a/0x220 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2861 [inline]
 dio_complete+0x6dd/0x950 fs/direct-io.c:310
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 process_scheduled_works kernel/workqueue.c:2352 [inline]
 rescuer_thread+0x5a0/0xcf0 kernel/workqueue.c:2543
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8bd86870 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8bd86570 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/28:
 #0: ffffffff8bd873c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6492
3 locks held by kworker/u4:2/39:
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90000b07da8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888073649bd0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff888073649bd0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/u4:5/2412:
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000a01fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888073649bd0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff888073649bd0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
1 lock held by klogd/2958:
 #0: ffff8880b9b39f58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2b/0x120 kernel/sched/core.c:544
2 locks held by getty/3278:
 #0: ffff88807f078098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002d162e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xe50/0x13c0 drivers/tty/n_tty.c:2124
1 lock held by syz-executor.2/4068:
 #0: ffffffff8bd92038 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:292 [inline]
 #0: ffffffff8bd92038 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x562/0x670 kernel/rcu/tree_exp.h:940
2 locks held by kworker/1:8/4120:
 #0: ffff888011866538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888011866538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888011866538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888011866538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888011866538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888011866538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900036ffda8 ((work_completion)(&rew->rew_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
2 locks held by syz-executor.5/4192:
 #0: ffff88807692c460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 #0: ffff88807692c460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 #1: ffff88806a422ec0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #1: ffff88806a422ec0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: do_truncate+0x12a/0x200 fs/open.c:63
1 lock held by syz-executor.5/4194:
 #0: ffff88806a422ec0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #0: ffff88806a422ec0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: generic_file_write_iter+0x8a/0x220 mm/filemap.c:3901
3 locks held by dio/loop5/4196:
 #0: ffff88806ea36938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806ea36938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806ea36938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806ea36938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806ea36938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806ea36938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000394fd58 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a422ec0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a422ec0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/u4:12/4205:
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900039bfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888073649bd0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff888073649bd0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/u4:16/4211:
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900039efda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888073649bd0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff888073649bd0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/u4:20/4220:
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003a7fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888073649bd0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff888073649bd0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/u4:25/4241:
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003b2fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888073649bd0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff888073649bd0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/u4:27/4243:
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003b4fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888073649bd0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff888073649bd0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
2 locks held by syz-executor.1/4295:
 #0: ffff888067196460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 #0: ffff888067196460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 #1: ffff888073649bd0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #1: ffff888073649bd0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: do_truncate+0x12a/0x200 fs/open.c:63
1 lock held by syz-executor.1/4304:
 #0: ffff888073649bd0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #0: ffff888073649bd0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: generic_file_write_iter+0x8a/0x220 mm/filemap.c:3901
2 locks held by syz-executor.4/4297:
 #0: ffff88807bd84460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 #0: ffff88807bd84460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 #1: ffff88806a482220 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #1: ffff88806a482220 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: do_truncate+0x12a/0x200 fs/open.c:63
1 lock held by syz-executor.4/4305:
 #0: ffff88806a482220 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #0: ffff88806a482220 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: generic_file_write_iter+0x8a/0x220 mm/filemap.c:3901
2 locks held by syz-executor.3/4301:
 #0: ffff888067194460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 #0: ffff888067194460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 #1: ffff888073649580 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #1: ffff888073649580 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: do_truncate+0x12a/0x200 fs/open.c:63
1 lock held by syz-executor.3/4303:
 #0: ffff888073649580 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #0: ffff888073649580 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: generic_file_write_iter+0x8a/0x220 mm/filemap.c:3901
3 locks held by dio/loop4/4309:
 #0: ffff88802352f938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88802352f938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88802352f938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88802352f938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88802352f938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88802352f938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003e5fd58 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a482220 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a482220 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by dio/loop1/4311:
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b9c8938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003e8fd58 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888073649bd0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff888073649bd0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by dio/loop3/4312:
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003e9fd58 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888073649580 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff888073649580 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/u4:32/4315:
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003ecfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888073649580 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff888073649580 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/u4:33/4318:
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003effda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888073649580 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff888073649580 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/u4:34/4319:
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003f0fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888073649580 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff888073649580 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/u4:35/4320:
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003f1fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888073649580 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff888073649580 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/u4:36/4321:
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003f2fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888073649580 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff888073649580 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/u4:37/4322:
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003f3fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888073649580 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff888073649580 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/u4:38/4323:
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003f4fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888073649580 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff888073649580 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/u4:39/4324:
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003f5fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888073649580 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff888073649580 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/u4:40/4325:
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003f6fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888073649580 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff888073649580 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/u4:46/4331:
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b9ca138 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003fcfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888073649580 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff888073649580 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
1 lock held by syz-executor.4/4438:
 #0: ffff8880b9b39f58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2b/0x120 kernel/sched/core.c:544

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1e6/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:212 [inline]
 watchdog+0xc1d/0xf50 kernel/hung_task.c:369
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 4379 Comm: syz-executor.5 Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:put_cpu_partial+0x98/0x210 mm/slub.c:2601
Code: 7b 28 00 0f 85 2d 01 00 00 65 48 8b 04 25 80 6f 02 00 48 89 43 28 48 8b 45 00 65 48 8b 40 18 48 85 c0 74 1c 45 85 ff 8b 50 10 <0f> 84 ad 00 00 00 3b 55 30 0f 82 a4 00 00 00 49 89 c5 31 c0 eb 0b
RSP: 0018:ffffc900043d7c78 EFLAGS: 00000002
RAX: ffffea00007a3400 RBX: ffff8880b9b410a0 RCX: ffffffff815e4bee
RDX: 0000000000000004 RSI: ffffffff81c70f8d RDI: 0000000000000000
RBP: ffff8881400078c0 R08: 0000000000000000 R09: ffffffff9068e947
R10: fffffbfff20d1d28 R11: 0000000000000001 R12: 0000000000000200
R13: 0000000000000001 R14: ffffea0001e4a480 R15: 0000000000000001
FS:  0000555555ec0400(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa42576a1b8 CR3: 0000000071625000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:447
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:727 [inline]
 slab_alloc_node mm/slub.c:3243 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3258 [inline]
 kmem_cache_alloc_lru+0x255/0x730 mm/slub.c:3275
 alloc_inode_sb include/linux/fs.h:3095 [inline]
 sock_alloc_inode+0x23/0x1d0 net/socket.c:304
 alloc_inode+0x61/0x230 fs/inode.c:260
 new_inode_pseudo+0x14/0xe0 fs/inode.c:1018
 sock_alloc+0x3c/0x260 net/socket.c:627
 __sock_create+0xb9/0x790 net/socket.c:1479
 sock_create net/socket.c:1566 [inline]
 __sys_socket_create net/socket.c:1603 [inline]
 __sys_socket_create net/socket.c:1588 [inline]
 __sys_socket+0x12f/0x240 net/socket.c:1636
 __do_sys_socket net/socket.c:1649 [inline]
 __se_sys_socket net/socket.c:1647 [inline]
 __x64_sys_socket+0x6f/0xb0 net/socket.c:1647
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa42568a887
Code: f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 29 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc60562cc8 EFLAGS: 00000202 ORIG_RAX: 0000000000000029
RAX: ffffffffffffffda RBX: 00007ffc60563400 RCX: 00007fa42568a887
RDX: 0000000000000006 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 0000000000000003 R08: 0000000000000000 R09: 00007ffc60562d40
R10: 0000000000000010 R11: 0000000000000202 R12: 0000000000000032
R13: 0000000000036c82 R14: 0000000000000008 R15: 00007ffc60563440
 </TASK>


Tested on:

commit:         200e340f Merge tag 'pull-work.dcache' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14df9cf3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a3f4d6985d3164cd
dashboard link: https://syzkaller.appspot.com/bug?extid=ed920a72fd23eb735158
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14461b73080000

