Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEF45641AD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 18:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbiGBQvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 12:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbiGBQvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 12:51:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9E2DEA7;
        Sat,  2 Jul 2022 09:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656780691; x=1688316691;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h7voj+BdHoDXvLIKv/HQlK6DZFrt0N8+nXagOZ9WsGY=;
  b=fxT1bj+TLMhE1l4nIxuLnU+EQCoK6vHpuYYM4fyJC8Eq/xvKQMd720t6
   kOTWWNRfsK+yGRzuUsR62O9Q+rmbaVzszGv4bFAQhZJ7LEJUzo5vVckZs
   r0de6fQ1CKWo8BaGaxiG2XfhqGRwe0gGPywL7BTykbqUk9U+wEBrhLP/I
   wcNSTXk9DFn6EJIrdeb8ODXOqs7xVta2j5B1ZcOwRzP2rXnPSAJBPH+cm
   IDONItKlLMPicQQh1pXxn+nHfyqDWuq05VK/RcDad0Cm7Q+c6pAu4bYbR
   K3uYwxJLi+L0zt2ZbxFnAZHHWQNbFc0FMyVjuWyX+kEf2euwT3f+iFyQi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="280405822"
X-IronPort-AV: E=Sophos;i="5.92,240,1650956400"; 
   d="scan'208";a="280405822"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 09:51:31 -0700
X-IronPort-AV: E=Sophos;i="5.92,240,1650956400"; 
   d="scan'208";a="648788101"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.83])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 09:51:29 -0700
Message-ID: <e560121e-6f3b-9188-7ccb-97357881e390@intel.com>
Date:   Sat, 2 Jul 2022 19:51:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH] mmc: sdhci-of-at91: fix set_uhs_signaling rewriting of
 MC1R
Content-Language: en-US
To:     Eugen Hristev <eugen.hristev@microchip.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Karl Olsen <karl@micro-technic.com>
References: <20220630090926.15061-1-eugen.hristev@microchip.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220630090926.15061-1-eugen.hristev@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/22 12:09, Eugen Hristev wrote:
> In set_uhs_signaling, the DDR bit is being set by fully writing the MC1R
> register.
> This can lead to accidental erase of certain bits in this register.
> Avoid this by doing a read-modify-write operation.
> 
> Fixes: d0918764c17b ("mmc: sdhci-of-at91: fix MMC_DDR_52 timing selection")
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> Tested-by: Karl Olsen <karl@micro-technic.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-at91.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 10fb4cb2c731..cd0134580a90 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -100,8 +100,13 @@ static void sdhci_at91_set_clock(struct sdhci_host *host, unsigned int clock)
>  static void sdhci_at91_set_uhs_signaling(struct sdhci_host *host,
>  					 unsigned int timing)
>  {
> -	if (timing == MMC_TIMING_MMC_DDR52)
> -		sdhci_writeb(host, SDMMC_MC1R_DDR, SDMMC_MC1R);
> +	u8 mc1r;
> +
> +	if (timing == MMC_TIMING_MMC_DDR52) {
> +		mc1r = sdhci_readb(host, SDMMC_MC1R);
> +		mc1r |= SDMMC_MC1R_DDR;
> +		sdhci_writeb(host, mc1r, SDMMC_MC1R);
> +	}
>  	sdhci_set_uhs_signaling(host, timing);
>  }
>  

