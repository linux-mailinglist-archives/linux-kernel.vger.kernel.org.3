Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703C95A7858
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiHaIBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiHaIBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:01:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08585A2A88
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:01:12 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oTIes-0001nm-Bp; Wed, 31 Aug 2022 10:01:10 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oTIer-0001pY-Q3; Wed, 31 Aug 2022 10:01:09 +0200
Date:   Wed, 31 Aug 2022 10:01:09 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel@pengutronix.de, Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/2] gpio: Add gpio latch driver
Message-ID: <20220831080109.tqzwgm3o47c7wlzi@pengutronix.de>
References: <20220831055811.1936613-1-s.hauer@pengutronix.de>
 <20220831055811.1936613-2-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831055811.1936613-2-s.hauer@pengutronix.de>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sascha,

On 22-08-31, Sascha Hauer wrote:
> This driver implements a GPIO multiplexer based on latches connected to
> other GPIOs. A set of data GPIOs is connected to the data input of
> multiple latches. The clock input of each latch is driven by another
> set of GPIOs. With two 8-bit latches 10 GPIOs can be multiplexed into
> 16 GPIOs. GPOs might be a better term as in fact the multiplexed pins
> are output only.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

apart the one minor nit (see end) feel free to add my

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

> ---
>  drivers/gpio/Kconfig      |   6 ++
>  drivers/gpio/Makefile     |   1 +
>  drivers/gpio/gpio-latch.c | 190 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 197 insertions(+)
>  create mode 100644 drivers/gpio/gpio-latch.c
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 0642f579196f2..e4603810ec910 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1690,6 +1690,12 @@ config GPIO_AGGREGATOR
>  	      industrial control context, to be operated from userspace using
>  	      the GPIO chardev interface.
>  
> +config GPIO_LATCH
> +	tristate "GPIO latch driver"
> +	help
> +	  Say yes here to enable a driver for GPIO multiplexers based on latches
> +	  connected to other GPIOs.
> +
>  config GPIO_MOCKUP
>  	tristate "GPIO Testing Driver"
>  	select IRQ_SIM
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index a0985d30f51bb..310fa08decc69 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -75,6 +75,7 @@ obj-$(CONFIG_GPIO_IT87)			+= gpio-it87.o
>  obj-$(CONFIG_GPIO_IXP4XX)		+= gpio-ixp4xx.o
>  obj-$(CONFIG_GPIO_JANZ_TTL)		+= gpio-janz-ttl.o
>  obj-$(CONFIG_GPIO_KEMPLD)		+= gpio-kempld.o
> +obj-$(CONFIG_GPIO_LATCH)		+= gpio-latch.o
>  obj-$(CONFIG_GPIO_LOGICVC)		+= gpio-logicvc.o
>  obj-$(CONFIG_GPIO_LOONGSON1)		+= gpio-loongson1.o
>  obj-$(CONFIG_GPIO_LOONGSON)		+= gpio-loongson.o
> diff --git a/drivers/gpio/gpio-latch.c b/drivers/gpio/gpio-latch.c
> new file mode 100644
> index 0000000000000..4068ed4066272
> --- /dev/null
> +++ b/drivers/gpio/gpio-latch.c
> @@ -0,0 +1,190 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * GPIO latch driver
> + *
> + *  Copyright (C) 2022 Sascha Hauer <s.hauer@pengutronix.de>
> + *
> + * This driver implements a GPIO (or better GPO as there is no input)
> + * multiplexer based on latches like this:
> + *
> + * CLK0 ----------------------.        ,--------.
> + * CLK1 -------------------.  `--------|>    #0 |
> + *                         |           |        |
> + * OUT0 ----------------+--|-----------|D0    Q0|-----|<
> + * OUT1 --------------+-|--|-----------|D1    Q1|-----|<
> + * OUT2 ------------+-|-|--|-----------|D2    Q2|-----|<
> + * OUT3 ----------+-|-|-|--|-----------|D3    Q3|-----|<
> + * OUT4 --------+-|-|-|-|--|-----------|D4    Q4|-----|<
> + * OUT5 ------+-|-|-|-|-|--|-----------|D5    Q5|-----|<
> + * OUT6 ----+-|-|-|-|-|-|--|-----------|D6    Q6|-----|<
> + * OUT7 --+-|-|-|-|-|-|-|--|-----------|D7    Q7|-----|<
> + *        | | | | | | | |  |           `--------'
> + *        | | | | | | | |  |
> + *        | | | | | | | |  |           ,--------.
> + *        | | | | | | | |  `-----------|>    #1 |
> + *        | | | | | | | |              |        |
> + *        | | | | | | | `--------------|D0    Q0|-----|<
> + *        | | | | | | `----------------|D1    Q1|-----|<
> + *        | | | | | `------------------|D2    Q2|-----|<
> + *        | | | | `--------------------|D3    Q3|-----|<
> + *        | | | `----------------------|D4    Q4|-----|<
> + *        | | `------------------------|D5    Q5|-----|<
> + *        | `--------------------------|D6    Q6|-----|<
> + *        `----------------------------|D7    Q7|-----|<
> + *                                     `--------'
> + *
> + * The above is just an example. The actual number of number of latches and
> + * the number of inputs per latch is derived from the number of GPIOs given
> + * in the corresponding device tree properties.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio/consumer.h>
> +
> +#include "gpiolib.h"
> +
> +struct gpio_latch_priv {
> +	struct gpio_chip gc;
> +	struct gpio_descs *clk_gpios;
> +	struct gpio_descs *data_gpios;
> +	spinlock_t lock;
> +	int n_ports;
> +	int n_pins;
> +	unsigned int *shadow;
> +	struct mutex mutex;
> +	spinlock_t spinlock;
> +};
> +
> +static int gpio_latch_get_direction(struct gpio_chip *gc, unsigned int offset)
> +{
> +	return GPIO_LINE_DIRECTION_OUT;
> +}
> +
> +static void __gpio_latch_set(struct gpio_latch_priv *priv,
> +			     void (* set)(struct gpio_desc *desc, int value),
> +			     unsigned int offset, int val)
> +{
> +	int latch = offset / priv->n_pins;
> +	int i;
> +
> +	if (val)
> +		priv->shadow[latch] |= BIT(offset % priv->n_pins);
> +	else
> +		priv->shadow[latch] &= ~BIT(offset % priv->n_pins);
> +
> +	for (i = 0; i < priv->n_pins; i++)
> +		set(priv->data_gpios->desc[i], priv->shadow[latch] & BIT(i));
> +
> +	set(priv->clk_gpios->desc[latch], 1);
> +	set(priv->clk_gpios->desc[latch], 0);
> +}
> +
> +static void gpio_latch_set(struct gpio_chip *gc, unsigned int offset, int val)
> +{
> +	struct gpio_latch_priv *priv = gpiochip_get_data(gc);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->spinlock, flags);
> +
> +	__gpio_latch_set(priv, gpiod_set_value, offset, val);
> +
> +	spin_unlock_irqrestore(&priv->spinlock, flags);
> +}
> +
> +static void gpio_latch_set_can_sleep(struct gpio_chip *gc, unsigned int offset, int val)
> +{
> +	struct gpio_latch_priv *priv = gpiochip_get_data(gc);
> +
> +	mutex_lock(&priv->mutex);
> +
> +	__gpio_latch_set(priv, gpiod_set_value_cansleep, offset, val);
> +
> +	mutex_unlock(&priv->mutex);
> +}
> +
> +static bool gpio_latch_can_sleep(struct gpio_latch_priv *priv)
> +{
> +	int i;
> +
> +	for (i = 0; i < priv->n_ports; i++)
> +		if (gpiod_cansleep(priv->clk_gpios->desc[i]))
> +			return true;
> +
> +	for (i = 0; i < priv->n_pins; i++)
> +		if (gpiod_cansleep(priv->data_gpios->desc[i]))
> +			return true;
> +
> +	return false;
> +}
> +
> +static int gpio_latch_probe(struct platform_device *pdev)
> +{
> +	struct gpio_latch_priv *priv;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->clk_gpios = devm_gpiod_get_array(&pdev->dev, "clk", GPIOD_OUT_LOW);
> +	if (IS_ERR(priv->clk_gpios))
> +		return PTR_ERR(priv->clk_gpios);
> +
> +	priv->data_gpios = devm_gpiod_get_array(&pdev->dev, "data", GPIOD_OUT_LOW);
> +	if (IS_ERR(priv->data_gpios))
> +		return PTR_ERR(priv->data_gpios);
> +
> +	priv->n_ports = priv->clk_gpios->ndescs;
> +	priv->n_pins = priv->data_gpios->ndescs;
> +
> +	priv->shadow = devm_kcalloc(&pdev->dev, priv->n_ports, sizeof(*priv->shadow),
> +				    GFP_KERNEL);
> +	if (!priv->shadow)
> +		return -ENOMEM;
> +
> +	if (gpio_latch_can_sleep(priv)) {
> +		priv->gc.can_sleep = true;
> +		priv->gc.set = gpio_latch_set_can_sleep;
> +		mutex_init(&priv->mutex);
> +	} else {
> +		priv->gc.can_sleep = false;
> +		priv->gc.set = gpio_latch_set;
> +		spin_lock_init(&priv->spinlock);
> +	}
> +
> +	priv->gc.get_direction = gpio_latch_get_direction;
> +	priv->gc.ngpio = priv->n_ports * priv->n_pins;
> +	priv->gc.owner = THIS_MODULE;
> +	priv->gc.base = -1;
> +	priv->gc.parent = &pdev->dev;
> +	priv->gc.of_node = pdev->dev.of_node;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return devm_gpiochip_add_data(&pdev->dev, &priv->gc, priv);
> +}
> +
> +static const struct of_device_id gpio_latch_ids[] = {
> +	{
> +		.compatible	= "gpio-latch",
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +MODULE_DEVICE_TABLE(of, gpio_latch_ids);
> +
> +static struct platform_driver gpio_latch_driver = {
> +	.driver	= {
> +		.name		= "gpio-latch",
> +		.of_match_table	= gpio_latch_ids,
> +	},
> +	.probe	= gpio_latch_probe,
> +};
> +module_platform_driver(gpio_latch_driver);
> +
> +MODULE_LICENSE("GPL v2");

checkpatch.pl should complain about this since it it now GPL, see commit
bf7fbeeae6db. Sorry for not spotted that earlier.

Regards,
  Marco

> +MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
> +MODULE_DESCRIPTION("GPIO latch driver");
> -- 
> 2.30.2
