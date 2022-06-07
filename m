Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3C05403B0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343831AbiFGQ1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbiFGQ1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:27:11 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8111AD;
        Tue,  7 Jun 2022 09:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1654619226; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HQKTT3DBsyAu7n209v9YKnHJBKH0K7d7v+HEytHeZ1M=;
        b=mu9UqRZvZAVAHxHN+JE2ruAE3VuYSiSAXtTGLe9aayCyBxSQWNeTtUsDMepw5WZV7ikKE8
        4/5cYeaUk2owu/LmB03XD5gzqBdWmEFAVdJMy4VoecWU/VTPbIJ4JyhL5Mm1uLyxMxJ3Vm
        R7RakfMGRs+AlJi05VmICImyElY8aZo=
Date:   Tue, 07 Jun 2022 17:26:53 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] pinctrl: ingenic: Convert to immutable irq chip
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     linus.walleij@linaro.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <TC84DR.BXHQAW8NSA8H@crapouillou.net>
In-Reply-To: <20220607110525.36922-1-aidanmacdonald.0x0@gmail.com>
References: <20220607110525.36922-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

Le mar., juin 7 2022 at 12:05:25 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> Update the driver to use an immutable IRQ chip to fix this warning:
>=20
>     "not an immutable chip, please consider fixing it!"
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/pinctrl/pinctrl-ingenic.c | 33=20
> ++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/pinctrl/pinctrl-ingenic.c=20
> b/drivers/pinctrl/pinctrl-ingenic.c
> index 1ca11616db74..37258fb05be3 100644
> --- a/drivers/pinctrl/pinctrl-ingenic.c
> +++ b/drivers/pinctrl/pinctrl-ingenic.c
> @@ -135,7 +135,6 @@ struct ingenic_pinctrl {
>  struct ingenic_gpio_chip {
>  	struct ingenic_pinctrl *jzpc;
>  	struct gpio_chip gc;
> -	struct irq_chip irq_chip;
>  	unsigned int irq, reg_base;
>  };
>=20
> @@ -3419,6 +3418,8 @@ static void ingenic_gpio_irq_enable(struct=20
> irq_data *irqd)
>  	struct ingenic_gpio_chip *jzgc =3D gpiochip_get_data(gc);
>  	int irq =3D irqd->hwirq;
>=20
> +	gpiochip_enable_irq(gc, irq);
> +
>  	if (is_soc_or_above(jzgc->jzpc, ID_JZ4770))
>  		ingenic_gpio_set_bit(jzgc, JZ4770_GPIO_INT, irq, true);
>  	else if (is_soc_or_above(jzgc->jzpc, ID_JZ4740))
> @@ -3443,6 +3444,8 @@ static void ingenic_gpio_irq_disable(struct=20
> irq_data *irqd)
>  		ingenic_gpio_set_bit(jzgc, JZ4740_GPIO_SELECT, irq, false);
>  	else
>  		ingenic_gpio_set_bit(jzgc, JZ4730_GPIO_GPIER, irq, false);
> +
> +	gpiochip_disable_irq(gc, irq);
>  }
>=20
>  static void ingenic_gpio_irq_ack(struct irq_data *irqd)
> @@ -3684,6 +3687,20 @@ static void ingenic_gpio_irq_release(struct=20
> irq_data *data)
>  	return gpiochip_relres_irq(gpio_chip, data->hwirq);
>  }
>=20
> +static const struct irq_chip ingenic_gpio_irqchip =3D {
> +	.name			=3D "gpio",
> +	.irq_enable		=3D ingenic_gpio_irq_enable,
> +	.irq_disable		=3D ingenic_gpio_irq_disable,
> +	.irq_unmask		=3D ingenic_gpio_irq_unmask,
> +	.irq_mask		=3D ingenic_gpio_irq_mask,
> +	.irq_ack		=3D ingenic_gpio_irq_ack,
> +	.irq_set_type		=3D ingenic_gpio_irq_set_type,
> +	.irq_set_wake		=3D ingenic_gpio_irq_set_wake,
> +	.irq_request_resources	=3D ingenic_gpio_irq_request,
> +	.irq_release_resources	=3D ingenic_gpio_irq_release,
> +	.flags			=3D IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
> +};
> +
>  static int ingenic_pinmux_set_pin_fn(struct ingenic_pinctrl *jzpc,
>  		int pin, int func)
>  {
> @@ -4172,20 +4189,8 @@ static int __init ingenic_gpio_probe(struct=20
> ingenic_pinctrl *jzpc,
>  	if (!jzgc->irq)
>  		return -EINVAL;
>=20
> -	jzgc->irq_chip.name =3D jzgc->gc.label;
> -	jzgc->irq_chip.irq_enable =3D ingenic_gpio_irq_enable;
> -	jzgc->irq_chip.irq_disable =3D ingenic_gpio_irq_disable;
> -	jzgc->irq_chip.irq_unmask =3D ingenic_gpio_irq_unmask;
> -	jzgc->irq_chip.irq_mask =3D ingenic_gpio_irq_mask;
> -	jzgc->irq_chip.irq_ack =3D ingenic_gpio_irq_ack;
> -	jzgc->irq_chip.irq_set_type =3D ingenic_gpio_irq_set_type;
> -	jzgc->irq_chip.irq_set_wake =3D ingenic_gpio_irq_set_wake;
> -	jzgc->irq_chip.irq_request_resources =3D ingenic_gpio_irq_request;
> -	jzgc->irq_chip.irq_release_resources =3D ingenic_gpio_irq_release;
> -	jzgc->irq_chip.flags =3D IRQCHIP_MASK_ON_SUSPEND;
> -
>  	girq =3D &jzgc->gc.irq;
> -	girq->chip =3D &jzgc->irq_chip;
> +	gpio_irq_chip_set_chip(girq, &ingenic_gpio_irqchip);

This will change each irq_chip's name to "gpio", do we want that?

You didn't remove jzgc->irq_chip, so maybe what you could do is
jzgc->irq_chip =3D ingenic_gpio_irqchip;
jzgc->irq_chip.name =3D jzgc->gc.label;
gpio_irq_chip_set_chip(girq, &jzgc->irq_chip);

Thoughts?

Cheers,
-Paul

>  	girq->parent_handler =3D ingenic_gpio_irq_handler;
>  	girq->num_parents =3D 1;
>  	girq->parents =3D devm_kcalloc(dev, 1, sizeof(*girq->parents),
> --
> 2.35.1
>=20


