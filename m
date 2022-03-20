Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089484E1D0F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 18:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245690AbiCTRU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 13:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242321AbiCTRUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 13:20:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0E824BCF;
        Sun, 20 Mar 2022 10:19:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D92BD611F1;
        Sun, 20 Mar 2022 17:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62786C340E9;
        Sun, 20 Mar 2022 17:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647796740;
        bh=dfCviDnwekk5BaoAxkT2yXmc2iRJd9EtrnFoA/VixQU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t2spilqaTG43PI5M8nZrsqSL2hw1mnjZYhIgmA4f8UESQ0xMfChK7T6gPw8Eq1U5b
         rJU/eW1Qb2uksNFT1H0qgyqeM/Pn30+TfC5UWhPTPZZ1p7tdAvVY3GvJh/Z0rKhgsA
         ZevIz7HVV0TR85X2nNt4ZZPR6V8rkijqBTVF8K8W+vpelX+VCQkXV+8yHWKQ+gRT4j
         cwWpCnqSuvrUDDUOCNf8xkaWl+x1Pv7lx1N8ubVJ/a0eT6Km6i4lrqPSNfSUHcTcWt
         +zp/MlZJn1LsG9qj0R/OwTlTJj3M23qID2SpxUnCGw9Ih4uAzrfB/6lnety7LUhjnp
         gU3MqWLwftW9Q==
Date:   Sun, 20 Mar 2022 17:26:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/5] iio: accel: bma400: Add triggered buffer support
Message-ID: <20220320172624.6b8ecd2b@jic23-huawei>
In-Reply-To: <20220319181023.8090-4-jagathjog1996@gmail.com>
References: <20220319181023.8090-1-jagathjog1996@gmail.com>
        <20220319181023.8090-4-jagathjog1996@gmail.com>
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

On Sat, 19 Mar 2022 23:40:21 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Added trigger buffer support to read continuous acceleration
> data from device with data ready interrupt which is mapped
> to INT1 pin.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> ---
>  drivers/iio/accel/Kconfig       |   2 +
>  drivers/iio/accel/bma400.h      |  10 +-
>  drivers/iio/accel/bma400_core.c | 161 +++++++++++++++++++++++++++++++-
>  drivers/iio/accel/bma400_i2c.c  |   2 +-
>  drivers/iio/accel/bma400_spi.c  |   2 +-
>  5 files changed, 169 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 49587c992a6d..0eb379578e00 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -177,6 +177,8 @@ config BMA220
>  config BMA400
>  	tristate "Bosch BMA400 3-Axis Accelerometer Driver"
>  	select REGMAP
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	select BMA400_I2C if I2C
>  	select BMA400_SPI if SPI
>  	help
> diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> index cfc2c9bacec8..b306a5ad513a 100644
> --- a/drivers/iio/accel/bma400.h
> +++ b/drivers/iio/accel/bma400.h
> @@ -62,6 +62,13 @@
>  #define BMA400_ACC_CONFIG2_REG      0x1b
>  #define BMA400_CMD_REG              0x7e
>  
> +/* Interrupt registers */
> +#define BMA400_INT_CONFIG0_REG      0x1f
> +#define BMA400_INT_CONFIG1_REG      0x20
> +#define BMA400_INT1_MAP_REG         0x21
> +#define BMA400_INT_IO_CTRL_REG      0x24
> +#define BMA400_INT_DRDY_MSK         BIT(7)
> +
>  /* Chip ID of BMA 400 devices found in the chip ID register. */
>  #define BMA400_ID_REG_VAL           0x90
>  
> @@ -92,6 +99,7 @@
>  
>  extern const struct regmap_config bma400_regmap_config;
>  
> -int bma400_probe(struct device *dev, struct regmap *regmap, const char *name);
> +int bma400_probe(struct device *dev, struct regmap *regmap, int irq,
> +		 const char *name);
>  
>  #endif
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index dcc7549c7a0e..797403c7dd85 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -20,6 +20,12 @@
>  #include <linux/mutex.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
>  
>  #include "bma400.h"
>  
> @@ -61,6 +67,13 @@ struct bma400_data {
>  	struct bma400_sample_freq sample_freq;
>  	int oversampling_ratio;
>  	int scale;
> +	struct iio_trigger *trig;
> +	/* Correct time stamp alignment */
> +	struct {
> +		__be16 buff[3];
> +		u8 temperature;
> +		s64 ts __aligned(8);
> +	} buffer;
you are doing bulk reads from an spi device into here.
There is a long running discussion about what we can assume about need for DMA
safety when regmap is involved.  Current state is we can't assume we don't need
to be DMA safe.  As such this should be in a separate cacheline from anything
that might be touched concurrently with DMA.

Mark buffer ___cacheline_aligned; and we should be fine.

If curious, Wolfram Sang did a good talk on this at ELCE a few years back that
google should find for you. It's an interesting little corner of horribleness :)

>  };
>  
>  static bool bma400_is_writable_reg(struct device *dev, unsigned int reg)
> @@ -152,7 +165,7 @@ static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
>  	{ }
>  };
>  
> -#define BMA400_ACC_CHANNEL(_axis) { \
> +#define BMA400_ACC_CHANNEL(_index, _axis) { \
>  	.type = IIO_ACCEL, \
>  	.modified = 1, \
>  	.channel2 = IIO_MOD_##_axis, \
> @@ -164,17 +177,32 @@ static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
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
> @@ -632,6 +660,11 @@ static int bma400_init(struct bma400_data *data)
>  	if (ret)
>  		goto err_reg_disable;
>  
> +	/* Configure INT-1 pin to push pull */

Hmm. We should be getting the requirements for using this pin from DT, though
I can't immediately think how to do it.  If the interrupt controller
is happy with open drain, then we should do that as well. Ultimately I think
this code will be happy with shared interrupts so lets not make it harder
than we need to.

> +	ret = regmap_write(data->regmap, BMA400_INT_IO_CTRL_REG, 0x02);
> +	if (ret)
> +		goto err_reg_disable;
> +
>  	/*
>  	 * Once the interrupt engine is supported we might use the
>  	 * data_src_reg, but for now ensure this is set to the
> @@ -786,6 +819,33 @@ static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
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
> +	ret = regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG,
> +				 BMA400_INT_DRDY_MSK,
> +				 FIELD_PREP(BMA400_INT_DRDY_MSK, state));
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static const unsigned long bma400_avail_scan_masks[] = {
> +	GENMASK(3, 0),
> +	0,
> +};
> +
>  static const struct iio_info bma400_info = {
>  	.read_raw          = bma400_read_raw,
>  	.read_avail        = bma400_read_avail,
> @@ -793,6 +853,63 @@ static const struct iio_info bma400_info = {
>  	.write_raw_get_fmt = bma400_write_raw_get_fmt,
>  };
>  
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
> +			       &data->buffer.buff, 3 * sizeof(__be16));
> +	mutex_unlock(&data->mutex);
> +	if (ret)
> +		goto out;
> +
> +	ret = regmap_read(data->regmap, BMA400_TEMP_DATA_REG, &temp);
> +	if (ret)
> +		goto out;
> +
> +	data->buffer.temperature = temp;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> +					   iio_get_time_ns(indio_dev));
> +
> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
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
> +	mutex_unlock(&data->mutex);
> +	if (ret)
> +		goto out;
> +
> +	if (status & BMA400_INT_DRDY_MSK)

0-day pointed this out. You need an le16_to_cpu()

> +		iio_trigger_poll_chained(data->trig);
> +
> +out:
> +	return IRQ_HANDLED;
> +}
> +
>  static void bma400_disable(void *data_ptr)
>  {
>  	struct bma400_data *data = data_ptr;
> @@ -806,7 +923,8 @@ static void bma400_disable(void *data_ptr)
>  	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
>  }
>  
> -int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)
> +int bma400_probe(struct device *dev, struct regmap *regmap, int irq,
> +		 const char *name)
>  {
>  	struct iio_dev *indio_dev;
>  	struct bma400_data *data;
> @@ -833,12 +951,45 @@ int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)
>  	indio_dev->info = &bma400_info;
>  	indio_dev->channels = bma400_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(bma400_channels);
> +	indio_dev->available_scan_masks = bma400_avail_scan_masks;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	ret = devm_add_action_or_reset(dev, bma400_disable, data);
>  	if (ret)
>  		return ret;
>  
> +	if (irq > 0) {
> +		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +						    indio_dev->name,
> +						    iio_device_id(indio_dev));
> +		if (!data->trig)
> +			return -ENOMEM;
> +
> +		data->trig->ops = &bma400_trigger_ops;
> +		iio_trigger_set_drvdata(data->trig, indio_dev);
> +
> +		ret = devm_iio_trigger_register(data->dev, data->trig);
> +		if (ret) {
> +			dev_err(dev, "iio trigger register failed\n");
> +			return ret;
> +		}
> +		indio_dev->trig = iio_trigger_get(data->trig);
> +		ret = devm_request_threaded_irq(dev, irq, NULL,
> +						&bma400_interrupt,
> +						IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +						indio_dev->name, indio_dev);
> +		if (ret) {
> +			dev_err(dev, "request irq %d failed\n", irq);
> +			return ret;
> +		}
> +	}
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +					      &bma400_trigger_handler, NULL);
> +	if (ret) {
> +		dev_err(dev, "iio triggered buffer setup failed\n");
> +		return ret;
> +	}
>  	return devm_iio_device_register(dev, indio_dev);
>  }

