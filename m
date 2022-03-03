Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCAC4CC711
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 21:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbiCCUbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 15:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbiCCUbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 15:31:21 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id BE05A1786A1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 12:30:34 -0800 (PST)
Received: (qmail 1288865 invoked by uid 1000); 3 Mar 2022 15:30:33 -0500
Date:   Thu, 3 Mar 2022 15:30:33 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+a48e3d1a875240cab5de@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in usbtmc_ioctl/usb_submit_urb
Message-ID: <YiElaWLdXT+m/RJM@rowland.harvard.edu>
References: <00000000000091f0b805d9556a82@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000091f0b805d9556a82@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 11:29:26AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    2293be58d6a1 Merge tag 'trace-v5.17-rc4' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=166215b6700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4b9a7fa580ff2b33
> dashboard link: https://syzkaller.appspot.com/bug?extid=a48e3d1a875240cab5de
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172cdd12700000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170790e6700000
> 
> Bisection is inconclusive: the issue happens on the oldest tested release.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f51482700000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=17f51482700000
> console output: https://syzkaller.appspot.com/x/log.txt?x=13f51482700000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a48e3d1a875240cab5de@syzkaller.appspotmail.com
> 
> usb 5-1: BOGUS control dir, pipe 80001e80 doesn't match bRequestType 0
> WARNING: CPU: 0 PID: 3813 at drivers/usb/core/urb.c:412 usb_submit_urb+0x13a5/0x1970 drivers/usb/core/urb.c:410
> Modules linked in:
> CPU: 0 PID: 3813 Comm: syz-executor122 Not tainted 5.17.0-rc5-syzkaller-00306-g2293be58d6a1 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:usb_submit_urb+0x13a5/0x1970 drivers/usb/core/urb.c:410
> Code: 4c 24 38 8a 04 01 84 c0 0f 85 ad 05 00 00 45 0f b6 06 48 c7 c7 c0 f0 26 8b 48 8b 74 24 20 4c 89 e2 89 d9 31 c0 e8 3b 4b 58 fb <0f> 0b e9 0b f0 ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c a8 ed ff
> RSP: 0018:ffffc90002c3fa40 EFLAGS: 00010246
> RAX: 1323d10499d7ec00 RBX: 0000000080001e80 RCX: ffff88801c2c5700
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffff816aea02 R09: fffffbfff1ffbbde
> R10: fffffbfff1ffbbde R11: 0000000000000000 R12: ffff88801d757618
> R13: ffff88801d79d000 R14: ffff88801da98b18 R15: ffff88807a91f0a8
> FS:  00005555574a2300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa78ffa04d0 CR3: 00000000195f0000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  usb_start_wait_urb+0x113/0x530 drivers/usb/core/message.c:58
>  usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
>  usb_control_msg+0x2a5/0x4b0 drivers/usb/core/message.c:153
>  usbtmc_ioctl_request drivers/usb/class/usbtmc.c:1947 [inline]

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ v5.17-rc4

Index: usb-devel/drivers/usb/class/usbtmc.c
===================================================================
--- usb-devel.orig/drivers/usb/class/usbtmc.c
+++ usb-devel/drivers/usb/class/usbtmc.c
@@ -1919,6 +1919,7 @@ static int usbtmc_ioctl_request(struct u
 	struct usbtmc_ctrlrequest request;
 	u8 *buffer = NULL;
 	int rv;
+	unsigned int is_in, pipe;
 	unsigned long res;
 
 	res = copy_from_user(&request, arg, sizeof(struct usbtmc_ctrlrequest));
@@ -1928,12 +1929,14 @@ static int usbtmc_ioctl_request(struct u
 	if (request.req.wLength > USBTMC_BUFSIZE)
 		return -EMSGSIZE;
 
+	is_in = request.req.bRequestType & USB_DIR_IN;
+
 	if (request.req.wLength) {
 		buffer = kmalloc(request.req.wLength, GFP_KERNEL);
 		if (!buffer)
 			return -ENOMEM;
 
-		if ((request.req.bRequestType & USB_DIR_IN) == 0) {
+		if (!is_in) {
 			/* Send control data to device */
 			res = copy_from_user(buffer, request.data,
 					     request.req.wLength);
@@ -1944,8 +1947,12 @@ static int usbtmc_ioctl_request(struct u
 		}
 	}
 
+	if (is_in)
+		pipe = usb_rcvctrlpipe(data->usb_dev, 0);
+	else
+		pipe = usb_sndctrlpipe(data->usb_dev, 0);
 	rv = usb_control_msg(data->usb_dev,
-			usb_rcvctrlpipe(data->usb_dev, 0),
+			pipe,
 			request.req.bRequest,
 			request.req.bRequestType,
 			request.req.wValue,
@@ -1957,7 +1964,7 @@ static int usbtmc_ioctl_request(struct u
 		goto exit;
 	}
 
-	if (rv && (request.req.bRequestType & USB_DIR_IN)) {
+	if (rv && is_in) {
 		/* Read control data from device */
 		res = copy_to_user(request.data, buffer, rv);
 		if (res)
