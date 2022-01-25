Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B4F49AB4B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390065AbiAYEr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:47:27 -0500
Received: from mga14.intel.com ([192.55.52.115]:42795 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S248001AbiAYDzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643082945; x=1674618945;
  h=cc:subject:to:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=zlw5ADHuEjC3rrgpbVFAVmAXOq0f2hfek2JlqjXlmsE=;
  b=LugpM3xNW4Dvzhy6oELsc6iNbtCrBy3YmPsHZJrWVPfsYTvsuDD0N7yR
   wbpXm0x+Vt+dkqMqcgvL8qFe9Sj1jZxYmXcjs9ObE/GgCTUjBOd7b75BE
   cC/nx4EEQV1kh+eN9UpWOAsNO/5/HQtm0xWoga7p3Yw6zwpHFEH2W5dkk
   xnekY0WyvqmvigwqZLZxZ5vLTyaax3mZmUDL/QekDzk4Ojd1wshhqehyK
   xMSvfCctM3vRW/8XjcIHSBQCJi1T08ulZmwo9aoX/DN1S5k0vHEoe8quX
   Kfb28wj5NsCoLs8jYqd9Tiv3QSqGiTn/L+7FrIsF5YZ69A97ZnJt7vsRf
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="246429219"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="246429219"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 19:55:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="534545827"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 24 Jan 2022 19:55:15 -0800
Cc:     baolu.lu@linux.intel.com, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 6/7] iommu: Use right way to retrieve iommu_ops
To:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-7-baolu.lu@linux.intel.com>
 <363b8f7d-5459-0d19-c1ac-a2c6bce9d26f@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <8d4fea6f-aa21-3703-a254-2594004c60a1@linux.intel.com>
Date:   Tue, 25 Jan 2022 11:54:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <363b8f7d-5459-0d19-c1ac-a2c6bce9d26f@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/25/22 8:20 AM, Robin Murphy wrote:
> On 2022-01-24 07:11, Lu Baolu wrote:
>> The common iommu_ops is hooked to both device and domain. When a helper
>> has both device and domain pointer, the way to get the iommu_ops looks
>> messy in iommu core. This sorts out the way to get iommu_ops. The device
>> related helpers go through device pointer, while the domain related ones
>> go through domain pointer.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   include/linux/iommu.h |  8 ++++++++
>>   drivers/iommu/iommu.c | 25 ++++++++++++++-----------
>>   2 files changed, 22 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index aa5486243892..111b3e9c79bb 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -385,6 +385,14 @@ static inline void iommu_iotlb_gather_init(struct 
>> iommu_iotlb_gather *gather)
>>       };
>>   }
>> +static inline const struct iommu_ops *dev_iommu_ops_get(struct device 
>> *dev)
>> +{
>> +    if (dev && dev->iommu && dev->iommu->iommu_dev)
>> +        return dev->iommu->iommu_dev->ops;
>> +
>> +    return NULL;
> 
> This probably warrants at least a WARN, but it's arguable to just assume 
> that valid ops must be installed if iommu_probe_device() has succeeded. 
> The device ops are essentially for internal use within the IOMMU 
> subsystem itself, so we should be able to trust ourselves not to misuse 
> the helper.

I agree that we could add a WARN() here. The expectation is that every
device going through the IOMMU interfaces or helpers should have been
probed by iommu_probe_device().

> 
>> +}
>> +
>>   #define IOMMU_BUS_NOTIFY_PRIORITY        0
>>   #define IOMMU_GROUP_NOTIFY_ADD_DEVICE        1 /* Device added */
>>   #define IOMMU_GROUP_NOTIFY_DEL_DEVICE        2 /* Pre Device removed */
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 5230c6d90ece..6631e2ea44df 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -764,6 +764,7 @@ EXPORT_SYMBOL_GPL(iommu_group_set_name);
>>   static int iommu_create_device_direct_mappings(struct iommu_group 
>> *group,
>>                              struct device *dev)
>>   {
>> +    const struct iommu_ops *ops = dev_iommu_ops_get(dev);
>>       struct iommu_domain *domain = group->default_domain;
>>       struct iommu_resv_region *entry;
>>       struct list_head mappings;
>> @@ -785,8 +786,8 @@ static int 
>> iommu_create_device_direct_mappings(struct iommu_group *group,
>>           dma_addr_t start, end, addr;
>>           size_t map_size = 0;
>> -        if (domain->ops->apply_resv_region)
>> -            domain->ops->apply_resv_region(dev, domain, entry);
>> +        if (ops->apply_resv_region)
>> +            ops->apply_resv_region(dev, domain, entry);
> 
> Strictly I think this was a domain op, as it was about reserving the 
> IOVA range in the given DMA domain. Also taking the domain as an 
> argument is a bit of a giveaway. However it's now just dead code either 
> way since there are no remaining implementations, and no reason for any 
> new ones.

This callback is a dead code. I will cleanup it.

$ git grep apply_resv_region
drivers/iommu/iommu.c:          if (ops->apply_resv_region)
drivers/iommu/iommu.c:                  ops->apply_resv_region(dev, 
domain, entry);
include/linux/iommu.h: * @apply_resv_region: Temporary helper call-back 
for iova reserved ranges
include/linux/iommu.h:  void (*apply_resv_region)(struct device *dev,

> 
>>           start = ALIGN(entry->start, pg_size);
>>           end   = ALIGN(entry->start + entry->length, pg_size);
>> @@ -831,8 +832,10 @@ static int 
>> iommu_create_device_direct_mappings(struct iommu_group *group,
>>   static bool iommu_is_attach_deferred(struct iommu_domain *domain,
>>                        struct device *dev)
>>   {
>> -    if (domain->ops->is_attach_deferred)
>> -        return domain->ops->is_attach_deferred(domain, dev);
>> +    const struct iommu_ops *ops = dev_iommu_ops_get(dev);
>> +
>> +    if (ops->is_attach_deferred)
>> +        return ops->is_attach_deferred(domain, dev);
> 
> Similarly if this takes a domain as its first argument then it's de 
> facto a domain method. However, I'd concur that logically it *is* a 
> device op, so let's drop that (unused) domain argument if we're cleaning 
> up.
> 
> Maybe there's even an argument for factoring this out to a standard flag 
> in dev_iommu rather than an op at all?

Make it part of dev_iommu looks more attractive. Let me check how many
efforts will it take. If a lot of changes required, maybe we can remove
@domain in this series and then switch it to a dev_iommu flag in a
separated series.

> 
> The others covered here look OK - we can blame PCI for page response 
> being weirdly device-centric - however could we also convert all the 
> feasible instances of dev->bus->iommu_ops to dev_iommu_ops() as well?

Sure.

> (Subtly implying that I'm also not a fan of having "_get" in the name 
> for a non-refcounted lookup...) Obviously iommu_probe_device() and 
> iommmu_domain_alloc() still need bus ops at this point, but I'm working 
> on that... :)

Thanks and glad to know that.

> 
> Thanks,
> Robin.

Best regards,
baolu
