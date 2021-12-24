Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE80A47EFC1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 16:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353035AbhLXPDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 10:03:31 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:42199 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352999AbhLXPDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 10:03:30 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id D4E361BF203;
        Fri, 24 Dec 2021 15:03:27 +0000 (UTC)
Date:   Fri, 24 Dec 2021 16:03:26 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     linux-gpio@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] pinctrl: at91-pio4: Use platform_get_irq_optional()
 to get the interrupt
Message-ID: <YcXhPrvOsBRVAJ8w@piout.net>
References: <20211224145748.18754-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224145748.18754-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224145748.18754-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/12/2021 14:57:48+0000, Lad Prabhakar wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq_optional().
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/pinctrl/pinctrl-at91-pio4.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
> index fafd1f55cba7..ebfb106be97d 100644
> --- a/drivers/pinctrl/pinctrl-at91-pio4.c
> +++ b/drivers/pinctrl/pinctrl-at91-pio4.c
> @@ -1045,7 +1045,6 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
>  	const char **group_names;
>  	const struct of_device_id *match;
>  	int i, ret;
> -	struct resource	*res;
>  	struct atmel_pioctrl *atmel_pioctrl;
>  	const struct atmel_pioctrl_data *atmel_pioctrl_data;
>  
> @@ -1164,16 +1163,15 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
>  
>  	/* There is one controller but each bank has its own irq line. */
>  	for (i = 0; i < atmel_pioctrl->nbanks; i++) {
> -		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
> -		if (!res) {
> +		ret = platform_get_irq_optional(pdev, i);

I don't think the irq should be optional here.

> +		if (ret < 0) {
>  			dev_err(dev, "missing irq resource for group %c\n",
>  				'A' + i);
> -			return -EINVAL;
> +			return ret;
>  		}
> -		atmel_pioctrl->irqs[i] = res->start;
> -		irq_set_chained_handler_and_data(res->start,
> -			atmel_gpio_irq_handler, atmel_pioctrl);
> -		dev_dbg(dev, "bank %i: irq=%pr\n", i, res);
> +		atmel_pioctrl->irqs[i] = ret;
> +		irq_set_chained_handler_and_data(ret, atmel_gpio_irq_handler, atmel_pioctrl);
> +		dev_dbg(dev, "bank %i: irq=%d\n", i, ret);
>  	}
>  
>  	atmel_pioctrl->irq_domain = irq_domain_add_linear(dev->of_node,
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
