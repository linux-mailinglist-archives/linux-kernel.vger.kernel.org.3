Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65AA5662BB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 07:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiGEFV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 01:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiGEFVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 01:21:25 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5DF12A9A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 22:21:23 -0700 (PDT)
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2655LLBb056114;
        Tue, 5 Jul 2022 14:21:21 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Tue, 05 Jul 2022 14:21:21 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2655LKMB056102
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 5 Jul 2022 14:21:20 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <617f64e3-74c8-f98b-3430-bd476867e483@I-love.SAKURA.ne.jp>
Date:   Tue, 5 Jul 2022 14:21:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] char: misc: make misc_open() and misc_register() killable
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@google.com>
References: <000000000000d9ff3a05bb37069e@google.com>
 <72e74af9-f1b6-e383-a2c3-6ee8a0aea5e0@I-love.SAKURA.ne.jp>
 <YsKW6VvWqvcMRBSl@kroah.com>
 <100f445e-9fa8-4f37-76aa-8359f0008c59@I-love.SAKURA.ne.jp>
 <YsLIepAXeBKT0AF/@kroah.com>
 <01a93294-e323-b9ca-7e95-a33d4b89dc47@I-love.SAKURA.ne.jp>
 <YsL5pUuydMWJ9dSQ@kroah.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YsL5pUuydMWJ9dSQ@kroah.com>
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

On 2022/07/04 23:31, Greg KH wrote:
> I don't understand what you are trying to "fix" here.  What is userspace
> doing (as a normal user) that is causing a problem, and what problem is
> it causing and for what device/hardware/driver is this a problem?

Currently the root cause is unknown.
This might be another example of deadlock hidden by device_initialize().

We can see from https://syzkaller.appspot.com/text?tag=CrashReport&x=11feb7e0080000 that
when khungtaskd reports that a process is blocked waiting for misc_mtx at misc_open(),
there is a process which is holding system_transition_mutex from snapshot_open().

----------------------------------------
INFO: task syz-executor.4:21922 blocked for more than 143 seconds.
      Not tainted 5.19.0-rc4-syzkaller-00187-g089866061428 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:28408 pid:21922 ppid:  3666 flags:0x00000004

2 locks held by syz-executor.5/21906:
 #0: ffffffff8c82f708 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5f/0x4a0 drivers/char/misc.c:107
 #1: ffffffff8bc536e8 (system_transition_mutex){+.+.}-{3:3}, at: snapshot_open+0x3b/0x2a0 kernel/power/user.c:54
1 lock held by syz-executor.4/21922:
 #0: ffffffff8c82f708 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5f/0x4a0 drivers/char/misc.c:107
----------------------------------------

Possible locations where snapshot_open() might sleep with system_transition_mutex held are
pm_notifier_call_chain_robust()/wait_for_device_probe()/create_basic_memory_bitmaps().
But I think we can exclude pm_notifier_call_chain_robust() because lockdep does not report
that that process is holding "struct blocking_notifier_head"->rwsem. I suspect that
that process is sleeping at wait_for_device_probe(), for it waits for probe operations.

----------------------------------------
void wait_for_device_probe(void)
{
	/* wait for the deferred probe workqueue to finish */
	flush_work(&deferred_probe_work);

	/* wait for the known devices to complete their probing */
	wait_event(probe_waitqueue, atomic_read(&probe_count) == 0);
	async_synchronize_full();
}
----------------------------------------

> 
> Yes, you can sleep in open(), but you shouldn't sleep long, if at all
> possible as it can be annoying.  So why not fix up the offending driver
> not to sleep to long?

We can't predict how long snapshot_open() sleeps inside wait_for_device_probe().

Looking at abovementioned report again, it seems to be common that one process is
inside input_register_handle() and another process is inside input_close_device(),
and these two processes are holding the same &dev->mutex#2 object. Guessing from
the code that input_register_handle() will not sleep with dev->mutex held,
input_close_device() is holding dev->mutex and input_register_handle() is
waiting for input_close_device() to release dev->mutex.

Therefore, there might be a race or deadlock between these two processes.
If &dev->mutex#2 were subjected to device_initialize() magic, lockdep won't be
able to catch the deadlock. But I'm not familiar with device management code...

Maybe input_close_device() is failing to release dev->mutex for some reason?
Maybe nothing but too slow to wait?

----------------------------------------
7 locks held by kworker/1:0/22:
 #0: ffff888011a65d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888011a65d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888011a65d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888011a65d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888011a65d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888011a65d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900001c7da8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff8881479d4190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #2: ffff8881479d4190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4690 drivers/usb/core/hub.c:5691
 #3: ffff888044782190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #3: ffff888044782190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x76/0x530 drivers/base/dd.c:964
 #4: ffff8880447d2118 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #4: ffff8880447d2118 (&dev->mutex){....}-{3:3}, at: __device_attach+0x76/0x530 drivers/base/dd.c:964
 #5: ffffffff8ceafca8 (input_mutex){+.+.}-{3:3}, at: input_register_device.cold+0x34/0x304 drivers/input/input.c:2378
 #6: ffff8880447d52c0 (&dev->mutex#2){+.+.}-{3:3}, at: input_register_handle+0x6d/0x510 drivers/input/input.c:2544

2 locks held by acpid/2962:
 #0: ffff888042a28158 (&joydev->mutex){+.+.}-{3:3}, at: joydev_close_device drivers/input/joydev.c:220 [inline]
 #0: ffff888042a28158 (&joydev->mutex){+.+.}-{3:3}, at: joydev_release+0x187/0x290 drivers/input/joydev.c:252
 #1: ffff8880447d52c0 (&dev->mutex#2){+.+.}-{3:3}, at: input_close_device+0x42/0x1f0 drivers/input/input.c:726

7 locks held by kworker/1:11/5743:
 #0: ffff888011a65d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888011a65d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888011a65d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888011a65d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888011a65d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888011a65d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900153c7da8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888021384190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #2: ffff888021384190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4690 drivers/usb/core/hub.c:5691
 #3: ffff8880468a4190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #3: ffff8880468a4190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x76/0x530 drivers/base/dd.c:964
 #4: ffff8880468a6118 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #4: ffff8880468a6118 (&dev->mutex){....}-{3:3}, at: __device_attach+0x76/0x530 drivers/base/dd.c:964
 #5: ffff8880255f1a20 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #5: ffff8880255f1a20 (&dev->mutex){....}-{3:3}, at: __device_attach+0x76/0x530 drivers/base/dd.c:964
 #6: ffffffff8ceafca8 (input_mutex){+.+.}-{3:3}, at: input_register_device.cold+0x34/0x304 drivers/input/input.c:2378
----------------------------------------

