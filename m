Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19874C5A9C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 12:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiB0LP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 06:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiB0LP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 06:15:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC195D19C;
        Sun, 27 Feb 2022 03:15:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21BF460DE0;
        Sun, 27 Feb 2022 11:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A7DC340F0;
        Sun, 27 Feb 2022 11:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645960518;
        bh=so8qhTMGW64BedNr/biV8QL/q7GJ4vQHYbvANp3zXPQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TkNDe4unsiM+LocSd26kfNVuyiFkB4p+IPBXLIcl5cZxPwDaGF7cTIiaxerWDEvDF
         ZwV/+UKgSy01TCRD3HXOXTnotVXfci85TMtrY++108Pv4PJDK/l5QGZajwsEnVmzC+
         ZAdrNDAeYS8/Me2xKo/8ujjtCnA48b1A6f5shIXiwtYJcZ0acbhXX4RpuWV4aYujG7
         TqsSbBDAovfjh4iRjotMlGeKHe6BbAhy4hFNXxxe9sMTU/vqPPwpiNPmfImTPPUmXU
         /6636MyW3I/cvL7ABPF5H/dEWPNBRLrWhF1b0uTS+1yCeuMeagE+tqESWheICe+5Rh
         C9asoVUm/FExQ==
Date:   Sun, 27 Feb 2022 11:22:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v2 4/8] iio: accel: adxl345: Make use of device
 properties
Message-ID: <20220227112221.0a03447d@jic23-huawei>
In-Reply-To: <20220222090009.2060-4-andriy.shevchenko@linux.intel.com>
References: <20220222090009.2060-1-andriy.shevchenko@linux.intel.com>
        <20220222090009.2060-4-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2022 11:00:05 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: no changes
>  drivers/iio/accel/adxl345.h      |  2 +-
>  drivers/iio/accel/adxl345_core.c |  5 ++++-
>  drivers/iio/accel/adxl345_i2c.c  | 11 ++++-------
>  drivers/iio/accel/adxl345_spi.c  |  3 +--
>  4 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> index 9b0d4f487c43..d7e67cb08538 100644
> --- a/drivers/iio/accel/adxl345.h
> +++ b/drivers/iio/accel/adxl345.h
> @@ -13,6 +13,6 @@ enum adxl345_device_type {
>  	ADXL375 = 2,
>  };
>  
> -int adxl345_core_probe(struct device *dev, struct regmap *regmap, enum adxl345_device_type type);
> +int adxl345_core_probe(struct device *dev, struct regmap *regmap);
>  
>  #endif /* _ADXL345_H_ */
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 0f34c349aa1e..315a408115b3 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  
>  #include <linux/iio/iio.h>
> @@ -213,14 +214,16 @@ static void adxl345_powerdown(void *regmap)
>  	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STANDBY);
>  }
>  
> -int adxl345_core_probe(struct device *dev, struct regmap *regmap, enum adxl345_device_type type)
> +int adxl345_core_probe(struct device *dev, struct regmap *regmap)
>  {
> +	enum adxl345_device_type type;
>  	struct adxl345_data *data;
>  	struct iio_dev *indio_dev;
>  	const char *name;
>  	u32 regval;
>  	int ret;
>  
> +	type = (uintptr_t)device_get_match_data(dev);
>  	switch (type) {
>  	case ADXL345:
>  		name = "adxl345";
> diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
> index 1e42cf3a2991..861d8477d799 100644
> --- a/drivers/iio/accel/adxl345_i2c.c
> +++ b/drivers/iio/accel/adxl345_i2c.c
> @@ -19,19 +19,16 @@ static const struct regmap_config adxl345_i2c_regmap_config = {
>  	.val_bits = 8,
>  };
>  
> -static int adxl345_i2c_probe(struct i2c_client *client,
> -			     const struct i2c_device_id *id)
> +static int adxl345_i2c_probe(struct i2c_client *client)
>  {
> +	enum adxl345_device_type type;
Not used - (via a build warning)

Jonathan

>  	struct regmap *regmap;
>  
> -	if (!id)
> -		return -ENODEV;
> -
>  	regmap = devm_regmap_init_i2c(client, &adxl345_i2c_regmap_config);
>  	if (IS_ERR(regmap))
>  		return dev_err_probe(&client->dev, PTR_ERR(regmap), "Error initializing regmap\n");
>  
> -	return adxl345_core_probe(&client->dev, regmap, id->driver_data);
> +	return adxl345_core_probe(&client->dev, regmap);
>  }
>  
>  static const struct i2c_device_id adxl345_i2c_id[] = {
> @@ -55,7 +52,7 @@ static struct i2c_driver adxl345_i2c_driver = {
>  		.name	= "adxl345_i2c",
>  		.of_match_table = adxl345_of_match,
>  	},
> -	.probe		= adxl345_i2c_probe,
> +	.probe_new	= adxl345_i2c_probe,
>  	.id_table	= adxl345_i2c_id,
>  };
>  
> diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
> index 34b7001d519f..ee4c50c8a95b 100644
> --- a/drivers/iio/accel/adxl345_spi.c
> +++ b/drivers/iio/accel/adxl345_spi.c
> @@ -22,7 +22,6 @@ static const struct regmap_config adxl345_spi_regmap_config = {
>  
>  static int adxl345_spi_probe(struct spi_device *spi)
>  {
> -	const struct spi_device_id *id = spi_get_device_id(spi);
>  	struct regmap *regmap;
>  
>  	/* Bail out if max_speed_hz exceeds 5 MHz */
> @@ -34,7 +33,7 @@ static int adxl345_spi_probe(struct spi_device *spi)
>  	if (IS_ERR(regmap))
>  		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
>  
> -	return adxl345_core_probe(&spi->dev, regmap, id->driver_data);
> +	return adxl345_core_probe(&spi->dev, regmap);
>  }
>  
>  static const struct spi_device_id adxl345_spi_id[] = {

