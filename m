Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD9948C0C6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 10:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351962AbiALJK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 04:10:28 -0500
Received: from mga14.intel.com ([192.55.52.115]:38920 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351954AbiALJKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641978622; x=1673514622;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=tOleNNII3LcX22NThqepoEH8by+M+skaN1NYX5+X33s=;
  b=YmYAcar0JIi1y1vd/aR0M21fb42xIDRA9Izx9JGCZNi7xLpCyHW+rkVP
   SGYrbDAo3K2xfZBe2jD2PqxcDK1czFmsKzsq+4qf4PCKC7PQL7E/fLKTA
   jtaw90W+tqM7zPflx14JnTzozqJHEDJvfQKdiKt79AFts/DF0wIKcx6aE
   shlxo94rZjN9mGpFDLkL+f0bzjtfEmvjU1uLBL3DEelPW+2pXJfBK4lX8
   9soN6EWRPwsCUhXXPgegbVsYybKOS2fcw8feWHIll3WqILuWJeedKddeQ
   gsg62rEqtRHdAxIBvPoiX7UyIdacxNtN7+KXrNaYwycs0YT0me8bnMAfw
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="243895608"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="243895608"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 01:10:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="472765889"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga003.jf.intel.com with ESMTP; 12 Jan 2022 01:10:19 -0800
Subject: Re: [PATCH v2] mmc: sdhci-of-esdhc: Check for error num after setting
 mask
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220112083156.1124782-1-jiasheng@iscas.ac.cn>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <87a5b5d2-d980-bbac-913b-0d9d4bd521a2@intel.com>
Date:   Wed, 12 Jan 2022 11:10:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220112083156.1124782-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2022 10:31, Jiasheng Jiang wrote:
> Because of the possible failure of the dma_supported(), the
> dma_set_mask_and_coherent() may return error num.
> Therefore, it should be better to check it and return the error if
> fails.
> And since the sdhci_setup_host() has already checked the return value of
> the enable_dma, we need not check it in sdhci_resume_host() again.
> 
> Fixes: 5552d7ad596c ("mmc: sdhci-of-esdhc: set proper dma mask for ls104x chips")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changelog
> 
> v1 -> v2
> 
> * Change 1. Remove the change of esdhc_of_resume and refine the commit
> * message.
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index a593b1fbd69e..0f3658b36513 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -524,12 +524,16 @@ static void esdhc_of_adma_workaround(struct sdhci_host *host, u32 intmask)
>  
>  static int esdhc_of_enable_dma(struct sdhci_host *host)
>  {
> +	int ret;
>  	u32 value;
>  	struct device *dev = mmc_dev(host->mmc);
>  
>  	if (of_device_is_compatible(dev->of_node, "fsl,ls1043a-esdhc") ||
> -	    of_device_is_compatible(dev->of_node, "fsl,ls1046a-esdhc"))
> -		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
> +	    of_device_is_compatible(dev->of_node, "fsl,ls1046a-esdhc")) {
> +		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
> +		if (ret)
> +			return ret;
> +	}
>  
>  	value = sdhci_readl(host, ESDHC_DMA_SYSCTL);
>  
> 

