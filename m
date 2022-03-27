Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8424E8810
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 16:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbiC0OZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 10:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbiC0OZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 10:25:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3736C65;
        Sun, 27 Mar 2022 07:23:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A49F0B80C6A;
        Sun, 27 Mar 2022 14:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727FEC340ED;
        Sun, 27 Mar 2022 14:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648390998;
        bh=pOxwUfwAuSecqaYfR7eqZrofjYQyNM4DGe7bmojMq/s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sTzM6ZCj2Wgr5XRgfPG3FiIghxo55w2wXVxnd5Z/49t36TZ+yjUXzPSIFVr30+eqk
         kdY9XPvpO9XOTN7oNYy/2/ymKcTa36rnNtQDBH0YDg5kRIlU/5+LCuoxK12w2bRIkX
         PjIZu6o+rS6aTzCRThjKklreYMklVYezwdPC0EPPPIAa407ateKnX2DdKcvvLw5TQB
         923u9FtM12Javc4a6VCFs+Znek3l1gcs5fjDA+czzIIyVor9X86ALRGLokQV0fCVuS
         NmdmEK7uGtdiHMIPbQ+lv3vP2XlNvsA/IvY1RCftyRWDwT0FHvgtbkmR7YEiGk9801
         dvK9Bv0gV2RBg==
Date:   Sun, 27 Mar 2022 15:30:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        krisman@collabora.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, alvaro.soliverez@collabora.com
Subject: Re: [PATCH 3/3] iio: light: Add support for ltrf216a sensor
Message-ID: <20220327153049.10e525e9@jic23-huawei>
In-Reply-To: <20220325103014.6597-4-shreeya.patel@collabora.com>
References: <20220325103014.6597-1-shreeya.patel@collabora.com>
        <20220325103014.6597-4-shreeya.patel@collabora.com>
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

On Fri, 25 Mar 2022 16:00:14 +0530
Shreeya Patel <shreeya.patel@collabora.com> wrote:

Hi Zhigang, Shreeya,

Comments inline.

Thanks,

Jonathan
> From: Zhigang Shi <Zhigang.Shi@liteon.com>
> 
> Add initial support for ltrf216a ambient light sensor.
> 
> Datasheet :-
> https://gitlab.steamos.cloud/shreeya/iio/-/blob/main/LTR-F216A-QT.pdf
We now have a Datasheet tag, so make this part of the tag block so automated
tools can find it easily:
> 
> 
Datasheet: https://gitlab.steamos.cloud/shreeya/iio/-/blob/main/LTR-F216A-QT.pdf
> Co-developed-by: Shreeya Patel <shreeya.patel@collabora.com>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> Signed-off-by: Zhigang Shi <Zhigang.Shi@liteon.com>
> ---
>  drivers/iio/light/Kconfig    |  10 ++
>  drivers/iio/light/Makefile   |   1 +
>  drivers/iio/light/ltrf216a.c | 334 +++++++++++++++++++++++++++++++++++
>  3 files changed, 345 insertions(+)
>  create mode 100644 drivers/iio/light/ltrf216a.c
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index a62c7b4b8678..08fa383a8ca7 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -318,6 +318,16 @@ config SENSORS_LM3533
>  	  changes. The ALS-control output values can be set per zone for the
>  	  three current output channels.
>  
> +config LTRF216A
> +        tristate "Liteon LTRF216A Light Sensor"
> +        depends on I2C
> +        help
> +          If you say Y or M here, you get support for Liteon LTRF216A
> +          Ambient Light Sensor.
> +
> +          If built as a dynamically linked module, it will be called
> +          ltrf216a.
> +
>  config LTR501
>  	tristate "LTR-501ALS-01 light sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index d10912faf964..8fa91b9fe5b6 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
>  obj-$(CONFIG_ISL29125)		+= isl29125.o
>  obj-$(CONFIG_JSA1212)		+= jsa1212.o
>  obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
> +obj-$(CONFIG_LTRF216A)		+= ltrf216a.o
>  obj-$(CONFIG_LTR501)		+= ltr501.o
>  obj-$(CONFIG_LV0104CS)		+= lv0104cs.o
>  obj-$(CONFIG_MAX44000)		+= max44000.o
> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
> new file mode 100644
> index 000000000000..99295358a7fe
> --- /dev/null
> +++ b/drivers/iio/light/ltrf216a.c
> @@ -0,0 +1,334 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * LTRF216A Ambient Light Sensor
> + *
> + * Copyright (C) 2021 Lite-On Technology Corp (Singapore)
> + * Author: Shi Zhigang <Zhigang.Shi@liteon.com>
> + *
> + * IIO driver for LTRF216A (7-bit I2C slave address 0x53).
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/mutex.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

mod_devicetable.h for the id tables

> +#include <linux/pm.h>
> +#include <linux/delay.h>
> +
> +#define LTRF216A_DRV_NAME "ltrf216a"
> +
> +#define LTRF216A_MAIN_CTRL		0x00
> +
> +#define LTRF216A_ALS_MEAS_RATE		0x04

MEAS_RES seems more appropriate from datasheet.
As mentioned below, also add defines for all the fields
of the registers you will access and where the fields are
obvious numerical things, add defines for the values they
can take.


> +#define LTRF216A_MAIN_STATUS		0x07
> +#define LTRF216A_CLEAR_DATA_0		0x0A
> +
> +#define LTRF216A_ALS_DATA_0		0x0D
> +
> +static const int int_time_mapping[] = { 400000, 200000, 100000 };
> +
> +struct ltrf216a_data {
> +	struct i2c_client *client;
> +	u32			int_time;
> +	u8			int_time_fac;
> +	u8			als_gain_fac;
> +	struct mutex mutex;

All locks need a comment to say exactly what they are protecting.

> +};
> +
> +/* open air. need to update based on TP transmission rate. */
> +#define WIN_FAC	1
> +
> +static const struct iio_chan_spec ltrf216a_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_PROCESSED) |
> +			BIT(IIO_CHAN_INFO_INT_TIME),
> +	}
> +};
> +
> +static IIO_CONST_ATTR_INT_TIME_AVAIL("0.1 0.2 0.4");
> +
> +static struct attribute *ltrf216a_attributes[] = {
> +	&iio_const_attr_integration_time_available.dev_attr.attr,
please use the read_avail callback and set the appropriate
_available bit.

That allows in kernel access to this information + is probably
shorter in this case as you won't have an attribute group etc
to deal wtih.

> +	NULL
> +};
> +
> +static const struct attribute_group ltrf216a_attribute_group = {
> +	.attrs = ltrf216a_attributes,
> +};
> +
> +static int ltrf216a_init(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +	struct ltrf216a_data *data = iio_priv(indio_dev);
> +
> +	ret = i2c_smbus_read_byte_data(data->client, LTRF216A_MAIN_CTRL);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading LTRF216A_MAIN_CTRL\n");
> +		return ret;
> +	}
> +
> +	/* enable sensor */
> +	ret |= 0x02;

Needs a #define and preferably use
	ret |= FIELD_PREP()...

> +	ret = i2c_smbus_write_byte_data(data->client, LTRF216A_MAIN_CTRL, ret);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing LTRF216A_MAIN_CTRL\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ltrf216a_disable(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +	struct ltrf216a_data *data = iio_priv(indio_dev);
> +
> +	ret = i2c_smbus_write_byte_data(data->client, LTRF216A_MAIN_CTRL, 0);
> +	if (ret < 0)
> +		dev_err(&data->client->dev, "Error writing LTRF216A_MAIN_CTRL\n");
> +
> +	return ret;
> +}
> +
> +static int ltrf216a_set_it_time(struct ltrf216a_data *data, int itime)
> +{
> +	int i, ret, index = -1;
> +	u8 reg;
> +
> +	for (i = 0; i < ARRAY_SIZE(int_time_mapping); i++) {
> +		if (int_time_mapping[i] == itime) {
> +			index = i;
> +			break;
> +		}
> +	}
> +	/* Make sure integration time index is valid */
> +	if (index < 0)
> +		return -EINVAL;
> +
> +	if (index == 0) {

Switch statement seems more appropriate than this stack of if else

> +		reg = 0x03;

reg isn't a great name as I assume this is the value, not the address
which was my first thought... Perhaps reg_val?

> +		data->int_time_fac = 4;
> +	} else if (index == 1) {
> +		reg = 0x13;
> +		data->int_time_fac = 2;
> +	} else {
> +		reg = (index << 4) | 0x02;

Unless I'm missing something index == 2 if we get here.
So why the calculation?  I'd suggest defining the two fields and using
FIELD_PREP() to set up each part probably to one of a set of
#define LTRF216A_ALS_MEAS_RATE_

> +		data->int_time_fac = 1;
> +	}
> +
> +	ret = i2c_smbus_write_byte_data(data->client, LTRF216A_ALS_MEAS_RATE, reg);
Called MEAS_RES on the datasheet, why this name for the register?

> +	if (ret < 0)
> +		return ret;
> +
> +	data->int_time = itime;
> +
> +	return 0;
> +}
> +
> +static int ltrf216a_get_it_time(struct ltrf216a_data *data, int *val, int *val2)
> +{
> +	*val = 0;
> +	*val2 = data->int_time;

I'd put this inline as it avoids a question I had at the call site on why
you passed *val in as it would always be 0.

> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int ltrf216a_read_data(struct ltrf216a_data *data, u8 addr)
> +{
> +	int ret;
> +	int tries = 25;
> +	int val_0, val_1, val_2;
> +
> +	while (tries--) {
> +		ret = i2c_smbus_read_byte_data(data->client, LTRF216A_MAIN_STATUS);
> +		if (ret < 0)
> +			return ret;
> +		if (ret & 0x08)

That 0x08 is a magic number and also better defined using BIT(3)
Anyhow, use a define for that.

> +			break;
> +		msleep(20);
> +	}
> +
> +	val_0 = i2c_smbus_read_byte_data(data->client, addr);

All of these can return errors so you should check.
Device doesn't support any larger reads?

> +	val_1 = i2c_smbus_read_byte_data(data->client, addr + 1);
> +	val_2 = i2c_smbus_read_byte_data(data->client, addr + 2);
> +	ret = (val_2 << 16) + (val_1 << 8) + val_0;

This is a le24_to_cpu() conversion.
Preferred choice would be to use something like
	u8 buf[3];
	int i;

	for (i = 0; i < 3; i++) {
		ret = i2c_smbus_read_byte_data(data->client, addr);
		if (ret < 0)
			return ret;
		buf[i] = ret;
	}
	return le24_to_cpu(buf);

> +
> +	return ret;
> +}
> +
> +static int ltrf216a_get_lux(struct ltrf216a_data *data)
> +{
> +	int greendata, cleardata, lux;
> +
> +	greendata = ltrf216a_read_data(data, LTRF216A_ALS_DATA_0);
> +	cleardata = ltrf216a_read_data(data, LTRF216A_CLEAR_DATA_0);
> +
> +	if (greendata < 0 || cleardata < 0)

I'd rather see the error passed all the way up than eaten here.

> +		lux = 0;
> +	else
> +		lux = greendata * 8 * WIN_FAC / data->als_gain_fac / data->int_time_fac / 10;

This feels like it would be better reported as
IIO_VAL_FRACTIONAL;
Won't make any difference if the only user is sysfs, but if anyone
ever wants to use the in kernel access to this device they will get
access to better precision.

Also possible the core handling for IIO_VAL_FRACTIONAL will do a better
job on retaining precision.

> +
> +	return lux;
> +}
> +
> +static int ltrf216a_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	int ret;
> +	struct ltrf216a_data *data = iio_priv(indio_dev);
> +
> +	mutex_lock(&data->mutex);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = ltrf216a_get_lux(data);
> +		*val = ret;
> +		ret = IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		ret = ltrf216a_get_it_time(data, val, val2);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static int ltrf216a_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int val,
> +			      int val2, long mask)
> +{
> +	struct ltrf216a_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		if (val != 0)
> +			return -EINVAL;
> +		mutex_lock(&data->mutex);
> +		ret = ltrf216a_set_it_time(data, val2);
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info ltrf216a_info = {
> +	.read_raw	= ltrf216a_read_raw,
> +	.write_raw	= ltrf216a_write_raw,
> +	.attrs		= &ltrf216a_attribute_group,
> +};
> +
> +static int ltrf216a_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)

Whilst it's taking a long time to clean out the old
approach, probe_new() callback preferred for new i2c drivers.

> +{
> +	struct ltrf216a_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	mutex_init(&data->mutex);
> +
> +	indio_dev->info = &ltrf216a_info;
> +	indio_dev->name = LTRF216A_DRV_NAME;
> +	indio_dev->channels = ltrf216a_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ltrf216a_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = ltrf216a_init(indio_dev);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "ltrf216a chip init failed\n");
> +		return ret;

As below, slightly preference for dev_err_probe().
It doesn't really matter when deferral isn't a possibility but using
that function ends up slightly neater.

> +	}
blank line here.  Adding separation so we have
"function call
error handler

next thing.."

Just makes things a tiny bit easier to read quickly.


> +	data->int_time = 100000;
> +	data->int_time_fac = 1;
> +	data->als_gain_fac = 3;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "failed to register iio dev\n");
Once using devm, this can be
		return dev_err_probe(&client->dev, ret,
				     "failed to register iio dev\n");

Which is neater but only use this function to print errors for things
that happen in probe.
 
> +		goto err_init;
> +	}
> +
> +	return 0;
> +err_init:
> +	ltrf216a_disable(indio_dev);
> +	return ret;
> +}
> +
> +static int ltrf216a_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);
> +	ltrf216a_disable(indio_dev);

As Kryzstof mentioned, use
devm versions and where they don't exist you can use
devm_add_action_or_reset() (e.g. for this disable)

That way we don't need error handling or a remove function.
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int ltrf216a_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +
> +	return ltrf216a_disable(indio_dev);
> +}
> +
> +static int ltrf216a_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +
> +	return ltrf216a_init(indio_dev);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(ltrf216a_pm_ops, ltrf216a_suspend, ltrf216a_resume);
> +#define LTRF216A_PM_OPS (&ltrf216a_pm_ops)
> +#else
> +#define LTRF216A_PM_OPS NULL
> +#endif

Recently some 'magic' macros were added to pm.h that allow you to just
specify this stuff without guards 

static DEFINE_SIMPLE_PM_OPS(ltrf216a_pm_ops, lt..._)

and use

.pm = pm_sleep_ptr(&ltrf216a_pm_ops),

below

and then the compiler can see enough to remove the unused code
if CONFIG_PM_SLEEP isn't defined without the need for messy
__maybe_unused etc.

We are part way through driving this change through IIO and
less of the way along with the rest of the kernel, but it's
a nice cleanup so please apply it to new code like this.

> +
> +static const struct i2c_device_id ltrf216a_id[] = {
> +	{ LTRF216A_DRV_NAME, 0},

Space after 0

> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, ltrf216a_id);
> +
> +static const struct of_device_id ltrf216a_of_match[] = {
> +	{ .compatible = "ltr,ltrf216a", },
> +	{ .compatible = "liteon,ltrf216a", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ltrf216a_of_match);
> +
> +static struct i2c_driver ltrf216a_driver = {
> +	.driver = {
> +		.name = LTRF216A_DRV_NAME,
> +		.pm = LTRF216A_PM_OPS,
> +		.of_match_table = ltrf216a_of_match,
> +	},
> +	.probe		= ltrf216a_probe,
> +	.remove		= ltrf216a_remove,
> +	.id_table	= ltrf216a_id,
> +};
> +
> +module_i2c_driver(ltrf216a_driver);
> +
> +MODULE_AUTHOR("Shi Zhigang <Zhigang.Shi@liteon.com>");
> +MODULE_DESCRIPTION("LTRF216A ambient light sensor driver");
> +MODULE_LICENSE("GPL v2");

