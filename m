Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A294D8617
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 14:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241878AbiCNNjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 09:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241982AbiCNNj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 09:39:29 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F059B193E1;
        Mon, 14 Mar 2022 06:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647265095; x=1678801095;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AHI/JJbTZfROueDYE5RJAT/7Do58iIUYLmMbqYg/tQ8=;
  b=CfpeUVkdInDWP5qerM1qYWEf1aC3bK/zmCJ+IN0efb+/6TYqptEvY5lu
   kYIyPHk1rDQVo9399MccZz1F5xDE2KickKnOQ6QWcTV0KbYq6HVz+ufGi
   Cu8U1zvjav3qbocW3YTyA3xRiloPThCOIskTTyuzP1J3D4AbqgaPAuokp
   9B7R5YE0vIKS7uRgxGYfDtQic9e4jeZkdWoqqIlZoWR/znLRuJiweZUOw
   5srauU9ZYBpmptR9HdjARK/MSAFSx12FpQgA1PfftCEqpIQGuDrBALvWU
   SZB57B/XTUvhtGo4WxFXccpJ30I2/MxI5KpHGa7HJ1bIdk9DJBfvCTNL1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="235975176"
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="235975176"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 06:38:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="515427504"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga006.jf.intel.com with ESMTP; 14 Mar 2022 06:38:12 -0700
Message-ID: <f394b9fd-443b-953c-3c4b-596ae4348a58@intel.com>
Date:   Mon, 14 Mar 2022 15:38:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH V2] mmc: sdhci-pci-gli: Add runtime PM for GL9763E
Content-Language: en-US
To:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        greg.tu@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
        SeanHY.Chen@genesyslogic.com.tw, hl.liu@genesyslogic.com.tw,
        Kevin Chang <kevin.chang@lcfuturecenter.com>
References: <20220307090009.1386876-1-benchuanggli@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220307090009.1386876-1-benchuanggli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 11:00, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> Add runtime PM for GL9763E and disable PLL in runtime suspend. So power
> gated of upstream port can be enabled. GL9763E has an auxiliary power
> so it keep states in runtime suspend. In runtime resume, PLL is enabled
> and waits for it to stabilize.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Tested-by: Kevin Chang <kevin.chang@lcfuturecenter.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes in v2:
> * modify commit messages
> * Use read_poll_timeout() instead of while loop
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 47 ++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 97035d77c18c..c854c8db32e4 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -13,6 +13,7 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/delay.h>
>  #include <linux/of.h>
> +#include <linux/iopoll.h>
>  #include "sdhci.h"
>  #include "sdhci-pci.h"
>  #include "cqhci.h"
> @@ -873,6 +874,47 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>  	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
>  }
>  
> +#ifdef CONFIG_PM
> +static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
> +{
> +	struct sdhci_pci_slot *slot = chip->slots[0];
> +	struct sdhci_host *host = slot->host;
> +	u16 clock;
> +
> +	clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	clock &= ~(SDHCI_CLOCK_PLL_EN | SDHCI_CLOCK_CARD_EN);
> +	sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> +
> +	return 0;
> +}
> +
> +static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
> +{
> +	struct sdhci_pci_slot *slot = chip->slots[0];
> +	struct sdhci_host *host = slot->host;
> +	u16 clock;
> +
> +	clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +
> +	clock |= SDHCI_CLOCK_PLL_EN;
> +	clock &= ~SDHCI_CLOCK_INT_STABLE;
> +	sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> +
> +	/* Wait max 150 ms */
> +	if (read_poll_timeout(sdhci_readw, clock, (clock & SDHCI_CLOCK_INT_STABLE),
> +			      1000, 150000, false, host, SDHCI_CLOCK_CONTROL)) {
> +		pr_err("%s: PLL clock never stabilised.\n",
> +		       mmc_hostname(host->mmc));
> +		sdhci_dumpregs(host);
> +	}
> +
> +	clock |= SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> +
> +	return 0;
> +}
> +#endif
> +
>  static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
>  {
>  	struct pci_dev *pdev = slot->chip->pdev;
> @@ -982,6 +1024,11 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
>  #ifdef CONFIG_PM_SLEEP
>  	.resume		= sdhci_cqhci_gli_resume,
>  	.suspend	= sdhci_cqhci_gli_suspend,
> +#endif
> +#ifdef CONFIG_PM
> +	.runtime_suspend = gl9763e_runtime_suspend,
> +	.runtime_resume  = gl9763e_runtime_resume,
> +	.allow_runtime_pm = true,
>  #endif
>  	.add_host       = gl9763e_add_host,
>  };

