Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D354FFB3C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbiDMQ2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiDMQ2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:28:49 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26A744A35;
        Wed, 13 Apr 2022 09:26:27 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r133-20020a1c448b000000b0038ccb70e239so4312183wma.3;
        Wed, 13 Apr 2022 09:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z/Cz/PyERM9YfasFoDS3iI8CoehlrApmFqRSA2cjnNY=;
        b=UagYgR/krlOwCQL/uhhvT7TRWv62vgwbMUVVNu1i84gxKwyT8C242rDhUeZaeA5Ood
         FK/2g6+/D9H8ySHqU+Tyu329IUW3I1ZeTi2G3Ycy9VTdTjd+aFwHThIcI2iKVz6N/yAM
         6+gPjmp6HTN31htuTDmilsJIgVbjES9FyclkJxTY3kTjp03lzTujnesl6cjE5I9WXj7n
         dTMoZVPSXU5ibXSGt0K9pxTjfw3OIVY+jqkP5ZwB/ckhOnd6NKgg9j6BsFARrQSfALWl
         ssNcI8+2ArcRVuSsyW6Aql5WF6DDecigpOg1+xZvOwdvTizwrfcHVhGwDHwi5RVAC3+p
         u2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z/Cz/PyERM9YfasFoDS3iI8CoehlrApmFqRSA2cjnNY=;
        b=f4tdL4LTn6dvAqGKW6guqKlO7M4h2cPrYzzXH+YZ1BH9PNi1RAsdrexe5RFolJrP5J
         kg+rNWgfqecBUEU7sohChaHEYqzTxbGFoBz2LTmqXetOGC/rhhQin3nNPC4e2e7RrQFn
         C3l5L3iZRRByhfY1VH0KN4V28bjLwhnew3Pf+aVbGFSL5rl4pFrqPfdKDIRPCoE1Zplq
         M4lRfrRxqBz3s5SN/KSoWCcz8itFqoh/12RgJZJYkvbL3xuN15/Nr/bJUja/NdT7x9va
         0NHZ7xyAJ7wDbPQrcWBT0hPii/b2vrR8+SFT4gpzn4pXkQKvhvED4jAchm+ptOY6g+h9
         5S1w==
X-Gm-Message-State: AOAM530rBm9OEwQLxbLXY4SYE80bnhXHKMWCafcOBC/0m8/YDSTRMXLU
        i6gHWhqY77Na8bmRe5SGvI0=
X-Google-Smtp-Source: ABdhPJwKQClODbSjjiaNQHDFeMiZXzY8jczgvkClhxZtHdEkf0dGDMkUGrEWSWsHqPRqdNKHGLwqWw==
X-Received: by 2002:a05:600c:3493:b0:38e:bbbb:26f7 with SMTP id a19-20020a05600c349300b0038ebbbb26f7mr9345326wmq.114.1649867186333;
        Wed, 13 Apr 2022 09:26:26 -0700 (PDT)
Received: from arch-thunder (a109-49-33-111.cpe.netcabo.pt. [109.49.33.111])
        by smtp.gmail.com with ESMTPSA id g8-20020a5d4888000000b00207a49fa6a1sm10713117wrq.81.2022.04.13.09.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 09:26:25 -0700 (PDT)
Date:   Wed, 13 Apr 2022 17:26:23 +0100
From:   Rui Miguel Silva <rmfrfs@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: gyro: fxas21002c: Make use of device
 properties
Message-ID: <20220413162623.azoqoehu23kggk4x@arch-thunder>
References: <20220413131513.59258-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413131513.59258-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,
Thanks for the patch.

On Wed, Apr 13, 2022 at 04:15:13PM +0300, Andy Shevchenko wrote:
> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This LGTM.

Acked-by: Rui Miguel Silva <rmfrfs@gmail.com>

Cheers,
     Rui

> ---
>  drivers/iio/gyro/fxas21002c_core.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
> index 410e5e9f2672..0923fd793492 100644
> --- a/drivers/iio/gyro/fxas21002c_core.c
> +++ b/drivers/iio/gyro/fxas21002c_core.c
> @@ -7,9 +7,9 @@
>  
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> -#include <linux/of_irq.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  
> @@ -822,7 +822,6 @@ static int fxas21002c_trigger_probe(struct fxas21002c_data *data)
>  {
>  	struct device *dev = regmap_get_device(data->regmap);
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> -	struct device_node *np = indio_dev->dev.of_node;
>  	unsigned long irq_trig;
>  	bool irq_open_drain;
>  	int irq1;
> @@ -831,8 +830,7 @@ static int fxas21002c_trigger_probe(struct fxas21002c_data *data)
>  	if (!data->irq)
>  		return 0;
>  
> -	irq1 = of_irq_get_byname(np, "INT1");
> -
> +	irq1 = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
>  	if (irq1 == data->irq) {
>  		dev_info(dev, "using interrupt line INT1\n");
>  		ret = regmap_field_write(data->regmap_fields[F_INT_CFG_DRDY],
> @@ -843,7 +841,7 @@ static int fxas21002c_trigger_probe(struct fxas21002c_data *data)
>  
>  	dev_info(dev, "using interrupt line INT2\n");
>  
> -	irq_open_drain = of_property_read_bool(np, "drive-open-drain");
> +	irq_open_drain = device_property_read_bool(dev, "drive-open-drain");
>  
>  	data->dready_trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
>  						   indio_dev->name,
> -- 
> 2.35.1
> 
