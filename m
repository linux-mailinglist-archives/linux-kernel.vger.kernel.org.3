Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04F35687B3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiGFMDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbiGFMDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:03:00 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33D729C89
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:02:57 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id c143so18390401ybf.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 05:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0gmjR92/ilIXmcsx4h/zr5BFgWECYWRbjj9sJUHVD5g=;
        b=N0QdBambMGMYoYTp/ybVCNWrXaoTghttU7dgzH1l1Y815ND8OXpTpu5QKKrePRio6K
         7KRIAEGNTbZNiZMcIdV01pU5MrQKf6HbwibJdhvBWUGxTwsln5OQOxD1KyYopxUZJcPE
         mMQC3hncbvPCqEN5/TDUcHDFsNGPQrjNyEjWQLjKOkKp7AFoE/YneoshO+XADZxAckrp
         RqeX1dSD8GhOF6x1crOVz6mxaTuPjvplVjwE0a42z076XoJUpLWAIDKt2gdd0dWbw6vJ
         b+gii6IWb+yFYUGp21En+gqfoYPiDpaQ2MKBGmjaw9Mj62zCGnlxLSNNREnE97v4WciT
         HTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0gmjR92/ilIXmcsx4h/zr5BFgWECYWRbjj9sJUHVD5g=;
        b=W4vqY2s5eLMOSdkuCpdiss80fiTwQexLxOIsUJyqpjZ2Vq342Hcp6y6gxucb8XO4mj
         IAKC3bIgqgPXMQos4p4x+5+1hFGeiVIrOycXvob/OP1Cftc9CK1n168UfnWnp6JjpjjC
         SXxTy0tl+aej7MepmsprnDhpSqL40hdRGVHtdoJV+TF+rhz7h9CNYFsAgvOxBgl2iDkn
         ikUDeEPdtjV3cMRp/RBJcPpKW1BVpYBQb264Dn7a483740QWHTuN6uYqWpN7q26SjZwq
         MP3pOuN0VVWFkFgCyI/6N0aWvUKkreonX6SNC4X5ZGW85FcH2mpReFMf3n6JcxHCxIvU
         tPvQ==
X-Gm-Message-State: AJIora+nR6WkL/1vo3x5YbX31koLJAlOzqN83fHmEFqEWpzlezeqm751
        cV9SKq+tD0Xup/dtsacHtG/icYt8zWsTa5hzyWuQ3A==
X-Google-Smtp-Source: AGRyM1scIVOs0IANCeR4dGbkLq+Asjhy7uyA2rcSCG+/Hp/SD0OHvYykzYTKpepZq4LxW7fE9lvCJ2AbK8AjUePoonI=
X-Received: by 2002:a05:6902:1241:b0:66e:a6f1:83f3 with SMTP id
 t1-20020a056902124100b0066ea6f183f3mr859140ybu.492.1657108977088; Wed, 06 Jul
 2022 05:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220703111057.23246-1-aidanmacdonald.0x0@gmail.com>
 <20220703111057.23246-4-aidanmacdonald.0x0@gmail.com> <CACRpkdamknwRPGEeGGQGQPtKw=dPXa79GAJy+E6y+03NakN=cA@mail.gmail.com>
 <GrX3yDSwNOGIBcWmKqusaJ3dDqNGLr3Y@localhost>
In-Reply-To: <GrX3yDSwNOGIBcWmKqusaJ3dDqNGLr3Y@localhost>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 6 Jul 2022 14:02:43 +0200
Message-ID: <CACRpkdbHg-vTj6CnkF=oMxtpy+FxEPdn2_qKzgtsT0TYU6Nv-g@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: regmap: Support a custom ->to_irq() hook
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     michael@walle.cc, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 5, 2022 at 1:08 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
> Linus Walleij <linus.walleij@linaro.org> writes:

> I'm not trying to argue that hierarchical IRQ domains are always a bad
> thing -- I'm just pointing out they're not always useful or necessary.
> All your points make sense when the GPIO controller is a large distinct
> block with potentially many GPIOs. When we're dealing with an MFD device
> with just a few GPIOs, maybe even just one, having a separate IRQ domain
> makes less sense; the added structure is generally not useful.

Do you mean your driver does this:

MFD main device
MFD irqchip
 |
 +->  MFD gpiochip
         No irqchip here, so .to_irq() just refers ^ to that one up there

IIUC you mean that if I want to use the irqchip directly then
I have to refer to the MFD irqchip, I just cannot refer to the
gpiochip subnode because that one does not have an irqchip.

// Getting GPIO from gpiochip and irq from MFD device
// for the same GPIO line
gpios = <&gpio 3 GPIO_ACTIVE_LOW>;
irqs = <&mfd 114 IRQ_EDGE_RISING>;

Then for a Linux driver this can be papered over by using the
.to_irq() callback and just defining gpios.

This isn't very good, if you created a separate gpiochip then you
should have a separate (hierarchical) irqchip associated with that
gpiochip as well.

// Getting GPIO and irq from the same gpiochip node
gpios = <&gpio 3 GPIO_ACTIVE_LOW>;
irqs = <&gpio 3 IRQ_EDGE_RISING>;

I made this mistake with the ab8500 driver and
I would not do it like this today. I would use hierarchical gpio
irqchip. And I should go and fix it. (Is on my TODO.)

> Looking at other GPIO drivers using a hierarchical IRQ domain, they
> include their own IRQ chips with specialized ops. In my case I don't
> need any of that (and it'd be the same with other MFD devices) so it
> looks like using an IRQ domain would mean I'd have to create a fake
> IRQ chip and domain just to translate between two number spaces.
>
> Is that really better than simply using ->to_irq()?

To be honest most irqchips are "fake", what they mostly do is figure
out which of a few internal sources that fired the irq, so it models the
different things connected to a single IRQ line.

So yeah, I think the hierarchical irqchip is worth it, especially if that
means the offset of the irqs and gpios become the same.

Maybe we can add more helpers in the core to make it dirt simple
though? It would help others with the same problem.

Yours,
Linus Walleij
