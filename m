Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B7B466584
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358673AbhLBOol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhLBOoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:44:38 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04B0C06174A;
        Thu,  2 Dec 2021 06:41:15 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so40182133otl.3;
        Thu, 02 Dec 2021 06:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y4at8L60EXfC3cEZPxJ2dBLND1wT12N83NGhaALKKS0=;
        b=nLKe1VXlRjDQoG4ohd4OQO8q80qM2cmlZyZa2LSp2un5q4FcuxASvQZxUfp+cp16/9
         ea938qTVJPehLvuG7alpoZvd8P1KGq1cgWs0xzqFEpGnBsqOsduCKPdXpBnI8ovKqZZb
         sWO4fELGA9d5E11bCpUpQEDGE84RStt6gCpELEVhlkwYq66914QqyWLGqkpu57CZak96
         YmpTYIwvuCu7IX/njU1NEdmeXlug/lhFnHpUizVCjQ9nYYKYh7qIeo5JY2BL7rYYM5he
         3UIN0+gZ37g0ts4G/FdT0XYJ9UoSY3qs5nLCERtzmnJTHxTe8AQbUAsPPViWFsOMU4fK
         7xVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Y4at8L60EXfC3cEZPxJ2dBLND1wT12N83NGhaALKKS0=;
        b=jEN7xwRF4oY+rLfBcNtpevWQvoGOP4DtLXI1fgR4f7VegfcyhjAp8Npd4lDn8DXuku
         DsPX53y90F2325x0WlQDlqAcpGaA0ypuGgnbqOIzTEGzdclbNY1zW49aDBhpcedk9XU6
         hl5spW6QSKopKgUJMT0N0bST7JuV8NNwYyJhwWLOSFoQl+6AlWA035lZQDrXLNnx6+aW
         hOxNTqGjLqLCsVC0VJC9DDA7MKgi+IxGiYr4B3cCZjSVRfdVWLiX2IJUmSgEKx32CbV3
         3HYfWA7OkD9W6gWjq4lYH4C3Nl+ufA3aEsY+53Mwclljt/RzJLXXaAjciJ5A27XinqCm
         OKfA==
X-Gm-Message-State: AOAM532aDAu/MrvqnB+fGbWccC3b5VJJaTMopPVdxOTtMJByHq06KiVV
        mPBdG7uboOEt8Ffw3h+NEZQ=
X-Google-Smtp-Source: ABdhPJz5xD8isNpVTkMna0LFOmiVRyMKZUrUK9Ae68fME5gRpQzvlI1Yv57sLiKQHGIwBIssBT1i5w==
X-Received: by 2002:a05:6830:3094:: with SMTP id f20mr11773489ots.201.1638456075329;
        Thu, 02 Dec 2021 06:41:15 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x12sm1192120oom.44.2021.12.02.06.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 06:41:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 2 Dec 2021 06:41:13 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     support.opensource@diasemi.com, linux-watchdog@vger.kernel.org,
        wim@linux-watchdog.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/4] watchdog: da9062: reset board on watchdog timeout
Message-ID: <20211202144113.GB828760@roeck-us.net>
References: <20211202093230.3951996-1-andrej.picej@norik.com>
 <20211202093230.3951996-2-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202093230.3951996-2-andrej.picej@norik.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 10:32:28AM +0100, Andrej Picej wrote:
> Implement a method to change watchdog timeout configuration based on DT
> binding ("dlg,wdt-sd"). There is a possibility to change the bahaviour
> of watchdog reset. Setting WATCHDOG_SD bit enables SHUTDOWN mode, and
> clearing it enables POWERDOWN mode on watchdog timeout.
> 
> If no DT binding is specified the WATCHDOG_SD bit stays in default
> configuration, not breaking behaviour of devices which might depend on
> default fuse configuration.
> 
> Note: This patch requires that the config register CONFIG_I is
> configured as writable in the da9062 multi function device.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Chnages in v4:
>  - move the code to probe function
> 
> Changes in v3:
>  - no changes
> 
> Changes in v2:
>  - don't force the "reset" for all da9062-watchdog users, instead add DT
>    binding where the behavior can be selected
> ---
>  drivers/watchdog/da9062_wdt.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
> index f02cbd530538..bd85f84b0fd4 100644
> --- a/drivers/watchdog/da9062_wdt.c
> +++ b/drivers/watchdog/da9062_wdt.c
> @@ -195,8 +195,11 @@ static int da9062_wdt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	unsigned int timeout;
> +	unsigned int mask;
>  	struct da9062 *chip;
>  	struct da9062_watchdog *wdt;
> +	int ret;
> +	u32 val;
>  
>  	chip = dev_get_drvdata(dev->parent);
>  	if (!chip)
> @@ -236,6 +239,30 @@ static int da9062_wdt_probe(struct platform_device *pdev)
>  		set_bit(WDOG_HW_RUNNING, &wdt->wdtdev.status);
>  	}
>  
> +	/*
> +	 * Configure what happens on watchdog timeout. Can be specified with
> +	 * "dlg,wdt-sd" dt-binding (0 -> POWERDOWN, 1 -> SHUTDOWN).
> +	 * If "dlg,wdt-sd" dt-binding is NOT set use the default.
> +	 */
> +	ret = device_property_read_u32(dev, "dlg,wdt-sd", &val);
> +	if (!ret) {
> +		if (val)
> +			/* Use da9062's SHUTDOWN mode */
> +			mask = DA9062AA_WATCHDOG_SD_MASK;
> +		else
> +			/* Use da9062's POWERDOWN mode. */
> +			mask = 0x0;
> +
> +		ret = regmap_update_bits(wdt->hw->regmap,
> +						DA9062AA_CONFIG_I,
> +						DA9062AA_WATCHDOG_SD_MASK,
> +						mask);
> +
> +		if (ret)
> +			dev_err(dev, "failed to set wdt reset mode: %d\n",
> +				ret);
> +	}
> +
>  	return devm_watchdog_register_device(dev, &wdt->wdtdev);
>  }
>  
> -- 
> 2.25.1
> 
