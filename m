Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EDD4B3C9A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 18:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbiBMRpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 12:45:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiBMRpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 12:45:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7BD5A089;
        Sun, 13 Feb 2022 09:45:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20349B80B34;
        Sun, 13 Feb 2022 17:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4C7C004E1;
        Sun, 13 Feb 2022 17:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644774325;
        bh=COdjjC01iBK0JsZH5nPzUnTD03GE7GcsFLUEE/Ys078=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jd+OqXxA3UrIHgrbShzIXIookEG90ZszYD9NMleOcmGnUOITjSH4Air83X3RTEvzM
         qxBvvNy3xmDZ353nDFD/ixGI/vke33csZgbUqMkeKrVReqY5cSRrOtHF3kWjKntWvC
         60FlthrLUJ7y5AWxqkjRnhMh6Srfjj9EU/EcK6++9T01+mF5vJ8xogkoVSmIAYjLRI
         56ntp5T/nUsL5+jX3kcZgliwl4zgiVEY9sZKcCprnJxnZ65S1u6Bn+E/F+7qNjWQZO
         sIQLqi/5vVDqFoGERlPua5poOLVPIqc1lWMw2UwBqXReSnUGDG/ajcLlsGaLEa5XCj
         N3GP6h5/tHMjQ==
Date:   Sun, 13 Feb 2022 17:52:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: ssp_sensors: Make use of device properties
Message-ID: <20220213175207.143e5767@jic23-huawei>
In-Reply-To: <20220210135724.26660-1-andriy.shevchenko@linux.intel.com>
References: <20220210135724.26660-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2022 15:57:24 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  drivers/iio/common/ssp_sensors/ssp_dev.c | 22 +++++-----------------
>  1 file changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
> index eafaf4529df5..c1abd20ff808 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_dev.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
> @@ -7,9 +7,10 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/mfd/core.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
> -#include <linux/of_platform.h>
> +#include <linux/property.h>
> +
>  #include "ssp.h"
>  
>  #define SSP_WDT_TIME			10000
> @@ -425,7 +426,6 @@ int ssp_queue_ssp_refresh_task(struct ssp_data *data, unsigned int delay)
>  				  msecs_to_jiffies(delay));
>  }
>  
> -#ifdef CONFIG_OF
>  static const struct of_device_id ssp_of_match[] = {
>  	{
>  		.compatible	= "samsung,sensorhub-rinato",
> @@ -441,8 +441,6 @@ MODULE_DEVICE_TABLE(of, ssp_of_match);
>  static struct ssp_data *ssp_parse_dt(struct device *dev)
>  {
>  	struct ssp_data *data;
> -	struct device_node *node = dev->of_node;
> -	const struct of_device_id *match;
>  
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
> @@ -461,22 +459,12 @@ static struct ssp_data *ssp_parse_dt(struct device *dev)
>  	if (IS_ERR(data->mcu_reset_gpiod))
>  		return NULL;
>  
> -	match = of_match_node(ssp_of_match, node);
> -	if (!match)
> -		return NULL;
> -
> -	data->sensorhub_info = match->data;
> +	data->sensorhub_info = device_get_match_data(dev);
>  
>  	dev_set_drvdata(dev, data);
>  
>  	return data;
>  }
> -#else
> -static struct ssp_data *ssp_parse_dt(struct device *pdev)
> -{
> -	return NULL;
> -}
> -#endif
>  
>  /**
>   * ssp_register_consumer() - registers iio consumer in ssp framework
> @@ -670,7 +658,7 @@ static struct spi_driver ssp_driver = {
>  	.remove = ssp_remove,
>  	.driver = {
>  		.pm = &ssp_pm_ops,
> -		.of_match_table = of_match_ptr(ssp_of_match),
> +		.of_match_table = ssp_of_match,
>  		.name = "sensorhub"
>  	},
>  };

