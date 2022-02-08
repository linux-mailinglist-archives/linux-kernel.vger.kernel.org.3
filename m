Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CC54AD49D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 10:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353907AbiBHJTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 04:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353813AbiBHJTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:19:07 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE80C03FEC1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:19:05 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id o12so50305234eju.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 01:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7TpW3hBV/IKUYOuIgoBUlIR8VMvbzIXTES3PAvE+6s=;
        b=nK6pVNAzJM1Hi2ubc/6IDdZK4e2ffC9uq1T6kQslp+VuSjrTAdNB0+MSpPzS2R5dX/
         guUAFLujpIOPwL7mC8gDCFzUjxMLLl8LpjdoCPrkEfVnnJBpzdD/LgSs1HeBhb8w26yI
         qnCdp7YEsnx2ieEDqu9g/FvhKP6JtbKp7pfVB3HnRosBZnXpBSR+X/ZInfifT4KqXOFm
         P+hly883jjF3f4nCrH+IHY6xIDcNyWyjaVphQPpFqLOXycZyXpeygoZy7VuqOOwx0Jns
         9UcD3jEAqcs6pOeU0J8WnFoSdx6hV37Rik+hki/yTgfzeztgem+LiRwvD9DCa3OLrG0r
         Q5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7TpW3hBV/IKUYOuIgoBUlIR8VMvbzIXTES3PAvE+6s=;
        b=u+ZBprB06CvnX9dLuPd6abz4pHTNAOJvt+ZTD/wPgfNmGJ3Rn5nyz2UHkztY7Mwub1
         PJzwEHdOpw3av1m01Ws5378G7vR1+o5GY0fBnsWip22g90q0UsFBzA/pqpH7E1E18V7F
         +7dkzd2pxx0zys5cTWyjtEz3q4jBxcQTeEucErqYBiry+HjtXGcyyYH+qLk2L0svZPDG
         kfMmKYuh6rTMjQ0qh9YVP03fjNmOxnerBy0Ss1pIFIXL19E5ehacVy7UsbS7h3J0jEJt
         sV91W2cejACRuA1dOk639sJspK/ohzs4j65/ADUD7/0Dl6lnp6t9S5/CGQ36JfvlQeuC
         +WCA==
X-Gm-Message-State: AOAM533Ayy439Uf+VleWN1CjaRkOKqFIFSQ0JUaSeoMTBGmsT13L2QKB
        9vYDz1MPEjcq4jkqEuH3bCqhkwEpfIxiPag/HxGbOeqDLfE=
X-Google-Smtp-Source: ABdhPJyQoOMGeM5XHvR/UH7ToPbAf/cqRfW6RcGwBbXeAF7Lj0olb8gQNJqMqwzvRSuT8EZ2ix5GXOSIAqK9S9U6BU4=
X-Received: by 2002:a17:907:728c:: with SMTP id dt12mr2821017ejc.697.1644311944144;
 Tue, 08 Feb 2022 01:19:04 -0800 (PST)
MIME-Version: 1.0
References: <20220131133049.77780-1-robert.marko@sartura.hr> <20220131133049.77780-3-robert.marko@sartura.hr>
In-Reply-To: <20220131133049.77780-3-robert.marko@sartura.hr>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 8 Feb 2022 10:18:53 +0100
Message-ID: <CAMRc=MfdGBkLU5c83g9YdayiAWYsaULhs1O6CThB=BFGENQY1Q@mail.gmail.com>
Subject: Re: [PATCH v10 2/6] gpio: Add Delta TN48M CPLD GPIO driver
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, skhan@linuxfoundation.org,
        luka.perkov@sartura.hr,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michael Walle <michael@walle.cc>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 2:30 PM Robert Marko <robert.marko@sartura.hr> wrote:
>
> Delta TN48M switch has an onboard Lattice CPLD that is used as a GPIO
> expander.
>
> The CPLD provides 12 pins in total on the TN48M, but on more advanced
> switch models it provides up to 192 pins, so the driver is extendable
> to support more switches.
>
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Michael Walle <michael@walle.cc>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v10:
> * Rebase onto 5.17-rc1
>
> Changes in v9:
> * Use {} instead of {0} for initialising the regmap config per Andys
> comment
> * Fix spelling mistake in KConfig
>
> Changes in v8:
> * No need to assing NULL to gpio_config per Andys comment
>
> Changes in v7:
> * Change compatibles, reduce their number
> * Rework the driver to be easily extendible to support more devices
> * Use match data to populate configuration
> * Drop reviews and ACK-s as the driver changed
>
> Changes in v6:
> * Drop unused header
> * Return the return value of device_property_read_u32()
> instead of a hardcoded return
>
> Changes in v2:
> * Rewrite to use simple I2C MFD and GPIO regmap
> * Drop DT bindings for pin numbering
> ---
>  drivers/gpio/Kconfig      |  12 +++++
>  drivers/gpio/Makefile     |   1 +
>  drivers/gpio/gpio-tn48m.c | 100 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 113 insertions(+)
>  create mode 100644 drivers/gpio/gpio-tn48m.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 1c211b4c63be..c822cf6146cf 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1346,6 +1346,18 @@ config GPIO_TIMBERDALE
>         help
>         Add support for the GPIO IP in the timberdale FPGA.
>
> +config GPIO_TN48M_CPLD
> +       tristate "Delta Networks TN48M switch CPLD GPIO driver"
> +       depends on MFD_TN48M_CPLD
> +       select GPIO_REGMAP
> +       help
> +         This enables support for the GPIOs found on the Delta
> +         Networks TN48M switch Lattice CPLD. It provides 12 pins in total,
> +         they are input-only or output-only type.
> +
> +         This driver can also be built as a module. If so, the
> +         module will be called gpio-tn48m.
> +
>  config GPIO_TPS65086
>         tristate "TI TPS65086 GPO"
>         depends on MFD_TPS65086
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index edbaa3cb343c..3b68a9808154 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -148,6 +148,7 @@ obj-$(CONFIG_GPIO_TEGRA186)         += gpio-tegra186.o
>  obj-$(CONFIG_GPIO_TEGRA)               += gpio-tegra.o
>  obj-$(CONFIG_GPIO_THUNDERX)            += gpio-thunderx.o
>  obj-$(CONFIG_GPIO_TIMBERDALE)          += gpio-timberdale.o
> +obj-$(CONFIG_GPIO_TN48M_CPLD)          += gpio-tn48m.o
>  obj-$(CONFIG_GPIO_TPIC2810)            += gpio-tpic2810.o
>  obj-$(CONFIG_GPIO_TPS65086)            += gpio-tps65086.o
>  obj-$(CONFIG_GPIO_TPS65218)            += gpio-tps65218.o
> diff --git a/drivers/gpio/gpio-tn48m.c b/drivers/gpio/gpio-tn48m.c
> new file mode 100644
> index 000000000000..cd4a80b22794
> --- /dev/null
> +++ b/drivers/gpio/gpio-tn48m.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Delta TN48M CPLD GPIO driver
> + *
> + * Copyright (C) 2021 Sartura Ltd.
> + *
> + * Author: Robert Marko <robert.marko@sartura.hr>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/gpio/regmap.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +enum tn48m_gpio_type {
> +       TN48M_GP0 = 1,
> +       TN48M_GPI,
> +};
> +
> +struct tn48m_gpio_config {
> +       int ngpio;
> +       int ngpio_per_reg;
> +       enum tn48m_gpio_type type;
> +};
> +
> +static const struct tn48m_gpio_config tn48m_gpo_config = {
> +       .ngpio = 4,
> +       .ngpio_per_reg = 4,
> +       .type = TN48M_GP0,
> +};
> +
> +static const struct tn48m_gpio_config tn48m_gpi_config = {
> +       .ngpio = 4,
> +       .ngpio_per_reg = 4,
> +       .type = TN48M_GPI,
> +};
> +
> +static int tn48m_gpio_probe(struct platform_device *pdev)
> +{
> +       const struct tn48m_gpio_config *gpio_config;
> +       struct gpio_regmap_config config = {};
> +       struct regmap *regmap;
> +       u32 base;
> +       int ret;
> +
> +       if (!pdev->dev.parent)
> +               return -ENODEV;
> +
> +       gpio_config = device_get_match_data(&pdev->dev);
> +       if (!gpio_config)
> +               return -ENODEV;
> +
> +       ret = device_property_read_u32(&pdev->dev, "reg", &base);
> +       if (ret)
> +               return ret;
> +
> +       regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +       if (!regmap)
> +               return -ENODEV;
> +
> +       config.regmap = regmap;
> +       config.parent = &pdev->dev;
> +       config.ngpio = gpio_config->ngpio;
> +       config.ngpio_per_reg = gpio_config->ngpio_per_reg;
> +       switch (gpio_config->type) {
> +       case TN48M_GP0:
> +               config.reg_set_base = base;
> +               break;
> +       case TN48M_GPI:
> +               config.reg_dat_base = base;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(&pdev->dev, &config));
> +}
> +
> +static const struct of_device_id tn48m_gpio_of_match[] = {
> +       { .compatible = "delta,tn48m-gpo", .data = &tn48m_gpo_config },
> +       { .compatible = "delta,tn48m-gpi", .data = &tn48m_gpi_config },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, tn48m_gpio_of_match);
> +
> +static struct platform_driver tn48m_gpio_driver = {
> +       .driver = {
> +               .name = "delta-tn48m-gpio",
> +               .of_match_table = tn48m_gpio_of_match,
> +       },
> +       .probe = tn48m_gpio_probe,
> +};
> +module_platform_driver(tn48m_gpio_driver);
> +
> +MODULE_AUTHOR("Robert Marko <robert.marko@sartura.hr>");
> +MODULE_DESCRIPTION("Delta TN48M CPLD GPIO driver");
> +MODULE_LICENSE("GPL");
> --
> 2.34.1
>

Small and clean, I love it.

Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
