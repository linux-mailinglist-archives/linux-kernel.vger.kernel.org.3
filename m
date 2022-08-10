Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5AC58F042
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbiHJQVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiHJQV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:21:26 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD63760D3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:21:23 -0700 (PDT)
Received: by mail-qk1-f199.google.com with SMTP id l15-20020a05620a28cf00b006b46997c070so13072364qkp.20
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=F0vaSczpvP8R82rl8prYtCcXvrtx4RK6WvJcOL8btmI=;
        b=wCF6MyGfYJW6474o3tdzSG8a9BR74AiPUOYIDZm0G+JaAgXpYh3DHILRgqpsdNxTjZ
         EmLIFHPw/B7h01pCjKI26zFbUQuk4F9rDsmrOdO/8cWj0zzqQlFptaQ596ydS4Xg7HEz
         CguMxN++vEdF9YvhQ9C3IHroXVLBaJLeBuEAxvTqOBPpuTWLK0mgmvdgSizpyh8veq95
         60ODYTiJ51yN575nYlPHs2XUq9+3vDWXLFDicb30mK+CAbOU5A/YcHu3OxbriwMV5RMn
         JdDqYikSUPtEcxEqreFvb7nNU2GpaaXuHsNtvLdS5nK5M+3EhbYdy3juOVn2tmESDxX1
         h81Q==
X-Gm-Message-State: ACgBeo38zJklF0ekwUwXgWxeL67nWrKlppq5OtVN3Xclm86PnMGzttKV
        4W66wq8ITN0uj2N80nFijfN0pXelBajyTurp0sh00X7iw2y3
X-Google-Smtp-Source: AA6agR5NWX2c0eWMOCKz66WL/5Qr7M9A+7oFi9HWsISuar3kXEmT2iXPfrzNFhgrr0F9qVZjV/IJjSiRUS3fPgupO+0eFEx6U/F1
MIME-Version: 1.0
X-Received: by 2002:a05:6638:16cf:b0:341:4543:b354 with SMTP id
 g15-20020a05663816cf00b003414543b354mr13784164jat.114.1660148471818; Wed, 10
 Aug 2022 09:21:11 -0700 (PDT)
Date:   Wed, 10 Aug 2022 09:21:11 -0700
In-Reply-To: <20220810110345.2568-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000efee0e05e5e56fc7@google.com>
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

INFO: task kworker/1:3:3263 blocked for more than 143 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:3     state:D stack:26488 pid: 3263 ppid:     2 flags:0x00004000
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
 inode_lock include/linux/fs.h:760 [inline]
 __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
 fat_file_fsync+0x73/0x200 fs/fat/file.c:191
 vfs_fsync_range+0x13a/0x220 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2861 [inline]
 dio_complete+0x6dd/0x950 fs/direct-io.c:310
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
INFO: task kworker/1:4:3612 blocked for more than 143 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:4     state:D stack:25008 pid: 3612 ppid:     2 flags:0x00004000
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
 inode_lock include/linux/fs.h:760 [inline]
 __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
 fat_file_fsync+0x73/0x200 fs/fat/file.c:191
 vfs_fsync_range+0x13a/0x220 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2861 [inline]
 dio_complete+0x6dd/0x950 fs/direct-io.c:310
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
INFO: task kworker/1:12:4188 blocked for more than 143 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:12    state:D stack:26856 pid: 4188 ppid:     2 flags:0x00004000
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
 inode_lock include/linux/fs.h:760 [inline]
 __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
 fat_file_fsync+0x73/0x200 fs/fat/file.c:191
 vfs_fsync_range+0x13a/0x220 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2861 [inline]
 dio_complete+0x6dd/0x950 fs/direct-io.c:310
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
INFO: task kworker/1:13:4189 blocked for more than 144 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:13    state:D stack:27592 pid: 4189 ppid:     2 flags:0x00004000
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
 inode_lock include/linux/fs.h:760 [inline]
 __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
 fat_file_fsync+0x73/0x200 fs/fat/file.c:191
 vfs_fsync_range+0x13a/0x220 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2861 [inline]
 dio_complete+0x6dd/0x950 fs/direct-io.c:310
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
INFO: task kworker/0:10:4191 blocked for more than 144 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:10    state:D stack:27264 pid: 4191 ppid:     2 flags:0x00004000
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
 dio_complete+0x6dd/0x950 fs/direct-io.c:310
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
INFO: task kworker/1:19:4235 blocked for more than 144 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:19    state:D stack:27800 pid: 4235 ppid:     2 flags:0x00004000
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
 inode_lock include/linux/fs.h:760 [inline]
 __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
 fat_file_fsync+0x73/0x200 fs/fat/file.c:191
 vfs_fsync_range+0x13a/0x220 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2861 [inline]
 dio_complete+0x6dd/0x950 fs/direct-io.c:310
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
INFO: task kworker/1:23:4242 blocked for more than 145 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:23    state:D stack:27512 pid: 4242 ppid:     2 flags:0x00004000
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
 inode_lock include/linux/fs.h:760 [inline]
 __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
 fat_file_fsync+0x73/0x200 fs/fat/file.c:191
 vfs_fsync_range+0x13a/0x220 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2861 [inline]
 dio_complete+0x6dd/0x950 fs/direct-io.c:310
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
INFO: task syz-executor.3:4261 blocked for more than 145 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:26600 pid: 4261 ppid:  4068 flags:0x00000004
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
RIP: 0033:0x7f722bc89209
RSP: 002b:00007f722cd92168 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007f722bd9c030 RCX: 00007f722bc89209
RDX: 0000000020000540 RSI: 0000000000001801 RDI: 00007f722cd93000
RBP: 00007f722bce3161 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff0400f02f R14: 00007f722cd92300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.2:4257 blocked for more than 145 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:26600 pid: 4257 ppid:  4070 flags:0x00000004
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
RIP: 0033:0x7fc474289209
RSP: 002b:00007fc475458168 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007fc47439c030 RCX: 00007fc474289209
RDX: 0000000020000540 RSI: 0000000000001801 RDI: 00007fc475459000
RBP: 00007fc4742e3161 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffa5a7733f R14: 00007fc475458300 R15: 0000000000022000
 </TASK>
INFO: task dio/loop2:4260 blocked for more than 146 seconds.
      Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:dio/loop2       state:D stack:28888 pid: 4260 ppid:     2 flags:0x00004000
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
3 locks held by kworker/0:0/6:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900000b7da8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8bd86870 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8bd86570 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
3 locks held by kworker/0:1/14:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90000137da8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
1 lock held by khungtaskd/28:
 #0: ffffffff8bd873c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6492
3 locks held by kworker/0:2/917:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90004977da8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:3/3263:
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90002f3fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b54b510 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b54b510 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
2 locks held by getty/3280:
 #0: ffff888025b87098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002d162e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xe50/0x13c0 drivers/tty/n_tty.c:2124
3 locks held by kworker/0:3/3611:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003cefda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:4/3612:
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003cffda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b54b510 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b54b510 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:4/3621:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000433fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:5/4120:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900037dfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:6/4121:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900037efda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:7/4122:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900037ffda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:8/4145:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000386fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:11/4187:
 #0: ffff88806bacb538 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806bacb538 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806bacb538 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806bacb538 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806bacb538 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806bacb538 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000392fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806e3588e0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806e3588e0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:12/4188:
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000393fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b54b510 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b54b510 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:13/4189:
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000394fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b54b510 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b54b510 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:9/4190:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000395fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:10/4191:
 #0: ffff88807ddb7538 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807ddb7538 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807ddb7538 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807ddb7538 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807ddb7538 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807ddb7538 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000396fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b54e140 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b54e140 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:11/4192:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000397fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:12/4193:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900038dfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:13/4194:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000398fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:15/4196:
 #0: ffff88806bacb538 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806bacb538 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806bacb538 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806bacb538 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806bacb538 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806bacb538 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900039afda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806e3588e0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806e3588e0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:14/4204:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900039ffda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:15/4205:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003a0fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:16/4212:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003a3fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:17/4213:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003a4fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:19/4235:
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003b5fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b54b510 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b54b510 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:23/4242:
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003bcfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b54b510 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b54b510 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
2 locks held by syz-executor.3/4253:
 #0: ffff88806cb66460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 #0: ffff88806cb66460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 #1: ffff88806b54e140 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #1: ffff88806b54e140 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: do_truncate+0x12a/0x200 fs/open.c:63
1 lock held by syz-executor.3/4261:
 #0: ffff88806b54e140 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #0: ffff88806b54e140 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: generic_file_write_iter+0x8a/0x220 mm/filemap.c:3901
2 locks held by syz-executor.2/4254:
 #0: ffff88807ba50460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 #0: ffff88807ba50460 (sb_writers#13){.+.+}-{0:0}, at: do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 #1: ffff88806b54b510 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #1: ffff88806b54b510 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: do_truncate+0x12a/0x200 fs/open.c:63
1 lock held by syz-executor.2/4257:
 #0: ffff88806b54b510 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #0: ffff88806b54b510 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: generic_file_write_iter+0x8a/0x220 mm/filemap.c:3901
3 locks held by dio/loop2/4260:
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880700ed538 ((wq_completion)dio/loop2){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003c67d58 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b54b510 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b54b510 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:25/4262:
 #0: ffff88806bacb538 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806bacb538 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806bacb538 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806bacb538 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806bacb538 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806bacb538 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003cafda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806e3588e0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806e3588e0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by dio/loop3/4267:
 #0: ffff88807ddb7538 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807ddb7538 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807ddb7538 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807ddb7538 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807ddb7538 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807ddb7538 ((wq_completion)dio/loop3){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003d4fd58 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806b54e140 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806b54e140 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/1:34/4275:
 #0: ffff88806bacb538 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88806bacb538 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88806bacb538 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88806bacb538 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88806bacb538 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88806bacb538 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003dbfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806e3588e0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806e3588e0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:18/4349:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90004017da8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:19/4350:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90004027da8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:20/4365:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900040e7da8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:21/4468:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900047c7da8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:22/4570:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90004bbfda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:23/4571:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90004c1fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:24/4574:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90004c6fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:25/4576:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90004b2fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:26/4577:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90004c8fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:27/4578:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90004c9fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:28/4580:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90004cafda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:29/4582:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90004d2fda8 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:760 [inline]
 #2: ffff88806a224e50 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
3 locks held by kworker/0:30/4583:
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88807040d138 ((wq_completion)dio/loop0){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:

Tested on:

commit:         200e340f Merge tag 'pull-work.dcache' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17d3c235080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a3f4d6985d3164cd
dashboard link: https://syzkaller.appspot.com/bug?extid=ed920a72fd23eb735158
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=125541a9080000

