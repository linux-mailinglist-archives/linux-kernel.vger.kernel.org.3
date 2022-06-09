Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B114E544C3D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245536AbiFIMgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245521AbiFIMgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:36:38 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4031DE8;
        Thu,  9 Jun 2022 05:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1654778189; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DmkQrS2GZnU4WU6MdKYgfrBEToonLo9W7ELjbdd0gZY=;
        b=AyXyPKoytLKO8j56ZrycISKjWJ1+k28k/h1kldybb/7juL5l7D22CqimiLle+W2rpBZbrK
        KzzgTot68mJ2+msATvN6w3uZPICa2giw3HID0ryRQqwi+1xc7l/oGWe77C/FZZ3fq2cEre
        o6ZwobkGUPJLwFd+aQax/LVjiuGxdzY=
Date:   Thu, 09 Jun 2022 13:36:19 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] pinctrl: ingenic: Convert to immutable irq chip
To:     Marc Zyngier <maz@kernel.org>
Cc:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linus.walleij@linaro.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <J0N7DR.9XKBU8Q47U6Y2@crapouillou.net>
In-Reply-To: <1458d1b8982aa5a84680ebeb869f1c78@kernel.org>
References: <20220607110525.36922-1-aidanmacdonald.0x0@gmail.com>
        <TC84DR.BXHQAW8NSA8H@crapouillou.net>
        <OUo8utshKyFB2wcmtEAH6jswJGetDRWg@localhost>
        <8TF7DR.ISCIMDT0UMMA@crapouillou.net>
        <1458d1b8982aa5a84680ebeb869f1c78@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Le jeu., juin 9 2022 at 13:08:53 +0100, Marc Zyngier <maz@kernel.org> a=20
=E9crit :
> On 2022-06-09 11:00, Paul Cercueil wrote:
>> Hi Aidan,
>>=20
>> Le mar., juin 7 2022 at 17:47:19 +0100, Aidan MacDonald
>> <aidanmacdonald.0x0@gmail.com> a =E9crit :
>>>=20
>>> Paul Cercueil <paul@crapouillou.net> writes:
>>>=20
>>>>  Hi Aidan,
>>>>=20
>>>>  Le mar., juin 7 2022 at 12:05:25 +0100, Aidan MacDonald
>>>>  <aidanmacdonald.0x0@gmail.com> a =E9crit :
>>>>>  Update the driver to use an immutable IRQ chip to fix this=20
>>>>> warning:
>>>>>      "not an immutable chip, please consider fixing it!"
>>>>>  Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>>>>>  ---
>>>>>   drivers/pinctrl/pinctrl-ingenic.c | 33=20
>>>>> =7F=7F=7F=7F++++++++++++++++++-------------
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
>>>>>  @@ -3419,6 +3418,8 @@ static void ingenic_gpio_irq_enable(struct=20
>>>>> =7F=7F=7F=7Firq_data
>>>>>  *irqd)
>>>>>   	struct ingenic_gpio_chip *jzgc =3D gpiochip_get_data(gc);
>>>>>   	int irq =3D irqd->hwirq;
>>>>>  +	gpiochip_enable_irq(gc, irq);
>>>>>  +
>>>>>   	if (is_soc_or_above(jzgc->jzpc, ID_JZ4770))
>>>>>   		ingenic_gpio_set_bit(jzgc, JZ4770_GPIO_INT, irq, true);
>>>>>   	else if (is_soc_or_above(jzgc->jzpc, ID_JZ4740))
>>>>>  @@ -3443,6 +3444,8 @@ static void=20
>>>>> ingenic_gpio_irq_disable(struct =7F=7F=7F=7Firq_data
>>>>>  *irqd)
>>>>>   		ingenic_gpio_set_bit(jzgc, JZ4740_GPIO_SELECT, irq, false);
>>>>>   	else
>>>>>   		ingenic_gpio_set_bit(jzgc, JZ4730_GPIO_GPIER, irq, false);
>>>>>  +
>>>>>  +	gpiochip_disable_irq(gc, irq);
>>>>>   }
>>>>>   static void ingenic_gpio_irq_ack(struct irq_data *irqd)
>>>>>  @@ -3684,6 +3687,20 @@ static void=20
>>>>> ingenic_gpio_irq_release(struct =7F=7F=7F=7Firq_data
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
>>>>>   static int ingenic_pinmux_set_pin_fn(struct ingenic_pinctrl=20
>>>>> *jzpc,
>>>>>   		int pin, int func)
>>>>>   {
>>>>>  @@ -4172,20 +4189,8 @@ static int __init=20
>>>>> ingenic_gpio_probe(struct
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
>>>>>  -	jzgc->irq_chip.irq_request_resources =3D=20
>>>>> ingenic_gpio_irq_request;
>>>>>  -	jzgc->irq_chip.irq_release_resources =3D=20
>>>>> ingenic_gpio_irq_release;
>>>>>  -	jzgc->irq_chip.flags =3D IRQCHIP_MASK_ON_SUSPEND;
>>>>>  -
>>>>>   	girq =3D &jzgc->gc.irq;
>>>>>  -	girq->chip =3D &jzgc->irq_chip;
>>>>>  +	gpio_irq_chip_set_chip(girq, &ingenic_gpio_irqchip);
>>>>=20
>>>>  This will change each irq_chip's name to "gpio", do we want that?
>>>>=20
>>>>  You didn't remove jzgc->irq_chip, so maybe what you could do is
>>>>  jzgc->irq_chip =3D ingenic_gpio_irqchip;
>>>>  jzgc->irq_chip.name =3D jzgc->gc.label;
>>>>  gpio_irq_chip_set_chip(girq, &jzgc->irq_chip);
>>>>=20
>>>>  Thoughts?
>>>>=20
>>>>  Cheers,
>>>>  -Paul
>>>>=20
>>>=20
>>> I wondered that myself, but it doesn't seem to affect anything=20
>>> except
>>> what is displayed in /proc/interrupts. Is the name used anywhere=20
>>> else
>>> where it might cause confusion?
>>=20
>> I don't really know. If it only really affects the display in
>> /proc/interrupts then I'm fine with it. In doubt, I'd prefer to keep
>> the existing names.
>>=20
>>> The only similar case I could find was pinctrl-microchip-sgpio.c=20
>>> where
>>> microchip_sgpio_register_bank() is called in a loop and registers=20
>>> the
>>> same irq chip repeatedly, so it's probably(?) okay to do this here.=20
>>> It
>>> seems to defeat the point of immutable irqchips if they just have=20
>>> to =7F=7Fbe
>>> copied anyway...
>>=20
>> The point of immutable irqchips is that they aren't modified by the
>> core, if I understand it correctly. Immutable doesn't mean it has to
>> be static const.
>=20
> I want these to be made const. I agree that the fancy string should
> be kept (sadly), as it is a userspace visible change, and we don't
> do that.
>=20
> You can solve it using the irq_print_chip() callback as part of
> your irq_chip structures. See 3344265a2692 for an example.

Works for me.

Cheers,
-Paul


