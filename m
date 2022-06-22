Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9228554873
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352265AbiFVI6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245255AbiFVI6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:58:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC6033E17;
        Wed, 22 Jun 2022 01:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655888297; x=1687424297;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U8gy03Q4jQrZZhWStg1EdzgEeFefaKvkMwEkHvh6v3Y=;
  b=gzmIDSDBj6G0z8BcNJzunN6KweDjyKbDM2+CfjghelEAV6qvco8wQveY
   MKxf5o71qtG89G20N8W3rD9cxMLBQHKy9ScUMHCNh/np32lVVy2HNPhJ8
   x4EOaygkNrbFBypOcDacZjJPBjPymGWpcsLuMzYq/L1xUXsPpfXKlbYae
   DwFd3xae88qz9y86au8FSBk8P8tzNq7lRg/IIhH9Tx5NiIxGCFGq6HAKc
   UiC0lgv9bsDXZC9Y+dXkF9p3DdBEIggRiZ3OTbluE457YH3rgefuSieX5
   wiG3CNquqau2Kl6JGe9xqsubNYP6SurRltNHrQbq1GEidObQJDY1Q04Zk
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="277907874"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="277907874"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 01:58:17 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="644086023"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.59.193])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 01:58:15 -0700
Message-ID: <569cc212-d1b1-d433-1f61-f94bf8037251@intel.com>
Date:   Wed, 22 Jun 2022 11:58:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH -next] mmc: sdhci-pci-gli: Fix build error unused-function
Content-Language: en-US
To:     Ren Zhijie <renzhijie2@huawei.com>, ulf.hansson@linaro.org,
        reniuschengl@gmail.com, jasonlai.genesyslogic@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220619104712.125364-1-renzhijie2@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220619104712.125364-1-renzhijie2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/22 13:47, Ren Zhijie wrote:
> If CONFIG_PM is not set.
> 
> make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-, will be failed, like this:
> 
> drivers/mmc/host/sdhci-pci-gli.c:834:13: error: ‘gl9763e_set_low_power_negotiation’ defined but not used [-Werror=unused-function]
>  static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot, bool enable)
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[3]: *** [drivers/mmc/host/sdhci-pci-gli.o] Error 1
> 
> To fix building warning, wrap all related code with CONFIG_PM.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 78fe993ae714("mmc: host: Improve I/O read/write performance for GL9763E")
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 50 ++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index a76506adc206..4d509f656188 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -831,31 +831,6 @@ static void sdhci_gl9763e_dumpregs(struct mmc_host *mmc)
>  	sdhci_dumpregs(mmc_priv(mmc));
>  }
>  
> -static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot, bool enable)
> -{
> -	struct pci_dev *pdev = slot->chip->pdev;
> -	u32 value;
> -
> -	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> -	value &= ~GLI_9763E_VHS_REV;
> -	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
> -	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> -
> -	pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
> -
> -	if (enable)
> -		value &= ~GLI_9763E_CFG_LPSN_DIS;
> -	else
> -		value |= GLI_9763E_CFG_LPSN_DIS;
> -
> -	pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
> -
> -	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> -	value &= ~GLI_9763E_VHS_REV;
> -	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> -	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> -}
> -
>  static void sdhci_gl9763e_cqe_pre_enable(struct mmc_host *mmc)
>  {
>  	struct cqhci_host *cq_host = mmc->cqe_private;
> @@ -991,6 +966,31 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>  }
>  
>  #ifdef CONFIG_PM
> +static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot, bool enable)
> +{
> +	struct pci_dev *pdev = slot->chip->pdev;
> +	u32 value;
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> +	value &= ~GLI_9763E_VHS_REV;
> +	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
> +	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
> +
> +	if (enable)
> +		value &= ~GLI_9763E_CFG_LPSN_DIS;
> +	else
> +		value |= GLI_9763E_CFG_LPSN_DIS;
> +
> +	pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> +	value &= ~GLI_9763E_VHS_REV;
> +	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> +	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> +}
> +
>  static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
>  {
>  	struct sdhci_pci_slot *slot = chip->slots[0];

