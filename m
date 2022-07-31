Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7336585FE8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 18:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbiGaQlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 12:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237175AbiGaQlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:41:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E9860EE;
        Sun, 31 Jul 2022 09:41:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CE5CB80D18;
        Sun, 31 Jul 2022 16:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFA0C433D6;
        Sun, 31 Jul 2022 16:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659285670;
        bh=jVIikIEAbW8a0Ip4W9QaUNGqtqgAj6jrVEjicyzVQQU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c04z/5s2oZyIXF/fqq/7T7G7k+BJIz0nBsuR6JdXLStYTxHReDdY4AhZQy7gK+0dP
         hMPRmAanpTE6HDgvf9L3e8osyu25Y/3NcfHN2qMT6TxcQaZM4icfJTj4vha9TtNwDA
         dnLzxtlbVXtRgK6lcybVI4ycssjl76H3upIsd71SSg1jYiDPgwtPp2N8/MZBJCdF8I
         LAv4LUqQhPKmfJQHxg95w+z9PCXJfOx/qSI2NS8u4bAYskD2WXSiQmYy6K9pAXs9Zb
         ungWZHN+BDcMOzVQK67Jxf0HqUWGN1Z7FpHyXLM7P005gdQ37sNiQwQRIQsMK34kZY
         xLmGvM7/0CTAA==
Date:   Sun, 31 Jul 2022 17:51:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/9] iio: adc: mcp3911: add support for buffers
Message-ID: <20220731175121.5d9493a0@jic23-huawei>
In-Reply-To: <20220722130726.7627-6-marcus.folkesson@gmail.com>
References: <20220722130726.7627-1-marcus.folkesson@gmail.com>
        <20220722130726.7627-6-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 15:07:22 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Add support for buffers to make the driver fit for more usecases.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Assuming the Kconfig change from previous patch is pulled into this one...

A few questions / comments inline.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/mcp3911.c | 96 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 89 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index 00dadb1761dc..96c0a2a50c7c 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -5,15 +5,22 @@
>   * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
>   * Copyright (C) 2018 Kent Gustavsson <kent@minoris.se>
>   */
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/trigger.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/property.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>

Line break here to separate the 'chunks' of includes.

> +#include <asm/unaligned.h>
>  
>  #define MCP3911_REG_CHANNEL0		0x00
>  #define MCP3911_REG_CHANNEL1		0x03
> @@ -22,6 +29,7 @@
>  #define MCP3911_REG_GAIN		0x09
>  
>  #define MCP3911_REG_STATUSCOM		0x0a
> +#define MCP3911_STATUSCOM_READ		GENMASK(7, 6)
>  #define MCP3911_STATUSCOM_CH1_24WIDTH	BIT(4)
>  #define MCP3911_STATUSCOM_CH0_24WIDTH	BIT(3)
>  #define MCP3911_STATUSCOM_EN_OFFCAL	BIT(2)
> @@ -54,6 +62,13 @@ struct mcp3911 {
>  	struct regulator *vref;
>  	struct clk *clki;
>  	u32 dev_addr;
> +	struct {
> +		u32 channels[MCP3911_NUM_CHANNELS];
> +		s64 ts __aligned(8);
> +	} scan;
> +
> +	u8 tx_buf[MCP3911_NUM_CHANNELS * 3] __aligned(IIO_DMA_MINALIGN);
> +	u8 rx_buf[MCP3911_NUM_CHANNELS * 3];
>  };
>  
>  static int mcp3911_read(struct mcp3911 *adc, u8 reg, u32 *val, u8 len)
> @@ -196,16 +211,63 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
>  		.type = IIO_VOLTAGE,				\
>  		.indexed = 1,					\
>  		.channel = idx,					\
> +		.scan_index = idx,				\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
>  			BIT(IIO_CHAN_INFO_OFFSET) |		\
>  			BIT(IIO_CHAN_INFO_SCALE),		\
> +		.scan_type = {					\
> +			.sign = 's',				\
> +			.realbits = 24,				\
> +			.storagebits = 32,			\
> +			.endianness = IIO_BE,			\
> +		},						\
>  }
>  
>  static const struct iio_chan_spec mcp3911_channels[] = {
>  	MCP3911_CHAN(0),
>  	MCP3911_CHAN(1),
> +	IIO_CHAN_SOFT_TIMESTAMP(2),
>  };
>  
> +static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct mcp3911 *adc = iio_priv(indio_dev);
> +	struct spi_transfer xfer = {
> +		.tx_buf = adc->tx_buf,
> +		.rx_buf = adc->rx_buf,
> +		.len = sizeof(adc->rx_buf),
> +	};
> +	int scan_index;
> +	int i = 0;
> +	int ret;
> +
> +	mutex_lock(&adc->lock);
> +	adc->tx_buf[0] = MCP3911_REG_READ(MCP3911_CHANNEL(0), adc->dev_addr);
> +	ret = spi_sync_transfer(adc->spi, &xfer, 1);
> +	if (ret < 0) {
> +		dev_warn(&adc->spi->dev,
> +				"failed to get conversion data\n");
> +		goto out;
> +	}
> +
> +	for_each_set_bit(scan_index, indio_dev->active_scan_mask,
> +			indio_dev->masklength) {
> +		const struct iio_chan_spec *scan_chan = &indio_dev->channels[scan_index];
> +
> +		adc->scan.channels[i] = get_unaligned_be24(&adc->rx_buf[scan_chan->channel * 3]);

This has me a little curious.  It seems to be potentially reading from byte 0 which in the spi
transfer is at the same time as the tx that tells the device what the command is.  I'd expect
it to be one byte later.  Easiest way to do that being to have two transfers (though you could
just add to the offset). I might be misremembering how the spi_transfer stuff works though.
Been a while since I hacked anything SPI based...

> +		i++;
> +	}
> +	iio_push_to_buffers_with_timestamp(indio_dev, &adc->scan,
> +			iio_get_time_ns(indio_dev));
> +out:
> +	mutex_unlock(&adc->lock);
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static const struct iio_info mcp3911_info = {
>  	.read_raw = mcp3911_read_raw,
>  	.write_raw = mcp3911_write_raw,
> @@ -214,7 +276,7 @@ static const struct iio_info mcp3911_info = {
>  static int mcp3911_config(struct mcp3911 *adc)
>  {
>  	struct device *dev = &adc->spi->dev;
> -	u32 configreg;
> +	u32 regval;
>  	int ret;
>  
>  	ret = device_property_read_u32(dev, "microchip,device-addr", &adc->dev_addr);
> @@ -233,29 +295,43 @@ static int mcp3911_config(struct mcp3911 *adc)
>  	}
>  	dev_dbg(&adc->spi->dev, "use device address %i\n", adc->dev_addr);
>  
> -	ret = mcp3911_read(adc, MCP3911_REG_CONFIG, &configreg, 2);
> +	ret = mcp3911_read(adc, MCP3911_REG_CONFIG, &regval, 2);

If I was being fussy I'd ask you to pull the refactoring in here out as a precusor
patch to simplify reviewing the new stuff a little.  However it's fairly minor
so I'll let that go this time.

>  	if (ret)
>  		return ret;
>  
> +	regval &= ~MCP3911_CONFIG_VREFEXT;
>  	if (adc->vref) {
>  		dev_dbg(&adc->spi->dev, "use external voltage reference\n");
> -		configreg |= MCP3911_CONFIG_VREFEXT;
> +		regval |= FIELD_PREP(MCP3911_CONFIG_VREFEXT, 1);
>  	} else {
>  		dev_dbg(&adc->spi->dev,
>  			"use internal voltage reference (1.2V)\n");
> -		configreg &= ~MCP3911_CONFIG_VREFEXT;
> +		regval |= FIELD_PREP(MCP3911_CONFIG_VREFEXT, 0);
>  	}
>  
> +	regval &= ~MCP3911_CONFIG_CLKEXT;
>  	if (adc->clki) {
>  		dev_dbg(&adc->spi->dev, "use external clock as clocksource\n");
> -		configreg |= MCP3911_CONFIG_CLKEXT;
> +		regval |= FIELD_PREP(MCP3911_CONFIG_CLKEXT, 1);
>  	} else {
>  		dev_dbg(&adc->spi->dev,
>  			"use crystal oscillator as clocksource\n");
> -		configreg &= ~MCP3911_CONFIG_CLKEXT;
> +		regval |= FIELD_PREP(MCP3911_CONFIG_CLKEXT, 0);
>  	}
>  
> -	return  mcp3911_write(adc, MCP3911_REG_CONFIG, configreg, 2);
> +	ret = mcp3911_write(adc, MCP3911_REG_CONFIG, regval, 2);
> +	if (ret)
> +		return ret;
> +
> +	ret = mcp3911_read(adc, MCP3911_REG_STATUSCOM, &regval, 2);
> +	if (ret)
> +		return ret;
> +
> +	/* Address counter incremented, cycle through register types */
> +	regval &= ~MCP3911_STATUSCOM_READ;
> +	regval |= FIELD_PREP(MCP3911_STATUSCOM_READ, 0x02);
> +
> +	return  mcp3911_write(adc, MCP3911_REG_STATUSCOM, regval, 2);
>  }
>  


