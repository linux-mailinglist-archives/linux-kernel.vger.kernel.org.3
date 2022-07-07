Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED65656AA06
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbiGGRwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbiGGRwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:52:05 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23CF59253;
        Thu,  7 Jul 2022 10:52:04 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id sb34so33673935ejc.11;
        Thu, 07 Jul 2022 10:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KR2UDwCoOFfk3aid7VAOv89TmttgxGQj+7CaHoga6Qg=;
        b=MRaATrwPP9hjvm1NNuEqHIaDKRUA3QAdXALhua1f36jJBhfBmI/gHkcre0uKbhYPeq
         0W1nLnew8xh5il2NpNw4CK56oP1NALRfP+hIP8zFb5t6RNBMRG36zmvq/sS5Pj8d9CTZ
         m25BzjRTwsLGI3bu64jSSYuYJezxrjLZQJbw1sTcqvTa/FMa9b7V0r31ErRJLGur2aBh
         cfz51uSxB513iHKKLBq17+dtbwXBLjlu2WEG/R4VHnZ46+FCsursWfc1SWTWCFi0AS9o
         BJeib9RUdQrCjtFnK6Oj8hQ7zv79cBgbhvdYIdFg3kjES2nUAvbiWHal0AzJqOT07Kg6
         HYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KR2UDwCoOFfk3aid7VAOv89TmttgxGQj+7CaHoga6Qg=;
        b=zr2dKfBgKDoXLlu1GB6jReRw+Q70DUl5sDJRpLQjdoN5MldcSlFjGhOmMUZ75qi94J
         +BYmjrHfSlvbu1PLBZqDKtff/64ZfvwrNY2oCDYKKGo+UyhxF5EaogdC8OcOkR1TaE5H
         elegxv0tCM3i0bWq9UdMHYEARd68Q0Z10xy/te23gD318raUXwbc7IbzRXPswsJyRp1u
         oH2+x0ZUtWTjNo+OvMdLgaLSe6ST23aEWAfqs0bunZkDeKb/5k0NlGtfDHUHaoU/phvu
         nQ8uP+KYwyeTfG4/GqDlfH76/hmdnP7h7UeMz3qpoUSS5nW/uaHY/pkEB+FWHrAf9u7C
         iaSg==
X-Gm-Message-State: AJIora9cpX0VGrLUx/GnlTi5CJK/6PeygABEwDdwIK7+SGTZHcMw/U9+
        hR9tLNBE0uyE5UM76RdYUPD/wi13yXera5JompQ=
X-Google-Smtp-Source: AGRyM1uMk9Z0CtOaCfORAc+j23Jcvk1cBQMlmf5u9QjL6vDaOGE8rwki82hA51td2jlapijoqWB/QzoOnLstUmyMLUY=
X-Received: by 2002:a17:907:3f92:b0:72a:b80c:ef3 with SMTP id
 hr18-20020a1709073f9200b0072ab80c0ef3mr25975249ejc.264.1657216323499; Thu, 07
 Jul 2022 10:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220703194020.78701-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <87h73un2pv.wl-maz@kernel.org>
In-Reply-To: <87h73un2pv.wl-maz@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 7 Jul 2022 18:51:37 +0100
Message-ID: <CA+V-a8tKOEcBD=X4=8S=jtw53ypfnckv-4+h7Dd4R969QNNeww@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Renesas RZ/G2L IRQC support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Wed, Jul 6, 2022 at 8:02 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sun, 03 Jul 2022 20:40:15 +0100,
> Lad Prabhakar <prabhakar.csengg@gmail.com> wrote:
> >
> > Hi All,
> >
> > The RZ/G2L Interrupt Controller is a front-end for the GIC found on
> > Renesas RZ/G2L SoC's with below pins:
> > - IRQ sense select for 8 external interrupts, mapped to 8 GIC SPI
> >   interrupts
> > - GPIO pins used as external interrupt input pins out of GPIOINT0-122 a
> >   maximum of only 32 can be mapped to 32 GIC SPI interrupts,
> > - NMI edge select.
> >
> >                                                              _____________
> >                                                              |    GIC     |
> >                                                              |  ________  |
> >                                       ____________           | |        | |
> > NMI --------------------------------->|          |  SPI0-479 | | GIC-600| |
> >              _______                  |          |------------>|        | |
> >              |      |                 |          |  PPI16-31 | |        | |
> >              |      | IRQ0-IRQ7       |   IRQC   |------------>|        | |
> > P0_P48_4 --->| GPIO |---------------->|          |           | |________| |
> >              |      |GPIOINT0-122     |          |           |            |
> >              |      |---------------->| TINT0-31 |           |            |
> >              |______|                 |__________|           |____________|
> >
> > The proposed patches add hierarchical IRQ domain, one in IRQC driver and
> > another in pinctrl driver. Upon interrupt requests map the interrupt to
> > GIC. Out of GPIOINT0-122 only 32 can be mapped to GIC SPI, this mapping is
> > handled by the pinctrl and IRQC driver.
> >
> > Cheers,
> > Prabhakar
> >
> > v6->v7:
> > * Used devm_reset_control_get_exclusive() instead of
> >   devm_reset_control_get_exclusive_by_index()
> > * Included RB tag from Linus for patch 5/5
> > * Switched to newer version of populate_parent_alloc_arg() (patch depends
> >   on https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/
> >   patch/?id=178b7e21459e9a7e2a2c369711ef0cc9b1cfbcd7)
>
> Please add this patch as part of the series.
>
Sure will do.

Cheers,
Prabhakar
