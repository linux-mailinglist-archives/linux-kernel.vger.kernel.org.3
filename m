Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A444D6A0F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiCKW6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 17:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiCKW6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:58:38 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 53CB224F7B1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:48:23 -0800 (PST)
Received: (qmail 1595351 invoked by uid 1000); 11 Mar 2022 16:01:40 -0500
Date:   Fri, 11 Mar 2022 16:01:40 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+f0fae482604e6d9a87c9@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, pavel.hofman@ivitera.com,
        rob@robgreener.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] memory leak in usb_get_configuration
Message-ID: <Yiu4tCONfHVH1Qfv@rowland.harvard.edu>
References: <000000000000351b8605d9d1d1bf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000351b8605d9d1d1bf@google.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 03:54:24PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0014404f9c18 Merge branch 'akpm' (patches from Andrew)
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15864216700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3f0a704147ec8e32
> dashboard link: https://syzkaller.appspot.com/bug?extid=f0fae482604e6d9a87c9
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a63dbe700000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e150a1700000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f0fae482604e6d9a87c9@syzkaller.appspotmail.com
> 
> BUG: memory leak
> unreferenced object 0xffff88810c0289e0 (size 32):
>   comm "kworker/1:2", pid 139, jiffies 4294947862 (age 15.910s)
>   hex dump (first 32 bytes):
>     09 02 12 00 01 00 00 00 00 09 04 00 00 00 d0 bb  ................
>     3a 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  :...............
>   backtrace:
>     [<ffffffff82c98127>] kmalloc include/linux/slab.h:586 [inline]
>     [<ffffffff82c98127>] usb_get_configuration+0x1c7/0x1cd0 drivers/usb/core/config.c:919
>     [<ffffffff82c863f9>] usb_enumerate_device drivers/usb/core/hub.c:2398 [inline]
>     [<ffffffff82c863f9>] usb_new_device+0x1a9/0x2e0 drivers/usb/core/hub.c:2536
>     [<ffffffff82c88ea4>] hub_port_connect drivers/usb/core/hub.c:5358 [inline]
>     [<ffffffff82c88ea4>] hub_port_connect_change drivers/usb/core/hub.c:5502 [inline]
>     [<ffffffff82c88ea4>] port_event drivers/usb/core/hub.c:5660 [inline]
>     [<ffffffff82c88ea4>] hub_event+0x1364/0x21a0 drivers/usb/core/hub.c:5742
>     [<ffffffff8126a41f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
>     [<ffffffff8126ad49>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
>     [<ffffffff81274705>] kthread+0x125/0x160 kernel/kthread.c:377
>     [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

The console log shows that this is connected to gspca_dev_probe.  Let's 
see who's calling it...

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/  0014404f9c18

Index: usb-devel/drivers/media/usb/gspca/gspca.c
===================================================================
--- usb-devel.orig/drivers/media/usb/gspca/gspca.c
+++ usb-devel/drivers/media/usb/gspca/gspca.c
@@ -1599,6 +1599,7 @@ int gspca_dev_probe(struct usb_interface
 	if (dev->descriptor.bNumConfigurations != 1) {
 		pr_err("%04x:%04x too many config\n",
 		       id->idVendor, id->idProduct);
+		dump_stack();
 		return -ENODEV;
 	}
 
