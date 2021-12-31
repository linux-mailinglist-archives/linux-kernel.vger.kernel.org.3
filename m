Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB5C48256D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 18:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhLaRes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 12:34:48 -0500
Received: from netrider.rowland.org ([192.131.102.5]:48565 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229690AbhLaRer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 12:34:47 -0500
Received: (qmail 1135115 invoked by uid 1000); 31 Dec 2021 12:34:46 -0500
Date:   Fri, 31 Dec 2021 12:34:46 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, axboe@kernel.dk,
        dan.carpenter@oracle.com, jj251510319013@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] usb: gadget: don't release an existing dev->buf
Message-ID: <Yc8/Nsr9pPAqgtK/@rowland.harvard.edu>
References: <20211231172138.7993-1-hbh25y@gmail.com>
 <20211231172138.7993-2-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211231172138.7993-2-hbh25y@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 01, 2022 at 01:21:37AM +0800, Hangyu Hua wrote:
> dev->buf does not need to be released if it already exists before
> executing dev_config.
> 
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/gadget/legacy/inode.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
> index 3b58f4fc0a80..eaad03c0252f 100644
> --- a/drivers/usb/gadget/legacy/inode.c
> +++ b/drivers/usb/gadget/legacy/inode.c
> @@ -1826,8 +1826,9 @@ dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
>  	spin_lock_irq (&dev->lock);
>  	value = -EINVAL;
>  	if (dev->buf) {
> +		spin_unlock_irq(&dev->lock);
>  		kfree(kbuf);
> -		goto fail;
> +		return value;
>  	}
>  	dev->buf = kbuf;
>  
> -- 
> 2.25.1
> 
