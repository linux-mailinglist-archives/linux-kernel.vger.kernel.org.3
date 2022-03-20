Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB0B4E1D04
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 18:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245670AbiCTRIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 13:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbiCTRIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 13:08:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E167554BF7;
        Sun, 20 Mar 2022 10:06:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DF8C60DBE;
        Sun, 20 Mar 2022 17:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F077C340EE;
        Sun, 20 Mar 2022 17:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647796018;
        bh=YMAWP0dJkPTQxKibh5zTVpYw4JhL6kvUUt0ygV/sKVg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z50jxHHPQUV9ASv50t+aJlg84fIDhH8AwnZEkb91WUhz73lrWIz5UNqQzjF5VfTdh
         IsIfIfgUm5jvGv4D0LEft1Z5aFLHiZzudNu8J3jyI/VnJakOoTck/9787OQcHiFMl4
         dvXn7vHCUruD+Ab/K833/vhtf/VdJFC6A/nh9HzuwX0FmoMC+dy+Uj+IAxEZvX+Iev
         ZDrwKI2JDPfhCWjSA9dGTwBhK1mcp/hT7InQHS7sjpKbZDqJOfJm9ZbNI3DspdbYzq
         oL4cf9+khUJWQD2Q2CYI+yH8vgFbmm5NTKdAUAOXBEvjFGCjCwLKW0soE5cEWiwpvM
         pL+SKO96WFQeA==
Date:   Sun, 20 Mar 2022 17:14:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] iio: accel: bma400: conversion to device-managed
 function
Message-ID: <20220320171422.614a4f25@jic23-huawei>
In-Reply-To: <20220319181023.8090-2-jagathjog1996@gmail.com>
References: <20220319181023.8090-1-jagathjog1996@gmail.com>
        <20220319181023.8090-2-jagathjog1996@gmail.com>
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

On Sat, 19 Mar 2022 23:40:19 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> This is a conversion to device-managed by using devm_iio_device_register
> inside probe function, now disabling the regulator and putting bma400 to
> power down via a devm_add_action_or_reset() hook.
> 
> The dev_set_drvdata() call, bma400_remove() function and hooks in the I2C
> and SPI driver struct is removed as devm_iio_device_register function is
> used to automatically unregister on driver detach.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>

Hi Jagath,

There is an oddity in the existing driver that has lead this in
what I think is the wrong direction.  See below.

> ---
>  drivers/iio/accel/bma400.h      |  2 --
>  drivers/iio/accel/bma400_core.c | 39 ++++++++++++++-------------------
>  drivers/iio/accel/bma400_i2c.c  |  8 -------
>  drivers/iio/accel/bma400_spi.c  |  8 -------
>  4 files changed, 17 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> index c4c8d74155c2..e938da5a57b4 100644
> --- a/drivers/iio/accel/bma400.h
> +++ b/drivers/iio/accel/bma400.h
> @@ -94,6 +94,4 @@ extern const struct regmap_config bma400_regmap_config;
>  
>  int bma400_probe(struct device *dev, struct regmap *regmap, const char *name);
>  
> -void bma400_remove(struct device *dev);
> -
>  #endif
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index fd2647b728d3..dcc7549c7a0e 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -793,6 +793,19 @@ static const struct iio_info bma400_info = {
>  	.write_raw_get_fmt = bma400_write_raw_get_fmt,
>  };
>  
> +static void bma400_disable(void *data_ptr)
> +{
> +	struct bma400_data *data = data_ptr;
> +	int ret;
> +
> +	ret = bma400_set_power_mode(data, POWER_MODE_SLEEP);
> +	if (ret)
> +		dev_warn(data->dev, "Failed to put device into sleep mode (%pe)\n",
> +			 ERR_PTR(ret));
> +
> +	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);

So this raised alarm bells.  You almost never want a devm callback to do two things.

The reason it 'looks' like this might be ok is that the driver is currently calling
bma400_set_power_mode(data, POWER_MODE_SLEEP) in error paths during probe.
I think it should be.  If you make that modification first you'll see that to
keep a clean: "only undo things you have done" approach you'll then need
to have a pair of devm_add_action_or_reset() callbacks so as to cover the
disabling of the regulators when the power enabling fails and then to
cover the change to sleep mode if anything else fails.


Jonathan

> +}
> +
>  int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)
>  {
>  	struct iio_dev *indio_dev;
> @@ -822,31 +835,13 @@ int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)
>  	indio_dev->num_channels = ARRAY_SIZE(bma400_channels);
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	dev_set_drvdata(dev, indio_dev);
> -
> -	return iio_device_register(indio_dev);
> -}
> -EXPORT_SYMBOL(bma400_probe);
> -
> -void bma400_remove(struct device *dev)
> -{
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> -	struct bma400_data *data = iio_priv(indio_dev);
> -	int ret;
> -
> -	mutex_lock(&data->mutex);
> -	ret = bma400_set_power_mode(data, POWER_MODE_SLEEP);
> -	mutex_unlock(&data->mutex);
> -
> +	ret = devm_add_action_or_reset(dev, bma400_disable, data);
>  	if (ret)
> -		dev_warn(dev, "Failed to put device into sleep mode (%pe)\n", ERR_PTR(ret));
> -
> -	regulator_bulk_disable(ARRAY_SIZE(data->regulators),
> -			       data->regulators);
> +		return ret;
>  
> -	iio_device_unregister(indio_dev);
> +	return devm_iio_device_register(dev, indio_dev);
>  }
> -EXPORT_SYMBOL(bma400_remove);
> +EXPORT_SYMBOL(bma400_probe);
>  
>  MODULE_AUTHOR("Dan Robertson <dan@dlrobertson.com>");
>  MODULE_DESCRIPTION("Bosch BMA400 triaxial acceleration sensor core");
> diff --git a/drivers/iio/accel/bma400_i2c.c b/drivers/iio/accel/bma400_i2c.c
> index f50df5310beb..56da06537562 100644
> --- a/drivers/iio/accel/bma400_i2c.c
> +++ b/drivers/iio/accel/bma400_i2c.c
> @@ -27,13 +27,6 @@ static int bma400_i2c_probe(struct i2c_client *client,
>  	return bma400_probe(&client->dev, regmap, id->name);
>  }
>  
> -static int bma400_i2c_remove(struct i2c_client *client)
> -{
> -	bma400_remove(&client->dev);
> -
> -	return 0;
> -}
> -
>  static const struct i2c_device_id bma400_i2c_ids[] = {
>  	{ "bma400", 0 },
>  	{ }
> @@ -52,7 +45,6 @@ static struct i2c_driver bma400_i2c_driver = {
>  		.of_match_table = bma400_of_i2c_match,
>  	},
>  	.probe    = bma400_i2c_probe,
> -	.remove   = bma400_i2c_remove,
>  	.id_table = bma400_i2c_ids,
>  };
>  
> diff --git a/drivers/iio/accel/bma400_spi.c b/drivers/iio/accel/bma400_spi.c
> index 9f622e37477b..96dc9c215401 100644
> --- a/drivers/iio/accel/bma400_spi.c
> +++ b/drivers/iio/accel/bma400_spi.c
> @@ -87,13 +87,6 @@ static int bma400_spi_probe(struct spi_device *spi)
>  	return bma400_probe(&spi->dev, regmap, id->name);
>  }
>  
> -static int bma400_spi_remove(struct spi_device *spi)
> -{
> -	bma400_remove(&spi->dev);
> -
> -	return 0;
> -}
> -
>  static const struct spi_device_id bma400_spi_ids[] = {
>  	{ "bma400", 0 },
>  	{ }
> @@ -112,7 +105,6 @@ static struct spi_driver bma400_spi_driver = {
>  		.of_match_table = bma400_of_spi_match,
>  	},
>  	.probe    = bma400_spi_probe,
> -	.remove   = bma400_spi_remove,
>  	.id_table = bma400_spi_ids,
>  };
>  

