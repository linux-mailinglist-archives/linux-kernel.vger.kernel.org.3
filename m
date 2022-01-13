Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6B348D26A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 07:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiAMGoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 01:44:17 -0500
Received: from mga14.intel.com ([192.55.52.115]:14266 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231876AbiAMGoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 01:44:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642056253; x=1673592253;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Z4HhKchxZusULm7Y/UuoDfzSQXkgGXkyTX7IePL/d9c=;
  b=ffiPvoIOKA2u6Z5WhJe29PdQgrkyO1r31NtPmPtPA7BN8ILZugt5VMls
   bPGakQBFl5xbyVyqmhY7di+6oRE2R1oSqe40jiqRAIGU4h67Q2Z/JTpG+
   DjePYMLh0F6ymeauJPCgQ8PAsoSZpTcNRIppTeMt4poRA+D+xysauGfwv
   Z2ChTvb35+ZkA2IVOET0k+8kC5zp8C6Yku1s9eFGCi/+UhnQCK8k+h/H4
   /ZgA+VjAFZvJnjNl8cqaCPzZ6EzkuQMMhy4X3JiUe0pCEhuJRt50yPc/W
   6Ef4tYmocx0ed8sePbYnrQ64ZFtjymKRtzLNH4qS339pLYAZP6C0ihERh
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="244148621"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="244148621"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 22:44:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="529541897"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 12 Jan 2022 22:44:09 -0800
Subject: Re: [PATCH] mmc: tegra: Enable wake on SD card event
To:     Aniruddha Rao <anrao@nvidia.com>, ulf.hansson@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de
Cc:     linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1642050969-21152-1-git-send-email-anrao@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4108cce3-ed97-faa7-41a3-8ffbd8473525@intel.com>
Date:   Thu, 13 Jan 2022 08:44:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1642050969-21152-1-git-send-email-anrao@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2022 07:16, Aniruddha Rao wrote:
> Enable GPIO wake source on SD card detect line.
> Physical card insertion/removal event should wake the system
> from suspend.
> 
> Signed-off-by: Aniruddha Rao <anrao@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 35ebba0..5c84bd5 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1673,6 +1673,9 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>  	/* HW busy detection is supported, but R1B responses are required. */
>  	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
>  
> +	/* GPIO CD can be set as a wakeup source */
> +	host->mmc->caps |= MMC_CAP_CD_WAKE;
> +
>  	tegra_sdhci_parse_dt(host);
>  
>  	tegra_host->power_gpio = devm_gpiod_get_optional(&pdev->dev, "power",
> @@ -1840,7 +1843,7 @@ static int sdhci_tegra_suspend(struct device *dev)
>  		return ret;
>  	}
>  
> -	return 0;
> +	return mmc_gpio_set_cd_wake(host->mmc, true);
>  }
>  
>  static int sdhci_tegra_resume(struct device *dev)
> @@ -1848,6 +1851,10 @@ static int sdhci_tegra_resume(struct device *dev)
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	int ret;
>  
> +	ret = mmc_gpio_set_cd_wake(host->mmc, false);
> +	if (ret)
> +		return ret;
> +
>  	ret = pm_runtime_force_resume(dev);
>  	if (ret)
>  		return ret;
> 

