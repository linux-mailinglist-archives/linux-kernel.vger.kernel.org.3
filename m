Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF624A00E3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350958AbiA1Tbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 14:31:35 -0500
Received: from mail-yb1-f171.google.com ([209.85.219.171]:45791 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiA1Tbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:31:35 -0500
Received: by mail-yb1-f171.google.com with SMTP id h14so21410205ybe.12;
        Fri, 28 Jan 2022 11:31:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iACbVIkyffDsWqCKyxPBKKmf6phxGfDeQiG/fPIRARI=;
        b=Ft4nBYd9AGV+K6o71C6ALE69yXUaQlXIS94jze8pO0jERqpeHvmQBlDJBu9QeOpKuh
         uZ3upLJXb5Bs+4/tgJ8UuEkCW+adm149JC2Xl524Q/GMOdkhgtDNgQrwgpQwvGK8wavU
         dP9tHtYU54KzPXRA/mMqMw9MauuKxm+WOQAZOtzGr9DtLVMBw5HT60Q2d1u5H481Azi9
         F18JCYKxIxHK9g9u8loG3jshRdSSK8KliVgPMmqN4iw7VWH6DCP7GASqpBO8heX7hMeW
         xO3TaHVcGf9aYHaTFvIQc76WOQFVl6XkIc35Luk0xhWxy4tMAT+ZdFw6/0NSF+lxiO5n
         S+3w==
X-Gm-Message-State: AOAM533pMgy/qoHmQNDgAIo1YMD4xpYd7Dly8GV78uFNMEugwJw71dbP
        xDcxiYcKo2N3MjyFL2Iu7E7Vtflh7ufT2dFxzxY=
X-Google-Smtp-Source: ABdhPJxCeeXYaMzyoWWskovy5rWy5Ko8D9w4a6bdtpLUfGjyVZkGPXwGfrCBXQ2kv06VkZEnf4QhTHaw0Jv7Qpjnco4=
X-Received: by 2002:a25:6148:: with SMTP id v69mr440042ybb.466.1643398294427;
 Fri, 28 Jan 2022 11:31:34 -0800 (PST)
MIME-Version: 1.0
References: <20211126125244.126300-1-abailon@baylibre.com> <20211126125244.126300-3-abailon@baylibre.com>
In-Reply-To: <20211126125244.126300-3-abailon@baylibre.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Jan 2022 20:31:23 +0100
Message-ID: <CAJZ5v0jejFG76OfewYg3kmKv4xwLdRBpC+zRpJ9Jom+tqo7qyg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] thermal: add a virtual sensor to aggregate temperatures
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ben.tseng@mediatek.com, Kevin Hilman <khilman@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 1:53 PM Alexandre Bailon <abailon@baylibre.com> wrote:
>
> This adds a virtual thermal sensor driver that reads temperature from
> multiple hardware sensors and returns an aggregated temperature.
> Currently, this supports three aggregations:
> the minimum, maximum and average temperature.
>
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  drivers/thermal/Kconfig                  |   8 +
>  drivers/thermal/Makefile                 |   1 +
>  drivers/thermal/virtual_thermal_sensor.c | 218 +++++++++++++++++++++++
>  3 files changed, 227 insertions(+)
>  create mode 100644 drivers/thermal/virtual_thermal_sensor.c
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index d7f44deab5b1..b326fae5ad1d 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -228,6 +228,14 @@ config THERMAL_MMIO
>           register or shared memory, is a potential candidate to work with this
>           driver.
>
> +config VIRTUAL_THERMAL

The name is a bit overly generic IMV and that may be confusing.  It
would be good to use a name reflecting the fact that this is DT-based.
For example, something like thermal_of_virtual_sensor or similar.

> +       tristate "DT-based virtual thermal sensor driver"
> +       depends on THERMAL_OF || COMPILE_TEST
> +       help
> +         This option enables the generic DT-based thermal sensor aggregator.
> +         This driver creates a thermal sensor that reads multiple hardware
> +         sensors and aggregates their output.
> +
>  config HISI_THERMAL
>         tristate "Hisilicon thermal driver"
>         depends on ARCH_HISI || COMPILE_TEST
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 82fc3e616e54..8bf55973059c 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -60,3 +60,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)        += uniphier_thermal.o
>  obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
>  obj-$(CONFIG_SPRD_THERMAL)     += sprd_thermal.o
>  obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)   += khadas_mcu_fan.o
> +obj-$(CONFIG_VIRTUAL_THERMAL) += virtual_thermal_sensor.o
> diff --git a/drivers/thermal/virtual_thermal_sensor.c b/drivers/thermal/virtual_thermal_sensor.c
> new file mode 100644
> index 000000000000..9f38af925fd1
> --- /dev/null
> +++ b/drivers/thermal/virtual_thermal_sensor.c
> @@ -0,0 +1,218 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * virtual_thermal_sensor.c - DT-based virtual thermal sensor driver.

It would be good to have some more information on what it does here.

> + *
> + * Copyright (c) 2021 BayLibre
> + */
> +
> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>
> +#include <linux/types.h>
> +#include <linux/string.h>
> +
> +#include <dt-bindings/thermal/virtual-sensor.h>
> +
> +struct virtual_thermal_zone_device {
> +       struct thermal_zone_device *zone;
> +       struct module *owner;
> +};
> +
> +struct virtual_thermal_sensor {
> +       int count;
> +       struct virtual_thermal_zone_device *zones;
> +       struct thermal_zone_device *tzd;
> +       int (*aggr_temp)(int temp1, int temp2);
> +
> +       struct list_head node;
> +};
> +
> +static int max_temp(int temp1, int temp2)
> +{
> +       return max(temp1, temp2);
> +}
> +
> +static int min_temp(int temp1, int temp2)
> +{
> +       return min(temp1, temp2);
> +}
> +
> +static int avg_temp(int temp1, int temp2)
> +{
> +       return (temp1 + temp2) / 2;
> +}
> +
> +static int virtual_thermal_sensor_get_temp(void *data, int *temperature)
> +{
> +       struct virtual_thermal_sensor *sensor = data;
> +       int max_temp = INT_MIN;
> +       int temp;
> +       int i;
> +
> +       for (i = 0; i < sensor->count; i++) {
> +               struct thermal_zone_device *zone;
> +
> +               zone = sensor->zones[i].zone;

What if one of the zones gets unregistered after registering a thermal
sensor depending on it?

I don't think this will still work in that case.

> +               zone->ops->get_temp(zone, &temp);
> +               max_temp = sensor->aggr_temp(max_temp, temp);
> +       }
> +
> +       *temperature = max_temp;
> +
> +       return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops virtual_thermal_sensor_ops = {
> +       .get_temp = virtual_thermal_sensor_get_temp,
> +};
> +
> +static int virtual_thermal_sensor_get_module(struct virtual_thermal_zone_device *zone,
> +                                            const char *name)
> +{
> +               struct platform_device *sensor_pdev;
> +               struct device_node *node;
> +
> +               node = of_find_node_by_name(NULL, name);
> +               if (!node)
> +                       return -ENODEV;
> +
> +               node = of_parse_phandle(node, "thermal-sensors", 0);
> +               if (!node)
> +                       return -ENODEV;
> +
> +               sensor_pdev = of_find_device_by_node(node);
> +               if (!sensor_pdev)
> +                       return -ENODEV;
> +
> +               if (!sensor_pdev->dev.driver)
> +                       return -EPROBE_DEFER;
> +
> +               if (!try_module_get(sensor_pdev->dev.driver->owner))
> +                       return -ENODEV;
> +
> +               zone->owner = sensor_pdev->dev.driver->owner;
> +
> +               return 0;
> +}
> +
> +static void virtual_thermal_sensor_put_modules(struct virtual_thermal_sensor *sensor)
> +{
> +       int i;
> +
> +       for (i = 0; i < sensor->count; i++) {
> +               if (sensor->zones[i].zone)
> +                       module_put(sensor->zones[i].owner);
> +       }
> +}
> +
> +static int virtual_thermal_sensor_probe(struct platform_device *pdev)
> +{
> +       struct virtual_thermal_sensor *sensor;
> +       struct device *dev = &pdev->dev;
> +       struct property *prop;
> +       const char *name;
> +       u32 type;
> +       int ret;
> +       int i = 0;
> +
> +       sensor = devm_kzalloc(dev, sizeof(*sensor), GFP_KERNEL);
> +       if (!sensor)
> +               return -ENOMEM;
> +       sensor->count = of_property_count_strings(dev->of_node, "thermal-sensors");
> +       if (sensor->count <= 0)
> +               return -EINVAL;
> +
> +       sensor->zones = devm_kmalloc_array(dev, sensor->count,
> +                                            sizeof(*sensor->zones),
> +                                            GFP_KERNEL);
> +       if (!sensor->zones)
> +               return -ENOMEM;
> +
> +       of_property_for_each_string(dev->of_node, "thermal-sensors", prop, name) {
> +               struct virtual_thermal_zone_device *virtual_zone;
> +               struct thermal_zone_device *zone;
> +
> +               virtual_zone = &sensor->zones[i++];
> +
> +               zone = thermal_zone_get_zone_by_name(name);
> +               if (IS_ERR(zone))
> +                       return PTR_ERR(zone);
> +
> +               ret = virtual_thermal_sensor_get_module(virtual_zone, name);
> +               if (ret)
> +                       goto err;

The above prevents the module holding the zone driver from being
unloaded while it is used by this virtual sensor, but it still doesn't
prevent its zone from being unregistered after probing the virtual
sensor.

> +
> +               virtual_zone->zone = zone;
> +       }
> +
> +       ret = of_property_read_u32(dev->of_node, "aggregation-function", &type);
> +       if (ret)
> +               return ret;
> +
> +       switch (type) {
> +       case VIRTUAL_THERMAL_SENSOR_MAX_VAL:
> +               sensor->aggr_temp = max_temp;
> +               break;
> +       case VIRTUAL_THERMAL_SENSOR_MIN_VAL:
> +               sensor->aggr_temp = min_temp;
> +               break;
> +       case VIRTUAL_THERMAL_SENSOR_AVG_VAL:
> +               sensor->aggr_temp = avg_temp;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       sensor->tzd = devm_thermal_zone_of_sensor_register(dev, 0, sensor,
> +                                                          &virtual_thermal_sensor_ops);
> +       if (IS_ERR(sensor->tzd))
> +               return PTR_ERR(sensor->tzd);
> +
> +       platform_set_drvdata(pdev, sensor);
> +
> +       return 0;
> +
> +err:
> +       virtual_thermal_sensor_put_modules(sensor);
> +
> +       return ret;
> +}
> +
> +static int virtual_thermal_sensor_remove(struct platform_device *pdev)
> +{
> +       struct virtual_thermal_sensor *sensor;
> +
> +       sensor = platform_get_drvdata(pdev);
> +       list_del(&sensor->node);
> +
> +       virtual_thermal_sensor_put_modules(sensor);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id virtual_thermal_sensor_of_match[] = {
> +       {
> +               .compatible = "virtual,thermal-sensor",
> +       },
> +       {
> +       },
> +};
> +MODULE_DEVICE_TABLE(of, virtual_thermal_sensor_of_match);
> +
> +static struct platform_driver virtual_thermal_sensor = {
> +       .probe = virtual_thermal_sensor_probe,
> +       .remove = virtual_thermal_sensor_remove,
> +       .driver = {
> +               .name = "virtual-thermal-sensor",
> +               .of_match_table = virtual_thermal_sensor_of_match,
> +       },
> +};
> +
> +module_platform_driver(virtual_thermal_sensor);
> +MODULE_AUTHOR("Alexandre Bailon <abailon@baylibre.com>");
> +MODULE_DESCRIPTION("Virtual thermal sensor");
> +MODULE_LICENSE("GPL v2");
> --
