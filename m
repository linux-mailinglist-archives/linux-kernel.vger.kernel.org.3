Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1313C5A3F1C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 20:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiH1ScT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 14:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiH1ScR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 14:32:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF25728E21;
        Sun, 28 Aug 2022 11:32:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 653AEB80B8E;
        Sun, 28 Aug 2022 18:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D166C433C1;
        Sun, 28 Aug 2022 18:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661711522;
        bh=lQD0wNuH/HwdqWREe143v4ogYg4x/Y+B47zvJlkPmOo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L9LQzswLplRscN+OjRixUB0Eq1LWG4JGRl78lhnBDXi/RuxBFOblcOwBNdQGZ9qP1
         dyKAZqQIcjk1bwpA+Ew1bGVv8zkjFLDJ50nrjIWHs542RjrYT9ZJe5TiTLhMr0WJfn
         6OUC56G9F6o1EaUwcTLxytSlt+CZ0cgrT4jnpuYs5KyQqC5VIOFzP3qLmwRo39pz22
         EpYsSrKTz9E/5yVEe8Oz1lw+eCSGj3q8Ulcs99iZ3GQonJEFlfTEPReZDiU0mqOs8T
         ZKgcu1tXZpfw9Ybnt+qKasCTvAkcQ55oyfiN+UJJUgpzULrx3fDJe/wbIxAdEPgO7z
         eGaHgMV1NRihQ==
Date:   Sun, 28 Aug 2022 18:57:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     George Mois <george.mois@analog.com>
Cc:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lucas.p.stankus@gmail.com>
Subject: Re: [PATCH v2 2/2] drivers: iio: accel adxl312 and adxl314 support
Message-ID: <20220828185740.2c46ea55@jic23-huawei>
In-Reply-To: <20220823081520.30313-2-george.mois@analog.com>
References: <20220823081520.30313-1-george.mois@analog.com>
        <20220823081520.30313-2-george.mois@analog.com>
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

On Tue, 23 Aug 2022 11:15:20 +0300
George Mois <george.mois@analog.com> wrote:

> ADXL312 and ADXL314 are small, thin, low power, 3-axis accelerometers
> with high resolution (13-bit) measurement up to +/-12 g and +/- 200 g
> respectively.
> 
> Implement support for ADXL312 and ADXL314 by extending the ADXL313
> driver.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL312.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL314.pdf
> 
> Signed-off-by: George Mois <george.mois@analog.com>
Hi George,

A few comments inline.  In particular, look at probe paths other than
DT / ACPI or other providers of the property.h supplied accessors.
Whilst it would be nice if there weren't any, I think we are still a long
way from that state.

Jonathan


> ---
> changes in v2:
>  - extend the adxl313_of_match table with chip type specific data
>  - remove SPI bus header file in core driver
>  - remove accidental revert in adxl313_data structure
>  - use chip type specific data for decisions within the driver
>  - warn instead of fails when chip ID does not match expected chip ID
>   for specific device
>  - remove noise in the log
>  - replace magic numbers with defines
>  - update namespacing with new exports to the same adxl313_of_match
>  - add I2C support
>  drivers/iio/accel/adxl313.h      |  24 ++++-
>  drivers/iio/accel/adxl313_core.c | 174 +++++++++++++++++++++++--------
>  drivers/iio/accel/adxl313_i2c.c  |  47 ++++++---
>  drivers/iio/accel/adxl313_spi.c  |  59 +++++++----
>  4 files changed, 223 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
> index 4415f2fc07e1..854bae97c97c 100644
> --- a/drivers/iio/accel/adxl313.h
> +++ b/drivers/iio/accel/adxl313.h
> @@ -26,6 +26,7 @@
>  #define ADXL313_REG_FIFO_STATUS		0x39
>  
>  #define ADXL313_DEVID0			0xAD
> +#define ADXL313_DEVID0_ADXL312_314	0xE5
>  #define ADXL313_DEVID1			0x1D
>  #define ADXL313_PARTID			0xCB
>  #define ADXL313_SOFT_RESET		0x52
> @@ -37,18 +38,37 @@
>  #define ADXL313_MEASUREMENT_MODE	BIT(3)
>  
>  #define ADXL313_RANGE_MSK		GENMASK(1, 0)
> -#define ADXL313_RANGE_4G		3
> +#define ADXL313_RANGE_MAX		3
>  
>  #define ADXL313_FULL_RES		BIT(3)
>  #define ADXL313_SPI_3WIRE		BIT(6)
>  #define ADXL313_I2C_DISABLE		BIT(6)
>  
> +extern const struct regmap_access_table adxl312_readable_regs_table;
>  extern const struct regmap_access_table adxl313_readable_regs_table;
> +extern const struct regmap_access_table adxl314_readable_regs_table;
>  
> +extern const struct regmap_access_table adxl312_writable_regs_table;
>  extern const struct regmap_access_table adxl313_writable_regs_table;
> +extern const struct regmap_access_table adxl314_writable_regs_table;
> +
> +extern const struct of_device_id adxl313_of_match[];
> +
> +enum adxl313_device_type {
> +	ADXL312,
> +	ADXL313,
> +	ADXL314,
> +};
> +
> +struct adxl313_chip_info {
> +	const char			*name;
> +	enum adxl313_device_type	type;

I think you only need access to type from the two bus drivers.
Perhaps just expose and accessor function and move the chip_info definition
down into the common core module?

Not that important though, just a nice layering.

> +	int				scale_factor;
> +	bool				variable_range;
> +	bool				soft_reset;
> +};
>  
> diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
> index afeef779e1d0..ecb6eef1e197 100644
> --- a/drivers/iio/accel/adxl313_core.c
> +++ b/drivers/iio/accel/adxl313_core.c
> @@ -14,6 +14,13 @@

> +const struct of_device_id adxl313_of_match[] = {
> +	{
> +		.compatible = "adi,adxl312",
> +		.data = &adxl31x_chip_info[ADXL312],
> +	},
> +	{
> +		.compatible = "adi,adxl313",
> +		.data = &adxl31x_chip_info[ADXL313],
> +	},
> +	{
> +		.compatible = "adi,adxl314",
> +		.data = &adxl31x_chip_info[ADXL314],
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adxl313_of_match);

Isn't this in wrong driver?  Should be in the i2c and spi drivers
to result in the aliases being in the module we want to load
rather than the common module.

> +EXPORT_SYMBOL_NS_GPL(adxl313_of_match, IIO_ADXL313);



> @@ -226,11 +306,15 @@ static int adxl313_setup(struct device *dev, struct adxl313_data *data,
>  	unsigned int regval;
>  	int ret;
>  
> -	/* Ensures the device is in a consistent state after start up */
> -	ret = regmap_write(data->regmap, ADXL313_REG_SOFT_RESET,
> -			   ADXL313_SOFT_RESET);
> -	if (ret)
> -		return ret;
> +	/* If sw reset available, ensures the device is in a consistent
Multiline comment syntax in IIO (and most of the kernel) is:

	/*
	 * If sw reset available...
	 * state after start up.
	 */

> +	 * state after start up
> +	 */
> +	if (data->chip_info->soft_reset) {
> +		ret = regmap_write(data->regmap, ADXL313_REG_SOFT_RESET,
> +				   ADXL313_SOFT_RESET);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	if (setup) {
>  		ret = setup(dev, data->regmap);
> @@ -242,41 +326,44 @@ static int adxl313_setup(struct device *dev, struct adxl313_data *data,
>  	if (ret)
>  		return ret;
>  
> -	if (regval != ADXL313_DEVID0) {
> -		dev_err(dev, "Invalid manufacturer ID: 0x%02x\n", regval);
> -		return -ENODEV;
> -	}
> +	if (data->chip_info->type == ADXL313 && regval != ADXL313_DEVID0)
> +		dev_warn(dev, "Invalid manufacturer ID: 0x%02x\n", regval);
>  
> -	ret = regmap_read(data->regmap, ADXL313_REG_DEVID1, &regval);
Feels like a lot of this code should only be called if the firmware claims
this is an adxl313.  Can we factor it out to a separate function conditional
on data->chip_info->type == ADXL1313 or better still, use a callback function
in the chip_info structure.

I 'think' after this patch, for non ADXL313 device there are only a few lines
of this function that are actually relevant. Maybe just have a callback in 
chip_info for the whole of axl313_setup / adxl312_setup?
> -	if (ret)
> -		return ret;
> +	/* If ADXL313, check DEVID1 and PARTID */
> +	if (regval == ADXL313_DEVID0) {
> +		ret = regmap_read(data->regmap, ADXL313_REG_DEVID1, &regval);
> +		if (ret)
> +			return ret;
>  
> -	if (regval != ADXL313_DEVID1) {
> -		dev_err(dev, "Invalid mems ID: 0x%02x\n", regval);
> -		return -ENODEV;
> -	}
> +		if (regval != ADXL313_DEVID1)
> +			dev_warn(dev, "Invalid mems ID: 0x%02x\n", regval);
>  
> -	ret = regmap_read(data->regmap, ADXL313_REG_PARTID, &regval);
> -	if (ret)
> -		return ret;
> +		ret = regmap_read(data->regmap, ADXL313_REG_PARTID, &regval);
> +		if (ret)
> +			return ret;
>  
> -	if (regval != ADXL313_PARTID) {
> -		dev_err(dev, "Invalid device ID: 0x%02x\n", regval);
> -		return -ENODEV;
> +		if (regval != ADXL313_PARTID)
> +			dev_warn(dev, "Invalid device ID: 0x%02x\n", regval);
>  	}
>  
> -	/* Sets the range to +/- 4g */
> -	ret = regmap_update_bits(data->regmap, ADXL313_REG_DATA_FORMAT,
> -				 ADXL313_RANGE_MSK,
> -				 FIELD_PREP(ADXL313_RANGE_MSK, ADXL313_RANGE_4G));
> -	if (ret)
> -		return ret;
> +	/* If ADXL312 or ADXL314 device, check DEVID0 */
> +	if (data->chip_info->type != ADXL313 && regval != ADXL313_DEVID0_ADXL312_314)
> +		dev_warn(dev, "Invalid manufacturer ID: %#02x\n", regval);
>  
> -	/* Enables full resolution */
> -	ret = regmap_update_bits(data->regmap, ADXL313_REG_DATA_FORMAT,
> -				 ADXL313_FULL_RES, ADXL313_FULL_RES);
> -	if (ret)
> -		return ret;
> +	/* Sets the range to maximum, full resolution, if applicable */
> +	if (data->chip_info->variable_range) {
> +		ret = regmap_update_bits(data->regmap, ADXL313_REG_DATA_FORMAT,
> +					 ADXL313_RANGE_MSK,
> +					 FIELD_PREP(ADXL313_RANGE_MSK, ADXL313_RANGE_MAX));
> +		if (ret)
> +			return ret;
> +
> +		/* Enables full resolution */
> +		ret = regmap_update_bits(data->regmap, ADXL313_REG_DATA_FORMAT,
> +					 ADXL313_FULL_RES, ADXL313_FULL_RES);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	/* Enables measurement mode */
>  	return regmap_update_bits(data->regmap, ADXL313_REG_POWER_CTL,
> @@ -288,7 +375,6 @@ static int adxl313_setup(struct device *dev, struct adxl313_data *data,
>   * adxl313_core_probe() - probe and setup for adxl313 accelerometer
>   * @dev:	Driver model representation of the device
>   * @regmap:	Register map of the device
> - * @name:	Device name buffer reference
>   * @setup:	Setup routine to be executed right before the standard device
>   *		setup, can also be set to NULL if not required
>   *
> @@ -296,9 +382,9 @@ static int adxl313_setup(struct device *dev, struct adxl313_data *data,
>   */
>  int adxl313_core_probe(struct device *dev,
>  		       struct regmap *regmap,
> -		       const char *name,
>  		       int (*setup)(struct device *, struct regmap *))
>  {
> +	const struct adxl313_chip_info *chip_data = device_get_match_data(dev);

As below, you can't do this unfortunately because it may well return NULL.
Instead, pass the chip_info pointer to this probe() function.

>  	struct adxl313_data *data;
>  	struct iio_dev *indio_dev;
>  	int ret;
> @@ -309,9 +395,11 @@ int adxl313_core_probe(struct device *dev,
>  
>  	data = iio_priv(indio_dev);
>  	data->regmap = regmap;
> +	data->chip_info = chip_data;
> +
>  	mutex_init(&data->lock);
>  
> -	indio_dev->name = name;
> +	indio_dev->name = chip_data->name;
>  	indio_dev->info = &adxl313_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = adxl313_channels;
> diff --git a/drivers/iio/accel/adxl313_i2c.c b/drivers/iio/accel/adxl313_i2c.c
> index c329765dbf60..32fb8d4866f8 100644
> --- a/drivers/iio/accel/adxl313_i2c.c
> +++ b/drivers/iio/accel/adxl313_i2c.c
> @@ -14,42 +14,57 @@
>  
>  #include "adxl313.h"
>  
> -static const struct regmap_config adxl313_i2c_regmap_config = {
> -	.reg_bits	= 8,
> -	.val_bits	= 8,
> -	.rd_table	= &adxl313_readable_regs_table,
> -	.wr_table	= &adxl313_writable_regs_table,
> -	.max_register	= 0x39,
> +static const struct regmap_config adxl31x_i2c_regmap_config[] = {
> +	[ADXL312] = {
> +		.reg_bits	= 8,
> +		.val_bits	= 8,
> +		.rd_table	= &adxl312_readable_regs_table,
> +		.wr_table	= &adxl312_writable_regs_table,
> +		.max_register	= 0x39,
> +	},
> +	[ADXL313] = {
> +		.reg_bits	= 8,
> +		.val_bits	= 8,
> +		.rd_table	= &adxl313_readable_regs_table,
> +		.wr_table	= &adxl313_writable_regs_table,
> +		.max_register	= 0x39,
> +	},
> +	[ADXL314] = {
> +		.reg_bits	= 8,
> +		.val_bits	= 8,
> +		.rd_table	= &adxl314_readable_regs_table,
> +		.wr_table	= &adxl314_writable_regs_table,
> +		.max_register	= 0x39,
> +	}
>  };
>  
>  static int adxl313_i2c_probe(struct i2c_client *client)
>  {
> +	const struct adxl313_chip_info *chip_data;
>  	struct regmap *regmap;
>  
> -	regmap = devm_regmap_init_i2c(client, &adxl313_i2c_regmap_config);
> +	chip_data = device_get_match_data(&client->dev);
As below. This may well be null - so you need to have the backup handling
provided by the i2c subsystem. (i2c_match_id()->driver_data)
> +
> +	regmap = devm_regmap_init_i2c(client,
> +				      &adxl31x_i2c_regmap_config[chip_data->type]);
>  	if (IS_ERR(regmap)) {
>  		dev_err(&client->dev, "Error initializing i2c regmap: %ld\n",
>  			PTR_ERR(regmap));
>  		return PTR_ERR(regmap);
>  	}
>  
> -	return adxl313_core_probe(&client->dev, regmap, client->name, NULL);
> +	return adxl313_core_probe(&client->dev, regmap, NULL);
>  }
>  
>  static const struct i2c_device_id adxl313_i2c_id[] = {
> -	{ "adxl313" },
> +	{ "adxl312", ADXL312 },
> +	{ "adxl313", ADXL313 },
> +	{ "adxl314", ADXL314 },
Similar to spi comments below on how the data here should be used, but currently isn't.

>  	{ }
>  };
>  
>  MODULE_DEVICE_TABLE(i2c, adxl313_i2c_id);
>  
> -static const struct of_device_id adxl313_of_match[] = {
> -	{ .compatible = "adi,adxl313" },
> -	{ }
> -};
> -
> -MODULE_DEVICE_TABLE(of, adxl313_of_match);
> -
>  static struct i2c_driver adxl313_i2c_driver = {
>  	.driver = {
>  		.name	= "adxl313_i2c",
> diff --git a/drivers/iio/accel/adxl313_spi.c b/drivers/iio/accel/adxl313_spi.c
> index a3c6d553462d..c22ab02163ed 100644
> --- a/drivers/iio/accel/adxl313_spi.c
> +++ b/drivers/iio/accel/adxl313_spi.c
> @@ -11,17 +11,38 @@
>  #include <linux/module.h>
>  #include <linux/regmap.h>
>  #include <linux/spi/spi.h>
> +#include <linux/property.h>
>  
>  #include "adxl313.h"
>  
> -static const struct regmap_config adxl313_spi_regmap_config = {
> -	.reg_bits	= 8,
> -	.val_bits	= 8,
> -	.rd_table	= &adxl313_readable_regs_table,
> -	.wr_table	= &adxl313_writable_regs_table,
> -	.max_register	= 0x39,
> -	 /* Setting bits 7 and 6 enables multiple-byte read */
> -	.read_flag_mask	= BIT(7) | BIT(6),
> +static const struct regmap_config adxl31x_spi_regmap_config[] = {
> +	[ADXL312] = {
> +		.reg_bits	= 8,
> +		.val_bits	= 8,
> +		.rd_table	= &adxl312_readable_regs_table,
> +		.wr_table	= &adxl312_writable_regs_table,
> +		.max_register	= 0x39,
> +		/* Setting bits 7 and 6 enables multiple-byte read */
> +		.read_flag_mask	= BIT(7) | BIT(6),
> +	},
> +	[ADXL313] = {
> +		.reg_bits	= 8,
> +		.val_bits	= 8,
> +		.rd_table	= &adxl313_readable_regs_table,
> +		.wr_table	= &adxl313_writable_regs_table,
> +		.max_register	= 0x39,
> +		/* Setting bits 7 and 6 enables multiple-byte read */
> +		.read_flag_mask	= BIT(7) | BIT(6),
> +	},
> +	[ADXL314] = {
> +		.reg_bits	= 8,
> +		.val_bits	= 8,
> +		.rd_table	= &adxl314_readable_regs_table,
> +		.wr_table	= &adxl314_writable_regs_table,
> +		.max_register	= 0x39,
> +		/* Setting bits 7 and 6 enables multiple-byte read */
> +		.read_flag_mask	= BIT(7) | BIT(6),
> +	}
>  };
>  
>  static int adxl313_spi_setup(struct device *dev, struct regmap *regmap)
> @@ -42,7 +63,7 @@ static int adxl313_spi_setup(struct device *dev, struct regmap *regmap)
>  
>  static int adxl313_spi_probe(struct spi_device *spi)
>  {
> -	const struct spi_device_id *id = spi_get_device_id(spi);
> +	const struct adxl313_chip_info *chip_data;
>  	struct regmap *regmap;
>  	int ret;
>  
> @@ -51,31 +72,29 @@ static int adxl313_spi_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	regmap = devm_regmap_init_spi(spi, &adxl313_spi_regmap_config);
> +	chip_data = device_get_match_data(&spi->dev);

If this fails (which it will if the driver was probed via various routes, such
as greybus (I think that still doesn't use the generic firmware handling?),
or for i2c the magic sysfs file, not to mention anyone still use
a board file, then you need to fall back to the spi_get_device_id() path. 

> +
> +	regmap = devm_regmap_init_spi(spi,
> +				      &adxl31x_spi_regmap_config[chip_data->type]);
> +
>  	if (IS_ERR(regmap)) {
>  		dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
>  			PTR_ERR(regmap));
>  		return PTR_ERR(regmap);
>  	}
>  
> -	return adxl313_core_probe(&spi->dev, regmap, id->name,
> -				  &adxl313_spi_setup);
> +	return adxl313_core_probe(&spi->dev, regmap, &adxl313_spi_setup);
>  }
>  
>  static const struct spi_device_id adxl313_spi_id[] = {
> -	{ "adxl313" },
> +	{ "adxl312", ADXL312 },
> +	{ "adxl313", ADXL313 },
> +	{ "adxl314", ADXL314 },
These should be useful (see above about need to use
id->driver_data) but right now you aren't using the driver_data part
at all.

>  	{ }
>  };
>  
>  MODULE_DEVICE_TABLE(spi, adxl313_spi_id);
>  
> -static const struct of_device_id adxl313_of_match[] = {
> -	{ .compatible = "adi,adxl313" },
> -	{ }
> -};
> -
> -MODULE_DEVICE_TABLE(of, adxl313_of_match);
> 
I'd prefer to see the unification of the of_device_id tables
done in a precursor patch.

>  static struct spi_driver adxl313_spi_driver = {
>  	.driver = {
>  		.name	= "adxl313_spi",

