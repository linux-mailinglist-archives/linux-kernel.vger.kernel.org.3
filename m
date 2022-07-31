Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D41A585EC3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 14:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbiGaMD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 08:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiGaMD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 08:03:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF1211814;
        Sun, 31 Jul 2022 05:03:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7F9EB80D1D;
        Sun, 31 Jul 2022 12:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E52CC433D6;
        Sun, 31 Jul 2022 12:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659269003;
        bh=dgiL09k3fn1iAi1x9FpXJw4FrC+NXMosnHbICt8S4Zs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JHQK9Pl3O8Vnrcfj3/YDIY+pWrMUG0hvj6nyIrkJ7tCFKK21Ncfec/QzojLSvDARe
         lr7o0yzRQLgJPTbozA0g4qVRpxpOVddLE8Cbk9bzVU5MVbHHq3GPtsHTbYZl+9Bp0x
         RDTc1fS9WNoDB3Z8Pa/hIeAwaidUaAqlEksqllwiqwL//DTKNHkAhEk9KcBqzekef6
         MD/ktPdll/uLze02Gb3/vqdV89Tavmope2E223OB+k63KAOZoOjKqc8X7sTGh7Gob3
         M3mQ4WKjwtOvXcsR/5y3dwsDMSuzK0agZtMtpBgA+MZ+XvgS1rGY9M64kPie3Rr9f7
         Grz3f+dzYSQIA==
Date:   Sun, 31 Jul 2022 13:13:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com, lukasz.luba@arm.com,
        broonie@kernel.org, damien.lemoal@opensource.wdc.com,
        heiko@sntech.de, hayashi.kunihiko@socionext.com,
        mhiramat@kernel.org, talel@amazon.com, thierry.reding@gmail.com,
        digetx@gmail.com, jonathanh@nvidia.com, anarsoul@gmail.com,
        tiny.windzz@gmail.com, baolin.wang7@gmail.com,
        f.fainelli@gmail.com, bjorn.andersson@linaro.org,
        mcoquelin.stm32@gmail.com, glaroque@baylibre.com,
        miquel.raynal@bootlin.com, shawnguo@kernel.org,
        niklas.soderlund@ragnatech.se, matthias.bgg@gmail.com,
        j-keerthy@ti.com, Lars-Peter Clausen <lars@metafoo.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support)
Subject: Re: [PATCH v3 27/32] iio/drivers/sun4i_gpadc: Switch to new of
 thermal API
Message-ID: <20220731131328.7301de32@jic23-huawei>
In-Reply-To: <20220727210253.3794069-28-daniel.lezcano@linexp.org>
References: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
        <20220727210253.3794069-28-daniel.lezcano@linexp.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 23:02:48 +0200
Daniel Lezcano <daniel.lezcano@linexp.org> wrote:

> The thermal OF code has a new API allowing to migrate the OF
> initialization to a simpler approach. The ops are no longer device
> tree specific and are the generic ones provided by the core code.
> 
> Convert the ops to the thermal_zone_device_ops format and use the new
> API to register the thermal zone with these generic ops.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Whilst making no pretence at having checked what the new calls do, I'm fine with this
patch affecting the driver in IIO and going through appropriate thermal tree.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index 2d393a4dfff6..13d1e937357c 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -412,9 +412,9 @@ static int sun4i_gpadc_runtime_resume(struct device *dev)
>  	return 0;
>  }
>  
> -static int sun4i_gpadc_get_temp(void *data, int *temp)
> +static int sun4i_gpadc_get_temp(struct thermal_zone_device *tz, int *temp)
>  {
> -	struct sun4i_gpadc_iio *info = data;
> +	struct sun4i_gpadc_iio *info = tz->devdata;
>  	int val, scale, offset;
>  
>  	if (sun4i_gpadc_temp_read(info->indio_dev, &val))
> @@ -428,7 +428,7 @@ static int sun4i_gpadc_get_temp(void *data, int *temp)
>  	return 0;
>  }
>  
> -static const struct thermal_zone_of_device_ops sun4i_ts_tz_ops = {
> +static const struct thermal_zone_device_ops sun4i_ts_tz_ops = {
>  	.get_temp = &sun4i_gpadc_get_temp,
>  };
>  
> @@ -637,9 +637,9 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
>  	pm_runtime_enable(&pdev->dev);
>  
>  	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
> -		info->tzd = thermal_zone_of_sensor_register(info->sensor_device,
> -							    0, info,
> -							    &sun4i_ts_tz_ops);
> +		info->tzd = thermal_of_zone_register(info->sensor_device,
> +						     0, info,
> +						     &sun4i_ts_tz_ops);
>  		/*
>  		 * Do not fail driver probing when failing to register in
>  		 * thermal because no thermal DT node is found.

