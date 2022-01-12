Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D54A48BECF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351102AbiALHGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:06:39 -0500
Received: from mga05.intel.com ([192.55.52.43]:33619 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237328AbiALHGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641971198; x=1673507198;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=w1S6Ea3urNn5/maW8twjQA1LVYjr4EJNP9bamJwc15Y=;
  b=UuPxU7y8SQi8k7vdZ/zTXb01ntsy0BYrKWC7CBKrBZmmQ+W8LvPXf+tK
   gRRIubLn2HVrdHGxnvm/hv19GOin+GUA06umEeeoN+yfYwNsoIdgYvhbx
   hAATAyDtNug0ZBRX0cNc6Vt8QqELIzAYWRe8ksnMku0ZHSjeTjsMWezPZ
   nMCPzL6GE0q6FjFapNh35okJypgFJLjGvqUw19KLti/9TCDIzA2fIyUDs
   szHFnn3aRw/vwcjL2EdNRe5bZddpKIF7453jhu73iy2iRhfdayp4jqRWf
   tgIwLEz7NYUcS9j4sDDqGS84cfRCXXnVLiOraVp68JMYJXhae26MKzmxe
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="330022111"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="330022111"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 23:06:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="472736893"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga003.jf.intel.com with ESMTP; 11 Jan 2022 23:06:36 -0800
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: Check for error num after setting
 mask
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220106021638.2527426-1-jiasheng@iscas.ac.cn>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ae5373d2-372a-5eb6-1b2a-7b1dae888355@intel.com>
Date:   Wed, 12 Jan 2022 09:06:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220106021638.2527426-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2022 04:16, Jiasheng Jiang wrote:
> Because of the possible failure of the dma_supported(), the
> dma_set_mask_and_coherent() may return error num.
> Therefore, it should be better to check it and return the error if
> fails.
> Also, the caller, esdhc_of_resume(), should deal with the return value.
> Moreover, as the sdhci_esdhc_driver has not been used, it does not need to
> be considered.

Apologies, but that last sentence I don't understand.  Can you clarify it a bit.
What doesn't need to be considered and why?

> 
> Fixes: 5552d7ad596c ("mmc: sdhci-of-esdhc: set proper dma mask for ls104x chips")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index a593b1fbd69e..bedfc7bb5174 100644
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
> @@ -1245,7 +1249,10 @@ static int esdhc_of_resume(struct device *dev)
>  
>  	if (ret == 0) {
>  		/* Isn't this already done by sdhci_resume_host() ? --rmk */
> -		esdhc_of_enable_dma(host);
> +		ret = esdhc_of_enable_dma(host);
> +		if (ret)
> +			return ret;
> +

This is already done by sdhci_resume_host(), which assumes there can be no
error if DMA has been enabled previously i.e. -> enable_dma() is called
at setup and the return value checked then.  If it is possible that DMA
support can disappear later, then it would be better to address that in
SDHCI so that all SDHCI drivers get the benefit.

>  		sdhci_writel(host, esdhc_proctl, SDHCI_HOST_CONTROL);
>  	}
>  	return ret;
> 

