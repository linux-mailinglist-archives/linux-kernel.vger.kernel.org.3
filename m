Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0460C492B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 17:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346211AbiARQr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 11:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236908AbiARQr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 11:47:58 -0500
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [IPv6:2001:67c:2050:1::465:111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BFDC061574;
        Tue, 18 Jan 2022 08:47:57 -0800 (PST)
Received: from smtp102.mailbox.org (unknown [91.198.250.119])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4JdZT72kt8z9scy;
        Tue, 18 Jan 2022 17:47:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1642524473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qljFJMkFb9d7vcqEyz7OUbcIm/7My2BmlvxkxLSAZkg=;
        b=KMMG7u9zaBjNqC+zKqbjUoeW2obA/AJmi7FYLauC1NSgMu8saMSpaXVFaW5pCQLAQOG/fV
        3qDSr6tw4bt0wEIsITSnKJdIHy2VWnF4G8+fY/o4Wmy3adVBqbVJHuhGoMTWHu5ykFMewp
        2ZQxtS99FYdWLI0ENQEppTEP0QW9u4zQVxJz8rXZkyhS/HNeXhDDmLmqEIs63jVVuOTc3i
        Wi4btrK7eve/L/iifUQ5MvYaRh77zX4m5qIvLMCN9u6Bq1kqXwrlvzoeL6YnnbEUVojHOZ
        jWKTw88sWcHaLQWjyofrLYJZwkBywEmX6eaJ7CZGgFSFRMFl9OJzxDvqRzJK3Q==
Message-ID: <b7ef895cdfd261dd248bcf0d0da22dc38881f8bc.camel@sylv.io>
Subject: Re: [PATCH v1 4/4] pmbus: Add support for bcm6123 Bus Converter
From:   sylv <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Date:   Tue, 18 Jan 2022 17:47:49 +0100
In-Reply-To: <31890e5b-29f6-2ff0-f15d-a92c02c1e60c@roeck-us.net>
References: <cover.1642434222.git.sylv@sylv.io>
         <db9cb6a43de9b248b76f815c6c173d1eefd42ad0.1642434222.git.sylv@sylv.io>
         <c04086b8-7948-c1d9-56ee-e20455e8c92b@roeck-us.net>
         <31890e5b-29f6-2ff0-f15d-a92c02c1e60c@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-01-17 at 09:21 -0800, Guenter Roeck wrote:
> On 1/17/22 9:01 AM, Guenter Roeck wrote:
> > On 1/17/22 8:12 AM, Marcello Sylvester Bauer wrote:
> > > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > 
> > > BCM6123 is an Fixed-Ratio DC-DC Converter.
> > > 
> > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> > > ---
> > >   drivers/hwmon/pmbus/Kconfig   |  9 ++++
> > >   drivers/hwmon/pmbus/Makefile  |  1 +
> > >   drivers/hwmon/pmbus/bcm6123.c | 90 +++++++++++++++++++++++++++++++++++
> > 
> > Documentation/hwmon/bcm6123 is missing.
> > 
> > >   3 files changed, 100 insertions(+)
> > >   create mode 100644 drivers/hwmon/pmbus/bcm6123.c
> > > 
> > > diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> > > index c96f7b7338bd..62dac90631c5 100644
> > > --- a/drivers/hwmon/pmbus/Kconfig
> > > +++ b/drivers/hwmon/pmbus/Kconfig
> > > @@ -48,6 +48,15 @@ config SENSORS_ADM1275
> > >         This driver can also be built as a module. If so, the module will
> > >         be called adm1275.
> > > +config SENSORS_BCM6123
> > > +    tristate "Vicor BCM6123 Compatible Power Supplies"
> > 
> > Is this a power supply or a chip ? It can't be both.
> > 
> > > +    help
> > > +      If you say yes here you get hardware monitoring support for Vicor
> > > +      BCM6123 Power Supplies.
> > > +
> > > +      This driver can also be built as a module. If so, the module will
> > > +      be called bcm6123.
> > > +
> > >   config SENSORS_BEL_PFE
> > >       tristate "Bel PFE Compatible Power Supplies"
> > >       help
> > > diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> > > index e5935f70c9e0..2918c2ea7bc5 100644
> > > --- a/drivers/hwmon/pmbus/Makefile
> > > +++ b/drivers/hwmon/pmbus/Makefile
> > > @@ -7,6 +7,7 @@ obj-$(CONFIG_PMBUS)        += pmbus_core.o
> > >   obj-$(CONFIG_SENSORS_PMBUS)    += pmbus.o
> > >   obj-$(CONFIG_SENSORS_ADM1266)    += adm1266.o
> > >   obj-$(CONFIG_SENSORS_ADM1275)    += adm1275.o
> > > +obj-$(CONFIG_SENSORS_BCM6123)    += bcm6123.o
> > >   obj-$(CONFIG_SENSORS_BEL_PFE)    += bel-pfe.o
> > >   obj-$(CONFIG_SENSORS_BPA_RS600)    += bpa-rs600.o
> > >   obj-$(CONFIG_SENSORS_DELTA_AHE50DC_FAN) += delta-ahe50dc-fan.o
> > > diff --git a/drivers/hwmon/pmbus/bcm6123.c b/drivers/hwmon/pmbus/bcm6123.c
> > > new file mode 100644
> > > index 000000000000..78fc259bc40f
> > > --- /dev/null
> > > +++ b/drivers/hwmon/pmbus/bcm6123.c
> > > @@ -0,0 +1,90 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Hardware monitoring driver for Infineon bcm6123
> > > + *
> > Infineon ?
> > 
> > > + * Copyright (c) 2021 9elements GmbH
> > > + *
> > > + * VOUT_MODE is not supported by the device. The driver fakes VOUT linear16
> > > + * mode with exponent value -8 as direct mode with m=256/b=0/R=0.
> > > + *
> > 
> > Does it not ? The datasheet doesn't say, and the code below doesn't match
> > this description.
> > 
> > > + * The device supports VOUT_PEAK, IOUT_PEAK, and TEMPERATURE_PEAK, however
> > > + * this driver does not currently support them.
> > 
> > Does it ? There is no reference for this in the datasheet.
> > 
> > Overall it seems like there is a lot of cut-and-paste. Please clean this up.

Sorry. Looks like it is not related to this driver and should be
removed.

> > 
> > > + */
> > > +
> > > +#include <linux/err.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/init.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/pmbus.h>
> > > +#include "pmbus.h"
> > > +
> > > +static struct pmbus_platform_data bcm6123_plat_data = {
> > > +    .flags = PMBUS_NO_CAPABILITY,
> > > +};
> > 
> > We should only set this flag if it is really needed.

The capability command did not return valid information during testing.
e.g. it claimed PEC is supported and caused therefore unexpected
issues. I'll test it again to see if it's necessary for the driver to
work.

> > 
> > > +
> > > +static struct pmbus_driver_info bcm6123_info = {
> > > +    .pages = 2,
> > > +    .format[PSC_VOLTAGE_IN] = direct,
> > > +    .format[PSC_VOLTAGE_OUT] = direct,
> > > +    .format[PSC_CURRENT_IN] = direct,
> > > +    .format[PSC_CURRENT_OUT] = direct,
> > > +    .format[PSC_POWER] = linear,
> > > +    .format[PSC_TEMPERATURE] = linear,
> > > +    .m[PSC_VOLTAGE_IN] = 1,
> > > +    .b[PSC_VOLTAGE_IN] = 0,
> > > +    .R[PSC_VOLTAGE_IN] = 1,
> > > +    .m[PSC_VOLTAGE_OUT] = 1,
> > > +    .b[PSC_VOLTAGE_OUT] = 0,
> > > +    .R[PSC_VOLTAGE_OUT] = 1,
> > > +    .m[PSC_CURRENT_IN] = 1,
> > > +    .b[PSC_CURRENT_IN] = 0,
> > > +    .R[PSC_CURRENT_IN] = 3,
> > > +    .m[PSC_CURRENT_OUT] = 1,
> > > +    .b[PSC_CURRENT_OUT] = 0,
> > > +    .R[PSC_CURRENT_OUT] = 2,
> > > +    .func[0] = 0, /* Summing page without voltage readings */
> > 
> > This needs further explanation. The public datasheet doesn't say anything
> > about multiple pages, and it doesn't really make much sense to have an
> > "empty" page with no information in it.
> > 
> 
> Digging further, there is actually a digital supervisor (D44TL1A0) which is used
> to access BCM6123, and there can be up to 4 BCM6123 connected to D44TL1A0.
> Page 0 is the supervisor, and pages 1..4 provide data for the connected BCM6123s.
> Page 0 does report various telemetry values, which should be supported. Pages
> 2..4 should be supported as well.
> 
> Question is if the driver should be named after the supervisor or after
> the voltage converter; I'll leave that up to you. Either case it needs
> to support all five pages.
> 
> Guenter

After Digging further ourselves, it looks like our hardware also
contains a digital supervisor IC (PLI1209BC), which is connected to one
BCM6123 only. Unfortunately, we were not able to find the data sheet
before:

https://www.vicorpower.com/documents/datasheets/ds-PLI1209BCxyzz-VICOR.pdf
This explains why there are two pages in our case. Since there are
different hardware configurations it would make more sense to name this
driver after the supervisor.

I'll rework this patch set and implement the PLI1209BC properly.

Marcello

> 
> > > +    .func[1] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
> > > +        | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
> > > +        | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
> > > +        | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
> > > +        | PMBUS_HAVE_IIN | PMBUS_HAVE_POUT,
> > > +};
> > > +
> > > +static int bcm6123_probe(struct i2c_client *client)
> > > +{
> > > +    client->dev.platform_data = &bcm6123_plat_data;
> > > +
> > > +    return pmbus_do_probe(client, &bcm6123_info);
> > > +}
> > > +
> > > +static const struct i2c_device_id bcm6123_id[] = {
> > > +    {"bcm6123", 0},
> > > +    {}
> > > +};
> > > +
> > > +MODULE_DEVICE_TABLE(i2c, bcm6123_id);
> > > +
> > > +#ifdef CONFIG_OF
> > > +static const struct of_device_id bcm6123_of_match[] = {
> > > +    { .compatible = "vicor,bcm6123" },
> > > +    { },
> > > +};
> > > +MODULE_DEVICE_TABLE(of, bcm6123_of_match);
> > > +#endif
> > > +
> > > +/* This is the driver that will be inserted */
> > > +static struct i2c_driver bcm6123_driver = {
> > > +    .driver = {
> > > +           .name = "bcm6123",
> > > +           .of_match_table = of_match_ptr(bcm6123_of_match),
> > > +           },
> > > +    .probe_new = bcm6123_probe,
> > > +    .id_table = bcm6123_id,
> > > +};
> > > +
> > > +module_i2c_driver(bcm6123_driver);
> > > +
> > > +MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
> > > +MODULE_DESCRIPTION("PMBus driver for Vicor bcm6123");
> > > +MODULE_LICENSE("GPL");
> > > 
> > 
> 

