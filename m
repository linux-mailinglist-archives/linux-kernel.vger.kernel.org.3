Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4700053266B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbiEXJ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbiEXJ3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:29:40 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C72C340ED
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:29:38 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id z7so8582072ybf.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HVD805PIWF+vPNoBSV15VHHtEetrJAxgrnMmdyS5kRQ=;
        b=S0mvoueLkkCMEb0khGrKphavMKc90PQbW1hZrqOzWs1cit1wqnOgBEbOhwC2Gm1gcj
         kIHM1+IQNCQTcaoja5VpEYpV4co8AzCNNu+83KAIk53kLqOmI2hfP1Ar9xXxIieD16Om
         xjzFu5740eVTIKeVCbdUJGmwGM0Rkl5LQ+ZYKyjPu4YPaP+cGshdi94MjFCF/XNepcPw
         oYZJyyObKJcD+Yod/TT0w5hVunqVNuqN1+xGJPHLYopcydm+GoghNABwOFA16ah6fLCU
         dQB3qPEbBbhUjnXIz4bp3atdEuAhPeAjinnOqRPhWOrHjmxFQ8/GB4oqJh3UN8Mnv3dI
         /e3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HVD805PIWF+vPNoBSV15VHHtEetrJAxgrnMmdyS5kRQ=;
        b=Y5BZdCs/okqS7VbRh1yJ33gHW+oLeBthkaZR0RcXaV3jrBRR5+PRvwzca0GK21Ygob
         NW7szoMoAn9QxxmcWrq631Bdn7oVtbgXDK+9R30lPgybCtr3SPtL33NENl3osye6DIlr
         ZpOGXJTxYTXGcgaJ/buZsJcs658jkQPN9QviCZfmzc5/SwCid4g052rlU1gLPBm9RPmr
         fZC/H7mWOXpcLAWTMfC0+acVym683oQvr3jSoz6iMC6+Rh5ZAQBiJugfF0MvECb7erP8
         9ynr329L/fwtzrdzIAHV0b5EFgH3ZCPclbiQVAKD297oGKFyJkc1goAM9d3rW8YPlbov
         DHNA==
X-Gm-Message-State: AOAM533MConsnWbwXHINQUh3QY6DtN8J1FaRfjhOtE6oS2FW7sz8kBUL
        2nURgeZL5/przgn3KcBb3wWXt+scgRgq6ptAOZpjxA==
X-Google-Smtp-Source: ABdhPJwSufTp3IMXxz6Jk+46mDzRwOrdHVqjcyhgQZKrft4yGeS0BqvUhfbsZIAkn9moT48nyJeOgOP8pXv2k6Y8YBs=
X-Received: by 2002:a05:6902:704:b0:64d:f270:22b0 with SMTP id
 k4-20020a056902070400b0064df27022b0mr25054247ybt.626.1653384577755; Tue, 24
 May 2022 02:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220523174238.28942-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220523174238.28942-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CACRpkdYaWmD9PTcGgeP5MTe9bXMgmf=tUSDBQ-4VxSfL4qkoeQ@mail.gmail.com> <CA+V-a8s+dWMwL6zQnWwFAa15sMgPGYrW+GZ=WhSW1tPxgpLOqA@mail.gmail.com>
In-Reply-To: <CA+V-a8s+dWMwL6zQnWwFAa15sMgPGYrW+GZ=WhSW1tPxgpLOqA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 May 2022 11:29:26 +0200
Message-ID: <CACRpkdb43hCCp43p5wmmfhh_6Qr-bAB2vYo7tX27MTGwfjbPGw@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] gpio: gpiolib: Allow free() callback to be overridden
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

On Tue, May 24, 2022 at 11:07 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Tue, May 24, 2022 at 9:54 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > On Mon, May 23, 2022 at 7:43 PM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > > Allow free() callback to be overridden from irq_domain_ops for
> > > hierarchical chips.
> > >
> > > This allows drivers to free up resources which are allocated during
> > > child_to_parent_hwirq()/populate_parent_alloc_arg() callbacks.
> > >
> > > On Renesas RZ/G2L platform a bitmap is maintained for TINT slots, a slot
> > > is allocated in child_to_parent_hwirq() callback which is freed up in free
> > > callback hence this override.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > So that function today looks like this:
> >
> > static void gpiochip_hierarchy_setup_domain_ops(struct irq_domain_ops *ops)
> > {
> >         ops->activate = gpiochip_irq_domain_activate;
> >         ops->deactivate = gpiochip_irq_domain_deactivate;
> >         ops->alloc = gpiochip_hierarchy_irq_domain_alloc;
> >         ops->free = irq_domain_free_irqs_common;
> >
> >         /*
> >          * We only allow overriding the translate() function for
> >          * hierarchical chips, and this should only be done if the user
> >          * really need something other than 1:1 translation.
> >          */
> >         if (!ops->translate)
> >                 ops->translate = gpiochip_hierarchy_irq_domain_translate;
> > }
> >
> > (...)
> > -       ops->free = irq_domain_free_irqs_common;
> > (...)
> > > +       if (!ops->free)
> > > +               ops->free = irq_domain_free_irqs_common;
> >
> > Marc Z is working on cleaning up the way that gpiolib is (ab)using
> > irqchips. We definitely need his ACK if we do things like this.
> > This doesn't look like one of the big offenders to me, but I want
> > to make sure we don't create new problems while Marc is trying
> > to solve the old ones.
> >
> Agreed, I had a discussion with Marc on v3 series [0].

Hm yeah I guess I am just stepping on Marc's toes with all my mails :(

I'll try to just wait for Marc's Reviewed-by instead and not add to the noise,
I'm probably just wrong.

Yours,
Linus Walleij
