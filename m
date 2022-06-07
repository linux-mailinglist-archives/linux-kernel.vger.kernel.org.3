Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BBF540439
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 19:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345322AbiFGRAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 13:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345363AbiFGRAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:00:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0849F338F;
        Tue,  7 Jun 2022 10:00:03 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bg6so16635489ejb.0;
        Tue, 07 Jun 2022 10:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version:content-transfer-encoding;
        bh=S4VNfIke2KvnIJMRH6f3rNuBXi/ZA3zV6uDJeQjXmuM=;
        b=XoRM00N+6Fems+DaFXMoRxUfOYcdFfCtH6mFIARABY5BhA6F4rfx2mkxwv01maf96k
         nTl5lEKoT2wjKMQFXlaUaCF4OGeNAV8zWFfdYk7Q5emAi3v1LD6anMPP/WNhi/5vM0At
         FT1uPMLYhi8eiavZAe3FPEQstjLibpvEI+G5RMdP29SW+viUozVjvl5n2XY5aJYAdCUd
         EwCDv6xfyA1l/kqo07ZZ6k3Yp5VmbgNtxjUJamVowAapQc5rS8QfZ7lZblRnnt2UJeRR
         UNgdyOPV2wVDKRWU0VXGK9OMCe1tM2oCh8SRIMjvEOM6SV0AcJJxVn4zaGMX9SbQM70T
         wM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=S4VNfIke2KvnIJMRH6f3rNuBXi/ZA3zV6uDJeQjXmuM=;
        b=T9oAYbSY3HpF3HQQznDwRuFpc/LofI4HCXPhIPWnTy09g4a4lZlC00lJuiiZlqpbt/
         C/pq6QqmYaV3qu4OPcXFzR+X5w+1hkb9RNjQtLMlJ7P0D+d+pSgse9Fsf9zb45PBtWY5
         TMA1rUQqoid6YFPFrclJNJGTGuZ0eM6vg0WkgObp4Iu+6u8sT+PGbiw9FiqUK2vI2rRv
         MkmlKURiZECuaarNw+K6PQzJEpOBq7ris+XyFrS02jpaZfaNJS5KA5J/43QG9iRpguSj
         lC8zPUcg/LkhWwX3YxDC18MTw1XCp3NFwLyrMN93CmDRWkQyKO0UK9mLBc4j/MoVfgxZ
         4Fyw==
X-Gm-Message-State: AOAM533f5ibeADo5I9Ktn8koyrnJYnJsFhn69t+EgWF8QUpwTMA69W6h
        1r6Z87WbpUjdndzY0Kyha4c=
X-Google-Smtp-Source: ABdhPJzltR9FAeMw59VT6yBMmW6WR18FUMvbw6FRycDCDKYttTuT7QrLC7JP8zVaXstbu0hJmuZIFQ==
X-Received: by 2002:a17:906:54c3:b0:6ef:d07b:c8ec with SMTP id c3-20020a17090654c300b006efd07bc8ecmr27443327ejp.687.1654621202058;
        Tue, 07 Jun 2022 10:00:02 -0700 (PDT)
Received: from localhost (92.40.203.36.threembb.co.uk. [92.40.203.36])
        by smtp.gmail.com with ESMTPSA id gi5-20020a1709070c8500b006feb8cebbbfsm7904125ejc.6.2022.06.07.10.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 10:00:01 -0700 (PDT)
References: <20220607110525.36922-1-aidanmacdonald.0x0@gmail.com>
 <TC84DR.BXHQAW8NSA8H@crapouillou.net>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     linus.walleij@linaro.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: ingenic: Convert to immutable irq chip
Date:   Tue, 07 Jun 2022 17:47:19 +0100
In-reply-to: <TC84DR.BXHQAW8NSA8H@crapouillou.net>
Message-ID: <OUo8utshKyFB2wcmtEAH6jswJGetDRWg@localhost>
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


Paul Cercueil <paul@crapouillou.net> writes:

> Hi Aidan,
>
> Le mar., juin 7 2022 at 12:05:25 +0100, Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> a =C3=A9crit :
>> Update the driver to use an immutable IRQ chip to fix this warning:
>>     "not an immutable chip, please consider fixing it!"
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> ---
>>  drivers/pinctrl/pinctrl-ingenic.c | 33 ++++++++++++++++++-------------
>>  1 file changed, 19 insertions(+), 14 deletions(-)
>> diff --git a/drivers/pinctrl/pinctrl-ingenic.c
>> b/drivers/pinctrl/pinctrl-ingenic.c
>> index 1ca11616db74..37258fb05be3 100644
>> --- a/drivers/pinctrl/pinctrl-ingenic.c
>> +++ b/drivers/pinctrl/pinctrl-ingenic.c
>> @@ -135,7 +135,6 @@ struct ingenic_pinctrl {
>>  struct ingenic_gpio_chip {
>>  	struct ingenic_pinctrl *jzpc;
>>  	struct gpio_chip gc;
>> -	struct irq_chip irq_chip;
>>  	unsigned int irq, reg_base;
>>  };
>> @@ -3419,6 +3418,8 @@ static void ingenic_gpio_irq_enable(struct irq_data
>> *irqd)
>>  	struct ingenic_gpio_chip *jzgc =3D gpiochip_get_data(gc);
>>  	int irq =3D irqd->hwirq;
>> +	gpiochip_enable_irq(gc, irq);
>> +
>>  	if (is_soc_or_above(jzgc->jzpc, ID_JZ4770))
>>  		ingenic_gpio_set_bit(jzgc, JZ4770_GPIO_INT, irq, true);
>>  	else if (is_soc_or_above(jzgc->jzpc, ID_JZ4740))
>> @@ -3443,6 +3444,8 @@ static void ingenic_gpio_irq_disable(struct irq_da=
ta
>> *irqd)
>>  		ingenic_gpio_set_bit(jzgc, JZ4740_GPIO_SELECT, irq, false);
>>  	else
>>  		ingenic_gpio_set_bit(jzgc, JZ4730_GPIO_GPIER, irq, false);
>> +
>> +	gpiochip_disable_irq(gc, irq);
>>  }
>>  static void ingenic_gpio_irq_ack(struct irq_data *irqd)
>> @@ -3684,6 +3687,20 @@ static void ingenic_gpio_irq_release(struct irq_d=
ata
>> *data)
>>  	return gpiochip_relres_irq(gpio_chip, data->hwirq);
>>  }
>> +static const struct irq_chip ingenic_gpio_irqchip =3D {
>> +	.name			=3D "gpio",
>> +	.irq_enable		=3D ingenic_gpio_irq_enable,
>> +	.irq_disable		=3D ingenic_gpio_irq_disable,
>> +	.irq_unmask		=3D ingenic_gpio_irq_unmask,
>> +	.irq_mask		=3D ingenic_gpio_irq_mask,
>> +	.irq_ack		=3D ingenic_gpio_irq_ack,
>> +	.irq_set_type		=3D ingenic_gpio_irq_set_type,
>> +	.irq_set_wake		=3D ingenic_gpio_irq_set_wake,
>> +	.irq_request_resources	=3D ingenic_gpio_irq_request,
>> +	.irq_release_resources	=3D ingenic_gpio_irq_release,
>> +	.flags			=3D IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
>> +};
>> +
>>  static int ingenic_pinmux_set_pin_fn(struct ingenic_pinctrl *jzpc,
>>  		int pin, int func)
>>  {
>> @@ -4172,20 +4189,8 @@ static int __init ingenic_gpio_probe(struct
>> ingenic_pinctrl *jzpc,
>>  	if (!jzgc->irq)
>>  		return -EINVAL;
>> -	jzgc->irq_chip.name =3D jzgc->gc.label;
>> -	jzgc->irq_chip.irq_enable =3D ingenic_gpio_irq_enable;
>> -	jzgc->irq_chip.irq_disable =3D ingenic_gpio_irq_disable;
>> -	jzgc->irq_chip.irq_unmask =3D ingenic_gpio_irq_unmask;
>> -	jzgc->irq_chip.irq_mask =3D ingenic_gpio_irq_mask;
>> -	jzgc->irq_chip.irq_ack =3D ingenic_gpio_irq_ack;
>> -	jzgc->irq_chip.irq_set_type =3D ingenic_gpio_irq_set_type;
>> -	jzgc->irq_chip.irq_set_wake =3D ingenic_gpio_irq_set_wake;
>> -	jzgc->irq_chip.irq_request_resources =3D ingenic_gpio_irq_request;
>> -	jzgc->irq_chip.irq_release_resources =3D ingenic_gpio_irq_release;
>> -	jzgc->irq_chip.flags =3D IRQCHIP_MASK_ON_SUSPEND;
>> -
>>  	girq =3D &jzgc->gc.irq;
>> -	girq->chip =3D &jzgc->irq_chip;
>> +	gpio_irq_chip_set_chip(girq, &ingenic_gpio_irqchip);
>
> This will change each irq_chip's name to "gpio", do we want that?
>
> You didn't remove jzgc->irq_chip, so maybe what you could do is
> jzgc->irq_chip =3D ingenic_gpio_irqchip;
> jzgc->irq_chip.name =3D jzgc->gc.label;
> gpio_irq_chip_set_chip(girq, &jzgc->irq_chip);
>
> Thoughts?
>
> Cheers,
> -Paul
>

I wondered that myself, but it doesn't seem to affect anything except
what is displayed in /proc/interrupts. Is the name used anywhere else
where it might cause confusion?

The only similar case I could find was pinctrl-microchip-sgpio.c where
microchip_sgpio_register_bank() is called in a loop and registers the
same irq chip repeatedly, so it's probably(?) okay to do this here. It
seems to defeat the point of immutable irqchips if they just have to be
copied anyway...

(btw, I did remove jzgc->irq_chip -- or did I miss something?)

Best regards,
Aidan

>>  	girq->parent_handler =3D ingenic_gpio_irq_handler;
>>  	girq->num_parents =3D 1;
>>  	girq->parents =3D devm_kcalloc(dev, 1, sizeof(*girq->parents),
>> --
>> 2.35.1
>>=20

