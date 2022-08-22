Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B611D59C9AE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiHVUME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiHVUMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:12:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F386C53D20;
        Mon, 22 Aug 2022 13:12:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 859936129B;
        Mon, 22 Aug 2022 20:12:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BF9C433D6;
        Mon, 22 Aug 2022 20:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661199119;
        bh=TKo1ySgb4LWwHNOCd32+WQ8McSFwQpGEUUmVqFJEa90=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tmlo4OZcZF4IZHSTHqXKF7FWcdXyagPnm/D853y1yUY6jUh0yxfkU5pLdJ0IommDG
         sfNZCQs86fsJXIfL9mzKyrkfcdRt/GxtV4d9749aAAFPkr/AQL+CPvabU2ri5kPpmC
         yp917CSyQxQuavWI6JWZm0o8MLqnBgWdGlRN1HsRUZQg8bpQzNrGJnMnU2rLwuOkjR
         5E17+kcBqEAFDr1j9kxpPq+XEgKXqBpjHMW9gYxWsm40Yvv8R275SkEANnx17feMyo
         ELXXNA0y8VbtTwsZH0wcd1k76Nlkxq6JEs6YOavN4q/aXWMolRJtkZmYv5QHYnEhyF
         1NRz1UHJYZZWQ==
Date:   Mon, 22 Aug 2022 20:37:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ciprian Regus <ciprian.regus@analog.com>
Cc:     <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/3] drivers: iio: adc: LTC2499 support
Message-ID: <20220822203731.29c4c33b@jic23-huawei>
In-Reply-To: <20220822125106.1106798-3-ciprian.regus@analog.com>
References: <20220822125106.1106798-1-ciprian.regus@analog.com>
        <20220822125106.1106798-3-ciprian.regus@analog.com>
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

On Mon, 22 Aug 2022 15:51:05 +0300
Ciprian Regus <ciprian.regus@analog.com> wrote:

> The LTC2499 is a 16-channel (eight differential), 24-bit,
> ADC with Easy Drive technology and a 2-wire, I2C interface.
> 
> Implement support for the LTC2499 ADC by extending the LTC2497
> driver. A new chip_info struct is added to differentiate between
> chip types and resolutions when reading data from the device.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/2499fe.pdf
> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
Hi Ciprian,

Various comments inline.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ltc2496.c      |  8 +++++++-
>  drivers/iio/adc/ltc2497-core.c |  2 +-
>  drivers/iio/adc/ltc2497.c      | 34 +++++++++++++++++++++++++++++-----
>  drivers/iio/adc/ltc2497.h      | 13 ++++++++++++-
>  4 files changed, 49 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ltc2496.c b/drivers/iio/adc/ltc2496.c
> index dfb3bb5997e5..98338104c24a 100644
> --- a/drivers/iio/adc/ltc2496.c
> +++ b/drivers/iio/adc/ltc2496.c
> @@ -14,6 +14,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/driver.h>
>  #include <linux/module.h>
> +#include <linux/property.h>
why?

>  #include <linux/mod_devicetable.h>
>  
>  #include "ltc2497.h"
> @@ -74,6 +75,7 @@ static int ltc2496_probe(struct spi_device *spi)
>  	spi_set_drvdata(spi, indio_dev);
>  	st->spi = spi;
>  	st->common_ddata.result_and_measure = ltc2496_result_and_measure;
> +	st->common_ddata.chip_info = device_get_match_data(dev);
>  
>  	return ltc2497core_probe(dev, indio_dev);
>  }
> @@ -85,8 +87,12 @@ static void ltc2496_remove(struct spi_device *spi)
>  	ltc2497core_remove(indio_dev);
>  }
>  
> +static struct chip_info ltc2496_info = {
> +	.resolution = 16,
> +};
> +
>  static const struct of_device_id ltc2496_of_match[] = {
> -	{ .compatible = "lltc,ltc2496", },
> +	{ .compatible = "lltc,ltc2496", .data = (void *)&ltc2496_info },

as below. Take the chip_info structure const and drop the cast.

>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, ltc2496_of_match);
> diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
> index 2a485c8a1940..b2752399402c 100644
> --- a/drivers/iio/adc/ltc2497-core.c
> +++ b/drivers/iio/adc/ltc2497-core.c
> @@ -95,7 +95,7 @@ static int ltc2497core_read_raw(struct iio_dev *indio_dev,
>  			return ret;
>  
>  		*val = ret / 1000;
> -		*val2 = 17;
> +		*val2 = ddata->chip_info->resolution + 1;
>  
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  
> diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> index f7c786f37ceb..bb5e0d4301e2 100644
> --- a/drivers/iio/adc/ltc2497.c
> +++ b/drivers/iio/adc/ltc2497.c
> @@ -7,10 +7,14 @@
>   * Datasheet: http://cds.linear.com/docs/en/datasheet/2497fd.pdf
>   */
>  
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>

Not immediately obvious why these need adding as part of this patch.
If just general include improvement, separate patch please.

> +
Why blank line?
>  #include <linux/i2c.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/driver.h>
>  #include <linux/module.h>
> +#include <linux/property.h>

May make sense, but not obvious why it's in this patch.
If it's missing and should be present, please do it in a separate patch.

>  #include <linux/mod_devicetable.h>
>  
>  #include "ltc2497.h"
> @@ -19,6 +23,8 @@ struct ltc2497_driverdata {
>  	/* this must be the first member */
>  	struct ltc2497core_driverdata common_ddata;
>  	struct i2c_client *client;
> +	u32 recv_size;
> +	u32 sub_lsb;

>  	/*
>  	 * DMA (thus cache coherency maintenance) may require the
>  	 * transfer buffers to live in their own cache lines.
> @@ -34,13 +40,14 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
>  	int ret;
>  
>  	if (val) {
> -		ret = i2c_master_recv(st->client, (char *)&st->buf, 3);
> +		ret = i2c_master_recv(st->client, (char *)&st->buf, st->recv_size);
Not helpful yet, but there was a patch series under review form Jason Gerecke that
changed the i2c transfer commands to use a u8.  

Which raises a question. buf is a __be32 which is rather odd given size of 3 in original
code.  If we have a case where it needs to have separate types for different transfers, use
a union.

>  		if (ret < 0) {
>  			dev_err(&st->client->dev, "i2c_master_recv failed\n");
>  			return ret;
>  		}
>  
> -		*val = (be32_to_cpu(st->buf) >> 14) - (1 << 17);

Old code here is less than ideal, should be reading into 3 bytes then using
the be24 accesors. Please fix whilst here.  You will need multiple paths here
depending on size.

> +		*val = (be32_to_cpu(st->buf) >> st->sub_lsb) -
> +			BIT(ddata->chip_info->resolution + 1);
>  	}
>  
>  	ret = i2c_smbus_write_byte(st->client,
> @@ -54,6 +61,7 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
>  static int ltc2497_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> +	u32 resolution;
>  	struct iio_dev *indio_dev;
>  	struct ltc2497_driverdata *st;
>  	struct device *dev = &client->dev;
> @@ -70,6 +78,11 @@ static int ltc2497_probe(struct i2c_client *client,
>  	i2c_set_clientdata(client, indio_dev);
>  	st->client = client;
>  	st->common_ddata.result_and_measure = ltc2497_result_and_measure;
> +	st->common_ddata.chip_info = device_get_match_data(dev);
> +
> +	resolution = st->common_ddata.chip_info->resolution;
> +	st->sub_lsb = 31 - (resolution + 1);
> +	st->recv_size = resolution / BITS_PER_BYTE + 1;
>  
>  	return ltc2497core_probe(dev, indio_dev);
>  }
> @@ -83,15 +96,26 @@ static int ltc2497_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> +static struct chip_info ltc2497_info[] = {

Should be const - which is why you need the cast below.

> +	[TYPE_LTC2497] = {
> +		.resolution = 16,
> +	},
> +	[TYPE_LTC2499] = {
> +		.resolution = 24,
> +	}
> +};
> +
>  static const struct i2c_device_id ltc2497_id[] = {
> -	{ "ltc2497", 0 },
> +	{ "ltc2497", TYPE_LTC2497 },
> +	{ "ltc2499", TYPE_LTC2499 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ltc2497_id);
>  
>  static const struct of_device_id ltc2497_of_match[] = {
> -	{ .compatible = "lltc,ltc2497", },
> -	{},
> +	{ .compatible = "lltc,ltc2497", .data = (void *)&ltc2497_info[TYPE_LTC2497] },
> +	{ .compatible = "lltc,ltc2499", .data = (void *)&ltc2497_info[TYPE_LTC2499] },
Cast is a bad sign.  Reason above.

> +	{}
>  };
>  MODULE_DEVICE_TABLE(of, ltc2497_of_match);
>  
> diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
> index d0b42dd6b8ad..f4d939cfd48b 100644
> --- a/drivers/iio/adc/ltc2497.h
> +++ b/drivers/iio/adc/ltc2497.h
> @@ -4,9 +4,20 @@
>  #define LTC2497_CONFIG_DEFAULT		LTC2497_ENABLE
>  #define LTC2497_CONVERSION_TIME_MS	150ULL
>  
> +enum chip_type {
> +	TYPE_LTC2496,
> +	TYPE_LTC2497,
> +	TYPE_LTC2499
> +};
> +
> +struct chip_info {
> +	u32 resolution;
> +};
> +
>  struct ltc2497core_driverdata {
>  	struct regulator *ref;
> -	ktime_t	time_prev;
> +	ktime_t time_prev;
I'm staring at this and can't see the difference between the two lines.
Closer inspection (i.e. messing with the stuff around it) tells me line
you are removing has a tab when should be a space.  Whilst trivial please
call that out in patch description (or do it as a separate patch).

> +	const struct chip_info *chip_info;
>  	u8 addr_prev;
>  	int (*result_and_measure)(struct ltc2497core_driverdata *ddata,
>  				  u8 address, int *val);

