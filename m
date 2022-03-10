Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB584D4D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbiCJPaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 10:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbiCJPaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:30:05 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 5B4B0158DA9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 07:29:03 -0800 (PST)
Received: (qmail 1545480 invoked by uid 1000); 10 Mar 2022 10:29:02 -0500
Date:   Thu, 10 Mar 2022 10:29:02 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     syzbot <syzbot+f0fae482604e6d9a87c9@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, pavel.hofman@ivitera.com,
        rob@robgreener.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] memory leak in usb_get_configuration
Message-ID: <YioZPi6Q9k2Luznl@rowland.harvard.edu>
References: <000000000000351b8605d9d1d1bf@google.com>
 <b7bd6b82-03e3-eac8-21f5-1b05c97c98a3@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7bd6b82-03e3-eac8-21f5-1b05c97c98a3@suse.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 10:51:42AM +0100, Oliver Neukum wrote:
> 
> On 10.03.22 00:54, syzbot wrote:
> 
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    0014404f9c18 Merge branch 'akpm' (patches from Andrew)
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15864216700000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3f0a704147ec8e32
> > dashboard link: https://syzkaller.appspot.com/bug?extid=f0fae482604e6d9a87c9
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a63dbe700000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e150a1700000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+f0fae482604e6d9a87c9@syzkaller.appspotmail.com
> >
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 0014404f9c18
> 
>  

> From 785609ab0d95c753dc31267b3c4da585c16e0274 Mon Sep 17 00:00:00 2001
> From: Oliver Neukum <oneukum@suse.com>
> Date: Thu, 10 Mar 2022 10:40:36 +0100
> Subject: [PATCH] USB: hub: fix memory leak on failure of usb_get_config
> 
> kfree()s on the error path need to be added.

No, they don't.  The config and rawdescriptors buffers get freed later 
on in usb_destroy_configuration().

This problem is something else.  Probably whatever driver is calling 
gspca_probe() (see the console log) is taking a reference to the 
usb_device or usb_interface and then failing to release that reference 
on its error path.

Alan Stern

> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
>  drivers/usb/core/config.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
> index 48bc8a4814ac..548ce5ca6847 100644
> --- a/drivers/usb/core/config.c
> +++ b/drivers/usb/core/config.c
> @@ -885,12 +885,16 @@ int usb_get_configuration(struct usb_device *dev)
>  
>  	length = ncfg * sizeof(char *);
>  	dev->rawdescriptors = kzalloc(length, GFP_KERNEL);
> -	if (!dev->rawdescriptors)
> -		return -ENOMEM;
> +	if (!dev->rawdescriptors) {
> +		result = -ENOMEM;
> +		goto err2;
> +	}
>  
>  	desc = kmalloc(USB_DT_CONFIG_SIZE, GFP_KERNEL);
> -	if (!desc)
> -		return -ENOMEM;
> +	if (!desc) {
> +		result = -ENOMEM;
> +		goto err2;
> +	}
>  
>  	for (cfgno = 0; cfgno < ncfg; cfgno++) {
>  		/* We grab just the first descriptor so we know how long
> @@ -952,6 +956,11 @@ int usb_get_configuration(struct usb_device *dev)
>  err:
>  	kfree(desc);
>  	dev->descriptor.bNumConfigurations = cfgno;
> +err2:
> +	kfree(dev->rawdescriptors);
> +	kfree(dev->config);
> +	dev->rawdescriptors = NULL;
> +	dev->config = NULL;
>  
>  	return result;
>  }
> -- 
> 2.34.1
> 

