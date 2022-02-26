Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC694C57BD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiBZSsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiBZSsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:48:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D151F584F;
        Sat, 26 Feb 2022 10:47:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90BDC60EE7;
        Sat, 26 Feb 2022 18:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56D5C340E8;
        Sat, 26 Feb 2022 18:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645901278;
        bh=mLAjK+X+l7vxBuPBU+HlWMUwUk3FTUq7sT2ElYBrhjE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nh+aBYBPe2rBUr+bEgqZlHH/VxLXD206V0lcP6vJbkmZwN4r9RVESbwxvsjP1IyyV
         9GNHxT3W4mjeSE9KICcsGi6kCOVLhsf6FF+jM8NGkjJzpPJUPvwndHgmFQC9KE2bd0
         yLZaT8FNZhVvHCRca/xjULatecWH9LTjoJ+bexbKi3BpPqWkUSk5+OG/ul3wKHmprs
         8uj0kdFdCANDM+cSLKAx1F4VIcilmvCT9/SbhGkeir22HkF37yIichIomRQai8HyBy
         xIwn34nZTZI3Ul7MKdIg5T5XmCW1ayuTGx+FdBvHuDSP2C+HfHGrCjN5xBPWyN6PVk
         HfbSNpxYy7pwg==
Date:   Sat, 26 Feb 2022 18:54:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v2 3/8] iio: accel: adxl345: Get rid of name parameter
 in adxl345_core_probe()
Message-ID: <20220226185458.6cd6848a@jic23-huawei>
In-Reply-To: <20220222090009.2060-3-andriy.shevchenko@linux.intel.com>
References: <20220222090009.2060-1-andriy.shevchenko@linux.intel.com>
        <20220222090009.2060-3-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
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

On Tue, 22 Feb 2022 11:00:04 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> As a preparation to switch to use device properties, get rid of name
> parameter in adxl345_core_probe(). Instead, choose it based on the type.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: no changes
>  drivers/iio/accel/adxl345.h      |  3 +--
>  drivers/iio/accel/adxl345_core.c | 15 +++++++++++++--
>  drivers/iio/accel/adxl345_i2c.c  |  3 +--
>  drivers/iio/accel/adxl345_spi.c  |  2 +-
>  4 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> index 5a68d4dac717..9b0d4f487c43 100644
> --- a/drivers/iio/accel/adxl345.h
> +++ b/drivers/iio/accel/adxl345.h
> @@ -13,7 +13,6 @@ enum adxl345_device_type {
>  	ADXL375 = 2,
>  };
>  
> -int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> -		       enum adxl345_device_type type, const char *name);
> +int adxl345_core_probe(struct device *dev, struct regmap *regmap, enum adxl345_device_type type);

Nit picking but I'm not that keen on these lines being so long as it doesn't
really help readability so I'd rather keep them sub 80 chars.

If I'm happy with everything else I might tidy that up whilst applying.

Thanks,

Jonathan



>  
>  #endif /* _ADXL345_H_ */
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 078e1029e49d..0f34c349aa1e 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -213,14 +213,25 @@ static void adxl345_powerdown(void *regmap)
>  	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STANDBY);
>  }
>  
> -int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> -		       enum adxl345_device_type type, const char *name)
> +int adxl345_core_probe(struct device *dev, struct regmap *regmap, enum adxl345_device_type type)
>  {
>  	struct adxl345_data *data;
>  	struct iio_dev *indio_dev;
> +	const char *name;
>  	u32 regval;
>  	int ret;
>  
> +	switch (type) {
> +	case ADXL345:
> +		name = "adxl345";
> +		break;
> +	case ADXL375:
> +		name = "adxl375";
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
>  	ret = regmap_read(regmap, ADXL345_REG_DEVID, &regval);
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "Error reading device ID\n");
> diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
> index 4c6efe2eefc1..1e42cf3a2991 100644
> --- a/drivers/iio/accel/adxl345_i2c.c
> +++ b/drivers/iio/accel/adxl345_i2c.c
> @@ -31,8 +31,7 @@ static int adxl345_i2c_probe(struct i2c_client *client,
>  	if (IS_ERR(regmap))
>  		return dev_err_probe(&client->dev, PTR_ERR(regmap), "Error initializing regmap\n");
>  
> -	return adxl345_core_probe(&client->dev, regmap, id->driver_data,
> -				  id->name);
> +	return adxl345_core_probe(&client->dev, regmap, id->driver_data);
>  }
>  
>  static const struct i2c_device_id adxl345_i2c_id[] = {
> diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
> index 72550132b1bb..34b7001d519f 100644
> --- a/drivers/iio/accel/adxl345_spi.c
> +++ b/drivers/iio/accel/adxl345_spi.c
> @@ -34,7 +34,7 @@ static int adxl345_spi_probe(struct spi_device *spi)
>  	if (IS_ERR(regmap))
>  		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
>  
> -	return adxl345_core_probe(&spi->dev, regmap, id->driver_data, id->name);
> +	return adxl345_core_probe(&spi->dev, regmap, id->driver_data);
>  }
>  
>  static const struct spi_device_id adxl345_spi_id[] = {

