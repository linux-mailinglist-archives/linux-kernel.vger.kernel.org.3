Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13454E1D18
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 18:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245715AbiCTRYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 13:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245698AbiCTRY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 13:24:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857D426E2;
        Sun, 20 Mar 2022 10:22:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34F77B80EE5;
        Sun, 20 Mar 2022 17:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A896C340E9;
        Sun, 20 Mar 2022 17:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647796976;
        bh=JQECpMcoOI6HhlrXeGL0n9bXm/PyRPOysYHPy2+o1mM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NMpwFlA3KwuTp7IV3o+MUowc+aMaqP6AVMPex2wGz/oY4aTG7qidcYEcuV2GzLzxt
         9KImuDFfYJfnTFXnGdTuIkc/PxC79ceY6xdwyLLNEb98QqP52zTD9ClBpUK4UX9nit
         DAkn2k/WVRap/ggaq/7D+5Fl1C/b7JOxqIs7YEaft1J5ewwdvmIxMh8BNFwenbUdnB
         ypau4CpDrWCzQYHm4Mz3FILM75HCwOJsdZbSmMxFABdoc0Ms75C28RYY2ehhGOCek6
         MM6qK0FslkSoqYlQFgUuvLNvUPdBjpBHlgEoIZwHpAda5+KtC78kfsdVk6sG0ZTPHN
         bpfSA/7Fm1nqw==
Date:   Sun, 20 Mar 2022 17:30:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/5] iio: accel: bma400: Add separate channel for
 step counter
Message-ID: <20220320173021.220ee3c6@jic23-huawei>
In-Reply-To: <20220319181023.8090-5-jagathjog1996@gmail.com>
References: <20220319181023.8090-1-jagathjog1996@gmail.com>
        <20220319181023.8090-5-jagathjog1996@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Mar 2022 23:40:22 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Added channel for step counter which can be enable or disable
> through the sysfs interface.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
hi Jagath,

Been a long time since we had a steps counter. Good to have 
support on another device.

One minor thing inline, but otherwise looks good to me.

Jonathan

> ---
>  drivers/iio/accel/bma400.h      |  1 +
>  drivers/iio/accel/bma400_core.c | 47 ++++++++++++++++++++++++++++++---
>  2 files changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> index b306a5ad513a..65bbc80cbb7f 100644
> --- a/drivers/iio/accel/bma400.h
> +++ b/drivers/iio/accel/bma400.h
> @@ -53,6 +53,7 @@
>  #define BMA400_STEP_CNT1_REG        0x16
>  #define BMA400_STEP_CNT3_REG        0x17
>  #define BMA400_STEP_STAT_REG        0x18
> +#define BMA400_STEP_INT_MSK         BIT(0)
>  
>  /*
>   * Read-write configuration registers
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index 797403c7dd85..305643e99eb5 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -68,6 +68,7 @@ struct bma400_data {
>  	int oversampling_ratio;
>  	int scale;
>  	struct iio_trigger *trig;
> +	int steps_enabled;
>  	/* Correct time stamp alignment */
>  	struct {
>  		__be16 buff[3];
> @@ -202,6 +203,13 @@ static const struct iio_chan_spec bma400_channels[] = {
>  			.endianness = IIO_LE,
>  		},
>  	},
> +	{
> +		.type = IIO_STEPS,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_ENABLE),
> +		.scan_index = -1, /* No buffer support */
> +	},
> +
>  	IIO_CHAN_SOFT_TIMESTAMP(4),
>  };
>  
> @@ -686,13 +694,28 @@ static int bma400_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct bma400_data *data = iio_priv(indio_dev);
>  	int ret;
> +	u32 steps_raw;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_PROCESSED:
> -		mutex_lock(&data->mutex);
> -		ret = bma400_get_temp_reg(data, val, val2);
> -		mutex_unlock(&data->mutex);
> -		return ret;
> +		switch (chan->type) {
> +		case IIO_STEPS:
> +			mutex_lock(&data->mutex);
> +			ret = regmap_bulk_read(data->regmap, BMA400_STEP_CNT0_REG,
> +					       &steps_raw, 3 * sizeof(u8));
> +			mutex_unlock(&data->mutex);
> +			if (ret)
> +				return ret;
> +			*val = steps_raw & 0x00FFFFFF;

No need for an endian conversion in here?  I'd also intialize steps_raw = 0 before
the bulk read then you shouldn't need to mask as you only read 3 bytes in.

> +			return IIO_VAL_INT;
> +		case IIO_TEMP:
> +			mutex_lock(&data->mutex);
> +			ret = bma400_get_temp_reg(data, val, val2);
> +			mutex_unlock(&data->mutex);
> +			return ret;
> +		default:
> +			return -EINVAL;
> +		}
>  	case IIO_CHAN_INFO_RAW:
>  		mutex_lock(&data->mutex);
>  		ret = bma400_get_accel_reg(data, chan, val);
> @@ -733,6 +756,9 @@ static int bma400_read_raw(struct iio_dev *indio_dev,
>  
>  		*val = data->oversampling_ratio;
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_ENABLE:
> +		*val = data->steps_enabled;
> +		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -798,6 +824,17 @@ static int bma400_write_raw(struct iio_dev *indio_dev,
>  		ret = bma400_set_accel_oversampling_ratio(data, val);
>  		mutex_unlock(&data->mutex);
>  		return ret;
> +	case IIO_CHAN_INFO_ENABLE:
> +		if (data->steps_enabled == val)
> +			return 0;
> +
> +		mutex_lock(&data->mutex);
> +		ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG1_REG,
> +					 BMA400_STEP_INT_MSK,
> +					 FIELD_PREP(BMA400_STEP_INT_MSK, !!val));
> +		mutex_unlock(&data->mutex);
> +		data->steps_enabled = val;
> +		return ret;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -814,6 +851,8 @@ static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_ENABLE:
> +		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
>  	}

