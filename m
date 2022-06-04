Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB2253D74D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 16:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236990AbiFDOxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 10:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiFDOw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 10:52:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4695127FC1;
        Sat,  4 Jun 2022 07:52:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B5A6ACE08CF;
        Sat,  4 Jun 2022 14:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9984AC385B8;
        Sat,  4 Jun 2022 14:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654354370;
        bh=xdUGhdt89c8Ya1jDN1HyyDvJBUGmQrVdTs+XLzvctis=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Oy8Gt2shuIX7SVTdz+N0W2TPer2nBin1x2lhEWQgkzqC3slJ/lBDtWZINnIrN1BlO
         AkLu4KwGZ9oJdMtD+FlgYeZJ+lp0evL1t2hvyk8TkRZGzf9ToX0olAGbvg7RseIiTa
         5eYpd97RNARfDDn/wMUfsbiLIIdLrFvqzavvaTFpEiReMThFtTAe7+ZPGOR2fwSqU0
         LeayOar2BevWV06HdjvPZTl9ofTkE3i0Fqb0Il0JRJ8qdAvgaBi3NM/ntSaM1lEZU/
         dyXcmCTb2J1bVTlLIbf+/WRoPjEvUktD6flKMsSV+8owWzkWeoMaVgUwsOe4kXGriE
         CxDA6YdCN17VA==
Date:   Sat, 4 Jun 2022 16:01:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] iio: accel: bma400: Add support for single and double
 tap events
Message-ID: <20220604160153.504e96ae@jic23-huawei>
In-Reply-To: <20220529040153.4878-3-jagathjog1996@gmail.com>
References: <20220529040153.4878-1-jagathjog1996@gmail.com>
        <20220529040153.4878-3-jagathjog1996@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Sun, 29 May 2022 09:31:53 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Add support for single and double tap events based on the tap threshold
> value and minimum quite time value between the taps. INT1 pin is used to
> interrupt and event is pushed to userspace.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>

Hi Jagath,

A few comments inline.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/bma400.h      |  11 ++
>  drivers/iio/accel/bma400_core.c | 186 ++++++++++++++++++++++++++++++--
>  2 files changed, 188 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> index e8f802a82300..7331474433fa 100644
> --- a/drivers/iio/accel/bma400.h
> +++ b/drivers/iio/accel/bma400.h
> @@ -40,6 +40,7 @@
>  #define BMA400_INT_STAT1_REG        0x0f
>  #define BMA400_INT_STAT2_REG        0x10
>  #define BMA400_INT12_MAP_REG        0x23
> +#define BMA400_INT_ENG_OVRUN_MSK    BIT(4)
>  
>  /* Temperature register */
>  #define BMA400_TEMP_DATA_REG        0x11
> @@ -105,6 +106,16 @@
>  #define BMA400_INT_GEN2_MSK         BIT(3)
>  #define BMA400_GEN_HYST_MSK         GENMASK(1, 0)
>  
> +/* TAP config registers */
> +#define BMA400_TAP_CONFIG           0x57
> +#define BMA400_TAP_CONFIG1          0x58
> +#define BMA400_S_TAP_MSK            BIT(2)
> +#define BMA400_D_TAP_MSK            BIT(3)
> +#define BMA400_INT_S_TAP_MSK        BIT(10)
> +#define BMA400_INT_D_TAP_MSK        BIT(11)
> +#define BMA400_TAP_SEN_MSK          GENMASK(2, 0)
> +#define BMA400_TAP_QUITE_MSK        GENMASK(3, 2)
> +
>  /*
>   * BMA400_SCALE_MIN macro value represents m/s^2 for 1 LSB before
>   * converting to micro values for +-2g range.
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index 517920400df1..2385883707f2 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -88,6 +88,7 @@ struct bma400_data {
>  	bool step_event_en;
>  	bool activity_event_en;
>  	unsigned int generic_event_en;
> +	unsigned int tap_event_en;
>  	/* Correct time stamp alignment */
>  	struct {
>  		__le16 buff[3];
> @@ -216,6 +217,19 @@ static const struct iio_event_spec bma400_accel_event[] = {
>  				       BIT(IIO_EV_INFO_HYSTERESIS) |
>  				       BIT(IIO_EV_INFO_ENABLE),
>  	},
> +	{
> +		.type = IIO_EV_TYPE_GESTURE,
> +		.dir = IIO_EV_DIR_SINGLETAP,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
> +				       BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_GESTURE,
> +		.dir = IIO_EV_DIR_DOUBLETAP,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
> +				       BIT(IIO_EV_INFO_PERIOD) |

Feels like period isn't well defined for this case.  So probably needs a specific
ABI entry and period might not be best choice...  However, period has no logical
other meaning in this case (what does 'amount of time a double tap has been true for before
event mean?') so I think it is fine to use it, as long as ABI docs exist to say what it's
meaning is for this case.

> +				       BIT(IIO_EV_INFO_ENABLE),
> +	},
>  };
>  
>  #define BMA400_ACC_CHANNEL(_index, _axis) { \
> @@ -407,6 +421,14 @@ static int bma400_set_accel_output_data_rate(struct bma400_data *data,
>  	unsigned int val;
>  	int ret;
>  
> +	/*
> +	 * No need to change ODR when tap event is enabled because

Do not change ODR...


> +	 * tap interrupt is operating with the data rate of 200Hz.
> +	 * See datasheet page 124.
> +	 */
> +	if (data->tap_event_en)
> +		return -EBUSY;
> +
>  	if (hz >= BMA400_ACC_ODR_MIN_WHOLE_HZ) {
>  		if (uhz || hz > BMA400_ACC_ODR_MAX_HZ)
>  			return -EINVAL;
> @@ -1012,6 +1034,10 @@ static int bma400_read_event_config(struct iio_dev *indio_dev,
>  		case IIO_EV_DIR_FALLING:
>  			return FIELD_GET(BMA400_INT_GEN2_MSK,
>  					 data->generic_event_en);
> +		case IIO_EV_DIR_SINGLETAP:
> +			return FIELD_GET(BMA400_S_TAP_MSK, data->tap_event_en);
> +		case IIO_EV_DIR_DOUBLETAP:
> +			return FIELD_GET(BMA400_D_TAP_MSK, data->tap_event_en);
>  		default:
>  			return -EINVAL;
>  		}
> @@ -1101,6 +1127,74 @@ static int bma400_activity_event_en(struct bma400_data *data,
>  	return 0;
>  }
>  
> +static int bma400_tap_event_enable(struct bma400_data *data,
> +				   enum iio_event_direction dir, int state)
> +{
> +	int ret;
> +	unsigned int mask, field_value;
> +
> +	if (data->power_mode == POWER_MODE_SLEEP)
> +		return -EBUSY;

There are existing examples of this in driver, but I can't immediately
see how we end up in sleep mode.  Perhaps a comment on why this might happen?

> +
> +	/*
> +	 * acc_filt1 is the data source for the tap interrupt and it is
> +	 * operating on an input data rate of 200Hz.
> +	 */
> +	if (!data->tap_event_en) {

Feels like checking the wrong thing.  If we need 200Hz, check if the
data rate is at 200Hz rather than if the tap_event is not enabled.
Obviously same result, but one seems more obvious.

Also if bma400_set_accel_output_data_rate() is effectively a noop when
the data rate is unchanged (and it should be with regmap caching) then
maybe just call it unconditionally?

This might be a nasty surprise for other users though - so if buffered
output is in use, maybe just don't allow the rate change, even if
that means not enabling tap detection.

> +		ret = bma400_set_accel_output_data_rate(data, 200, 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_update_bits(data->regmap, BMA400_INT12_MAP_REG,
> +				 BMA400_S_TAP_MSK,
> +				 FIELD_PREP(BMA400_S_TAP_MSK, state));
> +	if (ret)
> +		return ret;
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_SINGLETAP:
> +		mask = BMA400_S_TAP_MSK;
> +		set_mask_bits(&field_value, BMA400_S_TAP_MSK,
> +			      FIELD_PREP(BMA400_S_TAP_MSK, state));
> +		break;
> +	case IIO_EV_DIR_DOUBLETAP:
> +		mask = BMA400_D_TAP_MSK;
> +		set_mask_bits(&field_value, BMA400_D_TAP_MSK,
> +			      FIELD_PREP(BMA400_D_TAP_MSK, state));
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG1_REG, mask,
> +				 field_value);
> +	if (ret)
> +		return ret;
> +
> +	set_mask_bits(&data->tap_event_en, mask, field_value);

blank line here

> +	return 0;
> +}
> +
> +static int bma400_disable_adv_interrupt(struct bma400_data *data)
> +{
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, BMA400_INT_CONFIG0_REG, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, BMA400_INT_CONFIG1_REG, 0);
> +	if (ret)
> +		return ret;
> +
> +	data->tap_event_en = 0;
> +	data->generic_event_en = 0;
> +	data->step_event_en = 0;
> +	data->activity_event_en = 0;

blank line here

> +	return 0;
> +}
> +
>  static int bma400_write_event_config(struct iio_dev *indio_dev,
>  				     const struct iio_chan_spec *chan,
>  				     enum iio_event_type type,
> @@ -1111,10 +1205,20 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
>  
>  	switch (chan->type) {
>  	case IIO_ACCEL:
> -		mutex_lock(&data->mutex);
> -		ret = bma400_activity_event_en(data, dir, state);
> -		mutex_unlock(&data->mutex);
> -		return ret;
> +		switch (type) {
> +		case IIO_EV_TYPE_MAG:
> +			mutex_lock(&data->mutex);
> +			ret = bma400_activity_event_en(data, dir, state);
> +			mutex_unlock(&data->mutex);
> +			return ret;
> +		case IIO_EV_TYPE_GESTURE:
> +			mutex_lock(&data->mutex);
> +			ret = bma400_tap_event_enable(data, dir, state);

Given existing naming event_en would seem more consistent.

> +			mutex_unlock(&data->mutex);
> +			return ret;
> +		default:
> +			return -EINVAL;
> +		}
>  	case IIO_STEPS:
>  		mutex_lock(&data->mutex);
>  		ret = bma400_steps_event_enable(data, state);
> @@ -1159,8 +1263,8 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
>  	struct bma400_data *data = iio_priv(indio_dev);
>  	int ret, reg;
>  
> -	switch (chan->type) {
> -	case IIO_ACCEL:
> +	switch (type) {
> +	case IIO_EV_TYPE_MAG:
>  		reg = get_gen_config_reg(dir);
>  		if (reg < 0)
>  			return -EINVAL;
> @@ -1196,6 +1300,25 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_EV_TYPE_GESTURE:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			ret = regmap_read(data->regmap,
> +					  BMA400_TAP_CONFIG, val);

Line wrap looks a bit premature - BMA400_TAP_CONFIG can fit on previous line.

> +			if (ret)
> +				return ret;
> +			*val = FIELD_GET(BMA400_TAP_SEN_MSK, *val);
> +			return IIO_VAL_INT;
> +		case IIO_EV_INFO_PERIOD:
> +			ret = regmap_read(data->regmap,
> +					  BMA400_TAP_CONFIG1, val);
> +			if (ret)
> +				return ret;
> +			*val = FIELD_GET(BMA400_TAP_QUITE_MSK, *val);
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1211,8 +1334,8 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
>  	struct bma400_data *data = iio_priv(indio_dev);
>  	int reg, ret;
>  
> -	switch (chan->type) {
> -	case IIO_ACCEL:
> +	switch (type) {
> +	case IIO_EV_TYPE_MAG:
>  		reg = get_gen_config_reg(dir);
>  		if (reg < 0)
>  			return -EINVAL;
> @@ -1228,7 +1351,6 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
>  		case IIO_EV_INFO_PERIOD:
>  			if (val < 1 || val > 65535)
>  				return -EINVAL;
> -
>  			mutex_lock(&data->mutex);
>  			put_unaligned_be16(val, &data->duration);
>  			ret = regmap_bulk_write(data->regmap,
> @@ -1248,6 +1370,30 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_EV_TYPE_GESTURE:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			if (val < 0 || val > 7)

Add an _avail for the event control perhaps?
I think we never brought those into the core code, so you'll have to do
it manually by registering the additional event attr.

There are some examples in tree such as light/tsl2591

> +				return -EINVAL;
> +
> +			return regmap_update_bits(data->regmap,
> +						  BMA400_TAP_CONFIG,
> +						  BMA400_TAP_SEN_MSK,
> +						  FIELD_PREP(BMA400_TAP_SEN_MSK,
> +							     val));
> +
> +		case IIO_EV_INFO_PERIOD:
> +			if (val < 0 || val > 3)
> +				return -EINVAL;
> +
> +			return regmap_update_bits(data->regmap,
> +						  BMA400_TAP_CONFIG1,
> +						  BMA400_TAP_QUITE_MSK,
> +						  FIELD_PREP(BMA400_TAP_QUITE_MSK,
> +							     val));
> +		default:
> +			return -EINVAL;
> +		}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1350,6 +1496,28 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
>  	if (ret || !data->status)
>  		goto unlock_err;
>  
> +	/* Disable all advance interrupts if interrupt engine overrun occurs */

Add a reference, or more detail on why this is the correct action if we get
an engine overrun.

> +	if (FIELD_GET(BMA400_INT_ENG_OVRUN_MSK, le16_to_cpu(data->status))) {
> +		bma400_disable_adv_interrupt(data);
> +		dev_err(data->dev, "Interrupt engine overrun\n");
> +		goto unlock_err;
> +	}
> +
> +	if (FIELD_GET(BMA400_INT_S_TAP_MSK, le16_to_cpu(data->status)))
> +		ev_dir = IIO_EV_DIR_SINGLETAP;
> +
> +	if (FIELD_GET(BMA400_INT_D_TAP_MSK, le16_to_cpu(data->status)))

If both can occur, send two events. If not, else if

> +		ev_dir = IIO_EV_DIR_DOUBLETAP;
> +
> +	if (ev_dir != IIO_EV_DIR_NONE) {
> +		iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> +						  IIO_MOD_X_OR_Y_OR_Z,
> +						  IIO_EV_TYPE_GESTURE, ev_dir),
> +			       timestamp);
> +	}
> +
> +	ev_dir = IIO_EV_DIR_NONE;
>  	if (FIELD_GET(BMA400_INT_GEN1_MSK, le16_to_cpu(data->status)))
>  		ev_dir = IIO_EV_DIR_RISING;
>  

