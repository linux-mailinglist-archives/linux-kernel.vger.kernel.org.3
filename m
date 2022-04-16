Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B327503784
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 18:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbiDPQdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 12:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiDPQdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 12:33:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA8830F53;
        Sat, 16 Apr 2022 09:30:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A88B260DBE;
        Sat, 16 Apr 2022 16:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D595C385A3;
        Sat, 16 Apr 2022 16:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650126636;
        bh=2DGsMI9gQAauiDKuSOtKMmaUhoHhHE2AFZVGnV9z4lk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WsniiX4LfInXccdA2CR2LYCEVKPKw8av7ZCYieknr2mjixcYlwvxmWXYcvAVK8JeZ
         eY54NpaztnRU8kueDH1wF1Pi14nSfmz7UE1b+KWSzm4WNXK9p5kagDqOn2rBWg4atW
         MBIln9wr3D+05xOlPZp+HrlEcmsD9tEF/KeFwx1PjAkNu/cqZWSpMEyyZnENLLMYn2
         w9p2WAlExXzdyBy7KGPm/eXf091pl/+XkNaO/8sEQx1Pj5303fq3GWJUMkI4FarrGT
         dla9qvmXhpT0BJVXuj8DSf9fQ4fzdNzITboqv4s+rUTN6uLzc7Kizaj7bajkm1KTtm
         tfBvbensD7d0g==
Date:   Sat, 16 Apr 2022 17:38:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/9] iio: accel: bma400: Add triggered buffer support
Message-ID: <20220416173833.75768287@jic23-huawei>
In-Reply-To: <20220411203133.19929-5-jagathjog1996@gmail.com>
References: <20220411203133.19929-1-jagathjog1996@gmail.com>
        <20220411203133.19929-5-jagathjog1996@gmail.com>
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

On Tue, 12 Apr 2022 02:01:28 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Added trigger buffer support to read continuous acceleration
> data from device with data ready interrupt which is mapped
> to INT1 pin.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
A few comments inline.

Jonathan

> ---
>  drivers/iio/accel/Kconfig       |   2 +
>  drivers/iio/accel/bma400.h      |  10 ++-
>  drivers/iio/accel/bma400_core.c | 153 ++++++++++++++++++++++++++++++--
>  drivers/iio/accel/bma400_i2c.c  |   2 +-
>  drivers/iio/accel/bma400_spi.c  |   2 +-
>  5 files changed, 161 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index eac3f02662ae..958097814232 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -204,6 +204,8 @@ config BMA220
>  config BMA400
>  	tristate "Bosch BMA400 3-Axis Accelerometer Driver"
>  	select REGMAP
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	select BMA400_I2C if I2C
>  	select BMA400_SPI if SPI
>  	help
> diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> index 8dbf85eeb005..a7482a66b36b 100644
> --- a/drivers/iio/accel/bma400.h
> +++ b/drivers/iio/accel/bma400.h
> @@ -62,6 +62,13 @@
>  #define BMA400_ACC_CONFIG2_REG      0x1b
>  #define BMA400_CMD_REG              0x7e
>  
> +/* Interrupt registers */
> +#define BMA400_INT_CONFIG0_REG	    0x1f
> +#define BMA400_INT_CONFIG1_REG	    0x20
> +#define BMA400_INT1_MAP_REG	    0x21
> +#define BMA400_INT_IO_CTRL_REG	    0x24
> +#define BMA400_INT_DRDY_MSK	    BIT(7)
> +
>  /* Chip ID of BMA 400 devices found in the chip ID register. */
>  #define BMA400_ID_REG_VAL           0x90
>  
> @@ -111,6 +118,7 @@
>  
>  extern const struct regmap_config bma400_regmap_config;
>  
> -int bma400_probe(struct device *dev, struct regmap *regmap, const char *name);
> +int bma400_probe(struct device *dev, struct regmap *regmap, int irq,
> +		 const char *name);
>  
>  #endif
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index 07674d89d978..b7b2b67aef31 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -11,6 +11,7 @@
>   *  - Create channel for sensor time
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> @@ -20,6 +21,10 @@
>  #include <linux/regulator/consumer.h>
>  
>  #include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  
>  #include "bma400.h"
>  
> @@ -61,6 +66,13 @@ struct bma400_data {
>  	struct bma400_sample_freq sample_freq;
>  	int oversampling_ratio;
>  	int scale;
> +	struct iio_trigger *trig;
> +	/* Correct time stamp alignment */
> +	struct {
> +		__le16 buff[3];
> +		u8 temperature;
> +		s64 ts __aligned(8);
> +	} buffer ____cacheline_aligned;
See below, but I'd suggest adding
	__le16 status;
here to be in the same cacheline as the buffer and hence also DMA safe (as it's
not in the same line as anything else which could be modified concurrently.)

>  };
>  
>  static bool bma400_is_writable_reg(struct device *dev, unsigned int reg)
> @@ -152,7 +164,7 @@ static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
>  	{ }
>  };
>  
> -#define BMA400_ACC_CHANNEL(_axis) { \
> +#define BMA400_ACC_CHANNEL(_index, _axis) { \
>  	.type = IIO_ACCEL, \
>  	.modified = 1, \
>  	.channel2 = IIO_MOD_##_axis, \
> @@ -164,17 +176,32 @@ static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
>  		BIT(IIO_CHAN_INFO_SCALE) | \
>  		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
>  	.ext_info = bma400_ext_info, \
> +	.scan_index = _index,	\
> +	.scan_type = {		\
> +		.sign = 's',	\
> +		.realbits = 12,		\
> +		.storagebits = 16,	\
> +		.endianness = IIO_LE,	\
> +	},				\
>  }
>  
>  static const struct iio_chan_spec bma400_channels[] = {
> -	BMA400_ACC_CHANNEL(X),
> -	BMA400_ACC_CHANNEL(Y),
> -	BMA400_ACC_CHANNEL(Z),
> +	BMA400_ACC_CHANNEL(0, X),
> +	BMA400_ACC_CHANNEL(1, Y),
> +	BMA400_ACC_CHANNEL(2, Z),
>  	{
>  		.type = IIO_TEMP,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.scan_index = 3,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 8,
> +			.storagebits = 8,
> +			.endianness = IIO_LE,
> +		},
>  	},
> +	IIO_CHAN_SOFT_TIMESTAMP(4),
>  };
>  
>  static int bma400_get_temp_reg(struct bma400_data *data, int *val, int *val2)
> @@ -659,6 +686,10 @@ static int bma400_init(struct bma400_data *data)
>  	if (ret)
>  		return ret;
>  
> +	/* Configure INT1 pin to open drain */
> +	ret = regmap_write(data->regmap, BMA400_INT_IO_CTRL_REG, 0x06);
> +	if (ret)
> +		return ret;
>  	/*
>  	 * Once the interrupt engine is supported we might use the
>  	 * data_src_reg, but for now ensure this is set to the
> @@ -807,6 +838,29 @@ static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int bma400_data_rdy_trigger_set_state(struct iio_trigger *trig,
> +					     bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct bma400_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG0_REG,
> +				 BMA400_INT_DRDY_MSK,
> +				 FIELD_PREP(BMA400_INT_DRDY_MSK, state));
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG,
> +				  BMA400_INT_DRDY_MSK,
> +				  FIELD_PREP(BMA400_INT_DRDY_MSK, state));
> +}
> +
> +static const unsigned long bma400_avail_scan_masks[] = {
> +	GENMASK(3, 0),
> +	0
> +};
> +
>  static const struct iio_info bma400_info = {
>  	.read_raw          = bma400_read_raw,
>  	.read_avail        = bma400_read_avail,
> @@ -814,7 +868,64 @@ static const struct iio_info bma400_info = {
>  	.write_raw_get_fmt = bma400_write_raw_get_fmt,
>  };
>  
> -int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)
> +static const struct iio_trigger_ops bma400_trigger_ops = {
> +	.set_trigger_state = &bma400_data_rdy_trigger_set_state,
> +	.validate_device = &iio_trigger_validate_own_device,
> +};
> +
> +static irqreturn_t bma400_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct bma400_data *data = iio_priv(indio_dev);
> +	int ret, temp;
> +
> +	mutex_lock(&data->mutex);
> +
> +	/* bulk read six registers, with the base being the LSB register */
> +	ret = regmap_bulk_read(data->regmap, BMA400_X_AXIS_LSB_REG,
> +			       &data->buffer.buff, sizeof(data->buffer.buff));
> +	mutex_unlock(&data->mutex);
> +	if (ret)
> +		return IRQ_NONE;
> +
> +	ret = regmap_read(data->regmap, BMA400_TEMP_DATA_REG, &temp);
> +	if (ret)
> +		return IRQ_NONE;
> +
> +	data->buffer.temperature = temp;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> +					   iio_get_time_ns(indio_dev));
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t bma400_interrupt(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct bma400_data *data = iio_priv(indio_dev);
> +	int ret;
> +	__le16 status;
> +
> +	mutex_lock(&data->mutex);
> +	ret = regmap_bulk_read(data->regmap, BMA400_INT_STAT0_REG, &status,
> +			       sizeof(status));

regmap_bulk_read() (may) need a DMA safe buffer. Which means you can't use
a variable on the stack.  Look at using the carefully aligned and padded
data->buffer if you can as that is DMA safe.
 
Note that then you will need that lock as it protects that buffer...

You could also just add a suitable buffer after that instead
of reusing that particular structure.

> +	mutex_unlock(&data->mutex);
> +	if (ret)
> +		return IRQ_NONE;
> +
> +	if (FIELD_GET(BMA400_INT_DRDY_MSK, le16_to_cpu(status))) {
> +		iio_trigger_poll_chained(data->trig);
> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_NONE;
> +}

