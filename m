Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70502482569
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 18:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhLaRdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 12:33:02 -0500
Received: from netrider.rowland.org ([192.131.102.5]:39931 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229690AbhLaRdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 12:33:01 -0500
Received: (qmail 1135077 invoked by uid 1000); 31 Dec 2021 12:33:00 -0500
Date:   Fri, 31 Dec 2021 12:33:00 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+3ae6a2b06f131ab9849f@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, dvyukov@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Write in
 usb_hcd_poll_rh_status (2)
Message-ID: <Yc8+zLP8KTB8gT71@rowland.harvard.edu>
References: <Yc5rgUo8dyJKX98M@rowland.harvard.edu>
 <00000000000065d16005d46a614b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000065d16005d46a614b@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 09:24:09PM -0800, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> KASAN: slab-out-of-bounds Write in usb_hcd_poll_rh_status
> 
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in memcpy include/linux/fortify-string.h:225 [inline]
> BUG: KASAN: slab-out-of-bounds in usb_hcd_poll_rh_status+0x376/0x780 drivers/usb/core/hcd.c:774
> Write of size 2 at addr ffff8880127f7028 by task syz-executor029/4082

Still not enough information.

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
@@ -771,6 +771,8 @@ void usb_hcd_poll_rh_status(struct usb_h
 			clear_bit(HCD_FLAG_POLL_PENDING, &hcd->flags);
 			hcd->status_urb = NULL;
 			urb->actual_length = length;
+			dev_info(hcd->self.controller, "poll_rh_status: len %d maxch %d tblen %d\n",
+					length, urb->dev->maxchild, urb->transfer_buffer_length);
 			memcpy(urb->transfer_buffer, buffer, length);
 
 			usb_hcd_unlink_urb_from_ep(hcd, urb);
@@ -809,8 +811,10 @@ static int rh_queue_status (struct usb_h
 	unsigned	len = 1 + (urb->dev->maxchild / 8);
 
 	spin_lock_irqsave (&hcd_root_hub_lock, flags);
+	dev_info(hcd->self.controller, "rh_queue_status: len %d maxch %d tblen %d\n",
+			len, urb->dev->maxchild, urb->transfer_buffer_length);
 	if (hcd->status_urb || urb->transfer_buffer_length < len) {
-		dev_dbg (hcd->self.controller, "not queuing rh status urb\n");
+		dev_info(hcd->self.controller, "not queuing rh status urb\n");
 		retval = -EINVAL;
 		goto done;
 	}

