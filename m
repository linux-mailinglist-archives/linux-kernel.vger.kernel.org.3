Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFCE4CBAAD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiCCJua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiCCJu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:50:28 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8691154720;
        Thu,  3 Mar 2022 01:49:43 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id u3so9053578ybh.5;
        Thu, 03 Mar 2022 01:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fHLfYquwZiNVbsELh+EpgmoGDweD9121DgLApka/QvA=;
        b=CdVhSGZ57z8OqjTnZw+rvpuGupHXfRGgEfCpwr+lYtmnr3TATynK9+CMwj/OeC+QMm
         KhsO7i/LAfKFYFaEt1bdTwTZqllc5bneHrtv1Ju5H40ysXE3UgH8TwR6hL3ebyAkQd2d
         oVv+wqr+vNgFnATv75NEI17Wl74XEWKl0sD/wtEY/SEyUNXJNeBxKHY+PydYSgdPnDNP
         AZO6P7sRLQGI+ftGwY+wFTw16OGoR58bRArhsNw0i15V4pF9GotphROcPVC/GkWT4gnC
         ET7sZRwFjYE1+a9Bg9P0yXc1SRXWy218czvUqapXjd6MBBcxuHSfIWWQbG2foALeieC2
         d8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fHLfYquwZiNVbsELh+EpgmoGDweD9121DgLApka/QvA=;
        b=IWRgDP7RykubpXbbmaphZE0mUANdy946T8gAJibPtnZmqbM+RJMtQFMLpn/WhJhJwV
         z0oMdiU8ZUxtugWG2o1+61BTa6AIVjCJYuXFjyw+NF/3llDBSdL0KIo1pgbEPKPS7snH
         g6AinynKbfsU2zWsc/oBSbPrsWETTePfz7KYIaVEgdoc+RT6Q326K9riPS/4K/DiCsqe
         STLmN2vPL4inf7me9AWQcrc6OiajEkHYx/8X9hIaZccaqmBtd9ZUAwW+86VwvpfFr0M8
         hHywz6Zph37E573EOAcBiDJUf2INZahPb2Qtk7StWSFu/H+G+EiOcJtAVW7Nq6gaZ8/v
         0XEA==
X-Gm-Message-State: AOAM533PABq5C0/eUPmi/hwSXJZelgltztA1dm/bf08OTKDsxjWPA28g
        PuOh9+RkVpeHiAUc9RLrp8xluPcpRTNHvbi8Kbm2KmF+Y4M=
X-Google-Smtp-Source: ABdhPJza2D81tFDK8SAUMbvNiCknXBEdiKulxW8TjzuF3mLcKyLOahi/NjYHGmzw12LY7sBIdX4o6XObqVU0Oue9kNc=
X-Received: by 2002:a25:5145:0:b0:61d:ad99:6e5a with SMTP id
 f66-20020a255145000000b0061dad996e5amr32495636ybb.228.1646300982969; Thu, 03
 Mar 2022 01:49:42 -0800 (PST)
MIME-Version: 1.0
References: <20220303015151.1711860-1-pgwipeout@gmail.com> <CAPDyKFrk+HCbSZtB7uv6u9tjTgzFDjpB9oP9FYJUqNxcCzQ9iw@mail.gmail.com>
In-Reply-To: <CAPDyKFrk+HCbSZtB7uv6u9tjTgzFDjpB9oP9FYJUqNxcCzQ9iw@mail.gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 3 Mar 2022 04:49:30 -0500
Message-ID: <CAMdYzYrndAwWJELRRL4kP-BCdWuF6bLVwS2PUMVx_UcJZE=nsQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: dw-mmc-rockchip: fix handling invalid clock rates
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
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

On Thu, Mar 3, 2022 at 2:53 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 3 Mar 2022 at 02:52, Peter Geis <pgwipeout@gmail.com> wrote:
> >
> > The Rockchip ciu clock cannot be set as low as the dw-mmc hardware
> > supports. This leads to a situation during card initialization where the
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
> >  drivers/mmc/host/dw_mmc-rockchip.c | 31 ++++++++++++++++++++++++++----
> >  1 file changed, 27 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> > index 95d0ec0f5f3a..c198590cd74a 100644
> > --- a/drivers/mmc/host/dw_mmc-rockchip.c
> > +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> > @@ -15,7 +15,9 @@
> >  #include "dw_mmc.h"
> >  #include "dw_mmc-pltfm.h"
> >
> > -#define RK3288_CLKGEN_DIV       2
> > +#define RK3288_CLKGEN_DIV      2
> > +#define RK3288_MIN_INIT_FREQ   375000
> > +#define MMC_MAX_INIT_FREQ      400000
> >
> >  struct dw_mci_rockchip_priv_data {
> >         struct clk              *drv_clk;
> > @@ -27,6 +29,7 @@ struct dw_mci_rockchip_priv_data {
> >  static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> >  {
> >         struct dw_mci_rockchip_priv_data *priv = host->priv;
> > +       struct mmc_host *mmc = mmc_from_priv(host);
> >         int ret;
> >         unsigned int cclkin;
> >         u32 bus_hz;
> > @@ -34,6 +37,10 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> >         if (ios->clock == 0)
> >                 return;
> >
> > +       /* the clock will fail if below the f_min rate */
> > +       if (ios->clock < mmc->f_min)
> > +               ios->clock = mmc->f_min;
> > +
>
> You shouldn't need this. The mmc core should manage this already.

I thought so too, but while setting f_min did reduce the number of
errors, it didn't stop them completely.
Each tick I was getting three failures, it turns out mmc core tries
anyways with 300000, 200000, and 100000.
Clamping it here was necessary to stop these.

>
> >         /*
> >          * cclkin: source clock of mmc controller
> >          * bus_hz: card interface clock generated by CLKGEN
> > @@ -51,7 +58,7 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> >
> >         ret = clk_set_rate(host->ciu_clk, cclkin);
> >         if (ret)
> > -               dev_warn(host->dev, "failed to set rate %uHz\n", ios->clock);
> > +               dev_warn(host->dev, "failed to set rate %uHz err: %d\n", cclkin, ret);
> >
> >         bus_hz = clk_get_rate(host->ciu_clk) / RK3288_CLKGEN_DIV;
> >         if (bus_hz != host->bus_hz) {
> > @@ -290,13 +297,29 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
> >
> >  static int dw_mci_rockchip_init(struct dw_mci *host)
> >  {
> > +       struct mmc_host *mmc = mmc_from_priv(host);
> > +       int ret;
> > +
> >         /* It is slot 8 on Rockchip SoCs */
> >         host->sdio_id0 = 8;
> >
> > -       if (of_device_is_compatible(host->dev->of_node,
> > -                                   "rockchip,rk3288-dw-mshc"))
> > +       if (of_device_is_compatible(host->dev->of_node, "rockchip,rk3288-dw-mshc")) {
> >                 host->bus_hz /= RK3288_CLKGEN_DIV;
> >
> > +               /* clock driver will fail if the clock is less than the lowest source clock
> > +                * divided by the internal clock divider. Test for the lowest available
> > +                * clock and set the f_min freq to clock / clock divider. If we fail, set
> > +                * it to the downstream hardcoded value.
> > +                */
> > +               ret = clk_round_rate(host->ciu_clk, MMC_MAX_INIT_FREQ * RK3288_CLKGEN_DIV);
> > +               if (ret < 0) {
> > +                       dev_warn(host->dev, "mmc safe rate failed: %d\n", ret);
> > +                       mmc->f_min = RK3288_MIN_INIT_FREQ;
> > +               } else {
> > +                       mmc->f_min = ret / RK3288_CLKGEN_DIV;
> > +               }
> > +       }
> > +
> >         return 0;
> >  }
> >
>
> Kind regards
> Uffe
