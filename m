Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BA35391E2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344765AbiEaNjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344762AbiEaNjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:39:07 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C254A3FD
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:39:03 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 1so14701801ljp.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rV+IwUnjJeMeaLuOoAuodxAXJv2e1zA8eKGCdKHN510=;
        b=aK6SduPUBnymJsbjYP8iiifXthYMYLwOHK6Ld3DlMMKNkWarDDunHmUfEq5sqmy8GV
         nRX7yuMXnhH6fyDaiQlcWx++J08xJYRPCWgVH9NQJyKN68AwWt9S14BKBk+vDtcVnAUA
         ifwgXmWp5PajZLOGS4wIIe1C6saBSt6MonJ5T+AqjBzLximu8th6TDF+hVjKTOaiQCnv
         pdGXti2Y5aLfwIYoByqBs4dVZYL+AkwdQnxB2vF0akc+16h5AViT2N4idnJJn61tvF3I
         bz9AMs6+bqVfPmC/CyBlHRKzW4/vUaM2sboP8m1ymnAuOUurizkzERbk/YAOUMz4rf3b
         xvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rV+IwUnjJeMeaLuOoAuodxAXJv2e1zA8eKGCdKHN510=;
        b=UlSMN1dngxCTjWdw3PHUVlQbscJqHrXE13NTGZSwJMws7v5/kAii6lHJu1vmMi3xLW
         suafqv0s1RvqT7XwjnufLERDtUfQyJHQTgmXvhOha33l8edeKh5D6zVVqqmVqdy0cMzu
         1RxuL2VHv2aAytYDC5k0fvxQ8B4yfiWY2YVLtnZDiChmvsi6fvSnDhNkdQtI9SlndRxa
         xqLKpY2kYKaE5EsJjsXLPr9zoFBfXaiKgCD+eCZ9ECh0o1S/pL/XGJY7NXe11GZkruLI
         VW3+oLVIwNuL61wU0UadYUtdfu1m6x9P5SxOaC4oMSzmZq9n9nHwGyPMR0uYjtSb3pOk
         IYWA==
X-Gm-Message-State: AOAM533ux+88o9J3mwFEXq2kdrLoc+//KBP54PoBk8yExYq/ltozwdow
        wrxj1/0tYhwxgReteR8N4m7gqe655fJ92+pYmbYZRg==
X-Google-Smtp-Source: ABdhPJxxSN08j36y9Nsvv/qbdQgjo0d1IK1+kmolxk6AXhFtn4SjzokuR/8mLpb+7H1Msqpw1zPPrGlDxcrRZV9GXWw=
X-Received: by 2002:a2e:954c:0:b0:253:d9bf:9f55 with SMTP id
 t12-20020a2e954c000000b00253d9bf9f55mr33323645ljh.300.1654004341321; Tue, 31
 May 2022 06:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220504213251.264819-1-sebastian.reichel@collabora.com> <20220504213251.264819-10-sebastian.reichel@collabora.com>
In-Reply-To: <20220504213251.264819-10-sebastian.reichel@collabora.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 31 May 2022 15:38:24 +0200
Message-ID: <CAPDyKFoRmpX5Pwmu370=tzg6ZAEPNm3LLAooXVLs35z94JsycQ@mail.gmail.com>
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

Queued for v5.20 on the devel branch, thanks!

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
