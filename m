Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B9046EAAC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239229AbhLIPMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:12:10 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:59664 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbhLIPMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:12:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5929ECE2643
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 15:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E8DC004DD;
        Thu,  9 Dec 2021 15:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639062511;
        bh=WTHAP2zC5FCHpsSxty3S5cxTlkk8IRYS8wYdTydioQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s2goKKOHpEUbIIl6pk/9VwLEJexCnLiC0SUuLLaXuCZygxCcOr2oxohSk8vbBJJNO
         NI4AMmIuOlsye5m3sa1ZkjobxDc789PPCVhFrNiTFtLzIqORzM2LzmYNlDLBAp+qXZ
         rP2bRsEVPl5uTuNBX5RTeiMqkftAIvxyo+GGOWEU=
Date:   Thu, 9 Dec 2021 16:08:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: fix a memory leak in rtw_mp_pwrtrk()
Message-ID: <YbIb65kjhl6FSfBv@kroah.com>
References: <20211209132516.8387-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209132516.8387-1-niejianglei2021@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 09:25:15PM +0800, Jianglei Nie wrote:
> Line 5968 (#1) allocates a memory chunk for input by kmalloc().
> Line 5973 (#2), line 5989 (#4) and line 5994 (#5) free the input
> before the function returns while line 5986 (#3) forget to free it,
> which will lead to a memory leak. This bug influences all stable
> versions from 5.15.1 to 5.15.7.
> 
> We should kfree() input in line 5986 (#3).
> 
> 5960 static int rtw_mp_pwrtrk(struct net_device *dev,
> 5961 			struct iw_request_info *info,
> 5962 			struct iw_point *wrqu, char *extra)
> 5963 {
> 5968 	char	*input = kmalloc(wrqu->length, GFP_KERNEL);
> 	// #1: kmalloc space
> 5970 	if (!input)
> 5971 		return -ENOMEM;
> 5972 	if (copy_from_user(input, wrqu->pointer, wrqu->length)) {
> 5973 		kfree(input); // #2: kfree space
> 5974 		return -EFAULT;
> 5975	}
> 
> 5980	if (strncmp(input, "stop", 4) == 0) {
> 5981		enable = 0;
> 5982		sprintf(extra, "mp tx power tracking stop");
> 5983	} else if (sscanf(input, "ther =%d", &thermal)) {
> 5984		ret = Hal_SetThermalMeter(padapter, (u8)thermal);
> 5985		if (ret == _FAIL)
> 5986			return -EPERM; // #3: missing kfree
> 5987		sprintf(extra, "mp tx power tracking start,
> 			target value =%d ok ", thermal);
> 5988	} else {
> 5989		kfree(input); // #4: kfree space
> 5990		return -EINVAL;
> 5991	}
> 
> 5994	kfree(input); // #5: kfree space
> 
> 6000	return 0;
> 6001 }
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 0eccce57c63a..906a57eae1af 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -5982,8 +5982,10 @@ static int rtw_mp_pwrtrk(struct net_device *dev,
>  			sprintf(extra, "mp tx power tracking stop");
>  		} else if (sscanf(input, "ther =%d", &thermal)) {
>  				ret = Hal_SetThermalMeter(padapter, (u8)thermal);
> -				if (ret == _FAIL)
> +				if (ret == _FAIL) {
> +					kfree(input);
>  					return -EPERM;
> +				}
>  				sprintf(extra, "mp tx power tracking start, target value =%d ok ", thermal);
>  		} else {
>  			kfree(input);
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
