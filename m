Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E11757388C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbiGMOQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiGMOQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:16:20 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C222F255B5;
        Wed, 13 Jul 2022 07:16:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so3858646pjr.4;
        Wed, 13 Jul 2022 07:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rQncS2p3wVKtOjrW4i07RKhqwuoViitZNvlS0Y4jzLc=;
        b=j2hRrJ9MyKlTj5RkDSuR7tuhnFy8qC33r2jaCE6VA66SIE+LIT6iLUXf8g08U7PCar
         k2DRPgEsVQVvjr3YKPrptd0YcQhLjzn8oRrbO2QOJritjWiKqvVNwPUR1HHZBxMM2pza
         PyRwRHThq41tpukMw5yKbheKsVl6wum6aSIIw7EgXig6Ugr+HNL0OwIhPCalXF/eI8sp
         whHNgNaGlRb1N3DTpna+Bbx7YWPbcSFZ2ZJy97MVn4hxgHtW60FA2QgrOm2+YakG9BNK
         PNJZ9xEoLBLjUs3V7oVb95zBu4oij2TUBaHt2N1sV5ZYuUWk7KCzweCMP1f+3/fqPKui
         fp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rQncS2p3wVKtOjrW4i07RKhqwuoViitZNvlS0Y4jzLc=;
        b=QYtsFTioZJLfgCyVhRd/uTvTyqLh9ZVKm4AM5xvttMLXY7IleeENa5X3Uu4Qwy0nDu
         GgJRb4GVzygq4bYuJda/70+45jxbDQvLWJ1Fkip0ua9G7Z8UCd3PdgKhIQc6KHIK8gEC
         NHYUuxp9Wk0G8makGAb0c/DW7xeSZ51ojT6Gr1txXd7FcttpyYZsdv2hYHy8iJrXiyW+
         zYHjFT3LQzzwXidgOqpcXzMM41LO8KYQiY/hhe5Oyxt7jyGsKLihD+C+ipm2EKUZeMLe
         X1KdAs81RGp/wmWX9ZZJOVsFcrKPYqA3u8zxj68hKvJM+2PsDAQd9LQrhDtYRn9mdhAU
         I2fQ==
X-Gm-Message-State: AJIora+DEXhj7kJ+Fi/vEhAF003EEJ03YFWdP5xuuLWl8UbUNN/j90FT
        GCJxA/y3K/NymAfkNTMAROk=
X-Google-Smtp-Source: AGRyM1v+nME38Ex7+AIFMd8GLL5z9F+LWfZaFGnZESpqOcMyYzgfxVm/PTkCuOsI0ZKBunsx7IWOqQ==
X-Received: by 2002:a17:90a:ca12:b0:1ef:7c87:70ac with SMTP id x18-20020a17090aca1200b001ef7c8770acmr10552201pjt.153.1657721779148;
        Wed, 13 Jul 2022 07:16:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v3-20020aa799c3000000b0052ab9f1fe45sm8930791pfi.120.2022.07.13.07.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 07:16:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 13 Jul 2022 07:16:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Atif Ofluoglu <Atif.Ofluoglu@analog.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (pmbus/max20754) Add support for MAX20754
Message-ID: <20220713141616.GA3823727@roeck-us.net>
References: <cover.1657204859.git.atif.ofluoglu@analog.com>
 <3659043f92b0ca9e538679e00f7dcc214525ff2e.1657204859.git.atif.ofluoglu@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3659043f92b0ca9e538679e00f7dcc214525ff2e.1657204859.git.atif.ofluoglu@analog.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 03:29:17PM +0000, Atif Ofluoglu wrote:
> From: Atif Ofluoglu <atif.ofluoglu@analog.com>
> 
> Signed-off-by: Atif Ofluoglu <Atif.Ofluoglu@analog.com>

Please use lowercase for the e-mail address to avoid confusing
checkpatch.

> ---
>  drivers/hwmon/pmbus/Kconfig    |   9 +
>  drivers/hwmon/pmbus/Makefile   |   1 +
>  drivers/hwmon/pmbus/max20754.c | 390 +++++++++++++++++++++++++++++++++
>  3 files changed, 400 insertions(+)
>  create mode 100644 drivers/hwmon/pmbus/max20754.c
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index dfae76db65ae..f259b8739766 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -254,6 +254,15 @@ config SENSORS_MAX20751
>  	  This driver can also be built as a module. If so, the module will
>  	  be called max20751.
>  
> +config SENSORS_MAX20754
> +	tristate "Maxim MAX20754"
> +	help
> +	  If you say yes here you get hardware monitoring support for Maxim
> +	  MAX20754.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called max20754.
> +
>  config SENSORS_MAX31785
>  	tristate "Maxim MAX31785 and compatibles"
>  	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 4678fba5012c..b8b1d8a84b3b 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_SENSORS_MAX16064)	+= max16064.o
>  obj-$(CONFIG_SENSORS_MAX16601)	+= max16601.o
>  obj-$(CONFIG_SENSORS_MAX20730)	+= max20730.o
>  obj-$(CONFIG_SENSORS_MAX20751)	+= max20751.o
> +obj-$(CONFIG_SENSORS_MAX20751)	+= max20754.o
>  obj-$(CONFIG_SENSORS_MAX31785)	+= max31785.o
>  obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
>  obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
> diff --git a/drivers/hwmon/pmbus/max20754.c b/drivers/hwmon/pmbus/max20754.c
> new file mode 100644
> index 000000000000..5e29e8f8009b
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/max20754.c
> @@ -0,0 +1,390 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Maxim MAX20754 Dual-Output, Configurable Multiphase
> + * Power-Supply Controller with PMBus Interface
> + * and Internal Buck Converter Driver
> + *
> + * Author: Atif Emre Ofluoglu <atif.ofluoglu@analog.com>
> + * Copyright (C) 2022 Analog Devices
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under  the terms of  the GNU General  Public License as published
> + * by the Free Software Foundation;  either version 2 of the  License,
> + * or (at your option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/hwmon.h>

Alphabetic include file order, please.

> +#include <linux/hwmon-sysfs.h>

Not needed.

> +#include "pmbus.h"
> +
> +enum chips { max20754 };

Not needed unless you plan to add another chip to the driver later on,
and then it should be added with the patch introducing that chip.

> +
> +#define MAX20754_NUM_PHASES 6
> +#define MAX20754_LINEAR_EXPONENT -10

#define<space>NAME<tab>value, please. Also, (-10)

> +
> +struct max20754_data {
> +	enum chips id;
> +	struct pmbus_driver_info info;
> +	struct i2c_client *rail2;
> +	bool smbus_i2c_block_read;
> +};
> +
> +#define to_max20754_data(x) container_of(x, struct max20754_data, info)
> +
> +enum max20754_reg_index {
> +	operation_index,
> +	on_off_config_index,
> +	vout_command_index,
> +	num_regs,
> +};
> +
> +static const u8 max20754_regs[num_regs][2] = {
> +	[operation_index] = {PMBUS_OPERATION, 1},
> +	[on_off_config_index] = {PMBUS_ON_OFF_CONFIG, 1},
> +	[vout_command_index] = {PMBUS_VOUT_COMMAND, 2},
> +};
> +
> +static u16 val_to_linear16(int val)
> +{
> +	return ((u16)val * 1000LL) >> -MAX20754_LINEAR_EXPONENT;

Double negation whenever MAX20754_LINEAR_EXPONENT ? What is the point
of that ?

> +}
> +
> +static long linear16_to_val(s64 val)
> +{
> +	if (val == 0)
> +		return 0;

Why is that needed ?

> +
> +	val <<= -MAX20754_LINEAR_EXPONENT;
> +	val = DIV_ROUND_CLOSEST_ULL(val, 1000);
> +	val = clamp_val(val, 0, 0xffff);
> +	return val;
> +}
> +
> +static int max20754_read_block_data(struct i2c_client *client, int reg,
> +				    u8 length, u8 *values)
> +{
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct max20754_data *data = to_max20754_data(info);
> +	int ret;
> +
> +	if (data->smbus_i2c_block_read) {
> +		ret = i2c_smbus_read_i2c_block_data(client, reg, length, values);
> +		if (ret < 1)
> +			return ret;
> +		ret = ret - 1;
> +		memcpy(values, &values[1], ret);
> +	} else {
> +		ret = i2c_smbus_read_block_data(client, reg, values);
> +	}
> +
> +	return ret;
> +}
> +
> +static int max20754_read_word(struct i2c_client *client, int page, int phase,
> +			      int reg)
> +{
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct max20754_data *data = to_max20754_data(info);
> +
> +	if (reg > 0xFF)
> +		return -ENXIO;
> +
> +	if (reg == PMBUS_MFR_VOUT_MAX)
> +		reg = PMBUS_VOUT_MAX;
> +

I don't think this makes sense. MFR_VOUT_MAX is the _rated_
maximum output voltage, while VOUT_MAX is the _configured_ maximum
output voltage. Those are distinctly diffferent.

> +	switch (page) {
> +	case 0:		/* RAIL1 */
> +		return i2c_smbus_read_word_data(client, reg);
> +	case 1:		/* RAIL2 */
> +		return i2c_smbus_read_word_data(data->rail2, reg);
> +	default:
> +		return -ENODATA;
> +	}
> +
> +	return -ENODATA;
> +}
> +
> +static int max20754_write_word(struct i2c_client *client, int page, int reg, u16 value)
> +{
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct max20754_data *data = to_max20754_data(info);
> +
> +	switch (reg) {
> +	case PMBUS_OPERATION:
> +		if (value >= 0x90 && value <= 0x93)
> +			return -EOPNOTSUPP;
> +		break;
> +	case PMBUS_MFR_VOUT_MAX:
> +		reg = PMBUS_VOUT_MAX;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	switch (page) {
> +	case 0:		/* RAIL1 */
> +		return i2c_smbus_write_word_data(client, reg, value);
> +	case 1:		/* RAIL2 */
> +		return i2c_smbus_write_word_data(data->rail2, reg, value);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return -ENODATA;
> +}
> +
> +static int max20754_read_byte(struct i2c_client *client, int page, int reg)
> +{
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct max20754_data *data = to_max20754_data(info);
> +	int vout_mode;
> +
> +	if (reg == PMBUS_VOUT_MODE) {
> +		vout_mode = i2c_smbus_read_byte_data(client, reg);
> +		if (vout_mode != 0x2C)
> +			vout_mode = 0x16;

This ignores errors.

> +		return vout_mode;

Needs explanation.

> +	}
> +
> +	switch (page) {
> +	case 0:		/* RAIL1 */
> +		return i2c_smbus_read_byte_data(client, reg);
> +	case 1:		/* RAIL2 */
> +		return i2c_smbus_read_byte_data(data->rail2, reg);
> +	default:
> +		return -ENODATA;
> +	}
> +	return -ENODATA;
> +}
> +
> +static int max20754_write_byte(struct i2c_client *client, int page, u8 reg)
> +{
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct max20754_data *data = to_max20754_data(info);
> +
> +	if (reg == PMBUS_CLEAR_FAULTS) {
> +		switch (page) {
> +		case 0:
> +			return i2c_smbus_write_byte(client, reg);
> +		case 1:
> +			return i2c_smbus_write_byte(data->rail2, reg);
> +		default:
> +			return -ENODATA;
> +		}
> +	}
> +	return -ENODATA;
> +}
> +
> +static int max20754_identify(struct i2c_client *client,
> +			     struct pmbus_driver_info *info)
> +{
> +	struct device *dev = &client->dev;
> +	u8 buf[9] = {0};
> +	int ret;
> +
> +	ret = max20754_read_block_data(client,
> +				       PMBUS_IC_DEVICE_ID, 9,
> +				       buf);
> +
> +	if (ret < 0 || ret < 8)
> +		return -ENODEV;
> +
> +	/*
> +	 * PMBUS_IC_DEVICE_ID is expected to return "MAX20754"
> +	 */
> +
> +	if (strncmp(buf, "MAX20754", 8)) {
> +		buf[ret] = '\0';
> +		dev_err(dev, "Unsupported chip '%s'\n", buf);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}

The above can and should be handled in the probe function.
With this, the smbus_i2c_block_read boolean in struct max20754_data
is no longer necessary. 

> +
> +static ssize_t max20754_register_store(struct device *dev,
> +				       struct device_attribute *attr, const char *buf,
> +				       size_t count)
> +{
> +	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct max20754_data *data = to_max20754_data(info);
> +
> +	u8 cmd = max20754_regs[sattr->index][0];
> +	u8 reg_size = max20754_regs[sattr->index][1];
> +	u8 rail_number = sattr->nr;
> +	long val = 0;

Unnecessary initialization.

> +	int ret;
> +
> +	ret = kstrtol(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (rail_number == 1)
> +		client = data->rail2;
> +
> +	if (cmd == PMBUS_VOUT_COMMAND)
> +		val = linear16_to_val(val);
> +
> +	switch (reg_size) {
> +	case 1:
> +		ret = i2c_smbus_write_byte_data(client, cmd, val);
> +		break;
> +	case 2:
> +		ret = i2c_smbus_write_word_data(client, cmd, val);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static ssize_t max20754_register_show(struct device *dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +
> +	int ret_val = 0;

Why ret_val instead of ret like everywhere else ?

> +	u8 cmd = max20754_regs[sattr->index][0];
> +	u8 reg_size = max20754_regs[sattr->index][1];
> +	u8 rail_number = sattr->nr;
> +
> +	switch (reg_size) {
> +	case 1:
> +		ret_val = max20754_read_byte(client, rail_number, cmd);
> +		break;
> +	case 2:
> +		ret_val = max20754_read_word(client, rail_number, 0, cmd);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (ret_val < 0)
> +		return -ENODATA;
> +
> +	if (cmd == PMBUS_VOUT_COMMAND)
> +		ret_val = val_to_linear16(ret_val);
> +
> +	return sprintf(buf, "%d\n", ret_val);
> +}
> +
> +#define MAX20754_REGISTER_ATTR_RW(__name, __reg_index, __size) \
> +	SENSOR_DEVICE_ATTR_2_RW(__name, max20754_register, __size, __reg_index)
> +
> +static MAX20754_REGISTER_ATTR_RW(operation, operation_index, 0);
> +static MAX20754_REGISTER_ATTR_RW(on_off_config, on_off_config_index, 0);
> +
> +static MAX20754_REGISTER_ATTR_RW(vout1_command, vout_command_index, 0);
> +static MAX20754_REGISTER_ATTR_RW(vout2_command, vout_command_index, 1);
> +

The above attributes are not acceptable. Register as regulator(s) if you
want to control output voltage and operation.

> +static struct attribute *max20754_attrs[] = {
> +	&sensor_dev_attr_operation.dev_attr.attr,
> +	&sensor_dev_attr_on_off_config.dev_attr.attr,
> +	&sensor_dev_attr_vout1_command.dev_attr.attr,
> +	&sensor_dev_attr_vout2_command.dev_attr.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(max20754);
> +
> +static struct pmbus_driver_info max20754_info = {
> +	.pages = 2,
> +	.format[PSC_VOLTAGE_IN] = linear,
> +	.format[PSC_VOLTAGE_OUT] = linear,
> +	.vrm_version[0] = vr12,
> +	.format[PSC_TEMPERATURE] = linear,
> +	.format[PSC_CURRENT_OUT] = linear,
> +	.format[PSC_POWER] = linear,
> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> +		PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
> +		PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_STATUS_TEMP,
> +	.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_INPUT |
> +		PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
> +		PMBUS_HAVE_TEMP2 | PMBUS_HAVE_STATUS_TEMP,
> +	.identify = max20754_identify,
> +	.read_byte_data = max20754_read_byte,
> +	.read_word_data = max20754_read_word,
> +	.write_byte = max20754_write_byte,
> +	.write_word_data = max20754_write_word,
> +};
> +
> +static void max20754_remove(void *_data)
> +{
> +	struct max20754_data *data = _data;
> +
> +	i2c_unregister_device(data->rail2);
> +}
> +
> +static int max20754_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct max20754_data *data;
> +	bool i2c_block_data_ok = false;
> +	int ret = 0;

Unnecessary assignment.

> +
> +	ret = i2c_check_functionality(client->adapter,
> +				      I2C_FUNC_SMBUS_READ_BYTE_DATA |
> +				      I2C_FUNC_SMBUS_READ_BLOCK_DATA);
> +
Unnecessary empty line. Also, assigning the return value to a variable
isn't really necessary.

	if (!i2c_check_functionality(...)) {
		...


> +	if (!ret) 
> +		ret = i2c_check_functionality(client->adapter,
> +					      I2C_FUNC_SMBUS_READ_BYTE_DATA |
> +					      I2C_FUNC_SMBUS_I2C_BLOCK);
> +		if (!ret)
> +			return -ENODEV;

		if (!i2c_check_functionality(...))
			return -ENODEV;
> +
> +		i2c_block_data_ok = true;
> +	}
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->rail2 = i2c_new_dummy_device(client->adapter, client->addr + 1);
> +	if (IS_ERR(data->rail2)) {
> +		dev_err(dev, "Failed to register rail2 client\n");
> +		return PTR_ERR(data->rail2);
> +	}
> +	ret = devm_add_action_or_reset(dev, max20754_remove, data);
> +	if (ret)
> +		return ret;
> +
> +	data->info = max20754_info;
> +	data->info.groups = max20754_groups;
> +	data->smbus_i2c_block_read = i2c_block_data_ok;
> +
> +	return pmbus_do_probe(client, &data->info);
> +}
> +
> +static const struct i2c_device_id max20754_id[] = {
> +	{"max20754", max20754},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, max20754_id);
> +
> +static struct i2c_driver max20754_driver = {
> +	.driver = {
> +		   .name = "max20754",
> +		   },
> +	.probe_new = max20754_probe,
> +	.remove = pmbus_do_remove,

Please rebase to latest kernel. pmbus_do_remove() no longer exists.

> +	.id_table = max20754_id,
> +};
> +
> +module_i2c_driver(max20754_driver);
> +
> +MODULE_AUTHOR("Atif Emre Ofluoglu <atif.ofluoglu@analog.com>");
> +MODULE_DESCRIPTION("PMBus driver for Maxim MAX20754");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(PMBUS);
