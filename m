Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD8E585FB4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 18:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237500AbiGaQDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 12:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiGaQD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:03:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281F8FD0B;
        Sun, 31 Jul 2022 09:03:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3311B80D12;
        Sun, 31 Jul 2022 16:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62694C433C1;
        Sun, 31 Jul 2022 16:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659283405;
        bh=Ew/ZQrZUcIW4AcnmrC7SCf1AnEp69vFi00O2yyTogV0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fIqSHDwGGBDALQgRMsY77xiXM/EDRksHqphcMOljuBNa2EvbV3Y8InFFRg3VXe42N
         9D3huV8KIrY+NI+3n3WukR+b0fX9oyT0FuxLSvOfA5CaLW50O4XtiYmibzirh2Gy57
         ooWKdobLBPRjExwA+y9WBzDRaWJGs1A7kQyT06K78j/Int6HX9Yw6aLxDuSxRL6bQ4
         nc2H5RyVAnhwOCCfDIOYG2M/YI97vUqI4KLOyLT1bqiYvrs5FcMl7Ww1h45vF/M/0S
         50e3KMM8mLuYrsD5NAldtqIMdmS5DZTEH97aCA3FCd6tBUkd0ksPVvY3k1nnGZhZuw
         8CeUpb0soXWOA==
Date:   Sun, 31 Jul 2022 17:13:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] iio: pressure: bmp280: Fix alignment for DMA
 safety
Message-ID: <20220731171337.0c9a2a09@jic23-huawei>
In-Reply-To: <e6f4055d1c2a535e645ce6c25091dd5b40cd5a2f.1658597501.git.ang.iglesiasg@gmail.com>
References: <cover.1658597501.git.ang.iglesiasg@gmail.com>
        <e6f4055d1c2a535e645ce6c25091dd5b40cd5a2f.1658597501.git.ang.iglesiasg@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jul 2022 19:39:10 +0200
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> Adds a DMA-safe buffer to driver data struct to store raw data from sensor
> 
> Updated calibration read functions to use DMA-safe buffers as well.
> In this case, as calibration data is only read at sensor initialization,
> the buffers are allocated with kmalloc and freed after being processed.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
A few comments inline.  This is more complex than it needs to be because
you can still use __be16 *buf; and index in the right steps.  Side effect
being it's aligned, so conversions will be cheaper as well.

> ---
>  drivers/iio/pressure/bmp280-core.c | 164 ++++++++++++++++++-----------
>  1 file changed, 103 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 60fba199c7a0..9311eeec8473 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -29,6 +29,7 @@
>  #include <linux/completion.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/random.h>
> +#include <asm/unaligned.h>
>  
>  #include "bmp280.h"
>  
> @@ -36,7 +37,19 @@
>   * These enums are used for indexing into the array of calibration
>   * coefficients for BMP180.
>   */
> -enum { AC1, AC2, AC3, AC4, AC5, AC6, B1, B2, MB, MC, MD };
> +enum {
> +	AC1 = 0,
> +	AC2 = 2,
> +	AC3 = 4,
> +	AC4 = 6,
> +	AC5 = 8,
> +	AC6 = 10,
> +	B1 = 12,
> +	B2 = 14,
> +	MB = 16,
> +	MC = 18,
> +	MD = 20,
Looks like we are specifying a size wrong somewhere as these are all 
multiples of 2.

> +};
>  
>  struct bmp180_calib {
>  	s16 AC1;
> @@ -104,6 +117,12 @@ struct bmp280_data {
>  	 * calculation.
>  	 */
>  	s32 t_fine;
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) may require the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	u8 buf[3] __aligned(IIO_DMA_MINALIGN);
So, on many platforms of interest (anything arm64) we are going to be
padding this struture out after this to 128 bytes anyway.  So no advantage
to keeping this short.  I'd just use this buffer for the calibration cases
as well and drop the extra allocations.  You'll waste space on x86/x86_64 but
meh, who cares about those legacy architectures :)


>  };
>  
>  struct bmp280_chip_info {
> @@ -135,8 +154,18 @@ struct bmp280_chip_info {
>   * These enums are used for indexing into the array of compensation
>   * parameters for BMP280.
>   */
> -enum { T1, T2, T3 };
> -enum { P1, P2, P3, P4, P5, P6, P7, P8, P9 };
> +enum { T1 = 0, T2 = 2, T3 = 4 };
> +enum {
> +	P1 = 0,
> +	P2 = 2,
> +	P3 = 4,
> +	P4 = 6,
> +	P5 = 8,
> +	P6 = 10,
> +	P7 = 12,
> +	P8 = 14,
> +	P9 = 16,
> +};
>  
>  static const struct iio_chan_spec bmp280_channels[] = {
>  	{
> @@ -159,51 +188,59 @@ static const struct iio_chan_spec bmp280_channels[] = {
>  static int bmp280_read_calib(struct bmp280_data *data, unsigned int chip)
>  {
>  	int ret;
> +	u8 *t_buf;
> +	u8 *p_buf;
>  	unsigned int tmp;
> -	__le16 l16;
> -	__be16 b16;
>  	struct device *dev = data->dev;
>  	struct bmp280_calib *calib = &data->calib.bmp280;
> -	__le16 t_buf[BMP280_COMP_TEMP_REG_COUNT / 2];
> -	__le16 p_buf[BMP280_COMP_PRESS_REG_COUNT / 2];
>  
> +	t_buf = kmalloc(BMP280_COMP_TEMP_REG_COUNT, GFP_KERNEL);
> +	if (!t_buf)
> +		return -ENOMEM;
>  	/* Read temperature calibration values. */
>  	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_TEMP_START,
>  			       t_buf, BMP280_COMP_TEMP_REG_COUNT);
>  	if (ret < 0) {
>  		dev_err(data->dev,
>  			"failed to read temperature calibration parameters\n");
> +		kfree(t_buf);
>  		return ret;
>  	}
>  
>  	/* Toss the temperature calibration data into the entropy pool */
>  	add_device_randomness(t_buf, sizeof(t_buf));
>  
> -	calib->T1 = le16_to_cpu(t_buf[T1]);
> -	calib->T2 = le16_to_cpu(t_buf[T2]);
> -	calib->T3 = le16_to_cpu(t_buf[T3]);
> +	calib->T1 = get_unaligned_le16(&t_buf[T1]);
> +	calib->T2 = get_unaligned_le16(&t_buf[T2]);
> +	calib->T3 = get_unaligned_le16(&t_buf[T3]);
> +	kfree(t_buf);
>  
> +	p_buf = kmalloc(BMP280_COMP_PRESS_REG_COUNT, GFP_KERNEL);
> +	if (!p_buf)
> +		return -ENOMEM;
>  	/* Read pressure calibration values. */
>  	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_PRESS_START,
>  			       p_buf, BMP280_COMP_PRESS_REG_COUNT);
>  	if (ret < 0) {
>  		dev_err(data->dev,
>  			"failed to read pressure calibration parameters\n");
> +		kfree(p_buf);
>  		return ret;
>  	}
>  
>  	/* Toss the pressure calibration data into the entropy pool */
>  	add_device_randomness(p_buf, sizeof(p_buf));
>  
> -	calib->P1 = le16_to_cpu(p_buf[P1]);
> -	calib->P2 = le16_to_cpu(p_buf[P2]);
> -	calib->P3 = le16_to_cpu(p_buf[P3]);
> -	calib->P4 = le16_to_cpu(p_buf[P4]);
> -	calib->P5 = le16_to_cpu(p_buf[P5]);
> -	calib->P6 = le16_to_cpu(p_buf[P6]);
> -	calib->P7 = le16_to_cpu(p_buf[P7]);
> -	calib->P8 = le16_to_cpu(p_buf[P8]);
> -	calib->P9 = le16_to_cpu(p_buf[P9]);
> +	calib->P1 = get_unaligned_le16(&p_buf[P1]);
> +	calib->P2 = get_unaligned_le16(&p_buf[P2]);
> +	calib->P3 = get_unaligned_le16(&p_buf[P3]);
> +	calib->P4 = get_unaligned_le16(&p_buf[P4]);
> +	calib->P5 = get_unaligned_le16(&p_buf[P5]);
> +	calib->P6 = get_unaligned_le16(&p_buf[P6]);
> +	calib->P7 = get_unaligned_le16(&p_buf[P7]);
> +	calib->P8 = get_unaligned_le16(&p_buf[P8]);
> +	calib->P9 = get_unaligned_le16(&p_buf[P9]);
> +	kfree(p_buf);
>  
>  	/*
>  	 * Read humidity calibration values.
> @@ -222,12 +259,12 @@ static int bmp280_read_calib(struct bmp280_data *data, unsigned int chip)
>  	}
>  	calib->H1 = tmp;
>  
> -	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H2, &l16, 2);
> +	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H2, data->buf, 2);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to read H2 comp value\n");
>  		return ret;
>  	}
> -	calib->H2 = sign_extend32(le16_to_cpu(l16), 15);
> +	calib->H2 = get_unaligned_le16(data->buf);
>  
>  	ret = regmap_read(data->regmap, BMP280_REG_COMP_H3, &tmp);
>  	if (ret < 0) {
> @@ -236,20 +273,20 @@ static int bmp280_read_calib(struct bmp280_data *data, unsigned int chip)
>  	}
>  	calib->H3 = tmp;
>  
> -	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H4, &b16, 2);
> +	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H4, data->buf, 2);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to read H4 comp value\n");
>  		return ret;
>  	}
> -	calib->H4 = sign_extend32(((be16_to_cpu(b16) >> 4) & 0xff0) |
> -				  (be16_to_cpu(b16) & 0xf), 11);
> +	calib->H4 = sign_extend32(((get_unaligned_be16(data->buf) >> 4) & 0xff0) |
> +				  (get_unaligned_be16(data->buf) & 0xf), 11);
>  
> -	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H5, &l16, 2);
> +	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H5, data->buf, 2);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to read H5 comp value\n");
>  		return ret;
>  	}
> -	calib->H5 = sign_extend32(((le16_to_cpu(l16) >> 4) & 0xfff), 11);
> +	calib->H5 = sign_extend32(((get_unaligned_le16(data->buf) >> 4) & 0xfff), 11);
>  
>  	ret = regmap_read(data->regmap, BMP280_REG_COMP_H6, &tmp);
>  	if (ret < 0) {
> @@ -344,16 +381,15 @@ static int bmp280_read_temp(struct bmp280_data *data,
>  			    int *val)
>  {
>  	int ret;
> -	__be32 tmp = 0;
>  	s32 adc_temp, comp_temp;
>  
> -	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB, &tmp, 3);
> +	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB, data->buf, 3);
>  	if (ret < 0) {
>  		dev_err(data->dev, "failed to read temperature\n");
>  		return ret;
>  	}
>  
> -	adc_temp = be32_to_cpu(tmp) >> 12;
> +	adc_temp = get_unaligned_be24(data->buf) >> 4;
>  	if (adc_temp == BMP280_TEMP_SKIPPED) {
>  		/* reading was skipped */
>  		dev_err(data->dev, "reading temperature skipped\n");
> @@ -377,7 +413,6 @@ static int bmp280_read_press(struct bmp280_data *data,
>  			     int *val, int *val2)
>  {
>  	int ret;
> -	__be32 tmp = 0;
>  	s32 adc_press;
>  	u32 comp_press;
>  
> @@ -386,13 +421,13 @@ static int bmp280_read_press(struct bmp280_data *data,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB, &tmp, 3);
> +	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB, data->buf, 3);
>  	if (ret < 0) {
>  		dev_err(data->dev, "failed to read pressure\n");
>  		return ret;
>  	}
>  
> -	adc_press = be32_to_cpu(tmp) >> 12;
> +	adc_press = get_unaligned_be24(data->buf) >> 4;
>  	if (adc_press == BMP280_PRESS_SKIPPED) {
>  		/* reading was skipped */
>  		dev_err(data->dev, "reading pressure skipped\n");
> @@ -408,7 +443,6 @@ static int bmp280_read_press(struct bmp280_data *data,
>  
>  static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
>  {
> -	__be16 tmp;
>  	int ret;
>  	s32 adc_humidity;
>  	u32 comp_humidity;
> @@ -418,13 +452,13 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB, &tmp, 2);
> +	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB, data->buf, 2);
>  	if (ret < 0) {
>  		dev_err(data->dev, "failed to read humidity\n");
>  		return ret;
>  	}
>  
> -	adc_humidity = be16_to_cpu(tmp);
> +	adc_humidity = get_unaligned_be16(data->buf);
>  	if (adc_humidity == BMP280_HUMIDITY_SKIPPED) {
>  		/* reading was skipped */
>  		dev_err(data->dev, "reading humidity skipped\n");
> @@ -755,56 +789,65 @@ static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
>  
>  static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
>  {
> -	__be16 tmp;
>  	int ret;
>  
>  	ret = bmp180_measure(data, BMP180_MEAS_TEMP);
>  	if (ret)
>  		return ret;
>  
> -	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB, &tmp, 2);
> +	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB, data->buf, 2);
>  	if (ret)
>  		return ret;
>  
> -	*val = be16_to_cpu(tmp);
> +	*val = get_unaligned_be16(data->buf);
>  
>  	return 0;
>  }
>  
>  static int bmp180_read_calib(struct bmp280_data *data, unsigned int chip)
>  {
> +	struct bmp180_calib *calib = &data->calib.bmp180;
> +	u8 *buf;
>  	int ret;
>  	int i;
> -	struct bmp180_calib *calib = &data->calib.bmp180;
> -	__be16 buf[BMP180_REG_CALIB_COUNT / 2];
> +
> +	buf = kmalloc(BMP180_REG_CALIB_COUNT, GFP_KERNEL);
No need to change the type of buf.  Keep it as __be16 *buf = kmalloc()...
That way your indexing still works nicely without needing to scatter *2 and += 2
throughout.  Note that if you embed this as I suggest above, just use a union so
you can overlap it with the u8 buffer.

> +	if (!buf)
> +		return -ENOMEM;
>  
>  	ret = regmap_bulk_read(data->regmap, BMP180_REG_CALIB_START, buf,
> -			       sizeof(buf));
> +			       BMP180_REG_CALIB_COUNT);
>  
> -	if (ret < 0)
> +	if (ret < 0) {
> +		kfree(buf);
>  		return ret;
> +	}
>  
>  	/* None of the words has the value 0 or 0xFFFF */
> -	for (i = 0; i < ARRAY_SIZE(buf); i++) {
> -		if (buf[i] == cpu_to_be16(0) || buf[i] == cpu_to_be16(0xffff))
> +	for (i = 0; i < BMP180_REG_CALIB_COUNT; i += 2) {
> +		if (get_unaligned_be16(&buf[i]) == cpu_to_be16(0) ||
> +		    get_unaligned_be16(&buf[i]) == cpu_to_be16(0xffff)) {
> +			kfree(buf);
>  			return -EIO;
> +		}
>  	}
>  
>  	/* Toss the calibration data into the entropy pool */
> -	add_device_randomness(buf, sizeof(buf));
> -
> -	calib->AC1 = be16_to_cpu(buf[AC1]);
> -	calib->AC2 = be16_to_cpu(buf[AC2]);
> -	calib->AC3 = be16_to_cpu(buf[AC3]);
> -	calib->AC4 = be16_to_cpu(buf[AC4]);
> -	calib->AC5 = be16_to_cpu(buf[AC5]);
> -	calib->AC6 = be16_to_cpu(buf[AC6]);
> -	calib->B1 = be16_to_cpu(buf[B1]);
> -	calib->B2 = be16_to_cpu(buf[B2]);
> -	calib->MB = be16_to_cpu(buf[MB]);
> -	calib->MC = be16_to_cpu(buf[MC]);
> -	calib->MD = be16_to_cpu(buf[MD]);
> -
> +	add_device_randomness(buf, BMP180_REG_CALIB_COUNT);
> +
> +	calib->AC1 = get_unaligned_be16(&buf[AC1]);
> +	calib->AC2 = get_unaligned_be16(&buf[AC2]);
> +	calib->AC3 = get_unaligned_be16(&buf[AC3]);
> +	calib->AC4 = get_unaligned_be16(&buf[AC4]);
> +	calib->AC5 = get_unaligned_be16(&buf[AC5]);
> +	calib->AC6 = get_unaligned_be16(&buf[AC6]);
> +	calib->B1 = get_unaligned_be16(&buf[B1]);
> +	calib->B2 = get_unaligned_be16(&buf[B2]);
> +	calib->MB = get_unaligned_be16(&buf[MB]);
> +	calib->MC = get_unaligned_be16(&buf[MC]);
> +	calib->MD = get_unaligned_be16(&buf[MD]);
> +
> +	kfree(buf);
>  	return 0;
>  }
>  
> @@ -852,18 +895,17 @@ static int bmp180_read_temp(struct bmp280_data *data, int *val)
>  static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
>  {
>  	int ret;
> -	__be32 tmp = 0;
>  	u8 oss = data->oversampling_press;
>  
>  	ret = bmp180_measure(data, BMP180_MEAS_PRESS_X(oss));
>  	if (ret)
>  		return ret;
>  
> -	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB, &tmp, 3);
> +	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB, data->buf, 3);
>  	if (ret)
>  		return ret;
>  
> -	*val = (be32_to_cpu(tmp) >> 8) >> (8 - oss);
> +	*val = get_unaligned_be24(data->buf) >> (8 - oss);
>  
>  	return 0;
>  }

