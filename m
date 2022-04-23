Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA92C50C952
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbiDWKfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 06:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbiDWKfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:35:36 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5793F22BF6;
        Sat, 23 Apr 2022 03:32:39 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id bf11so12378996ljb.7;
        Sat, 23 Apr 2022 03:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FjHVIpwQVF2j9Z1J3pzN5aGfezd4ZG1gp/yXo52Doyk=;
        b=XFmDGucF/OcegOVH0xx/d8n/IGwkExBInzgnH2Lm7dLvoea6vEpiarJprM8axfZYn6
         xdqdozexD2dH6IbHU5LMU7IS9U+oioxj5yy6DIUWl2cXiOWkfXf0jBRUlbUac9HTVnqB
         RiOklvCNDaZGnqGSqOn6qqrJh+pq6gQJAqGVe8G1NMAPMjHTihC998Aaq06Jmcc+fcT+
         iz/U5Gi7FQk1R1FbfVjnYWzi8EXNYk8F+GlASybLnp/xB8AV28jXILYawb2+8Cn5XGAL
         kLLkAgfNwnWBTuxawnfafuToG52yusZv5V839takuTzRzaFeEZiTEDGv/G0oXano+ONU
         j+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FjHVIpwQVF2j9Z1J3pzN5aGfezd4ZG1gp/yXo52Doyk=;
        b=KCTlJkNynU29CGY0k2iS81iCNCEOGuOpqK1owtrkqjYtW9EO5paYyQlyV3HRpxptj3
         ZVyoXEIQommDlftZ+YPgYDLeFY0CpLlTvzcYcGPWOXHOK75L2YOsC83huyF0KS/JNBwZ
         S+0Nxbtj+ALrihwndKCtJtqjkuhI8ldU6JPeQNUeKoBGNmKLizoGzs7fd0tRVzVkLMms
         vprBWwpDFtuWjHRdVNBdjb7vkB1Fo1GczA8POVV0ejg3DxnTBXI4h4t61A2YsJFmQFnN
         XIvV+sTjewtA9H3Gw87gS8B4WHyVdw7Tr3ZeuAMcjMM2Ddt685/0G4L2+/5oJd664yOu
         Djpg==
X-Gm-Message-State: AOAM531xjJ8tckkekqujWsIJ+QxIpoaJncC2WDbCNDQRoPNiV75YtuHu
        xvnF+LzMYql2RVymtFwA/rQ=
X-Google-Smtp-Source: ABdhPJypw+C0OHw2I6BBqFjoROXfn7uqBt7/o3BKuV0y5z0fzD6WCOzfmSwCSW856LNxwR99k8GuRg==
X-Received: by 2002:a05:651c:1781:b0:247:daa7:4358 with SMTP id bn1-20020a05651c178100b00247daa74358mr5186355ljb.477.1650709957430;
        Sat, 23 Apr 2022 03:32:37 -0700 (PDT)
Received: from [192.168.2.145] (109-252-138-167.dynamic.spd-mgts.ru. [109.252.138.167])
        by smtp.googlemail.com with ESMTPSA id m1-20020a2e7101000000b0024f081cb0absm73107ljc.83.2022.04.23.03.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 03:32:36 -0700 (PDT)
Message-ID: <0ac35b47-720e-ae99-45d2-3f8d63868a1e@gmail.com>
Date:   Sat, 23 Apr 2022 13:32:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv1 08/19] mmc: sdhci-of-dwcmshc: add reset call back for
 rockchip Socs
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>, kernel@collabora.com
References: <20220422170920.401914-1-sebastian.reichel@collabora.com>
 <20220422170920.401914-9-sebastian.reichel@collabora.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220422170920.401914-9-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

22.04.2022 20:09, Sebastian Reichel пишет:
> From: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> 
> The reset function build in the SDHCI will not reset the logic
> circuit related to the tuning function, which may cause data
> reading errors. Resetting the complete SDHCI controller through
> the reset controller fixes the issue.
> 
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> [rebase]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index bac874ab0b33..d95ae6ca1256 100644
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
>  	/* Rockchip specified optional clocks */
>  	struct clk_bulk_data rockchip_clks[RK3568_MAX_CLKS];
> +	struct reset_control *reset;
>  	u8 txclk_tapnum;
>  };
>  
> @@ -255,6 +257,23 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>  	sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
>  }
>  
> +static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	struct rk35xx_priv *priv = dwc_priv->priv;
> +
> +	if (mask & SDHCI_RESET_ALL) {
> +		if (!IS_ERR_OR_NULL(priv->reset)) {

priv->reset can't be a error ptr since probe fails on error.

> +			reset_control_assert(priv->reset);
> +			udelay(1);
> +			reset_control_deassert(priv->reset);
> +		}
> +	}
> +
> +	sdhci_reset(host, mask);
> +}
> +
>  static const struct sdhci_ops sdhci_dwcmshc_ops = {
>  	.set_clock		= sdhci_set_clock,
>  	.set_bus_width		= sdhci_set_bus_width,
> @@ -269,7 +288,7 @@ static const struct sdhci_ops sdhci_dwcmshc_rk3568_ops = {
>  	.set_bus_width		= sdhci_set_bus_width,
>  	.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
>  	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
> -	.reset			= sdhci_reset,
> +	.reset			= rk35xx_sdhci_reset,
>  	.adma_write_desc	= dwcmshc_adma_write_desc,
>  };
>  
> @@ -292,6 +311,13 @@ static int dwcmshc_rk3568_init(struct sdhci_host *host, struct dwcmshc_priv *dwc
>  	int err;
>  	struct rk3568_priv *priv = dwc_priv->priv;
>  
> +	priv->reset = devm_reset_control_array_get_exclusive(mmc_dev(host->mmc));

The devm_reset_control_array_get_exclusive() never returns NULL.

The devm_reset_control_array_get_optional_exclusive(() may return NULL
if reset is missing in DT, perhaps that's what you actually want?

> +	if (IS_ERR_OR_NULL(priv->reset)) {
> +		err = PTR_ERR(priv->reset);

NULL isn't a error

> +		dev_err(mmc_dev(host->mmc), "failed to get reset control %d\n", err);

dev_err_probe()?

