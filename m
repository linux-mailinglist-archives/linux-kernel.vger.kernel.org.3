Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9683492CAD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347572AbiARRwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347566AbiARRwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:52:03 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15A0C061574;
        Tue, 18 Jan 2022 09:52:02 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id s22so29645394oie.10;
        Tue, 18 Jan 2022 09:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w+gjenYqJuTH95mTSqiJAAOb7P8pJm3BvUPKGkPNrZc=;
        b=A5VqHprLhr6bv1zS/e4x4MEV/Gsacf3ESH9k5mvRCguOn6GNT97kyudtfrEavpIIwE
         rrmAL2b4FU1/9KFTRdnDVDlOet4KAFIj7MvrciJmPd522fi0dFrO1I6VkZ3+xz3ArLTF
         Hkz/dLoZichEHPPMK9VY9ND2RxHRcYy1C2k38V9eSVjdUh9/WvCjEOTXILBGJ2cLq2hA
         xOEvjj7zjEjnceNv/keYCuCqqvEpVdECPzRw7kYQS9LjJuqG82sKbKJ5rxZcpwxm9TUo
         ivKvRz/WJfC7eoWXYybff3kUuzH9MgDa8ZtVhTzaU5z356WP2cUw0hL2lw1rCeCAF9ut
         jcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w+gjenYqJuTH95mTSqiJAAOb7P8pJm3BvUPKGkPNrZc=;
        b=6IoFYOV8YVk2aYKps960fe1cIChqtdftUyOekQRcyEkQGk//DQ22l0VtWhSxIjrCpe
         zJo3sXsCevFwCGhvrVGjRrWNxP/4SPCn5YvS5wz2zhK6/S72eEnydm8PeU17Ib9lJ60L
         NHzJm8o7V36Y+zKxdsrSywPBzErGPIk3tkMk/RuDeaxJYJVOWV4W9pTzZMSVog4oGFzF
         oMIHYVoe0c/HBRusaL48ULSgU9tu1Lio/7YgQWMtGIjQ/OFzSFyM+YhKFh1aa0a91mej
         kCP9mQNlrITURVYhKeMzYUiYCx/awtKBevOTW/9xhd2TfAEOuGGQyRbF2x4AhzYbjhO8
         pZxA==
X-Gm-Message-State: AOAM533zvzAwqCMRMrlh/VbCLKr8gfilLFQEwXAZhWY4oEGqpXiDSPMi
        c04zHJOsJK8Vq6/WC1dmws2YlrKA69M=
X-Google-Smtp-Source: ABdhPJwys+jieDiEPyhXxpxAtF72LCsE+1Ux1z5DYTmn3VBqHA/o0NKa6CCmdZgnVUUQ4qEYrmIUkw==
X-Received: by 2002:a05:6808:14cc:: with SMTP id f12mr2969584oiw.109.1642528321622;
        Tue, 18 Jan 2022 09:52:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j4sm2594629otq.69.2022.01.18.09.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 09:52:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     sylv <sylv@sylv.io>, linux-hwmon@vger.kernel.org
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
References: <cover.1642434222.git.sylv@sylv.io>
 <db9cb6a43de9b248b76f815c6c173d1eefd42ad0.1642434222.git.sylv@sylv.io>
 <c04086b8-7948-c1d9-56ee-e20455e8c92b@roeck-us.net>
 <31890e5b-29f6-2ff0-f15d-a92c02c1e60c@roeck-us.net>
 <b7ef895cdfd261dd248bcf0d0da22dc38881f8bc.camel@sylv.io>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 4/4] pmbus: Add support for bcm6123 Bus Converter
Message-ID: <d53a1db7-5555-f0e6-c8fc-1c1b5f9c6e3a@roeck-us.net>
Date:   Tue, 18 Jan 2022 09:51:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <b7ef895cdfd261dd248bcf0d0da22dc38881f8bc.camel@sylv.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/22 8:47 AM, sylv wrote:
> On Mon, 2022-01-17 at 09:21 -0800, Guenter Roeck wrote:
>> On 1/17/22 9:01 AM, Guenter Roeck wrote:
>>> On 1/17/22 8:12 AM, Marcello Sylvester Bauer wrote:
>>>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>>
>>>> BCM6123 is an Fixed-Ratio DC-DC Converter.
>>>>
>>>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>>>> ---
>>>>    drivers/hwmon/pmbus/Kconfig   |  9 ++++
>>>>    drivers/hwmon/pmbus/Makefile  |  1 +
>>>>    drivers/hwmon/pmbus/bcm6123.c | 90 +++++++++++++++++++++++++++++++++++
>>>
>>> Documentation/hwmon/bcm6123 is missing.
>>>
>>>>    3 files changed, 100 insertions(+)
>>>>    create mode 100644 drivers/hwmon/pmbus/bcm6123.c
>>>>
>>>> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
>>>> index c96f7b7338bd..62dac90631c5 100644
>>>> --- a/drivers/hwmon/pmbus/Kconfig
>>>> +++ b/drivers/hwmon/pmbus/Kconfig
>>>> @@ -48,6 +48,15 @@ config SENSORS_ADM1275
>>>>          This driver can also be built as a module. If so, the module will
>>>>          be called adm1275.
>>>> +config SENSORS_BCM6123
>>>> +    tristate "Vicor BCM6123 Compatible Power Supplies"
>>>
>>> Is this a power supply or a chip ? It can't be both.
>>>
>>>> +    help
>>>> +      If you say yes here you get hardware monitoring support for Vicor
>>>> +      BCM6123 Power Supplies.
>>>> +
>>>> +      This driver can also be built as a module. If so, the module will
>>>> +      be called bcm6123.
>>>> +
>>>>    config SENSORS_BEL_PFE
>>>>        tristate "Bel PFE Compatible Power Supplies"
>>>>        help
>>>> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
>>>> index e5935f70c9e0..2918c2ea7bc5 100644
>>>> --- a/drivers/hwmon/pmbus/Makefile
>>>> +++ b/drivers/hwmon/pmbus/Makefile
>>>> @@ -7,6 +7,7 @@ obj-$(CONFIG_PMBUS)        += pmbus_core.o
>>>>    obj-$(CONFIG_SENSORS_PMBUS)    += pmbus.o
>>>>    obj-$(CONFIG_SENSORS_ADM1266)    += adm1266.o
>>>>    obj-$(CONFIG_SENSORS_ADM1275)    += adm1275.o
>>>> +obj-$(CONFIG_SENSORS_BCM6123)    += bcm6123.o
>>>>    obj-$(CONFIG_SENSORS_BEL_PFE)    += bel-pfe.o
>>>>    obj-$(CONFIG_SENSORS_BPA_RS600)    += bpa-rs600.o
>>>>    obj-$(CONFIG_SENSORS_DELTA_AHE50DC_FAN) += delta-ahe50dc-fan.o
>>>> diff --git a/drivers/hwmon/pmbus/bcm6123.c b/drivers/hwmon/pmbus/bcm6123.c
>>>> new file mode 100644
>>>> index 000000000000..78fc259bc40f
>>>> --- /dev/null
>>>> +++ b/drivers/hwmon/pmbus/bcm6123.c
>>>> @@ -0,0 +1,90 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +/*
>>>> + * Hardware monitoring driver for Infineon bcm6123
>>>> + *
>>> Infineon ?
>>>
>>>> + * Copyright (c) 2021 9elements GmbH
>>>> + *
>>>> + * VOUT_MODE is not supported by the device. The driver fakes VOUT linear16
>>>> + * mode with exponent value -8 as direct mode with m=256/b=0/R=0.
>>>> + *
>>>
>>> Does it not ? The datasheet doesn't say, and the code below doesn't match
>>> this description.
>>>
>>>> + * The device supports VOUT_PEAK, IOUT_PEAK, and TEMPERATURE_PEAK, however
>>>> + * this driver does not currently support them.
>>>
>>> Does it ? There is no reference for this in the datasheet.
>>>
>>> Overall it seems like there is a lot of cut-and-paste. Please clean this up.
> 
> Sorry. Looks like it is not related to this driver and should be
> removed.
> 
>>>
>>>> + */
>>>> +
>>>> +#include <linux/err.h>
>>>> +#include <linux/i2c.h>
>>>> +#include <linux/init.h>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/pmbus.h>
>>>> +#include "pmbus.h"
>>>> +
>>>> +static struct pmbus_platform_data bcm6123_plat_data = {
>>>> +    .flags = PMBUS_NO_CAPABILITY,
>>>> +};
>>>
>>> We should only set this flag if it is really needed.
> 
> The capability command did not return valid information during testing.
> e.g. it claimed PEC is supported and caused therefore unexpected
> issues. I'll test it again to see if it's necessary for the driver to
> work.
> 
>>>
>>>> +
>>>> +static struct pmbus_driver_info bcm6123_info = {
>>>> +    .pages = 2,
>>>> +    .format[PSC_VOLTAGE_IN] = direct,
>>>> +    .format[PSC_VOLTAGE_OUT] = direct,
>>>> +    .format[PSC_CURRENT_IN] = direct,
>>>> +    .format[PSC_CURRENT_OUT] = direct,
>>>> +    .format[PSC_POWER] = linear,
>>>> +    .format[PSC_TEMPERATURE] = linear,
>>>> +    .m[PSC_VOLTAGE_IN] = 1,
>>>> +    .b[PSC_VOLTAGE_IN] = 0,
>>>> +    .R[PSC_VOLTAGE_IN] = 1,
>>>> +    .m[PSC_VOLTAGE_OUT] = 1,
>>>> +    .b[PSC_VOLTAGE_OUT] = 0,
>>>> +    .R[PSC_VOLTAGE_OUT] = 1,
>>>> +    .m[PSC_CURRENT_IN] = 1,
>>>> +    .b[PSC_CURRENT_IN] = 0,
>>>> +    .R[PSC_CURRENT_IN] = 3,
>>>> +    .m[PSC_CURRENT_OUT] = 1,
>>>> +    .b[PSC_CURRENT_OUT] = 0,
>>>> +    .R[PSC_CURRENT_OUT] = 2,
>>>> +    .func[0] = 0, /* Summing page without voltage readings */
>>>
>>> This needs further explanation. The public datasheet doesn't say anything
>>> about multiple pages, and it doesn't really make much sense to have an
>>> "empty" page with no information in it.
>>>
>>
>> Digging further, there is actually a digital supervisor (D44TL1A0) which is used
>> to access BCM6123, and there can be up to 4 BCM6123 connected to D44TL1A0.
>> Page 0 is the supervisor, and pages 1..4 provide data for the connected BCM6123s.
>> Page 0 does report various telemetry values, which should be supported. Pages
>> 2..4 should be supported as well.
>>
>> Question is if the driver should be named after the supervisor or after
>> the voltage converter; I'll leave that up to you. Either case it needs
>> to support all five pages.
>>
>> Guenter
> 
> After Digging further ourselves, it looks like our hardware also
> contains a digital supervisor IC (PLI1209BC), which is connected to one
> BCM6123 only. Unfortunately, we were not able to find the data sheet
> before:
> 
> https://www.vicorpower.com/documents/datasheets/ds-PLI1209BCxyzz-VICOR.pdf
> This explains why there are two pages in our case. Since there are
> different hardware configurations it would make more sense to name this
> driver after the supervisor.
> 
> I'll rework this patch set and implement the PLI1209BC properly.
> 

Apparently there are (at least) two different supervisor chips,
PLI1209BC and D44TL1A0. Given that, it is ok if you only implement
support for PLI1209BC is that is what you use, but the driver name
should indeed reflect the supervisor chip to ensure that support
for the other supervisor chip can be added at a later point.

Thanks,
Guenter

> Marcello
> 
>>
>>>> +    .func[1] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
>>>> +        | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
>>>> +        | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
>>>> +        | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
>>>> +        | PMBUS_HAVE_IIN | PMBUS_HAVE_POUT,
>>>> +};
>>>> +
>>>> +static int bcm6123_probe(struct i2c_client *client)
>>>> +{
>>>> +    client->dev.platform_data = &bcm6123_plat_data;
>>>> +
>>>> +    return pmbus_do_probe(client, &bcm6123_info);
>>>> +}
>>>> +
>>>> +static const struct i2c_device_id bcm6123_id[] = {
>>>> +    {"bcm6123", 0},
>>>> +    {}
>>>> +};
>>>> +
>>>> +MODULE_DEVICE_TABLE(i2c, bcm6123_id);
>>>> +
>>>> +#ifdef CONFIG_OF
>>>> +static const struct of_device_id bcm6123_of_match[] = {
>>>> +    { .compatible = "vicor,bcm6123" },
>>>> +    { },
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, bcm6123_of_match);
>>>> +#endif
>>>> +
>>>> +/* This is the driver that will be inserted */
>>>> +static struct i2c_driver bcm6123_driver = {
>>>> +    .driver = {
>>>> +           .name = "bcm6123",
>>>> +           .of_match_table = of_match_ptr(bcm6123_of_match),
>>>> +           },
>>>> +    .probe_new = bcm6123_probe,
>>>> +    .id_table = bcm6123_id,
>>>> +};
>>>> +
>>>> +module_i2c_driver(bcm6123_driver);
>>>> +
>>>> +MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
>>>> +MODULE_DESCRIPTION("PMBus driver for Vicor bcm6123");
>>>> +MODULE_LICENSE("GPL");
>>>>
>>>
>>
> 

