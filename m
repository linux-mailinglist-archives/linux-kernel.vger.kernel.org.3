Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2AB4BC96F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 17:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242678AbiBSQ4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 11:56:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242620AbiBSQ4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 11:56:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E3D20F6E;
        Sat, 19 Feb 2022 08:56:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C0B9B80881;
        Sat, 19 Feb 2022 16:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58C2C004E1;
        Sat, 19 Feb 2022 16:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645289785;
        bh=cino2dQZWLjiKLJnkvRKaH07YeivuoFw+I6EHne7xus=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BCcJ/ZzLcTG8DdctXxnw8eXj6r0O6bCjWZgVs0Hz9J9aGZfIfZD04IhKQ63G+VEDd
         9dANNr8A9Js8uQFeYg89X+d21LcWYhJwjbG0rgvjApT/2OsGwCY8Wr2QHm3Lckh39r
         /jkWhfhbHm9TAX2cuu1+vjrWa5OcogTG8l/Js+yMaCug4Lxyc/itY3AbHexCXcwza8
         ZlSLymgCtEI95pZ27iym+5O/uHROSqc97TQVhhp6qbOJgrTr89YZvn3PaMZWjqtKvm
         lkQSjkZaiQaimZBOgFv3fW3kqy3XdzebRew1XbmH26lQDkKwcugXhV44eFfjB73kiV
         M1eCniyuKfZHQ==
Date:   Sat, 19 Feb 2022 17:03:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     mchehab+huawei@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v3 12/13] iio: imu: add BNO055 I2C driver
Message-ID: <20220219170313.78e64ddd@jic23-huawei>
In-Reply-To: <20220217162710.33615-13-andrea.merello@gmail.com>
References: <20220217162710.33615-1-andrea.merello@gmail.com>
        <20220217162710.33615-13-andrea.merello@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2022 17:27:09 +0100
Andrea Merello <andrea.merello@gmail.com> wrote:

> This path adds an I2C driver for communicating to a BNO055 IMU via I2C
> bus and it enables the BNO055 core driver to work in this scenario.
> 
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>

Minor comment inline to add an of_device_id table.
Isn't i2c so much nicer than serial? :) 

Thanks,

Jonathan


> ---
>  drivers/iio/imu/bno055/Kconfig      | 11 +++++++
>  drivers/iio/imu/bno055/Makefile     |  1 +
>  drivers/iio/imu/bno055/bno055_i2c.c | 50 +++++++++++++++++++++++++++++
>  3 files changed, 62 insertions(+)
>  create mode 100644 drivers/iio/imu/bno055/bno055_i2c.c
> 
> diff --git a/drivers/iio/imu/bno055/Kconfig b/drivers/iio/imu/bno055/Kconfig
> index 8a83639ad2a9..3693a408e270 100644
> --- a/drivers/iio/imu/bno055/Kconfig
> +++ b/drivers/iio/imu/bno055/Kconfig
> @@ -12,3 +12,14 @@ config BOSCH_BNO055_SERIAL
>  
>  	  This driver can also be built as a module. If so, the module will be
>  	  called bno055_sl.
> +
> +config BOSCH_BNO055_I2C
> +	tristate "Bosch BNO055 attached via I2C bus"
> +	depends on I2C
> +	select REGMAP_I2C
> +	select BOSCH_BNO055_IIO
> +	help
> +	  Enable this to support Bosch BNO055 IMUs attached via I2C bus.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called bno055_i2c.
> diff --git a/drivers/iio/imu/bno055/Makefile b/drivers/iio/imu/bno055/Makefile
> index 416f0ff96de5..2fe2b0857903 100644
> --- a/drivers/iio/imu/bno055/Makefile
> +++ b/drivers/iio/imu/bno055/Makefile
> @@ -2,3 +2,4 @@
>  
>  obj-$(CONFIG_BOSCH_BNO055_IIO) += bno055.o
>  obj-$(CONFIG_BOSCH_BNO055_SERIAL) += bno055_sl.o
> +obj-$(CONFIG_BOSCH_BNO055_I2C) += bno055_i2c.o
> diff --git a/drivers/iio/imu/bno055/bno055_i2c.c b/drivers/iio/imu/bno055/bno055_i2c.c
> new file mode 100644
> index 000000000000..9900e2a4d905
> --- /dev/null
> +++ b/drivers/iio/imu/bno055/bno055_i2c.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Support for I2C-interfaced Bosch BNO055 IMU.
> + *
> + * Copyright (C) 2021 Istituto Italiano di Tecnologia
> + * Electronic Design Laboratory
> + * Written by Andrea Merello <andrea.merello@iit.it>
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/module.h>
> +
> +#include "bno055.h"
> +
> +#define BNO055_I2C_XFER_BURST_BREAK_THRESHOLD 3 /* FIXME */
> +
> +static int bno055_i2c_probe(struct i2c_client *client,
> +			    const struct i2c_device_id *id)
> +{
> +	struct regmap *regmap =
> +		devm_regmap_init_i2c(client, &bno055_regmap_config);
> +
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Unable to init register map");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	return bno055_probe(&client->dev, regmap,
> +			    BNO055_I2C_XFER_BURST_BREAK_THRESHOLD, true);
> +}
> +
> +static const struct i2c_device_id bno055_i2c_id[] = {
> +	{"bno055", 0},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, bno055_i2c_id);

No of_device_id table?  Whilst the fallback path that
usese the i2c_device_id will mostly work, it leaves us in theory
more susceptible to naming clashes and is generally not as nice.
Hence definitely prefer it if we have an of_device_id table as well
as the i2c_device_id one.

> +
> +static struct i2c_driver bno055_driver = {
> +	.driver = {
> +		.name = "bno055-i2c",
> +	},
> +	.probe = bno055_i2c_probe,
> +	.id_table = bno055_i2c_id
> +};
> +module_i2c_driver(bno055_driver);
> +
> +MODULE_AUTHOR("Andrea Merello");
> +MODULE_DESCRIPTION("Bosch BNO055 I2C interface");
> +MODULE_LICENSE("GPL v2");

