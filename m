Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB7657F4DB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 13:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiGXL6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 07:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGXL6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 07:58:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83477175A0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 04:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658663920; x=1690199920;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KM20Px9+IUMc5pfne0smI8tn/OJ7VtEBAo/304bGylA=;
  b=OLglnXW+BL7XBcqP48a32jlzQU2OOVz5ZKEnCdKSsKvnBmlmTDZhTJ6H
   d8N9wqk2/pTJ8Oj3Yu/rBZgkRYSg/1FRYdMnZQ25CblLmmOB8HL10UTYS
   gytxWs69yHb6NieK8at4KXWxI5o29VwvEoBvny2mhxvJRcZRB4nOVFi6D
   sRez6qUZzVpfwS9wsXXK3SwEuWSX5FTJMYbRxu/6I2kayl1z0rzUlkpED
   Fs62To3QsNcxkE7Fy6UUJAun42R9oMa3RWfDGR39u9bKOlVZNhDLgGRMR
   jgFsxJX2vdAL8hET7nDkmmSdNqKu4y5A74p7cZbWFuvoUaX3ceQhqwQ2L
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="373841591"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="373841591"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 04:58:40 -0700
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="657793537"
Received: from zjiang1-mobl.ccr.corp.intel.com (HELO [10.249.170.155]) ([10.249.170.155])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 04:58:35 -0700
Message-ID: <e4719cdb-6046-46cf-e63d-a1e7968ffefb@linux.intel.com>
Date:   Sun, 24 Jul 2022 19:58:33 +0800
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
        linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 07/12] arm-smmu-v3/sva: Add SVA domain support
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-8-baolu.lu@linux.intel.com>
 <20220723142009.GG79279@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220723142009.GG79279@nvidia.com>
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

On 2022/7/23 22:20, Jason Gunthorpe wrote:
> On Tue, Jul 05, 2022 at 01:07:05PM +0800, Lu Baolu wrote:
>> Add support for SVA domain allocation and provide an SVA-specific
>> iommu_domain_ops.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  6 ++
>>   .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 69 +++++++++++++++++++
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  3 +
>>   3 files changed, 78 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> index d2ba86470c42..96399dd3a67a 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> @@ -758,6 +758,7 @@ struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm);
>>   void arm_smmu_sva_unbind(struct iommu_sva *handle);
>>   u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
>>   void arm_smmu_sva_notifier_synchronize(void);
>> +struct iommu_domain *arm_smmu_sva_domain_alloc(void);
>>   #else /* CONFIG_ARM_SMMU_V3_SVA */
>>   static inline bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>>   {
>> @@ -803,5 +804,10 @@ static inline u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
>>   }
>>   
>>   static inline void arm_smmu_sva_notifier_synchronize(void) {}
>> +
>> +static inline struct iommu_domain *arm_smmu_sva_domain_alloc(void)
>> +{
>> +	return NULL;
>> +}
>>   #endif /* CONFIG_ARM_SMMU_V3_SVA */
>>   #endif /* _ARM_SMMU_V3_H */
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>> index f155d406c5d5..fc4555dac5b4 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>> @@ -549,3 +549,72 @@ void arm_smmu_sva_notifier_synchronize(void)
>>   	 */
>>   	mmu_notifier_synchronize();
>>   }
>> +
>> +static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
>> +				      struct device *dev, ioasid_t id)
>> +{
>> +	int ret = 0;
>> +	struct mm_struct *mm;
>> +	struct iommu_sva *handle;
>> +
>> +	if (domain->type != IOMMU_DOMAIN_SVA)
>> +		return -EINVAL;
> 
> Not needed, this function is only called from the sva ops, other
> domain types are impossible, we don't need sanity tests in drivers
> 
>> +	mm = domain->mm;
>> +	if (WARN_ON(!mm))
>> +		return -ENODEV;
> 
> Also guarenteed by core code, don't need sanity tests

Above two updated. Thanks!

> 
>> +static void arm_smmu_sva_block_dev_pasid(struct iommu_domain *domain,
>> +					 struct device *dev, ioasid_t id)
>> +{
>> +	struct mm_struct *mm = domain->mm;
>> +	struct arm_smmu_bond *bond = NULL, *t;
>> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>> +
>> +	mutex_lock(&sva_lock);
>> +	list_for_each_entry(t, &master->bonds, list) {
>> +		if (t->mm == mm) {
>> +			bond = t;
>> +			break;
> 
> This doesn't seem like what I would expect, the domain should be used
> at the key in these datastructures, not the mm..

Both Intel and arm-smmu-v3 SVA code have room to cleanup. I've discussed
this with Jean. We will cleanup and refactor the individual drivers in
separated series.

> 
>> index ae8ec8df47c1..a30b252e2f95 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -1999,6 +1999,9 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>>   {
>>   	struct arm_smmu_domain *smmu_domain;
>>   
>> +	if (type == IOMMU_DOMAIN_SVA)
>> +		return arm_smmu_sva_domain_alloc();
> 
> If no drivers are sharing any code with their other alloc paths perhaps we
> should have a dedicated op for SVA?

AFAICS, Robin is refactoring the domain allocation interfaces. How about
leaving this until we finalize the interface?

Best regards,
baolu
