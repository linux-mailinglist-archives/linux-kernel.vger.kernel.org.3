Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59E256523F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbiGDK1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiGDK0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:26:47 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9556D101C1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:25:57 -0700 (PDT)
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 264APnoR085785;
        Mon, 4 Jul 2022 19:25:49 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Mon, 04 Jul 2022 19:25:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 264APmef085781
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 4 Jul 2022 19:25:49 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <100f445e-9fa8-4f37-76aa-8359f0008c59@I-love.SAKURA.ne.jp>
Date:   Mon, 4 Jul 2022 19:25:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] char: misc: make misc_open() and misc_register() killable
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
References: <000000000000d9ff3a05bb37069e@google.com>
 <72e74af9-f1b6-e383-a2c3-6ee8a0aea5e0@I-love.SAKURA.ne.jp>
 <YsKW6VvWqvcMRBSl@kroah.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YsKW6VvWqvcMRBSl@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/07/04 16:29, Greg KH wrote:
> On Mon, Jul 04, 2022 at 03:44:07PM +0900, Tetsuo Handa wrote:
>> syzbot is reporting hung task at misc_open() [1], for snapshot_open() from
>> misc_open() might sleep for long with misc_mtx held whereas userspace can
>> flood with concurrent misc_open() requests. Mitigate this problem by making
>> misc_open() and misc_register() killable.
> 
> I do not understand, why not just fix snapshot_open()?  Why add this
> complexity to the misc core for a foolish individual misc device?  Why
> not add the fix there where it is spinning instead?

Quoting an example from [1]. Multiple processes are calling misc_open() and
all but one processes are blocked at mutex_lock(&misc_mtx). The one which is
not blocked at mutex_lock(&misc_mtx) is also holding system_transition_mutex.

If you don't like mutex_lock_killable(&misc_mtx), we will need to consider moving
file->f_op->open() from misc_open() to after mutex_unlock(&misc_mtx). However,
since there might be misc devices which count on serialization currently provided
by mutex_lock(&misc_mtx), I guess we will after all end up with adding
"struct mutex" to "struct miscdevice" and call
mutex_lock_killable(&"struct miscdevice"->mutex) before calling
file->f_op->open() from misc_open().

----------------------------------------
INFO: task syz-executor864:6907 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor864 state:D stack:27936 pid: 6907 ppid:  6545 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xb44/0x5960 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xa34/0x12f0 kernel/locking/mutex.c:729
 misc_open+0x55/0x4a0 drivers/char/misc.c:107
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4c8/0x11d0 fs/open.c:822
 do_open fs/namei.c:3428 [inline]
 path_openat+0x1c9a/0x2740 fs/namei.c:3561
 do_filp_open+0x1aa/0x400 fs/namei.c:3588
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1200
 do_sys_open fs/open.c:1216 [inline]
 __do_sys_openat fs/open.c:1232 [inline]
 __se_sys_openat fs/open.c:1227 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1227
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7ff261e34347
RSP: 002b:00007ffe30328bb0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000020000440 RCX: 00007ff261e34347
RDX: 0000000000000002 RSI: 00007ff261eba03b RDI: 00000000ffffff9c
RBP: 00007ff261eba03b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ffe3032acdc R14: 0000000000000076 R15: 00007ffe3032ace0
INFO: task syz-executor864:6922 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor864 state:D stack:28616 pid: 6922 ppid:  6546 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xb44/0x5960 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xa34/0x12f0 kernel/locking/mutex.c:729
 misc_open+0x55/0x4a0 drivers/char/misc.c:107
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4c8/0x11d0 fs/open.c:822
 do_open fs/namei.c:3428 [inline]
 path_openat+0x1c9a/0x2740 fs/namei.c:3561
 do_filp_open+0x1aa/0x400 fs/namei.c:3588
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1200
 do_sys_open fs/open.c:1216 [inline]
 __do_sys_openat fs/open.c:1232 [inline]
 __se_sys_openat fs/open.c:1227 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1227
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7ff261e34347
RSP: 002b:00007ffe30328bb0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000020000440 RCX: 00007ff261e34347
RDX: 0000000000000002 RSI: 00007ff261eba03b RDI: 00000000ffffff9c
RBP: 00007ff261eba03b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ffe3032acdc R14: 0000000000000076 R15: 00007ffe3032ace0
INFO: task syz-executor864:6936 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor864 state:D stack:27760 pid: 6936 ppid:  6548 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xb44/0x5960 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xa34/0x12f0 kernel/locking/mutex.c:729
 misc_open+0x55/0x4a0 drivers/char/misc.c:107
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4c8/0x11d0 fs/open.c:822
 do_open fs/namei.c:3428 [inline]
 path_openat+0x1c9a/0x2740 fs/namei.c:3561
 do_filp_open+0x1aa/0x400 fs/namei.c:3588
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1200
 do_sys_open fs/open.c:1216 [inline]
 __do_sys_openat fs/open.c:1232 [inline]
 __se_sys_openat fs/open.c:1227 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1227
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7ff261e34347
RSP: 002b:00007ffe30328bb0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000020000440 RCX: 00007ff261e34347
RDX: 0000000000000002 RSI: 00007ff261eba03b RDI: 00000000ffffff9c
RBP: 00007ff261eba03b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ffe3032acdc R14: 0000000000000076 R15: 00007ffe3032ace0
INFO: task syz-executor864:6954 blocked for more than 144 seconds.
      Not tainted 5.15.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor864 state:D stack:28328 pid: 6954 ppid:  6549 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xb44/0x5960 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xa34/0x12f0 kernel/locking/mutex.c:729
 misc_open+0x55/0x4a0 drivers/char/misc.c:107
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4c8/0x11d0 fs/open.c:822
 do_open fs/namei.c:3428 [inline]
 path_openat+0x1c9a/0x2740 fs/namei.c:3561
 do_filp_open+0x1aa/0x400 fs/namei.c:3588
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1200
 do_sys_open fs/open.c:1216 [inline]
 __do_sys_openat fs/open.c:1232 [inline]
 __se_sys_openat fs/open.c:1227 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1227
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7ff261e34347
RSP: 002b:00007ffe30328bb0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000020000440 RCX: 00007ff261e34347
RDX: 0000000000000002 RSI: 00007ff261eba03b RDI: 00000000ffffff9c
RBP: 00007ff261eba03b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ffe3032acdc R14: 0000000000000076 R15: 00007ffe3032ace0
INFO: task syz-executor864:6972 blocked for more than 144 seconds.
      Not tainted 5.15.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor864 state:D stack:28328 pid: 6972 ppid:  6547 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xb44/0x5960 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xa34/0x12f0 kernel/locking/mutex.c:729
 misc_open+0x55/0x4a0 drivers/char/misc.c:107
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4c8/0x11d0 fs/open.c:822
 do_open fs/namei.c:3428 [inline]
 path_openat+0x1c9a/0x2740 fs/namei.c:3561
 do_filp_open+0x1aa/0x400 fs/namei.c:3588
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1200
 do_sys_open fs/open.c:1216 [inline]
 __do_sys_openat fs/open.c:1232 [inline]
 __se_sys_openat fs/open.c:1227 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1227
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7ff261e34347
RSP: 002b:00007ffe30328bb0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000020000440 RCX: 00007ff261e34347
RDX: 0000000000000002 RSI: 00007ff261eba03b RDI: 00000000ffffff9c
RBP: 00007ff261eba03b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ffe3032acdc R14: 0000000000000076 R15: 00007ffe3032ace0

Showing all locks held in the system:
1 lock held by khungtaskd/27:
 #0: ffffffff8b97f0e0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6446
5 locks held by kworker/1:2/1053:
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:634 [inline]
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:661 [inline]
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x8a3/0x16b0 kernel/workqueue.c:2268
 #1: ffffc900049ffdb0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8d7/0x16b0 kernel/workqueue.c:2272
 #2: ffff88801fed4220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff88801fed4220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4330 drivers/usb/core/hub.c:5662
 #3: ffff888022e64220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #3: ffff888022e64220 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #4: ffff8880781991a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #4: ffff8880781991a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
5 locks held by kworker/0:2/1266:
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:634 [inline]
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:661 [inline]
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x8a3/0x16b0 kernel/workqueue.c:2268
 #1: ffffc900053efdb0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8d7/0x16b0 kernel/workqueue.c:2272
 #2: ffff888146d2f220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff888146d2f220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4330 drivers/usb/core/hub.c:5662
 #3: ffff88806fe79220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #3: ffff88806fe79220 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #4: ffff88801fe231a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #4: ffff88801fe231a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
5 locks held by kworker/1:3/2969:
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:634 [inline]
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:661 [inline]
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x8a3/0x16b0 kernel/workqueue.c:2268
 #1: ffffc90001177db0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8d7/0x16b0 kernel/workqueue.c:2272
 #2: ffff888146d3d220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff888146d3d220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4330 drivers/usb/core/hub.c:5662
 #3: ffff8880750ec220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #3: ffff8880750ec220 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #4: ffff888078ab61a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #4: ffff888078ab61a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
1 lock held by in:imklog/6253:
 #0: ffff88801b806db0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:990
5 locks held by kworker/1:0/6557:
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:634 [inline]
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:661 [inline]
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x8a3/0x16b0 kernel/workqueue.c:2268
 #1: ffffc90002c37db0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8d7/0x16b0 kernel/workqueue.c:2272
 #2: ffff888146d23220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff888146d23220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4330 drivers/usb/core/hub.c:5662
 #3: ffff888079db5220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #3: ffff888079db5220 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #4: ffff88801a88f1a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #4: ffff88801a88f1a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
5 locks held by kworker/0:1/6563:
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:634 [inline]
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:661 [inline]
 #0: ffff88801643cd38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x8a3/0x16b0 kernel/workqueue.c:2268
 #1: ffffc90002cb7db0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8d7/0x16b0 kernel/workqueue.c:2272
 #2: ffff8880200b6220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff8880200b6220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4330 drivers/usb/core/hub.c:5662
 #3: ffff88806e962220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #3: ffff88806e962220 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #4: ffff88806eba91a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #4: ffff88806eba91a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
1 lock held by syz-executor864/6907:
 #0: ffffffff8c3c4488 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x55/0x4a0 drivers/char/misc.c:107
1 lock held by syz-executor864/6922:
 #0: ffffffff8c3c4488 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x55/0x4a0 drivers/char/misc.c:107
1 lock held by syz-executor864/6936:
 #0: ffffffff8c3c4488 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x55/0x4a0 drivers/char/misc.c:107
1 lock held by syz-executor864/6954:
 #0: ffffffff8c3c4488 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x55/0x4a0 drivers/char/misc.c:107
1 lock held by syz-executor864/6972:
 #0: ffffffff8c3c4488 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x55/0x4a0 drivers/char/misc.c:107
2 locks held by syz-executor864/6975:
 #0: ffffffff8c3c4488 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x55/0x4a0 drivers/char/misc.c:107
 #1: ffffffff8b84d408 (system_transition_mutex){+.+.}-{3:3}, at: snapshot_open+0x3b/0x2a0 kernel/power/user.c:54

----------------------------------------

