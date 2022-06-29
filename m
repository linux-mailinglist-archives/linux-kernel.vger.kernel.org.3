Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE0355FB19
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiF2Iyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiF2Iyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:54:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815903D1C7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:54:43 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id mf9so31268811ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sh+b35XXQ2jbAkb1ALpB14fahCKOjIDGbp7tSsTdQWI=;
        b=lZy3TdnmPg2NNe6J4qdSlZnevP/8LrZ4cEb1SQakbkHGd8QUuuAqYqUSe1ajuRB1Pc
         DfI6RJ9CtzpntjX4noklP/hj0VWn+aAekYl02t2wRLqsTByum4xytbBS5oQDcFC1fI+V
         NQmowN6Pbc+t42BRM3QAINOIQIWw+XqtSa3vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sh+b35XXQ2jbAkb1ALpB14fahCKOjIDGbp7tSsTdQWI=;
        b=xgnEaXnUyX81cZPuDvdvf4MzRLuyu7Ej8BSUMbEoFnwR9x4RAz/UDeh7iBu9hfbKHu
         LtNDf1mfzmjbp26LM4lXaa1b7o6FWzsn6PiaXrLSZp5KcBx9/jI03YojCzgvzfbtNhqY
         2tZ/f403fdwsdg7raWSpcg3kVaojsmJERA/DcMlty2Lod/uV1N+JwQyez0fhL7LYlBFQ
         Z+UmR3hsJ3dQVvgqBOyXZpOV8rZcdBHLdt9QaamyzdPnzgf33jYRxruL/xSm4BoxiX4U
         9M8aa3YRa6IJUzUELJ5iiVnKKl6Wjv0XXv0BP/E0Ksiud2mDaTykjNrBmN3VVqXzD/zF
         VLpA==
X-Gm-Message-State: AJIora9layRCI42JNkmQPUwkGZ5b36xSc/PgJ2D0xPFfjEgOq49IxEXP
        T50/Uenm4rnJdZx1stJMV6Vf40vKw+4/ndmF7nQJ/w==
X-Google-Smtp-Source: AGRyM1siGSU06j0D3br553VCQ+qVC09vr2dXCVCPXf1Ua7vk/CwZOv8utL6KOQYRg+gxgX1VJambvvbGO5m7HTMCtkw=
X-Received: by 2002:a17:906:58c7:b0:722:f4bf:cb75 with SMTP id
 e7-20020a17090658c700b00722f4bfcb75mr2257332ejs.450.1656492881842; Wed, 29
 Jun 2022 01:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220612135414.3003-1-johnson.wang@mediatek.com>
 <20220612135414.3003-3-johnson.wang@mediatek.com> <ca4b9a0e-b1ca-6861-e4c0-30a8c8a5c99c@collabora.com>
 <9addc9fb0c949e921f915fcf128783393214bfde.camel@mediatek.com> <30e07350-ff56-a361-121e-3cb3a27643a1@collabora.com>
In-Reply-To: <30e07350-ff56-a361-121e-3cb3a27643a1@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 29 Jun 2022 16:54:30 +0800
Message-ID: <CAGXv+5F3YK51eL60-SD6pfW90xSZYoVvLXvbQ1oq+8zQmfkKwA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] clk: mediatek: Add frequency hopping support
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Edward-JW Yang <edward-jw.yang@mediatek.com>,
        =?UTF-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        yu-chang.wang@mediatek.com, kuan-hsin.lee@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 6:09 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 24/06/22 09:12, Edward-JW Yang ha scritto:
> > Hi AngeloGioacchino,
> >
> > Thanks for all the advices.
> >
> > On Mon, 2022-06-13 at 17:43 +0800, AngeloGioacchino Del Regno wrote:
> >> Il 12/06/22 15:54, Johnson Wang ha scritto:
> >>> Add frequency hopping support and spread spectrum clocking
> >>> control for MT8186.
> >>>
> >>> Signed-off-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
> >>> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> >>
> >> Before going on with the review, there's one important consideration:
> >> the Frequency Hopping control is related to PLLs only (so, no other clock
> >> types get in the mix).
> >>
> >> Checking the code, the *main* thing that we do here is initializing the
> >> FHCTL by setting some registers, and we're performing the actual frequency
> >> hopping operation in clk-pll, which is right but, at this point, I think
> >> that the best way to proceed is to add the "FHCTL superpowers" to clk-pll
> >> itself, instead of adding multiple new files and devicetree bindings that
> >> are specific to the FHCTL itself.
> >>
> >> This would mean that the `fh-id` and `perms` params that you're setting in
> >> the devicetree get transferred to clk-mt8186 (and hardcoded there), as to
> >> extend the PLL declarations to include these two: that will also simplify
> >> the driver so that you won't have to match names here and there.
> >>
> >> Just an example:
> >>
> >>      PLL(CLK_APMIXED_CCIPLL, "ccipll", 0x0224, 0x0230, 0,
> >>
> >>          PLL_AO, 0, 22, 0x0228, 24, 0, 0, 0, 0x0228, 2, FHCTL_PERM_DBG_DUMP),
> >>
> >> Besides, there are another couple of reasons why you should do that instead,
> >> of which:
> >>    - The devicetree should be "generic enough", we shall not see the direct value
> >>      to write to the registers in there (yet, perms assigns exactly that)
> >>    - These values won't change on a per-device basis, I believe? They're SoC-related,
> >>      not board-related, right?
> >>
> >> In case they're board related (and/or related to TZ permissions), we can always add
> >> a bool property to the apmixedsys to advertise that board X needs to use an
> >> alternative permission (ex.: `mediatek,secure-fhctl`).
> >
> > I think we should remain clk-fhctl files because FHCTL is a independent HW and is
> > not a necessary component of clk-pll.
>
> I know what FHCTL is, but thank you anyway for the explanation, that's appreciated.
> In any case, this not being a *mandatory* component doesn't mean that when it is
> enabled it's not changing the way we manage the PLLs..........
>
> > Frequency hopping function from FHCTL is not used to replace original flow of
> > set_rate in clk-pll. They are two different ways to change PLL's frequency. The
>
> I disagree: when we want to use FHCTL, we effectively hand-over PLL control from
> APMIXEDSYS to the Frequency Hopping controller - and we're effectively replacing
> the set_rate() logic of clk-pll.
>
> > current set_rate method in clk-pll changes PLL register setting directly. Another
> > way uses FHCTL to change PLL rate.
>
> ...and of course, if we change that, we're effectively mutating the functionality
> of the MediaTek clk-pll driver and please understand that seeing a clear mutation
> in that driver is a bit more human-readable.
>
> Besides, this makes me think about one question: is there any instance in which,
> when FHCTL rate setting fails, we fall back to direct register writes?
>
> I don't think that this is feasible because we have a register in FHCTL that
> effectively hands over control to it, so direct register writes should not work
> when the PLL is not under APMIXEDSYS control, but I'm asking just to be extremely
> sure that my understanding is right.
>
> > We will set some PLL's frequency be controlled
> > by clk-pll and some are controlled by FHCTL.
>
> Another question: is this also changing on a per-board basis?
>
> (note: the pll names in the example are random and not specific to anything)
>
> Example: board A wants FHCTL on MMPLL, TVDPLL, MPLL, but *shall not* hand over
>                   NNAPLL, MFGPLL
>           board B wants FHCTL on NNAPLL, TVDPLL but *shall not* hand over MMPLL
>
> Granted that the two A, B boards are using the same SoC, can that ever happen?
>
> > And use `perms` param to decide
> > whether a PLL is using FHCTL to change its frequency.
>
> The perms param seems to be about:
>   * Enabling debug (but you're not providing any way to actually use debugging
>     features, so what's the point?)
>   * Handing over PLL control to FHCTL for hopping (can be as well done with
>     simply using a different .set_rate() callback instead of a flag)
>   * Enabling/disabling Spread Spectrum Clocking (and I think that this is a
>     legit use for flags, but if it's just one flag, you can as well use a
>     bool and manage this with a devicetree param like "enable-ssc")
>
> That said, I think that the current way of enabling the FHCTL is more complicated
> than how it should really be.
>
> >
> > FHCTL has another function called SSC(spread spectrum clocking) which is used to
> > solve PLL de-sense problem. De-sense problem is board-related so we introduce a
> > `ssc-rate` param in the devicetree to decide whether SSC is enabled and how many
> > rate should be set. Mixing SSC function into clk-pll may cause clk-pll more
> > complex.
> >
>
> Thing is, I don't get why you think that adding SSC to clk-pll would complicate it
> so much... it's really just a few register writes and nothing else, so I really
> don't see where the problem is, here.
>
> Another issue is that this driver may be largely incomplete, so perhaps I can't
> really see the complications you're talking about? Is this the case?
>
> Regarding keeping the FHCTL code in separated files, that's fine, but I would still
> integrate it tightly in clk-pll and its registration flow, because - yes, this is
> for sure not mandatory, but the main parameters are constant, they never change for
> a specific PLL, as they're register offsets, bits and masks (which, again, will
> never change as long as we're using the same SoC).
>
> >>
> >> In any case, to speed up development (I believe that transferring this in clk-pll
> >> means that the code will still be more or less the same), I've performed a review
> >> on the code; check below.
> >>
> >>> ---
> >>>    drivers/clk/mediatek/Kconfig          |   8 +
> >>>    drivers/clk/mediatek/Makefile         |   2 +
> >>>    drivers/clk/mediatek/clk-fhctl-ap.c   | 347 ++++++++++++++++++++++++++
> >>>    drivers/clk/mediatek/clk-fhctl-pll.c  | 209 ++++++++++++++++
> >>>    drivers/clk/mediatek/clk-fhctl-pll.h  |  74 ++++++
> >>>    drivers/clk/mediatek/clk-fhctl-util.h |  24 ++
> >>>    drivers/clk/mediatek/clk-fhctl.c      | 191 ++++++++++++++
> >>>    drivers/clk/mediatek/clk-fhctl.h      |  45 ++++
> >>>    drivers/clk/mediatek/clk-pll.c        |   5 +-
> >>>    drivers/clk/mediatek/clk-pll.h        |   5 +
> >>>    10 files changed, 909 insertions(+), 1 deletion(-)
> >>>    create mode 100644 drivers/clk/mediatek/clk-fhctl-ap.c
> >>>    create mode 100644 drivers/clk/mediatek/clk-fhctl-pll.c
> >>>    create mode 100644 drivers/clk/mediatek/clk-fhctl-pll.h
> >>>    create mode 100644 drivers/clk/mediatek/clk-fhctl-util.h
> >>>    create mode 100644 drivers/clk/mediatek/clk-fhctl.c
> >>>    create mode 100644 drivers/clk/mediatek/clk-fhctl.h
> >>>
> >>> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> >>> index d5936cfb3bee..fd887c537a91 100644
> >>> --- a/drivers/clk/mediatek/Kconfig
> >>> +++ b/drivers/clk/mediatek/Kconfig
> >>> @@ -622,4 +622,12 @@ config COMMON_CLK_MT8516_AUDSYS
> >>>     help
> >>>       This driver supports MediaTek MT8516 audsys clocks.
> >>>
> >>> +config COMMON_CLK_MTK_FREQ_HOPPING
> >>> +   tristate "MediaTek frequency hopping driver"
> >>
> >> If this goes inside of clk-pll, this configuration option can be safely removed.
> >
> > I think we should keep this for clk-fhctl* files.
> >
> >>
> >>> +   depends on ARCH_MEDIATEK || COMPILE_TEST
> >>> +   select COMMON_CLK_MEDIATEK
> >>> +   help
> >>> +     This driver supports frequency hopping and spread spectrum clocking
> >>> +     control for some MediaTek SoCs.
> >>> +
> >>>    endmenu
> >>> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> >>> index caf2ce93d666..3c0e9bd3978b 100644
> >>> --- a/drivers/clk/mediatek/Makefile
> >>> +++ b/drivers/clk/mediatek/Makefile
> >>> @@ -99,3 +99,5 @@ obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o
> >>>                                clk-mt8195-apusys_pll.o
> >>>    obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
> >>>    obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
> >>> +obj-$(CONFIG_COMMON_CLK_MTK_FREQ_HOPPING) += fhctl.o
> >>> +fhctl-objs += clk-fhctl.o clk-fhctl-ap.o clk-fhctl-pll.o
> >>> diff --git a/drivers/clk/mediatek/clk-fhctl-ap.c b/drivers/clk/mediatek/clk-fhctl-ap.c
> >>> new file mode 100644
> >>> index 000000000000..9e3226a9c1ca
> >>> --- /dev/null
> >>> +++ b/drivers/clk/mediatek/clk-fhctl-ap.c
> >>> @@ -0,0 +1,347 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/*
> >>> + * Copyright (c) 2022 MediaTek Inc.
> >>> + */
> >>> +
> >>> +#include <linux/device.h>
> >>> +#include <linux/module.h>
> >>> +#include <linux/of.h>
> >>> +#include <linux/of_address.h>
> >>> +#include <linux/of_device.h>
> >>> +#include <linux/platform_device.h>
> >>> +#include <linux/string.h>
> >>> +#include <linux/slab.h>
> >>> +#include "clk-fhctl.h"
> >>> +#include "clk-fhctl-pll.h"
> >>> +#include "clk-fhctl-util.h"
> >>> +
> >>> +#define FHCTL_TARGET FHCTL_AP
> >>> +
> >>> +#define PERCENT_TO_DDSLMT(dds, percent_m10) \
> >>> +   ((((dds) * (percent_m10)) >> 5) / 100)
> >>> +
> >>> +struct fh_ap_match {
> >>> +   char *name;
> >>> +   struct fh_hdlr *hdlr;
> >>> +   int (*init)(struct pll_dts *array, struct fh_ap_match *match);
> >>> +};
> >>> +
> >>> +struct hdlr_data {
> >>> +   struct pll_dts *array;
> >>> +   struct fh_pll_domain *domain;
> >>> +   spinlock_t *lock;
> >>> +};
> >>> +
> >>> +static int fhctl_set_ssc_regs(struct fh_pll_regs *regs,
> >>> +                         struct fh_pll_data *data,
> >>> +                         int fh_id, int rate)
> >>> +{
> >>> +   unsigned int updnlmt_val;
> >>> +
> >>> +   if (rate > 0) {
> >>> +           fh_set_field(regs->reg_cfg, data->frddsx_en, 0);
> >>> +           fh_set_field(regs->reg_cfg, data->sfstrx_en, 0);
> >>> +           fh_set_field(regs->reg_cfg, data->fhctlx_en, 0);
> >>
> >> Are all of these writes to be performed with a barrier?
> >> Can't we use writel_relaxed() for some, with a "final" writel() where ordering
> >> *really* matters?
> >
> > Do this mean use writel_relaxed() on the first two and writel() on the thrid?
> >
>
> If it's important that the hardware has frddsx_en, sfstrx_en, fhctlx_en *before*
> programming df_val/dt_val, then yes.... otherwise, just use writel_relaxed()
> everywhere until the last write has to happen.
>
> writel_relaxed(something,       a)
> writel_relaxed(something_else,  b)
> writel_relaxed(something_more,  a)
> writel_relaxed(another_one,     c)
> writel_relaxed(blah,            b)
> writel(reg_cfg,                 X)
>
> ....but having a second look at it, this doesn't make a lot of sense because you
> are anyway performing multiple writes to the same `reg_cfg`, so I think that you
> can as well aggregate the writes in one and reduce the barriers like that, so

Writes to the same endpoint are always ordered. The barrier gives you
ordering against writes to memory _only_.

MMIO addresses are mapped as Device-nGnRE. nR specifically means
non-reordering.

If you want to make sure writes hit the hardware, instead of getting
queued up in the interconnects, you need to read back the register
from the hardware.

For reference, see this talk: https://youtu.be/i6DayghhA8Q
Note: I banged my head against this more than a couple times.

ChenYu

> we'd have something like:
>
>
> u32 pcw_val, val;
>
> /* Important: This assumes that the contents of reg_cfg never change during the
>     execution of this programming sequence. */
> val = readl_relaxed(regs->reg_cfg);
> pcw_val = readl_relaxed(regs->reg_con_pcw) & data->dds_mask;
>
> /* Pause/disable Frequency Hopping controller for reconfiguration */
>
>
> /* P.S.: can't we use FHCTLx_PAUSE instead of turning off?? */
>
>
>
> /* SSC: Disable free-run mode */
> val &= ~data->frddsx_en;
>
> /* Disable Soft-start mode */
> val &= ~data->sfstrx_en;
>
> /* Disable Frequency Hopping controller */
> val &= ~data->fhctlx_en;
>
> writel(val, regs->reg_cfg);
>
> /* **** warning: I'm covering only the enablement flow, not the disablement **** */
>
> /* SSC Slope: Set delta frequency, delta time (df/dt) */
> val |= data->df_val & data->msk_frddsx_dys;
> val |= data->dt_val & data->msk_frddsx_dts;
>
> /* is it important to write these before DDS?
>   * no -> writel_relaxed; yes -> writel
>   */
> writel_relaxed(val, regs->reg_cfg);
>
> /* Update PLL Toggle value */
> writel_relaxed(pcw_val | data->tgl_org, regs->reg_dds);
>
> /* SSC Swing: Calculate upper/lower limits */
> updnlmt_val = PERCENT_TO_DDSLMT((readl_relaxed(regs->reg_dds) & data->dds_mask),
>                                 rate << data->updnlmt_shft);
> writel_relaxed(updnlmt_val, regs->reg_updnlmt);
>
> /* Hand over PLL control to FHCTL */
> fh_set_field(regs->reg_hp_en, BIT(fh_id), 1);
>
> /* Re-Enable SSC and Hopping control */
> val |= data->frddsx_en | data->fhctlx_en;
> writel(val, data->reg_cfg);
>
>
> Roughly, that's the idea.
> Also, keep in mind that aggregating the writes when possible is already
> improving the flow... relaxing R/W is another improvement though... but
> beware that technically this is important only in performance paths (so
> if this function gets called only very few times in a kernel life, it's
> not really important to use _relaxed accessors).
>
> Besides... I don't *really* like seeing the fh_{set, get}_field helpers...
> they're confusing at best, and open-coding the R/W makes you able to
> aggregate fields in one write without impacting on human readability.
>
>
> >>
> >> Also, at least these three field settings are common between (rate > 0) and
> >> (rate <= 0), so they can go outside of the conditional.
> >
> > OK, we will move them to outside of conditional. Thanks.
> >
> >>
> >>> +
> >>> +           /* Set the relative parameter registers (dt/df/upbnd/downbnd) */
> >>> +           fh_set_field(regs->reg_cfg, data->msk_frddsx_dys, data->df_val);
> >>> +           fh_set_field(regs->reg_cfg, data->msk_frddsx_dts, data->dt_val);
> >>> +
> >>> +           writel((readl(regs->reg_con_pcw) & data->dds_mask) |
> >>> +                   data->tgl_org, regs->reg_dds);
> >>> +
> >>> +           /* Calculate UPDNLMT */
> >>> +           updnlmt_val = PERCENT_TO_DDSLMT((readl(regs->reg_dds) &
> >>> +                                            data->dds_mask), rate) <<
> >>> +                                            data->updnlmt_shft;
> >>> +
> >>> +           writel(updnlmt_val, regs->reg_updnlmt);
> >>> +
> >>> +           fh_set_field(regs->reg_hp_en, BIT(fh_id), 1);
> >>> +
> >>> +           /* Enable SSC */
> >>> +           fh_set_field(regs->reg_cfg, data->frddsx_en, 1);
> >>> +           /* Enable Hopping control */
> >>> +           fh_set_field(regs->reg_cfg, data->fhctlx_en, 1);
> >>> +
> >>> +   } else {
> >>> +           fh_set_field(regs->reg_cfg, data->frddsx_en, 0);
> >>> +           fh_set_field(regs->reg_cfg, data->sfstrx_en, 0);
> >>> +           fh_set_field(regs->reg_cfg, data->fhctlx_en, 0);
> >>> +
> >>> +           /* Switch to APMIXEDSYS control */
> >>> +           fh_set_field(regs->reg_hp_en, BIT(fh_id), 0);
> >>> +
> >>> +           /* Wait for DDS to be stable */
> >>> +           udelay(30);
> >>> +   }
> >>> +
> >>> +   return 0;
> >>> +}
> >>> +
> >>> +static int hopping_hw_flow(void *priv_data, char *domain_name, int fh_id,
> >>> +                      unsigned int new_dds, int postdiv)
> >>> +{
> >>> +   struct fh_pll_domain *domain;
> >>> +   struct fh_pll_regs *regs;
> >>> +   struct fh_pll_data *data;
> >>> +   unsigned int dds_mask;
> >>> +   unsigned int mon_dds = 0;
> >>> +   int ret = 0;
> >>> +   unsigned int con_pcw_tmp;
> >>> +   struct hdlr_data *d = (struct hdlr_data *)priv_data;
> >>> +   struct pll_dts *array = d->array;
> >>> +
> >>> +   domain = d->domain;
> >>> +   regs = &domain->regs[fh_id];
> >>> +   data = &domain->data[fh_id];
> >>> +   dds_mask = data->dds_mask;
> >>
> >> Just perform these assignments in the variable declarations... with some
> >> reordering as well, and drop the zero assignment to ret.
> >>
> >> In few words:
> >>
> >>      struct hdlr_data *d = (struct hdlr_data *)priv_data;
> >>
> >>      struct fh_pll_domain *domain = d->domain;
> >>
> >>      struct fh_pll_regs *regs = &domain->regs[fh_id];
> >>
> >>      struct fh_pll_data *data = &domain->data[fh_id];
> >>
> >>      struct pll_dts *array = d->array;
> >>
> >>      u32 con_pcw_tmp, dds_mask;
> >>
> >>      u32 mon_dds = 0;
> >>
> >>      int ret;
> >>
> >> This comment is valid for some other functions as well - I won't repeat
> >> this for every instance... :-)
> >
> > OK, we will merge them. Thanks.
> >
> >>
> >>> +
> >>> +   if (array->ssc_rate)
> >>> +           fhctl_set_ssc_regs(regs, data, fh_id, 0);
> >>> +
> >>> +   writel((readl(regs->reg_con_pcw) & dds_mask) |
> >>> +           data->tgl_org, regs->reg_dds);
> >>> +
> >>> +   fh_set_field(regs->reg_cfg, data->sfstrx_en, 1);
> >>> +   fh_set_field(regs->reg_cfg, data->fhctlx_en, 1);
> >>> +   writel(data->slope0_value, regs->reg_slope0);
> >>> +   writel(data->slope1_value, regs->reg_slope1);
> >>> +
> >>> +   fh_set_field(regs->reg_hp_en, BIT(fh_id), 1);
> >>> +   writel((new_dds) | (data->dvfs_tri), regs->reg_dvfs);
> >>> +
> >>> +   /* Wait 1000 us until DDS stable */
> >>> +   ret = readl_poll_timeout_atomic(regs->reg_mon, mon_dds,
> >>> +                           (mon_dds & dds_mask) == new_dds, 10, 1000);
> >>
> >> Why are you writing to CON_PCW even when this returns en error?
> >> Please add a comment explaining the reasons.
> >
> > Oh, we will add a warning log and dump HW register when this returns an error
> > The reg_mon is a register reflects the current frequency rate. So, it's fine to
> > write the current rate back to CON_PCW. We will also add a comment on it. Thanks
> >
> >>
> >>> +
> >>> +   con_pcw_tmp = readl(regs->reg_con_pcw) & (~dds_mask);
> >>> +   con_pcw_tmp = (con_pcw_tmp | (readl(regs->reg_mon) & dds_mask) |
> >>> +                  data->pcwchg);
> >>> +
> >>> +   writel(con_pcw_tmp, regs->reg_con_pcw);
> >>> +
> >>> +   fh_set_field(regs->reg_hp_en, BIT(fh_id), 0);
> >>> +
> >>> +   if (array->ssc_rate)
> >>> +           fhctl_set_ssc_regs(regs, data, fh_id, array->ssc_rate);
> >>> +
> >>> +   return ret;
> >>> +}
> >>> +
> >>> +static unsigned int __get_postdiv(struct fh_pll_regs *regs,
> >>> +                             struct fh_pll_data *data)
> >>> +{
> >>> +   unsigned int regval;
> >>> +
> >>> +   regval = (readl(regs->reg_con_postdiv) & data->postdiv_mask)
> >>> +             >> data->postdiv_offset;
> >>> +
> >>> +   return data->postdiv_table[regval];
> >>
> >> Can we instead simply reuse `struct clk_div_table` from clk-provider.h?
> >
> > "postdiv" is part of setting in PCW_CON, not a individual clk divider. I think
> > it's not suitable to use `struct clk_div_table` here.
> >
>
> Uhm, I don't think that `struct clk_div_table` is tied to individual clk dividers
> in its definition... I mean, it shouldn't be a problem to reuse it in this case...
> The advantage of it is that we are able to set a clear idx<->divider relation.
>
> Anyway, if you have strong feelings about not using clk_div_table, it's ok,
> unless anyone else has considerations about that.
>
