Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808935453BD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345259AbiFISKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345252AbiFISKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:10:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3F03AD8A8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 11:09:58 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJsV61Xspz67VcZ;
        Fri, 10 Jun 2022 02:06:22 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 9 Jun 2022 20:09:56 +0200
Received: from [10.47.88.201] (10.47.88.201) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 9 Jun
 2022 19:09:55 +0100
Message-ID: <b46fd053-aaee-a384-0e5a-e7a5a011c71a@huawei.com>
Date:   Thu, 9 Jun 2022 19:09:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] iommu/dma: Add config for PCI SAC address trick
To:     Robin Murphy <robin.murphy@arm.com>, <will@kernel.org>,
        <joro@8bytes.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <hch@lst.de>
References: <3f06994f9f370f9d35b2630ab75171ecd2065621.1654782107.git.robin.murphy@arm.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <3f06994f9f370f9d35b2630ab75171ecd2065621.1654782107.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.88.201]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2022 16:12, Robin Murphy wrote:
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
> adding it to iommu-dma, but those really should be fixed with proper
> firmware bindings by now. Let's be brave and default it to off in the
> hope that CI systems and developers will find and fix those bugs, > but
> expect that desktop-focused distro configs are likely to want to turn
> it back on for maximum compatibility.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

FWIW,
Reviewed-by: John Garry <john.garry@huawei.com>

If we're not enabling by default for x86 then doesn't Jeorg have some 
XHCI issue which we would now need to quirk? I don't remember which 
device exactly. Or, alternatively, simply ask him to enable this new config.


> ---
> 
> v2: Tweak wording to clarify that it's not really an optimisation in
>      general, remove "default X86".
> 
>   drivers/iommu/Kconfig     | 26 ++++++++++++++++++++++++++
>   drivers/iommu/dma-iommu.c |  2 +-
>   2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index c79a0df090c0..5a225b48dd00 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -144,6 +144,32 @@ config IOMMU_DMA
>   	select IRQ_MSI_IOMMU
>   	select NEED_SG_DMA_LENGTH
>   
> +config IOMMU_DMA_PCI_SAC
> +	bool "Enable 64-bit legacy PCI optimisation by default"
> +	depends on IOMMU_DMA
> +	help
> +	  Enable by default an IOMMU optimisation for 64-bit legacy PCI devices,
> +	  wherein the DMA API layer will always first try to allocate a 32-bit
> +	  DMA address suitable for a single address cycle, before falling back
> +	  to allocating from the device's full usable address range. If your
> +	  system has 64-bit legacy PCI devices in 32-bit slots where using dual
> +	  address cycles reduces DMA throughput significantly, this may be
> +	  beneficial to overall performance.
> +
> +	  If you have a modern PCI Express based system, this feature mostly just
> +	  represents extra overhead in the allocation path for no practical
> +	  benefit, and it should usually be preferable to say "n" here.
> +
> +	  However, beware that this feature has also historically papered over
> +	  bugs where the IOMMU address width and/or device DMA mask is not set
> +	  correctly. If device DMA problems and IOMMU faults start occurring
> +	  after disabling this option, it is almost certainly indicative of a
> +	  latent driver or firmware/BIOS bug, which would previously have only
> +	  manifested with several gigabytes worth of concurrent DMA mappings.
> +
> +	  If this option is not set, the feature can still be re-enabled at
> +	  boot time with the "iommu.forcedac=0" command-line argument.
> +
>   # Shared Virtual Addressing
>   config IOMMU_SVA
>   	bool
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index f90251572a5d..9f9d9ba7f376 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -67,7 +67,7 @@ struct iommu_dma_cookie {
>   };
>   
>   static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
> -bool iommu_dma_forcedac __read_mostly;
> +bool iommu_dma_forcedac __read_mostly = !IS_ENABLED(CONFIG_IOMMU_DMA_PCI_SAC);
>   
>   static int __init iommu_dma_forcedac_setup(char *str)
>   {

