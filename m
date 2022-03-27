Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7096E4E88F1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 18:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbiC0Qou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 12:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiC0Qoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 12:44:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4252C261C;
        Sun, 27 Mar 2022 09:43:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E44A2B80D62;
        Sun, 27 Mar 2022 16:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC17C340F0;
        Sun, 27 Mar 2022 16:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648399383;
        bh=pvinDH2/pjvL9buXH7V6IV1ZjT3Yha41AV69Dn+WGsM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DaBQ2h9fkaeYuwAbqZcibCnPRt1BY2zJEksWo8ChNpgREBmcDQR39AwZGAFwpD98H
         ZocuNpa6u3GfhoNxhMiUUiiNF9Ew7KlBkLS69ALIZGP3hIJup2l8TfUjDF8DyetDkY
         8Rmibpf3MEHMUjMsO7mWNrSCAY1wGoxO8DsXeL3egQcNeAlKa8upvbzxCl7sqEh/Hp
         VspGJ8SsiQEXa7qVLohvqubKskAgiyFT59ZDj7tkzr48u//2scWtWaV+Q9WTnYrSny
         RsHJa+tBvQpCNYVXNFH6sMGHoNYjyzWje/999ryv4rg20XbR/VZYteu0MuPDRK3Ynz
         hqXklI/jbAdHQ==
Date:   Sun, 27 Mar 2022 17:50:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: accel: bma400: Add step change event
Message-ID: <20220327175036.4b026481@jic23-huawei>
In-Reply-To: <20220326194146.15549-6-jagathjog1996@gmail.com>
References: <20220326194146.15549-1-jagathjog1996@gmail.com>
        <20220326194146.15549-6-jagathjog1996@gmail.com>
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

On Sun, 27 Mar 2022 01:11:46 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Added support for event when there is a detection of step change.
> INT1 pin is used to interrupt and event is pushed to userspace.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>

These last two patches look fine to me.  Simply having the
event enable the channel makes things simpler.

I briefly wondered if we need to care about sequences like

1) Enable event
2) Enable channel (already enabled, but perhaps this indicates separate intent)
3) Disable event.
4) Is the channel still enabled?

or the simpler case of whether we should disable the channel if the event is
disabled and it wasn't otherwise turned on.

However, I can't see a sensible way to do so. Hence I think what you have
gone with is the best we can do.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/bma400.h      |  2 +
>  drivers/iio/accel/bma400_core.c | 73 +++++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
> 
> diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> index c9b856b37021..c4ec0cf6dc00 100644
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
>  #define BMA400_STEP_INT_MSK	    BIT(0)
> +#define BMA400_STEP_STAT_MASK	    GENMASK(9, 8)
>  
>  /*
>   * Read-write configuration registers
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index ec2f9c380bda..aaa104a2698b 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -24,6 +24,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
>  #include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
> @@ -70,6 +71,7 @@ struct bma400_data {
>  	int scale;
>  	struct iio_trigger *trig;
>  	int steps_enabled;
> +	bool step_event_en;
>  	/* Correct time stamp alignment */
>  	struct {
>  		__le16 buff[3];
> @@ -167,6 +169,12 @@ static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
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
> @@ -209,6 +217,8 @@ static const struct iio_chan_spec bma400_channels[] = {
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
>  				      BIT(IIO_CHAN_INFO_ENABLE),
>  		.scan_index = -1, /* No buffer support */
> +		.event_spec = &bma400_step_detect_event,
> +		.num_event_specs = 1,
>  	},
>  	IIO_CHAN_SOFT_TIMESTAMP(4),
>  };
> @@ -878,6 +888,58 @@ static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
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
> +	switch (type) {
> +	case IIO_EV_TYPE_CHANGE:
> +		return data->step_event_en;
> +	default:
> +		return -EINVAL;
> +	}
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
> +	switch (type) {
> +	case IIO_EV_TYPE_CHANGE:
> +		mutex_lock(&data->mutex);
> +		if (!data->steps_enabled) {
> +			ret = regmap_update_bits(data->regmap,
> +						 BMA400_INT_CONFIG1_REG,
> +						 BMA400_STEP_INT_MSK,
> +						 FIELD_PREP(BMA400_STEP_INT_MSK,
> +							    1));
> +			if (ret)
> +				return ret;
> +			data->steps_enabled = 1;
> +		}
> +
> +		ret = regmap_update_bits(data->regmap,
> +					 BMA400_INT12_MAP_REG,
> +					 BMA400_STEP_INT_MSK,
> +					 FIELD_PREP(BMA400_STEP_INT_MSK,
> +						    state));
> +		mutex_unlock(&data->mutex);
> +		if (ret)
> +			return ret;
> +		data->step_event_en = state;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int bma400_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  					     bool state)
>  {
> @@ -910,6 +972,8 @@ static const struct iio_info bma400_info = {
>  	.read_avail        = bma400_read_avail,
>  	.write_raw         = bma400_write_raw,
>  	.write_raw_get_fmt = bma400_write_raw_get_fmt,
> +	.read_event_config = bma400_read_event_config,
> +	.write_event_config = bma400_write_event_config,
>  };
>  
>  static const struct iio_trigger_ops bma400_trigger_ops = {
> @@ -965,6 +1029,15 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
>  		ret = IRQ_HANDLED;
>  	}
>  
> +	if (FIELD_GET(BMA400_STEP_STAT_MASK, le16_to_cpu(status))) {
> +		iio_push_event(indio_dev,
> +			       IIO_EVENT_CODE(IIO_STEPS, 0, IIO_NO_MOD,
> +					      IIO_EV_DIR_NONE,
> +					      IIO_EV_TYPE_CHANGE, 0, 0, 0),
> +			       iio_get_time_ns(indio_dev));
> +		ret = IRQ_HANDLED;
> +	}
> +
>  	return ret;
>  }
>  

