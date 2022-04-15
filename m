Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C24502DDA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 18:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355899AbiDOQoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 12:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237892AbiDOQoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 12:44:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E525DAFE0;
        Fri, 15 Apr 2022 09:41:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6944B807E7;
        Fri, 15 Apr 2022 16:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841CDC385A5;
        Fri, 15 Apr 2022 16:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650040901;
        bh=XITfwtrWiieCoPbYwSITipPQbv166TbyJPrWPrM5rDc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h+76pOD44SMOeceROMgajM3K40gLojwH6erAiXPhSENdIKQfCtBnuCTOPALpxzClz
         qPTt2IUKFncH4RM2J4WJ1N0RLicBRABf6HqDTYJLTT4XZmoo1+qdiMISRXhmKykT0L
         DbpcFDllr3mtKb4ONsdU5uhh/xcMXL1Ziwhpf0juknwX4VRpxpGJCcTm6XznENMME/
         IUeMQ6OweLJnx//Tr3ShseTdcSCfvC/xNbH5ubuWfSRPRKlGY/9QdTue4dDlB2U+9h
         G6wR/HmVFTlINYZIJ9rYKqHiWLnSGCD0I+v8qxIho66+aCTHEkKHVeiIvtukVlfVKu
         K422AcxsZaPyw==
Date:   Fri, 15 Apr 2022 17:49:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     mchehab+huawei@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v4 13/14] iio: imu: add BNO055 I2C driver
Message-ID: <20220415174938.51c81082@jic23-huawei>
In-Reply-To: <20220415130005.85879-14-andrea.merello@gmail.com>
References: <20220415130005.85879-1-andrea.merello@gmail.com>
        <20220415130005.85879-14-andrea.merello@gmail.com>
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

On Fri, 15 Apr 2022 15:00:04 +0200
Andrea Merello <andrea.merello@gmail.com> wrote:

> From: Andrea Merello <andrea.merello@iit.it>
> 
> This path adds an I2C driver for communicating to a BNO055 IMU via I2C
> bus and it enables the BNO055 core driver to work in this scenario.
> 
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>
One trivial comment inline.

...
> diff --git a/drivers/iio/imu/bno055/Makefile b/drivers/iio/imu/bno055/Makefile
> index 20128b1a1afc..20f911aad94b 100644
> --- a/drivers/iio/imu/bno055/Makefile
> +++ b/drivers/iio/imu/bno055/Makefile
> @@ -2,5 +2,6 @@
>  
>  obj-$(CONFIG_BOSCH_BNO055_IIO) += bno055.o
>  obj-$(CONFIG_BOSCH_BNO055_SERIAL) += bno055_ser.o
> +obj-$(CONFIG_BOSCH_BNO055_I2C) += bno055_i2c.o
>  
>  CFLAGS_bno055_ser.o := -I$(src)
> diff --git a/drivers/iio/imu/bno055/bno055_i2c.c b/drivers/iio/imu/bno055/bno055_i2c.c
> new file mode 100644
> index 000000000000..d59bb4e661be
> --- /dev/null
> +++ b/drivers/iio/imu/bno055/bno055_i2c.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Support for I2C-interfaced Bosch BNO055 IMU.
> + *
> + * Copyright (C) 2021-2022 Istituto Italiano di Tecnologia
> + * Electronic Design Laboratory
> + * Written by Andrea Merello <andrea.merello@iit.it>
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/module.h>
Please add an include of
mod_devicetable.h for the struct of_device_id etc definitions

> +#include <linux/regmap.h>
> +
> +#include "bno055.h"
> +
> +#define BNO055_I2C_XFER_BURST_BREAK_THRESHOLD 3 /* FIXME */
> +
> +static int bno055_i2c_probe(struct i2c_client *client)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_i2c(client, &bno055_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(regmap),
> +				     "Unable to init register map");
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
> +
> +static const struct of_device_id __maybe_unused bno055_i2c_of_match[] = {
> +	{ .compatible = "bosch,bno055" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, bno055_i2c_of_match);
> +
> +static struct i2c_driver bno055_driver = {
> +	.driver = {
> +		.name = "bno055-i2c",
> +		.of_match_table = of_match_ptr(bno055_i2c_of_match),
> +	},
> +	.probe_new = bno055_i2c_probe,
> +	.id_table = bno055_i2c_id,
> +};
> +module_i2c_driver(bno055_driver);
> +
> +MODULE_AUTHOR("Andrea Merello");
> +MODULE_DESCRIPTION("Bosch BNO055 I2C interface");
> +MODULE_IMPORT_NS(IIO_BNO055);
> +MODULE_LICENSE("GPL");

