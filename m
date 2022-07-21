Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC3257CCC2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiGUN6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiGUN6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:58:47 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id F069C30F7A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:58:42 -0700 (PDT)
Received: (qmail 230677 invoked by uid 1000); 21 Jul 2022 09:58:42 -0400
Date:   Thu, 21 Jul 2022 09:58:42 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+b0de012ceb1e2a97891b@syzkaller.appspotmail.com>
Cc:     andriy.shevchenko@linux.intel.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rogerq@ti.com,
        syzkaller-bugs@googlegroups.com, zhengdejin5@gmail.com
Subject: Re: [syzbot] KASAN: use-after-free Read in usb_udc_uevent
Message-ID: <YtlbkmVGJyhO4kR6@rowland.harvard.edu>
References: <0000000000004de90405a719c951@google.com>
 <000000000000d36e8705e4406a16@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d36e8705e4406a16@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 11:03:24AM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    cb71b93c2dc3 Add linux-next specific files for 20220628
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=172591aa080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
> dashboard link: https://syzkaller.appspot.com/bug?extid=b0de012ceb1e2a97891b
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ab4d62080000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b0de012ceb1e2a97891b@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in usb_udc_uevent+0x11f/0x130 drivers/usb/gadget/udc/core.c:1732
> Read of size 8 at addr ffff888078ce2050 by task udevd/2968
> 
> CPU: 1 PID: 2968 Comm: udevd Not tainted 5.19.0-rc4-next-20220628-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:317 [inline]
>  print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
>  kasan_report+0xbe/0x1f0 mm/kasan/report.c:495
>  usb_udc_uevent+0x11f/0x130 drivers/usb/gadget/udc/core.c:1732
>  dev_uevent+0x290/0x770 drivers/base/core.c:2424
>  uevent_show+0x1b8/0x380 drivers/base/core.c:2480

It looks like the usb_udc_uevent call races with gadget removal.  The 
problem is that usb_udc_uevent accesses udc->driver but does not hold 
the udc_lock mutex (which protects this field) while doing so.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/ cb71b93c2dc3

Index: usb-devel/drivers/usb/gadget/udc/core.c
===================================================================
--- usb-devel.orig/drivers/usb/gadget/udc/core.c
+++ usb-devel/drivers/usb/gadget/udc/core.c
@@ -1728,13 +1728,14 @@ static int usb_udc_uevent(struct device
 		return ret;
 	}
 
-	if (udc->driver) {
+	mutex_lock(&udc_lock);
+	if (udc->driver)
 		ret = add_uevent_var(env, "USB_UDC_DRIVER=%s",
 				udc->driver->function);
-		if (ret) {
-			dev_err(dev, "failed to add uevent USB_UDC_DRIVER\n");
-			return ret;
-		}
+	mutex_unlock(&udc_lock);
+	if (ret) {
+		dev_err(dev, "failed to add uevent USB_UDC_DRIVER\n");
+		return ret;
 	}
 
 	return 0;

