Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673A25668E8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbiGELIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiGELIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:08:24 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23704B8F;
        Tue,  5 Jul 2022 04:08:21 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r14so11243305wrg.1;
        Tue, 05 Jul 2022 04:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=rGy19FOb3651PZBhMiKsi+mYXIqLyLsJIOOT5/FayXM=;
        b=UNLzgpKPch+ns5dVbll7mhlTZcqr82OMlInIDOoCidkLtUTaZOf8/s0rso2o9wVPwN
         1JnUzPFFR0N7Aa6LB+n0D+Is9iwVgZ+7BBbDAsdhO7thw+vWD1Z6Z10UYirhvX1HI+wY
         zazp6/DppRHrmlE0hrFGgNt86cUtIikxYXdx3Z6gfJ1nH0+jNMcvt/BoLBIDORCG7stS
         n3ZQ7yo5nRZhEKWcnxbnNAZ09gS12GxgV7kNtjtoYOzOylVqiRyWZ2QDIHLledmIgjAY
         YjroEUF+h3ovwsTcmVteuNRXA96SCQAwdjXjSx+opZals5iEq+FyjtGU+WqX7Qm+LLhz
         5LVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=rGy19FOb3651PZBhMiKsi+mYXIqLyLsJIOOT5/FayXM=;
        b=OEsEmZEwu7DilnTGCWXpOy5iRjcHCgpwPwkaXiljGKXuC34apQ2QNxcs0qGh+RdO/W
         gykhxgHhm39AFYgNzKhxKyrkqcXZF2YF/m2KY1/9ufiaPoyVqGJLHsPoxgaBcPSHtEhI
         WrwDreXyLbOg798yRXcuNsq7qxicVS9jyZZrvjb0c+EX2Ird6HdJ3BinkB/OCZV5WmD2
         0Irft9ceRs5RKl6Rz2NoSNnPjU/Ks64XZBPCSMaGE7nZMY2yHUQP1hVjWYDF1AHGHEeI
         PSzIRlYqsJQCngfvAV+xF2iV7xC6GJwdXdM5YfoYJx9GOGRFql8atpLKolTaBy9EGuE+
         WqgA==
X-Gm-Message-State: AJIora/h8Q6wm1SQ9GRw3qpNDLYAQX9GJn+3olo3mM7SKpL0JICcFirQ
        AqkmPC4vENLZQxn1FFRumlmW4cEVCuo=
X-Google-Smtp-Source: AGRyM1vUBXmNptlwCc+RXJFUGSEoPrN81LdeONOmYqvrpw9l7WSz2W4/W9TPlvskKH7ZHuU7pv+s+A==
X-Received: by 2002:a5d:6483:0:b0:21b:c708:ba3e with SMTP id o3-20020a5d6483000000b0021bc708ba3emr33705212wri.597.1657019300444;
        Tue, 05 Jul 2022 04:08:20 -0700 (PDT)
Received: from localhost (92.40.203.24.threembb.co.uk. [92.40.203.24])
        by smtp.gmail.com with ESMTPSA id ay26-20020a5d6f1a000000b0021baf5e590dsm32671527wrb.71.2022.07.05.04.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 04:08:20 -0700 (PDT)
References: <20220703111057.23246-1-aidanmacdonald.0x0@gmail.com>
 <20220703111057.23246-4-aidanmacdonald.0x0@gmail.com>
 <CACRpkdamknwRPGEeGGQGQPtKw=dPXa79GAJy+E6y+03NakN=cA@mail.gmail.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     michael@walle.cc, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] gpio: regmap: Support a custom ->to_irq() hook
In-reply-to: <CACRpkdamknwRPGEeGGQGQPtKw=dPXa79GAJy+E6y+03NakN=cA@mail.gmail.com>
Date:   Tue, 05 Jul 2022 12:09:28 +0100
Message-ID: <GrX3yDSwNOGIBcWmKqusaJ3dDqNGLr3Y@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Walleij <linus.walleij@linaro.org> writes:

> On Sun, Jul 3, 2022 at 1:10 PM Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> wrote:
>
>> Some GPIO chips require a custom to_irq() callback for mapping
>> their IRQs, eg. because their interrupts come from a parent IRQ
>> chip where the GPIO offset doesn't map 1-to-1 with hwirq number.
>>
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>
> What is the usecase for this?

This is a generic GPIO chip; so I guess any use case for ->to_irq()?

> Since GPIO chips and IRQ chips are orthogonal there is absolutely
> no guarantee that ->to_irq() is called before a driver start to use
> an IRQ from the irqchip side:
>
> (quoting Documentation/driver-api/gpio/driver.rst)
>
>  It is legal for any IRQ consumer to request an IRQ from any irqchip even if it
>  is a combined GPIO+IRQ driver. The basic premise is that gpio_chip and
>  irq_chip are orthogonal, and offering their services independent of each
>  other.
>
>  gpiod_to_irq() is just a convenience function to figure out the IRQ for a
>  certain GPIO line and should not be relied upon to have been called before
>  the IRQ is used.
>
>  Always prepare the hardware and make it ready for action in respective
>  callbacks from the GPIO and irq_chip APIs. Do not rely on gpiod_to_irq() having
>  been called first.
>
> (end quote)

That's fine, and I don't require ->to_irq() to be called. The IRQ chip
in my case is provided by an MFD driver (axp20x to be specific) and it
*does* work orthogonally to the GPIO driver -- the GPIO driver neither
knows nor cares about the IRQ chip.

> Using ->to_irq() makes sense in a few cases such as when
> a GPIO key that can also poll for state want to get hold of an
> IRQ to react to edges.

This is my use case; specifically, GPIO keys and ASoC jack detection.

> Now: if a consumer requests IRQ nr 3 from your driver say from ACPI or
> from a device tree, and as you say GPIOs and IRQs are not 1-to-1 mapped,
> so IRQ nr 3 may be coming from GPIO 314, isn't this going to be really
> messy for users? One local numberspace for GPIO and another local
> numberspace for IRQs?

Well, this is how MFD drivers with GPIO functionality often work, they
aren't creating a special IRQ sub-domain for GPIOs and it doesn't seem
to be a problem there. Most likely because those MFD devices are being
used for GPIO keys or something similar.

Referring to the interrupt directly would make sense if the GPIO was
wired to another chip's IRQ line, but that is unlikely to be the case
for MFD devices because they're behind a slow bus.

> To me it seems like the reasoning is something like
>
> - I only use GPIO line numbers like <&gpio 3>;
> - Then I call gpiod_to_irq() on that number so I do not need to
>   deal with looking up the IRQ some other way
> - request_irq();
> - Profit.
>

Yeah, that's accurate for my use case.

> There is no guarantee that the API will be used like that at all, actually
> it is uncommon.
>
> Yours,
> Linus Walleij

I'm not trying to argue that hierarchical IRQ domains are always a bad
thing -- I'm just pointing out they're not always useful or necessary.
All your points make sense when the GPIO controller is a large distinct
block with potentially many GPIOs. When we're dealing with an MFD device
with just a few GPIOs, maybe even just one, having a separate IRQ domain
makes less sense; the added structure is generally not useful.

Looking at other GPIO drivers using a hierarchical IRQ domain, they
include their own IRQ chips with specialized ops. In my case I don't
need any of that (and it'd be the same with other MFD devices) so it
looks like using an IRQ domain would mean I'd have to create a fake
IRQ chip and domain just to translate between two number spaces.

Is that really better than simply using ->to_irq()?

Regards,
Aidan
