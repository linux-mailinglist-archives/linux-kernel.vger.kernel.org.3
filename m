Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6087E544B53
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245148AbiFIMJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245138AbiFIMJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:09:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3D81A35AB;
        Thu,  9 Jun 2022 05:08:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10B86B82D48;
        Thu,  9 Jun 2022 12:08:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4525C34114;
        Thu,  9 Jun 2022 12:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654776536;
        bh=ypEXZgOGtbeVdSRZ+vnYi+6VBYMjadfufmnpungoAuE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jNNAxRvuFlRfEfbO4iMWoqvaiTNwJfhh2Q0+gWJCXKX3kosJktS8FlOaYAtzifbd3
         lWm1OaWIE9Z0kCvrrQMi+poizIxOB0kS/7UV5w3+bR9ulSp39B+7NOYgnqiv1eohDR
         1BgvzxLsCyWaWp7HI/sBLPHoltvr20zCmTAwkYbKmWQIueVdSMJ0mGN8jokab2ikUk
         ApeZPeIZBOEL9xdquo/hSqBI31xbUyM9+YHnvvivF5vuQn0tKw19QrIn5YaofjW/qe
         FMIufN+TrgvQ708Yn3JN+8frzvY1sSPzenXmKU3EMGgkHSWjw1Xopd/eeHoqnygztt
         gdpaJdoBsDt1g==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nzGy6-00GrUB-7z; Thu, 09 Jun 2022 13:08:54 +0100
MIME-Version: 1.0
Date:   Thu, 09 Jun 2022 13:08:53 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linus.walleij@linaro.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: ingenic: Convert to immutable irq chip
In-Reply-To: <8TF7DR.ISCIMDT0UMMA@crapouillou.net>
References: <20220607110525.36922-1-aidanmacdonald.0x0@gmail.com>
 <TC84DR.BXHQAW8NSA8H@crapouillou.net>
 <OUo8utshKyFB2wcmtEAH6jswJGetDRWg@localhost>
 <8TF7DR.ISCIMDT0UMMA@crapouillou.net>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <1458d1b8982aa5a84680ebeb869f1c78@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: paul@crapouillou.net, aidanmacdonald.0x0@gmail.com, linus.walleij@linaro.org, linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-09 11:00, Paul Cercueil wrote:
> Hi Aidan,
> 
> Le mar., juin 7 2022 at 17:47:19 +0100, Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> a écrit :
>> 
>> Paul Cercueil <paul@crapouillou.net> writes:
>> 
>>>  Hi Aidan,
>>> 
>>>  Le mar., juin 7 2022 at 12:05:25 +0100, Aidan MacDonald
>>>  <aidanmacdonald.0x0@gmail.com> a écrit :
>>>>  Update the driver to use an immutable IRQ chip to fix this warning:
>>>>      "not an immutable chip, please consider fixing it!"
>>>>  Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>>>>  ---
>>>>   drivers/pinctrl/pinctrl-ingenic.c | 33 
>>>> ++++++++++++++++++-------------
>>>>   1 file changed, 19 insertions(+), 14 deletions(-)
>>>>  diff --git a/drivers/pinctrl/pinctrl-ingenic.c
>>>>  b/drivers/pinctrl/pinctrl-ingenic.c
>>>>  index 1ca11616db74..37258fb05be3 100644
>>>>  --- a/drivers/pinctrl/pinctrl-ingenic.c
>>>>  +++ b/drivers/pinctrl/pinctrl-ingenic.c
>>>>  @@ -135,7 +135,6 @@ struct ingenic_pinctrl {
>>>>   struct ingenic_gpio_chip {
>>>>   	struct ingenic_pinctrl *jzpc;
>>>>   	struct gpio_chip gc;
>>>>  -	struct irq_chip irq_chip;
>>>>   	unsigned int irq, reg_base;
>>>>   };
>>>>  @@ -3419,6 +3418,8 @@ static void ingenic_gpio_irq_enable(struct 
>>>> irq_data
>>>>  *irqd)
>>>>   	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
>>>>   	int irq = irqd->hwirq;
>>>>  +	gpiochip_enable_irq(gc, irq);
>>>>  +
>>>>   	if (is_soc_or_above(jzgc->jzpc, ID_JZ4770))
>>>>   		ingenic_gpio_set_bit(jzgc, JZ4770_GPIO_INT, irq, true);
>>>>   	else if (is_soc_or_above(jzgc->jzpc, ID_JZ4740))
>>>>  @@ -3443,6 +3444,8 @@ static void ingenic_gpio_irq_disable(struct 
>>>> irq_data
>>>>  *irqd)
>>>>   		ingenic_gpio_set_bit(jzgc, JZ4740_GPIO_SELECT, irq, false);
>>>>   	else
>>>>   		ingenic_gpio_set_bit(jzgc, JZ4730_GPIO_GPIER, irq, false);
>>>>  +
>>>>  +	gpiochip_disable_irq(gc, irq);
>>>>   }
>>>>   static void ingenic_gpio_irq_ack(struct irq_data *irqd)
>>>>  @@ -3684,6 +3687,20 @@ static void ingenic_gpio_irq_release(struct 
>>>> irq_data
>>>>  *data)
>>>>   	return gpiochip_relres_irq(gpio_chip, data->hwirq);
>>>>   }
>>>>  +static const struct irq_chip ingenic_gpio_irqchip = {
>>>>  +	.name			= "gpio",
>>>>  +	.irq_enable		= ingenic_gpio_irq_enable,
>>>>  +	.irq_disable		= ingenic_gpio_irq_disable,
>>>>  +	.irq_unmask		= ingenic_gpio_irq_unmask,
>>>>  +	.irq_mask		= ingenic_gpio_irq_mask,
>>>>  +	.irq_ack		= ingenic_gpio_irq_ack,
>>>>  +	.irq_set_type		= ingenic_gpio_irq_set_type,
>>>>  +	.irq_set_wake		= ingenic_gpio_irq_set_wake,
>>>>  +	.irq_request_resources	= ingenic_gpio_irq_request,
>>>>  +	.irq_release_resources	= ingenic_gpio_irq_release,
>>>>  +	.flags			= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
>>>>  +};
>>>>  +
>>>>   static int ingenic_pinmux_set_pin_fn(struct ingenic_pinctrl *jzpc,
>>>>   		int pin, int func)
>>>>   {
>>>>  @@ -4172,20 +4189,8 @@ static int __init ingenic_gpio_probe(struct
>>>>  ingenic_pinctrl *jzpc,
>>>>   	if (!jzgc->irq)
>>>>   		return -EINVAL;
>>>>  -	jzgc->irq_chip.name = jzgc->gc.label;
>>>>  -	jzgc->irq_chip.irq_enable = ingenic_gpio_irq_enable;
>>>>  -	jzgc->irq_chip.irq_disable = ingenic_gpio_irq_disable;
>>>>  -	jzgc->irq_chip.irq_unmask = ingenic_gpio_irq_unmask;
>>>>  -	jzgc->irq_chip.irq_mask = ingenic_gpio_irq_mask;
>>>>  -	jzgc->irq_chip.irq_ack = ingenic_gpio_irq_ack;
>>>>  -	jzgc->irq_chip.irq_set_type = ingenic_gpio_irq_set_type;
>>>>  -	jzgc->irq_chip.irq_set_wake = ingenic_gpio_irq_set_wake;
>>>>  -	jzgc->irq_chip.irq_request_resources = ingenic_gpio_irq_request;
>>>>  -	jzgc->irq_chip.irq_release_resources = ingenic_gpio_irq_release;
>>>>  -	jzgc->irq_chip.flags = IRQCHIP_MASK_ON_SUSPEND;
>>>>  -
>>>>   	girq = &jzgc->gc.irq;
>>>>  -	girq->chip = &jzgc->irq_chip;
>>>>  +	gpio_irq_chip_set_chip(girq, &ingenic_gpio_irqchip);
>>> 
>>>  This will change each irq_chip's name to "gpio", do we want that?
>>> 
>>>  You didn't remove jzgc->irq_chip, so maybe what you could do is
>>>  jzgc->irq_chip = ingenic_gpio_irqchip;
>>>  jzgc->irq_chip.name = jzgc->gc.label;
>>>  gpio_irq_chip_set_chip(girq, &jzgc->irq_chip);
>>> 
>>>  Thoughts?
>>> 
>>>  Cheers,
>>>  -Paul
>>> 
>> 
>> I wondered that myself, but it doesn't seem to affect anything except
>> what is displayed in /proc/interrupts. Is the name used anywhere else
>> where it might cause confusion?
> 
> I don't really know. If it only really affects the display in
> /proc/interrupts then I'm fine with it. In doubt, I'd prefer to keep
> the existing names.
> 
>> The only similar case I could find was pinctrl-microchip-sgpio.c where
>> microchip_sgpio_register_bank() is called in a loop and registers the
>> same irq chip repeatedly, so it's probably(?) okay to do this here. It
>> seems to defeat the point of immutable irqchips if they just have to 
>> be
>> copied anyway...
> 
> The point of immutable irqchips is that they aren't modified by the
> core, if I understand it correctly. Immutable doesn't mean it has to
> be static const.

I want these to be made const. I agree that the fancy string should
be kept (sadly), as it is a userspace visible change, and we don't
do that.

You can solve it using the irq_print_chip() callback as part of
your irq_chip structures. See 3344265a2692 for an example.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
