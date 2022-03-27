Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535194E88D7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 18:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbiC0QaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 12:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236028AbiC0QaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 12:30:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533F36430;
        Sun, 27 Mar 2022 09:28:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05A18B80D87;
        Sun, 27 Mar 2022 16:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E91C340EC;
        Sun, 27 Mar 2022 16:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648398498;
        bh=hbtabaqAl60KDXR0ALM8mPHH4bvEdZJyIUMFPMJYXBQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B1FdCTAk+Cqbt9oVx3VrAeIQuVnLIaVpKuy8/CQRhHfvTkfbp2XnQt75427fDAj3X
         JrVeiLzbhkqg9vNqAHF8DeLD/kewKhQqo+viwxOqcwKsbjMmwJ2X81pZwxHm9fygiZ
         11q3yCxig+TDD9+bbGkFh/oEPZNfcm1mLSgtIpCBilsKJhkC0eoH5oCGlMNv86DknH
         nNGNUjmaIfJ/dEcONx9X1RXnrySgr1L7SYvUD2vg0cMYDe3Jwe58yv2mVld7n9FOWG
         te0pjDzukBbXh1tmUjiypB6K+clW6hMivK6yClhc0w2Opny+hiBC8vkRoZ6MOilh8M
         ZFmKWRogMrSYQ==
Date:   Sun, 27 Mar 2022 17:35:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: accel: bma400: conversion to device-managed
 function
Message-ID: <20220327173551.4fdcc706@jic23-huawei>
In-Reply-To: <20220326194146.15549-3-jagathjog1996@gmail.com>
References: <20220326194146.15549-1-jagathjog1996@gmail.com>
        <20220326194146.15549-3-jagathjog1996@gmail.com>
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

On Sun, 27 Mar 2022 01:11:43 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> This is a conversion to device-managed by using devm_iio_device_register
> inside probe function, now disabling the regulator and putting bma400 to
> power down via a devm_add_action_or_reset() hook.

I would state here that previously the bma400 was not put into power down
mode in some error paths in probe where it now is, but that should cause no
harm.
> 
> The dev_set_drvdata() call, bma400_remove() function and hooks in the I2C
> and SPI driver struct is removed as devm_iio_device_register function is
> used to automatically unregister on driver detach.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
one other minor thing inline.

Jonathan

> ---
>  drivers/iio/accel/bma400.h      |  2 -
>  drivers/iio/accel/bma400_core.c | 77 ++++++++++++++++-----------------
>  drivers/iio/accel/bma400_i2c.c  |  8 ----
>  drivers/iio/accel/bma400_spi.c  |  8 ----
>  4 files changed, 38 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> index 190366debdb3..c1b3dbfbd98f 100644
> --- a/drivers/iio/accel/bma400.h
> +++ b/drivers/iio/accel/bma400.h
> @@ -112,6 +112,4 @@ extern const struct regmap_config bma400_regmap_config;
>  
>  int bma400_probe(struct device *dev, struct regmap *regmap, const char *name);
>  
> -void bma400_remove(struct device *dev);
> -
>  #endif
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index fd2647b728d3..dc273381a0a2 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -560,6 +560,26 @@ static void bma400_init_tables(void)
>  	}
>  }
>  
> +static void bma400_regulators_disable(void *data_ptr)
> +{
> +	struct bma400_data *data = data_ptr;
> +
> +	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
> +}
> +
> +static void bma400_power_disable(void *data_ptr)
> +{
> +	struct bma400_data *data = data_ptr;
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +	ret = bma400_set_power_mode(data, POWER_MODE_SLEEP);
> +	if (ret)
> +		dev_warn(data->dev, "Failed to put device into sleep mode (%pe)\n",
> +			 ERR_PTR(ret));

Drop the check on ret out of the locked region.  No reason for it to be done
under the lock so generally nice not to do so.  Also matches the previous
ordering so there shouldnt' be any questions about it.

> +	mutex_unlock(&data->mutex);
> +}
> +
>  static int bma400_init(struct bma400_data *data)
>  {
>  	unsigned int val;
> @@ -569,13 +589,12 @@ static int bma400_init(struct bma400_data *data)
>  	ret = regmap_read(data->regmap, BMA400_CHIP_ID_REG, &val);
>  	if (ret) {
>  		dev_err(data->dev, "Failed to read chip id register\n");
> -		goto out;
> +		return ret;
>  	}
>  
>  	if (val != BMA400_ID_REG_VAL) {
>  		dev_err(data->dev, "Chip ID mismatch\n");
> -		ret = -ENODEV;
> -		goto out;
> +		return -ENODEV;
>  	}
>  
>  	data->regulators[BMA400_VDD_REGULATOR].supply = "vdd";
> @@ -589,27 +608,31 @@ static int bma400_init(struct bma400_data *data)
>  				"Failed to get regulators: %d\n",
>  				ret);
>  
> -		goto out;
> +		return ret;
>  	}
>  	ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
>  				    data->regulators);
>  	if (ret) {
>  		dev_err(data->dev, "Failed to enable regulators: %d\n",
>  			ret);
> -		goto out;
> +		return ret;
>  	}
>  
> +	ret = devm_add_action_or_reset(data->dev, bma400_regulators_disable, data);
> +	if (ret)
> +		return ret;
> +
>  	ret = bma400_get_power_mode(data);
>  	if (ret) {
>  		dev_err(data->dev, "Failed to get the initial power-mode\n");
> -		goto err_reg_disable;
> +		return ret;
>  	}
>  
>  	if (data->power_mode != POWER_MODE_NORMAL) {
>  		ret = bma400_set_power_mode(data, POWER_MODE_NORMAL);
>  		if (ret) {
>  			dev_err(data->dev, "Failed to wake up the device\n");
> -			goto err_reg_disable;
> +			return ret;
>  		}
>  		/*
>  		 * TODO: The datasheet waits 1500us here in the example, but
> @@ -618,19 +641,23 @@ static int bma400_init(struct bma400_data *data)
>  		usleep_range(1500, 2000);
>  	}
>  
> +	ret = devm_add_action_or_reset(data->dev, bma400_power_disable, data);
> +	if (ret)
> +		return ret;
> +
>  	bma400_init_tables();
>  
>  	ret = bma400_get_accel_output_data_rate(data);
>  	if (ret)
> -		goto err_reg_disable;
> +		return ret;
>  
>  	ret = bma400_get_accel_oversampling_ratio(data);
>  	if (ret)
> -		goto err_reg_disable;
> +		return ret;
>  
>  	ret = bma400_get_accel_scale(data);
>  	if (ret)
> -		goto err_reg_disable;
> +		return ret;
>  
>  	/*
>  	 * Once the interrupt engine is supported we might use the
> @@ -639,12 +666,6 @@ static int bma400_init(struct bma400_data *data)
>  	 * channel.
>  	 */
>  	return regmap_write(data->regmap, BMA400_ACC_CONFIG2_REG, 0x00);
> -
> -err_reg_disable:
> -	regulator_bulk_disable(ARRAY_SIZE(data->regulators),
> -			       data->regulators);
> -out:
> -	return ret;
>  }
>  
>  static int bma400_read_raw(struct iio_dev *indio_dev,
> @@ -822,32 +843,10 @@ int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)
>  	indio_dev->num_channels = ARRAY_SIZE(bma400_channels);
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	dev_set_drvdata(dev, indio_dev);
> -
> -	return iio_device_register(indio_dev);
> +	return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL(bma400_probe);
>  
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
> -	if (ret)
> -		dev_warn(dev, "Failed to put device into sleep mode (%pe)\n", ERR_PTR(ret));
> -
> -	regulator_bulk_disable(ARRAY_SIZE(data->regulators),
> -			       data->regulators);
> -
> -	iio_device_unregister(indio_dev);
> -}
> -EXPORT_SYMBOL(bma400_remove);
> -

