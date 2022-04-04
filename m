Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB944F0FA1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 08:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377571AbiDDGtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 02:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240418AbiDDGtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 02:49:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63135381BA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 23:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649054832; x=1680590832;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=1qb2JwH7lgsujR96fwZNadimhjb2aZ4RRps5Gl3fB8s=;
  b=hLcWkfAc1WIptqjnxNqFecEaBvtV9g0sa+D3+RdTTih/UJ9fzlr8y5cZ
   WAoTHBFnM2KhHbE6oCZZc43MZu/yA2vPy27qiKIDI5lTTPXDZ5XpNgjqF
   FBxNMaGm75KZt4PqoPzsFZ+4CgUWuuY12xmi0+ed7SMXDoNaPsbqWCGPu
   CwtPoWDjdyeIxkQ2VPyroC83HHnTMwoktLpIyKw/5Z/+GU0rifZEt2YB4
   K/ejOwjMGUePPyfP3Yqk1We5oZdcaMhSU4L3GKkYYmpbJ8+S9ASAUkd9Z
   bq9kdq5NnUMPg/CyH4iyX5n5YfKjkmxpau6w9D7WVXZrYmespf4lwSwTp
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="247963086"
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="247963086"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 23:47:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="548544591"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.140]) ([10.254.214.140])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 23:47:08 -0700
Message-ID: <9958fae3-2918-c1b7-6804-8b840807eb5c@linux.intel.com>
Date:   Mon, 4 Apr 2022 14:47:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-5-baolu.lu@linux.intel.com>
 <20220330190852.GC2120790@nvidia.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC v2 04/11] iommu: Add attach/detach_dev_pasid domain
 ops
In-Reply-To: <20220330190852.GC2120790@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 2022/3/31 3:08, Jason Gunthorpe wrote:
> On Tue, Mar 29, 2022 at 01:37:53PM +0800, Lu Baolu wrote:
>> Attaching an IOMMU domain to a PASID of a device is a generic operation
>> for modern IOMMU drivers which support PASID-granular DMA address
>> translation. Currently visible usage scenarios include (but not limited):
>>
>>   - SVA (Shared Virtual Address)
>>   - kernel DMA with PASID
>>   - hardware-assist mediated device
>>
>> This adds a pair of common domain ops for this purpose and adds some
>> common helpers to attach/detach a domain to/from a {device, PASID} and
>> get/put the domain attached to {device, PASID}.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>   include/linux/iommu.h | 36 ++++++++++++++++++
>>   drivers/iommu/iommu.c | 88 +++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 124 insertions(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 29c4c2edd706..a46285488a57 100644
>> +++ b/include/linux/iommu.h
>> @@ -269,6 +269,8 @@ struct iommu_ops {
>>    * struct iommu_domain_ops - domain specific operations
>>    * @attach_dev: attach an iommu domain to a device
>>    * @detach_dev: detach an iommu domain from a device
>> + * @attach_dev_pasid: attach an iommu domain to a pasid of device
>> + * @detach_dev_pasid: detach an iommu domain from a pasid of device
>>    * @map: map a physically contiguous memory region to an iommu domain
>>    * @map_pages: map a physically contiguous set of pages of the same size to
>>    *             an iommu domain.
>> @@ -286,6 +288,10 @@ struct iommu_ops {
>>   struct iommu_domain_ops {
>>   	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
>>   	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
>> +	int (*attach_dev_pasid)(struct iommu_domain *domain,
>> +				struct device *dev, ioasid_t id);
>> +	void (*detach_dev_pasid)(struct iommu_domain *domain,
>> +				 struct device *dev, ioasid_t id);
> 
> ID should be pasid for consistency

Sure.

> 
>> +int iommu_attach_device_pasid(struct iommu_domain *domain,
>> +			      struct device *dev, ioasid_t pasid)
>> +{
>> +	struct iommu_group *group;
>> +	int ret = -EINVAL;
>> +	void *curr;
>> +
>> +	if (!domain->ops->attach_dev_pasid)
>> +		return -EINVAL;
>> +
>> +	group = iommu_group_get(dev);
>> +	if (!group)
>> +		return -ENODEV;
>> +
>> +	mutex_lock(&group->mutex);
>> +	/*
>> +	 * To keep things simple, we currently don't support IOMMU groups
>> +	 * with more than one device. Existing SVA-capable systems are not
>> +	 * affected by the problems that required IOMMU groups (lack of ACS
>> +	 * isolation, device ID aliasing and other hardware issues).
>> +	 */
>> +	if (!iommu_group_singleton_lockdown(group))
>> +		goto out_unlock;
>> +
>> +	xa_lock(&group->pasid_array);
>> +	curr = __xa_cmpxchg(&group->pasid_array, pasid, NULL,
>> +			    domain, GFP_KERNEL);
>> +	xa_unlock(&group->pasid_array);
> 
> Why the xa_lock/unlock? Just call the normal xa_cmpxchg?

I should use xa_cmpxchg() instead.


> 
>> +void iommu_detach_device_pasid(struct iommu_domain *domain,
>> +			       struct device *dev, ioasid_t pasid)
>> +{
>> +	struct iommu_group *group;
>> +
>> +	group = iommu_group_get(dev);
>> +	if (WARN_ON(!group))
>> +		return;
> 
> This group_get stuff really needs some cleaning, this makes no sense
> at all.
> 
> If the kref to group can go to zero within this function then the
> initial access of the kref is already buggy:
> 
> 	if (group)
> 		kobject_get(group->devices_kobj);
> 
> Because it will crash or WARN_ON.
> 
> We don't hit this because it is required that a group cannot be
> destroyed while a struct device has a driver bound, and all these
> paths are driver bound paths.
> 
> So none of these group_get/put patterns have any purpose at all, and
> now we are adding impossible WARN_ONs to..

The original intention of this check is that the helper is called on the
correct device. I agree that WARN_ON() is unnecessary because NULL
pointer reference will be caught automatically.

> 
>> +struct iommu_domain *
>> +iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid)
>> +{
>> +	struct iommu_domain *domain;
>> +	struct iommu_group *group;
>> +
>> +	group = iommu_group_get(dev);
>> +	if (!group)
>> +		return NULL;
> 
> And now we are doing useless things on a performance path!

Agreed.

> 
>> +	mutex_lock(&group->mutex);
>> +	domain = xa_load(&group->pasid_array, pasid);
>> +	if (domain && domain->type == IOMMU_DOMAIN_SVA)
>> +		iommu_sva_domain_get_user(domain);
>> +	mutex_unlock(&group->mutex);
>> +	iommu_group_put(group);
> 
> Why do we need so much locking on a performance path? RCU out of the
> xarray..
> 
> Not sure I see how this get_user refcounting can work ?

I should move the refcountering things to iommu_domain and make the
change easier for review. Will improve this in the new version.

> 
> Jason

Best regards,
baolu
