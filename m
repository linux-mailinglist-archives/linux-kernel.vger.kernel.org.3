Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D545F536DF0
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 19:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239062AbiE1RX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 13:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiE1RXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 13:23:22 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B71F611A1E
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 10:23:20 -0700 (PDT)
Received: (qmail 129814 invoked by uid 1000); 28 May 2022 13:23:20 -0400
Date:   Sat, 28 May 2022 13:23:20 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+02b16343704b3af1667e@syzkaller.appspotmail.com>
Cc:     andreyknvl@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in driver_unregister
Message-ID: <YpJaiGRcRjDzRxQC@rowland.harvard.edu>
References: <YpJNQN6++raKTXS5@rowland.harvard.edu>
 <0000000000005b7a1b05e0156265@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000005b7a1b05e0156265@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 10:02:12AM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> WARNING in driver_unregister
> 
> ------------[ cut here ]------------
> Unexpected driver unregister!
> WARNING: CPU: 0 PID: 2335 at drivers/base/driver.c:194 driver_unregister drivers/base/driver.c:194 [inline]
> WARNING: CPU: 0 PID: 2335 at drivers/base/driver.c:194 driver_unregister+0x8c/0xb0 drivers/base/driver.c:191
> Modules linked in:
> CPU: 0 PID: 2335 Comm: syz-executor.0 Not tainted 5.18.0-rc5-syzkaller-00157-g97fa5887cf28-dirty #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:driver_unregister drivers/base/driver.c:194 [inline]
> RIP: 0010:driver_unregister+0x8c/0xb0 drivers/base/driver.c:191
> Code: 68 4c 89 e7 e8 65 b9 db fe 48 89 ef e8 fd a0 ff ff 5d 41 5c e9 75 fa 78 fe e8 70 fa 78 fe 48 c7 c7 80 7a 81 86 e8 12 96 ee 02 <0f> 0b 5d 41 5c e9 5a fa 78 fe e8 75 93 ad fe eb 96 e8 6e 93 ad fe
> RSP: 0018:ffffc9000267fa78 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffff888118006050 RCX: 0000000000000000
> RDX: ffff888114fe8000 RSI: ffffffff812bdce8 RDI: fffff520004cff41
> RBP: ffff888118006098 R08: 0000000000000000 R09: 0000000000000001
> R10: ffffffff812b86be R11: 0000000000000000 R12: 0000000000000000
> R13: ffff888118006008 R14: ffff88811785e7a8 R15: ffff888100219ca0
> FS:  0000000000000000(0000) GS:ffff8881f6800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fc6f40b3718 CR3: 0000000007825000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  usb_gadget_unregister_driver+0x48/0x70 drivers/usb/gadget/udc/core.c:1590
>  raw_release+0x18b/0x290 drivers/usb/gadget/legacy/raw_gadget.c:412

Let's try getting some better information about what's really happening.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git 97fa5887cf28

Index: usb-devel/drivers/usb/gadget/legacy/raw_gadget.c
===================================================================
--- usb-devel.orig/drivers/usb/gadget/legacy/raw_gadget.c
+++ usb-devel/drivers/usb/gadget/legacy/raw_gadget.c
@@ -11,6 +11,7 @@
 #include <linux/ctype.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
+#include <linux/idr.h>
 #include <linux/kref.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
@@ -36,6 +37,9 @@ MODULE_LICENSE("GPL");
 
 /*----------------------------------------------------------------------*/
 
+static DEFINE_IDA(driver_id_numbers);
+#define DRIVER_DRIVER_NAME_LENGTH_MAX	32
+
 #define RAW_EVENT_QUEUE_SIZE	16
 
 struct raw_event_queue {
@@ -160,6 +164,9 @@ struct raw_dev {
 	/* Reference to misc device: */
 	struct device			*dev;
 
+	/* Make driver names unique */
+	int				driver_id_number;
+
 	/* Protected by lock: */
 	enum dev_state			state;
 	bool				gadget_registered;
@@ -188,6 +195,7 @@ static struct raw_dev *dev_new(void)
 	spin_lock_init(&dev->lock);
 	init_completion(&dev->ep0_done);
 	raw_event_queue_init(&dev->queue);
+	dev->driver_id_number = -1;
 	return dev;
 }
 
@@ -198,6 +206,9 @@ static void dev_free(struct kref *kref)
 
 	kfree(dev->udc_name);
 	kfree(dev->driver.udc_name);
+	kfree(dev->driver.driver.name);
+	if (dev->driver_id_number >= 0)
+		ida_free(&driver_id_numbers, dev->driver_id_number);
 	if (dev->req) {
 		if (dev->ep0_urb_queued)
 			usb_ep_dequeue(dev->gadget->ep0, dev->req);
@@ -398,6 +409,7 @@ static int raw_release(struct inode *ino
 	spin_unlock_irqrestore(&dev->lock, flags);
 
 	if (unregister) {
+		dev_info(dev->dev, "Unregistering driver %d at %px", dev->driver_id_number, dev);
 		ret = usb_gadget_unregister_driver(&dev->driver);
 		if (ret != 0)
 			dev_err(dev->dev,
@@ -421,6 +433,7 @@ static int raw_ioctl_init(struct raw_dev
 	struct usb_raw_init arg;
 	char *udc_driver_name;
 	char *udc_device_name;
+	char *driver_driver_name;
 	unsigned long flags;
 
 	if (copy_from_user(&arg, (void __user *)value, sizeof(arg)))
@@ -439,36 +452,44 @@ static int raw_ioctl_init(struct raw_dev
 		return -EINVAL;
 	}
 
+	ret = ida_alloc(&driver_id_numbers, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+	dev->driver_id_number = ret;
+
+	driver_driver_name = kmalloc(DRIVER_DRIVER_NAME_LENGTH_MAX, GFP_KERNEL);
+	if (!driver_driver_name) {
+		ret = -ENOMEM;
+		goto out_free_driver_id_number;
+	}
+	snprintf(driver_driver_name, DRIVER_DRIVER_NAME_LENGTH_MAX,
+				DRIVER_NAME ".%d", dev->driver_id_number);
+
 	udc_driver_name = kmalloc(UDC_NAME_LENGTH_MAX, GFP_KERNEL);
-	if (!udc_driver_name)
-		return -ENOMEM;
+	if (!udc_driver_name) {
+		ret = -ENOMEM;
+		goto out_free_driver_driver_name;
+	}
 	ret = strscpy(udc_driver_name, &arg.driver_name[0],
 				UDC_NAME_LENGTH_MAX);
-	if (ret < 0) {
-		kfree(udc_driver_name);
-		return ret;
-	}
+	if (ret < 0)
+		goto out_free_udc_driver_name;
 	ret = 0;
 
 	udc_device_name = kmalloc(UDC_NAME_LENGTH_MAX, GFP_KERNEL);
 	if (!udc_device_name) {
-		kfree(udc_driver_name);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out_free_udc_driver_name;
 	}
 	ret = strscpy(udc_device_name, &arg.device_name[0],
 				UDC_NAME_LENGTH_MAX);
-	if (ret < 0) {
-		kfree(udc_driver_name);
-		kfree(udc_device_name);
-		return ret;
-	}
+	if (ret < 0)
+		goto out_free_udc_device_name;
 	ret = 0;
 
 	spin_lock_irqsave(&dev->lock, flags);
 	if (dev->state != STATE_DEV_OPENED) {
 		dev_dbg(dev->dev, "fail, device is not opened\n");
-		kfree(udc_driver_name);
-		kfree(udc_device_name);
 		ret = -EINVAL;
 		goto out_unlock;
 	}
@@ -483,14 +504,24 @@ static int raw_ioctl_init(struct raw_dev
 	dev->driver.suspend = gadget_suspend;
 	dev->driver.resume = gadget_resume;
 	dev->driver.reset = gadget_reset;
-	dev->driver.driver.name = DRIVER_NAME;
+	dev->driver.driver.name = driver_driver_name;
 	dev->driver.udc_name = udc_device_name;
 	dev->driver.match_existing_only = 1;
 
 	dev->state = STATE_DEV_INITIALIZED;
+	spin_unlock_irqrestore(&dev->lock, flags);
+	return ret;
 
 out_unlock:
 	spin_unlock_irqrestore(&dev->lock, flags);
+out_free_udc_device_name:
+	kfree(udc_device_name);
+out_free_udc_driver_name:
+	kfree(udc_driver_name);
+out_free_driver_driver_name:
+	kfree(driver_driver_name);
+out_free_driver_id_number:
+	ida_free(&driver_id_numbers, dev->driver_id_number);
 	return ret;
 }
 
@@ -510,6 +541,7 @@ static int raw_ioctl_run(struct raw_dev
 	}
 	spin_unlock_irqrestore(&dev->lock, flags);
 
+	dev_info(dev->dev, "Registering driver %d at %px", dev->driver_id_number, dev);
 	ret = usb_gadget_register_driver(&dev->driver);
 
 	spin_lock_irqsave(&dev->lock, flags);
