Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95E94B2F57
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353734AbiBKVXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:23:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353697AbiBKVXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:23:49 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4C698C5C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 13:23:47 -0800 (PST)
Received: (qmail 646920 invoked by uid 1000); 11 Feb 2022 16:23:46 -0500
Date:   Fri, 11 Feb 2022 16:23:46 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+8caaaec4e7a55d75e243@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-input@vger.kernel.org, noralf@tronnes.org,
        syzkaller-bugs@googlegroups.com, tzimmermann@suse.de
Subject: Re: [syzbot] memory leak in hub_event (3)
Message-ID: <YgbT4uqSIVY9ku10@rowland.harvard.edu>
References: <0000000000005cacef05d7c3c10d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000005cacef05d7c3c10d@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 12:17:26PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    dfd42facf1e4 Linux 5.17-rc3
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14b4ef7c700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=48b71604a367da6e
> dashboard link: https://syzkaller.appspot.com/bug?extid=8caaaec4e7a55d75e243
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1396902c700000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1466e662700000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8caaaec4e7a55d75e243@syzkaller.appspotmail.com
> 
> BUG: memory leak
> unreferenced object 0xffff88810d49e800 (size 2048):
>   comm "kworker/1:1", pid 25, jiffies 4294954629 (age 16.460s)
>   hex dump (first 32 bytes):
>     ff ff ff ff 31 00 00 00 00 00 00 00 00 00 00 00  ....1...........
>     00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00  ................
>   backtrace:
>     [<ffffffff82c87a62>] kmalloc include/linux/slab.h:581 [inline]
>     [<ffffffff82c87a62>] kzalloc include/linux/slab.h:715 [inline]
>     [<ffffffff82c87a62>] usb_alloc_dev+0x32/0x450 drivers/usb/core/usb.c:582
>     [<ffffffff82c91a47>] hub_port_connect drivers/usb/core/hub.c:5260 [inline]
>     [<ffffffff82c91a47>] hub_port_connect_change drivers/usb/core/hub.c:5502 [inline]
>     [<ffffffff82c91a47>] port_event drivers/usb/core/hub.c:5660 [inline]
>     [<ffffffff82c91a47>] hub_event+0x1097/0x21a0 drivers/usb/core/hub.c:5742
>     [<ffffffff8126c3ef>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
>     [<ffffffff8126ccd9>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
>     [<ffffffff81276765>] kthread+0x125/0x160 kernel/kthread.c:377
>     [<ffffffff810022ff>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

There's a refcount leak in the probe-failure path of the hid-elo driver.  
(You can see that this is the relevant driver in the console output.)  
It doesn't need the refcount anyway, because the elo_priv structure is 
always deallocated synchronously before the elo_remove routine returns.

(Syzbot isn't always all that great at deducing where the real problem 
lies when something goes wrong.)

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ v5.17-rc3

Index: usb-devel/drivers/hid/hid-elo.c
===================================================================
--- usb-devel.orig/drivers/hid/hid-elo.c
+++ usb-devel/drivers/hid/hid-elo.c
@@ -239,7 +239,7 @@ static int elo_probe(struct hid_device *
 
 	INIT_DELAYED_WORK(&priv->work, elo_work);
 	udev = interface_to_usbdev(to_usb_interface(hdev->dev.parent));
-	priv->usbdev = usb_get_dev(udev);
+	priv->usbdev = udev;
 
 	hid_set_drvdata(hdev, priv);
 
@@ -270,8 +270,6 @@ static void elo_remove(struct hid_device
 {
 	struct elo_priv *priv = hid_get_drvdata(hdev);
 
-	usb_put_dev(priv->usbdev);
-
 	hid_hw_stop(hdev);
 	cancel_delayed_work_sync(&priv->work);
 	kfree(priv);
