Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDE4591EAE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 08:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiHNGjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 02:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHNGjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 02:39:17 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CF95C356
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 23:39:14 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id l18-20020a6bd112000000b0067cb64ad9b2so2689904iob.20
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 23:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=hhD9D5/ZT023Q2lUI1FMmiK9TO0Iyr19k9bOz7ycCyw=;
        b=H2YjRU/Cq09b3d+wL2FhLB9Rg82IKOqGDjjZOIrP7Kde9eqe3iieTw/Z9h8/VGScvH
         6dMxPfVBAvz6pr9yXPbd/cNtSA5yJ1OysL0kwzHkbWbIpkwDW45Jj1IlG9pURFaLcNQy
         qZ3ZMf1usBCdCCl5bpHHhohRdp6lR+aUe57eRR5nGP7HZuklv6tJYXWcPQvxJLwquMDM
         YWRkS2X8Cst1nzfd+/US+hvAm7HIWB+SKwYqcINsNzKEW1JciYsV58LJjU8LgMEfkQVP
         uNh4h6wIRGgAhxn1ECiY+whSOvgpjPPaECLgvWvqQilnDetI6Ldq17UMwc+sYMoWSgS3
         A7Qw==
X-Gm-Message-State: ACgBeo3I0r8MCPnnxLR7hqIRSdijA/vmRbpHnjxBKIQJmlwtB+g9t0iu
        1OH+CqgV15iazivQX/y/YPfjRpk+mKJNaJhypmkyaBFJXnMQ
X-Google-Smtp-Source: AA6agR4ONYU7EFiSPD9n0qtU868J/90kZZuAlHTU6YsC7ZHaXBAms0UMLWZdNNS7qzrNjWX/Yr8iHD6fO1/77WUXHIltdf0lL2S7
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1646:b0:2dd:11e5:edaf with SMTP id
 v6-20020a056e02164600b002dd11e5edafmr5160247ilu.96.1660459153610; Sat, 13 Aug
 2022 23:39:13 -0700 (PDT)
Date:   Sat, 13 Aug 2022 23:39:13 -0700
In-Reply-To: <20220814010408.770-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003dcd505e62dc6fd@google.com>
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
INFO: task hung in __generic_file_fsync

INFO: task kworker/0:1:14 blocked for more than 143 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1     state:D stack:25376 pid:   14 ppid:     2 flags:0x00004000
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
 inode_lock include/linux/fs.h:761 [inline]
 __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
 fat_file_fsync+0x73/0x200 fs/fat/file.c:191
 vfs_fsync_range+0x13a/0x220 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2862 [inline]
 dio_complete+0x6e4/0x950 fs/direct-io.c:310
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
INFO: task kworker/0:5:3614 blocked for more than 143 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:5     state:D stack:26104 pid: 3614 ppid:     2 flags:0x00004000
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
 inode_lock include/linux/fs.h:761 [inline]
 __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
 fat_file_fsync+0x73/0x200 fs/fat/file.c:191
 vfs_fsync_range+0x13a/0x220 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2862 [inline]
 dio_complete+0x6e4/0x950 fs/direct-io.c:310
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
INFO: task syz-executor.5:4177 blocked for more than 144 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:25792 pid: 4177 ppid:  4078 flags:0x00004004
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
RIP: 0033:0x7f18fd289209
RSP: 002b:00007f18fe3cd168 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 00007f18fd39bf60 RCX: 00007f18fd289209
RDX: 0000000000000000 RSI: 00000000010099b8 RDI: 0000000000000004
RBP: 00007f18fd2e3161 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff046c69af R14: 00007f18fe3cd300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.5:4179 blocked for more than 145 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:26600 pid: 4179 ppid:  4078 flags:0x00000004
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
RIP: 0033:0x7f18fd289209
RSP: 002b:00007f18fe3ac168 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007f18fd39c030 RCX: 00007f18fd289209
RDX: 0000000020000540 RSI: 0000000000001801 RDI: 00007f18fe383000
RBP: 00007f18fd2e3161 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff046c69af R14: 00007f18fe3ac300 R15: 0000000000022000
 </TASK>
INFO: task dio/loop5:4182 blocked for more than 147 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:dio/loop5       state:D stack:28888 pid: 4182 ppid:     2 flags:0x00004000
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
 inode_lock include/linux/fs.h:761 [inline]
 __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
 fat_file_fsync+0x73/0x200 fs/fat/file.c:191
 vfs_fsync_range+0x13a/0x220 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2862 [inline]
 dio_complete+0x6e4/0x950 fs/direct-io.c:310
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 process_scheduled_works kernel/workqueue.c:2352 [inline]
 rescuer_thread+0x5a0/0xcf0 kernel/workqueue.c:2543
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
INFO: task kworker/0:8:4183 blocked for more than 147 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:8     state:D stack:28968 pid: 4183 ppid:     2 flags:0x00004000
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
 inode_lock include/linux/fs.h:761 [inline]
 __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
 fat_file_fsync+0x73/0x200 fs/fat/file.c:191
 vfs_fsync_range+0x13a/0x220 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2862 [inline]
 dio_complete+0x6e4/0x950 fs/direct-io.c:310
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
INFO: task kworker/0:9:4184 blocked for more than 148 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:9     state:D stack:28968 pid: 4184 ppid:     2 flags:0x00004000
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
 inode_lock include/linux/fs.h:761 [inline]
 __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
 fat_file_fsync+0x73/0x200 fs/fat/file.c:191
 vfs_fsync_range+0x13a/0x220 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2862 [inline]
 dio_complete+0x6e4/0x950 fs/direct-io.c:310
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
INFO: task kworker/0:10:4185 blocked for more than 148 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:10    state:D stack:28968 pid: 4185 ppid:     2 flags:0x00004000
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
 inode_lock include/linux/fs.h:761 [inline]
 __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
 fat_file_fsync+0x73/0x200 fs/fat/file.c:191
 vfs_fsync_range+0x13a/0x220 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2862 [inline]
 dio_complete+0x6e4/0x950 fs/direct-io.c:310
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
INFO: task kworker/0:11:4186 blocked for more than 148 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:11    state:D stack:28600 pid: 4186 ppid:     2 flags:0x00004000
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
 inode_lock include/linux/fs.h:761 [inline]
 __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
 fat_file_fsync+0x73/0x200 fs/fat/file.c:191
 vfs_fsync_range+0x13a/0x220 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2862 [inline]
 dio_complete+0x6e4/0x950 fs/direct-io.c:310
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/0:0/6:
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900000b7da8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a155210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a155210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8bd86870 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8bd86570 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
3 locks held by kworker/0:1/14:
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90000137da8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806be69670 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806be69670 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
1 lock held by khungtaskd/28:
 #0: ffffffff8bd873c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6492
3 locks held by kworker/0:2/141:
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000293fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a155210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a155210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
2 locks held by getty/3281:
 #0: ffff888026115098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002d162e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xe50/0x13c0 drivers/tty/n_tty.c:2124
3 locks held by kworker/0:3/3612:
 #0: ffff88806aff5538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806aff5538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806aff5538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806aff5538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806aff5538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806aff5538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003fffda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a1558b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a1558b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:4/3613:
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000400fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a155210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a155210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:5/3614:
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000401fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806be69670 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806be69670 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:6/4172:
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900038ffda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a155210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a155210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:7/4174:
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000391fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
2 locks held by syz-executor.5/4177:
 #0: ffff888021b40460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 #0: ffff888021b40460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 #1: ffff88806be69670 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #1: ffff88806be69670 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: do_truncate+0x12a/0x200 fs/open.c:63
1 lock held by syz-executor.5/4179:
 #0: ffff88806be69670 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #0: ffff88806be69670 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: generic_file_write_iter+0x8a/0x220 mm/filemap.c:3901
3 locks held by dio/loop5/4182:
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000399fd58 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806be69670 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806be69670 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:8/4183:
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900039afda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806be69670 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806be69670 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:9/4184:
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900039bfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806be69670 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806be69670 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:10/4185:
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900039cfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806be69670 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806be69670 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:11/4186:
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806a936938 ((wq_completion)dio/loop5){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900039dfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806be69670 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806be69670 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:12/4187:
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900039efda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:13/4188:
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900039ffda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a155210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a155210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:14/4208:
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003b0fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:15/4209:
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003b1fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a155210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a155210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:16/4210:
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000393fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:17/4211:
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003b2fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:18/4212:
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003b3fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:19/4213:
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003b4fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a155210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a155210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:20/4214:
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003b5fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a155210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a155210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:21/4215:
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003b6fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:22/4216:
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003b7fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a155210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a155210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:23/4217:
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003b8fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:13/4220:
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003bbfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:16/4223:
 #0: ffff88806ae3cd38 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806ae3cd38 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806ae3cd38 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806ae3cd38 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806ae3cd38 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806ae3cd38 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003befda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a154b70 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a154b70 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:24/4229:
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003c1fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:25/4249:
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003acfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:26/4250:
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003a3fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:27/4273:
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003d77da8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a155210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a155210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
2 locks held by syz-executor.4/4300:
 #0: ffff8880796a4460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 #0: ffff8880796a4460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 #1: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #1: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: do_truncate+0x12a/0x200 fs/open.c:63
1 lock held by syz-executor.4/4307:
 #0: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #0: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: generic_file_write_iter+0x8a/0x220 mm/filemap.c:3901
2 locks held by syz-executor.3/4296:
 #0: ffff888025eea460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 #0: ffff888025eea460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 #1: ffff88806a1544d0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #1: ffff88806a1544d0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: do_truncate+0x12a/0x200 fs/open.c:63
1 lock held by syz-executor.3/4305:
 #0: ffff88806a1544d0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #0: ffff88806a1544d0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: generic_file_write_iter+0x8a/0x220 mm/filemap.c:3901
2 locks held by syz-executor.0/4297:
 #0: ffff88807f2a6460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 #0: ffff88807f2a6460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 #1: ffff88806a155210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #1: ffff88806a155210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: do_truncate+0x12a/0x200 fs/open.c:63
1 lock held by syz-executor.0/4306:
 #0: ffff88806a155210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #0: ffff88806a155210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: generic_file_write_iter+0x8a/0x220 mm/filemap.c:3901
2 locks held by syz-executor.2/4299:
 #0: ffff888025eec460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 #0: ffff888025eec460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 #1: ffff88806a154b70 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #1: ffff88806a154b70 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: do_truncate+0x12a/0x200 fs/open.c:63
1 lock held by syz-executor.2/4304:
 #0: ffff88806a154b70 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #0: ffff88806a154b70 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: generic_file_write_iter+0x8a/0x220 mm/filemap.c:3901
2 locks held by syz-executor.1/4302:
 #0: ffff88807cb26460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 #0: ffff88807cb26460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 #1: ffff88806a1558b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #1: ffff88806a1558b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: do_truncate+0x12a/0x200 fs/open.c:63
1 lock held by syz-executor.1/4308:
 #0: ffff88806a1558b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #0: ffff88806a1558b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: generic_file_write_iter+0x8a/0x220 mm/filemap.c:3901
3 locks held by dio/loop2/4309:
 #0: ffff88806ae3cd38 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806ae3cd38 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806ae3cd38 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806ae3cd38 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806ae3cd38 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806ae3cd38 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003effd58 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a154b70 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a154b70 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by dio/loop4/4310:
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003f0fd58 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by dio/loop3/4311:
 #0: ffff88806ae3ed38 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806ae3ed38 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806ae3ed38 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806ae3ed38 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806ae3ed38 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806ae3ed38 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003f1fd58 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a1544d0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a1544d0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by dio/loop0/4312:
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003f2fd58 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a155210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a155210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by dio/loop1/4313:
 #0: ffff88806aff5538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806aff5538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806aff5538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806aff5538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806aff5538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806aff5538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003f3fd58 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a1558b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a1558b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:19/4314:
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003f4fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:20/4315:
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003f5fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:21/4316:
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b912938 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003f6fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a157330 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:22/4317:
 #0: ffff88806aff5538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806aff5538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806aff5538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806aff5538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806aff5538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806aff5538 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003f7fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a1558b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a1558b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:23/4318:
 #0: ffff88806ae3ed38 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806ae3ed38 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806ae3ed38 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806ae3ed38 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806ae3ed38 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806ae3ed38 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003f8fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a1544d0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #2: ffff88806a1544d0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:28/4320:
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b906138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0

Tested on:

commit:         200e340f Merge tag 'pull-work.dcache' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15da7685080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a3f4d6985d3164cd
dashboard link: https://syzkaller.appspot.com/bug?extid=ed920a72fd23eb735158
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=138ca25b080000

