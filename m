Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAD347149C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 17:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhLKQEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 11:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhLKQEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 11:04:44 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306C2C061714;
        Sat, 11 Dec 2021 08:04:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E6B6ACE09E3;
        Sat, 11 Dec 2021 16:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7F5C004DD;
        Sat, 11 Dec 2021 16:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639238680;
        bh=RTq1eV4XNyETDPGbIyXnB/BvMFXGQgCiwC2Kvc8dD+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=clEt3fQxyBokpGnV14D8zvFMkWF+3Jdat+rcWybgHS2aELGVzlmSw+L1Xp1WQY595
         4RN2GFzslFghFvgO7BP8ce33fyzn2gLvm6wFvWZg+702sD9yZUPHDux/pqI7D1fw+7
         wYTkBxsMOXrPrMcyMKnh05xjSD2/AEee6D18JnfpyQrAXQl45DTi3sm+ddm4NDQAd4
         YYaxOeMXFdFge9EhO7qjmB2j8e9pEecLva/726kFVEDcy9rMGxlA/yIMCjr4hG42kA
         D8wibPskWTNwc2sQJZwdhguIBfNw7l3Sf0NhQw4QErdZ3o/AtnK4gPJNo9jkaJobeV
         mO1fznq1tNpYw==
Received: by pali.im (Postfix)
        id 6DB97735; Sat, 11 Dec 2021 17:04:37 +0100 (CET)
Date:   Sat, 11 Dec 2021 17:04:37 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hwmon: (dell-smm) Simplify ioctl handler
Message-ID: <20211211160437.twf4awowdrzkj6ey@pali>
References: <20211211155422.16830-1-W_Armin@gmx.de>
 <20211211155422.16830-2-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211211155422.16830-2-W_Armin@gmx.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 December 2021 16:54:21 Armin Wolf wrote:
> The second switch-case has no real purpose:
> 
> - for I8K_BIOS_VERSION, val does not represent a return value,
>   making the check for error values unnecessary.
> - for I8K_MACHINE_ID, val remains zero, so the error check is
>   unnecessary too.
> 
> Remove the switch-case and move the calls to copy_to_user()
> into the first switch-case for I8K_BIOS_VERSION/_MACHINE_ID.
> Omit buff[] since data->bios_machineid already contains the string
> with the necessary zero padding through devm_kzalloc().
> 
> Tested on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Reviewed-by: Pali Rohár <pali@kernel.org>

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 30 +++++++++---------------------
>  1 file changed, 9 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 5596c211f38d..186d40938036 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -454,7 +454,6 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_smm_data *data, unsigned int cmd
>  {
>  	int val = 0;
>  	int speed, err;
> -	unsigned char buff[16];
>  	int __user *argp = (int __user *)arg;
> 
>  	if (!argp)
> @@ -468,15 +467,19 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_smm_data *data, unsigned int cmd
> 
>  		val = (data->bios_version[0] << 16) |
>  				(data->bios_version[1] << 8) | data->bios_version[2];
> -		break;
> 
> +		if (copy_to_user(argp, &val, sizeof(val)))
> +			return -EFAULT;
> +
> +		return 0;
>  	case I8K_MACHINE_ID:
>  		if (restricted && !capable(CAP_SYS_ADMIN))
>  			return -EPERM;
> 
> -		strscpy_pad(buff, data->bios_machineid, sizeof(buff));
> -		break;
> +		if (copy_to_user(argp, data->bios_machineid, sizeof(data->bios_machineid)))
> +			return -EFAULT;
> 
> +		return 0;
>  	case I8K_FN_STATUS:
>  		val = i8k_get_fn_status();
>  		break;
> @@ -527,23 +530,8 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_smm_data *data, unsigned int cmd
>  	if (val < 0)
>  		return val;
> 
> -	switch (cmd) {
> -	case I8K_BIOS_VERSION:
> -		if (copy_to_user(argp, &val, 4))
> -			return -EFAULT;
> -
> -		break;
> -	case I8K_MACHINE_ID:
> -		if (copy_to_user(argp, buff, 16))
> -			return -EFAULT;
> -
> -		break;
> -	default:
> -		if (copy_to_user(argp, &val, sizeof(int)))
> -			return -EFAULT;
> -
> -		break;
> -	}
> +	if (copy_to_user(argp, &val, sizeof(int)))
> +		return -EFAULT;
> 
>  	return 0;
>  }
> --
> 2.30.2
> 
