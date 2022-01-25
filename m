Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A98849AB31
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1325434AbiAYEnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:43:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:11440 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1324254AbiAYDa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643081456; x=1674617456;
  h=cc:subject:to:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=+G9uJ5cBRukDuRVioB36b7JgfNmSiiRAztt/zlvEwis=;
  b=LseJGdQqIKpFgs+N8PQdIJa7pq8hwO6U+kkuRndUeGIWkeNA+uZdT2D7
   hG0t1qmvAz83c452BI9iRVeIZMci7EKqiJWFHkudYfziM6OdArGz7fwCL
   tOHXkk6Mo89XcJjzn1xwqVu29hIzARvkmhbp9ITHoWVuVtKEq51hFdiTj
   Um1LCc7b2xQVrO1p0wOqJ0gUiB/zt6J+ak+JVm7pb73b05VNuurinhxww
   kYoqxZ4ug23q5LKngplQTQS4JamXo6qlcX6Rn5R5ogTzWScGnWUxjK7iW
   6GWEczOGNstcBL04lMRfOJjj4xjykXJ+9o7oVomPKyakB34yET78xMOwL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="306922475"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="306922475"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 19:19:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="534536381"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 24 Jan 2022 19:19:01 -0800
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] iommu: Use right way to retrieve iommu_ops
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-7-baolu.lu@linux.intel.com>
 <20220124173650.GF966497@nvidia.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e4493dac-07bf-7ee3-5bea-a159fd37a2dd@linux.intel.com>
Date:   Tue, 25 Jan 2022 11:18:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220124173650.GF966497@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/22 1:36 AM, Jason Gunthorpe wrote:
> On Mon, Jan 24, 2022 at 03:11:01PM +0800, Lu Baolu wrote:
>> The common iommu_ops is hooked to both device and domain. When a helper
>> has both device and domain pointer, the way to get the iommu_ops looks
>> messy in iommu core. This sorts out the way to get iommu_ops. The device
>> related helpers go through device pointer, while the domain related ones
>> go through domain pointer.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>   include/linux/iommu.h |  8 ++++++++
>>   drivers/iommu/iommu.c | 25 ++++++++++++++-----------
>>   2 files changed, 22 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index aa5486243892..111b3e9c79bb 100644
>> +++ b/include/linux/iommu.h
>> @@ -385,6 +385,14 @@ static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
>>   	};
>>   }
>>   
>> +static inline const struct iommu_ops *dev_iommu_ops_get(struct device *dev)
>> +{
>> +	if (dev && dev->iommu && dev->iommu->iommu_dev)
>> +		return dev->iommu->iommu_dev->ops;
>> +
>> +	return NULL;
> 
> What is the purpose of this helper?

Get the iommu_ops from a device pointer. Just want to avoid duplicate
code in various functions.

> 
>> +	const struct iommu_ops *ops = dev_iommu_ops_get(dev);
>>   	struct iommu_domain *domain = group->default_domain;
>>   	struct iommu_resv_region *entry;
>>   	struct list_head mappings;
>> @@ -785,8 +786,8 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
>>   		dma_addr_t start, end, addr;
>>   		size_t map_size = 0;
>>   
>> -		if (domain->ops->apply_resv_region)
>> -			domain->ops->apply_resv_region(dev, domain, entry);
>> +		if (ops->apply_resv_region)
>> +			ops->apply_resv_region(dev, domain, entry);
> 
> Here we call it and don't check for NULL? So why did we check the
> interior pointers in the helper?

Yes. Should check.

> 
>> @@ -831,8 +832,10 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
>>   static bool iommu_is_attach_deferred(struct iommu_domain *domain,
>>   				     struct device *dev)
>>   {
>> -	if (domain->ops->is_attach_deferred)
>> -		return domain->ops->is_attach_deferred(domain, dev);
>> +	const struct iommu_ops *ops = dev_iommu_ops_get(dev);
>> +
>> +	if (ops->is_attach_deferred)
>> +		return ops->is_attach_deferred(domain, dev);
> 
> Same here, at least return false if ops is null..

Yes.

>    
>> @@ -1251,10 +1254,10 @@ int iommu_page_response(struct device *dev,
>>   	struct iommu_fault_event *evt;
>>   	struct iommu_fault_page_request *prm;
>>   	struct dev_iommu *param = dev->iommu;
>> +	const struct iommu_ops *ops = dev_iommu_ops_get(dev);
>>   	bool has_pasid = msg->flags & IOMMU_PAGE_RESP_PASID_VALID;
>> -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>>   
>> -	if (!domain || !domain->ops->page_response)
>> +	if (!ops || !ops->page_response)
>>   		return -ENODEV;
>>   
>>   	if (!param || !param->fault_param)
>> @@ -1295,7 +1298,7 @@ int iommu_page_response(struct device *dev,
>>   			msg->pasid = 0;
>>   		}
>>   
>> -		ret = domain->ops->page_response(dev, evt, msg);
>> +		ret = ops->page_response(dev, evt, msg);
>>   		list_del(&evt->list);
>>   		kfree(evt);
>>   		break;
> 
> Feels weird that page_response is not connected to a domain, the fault
> originated from a domain after all. I would say this op should be
> moved to the domain and the caller should provide the a pointer to the
> domain that originated the fault.
> 
> Ideally since only some domain's will be configured to handle faults
> at all - domains that can't do this should have a NULL page_response
> op, even if other domains created by the same device driver could
> handle page_response..
> 
>> @@ -1758,10 +1761,10 @@ static int __iommu_group_dma_attach(struct iommu_group *group)
>>   
>>   static int iommu_group_do_probe_finalize(struct device *dev, void *data)
>>   {
>> -	struct iommu_domain *domain = data;
>> +	const struct iommu_ops *ops = dev_iommu_ops_get(dev);
>>   
>> -	if (domain->ops->probe_finalize)
>> -		domain->ops->probe_finalize(dev);
>> +	if (ops->probe_finalize)
>> +		ops->probe_finalize(dev);
> 
> This is an oddball one too, it is finishing setting up the default
> domain for a device? Several drivers seem to recover the default
> domain in their implementations..

In order to avoid default domain type (DMA or IDENDITY) conflict among
devices in a same iommu_group, the probe process is divided into two
phases, one for determining the default domain type and the other for
allocating the default domain and attaching it to the device.

ops->probe_finalize() is called to tell the vendor iommu driver that
the device probe is done. Normally the vendor iommu driver could set the
dma ops in this callback.

> 
> Jason
> 

Best regards,
baolu
