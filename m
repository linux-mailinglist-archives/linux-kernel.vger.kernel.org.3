Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91881503622
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 13:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiDPLHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 07:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiDPLHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 07:07:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA5FF2;
        Sat, 16 Apr 2022 04:04:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 775F760EC8;
        Sat, 16 Apr 2022 11:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D94FC385A3;
        Sat, 16 Apr 2022 11:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650107079;
        bh=22vqrDrATcTvNHzYENBFLVN2ck1Ig62NFHe/ggmr8sY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BSwZL883Mbp8vsy28dOm8OvQLGmeioLiTF0VudzXNJ5E2FHpvjqOc/aXBj6JMK9yw
         fVYt3BVX2bSPIYwL/2I2ERMRmlYRVLrPEcmY1hp3STrdHdhLUX4LYmFv02eC+e240Y
         5zD1J9JSxC3IVW4Bnrt5vb40TKpuVIZisMEw2wjFop/OxURycn1P1cWKQJTfEosycX
         RlgVqxhVAPbcStE3H2TtmmDwPQd0tKjLgcllJjA45ut+cnOYmHRnZi3a5SXuHWDD16
         m39B1sC66tvbT0JQ/iyIFQFUvxS0LhoIxb3N5nOCZ1Xxq3OVbh5BZ5OYbqnrcmpmqw
         P4qcGZexux/yA==
Date:   Sat, 16 Apr 2022 12:12:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Brian Masney <bmasney@redhat.com>
Subject: Re: [PATCH v1 1/1] iio: light: tsl2772: Make use of device
 properties
Message-ID: <20220416121238.67708b6a@jic23-huawei>
In-Reply-To: <20220413181402.19582-1-andriy.shevchenko@linux.intel.com>
References: <20220413181402.19582-1-andriy.shevchenko@linux.intel.com>
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

On Wed, 13 Apr 2022 21:14:02 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> While at it, reuse temporary device pointer in the same function.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+CC Bryan as an FYI.

Applied to the togreg branch of iio.git and pushed out as testing for
all the normal reasons.

Thanks,

Jonathan


> ---
>  drivers/iio/light/tsl2772.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> index 729f14d9f2a4..dd9051f1cc1a 100644
> --- a/drivers/iio/light/tsl2772.c
> +++ b/drivers/iio/light/tsl2772.c
> @@ -15,7 +15,9 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/property.h>
>  #include <linux/slab.h>
> +
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -549,10 +551,10 @@ static int tsl2772_get_prox(struct iio_dev *indio_dev)
>  
>  static int tsl2772_read_prox_led_current(struct tsl2772_chip *chip)
>  {
> -	struct device_node *of_node = chip->client->dev.of_node;
> +	struct device *dev = &chip->client->dev;
>  	int ret, tmp, i;
>  
> -	ret = of_property_read_u32(of_node, "led-max-microamp", &tmp);
> +	ret = device_property_read_u32(dev, "led-max-microamp", &tmp);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -563,20 +565,18 @@ static int tsl2772_read_prox_led_current(struct tsl2772_chip *chip)
>  		}
>  	}
>  
> -	dev_err(&chip->client->dev, "Invalid value %d for led-max-microamp\n",
> -		tmp);
> +	dev_err(dev, "Invalid value %d for led-max-microamp\n", tmp);
>  
>  	return -EINVAL;
> -
>  }
>  
>  static int tsl2772_read_prox_diodes(struct tsl2772_chip *chip)
>  {
> -	struct device_node *of_node = chip->client->dev.of_node;
> +	struct device *dev = &chip->client->dev;
>  	int i, ret, num_leds, prox_diode_mask;
>  	u32 leds[TSL2772_MAX_PROX_LEDS];
>  
> -	ret = of_property_count_u32_elems(of_node, "amstaos,proximity-diodes");
> +	ret = device_property_count_u32(dev, "amstaos,proximity-diodes");
>  	if (ret < 0)
>  		return ret;
>  
> @@ -584,12 +584,9 @@ static int tsl2772_read_prox_diodes(struct tsl2772_chip *chip)
>  	if (num_leds > TSL2772_MAX_PROX_LEDS)
>  		num_leds = TSL2772_MAX_PROX_LEDS;
>  
> -	ret = of_property_read_u32_array(of_node, "amstaos,proximity-diodes",
> -					 leds, num_leds);
> +	ret = device_property_read_u32_array(dev, "amstaos,proximity-diodes", leds, num_leds);
>  	if (ret < 0) {
> -		dev_err(&chip->client->dev,
> -			"Invalid value for amstaos,proximity-diodes: %d.\n",
> -			ret);
> +		dev_err(dev, "Invalid value for amstaos,proximity-diodes: %d.\n", ret);
>  		return ret;
>  	}
>  
> @@ -600,9 +597,7 @@ static int tsl2772_read_prox_diodes(struct tsl2772_chip *chip)
>  		else if (leds[i] == 1)
>  			prox_diode_mask |= TSL2772_DIODE1;
>  		else {
> -			dev_err(&chip->client->dev,
> -				"Invalid value %d in amstaos,proximity-diodes.\n",
> -				leds[i]);
> +			dev_err(dev, "Invalid value %d in amstaos,proximity-diodes.\n", leds[i]);
>  			return -EINVAL;
>  		}
>  	}

