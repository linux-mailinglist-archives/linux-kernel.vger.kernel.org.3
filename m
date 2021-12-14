Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F954740A0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhLNKlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:41:42 -0500
Received: from mga18.intel.com ([134.134.136.126]:8412 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233140AbhLNKll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639478501; x=1671014501;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=nD1dWC4ja2jEDV7QrfC4Kkllk7voDyF5NiShZMOJOkE=;
  b=JxQ9Jtd3/m/W2roMAzPZe3Sw1XR5iX8926rYsXtg3yYxHzmkLnkpjpyb
   1rtoyvERVz23wAb0kG+cCP832U4HyKKBepdn9XKYYzT7oSzE+klmac+8K
   Zl480ywDkTgsG2YkF9dMPB8OzOg7qK8t6nnJpb3TeFMCTjDdfnzmJV9RQ
   fy7e58jhz21xyK1SmbyJ5uwdxXSpTS/YjQ8EbIJqNjbfXyMGJU1zQMpB5
   RcxUO5LTueHVZ4Av9JM0/vWHCrp/ivuCfXaSiYA9Ju7XxrO7XnlMLxhe7
   YafmrJidu2RNEEBDOn2sf2MSIyUizQLsw84j/6ebIXk25qCuYp4kUQWfn
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="225810798"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="225810798"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 02:41:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="465030158"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga006.jf.intel.com with ESMTP; 14 Dec 2021 02:41:38 -0800
Subject: Re: [PATCH v2 1/2] mmc: sdhci-pci-gli: GL9755: Support for CD/WP
 inversion on OF platforms
To:     Hector Martin <marcan@marcan.st>,
        Ben Chuang <benchuanggli@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20211212070210.141664-1-marcan@marcan.st>
 <20211212070210.141664-2-marcan@marcan.st>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <72e29a9d-7e2a-5c2e-c44b-42172aae4f2d@intel.com>
Date:   Tue, 14 Dec 2021 12:41:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211212070210.141664-2-marcan@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2021 09:02, Hector Martin wrote:
> This is required on some Apple ARM64 laptops using this controller.
> As is typical on DT platforms, pull these quirks from the device tree
> using the standard mmc bindings.
> 
> See Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>

A couple of kernel style issues, but fix those and you can add:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 4fd99c1e82ba..ad742743a494 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -12,6 +12,7 @@
>  #include <linux/pci.h>
>  #include <linux/mmc/mmc.h>
>  #include <linux/delay.h>
> +#include <linux/of.h>
>  #include "sdhci.h"
>  #include "sdhci-pci.h"
>  #include "cqhci.h"
> @@ -114,8 +115,10 @@
>  #define   GLI_9755_WT_EN_OFF    0x0
>  
>  #define PCI_GLI_9755_PECONF   0x44
> -#define   PCI_GLI_9755_LFCLK    GENMASK(14, 12)
> -#define   PCI_GLI_9755_DMACLK   BIT(29)
> +#define   PCI_GLI_9755_LFCLK          GENMASK(14, 12)
> +#define   PCI_GLI_9755_DMACLK         BIT(29)

Please don't mix in white space changes.

> +#define   PCI_GLI_9755_INVERT_CD      BIT(30)
> +#define   PCI_GLI_9755_INVERT_WP      BIT(31)
>  
>  #define PCI_GLI_9755_CFG2          0x48
>  #define   PCI_GLI_9755_CFG2_L1DLY    GENMASK(28, 24)
> @@ -570,6 +573,18 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
>  	gl9755_wt_on(pdev);
>  
>  	pci_read_config_dword(pdev, PCI_GLI_9755_PECONF, &value);
> +#ifdef CONFIG_OF
> +	if (pdev->dev.of_node) {

As Robin wrote, please remove #ifdef and if (pdev->dev.of_node)
because they are not needed.

> +		/*
> +		 * Apple ARM64 platforms using these chips may have
> +		 * inverted CD/WP detection.
> +		 */
> +		if (of_property_read_bool(pdev->dev.of_node, "cd-inverted"))
> +			value |= PCI_GLI_9755_INVERT_CD;
> +		if (of_property_read_bool(pdev->dev.of_node, "wp-inverted"))
> +			value |= PCI_GLI_9755_INVERT_WP;
> +	}
> +#endif
>  	value &= ~PCI_GLI_9755_LFCLK;
>  	value &= ~PCI_GLI_9755_DMACLK;
>  	pci_write_config_dword(pdev, PCI_GLI_9755_PECONF, value);
> 

