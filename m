Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075CC536D55
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 16:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbiE1Op1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 10:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiE1OpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 10:45:25 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 20F0517A98
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 07:45:24 -0700 (PDT)
Received: (qmail 126954 invoked by uid 1000); 28 May 2022 10:45:23 -0400
Date:   Sat, 28 May 2022 10:45:23 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     syzbot <syzbot+02b16343704b3af1667e@syzkaller.appspotmail.com>,
        andreyknvl@gmail.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in driver_unregister
Message-ID: <YpI1g7/sZVYKz5Hn@rowland.harvard.edu>
References: <YpEi/sbT/R/0yKzo@rowland.harvard.edu>
 <000000000000f9e65705e003513a@google.com>
 <YpFEc5zeFK0AXa2q@rowland.harvard.edu>
 <YpIQzJQzd93cWq4M@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpIQzJQzd93cWq4M@kroah.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 02:08:44PM +0200, Greg KH wrote:
> On Fri, May 27, 2022 at 05:36:51PM -0400, Alan Stern wrote:
> > On Fri, May 27, 2022 at 12:29:08PM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > WARNING in sysfs_create_file_ns
> > > 
> > > really_probe: driver_sysfs_add(gadget.0) failed
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 0 PID: 2361 at fs/sysfs/file.c:351 sysfs_create_file_ns+0x131/0x1c0 fs/sysfs/file.c:351
> > > Modules linked in:
> > > CPU: 0 PID: 2361 Comm: syz-executor.0 Not tainted 5.18.0-rc5-syzkaller-00157-g97fa5887cf28-dirty #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > RIP: 0010:sysfs_create_file_ns+0x131/0x1c0 fs/sysfs/file.c:351
> > > Code: e9 03 80 3c 01 00 75 7f 8b 4c 24 38 4d 89 e9 48 89 ee 48 8b 7b 30 44 8b 44 24 48 e8 e9 fa ff ff 41 89 c5 eb 0d e8 cf 7c 9d ff <0f> 0b 41 bd ea ff ff ff e8 c2 7c 9d ff 48 b8 00 00 00 00 00 fc ff
> > > RSP: 0018:ffffc900028ffca0 EFLAGS: 00010293
> > 
> > Here's some extra detail, taken from the console log:
> > 
> > [   98.336685][ T2361] really_probe: driver_sysfs_add(gadget.0) failed
> > [   98.336836][ T2360] sysfs: cannot create duplicate filename '/bus/gadget/drivers/dummy_udc'
> > [   98.343498][ T2361] ------------[ cut here ]------------
> > [   98.352154][ T2360] CPU: 1 PID: 2360 Comm: syz-executor.0 Not tainted 5.18.0-rc5-syzkaller-00157-g97fa5887cf28-dirty #0
> > [   98.357802][ T2361] WARNING: CPU: 0 PID: 2361 at fs/sysfs/file.c:351 sysfs_create_file_ns+0x131/0x1c0
> > 
> > Simultaneous splats from two different threads trying to add drivers with 
> > the same name suggests there might be a concurrency bug in the sysfs 
> > filesystem.  This sort of thing should be an error but it shouldn't bring 
> > the kernel to its knees.
> 
> It's not bringing anything down, it's just giving you a big fat warning
> that the developer did something wrong and it should be fixed.  The
> kernel should keep working just fine after this.
> 
> > Greg, do you know anyone who could take a look at this?  I don't know much 
> > about sysfs.
> 
> It's not a sysfs thing, it's a "we should not register the same driver
> name multiple times" thing, so that subsystem needs to be fixed to make
> this always a unique name.

Okay, here's an attempt at a real fix.

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
@@ -198,6 +205,8 @@ static void dev_free(struct kref *kref)
 
 	kfree(dev->udc_name);
 	kfree(dev->driver.udc_name);
+	kfree(dev->driver.driver.name);
+	ida_free(&driver_id_numbers, dev->driver_id_number);
 	if (dev->req) {
 		if (dev->ep0_urb_queued)
 			usb_ep_dequeue(dev->gadget->ep0, dev->req);
@@ -421,6 +430,7 @@ static int raw_ioctl_init(struct raw_dev
 	struct usb_raw_init arg;
 	char *udc_driver_name;
 	char *udc_device_name;
+	char *driver_driver_name;
 	unsigned long flags;
 
 	if (copy_from_user(&arg, (void __user *)value, sizeof(arg)))
@@ -439,36 +449,44 @@ static int raw_ioctl_init(struct raw_dev
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
@@ -483,14 +501,24 @@ static int raw_ioctl_init(struct raw_dev
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
 
