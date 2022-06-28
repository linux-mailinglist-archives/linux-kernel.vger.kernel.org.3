Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67F555C826
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245119AbiF1MF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiF1MFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:05:23 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D0932055;
        Tue, 28 Jun 2022 05:04:52 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id 2so4652923qvc.0;
        Tue, 28 Jun 2022 05:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zlmmkmS67MAx6J5t/JGg1s0oRcCGTGtJn2BOovrT090=;
        b=8RkH+W+ryhhz/FoQncAXKmUE6sUpCvQE+7+qqqXGUJrf+vsSZSfxugraKxEFSZnN1W
         t1+U5+6qbYVEVFBfYexEBi3waJBvXJt4hORFfq6TH8E6ieGeKYsITGws0VPMAcJ85Q+U
         2S81G3NYjPeja4ko4cOqewS/vrLwEjDjA03LjbyjjxOmlrx0FCO/Am6hXCOAu8CBirtK
         SGr0UFHlUMFA3I62ObHUm6KS7t6qtqbSXvgxk6Y2LEEjVq3QLGtdTQz+68niJ21zFRHw
         u4GnuN4EaE8GthiXVZroE2PK8IC6OEAgFWWqeXt0uz6hGVgDsHwYtHobLfors+JcnGL+
         wfyQ==
X-Gm-Message-State: AJIora/N8UHnL7xf5JPQ4e6BaIdX+R4nRJUAj3IgzOIHvzQZpYNCcfvb
        Hi5yLlvzTGh1GTb2YeEOJiXUKmD4eVoajw==
X-Google-Smtp-Source: AGRyM1sz72p4COf8/RBcOlJtUES927w++F6UxKr7nj5/nlr5TQghovBDSJXWvWDBmnQpFNqQTo4xoQ==
X-Received: by 2002:a05:6214:5841:b0:470:4b9c:9c95 with SMTP id ml1-20020a056214584100b004704b9c9c95mr3102799qvb.41.1656417891375;
        Tue, 28 Jun 2022 05:04:51 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id bq30-20020a05620a469e00b006a785ba0c25sm533130qkb.77.2022.06.28.05.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 05:04:51 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-31bf327d4b5so25092717b3.13;
        Tue, 28 Jun 2022 05:04:50 -0700 (PDT)
X-Received: by 2002:a0d:c787:0:b0:31b:a963:e1de with SMTP id
 j129-20020a0dc787000000b0031ba963e1demr13694935ywd.283.1656417890619; Tue, 28
 Jun 2022 05:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220615101227.13463-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdVX9_qO2Ydi=_57NC2fFRy=YAzuSV7xH=huAamXKOKwCA@mail.gmail.com> <YrrhO+kb5d2rtTNA@shikoro>
In-Reply-To: <YrrhO+kb5d2rtTNA@shikoro>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Jun 2022 14:04:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXVJV0Or_6HbusKdFhVAi3OQKw=udYBS2B0-iH7DpjS7w@mail.gmail.com>
Message-ID: <CAMuHMdXVJV0Or_6HbusKdFhVAi3OQKw=udYBS2B0-iH7DpjS7w@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: rcar-gen4: implement SDSRC properly
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Tue, Jun 28, 2022 at 1:08 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > > Tested on my Spider board (r8a779f0). Only build tested for r8a779g0 but
> > > the docs for the registers are the same.
> >
> > While the SDSRCSEL bits are the same, the register at offset 0x8a4 is
> > called SD0CKCR1 on R-Car S4-8, and CKSRCSELCR on R-Car V4H.
> > I guess that is why you removed the definition of SD0CKCR1, and stored
> > the register offset in DEF_GEN4_SDSRC(), despite both being the same?
>
> TBH, no :) I did that to be future proof in case the register gets moved
> somewhere else. Also, this is consistent how we did it with DEF_GEN3_SD.

In case of DEF_GEN3_SD(), we have a register offset parameter because
most affected SoCs have multiple SDHI instances, and multiple registers
to control their clocks.

> > >         case CLK_TYPE_GEN4_SDSRC:
> > > -               div = ((readl(base + SD0CKCR1) >> 29) & 0x03) + 4;
> > > +               value = (readl(base + core->offset) >> 29) & 3;
> > > +               if (value) {
> > > +                       div = value + 4;
> > > +               } else {
> > > +                       parent = clks[core->parent >> 16];
> > > +                       if (IS_ERR(parent))
> > > +                               return ERR_CAST(parent);
> > > +                       div = 2;
> > > +               }
> >
> > So this gives the exact same divider of PLL5 before.
> >
> > The clock diagram indeed shows different paths for value 0
> > (PLL5 -> 1/2 -> 1/2) and values 1 and 2 (PLL5 -> {1/5 or 1/6}).
> > But the textual description for SDSRC says "The SDSRC divider divides
> > PLL5 output clock", matching the original code.
> >
> > Do we have to complicate the code? ;-)
> > I guess the clock diagram was based on the diagram for R-Car H3
> > (which has two daisy-chained fixed 1/2 dividers), with the new 1/5
> > and 1/6 dividers added.
>
> We don't have to complicate the code unnecessarily. If you think the
> diagram is flawed, then we can keep the current code. I changed the code
> because I was confused when checking 'clk_summary' with the diagram and
> wanted to make it proper to reduce my confusion.
>
> My patches to enable eMMC on Spider have a significantly lower
> throughput than the BSP, so this was the first step of trying to verify
> things and get the clocks in shape.
>
> If you call it superfluous, then we can drop it. No hard feelings here.

OK, so let's drop this.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
