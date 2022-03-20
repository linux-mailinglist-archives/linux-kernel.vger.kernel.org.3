Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D694E1D27
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 18:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245713AbiCTRb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 13:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbiCTRb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 13:31:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBB727CED;
        Sun, 20 Mar 2022 10:30:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9443611DE;
        Sun, 20 Mar 2022 17:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BD7C340F3;
        Sun, 20 Mar 2022 17:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647797402;
        bh=m/vXSiOH4KdgFv3UnMrkovVusR3v9n+YqVWMGqHAVJs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b87Irg5uRnNFh2+LWyHXOtlOIWhAfE4fJU+oso5E/ajiueyFsda3qQbld9+4lUWpa
         TZRB1zu3IWTxo/j/l+0qZqZTYPq97XskmtVVvGOCEhJXRKqdNNwmq8qlDmk0uAyUyC
         HnsOui9/yE2RBW88UHs2zPImhfgZ425jYCCc7KN4HooJ+n1H8xOFrWKXUgEC/ZGipC
         qqXjs58rkBJePXHmQKwmINL/B2luITm9oG1TcLl9D1az60Y8LLKU4acNjxXhvQodOm
         0bUitNsLTv6orVZODsm03zku0JVYXr22iMsJDwYmrQ9R0Qxfy8CWswkaMXD0bWJ39E
         rXlbqB2SMCrPg==
Date:   Sun, 20 Mar 2022 17:37:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] iio: accel: bma400: Add step change event
Message-ID: <20220320173726.5a9c02bb@jic23-huawei>
In-Reply-To: <20220319181023.8090-6-jagathjog1996@gmail.com>
References: <20220319181023.8090-1-jagathjog1996@gmail.com>
        <20220319181023.8090-6-jagathjog1996@gmail.com>
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

On Sat, 19 Mar 2022 23:40:23 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Added support for event when there is a detection of single step
> or double step change.

This is new - do we have any way of saying if it was single or
double that was detected?
  
> INT1 pin is used to interrupt and event
> is pushed to userspace.

My main question in here is the interaction between the event
enable and the channel enable in the previous patch.

If the channel is enabled, the event will read as enabled but
it looks to me like the interrupt will never happen...

So I think you need to also check if the interrupt is enabled.

The other way around is fine as any IIO ABI is allowed to affect
any other so when you enable the interrupt it can also enable
the channel in general.

> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> ---
>  drivers/iio/accel/bma400.h      |  2 +
>  drivers/iio/accel/bma400_core.c | 72 +++++++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+)
> 
> diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> index 65bbc80cbb7f..c833119bb42e 100644
> --- a/drivers/iio/accel/bma400.h
> +++ b/drivers/iio/accel/bma400.h
> @@ -39,6 +39,7 @@
>  #define BMA400_INT_STAT0_REG        0x0e
>  #define BMA400_INT_STAT1_REG        0x0f
>  #define BMA400_INT_STAT2_REG        0x10
> +#define BMA400_INT12_MAP_REG	    0x23
>  
>  /* Temperature register */
>  #define BMA400_TEMP_DATA_REG        0x11
> @@ -54,6 +55,7 @@
>  #define BMA400_STEP_CNT3_REG        0x17
>  #define BMA400_STEP_STAT_REG        0x18
>  #define BMA400_STEP_INT_MSK         BIT(0)
> +#define BMA400_STEP_STAT_MASK	    GENMASK(1, 0)
>  
>  /*
>   * Read-write configuration registers
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index 305643e99eb5..79321e41df51 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -26,6 +26,7 @@
>  #include <linux/iio/trigger.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/events.h>
>  
>  #include "bma400.h"
>  
> @@ -69,6 +70,7 @@ struct bma400_data {
>  	int scale;
>  	struct iio_trigger *trig;
>  	int steps_enabled;
> +	bool step_event_en;
>  	/* Correct time stamp alignment */
>  	struct {
>  		__be16 buff[3];
> @@ -166,6 +168,12 @@ static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
>  	{ }
>  };
>  
> +static const struct iio_event_spec bma400_step_detect_event = {
> +	.type = IIO_EV_TYPE_CHANGE,
> +	.dir = IIO_EV_DIR_NONE,
> +	.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +};
> +
>  #define BMA400_ACC_CHANNEL(_index, _axis) { \
>  	.type = IIO_ACCEL, \
>  	.modified = 1, \
> @@ -208,6 +216,8 @@ static const struct iio_chan_spec bma400_channels[] = {
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
>  				      BIT(IIO_CHAN_INFO_ENABLE),
>  		.scan_index = -1, /* No buffer support */
> +		.event_spec = &bma400_step_detect_event,
> +		.num_event_specs = 1,
>  	},
>  
>  	IIO_CHAN_SOFT_TIMESTAMP(4),
> @@ -858,6 +868,59 @@ static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int bma400_read_event_config(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir)
> +{
> +	struct bma400_data *data = iio_priv(indio_dev);
> +
> +	switch (chan->type) {
> +	case IIO_STEPS:
> +		switch (type) {
> +		case IIO_EV_TYPE_CHANGE:
> +			return data->steps_enabled;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int bma400_write_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir, int state)
> +{
> +	int ret;
> +	struct bma400_data *data = iio_priv(indio_dev);
> +
> +	switch (chan->type) {
> +	case IIO_STEPS:
> +		switch (type) {
> +		case IIO_EV_TYPE_CHANGE:
> +			mutex_lock(&data->mutex);
> +			ret = regmap_update_bits(data->regmap,
> +						 BMA400_INT12_MAP_REG,
> +						 BMA400_STEP_INT_MSK,
> +						 FIELD_PREP(BMA400_STEP_INT_MSK,
> +							    state));
> +			mutex_unlock(&data->mutex);
> +			if (ret)
> +				return ret;
> +			data->steps_enabled = state;

How does this interact with the use in the previous patch?

> +			return 0;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
>  static int bma400_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  					     bool state)
>  {
> @@ -890,6 +953,8 @@ static const struct iio_info bma400_info = {
>  	.read_avail        = bma400_read_avail,
>  	.write_raw         = bma400_write_raw,
>  	.write_raw_get_fmt = bma400_write_raw_get_fmt,
> +	.read_event_config = bma400_read_event_config,
> +	.write_event_config = bma400_write_event_config,
>  };
>  
>  static const struct iio_trigger_ops bma400_trigger_ops = {
> @@ -945,6 +1010,13 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
>  	if (status & BMA400_INT_DRDY_MSK)
>  		iio_trigger_poll_chained(data->trig);
>  
> +	if (status & (BMA400_STEP_STAT_MASK << 8)) {

FIELD_GET() would be cleaner

> +		iio_push_event(indio_dev,
> +			       IIO_EVENT_CODE(IIO_STEPS, 0, IIO_NO_MOD,
> +					      IIO_EV_DIR_NONE,
> +					      IIO_EV_TYPE_CHANGE, 0, 0, 0),
> +			       iio_get_time_ns(indio_dev));
> +		}
>  out:
>  	return IRQ_HANDLED;
>  }

