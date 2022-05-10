Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF78521DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242883AbiEJPUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345526AbiEJPUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:20:09 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA4D4666C;
        Tue, 10 May 2022 07:59:54 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id c1so13363822qkf.13;
        Tue, 10 May 2022 07:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3e3Lz+jYEnYk5BFbUe1qTpBNu9HtQF+sDOwNpDINJlI=;
        b=qPwtF5pAEIBm7FNj4YVI5vpIwC9REJqgqyX05AT3M8kXNlW6lFIlou/VV57aX5gVe8
         gRip8XH754i/dY0U/VRe+g/y18Nj5ooaQtv6AZJiC7kLYd+Hpgsyu46TJz16I8pu+S9q
         Xi9GWE1rqdlYQqOSAk8z18Z+K+Uteya5uOuTE53vTua2Js1tx8WBgi7CjdzKZ5DJImYf
         xwasRtUnkEby+L8OwNScv/v3BZOEoYeAjN0TBlH/N5l0VDvjNEwS5F+WUVgsuBxTGz4J
         d8G1e1VCHO5ZkWwxxs5+TVcj+lkCi31gQeU9wJxlqwp/aoGAkMtIgmli7tZxTvzMXf1Z
         auJA==
X-Gm-Message-State: AOAM530sr+O0j0i6GKkHliN5dpspHvtvH3Tbemd9C2X/H7+oTI6Z0fGF
        eL8iE1IaVk1qYgRcs6S/4oaTazIynti3Fw==
X-Google-Smtp-Source: ABdhPJyeyQXHzd4g8uD9vWGJdqpkL4wUi/W742W14oohqRg3G4kCoXlpMJkiGiYEk2xNiTh2g4T/lA==
X-Received: by 2002:a05:620a:4091:b0:6a0:54cf:c0ed with SMTP id f17-20020a05620a409100b006a054cfc0edmr11845380qko.578.1652194792734;
        Tue, 10 May 2022 07:59:52 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id s11-20020ac85ecb000000b002f39b99f69dsm9058368qtx.55.2022.05.10.07.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 07:59:52 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id r11so31170660ybg.6;
        Tue, 10 May 2022 07:59:52 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr19168862ybu.604.1652194791974; Tue, 10
 May 2022 07:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220505193143.31826-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220505193143.31826-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220505193143.31826-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 May 2022 16:59:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX7A32skBCmXDbyP9Y+kY0S3nv+8iFHwqFnzJU1nYn1WQ@mail.gmail.com>
Message-ID: <CAMuHMdX7A32skBCmXDbyP9Y+kY0S3nv+8iFHwqFnzJU1nYn1WQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] clk: renesas: r9a07g043: Split up core, module
 and resets array
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>
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

Hi Prabhakar,

On Thu, May 5, 2022 at 9:32 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> In preparation for adding support for Renesas RZ/Five SoC as part of
> r9a07g043-cpg.c file, split up the core clock, module clock and resets
> array into common and SoC specific.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/r9a07g043-cpg.c
> +++ b/drivers/clk/renesas/r9a07g043-cpg.c
> @@ -36,9 +36,11 @@ enum clk_ids {
>         CLK_PLL3_DIV2_4_2,
>         CLK_SEL_PLL3_3,
>         CLK_DIV_PLL3_C,
> +#ifndef CONFIG_RISCV

Perhaps make this a positive check, i.e. check for CONFIG_ARM64?
Just in case Renesas spins out another variant with a
non-arm64/non-riscv core ;-)

>         CLK_PLL5,
>         CLK_PLL5_500,
>         CLK_PLL5_250,
> +#endif

Technically, this #ifdef protection is not needed, but it helps to
catch errors below.

>         CLK_PLL6,
>         CLK_PLL6_250,
>         CLK_P1_DIV2,
> @@ -76,227 +78,271 @@ static const char * const sel_pll3_3[] = { ".pll3_533", ".pll3_400" };
>  static const char * const sel_pll6_2[] = { ".pll6_250", ".pll5_250" };
>  static const char * const sel_shdi[] = { ".clk_533", ".clk_400", ".clk_266" };
>
> -static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
> -       /* External Clock Inputs */
> -       DEF_INPUT("extal", CLK_EXTAL),
> +static const struct {
> +       struct cpg_core_clk common[38];
> +#ifndef CONFIG_RISCV
> +       struct cpg_core_clk rzg2ul[3];
> +#endif

Unlike in the r9a07g044 vs. r9a07g054 case, there is no need to have
access to the individual arrays at runtime.  So you can just keep the
single r9a07g043_core_clks[] array, and add #ifdef/#endif around the
clock definitions for clocks that are present on one variant only.

> +} core_clks __initconst = {
> +       .common = {
> +               /* External Clock Inputs */
> +               DEF_INPUT("extal", CLK_EXTAL),
>
> -       /* Internal Core Clocks */
> -       DEF_FIXED(".osc", R9A07G043_OSCCLK, CLK_EXTAL, 1, 1),
> -       DEF_FIXED(".osc_div1000", CLK_OSC_DIV1000, CLK_EXTAL, 1, 1000),
> -       DEF_SAMPLL(".pll1", CLK_PLL1, CLK_EXTAL, PLL146_CONF(0)),
> -       DEF_FIXED(".pll2", CLK_PLL2, CLK_EXTAL, 200, 3),
> -       DEF_FIXED(".pll2_div2", CLK_PLL2_DIV2, CLK_PLL2, 1, 2),
> -       DEF_FIXED(".clk_800", CLK_PLL2_800, CLK_PLL2, 1, 2),
> -       DEF_FIXED(".clk_533", CLK_PLL2_SDHI_533, CLK_PLL2, 1, 3),
> -       DEF_FIXED(".clk_400", CLK_PLL2_SDHI_400, CLK_PLL2_800, 1, 2),
> -       DEF_FIXED(".clk_266", CLK_PLL2_SDHI_266, CLK_PLL2_SDHI_533, 1, 2),
> -       DEF_FIXED(".pll2_div2_8", CLK_PLL2_DIV2_8, CLK_PLL2_DIV2, 1, 8),
> -       DEF_FIXED(".pll2_div2_10", CLK_PLL2_DIV2_10, CLK_PLL2_DIV2, 1, 10),
> -       DEF_FIXED(".pll3", CLK_PLL3, CLK_EXTAL, 200, 3),
> -       DEF_FIXED(".pll3_div2", CLK_PLL3_DIV2, CLK_PLL3, 1, 2),
> -       DEF_FIXED(".pll3_div2_4", CLK_PLL3_DIV2_4, CLK_PLL3_DIV2, 1, 4),
> -       DEF_FIXED(".pll3_div2_4_2", CLK_PLL3_DIV2_4_2, CLK_PLL3_DIV2_4, 1, 2),
> -       DEF_FIXED(".pll3_400", CLK_PLL3_400, CLK_PLL3, 1, 4),
> -       DEF_FIXED(".pll3_533", CLK_PLL3_533, CLK_PLL3, 1, 3),
> -       DEF_MUX(".sel_pll3_3", CLK_SEL_PLL3_3, SEL_PLL3_3,
> -               sel_pll3_3, ARRAY_SIZE(sel_pll3_3), 0, CLK_MUX_READ_ONLY),
> -       DEF_DIV("divpl3c", CLK_DIV_PLL3_C, CLK_SEL_PLL3_3,
> -               DIVPL3C, dtable_1_32, CLK_DIVIDER_HIWORD_MASK),

I.e. add
#ifdef CONFIG_ARM64

> -       DEF_FIXED(".pll5", CLK_PLL5, CLK_EXTAL, 125, 1),
> -       DEF_FIXED(".pll5_500", CLK_PLL5_500, CLK_PLL5, 1, 6),
> -       DEF_FIXED(".pll5_250", CLK_PLL5_250, CLK_PLL5_500, 1, 2),

#endif

> -       DEF_FIXED(".pll6", CLK_PLL6, CLK_EXTAL, 125, 6),
> -       DEF_FIXED(".pll6_250", CLK_PLL6_250, CLK_PLL6, 1, 2),
> +               /* Internal Core Clocks */
> +               DEF_FIXED(".osc", R9A07G043_OSCCLK, CLK_EXTAL, 1, 1),

[...]

> +               DEF_FIXED("SD1_DIV4", CLK_SD1_DIV4, R9A07G043_CLK_SD1, 1, 4),
> +       },
> +#ifndef CONFIG_RISCV
> +       .rzg2ul = {
> +               DEF_FIXED(".pll5", CLK_PLL5, CLK_EXTAL, 125, 1),
> +               DEF_FIXED(".pll5_500", CLK_PLL5_500, CLK_PLL5, 1, 6),
> +               DEF_FIXED(".pll5_250", CLK_PLL5_250, CLK_PLL5_500, 1, 2),
> +       },
> +#endif
>
> -       /* Core output clk */
> -       DEF_DIV("I", R9A07G043_CLK_I, CLK_PLL1, DIVPL1A, dtable_1_8,
> -               CLK_DIVIDER_HIWORD_MASK),
> -       DEF_DIV("P0", R9A07G043_CLK_P0, CLK_PLL2_DIV2_8, DIVPL2A,
> -               dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
> -       DEF_FIXED("P0_DIV2", R9A07G043_CLK_P0_DIV2, R9A07G043_CLK_P0, 1, 2),
> -       DEF_FIXED("TSU", R9A07G043_CLK_TSU, CLK_PLL2_DIV2_10, 1, 1),
> -       DEF_DIV("P1", R9A07G043_CLK_P1, CLK_PLL3_DIV2_4,
> -               DIVPL3B, dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
> -       DEF_FIXED("P1_DIV2", CLK_P1_DIV2, R9A07G043_CLK_P1, 1, 2),
> -       DEF_DIV("P2", R9A07G043_CLK_P2, CLK_PLL3_DIV2_4_2,
> -               DIVPL3A, dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
> -       DEF_FIXED("M0", R9A07G043_CLK_M0, CLK_PLL3_DIV2_4, 1, 1),
> -       DEF_FIXED("ZT", R9A07G043_CLK_ZT, CLK_PLL3_DIV2_4_2, 1, 1),
> -       DEF_MUX("HP", R9A07G043_CLK_HP, SEL_PLL6_2,
> -               sel_pll6_2, ARRAY_SIZE(sel_pll6_2), 0, CLK_MUX_HIWORD_MASK),
> -       DEF_FIXED("SPI0", R9A07G043_CLK_SPI0, CLK_DIV_PLL3_C, 1, 2),
> -       DEF_FIXED("SPI1", R9A07G043_CLK_SPI1, CLK_DIV_PLL3_C, 1, 4),
> -       DEF_SD_MUX("SD0", R9A07G043_CLK_SD0, SEL_SDHI0,
> -                  sel_shdi, ARRAY_SIZE(sel_shdi)),
> -       DEF_SD_MUX("SD1", R9A07G043_CLK_SD1, SEL_SDHI1,
> -                  sel_shdi, ARRAY_SIZE(sel_shdi)),
> -       DEF_FIXED("SD0_DIV4", CLK_SD0_DIV4, R9A07G043_CLK_SD0, 1, 4),
> -       DEF_FIXED("SD1_DIV4", CLK_SD1_DIV4, R9A07G043_CLK_SD1, 1, 4),
>  };
>
> -static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {

Likewise, you can keep r9a07g043_mod_clks[].

#ifdef CONFIG_ARM64

> -       DEF_MOD("gic",          R9A07G043_GIC600_GICCLK, R9A07G043_CLK_P1,
> -                               0x514, 0),
> -       DEF_MOD("ia55_pclk",    R9A07G043_IA55_PCLK, R9A07G043_CLK_P2,
> -                               0x518, 0),
> -       DEF_MOD("ia55_clk",     R9A07G043_IA55_CLK, R9A07G043_CLK_P1,
> -                               0x518, 1),

#endif

and add the RZ/Five-only module clocks later protected by
#ifdef CONFIG_RISCV.

> -       DEF_MOD("dmac_aclk",    R9A07G043_DMAC_ACLK, R9A07G043_CLK_P1,
> -                               0x52c, 0),

[...]

> +static const struct {
> +       struct rzg2l_mod_clk common[54];
> +#ifdef CONFIG_RISCV
> +       struct rzg2l_mod_clk rzfive[0];
> +#else
> +       struct rzg2l_mod_clk rzg2ul[3];
> +#endif
> +} mod_clks = {
> +       .common = {
> +               DEF_MOD("dmac_aclk",    R9A07G043_DMAC_ACLK, R9A07G043_CLK_P1,
> +                                       0x52c, 0),

[...]

> +               DEF_MOD("tsu_pclk",     R9A07G043_TSU_PCLK, R9A07G043_CLK_TSU,
> +                                       0x5ac, 0),
> +       },
> +#ifdef CONFIG_RISCV
> +       .rzfive = {
> +       },
> +#else
> +       .rzg2ul = {
> +               DEF_MOD("gic",          R9A07G043_GIC600_GICCLK, R9A07G043_CLK_P1,
> +                                       0x514, 0),
> +               DEF_MOD("ia55_pclk",    R9A07G043_IA55_PCLK, R9A07G043_CLK_P2,
> +                                       0x518, 0),
> +               DEF_MOD("ia55_clk",     R9A07G043_IA55_CLK, R9A07G043_CLK_P1,
> +                                       0x518, 1),
> +       },
> +#endif
>  };
>
> -static struct rzg2l_reset r9a07g043_resets[] = {

If you do the same for the resets, you can drop "[RFC PATCH 2/4]
clk: renesas: rzg2l-cpg: Add support to stack the resets instead
of indexing".

> @@ -307,8 +353,8 @@ static const unsigned int r9a07g043_crit_mod_clks[] __initconst = {
>
>  const struct rzg2l_cpg_info r9a07g043_cpg_info = {
>         /* Core Clocks */
> -       .core_clks = r9a07g043_core_clks,
> -       .num_core_clks = ARRAY_SIZE(r9a07g043_core_clks),
> +       .core_clks = core_clks.common,
> +       .num_core_clks = ARRAY_SIZE(core_clks.common) + ARRAY_SIZE(core_clks.rzg2ul),

Then this change is not needed...

>         .last_dt_core_clk = LAST_DT_CORE_CLK,
>         .num_total_core_clks = MOD_CLK_BASE,
>
> @@ -317,11 +363,11 @@ const struct rzg2l_cpg_info r9a07g043_cpg_info = {
>         .num_crit_mod_clks = ARRAY_SIZE(r9a07g043_crit_mod_clks),
>
>         /* Module Clocks */
> -       .mod_clks = r9a07g043_mod_clks,
> -       .num_mod_clks = ARRAY_SIZE(r9a07g043_mod_clks),
> +       .mod_clks = mod_clks.common,
> +       .num_mod_clks = ARRAY_SIZE(mod_clks.common) + ARRAY_SIZE(mod_clks.rzg2ul),

Same here.

#ifdef CONFIG_ARM64

>         .num_hw_mod_clks = R9A07G043_TSU_PCLK + 1,

#endif

Note that compile-testing on non-arm64/non-riscv still works fine,
as .num_hw_mod_clks = 0 is not an issue at build-time.

>
>         /* Resets */
> -       .resets = r9a07g043_resets,

#ifdef CONFIG_ARM64

> -       .num_resets = R9A07G043_TSU_PRESETN + 1, /* Last reset ID + 1 */

#endif

> +       .resets = resets.common,
> +       ARRAY_SIZE(resets.common) + ARRAY_SIZE(resets.rzg2ul),

(BTW, ".num_resets = " was lost here)

>  };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
