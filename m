Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78E9591ABC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 15:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239582AbiHMNoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 09:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239571AbiHMNoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 09:44:12 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F83DED3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 06:44:08 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id j8-20020a6b7948000000b0067c2923d1b8so2026264iop.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 06:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=kry8ILqKIdnVjfVNgduVFlXBUFD8MfRYluncjDGHWWI=;
        b=fqYtYHyLjYCRjENccbgCC3ZVmKw65eA4uLkxFVQN8vGtsKllKQOS/3ufig6Gnk9aMQ
         ZVZWGJjI8tEh5S5z+r0L475I1OOrLYzlemHE8lviTUGmZAkeNlWd/OTg6+9bNralce7h
         WUrZv0q9JJ12JiplDwtI9Au0av02ma2FY0Q0pVvEchf7XSOPZ/+ztsL63PuwkFBQ0+C5
         6auotUqhxXXEMm2f6SqOQYlUh3AKEeCU86S8HEZUEtGkEt0pFY4ERpmCvRFasa1Hrw3G
         LijEKLevPYIgJCbo6T4u+cqQm41NKWDL4aZQ5VSGzMCynlh66T1rQmGA3uOcVwo7SVwL
         L28Q==
X-Gm-Message-State: ACgBeo2mOI0wMtiu8uYOKnjp5paKsVc1y/RUiKXm1jX+bMmC2bWxGNX5
        iIQsgg5HHzbvSUDsfPomT0k6Jwv+5z86kOyscaLZ4cpG2XAU
X-Google-Smtp-Source: AA6agR5UYmcmqBBlCQ8l9pAEL/K3g70xyP3uN6Qb6wXVS+fJg2MkxzwbASZNicpkGfdgGoFdOcbtFA66NJU8qug9WuxxRuF0AKCt
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a46:b0:2df:86f0:ebd2 with SMTP id
 u6-20020a056e021a4600b002df86f0ebd2mr3863789ilv.209.1660398247830; Sat, 13
 Aug 2022 06:44:07 -0700 (PDT)
Date:   Sat, 13 Aug 2022 06:44:07 -0700
In-Reply-To: <20220813072749.674-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bf6aba05e61f971c@google.com>
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
task:kworker/0:1     state:D stack:26016 pid:   14 ppid:     2 flags:0x00004000
Workqueue: dio/loop3 dio_aio_complete_work
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
 dio_complete+0x6ae/0x920 fs/direct-io.c:310
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
INFO: task kworker/0:2:917 blocked for more than 144 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:2     state:D stack:25672 pid:  917 ppid:     2 flags:0x00004000
Workqueue: dio/loop3 dio_aio_complete_work
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
 dio_complete+0x6ae/0x920 fs/direct-io.c:310
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
INFO: task kworker/0:3:2932 blocked for more than 144 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:3     state:D stack:26896 pid: 2932 ppid:     2 flags:0x00004000
Workqueue: dio/loop3 dio_aio_complete_work
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
 dio_complete+0x6ae/0x920 fs/direct-io.c:310
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
INFO: task kworker/0:4:3621 blocked for more than 144 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:4     state:D stack:25952 pid: 3621 ppid:     2 flags:0x00004000
Workqueue: dio/loop3 dio_aio_complete_work
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
 dio_complete+0x6ae/0x920 fs/direct-io.c:310
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
INFO: task kworker/0:5:3622 blocked for more than 144 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:5     state:D stack:26920 pid: 3622 ppid:     2 flags:0x00004000
Workqueue: dio/loop3 dio_aio_complete_work
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
 dio_complete+0x6ae/0x920 fs/direct-io.c:310
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
INFO: task kworker/0:6:3623 blocked for more than 145 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:6     state:D stack:26368 pid: 3623 ppid:     2 flags:0x00004000
Workqueue: dio/loop3 dio_aio_complete_work
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
 dio_complete+0x6ae/0x920 fs/direct-io.c:310
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
INFO: task kworker/0:7:4120 blocked for more than 145 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:7     state:D stack:26552 pid: 4120 ppid:     2 flags:0x00004000
Workqueue: dio/loop3 dio_aio_complete_work
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
 dio_complete+0x6ae/0x920 fs/direct-io.c:310
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
INFO: task kworker/0:8:4121 blocked for more than 145 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:8     state:D stack:27576 pid: 4121 ppid:     2 flags:0x00004000
Workqueue: dio/loop3 dio_aio_complete_work
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
 dio_complete+0x6ae/0x920 fs/direct-io.c:310
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
INFO: task kworker/0:9:4122 blocked for more than 146 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:9     state:D stack:25976 pid: 4122 ppid:     2 flags:0x00004000
Workqueue: dio/loop3 dio_aio_complete_work
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
 dio_complete+0x6ae/0x920 fs/direct-io.c:310
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
INFO: task kworker/0:10:4174 blocked for more than 146 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:10    state:D stack:27448 pid: 4174 ppid:     2 flags:0x00004000
Workqueue: dio/loop3 dio_aio_complete_work
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
 dio_complete+0x6ae/0x920 fs/direct-io.c:310
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/0:0/6:
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900000b7da8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8bd86870 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8bd86570 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
3 locks held by kworker/0:1/14:
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90000137da8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
1 lock held by khungtaskd/28:
 #0: ffffffff8bd873c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6492
3 locks held by kworker/u4:2/33:
 #0: ffff8880b9b39f58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2b/0x120 kernel/sched/core.c:544
 #1: ffff8880b9b277c8 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x176/0x4e0 kernel/sched/psi.c:880
 #2: ffff8880b9b39f58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2b/0x120 kernel/sched/core.c:544
3 locks held by kworker/0:2/917:
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000478fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:3/2932:
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000bbcfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by klogd/2959:
 #0: ffff8880b9b39f58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2b/0x120 kernel/sched/core.c:544
 #1: ffff8880b9a277c8 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x3e7/0x4e0 kernel/sched/psi.c:889
 #2: ffff88807ebd6230 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xaa/0x17e0 kernel/sched/core.c:4078
2 locks held by getty/3280:
 #0: ffff88814a8b3098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002d232e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xe50/0x13c0 drivers/tty/n_tty.c:2124
3 locks held by kworker/0:4/3621:
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003ecfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:5/3622:
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003edfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:6/3623:
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003eefda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:7/4120:
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000375fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:8/4121:
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000376fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:9/4122:
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000377fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:10/4174:
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900038cfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:11/4175:
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900038dfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:12/4181:
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900037cfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:13/4182:
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900038afda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:14/4183:
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000392fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:15/4184:
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000393fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:16/4185:
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000394fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:17/4190:
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000396fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
2 locks held by syz-executor.3/4215:
 #0: ffff8880213a0460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 #0: ffff8880213a0460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 #1: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #1: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: do_truncate+0x12a/0x200 fs/open.c:63
1 lock held by syz-executor.3/4219:
 #0: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #0: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: generic_file_write_iter+0x8a/0x220 mm/filemap.c:3901
3 locks held by dio/loop3/4220:
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b4ec938 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003aafd58 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806cf6c1b0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
2 locks held by syz-executor.1/4224:
 #0: ffff88807e288460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 #0: ffff88807e288460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 #1: ffff88806ceeede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #1: ffff88806ceeede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: do_truncate+0x12a/0x200 fs/open.c:63
1 lock held by syz-executor.1/4227:
 #0: ffff88806ceeede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #0: ffff88806ceeede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: generic_file_write_iter+0x8a/0x220 mm/filemap.c:3901
2 locks held by syz-executor.0/4226:
 #0: ffff8880773bc460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 #0: ffff8880773bc460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 #1: ffff88806cf6daf0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #1: ffff88806cf6daf0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: do_truncate+0x12a/0x200 fs/open.c:63
1 lock held by syz-executor.0/4229:
 #0: ffff88806cf6daf0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #0: ffff88806cf6daf0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: generic_file_write_iter+0x8a/0x220 mm/filemap.c:3901
3 locks held by dio/loop1/4228:
 #0: ffff88806b6b4938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b6b4938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b6b4938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b6b4938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b6b4938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b6b4938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003aefd58 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806ceeede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806ceeede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:18/4230:
 #0: ffff88806b6b4938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b6b4938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b6b4938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b6b4938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b6b4938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b6b4938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003a3fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806ceeede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806ceeede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:19/4232:
 #0: ffff88806b6b4938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b6b4938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b6b4938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b6b4938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b6b4938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b6b4938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003b0fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806ceeede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806ceeede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:20/4235:
 #0: ffff88806b6b4938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b6b4938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b6b4938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b6b4938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b6b4938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b6b4938 ((wq_completion)dio/loop1){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003b3fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806ceeede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806ceeede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:21/4237:
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003b5fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by dio/loop0/4238:
 #0: ffff88806b6ce538 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806b6ce538 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806b6ce538 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806b6ce538 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806b6ce538 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806b6ce538 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003b6fd58 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806cf6daf0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806cf6daf0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:22/4239:
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003b7fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:23/4240:
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003b8fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:24/4244:
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003bcfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:25/4246:
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003befda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:26/4247:
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003bffda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:27/4248:
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003c0fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:28/4249:
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003c1fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:29/4250:
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003c2fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:30/4253:
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003c5fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:31/4254:
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003c6fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:32/4265:
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003c9fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:33/4266:
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003cafda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:35/4328:
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003f6fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:36/4329:
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003f7fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:37/4330:
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003f8fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:38/4332:
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003fafda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:39/4333:
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807d4d5538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003fbfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b99ede0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
2 locks held by syz-executor.2/4505:
 #0: ffff88801d5c6460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 #0: ffff88801d5c6460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 #1: ffff88806

Tested on:

commit:         200e340f Merge tag 'pull-work.dcache' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=111a20f3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a3f4d6985d3164cd
dashboard link: https://syzkaller.appspot.com/bug?extid=ed920a72fd23eb735158
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10e5be97080000

