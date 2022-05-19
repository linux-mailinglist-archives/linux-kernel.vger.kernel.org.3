Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D1352D051
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbiESKUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiESKUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:20:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590F1BF76
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 03:20:45 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L3m4z1Chfz6H8Vm;
        Thu, 19 May 2022 18:17:39 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 12:20:42 +0200
Received: from [10.47.92.25] (10.47.92.25) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 11:20:42 +0100
Message-ID: <7ced25fb-9048-3df8-a62c-bfcb29176579@huawei.com>
Date:   Thu, 19 May 2022 11:20:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] iommu/dma: Add config for PCI SAC address trick
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
        <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <hch@lst.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <ef8abf1c6b0839e39b272738fc7bc4d9699c8bcb.1652895419.git.robin.murphy@arm.com>
In-Reply-To: <ef8abf1c6b0839e39b272738fc7bc4d9699c8bcb.1652895419.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.92.25]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2022 18:36, Robin Murphy wrote:
> For devices stuck behind a conventional PCI bus, saving extra cycles at
> 33MHz is probably fairly significant. However since native PCI Express
> is now the norm for high-performance devices, the optimisation to always
> prefer 32-bit addresses for the sake of avoiding DAC is starting to look
> rather anachronistic. Technically 32-bit addresses do have shorter TLPs
> on PCIe, but unless the device is saturating its link bandwidth with
> small transfers it seems unlikely that the difference is appreciable.
> 
> What definitely is appreciable, however, is that the IOVA allocator
> doesn't behave all that well once the 32-bit space starts getting full.
> As DMA working sets get bigger, this optimisation increasingly backfires
> and adds considerable overhead to the dma_map path for use-cases like
> high-bandwidth networking. We've increasingly bandaged the allocator
> in attempts to mitigate this, but it remains fundamentally at odds with
> other valid requirements to try as hard as possible to satisfy a request
> within the given limit; what we really need is to just avoid this odd
> notion of a speculative allocation when it isn't beneficial anyway.
> 
> Unfortunately that's where things get awkward... Having been present on
> x86 for 15 years or so now, it turns out there are systems which fail to
> properly define the upper limit of usable IOVA space for certain devices
> and this trick was the only thing letting them work OK. I had a similar
> ulterior motive for a couple of early arm64 systems when originally
> adding it to iommu-dma, but those really should now be fixed with proper
> firmware bindings, and other arm64 users really need it out of the way,
> so let's just leave it default-on for x86.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/Kconfig     | 24 ++++++++++++++++++++++++
>   drivers/iommu/dma-iommu.c |  2 +-

It might be worth printing this default value always and not just for 
when it is set from commandline, like what we do for default domain type 
and IOTLB invalidation policy

>   2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index c79a0df090c0..bf9b295f1c89 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -144,6 +144,30 @@ config IOMMU_DMA
>   	select IRQ_MSI_IOMMU
>   	select NEED_SG_DMA_LENGTH
>   
> +config IOMMU_DMA_PCI_SAC_OPT
> +	bool "Enable 64-bit legacy PCI optimisation by default"
> +	depends on IOMMU_DMA
> +	default X86

Do we have a strategy for if and when issues start popping up on other 
architectures? Is it to simply tell them to just turn this flag on (and 
also fix your platform)?

> +	help
> +	  Enable by default an IOMMU optimisation for 64-bit legacy PCI devices,
> +	  wherein the DMA API layer will always first try to allocate a 32-bit
> +	  DMA address suitable for a single address cycle, before falling back
> +	  to allocating from the full usable address range. If your system has
> +	  64-bit legacy PCI devices in 32-bit slots where using dual address
> +	  cycles reduces DMA throughput significantly, this optimisation may be
> +	  beneficial to overall performance.
> +
> +	  If you have a modern PCI Express based system, it should usually be
> +	  safe to say "n" here and avoid the potential extra allocation overhead.
> +	  However, beware that this optimisation has also historically papered
> +	  over bugs where the IOMMU address range above 32 bits is not fully
> +	  usable. If device DMA problems and/or IOMMU faults start occurring
> +	  with IOMMU translation enabled after disabling this option, it is
> +	  likely a sign of a latent driver or firmware/BIOS bug.
> +
> +	  If this option is not set, the optimisation can be enabled at
> +	  boot time with the "iommu.forcedac=0" command-line argument.
> +

Thanks,
John
