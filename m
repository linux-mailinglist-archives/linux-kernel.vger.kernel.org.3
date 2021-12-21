Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D0A47BB3F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbhLUHmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:42:43 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:32846 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhLUHmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:42:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47D92B8102E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7C4C36AE2;
        Tue, 21 Dec 2021 07:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640072560;
        bh=LDrzRwiWMRLX8IYuABYzc4sjUMW7eKO2kgtMj3KTOaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oYu2l4i6sqxAg6a1F9M67YJ5whsDyuaBF0jHzKnU97G/fN9Ar/QTVFxx0kbXqoInf
         WRjTWleA7ljGD6bGKOMY1uLBh4bwkXxNTqOnzFJpcFBP4F7p0I2KVY77ffrSoEWNkR
         /jHa5USsWPo4gQKFq2LxWL/+IGp7umGH5JFtxm5A=
Date:   Tue, 21 Dec 2021 08:42:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v3] staging: r8188eu: Use strndup_user instead of
 kmalloc/copy_from_user
Message-ID: <YcGFbUXOAVoxjDB0@kroah.com>
References: <20211213092558.77624-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213092558.77624-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 05:25:58PM +0800, Jiapeng Chong wrote:
> This code assumes that the user is going to give us a NUL terminated
> string which is not necessarily true.
> 
> Fix following coccicheck warning:
> 
> ./drivers/staging/r8188eu/os_dep/ioctl_linux.c:4253:8-15: WARNING
> opportunity for memdup_user.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: 2b42bd58b321 ("staging: r8188eu: introduce new os_dep dir for RTL8188eu driver")
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
> Changes in v3:
>   -Delete useless printk, modified the commit message and fixes tag.
> 
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 77728ba78d76..d8c28f279aa0 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -4247,18 +4247,10 @@ static int rtw_test(
>  
>  	DBG_88E("+%s\n", __func__);
>  	len = wrqu->data.length;
> +	pbuf = strndup_user(wrqu->data.pointer, len);
> +	if (IS_ERR(pbuf))
> +		return PTR_ERR(pbuf);
>  
> -	pbuf = kzalloc(len, GFP_KERNEL);
> -	if (!pbuf) {
> -		DBG_88E("%s: no memory!\n", __func__);
> -		return -ENOMEM;
> -	}
> -
> -	if (copy_from_user(pbuf, wrqu->data.pointer, len)) {
> -		kfree(pbuf);
> -		DBG_88E("%s: copy from user fail!\n", __func__);
> -		return -EFAULT;
> -	}
>  	DBG_88E("%s: string =\"%s\"\n", __func__, pbuf);
>  
>  	ptmp = (char *)pbuf;
> -- 
> 2.20.1.7.g153144c
> 
> 

This function does nothing, so it should just be deleted entirely.
Please let's not have odd custom ioctls hanging around that can do
nothing but cause problems.

Also, this function looks like a lovely way to crash a kernel, even with
your fix, so the sooner we get it removed the better.

thanks,

greg k-h
