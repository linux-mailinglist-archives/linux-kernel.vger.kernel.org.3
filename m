Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C65536762
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 21:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353384AbiE0TON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 15:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbiE0TOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 15:14:11 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0FECCB82D4
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 12:14:07 -0700 (PDT)
Received: (qmail 108885 invoked by uid 1000); 27 May 2022 15:14:06 -0400
Date:   Fri, 27 May 2022 15:14:06 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+02b16343704b3af1667e@syzkaller.appspotmail.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in driver_unregister
Message-ID: <YpEi/sbT/R/0yKzo@rowland.harvard.edu>
References: <0000000000008c664105dffae2eb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000008c664105dffae2eb@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 02:25:19AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    97fa5887cf28 USB: new quirk for Dell Gen 2 devices
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=170ebdc3f00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d7b232ec3adf5c8d
> dashboard link: https://syzkaller.appspot.com/bug?extid=02b16343704b3af1667e
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1124ad81f00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d6004df00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+02b16343704b3af1667e@syzkaller.appspotmail.com

There are at least two bugs here.  The first is the failure to select a 
unique driver name; the raw gadget always uses the name "raw-gadget".  As 
a result, registrations after the first one fail:

> kobject_add_internal failed for raw-gadget with -EEXIST, don't try to register things with the same name in the same directory.
> UDC core: USB Raw Gadget: driver registration failed: -17
> misc raw-gadget: fail, usb_gadget_register_driver returned -17

The most logical solution seems to be to use the driver name provided by 
the user.  That's what the patch below does.  However, this has the 
drawback that if the user provides a bad name then the registration 
attempt will cause a kernel error, because the kernel expects driver names 
to be controlled by drivers, not by users.  Maybe we should use an 
ida-generated suffix: "raw-gadget.N".

The second bug is the unexpected unregistration.  The raw-gadget driver is 
careful to keep track of whether registration succeeded, and it doesn't 
try to unregister itself if registration failed.  Nevertheless, that 
happened here:

> ------------[ cut here ]------------
> Unexpected driver unregister!
> WARNING: CPU: 0 PID: 1308 at drivers/base/driver.c:194 driver_unregister drivers/base/driver.c:194 [inline]
> WARNING: CPU: 0 PID: 1308 at drivers/base/driver.c:194 driver_unregister+0x8c/0xb0 drivers/base/driver.c:191
> Modules linked in:
> CPU: 0 PID: 1308 Comm: syz-executor314 Not tainted 5.18.0-rc5-syzkaller-00157-g97fa5887cf28 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:driver_unregister drivers/base/driver.c:194 [inline]
> RIP: 0010:driver_unregister+0x8c/0xb0 drivers/base/driver.c:191
> Code: 68 4c 89 e7 e8 65 b9 db fe 48 89 ef e8 fd a0 ff ff 5d 41 5c e9 75 fa 78 fe e8 70 fa 78 fe 48 c7 c7 80 7a 81 86 e8 12 96 ee 02 <0f> 0b 5d 41 5c e9 5a fa 78 fe e8 75 93 ad fe eb 96 e8 6e 93 ad fe
> RSP: 0018:ffffc90001087a78 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffff88811d184050 RCX: 0000000000000000
> RDX: ffff88810902d580 RSI: ffffffff812bdce8 RDI: fffff52000210f41
> RBP: ffff88811d184098 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffff812b86be R11: 0000000000000000 R12: 0000000000000000
> R13: ffff88811d184008 R14: ffff88811d05b1a8 R15: ffff8881008456a0
> FS:  0000000000000000(0000) GS:ffff8881f6800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fea994ab2d0 CR3: 0000000007825000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  usb_gadget_unregister_driver+0x48/0x70 drivers/usb/gadget/udc/core.c:1590
>  raw_release+0x18a/0x290 drivers/usb/gadget/legacy/raw_gadget.c:401
>  __fput+0x277/0x9d0 fs/file_table.c:317
>  task_work_run+0xdd/0x1a0 kernel/task_work.c:164

I have no idea how this could have happened; it looks impossible.  Maybe 
it has something to do with the fact that registration failed for two 
separate threads (see the syzbot console log).  I can't tell what's going 
on.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git 97fa5887cf28

Index: usb-devel/drivers/usb/gadget/legacy/raw_gadget.c
===================================================================
--- usb-devel.orig/drivers/usb/gadget/legacy/raw_gadget.c
+++ usb-devel/drivers/usb/gadget/legacy/raw_gadget.c
@@ -483,7 +483,7 @@ static int raw_ioctl_init(struct raw_dev
 	dev->driver.suspend = gadget_suspend;
 	dev->driver.resume = gadget_resume;
 	dev->driver.reset = gadget_reset;
-	dev->driver.driver.name = DRIVER_NAME;
+	dev->driver.driver.name = udc_driver_name;
 	dev->driver.udc_name = udc_device_name;
 	dev->driver.match_existing_only = 1;
 
