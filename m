Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2E451E7CC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 16:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376812AbiEGObH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 10:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbiEGObF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 10:31:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97722DFC;
        Sat,  7 May 2022 07:27:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79108608C3;
        Sat,  7 May 2022 14:27:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6414AC385A5;
        Sat,  7 May 2022 14:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651933637;
        bh=8jXCjBGJJPxlr9V8Zv0vyc5vMNnF06uj4+zEg0fhpsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A3vs/lC4UGjixwmTZ9Oc+ZggDjdz1Rio+dfRcyFx7B9JZjuC7EHZZPCA20XyTJCu9
         YCpuNVkfTX/txbkqNDZISV9INKPVYCJjLXJTUnJP1Va2ekU3OnXEAjfu91Z5UwOT+K
         it/aFKi6szvE0V0mqKFCApv/KF/ECV+RzSz2dQsc=
Date:   Sat, 7 May 2022 16:27:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     andreyknvl@gmail.com, balbi@kernel.org, jj251510319013@gmail.com,
        stern@rowland.harvard.edu, jannh@google.com, Julia.Lawall@inria.fr,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+dc7c3ca638e773db07f6@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: gadget: fix race when gadget driver register via
 ioctl
Message-ID: <YnaBwkhIxZ1wtIQX@kroah.com>
References: <20220507120851.29948-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507120851.29948-1-schspa@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 08:08:51PM +0800, Schspa Shi wrote:
> The usb_gadget_register_driver doesn't have inside locks to protect the
> driver, and If there is two threads are registered at the same time via
> the ioctl syscall, the system will crash as syzbot reported.
> 
> Call trace as:
>   driver_register+0x220/0x3a0 drivers/base/driver.c:171
>   usb_gadget_register_driver_owner+0xfb/0x1e0
>     drivers/usb/gadget/udc/core.c:1546
>   raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:513 [inline]
>   raw_ioctl+0x1883/0x2730 drivers/usb/gadget/legacy/raw_gadget.c:1220
> 
> This routine allows two processes to register the same driver instance
> via ioctl syscall. which lead to a race condition.
> 
> We can fix it by adding a driver_lock to avoid double register.
> 
> Reported-by: syzbot+dc7c3ca638e773db07f6@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/000000000000e66c2805de55b15a@google.com/
> 
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> ---
>  drivers/usb/gadget/legacy/raw_gadget.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
> index b3be8db1ff63..d7ff9c2b5397 100644
> --- a/drivers/usb/gadget/legacy/raw_gadget.c
> +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> @@ -155,7 +155,9 @@ struct raw_dev {
>  	spinlock_t			lock;
>  
>  	const char			*udc_name;
> +	/* Protected by driver_lock for reentrant registration */
>  	struct usb_gadget_driver	driver;
> +	struct mutex			driver_lock;

Why are you adding another lock here?  What's wrong with the existing
lock in this structure that requires an additional one?

>  
>  	/* Reference to misc device: */
>  	struct device			*dev;
> @@ -188,6 +190,8 @@ static struct raw_dev *dev_new(void)
>  	spin_lock_init(&dev->lock);
>  	init_completion(&dev->ep0_done);
>  	raw_event_queue_init(&dev->queue);
> +	mutex_init(&dev->driver_lock);
> +
>  	return dev;
>  }
>  
> @@ -398,7 +402,9 @@ static int raw_release(struct inode *inode, struct file *fd)
>  	spin_unlock_irqrestore(&dev->lock, flags);
>  
>  	if (unregister) {
> +		mutex_lock(&dev->driver_lock);
>  		ret = usb_gadget_unregister_driver(&dev->driver);
> +		mutex_unlock(&dev->driver_lock);
>  		if (ret != 0)
>  			dev_err(dev->dev,
>  				"usb_gadget_unregister_driver() failed with %d\n",
> @@ -510,7 +516,9 @@ static int raw_ioctl_run(struct raw_dev *dev, unsigned long value)
>  	}
>  	spin_unlock_irqrestore(&dev->lock, flags);
>  
> +	mutex_lock(&dev->driver_lock);
>  	ret = usb_gadget_register_driver(&dev->driver);
> +	mutex_unlock(&dev->driver_lock);

How can unregister race with register?

What ioctl is causing this race?  What userspace program is doing this?
Only one userspace program should be accessing this at once, right?

confused,

greg k-h
