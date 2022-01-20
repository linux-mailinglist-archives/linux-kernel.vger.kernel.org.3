Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E7C495339
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiATR2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:28:50 -0500
Received: from netrider.rowland.org ([192.131.102.5]:33033 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231535AbiATR2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:28:43 -0500
Received: (qmail 157157 invoked by uid 1000); 20 Jan 2022 12:28:42 -0500
Date:   Thu, 20 Jan 2022 12:28:42 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+76629376e06e2c2ad626@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, hdanton@sina.com, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        paskripkin@gmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] INFO: task hung in hub_port_init (2)
Message-ID: <YembypBPqEXg+YB+@rowland.harvard.edu>
References: <20220120080020.2619-1-hdanton@sina.com>
 <000000000000836a4805d5ff0b2b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000836a4805d5ff0b2b@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 12:11:10AM -0800, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-and-tested-by: syzbot+76629376e06e2c2ad626@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         6f59bc24 Add linux-next specific files for 20220118
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> kernel config:  https://syzkaller.appspot.com/x/.config?x=94e8da4df9ab6319
> dashboard link: https://syzkaller.appspot.com/bug?extid=76629376e06e2c2ad626
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=101ba7efb00000
> 
> Note: testing is done by a robot and is best-effort only.

Attempted fix.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/ 6f59bc24

Index: usb-devel/drivers/usb/core/hcd.c
===================================================================
--- usb-devel.orig/drivers/usb/core/hcd.c
+++ usb-devel/drivers/usb/core/hcd.c
@@ -1563,6 +1563,12 @@ int usb_hcd_submit_urb (struct urb *urb,
 		urb->hcpriv = NULL;
 		INIT_LIST_HEAD(&urb->urb_list);
 		atomic_dec(&urb->use_count);
+		/*
+		 * Order the write of urb->use_count above against the read of
+		 * urb->reject below.  Pairs with the memory barriers in
+		 * usb_kill_urb() and usb_poison_urb().
+		 */
+		smp_mb__after_atomic();
 		atomic_dec(&urb->dev->urbnum);
 		if (atomic_read(&urb->reject))
 			wake_up(&usb_kill_urb_queue);
@@ -1665,6 +1671,13 @@ static void __usb_hcd_giveback_urb(struc
 
 	usb_anchor_resume_wakeups(anchor);
 	atomic_dec(&urb->use_count);
+	/*
+	 * Order the write of urb->use_count above against the read of
+	 * urb->reject below.  Pairs with the memory barriers in
+	 * usb_kill_urb() and usb_poison_urb().
+	 */
+	smp_mb__after_atomic();
+
 	if (unlikely(atomic_read(&urb->reject)))
 		wake_up(&usb_kill_urb_queue);
 	usb_put_urb(urb);
Index: usb-devel/drivers/usb/core/urb.c
===================================================================
--- usb-devel.orig/drivers/usb/core/urb.c
+++ usb-devel/drivers/usb/core/urb.c
@@ -715,6 +715,12 @@ void usb_kill_urb(struct urb *urb)
 	if (!(urb && urb->dev && urb->ep))
 		return;
 	atomic_inc(&urb->reject);
+	/*
+	 * Order the write of urb->reject above against the read of
+	 * urb->use_count below.  Pairs with the barriers in
+	 * __usb_hcd_giveback_urb() and usb_hcd_submit_urb().
+	 */
+	smp_mb__after_atomic();
 
 	usb_hcd_unlink_urb(urb, -ENOENT);
 	wait_event(usb_kill_urb_queue, atomic_read(&urb->use_count) == 0);
@@ -756,6 +762,12 @@ void usb_poison_urb(struct urb *urb)
 	if (!urb)
 		return;
 	atomic_inc(&urb->reject);
+	/*
+	 * Order the write of urb->reject above against the read of
+	 * urb->use_count below.  Pairs with the barriers in
+	 * __usb_hcd_giveback_urb() and usb_hcd_submit_urb().
+	 */
+	smp_mb__after_atomic();
 
 	if (!urb->dev || !urb->ep)
 		return;

