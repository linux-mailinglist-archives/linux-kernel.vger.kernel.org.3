Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9037E46E38C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbhLIH7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:59:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60862 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbhLIH7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:59:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C506B81FBA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 07:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A77C004DD;
        Thu,  9 Dec 2021 07:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639036571;
        bh=aIzYtbig5MH7sfOsB9APmmHfEK+RIkIFW4Q7dyAbeoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=caChZhhr6IrwFcGT968xcIicf9Jvjc/wCV2eamjM3+eadeQ2+ergc4SEdgTIpu78X
         yPQJlPXk4vf951ycKJ1doDd8juve0H7u+YAe/xTvaHQCnhz3d2PGhdzXvqyFznsxMx
         rBW39obBHTV14NSx2bU076U7eUOaBN3KkstxDa4I=
Date:   Thu, 9 Dec 2021 08:56:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: fix a memory leak in rtw_mp_pwrtrk()
Message-ID: <YbG2mDYHqjb5AYGG@kroah.com>
References: <20211209071905.125440-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209071905.125440-1-niejianglei2021@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 03:19:05PM +0800, Jianglei Nie wrote:
> Line 5961 (#1) allocates a memory chunk for input by kmalloc().
> Line 5966 (#2), line 5982 (#4) and line 5987 (#5) free the input
> before the function returns while line 5979 (#3) forget to free it,
> which will lead to a memory leak.
> 
> We should kfree() input in line 5979 (#3).
> 
> 5953 static int rtw_mp_pwrtrk(struct net_device *dev,
> 5954 			struct iw_request_info *info,
> 5955 			struct iw_point *wrqu, char *extra)
> 5956 {
> 5961 	char	*input = kmalloc(wrqu->length, GFP_KERNEL);
> 	// #1: kmalloc space
> 5963 	if (!input)
> 5964 		return -ENOMEM;
> 5965 	if (copy_from_user(input, wrqu->pointer, wrqu->length)) {
> 5966 		kfree(input); // #2: kfree space
> 5967 		return -EFAULT;
> 5968	}
> 
> 5973	if (strncmp(input, "stop", 4) == 0) {
> 5974		enable = 0;
> 5975		sprintf(extra, "mp tx power tracking stop");
> 5976	} else if (sscanf(input, "ther =%d", &thermal)) {
> 5977		ret = Hal_SetThermalMeter(padapter, (u8)thermal);
> 5978		if (ret == _FAIL)
> 5979			return -EPERM; // #3: missing kfree
> 5980		sprintf(extra, "mp tx power tracking start,
> 			target value =%d ok ", thermal);
> 5981	} else {
> 5982		kfree(input); // #4: kfree space
> 5983		return -EINVAL;
> 5984	}
> 
> 5987	kfree(input); // #5: kfree space
> 
> 5993	return 0;
> 5994 }
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 1fd375076001..8f9e0f12c51f 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -5975,8 +5975,10 @@ static int rtw_mp_pwrtrk(struct net_device *dev,
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

What kernel tree and version did you make this patch against?  I do not
even see this function in Linus's tree, nor in my staging-next
development branch.

confused,

greg k-h
