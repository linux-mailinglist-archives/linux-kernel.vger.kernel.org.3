Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0090527292
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 17:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiENPYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 11:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiENPYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 11:24:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEFD32EFE;
        Sat, 14 May 2022 08:24:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EB1E60F90;
        Sat, 14 May 2022 15:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94CEC340EE;
        Sat, 14 May 2022 15:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652541840;
        bh=CXqphFwODHN30684avFpvEiVZJUE89dFdIU71DTb0qE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bYT0CqUfMQlYWWuOSBG1UIMkokA599O0E00rNbQPmwq6Coj9cU2BWEmvjhR6h7tBO
         dVfQNt24P2Tw/RkMR1fn0Cea/CGLRKwAjU/gu6H8Zw8I2+4QgQykY4rUtiW10JF/bn
         I8gtlhqgKoMvrahn0L2bxKQOs6M1+n1rFRnd1anmHJMAX+1mBgMQZDTscsV8UsrePb
         Zj+t2XH+bSJifq7R/B4HEV9YdqFUHp35AAv2+/P8TIbSWVjUhFQO9G5x4Bn04I7C5N
         IMwWX0R/H6kIiwvfhQUib913VisT4Na9wotjRuy+BoBgIwPDoHDScxr8jbctkx7abD
         VFmk5/ZJQG4Hw==
Date:   Sat, 14 May 2022 16:32:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     lars@metafoo.de, mchehab+huawei@kernel.org, ardeleanalex@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 1/6] iio: accel: bmi088: Modified the scale calculate
Message-ID: <20220514163235.6c6ae0f3@jic23-huawei>
In-Reply-To: <20220510141753.3878390-2-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220510141753.3878390-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220510141753.3878390-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
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

On Tue, 10 May 2022 14:17:48 +0000
LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:

> The units after application of scale are 100*m/s^2,
> The scale calculation is only for the device
> with the range of 3, 6, 12, and 24g,
> but some other chips have a range of 2, 4, 6, and 8g.
> 
> Modified the formula to a scale list.
> The scales in the list are calculated by 1/sensitivity*9.8.
> The new units after the application of scale are m/s^2.
> 
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  drivers/iio/accel/bmi088-accel-core.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
> index a06dae5c971d..9300313b63cb 100644
> --- a/drivers/iio/accel/bmi088-accel-core.c
> +++ b/drivers/iio/accel/bmi088-accel-core.c
> @@ -119,6 +119,7 @@ struct bmi088_accel_chip_info {
>  	u8 chip_id;
>  	const struct iio_chan_spec *channels;
>  	int num_channels;
> +	const int scale_table[4][2];
>  };
>  
>  struct bmi088_accel_data {
> @@ -280,6 +281,7 @@ static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
>  	struct bmi088_accel_data *data = iio_priv(indio_dev);
>  	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
> +	int reg;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -330,13 +332,12 @@ static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
>  				return ret;
>  
>  			ret = regmap_read(data->regmap,
> -					  BMI088_ACCEL_REG_ACC_RANGE, val);
> +					  BMI088_ACCEL_REG_ACC_RANGE, &reg);
>  			if (ret)
>  				goto out_read_raw_pm_put;
> -
> -			*val2 = 15 - (*val & 0x3);
> -			*val = 3 * 980;
> -			ret = IIO_VAL_FRACTIONAL_LOG2;
> +			*val = data->chip_info->scale_table[reg&0x03][0];
> +			*val2 = data->chip_info->scale_table[reg&0x03][1];

Spaces needed around the &
The 0x03 should be a define - something like BMIO088_ACCEL_ACC_RANGE_MSK

Also, this driver doesn't yet use FIELD_PREP() / FIELD_GET()
but this is a good example of where using FIELD_GET() will make the logic
clearer.


> +			ret = IIO_VAL_INT_PLUS_MICRO;
>  
>  			goto out_read_raw_pm_put;
>  		default:
> @@ -432,6 +433,7 @@ static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
>  		.chip_id = 0x1E,
>  		.channels = bmi088_accel_channels,
>  		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
> +		.scale_table = {{0, 897}, {0, 1795}, {0, 3590}, {0, 7179}},
>  	},
>  };
>  

