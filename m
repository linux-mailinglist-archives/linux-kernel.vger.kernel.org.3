Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB79591FF2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 15:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiHNNzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 09:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiHNNzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 09:55:05 -0400
X-Greylist: delayed 132 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 14 Aug 2022 06:55:03 PDT
Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88311CB3C;
        Sun, 14 Aug 2022 06:55:03 -0700 (PDT)
Received: from [90.243.5.40] (port=34492 helo=jic23-huawei)
        by mailhub-cam-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1oNE39-00FxlA-SQ; Sun, 14 Aug 2022 14:53:08 +0100
Date:   Sun, 14 Aug 2022 15:03:22 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] iio: pressure: bmp280: Fix alignment for DMA
 safety
Message-ID: <20220814150255.4f24fa9d@jic23-huawei>
In-Reply-To: <49086f5c1401d7d28ebf921a67b49f8403ddb16a.1659872590.git.ang.iglesiasg@gmail.com>
References: <cover.1659872590.git.ang.iglesiasg@gmail.com>
        <49086f5c1401d7d28ebf921a67b49f8403ddb16a.1659872590.git.ang.iglesiasg@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 19
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  7 Aug 2022 13:55:15 +0200
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> Adds DMA-safe buffers to driver data struct to store raw data from sensors
> 
> The multiple buffers used thorough the driver share the same memory
> allocated as part of the device data instance. The union containing
> the buffers is aligned to allow safe usage with DMA operations, such
> as regmap bulk read calls.
> 
> Updated measurement and calibration reading functions to use the new,
> DMA-safe, buffers.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
Hi Angel,

As you are doing a v6 anyway to address Andy's review, I
took another look and have a few additional comments below.
> ---
>  drivers/iio/pressure/bmp280-core.c | 122 ++++++++++++++---------------
>  drivers/iio/pressure/bmp280.h      |   3 +
>  2 files changed, 64 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index a109c2609896..4cd657dcbfed 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -31,6 +31,7 @@
>  #include <linux/completion.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/random.h>
> +#include <asm/unaligned.h>
>  
>  #include "bmp280.h"
>  
> @@ -106,6 +107,18 @@ struct bmp280_data {
>  	 * calculation.
>  	 */
>  	s32 t_fine;
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) may require the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	union {
> +		/* sensor data buffer */
> +		u8 data[3];
__le16 le16;
__be16 be16; 

added here would simplify some of the other changes below.

> +		/* calibration data buffers */
> +		__le16 bmp280_cal[BMP280_CONTIGUOUS_CALIB_REGS / 2];
> +		__be16 bmp180_cal[BMP180_REG_CALIB_COUNT / 2];
> +	} buf __aligned(IIO_DMA_MINALIGN);
>  };
>  
>  struct bmp280_chip_info {
> @@ -162,41 +175,29 @@ static int bmp280_read_calib(struct bmp280_data *data, unsigned int chip)
>  {
>  	int ret;
>  	unsigned int tmp;
> -	__le16 l16;
> -	__be16 b16;
>  	struct device *dev = data->dev;
> +	__le16 *t_buf = data->buf.bmp280_cal;
> +	__le16 *p_buf = &data->buf.bmp280_cal[T3+1];

spaces around +

>  	struct bmp280_calib *calib = &data->calib.bmp280;
> -	__le16 t_buf[BMP280_COMP_TEMP_REG_COUNT / 2];
> -	__le16 p_buf[BMP280_COMP_PRESS_REG_COUNT / 2];
>  
>  	/* Read temperature calibration values. */
>  	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_TEMP_START,
> -			       t_buf, BMP280_COMP_TEMP_REG_COUNT);
> +			       data->buf.bmp280_cal, sizeof(data->buf.bmp280_cal));
Given we don't use the local variable until later (as can't get the size from it,
I would suggest only setting it further down.

>  	if (ret < 0) {
>  		dev_err(data->dev,
>  			"failed to read temperature calibration parameters\n");
>  		return ret;
>  	}
>  
> -	/* Toss the temperature calibration data into the entropy pool */
> -	add_device_randomness(t_buf, sizeof(t_buf));
> +	/* Toss the temperature and pressure calibration data into the entropy pool */
> +	add_device_randomness(data->buf.bmp280_cal, sizeof(data->buf.bmp280_cal));
>  
like here.
	t_buf = data->bmp280_cal;

or just don't bother with those at all as they don't greatly help readability over
	calib->T1 = le16_to_cpu(data->bmp280_cal[T1]);
similar for p_buf.
Note I haven't looked at the existing code to see if there are other reasons to
use t_buf etc, so  may be wrong on this!
It will as make this patch more complex even if the code ends up simpler as a result.

> +	/* parse temperature calibration data */
>  	calib->T1 = le16_to_cpu(t_buf[T1]);
>  	calib->T2 = le16_to_cpu(t_buf[T2]);
>  	calib->T3 = le16_to_cpu(t_buf[T3]);
>  
> -	/* Read pressure calibration values. */
> -	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_PRESS_START,
> -			       p_buf, BMP280_COMP_PRESS_REG_COUNT);
> -	if (ret < 0) {
> -		dev_err(data->dev,
> -			"failed to read pressure calibration parameters\n");
> -		return ret;
> -	}
> -
> -	/* Toss the pressure calibration data into the entropy pool */
> -	add_device_randomness(p_buf, sizeof(p_buf));
> -
> +	/* parse pressure calibration data */
>  	calib->P1 = le16_to_cpu(p_buf[P1]);
>  	calib->P2 = le16_to_cpu(p_buf[P2]);
>  	calib->P3 = le16_to_cpu(p_buf[P3]);
> @@ -224,12 +225,12 @@ static int bmp280_read_calib(struct bmp280_data *data, unsigned int chip)
>  	}
>  	calib->H1 = tmp;
>  
> -	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H2, &l16, 2);
> +	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H2, data->buf.data, 2);

Bit nasty to read little endian into buf.data which I think is a u8 array.
Maybe we need another entry in that union for each of le16 and be16 similar to the
local variables previously in this function?
 
>  	if (ret < 0) {
>  		dev_err(dev, "failed to read H2 comp value\n");
>  		return ret;
>  	}
> -	calib->H2 = sign_extend32(le16_to_cpu(l16), 15);
> +	calib->H2 = get_unaligned_le16(data->buf.data);
>  
>  	ret = regmap_read(data->regmap, BMP280_REG_COMP_H3, &tmp);
>  	if (ret < 0) {
> @@ -238,20 +239,20 @@ static int bmp280_read_calib(struct bmp280_data *data, unsigned int chip)
>  	}
>  	calib->H3 = tmp;
>  
> -	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H4, &b16, 2);
> +	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H4, data->buf.data, 2);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to read H4 comp value\n");
>  		return ret;
>  	}
> -	calib->H4 = sign_extend32(((be16_to_cpu(b16) >> 4) & 0xff0) |
> -				  (be16_to_cpu(b16) & 0xf), 11);
> +	calib->H4 = sign_extend32(((get_unaligned_be16(data->buf.data) >> 4) & 0xff0) |
> +				  (get_unaligned_be16(data->buf.data) & 0xf), 11);
>  
> -	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H5, &l16, 2);
> +	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H5, data->buf.data, 2);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to read H5 comp value\n");
>  		return ret;
>  	}
> -	calib->H5 = sign_extend32(((le16_to_cpu(l16) >> 4) & 0xfff), 11);
> +	calib->H5 = sign_extend32(((get_unaligned_le16(data->buf.data) >> 4) & 0xfff), 11);
>  
>  	ret = regmap_read(data->regmap, BMP280_REG_COMP_H6, &tmp);
>  	if (ret < 0) {

...

>  static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
>  {
> -	__be16 tmp;
>  	int ret;
>  	s32 adc_humidity;
>  	u32 comp_humidity;
> @@ -420,13 +420,14 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB, &tmp, 2);
> +	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB,
> +			       data->buf.data, 2);
>  	if (ret < 0) {
>  		dev_err(data->dev, "failed to read humidity\n");
>  		return ret;
>  	}
>  
> -	adc_humidity = be16_to_cpu(tmp);
> +	adc_humidity = get_unaligned_be16(data->buf.data);

We are only unaligned because data is u8 and a dumb compiler might not realize the
alignment is forced.  Use the suggestion above of a couple more entries in the
union and we can switch back to be16_to_cpu()

>  	if (adc_humidity == BMP280_HUMIDITY_SKIPPED) {
>  		/* reading was skipped */
>  		dev_err(data->dev, "reading humidity skipped\n");
> @@ -767,7 +768,6 @@ static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
>  

