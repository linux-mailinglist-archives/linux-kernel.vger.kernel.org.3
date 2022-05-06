Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1F551D3C3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344235AbiEFI5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343537AbiEFI5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:57:02 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E365D5D181
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:53:19 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bu29so11522135lfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 01:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eaAW8uOFlvAinrao426R7OuE0ao2r8O8NVXKwXYnVX8=;
        b=wiZCB9DfTEPaFeiCnFgmB2CMBEwD1hiSVCRgnYecxvdZrzapfyCMHuRA+Akq1WGcti
         8nRPJu1TSpgG4pluut8jdfE8esvQySd6wQbmbcay8cEYT1bzLm7LA8zy8F75Jbxfp4pZ
         f/beuZ6yv2MyOyv2VmZNofKX16Xmem55e9R1qS2x1Yr73BBWuWncF7t52BXwz0QDoC2n
         X2artWPbeGuIYD3wcrm0yYFcyZaKpaUPpTP/Pdd4oMl4N2DXSmu7Zq1XJ/vWh3Z/R9fw
         xtRv0+bnymfvkVIqIwxqi6RYfy0D/4GsluTdhzOd/CPP5jl56ear2+Ul8mrxsY7pZyXm
         8ulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eaAW8uOFlvAinrao426R7OuE0ao2r8O8NVXKwXYnVX8=;
        b=bhnzzXbGswTgu7tWumJaJvIhwk5h+aRIwDOVJ4xQAwzaTHoXiVkAKneVA2mYVIyUyp
         53wDcokpqaPmDuB6nBnEmEutxNACeyk1KpTSZl8pIwb98UglsdRjHYM2hbmm/n/Sov2p
         cq8EZ1MJ7GibFERtEeCkhBev6Y4QloFKb9XP9u5BdlBICuYO3qPXfG1WESutwpWGc0Lx
         P2N9FAlBpwU86ynJOJoBDbZZBfRvnJlVhERFd3rD2uNtp6PUKe9kD9g1prMvvVASrheC
         roBNa8GyKg9X1wP3C2BgLvETxB+qy2ySgnuOL4fsQFggpIhaWPIeZy5oBMp0ob75EBpX
         cFjQ==
X-Gm-Message-State: AOAM5309AMxxpTTuM//+tOgky80H9Rnz5gGwlRUJP/cm6Z8mHTDSnC3y
        icF7MUbK8v9XOMUU+xDNTVEfrcpLKmf2TdQx8lqW2w==
X-Google-Smtp-Source: ABdhPJw0PTzOmg/+CrYgh09I3H2knLnkp9taoJl4RWlutgW8GPm+L9ti1Bep2tow/W7F5VNwFE8BOvnjE2bvwfCFMhQ=
X-Received: by 2002:ac2:4e98:0:b0:448:3039:d170 with SMTP id
 o24-20020ac24e98000000b004483039d170mr1889783lfr.233.1651827198179; Fri, 06
 May 2022 01:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220504213251.264819-1-sebastian.reichel@collabora.com> <20220504213251.264819-10-sebastian.reichel@collabora.com>
In-Reply-To: <20220504213251.264819-10-sebastian.reichel@collabora.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 6 May 2022 10:52:42 +0200
Message-ID: <CAPDyKFqLn4LfPRbhoWw_9BF26Lgmzq_1j=RB31NDGn9YvMnB5w@mail.gmail.com>
Subject: Re: [PATCHv2 09/21] mmc: sdhci-of-dwcmshc: add reset call back for
 rockchip Socs
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>, kernel@collabora.com
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

On Wed, 4 May 2022 at 23:33, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> From: Yifeng Zhao <yifeng.zhao@rock-chips.com>
>
> The reset function build in the SDHCI will not reset the logic
> circuit related to the tuning function, which may cause data
> reading errors. Resetting the complete SDHCI controller through
> the reset controller fixes the issue.
>
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> [rebase, use optional variant of reset getter]
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

I think this needs a corresponding update of the DT docs. Otherwise
this looks good to me.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index bac874ab0b33..3a1b5ba36405 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/reset.h>
>  #include <linux/sizes.h>
>
>  #include "sdhci-pltfm.h"
> @@ -63,6 +64,7 @@
>  struct rk3568_priv {
>         /* Rockchip specified optional clocks */
>         struct clk_bulk_data rockchip_clks[RK3568_MAX_CLKS];
> +       struct reset_control *reset;
>         u8 txclk_tapnum;
>  };
>
> @@ -255,6 +257,21 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>         sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
>  }
>
> +static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +       struct rk35xx_priv *priv = dwc_priv->priv;
> +
> +       if (mask & SDHCI_RESET_ALL && priv->reset) {
> +               reset_control_assert(priv->reset);
> +               udelay(1);
> +               reset_control_deassert(priv->reset);
> +       }
> +
> +       sdhci_reset(host, mask);
> +}
> +
>  static const struct sdhci_ops sdhci_dwcmshc_ops = {
>         .set_clock              = sdhci_set_clock,
>         .set_bus_width          = sdhci_set_bus_width,
> @@ -269,7 +286,7 @@ static const struct sdhci_ops sdhci_dwcmshc_rk3568_ops = {
>         .set_bus_width          = sdhci_set_bus_width,
>         .set_uhs_signaling      = dwcmshc_set_uhs_signaling,
>         .get_max_clock          = sdhci_pltfm_clk_get_max_clock,
> -       .reset                  = sdhci_reset,
> +       .reset                  = rk35xx_sdhci_reset,
>         .adma_write_desc        = dwcmshc_adma_write_desc,
>  };
>
> @@ -292,6 +309,13 @@ static int dwcmshc_rk3568_init(struct sdhci_host *host, struct dwcmshc_priv *dwc
>         int err;
>         struct rk3568_priv *priv = dwc_priv->priv;
>
> +       priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
> +       if (IS_ERR(priv->reset)) {
> +               err = PTR_ERR(priv->reset);
> +               dev_err(mmc_dev(host->mmc), "failed to get reset control %d\n", err);
> +               return err;
> +       }
> +
>         priv->rockchip_clks[0].id = "axi";
>         priv->rockchip_clks[1].id = "block";
>         priv->rockchip_clks[2].id = "timer";
> --
> 2.35.1
>
