Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4564C53CE07
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344449AbiFCRYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344439AbiFCRYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:24:51 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421A1527FE;
        Fri,  3 Jun 2022 10:24:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9EF15CE23F1;
        Fri,  3 Jun 2022 17:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECD8C385B8;
        Fri,  3 Jun 2022 17:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654277086;
        bh=xfag6dKeQNQUdy4u9ec+mbnjJETjTFrRoo6U96kuMWw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DRiOveNypFRpyQqmRX76utHPLIF3PYbCIConS60bj5XUOZJhCuC3OEwaL/FVH76L7
         YCoucggBzfeKLEOxzXKpFLSp2saKP0BMtHOh1Oat5vvMW4tQhrAvyskIEziW+NpKVT
         l6VzMqIyvrAjIhrj6vEP2GnydURJ5ovjfG5I4O7vEAYutes28CssM5u4/qVoE7s+aK
         6PMb6hocpXvaI1bp7vihsUg+v9HyTIwyA9BGVqYdJK/uJlBz/mEj9CEW1Gk0sF/Nuo
         L5StbbZFZXmVf3Kusbd68FIMNx5k/gnxCpL5xsh/5yP7MN33hYze1+FwmAzPSpTqt8
         F2Q56aolN32xg==
Date:   Fri, 3 Jun 2022 18:33:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Lars-Peter Clausen <lars@metafoo.de>,
        Haibo Chen <haibo.chen@nxp.com>
Subject: Re: [PATCH v1 1/1] iio: adc: vf610_adc: Make use of device
 properties
Message-ID: <20220603183347.1122fd21@jic23-huawei>
In-Reply-To: <20220531142353.64925-1-andriy.shevchenko@linux.intel.com>
References: <20220531142353.64925-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2022 17:23:53 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> Add mod_devicetable.h include.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied,

J
> ---
>  drivers/iio/adc/Kconfig     |  1 -
>  drivers/iio/adc/vf610_adc.c | 15 ++++++---------
>  2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 3b6a80786b51..448ae243cd31 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1257,7 +1257,6 @@ config TWL6030_GPADC
>  
>  config VF610_ADC
>  	tristate "Freescale vf610 ADC driver"
> -	depends on OF
>  	depends on HAS_IOMEM
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index c84293efc129..c6b16cf6e367 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -5,7 +5,9 @@
>   * Copyright 2013 Freescale Semiconductor, Inc.
>   */
>  
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/property.h>
>  #include <linux/platform_device.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
> @@ -14,10 +16,7 @@
>  #include <linux/io.h>
>  #include <linux/clk.h>
>  #include <linux/completion.h>
> -#include <linux/of.h>
> -#include <linux/of_irq.h>
>  #include <linux/regulator/consumer.h>
> -#include <linux/of_platform.h>
>  #include <linux/err.h>
>  
>  #include <linux/iio/iio.h>
> @@ -799,6 +798,7 @@ MODULE_DEVICE_TABLE(of, vf610_adc_match);
>  
>  static int vf610_adc_probe(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
>  	struct vf610_adc *info;
>  	struct iio_dev *indio_dev;
>  	int irq;
> @@ -846,13 +846,10 @@ static int vf610_adc_probe(struct platform_device *pdev)
>  
>  	info->vref_uv = regulator_get_voltage(info->vref);
>  
> -	of_property_read_u32_array(pdev->dev.of_node, "fsl,adck-max-frequency",
> -			info->max_adck_rate, 3);
> +	device_property_read_u32_array(dev, "fsl,adck-max-frequency", info->max_adck_rate, 3);
>  
> -	ret = of_property_read_u32(pdev->dev.of_node, "min-sample-time",
> -			&info->adc_feature.default_sample_time);
> -	if (ret)
> -		info->adc_feature.default_sample_time = DEFAULT_SAMPLE_TIME;
> +	info->adc_feature.default_sample_time = DEFAULT_SAMPLE_TIME;
> +	device_property_read_u32(dev, "min-sample-time", &info->adc_feature.default_sample_time);
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  

