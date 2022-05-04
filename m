Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60E551990B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345969AbiEDIB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbiEDIB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:01:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7011F60E
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 00:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651651102; x=1683187102;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Oeji1B4yyBuyoQEJOvbEGC1Gb4wYj2jfC/S7tYYEPvI=;
  b=nbgnkN5daR0e/KYNd0vuEb1KdRTRQaGjBO+54hrKHht8E+C9X3eCPltV
   iki7yGISGQO/Q31dGF80c1VAZUj2vJoTk/F72babedXp6ont1VEPPRUoW
   awmOq8fceGvuTbnjgUhH9uIbyLnVQdv8bbRo+c+Jk2MT8or1ghV9zjYmJ
   v3bB6BFABy3rFvJfSNgX8SowLXwSdbRGc/BtVngbW00eKc1SNVf9ufwr+
   UkbvgIsAmSlclBNvtkTc+2Lg1i4RnLqdUXPv2Az7hGzLstkPmXTbkqFnO
   o9fA0GqsztdBcxk6Gk/Ynhl37TMsP5WaqJHcA050wgJrvzbBcEa3aXMeD
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="248235963"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="248235963"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 00:58:22 -0700
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="734289803"
Received: from yanc1-mobl.ccr.corp.intel.com (HELO [10.255.30.223]) ([10.255.30.223])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 00:58:20 -0700
Message-ID: <b9787888-1524-e170-0506-c6a012891de6@linux.intel.com>
Date:   Wed, 4 May 2022 15:58:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/5] iommu/vt-d: Check domain force_snooping against
 attached devices
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220501112434.874236-1-baolu.lu@linux.intel.com>
 <20220501112434.874236-4-baolu.lu@linux.intel.com>
 <20220502131747.GJ8364@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220502131747.GJ8364@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/2 21:17, Jason Gunthorpe wrote:
> On Sun, May 01, 2022 at 07:24:32PM +0800, Lu Baolu wrote:
>> +static bool domain_support_force_snooping(struct dmar_domain *domain)
>> +{
>> +	struct device_domain_info *info;
>> +	unsigned long flags;
>> +	bool support = true;
>> +
>> +	spin_lock_irqsave(&device_domain_lock, flags);
>> +	if (list_empty(&domain->devices))
>> +		goto out;
> 
> Why? list_for_each_entry will just do nothing..

Yes. I will remove above two lines.

> 
>> +	list_for_each_entry(info, &domain->devices, link) {
>> +		if (!ecap_sc_support(info->iommu->ecap)) {
>> +			support = false;
>> +			break;
>> +		}
>> +	}
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
>> +		intel_pasid_setup_page_snoop_control(info->iommu, info->dev,
>> +						     PASID_RID2PASID);
>> +
>> +out_unlock:
>> +	spin_unlock_irqrestore(&device_domain_lock, flags);
>> +}
>> +
>>   static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
>>   {
>>   	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>>   
>> -	if (!domain_update_iommu_snooping(NULL))
>> +	if (!domain_support_force_snooping(dmar_domain))
>>   		return false;
> 
> Maybe exit early if force_snooping = true?

Yes, should check "force_snooping = true" and return directly if
force_snooping has already been set. As you pointed below, the new
domain_attach should take care of this flag as well. Thanks!

> 
>> +	domain_set_force_snooping(dmar_domain);
>>   	dmar_domain->force_snooping = true;
>> +
>>   	return true;
>>   }
>>   
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index f8d215d85695..815c744e6a34 100644
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -762,3 +762,21 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
>>   
>>   	return 0;
>>   }
>> +
>> +/*
>> + * Set the page snoop control for a pasid entry which has been set up.
>> + */
> 
> So the 'first level' is only used with pasid?

Yes. A fake pasid (RID2PASID in spec) is used for legacy transactions
(those w/o pasid).

> 
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
> 
> Doesn't this need to be done in other places too, like when a new attach
> is made? Patch 5 removed it, but should that be made if
> domain->force_snooping?

Yes. I missed this. Will take care of this in the next version.

> 
> Jason

Best regards,
baolu
