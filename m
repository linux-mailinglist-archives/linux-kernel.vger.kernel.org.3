Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34924C1143
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239855AbiBWL3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbiBWL3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:29:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D658BE27
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:29:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44D87B81E90
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E52EC340EC;
        Wed, 23 Feb 2022 11:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645615747;
        bh=3+TKJBP+0/cfGbXLRImmLTQIX5KdSRN6vrHnNX0/RWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R014DC4zaXCUwyOec8ES6tMl+M2P6jhGBMQDXgSW/KulpO1ooFjM3CY/2HG49zHhT
         8ZXJoM3x3zUvaubWCv5f8+XtmlvPnvllMtPDCDU6f/er6V5Gdfn57vWePtJjj+K/Po
         hshVAi8r4s0RlHboqdwFFonglLQonyAJD3HBo5Xw=
Date:   Wed, 23 Feb 2022 12:29:03 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     syzbot <syzbot+348b571beb5eeb70a582@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
Subject: Re: [syzbot] KASAN: use-after-free Read in dev_uevent
Message-ID: <YhYafwiwUV2Sbn5t@kroah.com>
References: <0000000000005a991a05a86970bb@google.com>
 <00000000000033314805d8765175@google.com>
 <PH0PR11MB58805E3C4CF7D4C41D49BFCFDA3C9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB58805E3C4CF7D4C41D49BFCFDA3C9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 11:17:07AM +0000, Zhang, Qiang1 wrote:
> 
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    4f12b742eb2b Merge tag 'nfs-for-5.17-3' of git://git.linux..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=110a6df2700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f6a069ed94a1ed1d
> dashboard link: https://syzkaller.appspot.com/bug?extid=348b571beb5eeb70a582
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12377296700000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+348b571beb5eeb70a582@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in dev_uevent+0x712/0x780 drivers/base/core.c:2320 Read of size 8 at addr ffff88802b934098 by task udevd/3689
> 
> CPU: 2 PID: 3689 Comm: udevd Not tainted 5.17.0-rc4-syzkaller-00229-g4f12b742eb2b #0 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014 Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  print_address_description.constprop.0.cold+0x8d/0x303 mm/kasan/report.c:255  __kasan_report mm/kasan/report.c:442 [inline]  kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
>  dev_uevent+0x712/0x780 drivers/base/core.c:2320
>  uevent_show+0x1b8/0x380 drivers/base/core.c:2391
>  dev_attr_show+0x4b/0x90 drivers/base/core.c:2094
>  sysfs_kf_seq_show+0x219/0x3d0 fs/sysfs/file.c:59
>  seq_read_iter+0x4f5/0x1280 fs/seq_file.c:230
>  kernfs_fop_read_iter+0x514/0x6f0 fs/kernfs/file.c:241  call_read_iter include/linux/fs.h:2068 [inline]
>  new_sync_read+0x429/0x6e0 fs/read_write.c:400
>  vfs_read+0x35c/0x600 fs/read_write.c:481
>  ksys_read+0x12d/0x250 fs/read_write.c:619
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f964cc558fe
> Code: c0 e9 e6 fe ff ff 50 48 8d 3d 0e c7 09 00 e8 c9 cf 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
> RSP: 002b:00007ffc0133d258 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 000056497b21a140 RCX: 00007f964cc558fe
> RDX: 0000000000001000 RSI: 000056497b218650 RDI: 0000000000000008
> RBP: 00007f964cd22380 R08: 0000000000000008 R09: 00007f964cd25a60
> R10: 0000000000000008 R11: 0000000000000246 R12: 000056497b21a140
> R13: 0000000000000d68 R14: 00007f964cd21780 R15: 0000000000000d68  </TASK>
> 
> Cc: Alan Stern 
>        Felipe Balbi
> 
> Hello syzbot, Please try it:
> 
> From 574d45ff924e2d2f9b9f5cc3e846f8004498a811 Mon Sep 17 00:00:00 2001
> From: Zqiang <qiang1.zhang@intel.com>
> Date: Wed, 23 Feb 2022 18:18:22 +0800
> Subject: [PATCH] driver core: Fix use-after-free in dev_uevent()
> 
> In dev_uevent(), if the "dev->driver" is valid, the "dev->driver->name"
> be accessed, there may be a window period between these two operations.

There should not be any such window period.  The bus locks should
prevent this, unless some driver is doing odd things with the pointers
that it should not be doing.

> in this window period if the "dev->driver" is set to null
> (in usb_gadget_unregister_driver function), when the "dev->driver->name"
> is accessed again, invalid address will be accessed. fix it by checking
> "dev->driver" again.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  drivers/base/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 3d6430eb0c6a..a45b927ee76e 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2317,7 +2317,7 @@ static int dev_uevent(struct kobject *kobj, struct kobj_uevent_env *env)
>                 add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
> 
>         if (dev->driver)
> -               add_uevent_var(env, "DRIVER=%s", dev->driver->name);
> +               add_uevent_var(env, "DRIVER=%s", dev_driver_string(dev));

What's to prevent the "window" from happening in the middle of the
dev_driver_string() call?

thanks,

greg k-h
