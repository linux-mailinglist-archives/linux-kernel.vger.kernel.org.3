Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDE1481FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241945AbhL3TqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:46:06 -0500
Received: from netrider.rowland.org ([192.131.102.5]:60859 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S241806AbhL3TqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:46:01 -0500
Received: (qmail 1117127 invoked by uid 1000); 30 Dec 2021 14:46:00 -0500
Date:   Thu, 30 Dec 2021 14:46:00 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, axboe@kernel.dk,
        jj251510319013@gmail.com, dan.carpenter@oracle.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] usb: gadget: clear related members when goto fail
Message-ID: <Yc4MeIt6JygZ6CrY@rowland.harvard.edu>
References: <20211230051132.21056-1-hbh25y@gmail.com>
 <20211230051132.21056-3-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230051132.21056-3-hbh25y@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 01:11:32PM +0800, Hangyu Hua wrote:
> dev->config and dev->hs_config and dev->dev need to be cleaned if
> dev_config fails to avoid UAF.
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

You must not do this.  I never sent you an Acked-by for this patch; you 
shouldn't claim that I did.

> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>  drivers/usb/gadget/legacy/inode.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
> index eaad03c0252f..d2e88f3b9131 100644
> --- a/drivers/usb/gadget/legacy/inode.c
> +++ b/drivers/usb/gadget/legacy/inode.c
> @@ -1847,7 +1847,7 @@ dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
>  		total = le16_to_cpu(dev->hs_config->wTotalLength);
>  		if (!is_valid_config(dev->hs_config, total) ||
>  				total > length - USB_DT_DEVICE_SIZE)
> -			goto fail;
> +			goto fail1;
>  		kbuf += total;
>  		length -= total;
>  	} else {
> @@ -1858,12 +1858,12 @@ dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
>  
>  	/* device descriptor (tweaked for paranoia) */
>  	if (length != USB_DT_DEVICE_SIZE)
> -		goto fail;
> +		goto fail1;
>  	dev->dev = (void *)kbuf;
>  	if (dev->dev->bLength != USB_DT_DEVICE_SIZE
>  			|| dev->dev->bDescriptorType != USB_DT_DEVICE
>  			|| dev->dev->bNumConfigurations != 1)
> -		goto fail;
> +		goto fail2;
>  	dev->dev->bcdUSB = cpu_to_le16 (0x0200);
>  
>  	/* triggers gadgetfs_bind(); then we can enumerate. */
> @@ -1875,6 +1875,9 @@ dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
>  
>  	value = usb_gadget_probe_driver(&gadgetfs_driver);
>  	if (value != 0) {
> +		dev->dev = NULL;
> +		dev->hs_config = NULL;
> +		dev->config = NULL;
>  		kfree (dev->buf);
>  		dev->buf = NULL;

Why not just grep the lock and goto fail?

>  	} else {
> @@ -1892,7 +1895,12 @@ dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
>  	}
>  	return value;
>  
> +fail2:
> +	dev->dev = NULL;
> +fail1:
> +	dev->hs_config = NULL;

It is not necessary to have all these different statement labels.  You 
can simply have "fail:" clear all three pointers.

>  fail:
> +	dev->config = NULL;
>  	spin_unlock_irq (&dev->lock);
>  	pr_debug ("%s: %s fail %zd, %p\n", shortname, __func__, value, dev);
>  	kfree (dev->buf);

Alan Stern
