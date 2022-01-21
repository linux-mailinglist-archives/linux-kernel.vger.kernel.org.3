Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22432496305
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378487AbiAUQj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:39:58 -0500
Received: from mail-ua1-f42.google.com ([209.85.222.42]:36856 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiAUQjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:39:55 -0500
Received: by mail-ua1-f42.google.com with SMTP id r15so17920116uao.3;
        Fri, 21 Jan 2022 08:39:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=08CzZT3mvD81ccDG4Ahw8PON0/dRtPJlIrRMOEcIQq0=;
        b=VIABAAJDHwzrGevUBUGMyFyUvaC57Ebu+5Brbt8ayORxrLEVHjGmvMCsB6DtwRZ4Ti
         XSrcEJE7IkiutsWg7oLxK5J8Wg5bsGZujUsobnYEWMJM3bemXsilmtBeJHT9AHRmR6Q5
         nZdurbTgmShFcZSxPK7BE9M6S6AQsnHxigjJvXYho9PQr3YthIM/qLsuCJ/9U0a9zuQL
         DLqxyUfyuleGKLqfeQIKWoj3bI7nL6NKZ9QAT8j4oH8oUWK1aqdOzd1qxoA4mTt84i4t
         6fqfuLHOssDD1SQtmyLG3jbCqgh3OKBZUmm5kqYsn5X3VTk/8FtOEXHuVDGZTa5/q3pU
         yCFg==
X-Gm-Message-State: AOAM532REYvzhdbkliAyeo4OvkmSKlXOSOu1hjc+Sp/MTFdqKgOzU7/e
        xDU86tZ5/Kh5RVwdonSCs94s98q0skccfA==
X-Google-Smtp-Source: ABdhPJxTIMpmYIk7YKy8RIe8g7s9OJw3hM2A8o9UZYd0sRl4Lz0psgrXlIC2JKCKJn9rTLVnl+kG2w==
X-Received: by 2002:a05:6102:3ec4:: with SMTP id n4mr2025644vsv.41.1642783194198;
        Fri, 21 Jan 2022 08:39:54 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id y4sm1329355vsi.14.2022.01.21.08.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 08:39:54 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id y4so17926134uad.1;
        Fri, 21 Jan 2022 08:39:53 -0800 (PST)
X-Received: by 2002:a67:e95a:: with SMTP id p26mr1990858vso.38.1642783193716;
 Fri, 21 Jan 2022 08:39:53 -0800 (PST)
MIME-Version: 1.0
References: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220110134659.30424-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVo4NuhSA6qarTROUJaQbdT85Fj8uO4ASiQVe2uxph+yg@mail.gmail.com> <CA+V-a8uD_EhOFBvKxMsaXcGV2PU1SSgKEis5MmO68xUM2702ww@mail.gmail.com>
In-Reply-To: <CA+V-a8uD_EhOFBvKxMsaXcGV2PU1SSgKEis5MmO68xUM2702ww@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Jan 2022 17:39:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVUE68XECyowVASyHsEN4jufJ7gdRUkqDD_qG-PUz2B7A@mail.gmail.com>
Message-ID: <CAMuHMdVUE68XECyowVASyHsEN4jufJ7gdRUkqDD_qG-PUz2B7A@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] clk: renesas: Add support for RZ/V2L SoC
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Fri, Jan 21, 2022 at 5:32 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Fri, Jan 21, 2022 at 2:45 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, Jan 10, 2022 at 2:47 PM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > > The clock structure for RZ/V2L is almost identical to RZ/G2L SoC. The only
> > > difference being RZ/V2L has an additional registers to control clock and
> > > reset for the DRP-AI block.
> > >
> > > This patch adds minimal clock and reset entries required to boot the
> > > system on Renesas RZ/V2L SMARC EVK and binds it with the RZ/G2L CPG core
> > > driver.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > > --- /dev/null
> > > +++ b/drivers/clk/renesas/r9a07g054-cpg.c
> >
> > > +const struct rzg2l_cpg_info r9a07g054_cpg_info = {
> > > +       /* Core Clocks */
> > > +       .core_clks = r9a07g054_core_clks,
> > > +       .num_core_clks = ARRAY_SIZE(r9a07g054_core_clks),
> > > +       .last_dt_core_clk = LAST_DT_CORE_CLK,
> > > +       .num_total_core_clks = MOD_CLK_BASE,
> > > +
> > > +       /* Critical Module Clocks */
> > > +       .crit_mod_clks = r9a07g054_crit_mod_clks,
> > > +       .num_crit_mod_clks = ARRAY_SIZE(r9a07g054_crit_mod_clks),
> > > +
> > > +       /* Module Clocks */
> > > +       .mod_clks = r9a07g054_mod_clks,
> > > +       .num_mod_clks = ARRAY_SIZE(r9a07g054_mod_clks),
> > > +       .num_hw_mod_clks = R9A07G054_TSU_PCLK + 1,
> >
> > R9A07G054_STPAI_ACLK_DRP
> >
> Agreed.
>
> > > +
> > > +       /* Resets */
> > > +       .resets = r9a07g054_resets,
> > > +       .num_resets = ARRAY_SIZE(r9a07g054_resets),
> > > +};
> >
> > Given RZ/V2L is RZ/G2L + DRP-AI, and the common clock IDs are the
> > same, what about reusing r9a07g044-cpg.c, and just adding a separate
> > r9a07g054_cpg_info?
> >
> Agreed. To clarify for clock and reset entries for common we use the
> macros defined for RZ/G2L and for DRP entries we use the RZ/V2L macros
> (which will be an additional member) ?

You can have a struct with two arrays:

    static const struct {
            static struct rzg2l_mod_clk common[...];
    #ifdef CONFIG_CLK_R9A07G054
            static struct rzg2l_mod_clk drp[...];
    #endif
    } r9a07g054_mod_clks[] = ...

See drivers/pinctrl/renesas/pfc-r8a77951.c.

> > When you add DRP-AI clocks and resets later, you just have to make
> > sure .num_{core_clks,mod_clks,resets} are correct, similar to how
> > drivers/pinctrl/renesas/pfc-r8a77951.c handles common and automotive
> > pin groups and functions.
> >
> Agreed.

E.g. ARRAY_SIZE(r9a07g054_mod_clks.common) vs.
ARRAY_SIZE(r9a07g054_mod_clks.common) + ARRAY_SIZE(r9a07g054_mod_clks.drp).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
