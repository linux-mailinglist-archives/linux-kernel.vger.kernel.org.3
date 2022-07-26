Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA88580F56
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238297AbiGZIp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiGZIpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:45:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9077E12AF4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 01:45:24 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oGGBq-0000eH-SW; Tue, 26 Jul 2022 10:45:18 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oGGBq-0003AC-Et; Tue, 26 Jul 2022 10:45:18 +0200
Date:   Tue, 26 Jul 2022 10:45:18 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2 2/2] reset: tps380x: Add TPS380x device driver supprt
Message-ID: <20220726084518.qmb2wjcazi3djcqr@pengutronix.de>
References: <20220530092226.748644-1-m.felsch@pengutronix.de>
 <20220530092226.748644-2-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530092226.748644-2-m.felsch@pengutronix.de>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

gentle ping.

On 22-05-30, Marco Felsch wrote:
> The TI TPS380x family [1] is a voltage supervisor with a dedicated
> manual reset (mr) line input and a reset output. The chip(s) have a
> build in reset delay, depending on the chip partnumber. This simple
> driver addresses this so the cosumer don't need to care about it.
> 
> [1] https://www.ti.com/product/TPS3801
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> Changelog:
> v2:
> - make reset_tps380x_ops static
> - fix commit message typo
> 
>  drivers/reset/Kconfig         |   8 +++
>  drivers/reset/Makefile        |   1 +
>  drivers/reset/reset-tps380x.c | 130 ++++++++++++++++++++++++++++++++++
>  3 files changed, 139 insertions(+)
>  create mode 100644 drivers/reset/reset-tps380x.c
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index e0fc80e041ea..e2eb616af812 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -256,6 +256,14 @@ config RESET_TI_SYSCON
>  	  you wish to use the reset framework for such memory-mapped devices,
>  	  say Y here. Otherwise, say N.
>  
> +config RESET_TI_TPS380X
> +	tristate "TI TPS380x Reset Driver"
> +	select GPIOLIB
> +	help
> +	  This enables the reset driver support for TI TPS380x devices. If
> +	  you wish to use the reset framework for such devices, say Y here.
> +	  Otherwise, say N.
> +
>  config RESET_TN48M_CPLD
>  	tristate "Delta Networks TN48M switch CPLD reset controller"
>  	depends on MFD_TN48M_CPLD || COMPILE_TEST
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index a80a9c4008a7..66399b92b1bb 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_RESET_STARFIVE_JH7100) += reset-starfive-jh7100.o
>  obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
>  obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
>  obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
> +obj-$(CONFIG_RESET_TI_TPS380X) += reset-tps380x.o
>  obj-$(CONFIG_RESET_TN48M_CPLD) += reset-tn48m.o
>  obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
>  obj-$(CONFIG_RESET_UNIPHIER_GLUE) += reset-uniphier-glue.o
> diff --git a/drivers/reset/reset-tps380x.c b/drivers/reset/reset-tps380x.c
> new file mode 100644
> index 000000000000..088158f54e6f
> --- /dev/null
> +++ b/drivers/reset/reset-tps380x.c
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * TI TPS380x Supply Voltage Supervisor and Reset Controller Driver
> + *
> + * Copyright (C) 2022 Pengutronix, Marco Felsch <kernel@pengutronix.de>
> + *
> + * Based on Simple Reset Controller Driver
> + *
> + * Copyright (C) 2017 Pengutronix, Philipp Zabel <kernel@pengutronix.de>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/reset-controller.h>
> +
> +struct tps380x_reset {
> +	struct reset_controller_dev	rcdev;
> +	struct gpio_desc		*reset_gpio;
> +	unsigned int			reset_ms;
> +};
> +
> +struct tps380x_reset_devdata {
> +	unsigned int min_reset_ms;
> +	unsigned int typ_reset_ms;
> +	unsigned int max_reset_ms;
> +};
> +
> +static inline
> +struct tps380x_reset *to_tps380x_reset(struct reset_controller_dev *rcdev)
> +{
> +	return container_of(rcdev, struct tps380x_reset, rcdev);
> +}
> +
> +static int
> +tps380x_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	struct tps380x_reset *tps380x = to_tps380x_reset(rcdev);
> +
> +	gpiod_set_value_cansleep(tps380x->reset_gpio, 1);
> +
> +	return 0;
> +}
> +
> +static int
> +tps380x_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	struct tps380x_reset *tps380x = to_tps380x_reset(rcdev);
> +
> +	gpiod_set_value_cansleep(tps380x->reset_gpio, 0);
> +	msleep(tps380x->reset_ms);
> +
> +	return 0;
> +}
> +
> +static const struct reset_control_ops reset_tps380x_ops = {
> +	.assert		= tps380x_reset_assert,
> +	.deassert	= tps380x_reset_deassert,
> +};
> +
> +static int tps380x_reset_of_xlate(struct reset_controller_dev *rcdev,
> +				  const struct of_phandle_args *reset_spec)
> +{
> +	/* No special handling needed, we have only one reset line per device */
> +	return 0;
> +}
> +
> +static int tps380x_reset_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	const struct tps380x_reset_devdata *devdata;
> +	struct tps380x_reset *tps380x;
> +
> +	devdata = device_get_match_data(dev);
> +	if (!devdata)
> +		return -EINVAL;
> +
> +	tps380x = devm_kzalloc(dev, sizeof(*tps380x), GFP_KERNEL);
> +	if (!tps380x)
> +		return -ENOMEM;
> +
> +	tps380x->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(tps380x->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(tps380x->reset_gpio),
> +				     "Failed to get GPIO\n");
> +
> +	/*
> +	 * Todo:
> +	 * Add firmware handling to switch between min/typ/max reset time
> +	 */
> +	tps380x->reset_ms = devdata->max_reset_ms;
> +
> +	tps380x->rcdev.ops = &reset_tps380x_ops;
> +	tps380x->rcdev.owner = THIS_MODULE;
> +	tps380x->rcdev.dev = dev;
> +	tps380x->rcdev.of_node = dev->of_node;
> +	tps380x->rcdev.of_reset_n_cells = 0;
> +	tps380x->rcdev.of_xlate = tps380x_reset_of_xlate;
> +	tps380x->rcdev.nr_resets = 1;
> +
> +	return devm_reset_controller_register(dev, &tps380x->rcdev);
> +}
> +
> +static const struct tps380x_reset_devdata tps3801_reset_data = {
> +	.min_reset_ms = 120,
> +	.typ_reset_ms = 200,
> +	.max_reset_ms = 280,
> +};
> +
> +static const struct of_device_id tps380x_reset_dt_ids[] = {
> +	{ .compatible = "ti,tps3801", .data = &tps3801_reset_data },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, tps380x_reset_dt_ids);
> +
> +static struct platform_driver tps380x_reset_driver = {
> +	.probe	= tps380x_reset_probe,
> +	.driver = {
> +		.name		= "tps380x-reset",
> +		.of_match_table	= tps380x_reset_dt_ids,
> +	},
> +};
> +module_platform_driver(tps380x_reset_driver);
> +
> +MODULE_AUTHOR("Marco Felsch <kernel@pengutronix.de>");
> +MODULE_DESCRIPTION("TI TPS380x Supply Voltags Supervisor and Reset Driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.30.2
> 
> 
