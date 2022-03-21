Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BFC4E2455
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 11:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346338AbiCUK3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 06:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244351AbiCUK3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:29:22 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EECABF66
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 03:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647858477; x=1679394477;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LDF4W4xRXP4neOhFFxNRxYCmc5oPsktu1t/2i1GPpFI=;
  b=GPhSUKAnxWzMVt5WS58a2h1Q/y04N+wAMvkbZpmyNNbOSkwx1m/D2Ye+
   D1I735Bl79A651r8RBMDSL5/p2Ei/uQRANbczYGr8DG6NThOwV19JqdAr
   yPNArO753uCm17JjmUU7wdp3YcyZi2rxoulLdBXO/4mJ2W2fQjZpDY+AP
   +P5BvAuKWxhQFP4CbDQ5DX0gbr/wNIFuBCrgjjbUpvcC40OW6TGFzuoOf
   0Dy37KrrXNLHX7BCOZvy+QGDqPOK3eRvJJS7XLYEUVOSw/5A6eJJbYkIX
   oozdhesiHfLIRsLyuBlxuDS+GwAhLDFwZBpxQfOyXaQFnOqrzbTtEi9fQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="244990888"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="244990888"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 03:27:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="559806927"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.169]) ([10.254.213.169])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 03:27:39 -0700
Message-ID: <d62ef788-c6b9-8259-88cc-486efaade2b7@linux.intel.com>
Date:   Mon, 21 Mar 2022 18:27:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 03/11] iommu: Add attach/detach_dev_pasid domain ops
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-4-baolu.lu@linux.intel.com>
 <BL1PR11MB527174765D1253AB4B88D2AD8C169@BL1PR11MB5271.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BL1PR11MB527174765D1253AB4B88D2AD8C169@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/21 15:13, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Sunday, March 20, 2022 2:40 PM
>>
>> Attaching an IOMMU domain to a PASID of a device is a generic operation
>> for modern IOMMU drivers which support PASID-granular DMA address
>> translation. Currently visible usage scenarios include (but not limited):
>>
>>   - SVA
>>   - kernel DMA with PASID
>>   - hardware-assist mediated device
>>
>> This adds a pair of common domain ops for this purpose and implements a
>> couple of wrapper helpers for in-kernel usage.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   include/linux/iommu.h | 22 ++++++++++++++++++++++
>>   drivers/iommu/iommu.c | 41
>> +++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 63 insertions(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 3e179b853380..e51845b9a146 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -268,6 +268,8 @@ struct iommu_ops {
>>    * struct iommu_domain_ops - domain specific operations
>>    * @attach_dev: attach an iommu domain to a device
>>    * @detach_dev: detach an iommu domain from a device
>> + * @attach_dev_pasid: attach an iommu domain to a pasid of device
>> + * @detach_dev_pasid: detach an iommu domain from a pasid of device
>>    * @map: map a physically contiguous memory region to an iommu domain
>>    * @map_pages: map a physically contiguous set of pages of the same size
>> to
>>    *             an iommu domain.
>> @@ -285,6 +287,10 @@ struct iommu_ops {
>>   struct iommu_domain_ops {
>>   	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
>>   	void (*detach_dev)(struct iommu_domain *domain, struct device
>> *dev);
>> +	int (*attach_dev_pasid)(struct iommu_domain *domain,
>> +				struct device *dev, ioasid_t id);
>> +	void (*detach_dev_pasid)(struct iommu_domain *domain,
>> +				 struct device *dev, ioasid_t id);
>>
>>   	int (*map)(struct iommu_domain *domain, unsigned long iova,
>>   		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
>> @@ -678,6 +684,11 @@ int iommu_group_claim_dma_owner(struct
>> iommu_group *group, void *owner);
>>   void iommu_group_release_dma_owner(struct iommu_group *group);
>>   bool iommu_group_dma_owner_claimed(struct iommu_group *group);
>>
>> +int iommu_attach_device_pasid(struct iommu_domain *domain,
>> +			      struct device *dev, ioasid_t pasid);
>> +void iommu_detach_device_pasid(struct iommu_domain *domain,
>> +			       struct device *dev, ioasid_t pasid);
>> +
>>   #else /* CONFIG_IOMMU_API */
>>
>>   struct iommu_ops {};
>> @@ -1046,6 +1057,17 @@ static inline bool
>> iommu_group_dma_owner_claimed(struct iommu_group *group)
>>   {
>>   	return false;
>>   }
>> +
>> +static inline int iommu_attach_device_pasid(struct iommu_domain
>> *domain,
>> +					    struct device *dev, ioasid_t pasid)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +static inline void iommu_detach_device_pasid(struct iommu_domain
>> *domain,
>> +					     struct device *dev, ioasid_t pasid)
>> +{
>> +}
>>   #endif /* CONFIG_IOMMU_API */
>>
>>   /**
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 0c42ece25854..78c71ee15f36 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -3167,3 +3167,44 @@ bool iommu_group_dma_owner_claimed(struct
>> iommu_group *group)
>>   	return user;
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
>> +
>> +int iommu_attach_device_pasid(struct iommu_domain *domain,
>> +			      struct device *dev, ioasid_t pasid)
>> +{
>> +	struct iommu_group *group;
>> +	int ret = -EINVAL;
>> +
>> +	if (!domain->ops->attach_dev_pasid)
>> +		return -EINVAL;
>> +
>> +	group = iommu_group_get(dev);
>> +	if (!group)
>> +		return -ENODEV;
>> +
>> +	mutex_lock(&group->mutex);
>> +	if (iommu_group_device_count(group) != 1)
>> +		goto out_unlock;
> Need move the reason of above limitation from iommu_sva_bind_device()
> to here:
> 
> 	/*
> 	 * To keep things simple, SVA currently doesn't support IOMMU groups
> 	 * with more than one device. Existing SVA-capable systems are not
> 	 * affected by the problems that required IOMMU groups (lack of ACS
> 	 * isolation, device ID aliasing and other hardware issues).
> 	 */
> 	if (iommu_group_device_count(group) != 1)
> 		goto out_unlock;

Yes. We need a comment around this code. But it's not only for SVA but
also for all pasid attachment feature. I need more inputs to judge
whether this limitation is reasonable.

> 
> btw I didn't see any safeguard on above assumption in device hotplug path
> to a group which already has SVA enabled...
> 

Agreed.

Best regards,
baolu
