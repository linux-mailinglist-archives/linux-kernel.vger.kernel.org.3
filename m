Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D6351BF0A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 14:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376368AbiEEMSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 08:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376316AbiEEMSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:18:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BAC6554
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 05:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651752861; x=1683288861;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5u315Q6xTtileslXK7Z/heN6yy8xKxXd07kS59rW7+g=;
  b=SECPu9/4aKKfx+IK3FLUFi5Jus3uEtYUx0wD+f/geje3779RNx9hfk+p
   vW1QNmq6YKEWGA8Z33fxiQqHy2+D/rSi3vlwc2EfEomFftSAKI6XZySSy
   DAb6eVURS8f2rLZRhWVi+/4xkhw+KmiPYsz/7Lkvg4dc/bJPf3jOX6CxT
   1oHcv+Z1aPduR5ybv8OtlEscwGscaXS+P+TD2NTYmtqDimb84bawb3Y1D
   F7wpDpM+rb7TQbp9fhSzkX7cmdDvN2znmSK1ycuYZtmKn7eSpfuESFPSH
   fvt+WTiRVKRNnv+vqiGnnN8PzOSalOwVL6aCXaoKwLCGzf89sn5GcyVXm
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="354525028"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="354525028"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 05:14:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="563216207"
Received: from minhaowa-mobl.ccr.corp.intel.com (HELO [10.255.30.75]) ([10.255.30.75])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 05:14:18 -0700
Message-ID: <d93853b5-cc5a-facb-e739-080483e87b4d@linux.intel.com>
Date:   Thu, 5 May 2022 20:14:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 4/4] iommu/vt-d: Remove hard coding PGSNP bit in PASID
 entries
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220505010710.1477739-1-baolu.lu@linux.intel.com>
 <20220505010710.1477739-5-baolu.lu@linux.intel.com>
 <BN9PR11MB52764D45B7CBC333D19A6F448CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52764D45B7CBC333D19A6F448CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2022/5/5 16:46, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, May 5, 2022 9:07 AM
>>
>> As enforce_cache_coherency has been introduced into the
>> iommu_domain_ops,
>> the kernel component which owns the iommu domain is able to opt-in its
>> requirement for force snooping support. The iommu driver has no need to
>> hard code the page snoop control bit in the PASID table entries anymore.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>, with one nit:
> 
>> ---
>>   drivers/iommu/intel/pasid.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index 41a0e3b02c79..0abfa7fc7fb0 100644
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -710,9 +710,6 @@ int intel_pasid_setup_second_level(struct
>> intel_iommu *iommu,
>>   	pasid_set_fault_enable(pte);
>>   	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
> 
> Probably in a separate patch but above should really be renamed
> to pasid_set_page_walk_snoop().

Yeah! Need a cleanup here. Above name is confusing.

> 
>>
>> -	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
>> -		pasid_set_pgsnp(pte);
>> -
>>   	/*
>>   	 * Since it is a second level only translation setup, we should
>>   	 * set SRE bit as well (addresses are expected to be GPAs).
>> --
>> 2.25.1
> 

Best regards,
baolu
