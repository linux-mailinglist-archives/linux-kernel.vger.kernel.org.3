Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B7F545344
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344864AbiFIRpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbiFIRpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:45:09 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D2E29B137;
        Thu,  9 Jun 2022 10:45:07 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id y19so48929206ejq.6;
        Thu, 09 Jun 2022 10:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version:content-transfer-encoding;
        bh=2Arm22YPpQPTnc0YJ8BaJwMzwtV2EtIlDPsx63hb728=;
        b=O1lxu3YMsqY72JvcVoDMbYb5akbDq/PebPWIogxsUzIRt0OYp0Tlf2DqizuyuhNyp2
         EtVA7W9J/Rg/N98a+sGWVQy5eJb4yF5eSPbzGuL+SqockElkalqv7XOM/R532+QobqEE
         IhLd6kz2boVvQAwzb5pfF+NjjTQQPpNKEUqdWthXnkDUoYEbzxo3MspVExXH3VtvG3jx
         K1h0LmtAvq3zCTPnk9U7vpwaQUDs+jDeh5YVS32ab5ui3ZS9IW/wF2XNnVsr48Fuw3yq
         uI2RgLKSe0Y9OtF8qtfdv3H+0zch4WmtMe8GVoKZ+17OCMWskO9VYIrRKEjnkrYS78lE
         6QKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=2Arm22YPpQPTnc0YJ8BaJwMzwtV2EtIlDPsx63hb728=;
        b=hukniOJ8TkV0PI2pw7I0RIf915rit9ZJJCdvNzAO4zComldKQ7xD17ivvD5NEXuh+Y
         HQjw92FPYHDkgWzeFDFOpihoarcVptl7n/3eRfpuTRHycw6niIf8n1GmBwCB+g6LbUUU
         iBuO6+jc1vJn+osY7cDfsf19tnAmwKG1aXmY5FP4j4+euSqLCToTC98ypJdIh1f0s0oG
         LBbZPH3NsrdiZsj8Yf9ZZjM9VadnOXC/bGVqNVoGVdilns2ESMAqCQg54pff5Tzo8xBu
         NP6dazcuvus13pjGq6iE3PosnROZ83BAqn9CqRETsD0egGTo9T9bJCV3usEWwla4RTPB
         fcaw==
X-Gm-Message-State: AOAM531tk+HEV5uvSW6IBCEsFD/WLztP/JF/ZnNf/UtGuoTEVF+wmBBu
        d9MeHumOzddjhCTx6pvknn4=
X-Google-Smtp-Source: ABdhPJwLtg6CjGzWJ2IbfDB8C73VqrOS+W/OuDKxl+OvLSM9ZGiJAy5eHjoAZR9HjxhwWXnCN05ylA==
X-Received: by 2002:a17:907:7246:b0:6ff:241f:200a with SMTP id ds6-20020a170907724600b006ff241f200amr36818504ejc.543.1654796705453;
        Thu, 09 Jun 2022 10:45:05 -0700 (PDT)
Received: from localhost (92.40.202.101.threembb.co.uk. [92.40.202.101])
        by smtp.gmail.com with ESMTPSA id g11-20020a17090669cb00b006fec1a73e48sm11041707ejs.64.2022.06.09.10.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 10:45:04 -0700 (PDT)
References: <20220607110525.36922-1-aidanmacdonald.0x0@gmail.com>
 <TC84DR.BXHQAW8NSA8H@crapouillou.net>
 <OUo8utshKyFB2wcmtEAH6jswJGetDRWg@localhost>
 <8TF7DR.ISCIMDT0UMMA@crapouillou.net>
 <1458d1b8982aa5a84680ebeb869f1c78@kernel.org>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>, linus.walleij@linaro.org,
        linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: ingenic: Convert to immutable irq chip
Date:   Thu, 09 Jun 2022 18:45:21 +0100
In-reply-to: <1458d1b8982aa5a84680ebeb869f1c78@kernel.org>
Message-ID: <qC9qbkh9nIk636ODaGapST9Je7Nb4JUB@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Marc Zyngier <maz@kernel.org> writes:

> On 2022-06-09 11:00, Paul Cercueil wrote:
>> Hi Aidan,
>> Le mar., juin 7 2022 at 17:47:19 +0100, Aidan MacDonald
>> <aidanmacdonald.0x0@gmail.com> a =C3=A9crit :
>>> Paul Cercueil <paul@crapouillou.net> writes:
>>>=20
>>>>  Hi Aidan,
>>>>  Le mar., juin 7 2022 at 12:05:25 +0100, Aidan MacDonald
>>>>  <aidanmacdonald.0x0@gmail.com> a =C3=A9crit :
>>>>>  Update the driver to use an immutable IRQ chip to fix this warning:
>>>>>      "not an immutable chip, please consider fixing it!"
>>>>>  Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>>>>>  ---
>>>>>   drivers/pinctrl/pinctrl-ingenic.c | 33 ++++++++++++++++++----------=
---
>>>>>   1 file changed, 19 insertions(+), 14 deletions(-)
>>>>>  diff --git a/drivers/pinctrl/pinctrl-ingenic.c
>>>>>  b/drivers/pinctrl/pinctrl-ingenic.c
>>>>>  index 1ca11616db74..37258fb05be3 100644
>>>>>  --- a/drivers/pinctrl/pinctrl-ingenic.c
>>>>>  +++ b/drivers/pinctrl/pinctrl-ingenic.c
>>>>>  @@ -135,7 +135,6 @@ struct ingenic_pinctrl {
>>>>>   struct ingenic_gpio_chip {
>>>>>   	struct ingenic_pinctrl *jzpc;
>>>>>   	struct gpio_chip gc;
>>>>>  -	struct irq_chip irq_chip;
>>>>>   	unsigned int irq, reg_base;
>>>>>   };
>>>>>  @@ -3419,6 +3418,8 @@ static void ingenic_gpio_irq_enable(struct irq=
_data
>>>>>  *irqd)
>>>>>   	struct ingenic_gpio_chip *jzgc =3D gpiochip_get_data(gc);
>>>>>   	int irq =3D irqd->hwirq;
>>>>>  +	gpiochip_enable_irq(gc, irq);
>>>>>  +
>>>>>   	if (is_soc_or_above(jzgc->jzpc, ID_JZ4770))
>>>>>   		ingenic_gpio_set_bit(jzgc, JZ4770_GPIO_INT, irq, true);
>>>>>   	else if (is_soc_or_above(jzgc->jzpc, ID_JZ4740))
>>>>>  @@ -3443,6 +3444,8 @@ static void ingenic_gpio_irq_disable(struct
>>>>> irq_data
>>>>>  *irqd)
>>>>>   		ingenic_gpio_set_bit(jzgc, JZ4740_GPIO_SELECT, irq, false);
>>>>>   	else
>>>>>   		ingenic_gpio_set_bit(jzgc, JZ4730_GPIO_GPIER, irq, false);
>>>>>  +
>>>>>  +	gpiochip_disable_irq(gc, irq);
>>>>>   }
>>>>>   static void ingenic_gpio_irq_ack(struct irq_data *irqd)
>>>>>  @@ -3684,6 +3687,20 @@ static void ingenic_gpio_irq_release(struct
>>>>> irq_data
>>>>>  *data)
>>>>>   	return gpiochip_relres_irq(gpio_chip, data->hwirq);
>>>>>   }
>>>>>  +static const struct irq_chip ingenic_gpio_irqchip =3D {
>>>>>  +	.name			=3D "gpio",
>>>>>  +	.irq_enable		=3D ingenic_gpio_irq_enable,
>>>>>  +	.irq_disable		=3D ingenic_gpio_irq_disable,
>>>>>  +	.irq_unmask		=3D ingenic_gpio_irq_unmask,
>>>>>  +	.irq_mask		=3D ingenic_gpio_irq_mask,
>>>>>  +	.irq_ack		=3D ingenic_gpio_irq_ack,
>>>>>  +	.irq_set_type		=3D ingenic_gpio_irq_set_type,
>>>>>  +	.irq_set_wake		=3D ingenic_gpio_irq_set_wake,
>>>>>  +	.irq_request_resources	=3D ingenic_gpio_irq_request,
>>>>>  +	.irq_release_resources	=3D ingenic_gpio_irq_release,
>>>>>  +	.flags			=3D IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
>>>>>  +};
>>>>>  +
>>>>>   static int ingenic_pinmux_set_pin_fn(struct ingenic_pinctrl *jzpc,
>>>>>   		int pin, int func)
>>>>>   {
>>>>>  @@ -4172,20 +4189,8 @@ static int __init ingenic_gpio_probe(struct
>>>>>  ingenic_pinctrl *jzpc,
>>>>>   	if (!jzgc->irq)
>>>>>   		return -EINVAL;
>>>>>  -	jzgc->irq_chip.name =3D jzgc->gc.label;
>>>>>  -	jzgc->irq_chip.irq_enable =3D ingenic_gpio_irq_enable;
>>>>>  -	jzgc->irq_chip.irq_disable =3D ingenic_gpio_irq_disable;
>>>>>  -	jzgc->irq_chip.irq_unmask =3D ingenic_gpio_irq_unmask;
>>>>>  -	jzgc->irq_chip.irq_mask =3D ingenic_gpio_irq_mask;
>>>>>  -	jzgc->irq_chip.irq_ack =3D ingenic_gpio_irq_ack;
>>>>>  -	jzgc->irq_chip.irq_set_type =3D ingenic_gpio_irq_set_type;
>>>>>  -	jzgc->irq_chip.irq_set_wake =3D ingenic_gpio_irq_set_wake;
>>>>>  -	jzgc->irq_chip.irq_request_resources =3D ingenic_gpio_irq_request;
>>>>>  -	jzgc->irq_chip.irq_release_resources =3D ingenic_gpio_irq_release;
>>>>>  -	jzgc->irq_chip.flags =3D IRQCHIP_MASK_ON_SUSPEND;
>>>>>  -
>>>>>   	girq =3D &jzgc->gc.irq;
>>>>>  -	girq->chip =3D &jzgc->irq_chip;
>>>>>  +	gpio_irq_chip_set_chip(girq, &ingenic_gpio_irqchip);
>>>>  This will change each irq_chip's name to "gpio", do we want that?
>>>>  You didn't remove jzgc->irq_chip, so maybe what you could do is
>>>>  jzgc->irq_chip =3D ingenic_gpio_irqchip;
>>>>  jzgc->irq_chip.name =3D jzgc->gc.label;
>>>>  gpio_irq_chip_set_chip(girq, &jzgc->irq_chip);
>>>>  Thoughts?
>>>>  Cheers,
>>>>  -Paul
>>>>=20
>>> I wondered that myself, but it doesn't seem to affect anything except
>>> what is displayed in /proc/interrupts. Is the name used anywhere else
>>> where it might cause confusion?
>> I don't really know. If it only really affects the display in
>> /proc/interrupts then I'm fine with it. In doubt, I'd prefer to keep
>> the existing names.
>>=20
>>> The only similar case I could find was pinctrl-microchip-sgpio.c where
>>> microchip_sgpio_register_bank() is called in a loop and registers the
>>> same irq chip repeatedly, so it's probably(?) okay to do this here. It
>>> seems to defeat the point of immutable irqchips if they just have to be
>>> copied anyway...
>> The point of immutable irqchips is that they aren't modified by the
>> core, if I understand it correctly. Immutable doesn't mean it has to
>> be static const.
>
> I want these to be made const. I agree that the fancy string should
> be kept (sadly), as it is a userspace visible change, and we don't
> do that.
>
> You can solve it using the irq_print_chip() callback as part of
> your irq_chip structures. See 3344265a2692 for an example.
>
> Thanks,
>
>         M.

Thanks for the tip! I'll do that and send a v2.
