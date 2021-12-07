Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CE746C3DD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 20:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbhLGTrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 14:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhLGTrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 14:47:35 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF82C061574;
        Tue,  7 Dec 2021 11:44:05 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id t19so665267oij.1;
        Tue, 07 Dec 2021 11:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IEBMJ4lTRD9p8Tc6Zm88lVexEGB7vmSkdDtAPDUTzpU=;
        b=CCzMcw58EuvH9GJcphDyUN2UtDxsrNmy0Jc6WO4nbojjEtCmpZn/CUSvIbauvXBLbK
         OC2Hs2si17J6xwhHbP+7OS9dA3jUIdu6KjGF+0+rhx9IlXJyM2XSoDrRkh9zkMH/ls2N
         F3AJTS8yv3S7JwBwRV87ezI7uvtoVy0ceKnpvT1jiI5BGOmnaA0w7m8YId+DnUE3sX4k
         yN0tSnYMRJO8WmmybYBzMwS7+4XjX4m81rRecThnRaSVR0LfhgnPDFA5ycSmswJ1yEqQ
         yL0dFrIUrb6aXKG+ZhhrV4bIAI0EVWALBLm2x6JXVipIalkVwT0zEVW04nQPMqMQNcGK
         WKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IEBMJ4lTRD9p8Tc6Zm88lVexEGB7vmSkdDtAPDUTzpU=;
        b=GILf8eMPYiTXmWKVvFLlxr/KsYWcWW2HUo64KcI9WEJK95KDMMRlIW4u1kD72QjAn3
         pRq4YNYiZEKld5ywOVqHr/FiJ49RthSxqFYIU6y5gloBmKbinwa9Uj/+rlT3uwykfRL2
         Aec6ikOi6btfMdQj6Ga9LMSM+tjM0F93q7t3hiGlsGDQhF36hgzjvLUGlq3vvmMimSAV
         a+Pi9bgAz3ZP2hMIWE/qI54SGikJnbzU5MXcDjlInSR3A2hmyOpU5Z9kuYXzvC27WpdQ
         HVzPADCfU7NHtzQXQgAFHGf5gFK+MtLW4KcvVsRxMx8iUmM4efyjnk29xlVeobBfIVuT
         oxWQ==
X-Gm-Message-State: AOAM530fMS/UeL0Fu4KtwEBUJ3akYVFwANhUE0MgGmS4bmPNFsd7ALGF
        3USz1AqRtDsjlzWAvUqho8W1lTNHWC0=
X-Google-Smtp-Source: ABdhPJw13aJor2WVwiw1zqaOFVl7mMhPp0LSFZE4AzHobzpz16xMrMxKhNSC0gyK0E6QFrrQZbd83w==
X-Received: by 2002:a05:6808:a1b:: with SMTP id n27mr7051351oij.111.1638906244148;
        Tue, 07 Dec 2021 11:44:04 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h1sm123514oog.26.2021.12.07.11.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 11:44:03 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3 1/2] hwmon: (pmbus) Add Delta AHE-50DC fan control
 module driver
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20211207071521.543-1-zev@bewilderbeest.net>
 <20211207071521.543-2-zev@bewilderbeest.net>
 <20211207175015.GA772416@roeck-us.net>
 <Ya+0YDWIRBQFnEDb@hatter.bewilderbeest.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f30241ad-f3c4-ee78-22f3-405401615b61@roeck-us.net>
Date:   Tue, 7 Dec 2021 11:44:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ya+0YDWIRBQFnEDb@hatter.bewilderbeest.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 11:22 AM, Zev Weiss wrote:
> On Tue, Dec 07, 2021 at 09:50:15AM PST, Guenter Roeck wrote:
>> On Mon, Dec 06, 2021 at 11:15:20PM -0800, Zev Weiss wrote:
>>> This device is an integrated module of the Delta AHE-50DC Open19 power
>>> shelf.  For lack of proper documentation, this driver has been developed
>>> referencing an existing (GPL) driver that was included in a code release
>>> from LinkedIn [1].  It provides four fan speeds, four temperatures, and
>>> one voltage reading, as well as a handful of warning and fault
>>> indicators.
>>>
>>> [1] https://github.com/linkedin/o19-bmc-firmware/blob/master/meta-openbmc/meta-linkedin/meta-deltapower/recipes-kernel/fancontrol-mod/files/fancontrol.c
>>>
>>
>> Hmm, that reference isn't really accurate anymore. I think it would be
>> better to just say that the device was found to be PMBus compliant.
> 
> Sure, will do.
> 
>>
>>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>>> ---
>>>  MAINTAINERS                             |  6 ++
>>>  drivers/hwmon/pmbus/Kconfig             | 12 ++++
>>>  drivers/hwmon/pmbus/Makefile            |  1 +
>>>  drivers/hwmon/pmbus/delta-ahe50dc-fan.c | 84 +++++++++++++++++++++++++
>>>  4 files changed, 103 insertions(+)
>>>  create mode 100644 drivers/hwmon/pmbus/delta-ahe50dc-fan.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 0ac052200ecb..8bb7ba52d2f5 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -5425,6 +5425,12 @@ W:    https://linuxtv.org
>>>  T:    git git://linuxtv.org/media_tree.git
>>>  F:    drivers/media/platform/sti/delta
>>>
>>> +DELTA AHE-50DC FAN CONTROL MODULE DRIVER
>>> +M:    Zev Weiss <zev@bewilderbeest.net>
>>> +L:    linux-hwmon@vger.kernel.org
>>> +S:    Maintained
>>> +F:    drivers/hwmon/pmbus/delta-ahe50dc-fan.c
>>> +
>>>  DELTA DPS920AB PSU DRIVER
>>>  M:    Robert Marko <robert.marko@sartura.hr>
>>>  L:    linux-hwmon@vger.kernel.org
>>> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
>>> index ffb609cee3a4..937e1c2c11e7 100644
>>> --- a/drivers/hwmon/pmbus/Kconfig
>>> +++ b/drivers/hwmon/pmbus/Kconfig
>>> @@ -66,6 +66,18 @@ config SENSORS_BPA_RS600
>>>        This driver can also be built as a module. If so, the module will
>>>        be called bpa-rs600.
>>>
>>> +config SENSORS_DELTA_AHE50DC_FAN
>>> +    tristate "Delta AHE-50DC fan control module"
>>> +    depends on I2C
>>> +    select REGMAP_I2C
> 
> And I realize I neglected to drop the depends & select lines here when moving this bit into the pmbus directory...
> 
>>> +    help
>>> +      If you say yes here you get hardware monitoring support for
>>> +      the integrated fan control module of the Delta AHE-50DC
>>> +      Open19 power shelf.
>>> +
>>> +      This driver can also be built as a module. If so, the module
>>> +      will be called delta-ahe50dc-fan.
>>> +
>>>  config SENSORS_FSP_3Y
>>>      tristate "FSP/3Y-Power power supplies"
>>>      help
>>> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
>>> index 0ed4d596a948..a56b2897288d 100644
>>> --- a/drivers/hwmon/pmbus/Makefile
>>> +++ b/drivers/hwmon/pmbus/Makefile
>>> @@ -9,6 +9,7 @@ obj-$(CONFIG_SENSORS_ADM1266)    += adm1266.o
>>>  obj-$(CONFIG_SENSORS_ADM1275)    += adm1275.o
>>>  obj-$(CONFIG_SENSORS_BEL_PFE)    += bel-pfe.o
>>>  obj-$(CONFIG_SENSORS_BPA_RS600)    += bpa-rs600.o
>>> +obj-$(CONFIG_SENSORS_DELTA_AHE50DC_FAN) += delta-ahe50dc-fan.o
>>>  obj-$(CONFIG_SENSORS_FSP_3Y)    += fsp-3y.o
>>>  obj-$(CONFIG_SENSORS_IBM_CFFPS)    += ibm-cffps.o
>>>  obj-$(CONFIG_SENSORS_DPS920AB)    += dps920ab.o
>>> diff --git a/drivers/hwmon/pmbus/delta-ahe50dc-fan.c b/drivers/hwmon/pmbus/delta-ahe50dc-fan.c
>>> new file mode 100644
>>> index 000000000000..07b1e7c5f5f5
>>> --- /dev/null
>>> +++ b/drivers/hwmon/pmbus/delta-ahe50dc-fan.c
>>> @@ -0,0 +1,84 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Delta AHE-50DC power shelf fan control module driver
>>> + *
>>> + * Copyright 2021 Zev Weiss <zev@bewilderbeest.net>
>>> + */
>>> +
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/i2c.h>
>>> +#include <linux/pmbus.h>
>>
>> Alphabetic include file order please.
> 
> Ack, will fix.
> 
>>
>>> +
>>> +#include "pmbus.h"
>>> +
>>> +#define AHE50DC_PMBUS_READ_TEMP4 0xd0
>>> +
>>> +static int ahe50dc_fan_read_word_data(struct i2c_client *client, int page, int phase, int reg)
>>> +{
>>> +    /* temp1 in (virtual) page 1 is remapped to mfr-specific temp4 */
>>> +    if (page == 1) {
>>> +        if (reg == PMBUS_READ_TEMPERATURE_1)
>>> +            return i2c_smbus_read_word_data(client, AHE50DC_PMBUS_READ_TEMP4);
>>> +        return -EOPNOTSUPP;
>>> +    }
>>> +    return -ENODATA;
>>> +}
>>> +
>>> +static struct pmbus_driver_info ahe50dc_fan_info = {
>>> +    .pages = 2,
>>> +    .format[PSC_FAN] = direct,
>>> +    .format[PSC_TEMPERATURE] = direct,
>>> +    .format[PSC_VOLTAGE_IN] = direct,
>>> +    .m[PSC_FAN] = 1,
>>> +    .b[PSC_FAN] = 0,
>>> +    .R[PSC_FAN] = 0,
>>> +    .m[PSC_TEMPERATURE] = 1,
>>> +    .b[PSC_TEMPERATURE] = 0,
>>> +    .R[PSC_TEMPERATURE] = 1,
>>> +    .m[PSC_VOLTAGE_IN] = 1,
>>> +    .b[PSC_VOLTAGE_IN] = 0,
>>> +    .R[PSC_VOLTAGE_IN] = 3,
>>
>> How did you determine the exponents ? The referenced driver
>> doesn't seem to make a difference between voltage and temperature
>> exponents (nor fan speed, which is a bit odd).
> 
> Lacking documentation, the honest answer here is that I just sort of eyeballed it.  However, after doing so, I dug through the code dump a bit more and found some userspace unit-conversion bits that appear to confirm what I arrived at:
> 
> https://github.com/linkedin/o19-bmc-firmware/blob/master/meta-openbmc/meta-linkedin/meta-deltapower/recipes-deltapower/platform-lib/files/powershelf/powershelf_fan.c
> 
> (Lines 107, and 153/161/169/177.)
> 

Brr. Well, why use a standard API/ABI if one can invent a non-standard one.

Can you check this with real hardware, by any chance ?

>>
>>> +    .func[0] = PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
>>> +        PMBUS_HAVE_VIN | PMBUS_HAVE_FAN12 | PMBUS_HAVE_FAN34 |
>>> +        PMBUS_HAVE_STATUS_FAN12 | PMBUS_HAVE_STATUS_FAN34 | PMBUS_PAGE_VIRTUAL,
>>> +    .func[1] = PMBUS_HAVE_TEMP | PMBUS_PAGE_VIRTUAL,
>>> +    .read_word_data = ahe50dc_fan_read_word_data,
>>> +};
>>> +
>>> +static struct pmbus_platform_data ahe50dc_fan_data = {
>>> +    .flags = PMBUS_NO_CAPABILITY,
>>> +};
>>
>> Is that necessary ? It should only be used if trying to read CAPABILITY
>> reports bad data.
> 
> Unfortunately it does seem to be needed -- CAPABILITY returns 0xff, but despite having bit 7 set the device mangles all subsequent transactions by returning bad PEC bytes if we enable I2C_CLIENT_PEC.  Actually, none of the fields in that CAPABILITY value seem to accurately reflect the device's observed behavior; I'm pretty sure 0xff is just what it returns when it doesn't support something (I think the bad PECs it sends are all 0xff too).
> 
> I'll add an explanatory comment in v4.
> 
>
Please do.

Thanks,
Guenter
