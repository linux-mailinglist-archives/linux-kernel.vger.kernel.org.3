Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37B64B14A5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245385AbiBJRye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:54:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242006AbiBJRyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:54:33 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64668192;
        Thu, 10 Feb 2022 09:54:32 -0800 (PST)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JvksB1gL2z67bNK;
        Fri, 11 Feb 2022 01:54:22 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 18:54:29 +0100
Received: from localhost (10.47.64.132) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Thu, 10 Feb
 2022 17:54:28 +0000
Date:   Thu, 10 Feb 2022 17:54:23 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jagath Jog J <jagathjog1996@gmail.com>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <andy.shevchenko@gmail.com>,
        <sst@poczta.fm>, <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: potentiometer: Add support for Maxim DS3502
Message-ID: <20220210175423.00005364@Huawei.com>
In-Reply-To: <20220207040408.4273-3-jagathjog1996@gmail.com>
References: <20220207040408.4273-1-jagathjog1996@gmail.com>
        <20220207040408.4273-3-jagathjog1996@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.64.132]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  7 Feb 2022 09:34:08 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> The DS3502 is a 7-bit, nonvolatile digital potentiometer featuring
> an output voltage range of up to 15.5V.
> DS3502 support is implemented into existing ds1803 driver
> 
> Datasheet: https://datasheets.maximintegrated.com/en/ds/DS3502.pdf
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
Hi Jagath,

Comments inline.  Looks pretty clean in the end so this is definitely
the better option than introducing another driver.

Thanks,

Jonathan

> ---
>  drivers/iio/potentiometer/Kconfig  |   4 +-
>  drivers/iio/potentiometer/ds1803.c | 150 +++++++++++++++++++++++------
>  2 files changed, 120 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
> index 832df8da2bc6..1741af33672c 100644
> --- a/drivers/iio/potentiometer/Kconfig
> +++ b/drivers/iio/potentiometer/Kconfig
> @@ -27,10 +27,10 @@ config AD5272
>  	  module will be called ad5272.
>  
>  config DS1803
> -	tristate "Maxim Integrated DS1803 Digital Potentiometer driver"
> +	tristate "Maxim Integrated DS1803 and similar Digital Potentiometer driver"
>  	depends on I2C
>  	help
> -	  Say yes here to build support for the Maxim Integrated DS1803
> +	  Say yes here to build support for the Maxim Integrated DS1803 and DS3502
>  	  digital potentiometer chip.
>  
>  	  To compile this driver as a module, choose M here: the
> diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
> index 20b45407eaac..5e403e3400f7 100644
> --- a/drivers/iio/potentiometer/ds1803.c
> +++ b/drivers/iio/potentiometer/ds1803.c
> @@ -1,12 +1,15 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Maxim Integrated DS1803 digital potentiometer driver
> + * Maxim Integrated DS1803 and DS3502 digital potentiometer driver

I'd stick to and similar wording here.  We want to be able
to grep the part number and hit the Kconfig + drivers, but
once is enough for either.  "and similar" avoids more churn
than necessary when adding additional parts.


>   * Copyright (c) 2016 Slawomir Stepien
> + * Copyright (c) 2022 Jagath Jog J
>   *
>   * Datasheet: https://datasheets.maximintegrated.com/en/ds/DS1803.pdf
> + * Datasheet: https://datasheets.maximintegrated.com/en/ds/DS3502.pdf
>   *
>   * DEVID	#Wipers	#Positions	Resistor Opts (kOhm)	i2c address
>   * ds1803	2	256		10, 50, 100		0101xxx
> + * DS3502       1       128             10                      01010xx

Stick to lowercase for consistency.
Also use tabs for spacing for consistency with existing table entry.

>   */
>  
>  #include <linux/err.h>
> @@ -16,47 +19,88 @@
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  
> -#define DS1803_MAX_POS		255
> -#define DS1803_WRITE(chan)	(0xa8 | ((chan) + 1))
> +#define DS1803_WIPER_0		(0xA9)

Single constants don't need or benefit from being surrounding in
brackets like this.

> +#define DS1803_WIPER_1		(0xAA)
> +#define DS3502_WR_IVR		(0x00)
> +#define DS3502_CR               (0x02)
> +#define DS3502_MODE0		(0x00)
> +#define DS3502_MODE1		(0x80)
>  
>  enum ds1803_type {
>  	DS1803_010,
>  	DS1803_050,
>  	DS1803_100,
> +	DS3502,
>  };
>  
>  struct ds1803_cfg {
> +	int wipers;
> +	int avail[3];
>  	int kohms;
>  };
>  
>  static const struct ds1803_cfg ds1803_cfg[] = {
> -	[DS1803_010] = { .kohms =  10, },
> -	[DS1803_050] = { .kohms =  50, },
> -	[DS1803_100] = { .kohms = 100, },
> +	[DS1803_010] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms =  10, },
> +	[DS1803_050] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms =  50, },
> +	[DS1803_100] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms = 100, },
> +	[DS3502] =     { .wipers = 1, .avail = { 0, 1, 127 }, .kohms =  10, },
> +};
> +
> +struct maxim_potentiometer {
> +	const struct iio_chan_spec *channels;
> +	u8 num_channels;
>  };
>  
>  struct ds1803_data {
>  	struct i2c_client *client;
> +	enum ds1803_type chip_type;

Move this into the ds1803_cfg.

>  	const struct ds1803_cfg *cfg;
> +	const struct maxim_potentiometer *chip;

Everything in here should go in ds1803_cfg as well.

>  };
>  
> -#define DS1803_CHANNEL(ch) {					\
> -	.type = IIO_RESISTANCE,					\
> -	.indexed = 1,						\
> -	.output = 1,						\
> -	.channel = (ch),					\
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +#define DS1803_CHANNEL(ch, addr) {					\
> +	.type = IIO_RESISTANCE,						\
> +	.indexed = 1,							\
> +	.output = 1,							\
> +	.channel = (ch),						\
> +	.address = (addr),						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_RAW),	\

Adding available is new functionality for the old part.
Good to have but ideally would be in a separate patch (probably before
the main one)

>  }
>  
>  static const struct iio_chan_spec ds1803_channels[] = {
> -	DS1803_CHANNEL(0),
> -	DS1803_CHANNEL(1),
> +	DS1803_CHANNEL(0, DS1803_WIPER_0),
> +	DS1803_CHANNEL(1, DS1803_WIPER_1),
> +};
> +
> +static const struct iio_chan_spec ds3502_channels[] = {
> +	{
> +		.type = IIO_RESISTANCE,
> +		.indexed = 1,
> +		.output = 1,
> +		.channel = 0,
> +		.address = (DS3502_WR_IVR),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_ENABLE),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_RAW),
> +	},
> +};
> +
> +static const struct maxim_potentiometer maxim_potentiometer_chips[] = {
> +	[DS1803_100] = {
> +				.channels = ds1803_channels,

Very deep indenting. Stick to
		This level and reduce the indent of the closing bracket by one
tab.

I would add this information to the existing ds1803_cfg structure.
you will have to duplicate a elements, but you will save on the
complexity of having two chip type related structures.
You will have to reorder the code to make that work cleanly.

> +				.num_channels = ARRAY_SIZE(ds1803_channels),
> +		},
> +	[DS3502]     = {
> +				.channels = ds3502_channels,
> +				.num_channels = ARRAY_SIZE(ds3502_channels),
> +		},
>  };
>  
>  static int ds1803_read_raw(struct iio_dev *indio_dev,
> -			    struct iio_chan_spec const *chan,
> -			    int *val, int *val2, long mask)
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
If there are valid white space tidy ups, please do them in
a separate patch as they just distract form the important stuff
ehre.

>  {
>  	struct ds1803_data *data = iio_priv(indio_dev);
>  	int pot = chan->channel;
> @@ -65,17 +109,28 @@ static int ds1803_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		ret = i2c_master_recv(data->client, result,
> -				indio_dev->num_channels);
> +		switch (data->chip_type) {
> +		case DS1803_010:
> +		case DS1803_050:
> +		case DS1803_100:
> +			ret = i2c_master_recv(data->client, result,
> +					      indio_dev->num_channels);
Whilst it doesn't cause problems, as a general rule, you shouldn't use
the output of a function if it has returned an error code. You should
do the
			if (ret < 0)
				return ret;
which seems have have gotten lost below.
> +			*val = result[pot];

return IIO_VAL_INT; here

> +			break;
> +		case DS3502:
> +			ret = i2c_smbus_read_byte_data(data->client, chan->address);

Preference for 80 char max lines when there is no strong reason to go over. Here
wrapping after client, will not hurt readability significantly.

> +			*val = ret;
> +			break;

return here.

> +		default:
> +			return -EINVAL;
> +		}
> +
>  		if (ret < 0)
>  			return ret;
> -
> -		*val = result[pot];
>  		return IIO_VAL_INT;
> -
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 1000 * data->cfg->kohms;
> -		*val2 = DS1803_MAX_POS;
> +		*val2 = data->cfg->avail[2];

Probably worth a comment on why [2] is the right option here.

>  		return IIO_VAL_FRACTIONAL;
>  	}
>  
> @@ -83,38 +138,64 @@ static int ds1803_read_raw(struct iio_dev *indio_dev,
>  }
>  
>  static int ds1803_write_raw(struct iio_dev *indio_dev,
> -			     struct iio_chan_spec const *chan,
> -			     int val, int val2, long mask)
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)

Check for white space only changes like this before sending patches.
They are easy to accidentally introduce but should not be in a patch
doing significant changes like this one.

>  {
>  	struct ds1803_data *data = iio_priv(indio_dev);
> -	int pot = chan->channel;
> +	int max_pos = data->cfg->avail[2];
> +	u8 addr = chan->address;
>  
>  	if (val2 != 0)
>  		return -EINVAL;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		if (val > DS1803_MAX_POS || val < 0)
> +		if (val > max_pos || val < 0)

as max_pos is just used here I would not bother with the local
variable.

> +			return -EINVAL;
> +		break;
> +	case IIO_CHAN_INFO_ENABLE:

This doesn't seem to map to enable as it is about whether the
value is written to the initial value register or not.
We may need to invent some new sysfs attributes to cover that
though I'd be a bit surprised if we have no precedence in other
DACs.


> +		if (val == 1)
> +			val = DS3502_MODE1;
> +		else if (val != DS3502_MODE0)
>  			return -EINVAL;
> +		addr = DS3502_CR;

In cases like this it's better to assign addr in both
case statements as one is no more of a 'default' than the
other choice.

>  		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
> -	return i2c_smbus_write_byte_data(data->client, DS1803_WRITE(pot), val);
> +	return i2c_smbus_write_byte_data(data->client, addr, val);

> +}
> +
> +static int ds1803_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length, long mask)
> +{

As mentioned above. This is great, but not strictly about support for
the new part, so it should be a different patch.

> +	struct ds1803_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		*vals = data->cfg->avail;
> +		*length = ARRAY_SIZE(data->cfg->avail);
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_RANGE;
> +	}
> +	return -EINVAL;
>  }
>  
>  static const struct iio_info ds1803_info = {
>  	.read_raw = ds1803_read_raw,
> +	.read_avail = ds1803_read_avail,
>  	.write_raw = ds1803_write_raw,
>  };
>  
>  static int ds1803_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +			const struct i2c_device_id *id)

Another white space change.  Fixing up the alignment is a good thing
to do but needs to be in a separate patch.

>  {
>  	struct device *dev = &client->dev;
>  	struct ds1803_data *data;
>  	struct iio_dev *indio_dev;
> +	enum ds1803_type chip_type = (id->driver_data <= DS1803_100 ? DS1803_100 : DS3502);

Why this dance?  You have all the models covered by a switch statement anyway.

> +	const struct maxim_potentiometer *chip = &maxim_potentiometer_chips[chip_type];
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>  	if (!indio_dev)
> @@ -125,10 +206,12 @@ static int ds1803_probe(struct i2c_client *client,
>  	data = iio_priv(indio_dev);
>  	data->client = client;
>  	data->cfg = &ds1803_cfg[id->driver_data];

Unrelated to this patch, but note that for DT based bindings this relies
on the part after the comma precisely matching the entry in the 
i2c_device_id table which is rather fragile. At somepoint we should tidy
this up to first check if there is a firmware provided entry with data
and only if there is not fall back to using id->driver_data if available.
It never is on ACPI platforms for starters.

> +	data->chip = chip;

Not used anywhere that I can see.

> +	data->chip_type = chip_type;
>  
>  	indio_dev->info = &ds1803_info;
> -	indio_dev->channels = ds1803_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(ds1803_channels);
> +	indio_dev->channels = chip->channels;
> +	indio_dev->num_channels = chip->num_channels;
>  	indio_dev->name = client->name;
>  
>  	return devm_iio_device_register(dev, indio_dev);
> @@ -138,6 +221,7 @@ static const struct of_device_id ds1803_dt_ids[] = {
>  	{ .compatible = "maxim,ds1803-010", .data = &ds1803_cfg[DS1803_010] },
>  	{ .compatible = "maxim,ds1803-050", .data = &ds1803_cfg[DS1803_050] },
>  	{ .compatible = "maxim,ds1803-100", .data = &ds1803_cfg[DS1803_100] },
> +	{ .compatible = "maxim,ds3502",     .data = &ds1803_cfg[DS3502] },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, ds1803_dt_ids);
> @@ -146,6 +230,7 @@ static const struct i2c_device_id ds1803_id[] = {
>  	{ "ds1803-010", DS1803_010 },
>  	{ "ds1803-050", DS1803_050 },
>  	{ "ds1803-100", DS1803_100 },
> +	{ "ds3502",	DS3502	   },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, ds1803_id);
> @@ -162,5 +247,6 @@ static struct i2c_driver ds1803_driver = {
>  module_i2c_driver(ds1803_driver);
>  
>  MODULE_AUTHOR("Slawomir Stepien <sst@poczta.fm>");
> -MODULE_DESCRIPTION("DS1803 digital potentiometer");
> +MODULE_AUTHOR("Jagath Jog J <jagathjog1996@gmail.com>");
> +MODULE_DESCRIPTION("DS1803 and DS3502 digital potentiometer");

I would use and similar here, or just don't bother changing the
description. It's common for these to not cover all the devices
supported.

>  MODULE_LICENSE("GPL v2");

