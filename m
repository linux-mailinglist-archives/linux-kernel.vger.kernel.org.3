Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5211B51B7F8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 08:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244378AbiEEGeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 02:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbiEEGeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 02:34:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2831A83F
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 23:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651732245; x=1683268245;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FWdkTJQPgfah88qi8uE8TAWSXAdTDOOpVO7WtKyi8WI=;
  b=DrODq11zGXEEqZgmckXDhNsZn5q4UbDaS5hYOftg4Vo73VrCAOEqV0Y7
   qoD0m81q1iv4q/gsv+L5mi3EstoBwfXZo1o7OJI4U8BH8OxSZcj9hDM7+
   xXDjKz7xP/TWh9uOZ8HBeLLQKHoQewdLcJUV4Sztl4WtzkI/EAlGPmMC6
   Vmpq5lOv27iDo5mjCWzLQ/dO6BHj8qi0T34+RgerU2Js3u8IPgI7gfvUe
   e7dza+m3GYHpIn2xQotdpdA2N60xk2t9+NBtkeUmv5VXhF8siF7Qkg/NE
   kc/HkvmBl9ZhTKGGfDpQUSH4veSfdGJ7uSG5KbQuwirV50rLDAC0gRsH6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="267610330"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="267610330"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 23:28:18 -0700
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="563093444"
Received: from minhaowa-mobl.ccr.corp.intel.com (HELO [10.255.30.75]) ([10.255.30.75])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 23:28:12 -0700
Message-ID: <d0e78ba5-9698-1dbf-4834-553fbcef6aad@linux.intel.com>
Date:   Thu, 5 May 2022 14:28:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 03/12] iommu: Add attach/detach_dev_pasid domain ops
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-4-baolu.lu@linux.intel.com> <YnFvX8IUwP2drNoj@myrica>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YnFvX8IUwP2drNoj@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/4 02:07, Jean-Philippe Brucker wrote:
> On Mon, May 02, 2022 at 09:48:33AM +0800, Lu Baolu wrote:
>> Attaching an IOMMU domain to a PASID of a device is a generic operation
>> for modern IOMMU drivers which support PASID-granular DMA address
>> translation. Currently visible usage scenarios include (but not limited):
>>
>>   - SVA (Shared Virtual Address)
>>   - kernel DMA with PASID
>>   - hardware-assist mediated device
>>
>> This adds a pair of common domain ops for this purpose and adds helpers
>> to attach/detach a domain to/from a {device, PASID}. Some buses, like
>> PCI, route packets without considering the PASID value. Thus a DMA target
>> address with PASID might be treated as P2P if the address falls into the
>> MMIO BAR of other devices in the group. To make things simple, these
>> interfaces only apply to devices belonging to the singleton groups, and
>> the singleton is immutable in fabric i.e. not affected by hotplug.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> just a nit below
> 
>> ---
>>   include/linux/iommu.h | 21 ++++++++++++
>>   drivers/iommu/iommu.c | 76 +++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 97 insertions(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index b8ffaf2cb1d0..ab36244d4e94 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -263,6 +263,8 @@ struct iommu_ops {
>>    * struct iommu_domain_ops - domain specific operations
>>    * @attach_dev: attach an iommu domain to a device
>>    * @detach_dev: detach an iommu domain from a device
>> + * @attach_dev_pasid: attach an iommu domain to a pasid of device
>> + * @detach_dev_pasid: detach an iommu domain from a pasid of device
>>    * @map: map a physically contiguous memory region to an iommu domain
>>    * @map_pages: map a physically contiguous set of pages of the same size to
>>    *             an iommu domain.
>> @@ -283,6 +285,10 @@ struct iommu_ops {
>>   struct iommu_domain_ops {
>>   	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
>>   	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
>> +	int (*attach_dev_pasid)(struct iommu_domain *domain,
>> +				struct device *dev, ioasid_t pasid);
>> +	void (*detach_dev_pasid)(struct iommu_domain *domain,
>> +				 struct device *dev, ioasid_t pasid);
>>   
>>   	int (*map)(struct iommu_domain *domain, unsigned long iova,
>>   		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
>> @@ -678,6 +684,10 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
>>   void iommu_group_release_dma_owner(struct iommu_group *group);
>>   bool iommu_group_dma_owner_claimed(struct iommu_group *group);
>>   
>> +int iommu_attach_device_pasid(struct iommu_domain *domain,
>> +			      struct device *dev, ioasid_t pasid);
>> +void iommu_detach_device_pasid(struct iommu_domain *domain,
>> +			       struct device *dev, ioasid_t pasid);
>>   #else /* CONFIG_IOMMU_API */
>>   
>>   struct iommu_ops {};
>> @@ -1051,6 +1061,17 @@ static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>>   {
>>   	return false;
>>   }
>> +
>> +static inline int iommu_attach_device_pasid(struct iommu_domain *domain,
>> +					    struct device *dev, ioasid_t pasid)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
>> +					     struct device *dev, ioasid_t pasid)
>> +{
>> +}
>>   #endif /* CONFIG_IOMMU_API */
>>   
>>   /**
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 29906bc16371..89c9d19ddb28 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -38,6 +38,7 @@ struct iommu_group {
>>   	struct kobject kobj;
>>   	struct kobject *devices_kobj;
>>   	struct list_head devices;
>> +	struct xarray pasid_array;
>>   	struct mutex mutex;
>>   	void *iommu_data;
>>   	void (*iommu_data_release)(void *iommu_data);
>> @@ -630,6 +631,7 @@ struct iommu_group *iommu_group_alloc(void)
>>   	mutex_init(&group->mutex);
>>   	INIT_LIST_HEAD(&group->devices);
>>   	INIT_LIST_HEAD(&group->entry);
>> +	xa_init(&group->pasid_array);
>>   
>>   	ret = ida_simple_get(&iommu_group_ida, 0, 0, GFP_KERNEL);
>>   	if (ret < 0) {
>> @@ -3190,3 +3192,77 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>>   	return user;
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
>> +
>> +/*
>> + * Use standard PCI bus topology and isolation features to check immutable
>> + * singleton. Otherwise, assume the bus is static and then singleton can
>> + * know from the device count in the group.
>> + */
> 
> The comment doesn't really add anything that can't be directly understood
> from the code.

Yes. It's fine to remove it.

Best regards,
baolu
