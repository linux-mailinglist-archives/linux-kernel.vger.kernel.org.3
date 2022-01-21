Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1E04962D5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346513AbiAUQcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiAUQcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:32:23 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482CCC06173D;
        Fri, 21 Jan 2022 08:32:23 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id g81so29077050ybg.10;
        Fri, 21 Jan 2022 08:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0AEPHLlPB0DQjc2I8SwOGj7WqkpQmEZBf/Y6hwbod4M=;
        b=qiUpTEAzUcBR0amoWXYxmF7bF60QDBtKJcJ1/mHizDK+oYb6edlDLJZL3SOjnkbHMF
         rKaB/DvBUb/pFDL3ztBc8RDqzvj6JU1zcV8GbOUIk0jKvEqJoea7Nc2lSw60r1Zpq9PJ
         NCZYCHL6jrRxBIQNXJom+ynUZkanBoWOOtKFpGqT6WF2/PHuSjZ4NsvJgYac06nuikcn
         Xsh0WbWF62CfJoNabhcAuM9AdietgM8aL6NkyZPRKX8WPUlujdYGmzEpEKlEU+AgmpkD
         rSE2E3T9nl2CmsOCgN2cR5gikRGvSyQ6E2StFL4HoBaUXhW0PrL71HrnKpShFCpcPJal
         SjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0AEPHLlPB0DQjc2I8SwOGj7WqkpQmEZBf/Y6hwbod4M=;
        b=j+K8gh5OJ7G0HMiBIU4eJsId1MaPubtyalMfzYKqLzZqhlEy6sBUX5UWMqmrdZP1kQ
         4PHJ8CmO+xHebxtQv+3H5nlJkURkHK0Y22LFw7RgPn2rQw2NezWy5r/o6bOzI6SuMbrt
         YjfZtCSbj+MvXxrt40qFMzN48IsFD7E9ioGegSdIy31o6uATorLd1bAQECCGoRYpKQLg
         OX7oQwekHLY5Xz+CQLFpewkxlLhtRdTwXzV7JhZDWPfn0vhlZIQs19DK1o8/pnBvjbNv
         c2OpxrGZ75RSXELBIKbn8zckMdz2oniBVbhOVIpUy2oboTOH4+oxTiupGIArVWeXVIP+
         nptw==
X-Gm-Message-State: AOAM532KIK9AMAfG+tSogWBAk5AXwZheo5j/Zs3TunEZu9Tn7U/XHmSj
        waXjznCHFRPNvujqaAYYxm5Tw2pv3f8jJL6vd58=
X-Google-Smtp-Source: ABdhPJyNQi8jcLJ7Frk1h5vRFhyh12pz8pNJ7SB3FUF+a3rDuDJxgLKNO1wvJQagR2LIF3i3u9vQERbPDj6jGCBg8Cc=
X-Received: by 2002:a25:3716:: with SMTP id e22mr7052558yba.690.1642782742527;
 Fri, 21 Jan 2022 08:32:22 -0800 (PST)
MIME-Version: 1.0
References: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220110134659.30424-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVo4NuhSA6qarTROUJaQbdT85Fj8uO4ASiQVe2uxph+yg@mail.gmail.com>
In-Reply-To: <CAMuHMdVo4NuhSA6qarTROUJaQbdT85Fj8uO4ASiQVe2uxph+yg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 21 Jan 2022 16:31:56 +0000
Message-ID: <CA+V-a8uD_EhOFBvKxMsaXcGV2PU1SSgKEis5MmO68xUM2702ww@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] clk: renesas: Add support for RZ/V2L SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

Hi Geert,

Thank you for the review.

On Fri, Jan 21, 2022 at 2:45 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar, Biju,
>
> On Mon, Jan 10, 2022 at 2:47 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > The clock structure for RZ/V2L is almost identical to RZ/G2L SoC. The only
> > difference being RZ/V2L has an additional registers to control clock and
> > reset for the DRP-AI block.
> >
> > This patch adds minimal clock and reset entries required to boot the
> > system on Renesas RZ/V2L SMARC EVK and binds it with the RZ/G2L CPG core
> > driver.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- /dev/null
> > +++ b/drivers/clk/renesas/r9a07g054-cpg.c
>
> > +const struct rzg2l_cpg_info r9a07g054_cpg_info = {
> > +       /* Core Clocks */
> > +       .core_clks = r9a07g054_core_clks,
> > +       .num_core_clks = ARRAY_SIZE(r9a07g054_core_clks),
> > +       .last_dt_core_clk = LAST_DT_CORE_CLK,
> > +       .num_total_core_clks = MOD_CLK_BASE,
> > +
> > +       /* Critical Module Clocks */
> > +       .crit_mod_clks = r9a07g054_crit_mod_clks,
> > +       .num_crit_mod_clks = ARRAY_SIZE(r9a07g054_crit_mod_clks),
> > +
> > +       /* Module Clocks */
> > +       .mod_clks = r9a07g054_mod_clks,
> > +       .num_mod_clks = ARRAY_SIZE(r9a07g054_mod_clks),
> > +       .num_hw_mod_clks = R9A07G054_TSU_PCLK + 1,
>
> R9A07G054_STPAI_ACLK_DRP
>
Agreed.

> > +
> > +       /* Resets */
> > +       .resets = r9a07g054_resets,
> > +       .num_resets = ARRAY_SIZE(r9a07g054_resets),
> > +};
>
> Given RZ/V2L is RZ/G2L + DRP-AI, and the common clock IDs are the
> same, what about reusing r9a07g044-cpg.c, and just adding a separate
> r9a07g054_cpg_info?
>
Agreed. To clarify for clock and reset entries for common we use the
macros defined for RZ/G2L and for DRP entries we use the RZ/V2L macros
(which will be an additional member) ?

> When you add DRP-AI clocks and resets later, you just have to make
> sure .num_{core_clks,mod_clks,resets} are correct, similar to how
> drivers/pinctrl/renesas/pfc-r8a77951.c handles common and automotive
> pin groups and functions.
>
Agreed.

Cheers,
Prabhakar
