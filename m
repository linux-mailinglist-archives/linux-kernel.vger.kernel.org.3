Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F8A5AC53B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 18:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbiIDQDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 12:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbiIDQDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 12:03:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6759D37FA1;
        Sun,  4 Sep 2022 09:02:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03400B80D70;
        Sun,  4 Sep 2022 16:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF69C433C1;
        Sun,  4 Sep 2022 16:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662307362;
        bh=Ua2OB2wG3UNxi13cb4yxy+mBYBkMyMH3UocD//rWYJs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Uc56CCQU2Vyi/RgB8d5HoulMVIkhNw8u6R6dXEnVy+XtpzJxurbnOOMUb/qIrFiZL
         s1IBtP8IpHZMuZTEwnmGtbXl+PBua1HCuBOCMfcN7qPdhQeZpYdDgcQMSYCvE6Vx32
         xKUXO5jVgYr/2LezGczHC0xMi4oMXKTHrgQk8toj2JEYKKu9qH6HL0hdvncKWkEdkn
         V3+S69Y4D+FmHqB1rUBjWa9XivFdXngj6Pp0RDzfrK7MY8kx7w/I2YPhO+lku+uuzA
         a4iTL+fZSKduJUE3rrWC/nQvinIAtcW+aNwConciQ+iH5fC8I0Z0HgqpcH4CJk68Bq
         96EkRE7vp1jyg==
Date:   Sun, 4 Sep 2022 16:28:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     George Mois <george.mois@analog.com>
Cc:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lucas.p.stankus@gmail.com>
Subject: Re: [PATCH v3 2/2] drivers: iio: accel: adxl312 and adxl314 support
Message-ID: <20220904162834.564a021c@jic23-huawei>
In-Reply-To: <20220831143538.65816-2-george.mois@analog.com>
References: <20220831143538.65816-1-george.mois@analog.com>
        <20220831143538.65816-2-george.mois@analog.com>
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

On Wed, 31 Aug 2022 17:35:38 +0300
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

Whilst there is some discussion of this going on in a different thread
my opinion is that Datasheet is a formal tag so there should be no blank line
here.

A few other minor comments inline.

> 
> Signed-off-by: George Mois <george.mois@analog.com>
> ---


> diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
> index afeef779e1d0..9c93e71c94f1 100644
> --- a/drivers/iio/accel/adxl313_core.c
> +++ b/drivers/iio/accel/adxl313_core.c
 
...
> -static int adxl313_setup(struct device *dev, struct adxl313_data *data,
> -			 int (*setup)(struct device *, struct regmap *))
> +static int adxl312_adxl314_check_id(struct device *dev,

Naming a function after multiple supported parts has a history of
going wrong over the longer term as that list of parts keeps getting longer.

Just name it after the first one supported.

> +				    struct adxl313_data *data)
>  {
>  	unsigned int regval;
>  	int ret;
>  

> +
> +static int adxl313_setup(struct device *dev, struct adxl313_data *data,
> +			 int (*setup)(struct device *, struct regmap *))
> +{
> +	int ret;
>  
> -	if (regval != ADXL313_PARTID) {
> -		dev_err(dev, "Invalid device ID: 0x%02x\n", regval);
> -		return -ENODEV;
> +	/*
> +	 * If sw reset available, ensures the device is in a consistent
> +	 * state after start up
> +	 */
> +	if (data->chip_info->soft_reset) {
> +		ret = regmap_write(data->regmap, ADXL313_REG_SOFT_RESET,
> +				   ADXL313_SOFT_RESET);
> +		if (ret)
> +			return ret;
>  	}
>  
> -	/* Sets the range to +/- 4g */
> -	ret = regmap_update_bits(data->regmap, ADXL313_REG_DATA_FORMAT,
> -				 ADXL313_RANGE_MSK,
> -				 FIELD_PREP(ADXL313_RANGE_MSK, ADXL313_RANGE_4G));
> -	if (ret)
> -		return ret;
> +	if (setup) {
> +		ret = setup(dev, data->regmap);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (data->chip_info->type == ADXL313)
> +		/* ADXL313 */
> +		ret = adxl313_check_id(dev, data);

I'd prefer these handled via a callback rather than checking on type.
That leads to the driver being easier to extend for future supported parts
as changes are focused in one place (the chip_info structures).

Otherwise this new approach seems much cleaner.


> +	else
> +		/* ADXL312 or ADXL314 */
> +		ret = adxl312_adxl314_check_id(dev, data);
>  



> diff --git a/drivers/iio/accel/adxl313_i2c.c b/drivers/iio/accel/adxl313_i2c.c
> index c329765dbf60..0665f2945a27 100644
> --- a/drivers/iio/accel/adxl313_i2c.c
> +++ b/drivers/iio/accel/adxl313_i2c.c
> @@ -14,42 +14,80 @@

>  
>  static const struct i2c_device_id adxl313_i2c_id[] = {
> -	{ "adxl313" },
> +	{ "adxl312", ADXL312 },

As for SPI case, it would be cleaner to put a pointer
in here as then the two paths will be more similar.

> +	{ "adxl313", ADXL313 },
> +	{ "adxl314", ADXL314 },
>  	{ }
>  };
>  
>  MODULE_DEVICE_TABLE(i2c, adxl313_i2c_id);
>  
>  static const struct of_device_id adxl313_of_match[] = {
> -	{ .compatible = "adi,adxl313" },
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
>  	{ }
>  };
>  
>  MODULE_DEVICE_TABLE(of, adxl313_of_match);
>  
> +static int adxl313_i2c_probe(struct i2c_client *client)
> +{
> +	const struct adxl313_chip_info *chip_data;
> +	enum adxl313_device_type chip_type;
> +	struct regmap *regmap;
> +
> +	chip_data = device_get_match_data(&client->dev);
> +	if (chip_data)
> +		chip_type = chip_data->type;
> +	else
> +		chip_type = i2c_match_id(adxl313_i2c_id, client)->driver_data;

> +
> +	regmap = devm_regmap_init_i2c(client,
> +				      &adxl31x_i2c_regmap_config[chip_type]);

As below: I think it is cleaner to get chip_data for either registration
path and extract chip_type from that. Aim being to avoid going backwards
and forwards between the structure and the enum.

> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Error initializing i2c regmap: %ld\n",
> +			PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	return adxl313_core_probe(&client->dev, regmap, &adxl31x_chip_info[chip_type], NULL);
> +}
> +
>  static struct i2c_driver adxl313_i2c_driver = {
>  	.driver = {
>  		.name	= "adxl313_i2c",
> diff --git a/drivers/iio/accel/adxl313_spi.c b/drivers/iio/accel/adxl313_spi.c
> index a3c6d553462d..2c3b094ef465 100644
> --- a/drivers/iio/accel/adxl313_spi.c
> +++ b/drivers/iio/accel/adxl313_spi.c
> @@ -11,17 +11,38 @@

>  
>  static int adxl313_spi_setup(struct device *dev, struct regmap *regmap)
> @@ -42,7 +63,8 @@ static int adxl313_spi_setup(struct device *dev, struct regmap *regmap)
>  
>  static int adxl313_spi_probe(struct spi_device *spi)
>  {
> -	const struct spi_device_id *id = spi_get_device_id(spi);
> +	const struct adxl313_chip_info *chip_data;
> +	enum adxl313_device_type chip_type;
>  	struct regmap *regmap;
>  	int ret;
>  
> @@ -51,26 +73,47 @@ static int adxl313_spi_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	regmap = devm_regmap_init_spi(spi, &adxl313_spi_regmap_config);
> +	chip_data = device_get_match_data(&spi->dev);
> +	if (chip_data)
> +		chip_type = chip_data->type;
> +	else
> +		chip_type = spi_get_device_id(spi)->driver_data;

I'd rather see you set chip_data here for either path then use that
directly in the core_probe() call below.  Note comment on storing
a pointer in spi_device_id->driver_data (it is carefully sized to allow
that to be done)

You will need to pull chip_type out for the regmap config, but at least
we are only going one way rather than
chip_data->chip_type->chip_data.


> +
> +	regmap = devm_regmap_init_spi(spi,
> +				      &adxl31x_spi_regmap_config[chip_type]);
> +
>  	if (IS_ERR(regmap)) {
>  		dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
>  			PTR_ERR(regmap));
>  		return PTR_ERR(regmap);
>  	}
>  
> -	return adxl313_core_probe(&spi->dev, regmap, id->name,
> -				  &adxl313_spi_setup);
> +	return adxl313_core_probe(&spi->dev, regmap,
> +				  &adxl31x_chip_info[chip_type], &adxl313_spi_setup);
>  }
>  
>  static const struct spi_device_id adxl313_spi_id[] = {
> -	{ "adxl313" },
> +	{ "adxl312", ADXL312 },

It's fine to store a pointer in the data field of this (will need casting appropriately)
and that will simplify handling in probe() as both sources will be of the same type.

> +	{ "adxl313", ADXL313 },
> +	{ "adxl314", ADXL314 },
>  	{ }
>  };
>  
>  MODULE_DEVICE_TABLE(spi, adxl313_spi_id);
>  
>  static const struct of_device_id adxl313_of_match[] = {
> -	{ .compatible = "adi,adxl313" },
> +	{
> +		.compatible = "adi,adxl312",
> +		.data = &adxl31x_chip_info[ADXL312],

Not particularly important but it's fairly common practice to have these
on one line.

	{ .compatible = "adi,adxl312", .data = &adxl31x_chip_info[ADXL312] },

> +	},
> +	{
> +		.compatible = "adi,adxl313",
> +		.data = &adxl31x_chip_info[ADXL313],
> +	},
> +	{
> +		.compatible = "adi,adxl314",
> +		.data = &adxl31x_chip_info[ADXL314],
> +	},
>  	{ }
>  };
>  

