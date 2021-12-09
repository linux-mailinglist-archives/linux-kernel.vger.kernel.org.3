Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9556546EAAD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239236AbhLIPMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239231AbhLIPMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:12:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B201AC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 07:08:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CB546CE2643
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 15:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF44C004DD;
        Thu,  9 Dec 2021 15:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639062525;
        bh=+DZzUPb0MXEP6/SL2iCITxve4BK9yABbHTlC4f2A+B0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PsjywAGu6jkA3Vlhq9H7wLcR5prEbnCEL8gAjBorFhqHIy913sb3yY12DSKxM+oTn
         l8kdpO83Lu1zFKwTBhmepsakWYwAxJ9iE2iC8VmumadOV8tEwFdscEOutneHtrcn+I
         yDaekilxYR1dwrGvtt6Eq/rV5zNSPuwyj7DIdLh4=
Date:   Thu, 9 Dec 2021 16:08:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: fix a memory leak in rtw_mp_QueryDrv()
Message-ID: <YbIb+jbuU9OSvjyN@kroah.com>
References: <20211209132516.8387-1-niejianglei2021@163.com>
 <20211209132516.8387-2-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209132516.8387-2-niejianglei2021@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 09:25:16PM +0800, Jianglei Nie wrote:
> Line 6191 (#1) allocates a memory chunk for input by kmalloc().
> Line 6213 (#3) frees the input before the function returns while
> line 6199 (#2) forget to free it, which will lead to a memory leak.
> This bug influences all stable versions from 5.15.1 to 5.15.7.
> 
> We should kfree() input in line 6199 (#2).
> 
> 6186 static int rtw_mp_QueryDrv(struct net_device *dev,
> 6187 			struct iw_request_info *info,
> 6188 			union iwreq_data *wrqu, char *extra)
> 6189 {
> 6191	char	*input = kmalloc(wrqu->data.length, GFP_KERNEL);
> 	// #1: kmalloc space
> 
> 6195	if (!input)
> 6196		return -ENOMEM;
> 
> 6198 	if (copy_from_user(input, wrqu->data.pointer, wrqu->data.length))
> 6199 			return -EFAULT; // #2: missing kfree
> 
> 6213 	kfree(input); // #3: kfree space
> 6214 	return 0;
> 6215 }
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 906a57eae1af..edc660f15436 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -6195,8 +6195,11 @@ static int rtw_mp_QueryDrv(struct net_device *dev,
>  	if (!input)
>  		return -ENOMEM;
>  
> -	if (copy_from_user(input, wrqu->data.pointer, wrqu->data.length))
> -			return -EFAULT;
> +	if (copy_from_user(input, wrqu->data.pointer, wrqu->data.length)) {
> +		kfree(input);
> +		return -EFAULT;
> +	}
> +
>  	DBG_88E("%s:iwpriv in =%s\n", __func__, input);
>  
>  	qAutoLoad = strncmp(input, "autoload", 8); /*  strncmp true is 0 */
> -- 
> 2.25.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
