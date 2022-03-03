Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A0E4CC80D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 22:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbiCCVbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 16:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbiCCVbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 16:31:10 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC89166E31;
        Thu,  3 Mar 2022 13:30:24 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2dbd8777564so71265067b3.0;
        Thu, 03 Mar 2022 13:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gSf4XqVZpmT23Xr2ZX9FwNJnPLIGiC4vINDwuY1D360=;
        b=actHS3mVoDg2rVOMxvcJgIehT4d7j3IhXrEOgR0Pl2sY1NC17ai8XMF+gGROSKqqVG
         y7Sd+Jefq9x0fRy2Qnmq8l2m2p3kVVndBGHZlsX3mnBFQnJL3xSXCG4X23+esMlNPL6/
         9vsAnzuP5gePXHpPejDcTs8yBo3VitwvagZxLJd40WXIdd8NMMlxuZExOUAVk1nbnwCq
         anANG9aUah+EcyVSl1rIRKo3ajo+B4YXgoMqbG4LqjlVIMJtvLbhLZ2T57R8egIaF3z2
         OqO5UUumBzM988xwcs91SEgo3xGFSguQ0WLvoMQSipOI99h+mgn/a12CP0NoPTr8/JdV
         Eo1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gSf4XqVZpmT23Xr2ZX9FwNJnPLIGiC4vINDwuY1D360=;
        b=aVdmdqcCb6ElTF8O/0awWbk3hk/CAqk49W667gGZI3pMDIE+ZmcX4gLr9OpBiZzH93
         trnOkNJw4JqRaqsyjrbWZYQcy8Ubp44E61GLqxOHH1O9LlerpuY8QJRHJXusWTrpkkBY
         MD3W59Q+b8lBGr5h2K+bt3KO1eOL7FiC57lPaeXU9szvDSN0VIywmGRGQQmRDUVsphH7
         37ykV9rFbM5qe8xZnEEi/MZEIkLnD16xZTOVndns9w+BfUQWQIVTjxBpfNU5hQnUY0uK
         m02RN/ZZeLlLLxZfcwKDGH0/sRUuJsB/Mb5NEvhqpcr3DmRZnlqt3Jw/U1Ur6N6NiH1K
         hAJg==
X-Gm-Message-State: AOAM532ZKmnWlSRkm4+gTQe73K420tQS2djUp3+YhqXxcydAJ2jJGmDC
        CMcRvr231nbTVoy0agZZkkyy72maHI91pPpMVic=
X-Google-Smtp-Source: ABdhPJxbeN2ZVZQxcoylq4D0YplTVnFvbUdRvpY3EGQd96NETA96fQjAnlpJbzAFt+Fap0SxoBv1SOqGfHz9WzO9914=
X-Received: by 2002:a0d:e082:0:b0:2dc:505b:dd20 with SMTP id
 j124-20020a0de082000000b002dc505bdd20mr2981033ywe.502.1646343023524; Thu, 03
 Mar 2022 13:30:23 -0800 (PST)
MIME-Version: 1.0
References: <20220303015151.1711860-1-pgwipeout@gmail.com> <07977a52-a492-4568-7259-7f213af0b0b0@arm.com>
In-Reply-To: <07977a52-a492-4568-7259-7f213af0b0b0@arm.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 3 Mar 2022 16:30:12 -0500
Message-ID: <CAMdYzYp3p2pX2raHHWpmmgVnZU4zEohYWeCJ+0C_YeOg12V=NA@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: dw-mmc-rockchip: fix handling invalid clock rates
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Addy Ke <addy.ke@rock-chips.com>,
        Doug Anderson <dianders@chromium.org>,
        linux-mmc@vger.kernel.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Mar 3, 2022 at 6:53 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-03-03 01:51, Peter Geis wrote:
> > The Rockchip ciu clock cannot be set as low as the dw-mmc hardware
> > supports.
>
> Isn't that specific to RK3568, per the downstream fix? Certainly my
> RK3399 has no problem if I simulate polling by plugging in an empty adapter:
>
> [499969.392530] mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req
> 400000Hz, actual 400000HZ div = 0)
> [499969.467709] mmc_host mmc1: Bus speed (slot 0) = 300000Hz (slot req
> 300000Hz, actual 300000HZ div = 0)
> [499969.545975] mmc_host mmc1: Bus speed (slot 0) = 200000Hz (slot req
> 200000Hz, actual 200000HZ div = 0)
> [499969.629824] mmc_host mmc1: Bus speed (slot 0) = 100000Hz (slot req
> 100000Hz, actual 100000HZ div = 0)
>
> Even though every card within arm's reach of my desk does seem happy to
> identify at 400KHz, there are apparently some that only work towards the
> lower end of the range, so it's less than ideal to impose this
> limitation where it isn't necessary.

Thanks for the insight!
In the V2 I'll change this to use the lowest supported frequency.
I'm also going to explore what's different in the rk3399 clock tree
from the rk356x clock tree.

>
> Robin.
>
> > This leads to a situation during card initialization where the
> > ciu clock is set lower than the clock driver can support. The
> > dw-mmc-rockchip driver spews errors when this happens.
> > For normal operation this only happens a few times during boot, but when
> > cd-broken is enabled (in cases such as the SoQuartz module) this fires
> > multiple times each poll cycle.
> >
> > Fix this by testing the minimum frequency the clock driver can support
> > that is within the mmc specification, then divide that by the internal
> > clock divider. Set the f_min frequency to this value, or if it fails,
> > set f_min to the downstream driver's default.
> >
> > Fixes: f629ba2c04c9 ("mmc: dw_mmc: add support for RK3288")
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >   drivers/mmc/host/dw_mmc-rockchip.c | 31 ++++++++++++++++++++++++++----
> >   1 file changed, 27 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> > index 95d0ec0f5f3a..c198590cd74a 100644
> > --- a/drivers/mmc/host/dw_mmc-rockchip.c
> > +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> > @@ -15,7 +15,9 @@
> >   #include "dw_mmc.h"
> >   #include "dw_mmc-pltfm.h"
> >
> > -#define RK3288_CLKGEN_DIV       2
> > +#define RK3288_CLKGEN_DIV    2
> > +#define RK3288_MIN_INIT_FREQ 375000
> > +#define MMC_MAX_INIT_FREQ    400000
> >
> >   struct dw_mci_rockchip_priv_data {
> >       struct clk              *drv_clk;
> > @@ -27,6 +29,7 @@ struct dw_mci_rockchip_priv_data {
> >   static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> >   {
> >       struct dw_mci_rockchip_priv_data *priv = host->priv;
> > +     struct mmc_host *mmc = mmc_from_priv(host);
> >       int ret;
> >       unsigned int cclkin;
> >       u32 bus_hz;
> > @@ -34,6 +37,10 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> >       if (ios->clock == 0)
> >               return;
> >
> > +     /* the clock will fail if below the f_min rate */
> > +     if (ios->clock < mmc->f_min)
> > +             ios->clock = mmc->f_min;
> > +
> >       /*
> >        * cclkin: source clock of mmc controller
> >        * bus_hz: card interface clock generated by CLKGEN
> > @@ -51,7 +58,7 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> >
> >       ret = clk_set_rate(host->ciu_clk, cclkin);
> >       if (ret)
> > -             dev_warn(host->dev, "failed to set rate %uHz\n", ios->clock);
> > +             dev_warn(host->dev, "failed to set rate %uHz err: %d\n", cclkin, ret);
> >
> >       bus_hz = clk_get_rate(host->ciu_clk) / RK3288_CLKGEN_DIV;
> >       if (bus_hz != host->bus_hz) {
> > @@ -290,13 +297,29 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
> >
> >   static int dw_mci_rockchip_init(struct dw_mci *host)
> >   {
> > +     struct mmc_host *mmc = mmc_from_priv(host);
> > +     int ret;
> > +
> >       /* It is slot 8 on Rockchip SoCs */
> >       host->sdio_id0 = 8;
> >
> > -     if (of_device_is_compatible(host->dev->of_node,
> > -                                 "rockchip,rk3288-dw-mshc"))
> > +     if (of_device_is_compatible(host->dev->of_node, "rockchip,rk3288-dw-mshc")) {
> >               host->bus_hz /= RK3288_CLKGEN_DIV;
> >
> > +             /* clock driver will fail if the clock is less than the lowest source clock
> > +              * divided by the internal clock divider. Test for the lowest available
> > +              * clock and set the f_min freq to clock / clock divider. If we fail, set
> > +              * it to the downstream hardcoded value.
> > +              */
> > +             ret = clk_round_rate(host->ciu_clk, MMC_MAX_INIT_FREQ * RK3288_CLKGEN_DIV);
> > +             if (ret < 0) {
> > +                     dev_warn(host->dev, "mmc safe rate failed: %d\n", ret);
> > +                     mmc->f_min = RK3288_MIN_INIT_FREQ;
> > +             } else {
> > +                     mmc->f_min = ret / RK3288_CLKGEN_DIV;
> > +             }
> > +     }
> > +
> >       return 0;
> >   }
> >
