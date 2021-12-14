Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3E5473CDC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 07:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhLNGBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 01:01:30 -0500
Received: from mga14.intel.com ([192.55.52.115]:34295 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhLNGB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 01:01:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639461689; x=1670997689;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ci/qhNRNS7RvrPrSsDjgrZYNVw1Al3ceB7ixpdUcULc=;
  b=gj3CwvxKikDXRyMnth1x4/rOp3fSK7n3nJEA1oY6iOrN6BI25XlH+RU+
   BB9eIuNWppNEeCmFTTBb3cs3jDd64Sn0UyhwRz2R7UOd3wdjZKGgoMk/A
   t7wl2D4Pjw12yibYPAJUkYhVjYiOesWJYEX54erChb/psCeYWTgSzKrRi
   NzEOahGrCIjAw1xovlBX8Qtyiv6EU9h5jApYh5a2H5uKPB/ljLtqyTtQl
   xg0ljdbabbnAqkFToOu7OPc5cHvf4E/z/rXTdWtwQG84E7lV+HZI8KJZR
   y+k+pAKCRV7HUXebSUOOfGDSPuv5s32zuukoyUHgX81HSXVPd4XiYUGqH
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="239129194"
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="239129194"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 22:01:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="464942290"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga006.jf.intel.com with ESMTP; 13 Dec 2021 22:01:25 -0800
Subject: Re: [PATCH v3] mmc: sdhci-tegra: Fix switch to HS400ES mode
To:     Prathamesh Shete <pshete@nvidia.com>, ulf.hansson@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     anrao@nvidia.com, smangipudi@nvidia.com
References: <bf629e1b-c61d-37e7-8802-b6d778f89c21@intel.com>
 <20211206140541.17148-1-pshete@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3dd2473a-00ca-4c62-e17f-9392cf74cda4@intel.com>
Date:   Tue, 14 Dec 2021 08:01:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211206140541.17148-1-pshete@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2021 16:05, Prathamesh Shete wrote:
> When CMD13 is sent after switching to HS400ES mode, the bus
> is operating at either MMC_HIGH_26_MAX_DTR or MMC_HIGH_52_MAX_DTR.
> To meet Tegra SDHCI requirement at HS400ES mode, force SDHCI
> interface clock to MMC_HS200_MAX_DTR (200 MHz) so that host
> controller CAR clock and the interface clock are rate matched.
> 
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>

One minor comment below otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 43 ++++++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 387ce9cdbd7c..ddaa3d9000f6 100644
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
> +	if (ios->enhanced_strobe) {
> +		val |= SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE;
> +	/*
> +	 * When CMD13 is sent from mmc_select_hs400es() after
> +	 * switching to HS400ES mode, the bus is operating at
> +	 * either MMC_HIGH_26_MAX_DTR or MMC_HIGH_52_MAX_DTR.
> +	 * To meet Tegra SDHCI requirement at HS400ES mode, force SDHCI
> +	 * interface clock to MMC_HS200_MAX_DTR (200 MHz) so that host
> +	 * controller CAR clock and the interface clock are rate matched.
> +	 */
> +	tegra_sdhci_set_clock(host, MMC_HS200_MAX_DTR);

Comment and line above need indenting

> +	} else {
> +		val &= ~SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE;
> +	}
> +
> +	sdhci_writel(host, val, SDHCI_TEGRA_VENDOR_SYS_SW_CTRL);
> +}
> +
>  static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> 

