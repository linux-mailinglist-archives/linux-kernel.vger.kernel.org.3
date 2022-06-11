Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35D1547704
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 20:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiFKSGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 14:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbiFKSGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 14:06:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83CA6C0DA;
        Sat, 11 Jun 2022 11:05:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B88FE611F0;
        Sat, 11 Jun 2022 18:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA917C34116;
        Sat, 11 Jun 2022 18:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654970755;
        bh=uue+qAlB+fKCVbgW7XxZhbTbwA2rSNEC3/ILtFODKm4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mk+nYrlqy8xROW3bynx+nX0wJf4LAlGXVV3to2q0LQe9gr0vUOIAXeRHDU87naJH5
         hj2vbIMyZAmVnEOvVbjFJSvyoEC8CPCeKlgC4uisH2AfDVXPhk/i/s25I2gD8BT8YJ
         1vCQiihLuGR8HbaTC5tqaSZLNlDjpMbIKWQpide/rnanuDl8PjR+ivhHVcXMvNwbKk
         PRDgsZBaxgRiG+HcKwkEyaIxhfhvlB2jyYjgWuKwy2f8EwNIi0dVEXKq8hO87kfEMa
         cwfNdC1fCRIerRPYmtZIFpken5cj0Y9ogTPx3bbdqjcyZpxoyBF3C70/ZJDOtfgx0D
         buQSy7M7AcVoQ==
Date:   Sat, 11 Jun 2022 19:15:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     <eugen.hristev@microchip.com>, <lars@metafoo.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <ludovic.desroches@atmel.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/16] iio: adc: at91-sama5d2_adc: add support for
 temperature sensor
Message-ID: <20220611191503.63387587@jic23-huawei>
In-Reply-To: <20220609083213.1795019-14-claudiu.beznea@microchip.com>
References: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
        <20220609083213.1795019-14-claudiu.beznea@microchip.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2022 11:32:10 +0300
Claudiu Beznea <claudiu.beznea@microchip.com> wrote:

> SAMA7G5 has a temperature sensor embedded that is connected to channel 31
> of ADC. Temperature sensor provides 2 outputs: VTEMP and VBG. VTEMP is
> proportional to the absolute temperature voltage, VBG is quasi-temperature
> independent voltage. The calibration data for temperature sensor are
> retrieved from OTP memory specific to SAMA7G5. The formula to calculate
> the junction temperature is as follows:
> 
> P1 + (Vref * (Vtemp - P6 - P4 * Vbg)) / (Vbg * VTEMP_DT)
> 
> where Pi are calibration data retrieved from OTP memory.
> 
> For better resolution before reading the temperature certain settings
> for oversampling ratio, sample frequency, EMR.TRACKX, MR.TRACKTIM are
> applied. The initial settings are reapplied at the end of temperature
> reading. Current support is not integrated with trigger buffers.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

This is a complex driver, so I got a bit lost figuring out what happens
about buffered capture of this channel.  What ends up in the buffer?
Most processed channels are not useable with that mode (and hence have
a scanindex == -1 which ensures they aren't exposed as an option for
userspace to enable).

Other comments inline.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 252 ++++++++++++++++++++++++++++-
>  1 file changed, 247 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 8f8fef42de84..67ced1369754 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -26,9 +26,12 @@
>  #include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/regulator/consumer.h>
>  
> +#include <dt-bindings/iio/adc/at91-sama5d2_adc.h>
> +
>  struct at91_adc_reg_layout {
>  /* Control Register */
>  	u16				CR;
> @@ -73,10 +76,13 @@ struct at91_adc_reg_layout {
>  /* Startup Time */
>  #define	AT91_SAMA5D2_MR_STARTUP(v)	((v) << 16)
>  #define AT91_SAMA5D2_MR_STARTUP_MASK	GENMASK(19, 16)
> +/* Minimum startup time for temperature sensor */
> +#define AT91_SAMA5D2_MR_STARTUP_TS_MIN	(50)
>  /* Analog Change */
>  #define	AT91_SAMA5D2_MR_ANACH		BIT(23)
>  /* Tracking Time */
>  #define	AT91_SAMA5D2_MR_TRACKTIM(v)	((v) << 24)
> +#define	AT91_SAMA5D2_MR_TRACKTIM_TS	6
>  #define	AT91_SAMA5D2_MR_TRACKTIM_MAX	0xf
>  /* Transfer Time */
>  #define	AT91_SAMA5D2_MR_TRANSFER(v)	((v) << 28)
> @@ -149,6 +155,9 @@ struct at91_adc_reg_layout {
>  #define AT91_SAMA5D2_TRACKX_MASK		GENMASK(23, 22)
>  #define AT91_SAMA5D2_TRACKX(x)			(((x) << 22) & \
>  						 AT91_SAMA5D2_TRACKX_MASK)
> +/* TRACKX for temperature sensor. */
> +#define AT91_SAMA5D2_TRACKX_TS			(1)
> +
>  /* Extended Mode Register - Averaging on single trigger event */
>  #define AT91_SAMA5D2_EMR_ASTE(V)		((V) << 20)
>  
> @@ -164,6 +173,8 @@ struct at91_adc_reg_layout {
>  	u16				ACR;
>  /* Analog Control Register - Pen detect sensitivity mask */
>  #define AT91_SAMA5D2_ACR_PENDETSENS_MASK        GENMASK(1, 0)
> +/* Analog Control Register - Source last channel */
> +#define AT91_SAMA5D2_ACR_SRCLCH		BIT(16)
>  
>  /* Touchscreen Mode Register */
>  	u16				TSMR;
> @@ -231,6 +242,10 @@ struct at91_adc_reg_layout {
>  	u16				WPSR;
>  /* Version Register */
>  	u16				VERSION;
> +/* Temperature Sensor Mode Register */
> +	u16				TEMPMR;
> +/* Temperature Sensor Mode - Temperature sensor on */
> +#define AT91_SAMA5D2_TEMPMR_TEMPON	BIT(0)
>  };
>  
>  static const struct at91_adc_reg_layout sama5d2_layout = {
> @@ -285,6 +300,7 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
>  	.EOC_IDR =		0x38,
>  	.EOC_IMR =		0x3c,
>  	.EOC_ISR =		0x40,
> +	.TEMPMR =		0x44,
>  	.OVER =			0x4c,
>  	.EMR =			0x50,
>  	.CWR =			0x54,
> @@ -390,6 +406,23 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
>  		.datasheet_name = name,					\
>  	}
>  
> +#define AT91_SAMA5D2_CHAN_TEMP(num, name, addr)				\
> +	{								\
> +		.type = IIO_TEMP,					\
> +		.channel = num,						\
> +		.address =  addr,					\
> +		.scan_index = num,					\
> +		.scan_type = {						\
> +			.sign = 'u',					\
> +			.realbits = 16,					\
> +			.storagebits = 16,				\

So this is unusual.  Normally a processed channel isn't suitable for buffered
capture because they tend not to fit in nice compact storage.  In this case
what actually goes in the buffer?  Perhaps a comment would be useful here.

> +		},							\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),	\
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_PROCESSED) | \
> +					BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),\
> +		.datasheet_name = name,					\
> +	}
> +
>  #define at91_adc_readl(st, reg)						\
>  	readl_relaxed((st)->base + (st)->soc_info.platform->layout->reg)
>  #define at91_adc_read_chan(st, reg)					\
> @@ -413,6 +446,8 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
>   * @osr_mask:		oversampling ratio bitmask on EMR register
>   * @osr_vals:		available oversampling rates
>   * @chan_realbits:	realbits for registered channels
> + * @temp_chan:		temperature channel index
> + * @temp_sensor:	temperature sensor supported
>   */
>  struct at91_adc_platform {
>  	const struct at91_adc_reg_layout	*layout;
> @@ -427,20 +462,54 @@ struct at91_adc_platform {
>  	unsigned int				osr_mask;
>  	unsigned int				osr_vals;
>  	unsigned int				chan_realbits;
> +	unsigned int				temp_chan;
> +	bool					temp_sensor;
> +};
> +
> +/**
> + * struct at91_adc_temp_sensor_clb - at91-sama5d2 temperature sensor
> + * calibration data structure
> + * @p1: P1 calibration temperature
> + * @p4: P4 calibration voltage
> + * @p6: P6 calibration voltage
> + */
> +struct at91_adc_temp_sensor_clb {
> +	u32 p1;
> +	u32 p4;
> +	u32 p6;
> +};
> +
> +/**
> + * enum at91_adc_ts_clb_idx - calibration indexes in NVMEM buffer
> + * @AT91_ADC_TS_CLB_IDX_P1: index for P1
> + * @AT91_ADC_TS_CLB_IDX_P4: index for P4
> + * @AT91_ADC_TS_CLB_IDX_P6: index for P6
> + * @AT91_ADC_TS_CLB_IDX_MAX: max index for temperature calibration packet in OTP
> + */
> +enum at91_adc_ts_clb_idx {
> +	AT91_ADC_TS_CLB_IDX_P1 = 2,
> +	AT91_ADC_TS_CLB_IDX_P4 = 5,
> +	AT91_ADC_TS_CLB_IDX_P6 = 7,
> +	AT91_ADC_TS_CLB_IDX_MAX = 19,
>  };
>  
> +/* Temperature sensor calibration - Vtemp voltage sensitivity to temperature. */
> +#define AT91_ADC_TS_VTEMP_DT		(2080U)
> +
>  /**
>   * struct at91_adc_soc_info - at91-sama5d2 soc information struct
>   * @startup_time:	device startup time
>   * @min_sample_rate:	minimum sample rate in Hz
>   * @max_sample_rate:	maximum sample rate in Hz
>   * @platform:		pointer to the platform structure
> + * @temp_sensor_clb:	temperature sensor calibration data structure
>   */
>  struct at91_adc_soc_info {
>  	unsigned			startup_time;
>  	unsigned			min_sample_rate;
>  	unsigned			max_sample_rate;
>  	const struct at91_adc_platform	*platform;
> +	struct at91_adc_temp_sensor_clb	temp_sensor_clb;
>  };
>  
>  struct at91_adc_trigger {
> @@ -488,6 +557,20 @@ struct at91_adc_touch {
>  	struct work_struct		workq;
>  };
>  
> +/**
> + * struct at91_adc_temp - at91-sama5d2 temperature information structure
> + * @sample_period_val:	sample period value
> + * @saved_sample_rate:	saved sample rate
> + * @saved_oversampling:	saved oversampling
> + * @init:		temperature sensor initialized
> + */
> +struct at91_adc_temp {
> +	u16				sample_period_val;
> +	u16				saved_sample_rate;
> +	u16				saved_oversampling;
> +	bool				init;
> +};
> +
>  /*
>   * Buffer size requirements:
>   * No channels * bytes_per_channel(2) + timestamp bytes (8)
> @@ -515,6 +598,7 @@ struct at91_adc_state {
>  	wait_queue_head_t		wq_data_available;
>  	struct at91_adc_dma		dma_st;
>  	struct at91_adc_touch		touch_st;
> +	struct at91_adc_temp		temp_st;
>  	struct iio_dev			*indio_dev;
>  	/* Ensure naturally aligned timestamp */
>  	u16				buffer[AT91_BUFFER_MAX_HWORDS] __aligned(8);
> @@ -604,6 +688,7 @@ static const struct iio_chan_spec at91_sama7g5_adc_channels[] = {
>  	AT91_SAMA5D2_CHAN_DIFF(22, 12, 13, 0x90),
>  	AT91_SAMA5D2_CHAN_DIFF(23, 14, 15, 0x98),
>  	IIO_CHAN_SOFT_TIMESTAMP(24),
> +	AT91_SAMA5D2_CHAN_TEMP(AT91_SAMA7G5_ADC_TEMP_CHANNEL, "temp", 0xdc),
>  };
>  
>  static const struct at91_adc_platform sama5d2_platform = {
> @@ -637,10 +722,13 @@ static const struct at91_adc_platform sama7g5_platform = {
>  	.adc_channels = &at91_sama7g5_adc_channels,
>  #define AT91_SAMA7G5_SINGLE_CHAN_CNT	16
>  #define AT91_SAMA7G5_DIFF_CHAN_CNT	8
> +#define AT91_SAMA7G5_TEMP_CHAN_CNT	1
>  	.nr_channels = AT91_SAMA7G5_SINGLE_CHAN_CNT +
> -		       AT91_SAMA7G5_DIFF_CHAN_CNT,
> +		       AT91_SAMA7G5_DIFF_CHAN_CNT +
> +		       AT91_SAMA7G5_TEMP_CHAN_CNT,
>  #define AT91_SAMA7G5_MAX_CHAN_IDX	(AT91_SAMA7G5_SINGLE_CHAN_CNT + \
> -					AT91_SAMA7G5_DIFF_CHAN_CNT)
> +					AT91_SAMA7G5_DIFF_CHAN_CNT + \
> +					AT91_SAMA7G5_TEMP_CHAN_CNT)
>  	.max_channels = ARRAY_SIZE(at91_sama7g5_adc_channels),
>  	.max_index = AT91_SAMA7G5_MAX_CHAN_IDX,
>  #define AT91_SAMA7G5_HW_TRIG_CNT	3
> @@ -652,6 +740,8 @@ static const struct at91_adc_platform sama7g5_platform = {
>  		    BIT(AT91_SAMA5D2_EMR_OSR_64SAMPLES) |
>  		    BIT(AT91_SAMA5D2_EMR_OSR_256SAMPLES),
>  	.chan_realbits = 16,
> +	.temp_sensor = true,
> +	.temp_chan = AT91_SAMA7G5_ADC_TEMP_CHANNEL,
>  };
>  
>  static int at91_adc_chan_xlate(struct iio_dev *indio_dev, int chan)
> @@ -1193,7 +1283,8 @@ static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
>  			continue;
>  		/* these channel types cannot be handled by this trigger */
>  		if (chan->type == IIO_POSITIONRELATIVE ||
> -		    chan->type == IIO_PRESSURE)
> +		    chan->type == IIO_PRESSURE ||
> +		    chan->type == IIO_TEMP)
>  			continue;
>  
>  		at91_adc_cor(st, chan);
> @@ -1235,7 +1326,8 @@ static int at91_adc_buffer_postdisable(struct iio_dev *indio_dev)
>  			continue;
>  		/* these channel types are virtual, no need to do anything */
>  		if (chan->type == IIO_POSITIONRELATIVE ||
> -		    chan->type == IIO_PRESSURE)
> +		    chan->type == IIO_PRESSURE ||
> +		    chan->type == IIO_TEMP)
>  			continue;
>  
>  		at91_adc_writel(st, CHDR, BIT(chan->channel));
> @@ -1617,12 +1709,19 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
>  		return ret;
>  	}
>  
> -	/* in this case we have a voltage channel */
> +	/* in this case we have a voltage or temperature channel */
>  
>  	st->chan = chan;
>  
>  	at91_adc_cor(st, chan);
>  	at91_adc_writel(st, CHER, BIT(chan->channel));
> +	/*
> +	 * TEMPMR.TEMPON needs to update after CHER otherwise if none
> +	 * of the channels are enabled and TEMPMR.TEMPON = 1 will
> +	 * trigger DRDY interruption while preparing for temperature read.
> +	 */
> +	if (chan->type == IIO_TEMP)
> +		at91_adc_writel(st, TEMPMR, AT91_SAMA5D2_TEMPMR_TEMPON);
>  	at91_adc_eoc_ena(st, chan->channel);
>  	at91_adc_writel(st, CR, AT91_SAMA5D2_CR_START);
>  
> @@ -1642,6 +1741,8 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
>  	}
>  
>  	at91_adc_eoc_dis(st, st->chan->channel);
> +	if (chan->type == IIO_TEMP)
> +		at91_adc_writel(st, TEMPMR, 0U);
>  	at91_adc_writel(st, CHDR, BIT(chan->channel));
>  
>  	/* Needed to ACK the DRDY interruption */
> @@ -1654,6 +1755,91 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static void at91_adc_temp_sensor_configure(struct at91_adc_state *st,
> +					   bool start)
> +{
> +	u32 sample_rate, oversampling_ratio;
> +	u32 startup_time, tracktim, trackx;
> +
> +	if (start) {
> +		/*
> +		 * Configure the sensor for best accuracy: 10MHz frequency,
> +		 * oversampling rate of 256, tracktim=0xf and trackx=1.
> +		 */
> +		sample_rate = 10000000U;
> +		oversampling_ratio = AT91_OSR_256SAMPLES;
> +		startup_time = AT91_SAMA5D2_MR_STARTUP_TS_MIN;
> +		tracktim = AT91_SAMA5D2_MR_TRACKTIM_TS;
> +		trackx = AT91_SAMA5D2_TRACKX_TS;
> +
> +		st->temp_st.saved_sample_rate = st->current_sample_rate;
> +		st->temp_st.saved_oversampling = st->oversampling_ratio;
> +	} else {
> +		/* Go back to previous settings. */
> +		sample_rate = st->temp_st.saved_sample_rate;
> +		oversampling_ratio = st->temp_st.saved_oversampling;
> +		startup_time = st->soc_info.startup_time;
> +		tracktim = 0;
> +		trackx = 0;
> +	}
> +
> +	at91_adc_setup_samp_freq(st->indio_dev, sample_rate, startup_time,
> +				 tracktim);
> +	at91_adc_config_emr(st, oversampling_ratio, trackx);
> +}
> +
> +static int at91_adc_read_temp(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int *val)
> +{
> +	struct at91_adc_state *st = iio_priv(indio_dev);
> +	struct at91_adc_temp_sensor_clb *clb = &st->soc_info.temp_sensor_clb;
> +	u64 div1, div2;
> +	u32 tmp;
> +	int ret, vbg, vtemp;
> +
> +	if (!st->soc_info.platform->temp_sensor || !st->temp_st.init)
> +		return -EPERM;

You shouldn't register the channel if it's not readable.  Hence this
should never happen.

> +
> +	if (iio_buffer_enabled(indio_dev))
> +		return -EBUSY;

claim_direct - never check the buffer is enabled as it's racy - nothing
stops it being enabled immediately after you check it (only exception
is before interfaces are exposed such as _resume() where it should be safe
to check).
Which fixes the locking issue in the previous patch.  Move the
iio_device_claim_direct() and mutex_lock() to all callers and you won't
have a problem any more.


> +
> +	mutex_lock(&st->lock);
> +
> +	at91_adc_temp_sensor_configure(st, true);
> +
> +	/* Read VBG. */
> +	tmp = at91_adc_readl(st, ACR);
> +	tmp |= AT91_SAMA5D2_ACR_SRCLCH;
> +	at91_adc_writel(st, ACR, tmp);
> +	ret = at91_adc_read_info_raw(indio_dev, chan, &vbg, false);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	/* Read VTEMP. */
> +	tmp &= ~AT91_SAMA5D2_ACR_SRCLCH;
> +	at91_adc_writel(st, ACR, tmp);
> +	ret = at91_adc_read_info_raw(indio_dev, chan, &vtemp, false);
> +
> +unlock:
> +	/* Revert previous settings. */
> +	at91_adc_temp_sensor_configure(st, false);
> +	mutex_unlock(&st->lock);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Temp[milli] = p1[milli] + (vtemp * clb->p6 - clb->p4 * vbg)/
> +	 *			     (vbg * AT91_ADC_TS_VTEMP_DT)
> +	 */
> +	div1 = DIV_ROUND_CLOSEST_ULL(((u64)vtemp * clb->p6), vbg);
> +	div1 = DIV_ROUND_CLOSEST_ULL((div1 * 1000), AT91_ADC_TS_VTEMP_DT);
> +	div2 = DIV_ROUND_CLOSEST_ULL((u64)clb->p4, AT91_ADC_TS_VTEMP_DT);
> +	div2 *= 1000;
> +	*val = clb->p1 + (int)div1 - (int)div2;
> +
> +	return ret;
> +}
> +
>  static int at91_adc_read_raw(struct iio_dev *indio_dev,
>  			     struct iio_chan_spec const *chan,
>  			     int *val, int *val2, long mask)
> @@ -1671,6 +1857,11 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
>  		*val2 = chan->scan_type.realbits;
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  
> +	case IIO_CHAN_INFO_PROCESSED:
> +		if (chan->type != IIO_TEMP)
> +			return -EINVAL;
> +		return at91_adc_read_temp(indio_dev, chan, val);
> +
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		mutex_lock(&st->lock);
>  		*val = at91_adc_get_sample_freq(st);
> @@ -1987,6 +2178,55 @@ static int at91_adc_buffer_and_trigger_init(struct device *dev,
>  	return 0;
>  }
>  
> +static void at91_adc_temp_sensor_init(struct at91_adc_state *st,
> +				      struct device *dev)
> +{
> +	struct at91_adc_temp_sensor_clb *clb = &st->soc_info.temp_sensor_clb;
> +	struct nvmem_cell *temp_calib;
> +	u32 *buf;
> +	size_t len;
> +
> +	if (!st->soc_info.platform->temp_sensor)
> +		return;
> +
> +	st->temp_st.init = false;

that structure is kzalloc so this isn't really needed unless you think it's
providing 'documentation'.

> +
> +	/* Get the calibration data from NVMEM. */
> +	temp_calib = devm_nvmem_cell_get(dev, "temperature_calib");
> +	if (IS_ERR(temp_calib)) {
> +		if (PTR_ERR(temp_calib) != -ENOENT)
> +			dev_err(dev, "Failed to get temperature_calib cell!\n");
> +		return;
> +	}
> +
> +	buf = nvmem_cell_read(temp_calib, &len);
> +	if (IS_ERR(buf)) {
> +		dev_err(dev, "Failed to read calibration data!\n");
> +		return;
> +	}
> +	if (len < AT91_ADC_TS_CLB_IDX_MAX * 4) {
> +		dev_err(dev, "Invalid calibration data!\n");
> +		goto free_buf;
> +	}
> +
> +	/* Store calibration data for later use. */
> +	clb->p1 = buf[AT91_ADC_TS_CLB_IDX_P1];
> +	clb->p4 = buf[AT91_ADC_TS_CLB_IDX_P4];
> +	clb->p6 = buf[AT91_ADC_TS_CLB_IDX_P6];
> +
> +	/*
> +	 * We prepare here the conversion to milli and also add constant
> +	 * factor (5 degrees Celsius) to p1 here to avoid doing it on
> +	 * hotpath.
> +	 */
> +	clb->p1 = clb->p1 * 1000 + 5000;
> +
> +	st->temp_st.init = true;
> +
> +free_buf:
> +	kfree(buf);
> +}
> +

