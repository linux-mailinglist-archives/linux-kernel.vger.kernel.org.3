Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DC9521E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242525AbiEJP2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346065AbiEJP07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:26:59 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648802016C6;
        Tue, 10 May 2022 08:14:32 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id x9so13749681qts.6;
        Tue, 10 May 2022 08:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vz1eJzNwX0qqlgjKghzI8UdnpqFW4v/yeEdgJ7aBooc=;
        b=d9g9CtWKsOGR7z5n/x33vnbuP8nImZ5VYEHaN+wmNX+xmzA0AG2Lj17Hhzmp9v/r4e
         kxWsxCd5aYsDBrvrtYcbR+h177R5jZ5eutBwK5x9W069WlEDrT41+UMymuBWmDRrHZ4n
         jufFg8l+Mi0QydGUJQev5YUn+CPnXkUBuQXCPh6qklp4s4NAndRDzRRRHQuxgP8j0If4
         2hlVlyocbw+OjjnQPLEbGR2Sc13/kRheMBasfRZykqLljY6WTyM1vFcBS6DaY4sEypcT
         wL1PV79eAiJY8va8OUlarZXKbY4H5R6nbtrEdHDhua/aO4g9KczjbFnGbLxjmVAZVDS8
         ISTA==
X-Gm-Message-State: AOAM533anAxpbCuPpkPilS7mwGw/khHj0B8sPG6fxG9xGXJcAXt0fG1r
        CEC6zp6Iu3Xx4ImJB4k234xIzpIuU75Z6w==
X-Google-Smtp-Source: ABdhPJzVNRRGRMkmw0kwAOgsedCsn5kkgcEeQ+MUFnOmBdpkRZfK+cpnisqt1Z+Az080srveVc8RTQ==
X-Received: by 2002:ac8:5bd5:0:b0:2f3:b654:694d with SMTP id b21-20020ac85bd5000000b002f3b654694dmr19934873qtb.435.1652195671013;
        Tue, 10 May 2022 08:14:31 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id h191-20020a379ec8000000b0069fc347ef5dsm8536086qke.74.2022.05.10.08.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 08:14:30 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id v59so31246334ybi.12;
        Tue, 10 May 2022 08:14:30 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr19243837ybu.604.1652195669937; Tue, 10
 May 2022 08:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220505193143.31826-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220505193143.31826-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220505193143.31826-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 May 2022 17:14:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVajeFy++etApUrZC4_sgFCPH76xOOb93rQWsz42i3EVg@mail.gmail.com>
Message-ID: <CAMuHMdVajeFy++etApUrZC4_sgFCPH76xOOb93rQWsz42i3EVg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] clk: renesas: r9a07g043: Add support for RZ/Five SoC
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Thu, May 5, 2022 at 9:32 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add minimal clock and resets entries required to boot RZ/Five SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

I'm only commenting on the actual clock/reset definitions, as I expect
the structure of this file to change...

> --- a/drivers/clk/renesas/r9a07g043-cpg.c
> +++ b/drivers/clk/renesas/r9a07g043-cpg.c
> @@ -151,7 +151,7 @@ static const struct {
>  static const struct {
>         struct rzg2l_mod_clk common[54];
>  #ifdef CONFIG_RISCV
> -       struct rzg2l_mod_clk rzfive[0];
> +       struct rzg2l_mod_clk rzfive[2];
>  #else
>         struct rzg2l_mod_clk rzg2ul[3];
>  #endif
> @@ -268,6 +268,10 @@ static const struct {
>         },
>  #ifdef CONFIG_RISCV
>         .rzfive = {
> +               DEF_MOD("iax45_pclk",   R9A07G043_IAX45_PCLK, R9A07G043_CLK_P2,
> +                                       0x518, 0),
> +               DEF_MOD("iax45_clk",    R9A07G043_IAX45_CLK, R9A07G043_CLK_P1,
> +                                       0x518, 1),

OK.

Note that the register offset and bits for the IAX45 block on riscv
are exactly the same as for the IA55 block on arm64.  Hence it
would be an option to use the exact same values in the DT binding
definitions for R9A07G043_IAX45_(P)CLK and R9A07G043_IA55_(P)CLK,
and avoid the #ifdefs and duplicated DEF_MOD() entries here.

I'm undecided what's the best option...

>         },
>  #else
>         .rzg2ul = {
> @@ -284,7 +288,7 @@ static const struct {
>  static const struct {
>         struct rzg2l_reset common[42];
>  #ifdef CONFIG_RISCV
> -       struct rzg2l_reset rzfive[0];
> +       struct rzg2l_reset rzfive[1];
>  #else
>         struct rzg2l_reset rzg2ul[3];
>  #endif
> @@ -335,6 +339,7 @@ static const struct {
>         },
>  #ifdef CONFIG_RISCV
>         .rzfive = {
> +               DEF_RST(R9A07G043_IAX45_RESETN, 0x818, 0),

Same for R9A07G043_IAX45_RESETN and R9A07G043_IAA55_RESETN.

>         },
>  #else
>         .rzg2ul = {
> @@ -345,16 +350,27 @@ static const struct {
>  #endif
>  };
>
> +#ifdef CONFIG_RISCV
> +static const unsigned int r9a07g043_crit_mod_clks[] __initconst = {
> +       MOD_CLK_BASE + R9A07G043_IAX45_CLK,
> +       MOD_CLK_BASE + R9A07G043_DMAC_ACLK,
> +};
> +#else
>  static const unsigned int r9a07g043_crit_mod_clks[] __initconst = {
>         MOD_CLK_BASE + R9A07G043_GIC600_GICCLK,
>         MOD_CLK_BASE + R9A07G043_IA55_CLK,
>         MOD_CLK_BASE + R9A07G043_DMAC_ACLK,
>  };
> +#endif

Please keep a single r9a07g043_crit_mod_clks[] array, and protect the
entries inside by #ifdef CONFIG_ARM64 or CONFIG_RISCV.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
