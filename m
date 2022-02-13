Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED594B3CB2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 19:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbiBMSBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 13:01:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbiBMSBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 13:01:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347285AEE2;
        Sun, 13 Feb 2022 10:01:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4DA6611EA;
        Sun, 13 Feb 2022 18:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB97C004E1;
        Sun, 13 Feb 2022 18:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644775276;
        bh=AyH6AirEXf7ydHkgN12SlyzFm4b00PX0Q2c5n2q81fs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tpZM0GMhH6Kl8AzxC+b4KXsVtQ7GD1iUnUsLbHRfVDHTpS3rEmua/fzS+8t2c1vdi
         tYrDlPLBMwC+o4RY8R/9LZ8x52HYO+KedS9R8Keru9xgKU1QpbhWJYsMLDqr6O+qYA
         AlVi4N/Gid/B8s3i2OD/Kfs7T8Zz/wi1MEYlNfY7mU1tT9kQRNl3We3YWb/jFcaf3A
         IVgTYroz6UMe1NRERyme4yAKugJRxmRi1pXlxyOtZI37/SYYgBBx6e7utrVMam15BY
         lVBtg6DbGY2dJV9E6r+2ViAVCYlBZv52R4xCguJn23dFRzMqai3rsNIyyLEw9trRMf
         J5OAh1RHLVCPA==
Date:   Sun, 13 Feb 2022 18:07:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH v3 1/1] iio: chemical: atlas-ezo-sensor: Make use of
 device properties
Message-ID: <20220213180757.751d1350@jic23-huawei>
In-Reply-To: <20220207124204.11658-1-andriy.shevchenko@linux.intel.com>
References: <20220207124204.11658-1-andriy.shevchenko@linux.intel.com>
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

On Mon,  7 Feb 2022 14:42:04 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

+Cc: Matt

Looks straight forward to me so I'll queue it up and Matt can comment
after if he likes.

Applied to the togreg branch of iio.git and pushed out as testing for
all the normal checks.

Thanks,

Jonathan


> ---
> v3: reincarnated enum (Jonathan)
>  drivers/iio/chemical/atlas-ezo-sensor.c | 32 +++++++++++++------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
> index b1bacfe3c3ce..bbcf5a59c1f4 100644
> --- a/drivers/iio/chemical/atlas-ezo-sensor.c
> +++ b/drivers/iio/chemical/atlas-ezo-sensor.c
> @@ -6,13 +6,15 @@
>   * Author: Matt Ranostay <matt.ranostay@konsulko.com>
>   */
>  
> -#include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/delay.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/property.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
> -#include <linux/of_device.h>
> +
>  #include <linux/iio/iio.h>
>  
>  #define ATLAS_EZO_DRV_NAME		"atlas-ezo-sensor"
> @@ -33,7 +35,7 @@ struct atlas_ezo_device {
>  
>  struct atlas_ezo_data {
>  	struct i2c_client *client;
> -	struct atlas_ezo_device *chip;
> +	const struct atlas_ezo_device *chip;
>  
>  	/* lock to avoid multiple concurrent read calls */
>  	struct mutex lock;
> @@ -184,17 +186,17 @@ static const struct iio_info atlas_info = {
>  };
>  
>  static const struct i2c_device_id atlas_ezo_id[] = {
> -	{ "atlas-co2-ezo", ATLAS_CO2_EZO },
> -	{ "atlas-o2-ezo", ATLAS_O2_EZO },
> -	{ "atlas-hum-ezo", ATLAS_HUM_EZO },
> +	{ "atlas-co2-ezo", (kernel_ulong_t)&atlas_ezo_devices[ATLAS_CO2_EZO] },
> +	{ "atlas-o2-ezo", (kernel_ulong_t)&atlas_ezo_devices[ATLAS_O2_EZO] },
> +	{ "atlas-hum-ezo", (kernel_ulong_t)&atlas_ezo_devices[ATLAS_HUM_EZO] },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, atlas_ezo_id);
>  
>  static const struct of_device_id atlas_ezo_dt_ids[] = {
> -	{ .compatible = "atlas,co2-ezo", .data = (void *)ATLAS_CO2_EZO, },
> -	{ .compatible = "atlas,o2-ezo", .data = (void *)ATLAS_O2_EZO, },
> -	{ .compatible = "atlas,hum-ezo", .data = (void *)ATLAS_HUM_EZO, },
> +	{ .compatible = "atlas,co2-ezo", .data = &atlas_ezo_devices[ATLAS_CO2_EZO], },
> +	{ .compatible = "atlas,o2-ezo", .data = &atlas_ezo_devices[ATLAS_O2_EZO], },
> +	{ .compatible = "atlas,hum-ezo", .data = &atlas_ezo_devices[ATLAS_HUM_EZO], },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, atlas_ezo_dt_ids);
> @@ -202,20 +204,20 @@ MODULE_DEVICE_TABLE(of, atlas_ezo_dt_ids);
>  static int atlas_ezo_probe(struct i2c_client *client,
>  		       const struct i2c_device_id *id)
>  {
> +	const struct atlas_ezo_device *chip;
>  	struct atlas_ezo_data *data;
> -	struct atlas_ezo_device *chip;
> -	const struct of_device_id *of_id;
>  	struct iio_dev *indio_dev;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> -	of_id = of_match_device(atlas_ezo_dt_ids, &client->dev);
> -	if (!of_id)
> -		chip = &atlas_ezo_devices[id->driver_data];
> +	if (dev_fwnode(&client->dev))
> +		chip = device_get_match_data(&client->dev);
>  	else
> -		chip = &atlas_ezo_devices[(unsigned long)of_id->data];
> +		chip = (const struct atlas_ezo_device *)id->driver_data;
> +	if (!chip)
> +		return -EINVAL;
>  
>  	indio_dev->info = &atlas_info;
>  	indio_dev->name = ATLAS_EZO_DRV_NAME;

