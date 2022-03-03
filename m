Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A754CB828
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 08:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiCCHyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 02:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiCCHyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:54:36 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B6A16F954
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 23:53:48 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id j15so1562855lfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 23:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SSFcHIZRKG8q+pVp4JuQk89OuVsOKCLaKsxq/8EH1wA=;
        b=Pmtg0yQ3A46d4sZ2+1rKpOInipMWjQlfPtDgvBGkH8k9R8Z9XwB6z2TngB8HG1I9QD
         H/gELtT5ro925eZP9YEbpLWo1D1zE/zaivFTVx+8zsTqCgM+v4CNAHEFIneNMNp9STxi
         aidW7SCgu6z66NkJbz/+BHW+N1xHTsYHQEN99JwB6I/ca042mJwrDLsYqFAesp4Sa2C6
         St/HCM37aweiaTbXs10qh436JCwa4dUhMmGqkyPv161jjWGj/VRPHKPCWsqNMR2DPei8
         72RzO0+eZYm9fFdmcG4f1t6EzzB5wLyFKFC6ZPfVwXL3aUueyFmdQBBidOo2PtLdcRhf
         Mt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SSFcHIZRKG8q+pVp4JuQk89OuVsOKCLaKsxq/8EH1wA=;
        b=voJ17xelb7MdPGlUsBOEM/uLc1OeT8B40sCqxs8P8Ai4QfMuu4Xr0bCWr6DiMwDVJC
         4M31Ud0z9EIoDpec0J00QZ8cZ/VtHzdaIbM5LtXyH08CfncYWEmrfkwqlNFDfW9QP+gc
         fLwlbp9GvUBWNWDBP4EIU8k7NUxIxGblYY7GeF0oFGLtVRWeYrpBpk+dSIWATPXxGQDs
         9gWykkGEwasuzKR39bC5Nxbe0RQ/jEMtnoDuGBmiN8rNO4ktaRlS2LJGhprIRj+GoKhB
         ZMoLkwLUeR55eseM6jerIq2b68NHDYJe/l1vMzXZtTqOqEBV7zFLweYb30ZdM1MbWLhT
         Hdjg==
X-Gm-Message-State: AOAM5315zS2Y+hq8Gr/cApVFSmUM0wwKlvboM1bZbZtCUedgGOPz0/0w
        05JbCvcjpDEkH04tXfKERk6mqjD7R1A4TfclIrhk1g==
X-Google-Smtp-Source: ABdhPJxkZj22etsDGZKCWOW+mI6FIW6VN8RNgI79VpmA0rC46M82JLVIIOiyfPgaXs+7NgTpw7zSzE1I9/il54zLqMo=
X-Received: by 2002:a19:2d11:0:b0:445:65c7:5f1e with SMTP id
 k17-20020a192d11000000b0044565c75f1emr20676352lfj.184.1646294026898; Wed, 02
 Mar 2022 23:53:46 -0800 (PST)
MIME-Version: 1.0
References: <20220303015151.1711860-1-pgwipeout@gmail.com>
In-Reply-To: <20220303015151.1711860-1-pgwipeout@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Mar 2022 08:53:09 +0100
Message-ID: <CAPDyKFrk+HCbSZtB7uv6u9tjTgzFDjpB9oP9FYJUqNxcCzQ9iw@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: dw-mmc-rockchip: fix handling invalid clock rates
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     robin.murphy@arm.com, Jaehoon Chung <jh80.chung@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Addy Ke <addy.ke@rock-chips.com>,
        Doug Anderson <dianders@chromium.org>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2022 at 02:52, Peter Geis <pgwipeout@gmail.com> wrote:
>
> The Rockchip ciu clock cannot be set as low as the dw-mmc hardware
> supports. This leads to a situation during card initialization where the
> ciu clock is set lower than the clock driver can support. The
> dw-mmc-rockchip driver spews errors when this happens.
> For normal operation this only happens a few times during boot, but when
> cd-broken is enabled (in cases such as the SoQuartz module) this fires
> multiple times each poll cycle.
>
> Fix this by testing the minimum frequency the clock driver can support
> that is within the mmc specification, then divide that by the internal
> clock divider. Set the f_min frequency to this value, or if it fails,
> set f_min to the downstream driver's default.
>
> Fixes: f629ba2c04c9 ("mmc: dw_mmc: add support for RK3288")
>
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  drivers/mmc/host/dw_mmc-rockchip.c | 31 ++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index 95d0ec0f5f3a..c198590cd74a 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -15,7 +15,9 @@
>  #include "dw_mmc.h"
>  #include "dw_mmc-pltfm.h"
>
> -#define RK3288_CLKGEN_DIV       2
> +#define RK3288_CLKGEN_DIV      2
> +#define RK3288_MIN_INIT_FREQ   375000
> +#define MMC_MAX_INIT_FREQ      400000
>
>  struct dw_mci_rockchip_priv_data {
>         struct clk              *drv_clk;
> @@ -27,6 +29,7 @@ struct dw_mci_rockchip_priv_data {
>  static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>  {
>         struct dw_mci_rockchip_priv_data *priv = host->priv;
> +       struct mmc_host *mmc = mmc_from_priv(host);
>         int ret;
>         unsigned int cclkin;
>         u32 bus_hz;
> @@ -34,6 +37,10 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>         if (ios->clock == 0)
>                 return;
>
> +       /* the clock will fail if below the f_min rate */
> +       if (ios->clock < mmc->f_min)
> +               ios->clock = mmc->f_min;
> +

You shouldn't need this. The mmc core should manage this already.

>         /*
>          * cclkin: source clock of mmc controller
>          * bus_hz: card interface clock generated by CLKGEN
> @@ -51,7 +58,7 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>
>         ret = clk_set_rate(host->ciu_clk, cclkin);
>         if (ret)
> -               dev_warn(host->dev, "failed to set rate %uHz\n", ios->clock);
> +               dev_warn(host->dev, "failed to set rate %uHz err: %d\n", cclkin, ret);
>
>         bus_hz = clk_get_rate(host->ciu_clk) / RK3288_CLKGEN_DIV;
>         if (bus_hz != host->bus_hz) {
> @@ -290,13 +297,29 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
>
>  static int dw_mci_rockchip_init(struct dw_mci *host)
>  {
> +       struct mmc_host *mmc = mmc_from_priv(host);
> +       int ret;
> +
>         /* It is slot 8 on Rockchip SoCs */
>         host->sdio_id0 = 8;
>
> -       if (of_device_is_compatible(host->dev->of_node,
> -                                   "rockchip,rk3288-dw-mshc"))
> +       if (of_device_is_compatible(host->dev->of_node, "rockchip,rk3288-dw-mshc")) {
>                 host->bus_hz /= RK3288_CLKGEN_DIV;
>
> +               /* clock driver will fail if the clock is less than the lowest source clock
> +                * divided by the internal clock divider. Test for the lowest available
> +                * clock and set the f_min freq to clock / clock divider. If we fail, set
> +                * it to the downstream hardcoded value.
> +                */
> +               ret = clk_round_rate(host->ciu_clk, MMC_MAX_INIT_FREQ * RK3288_CLKGEN_DIV);
> +               if (ret < 0) {
> +                       dev_warn(host->dev, "mmc safe rate failed: %d\n", ret);
> +                       mmc->f_min = RK3288_MIN_INIT_FREQ;
> +               } else {
> +                       mmc->f_min = ret / RK3288_CLKGEN_DIV;
> +               }
> +       }
> +
>         return 0;
>  }
>

Kind regards
Uffe
