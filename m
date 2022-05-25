Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5785336B5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 08:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244120AbiEYGUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 02:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242007AbiEYGUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 02:20:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C55E6EC49
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 23:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653459636; x=1684995636;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vJJ4lj6JSngeRrcXNnkqhrxyjqnmsKVzIMYvdkGbUx8=;
  b=DPQvWmtdPZ9UFPpk1+SjbFWrWyGHWkG9ZIZfZyemnYAaFkJxmjSIlOL7
   RCpKODaPv3pXdv+eZnYoaLc1gmcCNDCgd2wmqmP5JpbXIVEdKS0fkl248
   xdMqCt9RCPM9x06SOZ1F3vf13IMLDafFWVjwfYRfruR0z0YP+a62znEn+
   ldN1oyjoN6S+rMU3xO28pVlF705Oh1ERoDB8ZpplG5uZD38upVkA8Tw+F
   mPNdYJhcRj+Z8EMbAMazZHf4d0z1snWcnktgsDWTMWA7+p05q1LGY+am9
   djDyhLPpmCGKhQ1/inUVTW4jKSoivDiMUNlgPPK9zd4g4VRPkdCbzfS6s
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="271303823"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="271303823"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 23:20:36 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="601681830"
Received: from jwang96-mobl.ccr.corp.intel.com (HELO [10.255.29.139]) ([10.255.29.139])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 23:20:31 -0700
Message-ID: <ff8f23c0-8763-1fac-6526-9095101ca0e5@linux.intel.com>
Date:   Wed, 25 May 2022 14:20:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Jacob jun Pan <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
 <f3170016-4d7f-e78e-db48-68305f683349@arm.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <f3170016-4d7f-e78e-db48-68305f683349@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 2022/5/24 22:36, Robin Murphy wrote:
> On 2022-05-19 08:20, Lu Baolu wrote:
> [...]
>> diff --git a/drivers/iommu/iommu-sva-lib.c 
>> b/drivers/iommu/iommu-sva-lib.c
>> index 106506143896..210c376f6043 100644
>> --- a/drivers/iommu/iommu-sva-lib.c
>> +++ b/drivers/iommu/iommu-sva-lib.c
>> @@ -69,3 +69,51 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
>>       return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_sva_find);
>> +
>> +/*
>> + * IOMMU SVA driver-oriented interfaces
>> + */
>> +struct iommu_domain *
>> +iommu_sva_alloc_domain(struct bus_type *bus, struct mm_struct *mm)
> 
> Argh, please no new bus-based external interfaces! Domain allocation 
> needs to resolve to the right IOMMU instance to solve a number of 
> issues, and cleaning up existing users of iommu_domain_alloc() to 
> prepare for that is already hard enough. This is arguably even more 
> relevant here than for other domain types, since SVA support is more 
> likely to depend on specific features that can vary between IOMMU 
> instances even with the same driver. Please make the external interface 
> take a struct device, then resolve the ops through dev->iommu.
> 
> Further nit: the naming inconsistency bugs me a bit - 
> iommu_sva_domain_alloc() seems more natural. Also I'd question the 
> symmetry vs. usability dichotomy of whether we *really* want two 
> different free functions for a struct iommu_domain pointer, where any 
> caller which might mix SVA and non-SVA usage then has to remember how 
> they allocated any particular domain :/
> 
>> +{
>> +    struct iommu_sva_domain *sva_domain;
>> +    struct iommu_domain *domain;
>> +
>> +    if (!bus->iommu_ops || !bus->iommu_ops->sva_domain_ops)
>> +        return ERR_PTR(-ENODEV);
>> +
>> +    sva_domain = kzalloc(sizeof(*sva_domain), GFP_KERNEL);
>> +    if (!sva_domain)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    mmgrab(mm);
>> +    sva_domain->mm = mm;
>> +
>> +    domain = &sva_domain->domain;
>> +    domain->type = IOMMU_DOMAIN_SVA;
>> +    domain->ops = bus->iommu_ops->sva_domain_ops;
> 
> I'd have thought it would be logical to pass IOMMU_DOMAIN_SVA to the 
> normal domain_alloc call, so that driver-internal stuff like context 
> descriptors can be still be hung off the domain as usual (rather than 
> all drivers having to implement some extra internal lookup mechanism to 
> handle all the SVA domain ops), but that's something we're free to come 

Agreed with above comments. Thanks! I will post an additional patch
for review later.

> back and change later. FWIW I'd just stick the mm pointer in struct 
> iommu_domain, in a union with the fault handler stuff and/or iova_cookie 
> - those are mutually exclusive with SVA, right?

"iova_cookie" is mutually exclusive with SVA, but I am not sure about
the fault handler stuff.

Did you mean @handler and @handler_token staffs below?

struct iommu_domain {
         unsigned type;
         const struct iommu_domain_ops *ops;
         unsigned long pgsize_bitmap;    /* Bitmap of page sizes in use */
         iommu_fault_handler_t handler;
         void *handler_token;
         struct iommu_domain_geometry geometry;
         struct iommu_dma_cookie *iova_cookie;
};

Is it only for DMA domains? From the point view of IOMMU faults, it
seems to be generic.

Best regards,
baolu
