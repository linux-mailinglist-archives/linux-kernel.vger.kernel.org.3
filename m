Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C434048264A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 03:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbiAACHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 21:07:14 -0500
Received: from netrider.rowland.org ([192.131.102.5]:59359 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231915AbiAACHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 21:07:13 -0500
Received: (qmail 1142479 invoked by uid 1000); 31 Dec 2021 21:07:12 -0500
Date:   Fri, 31 Dec 2021 21:07:12 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg KH <greg@kroah.com>
Cc:     USB mailing list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH] USB: Fix "slab-out-of-bounds Write" bug in
 usb_hcd_poll_rh_status
Message-ID: <Yc+3UIQJ2STbxNua@rowland.harvard.edu>
References: <Yc9odypVqqB2uMm/@rowland.harvard.edu>
 <00000000000060560805d4773ba0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000060560805d4773ba0@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the USB core code for getting root-hub status reports was
originally written, it was assumed that the hub driver would be its
only caller.  But this isn't true now; user programs can use usbfs to
communicate with root hubs and get status reports.  When they do this,
they may use a transfer_buffer that is smaller than the data returned
by the HCD, which will lead to a buffer overflow error when
usb_hcd_poll_rh_status() tries to store the status data.  This was
discovered by syzbot:

BUG: KASAN: slab-out-of-bounds in memcpy include/linux/fortify-string.h:225 [inline]
BUG: KASAN: slab-out-of-bounds in usb_hcd_poll_rh_status+0x5f4/0x780 drivers/usb/core/hcd.c:776
Write of size 2 at addr ffff88801da403c0 by task syz-executor133/4062

This patch fixes the bug by reducing the amount of status data if it
won't fit in the transfer_buffer.  If some data gets discarded then
the URB's completion status is set to -EOVERFLOW rather than 0, to let
the user know what happened.

Reported-and-tested-by: syzbot+3ae6a2b06f131ab9849f@syzkaller.appspotmail.com
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Cc: <stable@vger.kernel.org>

---


[as1966]


 drivers/usb/core/hcd.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Index: usb-devel/drivers/usb/core/hcd.c
===================================================================
--- usb-devel.orig/drivers/usb/core/hcd.c
+++ usb-devel/drivers/usb/core/hcd.c
@@ -753,6 +753,7 @@ void usb_hcd_poll_rh_status(struct usb_h
 {
 	struct urb	*urb;
 	int		length;
+	int		status;
 	unsigned long	flags;
 	char		buffer[6];	/* Any root hubs with > 31 ports? */
 
@@ -770,11 +771,17 @@ void usb_hcd_poll_rh_status(struct usb_h
 		if (urb) {
 			clear_bit(HCD_FLAG_POLL_PENDING, &hcd->flags);
 			hcd->status_urb = NULL;
+			if (urb->transfer_buffer_length >= length) {
+				status = 0;
+			} else {
+				status = -EOVERFLOW;
+				length = urb->transfer_buffer_length;
+			}
 			urb->actual_length = length;
 			memcpy(urb->transfer_buffer, buffer, length);
 
 			usb_hcd_unlink_urb_from_ep(hcd, urb);
-			usb_hcd_giveback_urb(hcd, urb, 0);
+			usb_hcd_giveback_urb(hcd, urb, status);
 		} else {
 			length = 0;
 			set_bit(HCD_FLAG_POLL_PENDING, &hcd->flags);
