Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB984BB916
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbiBRM0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:26:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbiBRM0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:26:00 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94871FEBC8;
        Fri, 18 Feb 2022 04:25:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E8589CE322D;
        Fri, 18 Feb 2022 12:25:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856EEC340E9;
        Fri, 18 Feb 2022 12:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645187140;
        bh=hCw/QzW+metfpvnUJhYJxq5jHUUp3oRC3CxANUSCPqo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K57EV/CZWYVTFjJ2okmja32aJOfPyGqkh6ffprwvNM4WgG5QjEZQSa6x0dav0nxF5
         lTGS2pi+FZl3RTTN9/c00xm+/GxPjXDCukfaYxrgJ82e++kacq3nX6SbxLX3GCJIpd
         PUa/wuwpgTN3z3SioeFOM5gFkF8jBkrrXdGp+0yHj8VV5KSobYKYDdvhRKw2PYnMUn
         cSIsTe4FdWnfbnm9LvVf20DLsalP5Bv7THSPsO/8tHls01QhDwYYnlQMcnjscNi03Q
         h/P3WhzLj7IqkvtDHMGXShd4yzLCX1VaIRw+D0C/pU6cdAHOh4m3Q7PX7f8/zG+dLj
         0KVyK+u2OwDbw==
Date:   Fri, 18 Feb 2022 12:32:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com, sst@poczta.fm,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] iio: potentiometer: Add support for Maxim DS3502
Message-ID: <20220218123228.6ad125cc@jic23-huawei>
In-Reply-To: <20220218042038.15176-6-jagathjog1996@gmail.com>
References: <20220218042038.15176-1-jagathjog1996@gmail.com>
        <20220218042038.15176-6-jagathjog1996@gmail.com>
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

On Fri, 18 Feb 2022 09:50:37 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> The DS3502 is a 7-bit, nonvolatile digital potentiometer featuring
> an output voltage range of up to 15.5V.
> DS3502 support is implemented into existing DS1803 driver.
> Datasheet: https://datasheets.maximintegrated.com/en/ds/DS3502.pdf
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>

Hi Jagath,

One suggestion from my review of v2.  Instead of putting the enum
for type in the per chip type cfg structure, use a function pointer
and break out the device specific bits of the read_raw() into
separate functions accessed via that function pointer.

Thanks,

Jonathan

> ---
>  drivers/iio/potentiometer/Kconfig  |  6 ++--
>  drivers/iio/potentiometer/ds1803.c | 46 ++++++++++++++++++++++++------
>  2 files changed, 41 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
> index 832df8da2bc6..79c524640196 100644
> --- a/drivers/iio/potentiometer/Kconfig
> +++ b/drivers/iio/potentiometer/Kconfig
> @@ -27,11 +27,11 @@ config AD5272
>  	  module will be called ad5272.
>  
>  config DS1803
> -	tristate "Maxim Integrated DS1803 Digital Potentiometer driver"
> +	tristate "Maxim Integrated DS1803 and similar Digital Potentiometer driver"
>  	depends on I2C
>  	help
> -	  Say yes here to build support for the Maxim Integrated DS1803
> -	  digital potentiometer chip.
> +	  Say yes here to build support for the Maxim Integrated Devices DS1803 and
> +	  DS3502 digital potentiometer chip.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ds1803.
> diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
> index ca28ad147402..ca903e9c2816 100644
> --- a/drivers/iio/potentiometer/ds1803.c
> +++ b/drivers/iio/potentiometer/ds1803.c
> @@ -1,12 +1,15 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Maxim Integrated DS1803 digital potentiometer driver
> + * Maxim Integrated DS1803 and similar digital potentiometer driver
>   * Copyright (c) 2016 Slawomir Stepien
> + * Copyright (c) 2022 Jagath Jog J
>   *
>   * Datasheet: https://datasheets.maximintegrated.com/en/ds/DS1803.pdf
> + * Datasheet: https://datasheets.maximintegrated.com/en/ds/DS3502.pdf
>   *
>   * DEVID	#Wipers	#Positions	Resistor Opts (kOhm)	i2c address
>   * ds1803	2	256		10, 50, 100		0101xxx
> + * ds3502	1	128		10			01010xx
>   */
>  
>  #include <linux/err.h>
> @@ -18,11 +21,13 @@
>  
>  #define DS1803_WIPER_0         0xA9
>  #define DS1803_WIPER_1         0xAA
> +#define DS3502_WR_IVR          0x00
>  
>  enum ds1803_type {
>  	DS1803_010,
>  	DS1803_050,
>  	DS1803_100,
> +	DS3502,
>  };
>  
>  struct ds1803_cfg {
> @@ -36,6 +41,7 @@ struct ds1803_cfg {
>  struct ds1803_data {
>  	struct i2c_client *client;
>  	const struct ds1803_cfg *cfg;
> +	enum ds1803_type chip_type;

Hmm. I'm not that keen on this backwards reference (effectively).
Consider using a read() function pointer in here instead.

>  };
>  
>  #define DS1803_CHANNEL(ch, addr) {					\
> @@ -54,6 +60,10 @@ static const struct iio_chan_spec ds1803_channels[] = {
>  	DS1803_CHANNEL(1, DS1803_WIPER_1),
>  };
>  
> +static const struct iio_chan_spec ds3502_channels[] = {
> +	DS1803_CHANNEL(0, DS3502_WR_IVR),
> +};
> +
>  static const struct ds1803_cfg ds1803_cfg[] = {
>  	[DS1803_010] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms =  10,
>  			 .channels = ds1803_channels,
> @@ -64,6 +74,9 @@ static const struct ds1803_cfg ds1803_cfg[] = {
>  	[DS1803_100] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms = 100,
>  			 .channels = ds1803_channels,
>  			 .num_channels = ARRAY_SIZE(ds1803_channels) },
> +	[DS3502] =     { .wipers = 1, .avail = { 0, 1, 127 }, .kohms =  10,
> +			 .channels = ds3502_channels,
> +			 .num_channels = ARRAY_SIZE(ds3502_channels) },
>  };
>  
>  static int ds1803_read_raw(struct iio_dev *indio_dev,
> @@ -77,13 +90,26 @@ static int ds1803_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		ret = i2c_master_recv(data->client, result,
> -				      indio_dev->num_channels);
> -		if (ret < 0)
> -			return ret;
> -
> -		*val = result[pot];
> -		return IIO_VAL_INT;
> +		switch (data->chip_type) {
> +		case DS1803_010:
> +		case DS1803_050:
> +		case DS1803_100:

This block can become
			ret = data->read(indio_dev, chan, val);
or something along those lines and you can remove the switch statement
as it's a simple lookup.

> +			ret = i2c_master_recv(data->client, result,
> +					      indio_dev->num_channels);
> +			if (ret < 0)
> +				return ret;
> +			*val = result[pot];
> +			return IIO_VAL_INT;
> +		case DS3502:
> +			ret = i2c_smbus_read_byte_data(data->client,
> +						       chan->address);
> +			if (ret < 0)
> +				return ret;
> +			*val = ret;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
>  
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 1000 * data->cfg->kohms;
> @@ -156,6 +182,7 @@ static int ds1803_probe(struct i2c_client *client, const struct i2c_device_id *i
>  	if (!data->cfg)
>  		data->cfg = &ds1803_cfg[id->driver_data];
>  
> +	data->chip_type = id->driver_data;
>  	indio_dev->info = &ds1803_info;
>  	indio_dev->channels = data->cfg->channels;
>  	indio_dev->num_channels = data->cfg->num_channels;
> @@ -168,6 +195,7 @@ static const struct of_device_id ds1803_dt_ids[] = {
>  	{ .compatible = "maxim,ds1803-010", .data = &ds1803_cfg[DS1803_010] },
>  	{ .compatible = "maxim,ds1803-050", .data = &ds1803_cfg[DS1803_050] },
>  	{ .compatible = "maxim,ds1803-100", .data = &ds1803_cfg[DS1803_100] },
> +	{ .compatible = "maxim,ds3502", .data = &ds1803_cfg[DS3502] },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, ds1803_dt_ids);
> @@ -176,6 +204,7 @@ static const struct i2c_device_id ds1803_id[] = {
>  	{ "ds1803-010", DS1803_010 },
>  	{ "ds1803-050", DS1803_050 },
>  	{ "ds1803-100", DS1803_100 },
> +	{ "ds3502", DS3502 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, ds1803_id);
> @@ -192,5 +221,6 @@ static struct i2c_driver ds1803_driver = {
>  module_i2c_driver(ds1803_driver);
>  
>  MODULE_AUTHOR("Slawomir Stepien <sst@poczta.fm>");
> +MODULE_AUTHOR("Jagath Jog J <jagathjog1996@gmail.com>");
>  MODULE_DESCRIPTION("DS1803 digital potentiometer");
>  MODULE_LICENSE("GPL v2");

