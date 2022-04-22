Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7506250B7DE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447715AbiDVNHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbiDVNHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:07:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E069457B39
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650632655; x=1682168655;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uZG28orVAPmM/zfkdj07fKo/DkgWIcqu1t8OhIjSFOI=;
  b=M91fKUfPbvgwODVK2jTK42rrOrtWKugTt7QpxrjucoFBOT2+tMklR5J0
   a9ZcFvXWV0dGXEmKtVbs/Ukqe55/Q++bEoxqEkq7d8/dU6iVUiz5LHvvs
   fd1GAoLbiRA+psnFWcxjEoZ8rrg8gt5IaHyvmOQYqvToiwZ+d+vVl0c6C
   /0Z4MAJJEMLQnZXD4tpPsFhC0NiZi4BUcnLBzNRerL1z9RF7zAV2F0QhR
   E9W9LOridPlX9yGcaw/QXq7gNgd2DTfSClnqepIB3PQLiBbCbrEXRYRzO
   brJOy9XBxZ5oJduvrudtzYC7O8KF72uGXRkEyFiPbrs1JNohUiWyjC71R
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="327584880"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="327584880"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 06:04:15 -0700
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="556366441"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.236]) ([10.254.215.236])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 06:04:13 -0700
Message-ID: <503795b0-282c-2a8a-b669-5e7a0fc4a696@linux.intel.com>
Date:   Fri, 22 Apr 2022 21:04:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] iommu/vt-d: Check before setting PGSNP bit in
 pasid table entry
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
References: <20220421113558.3504874-1-baolu.lu@linux.intel.com>
 <20220421113558.3504874-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52767A16DC6BB80838C876068CF79@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52767A16DC6BB80838C876068CF79@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/22 10:47, Tian, Kevin wrote:
>> From: Lu Baolu
>> Sent: Thursday, April 21, 2022 7:36 PM
>>
>> The latest VT-d specification states that the PGSNP field in the pasid
>> table entry should be treated as Reserved(0) for implementations not
>> supporting Snoop Control (SC=0 in the Extended Capability Register).
>> This adds a check before setting the field.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/pasid.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index f8d215d85695..5cb2daa2b8cb 100644
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -625,8 +625,14 @@ int intel_pasid_setup_first_level(struct intel_iommu
>> *iommu,
>>   		}
>>   	}
>>
>> -	if (flags & PASID_FLAG_PAGE_SNOOP)
>> -		pasid_set_pgsnp(pte);
>> +	if (flags & PASID_FLAG_PAGE_SNOOP) {
>> +		if (ecap_sc_support(iommu->ecap)) {
>> +			pasid_set_pgsnp(pte);
>> +		} else {
>> +			pasid_clear_entry(pte);
>> +			return -EINVAL;
>> +		}
>> +	}
>>
>>   	pasid_set_domain_id(pte, did);
>>   	pasid_set_address_width(pte, iommu->agaw);
>> @@ -710,7 +716,8 @@ int intel_pasid_setup_second_level(struct
>> intel_iommu *iommu,
>>   	pasid_set_fault_enable(pte);
>>   	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
>>
>> -	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
>> +	if (ecap_sc_support(iommu->ecap) &&
>> +	    domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
>>   		pasid_set_pgsnp(pte);
>>
> This should be rebased on top of Jason's enforce coherency series
> instead of blindly setting it. No matter whether it's legacy mode
> where we set SNP in PTE or scalable mode where we set PGSNP
> in PASID entry for entire page table, the trigger point should be
> same i.e. when someone calls enforce_cache_coherency().

With Jason's enforce coherency series merged, we even don't need to set
PGSNP bit of a pasid entry for second level translation. 2nd level
always supports SNP in PTEs, so set PGSNP in pasid table entry is
unnecessary.

Any thoughts?

Best regards,
baolu
