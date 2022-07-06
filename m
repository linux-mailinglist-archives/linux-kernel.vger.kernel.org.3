Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC32568B16
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbiGFOVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiGFOVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:21:16 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6348C1FCDA;
        Wed,  6 Jul 2022 07:21:14 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id k30so11363902edk.8;
        Wed, 06 Jul 2022 07:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version;
        bh=3Wb+2NYdNYlT/r55W5Q9BfPi7qfSp7lu+o+6L0rJtv8=;
        b=gWJipTj+zP9LdoXW9ZZmPEOCzTlBkuyB0ff9epBmgDE/i75a/0ROab93UWiX68yi+7
         Yt1iVTbV0mmGIUPRsu7Iv5ZcPakBrVTGgNn3QbSAbJtpD1ll+9ETR4NC2zrYuD2Fnhr0
         3uqRa9NzLc3SPWQvYGtU92MRw784mM0wllnyz59w08XWzjpZjczcPBBFzQBfGl7lqBnO
         kAPfQ328Di9nQotQ680IHOoOE5XpcYZIGGB+pFBD4V5yok26buCnhT3XtXyauzJsZOcl
         ODNecWdJmbQGMgGDmfrBQHUim98ctmI2881WkJtNSMeuMS9vVtFx62bUPJeJme6xPEAJ
         6VZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=3Wb+2NYdNYlT/r55W5Q9BfPi7qfSp7lu+o+6L0rJtv8=;
        b=MHGARK1MfbjPjTMfgUdD/6o2VGqgirUU9ipTgpm7GN4fDtporzacIFB304Vg+/Ccd1
         H2gdAQkFYSfmXfAP8eJQshsEwpyaxcm7WVOhLb8GDT4ViLjFIoPPym9KDN+gjMiWd4vj
         OxNzleQc7hx2pU5j4itClotuPl3vzs+VnCfnYvU8z074G8WwecHRqP4P6geJavmHGg6I
         qv5rkVnev5BaNix64wVJS5es2+++XLgHz+QzATADI788Gsw/M1xzRGPIi1wSmHDvCnFK
         savL0E/iJy3MKGek+2Xm8r0vLELaIrU5PpxvftwsgzJlUrkQz/ThI9Vb/EXA0iTlcAii
         Fr4g==
X-Gm-Message-State: AJIora89nVyHkJMpDQs8S0r3TM9+uo18Pl4CdqmcR8j2t0ope/Gkzm7s
        lUlJ+cUdHX4sjSw3DAa0HPG4f3vTOoE=
X-Google-Smtp-Source: AGRyM1tT9stuoFyBcHRx0dfy4qvcPGQyu83eyJWdXOLAslwHbMig41DsfUkSzMnQ7gjy24d4uY2z1Q==
X-Received: by 2002:a05:6402:2985:b0:439:651b:c1f4 with SMTP id eq5-20020a056402298500b00439651bc1f4mr43380871edb.276.1657117272992;
        Wed, 06 Jul 2022 07:21:12 -0700 (PDT)
Received: from localhost (92.40.202.41.threembb.co.uk. [92.40.202.41])
        by smtp.gmail.com with ESMTPSA id au8-20020a170907092800b00722e19fec6dsm17325213ejc.156.2022.07.06.07.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 07:21:12 -0700 (PDT)
References: <20220703111057.23246-1-aidanmacdonald.0x0@gmail.com>
 <20220703111057.23246-4-aidanmacdonald.0x0@gmail.com>
 <CACRpkdamknwRPGEeGGQGQPtKw=dPXa79GAJy+E6y+03NakN=cA@mail.gmail.com>
 <GrX3yDSwNOGIBcWmKqusaJ3dDqNGLr3Y@localhost>
 <CACRpkdbHg-vTj6CnkF=oMxtpy+FxEPdn2_qKzgtsT0TYU6Nv-g@mail.gmail.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     michael@walle.cc, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] gpio: regmap: Support a custom ->to_irq() hook
Date:   Wed, 06 Jul 2022 14:50:49 +0100
In-reply-to: <CACRpkdbHg-vTj6CnkF=oMxtpy+FxEPdn2_qKzgtsT0TYU6Nv-g@mail.gmail.com>
Message-ID: <ZTG1etjWj47jkqTxIRgriV6pQhW9dasf@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Walleij <linus.walleij@linaro.org> writes:

> On Tue, Jul 5, 2022 at 1:08 PM Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> wrote:
>> Linus Walleij <linus.walleij@linaro.org> writes:
>
>> I'm not trying to argue that hierarchical IRQ domains are always a bad
>> thing -- I'm just pointing out they're not always useful or necessary.
>> All your points make sense when the GPIO controller is a large distinct
>> block with potentially many GPIOs. When we're dealing with an MFD device
>> with just a few GPIOs, maybe even just one, having a separate IRQ domain
>> makes less sense; the added structure is generally not useful.
>
> Do you mean your driver does this:
>
> MFD main device
> MFD irqchip
>  |
>  +->  MFD gpiochip
>          No irqchip here, so .to_irq() just refers ^ to that one up there
>
> IIUC you mean that if I want to use the irqchip directly then
> I have to refer to the MFD irqchip, I just cannot refer to the
> gpiochip subnode because that one does not have an irqchip.

Yep, that's right.

> // Getting GPIO from gpiochip and irq from MFD device
> // for the same GPIO line
> gpios = <&gpio 3 GPIO_ACTIVE_LOW>;
> irqs = <&mfd 114 IRQ_EDGE_RISING>;
>
> Then for a Linux driver this can be papered over by using the
> .to_irq() callback and just defining gpios.
>
> This isn't very good, if you created a separate gpiochip then you
> should have a separate (hierarchical) irqchip associated with that
> gpiochip as well.
>
> // Getting GPIO and irq from the same gpiochip node
> gpios = <&gpio 3 GPIO_ACTIVE_LOW>;
> irqs = <&gpio 3 IRQ_EDGE_RISING>;
>
> I made this mistake with the ab8500 driver and
> I would not do it like this today. I would use hierarchical gpio
> irqchip. And I should go and fix it. (Is on my TODO.)
>

If moving to hierarchical IRQ chips is the plan, could we add a note
to say .to_irq() is discouraged and shouldn't be used in new code?
Based on what you're saying (which I agree makes sense) it sounds
like there's really no reason to ever use .to_irq().

>> Looking at other GPIO drivers using a hierarchical IRQ domain, they
>> include their own IRQ chips with specialized ops. In my case I don't
>> need any of that (and it'd be the same with other MFD devices) so it
>> looks like using an IRQ domain would mean I'd have to create a fake
>> IRQ chip and domain just to translate between two number spaces.
>>
>> Is that really better than simply using ->to_irq()?
>
> To be honest most irqchips are "fake", what they mostly do is figure
> out which of a few internal sources that fired the irq, so it models the
> different things connected to a single IRQ line.
>
> So yeah, I think the hierarchical irqchip is worth it, especially if that
> means the offset of the irqs and gpios become the same.
>
> Maybe we can add more helpers in the core to make it dirt simple
> though? It would help others with the same problem.
>
> Yours,
> Linus Walleij

Okay, that sounds like a good plan. I'll look more carefully at the
existing drivers and see if I can use existing gpiolib helpers.

One potential issue (from reading the code) is that hierarchical IRQ
domains seemingly can't have a non-hierarchical domain as the parent:
irq_domain_alloc_irqs_parent() calls irq_domain_alloc_irqs_hierarchy()
and the latter fails with -ENOSYS for a non-hierarchical domain.

In my case I'm using a regmap IRQ chip, which is non-hierarchical,
so perhaps that will need to be expanded? 

Regards,
Aidan
