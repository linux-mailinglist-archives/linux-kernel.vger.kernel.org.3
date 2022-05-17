Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E3752A1CE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345926AbiEQMnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242996AbiEQMnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:43:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A10626556
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:43:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0726B1042;
        Tue, 17 May 2022 05:43:11 -0700 (PDT)
Received: from [10.57.82.55] (unknown [10.57.82.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05AA13F66F;
        Tue, 17 May 2022 05:43:08 -0700 (PDT)
Message-ID: <f971aea9-8ae1-95f8-b10a-cd77e9704dc0@arm.com>
Date:   Tue, 17 May 2022 13:43:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/5] iommu: Add blocking_domain_ops field in iommu_ops
Content-Language: en-GB
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
 <20220516015759.2952771-3-baolu.lu@linux.intel.com>
 <8a0fc6cf-f46e-f17e-2b76-099ada1683c3@arm.com>
 <20220516135741.GV1343366@nvidia.com>
 <c8492b29-bc27-ae12-d5c4-9fbbc797e310@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <c8492b29-bc27-ae12-d5c4-9fbbc797e310@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-17 03:37, Baolu Lu wrote:
> Hi Jason,
> 
> On 2022/5/16 21:57, Jason Gunthorpe wrote:
>> On Mon, May 16, 2022 at 12:22:08PM +0100, Robin Murphy wrote:
>>> On 2022-05-16 02:57, Lu Baolu wrote:
>>>> Each IOMMU driver must provide a blocking domain ops. If the hardware
>>>> supports detaching domain from device, setting blocking domain equals
>>>> detaching the existing domain from the deivce. Otherwise, an UNMANAGED
>>>> domain without any mapping will be used instead.
>>> Unfortunately that's backwards - most of the implementations of 
>>> .detach_dev
>>> are disabling translation entirely, meaning the device ends up 
>>> effectively
>>> in passthrough rather than blocked.
>> Ideally we'd convert the detach_dev of every driver into either
>> a blocking or identity domain. The trick is knowing which is which..
> 
> I am still a bit puzzled about how the blocking_domain should be used 
> when it is extended to support ->set_dev_pasid.
> 
> If it's a blocking domain, the IOMMU driver knows that setting the
> blocking domain to device pasid means detaching the existing one.
> 
> But if it's an identity domain, how could the IOMMU driver choose
> between:
> 
>   - setting the input domain to the pasid on device; or,
>   - detaching the existing domain.
> 
> I've ever thought about below solutions:
> 
> - Checking the domain types and dispatching them to different
>    operations.
> - Using different blocking domains for different types of domains.
> 
> But both look rough.
> 
>>
>> Guessing going down the list:
>>   apple dart - blocking, detach_dev calls apple_dart_hw_disable_dma() 
>> same as
>>                IOMMU_DOMAIN_BLOCKED
>>           [I wonder if this drive ris wrong in other ways though because
>>                 I dont see a remove_streams in attach_dev]
>>   exynos - this seems to disable the 'sysmmu' so I'm guessing this is
>>            identity
>>   iommu-vmsa - Comment says 'disable mmu translaction' so I'm guessing
>>                this is idenity
>>   mkt_v1 - Code looks similar to mkt, which is probably identity.
>>   rkt - No idea
>>   sprd - No idea
>>   sun50i - This driver confusingly treats identity the same as
>>            unmanaged, seems wrong, no idea.
>>   amd - Not sure, clear_dte_entry() seems to set translation on but 
>> points
>>         the PTE to 0 ? Based on the spec table 8 I would have expected
>>         TV to be clear which would be blocking. Maybe a bug??
>>   arm smmu qcomm - not sure
>>   intel - blocking
>>
>> These doesn't support default domains, so detach_dev should return
>> back to DMA API ownership, which is either identity or something weird:
>>   fsl_pamu - identity due to the PPC use of dma direct
>>   msm
>>   mkt
>>   omap
>>   s390 - platform DMA ops
>>   terga-gart - Usually something called a GART would be 0 length once
>>                disabled, guessing blocking?
>>   tegra-smmu
>>
>> So, the approach here should be to go driver by driver and convert
>> detach_dev to either identity, blocking or just delete it entirely,
>> excluding the above 7 that don't support default domains. And get acks
>> from the driver owners.
>>
> 
> Agreed. There seems to be a long way to go. I am wondering if we could
> decouple this refactoring from my new SVA API work? We can easily switch
> .detach_dev_pasid to using blocking domain later.

FWIW from my point of view I'm happy with having a .detach_dev_pasid op 
meaning implicitly-blocked access for now. On SMMUv3, PASIDs don't mix 
with our current notion of IOMMU_DOMAIN_IDENTITY (nor the potential one 
for IOMMU_DOMAIN_BLOCKED), so giving PASIDs functional symmetry with 
devices would need significantly more work anyway.

Thanks,
Robin.
