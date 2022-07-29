Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462A8584E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 12:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbiG2KVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 06:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiG2KVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 06:21:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD8F74CD1;
        Fri, 29 Jul 2022 03:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659090076; x=1690626076;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Yxu2G4VGiPVcwxTHTFYMsriLmADUxTrXB7PoN2zpY4s=;
  b=FMOrT/uAQ9gYo1OYN6e13DfEqfByalfc7BtGvQDSzrz5pQ1ZFBDQuWbv
   Ib84QesuM31xg82yYVBgkcy236Z6L7Re6NNMWPXI63tc7cwFhVPsGLUZp
   FJnzMTV28H1ktuy6IBl4v1ml/ljuiLiZ2iBV2Cox0n7gnb9yq3/U7BWnS
   +0I/STe+LzubbcHIr1r8LQneQfP+kiwLo48Q+i0KHQ7JqbXvIAkE/EW4+
   7NPDcPS4DIZT0XjKLfkJ6KSZ1Fp/SrIp4g2Pfscunx7N+rICq5hQjtRbV
   2bMG0S1mUOCDDvHG9pnME/eb6LlWAEFrL6Hizli04lVSDu8eSPiVivzxW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="275623948"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="275623948"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 03:21:15 -0700
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="660179185"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.46.142])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 03:21:13 -0700
Message-ID: <ec9422fa-664b-3c40-f5d5-283bca81f099@intel.com>
Date:   Fri, 29 Jul 2022 13:21:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH V2 1/1] mmc: sdhci-pci-o2micro: fix some SD cards
 compatibility issue at DDR50 mode
Content-Language: en-US
To:     Chevron Li <chevron.li@bayhubtech.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, shirley.her@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com
References: <20220729100524.387-1-chevron.li@bayhubtech.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220729100524.387-1-chevron.li@bayhubtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/22 13:05, Chevron Li wrote:
> Bayhub chips have better compatibility support for SDR50 than DDR50
> and both mode have the same R/W performance when clock frequency >= 100MHz.
> Disable DDR50 mode and use SDR50 instead.
> 
> Signed-off-by: Chevron Li <chevron.li@bayhubtech.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes on V1:
> 1.Set quirks2 flag SDHCI_QUIRK2_BROKEN_DDR50 for bayhub chips.
> 2.Use bayhub hardware input tuning for SDR50 mode instead of standard tuning flow.
> 
> Changes on V2:
> Update commit format and information.
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 0d4d343dbb77..ad457cd9cbaa 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -317,11 +317,12 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	u32 reg_val;
>  
>  	/*
> -	 * This handler only implements the eMMC tuning that is specific to
> +	 * This handler implements the hardware tuning that is specific to
>  	 * this controller.  Fall back to the standard method for other TIMING.
>  	 */
>  	if ((host->timing != MMC_TIMING_MMC_HS200) &&
> -		(host->timing != MMC_TIMING_UHS_SDR104))
> +		(host->timing != MMC_TIMING_UHS_SDR104) &&
> +		(host->timing != MMC_TIMING_UHS_SDR50))
>  		return sdhci_execute_tuning(mmc, opcode);
>  
>  	if (WARN_ON((opcode != MMC_SEND_TUNING_BLOCK_HS200) &&
> @@ -631,6 +632,8 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  		if (reg & 0x1)
>  			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>  
> +		host->quirks2 |= SDHCI_QUIRK2_BROKEN_DDR50;
> +
>  		sdhci_pci_o2_enable_msi(chip, host);
>  
>  		if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD0) {
> 
> base-commit: 68e77ffbfd06ae3ef8f2abf1c3b971383c866983

