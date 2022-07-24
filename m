Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C519C57F54C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 15:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbiGXNs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 09:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGXNsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 09:48:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2671912AE2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 06:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658670503; x=1690206503;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2puGSbFV6JbfMw1U8PHnFAbt7zegiUsTaOBtnWFYRPc=;
  b=JhaVI8caFOFJ09jAMKo4SGIrM22dFvyvuqYq0/bAbnyL6GJzIH7t8Bzz
   wcUEBLPvn59u1v3tOd029ZEucPui4hooouHXFJJRMXjlmfDoN3pecwbBQ
   ueNirNg04yGTsG958ABnl3vQjOPSbNoxgm5/1hk/hnBCVXNBPzy4Ulptg
   mfV/OPxRLJD87K8xrZ7pGkyja93jXYI7N6aHy2dn6H6SWAmNK3u6tkx9V
   wj8p93dQDbI5tO9PuY1XsTqIKt7Rv4G8+B01I6XDSv8ByS8bOY+/DefTA
   OpwsZ+jl24w36Rp47GSyADq8vXQ3F3uzkLDbthxEBPuyd4ZwVV2FjGk4F
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="267938460"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="267938460"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 06:48:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="657817092"
Received: from zjiang1-mobl.ccr.corp.intel.com (HELO [10.249.170.155]) ([10.249.170.155])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 06:48:17 -0700
Message-ID: <bffb6e2d-d310-49b9-0725-37ab4263c22d@linux.intel.com>
Date:   Sun, 24 Jul 2022 21:48:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
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
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 08/12] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-9-baolu.lu@linux.intel.com>
 <20220723142650.GH79279@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220723142650.GH79279@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/23 22:26, Jason Gunthorpe wrote:
> On Tue, Jul 05, 2022 at 01:07:06PM +0800, Lu Baolu wrote:
>> The existing iommu SVA interfaces are implemented by calling the SVA
>> specific iommu ops provided by the IOMMU drivers. There's no need for
>> any SVA specific ops in iommu_ops vector anymore as we can achieve
>> this through the generic attach/detach_dev_pasid domain ops.
>>
>> This refactors the IOMMU SVA interfaces implementation by using the
>> set/block_pasid_dev ops and align them with the concept of the SVA
>> iommu domain. Put the new SVA code in the sva related file in order
>> to make it self-contained.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Tested-by: Tony Zhu <tony.zhu@intel.com>
>> ---
>>   include/linux/iommu.h         |  67 +++++++++++--------
>>   drivers/iommu/iommu-sva-lib.c |  98 ++++++++++++++++++++++++++++
>>   drivers/iommu/iommu.c         | 119 ++++++++--------------------------
>>   3 files changed, 165 insertions(+), 119 deletions(-)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 42f0418dc22c..f59b0ecd3995 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -39,7 +39,6 @@ struct device;
>>   struct iommu_domain;
>>   struct iommu_domain_ops;
>>   struct notifier_block;
>> -struct iommu_sva;
>>   struct iommu_fault_event;
>>   struct iommu_dma_cookie;
>>   
>> @@ -57,6 +56,14 @@ struct iommu_domain_geometry {
>>   	bool force_aperture;       /* DMA only allowed in mappable range? */
>>   };
>>   
>> +/**
>> + * struct iommu_sva - handle to a device-mm bond
>> + */
>> +struct iommu_sva {
>> +	struct device		*dev;
>> +	refcount_t		users;
>> +};
>> +
>>   /* Domain feature flags */
>>   #define __IOMMU_DOMAIN_PAGING	(1U << 0)  /* Support for iommu_map/unmap */
>>   #define __IOMMU_DOMAIN_DMA_API	(1U << 1)  /* Domain for use in DMA-API
>> @@ -105,6 +112,7 @@ struct iommu_domain {
>>   		};
>>   		struct {	/* IOMMU_DOMAIN_SVA */
>>   			struct mm_struct *mm;
>> +			struct iommu_sva bond;
> 
> We can't store a single struct device inside a domain, this is not
> layed out right.

Yes, agreed.

> 
> The API is really refcounting the PASID:
> 
>> +struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>> +					struct mm_struct *mm);
>> +void iommu_sva_unbind_device(struct iommu_sva *handle);
> 
> So what you need to do is store that 'iommu_sva' in the group's PASID
> xarray.
> 
> The bind logic would be
> 
>    sva = xa_load(group->pasid, mm->pasid)
>    if (sva)
>       refcount_inc(sva->users)
>       return sva
>    sva = kalloc
>    sva->domain = domain
>    xa_store(group->pasid, sva);

Thanks for the suggestion. It makes a lot of sense to me.

Furthermore, I'd like to separate the generic data from the caller-
specific things because the group->pasid_array should also be able to
serve other usages. Hence, the attach/detach_device_pasid interfaces
might be changed like below:

/* Collection of per-pasid IOMMU data */
struct group_pasid {
	struct iommu_domain *domain;
	void *priv;
};

/*
  * iommu_attach_device_pasid() - Attach a domain to pasid of device
  * @domain: the iommu domain.
  * @dev: the attached device.
  * @pasid: the pasid of the device.
  * @data: private data, NULL if not needed.
  *
  * Return: 0 on success, or an error.
  */
int iommu_attach_device_pasid(struct iommu_domain *domain, struct device 
*dev,
			      ioasid_t pasid, void *data)
{
	struct iommu_group *group;
	struct group_pasid *param;
	int ret = -EINVAL;
	void *curr;

	if (!domain->ops->set_dev_pasid)
		return -EOPNOTSUPP;

	group = iommu_group_get(dev);
	if (!group)
		return -ENODEV;

	param = kzalloc(sizeof(*param), GFP_KERNEL);
	if (!param) {
		iommu_group_put(group);
		return -ENOMEM;
	}
	param->domain = domain;
	param->priv = data;

	mutex_lock(&group->mutex);
	if (!iommu_group_immutable_singleton(group, dev))
		goto out_unlock;

	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, param, GFP_KERNEL);
	if (curr) {
		ret = xa_err(curr) ? : -EBUSY;
		goto out_unlock;
	}
	ret = domain->ops->set_dev_pasid(domain, dev, pasid);
	if (ret)
		xa_erase(&group->pasid_array, pasid);
out_unlock:
	mutex_unlock(&group->mutex);
	iommu_group_put(group);
	if (ret)
		kfree(param);

	return ret;
}

/*
  * iommu_detach_device_pasid() - Detach the domain from pasid of device
  * @domain: the iommu domain.
  * @dev: the attached device.
  * @pasid: the pasid of the device.
  *
  * The @domain must have been attached to @pasid of the @dev with
  * iommu_detach_device_pasid().
  */
void iommu_detach_device_pasid(struct iommu_domain *domain, struct 
device *dev,
			       ioasid_t pasid)
{
	struct iommu_group *group = iommu_group_get(dev);
	struct group_pasid *param;

	mutex_lock(&group->mutex);
	domain->ops->set_dev_pasid(group->blocking_domain, dev, pasid);
	param = xa_erase(&group->pasid_array, pasid);
	WARN_ON(!param || param->domain != domain);
	mutex_unlock(&group->mutex);

	iommu_group_put(group);
	kfree(param);
}

Does this look right to you?

Best regards,
baolu
