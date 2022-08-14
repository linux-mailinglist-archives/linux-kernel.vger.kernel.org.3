Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C62591FE2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 15:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiHNNd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 09:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHNNdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 09:33:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530581759E;
        Sun, 14 Aug 2022 06:33:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 090FEB80AEE;
        Sun, 14 Aug 2022 13:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFF0C433D6;
        Sun, 14 Aug 2022 13:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660484001;
        bh=cXQdMAxMMUixvPWaJ3r9QcDJ3wViHH+mep8Gcae419Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P5o05DPbrLAsxKagWvkNIPOOjaTB4sPKlYcOwxc0NFeKQkvpb9UnCX/OXhaDklARp
         Zfo7t2f0YA8AjIbdtOWhsJPMmPe6A1n19kOVlrUpTjdiFbK2SKv2MxBSy5zGakCYoa
         9a1z62vZOIjInVMDp2qR1i/mzuY3tUZcTMhqmF2esDh8xojw9Wkz1UlMGGQiDG16WU
         JzRLfJgi7xHj/jVLNYNpBepzYQrH2e9VDdv23S1T+YU3WURAYpkZ0r50r2DCpmYecH
         aNkspgkQF+6NrkaEMyRWvrmWC18WymC32xd04YPnqX7lM60W/+c3EUVfd6hFqqVb8B
         GzBl+6u3Oyt/A==
Date:   Sun, 14 Aug 2022 14:43:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] iio: pressure: bmp280: simplify driver
 initialization logic
Message-ID: <20220814144350.7d0282e6@jic23-huawei>
In-Reply-To: <602f032955b56eb367177d1de7536f18ad94bc87.1659872590.git.ang.iglesiasg@gmail.com>
References: <cover.1659872590.git.ang.iglesiasg@gmail.com>
        <602f032955b56eb367177d1de7536f18ad94bc87.1659872590.git.ang.iglesiasg@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Sun,  7 Aug 2022 13:54:40 +0200
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> Simplified common initialization logic of different sensor types
> unifying calibration and initial configuration recovery.
> 
> Default config param values of each sensor type are stored inside
> chip_info structure and used to initialize sensor data struct instance.
> 
> The helper functions for read each sensor type calibration are converted
> to a callback available on the chip_info struct.
> 
> Revised BMP180 and BMP280 definitions and code functions to use GENMASK
> and FIELD_PREP/FIELD_GET utilities to homogenize structure with more
> recent drivers, in preparation for the patches adding support for the
> BMP380 sensors.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
Hi Angel, not sure if I commented on this before, but this patch is doing
several different things, so in the ideal case it would be split into
1: FIELD_PREP/FIELD_GET/GENMASK changes. 
2: Chipinfo related changes
3: Maybe the the reordering of defintions of local variables that Andy
   indirectly referered to.

However, this is short enough to be fairly reviewable as it stands
so from my point of view I'll accept leaving 1 and 2 combined if it is
going to be a lot of work to separate them. Doesn't look like it will be hard
but without trying I'm not totally sure!

One question inline on what the chip parameter to the calibration functions
is there for as it appears unused.

Thanks,

Jonathan


> ---
>  drivers/iio/pressure/bmp280-core.c | 120 ++++++++++++++++++-----------
>  drivers/iio/pressure/bmp280.h      |  73 +++++++++---------
>  2 files changed, 113 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index fe7aa81e7cc9..a109c2609896 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -16,6 +16,8 @@
>  
>  #define pr_fmt(fmt) "bmp280: " fmt
>  
> +#include <linux/bitops.h>
> +#include <linux/bitfield.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> @@ -107,19 +109,28 @@ struct bmp280_data {
>  };
>  
>  struct bmp280_chip_info {
> +	unsigned int id_reg;
> +
> +	int num_channels;
> +	unsigned int start_up_time;
> +
>  	const int *oversampling_temp_avail;
>  	int num_oversampling_temp_avail;
> +	int oversampling_temp_default;
>  
>  	const int *oversampling_press_avail;
>  	int num_oversampling_press_avail;
> +	int oversampling_press_default;
>  
>  	const int *oversampling_humid_avail;
>  	int num_oversampling_humid_avail;
> +	int oversampling_humid_default;
>  
>  	int (*chip_config)(struct bmp280_data *);
>  	int (*read_temp)(struct bmp280_data *, int *);
>  	int (*read_press)(struct bmp280_data *, int *, int *);
>  	int (*read_humid)(struct bmp280_data *, int *, int *);
> +	int (*read_calib)(struct bmp280_data *, unsigned int);
>  };
>  
>  /*
> @@ -147,15 +158,14 @@ static const struct iio_chan_spec bmp280_channels[] = {
>  	},
>  };
>  
> -static int bmp280_read_calib(struct bmp280_data *data,
> -			     struct bmp280_calib *calib,
> -			     unsigned int chip)
> +static int bmp280_read_calib(struct bmp280_data *data, unsigned int chip)
>  {
>  	int ret;
>  	unsigned int tmp;
>  	__le16 l16;
>  	__be16 b16;
>  	struct device *dev = data->dev;
> +	struct bmp280_calib *calib = &data->calib.bmp280;
>  	__le16 t_buf[BMP280_COMP_TEMP_REG_COUNT / 2];
>  	__le16 p_buf[BMP280_COMP_PRESS_REG_COUNT / 2];
>  
> @@ -611,8 +621,8 @@ static const struct iio_info bmp280_info = {
>  static int bmp280_chip_config(struct bmp280_data *data)
>  {
>  	int ret;
> -	u8 osrs = BMP280_OSRS_TEMP_X(data->oversampling_temp + 1) |
> -		  BMP280_OSRS_PRESS_X(data->oversampling_press + 1);
> +	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
> +		  FIELD_PREP(BMP280_OSRS_PRESS_MASK, data->oversampling_press + 1);
>  
>  	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
>  				 BMP280_OSRS_TEMP_MASK |
> @@ -640,21 +650,38 @@ static int bmp280_chip_config(struct bmp280_data *data)
>  static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
>  
>  static const struct bmp280_chip_info bmp280_chip_info = {
> +	.id_reg = BMP280_REG_ID,
> +	.start_up_time = 2000,
> +	.num_channels = 2,
> +
>  	.oversampling_temp_avail = bmp280_oversampling_avail,
>  	.num_oversampling_temp_avail = ARRAY_SIZE(bmp280_oversampling_avail),
> +	/*
> +	 * Oversampling config values on BMx280 have one additional setting
> +	 * that other generations of the family don't:
> +	 * The value 0 means the measurement is bypassed instead of
> +	 * oversampling set to x1.
> +	 *
> +	 * To account for this difference, and preserve the same common
> +	 * config logic, this is handled later on chip_config callback
> +	 * incrementing one unit the oversampling setting.
> +	 */
> +	.oversampling_temp_default = BMP280_OSRS_TEMP_2X - 1,
>  
>  	.oversampling_press_avail = bmp280_oversampling_avail,
>  	.num_oversampling_press_avail = ARRAY_SIZE(bmp280_oversampling_avail),
> +	.oversampling_press_default = BMP280_OSRS_PRESS_16X - 1,
>  
>  	.chip_config = bmp280_chip_config,
>  	.read_temp = bmp280_read_temp,
>  	.read_press = bmp280_read_press,
> +	.read_calib = bmp280_read_calib,
>  };
>  
>  static int bme280_chip_config(struct bmp280_data *data)
>  {
>  	int ret;
> -	u8 osrs = BMP280_OSRS_HUMIDITIY_X(data->oversampling_humid + 1);
> +	u8 osrs = FIELD_PREP(BMP280_OSRS_HUMIDITY_MASK, data->oversampling_humid + 1);
>  
>  	/*
>  	 * Oversampling of humidity must be set before oversampling of
> @@ -670,19 +697,27 @@ static int bme280_chip_config(struct bmp280_data *data)
>  }
>  
>  static const struct bmp280_chip_info bme280_chip_info = {
> +	.id_reg = BMP280_REG_ID,
> +	.start_up_time = 2000,
> +	.num_channels = 3,
> +
>  	.oversampling_temp_avail = bmp280_oversampling_avail,
>  	.num_oversampling_temp_avail = ARRAY_SIZE(bmp280_oversampling_avail),
> +	.oversampling_temp_default = BMP280_OSRS_TEMP_2X - 1,
>  
>  	.oversampling_press_avail = bmp280_oversampling_avail,
>  	.num_oversampling_press_avail = ARRAY_SIZE(bmp280_oversampling_avail),
> +	.oversampling_press_default = BMP280_OSRS_PRESS_16X - 1,
>  
>  	.oversampling_humid_avail = bmp280_oversampling_avail,
>  	.num_oversampling_humid_avail = ARRAY_SIZE(bmp280_oversampling_avail),
> +	.oversampling_humid_default = BMP280_OSRS_HUMIDITY_16X - 1,
>  
>  	.chip_config = bme280_chip_config,
>  	.read_temp = bmp280_read_temp,
>  	.read_press = bmp280_read_press,
>  	.read_humid = bmp280_read_humid,
> +	.read_calib = bmp280_read_calib,
>  };
>  
>  static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
> @@ -710,7 +745,7 @@ static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
>  		if (!ret)
>  			dev_err(data->dev, "timeout waiting for completion\n");
>  	} else {
> -		if (ctrl_meas == BMP180_MEAS_TEMP)
> +		if (FIELD_GET(BMP180_MEAS_CTRL_MASK, ctrl_meas) == BMP180_MEAS_TEMP)
>  			delay_us = 4500;
>  		else
>  			delay_us =
> @@ -735,7 +770,9 @@ static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
>  	__be16 tmp;
>  	int ret;
>  
> -	ret = bmp180_measure(data, BMP180_MEAS_TEMP);
> +	ret = bmp180_measure(data,
> +			     FIELD_PREP(BMP180_MEAS_CTRL_MASK, BMP180_MEAS_TEMP) |
> +			     BMP180_MEAS_SCO);
>  	if (ret)
>  		return ret;
>  
> @@ -748,11 +785,11 @@ static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
>  	return 0;
>  }
>  
> -static int bmp180_read_calib(struct bmp280_data *data,
> -			     struct bmp180_calib *calib)
> +static int bmp180_read_calib(struct bmp280_data *data, unsigned int chip)

What is chip used for?  If there will be a need for it in later patches, then
it's fine to add the additional parameter now but please say why in the patch
description.


>  {
>  	int ret;
>  	int i;
> +	struct bmp180_calib *calib = &data->calib.bmp180;
>  	__be16 buf[BMP180_REG_CALIB_COUNT / 2];
>  
>  	ret = regmap_bulk_read(data->regmap, BMP180_REG_CALIB_START, buf,
> @@ -832,7 +869,10 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
>  	__be32 tmp = 0;
>  	u8 oss = data->oversampling_press;
>  
> -	ret = bmp180_measure(data, BMP180_MEAS_PRESS_X(oss));
> +	ret = bmp180_measure(data,
> +			     FIELD_PREP(BMP180_MEAS_CTRL_MASK, BMP180_MEAS_PRESS) |
> +			     FIELD_PREP(BMP180_OSRS_PRESS_MASK, oss) |
> +			     BMP180_MEAS_SCO);
>  	if (ret)
>  		return ret;
>  
