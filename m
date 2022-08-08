Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CCE58C870
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242216AbiHHMhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbiHHMhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:37:18 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56086AE60;
        Mon,  8 Aug 2022 05:37:17 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id r14so9677838ljp.2;
        Mon, 08 Aug 2022 05:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/MHU6eLy/HH6PnrXo470+5XMlsFXh1eKam/uKQ3OWjc=;
        b=HkQQdjli/MeTyeCv25A1kZqw2Jlhf/xncGOTm1Zf1lUG9Z9b3QQZoMgcxLY8SXqGXE
         FbUvss9tHtCdiJV/n3LVpTLfJAwkbFceRlTNVsuFFqwqvLEocIRfXn+6eHTD9i/lv8T3
         AnOoK1232oW+myjAPuIicLPqwRNFEHJIx1bdCFKS4xpDT6d0xWea7WDxj/USi8Wd1+no
         xigweofxVveM5eV3qF8JPM8cdd0a8VacQXZFCCn4CDIyd81IpzNLPtm7L0gnkXfiLLFL
         bAwhanXLSZIIj4+JsEXC2i3SnkPFHZJMrGGT9JRFV1hsBZQwxMqjvxaRPJ+SKrJKqWLp
         Z5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/MHU6eLy/HH6PnrXo470+5XMlsFXh1eKam/uKQ3OWjc=;
        b=zQcN9ipzQWAvQ3kSgzHLnldQDrqP/pk998pBY5znEJO0y7B6sRzKfYt1ntytXJcAOF
         ngLIiFO0gYLO+6aU/FfoRB4j3AG8YBdw8WqnUxEKhqGQQzr0mLmnnBfdfJUirfWKvLpJ
         JGTXUxh9JBiprwCw5PFRFkCxc6J7IB6g3HZw6AxDssE2cgWLgx9uzTRK5bO8aD2LIbXT
         jnMemHMcgVYAUQ3bztUjHL7i9ak17qbVU/QoW5I5SxW7uAUPA2Dy5bbW4VxEgXbGeswB
         qevqlGHxynWwx5v+A06NQ8ZSO4H8EYDpVYTdgqUtQsW4zqhSwYYyJb7RsQFNDxt5Oni+
         t/8w==
X-Gm-Message-State: ACgBeo2hOgdbWODeMRXvDeYH1ximzOCC1TpwghwX+/byFo+n/rD4Tsma
        Ouv5QgvJrzGQEGjp39qRzTHdTCmEFkzl3SBSkTI=
X-Google-Smtp-Source: AA6agR4P6+xqLLUlvUc10ZcbpYNlFzVZlJtwU0GcE5Si/ptz/l8bCeFHrGn1AoXJnqEDX06IAjMPe59mA03TWafJAHM=
X-Received: by 2002:a05:651c:2d0:b0:25e:6c94:59d5 with SMTP id
 f16-20020a05651c02d000b0025e6c9459d5mr6055592ljo.488.1659962235606; Mon, 08
 Aug 2022 05:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220711123519.217219-1-tmaimon77@gmail.com> <20220711123519.217219-5-tmaimon77@gmail.com>
 <20220711195544.70A30C34115@smtp.kernel.org> <CAP6Zq1ie_RgJ_9S3ftoVJ=eJHX1xR4_O_czKZghNPKVEFOzC8Q@mail.gmail.com>
 <20220718191454.5B5D3C341C0@smtp.kernel.org> <CAP6Zq1ju08GSjNnEG+zDUC8W6aQMJxd5He7QJxy9++hTy0Dc7A@mail.gmail.com>
 <20220723030226.8E43CC341C6@smtp.kernel.org> <CAP6Zq1gUvMFG9BNObVNLpVgbMRpV7e--HFxknP8kvL4nGk8Hsw@mail.gmail.com>
 <20220729225603.12528C433D6@smtp.kernel.org> <CAP6Zq1hOxG+2X-qTbvPkrVHQ5zf04GO21m1n328Jiqgzns2CMA@mail.gmail.com>
 <20220804200549.60512C433C1@smtp.kernel.org>
In-Reply-To: <20220804200549.60512C433C1@smtp.kernel.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Mon, 8 Aug 2022 15:37:04 +0300
Message-ID: <CAP6Zq1j2r9df0CpT7pi32JuVLQBDjt7cCK7LmDJehtufG8M4-Q@mail.gmail.com>
Subject: Re: [PATCH v8 04/16] clk: npcm8xx: add clock controller
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Olof Johansson <olof@lixom.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Robert Hancock <robert.hancock@calian.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Tali Perry <tali.perry1@gmail.com>,
        Thomas G leixner <tglx@linutronix.de>,
        Patrick Venture <venture@google.com>,
        Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Nancy Yuen <yuenn@google.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        SERIAL DRIVERS <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Thanks for your reply.

On Thu, 4 Aug 2022 at 23:05, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Tomer Maimon (2022-08-04 07:01:30)
> > On Sat, 30 Jul 2022 at 01:56, Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Because it is jumbled in some range?
> > Yes.
> > >
> > > >
> > > > I do see a way to combine the clock and the reset driver, the NPCM
> > > > reset driver is serving other NPCM BMC's.
> > > > Should we use regmap to handle the clock registers instead of ioremap?
> > >
> > > Sure? Using regmap or not looks like a parallel discussion. How does it
> > > help use platform APIs?
> > I mean to use regmap API instead of platform API for handing the clock
> > and reset registers.
> > the regmap API gives only one user access to R/W (lock).
> > I will be happy to get more suggestions, on how should we solve this situation.
> >
>
> Using platform APIs means using platform_*() functions, not of_*()
> functions, which are open-firmware/DT related. Regmap can be used to
> operate on registers mapped as __iomem, which is different from platform
> APIs.
I will use platform_get_resource() and devm_ioremap_resource()
functions in the next version.

>
> Is having a lock even necessary? Do the reset and clk controls live
You are right,  lock use is not necessary.
> within a shared register where we would need to prevent one driver from
> accessing that register at the same time as the other?
reset and clk drivers are living fine with shared registers, we don't
need to handle the register access between the clk and the reset
drivers.

Best regards,

Tomer
