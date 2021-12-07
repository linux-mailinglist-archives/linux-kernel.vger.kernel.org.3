Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750F546B616
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhLGIj1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Dec 2021 03:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbhLGIjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:39:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0851BC061748
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 00:35:56 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1muVwp-0005HR-6U; Tue, 07 Dec 2021 09:35:39 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1muVwg-0003U5-SO; Tue, 07 Dec 2021 09:35:30 +0100
Message-ID: <75d34242693a41978fb7c6703dac3fd3a6437172.camel@pengutronix.de>
Subject: Re: [PATCH v5 04/10] reset: Add Sunplus SP7021 reset driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Qin Jian <qinjian@cqplus1.com>, robh+dt@kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, tglx@linutronix.de,
        maz@kernel.org, linux@armlinux.org.uk, broonie@kernel.org,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, wells.lu@sunplus.com
Date:   Tue, 07 Dec 2021 09:35:30 +0100
In-Reply-To: <5b847375ae9591dfd0551c86141102e02b450479.1638515726.git.qinjian@cqplus1.com>
References: <cover.1638515726.git.qinjian@cqplus1.com>
         <5b847375ae9591dfd0551c86141102e02b450479.1638515726.git.qinjian@cqplus1.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-12-03 at 15:34 +0800, Qin Jian wrote:
[...]
> diff --git a/drivers/reset/reset-sunplus.c b/drivers/reset/reset-sunplus.c
> new file mode 100644
> index 000000000..a1d88dbaf
> --- /dev/null
> +++ b/drivers/reset/reset-sunplus.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * SP7021 reset driver
> + *
> + * Copyright (C) Sunplus Technology Co., Ltd.
> + *       All rights reserved.
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/reboot.h>
> +
> +/* HIWORD_MASK_REG BITS */
> +#define BITS_PER_HWM_REG	16
> +
> +struct sp_reset_data {
> +	struct reset_controller_dev rcdev;
> +	void __iomem *membase;
> +} *sp_reset;
     ^^^^^^^^^^

I'd prefer if you removed the global sp_reset pointer.

[...]
> +static int sp_restart(struct notifier_block *this, unsigned long mode,
> +		      void *cmd)
> +{

You could embed the sp_restart_nb notifier block in struct sp_reset_data
and use container_of(this, struct sp_reset_data, notifier) to get to the
rcdev here.

> +	sp_reset_assert(&sp_reset->rcdev, 0);
> +	sp_reset_deassert(&sp_reset->rcdev, 0);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block sp_restart_nb = {
> +	.notifier_call = sp_restart,
> +	.priority = 192,
> +};
> +
> +static const struct reset_control_ops sp_reset_ops = {
> +	.assert   = sp_reset_assert,
> +	.deassert = sp_reset_deassert,
> +	.status   = sp_reset_status,
> +};
> +
> +static const struct of_device_id sp_reset_dt_ids[] = {
> +	{.compatible = "sunplus,sp7021-reset",},
> +	{ /* sentinel */ },
> +};
> +
> +static int sp_reset_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	void __iomem *membase;
> +	struct resource *res;
> +
> +	sp_reset = devm_kzalloc(&pdev->dev, sizeof(*sp_reset), GFP_KERNEL);
> +	if (!sp_reset)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	membase = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(membase))
> +		return PTR_ERR(membase);
> +
> +	sp_reset->membase = membase;
> +	sp_reset->rcdev.owner = THIS_MODULE;
> +	sp_reset->rcdev.nr_resets = resource_size(res) / 4 * 16;	/* HIWORD_MASK */
> +	sp_reset->rcdev.ops = &sp_reset_ops;
> +	sp_reset->rcdev.of_node = dev->of_node;
> +	register_restart_handler(&sp_restart_nb);

Either do this after devm_reset_controller_register(), which could
theoretically fail with -ENOMEM, or call unregister_restart_handler() in
the error case below.

> +
> +	return devm_reset_controller_register(dev, &sp_reset->rcdev);
> +}
> +
> +static struct platform_driver sp_reset_driver = {
> +	.probe = sp_reset_probe,
> +	.driver = {
> +		   .name = "sunplus-reset",
> +		   .of_match_table = sp_reset_dt_ids,
		^
Please fix the indentation, two tabs here.

		.suppress_bind_attrs = true,

to stop unbinding the driver. Alternatively, add a driver remove
function that unregisters the restart handler.

> +		   },
	^
One tab here.

> +};
> +
> +module_platform_driver(sp_reset_driver);
> +
> +MODULE_AUTHOR("Edwin Chiu <edwin.chiu@sunplus.com>");
> +MODULE_DESCRIPTION("Sunplus Reset Driver");
> +MODULE_LICENSE("GPL v2");

regards
Philipp
