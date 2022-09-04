Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA31E5AC50A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 17:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbiIDPk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 11:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiIDPkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 11:40:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DF424F3D;
        Sun,  4 Sep 2022 08:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED723B80D70;
        Sun,  4 Sep 2022 15:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FCAC433C1;
        Sun,  4 Sep 2022 15:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662306019;
        bh=HrL9LAj9yHqB4kKNcDqzIc7XfVBgY80voHwlu/wF7Fc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YR2Rp7oSpcyUMUXxJd0E0B7gjC0GYKmAkxvhjwmgTTJgnahXqCEig6nf1+RDr/1Np
         cFwO8oyUz0s4IHonrb00xjiLP+o2vPAqDMtg4+2yKEKY/SYATVWPs8vZ76EaK7HoJ4
         ohCeQIs1/qQ2T7SQ8E67A5QRJMhPhHrXthdXCvk0jIW0RdmjcPiJENsHbfeGuYAJ51
         wVpzKf35a4wUeYTBPFH9ZmCgp6ON7sDC8ltyLjNWTH0yeEMdWjXI6FdtAylslPf02U
         Ovx4Qvmm9Rg39NMtQyNug1tcy9d8J9K0z6HwevKcYan1Gevr/0dChS2VHq7wKF4YFx
         MKA7uPiY/urPw==
Date:   Sun, 4 Sep 2022 16:06:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ciprian Regus <ciprian.regus@analog.com>
Cc:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] drivers: iio: adc: LTC2499 support
Message-ID: <20220904160611.11beb352@jic23-huawei>
In-Reply-To: <20220901121700.1325733-4-ciprian.regus@analog.com>
References: <20220901121700.1325733-1-ciprian.regus@analog.com>
        <20220901121700.1325733-4-ciprian.regus@analog.com>
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

On Thu, 1 Sep 2022 15:16:59 +0300
Ciprian Regus <ciprian.regus@analog.com> wrote:

> The LTC2499 is a 16-channel (eight differential), 24-bit,
> ADC with Easy Drive technology and a 2-wire, I2C interface.
> 
> Implement support for the LTC2499 ADC by extending the LTC2497
> driver. A new chip_info struct is added to differentiate between
> chip types and resolutions when reading data from the device.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/2499fe.pdf
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>

A few small comments inline, but looks pretty good to me.

Jonathan

> ---
> changes in v2:
>  - removed the bitfield.h and bitops.h includes, since they were not needed.
>  - removed a blank line.
>  - replaced the data buffer for the ltc2497_driverdata with a union.
>  - depending on frame size, i2c transfers use either 3 or 4 byte buffers, instead
>    of always using a __be32.
>  - added a comment which explains the output data format and how does sign extension.
>    happen.
>  - added the const modifier for the chip_info structs.
>  - renamed the chip_info struct to ltc2497_chip_info.
>  - renamed the chip_type enum to ltc2497_chip_type
>  - added probe fallback to using i2c_device_id in case OF fails.
>  - used BITS_TO_BYTES() instead of dividing by 8.
>  - used a tab instead of a space in a struct field declaration, which in v1 appeared as
>    if the line was deleted and added back.
>  - added back a trailing comma.
>  - rearranged variable declaration lines so that longer ones would be first.
>  - used pointers to a chip info struct in the i2c_device_id table, instead of enums. 
>  drivers/iio/adc/ltc2496.c      |  8 ++++-
>  drivers/iio/adc/ltc2497-core.c |  2 +-
>  drivers/iio/adc/ltc2497.c      | 56 +++++++++++++++++++++++++++++++---
>  drivers/iio/adc/ltc2497.h      | 11 +++++++
>  4 files changed, 70 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/ltc2496.c b/drivers/iio/adc/ltc2496.c
> index dfb3bb5997e5..bf89d5ae19af 100644
> --- a/drivers/iio/adc/ltc2496.c
> +++ b/drivers/iio/adc/ltc2496.c
> @@ -15,6 +15,7 @@
>  #include <linux/iio/driver.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/property.h>
>  
>  #include "ltc2497.h"
>  
> @@ -74,6 +75,7 @@ static int ltc2496_probe(struct spi_device *spi)
>  	spi_set_drvdata(spi, indio_dev);
>  	st->spi = spi;
>  	st->common_ddata.result_and_measure = ltc2496_result_and_measure;
> +	st->common_ddata.chip_info = device_get_match_data(dev);

Hmm. This driver doesn't provide the other i2c registration path
(i2c_device_id table) so this is fine.  Adding that table can be a problem
for whoever needs it sometime in the future (I'm fine with patches to add
it though if anyone wants to write one!)
>  
>  	return ltc2497core_probe(dev, indio_dev);
>  }
> @@ -85,8 +87,12 @@ static void ltc2496_remove(struct spi_device *spi)
>  	ltc2497core_remove(indio_dev);
>  }
>  
> +static const struct ltc2497_chip_info ltc2496_info = {
> +	.resolution = 16,
> +};
> +
>  static const struct of_device_id ltc2496_of_match[] = {
> -	{ .compatible = "lltc,ltc2496", },
> +	{ .compatible = "lltc,ltc2496", .data = &ltc2496_info, },
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
> index f7c786f37ceb..2f660015f34b 100644
> --- a/drivers/iio/adc/ltc2497.c
> +++ b/drivers/iio/adc/ltc2497.c
> @@ -12,6 +12,7 @@
>  #include <linux/iio/driver.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/property.h>
>  
>  #include "ltc2497.h"
>  
> @@ -19,11 +20,16 @@ struct ltc2497_driverdata {
>  	/* this must be the first member */
>  	struct ltc2497core_driverdata common_ddata;
>  	struct i2c_client *client;
> +	u32 recv_size;
> +	u32 sub_lsb;
>  	/*
>  	 * DMA (thus cache coherency maintenance) may require the
>  	 * transfer buffers to live in their own cache lines.
>  	 */
> -	__be32 buf __aligned(IIO_DMA_MINALIGN);
> +	union {
> +		__be32 d32;
> +		u8 d8[3];
> +	} data __aligned(IIO_DMA_MINALIGN);
>  };
>  
>  static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
> @@ -34,13 +40,29 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
>  	int ret;
>  
>  	if (val) {
> -		ret = i2c_master_recv(st->client, (char *)&st->buf, 3);
> +		if (st->recv_size == 3)
> +			ret = i2c_master_recv(st->client, (char *)&st->data.d8, st->recv_size);
> +		else
> +			ret = i2c_master_recv(st->client, (char *)&st->data.d32, st->recv_size);
> +
>  		if (ret < 0) {
>  			dev_err(&st->client->dev, "i2c_master_recv failed\n");
>  			return ret;
>  		}
>  
> -		*val = (be32_to_cpu(st->buf) >> 14) - (1 << 17);
> +		/*
> +		 * The data format is 16/24 bit 2s complement, but with an upper sign bit on the
> +		 * resolution + 1 position, which is set for positive values only. Given this
> +		 * bit's value, subtracting BIT(resolution + 1) from the ADC's result is
> +		 * equivalent to a sign extension.

Description looks good to me.  Thanks for adding.

> +		 */
> +		if (st->recv_size == 3) {
> +			*val = (get_unaligned_be24(st->data.d8) >> st->sub_lsb)
> +				- BIT(ddata->chip_info->resolution + 1);
> +		} else {
> +			*val = (be32_to_cpu(st->data.d32) >> st->sub_lsb)
> +				- BIT(ddata->chip_info->resolution + 1);
> +		}
>  	}
>  

>  
> +static const struct ltc2497_chip_info ltc2497_info[] = {
> +	[TYPE_LTC2497] = {
> +		.resolution = 16,
> +		.name = NULL,
> +	},
> +	[TYPE_LTC2499] = {
> +		.resolution = 24,
> +		.name = "ltc2499",
> +	},
> +};
> +
>  static const struct i2c_device_id ltc2497_id[] = {
> -	{ "ltc2497", 0 },
> +	{ "ltc2497", (kernel_ulong_t)&ltc2497_info[TYPE_LTC2497] },
> +	{ "ltc2499", (kernel_ulong_t)&ltc2497_info[TYPE_LTC2497] },

TYPE_LTC2499

Guess you haven't tested this particular path but should be easy to
force it by not setting the of_device_id table pointer (or you could
use a board file but that's more trouble than ti's worth).

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ltc2497_id);
>  
>  static const struct of_device_id ltc2497_of_match[] = {
> -	{ .compatible = "lltc,ltc2497", },
> +	{ .compatible = "lltc,ltc2497", .data = &ltc2497_info[TYPE_LTC2497] },
> +	{ .compatible = "lltc,ltc2499", .data = &ltc2497_info[TYPE_LTC2499] },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, ltc2497_of_match);
> diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
> index d0b42dd6b8ad..95f6a5f4d4a6 100644
> --- a/drivers/iio/adc/ltc2497.h
> +++ b/drivers/iio/adc/ltc2497.h
> @@ -4,9 +4,20 @@
>  #define LTC2497_CONFIG_DEFAULT		LTC2497_ENABLE
>  #define LTC2497_CONVERSION_TIME_MS	150ULL
>  
> +enum ltc2497_chip_type {
> +	TYPE_LTC2496,

Hmm. this is a little interesting given there is no
such entry in the info table so that table will get pushed out
to have an empty first entry.  Maybe push this chip_type definition
down into the relevant c file and drop the LTC2496 entry (which will
then seem fine as that .c file doesn't cover that part.

> +	TYPE_LTC2497,
> +	TYPE_LTC2499,
> +};
> +

