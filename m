Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDEE51B87E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245699AbiEEHMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbiEEHMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:12:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE1146B3F
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 00:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651734554; x=1683270554;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yhEMFM3HV8KL3mz6avPBIxBH3iRpk8vn+fzx1P5KEos=;
  b=hT36336AS/CyXpMekyr/aNEmFwTLoB55PjJyrnjYhlMe98k95U5ZvJHq
   IfC/egEjNhK5l5WQWNRRZf/VpLQJYCgHaFtmGsbTgttdgHpToSocjnKlK
   PjFmZ5Y4QApFC8axoWkSSoEABJCzh26TlDUBRkoGxZbkORKQEmffvnDfk
   /7U0vjs4Nz7IwHxW3FswYn874FnWLEmCn0mtEao5FPOyJfj3dUZWFXkTW
   sVICjZ3KRfOBbHs31NslOCvPhBs2ZWdYq5Td2NKOgFdlEqTClZTbzf7jQ
   7rJ452ZDxna1czibzwqnXgDjG5y0zteTod7WaMYKaxkM84ybjvZ+U2DTS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="265619957"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="265619957"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 00:09:14 -0700
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="563109211"
Received: from minhaowa-mobl.ccr.corp.intel.com (HELO [10.255.30.75]) ([10.255.30.75])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 00:09:10 -0700
Message-ID: <2979ec44-e509-761c-3a0f-95ffec0986f3@linux.intel.com>
Date:   Thu, 5 May 2022 15:09:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 07/12] arm-smmu-v3/sva: Add SVA domain support
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
 <20220502014842.991097-8-baolu.lu@linux.intel.com> <YnFwiLkvYtLn43Qv@myrica>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YnFwiLkvYtLn43Qv@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/4 02:12, Jean-Philippe Brucker wrote:
> On Mon, May 02, 2022 at 09:48:37AM +0800, Lu Baolu wrote:
>> Add support for SVA domain allocation and provide an SVA-specific
>> iommu_domain_ops.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 14 +++++++
>>   .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 42 +++++++++++++++++++
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 21 ++++++++++
>>   3 files changed, 77 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> index cd48590ada30..7631c00fdcbd 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> @@ -759,6 +759,10 @@ struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
>>   void arm_smmu_sva_unbind(struct iommu_sva *handle);
>>   u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
>>   void arm_smmu_sva_notifier_synchronize(void);
>> +int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
>> +				  struct device *dev, ioasid_t id);
>> +void arm_smmu_sva_detach_dev_pasid(struct iommu_domain *domain,
>> +				   struct device *dev, ioasid_t id);
>>   #else /* CONFIG_ARM_SMMU_V3_SVA */
>>   static inline bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>>   {
>> @@ -804,5 +808,15 @@ static inline u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
>>   }
>>   
>>   static inline void arm_smmu_sva_notifier_synchronize(void) {}
>> +
>> +static inline int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
>> +						struct device *dev, ioasid_t id)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +static inline void arm_smmu_sva_detach_dev_pasid(struct iommu_domain *domain,
>> +						 struct device *dev,
>> +						 ioasid_t id) {}
>>   #endif /* CONFIG_ARM_SMMU_V3_SVA */
>>   #endif /* _ARM_SMMU_V3_H */
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>> index c623dae1e115..3b843cd3ed67 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>> @@ -541,3 +541,45 @@ void arm_smmu_sva_notifier_synchronize(void)
>>   	 */
>>   	mmu_notifier_synchronize();
>>   }
>> +
>> +int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
>> +				  struct device *dev, ioasid_t id)
>> +{
>> +	int ret = 0;
>> +	struct iommu_sva *handle;
>> +	struct mm_struct *mm = iommu_sva_domain_mm(domain);
>> +
>> +	if (domain->type != IOMMU_DOMAIN_SVA || !mm)
> 
> We wouldn't get that far with a non-SVA domain since iommu_sva_domain_mm()
> would dereference a NULL pointer. Could you move it after the domain->type
> check, and maybe add a WARN_ON()?  It could help catch issues in future
> API changes.

Sure. I will make it like this,

int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
                                   struct device *dev, ioasid_t id)
{
         int ret = 0;
         struct mm_struct *mm;
         struct iommu_sva *handle;

         if (domain->type != IOMMU_DOMAIN_SVA)
                 return -EINVAL;

         mm = iommu_sva_domain_mm(domain);
         if (WARN_ON(!mm))
                 return -ENODEV;
... ...

> 
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&sva_lock);
>> +	handle = __arm_smmu_sva_bind(dev, mm);
>> +	if (IS_ERR(handle))
>> +		ret = PTR_ERR(handle);
>> +	mutex_unlock(&sva_lock);
>> +
>> +	return ret;
>> +}
>> +
>> +void arm_smmu_sva_detach_dev_pasid(struct iommu_domain *domain,
>> +				   struct device *dev, ioasid_t id)
>> +{
>> +	struct arm_smmu_bond *bond = NULL, *t;
>> +	struct mm_struct *mm = iommu_sva_domain_mm(domain);
>> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>> +
>> +	mutex_lock(&sva_lock);
>> +	list_for_each_entry(t, &master->bonds, list) {
>> +		if (t->mm == mm) {
>> +			bond = t;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!WARN_ON(!bond) && refcount_dec_and_test(&bond->refs)) {
>> +		list_del(&bond->list);
>> +		arm_smmu_mmu_notifier_put(bond->smmu_mn);
>> +		kfree(bond);
>> +	}
>> +	mutex_unlock(&sva_lock);
>> +}
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index afc63fce6107..bd80de0bad98 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -1995,10 +1995,31 @@ static bool arm_smmu_capable(enum iommu_cap cap)
>>   	}
>>   }
>>   
>> +static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
>> +{
>> +	kfree(domain);
>> +}
>> +
>> +static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
>> +	.attach_dev_pasid	= arm_smmu_sva_attach_dev_pasid,
>> +	.detach_dev_pasid	= arm_smmu_sva_detach_dev_pasid,
>> +	.free			= arm_smmu_sva_domain_free,
>> +};
>> +
>>   static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>>   {
>>   	struct arm_smmu_domain *smmu_domain;
>>   
>> +	if (type == IOMMU_DOMAIN_SVA) {
>> +		struct iommu_domain *domain;
>> +
>> +		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
>> +		if (domain)
>> +			domain->ops = &arm_smmu_sva_domain_ops;
>> +
>> +		return domain;
>> +	}
>> +
> 
> I'd prefer moving all of this to arm-smmu-v3-sva.c and just call
> arm_smmu_sva_domain_alloc() here

Sure.

> 
> Otherwise the patch looks fine. I'll rework the driver when I find some
> time, because we can now remove arm_smmu_bond and move smmu_mn to the SVA
> domain, maybe also remove sva_lock but I haven't thought it through.

Yes. Intel SVA code also needs further cleanup. It's in my non-urgent
task list.

> 
> Thanks,
> Jean
> 
>>   	if (type != IOMMU_DOMAIN_UNMANAGED &&
>>   	    type != IOMMU_DOMAIN_DMA &&
>>   	    type != IOMMU_DOMAIN_DMA_FQ &&
>> -- 
>> 2.25.1
>>

Best regards,
baolu
