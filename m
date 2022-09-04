Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCF95AC58D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 19:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbiIDRAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 13:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbiIDRAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 13:00:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3581A813;
        Sun,  4 Sep 2022 10:00:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFBD660F81;
        Sun,  4 Sep 2022 17:00:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5359EC433D6;
        Sun,  4 Sep 2022 17:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662310833;
        bh=Qf0xv3a89g53tL4dSAy1At+cIBeCd34Psk4kdg/i7qI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FMXadKADdNn0oEiYbTur8ym6j601V52Gub/5YuxcsAJ8nPlRCAQoBooQGq0AOpPkI
         lBLyR+Uio4TppucHOrH1vPdx5/X765dXgTPtfXjNVY+MlMKJSUgJiNZynEh30/V5Gh
         +qalsD+Elvxg1+VaROhT1GI8vD25LpxzVfK5XHTIi9yii63V+6qcyOUx7ll/Qxef+f
         Z1FHMJ7mHB883mRBmXEHMTajzt58Xsa/nF3seA/gQ2zDXoqYbBR+VGKIP6HyzOq9QD
         +ynt0V7P9EuzunrO0Jl5iCsVX4u8HFmHTz8UK37TOz7ZDTvWhgIy2Dwcy3ALKjPitr
         DHRULFopvq8ew==
Date:   Sun, 4 Sep 2022 17:26:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     <kernel@axis.com>, <andy.shevchenko@gmail.com>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Axel Jonsson <axel.jonsson@axis.com>
Subject: Re: [PATCH v2 5/5] iio: adc: mcp320x: add triggered buffer support
Message-ID: <20220904172625.588a2e64@jic23-huawei>
In-Reply-To: <20220831100506.3368103-6-vincent.whitchurch@axis.com>
References: <20220831100506.3368103-1-vincent.whitchurch@axis.com>
        <20220831100506.3368103-6-vincent.whitchurch@axis.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Wed, 31 Aug 2022 12:05:06 +0200
Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:

> From: Axel Jonsson <axel.jonsson@axis.com>
> 
> Add support for triggered buffers.  The hardware doesn't provide any
> special method of reading multiple channels, so just read the channels
> in a loop to keep things simple.
> 
> Signed-off-by: Axel Jonsson <axel.jonsson@axis.com>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Hi.  

Just one question inline:  Is it worth providing the option of a timestamp?
Adds very little complexity to the code and sometimes very useful depending
on application.  Obviously, on a device like this it's very approximate and
is more or less just the time at which you start the read with no info on
how long that scan readout took. Still handy for some usecases - such as
when a sysfs trigger is being used to grab data in an uneven fashion.

Jonathan


> ---
>  drivers/iio/adc/Kconfig   |   2 +
>  drivers/iio/adc/mcp320x.c | 100 ++++++++++++++++++++++++++++++--------
>  2 files changed, 82 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 48ace7412874..9f2628120885 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -696,6 +696,8 @@ config MAX9611
>  config MCP320X
>  	tristate "Microchip Technology MCP3x01/02/04/08 and MCP3550/1/3"
>  	depends on SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for Microchip Technology's
>  	  MCP3001, MCP3002, MCP3004, MCP3008, MCP3201, MCP3202, MCP3204,
> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> index b1c1bf4b8047..bdc986285e1b 100644
> --- a/drivers/iio/adc/mcp320x.c
> +++ b/drivers/iio/adc/mcp320x.c
> @@ -37,13 +37,18 @@
>   * http://ww1.microchip.com/downloads/en/DeviceDoc/21950D.pdf  mcp3550/1/3
>   */
>  
> -#include <linux/err.h>
>  #include <linux/delay.h>
> -#include <linux/spi/spi.h>
> -#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
>  #include <linux/mod_devicetable.h>
> -#include <linux/iio/iio.h>
> +#include <linux/module.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>

Would have slightly preferred to see header reorg in a separate patch
as then easier to see what is being added rather than moved, but I'll cope
if it's a pain to factor out.

> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  
>  enum {
>  	mcp3001,
> @@ -243,31 +248,45 @@ static int mcp320x_read_raw(struct iio_dev *indio_dev,
>  		.indexed = 1,					\
>  		.channel = (num),				\
>  		.address = (num),				\
> +		.scan_index = (num),				\
> +		.scan_type = {					\
> +			.sign = 's',				\
> +			.realbits = 32,				\
> +			.storagebits = 32,			\
> +			.endianness = IIO_CPU,			\
> +		},						\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) \
>  	}
>  
> -#define MCP320X_VOLTAGE_CHANNEL_DIFF(chan1, chan2)		\
> +#define MCP320X_VOLTAGE_CHANNEL_DIFF(si, chan1, chan2)		\
>  	{							\
>  		.type = IIO_VOLTAGE,				\
>  		.indexed = 1,					\
>  		.channel = (chan1),				\
>  		.channel2 = (chan2),				\
>  		.address = (chan1),				\
> +		.scan_index = (si),				\
> +		.scan_type = {					\
> +			.sign = 's',				\
> +			.realbits = 32,				\
> +			.storagebits = 32,			\
> +			.endianness = IIO_CPU,			\
> +		},						\
>  		.differential = 1,				\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) \
>  	}
>  
>  static const struct iio_chan_spec mcp3201_channels[] = {
> -	MCP320X_VOLTAGE_CHANNEL_DIFF(0, 1),
> +	MCP320X_VOLTAGE_CHANNEL_DIFF(0, 0, 1),
>  };
>  
>  static const struct iio_chan_spec mcp3202_channels[] = {
>  	MCP320X_VOLTAGE_CHANNEL(0),
>  	MCP320X_VOLTAGE_CHANNEL(1),
> -	MCP320X_VOLTAGE_CHANNEL_DIFF(0, 1),
> -	MCP320X_VOLTAGE_CHANNEL_DIFF(1, 0),
> +	MCP320X_VOLTAGE_CHANNEL_DIFF(2, 0, 1),
> +	MCP320X_VOLTAGE_CHANNEL_DIFF(3, 1, 0),
>  };
>  
>  static const struct iio_chan_spec mcp3204_channels[] = {
> @@ -275,10 +294,10 @@ static const struct iio_chan_spec mcp3204_channels[] = {
>  	MCP320X_VOLTAGE_CHANNEL(1),
>  	MCP320X_VOLTAGE_CHANNEL(2),
>  	MCP320X_VOLTAGE_CHANNEL(3),
> -	MCP320X_VOLTAGE_CHANNEL_DIFF(0, 1),
> -	MCP320X_VOLTAGE_CHANNEL_DIFF(1, 0),
> -	MCP320X_VOLTAGE_CHANNEL_DIFF(2, 3),
> -	MCP320X_VOLTAGE_CHANNEL_DIFF(3, 2),
> +	MCP320X_VOLTAGE_CHANNEL_DIFF(4, 0, 1),
> +	MCP320X_VOLTAGE_CHANNEL_DIFF(5, 1, 0),
> +	MCP320X_VOLTAGE_CHANNEL_DIFF(6, 2, 3),
> +	MCP320X_VOLTAGE_CHANNEL_DIFF(7, 3, 2),
>  };
>  
>  static const struct iio_chan_spec mcp3208_channels[] = {
> @@ -290,14 +309,14 @@ static const struct iio_chan_spec mcp3208_channels[] = {
>  	MCP320X_VOLTAGE_CHANNEL(5),
>  	MCP320X_VOLTAGE_CHANNEL(6),
>  	MCP320X_VOLTAGE_CHANNEL(7),
> -	MCP320X_VOLTAGE_CHANNEL_DIFF(0, 1),
> -	MCP320X_VOLTAGE_CHANNEL_DIFF(1, 0),
> -	MCP320X_VOLTAGE_CHANNEL_DIFF(2, 3),
> -	MCP320X_VOLTAGE_CHANNEL_DIFF(3, 2),
> -	MCP320X_VOLTAGE_CHANNEL_DIFF(4, 5),
> -	MCP320X_VOLTAGE_CHANNEL_DIFF(5, 4),
> -	MCP320X_VOLTAGE_CHANNEL_DIFF(6, 7),
> -	MCP320X_VOLTAGE_CHANNEL_DIFF(7, 6),
> +	MCP320X_VOLTAGE_CHANNEL_DIFF(8, 0, 1),
> +	MCP320X_VOLTAGE_CHANNEL_DIFF(9, 1, 0),
> +	MCP320X_VOLTAGE_CHANNEL_DIFF(10, 2, 3),
> +	MCP320X_VOLTAGE_CHANNEL_DIFF(11, 3, 2),
> +	MCP320X_VOLTAGE_CHANNEL_DIFF(12, 4, 5),
> +	MCP320X_VOLTAGE_CHANNEL_DIFF(13, 5, 4),
> +	MCP320X_VOLTAGE_CHANNEL_DIFF(14, 6, 7),
> +	MCP320X_VOLTAGE_CHANNEL_DIFF(15, 7, 6),
>  };
>  
>  static const struct iio_info mcp320x_info = {
> @@ -390,6 +409,41 @@ static const struct mcp320x_chip_info mcp320x_chip_infos[] = {
>  	},
>  };
>  
> +static irqreturn_t mcp320x_buffer_trigger_handler(int irq, void *pollfunc)
> +{
> +	struct iio_poll_func *pf = pollfunc;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct mcp320x *adc = iio_priv(indio_dev);
> +	s32 data[ARRAY_SIZE(mcp3208_channels)];
> +	int i = 0;
> +	int chan;
> +
> +	mutex_lock(&adc->lock);
> +
> +	for_each_set_bit(chan, indio_dev->active_scan_mask, indio_dev->masklength) {
> +		const struct iio_chan_spec *spec = &indio_dev->channels[chan];
> +		int ret, val;
> +
> +		ret = mcp320x_adc_conversion(adc, spec, &val);
> +		if (ret < 0) {
> +			dev_err_ratelimited(&adc->spi->dev, "Failed to read data: %d\n",
> +					    ret);
> +			goto out;
> +		}
> +
> +		data[i++] = val;
> +	}
> +
> +	iio_push_to_buffers(indio_dev, data);

Worth option of a timestamp?  If you do add one, you'll need to expand data and
force alignment to be at least 8 bytes.

> +
> +out:
> +	mutex_unlock(&adc->lock);
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static void mcp320x_reg_disable(void *reg)
>  {
>  	regulator_disable(reg);
> @@ -471,6 +525,12 @@ static int mcp320x_probe(struct spi_device *spi)
>  
>  	mutex_init(&adc->lock);
>  
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
> +					      mcp320x_buffer_trigger_handler,
> +					      NULL);
> +	if (ret)
> +		return ret;
> +
>  	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  

