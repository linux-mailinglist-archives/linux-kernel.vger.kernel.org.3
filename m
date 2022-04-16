Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19856503798
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 18:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiDPQmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 12:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiDPQmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 12:42:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D603BE0E;
        Sat, 16 Apr 2022 09:40:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87D2DB803F7;
        Sat, 16 Apr 2022 16:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E34EC385A1;
        Sat, 16 Apr 2022 16:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650127200;
        bh=117922OSzxqzIKsbzmLpfsdLb7XmsnoYiqmR/kKVuZE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LULiVjuB9q1suCPcvvFxu3X7b0UUjvH5AfNEgsSgW256mrkNICNCnsT8iU0wW1a73
         Zg4Ca2RxpgV1xzIDyXuVPDQJwBzQ+hkcpIGQTxuV0whd4Ojkg/GjrTNJ4k2p2DXmi1
         0Ll9SLPYz95q/6iHqc2/gzdzd4ByMFIkl2WE8NC1in9biQkdwUqh/F/qxRBIIw507H
         5+hwXRNcSmxqvUfsGMVpEC+dtkJK04NZJyP7KcsuvOM/vx1Z69RKN+5RA1HWzsMqzA
         /RrtZZXgbDIH2uhFbq5JJg/s82M7F3m8zhGFVaG+NoWcwL9yzmbNibmxUH4GPkNZ8e
         cYdDA0H+CjM1Q==
Date:   Sat, 16 Apr 2022 17:47:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/9] iio: accel: bma400: Add activity recognition
 support
Message-ID: <20220416174757.24346a41@jic23-huawei>
In-Reply-To: <20220411203133.19929-8-jagathjog1996@gmail.com>
References: <20220411203133.19929-1-jagathjog1996@gmail.com>
        <20220411203133.19929-8-jagathjog1996@gmail.com>
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

On Tue, 12 Apr 2022 02:01:31 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Add support for activity recognition like STILL, WALKING, RUNNING
> and these events are pushed to the userspace whenever the STEP
> interrupt occurs.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
Hi Jagath,

Other than more questions on locking and a suggestion for some
code deduplication this looks good to me.

Jonathan

> ---
>  drivers/iio/accel/bma400_core.c | 104 ++++++++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
> 
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index 37f38626a9aa..69d2caa4ed18 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -59,6 +59,12 @@ struct bma400_sample_freq {
>  	int uhz;
>  };
>  
> +enum bma400_activity {
> +	BMA400_STILL,
> +	BMA400_WALKING,
> +	BMA400_RUNNING,
> +};
> +
>  struct bma400_data {
>  	struct device *dev;
>  	struct regmap *regmap;
> @@ -72,6 +78,7 @@ struct bma400_data {
>  	struct iio_trigger *trig;
>  	int steps_enabled;
>  	bool step_event_en;
> +	bool activity_event_en;
>  	/* Correct time stamp alignment */
>  	struct {
>  		__le16 buff[3];
> @@ -175,6 +182,12 @@ static const struct iio_event_spec bma400_step_detect_event = {
>  	.mask_separate = BIT(IIO_EV_INFO_ENABLE),
>  };
>  
> +static const struct iio_event_spec bma400_activity_event = {
> +	.type = IIO_EV_TYPE_CHANGE,
> +	.dir = IIO_EV_DIR_NONE,
> +	.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE),
> +};
> +
>  #define BMA400_ACC_CHANNEL(_index, _axis) { \
>  	.type = IIO_ACCEL, \
>  	.modified = 1, \
> @@ -196,6 +209,16 @@ static const struct iio_event_spec bma400_step_detect_event = {
>  	},				\
>  }
>  
> +#define BMA400_ACTIVITY_CHANNEL(_chan2) {	\
> +	.type = IIO_ACTIVITY,			\
> +	.modified = 1,				\
> +	.channel2 = _chan2,			\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),	\
> +	.scan_index = -1, /* No buffer support */		\
> +	.event_spec = &bma400_activity_event,			\
> +	.num_event_specs = 1,					\
> +}
> +
>  static const struct iio_chan_spec bma400_channels[] = {
>  	BMA400_ACC_CHANNEL(0, X),
>  	BMA400_ACC_CHANNEL(1, Y),
> @@ -220,6 +243,9 @@ static const struct iio_chan_spec bma400_channels[] = {
>  		.event_spec = &bma400_step_detect_event,
>  		.num_event_specs = 1,
>  	},
> +	BMA400_ACTIVITY_CHANNEL(IIO_MOD_STILL),
> +	BMA400_ACTIVITY_CHANNEL(IIO_MOD_WALKING),
> +	BMA400_ACTIVITY_CHANNEL(IIO_MOD_RUNNING),
>  	IIO_CHAN_SOFT_TIMESTAMP(4),
>  };
>  
> @@ -626,6 +652,20 @@ static void bma400_power_disable(void *data_ptr)
>  			 ERR_PTR(ret));
>  }
>  
> +static enum iio_modifier bma400_act_to_mod(enum bma400_activity activity)
> +{
> +	switch (activity) {
> +	case BMA400_STILL:
> +		return IIO_MOD_STILL;
> +	case BMA400_WALKING:
> +		return IIO_MOD_WALKING;
> +	case BMA400_RUNNING:
> +		return IIO_MOD_RUNNING;
> +	default:
> +		return IIO_NO_MOD;
> +	}
> +}
> +
>  static int bma400_init(struct bma400_data *data)
>  {
>  	unsigned int val;
> @@ -725,6 +765,7 @@ static int bma400_read_raw(struct iio_dev *indio_dev,
>  	struct bma400_data *data = iio_priv(indio_dev);
>  	int ret;
>  	u8 steps_raw[3];
> +	unsigned int activity;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_PROCESSED:
> @@ -743,6 +784,23 @@ static int bma400_read_raw(struct iio_dev *indio_dev,
>  				return ret;
>  			*val = get_unaligned_le24(steps_raw);
>  			return IIO_VAL_INT;
> +		case IIO_ACTIVITY:
> +			mutex_lock(&data->mutex);
> +			ret = regmap_read(data->regmap, BMA400_STEP_STAT_REG,
> +					  &activity);

More locking in here to think about. Not clear what you are protecting here.

> +			mutex_unlock(&data->mutex);
> +			if (ret)
> +				return ret;
> +			/*
> +			 * The device does not support confidence value levels,
> +			 * so we will always have 100% for current activity and
> +			 * 0% for the others.
I was thinking ahead when I came up with confidence for these. One day someone
will implement a sensor that is honest that it isn't that sure what the activity is.
:)  When they do we'll be ready!
> +			 */
> +			if (chan->channel2 == bma400_act_to_mod(activity))
> +				*val = 100;
> +			else
> +				*val = 0;
> +			return IIO_VAL_INT;
>  		default:
>  			return -EINVAL;
>  		}
> @@ -898,6 +956,8 @@ static int bma400_read_event_config(struct iio_dev *indio_dev,
>  	switch (chan->type) {
>  	case IIO_STEPS:
>  		return data->step_event_en;
> +	case IIO_ACTIVITY:
> +		return data->activity_event_en;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -937,6 +997,32 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
>  			return ret;
>  		data->step_event_en = state;
>  		return 0;
> +	case IIO_ACTIVITY:
> +		if (!data->step_event_en) {
> +			mutex_lock(&data->mutex);
> +			ret = regmap_update_bits(data->regmap,
> +						 BMA400_INT_CONFIG1_REG,
> +						 BMA400_STEP_INT_MSK,
> +						 FIELD_PREP(BMA400_STEP_INT_MSK,
> +							    1));
> +			if (ret) {
> +				mutex_unlock(&data->mutex);
> +				return ret;
> +			}
> +			data->steps_enabled = 1;
> +
> +			ret = regmap_update_bits(data->regmap,
> +						 BMA400_INT12_MAP_REG,
> +						 BMA400_STEP_INT_MSK,
> +						 FIELD_PREP(BMA400_STEP_INT_MSK,
> +							    1));

This looks like some code that could be sensibly factored out in the earlier
patch to provide a function to call here rather than having another copy
of more or less the same code.

> +			mutex_unlock(&data->mutex);
> +			if (ret)
> +				return ret;
> +			data->step_event_en = 1;

I can understand logic of using lock to keep the internal tracking in sync
with the device, but here you are doing that outside the lock which doesn't seem
to do that.

> +		}
> +		data->activity_event_en = state;
> +		return 0;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1015,6 +1101,7 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
>  	s64 timestamp = iio_get_time_ns(indio_dev);
>  	int ret;
>  	__le16 status;
> +	unsigned int act;
>  
>  	mutex_lock(&data->mutex);
>  	ret = regmap_bulk_read(data->regmap, BMA400_INT_STAT0_REG, &status,
> @@ -1029,6 +1116,23 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
>  					      IIO_EV_DIR_NONE,
>  					      IIO_EV_TYPE_CHANGE, 0, 0, 0),
>  			       timestamp);
> +
> +		if (data->activity_event_en) {
> +			mutex_lock(&data->mutex);
> +			ret = regmap_read(data->regmap, BMA400_STEP_STAT_REG,
> +					  &act);
> +			mutex_unlock(&data->mutex);
> +			if (ret)
> +				return IRQ_NONE;
> +
> +			iio_push_event(indio_dev,
> +				       IIO_EVENT_CODE(IIO_ACTIVITY, 0,
> +						      bma400_act_to_mod(act),
> +						      IIO_EV_DIR_NONE,
> +						      IIO_EV_TYPE_CHANGE, 0,
> +						      0, 0),
> +				       timestamp);
> +		}
>  		return IRQ_HANDLED;
>  	}
>  

