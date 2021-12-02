Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BDA466556
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358592AbhLBOi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:38:27 -0500
Received: from mga03.intel.com ([134.134.136.65]:6732 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358563AbhLBOi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:38:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="236657710"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="236657710"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 06:35:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="459675001"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga003.jf.intel.com with ESMTP; 02 Dec 2021 06:35:01 -0800
Subject: Re: [PATCH v2] mmc: sdhci-tegra: Fix switch to HS400ES mode
To:     Prathamesh Shete <pshete@nvidia.com>, ulf.hansson@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     anrao@nvidia.com, smangipudi@nvidia.com
References: <0a8368f9-8ca2-f01b-2f9e-0c91e3b946f5@intel.com>
 <20211202134948.18448-1-pshete@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <bf629e1b-c61d-37e7-8802-b6d778f89c21@intel.com>
Date:   Thu, 2 Dec 2021 16:35:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211202134948.18448-1-pshete@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2021 15:49, Prathamesh Shete wrote:
> When CMD13 is sent after switching to HS400ES mode, the bus
> is operating at either MMC_HIGH_26_MAX_DTR or MMC_HIGH_52_MAX_DTR.
> To meet Tegra SDHCI requirement at HS400ES mode, force SDHCI
> interface clock to MMC_HS200_MAX_DTR (200 MHz) so that host
> controller CAR clock and the interface clock are rate matched.
> 
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 43 ++++++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 387ce9cdbd7c..ca261cce9b37 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -354,23 +354,6 @@ static void tegra_sdhci_set_tap(struct sdhci_host *host, unsigned int tap)
>  	}
>  }
>  
> -static void tegra_sdhci_hs400_enhanced_strobe(struct mmc_host *mmc,
> -					      struct mmc_ios *ios)
> -{
> -	struct sdhci_host *host = mmc_priv(mmc);
> -	u32 val;
> -
> -	val = sdhci_readl(host, SDHCI_TEGRA_VENDOR_SYS_SW_CTRL);
> -
> -	if (ios->enhanced_strobe)
> -		val |= SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE;
> -	else
> -		val &= ~SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE;
> -
> -	sdhci_writel(host, val, SDHCI_TEGRA_VENDOR_SYS_SW_CTRL);
> -
> -}
> -
>  static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -791,6 +774,32 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>  	}
>  }
>  
> +static void tegra_sdhci_hs400_enhanced_strobe(struct mmc_host *mmc,
> +					      struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	u32 val;
> +
> +	val = sdhci_readl(host, SDHCI_TEGRA_VENDOR_SYS_SW_CTRL);
> +
> +	if (ios->enhanced_strobe)
> +		val |= SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE;
> +	else
> +		val &= ~SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE;
> +
> +	sdhci_writel(host, val, SDHCI_TEGRA_VENDOR_SYS_SW_CTRL);
> +
> +	/*
> +	 * When CMD13 is sent from mmc_select_hs400es() after
> +	 * switching to HS400ES mode, the bus is operating at
> +	 * either MMC_HIGH_26_MAX_DTR or MMC_HIGH_52_MAX_DTR.
> +	 * To meet Tegra SDHCI requirement at HS400ES mode, force SDHCI
> +	 * interface clock to MMC_HS200_MAX_DTR (200 MHz) so that host
> +	 * controller CAR clock and the interface clock are rate matched.

Still doesn't explain why you want to set MMC_HS200_MAX_DTR when
ios->enhanced_strobe is false e.g. mmc_set_initial_state()

> +	 */
> +	tegra_sdhci_set_clock(host, MMC_HS200_MAX_DTR);
> +}
> +
>  static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> 

