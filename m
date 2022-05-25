Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB41D533A68
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 12:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239151AbiEYKIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 06:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242629AbiEYKID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 06:08:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E886939DA
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 03:07:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06AE41FB;
        Wed, 25 May 2022 03:07:58 -0700 (PDT)
Received: from [10.57.82.55] (unknown [10.57.82.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CE023F73D;
        Wed, 25 May 2022 03:07:55 -0700 (PDT)
Message-ID: <567dffd4-8f15-ffb2-da69-4f47017c35fd@arm.com>
Date:   Wed, 25 May 2022 11:07:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Content-Language: en-GB
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Jacob jun Pan <jacob.jun.pan@intel.com>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
 <f3170016-4d7f-e78e-db48-68305f683349@arm.com>
 <ff8f23c0-8763-1fac-6526-9095101ca0e5@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ff8f23c0-8763-1fac-6526-9095101ca0e5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-25 07:20, Baolu Lu wrote:
> Hi Robin,
> 
> On 2022/5/24 22:36, Robin Murphy wrote:
>> On 2022-05-19 08:20, Lu Baolu wrote:
>> [...]
>>> diff --git a/drivers/iommu/iommu-sva-lib.c 
>>> b/drivers/iommu/iommu-sva-lib.c
>>> index 106506143896..210c376f6043 100644
>>> --- a/drivers/iommu/iommu-sva-lib.c
>>> +++ b/drivers/iommu/iommu-sva-lib.c
>>> @@ -69,3 +69,51 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
>>>       return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
>>>   }
>>>   EXPORT_SYMBOL_GPL(iommu_sva_find);
>>> +
>>> +/*
>>> + * IOMMU SVA driver-oriented interfaces
>>> + */
>>> +struct iommu_domain *
>>> +iommu_sva_alloc_domain(struct bus_type *bus, struct mm_struct *mm)
>>
>> Argh, please no new bus-based external interfaces! Domain allocation 
>> needs to resolve to the right IOMMU instance to solve a number of 
>> issues, and cleaning up existing users of iommu_domain_alloc() to 
>> prepare for that is already hard enough. This is arguably even more 
>> relevant here than for other domain types, since SVA support is more 
>> likely to depend on specific features that can vary between IOMMU 
>> instances even with the same driver. Please make the external 
>> interface take a struct device, then resolve the ops through dev->iommu.
>>
>> Further nit: the naming inconsistency bugs me a bit - 
>> iommu_sva_domain_alloc() seems more natural. Also I'd question the 
>> symmetry vs. usability dichotomy of whether we *really* want two 
>> different free functions for a struct iommu_domain pointer, where any 
>> caller which might mix SVA and non-SVA usage then has to remember how 
>> they allocated any particular domain :/
>>
>>> +{
>>> +    struct iommu_sva_domain *sva_domain;
>>> +    struct iommu_domain *domain;
>>> +
>>> +    if (!bus->iommu_ops || !bus->iommu_ops->sva_domain_ops)
>>> +        return ERR_PTR(-ENODEV);
>>> +
>>> +    sva_domain = kzalloc(sizeof(*sva_domain), GFP_KERNEL);
>>> +    if (!sva_domain)
>>> +        return ERR_PTR(-ENOMEM);
>>> +
>>> +    mmgrab(mm);
>>> +    sva_domain->mm = mm;
>>> +
>>> +    domain = &sva_domain->domain;
>>> +    domain->type = IOMMU_DOMAIN_SVA;
>>> +    domain->ops = bus->iommu_ops->sva_domain_ops;
>>
>> I'd have thought it would be logical to pass IOMMU_DOMAIN_SVA to the 
>> normal domain_alloc call, so that driver-internal stuff like context 
>> descriptors can be still be hung off the domain as usual (rather than 
>> all drivers having to implement some extra internal lookup mechanism 
>> to handle all the SVA domain ops), but that's something we're free to 
>> come 
> 
> Agreed with above comments. Thanks! I will post an additional patch
> for review later.
> 
>> back and change later. FWIW I'd just stick the mm pointer in struct 
>> iommu_domain, in a union with the fault handler stuff and/or 
>> iova_cookie - those are mutually exclusive with SVA, right?
> 
> "iova_cookie" is mutually exclusive with SVA, but I am not sure about
> the fault handler stuff.

To correct myself, the IOVA cookie should be irrelevant to *current* 
SVA, but if we ever get as far as whole-device-SVA without PASIDs then 
we might need an MSI cookie (modulo the additional problem of stealing 
some procvess address space for it).

> Did you mean @handler and @handler_token staffs below?
> 
> struct iommu_domain {
>          unsigned type;
>          const struct iommu_domain_ops *ops;
>          unsigned long pgsize_bitmap;    /* Bitmap of page sizes in use */
>          iommu_fault_handler_t handler;
>          void *handler_token;
>          struct iommu_domain_geometry geometry;
>          struct iommu_dma_cookie *iova_cookie;
> };
> 
> Is it only for DMA domains? From the point view of IOMMU faults, it
> seems to be generic.

Yes, it's the old common iommu_set_fault_handler() stuff (which arguably 
is more of a "notifier" than a "handler"), but I assume that that's 
irrelevant if SVA is using IOPF instead?

Thanks,
Robin.
