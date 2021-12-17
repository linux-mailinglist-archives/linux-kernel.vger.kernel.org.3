Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A98478FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbhLQPcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238423AbhLQPcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:32:13 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38B9C0698C3;
        Fri, 17 Dec 2021 07:31:26 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso3288375ots.6;
        Fri, 17 Dec 2021 07:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lu0UdPJL31ueXA/4Dw7vfRjVtZllsfpxLQQFiFGvr4c=;
        b=dfhmoVR+CtjD83midpW+yVb7FTXGOUvmVDDordobSyse0KllGGcqvc2I+Qn5giLKSo
         Jv+5N8dCbdu+0YUf1br7e8QIZdvLJx3jN0q2x91+s7skbsV5RNr2tRbYAp7/ZPjgTyIB
         x9z4S4K1DXcLFwPjtxl4L4V9Esvf+F7bPiTIkQNrNdLjMDkqSw019ZEiiLMGyYW6JAog
         bpfVm6OK1Ix9/EC0x2+54sZ8YRcTIMqU2G0p00z1u8j+TJ1m5CvDqRLOP2L3UTtM31sM
         ly72jdDFi5qwTzO6T31yXd45p6wz/bWMU2vL0oeC2j0sA9oQE89il+Kj9lriEwXssAPR
         zckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lu0UdPJL31ueXA/4Dw7vfRjVtZllsfpxLQQFiFGvr4c=;
        b=XR06cuC0B4qzM70NlCGbDp0/zPyyGe6iTShhV61xFhhQ6LoVJver1PCSSrfBB0Jkng
         S8DlZKWJBI33RImgqkboHRzL+PGFsL8neM3fU25r5MAJqs0xOyMf2TSEGtJudG1U1Hxh
         LHb8l1L9FR8fHtBzJxZLWnJ5oBJ2qvGtvxpuW6slUWM3VC3PG5B3DqMocxU1GQlbGbcK
         KrptWBswqH1bKeuWGNi+MnftmBb1w9FMcC27DZbQCjyqyrtm9uDqK2mb9OkIEyiiDsAB
         uqqmLKvcOwjkZ+H0zY4VwWgQwMKmkKvHFQ5Wk3Q6r+Q3g9JOsBDUJ4PnPg8RDzSnO01w
         66GA==
X-Gm-Message-State: AOAM533/GBkxi2EPnxSHzt+KAfdKxHI9EDa9BxHZmhtQmcnZkq/pL/up
        /f9NP9stlQlwMBmc8vr3wiA=
X-Google-Smtp-Source: ABdhPJyBWR7Omwd+THgRXU54oGJPmo+BO52v8Cdi72qHVd6nn8hAS22ps6EhSLf0MS98M/JxL9DCpw==
X-Received: by 2002:a9d:4d8b:: with SMTP id u11mr2506702otk.144.1639755086120;
        Fri, 17 Dec 2021 07:31:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 69sm1637677otf.33.2021.12.17.07.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 07:31:25 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 17 Dec 2021 07:31:24 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (raspberrypi) Exit immediately in case of error
 in init
Message-ID: <20211217153124.GA2486939@roeck-us.net>
References: <20211211184449.18211-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211211184449.18211-1-W_Armin@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2021 at 07:44:49PM +0100, Armin Wolf wrote:
> Exit immediately if devm_hwmon_device_register_with_info()
> fails since registering a delayed work whould be useless
> in such a case anyway.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/raspberrypi-hwmon.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> --
> 2.30.2
> 
> diff --git a/drivers/hwmon/raspberrypi-hwmon.c b/drivers/hwmon/raspberrypi-hwmon.c
> index 573f53d52912..1650d3b4c26e 100644
> --- a/drivers/hwmon/raspberrypi-hwmon.c
> +++ b/drivers/hwmon/raspberrypi-hwmon.c
> @@ -120,6 +120,8 @@ static int rpi_hwmon_probe(struct platform_device *pdev)
>  							       data,
>  							       &rpi_chip_info,
>  							       NULL);
> +	if (IS_ERR(data->hwmon_dev))
> +		return PTR_ERR(data->hwmon_dev);
> 
>  	ret = devm_delayed_work_autocancel(dev, &data->get_values_poll_work,
>  					   get_values_poll);
> @@ -127,10 +129,9 @@ static int rpi_hwmon_probe(struct platform_device *pdev)
>  		return ret;
>  	platform_set_drvdata(pdev, data);
> 
> -	if (!PTR_ERR_OR_ZERO(data->hwmon_dev))
> -		schedule_delayed_work(&data->get_values_poll_work, 2 * HZ);
> +	schedule_delayed_work(&data->get_values_poll_work, 2 * HZ);
> 
> -	return PTR_ERR_OR_ZERO(data->hwmon_dev);
> +	return 0;
>  }
> 
>  static struct platform_driver rpi_hwmon_driver = {
