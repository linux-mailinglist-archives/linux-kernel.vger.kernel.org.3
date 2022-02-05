Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D734AAA2B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 17:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380481AbiBEQbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 11:31:32 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50322 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiBEQb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 11:31:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D44F061038;
        Sat,  5 Feb 2022 16:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3E3C340E8;
        Sat,  5 Feb 2022 16:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644078687;
        bh=Ai3D4uxxN4oWQVjoo0GG+nemvOrbKf1yt5Rtxe5I+Hk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P4ZX/wGNDTivqhVWj7g9xSF3IAV0Vv9OL+5WUDL4LRiPItBmp6tziyNmwFIe31xhM
         33+QMj/yo2h0Arm4wUCvJoz8JVF4cO5eXIzTbD4EIV1jZRbwY2v6Ppgg6HD+Ha/crl
         s2Th/uewLk0Vr5fdVir7DZPbD8xf+CsW8a7oS2gYm75j9r/bRP0YnkPU/pZHfH76aX
         lcbyOs2NogOjIzHWfE+uDrh+K1NYVpus7Z0FUq9d1rpv1QCbq0bk2XBI9dDBvXmX4K
         Jc1eM6QS6ts6NWvjdImIX+AMsH3UWTgctTpqgE7M19HwuAHu34NpFmfRMmSNgqVHoI
         +u6uwqIAoBPVQ==
Date:   Sat, 5 Feb 2022 16:37:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/1] iio: chemical: atlas-ezo-sensor: Make use of
 device properties
Message-ID: <20220205163758.760d1c44@jic23-huawei>
In-Reply-To: <20220203162725.63979-1-andriy.shevchenko@linux.intel.com>
References: <20220203162725.63979-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Feb 2022 18:27:25 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Hi Andy,

Looks fine to me, though I'm a little curious what your logic
was in dropping the enum?  Moving to pointers to the array
entry is fine, but without the enum, you have to refer back
and forwards whilst reading to check entries are the right ones.

I wouldn't have bothered commenting on this if reviewing new
code, but here you are removing what I would consider good
practice.

> ---
> v2: fixed castings and qualifiers (LKP)
>  drivers/iio/chemical/atlas-ezo-sensor.c | 44 +++++++++++--------------
>  1 file changed, 20 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
> index b1bacfe3c3ce..3f3ea479b474 100644
> --- a/drivers/iio/chemical/atlas-ezo-sensor.c
> +++ b/drivers/iio/chemical/atlas-ezo-sensor.c
> @@ -6,25 +6,21 @@
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
>  #define ATLAS_INT_TIME_IN_MS		950
>  #define ATLAS_INT_HUM_TIME_IN_MS	350
>  
> -enum {
> -	ATLAS_CO2_EZO,
> -	ATLAS_O2_EZO,
> -	ATLAS_HUM_EZO,
> -};
> -
>  struct atlas_ezo_device {
>  	const struct iio_chan_spec *channels;
>  	int num_channels;
> @@ -33,7 +29,7 @@ struct atlas_ezo_device {
>  
>  struct atlas_ezo_data {
>  	struct i2c_client *client;
> -	struct atlas_ezo_device *chip;
> +	const struct atlas_ezo_device *chip;
>  
>  	/* lock to avoid multiple concurrent read calls */
>  	struct mutex lock;
> @@ -81,17 +77,17 @@ static const struct iio_chan_spec atlas_hum_ezo_channels[] = {
>  };
>  
>  static struct atlas_ezo_device atlas_ezo_devices[] = {
> -	[ATLAS_CO2_EZO] = {
> +	[0] = {

I think I would have kept the enum so ...

>  		.channels = atlas_co2_ezo_channels,
>  		.num_channels = 1,
>  		.delay = ATLAS_INT_TIME_IN_MS,
>  	},
> -	[ATLAS_O2_EZO] = {
> +	[1] = {
>  		.channels = atlas_o2_ezo_channels,
>  		.num_channels = 1,
>  		.delay = ATLAS_INT_TIME_IN_MS,
>  	},
> -	[ATLAS_HUM_EZO] = {
> +	[2] = {
>  		.channels = atlas_hum_ezo_channels,
>  		.num_channels = 1,
>  		.delay = ATLAS_INT_HUM_TIME_IN_MS,
> @@ -184,17 +180,17 @@ static const struct iio_info atlas_info = {
>  };
>  
>  static const struct i2c_device_id atlas_ezo_id[] = {
> -	{ "atlas-co2-ezo", ATLAS_CO2_EZO },
> -	{ "atlas-o2-ezo", ATLAS_O2_EZO },
> -	{ "atlas-hum-ezo", ATLAS_HUM_EZO },
> +	{ "atlas-co2-ezo", (kernel_ulong_t)&atlas_ezo_devices[0] },

Locally it would have been obvious that
(kernel_ulong_t(&atlas_ezo_devices[ATLAS_CO2_EZO])
was the right one index.

> +	{ "atlas-o2-ezo", (kernel_ulong_t)&atlas_ezo_devices[1] },
> +	{ "atlas-hum-ezo", (kernel_ulong_t)&atlas_ezo_devices[2] },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, atlas_ezo_id);
>  
>  static const struct of_device_id atlas_ezo_dt_ids[] = {
> -	{ .compatible = "atlas,co2-ezo", .data = (void *)ATLAS_CO2_EZO, },
> -	{ .compatible = "atlas,o2-ezo", .data = (void *)ATLAS_O2_EZO, },
> -	{ .compatible = "atlas,hum-ezo", .data = (void *)ATLAS_HUM_EZO, },
> +	{ .compatible = "atlas,co2-ezo", .data = &atlas_ezo_devices[0], },
> +	{ .compatible = "atlas,o2-ezo", .data = &atlas_ezo_devices[1], },
> +	{ .compatible = "atlas,hum-ezo", .data = &atlas_ezo_devices[2], },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, atlas_ezo_dt_ids);
> @@ -202,20 +198,20 @@ MODULE_DEVICE_TABLE(of, atlas_ezo_dt_ids);
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

