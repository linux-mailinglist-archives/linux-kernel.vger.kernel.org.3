Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C571D49616C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381337AbiAUOqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:46:18 -0500
Received: from mail-ua1-f47.google.com ([209.85.222.47]:42633 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348692AbiAUOpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:45:39 -0500
Received: by mail-ua1-f47.google.com with SMTP id p1so17222282uap.9;
        Fri, 21 Jan 2022 06:45:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vYdykKZxMsqfDJZuGZA6zXC8ig2MT7ctvQRDFMuGve0=;
        b=iUW2GvlPT2a/+dCnz26PgU0//pBBINOZzAiImHoR/JgaAMn8qMR03qhv5eUTMAjwth
         XTXfGCeu5iRQsuJDxe69poY0yMMulXZW/qI0eU+cKR4O2b8iRqNJsVWMA0y8ipHMomOU
         9+m8biTL3GKGq7ysS2A3LgdlhafVFRlyjiiuNfKL8ShsGBUeIY8KtcdZcsZ4D9q22gL+
         GbwLC96v+r0NavcqSxmH5vhSqidm0ioMROnurckVuOZx+A5k3mhOKtmmuZCbuG9ClYXG
         ZSs6Ha7TVyeBxDpa/kOcifFztUee4gKfvd6SBom/02+vtRR8WSextWNqFH+AjtgZ8D7r
         2y1g==
X-Gm-Message-State: AOAM533lCRwE/EbxGiUyLiyw2ZKe24wLRbNMaytiZmALCi7oxFtUwf9u
        m06OTQupYwqECBEqzL7cbl8Djbb/9vdGuA==
X-Google-Smtp-Source: ABdhPJzdcStbR8igvjF5NSqaio8BAhdbCs1n4kIutlDGYIREHsOc3tT+MCMKnZNo8f53drCkj0tpHA==
X-Received: by 2002:a9f:2424:: with SMTP id 33mr1822456uaq.67.1642776338265;
        Fri, 21 Jan 2022 06:45:38 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id p8sm515138vkm.23.2022.01.21.06.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 06:45:38 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id w206so5682132vkd.10;
        Fri, 21 Jan 2022 06:45:37 -0800 (PST)
X-Received: by 2002:a05:6122:c89:: with SMTP id ba9mr1626374vkb.39.1642776337605;
 Fri, 21 Jan 2022 06:45:37 -0800 (PST)
MIME-Version: 1.0
References: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220110134659.30424-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220110134659.30424-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Jan 2022 15:45:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVo4NuhSA6qarTROUJaQbdT85Fj8uO4ASiQVe2uxph+yg@mail.gmail.com>
Message-ID: <CAMuHMdVo4NuhSA6qarTROUJaQbdT85Fj8uO4ASiQVe2uxph+yg@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] clk: renesas: Add support for RZ/V2L SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar, Biju,

On Mon, Jan 10, 2022 at 2:47 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> The clock structure for RZ/V2L is almost identical to RZ/G2L SoC. The only
> difference being RZ/V2L has an additional registers to control clock and
> reset for the DRP-AI block.
>
> This patch adds minimal clock and reset entries required to boot the
> system on Renesas RZ/V2L SMARC EVK and binds it with the RZ/G2L CPG core
> driver.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/clk/renesas/r9a07g054-cpg.c

> +const struct rzg2l_cpg_info r9a07g054_cpg_info = {
> +       /* Core Clocks */
> +       .core_clks = r9a07g054_core_clks,
> +       .num_core_clks = ARRAY_SIZE(r9a07g054_core_clks),
> +       .last_dt_core_clk = LAST_DT_CORE_CLK,
> +       .num_total_core_clks = MOD_CLK_BASE,
> +
> +       /* Critical Module Clocks */
> +       .crit_mod_clks = r9a07g054_crit_mod_clks,
> +       .num_crit_mod_clks = ARRAY_SIZE(r9a07g054_crit_mod_clks),
> +
> +       /* Module Clocks */
> +       .mod_clks = r9a07g054_mod_clks,
> +       .num_mod_clks = ARRAY_SIZE(r9a07g054_mod_clks),
> +       .num_hw_mod_clks = R9A07G054_TSU_PCLK + 1,

R9A07G054_STPAI_ACLK_DRP

> +
> +       /* Resets */
> +       .resets = r9a07g054_resets,
> +       .num_resets = ARRAY_SIZE(r9a07g054_resets),
> +};

Given RZ/V2L is RZ/G2L + DRP-AI, and the common clock IDs are the
same, what about reusing r9a07g044-cpg.c, and just adding a separate
r9a07g054_cpg_info?

When you add DRP-AI clocks and resets later, you just have to make
sure .num_{core_clks,mod_clks,resets} are correct, similar to how
drivers/pinctrl/renesas/pfc-r8a77951.c handles common and automotive
pin groups and functions.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
