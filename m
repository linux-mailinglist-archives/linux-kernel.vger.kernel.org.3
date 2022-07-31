Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E16B585F2C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 15:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbiGaNvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 09:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiGaNvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 09:51:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E79BE05
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 06:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659275503; x=1690811503;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Tjj8k1ZbSTJrdsm3wdlXChxe3eXQV6X+q+n/n7e9r+w=;
  b=brS1s211HBTHOGRVaGgY6RLrr3oZqZe5FsvDBq9PTvSNNJrgbm8Bp+Ka
   RIeWyCq4NSY9FqmaeAo44ZKxdMnnIOJVGE8l5LneQIf40tQcparP86ZLh
   IJ5IdhTIiQ0iwDRf3zbIxY0ZpJSBph2o3W1Ty6kdFu0g1vDE0kbEIwbEe
   Z3Tb0SBixc5LsEzyVTyROl/mrZyPhngfgY3DK2vWG/nj9jfr5n7LopClw
   A85GCj0PXzwInKZO2CAtAeSxn3NYaNB6Kr+tjGYERDYJA7q45tSiPR0DP
   6uK9AKCJTsC1uUXDYz9BWH4Y1gA30O9urIGY/JPxFAKL8px7CmRwoY7PZ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="375300809"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="375300809"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 06:51:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="629933120"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.191]) ([10.254.208.191])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 06:51:39 -0700
Message-ID: <5fc19287-98a6-02e9-ba06-d2148c29ead2@linux.intel.com>
Date:   Sun, 31 Jul 2022 21:51:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 08/12] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-9-baolu.lu@linux.intel.com>
 <ac129729-0a5f-df09-76e1-13b5f8a143e2@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ac129729-0a5f-df09-76e1-13b5f8a143e2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/31 20:55, Yi Liu wrote:
> On 2022/7/5 13:07, Lu Baolu wrote:
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
>>   include/linux/iommu.h         |  67 +++++++++++--------
>>   drivers/iommu/iommu-sva-lib.c |  98 ++++++++++++++++++++++++++++
>>   drivers/iommu/iommu.c         | 119 ++++++++--------------------------
>>   3 files changed, 165 insertions(+), 119 deletions(-)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 42f0418dc22c..f59b0ecd3995 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -39,7 +39,6 @@ struct device;
>>   struct iommu_domain;
>>   struct iommu_domain_ops;
>>   struct notifier_block;
>> -struct iommu_sva;
>>   struct iommu_fault_event;
>>   struct iommu_dma_cookie;
>> @@ -57,6 +56,14 @@ struct iommu_domain_geometry {
>>       bool force_aperture;       /* DMA only allowed in mappable 
>> range? */
>>   };
>> +/**
>> + * struct iommu_sva - handle to a device-mm bond
>> + */
>> +struct iommu_sva {
>> +    struct device        *dev;
>> +    refcount_t        users;
>> +};
>> +
>>   /* Domain feature flags */
>>   #define __IOMMU_DOMAIN_PAGING    (1U << 0)  /* Support for 
>> iommu_map/unmap */
>>   #define __IOMMU_DOMAIN_DMA_API    (1U << 1)  /* Domain for use in 
>> DMA-API
>> @@ -105,6 +112,7 @@ struct iommu_domain {
>>           };
>>           struct {    /* IOMMU_DOMAIN_SVA */
>>               struct mm_struct *mm;
>> +            struct iommu_sva bond;
>>           };
>>       };
>>   };
>> @@ -638,13 +646,6 @@ struct iommu_fwspec {
>>   /* ATS is supported */
>>   #define IOMMU_FWSPEC_PCI_RC_ATS            (1 << 0)
>> -/**
>> - * struct iommu_sva - handle to a device-mm bond
>> - */
>> -struct iommu_sva {
>> -    struct device            *dev;
>> -};
>> -
>>   int iommu_fwspec_init(struct device *dev, struct fwnode_handle 
>> *iommu_fwnode,
>>                 const struct iommu_ops *ops);
>>   void iommu_fwspec_free(struct device *dev);
>> @@ -685,11 +686,6 @@ int iommu_dev_enable_feature(struct device *dev, 
>> enum iommu_dev_features f);
>>   int iommu_dev_disable_feature(struct device *dev, enum 
>> iommu_dev_features f);
>>   bool iommu_dev_feature_enabled(struct device *dev, enum 
>> iommu_dev_features f);
>> -struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>> -                    struct mm_struct *mm);
>> -void iommu_sva_unbind_device(struct iommu_sva *handle);
>> -u32 iommu_sva_get_pasid(struct iommu_sva *handle);
>> -
>>   int iommu_device_use_default_domain(struct device *dev);
>>   void iommu_device_unuse_default_domain(struct device *dev);
>> @@ -703,6 +699,8 @@ int iommu_attach_device_pasid(struct iommu_domain 
>> *domain, struct device *dev,
>>                     ioasid_t pasid);
>>   void iommu_detach_device_pasid(struct iommu_domain *domain, struct 
>> device *dev,
>>                      ioasid_t pasid);
>> +struct iommu_domain *
>> +iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid);
>>   #else /* CONFIG_IOMMU_API */
>>   struct iommu_ops {};
>> @@ -1033,21 +1031,6 @@ iommu_dev_disable_feature(struct device *dev, 
>> enum iommu_dev_features feat)
>>       return -ENODEV;
>>   }
>> -static inline struct iommu_sva *
>> -iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
>> -{
>> -    return NULL;
>> -}
>> -
>> -static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
>> -{
>> -}
>> -
>> -static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
>> -{
>> -    return IOMMU_PASID_INVALID;
>> -}
>> -
>>   static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct 
>> device *dev)
>>   {
>>       return NULL;
>> @@ -1093,6 +1076,12 @@ static inline void 
>> iommu_detach_device_pasid(struct iommu_domain *domain,
>>                            struct device *dev, ioasid_t pasid)
>>   {
>>   }
>> +
>> +static inline struct iommu_domain *
>> +iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid)
>> +{
>> +    return NULL;
>> +}
>>   #endif /* CONFIG_IOMMU_API */
>>   /**
>> @@ -1118,4 +1107,26 @@ void iommu_debugfs_setup(void);
>>   static inline void iommu_debugfs_setup(void) {}
>>   #endif
>> +#ifdef CONFIG_IOMMU_SVA
>> +struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>> +                    struct mm_struct *mm);
>> +void iommu_sva_unbind_device(struct iommu_sva *handle);
>> +u32 iommu_sva_get_pasid(struct iommu_sva *handle);
>> +#else
>> +static inline struct iommu_sva *
>> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
>> +{
>> +    return NULL;
>> +}
>> +
>> +static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
>> +{
>> +}
>> +
>> +static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
>> +{
>> +    return IOMMU_PASID_INVALID;
>> +}
>> +#endif /* CONFIG_IOMMU_SVA */
>> +
>>   #endif /* __LINUX_IOMMU_H */
>> diff --git a/drivers/iommu/iommu-sva-lib.c 
>> b/drivers/iommu/iommu-sva-lib.c
>> index 106506143896..751366980232 100644
>> --- a/drivers/iommu/iommu-sva-lib.c
>> +++ b/drivers/iommu/iommu-sva-lib.c
>> @@ -4,6 +4,7 @@
>>    */
>>   #include <linux/mutex.h>
>>   #include <linux/sched/mm.h>
>> +#include <linux/iommu.h>
>>   #include "iommu-sva-lib.h"
>> @@ -69,3 +70,100 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
>>       return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_sva_find);
>> +
>> +/**
>> + * iommu_sva_bind_device() - Bind a process address space to a device
>> + * @dev: the device
>> + * @mm: the mm to bind, caller must hold a reference to mm_users
>> + *
>> + * Create a bond between device and address space, allowing the 
>> device to access
>> + * the mm using the returned PASID. If a bond already exists between 
>> @device and
>> + * @mm, it is returned and an additional reference is taken. Caller 
>> must call
>> + * iommu_sva_unbind_device() to release each reference.
>> + *
>> + * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called 
>> first, to
>> + * initialize the required SVA features.
>> + *
>> + * On error, returns an ERR_PTR value.
>> + */
>> +struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct 
>> mm_struct *mm)
>> +{
>> +    struct iommu_domain *domain;
>> +    ioasid_t max_pasids;
>> +    int ret = -EINVAL;
>> +
>> +    max_pasids = dev->iommu->max_pasids;
>> +    if (!max_pasids)
>> +        return ERR_PTR(-EOPNOTSUPP);
>> +
>> +    /* Allocate mm->pasid if necessary. */
>> +    ret = iommu_sva_alloc_pasid(mm, 1, max_pasids - 1);
> 
> do we want to call mmgrab() before iomu_sva_alloc_pasid() to
> avoid using mm without any reference? In your current code,
> mmgrab() is called in iommu_sva_domain_alloc().

As the comment of this API states "caller must hold a reference to
mm_users".

Best regards,
baolu
