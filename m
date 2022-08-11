Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106DA590588
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbiHKRPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiHKROl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:14:41 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 547B1A0246
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:58:06 -0700 (PDT)
Received: (qmail 10155 invoked by uid 1000); 11 Aug 2022 12:58:05 -0400
Date:   Thu, 11 Aug 2022 12:58:05 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Rondreis <linhaoguo86@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: possible recursive locking detected in kernel v5.18
Message-ID: <YvU1HSa6ipoWc4BA@rowland.harvard.edu>
References: <CAB7eexKUpvX-JNiLzhXBDWgfg2T9e9_0Tw4HQ6keN==voRbP0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB7eexKUpvX-JNiLzhXBDWgfg2T9e9_0Tw4HQ6keN==voRbP0g@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 10:06:37AM +0800, Rondreis wrote:
> Hello,
> 
> When fuzzing the Linux kernel driver v5.18.0, the following crash was triggered.
> 
> HEAD commit: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f (HEAD, tag: v5.18)
> git tree: upstream
> 
> kernel config: https://pastebin.com/KecL2gaG
> C reproducer: https://pastebin.com/ZX3ZtZZ4
> console output: https://pastebin.com/UYyiRL3E
> 
> Basically, in the c reproducer, we use the gadget module to emulate
> the process of attaching a usb device (vendor id: 0x13d3, product id:
> 0x3340, with function: ms_null and midi_null).
> To reproduce this crash, we utilize a third-party library to emulate
> the attaching process: https://github.com/linux-usb-gadgets/libusbgx.
> Just clone this repository, make install it, and compile the c
> reproducer with ``` gcc crash.c -lusbgx -o crash ``` will do the
> trick.
> 
> It seems that there is a deadlock happened in function usb_stor_post_reset
> 
> The crash report is as follow:
> 
> ```
> usb 7-1: r8712u: Loading firmware from "rtlwifi/rtl8712u.bin"
> ============================================
> WARNING: possible recursive locking detected
> 5.18.0 #3 Not tainted
> --------------------------------------------
> kworker/1:3/1205 is trying to acquire lock:
> ffff888018638db8 (&us_interface_key[i]){+.+.}-{3:3}, at:
> usb_stor_pre_reset+0x35/0x40 drivers/usb/storage/usb.c:230
> 
> but task is already holding lock:
> ffff888018638db8 (&us_interface_key[i]){+.+.}-{3:3}, at:
> usb_stor_pre_reset+0x35/0x40 drivers/usb/storage/usb.c:230
> 
> other info that might help us debug this:
> Possible unsafe locking scenario:
> 
> CPU0
> ----
> lock(&us_interface_key[i]);
> lock(&us_interface_key[i]);
> 
> *** DEADLOCK ***
> 
> May be due to missing lock nesting notation
> 
> 7 locks held by kworker/1:3/1205:
> #0: ffff888105a82d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
> arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
> #0: ffff888105a82d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
> arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
> #0: ffff888105a82d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
> atomic_long_set include/linux/atomic/atomic-instrumented.h:1280
> [inline]
> #0: ffff888105a82d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
> set_work_data kernel/workqueue.c:636 [inline]
> #0: ffff888105a82d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
> set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
> #0: ffff888105a82d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
> process_one_work+0x8b0/0x1650 kernel/workqueue.c:2260
> #1: ffffc900004f7db0 ((work_completion)(&hub->events)){+.+.}-{0:0},
> at: process_one_work+0x8e4/0x1650 kernel/workqueue.c:2264
> #2: ffff88810be5a220 (&dev->mutex){....}-{3:3}, at: device_lock
> include/linux/device.h:835 [inline]
> #2: ffff88810be5a220 (&dev->mutex){....}-{3:3}, at:
> hub_event+0x1c1/0x4170 drivers/usb/core/hub.c:5691
> #3: ffff888110850220 (&dev->mutex){....}-{3:3}, at:
> __device_attach+0x7b/0x3f0 drivers/base/dd.c:965
> #4: ffff888018a871a8 (&dev->mutex){....}-{3:3}, at:
> __device_attach+0x7b/0x3f0 drivers/base/dd.c:965
> #5: ffff888018638db8 (&us_interface_key[i]){+.+.}-{3:3}, at:
> usb_stor_pre_reset+0x35/0x40 drivers/usb/storage/usb.c:230
> #6: ffff8881085711a8 (&dev->mutex){....}-{3:3}, at:
> device_release_driver_internal+0x23/0x2f0 drivers/base/dd.c:1245
> 
> stack backtrace:
> CPU: 1 PID: 1205 Comm: kworker/1:3 Not tainted 5.18.0 #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> Workqueue: usb_hub_wq hub_event
> Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:88 [inline]
> dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> print_deadlock_bug kernel/locking/lockdep.c:2988 [inline]
> check_deadlock kernel/locking/lockdep.c:3031 [inline]
> validate_chain kernel/locking/lockdep.c:3816 [inline]
> __lock_acquire.cold+0x152/0x3ca kernel/locking/lockdep.c:5053
> lock_acquire kernel/locking/lockdep.c:5665 [inline]
> lock_acquire+0x1ab/0x520 kernel/locking/lockdep.c:5630
> __mutex_lock_common kernel/locking/mutex.c:603 [inline]
> __mutex_lock+0x14f/0x1610 kernel/locking/mutex.c:747
> usb_stor_pre_reset+0x35/0x40 drivers/usb/storage/usb.c:230
> usb_reset_device+0x37d/0x9a0 drivers/usb/core/hub.c:6109
> r871xu_dev_remove+0x21a/0x270 drivers/staging/rtl8712/usb_intf.c:622
> usb_unbind_interface+0x1bd/0x890 drivers/usb/core/driver.c:458
> device_remove drivers/base/dd.c:545 [inline]
> device_remove+0x11f/0x170 drivers/base/dd.c:537
> __device_release_driver drivers/base/dd.c:1222 [inline]
> device_release_driver_internal+0x1a7/0x2f0 drivers/base/dd.c:1248
> usb_driver_release_interface+0x102/0x180 drivers/usb/core/driver.c:627
> usb_forced_unbind_intf+0x4d/0xa0 drivers/usb/core/driver.c:1118
> usb_reset_device+0x39b/0x9a0 drivers/usb/core/hub.c:6114
> rt2x00usb_probe+0x53/0x7f0
> usb_probe_interface+0x310/0x800 drivers/usb/core/driver.c:396
> call_driver_probe drivers/base/dd.c:555 [inline]
> really_probe drivers/base/dd.c:634 [inline]
> really_probe+0x23e/0xa00 drivers/base/dd.c:579
> __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:764
> driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:794
> __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:917
> bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
> __device_attach+0x26d/0x3f0 drivers/base/dd.c:989
> bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
> device_add+0xc45/0x1d40 drivers/base/core.c:3412
> usb_set_configuration+0x1019/0x1900 drivers/usb/core/message.c:2170
> usb_generic_driver_probe+0x9d/0xe0 drivers/usb/core/generic.c:238
> usb_probe_device+0xd9/0x2a0 drivers/usb/core/driver.c:293
> call_driver_probe drivers/base/dd.c:555 [inline]
> really_probe drivers/base/dd.c:634 [inline]
> really_probe+0x23e/0xa00 drivers/base/dd.c:579
> __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:764
> driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:794
> __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:917
> bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
> __device_attach+0x26d/0x3f0 drivers/base/dd.c:989
> bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
> device_add+0xc45/0x1d40 drivers/base/core.c:3412
> usb_new_device.cold+0x4b8/0x10ca drivers/usb/core/hub.c:2566
> hub_port_connect drivers/usb/core/hub.c:5359 [inline]
> hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
> port_event drivers/usb/core/hub.c:5663 [inline]
> hub_event+0x231e/0x4170 drivers/usb/core/hub.c:5745
> process_one_work+0x9cc/0x1650 kernel/workqueue.c:2289
> worker_thread+0x623/0x1070 kernel/workqueue.c:2436
> kthread+0x2ef/0x3a0 kernel/kthread.c:346
> ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
> </TASK>
> 
> 
> ```

Can you test the patch below?

Alan Stern



Index: usb-devel/drivers/staging/rtl8712/usb_intf.c
===================================================================
--- usb-devel.orig/drivers/staging/rtl8712/usb_intf.c
+++ usb-devel/drivers/staging/rtl8712/usb_intf.c
@@ -614,13 +614,6 @@ static void r871xu_dev_remove(struct usb
 	 * when disconnect
 	 */
 	usb_put_dev(udev);
-
-	/* If we didn't unplug usb dongle and remove/insert module, driver
-	 * fails on sitesurvey for the first time when device is up.
-	 * Reset usb port for sitesurvey fail issue.
-	 */
-	if (udev->state != USB_STATE_NOTATTACHED)
-		usb_reset_device(udev);
 }
 
 static int __init r8712u_drv_entry(void)

