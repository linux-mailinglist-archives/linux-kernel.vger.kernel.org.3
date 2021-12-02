Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DC6465E54
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 07:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345361AbhLBGnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 01:43:04 -0500
Received: from mga09.intel.com ([134.134.136.24]:4228 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236674AbhLBGnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 01:43:02 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="236451673"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="236451673"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 22:39:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="459530687"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga003.jf.intel.com with ESMTP; 01 Dec 2021 22:39:37 -0800
Subject: Re: [PATCH] mmc: sdhci-tegra: Add support to enumerate in HS400ES
 mode
To:     Prathamesh Shete <pshete@nvidia.com>, ulf.hansson@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     anrao@nvidia.com
References: <20211129111047.5299-1-pshete@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <0a8368f9-8ca2-f01b-2f9e-0c91e3b946f5@intel.com>
Date:   Thu, 2 Dec 2021 08:39:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211129111047.5299-1-pshete@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2021 13:10, Prathamesh Shete wrote:
> When CMD13 is sent after switching to HS400 mode, the bus
> is operating at either MMC_HIGH_26_MAX_DTR or MMC_HIGH_52_MAX_DTR.
> To meet Tegra SDHCI requirement at HS400 mode, force SDHCI
> interface clock to MMC_HS200_MAX_DTR (200 MHz) so that host
> controller CAR clock and the interface clock are rate matched.

This sounds like an issue with or without enhanced strobe?

Also it seems more like a fix than "adding support".
i.e. is this really "mmc: sdhci-tegra: Fix switch to HS400ES mode" ?

> 
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 387ce9cdbd7c..d800396d1112 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -123,6 +123,8 @@
>  					 SDHCI_TRNS_BLK_CNT_EN | \
>  					 SDHCI_TRNS_DMA)
>  
> +static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock);

Please move one of the functions so that the forward declaration is not necessary.

> +
>  struct sdhci_tegra_soc_data {
>  	const struct sdhci_pltfm_data *pdata;
>  	u64 dma_mask;
> @@ -369,6 +371,16 @@ static void tegra_sdhci_hs400_enhanced_strobe(struct mmc_host *mmc,
>  
>  	sdhci_writel(host, val, SDHCI_TEGRA_VENDOR_SYS_SW_CTRL);
>  
> +	/*
> +	 * When CMD13 is sent after switching to HS400 mode, the bus
> +	 * is operating at either MMC_HIGH_26_MAX_DTR or
> +	 * MMC_HIGH_52_MAX_DTR.
> +	 * To meet Tegra SDHCI requirement at HS400 mode, force SDHCI
> +	 * interface clock to MMC_HS200_MAX_DTR (200 MHz) so that host
> +	 * controller CAR clock and the interface clock are rate matched.
> +	 */
> +	tegra_sdhci_set_clock(host, MMC_HS200_MAX_DTR);

This being done irrespective of ios->enhanced_strobe, which doesn't seem
right based on the comment?

> +

Please remove the blank line.

>  }
>  
>  static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
> 

