Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140BD502E95
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 20:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345676AbiDOSOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 14:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiDOSOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 14:14:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D9250079;
        Fri, 15 Apr 2022 11:11:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA0E360B69;
        Fri, 15 Apr 2022 18:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FDDC385A4;
        Fri, 15 Apr 2022 18:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650046296;
        bh=jwi0PosNUVyFpkgorgWpNJaQhNUHV+XmZcnJ99lsu/M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iCux2JnnjimHonUQKM1R0X8Vvk/PR8AALKqRQVO1AG3X7w9qTvYKA23vjf8ycwAg5
         5AEmzIzJnMDGD15oMFUU11HnnBr1FH9sRoZM8QSjDpJWr149NDY0dGS0Tn5VZ0AzLR
         wHgmslI20wf0+9ZjJgV854QXTeCT5jzZpAw+DK30+dL0Se7CwU1UXv8R8H+YqTihhP
         VwK7Xi/LqB7dX9V2fREbNNXDXEow00pryG64io6VfDXstaE2F992WrQ/zUUboR/l15
         jCHsouAmrDN79a5xhoasNZ2iYD1TpgWEIjf2trQLRnx8yU+Hp0/jI6AetrESP45KuJ
         fpmH+/WItIRQQ==
Date:   Fri, 15 Apr 2022 19:19:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/1] iio: imu: bmi160: Make use of device properties
Message-ID: <20220415191933.2d41dd6e@jic23-huawei>
In-Reply-To: <20220414131804.25227-1-andriy.shevchenko@linux.intel.com>
References: <20220414131804.25227-1-andriy.shevchenko@linux.intel.com>
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

On Thu, 14 Apr 2022 16:18:04 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> While at it, reuse temporary device pointer in the same function.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Gah.  Can't argue with the patch as it's definitely an improvement, but
dev_name() was never the right thing to do if we couldn't get
the part name more directly. That field is supposed to be a chip
part number which dev_name is very unlikely to be!

Ah well - it's userspace ABI so not much we can do about it now...

Hence applied to the togreg branch of iio.git.  Note I'll not
be pushing that out as non rebasing for a few days so time
for others to review if they wish.

Thanks,

Jonathan

> ---
> v2: fixed subject to use proper part number in it
>  drivers/iio/imu/bmi160/bmi160_core.c | 27 ++++++---------------------
>  drivers/iio/imu/bmi160/bmi160_i2c.c  | 13 ++++++-------
>  drivers/iio/imu/bmi160/bmi160_spi.c  | 18 +++++++++++-------
>  3 files changed, 23 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> index 01336105792e..e7aec56ea136 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -11,10 +11,9 @@
>   */
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> -#include <linux/acpi.h>
>  #include <linux/delay.h>
>  #include <linux/irq.h>
> -#include <linux/of_irq.h>
> +#include <linux/property.h>
>  #include <linux/regulator/consumer.h>
>  
>  #include <linux/iio/iio.h>
> @@ -525,17 +524,6 @@ static const struct iio_info bmi160_info = {
>  	.attrs = &bmi160_attrs_group,
>  };
>  
> -static const char *bmi160_match_acpi_device(struct device *dev)
> -{
> -	const struct acpi_device_id *id;
> -
> -	id = acpi_match_device(dev->driver->acpi_match_table, dev);
> -	if (!id)
> -		return NULL;
> -
> -	return dev_name(dev);
> -}
> -
>  static int bmi160_write_conf_reg(struct regmap *regmap, unsigned int reg,
>  				 unsigned int mask, unsigned int bits,
>  				 unsigned int write_usleep)
> @@ -647,18 +635,18 @@ int bmi160_enable_irq(struct regmap *regmap, bool enable)
>  }
>  EXPORT_SYMBOL(bmi160_enable_irq);
>  
> -static int bmi160_get_irq(struct device_node *of_node, enum bmi160_int_pin *pin)
> +static int bmi160_get_irq(struct fwnode_handle *fwnode, enum bmi160_int_pin *pin)
>  {
>  	int irq;
>  
>  	/* Use INT1 if possible, otherwise fall back to INT2. */
> -	irq = of_irq_get_byname(of_node, "INT1");
> +	irq = fwnode_irq_get_byname(fwnode, "INT1");
>  	if (irq > 0) {
>  		*pin = BMI160_PIN_INT1;
>  		return irq;
>  	}
>  
> -	irq = of_irq_get_byname(of_node, "INT2");
> +	irq = fwnode_irq_get_byname(fwnode, "INT2");
>  	if (irq > 0)
>  		*pin = BMI160_PIN_INT2;
>  
> @@ -688,7 +676,7 @@ static int bmi160_config_device_irq(struct iio_dev *indio_dev, int irq_type,
>  		return -EINVAL;
>  	}
>  
> -	open_drain = of_property_read_bool(dev->of_node, "drive-open-drain");
> +	open_drain = device_property_read_bool(dev, "drive-open-drain");
>  
>  	return bmi160_config_pin(data->regmap, pin, open_drain, irq_mask,
>  				 BMI160_NORMAL_WRITE_USLEEP);
> @@ -872,9 +860,6 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
>  	if (ret)
>  		return ret;
>  
> -	if (!name && ACPI_HANDLE(dev))
> -		name = bmi160_match_acpi_device(dev);
> -
>  	indio_dev->channels = bmi160_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(bmi160_channels);
>  	indio_dev->name = name;
> @@ -887,7 +872,7 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
>  	if (ret)
>  		return ret;
>  
> -	irq = bmi160_get_irq(dev->of_node, &int_pin);
> +	irq = bmi160_get_irq(dev_fwnode(dev), &int_pin);
>  	if (irq > 0) {
>  		ret = bmi160_setup_irq(indio_dev, irq, int_pin);
>  		if (ret)
> diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
> index 26398614eddf..02f149d37b17 100644
> --- a/drivers/iio/imu/bmi160/bmi160_i2c.c
> +++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
> @@ -8,10 +8,9 @@
>   *      - 0x68 if SDO is pulled to GND
>   *      - 0x69 if SDO is pulled to VDDIO
>   */
> -#include <linux/acpi.h>
>  #include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
>  #include <linux/regmap.h>
>  
>  #include "bmi160.h"
> @@ -20,7 +19,7 @@ static int bmi160_i2c_probe(struct i2c_client *client,
>  			    const struct i2c_device_id *id)
>  {
>  	struct regmap *regmap;
> -	const char *name = NULL;
> +	const char *name;
>  
>  	regmap = devm_regmap_init_i2c(client, &bmi160_regmap_config);
>  	if (IS_ERR(regmap)) {
> @@ -31,6 +30,8 @@ static int bmi160_i2c_probe(struct i2c_client *client,
>  
>  	if (id)
>  		name = id->name;
> +	else
> +		name = dev_name(&client->dev);
>  
>  	return bmi160_core_probe(&client->dev, regmap, name, false);
>  }
> @@ -47,19 +48,17 @@ static const struct acpi_device_id bmi160_acpi_match[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, bmi160_acpi_match);
>  
> -#ifdef CONFIG_OF
>  static const struct of_device_id bmi160_of_match[] = {
>  	{ .compatible = "bosch,bmi160" },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, bmi160_of_match);
> -#endif
>  
>  static struct i2c_driver bmi160_i2c_driver = {
>  	.driver = {
>  		.name			= "bmi160_i2c",
> -		.acpi_match_table	= ACPI_PTR(bmi160_acpi_match),
> -		.of_match_table		= of_match_ptr(bmi160_of_match),
> +		.acpi_match_table	= bmi160_acpi_match,
> +		.of_match_table		= bmi160_of_match,
>  	},
>  	.probe		= bmi160_i2c_probe,
>  	.id_table	= bmi160_i2c_id,
> diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
> index 61389b41c6d9..24f7d75c7903 100644
> --- a/drivers/iio/imu/bmi160/bmi160_spi.c
> +++ b/drivers/iio/imu/bmi160/bmi160_spi.c
> @@ -5,9 +5,8 @@
>   * Copyright (c) 2016, Intel Corporation.
>   *
>   */
> -#include <linux/acpi.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
>  #include <linux/regmap.h>
>  #include <linux/spi/spi.h>
>  
> @@ -17,6 +16,7 @@ static int bmi160_spi_probe(struct spi_device *spi)
>  {
>  	struct regmap *regmap;
>  	const struct spi_device_id *id = spi_get_device_id(spi);
> +	const char *name;
>  
>  	regmap = devm_regmap_init_spi(spi, &bmi160_regmap_config);
>  	if (IS_ERR(regmap)) {
> @@ -24,7 +24,13 @@ static int bmi160_spi_probe(struct spi_device *spi)
>  			regmap);
>  		return PTR_ERR(regmap);
>  	}
> -	return bmi160_core_probe(&spi->dev, regmap, id->name, true);
> +
> +	if (id)
> +		name = id->name;
> +	else
> +		name = dev_name(&spi->dev);
> +
> +	return bmi160_core_probe(&spi->dev, regmap, name, true);
>  }
>  
>  static const struct spi_device_id bmi160_spi_id[] = {
> @@ -39,20 +45,18 @@ static const struct acpi_device_id bmi160_acpi_match[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, bmi160_acpi_match);
>  
> -#ifdef CONFIG_OF
>  static const struct of_device_id bmi160_of_match[] = {
>  	{ .compatible = "bosch,bmi160" },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, bmi160_of_match);
> -#endif
>  
>  static struct spi_driver bmi160_spi_driver = {
>  	.probe		= bmi160_spi_probe,
>  	.id_table	= bmi160_spi_id,
>  	.driver = {
> -		.acpi_match_table	= ACPI_PTR(bmi160_acpi_match),
> -		.of_match_table		= of_match_ptr(bmi160_of_match),
> +		.acpi_match_table	= bmi160_acpi_match,
> +		.of_match_table		= bmi160_of_match,
>  		.name			= "bmi160_spi",
>  	},
>  };

