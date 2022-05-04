Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF331519942
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346075AbiEDIKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346043AbiEDIK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:10:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304C1222BE
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651651613; x=1683187613;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tmRXtNrLKdCf11/lvNmRD1ODw4rKWktJoQuAZN0pXGU=;
  b=U3bUuEfW8ft6V1ski4+iMOo9c+ioFz6+3+8HpxES41USA+sMHLGlJ2ho
   JZveYUEIP7AXZQah2gCl4cS6LNzwXLDkJEdTyc56Lh0FqDwZj2HQI+x8v
   Ayj+bQq8Poa9w02zFaWSrQ28HDpiowIkDZ4qVxLtN1+IbakWbQtVzl3VH
   4c7glU0aQ8VlAKDHY0ZhCUMlop9MQYK6ZM86ANXgwbfWirS9lc41JcnEw
   TqL5zP3dOR7bZwANM126KnahqWhx1iz13qQ0r+EV9ypJI/ZSw+1+iJyA6
   hyDIuWpd+sqTpfBVLjSe/4m0Yds7Jfu8vRpAKIargeiR3JZ5HiflTMjRN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="267293916"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="267293916"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 01:06:52 -0700
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="734293601"
Received: from yanc1-mobl.ccr.corp.intel.com (HELO [10.255.30.223]) ([10.255.30.223])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 01:06:50 -0700
Message-ID: <7f739f3b-b2a1-8a81-e134-738bdf2c44eb@linux.intel.com>
Date:   Wed, 4 May 2022 16:06:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/5] iommu/vt-d: Check domain force_snooping against
 attached devices
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220501112434.874236-1-baolu.lu@linux.intel.com>
 <20220501112434.874236-4-baolu.lu@linux.intel.com>
 <20220502143154.444dd1dd@jacob-builder>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220502143154.444dd1dd@jacob-builder>
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

On 2022/5/3 05:31, Jacob Pan wrote:
> Hi BaoLu,

Hi Jacob,

> 
> On Sun, 1 May 2022 19:24:32 +0800, Lu Baolu <baolu.lu@linux.intel.com>
> wrote:
> 
>> As domain->force_snooping only impacts the devices attached with the
>> domain, there's no need to check against all IOMMU units. At the same
>> time, for a brand new domain (hasn't been attached to any device), the
>> force_snooping field could be set, but the attach_dev callback will
>> return failure if it wants to attach to a device which IOMMU has no
>> snoop control capability.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/pasid.h |  2 ++
>>   drivers/iommu/intel/iommu.c | 50 ++++++++++++++++++++++++++++++++++++-
>>   drivers/iommu/intel/pasid.c | 18 +++++++++++++
>>   3 files changed, 69 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
>> index ab4408c824a5..583ea67fc783 100644
>> --- a/drivers/iommu/intel/pasid.h
>> +++ b/drivers/iommu/intel/pasid.h
>> @@ -123,4 +123,6 @@ void intel_pasid_tear_down_entry(struct intel_iommu
>> *iommu, bool fault_ignore);
>>   int vcmd_alloc_pasid(struct intel_iommu *iommu, u32 *pasid);
>>   void vcmd_free_pasid(struct intel_iommu *iommu, u32 pasid);
>> +void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
>> +					  struct device *dev, u32 pasid);
>>   #endif /* __INTEL_PASID_H */
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 98050943d863..3c1c228f9031 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4554,13 +4554,61 @@ static phys_addr_t
>> intel_iommu_iova_to_phys(struct iommu_domain *domain, return phys;
>>   }
>>   
>> +static bool domain_support_force_snooping(struct dmar_domain *domain)
>> +{
>> +	struct device_domain_info *info;
>> +	unsigned long flags;
>> +	bool support = true;
>> +
>> +	spin_lock_irqsave(&device_domain_lock, flags);
>> +	if (list_empty(&domain->devices))
>> +		goto out;
>> +
>> +	list_for_each_entry(info, &domain->devices, link) {
>> +		if (!ecap_sc_support(info->iommu->ecap)) {
>> +			support = false;
>> +			break;
>> +		}
>> +	}
> why not just check the flag dmar_domain->force_snooping? devices wouldn't
> be able to attach if !ecap_sc, right?

I should check "dmar_domain->force_snooping" first. If this is the first
time that this flag is about to set, then check the capabilities.

> 
>> +out:
>> +	spin_unlock_irqrestore(&device_domain_lock, flags);
>> +	return support;
>> +}
>> +
>> +static void domain_set_force_snooping(struct dmar_domain *domain)
>> +{
>> +	struct device_domain_info *info;
>> +	unsigned long flags;
>> +
>> +	/*
>> +	 * Second level page table supports per-PTE snoop control. The
>> +	 * iommu_map() interface will handle this by setting SNP bit.
>> +	 */
>> +	if (!domain_use_first_level(domain))
>> +		return;
>> +
>> +	spin_lock_irqsave(&device_domain_lock, flags);
>> +	if (list_empty(&domain->devices))
>> +		goto out_unlock;
>> +
>> +	list_for_each_entry(info, &domain->devices, link)
>> +		intel_pasid_setup_page_snoop_control(info->iommu,
>> info->dev,
>> +						     PASID_RID2PASID);
>> +
> I guess other DMA API PASIDs need to have sc bit set as well. I will keep
> this in mind for my DMA API PASID patch.

Kernel DMA don't need to set the PGSNP bit. The x86 arch is always DMA
coherent. The force snooping is only needed when the device is
controlled by user space, but the VMM is optimized not to support the
virtualization of the wbinv instruction.

> 
>> +out_unlock:
>> +	spin_unlock_irqrestore(&device_domain_lock, flags);
>> +}
>> +
>>   static bool intel_iommu_enforce_cache_coherency(struct iommu_domain
>> *domain) {
>>   	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>>   
>> -	if (!domain_update_iommu_snooping(NULL))
>> +	if (!domain_support_force_snooping(dmar_domain))
>>   		return false;
>> +
>> +	domain_set_force_snooping(dmar_domain);
>>   	dmar_domain->force_snooping = true;
>> +
> nit: spurious change

I expect a blank line before return in the end.

>>   	return true;
>>   }
>>   
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index f8d215d85695..815c744e6a34 100644
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -762,3 +762,21 @@ int intel_pasid_setup_pass_through(struct
>> intel_iommu *iommu,
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
>> +	pte = intel_pasid_get_entry(dev, pasid);
>> +	if (WARN_ON(!pte || !pasid_pte_is_present(pte)))
>> +		return;
>> +
>> +	pasid_set_pgsnp(pte);
>> +	did = pasid_get_domain_id(pte);
>> +	pasid_flush_caches(iommu, pte, pasid, did);
>> +}
> 
> 
> Thanks,
> 
> Jacob

Best regards,
baolu
