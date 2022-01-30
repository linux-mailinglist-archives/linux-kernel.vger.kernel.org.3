Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C254A3701
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 15:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355257AbiA3Oxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 09:53:30 -0500
Received: from mail-yb1-f176.google.com ([209.85.219.176]:44592 "EHLO
        mail-yb1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355210AbiA3OxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 09:53:25 -0500
Received: by mail-yb1-f176.google.com with SMTP id r65so32816927ybc.11;
        Sun, 30 Jan 2022 06:53:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7eJIL31UX2rAhkSExrDSGNzwUL60RNw+wx2TtRBpbHM=;
        b=EGIaZctifb3Z6xrjTV7QI5nh/c9u2+7+J/H0ezfaLnGim/zGZaedgvsF8grMwD8ViK
         qkE3iw3mQEL6mabhYTMtZDmyib7YQ+Zg7UdJkB4shO911FrioclznN2Tr1N0AYtxzfSS
         kvQYX3XLliXRG6VERMz4iXPmpks6n8FdTgGfeZQ+Svc7lRUfIYMgwKsXUMOPX1NAI4Sr
         iccoMQrOJx4oQjLggjxTAIpXOUeXtiWpv/JC2S2IfReV4zM7m5RHFvA175eq+/XG52iQ
         8Ig1jEPqCSQTHzNrMcFzmo3YM8F82qdMGsbkIY+QaFKDFz+CPY07JsoIjo8YH+cwoi+B
         upZw==
X-Gm-Message-State: AOAM531SaMlUnRVvEdLV/4Wz8QJ309Zodk9w7j/nHwm8wXs39/lbBF9D
        mGllgQydsKca9Tpnz3YL8GVYEbeq2vcBEz8gQcc=
X-Google-Smtp-Source: ABdhPJz5Sdr72jUwaYcAB+X7TeIukkf5+ix90a/KgepawgznXeBG4JZ59eM1/4KjeSYHmb2QEwdTsN5SpYfoP1Z7nCA=
X-Received: by 2002:a25:34c4:: with SMTP id b187mr24811518yba.78.1643554404447;
 Sun, 30 Jan 2022 06:53:24 -0800 (PST)
MIME-Version: 1.0
References: <20211126125244.126300-1-abailon@baylibre.com> <20211126125244.126300-3-abailon@baylibre.com>
 <CAJZ5v0jejFG76OfewYg3kmKv4xwLdRBpC+zRpJ9Jom+tqo7qyg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jejFG76OfewYg3kmKv4xwLdRBpC+zRpJ9Jom+tqo7qyg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 30 Jan 2022 15:53:13 +0100
Message-ID: <CAJZ5v0iy_nVvvxYArBG=8=xxLzPDorct+bQQBLqcrWsjRuT5sg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] thermal: add a virtual sensor to aggregate temperatures
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 8:31 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Nov 26, 2021 at 1:53 PM Alexandre Bailon <abailon@baylibre.com> wrote:
> >
> > This adds a virtual thermal sensor driver that reads temperature from
> > multiple hardware sensors and returns an aggregated temperature.
> > Currently, this supports three aggregations:
> > the minimum, maximum and average temperature.
> >
> > Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> > ---
> >  drivers/thermal/Kconfig                  |   8 +
> >  drivers/thermal/Makefile                 |   1 +
> >  drivers/thermal/virtual_thermal_sensor.c | 218 +++++++++++++++++++++++
> >  3 files changed, 227 insertions(+)
> >  create mode 100644 drivers/thermal/virtual_thermal_sensor.c
> >
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index d7f44deab5b1..b326fae5ad1d 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -228,6 +228,14 @@ config THERMAL_MMIO
> >           register or shared memory, is a potential candidate to work with this
> >           driver.
> >
> > +config VIRTUAL_THERMAL
>
> The name is a bit overly generic IMV and that may be confusing.  It
> would be good to use a name reflecting the fact that this is DT-based.
> For example, something like thermal_of_virtual_sensor or similar.
>
> > +       tristate "DT-based virtual thermal sensor driver"
> > +       depends on THERMAL_OF || COMPILE_TEST
> > +       help
> > +         This option enables the generic DT-based thermal sensor aggregator.
> > +         This driver creates a thermal sensor that reads multiple hardware
> > +         sensors and aggregates their output.
> > +
> >  config HISI_THERMAL
> >         tristate "Hisilicon thermal driver"
> >         depends on ARCH_HISI || COMPILE_TEST
> > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > index 82fc3e616e54..8bf55973059c 100644
> > --- a/drivers/thermal/Makefile
> > +++ b/drivers/thermal/Makefile
> > @@ -60,3 +60,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)        += uniphier_thermal.o
> >  obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
> >  obj-$(CONFIG_SPRD_THERMAL)     += sprd_thermal.o
> >  obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)   += khadas_mcu_fan.o
> > +obj-$(CONFIG_VIRTUAL_THERMAL) += virtual_thermal_sensor.o
> > diff --git a/drivers/thermal/virtual_thermal_sensor.c b/drivers/thermal/virtual_thermal_sensor.c
> > new file mode 100644
> > index 000000000000..9f38af925fd1
> > --- /dev/null
> > +++ b/drivers/thermal/virtual_thermal_sensor.c
> > @@ -0,0 +1,218 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * virtual_thermal_sensor.c - DT-based virtual thermal sensor driver.
>
> It would be good to have some more information on what it does here.
>
> > + *
> > + * Copyright (c) 2021 BayLibre
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/export.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/slab.h>
> > +#include <linux/thermal.h>
> > +#include <linux/types.h>
> > +#include <linux/string.h>
> > +
> > +#include <dt-bindings/thermal/virtual-sensor.h>
> > +
> > +struct virtual_thermal_zone_device {
> > +       struct thermal_zone_device *zone;
> > +       struct module *owner;
> > +};
> > +
> > +struct virtual_thermal_sensor {
> > +       int count;
> > +       struct virtual_thermal_zone_device *zones;
> > +       struct thermal_zone_device *tzd;
> > +       int (*aggr_temp)(int temp1, int temp2);
> > +
> > +       struct list_head node;
> > +};
> > +
> > +static int max_temp(int temp1, int temp2)
> > +{
> > +       return max(temp1, temp2);
> > +}
> > +
> > +static int min_temp(int temp1, int temp2)
> > +{
> > +       return min(temp1, temp2);
> > +}
> > +
> > +static int avg_temp(int temp1, int temp2)
> > +{
> > +       return (temp1 + temp2) / 2;
> > +}
> > +
> > +static int virtual_thermal_sensor_get_temp(void *data, int *temperature)
> > +{
> > +       struct virtual_thermal_sensor *sensor = data;
> > +       int max_temp = INT_MIN;
> > +       int temp;
> > +       int i;
> > +
> > +       for (i = 0; i < sensor->count; i++) {
> > +               struct thermal_zone_device *zone;
> > +
> > +               zone = sensor->zones[i].zone;
>
> What if one of the zones gets unregistered after registering a thermal
> sensor depending on it?
>
> I don't think this will still work in that case.
>
> > +               zone->ops->get_temp(zone, &temp);
> > +               max_temp = sensor->aggr_temp(max_temp, temp);

One more thing: AFAICS, this is only going to work for the "average"
type of aggregation if there are two sensors involved.  For three (or
more), you won't really get the average.  For instance, for three
sensors the current patch leads to t = t_0 / 4 + t_1 / 4 + t_2 / 2
whereas the average is the sum of t_i divided by the number of them
(3).

It looks like you need to check the aggregation type here directly
instead of using the callback approach, which would also make it
easier to follow the code.

> > +       }
> > +
> > +       *temperature = max_temp;
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct thermal_zone_of_device_ops virtual_thermal_sensor_ops = {
> > +       .get_temp = virtual_thermal_sensor_get_temp,
> > +};
> > +
> > +static int virtual_thermal_sensor_get_module(struct virtual_thermal_zone_device *zone,
> > +                                            const char *name)
> > +{
> > +               struct platform_device *sensor_pdev;
> > +               struct device_node *node;
> > +
> > +               node = of_find_node_by_name(NULL, name);
> > +               if (!node)
> > +                       return -ENODEV;
> > +
> > +               node = of_parse_phandle(node, "thermal-sensors", 0);
> > +               if (!node)
> > +                       return -ENODEV;
> > +
> > +               sensor_pdev = of_find_device_by_node(node);
> > +               if (!sensor_pdev)
> > +                       return -ENODEV;
> > +
> > +               if (!sensor_pdev->dev.driver)
> > +                       return -EPROBE_DEFER;
> > +
> > +               if (!try_module_get(sensor_pdev->dev.driver->owner))
> > +                       return -ENODEV;
> > +
> > +               zone->owner = sensor_pdev->dev.driver->owner;
> > +
> > +               return 0;
> > +}
> > +
> > +static void virtual_thermal_sensor_put_modules(struct virtual_thermal_sensor *sensor)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < sensor->count; i++) {
> > +               if (sensor->zones[i].zone)
> > +                       module_put(sensor->zones[i].owner);
> > +       }
> > +}
> > +
> > +static int virtual_thermal_sensor_probe(struct platform_device *pdev)
> > +{
> > +       struct virtual_thermal_sensor *sensor;
> > +       struct device *dev = &pdev->dev;
> > +       struct property *prop;
> > +       const char *name;
> > +       u32 type;
> > +       int ret;
> > +       int i = 0;
> > +
> > +       sensor = devm_kzalloc(dev, sizeof(*sensor), GFP_KERNEL);
> > +       if (!sensor)
> > +               return -ENOMEM;
> > +       sensor->count = of_property_count_strings(dev->of_node, "thermal-sensors");
> > +       if (sensor->count <= 0)
> > +               return -EINVAL;
> > +
> > +       sensor->zones = devm_kmalloc_array(dev, sensor->count,
> > +                                            sizeof(*sensor->zones),
> > +                                            GFP_KERNEL);
> > +       if (!sensor->zones)
> > +               return -ENOMEM;
> > +
> > +       of_property_for_each_string(dev->of_node, "thermal-sensors", prop, name) {
> > +               struct virtual_thermal_zone_device *virtual_zone;
> > +               struct thermal_zone_device *zone;
> > +
> > +               virtual_zone = &sensor->zones[i++];
> > +
> > +               zone = thermal_zone_get_zone_by_name(name);
> > +               if (IS_ERR(zone))
> > +                       return PTR_ERR(zone);
> > +
> > +               ret = virtual_thermal_sensor_get_module(virtual_zone, name);
> > +               if (ret)
> > +                       goto err;
>
> The above prevents the module holding the zone driver from being
> unloaded while it is used by this virtual sensor, but it still doesn't
> prevent its zone from being unregistered after probing the virtual
> sensor.
>
> > +
> > +               virtual_zone->zone = zone;
> > +       }
> > +
> > +       ret = of_property_read_u32(dev->of_node, "aggregation-function", &type);
> > +       if (ret)
> > +               return ret;
> > +
> > +       switch (type) {
> > +       case VIRTUAL_THERMAL_SENSOR_MAX_VAL:
> > +               sensor->aggr_temp = max_temp;
> > +               break;
> > +       case VIRTUAL_THERMAL_SENSOR_MIN_VAL:
> > +               sensor->aggr_temp = min_temp;
> > +               break;
> > +       case VIRTUAL_THERMAL_SENSOR_AVG_VAL:
> > +               sensor->aggr_temp = avg_temp;
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       sensor->tzd = devm_thermal_zone_of_sensor_register(dev, 0, sensor,
> > +                                                          &virtual_thermal_sensor_ops);
> > +       if (IS_ERR(sensor->tzd))
> > +               return PTR_ERR(sensor->tzd);
> > +
> > +       platform_set_drvdata(pdev, sensor);
> > +
> > +       return 0;
> > +
> > +err:
> > +       virtual_thermal_sensor_put_modules(sensor);
> > +
> > +       return ret;
> > +}
> > +
> > +static int virtual_thermal_sensor_remove(struct platform_device *pdev)
> > +{
> > +       struct virtual_thermal_sensor *sensor;
> > +
> > +       sensor = platform_get_drvdata(pdev);
> > +       list_del(&sensor->node);
> > +
> > +       virtual_thermal_sensor_put_modules(sensor);
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct of_device_id virtual_thermal_sensor_of_match[] = {
> > +       {
> > +               .compatible = "virtual,thermal-sensor",
> > +       },
> > +       {
> > +       },
> > +};
> > +MODULE_DEVICE_TABLE(of, virtual_thermal_sensor_of_match);
> > +
> > +static struct platform_driver virtual_thermal_sensor = {
> > +       .probe = virtual_thermal_sensor_probe,
> > +       .remove = virtual_thermal_sensor_remove,
> > +       .driver = {
> > +               .name = "virtual-thermal-sensor",
> > +               .of_match_table = virtual_thermal_sensor_of_match,
> > +       },
> > +};
> > +
> > +module_platform_driver(virtual_thermal_sensor);
> > +MODULE_AUTHOR("Alexandre Bailon <abailon@baylibre.com>");
> > +MODULE_DESCRIPTION("Virtual thermal sensor");
> > +MODULE_LICENSE("GPL v2");
> > --
