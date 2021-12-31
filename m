Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B7248256F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 18:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhLaRfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 12:35:05 -0500
Received: from netrider.rowland.org ([192.131.102.5]:59783 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231526AbhLaRfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 12:35:04 -0500
Received: (qmail 1135134 invoked by uid 1000); 31 Dec 2021 12:35:03 -0500
Date:   Fri, 31 Dec 2021 12:35:03 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, axboe@kernel.dk,
        dan.carpenter@oracle.com, jj251510319013@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] usb: gadget: clear related members when goto fail
Message-ID: <Yc8/R4J0qYgXzkYn@rowland.harvard.edu>
References: <20211231172138.7993-1-hbh25y@gmail.com>
 <20211231172138.7993-3-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211231172138.7993-3-hbh25y@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 01, 2022 at 01:21:38AM +0800, Hangyu Hua wrote:
> dev->config and dev->hs_config and dev->dev need to be cleaned if
> dev_config fails to avoid UAF.
> 
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/gadget/legacy/inode.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
> index eaad03c0252f..25c8809e0a38 100644
> --- a/drivers/usb/gadget/legacy/inode.c
> +++ b/drivers/usb/gadget/legacy/inode.c
> @@ -1875,8 +1875,8 @@ dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
>  
>  	value = usb_gadget_probe_driver(&gadgetfs_driver);
>  	if (value != 0) {
> -		kfree (dev->buf);
> -		dev->buf = NULL;
> +		spin_lock_irq(&dev->lock);
> +		goto fail;
>  	} else {
>  		/* at this point "good" hardware has for the first time
>  		 * let the USB the host see us.  alternatively, if users
> @@ -1893,6 +1893,9 @@ dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
>  	return value;
>  
>  fail:
> +	dev->config = NULL;
> +	dev->hs_config = NULL;
> +	dev->dev = NULL;
>  	spin_unlock_irq (&dev->lock);
>  	pr_debug ("%s: %s fail %zd, %p\n", shortname, __func__, value, dev);
>  	kfree (dev->buf);
> -- 
> 2.25.1
> 
