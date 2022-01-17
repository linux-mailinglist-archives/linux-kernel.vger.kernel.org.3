Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E34C490F56
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 18:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242520AbiAQRWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 12:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239657AbiAQRVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:21:48 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF906C06175E;
        Mon, 17 Jan 2022 09:21:47 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id y11-20020a0568302a0b00b0059a54d66106so3482814otu.0;
        Mon, 17 Jan 2022 09:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:references:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rzXBkI7jlHLCnBzysOGzaf96oe/yXp64alYmf6FTdt0=;
        b=jGDLOebj0DlXWUCv3zHfJqwC5erpP6tmwzt/LsLLtD5rtVSpyxeMzSqpjBBboPhhIU
         sMBneCn12n7GmqchNPhXKuDlk3OZn1PUnzHOUpoBbKhI7X1oDLQareAxD3XAbN8H8bZo
         CvZPAJhagvY2iagxm7gMI36dCa1Us8JSpoSbWuk7AcuQ8HnxRzaDqSjwjxmmnOHYQ2IP
         5tHQhgdnxOrDU9qpvCkjnLQVcwDHAgX2AT07qYwdsBVpLal/YrRobVwOV1qA1mfCrFTG
         C/Aok9ZycC+o0ZGUmX/xOzXcu4QvG78nszK++Pot0wxaMRJ9LgosR8zNdTEM6GjPSw/w
         56iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:references:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rzXBkI7jlHLCnBzysOGzaf96oe/yXp64alYmf6FTdt0=;
        b=IMfuoenm1MNe1zAj7BrLW29zF2s4X97tHgrdC9IIoEZxDvLzMWPnbeb5hrZ2ndVAmx
         Gws8cTAgJ1QpYXB/g+0CySRRUCqICx42lOJGXKXFE9Nr6yKdM5f7EAKEgNYoKvAGFg2M
         pMl94ea8mSXy1r0BgO9bC+tY79vW0Z6Si8upVqubCFBd0XdYHOPQsVjn2eEBtNBDfWC3
         U+WJHYIP9CUPkCbow+C0nqEvy9svnj4+A0qcRlyMu474TX9dst6u4yudateIto7zlEZB
         3R3kNXyu8c4QlJ29zZ8XsNFWGjm5/xhDZ4MKJWsv5G5Zq3jkKvjlnosN1HX5q+Ldooqq
         Mm9A==
X-Gm-Message-State: AOAM53202ggNHFAdsQ75voUMOVHFECZaiJHVpcus3acS0p41k8Q2gGwB
        zUkVG6+OBVBzH6Cvzzpu0xO96rk8F9s=
X-Google-Smtp-Source: ABdhPJxyuyT1dvo2md01Q65+3N8amYjJF72Y8NFZoq253orHpLdf3NHlEZcjRKdBtuuxSQYVpQ6pMA==
X-Received: by 2002:a05:6830:232e:: with SMTP id q14mr16884274otg.133.1642440106869;
        Mon, 17 Jan 2022 09:21:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t14sm5895975oth.81.2022.01.17.09.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 09:21:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-hwmon@vger.kernel.org
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
References: <cover.1642434222.git.sylv@sylv.io>
 <db9cb6a43de9b248b76f815c6c173d1eefd42ad0.1642434222.git.sylv@sylv.io>
 <c04086b8-7948-c1d9-56ee-e20455e8c92b@roeck-us.net>
Subject: Re: [PATCH v1 4/4] pmbus: Add support for bcm6123 Bus Converter
Message-ID: <31890e5b-29f6-2ff0-f15d-a92c02c1e60c@roeck-us.net>
Date:   Mon, 17 Jan 2022 09:21:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c04086b8-7948-c1d9-56ee-e20455e8c92b@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/22 9:01 AM, Guenter Roeck wrote:
> On 1/17/22 8:12 AM, Marcello Sylvester Bauer wrote:
>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>
>> BCM6123 is an Fixed-Ratio DC-DC Converter.
>>
>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>> ---
>>   drivers/hwmon/pmbus/Kconfig   |  9 ++++
>>   drivers/hwmon/pmbus/Makefile  |  1 +
>>   drivers/hwmon/pmbus/bcm6123.c | 90 +++++++++++++++++++++++++++++++++++
> 
> Documentation/hwmon/bcm6123 is missing.
> 
>>   3 files changed, 100 insertions(+)
>>   create mode 100644 drivers/hwmon/pmbus/bcm6123.c
>>
>> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
>> index c96f7b7338bd..62dac90631c5 100644
>> --- a/drivers/hwmon/pmbus/Kconfig
>> +++ b/drivers/hwmon/pmbus/Kconfig
>> @@ -48,6 +48,15 @@ config SENSORS_ADM1275
>>         This driver can also be built as a module. If so, the module will
>>         be called adm1275.
>> +config SENSORS_BCM6123
>> +    tristate "Vicor BCM6123 Compatible Power Supplies"
> 
> Is this a power supply or a chip ? It can't be both.
> 
>> +    help
>> +      If you say yes here you get hardware monitoring support for Vicor
>> +      BCM6123 Power Supplies.
>> +
>> +      This driver can also be built as a module. If so, the module will
>> +      be called bcm6123.
>> +
>>   config SENSORS_BEL_PFE
>>       tristate "Bel PFE Compatible Power Supplies"
>>       help
>> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
>> index e5935f70c9e0..2918c2ea7bc5 100644
>> --- a/drivers/hwmon/pmbus/Makefile
>> +++ b/drivers/hwmon/pmbus/Makefile
>> @@ -7,6 +7,7 @@ obj-$(CONFIG_PMBUS)        += pmbus_core.o
>>   obj-$(CONFIG_SENSORS_PMBUS)    += pmbus.o
>>   obj-$(CONFIG_SENSORS_ADM1266)    += adm1266.o
>>   obj-$(CONFIG_SENSORS_ADM1275)    += adm1275.o
>> +obj-$(CONFIG_SENSORS_BCM6123)    += bcm6123.o
>>   obj-$(CONFIG_SENSORS_BEL_PFE)    += bel-pfe.o
>>   obj-$(CONFIG_SENSORS_BPA_RS600)    += bpa-rs600.o
>>   obj-$(CONFIG_SENSORS_DELTA_AHE50DC_FAN) += delta-ahe50dc-fan.o
>> diff --git a/drivers/hwmon/pmbus/bcm6123.c b/drivers/hwmon/pmbus/bcm6123.c
>> new file mode 100644
>> index 000000000000..78fc259bc40f
>> --- /dev/null
>> +++ b/drivers/hwmon/pmbus/bcm6123.c
>> @@ -0,0 +1,90 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Hardware monitoring driver for Infineon bcm6123
>> + *
> Infineon ?
> 
>> + * Copyright (c) 2021 9elements GmbH
>> + *
>> + * VOUT_MODE is not supported by the device. The driver fakes VOUT linear16
>> + * mode with exponent value -8 as direct mode with m=256/b=0/R=0.
>> + *
> 
> Does it not ? The datasheet doesn't say, and the code below doesn't match
> this description.
> 
>> + * The device supports VOUT_PEAK, IOUT_PEAK, and TEMPERATURE_PEAK, however
>> + * this driver does not currently support them.
> 
> Does it ? There is no reference for this in the datasheet.
> 
> Overall it seems like there is a lot of cut-and-paste. Please clean this up.
> 
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/i2c.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/pmbus.h>
>> +#include "pmbus.h"
>> +
>> +static struct pmbus_platform_data bcm6123_plat_data = {
>> +    .flags = PMBUS_NO_CAPABILITY,
>> +};
> 
> We should only set this flag if it is really needed.
> 
>> +
>> +static struct pmbus_driver_info bcm6123_info = {
>> +    .pages = 2,
>> +    .format[PSC_VOLTAGE_IN] = direct,
>> +    .format[PSC_VOLTAGE_OUT] = direct,
>> +    .format[PSC_CURRENT_IN] = direct,
>> +    .format[PSC_CURRENT_OUT] = direct,
>> +    .format[PSC_POWER] = linear,
>> +    .format[PSC_TEMPERATURE] = linear,
>> +    .m[PSC_VOLTAGE_IN] = 1,
>> +    .b[PSC_VOLTAGE_IN] = 0,
>> +    .R[PSC_VOLTAGE_IN] = 1,
>> +    .m[PSC_VOLTAGE_OUT] = 1,
>> +    .b[PSC_VOLTAGE_OUT] = 0,
>> +    .R[PSC_VOLTAGE_OUT] = 1,
>> +    .m[PSC_CURRENT_IN] = 1,
>> +    .b[PSC_CURRENT_IN] = 0,
>> +    .R[PSC_CURRENT_IN] = 3,
>> +    .m[PSC_CURRENT_OUT] = 1,
>> +    .b[PSC_CURRENT_OUT] = 0,
>> +    .R[PSC_CURRENT_OUT] = 2,
>> +    .func[0] = 0, /* Summing page without voltage readings */
> 
> This needs further explanation. The public datasheet doesn't say anything
> about multiple pages, and it doesn't really make much sense to have an
> "empty" page with no information in it.
> 

Digging further, there is actually a digital supervisor (D44TL1A0) which is used
to access BCM6123, and there can be up to 4 BCM6123 connected to D44TL1A0.
Page 0 is the supervisor, and pages 1..4 provide data for the connected BCM6123s.
Page 0 does report various telemetry values, which should be supported. Pages
2..4 should be supported as well.

Question is if the driver should be named after the supervisor or after
the voltage converter; I'll leave that up to you. Either case it needs
to support all five pages.

Guenter

>> +    .func[1] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
>> +        | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
>> +        | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
>> +        | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
>> +        | PMBUS_HAVE_IIN | PMBUS_HAVE_POUT,
>> +};
>> +
>> +static int bcm6123_probe(struct i2c_client *client)
>> +{
>> +    client->dev.platform_data = &bcm6123_plat_data;
>> +
>> +    return pmbus_do_probe(client, &bcm6123_info);
>> +}
>> +
>> +static const struct i2c_device_id bcm6123_id[] = {
>> +    {"bcm6123", 0},
>> +    {}
>> +};
>> +
>> +MODULE_DEVICE_TABLE(i2c, bcm6123_id);
>> +
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id bcm6123_of_match[] = {
>> +    { .compatible = "vicor,bcm6123" },
>> +    { },
>> +};
>> +MODULE_DEVICE_TABLE(of, bcm6123_of_match);
>> +#endif
>> +
>> +/* This is the driver that will be inserted */
>> +static struct i2c_driver bcm6123_driver = {
>> +    .driver = {
>> +           .name = "bcm6123",
>> +           .of_match_table = of_match_ptr(bcm6123_of_match),
>> +           },
>> +    .probe_new = bcm6123_probe,
>> +    .id_table = bcm6123_id,
>> +};
>> +
>> +module_i2c_driver(bcm6123_driver);
>> +
>> +MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
>> +MODULE_DESCRIPTION("PMBus driver for Vicor bcm6123");
>> +MODULE_LICENSE("GPL");
>>
> 

