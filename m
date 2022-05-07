Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C1951E86C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 18:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386031AbiEGQJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 12:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355534AbiEGQIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 12:08:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C8513DF1;
        Sat,  7 May 2022 09:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75AEA610A7;
        Sat,  7 May 2022 16:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D94C385A5;
        Sat,  7 May 2022 16:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651939495;
        bh=7gJ7HKVZI6ogIzJimDTlWi326Ku2yrwLVLrCgVSPHLI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GZvqAy5wedylbDfd/aCmncqNAvogdx8YQmX8+ji0WryyNndmSyIfig79+5VUH67ec
         rBV/hCaNqKdg/PTXDGJ4msNgRBVkOJd0ZH+dRpu8Hms0YZxzNMYKgVizDYgXs+PCjO
         xTzW7uj3aUtqXPlE6QmXt4QU5CK/lLgKpG6uE1ev8twyfKY194o+d3yvAI3cZi/BjP
         0e4KlTFvjSwv/Mwl2LMbOmBpUYhg3MXWpUY2MFMHCv/oWhPfb0kgHAT4/K6MHEyG3K
         kQjMVl+aMfS4uqYG5S3Xg79+8xQNQf0JB/g1+C7/XcXjNkQiWlfo5iLU2H62waaHxd
         UuyEnExdwGfWw==
Date:   Sat, 7 May 2022 17:13:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 08/10] iio: accel: bma400: Add support for activity
 and inactivity events
Message-ID: <20220507171323.7ccc7b24@jic23-huawei>
In-Reply-To: <20220505133021.22362-9-jagathjog1996@gmail.com>
References: <20220505133021.22362-1-jagathjog1996@gmail.com>
        <20220505133021.22362-9-jagathjog1996@gmail.com>
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

On Thu,  5 May 2022 19:00:19 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Add support for activity and inactivity events for all axis based on the
> threshold, duration and hysteresis value set from the userspace. INT1 pin
> is used to interrupt and event is pushed to userspace.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
I've applied the first 8 patches to the togreg branch of iio.git.

Most of the time it's a bad idea to introduce significant new features
in later versions of patch set as it means people mostly don't spot
that there is something new to look at.

That particular feature is also defining new and non trivial ABI.

I'll take a look at it and offer some initial comments, but to
get proper review it needs to be a new series with a clear rational
in a cover letter etc.

Jonathan

> ---
>  drivers/iio/accel/bma400.h      |  11 ++
>  drivers/iio/accel/bma400_core.c | 232 +++++++++++++++++++++++++++++++-
>  2 files changed, 242 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> index 0faa40fdbbf8..e8f802a82300 100644
> --- a/drivers/iio/accel/bma400.h
> +++ b/drivers/iio/accel/bma400.h
> @@ -94,6 +94,17 @@
>  #define BMA400_ACC_ODR_MIN_WHOLE_HZ 25
>  #define BMA400_ACC_ODR_MIN_HZ       12
>  
> +/* Generic interrupts register */
> +#define BMA400_GEN1INT_CONFIG0      0x3f
> +#define BMA400_GEN2INT_CONFIG0      0x4A
> +#define BMA400_GEN_CONFIG1_OFF      0x01
> +#define BMA400_GEN_CONFIG2_OFF      0x02
> +#define BMA400_GEN_CONFIG3_OFF      0x03
> +#define BMA400_GEN_CONFIG31_OFF     0x04
> +#define BMA400_INT_GEN1_MSK         BIT(2)
> +#define BMA400_INT_GEN2_MSK         BIT(3)
> +#define BMA400_GEN_HYST_MSK         GENMASK(1, 0)
> +
>  /*
>   * BMA400_SCALE_MIN macro value represents m/s^2 for 1 LSB before
>   * converting to micro values for +-2g range.
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index 1e4923064b63..8faff72625b3 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -87,6 +87,7 @@ struct bma400_data {
>  	int steps_enabled;
>  	bool step_event_en;
>  	bool activity_event_en;
> +	unsigned int generic_event_en;
>  	/* Correct time stamp alignment */
>  	struct {
>  		__le16 buff[3];
> @@ -94,6 +95,7 @@ struct bma400_data {
>  		s64 ts __aligned(8);
>  	} buffer __aligned(IIO_ALIGN);
>  	__le16 status;
> +	__be16 duration;
>  };
>  
>  static bool bma400_is_writable_reg(struct device *dev, unsigned int reg)
> @@ -197,6 +199,25 @@ static const struct iio_event_spec bma400_activity_event = {
>  	.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE),
>  };
>  
> +static const struct iio_event_spec bma400_accel_event[] = {
> +	{
> +		.type = IIO_EV_TYPE_MAG,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
> +				       BIT(IIO_EV_INFO_PERIOD) |
> +				       BIT(IIO_EV_INFO_HYSTERESIS) |
> +				       BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_MAG,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
> +				       BIT(IIO_EV_INFO_PERIOD) |
> +				       BIT(IIO_EV_INFO_HYSTERESIS) |
> +				       BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
>  #define BMA400_ACC_CHANNEL(_index, _axis) { \
>  	.type = IIO_ACCEL, \
>  	.modified = 1, \
> @@ -216,6 +237,8 @@ static const struct iio_event_spec bma400_activity_event = {
>  		.storagebits = 16,	\
>  		.endianness = IIO_LE,	\
>  	},				\
> +	.event_spec = bma400_accel_event,			\
> +	.num_event_specs = ARRAY_SIZE(bma400_accel_event)	\
>  }
>  
>  #define BMA400_ACTIVITY_CHANNEL(_chan2) {	\
> @@ -981,6 +1004,17 @@ static int bma400_read_event_config(struct iio_dev *indio_dev,
>  	struct bma400_data *data = iio_priv(indio_dev);
>  
>  	switch (chan->type) {
> +	case IIO_ACCEL:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			return FIELD_GET(BMA400_INT_GEN1_MSK,
> +					 data->generic_event_en);
> +		case IIO_EV_DIR_FALLING:
> +			return FIELD_GET(BMA400_INT_GEN2_MSK,
> +					 data->generic_event_en);
> +		default:
> +			return -EINVAL;
> +		}
>  	case IIO_STEPS:
>  		return data->step_event_en;
>  	case IIO_ACTIVITY:
> @@ -1008,6 +1042,65 @@ static int bma400_steps_event_enable(struct bma400_data *data, int state)
>  	return 0;
>  }
>  
> +static int bma400_activity_event_en(struct bma400_data *data,
> +				    enum iio_event_direction dir,
> +				    int state)
> +{
> +	int ret, reg, msk, value, field_value;
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		reg = BMA400_GEN1INT_CONFIG0;
> +		msk = BMA400_INT_GEN1_MSK;
> +		value = 2;
> +		set_mask_bits(&field_value, BMA400_INT_GEN1_MSK,
> +			      FIELD_PREP(BMA400_INT_GEN1_MSK, state));
> +		break;
> +	case IIO_EV_DIR_FALLING:
> +		reg = BMA400_GEN2INT_CONFIG0;
> +		msk = BMA400_INT_GEN2_MSK;
> +		value = 0;
> +		set_mask_bits(&field_value, BMA400_INT_GEN2_MSK,
> +			      FIELD_PREP(BMA400_INT_GEN2_MSK, state));
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Enabling all axis for interrupt evaluation */
> +	ret = regmap_write(data->regmap, reg, 0xF8);
> +	if (ret)
> +		return ret;
> +
> +	/* OR combination of all axis for interrupt evaluation */
> +	ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG1_OFF, value);
> +	if (ret)
> +		return ret;
> +
> +	/* Initial value to avoid interrupts while enabling*/
> +	ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG2_OFF, 0x0A);
> +	if (ret)
> +		return ret;
> +
> +	/* Initial duration value to avoid interrupts while enabling*/
> +	ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG31_OFF, 0x0F);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG, msk,
> +				 field_value);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG0_REG, msk,
> +				 field_value);
> +	if (ret)
> +		return ret;
> +
> +	set_mask_bits(&data->generic_event_en, msk, field_value);
> +	return 0;
> +}
> +
>  static int bma400_write_event_config(struct iio_dev *indio_dev,
>  				     const struct iio_chan_spec *chan,
>  				     enum iio_event_type type,
> @@ -1017,6 +1110,11 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
>  	int ret;
>  
>  	switch (chan->type) {
> +	case IIO_ACCEL:
> +		mutex_lock(&data->mutex);
> +		ret = bma400_activity_event_en(data, dir, state);
> +		mutex_unlock(&data->mutex);
> +		return ret;
>  	case IIO_STEPS:
>  		mutex_lock(&data->mutex);
>  		ret = bma400_steps_event_enable(data, state);
> @@ -1039,6 +1137,122 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int get_gen_config_reg(enum iio_event_direction dir)
> +{
> +	switch (dir) {
> +	case IIO_EV_DIR_FALLING:
> +		return BMA400_GEN2INT_CONFIG0;
> +	case IIO_EV_DIR_RISING:
> +		return BMA400_GEN1INT_CONFIG0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int bma400_read_event_value(struct iio_dev *indio_dev,
> +				   const struct iio_chan_spec *chan,
> +				   enum iio_event_type type,
> +				   enum iio_event_direction dir,
> +				   enum iio_event_info info,
> +				   int *val, int *val2)
> +{
> +	struct bma400_data *data = iio_priv(indio_dev);
> +	int ret, reg;
> +
> +	switch (chan->type) {
> +	case IIO_ACCEL:
> +		reg = get_gen_config_reg(dir);
> +		if (reg < 0)
> +			return -EINVAL;
> +
> +		*val2 = 0;
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			ret = regmap_read(data->regmap,
> +					  reg + BMA400_GEN_CONFIG2_OFF,
> +					  val);
> +			if (ret)
> +				return ret;
> +			return IIO_VAL_INT;
> +		case IIO_EV_INFO_PERIOD:
> +			mutex_lock(&data->mutex);
> +			ret = regmap_bulk_read(data->regmap,
> +					       reg + BMA400_GEN_CONFIG3_OFF,
> +					       &data->duration,
> +					       sizeof(data->duration));
> +			if (ret) {
> +				mutex_unlock(&data->mutex);
> +				return ret;
> +			}
> +			*val = be16_to_cpu(data->duration);
> +			mutex_unlock(&data->mutex);
> +			return IIO_VAL_INT;
> +		case IIO_EV_INFO_HYSTERESIS:
> +			ret = regmap_read(data->regmap, reg, val);
> +			if (ret)
> +				return ret;
> +			*val = FIELD_GET(BMA400_GEN_HYST_MSK, *val);
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int bma400_write_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int val, int val2)
> +{
> +	struct bma400_data *data = iio_priv(indio_dev);
> +	int reg, ret;
> +
> +	switch (chan->type) {
> +	case IIO_ACCEL:
> +		reg = get_gen_config_reg(dir);
> +		if (reg < 0)
> +			return -EINVAL;
> +
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			if (val < 1 || val > 255)
> +				return -EINVAL;
> +
> +			return regmap_write(data->regmap,
> +					    reg + BMA400_GEN_CONFIG2_OFF,
> +					    val);
> +		case IIO_EV_INFO_PERIOD:
> +			if (val < 1 || val > 65535)
> +				return -EINVAL;
> +
> +			mutex_lock(&data->mutex);
> +			put_unaligned_be16(val, &data->duration);
> +			ret = regmap_bulk_write(data->regmap,
> +						reg + BMA400_GEN_CONFIG3_OFF,
> +						&data->duration,
> +						sizeof(data->duration));
> +			mutex_unlock(&data->mutex);
> +			return ret;
> +		case IIO_EV_INFO_HYSTERESIS:
> +			if (val < 0 || val > 3)
> +				return -EINVAL;
> +
> +			return regmap_update_bits(data->regmap, reg,
> +						  BMA400_GEN_HYST_MSK,
> +						  FIELD_PREP(BMA400_GEN_HYST_MSK,
> +							     val));
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int bma400_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  					     bool state)
>  {
> @@ -1071,6 +1285,8 @@ static const struct iio_info bma400_info = {
>  	.write_raw_get_fmt = bma400_write_raw_get_fmt,
>  	.read_event_config = bma400_read_event_config,
>  	.write_event_config = bma400_write_event_config,
> +	.write_event_value = bma400_write_event_value,
> +	.read_event_value = bma400_read_event_value,
>  };
>  
>  static const struct iio_trigger_ops bma400_trigger_ops = {
> @@ -1119,7 +1335,7 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
>  	struct iio_dev *indio_dev = private;
>  	struct bma400_data *data = iio_priv(indio_dev);
>  	s64 timestamp = iio_get_time_ns(indio_dev);
> -	unsigned int act;
> +	unsigned int act, ev_dir = IIO_EV_DIR_NONE;
>  	int ret;
>  
>  	/* Lock to protect the data->status */
> @@ -1134,6 +1350,20 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
>  	if (ret || !data->status)
>  		goto unlock_err;
>  
> +	if (FIELD_GET(BMA400_INT_GEN1_MSK, le16_to_cpu(data->status)))
> +		ev_dir = IIO_EV_DIR_RISING;
> +
> +	if (FIELD_GET(BMA400_INT_GEN2_MSK, le16_to_cpu(data->status)))
> +		ev_dir = IIO_EV_DIR_FALLING;
> +
> +	if (ev_dir != IIO_EV_DIR_NONE) {
> +		iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> +						  IIO_MOD_X_OR_Y_OR_Z,
> +						  IIO_EV_TYPE_MAG, ev_dir),
> +			       timestamp);
> +	}
> +
>  	if (FIELD_GET(BMA400_STEP_STAT_MASK, le16_to_cpu(data->status))) {
>  		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_STEPS, 0, IIO_NO_MOD,

