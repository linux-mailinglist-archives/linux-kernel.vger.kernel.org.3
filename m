Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561D3479016
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbhLQPhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbhLQPhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:37:38 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE48C061574;
        Fri, 17 Dec 2021 07:37:38 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso3349799otr.2;
        Fri, 17 Dec 2021 07:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0RmXRl/tjOnvodSDvtzdKui0VUwLaJjDanmLe+EhNVU=;
        b=AjbX3eIjOwpzJQTZR9R0sz9jURzWLSKxV3w7Udr26CQTQ08Ex+d0DAdcsWOfGG34Re
         ci6LayQs7ZkEWKttwBzGBn7j0isFggw9E50LeyVCy/Z01O04eT69/L9YUqb4ox5k6dRB
         gIPGW/znpZMShFMuiS8fntlHBdsHbVYGtxeqLTtplO1plszq3YV/O9pMsDWkH8cOCbwX
         pLzdCdJSKRixoP7SeIVHeM+T7ort63PgME28m9WQg3NO4GCFxhnwMlokZl+YzQmPTanp
         tYQ90tvAle5HL/XSLX0PzpBKABS8PP6oZIptiOUqFJWLwxSrKTgEFn5Co7xpYYkaCpZ0
         5x7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=0RmXRl/tjOnvodSDvtzdKui0VUwLaJjDanmLe+EhNVU=;
        b=2OB3bbrHk2XEa89dMa0xgFHMpMrWsGCq63C/eAdkvAr9E9J2yEK8hywRzT+qV/fbLb
         u2LNBj6ZeJcMhxmp17iJ0kAC2LmCBHNJRuYCsQ2ezbECtB9048hu7LBjO8JjABoktWLC
         J2KUTbCkbQIOjn8IhzGCe0MMuZCbL2/OjjHoWv1l4AAP5+CB1m3P2bRXfvDfExt5TnJZ
         L9JD/7gR5XLI06f1XsJQFAsxwbgAvQY03tFDJEG0aU+Ebs6nlqhvphVAYmXl5gPC1Jc+
         suxiYNeAi5AhnT+lKXdnQrXUDR0CnDdk/91txEV2U5bi2C2jhih+kqI+rmr8QtAJYawT
         +bKA==
X-Gm-Message-State: AOAM5309Qb8SqCTIrPcku8/AsIxKiw+65YjgGvMfO91WAGQ7vUtsHywu
        PdIH7v0Rz3f7LCyEmXjiCGcvVyc+KDA=
X-Google-Smtp-Source: ABdhPJzfyLwZWo/YpXYWh7JF25pVzywS69t30dw07WMV7iXzH19gWbYx6IoITne25mZoavhJPNcwUA==
X-Received: by 2002:a05:6830:40c5:: with SMTP id h5mr2483334otu.261.1639755457647;
        Fri, 17 Dec 2021 07:37:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i29sm1682048ots.49.2021.12.17.07.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 07:37:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 17 Dec 2021 07:37:35 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hwmon: (dell-smm) Simplify ioctl handler
Message-ID: <20211217153735.GA2708734@roeck-us.net>
References: <20211211155422.16830-1-W_Armin@gmx.de>
 <20211211155422.16830-2-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211211155422.16830-2-W_Armin@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2021 at 04:54:21PM +0100, Armin Wolf wrote:
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
> Reviewed-by: Pali Rohár <pali@kernel.org>

Series applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 30 +++++++++---------------------
>  1 file changed, 9 insertions(+), 21 deletions(-)
> 
> --
> 2.30.2
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
