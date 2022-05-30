Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D54C5374F6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbiE3HAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiE3HAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:00:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8CB62CFF
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:00:22 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1nvZNv-0000l3-KM; Mon, 30 May 2022 09:00:15 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1nvZNu-0003Xe-Hy; Mon, 30 May 2022 09:00:14 +0200
Date:   Mon, 30 May 2022 09:00:14 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org, krzk+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 2/2] reset: tps380x: Add TPS380x device driver supprt
Message-ID: <20220530070014.rqpau7oranahd6jr@pengutronix.de>
References: <20220525142019.3615253-1-m.felsch@pengutronix.de>
 <20220525142019.3615253-2-m.felsch@pengutronix.de>
 <597de13b-28c8-3341-be11-da51e22304c3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <597de13b-28c8-3341-be11-da51e22304c3@linaro.org>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-05-26, Krzysztof Kozlowski wrote:
> On 25/05/2022 16:20, Marco Felsch wrote:
> > The TI TPS380x family [1] is a volatage supervisor with a dedicated
> > manual reset (mr) line input and a reset output. The chip(s) have a
> > build in reset delay, depending on the chip partnumber. This simple
> > driver addresses this so the cosumer don't need to care about it.
> > 
> > [1] https://www.ti.com/product/TPS3801
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >  drivers/reset/Kconfig         |   8 +++
> >  drivers/reset/Makefile        |   1 +
> >  drivers/reset/reset-tps380x.c | 130 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 139 insertions(+)
> >  create mode 100644 drivers/reset/reset-tps380x.c
> > 
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > index e0fc80e041ea..e2eb616af812 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -256,6 +256,14 @@ config RESET_TI_SYSCON
> >  	  you wish to use the reset framework for such memory-mapped devices,
> >  	  say Y here. Otherwise, say N.
> >  
> > +config RESET_TI_TPS380X
> > +	tristate "TI TPS380x Reset Driver"
> > +	select GPIOLIB
> > +	help
> > +	  This enables the reset driver support for TI TPS380x devices. If
> > +	  you wish to use the reset framework for such devices, say Y here.
> > +	  Otherwise, say N.
> > +
> >  config RESET_TN48M_CPLD
> >  	tristate "Delta Networks TN48M switch CPLD reset controller"
> >  	depends on MFD_TN48M_CPLD || COMPILE_TEST
> > diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> > index a80a9c4008a7..66399b92b1bb 100644
> > --- a/drivers/reset/Makefile
> > +++ b/drivers/reset/Makefile
> > @@ -33,6 +33,7 @@ obj-$(CONFIG_RESET_STARFIVE_JH7100) += reset-starfive-jh7100.o
> >  obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
> >  obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
> >  obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
> > +obj-$(CONFIG_RESET_TI_TPS380X) += reset-tps380x.o
> >  obj-$(CONFIG_RESET_TN48M_CPLD) += reset-tn48m.o
> >  obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
> >  obj-$(CONFIG_RESET_UNIPHIER_GLUE) += reset-uniphier-glue.o
> > diff --git a/drivers/reset/reset-tps380x.c b/drivers/reset/reset-tps380x.c
> > new file mode 100644
> > index 000000000000..fd2c0929ae2d
> > --- /dev/null
> > +++ b/drivers/reset/reset-tps380x.c
> > @@ -0,0 +1,130 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * TI TPS380x Supply Voltage Supervisor and Reset Controller Driver
> > + *
> > + * Copyright (C) 2022 Pengutronix, Marco Felsch <kernel@pengutronix.de>
> > + *
> > + * Based on Simple Reset Controller Driver
> > + *
> > + * Copyright (C) 2017 Pengutronix, Philipp Zabel <kernel@pengutronix.de>
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/property.h>
> > +#include <linux/reset-controller.h>
> > +
> > +struct tps380x_reset {
> > +	struct reset_controller_dev	rcdev;
> > +	struct gpio_desc		*reset_gpio;
> > +	unsigned int			reset_ms;
> > +};
> > +
> > +struct tps380x_reset_devdata {
> > +	unsigned int min_reset_ms;
> > +	unsigned int typ_reset_ms;
> > +	unsigned int max_reset_ms;
> > +};
> > +
> > +static inline
> > +struct tps380x_reset *to_tps380x_reset(struct reset_controller_dev *rcdev)
> > +{
> > +	return container_of(rcdev, struct tps380x_reset, rcdev);
> > +}
> > +
> > +static int
> > +tps380x_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
> > +{
> > +	struct tps380x_reset *tps380x = to_tps380x_reset(rcdev);
> > +
> > +	gpiod_set_value_cansleep(tps380x->reset_gpio, 1);
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +tps380x_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
> > +{
> > +	struct tps380x_reset *tps380x = to_tps380x_reset(rcdev);
> > +
> > +	gpiod_set_value_cansleep(tps380x->reset_gpio, 0);
> > +	msleep(tps380x->reset_ms);
> > +
> > +	return 0;
> > +}
> > +
> > +const struct reset_control_ops reset_tps380x_ops = {
> 
> This looks static.

Hi Krzysztof,

Arg.. of course. I will change that. Thanks for the review.

Regards,
  Marco
