Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B8C5112E1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359084AbiD0HyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359127AbiD0HyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:54:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D95FF5;
        Wed, 27 Apr 2022 00:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651045850; x=1682581850;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GGOTDAFzwuzwMxFsrqdMQraFAoaOmt/NogVcz01weJU=;
  b=Hq2luEC6FzAJfmmb8KeV0qpMUmxZ3iC+fHyujRl9bEulJ2FbMI20l9Tw
   JEn1mnBTO+HIpRNZEyfQIIlLygMTG4uA5+s+JfYly65iOkxIKYyUks9TY
   k1kdw9le9KQzBAUM7CS6e2aMjJ5BjnechniqactZYOc2vRLfGDUyKzQtd
   GgX39RTNpnxdJy0AoL291ZGhXeBpP/ksxqbPKvNOjWEBDdb4ITStKa74D
   OssAriThuJXFoBe3EVDqwpGPE8g4LD8ToCwm4IiAsjbvR7ZuZzhLSnYLR
   VbwYt4iORUCw4i4dFvjkhMoQojDf0JltJp9US/upjF4Wigs4gUiHehGo0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="246415634"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="246415634"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 00:50:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="580450624"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.122])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 00:50:44 -0700
Message-ID: <65b64001-0b85-8524-64c4-67eafed54697@intel.com>
Date:   Wed, 27 Apr 2022 10:50:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCHv1 08/19] mmc: sdhci-of-dwcmshc: add reset call back for
 rockchip Socs
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
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
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220422170920.401914-9-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/22 20:09, Sebastian Reichel wrote:
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

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

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
> +	if (IS_ERR_OR_NULL(priv->reset)) {
> +		err = PTR_ERR(priv->reset);
> +		dev_err(mmc_dev(host->mmc), "failed to get reset control %d\n", err);
> +		return err;
> +	}
> +
>  	priv->rockchip_clks[0].id = "axi";
>  	priv->rockchip_clks[1].id = "block";
>  	priv->rockchip_clks[2].id = "timer";

