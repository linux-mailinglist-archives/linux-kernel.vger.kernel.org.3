Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5A1563916
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 20:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiGASQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 14:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiGASQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:16:10 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C183014082;
        Fri,  1 Jul 2022 11:16:09 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id o25so5470724ejm.3;
        Fri, 01 Jul 2022 11:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qbwtZuVdzUuegUJwivo+X5ay7SFIYm4IMz9LKh/3woM=;
        b=AMlsqsBHk4nxUvPONMyHzCmL25MRrhk9QEGd4hXXdILut6LfXa0RsQr5iRLqoUwPEL
         YNYZ6L9lEdLFxVtoS2i76qeG7rpebQZX35VN8GcwP3oQXHEP29qr+qk8n6mEuAGH9Rvr
         7lQ38uTKMJl9NA64ZMUldmLooBznu/FYMI8ur/o0a7K2zLgAT5FbxU6d0pTfIWQwqwyy
         tFptTRPypDKIyKEWgVZHuG6a3PeXwVorLqXPEGBeo3+I9TpJMijLQNnxky9cuYhk5YE9
         3FmNkIHFbQRc58awMoEKjkoG/LL1qoKwHsFnSrBpKouV3ullLvvxyu5U/Nz1MA5VgFTd
         RWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qbwtZuVdzUuegUJwivo+X5ay7SFIYm4IMz9LKh/3woM=;
        b=d9q/ZqoZqYOjxKHtxIZOQlMEujwnszsBBWmtuLSQYkgbdXTjSINlAULb1qhVLE1t32
         6WD6FHwrmqWieyKj+Aji1QxEdVDYEKeKdOcdGNOE91A3HSj03rgsuE9OA+kG8CmYWKpK
         G8avpslQ0f1iugcNz8NqRwK9jyC8StWdI+nkUM5Vuri4BNW5fIGY2QyaAiiVt6slg820
         JB9349jZjfVkhOQCESb5a1c2ewFhdsQQsrlyN1WrfecHE26SQ+H6SNjA3o9bfPh+XnBT
         g6koTMEfk6mztivjhLquBfVsin9FksW1AY/bjgDEIAmKS1sBOWii3Nc9cCyzjYJza/vC
         qrOg==
X-Gm-Message-State: AJIora9swKj+OwAQ/ONvDhNajONqvSw6v4DSNeAOIi9IGkLDlBbV46Yv
        j7lJSQn5q8GMYGzLbEmbF11e8TfV9RWWJGhhsD8=
X-Google-Smtp-Source: AGRyM1tsDbqWuNy2XI0Iv4BQc4pW5R8UeM8nXn1rpenTQ9q64t9OHwQc+nTR67aZ9LvlfBKV9INcKf9gqNe+nJ3gBBg=
X-Received: by 2002:a17:907:72c4:b0:726:9406:f760 with SMTP id
 du4-20020a17090772c400b007269406f760mr15281003ejc.247.1656699368356; Fri, 01
 Jul 2022 11:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220625200600.7582-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220625200600.7582-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <87pmir1ln2.wl-maz@kernel.org>
In-Reply-To: <87pmir1ln2.wl-maz@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 1 Jul 2022 19:15:41 +0100
Message-ID: <CA+V-a8v_US0aa1q4gEXGHrLMicr3Oa6FUGB-4nTegzmv+8oCHA@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to
 handle GPIO interrupt
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Wed, Jun 29, 2022 at 5:26 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 25 Jun 2022 21:06:00 +0100,
> Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > Add IRQ domain to RZ/G2L pinctrl driver to handle GPIO interrupt.
> >
> > GPIO0-GPIO122 pins can be used as IRQ lines but only 32 pins can be
> > used as IRQ lines at a given time. Selection of pins as IRQ lines
> > is handled by IA55 (which is the IRQC block) which sits in between the
> > GPIO and GIC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 236 ++++++++++++++++++++++++
> >  1 file changed, 236 insertions(+)
> >
>
> [...]
>
> > +static void *rzg2l_gpio_populate_parent_fwspec(struct gpio_chip *chip,
> > +                                            unsigned int parent_hwirq,
> > +                                            unsigned int parent_type)
> > +{
> > +     struct irq_fwspec *fwspec;
> > +
> > +     fwspec = kzalloc(sizeof(*fwspec), GFP_KERNEL);
> > +     if (!fwspec)
> > +             return NULL;
> > +
> > +     fwspec->fwnode = chip->irq.parent_domain->fwnode;
> > +     fwspec->param_count = 2;
> > +     fwspec->param[0] = parent_hwirq;
> > +     fwspec->param[1] = parent_type;
> > +
> > +     return fwspec;
> > +}
>
> I jumped at this one again.
>
> Can you please pick [1] as part of your series and write this in a way
> that doesn't require extra memory allocation? It has already been
> ack'ed by Linus anyway, and we'd put an end to this thing for good.
>
> Thanks,
>
>         M.
>
> [1] https://lore.kernel.org/r/20220512162320.2213488-1-maz@kernel.org
>
I tried applying [1] on linux-next  (c4185b16aba7) and 5.19-rc4
(03c765b0e3b4) but this patch does not apply cleanly. Can you please
point me to the repo where this patch exists (or repo where the patch
applies cleanly)?

Cheers,
Prabhakar
