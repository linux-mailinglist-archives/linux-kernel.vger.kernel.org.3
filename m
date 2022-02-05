Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C284AAA73
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 18:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236833AbiBEROZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 12:14:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45216 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240832AbiBEROX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:14:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53B9060FB7;
        Sat,  5 Feb 2022 17:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261BAC340E8;
        Sat,  5 Feb 2022 17:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644081262;
        bh=ZEOaXagLLRIjL6zzyr5r/IJT99XQbQrCaHR/bL1BVqI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bYMP3UMjcGXTuec6peKx/JjMWS+Pa1draUsvPJcT22FX0c4QbpRaIcEA5EmIGw3aB
         5N+DWXRSO0BcJaTRQIlbGpiKeQmGhzAGpP7oQA5LTpHOdlBYIQehx9mcdWCPxrJh/O
         XfBFEs3pobGK6fEEo8U/5DnI5/ieZvrci1N9sfhFFAelxOcv1sPbZMVUscI/MVaK8K
         PSNxS0xK6JDBrtRI0G4S80d+bT8vnJ0FinUgG947otHycK+W7RU05+MLxheB5582H0
         aBTRBuohrOeAsZOFno49Gywlmlkv5p8gOjFAVZTb24cITzMcz4F47QSQla5+Zc70Ua
         LQTi/r4ewJNlQ==
Date:   Sat, 5 Feb 2022 17:20:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v2 1/1] iio: frequency: adf4350: Make use of device
 properties
Message-ID: <20220205172054.4c6e3013@jic23-huawei>
In-Reply-To: <20220203110006.4291-1-andriy.shevchenko@linux.intel.com>
References: <20220203110006.4291-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Feb 2022 13:00:06 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Whilst it's long each individual change is simple, so applied to the togreg
branch of iio.git and pushed out as testing to see if the autobuilders
can find anything we missed.

Thanks,

Jonathan


> ---
> v2: fixed typo (lkp)
>  drivers/iio/frequency/adf4350.c | 103 +++++++++++++-------------------
>  1 file changed, 42 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
> index 3d9eba716b69..9af20a51540d 100644
> --- a/drivers/iio/frequency/adf4350.c
> +++ b/drivers/iio/frequency/adf4350.c
> @@ -7,17 +7,18 @@
>  
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
>  #include <linux/spi/spi.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/err.h>
> -#include <linux/module.h>
>  #include <linux/gcd.h>
>  #include <linux/gpio/consumer.h>
>  #include <asm/div64.h>
>  #include <linux/clk.h>
> -#include <linux/of.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -381,10 +382,8 @@ static const struct iio_info adf4350_info = {
>  	.debugfs_reg_access = &adf4350_reg_access,
>  };
>  
> -#ifdef CONFIG_OF
>  static struct adf4350_platform_data *adf4350_parse_dt(struct device *dev)
>  {
> -	struct device_node *np = dev->of_node;
>  	struct adf4350_platform_data *pdata;
>  	unsigned int tmp;
>  
> @@ -392,101 +391,83 @@ static struct adf4350_platform_data *adf4350_parse_dt(struct device *dev)
>  	if (!pdata)
>  		return NULL;
>  
> -	snprintf(&pdata->name[0], SPI_NAME_SIZE - 1, "%pOFn", np);
> +	snprintf(pdata->name, sizeof(pdata->name), "%pfw", dev_fwnode(dev));
>  
>  	tmp = 10000;
> -	of_property_read_u32(np, "adi,channel-spacing", &tmp);
> +	device_property_read_u32(dev, "adi,channel-spacing", &tmp);
>  	pdata->channel_spacing = tmp;
>  
>  	tmp = 0;
> -	of_property_read_u32(np, "adi,power-up-frequency", &tmp);
> +	device_property_read_u32(dev, "adi,power-up-frequency", &tmp);
>  	pdata->power_up_frequency = tmp;
>  
>  	tmp = 0;
> -	of_property_read_u32(np, "adi,reference-div-factor", &tmp);
> +	device_property_read_u32(dev, "adi,reference-div-factor", &tmp);
>  	pdata->ref_div_factor = tmp;
>  
> -	pdata->ref_doubler_en = of_property_read_bool(np,
> -			"adi,reference-doubler-enable");
> -	pdata->ref_div2_en = of_property_read_bool(np,
> -			"adi,reference-div2-enable");
> +	pdata->ref_doubler_en = device_property_read_bool(dev, "adi,reference-doubler-enable");
> +	pdata->ref_div2_en = device_property_read_bool(dev, "adi,reference-div2-enable");
>  
>  	/* r2_user_settings */
> -	pdata->r2_user_settings = of_property_read_bool(np,
> -			"adi,phase-detector-polarity-positive-enable") ?
> -			ADF4350_REG2_PD_POLARITY_POS : 0;
> -	pdata->r2_user_settings |= of_property_read_bool(np,
> -			"adi,lock-detect-precision-6ns-enable") ?
> -			ADF4350_REG2_LDP_6ns : 0;
> -	pdata->r2_user_settings |= of_property_read_bool(np,
> -			"adi,lock-detect-function-integer-n-enable") ?
> -			ADF4350_REG2_LDF_INT_N : 0;
> +	pdata->r2_user_settings = 0;
> +	if (device_property_read_bool(dev, "adi,phase-detector-polarity-positive-enable"))
> +		pdata->r2_user_settings |= ADF4350_REG2_PD_POLARITY_POS;
> +	if (device_property_read_bool(dev, "adi,lock-detect-precision-6ns-enable"))
> +		pdata->r2_user_settings |= ADF4350_REG2_LDP_6ns;
> +	if (device_property_read_bool(dev, "adi,lock-detect-function-integer-n-enable"))
> +		pdata->r2_user_settings |= ADF4350_REG2_LDF_INT_N;
>  
>  	tmp = 2500;
> -	of_property_read_u32(np, "adi,charge-pump-current", &tmp);
> +	device_property_read_u32(dev, "adi,charge-pump-current", &tmp);
>  	pdata->r2_user_settings |= ADF4350_REG2_CHARGE_PUMP_CURR_uA(tmp);
>  
>  	tmp = 0;
> -	of_property_read_u32(np, "adi,muxout-select", &tmp);
> +	device_property_read_u32(dev, "adi,muxout-select", &tmp);
>  	pdata->r2_user_settings |= ADF4350_REG2_MUXOUT(tmp);
>  
> -	pdata->r2_user_settings |= of_property_read_bool(np,
> -			"adi,low-spur-mode-enable") ?
> -			ADF4350_REG2_NOISE_MODE(0x3) : 0;
> +	if (device_property_read_bool(dev, "adi,low-spur-mode-enable"))
> +		pdata->r2_user_settings |= ADF4350_REG2_NOISE_MODE(0x3);
>  
>  	/* r3_user_settings */
>  
> -	pdata->r3_user_settings = of_property_read_bool(np,
> -			"adi,cycle-slip-reduction-enable") ?
> -			ADF4350_REG3_12BIT_CSR_EN : 0;
> -	pdata->r3_user_settings |= of_property_read_bool(np,
> -			"adi,charge-cancellation-enable") ?
> -			ADF4351_REG3_CHARGE_CANCELLATION_EN : 0;
> -
> -	pdata->r3_user_settings |= of_property_read_bool(np,
> -			"adi,anti-backlash-3ns-enable") ?
> -			ADF4351_REG3_ANTI_BACKLASH_3ns_EN : 0;
> -	pdata->r3_user_settings |= of_property_read_bool(np,
> -			"adi,band-select-clock-mode-high-enable") ?
> -			ADF4351_REG3_BAND_SEL_CLOCK_MODE_HIGH : 0;
> +	pdata->r3_user_settings = 0;
> +	if (device_property_read_bool(dev, "adi,cycle-slip-reduction-enable"))
> +		pdata->r3_user_settings |= ADF4350_REG3_12BIT_CSR_EN;
> +	if (device_property_read_bool(dev, "adi,charge-cancellation-enable"))
> +		pdata->r3_user_settings |= ADF4351_REG3_CHARGE_CANCELLATION_EN;
> +	if (device_property_read_bool(dev, "adi,anti-backlash-3ns-enable"))
> +		pdata->r3_user_settings |= ADF4351_REG3_ANTI_BACKLASH_3ns_EN;
> +	if (device_property_read_bool(dev, "adi,band-select-clock-mode-high-enable"))
> +		pdata->r3_user_settings |= ADF4351_REG3_BAND_SEL_CLOCK_MODE_HIGH;
>  
>  	tmp = 0;
> -	of_property_read_u32(np, "adi,12bit-clk-divider", &tmp);
> +	device_property_read_u32(dev, "adi,12bit-clk-divider", &tmp);
>  	pdata->r3_user_settings |= ADF4350_REG3_12BIT_CLKDIV(tmp);
>  
>  	tmp = 0;
> -	of_property_read_u32(np, "adi,clk-divider-mode", &tmp);
> +	device_property_read_u32(dev, "adi,clk-divider-mode", &tmp);
>  	pdata->r3_user_settings |= ADF4350_REG3_12BIT_CLKDIV_MODE(tmp);
>  
>  	/* r4_user_settings */
>  
> -	pdata->r4_user_settings = of_property_read_bool(np,
> -			"adi,aux-output-enable") ?
> -			ADF4350_REG4_AUX_OUTPUT_EN : 0;
> -	pdata->r4_user_settings |= of_property_read_bool(np,
> -			"adi,aux-output-fundamental-enable") ?
> -			ADF4350_REG4_AUX_OUTPUT_FUND : 0;
> -	pdata->r4_user_settings |= of_property_read_bool(np,
> -			"adi,mute-till-lock-enable") ?
> -			ADF4350_REG4_MUTE_TILL_LOCK_EN : 0;
> +	pdata->r4_user_settings = 0;
> +	if (device_property_read_bool(dev, "adi,aux-output-enable"))
> +		pdata->r4_user_settings |= ADF4350_REG4_AUX_OUTPUT_EN;
> +	if (device_property_read_bool(dev, "adi,aux-output-fundamental-enable"))
> +		pdata->r4_user_settings |= ADF4350_REG4_AUX_OUTPUT_FUND;
> +	if (device_property_read_bool(dev, "adi,mute-till-lock-enable"))
> +		pdata->r4_user_settings |= ADF4350_REG4_MUTE_TILL_LOCK_EN;
>  
>  	tmp = 0;
> -	of_property_read_u32(np, "adi,output-power", &tmp);
> +	device_property_read_u32(dev, "adi,output-power", &tmp);
>  	pdata->r4_user_settings |= ADF4350_REG4_OUTPUT_PWR(tmp);
>  
>  	tmp = 0;
> -	of_property_read_u32(np, "adi,aux-output-power", &tmp);
> +	device_property_read_u32(dev, "adi,aux-output-power", &tmp);
>  	pdata->r4_user_settings |= ADF4350_REG4_AUX_OUTPUT_PWR(tmp);
>  
>  	return pdata;
>  }
> -#else
> -static
> -struct adf4350_platform_data *adf4350_parse_dt(struct device *dev)
> -{
> -	return NULL;
> -}
> -#endif
>  
