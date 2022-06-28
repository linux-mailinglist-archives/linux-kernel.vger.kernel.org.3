Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC69455CFE7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344266AbiF1JaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiF1JaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:30:00 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B0F1D327;
        Tue, 28 Jun 2022 02:29:58 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id q4so19106283qvq.8;
        Tue, 28 Jun 2022 02:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8nl+YSQWi5co5//msD4X8kc4HSNtS5aQKM6ed50ckE0=;
        b=EG9UGNgZEr8oLHOzQnIYIHMJL42S4cenMv1+1hLf82UhcMK8VCuTiyiVQI/vX/N8vt
         WQhaHhiUEQiO97KojsxnrmiGaZRMDks22+/9fM4DIDyKd6trwNmZP4ldWYpqVxMLrJlC
         lkvkjPX343SqX68qcV7v6MtrJtZErh0tEu/QoYEaTUpSTc3LuiXeIYAU46djC/kzHhip
         cGoIdkFKPIh5r8A7g3iGjzWC9XBLhHRAfs1zO+f3t6GJV7gAa6vxXTYJ4M1vTCA+PXQ6
         OjEPQE4dj4ulr0NcIihy+JY5Ug1VP+KwyyMJ4P+Ou//kXbak+lHnAqdSee2/xr7y57n7
         xDXg==
X-Gm-Message-State: AJIora8yXaa+ldWibxFWZYvIvj8cc7gko8AP2UZQkwE0CBst+rJ+Lfju
        b4XGu9pMBcftQNsBULbV5ixeQaKXQS8p4w==
X-Google-Smtp-Source: AGRyM1t17bZZUtAr7/2L7IAyQRDQwiw/bhYfIO4KAWnapufGYvpqrK86QPT6elN37HIgnOU3qXRdQw==
X-Received: by 2002:ac8:5bca:0:b0:31b:eb73:7ec with SMTP id b10-20020ac85bca000000b0031beb7307ecmr3120412qtb.272.1656408597806;
        Tue, 28 Jun 2022 02:29:57 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id b20-20020ae9eb14000000b006aee8580a37sm10349035qkg.10.2022.06.28.02.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 02:29:57 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-317741c86fdso110575987b3.2;
        Tue, 28 Jun 2022 02:29:57 -0700 (PDT)
X-Received: by 2002:a81:3a81:0:b0:317:7dcf:81d4 with SMTP id
 h123-20020a813a81000000b003177dcf81d4mr19723908ywa.47.1656408597026; Tue, 28
 Jun 2022 02:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220615101227.13463-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220615101227.13463-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Jun 2022 11:29:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVX9_qO2Ydi=_57NC2fFRy=YAzuSV7xH=huAamXKOKwCA@mail.gmail.com>
Message-ID: <CAMuHMdVX9_qO2Ydi=_57NC2fFRy=YAzuSV7xH=huAamXKOKwCA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Wed, Jun 15, 2022 at 12:12 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Depending on the divider setting, SDSRC can have a different parent.
> Implement this when reading the divider, to get a correct clock tree.
> Setting the divider is left to the bootloader for now.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch!

> Tested on my Spider board (r8a779f0). Only build tested for r8a779g0 but
> the docs for the registers are the same.

While the SDSRCSEL bits are the same, the register at offset 0x8a4 is
called SD0CKCR1 on R-Car S4-8, and CKSRCSELCR on R-Car V4H.
I guess that is why you removed the definition of SD0CKCR1, and stored
the register offset in DEF_GEN4_SDSRC(), despite both being the same?

> --- a/drivers/clk/renesas/r8a779f0-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a779f0-cpg-mssr.c
> @@ -71,7 +71,7 @@ static const struct cpg_core_clk r8a779f0_core_clks[] __initconst = {
>         DEF_FIXED(".pll6_div2", CLK_PLL6_DIV2,  CLK_PLL6,       2, 1),
>         DEF_FIXED(".s0",        CLK_S0,         CLK_PLL1_DIV2,  2, 1),
>
> -       DEF_BASE(".sdsrc",      CLK_SDSRC,      CLK_TYPE_GEN4_SDSRC, CLK_PLL5),
> +       DEF_GEN4_SDSRC(".sdsrc", CLK_SDSRC,     CLK_PLL5_DIV2,  CLK_PLL5, 0x08a4),
>         DEF_RATE(".oco",        CLK_OCO,        32768),
>
>         DEF_BASE(".rpcsrc",     CLK_RPCSRC,     CLK_TYPE_GEN4_RPCSRC, CLK_PLL5),
> diff --git a/drivers/clk/renesas/r8a779g0-cpg-mssr.c b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
> index 3fc4233b1ead..c8cd32cf4606 100644
> --- a/drivers/clk/renesas/r8a779g0-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
> @@ -86,7 +86,7 @@ static const struct cpg_core_clk r8a779g0_core_clks[] __initconst = {
>         DEF_FIXED(".s0_hsc",    CLK_S0_HSC,     CLK_PLL1_DIV2,  2, 1),
>         DEF_FIXED(".sv_vip",    CLK_SV_VIP,     CLK_PLL1,       5, 1),
>         DEF_FIXED(".sv_ir",     CLK_SV_IR,      CLK_PLL1,       5, 1),
> -       DEF_BASE(".sdsrc",      CLK_SDSRC,      CLK_TYPE_GEN4_SDSRC, CLK_PLL5),
> +       DEF_GEN4_SDSRC(".sdsrc", CLK_SDSRC,     CLK_PLL5_DIV2,  CLK_PLL5, 0x08a4),
>         DEF_RATE(".oco",        CLK_OCO,        32768),
>
>         DEF_BASE(".rpcsrc",     CLK_RPCSRC,             CLK_TYPE_GEN4_RPCSRC, CLK_PLL5),
> diff --git a/drivers/clk/renesas/rcar-gen4-cpg.c b/drivers/clk/renesas/rcar-gen4-cpg.c
> index c7ed43d6aa67..c6662ec10292 100644
> --- a/drivers/clk/renesas/rcar-gen4-cpg.c
> +++ b/drivers/clk/renesas/rcar-gen4-cpg.c
> @@ -240,7 +240,15 @@ struct clk * __init rcar_gen4_cpg_clk_register(struct device *dev,
>                                           base, core->div, core->offset);
>
>         case CLK_TYPE_GEN4_SDSRC:
> -               div = ((readl(base + SD0CKCR1) >> 29) & 0x03) + 4;
> +               value = (readl(base + core->offset) >> 29) & 3;
> +               if (value) {
> +                       div = value + 4;
> +               } else {
> +                       parent = clks[core->parent >> 16];
> +                       if (IS_ERR(parent))
> +                               return ERR_CAST(parent);
> +                       div = 2;
> +               }

So this gives the exact same divider of PLL5 before.

The clock diagram indeed shows different paths for value 0
(PLL5 -> 1/2 -> 1/2) and values 1 and 2 (PLL5 -> {1/5 or 1/6}).
But the textual description for SDSRC says "The SDSRC divider divides
PLL5 output clock", matching the original code.

Do we have to complicate the code? ;-)
I guess the clock diagram was based on the diagram for R-Car H3
(which has two daisy-chained fixed 1/2 dividers), with the new 1/5
and 1/6 dividers added.

> --- a/drivers/clk/renesas/rcar-gen4-cpg.h
> +++ b/drivers/clk/renesas/rcar-gen4-cpg.h
> @@ -67,7 +71,6 @@ struct rcar_gen4_cpg_pll_config {
>  };
>
>  #define CPG_RPCCKCR    0x874
> -#define SD0CKCR1       0x8a4
>
>  struct clk *rcar_gen4_cpg_clk_register(struct device *dev,
>         const struct cpg_core_clk *core, const struct cpg_mssr_info *info,

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
