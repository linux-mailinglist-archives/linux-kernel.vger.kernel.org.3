Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF78D4636FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242327AbhK3OrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242122AbhK3OrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:47:08 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83089C061574;
        Tue, 30 Nov 2021 06:43:49 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id r26so41625140oiw.5;
        Tue, 30 Nov 2021 06:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4spJjbJYTAC6+zy0UeFEEraBFzgvSm66xfAu2ijpsCw=;
        b=MEPay1Ifp8d2iN8EubUx+VietO1oip4iyeBoaWh3++Tn70MWoq2mJIP6CzyYp3n/7a
         dFaZvlm9MMUsie/0ZXNOWnmr/23dilUZMPPDYwTcmHz2T8nYnzJqIOf3ESyz17aPlv35
         JN1P5p7pMa/+UbWJmi1eM1gbvxRsPeOJ6jc3t6lrs9MWRpNbPtluT6J4c55pfQ/qebSN
         vPiZnevFcwIAfk2wV5iDOzibkbmll8RfEe7tym4fJNsPFfxcrLg+OcjQiUwCS8RrH0Yk
         D2KFa9qcdvvSOWir4eih58ywsLbvhR0HenM3fblSrgwaM1M61M9PFbuN+WYFGoioOCgT
         r+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=4spJjbJYTAC6+zy0UeFEEraBFzgvSm66xfAu2ijpsCw=;
        b=xJfyZjTBmuDhGy22zgCx/+lx0TLYN0Yd7/AFmyNWTbUFw850fnczNCHsWa4hMSHWpt
         wue21QoVuF58xE1esN/Zxl/oUe5+WDAmc/FmzLjiUlz5IB1dxYzOJ1iFXBm6q5tKO4cC
         ep922Q7n43INiSMh3h8kQ06cWuD5dslNtgA5S3xes2INIqLSMG5Jqtv0yfWR78zLxriT
         Ch1r7AjUANSRRXlpgsJLjtoXMCDceGqayr/rOVhYOF+iXn15NkNgAWol3wW54ifqWzNU
         ucbr6nYrHnGp8wqMNQ51Ac1XiC0mcjKI/G7gQa+vDiuECCvhIkPisYBxpyYxrGuunhx0
         EF/g==
X-Gm-Message-State: AOAM532L9ZRjqjZ0kMV/iBesKIcZP3tmkTD1or9qHj8/BqQ/sFKZm7yW
        rthvLpnvr1zO8tPKBf1irxc=
X-Google-Smtp-Source: ABdhPJw2WaUsHFV91w9r9h/nuAmAIUGV8vLtR9mBME9mJhGsL2Q0vvotMJf/vg0b+Yjvbl24v5ZwLg==
X-Received: by 2002:a05:6808:2014:: with SMTP id q20mr4621736oiw.9.1638283428859;
        Tue, 30 Nov 2021 06:43:48 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u6sm3863911oiu.34.2021.11.30.06.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 06:43:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 30 Nov 2021 06:43:47 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ed Brindley <kernel@maidavale.org>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (asus_wmi_sensors) fix an array overflow
Message-ID: <20211130144347.GA279534@roeck-us.net>
References: <20211130105034.GG5827@kili>
 <20211130105117.GH5827@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130105117.GH5827@kili>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 01:51:17PM +0300, Dan Carpenter wrote:
> Smatch detects this array overflow:
> 
>     drivers/hwmon/asus_wmi_sensors.c:569 asus_wmi_configure_sensor_setup()
>     error: buffer overflow 'hwmon_attributes' 8 <= 9
> 
> The hwmon_attributes[] array should have "hwmon_max" so that it gets
> larger when more attributes are added.
> 
> Fixes: 9d07e54a25b8 ("hwmon: (asus_wmi_sensors) Support X370 Asus WMI.")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/asus_wmi_sensors.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/asus_wmi_sensors.c b/drivers/hwmon/asus_wmi_sensors.c
> index 67af15d99396..c80eee874b6c 100644
> --- a/drivers/hwmon/asus_wmi_sensors.c
> +++ b/drivers/hwmon/asus_wmi_sensors.c
> @@ -125,7 +125,7 @@ static enum hwmon_sensor_types asus_data_types[] = {
>  	[WATER_FLOW]	= hwmon_fan,
>  };
>  
> -static u32 hwmon_attributes[] = {
> +static u32 hwmon_attributes[hwmon_max] = {
>  	[hwmon_chip]	= HWMON_C_REGISTER_TZ,
>  	[hwmon_temp]	= HWMON_T_INPUT | HWMON_T_LABEL,
>  	[hwmon_in]	= HWMON_I_INPUT | HWMON_I_LABEL,
