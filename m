Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2748258C571
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242316AbiHHJTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237318AbiHHJTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:19:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98C813F53;
        Mon,  8 Aug 2022 02:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659950353; x=1691486353;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HA7bIRYIO+TXtakNdlXcW8j6uVEalvRdw/+6qADL47w=;
  b=n4/B3WqVTJF1Fwbvuf9t3oIzV4ChyTc9d02Qa1S+P+1vAc3zL47CX3EM
   hIqBJ+zLU+yRd8mJJwzKug8J6MnCxiZak/d6KudGj8OaBCxytpj6u96+e
   DIZcs/qPIcnk7cK8yljUMhp5j5F+MPumr7ThxFnd9xgT/fYjcAJo3fta8
   7wd0RdD5uzcCQ4CGgp/szKSyiUkHZ54Yv6TzKpPon8kLjpXKIVApCQ4H4
   fGcI15aMjVBbYuUZ+cPCqOub9PCYIoiSoyvx0vIvi1391EzMkmKZDUh8+
   rXOq9vOvd3kIE0LrEbHlsdtJzEFHwQT8nCoPrlduMhYfZv1GMXJ/e4ncj
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="291323020"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="291323020"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 02:19:13 -0700
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="663863103"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.62.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 02:19:10 -0700
Message-ID: <9a248303-7a27-e90e-76b3-c01a00be4e3d@intel.com>
Date:   Mon, 8 Aug 2022 12:19:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] mmc: sdhci-xenon: Fix 2G limitation on AC5 SoC
Content-Language: en-US
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Elad Nachman <enachman@marvell.com>
References: <20220726170711.30324-1-vadym.kochan@plvision.eu>
 <139317dc-15e2-ac63-0e04-295e715a7747@gmail.com>
 <20220727164532.GA19351@plvision.eu> <20220801093044.GA22721@plvision.eu>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220801093044.GA22721@plvision.eu>
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

On 1/08/22 12:30, Vadym Kochan wrote:
> Hi Florian,
> 
> On Wed, Jul 27, 2022 at 07:45:32PM +0300, Vadym Kochan wrote:
>> Hi Florian,
>>
>> On Tue, Jul 26, 2022 at 10:37:46AM -0700, Florian Fainelli wrote:
>>> On 7/26/22 10:07, Vadym Kochan wrote:
>>>> From: Elad Nachman <enachman@marvell.com>
>>>>
>>>> There is a limitation on AC5 SoC that mmc controller
>>>> can't have DMA access over 2G memory.
>>>>
>>>> Signed-off-by: Elad Nachman <enachman@marvell.com>
>>>> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
>>>> ---
>>>>  drivers/mmc/host/sdhci-xenon.c | 13 +++++++++++++
>>>>  1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
>>>> index 08e838400b52..666d06b58564 100644
>>>> --- a/drivers/mmc/host/sdhci-xenon.c
>>>> +++ b/drivers/mmc/host/sdhci-xenon.c
>>>> @@ -18,6 +18,7 @@
>>>>  #include <linux/of.h>
>>>>  #include <linux/pm.h>
>>>>  #include <linux/pm_runtime.h>
>>>> +#include <linux/mm.h>
>>>>  
>>>>  #include "sdhci-pltfm.h"
>>>>  #include "sdhci-xenon.h"
>>>> @@ -422,6 +423,8 @@ static int xenon_probe_params(struct platform_device *pdev)
>>>>  	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>>>>  	u32 sdhc_id, nr_sdhc;
>>>>  	u32 tuning_count;
>>>> +	struct device_node *np = pdev->dev.of_node;
>>>> +	struct sysinfo si;
>>>>  
>>>>  	/* Disable HS200 on Armada AP806 */
>>>>  	if (priv->hw_version == XENON_AP806)
>>>> @@ -450,6 +453,15 @@ static int xenon_probe_params(struct platform_device *pdev)
>>>>  	}
>>>>  	priv->tuning_count = tuning_count;
>>>>  
>>>> +	si_meminfo(&si);
>>>> +
>>>> +	if (of_device_is_compatible(np, "marvell,ac5-sdhci") &&
>>>> +	    ((si.totalram * si.mem_unit) > 0x80000000 /*2G*/)) {
>>>
>>> Why not limit the DMA mask of the device and ensure, that bounce buffers get used so you can still do DMA?
>>>
>>> Also, you ought to be able to describe that limitation using Device Tree (assuming this is an option) and declaring a dedicated bus node for the SDHCI controller and providing a suitable dma-ranges property, see: arch/arm/boot/dts/bcm2711.dtsi and the 'soc' node for such examples.
>>>
>>>
>>
> 
> I could use DMA only in 2 ways:
> 
> #1 Use sdhci bounce buffer with SDMA mode
> 
>     But there was the issue that SDMA requires that SDHCI v4 mode should
>     be enabled, and when I enable it via sdhci_enable_v4_mode(host)
>     then I got error that EXT_CSD can't be recognized.
> 
>     But if I comment this line in sdhci.c:
>     
>     int sdhci_setup_host(struct sdhci_host *host)
>     {
>         ...
> 
> 	/* SDMA does not support 64-bit DMA if v4 mode not set */
> 	if ((host->flags & SDHCI_USE_64_BIT_DMA) && !host->v4_mode) {
> 		pr_info("XXX SDMA does not support 64-bit DMA if v4 mode not set\n");
> 		host->flags &= ~SDHCI_USE_SDMA;
> 	}
> 
>        ...
>     }
> 
>     then everything is OK.
> 
> #2 Use restricted-dma-pool in device-tree
> 
>    But I am not sure if it is good solution compared to #1.
> 
> Setting only DMA mask did not help because after some time I got
> "DMA overflow address" error stack-traces.

AFAICT using a DMA mask is the correct way to solve this.  If that
reveals another issue then that must be resolved also. Can you show
the stack traces and what kernel they are from?

> 
>> Do I understand correctly that the swiotlb will be used in case DMA
>> engine could not map the page in the specified range (limited by dma-ranges or
>> dma-mask) ?
>>
>>>
>>>> +		host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
>>>> +		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
>>>> +		dev_info(mmc_dev(mmc), "Disabling DMA because of 2GB DMA access limit.\n");
>>>> +	}
>>>> +
>>>>  	return xenon_phy_parse_params(dev, host);
>>>>  }
>>>>  
>>>> @@ -682,6 +694,7 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
>>>>  	{ .compatible = "marvell,armada-ap807-sdhci", .data = (void *)XENON_AP807},
>>>>  	{ .compatible = "marvell,armada-cp110-sdhci", .data =  (void *)XENON_CP110},
>>>>  	{ .compatible = "marvell,armada-3700-sdhci", .data =  (void *)XENON_A3700},
>>>> +	{ .compatible = "marvell,ac5-sdhci", .data = (void *)XENON_AP806},
>>>>  	{}
>>>>  };
>>>>  MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
>>>
>>>
>>> -- 
>>> Florian
>>
>> Thanks,
>>
> 
> Regards,

