Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09C6488A56
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 16:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbiAIPyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 10:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiAIPyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 10:54:22 -0500
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A899C06173F;
        Sun,  9 Jan 2022 07:54:22 -0800 (PST)
Received: from [81.101.6.87] (port=47168 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1n6aWQ-0007F5-GJ; Sun, 09 Jan 2022 15:54:18 +0000
Date:   Sun, 9 Jan 2022 16:00:09 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: adc: tsc2046: add .read_raw support
Message-ID: <20220109155956.003167f1@jic23-huawei>
In-Reply-To: <20220107093527.3046331-1-o.rempel@pengutronix.de>
References: <20220107093527.3046331-1-o.rempel@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Jan 2022 10:35:27 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Add read_raw() support to make use of iio_hwmon and other iio clients.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Hi Oleksij

Main questions in here are around settling time and the interface used for that.

> ---
>  drivers/iio/adc/ti-tsc2046.c | 114 ++++++++++++++++++++++++++++++++---
>  1 file changed, 106 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
> index 8126084616e6..55787d18e2cd 100644
> --- a/drivers/iio/adc/ti-tsc2046.c
> +++ b/drivers/iio/adc/ti-tsc2046.c
> @@ -82,6 +82,7 @@
>  #define TI_TSC2046_DATA_12BIT			GENMASK(14, 3)
>  
>  #define TI_TSC2046_MAX_CHAN			8
> +#define TI_TSC2046_INT_VREF			2500
>  
>  /* Represents a HW sample */
>  struct tsc2046_adc_atom {
> @@ -178,6 +179,11 @@ struct tsc2046_adc_priv {
>  	.type = IIO_VOLTAGE,					\
>  	.indexed = 1,						\
>  	.channel = index,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |	\
> +			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT) |	\
> +			BIT(IIO_CHAN_INFO_DEBOUNCE_TIME),	\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
>  	.datasheet_name = "#name",				\
>  	.scan_index = index,					\
>  	.scan_type = {						\
> @@ -241,6 +247,14 @@ static u8 tsc2046_adc_get_cmd(struct tsc2046_adc_priv *priv, int ch_idx,
>  	else
>  		pd = 0;
>  
> +	switch (ch_idx) {
> +	case TI_TSC2046_ADDR_TEMP1:
> +	case TI_TSC2046_ADDR_AUX:
> +	case TI_TSC2046_ADDR_VBAT:
> +	case TI_TSC2046_ADDR_TEMP0:
> +		pd |= TI_TSC2046_SER | TI_TSC2046_PD1_VREF_ON;
> +	}
> +
>  	return TI_TSC2046_START | FIELD_PREP(TI_TSC2046_ADDR, ch_idx) | pd;
>  }
>  
> @@ -252,16 +266,47 @@ static u16 tsc2046_adc_get_value(struct tsc2046_adc_atom *buf)
>  static int tsc2046_adc_read_one(struct tsc2046_adc_priv *priv, int ch_idx,
>  				u32 *effective_speed_hz)
>  {
> +	struct tsc2046_adc_ch_cfg *ch = &priv->ch_cfg[ch_idx];
> +	struct tsc2046_adc_atom *rx_buf, *tx_buf;
> +	unsigned int val, val_normalized = 0;
> +	int ret, i, count_skip = 0, max_count;
>  	struct spi_transfer xfer;
>  	struct spi_message msg;
> -	int ret;
> +	u8 cmd;
> +
> +	if (!effective_speed_hz) {
> +		count_skip = tsc2046_adc_time_to_count(priv, ch->settling_time_us);
> +		max_count = count_skip + ch->oversampling_ratio;
> +	} else {
> +		max_count = 1;
> +	}
> +
> +	tx_buf = kcalloc(max_count, sizeof(*tx_buf), GFP_KERNEL);
> +	if (!tx_buf)
> +		return -ENOMEM;
> +
> +	rx_buf = kcalloc(max_count, sizeof(*rx_buf), GFP_KERNEL);
> +	if (!rx_buf) {
> +		ret = -ENOMEM;
> +		goto free_tx;
> +	}

I guess these are fine to do everytime because you expect this to be used in
paths which aren't called at a particularly high frequency?

These buffers could get rather large so maybe you need a cap on settling time?


> +
> +	/*
> +	 * Do not enable automatic power down on working samples. Otherwise the
> +	 * plates will never be completely charged.
> +	 */
> +	cmd = tsc2046_adc_get_cmd(priv, ch_idx, true);
> +
> +	for (i = 0; i < max_count - 1; i++)
> +		tx_buf[i].cmd = cmd;
> +
> +	/* automatically power down on last sample */
> +	tx_buf[i].cmd = tsc2046_adc_get_cmd(priv, ch_idx, false);
>  
>  	memset(&xfer, 0, sizeof(xfer));
> -	priv->tx_one->cmd = tsc2046_adc_get_cmd(priv, ch_idx, false);
> -	priv->tx_one->data = 0;
> -	xfer.tx_buf = priv->tx_one;
> -	xfer.rx_buf = priv->rx_one;

Are these used for anything else?  If not probably need to drop them and
their allocation.

> -	xfer.len = sizeof(*priv->tx_one);
> +	xfer.tx_buf = tx_buf;
> +	xfer.rx_buf = rx_buf;
> +	xfer.len = sizeof(*tx_buf) * max_count;

This could be very big and more than possible some spi controllers will fail
it (or does the SPI core handle splitting very large transfers?)  Maybe a loop
is needed with smaller fixed size transfers?

>  	spi_message_init_with_transfers(&msg, &xfer, 1);
>  
>  	/*
> @@ -272,13 +317,25 @@ static int tsc2046_adc_read_one(struct tsc2046_adc_priv *priv, int ch_idx,
>  	if (ret) {
>  		dev_err_ratelimited(&priv->spi->dev, "SPI transfer failed %pe\n",
>  				    ERR_PTR(ret));
> -		return ret;
> +		goto free_bufs;
>  	}
>  
>  	if (effective_speed_hz)
>  		*effective_speed_hz = xfer.effective_speed_hz;
>  
> -	return tsc2046_adc_get_value(priv->rx_one);
> +	for (i = 0; i < max_count - count_skip; i++) {
> +		val = tsc2046_adc_get_value(&rx_buf[count_skip + i]);
> +		val_normalized += val;
> +	}
> +
> +	ret = DIV_ROUND_UP(val_normalized, max_count - count_skip);
> +
> +free_bufs:
> +	kfree(rx_buf);
> +free_tx:
> +	kfree(tx_buf);
> +
> +	return ret;
>  }
>  
>  static size_t tsc2046_adc_group_set_layout(struct tsc2046_adc_priv *priv,
> @@ -385,6 +442,46 @@ static irqreturn_t tsc2046_adc_trigger_handler(int irq, void *p)
>  	return IRQ_HANDLED;
>  }
>  
> +static int tsc2046_adc_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long m)
> +{
> +	struct tsc2046_adc_priv *priv = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = tsc2046_adc_read_one(priv, chan->channel, NULL);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		/*
> +		 * Note: the TSC2046 has internal voltage divider on the VBAT
> +		 * line. This divider can be influenced by external divider.
> +		 * So, it is better to use external voltage-divider.
> +		 */
> +		*val = TI_TSC2046_INT_VREF;
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*val = priv->ch_cfg[chan->channel].oversampling_ratio;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_DEBOUNCE_COUNT:

These are unusual. I think they've only been used for the more literal bounce suppression
of a human step counting algorithm.

I'd probably not expect to see the both even if we decide this is applicable.

> +		*val = tsc2046_adc_time_to_count(priv,
> +				priv->ch_cfg[chan->channel].settling_time_us);

Setting time is often about external circuitry so it's a bit unusual to expose
it to userspace rather than making it a device tree property and just making
sure the driver doesn't provide a reading until appropriate debounce has passed.
Here is coming from DT anyway, so what benefit do these two read only channel
properties provide?

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_DEBOUNCE_TIME:
> +		*val = priv->ch_cfg[chan->channel].settling_time_us;
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static int tsc2046_adc_update_scan_mode(struct iio_dev *indio_dev,
>  					const unsigned long *active_scan_mask)
>  {
> @@ -415,6 +512,7 @@ static int tsc2046_adc_update_scan_mode(struct iio_dev *indio_dev,
>  }
>  
>  static const struct iio_info tsc2046_adc_info = {
> +	.read_raw	  = tsc2046_adc_read_raw,
>  	.update_scan_mode = tsc2046_adc_update_scan_mode,
>  };
>  

