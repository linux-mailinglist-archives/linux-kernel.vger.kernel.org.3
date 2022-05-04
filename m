Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45086519A58
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiEDIvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346594AbiEDIve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:51:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D80024BE0
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651654079; x=1683190079;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kRAxXFRDE1RfRdjz1uNhLBx4H2p9vLqfF7AlX0j83pA=;
  b=DrSMerryL8rWbY641mejVxI7h+4eyvGVPkdqNYIPoYdpBvZJtMqoe0pg
   I5y+jiHMIUOH3h8GkIf+E6gZw3HNaouCQbhAT8gh3q/CAfroL1gwffvqd
   1fPF8shO6Rt6qf0rNxIp9kQBaPi3KvpoyAHN5R1Aa8atPJ1y6xakXMnI4
   UdIlCOh/iO8JOjAUVIVKXUxZAnVIwpXJeddqYU+oCI10rGyrvCcFIPprY
   0QP78pTxB22c6hr/z10OHXOaTdrqA20AahSWmKUBxfnICjCNgh20dNC8c
   pGxUsUzaLssVPYnhjtXSNsOC/wOD6zuMWcz3PqudW5IUKVoHarMFuYlVI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="354141673"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="354141673"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 01:47:59 -0700
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="734304227"
Received: from yanc1-mobl.ccr.corp.intel.com (HELO [10.255.30.223]) ([10.255.30.223])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 01:47:56 -0700
Message-ID: <d42cba21-049d-0f0a-f030-60e1609fc4c3@linux.intel.com>
Date:   Wed, 4 May 2022 16:47:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 4/5] iommu/vt-d: Remove domain_update_iommu_snooping()
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220501112434.874236-1-baolu.lu@linux.intel.com>
 <20220501112434.874236-5-baolu.lu@linux.intel.com>
 <20220502143603.4143dd66@jacob-builder>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220502143603.4143dd66@jacob-builder>
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

On 2022/5/3 05:36, Jacob Pan wrote:
> Hi BaoLu,
> 
> On Sun, 1 May 2022 19:24:33 +0800, Lu Baolu <baolu.lu@linux.intel.com>
> wrote:
> 
>> The IOMMU force snooping capability is not required to be consistent
>> among all the IOMMUs anymore. Remove force snooping capability check
>> in the IOMMU hot-add path and domain_update_iommu_snooping() becomes
>> a dead code now.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 34 +---------------------------------
>>   1 file changed, 1 insertion(+), 33 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 3c1c228f9031..d5808495eb64 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -533,33 +533,6 @@ static void domain_update_iommu_coherency(struct
>> dmar_domain *domain) rcu_read_unlock();
>>   }
>>   
>> -static bool domain_update_iommu_snooping(struct intel_iommu *skip)
>> -{
>> -	struct dmar_drhd_unit *drhd;
>> -	struct intel_iommu *iommu;
>> -	bool ret = true;
>> -
>> -	rcu_read_lock();
>> -	for_each_active_iommu(iommu, drhd) {
>> -		if (iommu != skip) {
>> -			/*
>> -			 * If the hardware is operating in the scalable
>> mode,
>> -			 * the snooping control is always supported
>> since we
>> -			 * always set PASID-table-entry.PGSNP bit if the
>> domain
>> -			 * is managed outside (UNMANAGED).
>> -			 */
>> -			if (!sm_supported(iommu) &&
>> -			    !ecap_sc_support(iommu->ecap)) {
>> -				ret = false;
>> -				break;
>> -			}
>> -		}
>> -	}
>> -	rcu_read_unlock();
>> -
>> -	return ret;
>> -}
>> -
>>   static int domain_update_iommu_superpage(struct dmar_domain *domain,
>>   					 struct intel_iommu *skip)
>>   {
>> @@ -3593,12 +3566,7 @@ static int intel_iommu_add(struct dmar_drhd_unit
>> *dmaru) iommu->name);
>>   		return -ENXIO;
>>   	}
>> -	if (!ecap_sc_support(iommu->ecap) &&
>> -	    domain_update_iommu_snooping(iommu)) {
>> -		pr_warn("%s: Doesn't support snooping.\n",
>> -			iommu->name);
>> -		return -ENXIO;
>> -	}
>> +
> Maybe I missed earlier patches, so this bit can also be deleted?
> 
> struct dmar_domain {
> 	u8 iommu_snooping: 1;		/* indicate snooping control
> feature */

It has been cleaned up by below commit:

71cfafda9c9b vfio: Move the Intel no-snoop control off of IOMMU_CACHE

> 
>>   	sp = domain_update_iommu_superpage(NULL, iommu) - 1;
>>   	if (sp >= 0 && !(cap_super_page_val(iommu->cap) & (1 << sp))) {
>>   		pr_warn("%s: Doesn't support large page.\n",
> 
> 
> Thanks,
> 
> Jacob

Best regards,
baolu
