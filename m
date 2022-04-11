Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A144FC2E7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 19:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348745AbiDKRJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 13:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiDKRJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 13:09:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062EB1FCD6;
        Mon, 11 Apr 2022 10:07:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id B492E1F43742
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649696823;
        bh=ObQYeh86iXVw5tZUjsEQEzqaRIl8zOWwS5sgStC7qVU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KNDeqnFKXxqc3CsWA9PiRey+bECP9FBmTAobtO00PlsxLRw67zAQePoDSBklUm9cj
         5JwZwB9D4rMqHL5o2lvgTd8wB/bdCrgahwDeBsNnACC217G7jcHsxXxpsP0jzUjxAv
         Ai1R56YLr2GlS0M70Hva5EG05+XR1h/UgvKOKaFJsH0hmTEDvkd+uVHUxGxFOnVqab
         6/u7OgUuPY8+l27NymDdUyPMsPYzcejYDFDPOPQ6DHy3A17SIPTs1YKBChbWTLPzs/
         WXyq11agykZ2soxMz3+IOVTp+2fLBKqGSvl9E4ufrg4QFxf1RvFV0P83VoYgUX66m7
         vTg6nk5/stnqw==
Message-ID: <d5de6b56-ad90-feec-c65a-53699c8ddbe9@collabora.com>
Date:   Mon, 11 Apr 2022 22:36:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/3] iio: light: Add support for ltrf216a sensor
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>, krzk@kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        krisman@collabora.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, alvaro.soliverez@collabora.com
References: <20220325103014.6597-1-shreeya.patel@collabora.com>
 <20220325103014.6597-4-shreeya.patel@collabora.com>
 <20220327153049.10e525e9@jic23-huawei>
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <20220327153049.10e525e9@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/22 20:00, Jonathan Cameron wrote:

Hi Jonathan,

I have a question inline related to one of your comments.

> On Fri, 25 Mar 2022 16:00:14 +0530
> Shreeya Patel <shreeya.patel@collabora.com> wrote:
>
> Hi Zhigang, Shreeya,
>
> Comments inline.
>
> Thanks,
>
> Jonathan
>> From: Zhigang Shi <Zhigang.Shi@liteon.com>
>>
>> Add initial support for ltrf216a ambient light sensor.
>>
>> Datasheet :-
>> https://gitlab.steamos.cloud/shreeya/iio/-/blob/main/LTR-F216A-QT.pdf
> We now have a Datasheet tag, so make this part of the tag block so automated
> tools can find it easily:
>>
> Datasheet: https://gitlab.steamos.cloud/shreeya/iio/-/blob/main/LTR-F216A-QT.pdf
>> Co-developed-by: Shreeya Patel <shreeya.patel@collabora.com>
>> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
>> Signed-off-by: Zhigang Shi <Zhigang.Shi@liteon.com>
>> ---
>>   drivers/iio/light/Kconfig    |  10 ++
>>   drivers/iio/light/Makefile   |   1 +
>>   drivers/iio/light/ltrf216a.c | 334 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 345 insertions(+)
>>   create mode 100644 drivers/iio/light/ltrf216a.c
>>
>> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
>> index a62c7b4b8678..08fa383a8ca7 100644
>> --- a/drivers/iio/light/Kconfig
>> +++ b/drivers/iio/light/Kconfig
>> @@ -318,6 +318,16 @@ config SENSORS_LM3533
>>   	  changes. The ALS-control output values can be set per zone for the
>>   	  three current output channels.
>>   
>> +config LTRF216A
>> +        tristate "Liteon LTRF216A Light Sensor"
>> +        depends on I2C
>> +        help
>> +          If you say Y or M here, you get support for Liteon LTRF216A
>> +          Ambient Light Sensor.
>> +
>> +          If built as a dynamically linked module, it will be called
>> +          ltrf216a.
>> +
>>   config LTR501
>>   	tristate "LTR-501ALS-01 light sensor"
>>   	depends on I2C
>> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
>> index d10912faf964..8fa91b9fe5b6 100644
>> --- a/drivers/iio/light/Makefile
>> +++ b/drivers/iio/light/Makefile
>> @@ -30,6 +30,7 @@ obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
>>   obj-$(CONFIG_ISL29125)		+= isl29125.o
>>   obj-$(CONFIG_JSA1212)		+= jsa1212.o
>>   obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
>> +obj-$(CONFIG_LTRF216A)		+= ltrf216a.o
>>   obj-$(CONFIG_LTR501)		+= ltr501.o
>>   obj-$(CONFIG_LV0104CS)		+= lv0104cs.o
>>   obj-$(CONFIG_MAX44000)		+= max44000.o
>> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
>> new file mode 100644
>> index 000000000000..99295358a7fe
>> --- /dev/null
>> +++ b/drivers/iio/light/ltrf216a.c
>> @@ -0,0 +1,334 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * LTRF216A Ambient Light Sensor
>> + *
>> + * Copyright (C) 2021 Lite-On Technology Corp (Singapore)
>> + * Author: Shi Zhigang <Zhigang.Shi@liteon.com>
>> + *
>> + * IIO driver for LTRF216A (7-bit I2C slave address 0x53).
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/i2c.h>
>> +#include <linux/mutex.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
> mod_devicetable.h for the id tables
>
>> +#include <linux/pm.h>
>> +#include <linux/delay.h>
>> +
>> +#define LTRF216A_DRV_NAME "ltrf216a"
>> +
>> +#define LTRF216A_MAIN_CTRL		0x00
>> +
>> +#define LTRF216A_ALS_MEAS_RATE		0x04
> MEAS_RES seems more appropriate from datasheet.
> As mentioned below, also add defines for all the fields
> of the registers you will access and where the fields are
> obvious numerical things, add defines for the values they
> can take.
>
>
>> +#define LTRF216A_MAIN_STATUS		0x07
>> +#define LTRF216A_CLEAR_DATA_0		0x0A
>> +
>> +#define LTRF216A_ALS_DATA_0		0x0D
>> +
>> +static const int int_time_mapping[] = { 400000, 200000, 100000 };
>> +
>> +struct ltrf216a_data {
>> +	struct i2c_client *client;
>> +	u32			int_time;
>> +	u8			int_time_fac;
>> +	u8			als_gain_fac;
>> +	struct mutex mutex;
> All locks need a comment to say exactly what they are protecting.
>
>> +};
>> +
>> +/* open air. need to update based on TP transmission rate. */
>> +#define WIN_FAC	1
>> +
>> +static const struct iio_chan_spec ltrf216a_channels[] = {
>> +	{
>> +		.type = IIO_LIGHT,
>> +		.info_mask_separate =
>> +			BIT(IIO_CHAN_INFO_PROCESSED) |
>> +			BIT(IIO_CHAN_INFO_INT_TIME),
>> +	}
>> +};
>> +
>> +static IIO_CONST_ATTR_INT_TIME_AVAIL("0.1 0.2 0.4");
>> +
>> +static struct attribute *ltrf216a_attributes[] = {
>> +	&iio_const_attr_integration_time_available.dev_attr.attr,
> please use the read_avail callback and set the appropriate
> _available bit.
>
> That allows in kernel access to this information + is probably
> shorter in this case as you won't have an attribute group etc
> to deal wtih.
>
>> +	NULL
>> +};
>> +
>> +static const struct attribute_group ltrf216a_attribute_group = {
>> +	.attrs = ltrf216a_attributes,
>> +};
>> +
>> +static int ltrf216a_init(struct iio_dev *indio_dev)
>> +{
>> +	int ret;
>> +	struct ltrf216a_data *data = iio_priv(indio_dev);
>> +
>> +	ret = i2c_smbus_read_byte_data(data->client, LTRF216A_MAIN_CTRL);
>> +	if (ret < 0) {
>> +		dev_err(&data->client->dev, "Error reading LTRF216A_MAIN_CTRL\n");
>> +		return ret;
>> +	}
>> +
>> +	/* enable sensor */
>> +	ret |= 0x02;
> Needs a #define and preferably use
> 	ret |= FIELD_PREP()...
>
>> +	ret = i2c_smbus_write_byte_data(data->client, LTRF216A_MAIN_CTRL, ret);
>> +	if (ret < 0) {
>> +		dev_err(&data->client->dev, "Error writing LTRF216A_MAIN_CTRL\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int ltrf216a_disable(struct iio_dev *indio_dev)
>> +{
>> +	int ret;
>> +	struct ltrf216a_data *data = iio_priv(indio_dev);
>> +
>> +	ret = i2c_smbus_write_byte_data(data->client, LTRF216A_MAIN_CTRL, 0);
>> +	if (ret < 0)
>> +		dev_err(&data->client->dev, "Error writing LTRF216A_MAIN_CTRL\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static int ltrf216a_set_it_time(struct ltrf216a_data *data, int itime)
>> +{
>> +	int i, ret, index = -1;
>> +	u8 reg;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(int_time_mapping); i++) {
>> +		if (int_time_mapping[i] == itime) {
>> +			index = i;
>> +			break;
>> +		}
>> +	}
>> +	/* Make sure integration time index is valid */
>> +	if (index < 0)
>> +		return -EINVAL;
>> +
>> +	if (index == 0) {
> Switch statement seems more appropriate than this stack of if else
>
>> +		reg = 0x03;
> reg isn't a great name as I assume this is the value, not the address
> which was my first thought... Perhaps reg_val?
>
>> +		data->int_time_fac = 4;
>> +	} else if (index == 1) {
>> +		reg = 0x13;
>> +		data->int_time_fac = 2;
>> +	} else {
>> +		reg = (index << 4) | 0x02;
> Unless I'm missing something index == 2 if we get here.
> So why the calculation?  I'd suggest defining the two fields and using
> FIELD_PREP() to set up each part probably to one of a set of
> #define LTRF216A_ALS_MEAS_RATE_
>
>> +		data->int_time_fac = 1;
>> +	}
>> +
>> +	ret = i2c_smbus_write_byte_data(data->client, LTRF216A_ALS_MEAS_RATE, reg);
> Called MEAS_RES on the datasheet, why this name for the register?
>
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	data->int_time = itime;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ltrf216a_get_it_time(struct ltrf216a_data *data, int *val, int *val2)
>> +{
>> +	*val = 0;
>> +	*val2 = data->int_time;
> I'd put this inline as it avoids a question I had at the call site on why
> you passed *val in as it would always be 0.
>
>> +
>> +	return IIO_VAL_INT_PLUS_MICRO;
>> +}
>> +
>> +static int ltrf216a_read_data(struct ltrf216a_data *data, u8 addr)
>> +{
>> +	int ret;
>> +	int tries = 25;
>> +	int val_0, val_1, val_2;
>> +
>> +	while (tries--) {
>> +		ret = i2c_smbus_read_byte_data(data->client, LTRF216A_MAIN_STATUS);
>> +		if (ret < 0)
>> +			return ret;
>> +		if (ret & 0x08)
> That 0x08 is a magic number and also better defined using BIT(3)
> Anyhow, use a define for that.
>
>> +			break;
>> +		msleep(20);
>> +	}
>> +
>> +	val_0 = i2c_smbus_read_byte_data(data->client, addr);
> All of these can return errors so you should check.
> Device doesn't support any larger reads?
>
>> +	val_1 = i2c_smbus_read_byte_data(data->client, addr + 1);
>> +	val_2 = i2c_smbus_read_byte_data(data->client, addr + 2);
>> +	ret = (val_2 << 16) + (val_1 << 8) + val_0;
> This is a le24_to_cpu() conversion.
> Preferred choice would be to use something like
> 	u8 buf[3];
> 	int i;
>
> 	for (i = 0; i < 3; i++) {
> 		ret = i2c_smbus_read_byte_data(data->client, addr);
> 		if (ret < 0)
> 			return ret;
> 		buf[i] = ret;
> 	}
> 	return le24_to_cpu(buf);
>

We do not have any le24_to_cpu() function in current kernel source code.
I was thinking to use le32_to_cpu() instead but it requires an argument of
type __le32 and our case we storing the values in u8 buf[3] so I'm not
really sure if it's possible to use le32_to_cpu() or any other function.



Thanks,
Shreeya Patel

