Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E6250378A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 18:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiDPQf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 12:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiDPQfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 12:35:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE5D3B2B1;
        Sat, 16 Apr 2022 09:33:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF41460DCA;
        Sat, 16 Apr 2022 16:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3D8C385A3;
        Sat, 16 Apr 2022 16:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650126801;
        bh=yh2F/q93aCsWp0FLnBhPO/VFXr1ot352TPPIXtctmdc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G9ONQqSpSIO/WWvRN8m/btnSFTrlMN/cx25ZBsAZLrth8eBKU3w2C/Cg0hPVib3ki
         mWaUCnKXviAbKIbC5rWw7oMtkR1WK/eRp56/8iMIjaBs68RDEMHWzP8t88arwM33SR
         xsISRC3EUKBI4QMgRaYcPl0Ks/eAfkwZhXX7ehCEuGdSHjzJTtEbYGSRyiyD1+/d12
         oL5MNWo74yiuMCg95MwT6mGOqNKCeU1GZj0UsvVOlvArTG9Diw3gkxsq4hO8lZOo8f
         SlHAnZUcHeW6yoAu714FFukJ9PtZsU/0/AR7UJJUx55jy5TL0y9mmhmE5yRBjYF+oy
         K2/bAcM+tS6FA==
Date:   Sat, 16 Apr 2022 17:41:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/9] iio: accel: bma400: Add separate channel for
 step counter
Message-ID: <20220416174118.13f787be@jic23-huawei>
In-Reply-To: <20220411203133.19929-6-jagathjog1996@gmail.com>
References: <20220411203133.19929-1-jagathjog1996@gmail.com>
        <20220411203133.19929-6-jagathjog1996@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Tue, 12 Apr 2022 02:01:29 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Added channel for step counter which can be enable or disable
> through the sysfs interface.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> ---
>  drivers/iio/accel/bma400.h      |  1 +
>  drivers/iio/accel/bma400_core.c | 48 ++++++++++++++++++++++++++++++---
>  2 files changed, 45 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> index a7482a66b36b..52f9ea95de81 100644
> --- a/drivers/iio/accel/bma400.h
> +++ b/drivers/iio/accel/bma400.h
> @@ -53,6 +53,7 @@
>  #define BMA400_STEP_CNT1_REG        0x16
>  #define BMA400_STEP_CNT3_REG        0x17
>  #define BMA400_STEP_STAT_REG        0x18
> +#define BMA400_STEP_INT_MSK	    BIT(0)
>  
>  /*
>   * Read-write configuration registers
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index b7b2b67aef31..c8f147163d3c 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -20,6 +20,8 @@
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  
> +#include <asm/unaligned.h>
> +
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/trigger.h>
> @@ -67,6 +69,7 @@ struct bma400_data {
>  	int oversampling_ratio;
>  	int scale;
>  	struct iio_trigger *trig;
> +	int steps_enabled;
>  	/* Correct time stamp alignment */
>  	struct {
>  		__le16 buff[3];
> @@ -201,6 +204,12 @@ static const struct iio_chan_spec bma400_channels[] = {
>  			.endianness = IIO_LE,
>  		},
>  	},
> +	{
> +		.type = IIO_STEPS,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_ENABLE),
> +		.scan_index = -1, /* No buffer support */
> +	},
>  	IIO_CHAN_SOFT_TIMESTAMP(4),
>  };
>  
> @@ -705,13 +714,28 @@ static int bma400_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct bma400_data *data = iio_priv(indio_dev);
>  	int ret;
> +	u8 steps_raw[3];
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_PROCESSED:
> -		mutex_lock(&data->mutex);
> -		ret = bma400_get_temp_reg(data, val, val2);
> -		mutex_unlock(&data->mutex);
> -		return ret;
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			mutex_lock(&data->mutex);
> +			ret = bma400_get_temp_reg(data, val, val2);
> +			mutex_unlock(&data->mutex);
> +			return ret;
> +		case IIO_STEPS:
> +			mutex_lock(&data->mutex);
> +			ret = regmap_bulk_read(data->regmap, BMA400_STEP_CNT0_REG,
> +					       &steps_raw, sizeof(steps_raw));

Bulk read to a non DMA safe buffer. Similar fix to before needed.
Or given this is a slow path, just use a local kmalloc() for the buffer.

The reality is you are probably fine today without such care, but last
time we discussed this the conclusion was that it would be a perfectly
valid optimisation in regmap to return to requiring DMA safe buffers
for bulk accesses.

> +			mutex_unlock(&data->mutex);
> +			if (ret)
> +				return ret;
> +			*val = get_unaligned_le24(steps_raw);
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
>  	case IIO_CHAN_INFO_RAW:
>  		mutex_lock(&data->mutex);
>  		ret = bma400_get_accel_reg(data, chan, val);
> @@ -752,6 +776,9 @@ static int bma400_read_raw(struct iio_dev *indio_dev,
>  
>  		*val = data->oversampling_ratio;
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_ENABLE:
> +		*val = data->steps_enabled;
> +		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -817,6 +844,17 @@ static int bma400_write_raw(struct iio_dev *indio_dev,
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

Why the lock for this one?

> +		mutex_unlock(&data->mutex);
> +		data->steps_enabled = val;
> +		return ret;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -833,6 +871,8 @@ static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_ENABLE:
> +		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
>  	}

