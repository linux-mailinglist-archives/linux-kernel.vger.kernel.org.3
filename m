Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AA248218D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 03:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242284AbhLaCbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 21:31:31 -0500
Received: from netrider.rowland.org ([192.131.102.5]:38421 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S237557AbhLaCba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 21:31:30 -0500
Received: (qmail 1123353 invoked by uid 1000); 30 Dec 2021 21:31:29 -0500
Date:   Thu, 30 Dec 2021 21:31:29 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+3ae6a2b06f131ab9849f@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, dvyukov@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Write in
 usb_hcd_poll_rh_status (2)
Message-ID: <Yc5rgUo8dyJKX98M@rowland.harvard.edu>
References: <Yc4RsFnaFfbCUeRy@rowland.harvard.edu>
 <0000000000007e5fdb05d4668af8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007e5fdb05d4668af8@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Trimmed CC: list]

On Thu, Dec 30, 2021 at 04:49:18PM -0800, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> KASAN: slab-out-of-bounds Write in usb_hcd_poll_rh_status
...
> Tested on:
> 
> commit:         eec4df26 Merge tag 's390-5.16-6' of git://git.kernel.o..
> git tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/

I'm glad to see that the git tree is reported properly, but the commit 
label is too short.  The reproducer bug report had exactly the opposite 
problems!  It said:

> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    eec4df26e24e Merge tag 's390-5.16-6' of git://git.kernel.o..
> git tree:       upstream

Andrey or Dmitry?  Can you guys unify these two outputs to make both 
lines correct always?

Moving on...  Important lines from the console log:

[   76.919138][ T4081] usb usb9: usbdev_do_ioctl: BULK
[   76.924966][ T4081] usb usb9: usbfs: process 4081 (syz-executor189) did not claim interface 0 before use
[   76.935186][ T4081] usb usb9: ep1 int-in, length 1, timeout 9
[   76.941355][ T4099] usb usb9: opened by process 4099: syz-executor189
[   76.942606][ T4087] usb usb9: usbdev_do_ioctl: BULK
[   76.949968][    C1] 
==================================================================
[   76.950070][    C1] BUG: KASAN: slab-out-of-bounds in usb_hcd_poll_rh_status+0x376/0x780
[   76.950102][    C1] Write of size 2 at addr ffff8880121ae230 by task syz-executor189/4087

It's hard to tell what's really happening.  The suspicious part is the 
"length 1" combined with the "Write of size 2" -- but they refer to 
different processes!

Maybe this diagnostic patch will help a little.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ eec4df26e24e

Index: usb-devel/drivers/usb/core/devio.c
===================================================================
--- usb-devel.orig/drivers/usb/core/devio.c
+++ usb-devel/drivers/usb/core/devio.c
@@ -109,7 +109,7 @@ struct async {
 	u8 bulk_status;
 };
 
-static bool usbfs_snoop;
+static bool usbfs_snoop = true;
 module_param(usbfs_snoop, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(usbfs_snoop, "true to log all usbfs traffic");
 
Index: usb-devel/drivers/usb/core/hcd.c
===================================================================
--- usb-devel.orig/drivers/usb/core/hcd.c
+++ usb-devel/drivers/usb/core/hcd.c
@@ -809,8 +809,10 @@ static int rh_queue_status (struct usb_h
 	unsigned	len = 1 + (urb->dev->maxchild / 8);
 
 	spin_lock_irqsave (&hcd_root_hub_lock, flags);
+	dev_info(hcd->self.controller, "rh_queue_status: len %d tblen %d\n",
+			len, urb->transfer_buffer_length);
 	if (hcd->status_urb || urb->transfer_buffer_length < len) {
-		dev_dbg (hcd->self.controller, "not queuing rh status urb\n");
+		dev_info(hcd->self.controller, "not queuing rh status urb\n");
 		retval = -EINVAL;
 		goto done;
 	}

