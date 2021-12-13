Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB05472BBA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbhLMLpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:45:35 -0500
Received: from foss.arm.com ([217.140.110.172]:52808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231452AbhLMLpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:45:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2792E6D;
        Mon, 13 Dec 2021 03:45:34 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 818D83F793;
        Mon, 13 Dec 2021 03:45:32 -0800 (PST)
Message-ID: <d3b93b6c-0f55-8c0f-0bd3-f6a090b358af@arm.com>
Date:   Mon, 13 Dec 2021 11:45:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 1/2] mmc: sdhci-pci-gli: GL9755: Support for CD/WP
 inversion on OF platforms
Content-Language: en-GB
To:     Hector Martin <marcan@marcan.st>,
        Ben Chuang <benchuanggli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20211212070210.141664-1-marcan@marcan.st>
 <20211212070210.141664-2-marcan@marcan.st>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211212070210.141664-2-marcan@marcan.st>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-12 07:02, Hector Martin wrote:
> This is required on some Apple ARM64 laptops using this controller.
> As is typical on DT platforms, pull these quirks from the device tree
> using the standard mmc bindings.
> 
> See Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>   drivers/mmc/host/sdhci-pci-gli.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 4fd99c1e82ba..ad742743a494 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -12,6 +12,7 @@
>   #include <linux/pci.h>
>   #include <linux/mmc/mmc.h>
>   #include <linux/delay.h>
> +#include <linux/of.h>
>   #include "sdhci.h"
>   #include "sdhci-pci.h"
>   #include "cqhci.h"
> @@ -114,8 +115,10 @@
>   #define   GLI_9755_WT_EN_OFF    0x0
>   
>   #define PCI_GLI_9755_PECONF   0x44
> -#define   PCI_GLI_9755_LFCLK    GENMASK(14, 12)
> -#define   PCI_GLI_9755_DMACLK   BIT(29)
> +#define   PCI_GLI_9755_LFCLK          GENMASK(14, 12)
> +#define   PCI_GLI_9755_DMACLK         BIT(29)
> +#define   PCI_GLI_9755_INVERT_CD      BIT(30)
> +#define   PCI_GLI_9755_INVERT_WP      BIT(31)
>   
>   #define PCI_GLI_9755_CFG2          0x48
>   #define   PCI_GLI_9755_CFG2_L1DLY    GENMASK(28, 24)
> @@ -570,6 +573,18 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
>   	gl9755_wt_on(pdev);
>   
>   	pci_read_config_dword(pdev, PCI_GLI_9755_PECONF, &value);
> +#ifdef CONFIG_OF
> +	if (pdev->dev.of_node) {

FWIW, of_property_read_bool() should handle a NULL node correctly, and 
its stub be optimised away for !OF, so you don't really need the 
explicit check or the #ifdef.

Robin.

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
>   	value &= ~PCI_GLI_9755_LFCLK;
>   	value &= ~PCI_GLI_9755_DMACLK;
>   	pci_write_config_dword(pdev, PCI_GLI_9755_PECONF, value);
> 
