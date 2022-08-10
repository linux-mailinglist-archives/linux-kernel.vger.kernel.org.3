Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038B258EC97
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 14:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiHJM7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 08:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiHJM6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:58:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EB361119;
        Wed, 10 Aug 2022 05:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660136327; x=1691672327;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BBnKiVqt2WWasptdQSbKfy0NnuckVrtBIjskjHg01Jo=;
  b=YcPyi62mIl1drbWw3Lx/xcMyJQYCcld7heujyOnHyCDCESKomd6LfHfd
   LZ13j9gRtaQs9xEUoWuva/PA0KwkX41RUN77QPjBxTbkq7p9EFffwwCdM
   uplna1tT26ajdDcIabBicNnHvqX3HFsSX1CSdcdsXooCxJBCR2pftI4OX
   iiIc/klPL8ZxqJcgvbJEMQffSDNHHbjB0CPqOfRUJWwyGPvSM6zkffPEu
   XEhOpwTsSCDWl58ze+TjtjJTwNK4WmJGm4u3qtEfLh4sMAaoF+QLpK9Aj
   XIWNX1ENcmdn95rLmcFFPknoU66coB3eWFitPdbKmVsCIPKa1BZWhp5y6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="291862946"
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="291862946"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 05:58:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="664885826"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.166])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 05:58:43 -0700
Message-ID: <765c3b77-9573-d48f-39a9-c311a62542ec@intel.com>
Date:   Wed, 10 Aug 2022 15:58:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3] mmc: sdhci-of-dwcmshc: add ACPI match data for
 BlueField-3 SoC
Content-Language: en-US
To:     Liming Sun <limings@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Woods <davwoods@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3a50873fdbf69f4a95b931a5d05cade04c1dacd0.1659099154.git.limings@nvidia.com>
 <20220809173742.178440-1-limings@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220809173742.178440-1-limings@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/08/22 20:37, Liming Sun wrote:
> Commit 08f3dff799d43 introduces the of_device_get_match_data()
> checking for some chip but breaks the BlueField-3 firmware which
> uses ACPI instead. This commit adds the ACPI match data and
> quirks/quirks2 to re-enable the support of BlueField-3 SoC.
> 
> Reviewed-by: David Woods <davwoods@nvidia.com>
> Signed-off-by: Liming Sun <limings@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> v2->v3:
>     Rebase to mmc next
> v1->v2:
>     Fixes an acpi warning
>     Reported-by: kernel test robot <lkp@intel.com>
> v1: Initial version.
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 4e904850973c..a7343d4bc50e 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -349,6 +349,15 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  };
>  
> +#ifdef CONFIG_ACPI
> +static const struct sdhci_pltfm_data sdhci_dwcmshc_bf3_pdata = {
> +	.ops = &sdhci_dwcmshc_ops,
> +	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +		   SDHCI_QUIRK2_ACMD23_BROKEN,
> +};
> +#endif
> +
>  static const struct sdhci_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
>  	.ops = &sdhci_dwcmshc_rk35xx_ops,
>  	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> @@ -431,7 +440,10 @@ MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
>  
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id sdhci_dwcmshc_acpi_ids[] = {
> -	{ .id = "MLNXBF30" },
> +	{
> +		.id = "MLNXBF30",
> +		.driver_data = (kernel_ulong_t)&sdhci_dwcmshc_bf3_pdata,
> +	},
>  	{}
>  };
>  #endif
> @@ -447,7 +459,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	int err;
>  	u32 extra;
>  
> -	pltfm_data = of_device_get_match_data(&pdev->dev);
> +	pltfm_data = device_get_match_data(&pdev->dev);
>  	if (!pltfm_data) {
>  		dev_err(&pdev->dev, "Error: No device match data found\n");
>  		return -ENODEV;

