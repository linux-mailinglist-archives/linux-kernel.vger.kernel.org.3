Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD93F50379E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 18:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbiDPQuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 12:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiDPQuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 12:50:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1E23EBBA;
        Sat, 16 Apr 2022 09:47:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1352260FA5;
        Sat, 16 Apr 2022 16:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E915AC385A1;
        Sat, 16 Apr 2022 16:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650127659;
        bh=I9SQ/1M0IlqjNpmio88+EWzDa36Hz8NSAa4kUa1McH8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e6a0B6zROXH6GbntRfooeLrPhB+t9AwCtQj7BMv5V/qsvOMg0XhKWL1ZPz/BySuSa
         fmYNZrF+S5wPt7XurnaN8oXd5gfTXdu6kl/KdPj75iOUbdhT3WoaqI9RVrVzSzicZN
         lfzw9D9s7kMaR6PijT3ez5CL0KoD0+cRcvlVL0N8FrLShhp926OHqGX4jxDvj2IZOG
         JHB2sJrpb/2FPPZgZM3ASF1oh91WBJQAF/IjdaZM203uSsMMQaterG+Y51PAskc/9m
         EAE4ssbYyNj5TqdsAi7DYyFmo0vQH2+/gJ1D32A5D2PQxEQ7jOW1DdSJHWp08TpaLF
         Q7yAnPofnqTYg==
Date:   Sat, 16 Apr 2022 17:55:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] iio: accel: bma400: Add support for activity and
 inactivity events
Message-ID: <20220416175537.193cfc10@jic23-huawei>
In-Reply-To: <20220411203133.19929-10-jagathjog1996@gmail.com>
References: <20220411203133.19929-1-jagathjog1996@gmail.com>
        <20220411203133.19929-10-jagathjog1996@gmail.com>
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

On Tue, 12 Apr 2022 02:01:33 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Add support for activity and inactivity events for all axis based on the
> threshold, duration and hysteresis value set from the userspace. INT1 pin
> is used to interrupt and event is pushed to userspace.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> ---
>  drivers/iio/accel/bma400.h      |  11 ++
>  drivers/iio/accel/bma400_core.c | 229 ++++++++++++++++++++++++++++++++
>  2 files changed, 240 insertions(+)
> 
> diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> index bc4641279be3..cbf8035c817e 100644
> --- a/drivers/iio/accel/bma400.h
> +++ b/drivers/iio/accel/bma400.h
> @@ -93,6 +93,17 @@
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
> index b6c79cfabaa4..226a5f63d1a6 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -79,6 +79,7 @@ struct bma400_data {
>  	int steps_enabled;
>  	bool step_event_en;
>  	bool activity_event_en;
> +	u8 generic_event_en;
>  	/* Correct time stamp alignment */
>  	struct {
>  		__le16 buff[3];
> @@ -188,6 +189,25 @@ static const struct iio_event_spec bma400_activity_event = {
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
> @@ -207,6 +227,8 @@ static const struct iio_event_spec bma400_activity_event = {
>  		.storagebits = 16,	\
>  		.endianness = IIO_LE,	\
>  	},				\
> +	.event_spec = bma400_accel_event,			\
> +	.num_event_specs = ARRAY_SIZE(bma400_accel_event)	\
>  }
>  
>  #define BMA400_ACTIVITY_CHANNEL(_chan2) {	\
> @@ -954,6 +976,17 @@ static int bma400_read_event_config(struct iio_dev *indio_dev,
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
> @@ -970,8 +1003,74 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
>  {
>  	int ret;
>  	struct bma400_data *data = iio_priv(indio_dev);
> +	int reg, msk, value, field_value;
>  
>  	switch (chan->type) {
> +	case IIO_ACCEL:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			reg = BMA400_GEN1INT_CONFIG0;
> +			msk = BMA400_INT_GEN1_MSK;
> +			value = 2;
> +			field_value = FIELD_PREP(BMA400_INT_GEN1_MSK, state);

Hopefully you can use msk in here and the compiler can tell it's constant...

> +			break;
> +		case IIO_EV_DIR_FALLING:
> +			reg = BMA400_GEN2INT_CONFIG0;
> +			msk = BMA400_INT_GEN2_MSK;
> +			value = 0;
> +			field_value = FIELD_PREP(BMA400_INT_GEN2_MSK, state);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		mutex_lock(&data->mutex);
> +		/* Enabling all axis for interrupt evaluation */
> +		ret = regmap_write(data->regmap, reg, 0xF8);
> +		if (ret) {
> +			mutex_unlock(&data->mutex);
> +			return ret;
> +		}
> +
> +		/* OR combination of all axis for interrupt evaluation */
> +		ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG1_OFF,
> +				   value);
> +		if (ret) {
> +			mutex_unlock(&data->mutex);
> +			return ret;
> +		}
> +
> +		/* Initial value to avoid interrupts while enabling*/
> +		ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG2_OFF,
> +				   0x0A);
> +		if (ret) {
> +			mutex_unlock(&data->mutex);
> +			return ret;
> +		}
> +
> +		/* Initial duration value to avoid interrupts while enabling*/
> +		ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG31_OFF,
> +				   0x0F);
> +		if (ret) {
> +			mutex_unlock(&data->mutex);
> +			return ret;
> +		}
> +
> +		ret = regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG,
> +					 msk, field_value);
> +		if (ret) {
> +			mutex_unlock(&data->mutex);
> +			return ret;
> +		}
> +
> +		ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG0_REG,
> +					 msk, field_value);
> +		mutex_unlock(&data->mutex);
> +		if (ret)
> +			return ret;

This whole stack or mutex_unlock() error handling is a good hint that you should
just factor out this case as a separate function then you can use a goto to
deal with the unlock cleanly.

> +
> +		set_mask_bits(&data->generic_event_en, msk, field_value);
> +		return 0;
>  	case IIO_STEPS:
>  		mutex_lock(&data->mutex);
>  		if (!data->steps_enabled) {
> @@ -1028,6 +1127,118 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
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
> +	int ret;
> +	u8 reg, duration[2];
> +
> +	reg = get_gen_config_reg(dir);
> +	if (reg < 0)
> +		return -EINVAL;
> +
> +	*val2 = 0;
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		mutex_lock(&data->mutex);
> +		ret = regmap_read(data->regmap, reg + BMA400_GEN_CONFIG2_OFF,
> +				  val);
> +		mutex_unlock(&data->mutex);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +	case IIO_EV_INFO_PERIOD:
> +		mutex_lock(&data->mutex);
> +		ret = regmap_bulk_read(data->regmap,
> +				       reg + BMA400_GEN_CONFIG3_OFF,
> +				       duration, sizeof(duration));
> +		mutex_unlock(&data->mutex);
> +		if (ret)
> +			return ret;
> +		*val = get_unaligned_be16(duration);

As well as dma safety question, you could just have used a __be16 for
duration then you can use be16_to_cpu() as you know it is aligned.

> +		return IIO_VAL_INT;
> +	case IIO_EV_INFO_HYSTERESIS:
> +		mutex_lock(&data->mutex);
> +		ret = regmap_read(data->regmap, reg, val);
> +		mutex_unlock(&data->mutex);
> +		if (ret)
> +			return ret;
> +		*val = FIELD_GET(BMA400_GEN_HYST_MSK, *val);
> +		return IIO_VAL_INT;
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
> +	int ret;
> +	u8 reg, duration[2];
> +
> +	reg = get_gen_config_reg(dir);
> +	if (reg < 0)
> +		return -EINVAL;
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		if (val < 1 || val > 255)
> +			return -EINVAL;
> +
> +		mutex_lock(&data->mutex);
> +		ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG2_OFF,
> +				   val);
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	case IIO_EV_INFO_PERIOD:
> +		if (val < 1 || val > 65535)
> +			return -EINVAL;
> +
> +		put_unaligned_be16(val, duration);
> +
> +		mutex_lock(&data->mutex);
> +		ret = regmap_bulk_write(data->regmap,
> +					reg + BMA400_GEN_CONFIG3_OFF,
> +					duration, sizeof(duration));

I can't remember if we are safe or not with bulk_writes but at least
in theory we might not be and should be using a dma safe buffer.

Also locking not necessary in various places in here.

> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	case IIO_EV_INFO_HYSTERESIS:
> +		if (val < 0 || val > 3)
> +			return -EINVAL;
> +
> +		mutex_lock(&data->mutex);
> +		ret = regmap_update_bits(data->regmap, reg,
> +					 BMA400_GEN_HYST_MSK,
> +					 FIELD_PREP(BMA400_GEN_HYST_MSK, val));
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

