Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5815AC4EE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 17:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbiIDPTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 11:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbiIDPTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 11:19:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB5915A2B;
        Sun,  4 Sep 2022 08:19:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FD2560F36;
        Sun,  4 Sep 2022 15:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8570FC433D6;
        Sun,  4 Sep 2022 15:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662304782;
        bh=5T5KK1R+lLkAiOgyJVvenWpyIpd2PPMpzy2c4deWB6I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dgfCT7NPTr7maI8aCZ++zMT7lYNHlabDUVdgplghDV4PFsRehywmABWlisb0Q4Mof
         Vs50C8gGL1XUMm7Y4NaxXIF226qzAsSlY9H0p6AQSoZ1Zy7KTDRy7vjkIlrlu+IjzS
         k+ESU0CMVnM34FTHFof8zh/1eA8QRydy4GlofNVZChd3rcgrm+ljYHZqPmRAj7NAa6
         f2ijauvAf6l9DyQkyfOGKencpePCywifPm9Zm8AB/ceaQnX3ZfkcK2dHJjkTGFXMXa
         Ytt+CmCQq6xF3e8IbuXbsJ0JGgMZhYzb7tkmfXL5tXkzvw1d9Eg1aSIokvaKDmhMlR
         yU00JfqrQY8OQ==
Date:   Sun, 4 Sep 2022 15:45:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     cmo@melexis.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 2/3] iio: temperature: mlx90632 Read sampling
 frequency
Message-ID: <20220904154535.0bb526bc@jic23-huawei>
In-Reply-To: <20220903222402.3426058-1-cmo@melexis.com>
References: <20220903222402.3426058-1-cmo@melexis.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  4 Sep 2022 00:24:02 +0200
cmo@melexis.com wrote:

> From: Crt Mori <cmo@melexis.com>
> 
> Allow users to read sensor sampling frequency to better plan the
> application measurement requests.

I didn't read this closely enough.  Why is the frequency read only?
We'd not normally have an available attribute in that case, because
the values aren't available if we have no way to set the value.

Jonathan

> 
> Signed-off-by: Crt Mori <cmo@melexis.com>
> ---
>  drivers/iio/temperature/mlx90632.c | 44 ++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index 9acd819c76a6..37edd324d6a1 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -80,6 +80,9 @@
>  #define MLX90632_PWR_STATUS_CONTINUOUS MLX90632_PWR_STATUS(3) /* continuous */
>  
>  #define MLX90632_EE_RR(ee_val) (ee_val & GENMASK(10, 8)) /* Only Refresh Rate bits */
> +#define MLX90632_REFRESH_RATE(ee_val) (MLX90632_EE_RR(ee_val) >> 8)
> +					/* Extract Refresh Rate from ee register */
> +#define MLX90632_REFRESH_RATE_STATUS(refresh_rate) (refresh_rate << 8)
>  
>  /* Measurement types */
>  #define MLX90632_MTYP_MEDICAL 0
> @@ -908,6 +911,24 @@ static int mlx90632_calc_ambient_dsp105(struct mlx90632_data *data, int *val)
>  	return ret;
>  }
>  
> +static int mlx90632_get_refresh_rate(struct mlx90632_data *data,
> +				     int *refresh_rate)
> +{
> +	unsigned int meas1;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, MLX90632_EE_MEDICAL_MEAS1, &meas1);
> +	if (ret < 0)
> +		return ret;
> +
> +	*refresh_rate = MLX90632_REFRESH_RATE(meas1);
> +
> +	return ret;
> +}
> +
> +static const int mlx90632_freqs[][2] = { {0, 500000}, {1, 0}, {2, 0}, {4, 0},
> +					  {8, 0}, {16, 0}, {32, 0}, {64, 0} };
> +
>  static int mlx90632_pm_interraction_wakeup(struct mlx90632_data *data)
>  {
>  	unsigned long now;
> @@ -978,6 +999,15 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
>  		*val = data->object_ambient_temperature;
>  		ret = IIO_VAL_INT;
>  		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = mlx90632_get_refresh_rate(data, &cr);
> +		if (ret < 0)
> +			goto mlx90632_read_raw_pm;
> +
> +		*val = mlx90632_freqs[cr][0];
> +		*val2 = mlx90632_freqs[cr][1];
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
>  	default:
>  		ret = -EINVAL;
>  		break;
> @@ -1012,12 +1042,24 @@ static int mlx90632_write_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static IIO_CONST_ATTR(sampling_frequency_available, "0.5 1 2 4 8 16 32 64");
> +
> +static struct attribute *mlx90632_attributes[] = {
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group mlx90632_attribute_group = {
> +	.attrs = mlx90632_attributes,
> +};
> +
>  static const struct iio_chan_spec mlx90632_channels[] = {
>  	{
>  		.type = IIO_TEMP,
>  		.modified = 1,
>  		.channel2 = IIO_MOD_TEMP_AMBIENT,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  	},
>  	{
>  		.type = IIO_TEMP,
> @@ -1025,12 +1067,14 @@ static const struct iio_chan_spec mlx90632_channels[] = {
>  		.channel2 = IIO_MOD_TEMP_OBJECT,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
>  			BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) | BIT(IIO_CHAN_INFO_CALIBAMBIENT),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  	},
>  };
>  
>  static const struct iio_info mlx90632_info = {
>  	.read_raw = mlx90632_read_raw,
>  	.write_raw = mlx90632_write_raw,
> +	.attrs = &mlx90632_attribute_group,
>  };
>  
>  static int mlx90632_sleep(struct mlx90632_data *data)

