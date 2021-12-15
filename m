Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF49B475C78
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244313AbhLOP6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:58:12 -0500
Received: from marcansoft.com ([212.63.210.85]:53462 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232587AbhLOP6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:58:11 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id BE539424D9;
        Wed, 15 Dec 2021 15:58:07 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] mmc: sdhci-pci-gli: GL9755: Support for CD/WP
 inversion on OF platforms
To:     Robin Murphy <robin.murphy@arm.com>,
        Ben Chuang <benchuanggli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20211212070210.141664-1-marcan@marcan.st>
 <20211212070210.141664-2-marcan@marcan.st>
 <d3b93b6c-0f55-8c0f-0bd3-f6a090b358af@arm.com>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <f24f9807-e960-3d85-2040-700796a46f97@marcan.st>
Date:   Thu, 16 Dec 2021 00:58:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d3b93b6c-0f55-8c0f-0bd3-f6a090b358af@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2021 20.45, Robin Murphy wrote:
> On 2021-12-12 07:02, Hector Martin wrote:
>> This is required on some Apple ARM64 laptops using this controller.
>> As is typical on DT platforms, pull these quirks from the device tree
>> using the standard mmc bindings.
>>
>> See Documentation/devicetree/bindings/mmc/mmc-controller.yaml
>>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> ---
>>   drivers/mmc/host/sdhci-pci-gli.c | 19 +++++++++++++++++--
>>   1 file changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
>> index 4fd99c1e82ba..ad742743a494 100644
>> --- a/drivers/mmc/host/sdhci-pci-gli.c
>> +++ b/drivers/mmc/host/sdhci-pci-gli.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/pci.h>
>>   #include <linux/mmc/mmc.h>
>>   #include <linux/delay.h>
>> +#include <linux/of.h>
>>   #include "sdhci.h"
>>   #include "sdhci-pci.h"
>>   #include "cqhci.h"
>> @@ -114,8 +115,10 @@
>>   #define   GLI_9755_WT_EN_OFF    0x0
>>   
>>   #define PCI_GLI_9755_PECONF   0x44
>> -#define   PCI_GLI_9755_LFCLK    GENMASK(14, 12)
>> -#define   PCI_GLI_9755_DMACLK   BIT(29)
>> +#define   PCI_GLI_9755_LFCLK          GENMASK(14, 12)
>> +#define   PCI_GLI_9755_DMACLK         BIT(29)
>> +#define   PCI_GLI_9755_INVERT_CD      BIT(30)
>> +#define   PCI_GLI_9755_INVERT_WP      BIT(31)
>>   
>>   #define PCI_GLI_9755_CFG2          0x48
>>   #define   PCI_GLI_9755_CFG2_L1DLY    GENMASK(28, 24)
>> @@ -570,6 +573,18 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
>>   	gl9755_wt_on(pdev);
>>   
>>   	pci_read_config_dword(pdev, PCI_GLI_9755_PECONF, &value);
>> +#ifdef CONFIG_OF
>> +	if (pdev->dev.of_node) {
> 
> FWIW, of_property_read_bool() should handle a NULL node correctly, and 
> its stub be optimised away for !OF, so you don't really need the 
> explicit check or the #ifdef.

Thanks, removed it for v3!

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
