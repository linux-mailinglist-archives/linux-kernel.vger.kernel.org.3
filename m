Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A11597015
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239495AbiHQNoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239276AbiHQNny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:43:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A8213AB19;
        Wed, 17 Aug 2022 06:43:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59AC4113E;
        Wed, 17 Aug 2022 06:43:52 -0700 (PDT)
Received: from [10.57.13.141] (unknown [10.57.13.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A136F3F67D;
        Wed, 17 Aug 2022 06:43:49 -0700 (PDT)
Message-ID: <94888b3b-8f54-367d-c6b4-5ebfeeafe4c4@arm.com>
Date:   Wed, 17 Aug 2022 14:43:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] mmc: sdhci-xenon: Fix 2G limitation on AC5 SoC
Content-Language: en-GB
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Elad Nachman <enachman@marvell.com>, iommu@lists.linux.dev
References: <20220726170711.30324-1-vadym.kochan@plvision.eu>
 <139317dc-15e2-ac63-0e04-295e715a7747@gmail.com>
 <20220727164532.GA19351@plvision.eu> <20220801093044.GA22721@plvision.eu>
 <9a248303-7a27-e90e-76b3-c01a00be4e3d@intel.com>
 <20220808095237.GA15939@plvision.eu>
 <6c94411c-4847-526c-d929-c9523aa65c11@intel.com>
 <20220808122652.GA6599@plvision.eu>
 <3f96b382-aede-1f52-33cb-5f95715bdf59@intel.com>
 <3d16ebad-ea6c-555e-2481-ca5fb08a6c66@arm.com>
 <20220816205129.GA6438@plvision.eu>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220816205129.GA6438@plvision.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-16 21:51, Vadym Kochan wrote:
[...]
>> The one thing to watch out for is that SWIOTLB doesn't necessarily interact
>> very well with DMA offsets. Given the intent of
>> of_dma_get_max_cpu_address(), I think it ought to work out OK now for
>> current kernels on DT systems if everything is described correctly, but
>> otherwise it's likely that you end up with ZONE_DMA either being empty or
>> containing all memory, so the SWIOTLB buffer ends up being allocated
>> anywhere such that it might not actually work as expected.
>>
>> Robin.
> 
> Hi Robin,
> 
> Thank you for the reply.
> 
> My understanding is that swiotlb is allocated (in case of arm64)
> in the following cases:
> 
>     #1 when it is forced from the kernel cmdline
> 
>     #2 when max_pfn is greater than arm64_dma_phys_limit (and this is used
>        as the end from which to allocate the swiotlb pool in the
>        top-botom direction via memblock API).
> 
>     #3 using restricted dma-pool
> 
> Of course option #3 works fine because swiotlb is kind of forced to use
> particulary this range of memory.
> 
> Both options #1 & #2 causes to use full memory mask even if to specify
> dma-ranges in the DT:
> 
>      dma-ranges = <0x0 0x0 0x2 0x0 0x0 0x80000000>;
> 
> or if to specify the opposite:
> 
>      dma-ranges = <0x2 0x0 0x0 0x0 0x0 0x80000000>;
> 
>      just to make it lower than U32 to pass
> 
>          zone_dma_bits = min3(32U, dt_zone_dma_bits, acpi_zone_dma_bits)
> 
>      condition, but then it will be re-set in max_zone_phys() by:
> 
>       
> 	if (phys_start > U32_MAX)
> 		zone_mask = PHYS_ADDR_MAX;
> 	else if (phys_start > zone_mask)
> 		zone_mask = U32_MAX;

Ah, indeed I missed that, sorry. It seems that that change to stop 
assuming an offset kind of crossed over with the introduction of 
*_dma_get_max_cpu_address(), but now that that firmware property parsing 
*is* implemented, in principle it should be equally possible to evaluate 
the actual offsets as well, and decide whether an offset ZONE_DMA is 
appropriate or not. Either way, this is definitely the area which needs 
work if we want to to able to support topologies like this properly.

> So, currently I dont see how to pin swiotlb (I see it as a main problem) to some specific range of physical
> memory (particulary to the first 2G of RAM).

Indeed, if ZONE_DMA and/or ZONE_DMA32 can't be set appropriately, then 
there's no way to guarantee correct allocation of any DMA buffers, short 
of hacking it with explicitly placed reserved-memory carveouts.

Thanks,
Robin.
