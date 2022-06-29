Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076CF5605DC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiF2Q3L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Jun 2022 12:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiF2Q3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:29:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7435C275DE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:29:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1o6aYg-00071l-0G; Wed, 29 Jun 2022 18:28:54 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1o6aYb-003QpM-5u; Wed, 29 Jun 2022 18:28:52 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1o6aYe-000Dhz-4j; Wed, 29 Jun 2022 18:28:52 +0200
Message-ID: <f51a6ccda0f7b4596406789fa73e1bdad85186bc.camel@pengutronix.de>
Subject: Re: [PATCH v6 2/5] irqchip: Add RZ/G2L IA55 Interrupt Controller
 driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Date:   Wed, 29 Jun 2022 18:28:52 +0200
In-Reply-To: <20220625200600.7582-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220625200600.7582-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
         <20220625200600.7582-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
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

On Sa, 2022-06-25 at 21:05 +0100, Lad Prabhakar wrote:
> Add a driver for the Renesas RZ/G2L Interrupt Controller.
> 
> This supports external pins being used as interrupts. It supports
> one line for NMI, 8 external pins and 32 GPIO pins (out of 123)
> to be used as IRQ lines.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/irqchip/Kconfig             |   8 +
>  drivers/irqchip/Makefile            |   1 +
>  drivers/irqchip/irq-renesas-rzg2l.c | 393 ++++++++++++++++++++++++++++
>  3 files changed, 402 insertions(+)
>  create mode 100644 drivers/irqchip/irq-renesas-rzg2l.c
> 
[...]
> diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
> new file mode 100644
> index 000000000000..cc16fcf2bbc6
> --- /dev/null
> +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> @@ -0,0 +1,393 @@
[...]
> +static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
> +{
> +	struct irq_domain *irq_domain, *parent_domain;
> +	struct platform_device *pdev;
> +	struct reset_control *resetn;
> +	struct rzg2l_irqc_priv *priv;
> +	int ret;
> +
> +	pdev = of_find_device_by_node(node);
> +	if (!pdev)
> +		return -ENODEV;
> +
> +	parent_domain = irq_find_host(parent);
> +	if (!parent_domain) {
> +		dev_err(&pdev->dev, "cannot find parent domain\n");
> +		return -ENODEV;
> +	}
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->base = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	ret = rzg2l_irqc_parse_interrupts(priv, node);
> +	if (ret) {
> +		dev_err(&pdev->dev, "cannot parse interrupts: %d\n", ret);
> +		return ret;
> +	}
> +
> +	resetn = devm_reset_control_get_exclusive_by_index(&pdev->dev, 0);

Why is this by index? I'd expect

	resetn = devm_reset_control_get_exclusive(&pdev->dev, NULL);

should work just as well?

regards
Philipp
