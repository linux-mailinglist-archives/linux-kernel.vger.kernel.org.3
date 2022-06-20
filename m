Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8AC550DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbiFTAe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237518AbiFTAe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:34:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0120D64D8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655685296; x=1687221296;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bRwOrL3zS4/DTbu+XdtxLOCJrOogVrjj6ICT6KYMsqg=;
  b=FlptYWKCckgZ1QhdyrCxVm5BhhjFV6XTA+UFcuyx4jSCvgoSdq+aT5yA
   +BC//KXMi0qGvSYTPV4v8/Hl6R0Cx9/Rl6666hwDwH4d2CWcPqIhYOVqm
   GF2Iv2jJTzM9T8pF55F4SCnWH9mUnfglBQbXfp3w5cVzppXnY6fWPRMaw
   2q/7Gus4FD0zh1VGBEf0yYKTPMv3Q5wbA0ffGR7HmN/USObcVfC9L0T8O
   w7cypSSI/QkLYRyXuWZKDeOyMZ92jroPyTspkbtYbgMll2wBEWb7rEoLL
   bS5BefKgQ5zCm7wdwN2zU9TOCa3H8DR9NXBlEV3LW04RGZwksy8/zeCVj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="277322108"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="277322108"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 17:34:55 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="832865028"
Received: from lgao7-mobl2.ccr.corp.intel.com (HELO [10.255.31.74]) ([10.255.31.74])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 17:34:52 -0700
Message-ID: <8dacfbe6-3f00-c61e-49e1-712c369a2285@linux.intel.com>
Date:   Mon, 20 Jun 2022 08:34:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Vinod Koul <vkoul@kernel.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v8 04/11] iommu: Add sva iommu_domain support
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>
References: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
 <20220607014942.3954894-5-baolu.lu@linux.intel.com>
 <20220609202540.GD33363@araj-dh-work>
 <a78c5bd0-a9f2-2a6d-3099-8d03c123fa93@linux.intel.com>
 <BN9PR11MB52765DEC46616F67185B1F1F8CAF9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52765DEC46616F67185B1F1F8CAF9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/17 15:43, Tian, Kevin wrote:
>> From: Baolu Lu
>> Sent: Friday, June 10, 2022 3:16 PM
>>>
>>>> +#define __IOMMU_DOMAIN_HOST_VA	(1U << 5)  /* Host CPU virtual
>> address */
>>>
>>> Do you mean general CPU VA? or Host CPU VA, I'm reading the latter as
>> 2nd
>>> stage?
>>
>> Host CPU VA. In the near future, we will add another flag _GUEST_VA, so
>> that the shared page table types are distiguished.
> 
> How does the kernel knows that an user page table translates guest VA?
> IMHO I don't think the kernel should care about it except managing
> all the aspects related to the user page table itself...

Okay.

> 
>>
>>>
>>>> +
>>>>    /*
>>>>     * This are the possible domain-types
>>>>     *
>>>> @@ -86,15 +89,24 @@ struct iommu_domain_geometry {
>>>>    #define IOMMU_DOMAIN_DMA_FQ
>> 	(__IOMMU_DOMAIN_PAGING |	\
>>>>    				 __IOMMU_DOMAIN_DMA_API |	\
>>>>    				 __IOMMU_DOMAIN_DMA_FQ)
>>>> +#define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SHARED |
>> 	\
>>>> +				 __IOMMU_DOMAIN_HOST_VA)
>>>
>>> Doesn't shared automatically mean CPU VA? Do we need another flag?
>>
>> Yes. Shared means CPU VA, but there're many types. Besides above two, we
>> also see the shared KVM/EPT.
>>
> 
> Will the two sharing scenarios share any common code? If not then
> having a separate flag bit is meaningless.

So far, I haven't seen the need for common code. I've ever thought about
the common notifier callback for page table entry update of SVA and KVM.
But there has been no feasible plan.

> 
> It might be more straightforward to be:
> 
> #define IOMMU_DOMAIN_SVA	__IOMMU_DOMAIN_SVA
> #define IOMMU_DOMAIN_KVM __IOMMU_DOMAIN_KVM
> #define IOMMU_DOMAIN_USER __IOMMU_DOMAIN_USER

I am okay with this and we can add some shared bits later if we need to
consolidate any code.

--
Best regards,
baolu
