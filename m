Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F69E5272A1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 17:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbiENPbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 11:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiENPba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 11:31:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D79195A3;
        Sat, 14 May 2022 08:31:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7AC2B8075F;
        Sat, 14 May 2022 15:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B9EC340EE;
        Sat, 14 May 2022 15:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652542286;
        bh=NsuPP0wSi3Gueh4IgKAYYoWCOuew4mTzdAFK5yqAd+s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WjYfEN2ey2ofZCN/S9SZN/UvERi7jtwlE+FPltkdESCwE9coy1yd/xy3Ds+t+By1D
         5I91kQfUCx4XyngEPtx+Mdah8xGVOTsjQ83qTXzLC/JdDUHFZazWlnAm5V4Wqau7hi
         BqF0zHiyLiU0GoyRoYACMu0DYte9B5vmW9rXr1nWTmhPvUXxJoApauylRUR4pH45Wx
         18P3vuf9GEOhR6z0pds9N5ainhTuv6W/bgQpuVBfBRkzde0QNTLhfaYdC25nURdPx2
         DQeCrEJQ+872EtFBNKFX6YEBLZojEYGh4Vjmchu6yPTQTfr5WWev5s6aa5XeNfIvZa
         JKDXIn5c2lSeA==
Date:   Sat, 14 May 2022 16:40:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     lars@metafoo.de, mchehab+huawei@kernel.org, ardeleanalex@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 3/6] iio: accel: bmi088: modified the device name
Message-ID: <20220514164001.0ee0f49e@jic23-huawei>
In-Reply-To: <20220510141753.3878390-4-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220510141753.3878390-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220510141753.3878390-4-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022 14:17:50 +0000
LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:

> It is possible to have multiple sensors connected on the same platform,
> To support multiple sensors, the commit makes it possible to obtain the
> device name by reading the chip ID instead of the device-tree name.
> To be compatible with previous versions, renam bmi088a to bmi088-accel.
rename

This is technically a userspace ABI change.  However, the value changed was a fallback
anyway, so number of cases where you would actually get it are very few.

Hence I'm not that worried about the change.  I would add that it is an ABI change
and ideally figure out under what circumstances it matters (I 'think' it might be
when using fallback compatibles - but you should check).

> 
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  drivers/iio/accel/bmi088-accel-core.c | 6 +++---
>  drivers/iio/accel/bmi088-accel-spi.c  | 4 +---
>  drivers/iio/accel/bmi088-accel.h      | 2 +-
>  3 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
> index 8fee1d02e773..de2385e4dad5 100644
> --- a/drivers/iio/accel/bmi088-accel-core.c
> +++ b/drivers/iio/accel/bmi088-accel-core.c
> @@ -459,7 +459,7 @@ static const struct iio_chan_spec bmi088_accel_channels[] = {
>  
>  static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
>  	[0] = {
> -		.name = "bmi088a",
> +		.name = "bmi088-accel",
>  		.chip_id = 0x1E,
>  		.channels = bmi088_accel_channels,
>  		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
> @@ -524,7 +524,7 @@ static int bmi088_accel_chip_init(struct bmi088_accel_data *data)
>  }
>  
>  int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap,
> -	int irq, const char *name, bool block_supported)
> +	int irq, bool block_supported)
>  {
>  	struct bmi088_accel_data *data;
>  	struct iio_dev *indio_dev;
> @@ -545,7 +545,7 @@ int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap,
>  
>  	indio_dev->channels = data->chip_info->channels;
>  	indio_dev->num_channels = data->chip_info->num_channels;
> -	indio_dev->name = name ? name : data->chip_info->name;
> +	indio_dev->name = data->chip_info->name;
>  	indio_dev->available_scan_masks = bmi088_accel_scan_masks;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &bmi088_accel_info;
> diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
> index dd1e3f6cf211..0fed0081e1fd 100644
> --- a/drivers/iio/accel/bmi088-accel-spi.c
> +++ b/drivers/iio/accel/bmi088-accel-spi.c
> @@ -42,7 +42,6 @@ static struct regmap_bus bmi088_regmap_bus = {
>  static int bmi088_accel_probe(struct spi_device *spi)
>  {
>  	struct regmap *regmap;
> -	const struct spi_device_id *id = spi_get_device_id(spi);
>  
>  	regmap = devm_regmap_init(&spi->dev, &bmi088_regmap_bus,
>  			spi, &bmi088_regmap_conf);
> @@ -52,8 +51,7 @@ static int bmi088_accel_probe(struct spi_device *spi)
>  		return PTR_ERR(regmap);
>  	}
>  
> -	return bmi088_accel_core_probe(&spi->dev, regmap, spi->irq, id->name,
> -				       true);
> +	return bmi088_accel_core_probe(&spi->dev, regmap, spi->irq, true);
>  }
>  
>  static int bmi088_accel_remove(struct spi_device *spi)
> diff --git a/drivers/iio/accel/bmi088-accel.h b/drivers/iio/accel/bmi088-accel.h
> index 5c25f16b672c..c32afe9606a8 100644
> --- a/drivers/iio/accel/bmi088-accel.h
> +++ b/drivers/iio/accel/bmi088-accel.h
> @@ -12,7 +12,7 @@ extern const struct regmap_config bmi088_regmap_conf;
>  extern const struct dev_pm_ops bmi088_accel_pm_ops;
>  
>  int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
> -			    const char *name, bool block_supported);
> +			    bool block_supported);
>  int bmi088_accel_core_remove(struct device *dev);
>  
>  #endif /* BMI088_ACCEL_H */

