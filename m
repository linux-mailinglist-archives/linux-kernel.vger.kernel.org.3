Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8834520A94
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 03:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbiEJBUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 21:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbiEJBU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 21:20:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92897185410
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 18:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652145390; x=1683681390;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+Ruqm3+0fGIIuggqvQ6ClDXEoBd07gxr4rP4iwgEIeA=;
  b=HP5TIH9bU5hTYD+YDOODp92DziFZFZZrbUDG1PoGo7+0V3dBkH55oii1
   jile3zBGF8OZ6+QXO3I/ZOEl6rgHksPsyeTY2N4JH8zTwJLNlo0iudTFh
   3quoSLemlkwNWOWhy6i21J4ntzXoDafR18vnCwRec2B5gSNwyjOM/Ou8F
   82uX8GrDPh1KA5sRM1Y0DMfNnqu7eM67MM6pwBm4vPfR+A/+Q/JezLQn2
   Y9FTKrwEQ/4zwlF5fC5Tzw+VwO1R93RpvsiVevTWQBs7j+elvyoYE75kC
   iRRQFZ6itSTU7GwhH0Kr+2V8vgJ1KKcFbkRRq4tF1k/PS7qk9K2bI7x4g
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="355649117"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="355649117"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 18:16:30 -0700
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="593185256"
Received: from qihu-mobl.ccr.corp.intel.com (HELO [10.255.29.74]) ([10.255.29.74])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 18:16:28 -0700
Message-ID: <2f279564-633b-fe93-5ffd-34b3e8f1c6fc@linux.intel.com>
Date:   Tue, 10 May 2022 09:16:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 2/4] iommu/vt-d: Check domain force_snooping against
 attached devices
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220508123525.1973626-1-baolu.lu@linux.intel.com>
 <20220508123525.1973626-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52764D8783A4C9F742A76BC88CC99@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52764D8783A4C9F742A76BC88CC99@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/10 08:51, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Sunday, May 8, 2022 8:35 PM
>>
>> As domain->force_snooping only impacts the devices attached with the
>> domain, there's no need to check against all IOMMU units. On the other
>> hand, force_snooping could be set on a domain no matter whether it has
>> been attached or not, and once set it is an immutable flag. If no
>> device attached, the operation always succeeds. Then this empty domain
>> can be only attached to a device of which the IOMMU supports snoop
>> control.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Thank you, Kevin. I will queue this series for v5.19.

Best regards,
baolu

> 
>> ---
>>   include/linux/intel-iommu.h |  1 +
>>   drivers/iommu/intel/pasid.h |  2 ++
>>   drivers/iommu/intel/iommu.c | 53
>> ++++++++++++++++++++++++++++++++++---
>>   drivers/iommu/intel/pasid.c | 42 +++++++++++++++++++++++++++++
>>   4 files changed, 95 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
>> index 72e5d7900e71..4f29139bbfc3 100644
>> --- a/include/linux/intel-iommu.h
>> +++ b/include/linux/intel-iommu.h
>> @@ -540,6 +540,7 @@ struct dmar_domain {
>>   	u8 has_iotlb_device: 1;
>>   	u8 iommu_coherency: 1;		/* indicate coherency of
>> iommu access */
>>   	u8 force_snooping : 1;		/* Create IOPTEs with snoop control
>> */
>> +	u8 set_pte_snp:1;
>>
>>   	struct list_head devices;	/* all devices' list */
>>   	struct iova_domain iovad;	/* iova's that belong to this domain
>> */
>> diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
>> index ab4408c824a5..583ea67fc783 100644
>> --- a/drivers/iommu/intel/pasid.h
>> +++ b/drivers/iommu/intel/pasid.h
>> @@ -123,4 +123,6 @@ void intel_pasid_tear_down_entry(struct
>> intel_iommu *iommu,
>>   				 bool fault_ignore);
>>   int vcmd_alloc_pasid(struct intel_iommu *iommu, u32 *pasid);
>>   void vcmd_free_pasid(struct intel_iommu *iommu, u32 pasid);
>> +void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
>> +					  struct device *dev, u32 pasid);
>>   #endif /* __INTEL_PASID_H */
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index b4802f4055a0..048ebfbd5fcb 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -2459,7 +2459,7 @@ static int domain_setup_first_level(struct
>> intel_iommu *iommu,
>>   	if (level == 5)
>>   		flags |= PASID_FLAG_FL5LP;
>>
>> -	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
>> +	if (domain->force_snooping)
>>   		flags |= PASID_FLAG_PAGE_SNOOP;
>>
>>   	return intel_pasid_setup_first_level(iommu, dev, (pgd_t *)pgd, pasid,
>> @@ -4444,7 +4444,7 @@ static int intel_iommu_map(struct iommu_domain
>> *domain,
>>   		prot |= DMA_PTE_READ;
>>   	if (iommu_prot & IOMMU_WRITE)
>>   		prot |= DMA_PTE_WRITE;
>> -	if (dmar_domain->force_snooping)
>> +	if (dmar_domain->set_pte_snp)
>>   		prot |= DMA_PTE_SNP;
>>
>>   	max_addr = iova + size;
>> @@ -4567,13 +4567,60 @@ static phys_addr_t
>> intel_iommu_iova_to_phys(struct iommu_domain *domain,
>>   	return phys;
>>   }
>>
>> +static bool domain_support_force_snooping(struct dmar_domain *domain)
>> +{
>> +	struct device_domain_info *info;
>> +	bool support = true;
>> +
>> +	assert_spin_locked(&device_domain_lock);
>> +	list_for_each_entry(info, &domain->devices, link) {
>> +		if (!ecap_sc_support(info->iommu->ecap)) {
>> +			support = false;
>> +			break;
>> +		}
>> +	}
>> +
>> +	return support;
>> +}
>> +
>> +static void domain_set_force_snooping(struct dmar_domain *domain)
>> +{
>> +	struct device_domain_info *info;
>> +
>> +	assert_spin_locked(&device_domain_lock);
>> +
>> +	/*
>> +	 * Second level page table supports per-PTE snoop control. The
>> +	 * iommu_map() interface will handle this by setting SNP bit.
>> +	 */
>> +	if (!domain_use_first_level(domain)) {
>> +		domain->set_pte_snp = true;
>> +		return;
>> +	}
>> +
>> +	list_for_each_entry(info, &domain->devices, link)
>> +		intel_pasid_setup_page_snoop_control(info->iommu, info-
>>> dev,
>> +						     PASID_RID2PASID);
>> +}
>> +
>>   static bool intel_iommu_enforce_cache_coherency(struct iommu_domain
>> *domain)
>>   {
>>   	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>> +	unsigned long flags;
>>
>> -	if (!domain_update_iommu_snooping(NULL))
>> +	if (dmar_domain->force_snooping)
>> +		return true;
>> +
>> +	spin_lock_irqsave(&device_domain_lock, flags);
>> +	if (!domain_support_force_snooping(dmar_domain)) {
>> +		spin_unlock_irqrestore(&device_domain_lock, flags);
>>   		return false;
>> +	}
>> +
>> +	domain_set_force_snooping(dmar_domain);
>>   	dmar_domain->force_snooping = true;
>> +	spin_unlock_irqrestore(&device_domain_lock, flags);
>> +
>>   	return true;
>>   }
>>
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index f8d215d85695..d19dd66a670c 100644
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -762,3 +762,45 @@ int intel_pasid_setup_pass_through(struct
>> intel_iommu *iommu,
>>
>>   	return 0;
>>   }
>> +
>> +/*
>> + * Set the page snoop control for a pasid entry which has been set up.
>> + */
>> +void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
>> +					  struct device *dev, u32 pasid)
>> +{
>> +	struct pasid_entry *pte;
>> +	u16 did;
>> +
>> +	spin_lock(&iommu->lock);
>> +	pte = intel_pasid_get_entry(dev, pasid);
>> +	if (WARN_ON(!pte || !pasid_pte_is_present(pte))) {
>> +		spin_unlock(&iommu->lock);
>> +		return;
>> +	}
>> +
>> +	pasid_set_pgsnp(pte);
>> +	did = pasid_get_domain_id(pte);
>> +	spin_unlock(&iommu->lock);
>> +
>> +	if (!ecap_coherent(iommu->ecap))
>> +		clflush_cache_range(pte, sizeof(*pte));
>> +
>> +	/*
>> +	 * VT-d spec 3.4 table23 states guides for cache invalidation:
>> +	 *
>> +	 * - PASID-selective-within-Domain PASID-cache invalidation
>> +	 * - PASID-selective PASID-based IOTLB invalidation
>> +	 * - If (pasid is RID_PASID)
>> +	 *    - Global Device-TLB invalidation to affected functions
>> +	 *   Else
>> +	 *    - PASID-based Device-TLB invalidation (with S=1 and
>> +	 *      Addr[63:12]=0x7FFFFFFF_FFFFF) to affected functions
>> +	 */
>> +	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
>> +	qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
>> +
>> +	/* Device IOTLB doesn't need to be flushed in caching mode. */
>> +	if (!cap_caching_mode(iommu->cap))
>> +		devtlb_invalidation_with_pasid(iommu, dev, pasid);
>> +}
>> --
>> 2.25.1
> 

