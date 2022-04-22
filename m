Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDC450B80E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447788AbiDVNQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447789AbiDVNQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:16:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68348580DA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650633220; x=1682169220;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tC39CcHCCAkxRGoLupvWWCwop7YOMFc9XUJ+TwGQPfg=;
  b=DRS8dm3s5lCUGTfjsvIVHN0LLnFrFrDnWhnO5RJFDhl9ZFa0i6elxZGv
   Dsw1XyykM49RhKv30EZ9G+N2cq90Y9EFU3xZBjvCnftN6vK+T+49sVQCD
   i3p773RGIlRKQdOgVU0cojh/BtCIFCij/rKLSg+67+uE/Ds9oOU9FoIJ0
   6iEraarXqoTgNnPUlMHxMh8NXHqf2GBbR1JMWHRUgkrCROoaEER7wXnrR
   LZ4+eYMMZ/VrVsN5zBaBYlrJLhZCPosm/iif4SxNHhhqLug0aBybbQpri
   tMS/EjDyZuIGPB+aG3NHV6IeKOF+rxjE4GGApRSyV/eXaZlkqynSlguup
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="351109961"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="351109961"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 06:13:40 -0700
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="556374272"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.236]) ([10.254.215.236])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 06:13:37 -0700
Message-ID: <8440e43b-aa1f-2648-6b64-afc34aa97bc2@linux.intel.com>
Date:   Fri, 22 Apr 2022 21:13:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] iommu/vt-d: Set PGSNP bit in pasid table entry for
 SVA binding
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
References: <20220421113558.3504874-1-baolu.lu@linux.intel.com>
 <20220421113558.3504874-3-baolu.lu@linux.intel.com>
 <BN9PR11MB5276EDDABE40B6A6A67A0F4E8CF79@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276EDDABE40B6A6A67A0F4E8CF79@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2022/4/22 11:05, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, April 21, 2022 7:36 PM
>>
>> This field make the requests snoop processor caches irrespective of
>> other attributes in the request or other fields in paging structure
>> entries used to translate the request.
> 
> I think you want to first point out the fact that SVA wants snoop
> cache instead of just talking about the effect of PGSNP.
> 
> But thinking more I wonder why PGSNP is ever required. This is
> similar to DMA API case. x86 is already cache coherent for normal
> DMA (if not setting PCI no-snoop) and if the driver knows no-snoop
> is incompatible to SVA API then it should avoid triggering no-snoop
> traffic for SVA usage. In this case it is pointless for IOMMU driver
> to enable force-snooping. Even in the future certain platform allows
> no-snoop usage w/ SVA (I'm not sure how it works) this again should
> be reflected by additional SVA APIs for driver to explicitly manage.
> 
> force-snoop should be enabled only in device assignment case IMHO,
> orthogonal to whether vSVA is actually used.
> 
> Did I misunderstand the motivation here?

No, you didn't.

Let's talk with the arch guys for more details before move this patch
ahead. Thanks for pointing this out.

Best regards,
baolu

> 
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/svm.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>> index 23a38763c1d1..c720d1be992d 100644
>> --- a/drivers/iommu/intel/svm.c
>> +++ b/drivers/iommu/intel/svm.c
>> @@ -391,9 +391,12 @@ static struct iommu_sva
>> *intel_svm_bind_mm(struct intel_iommu *iommu,
>>   	}
>>
>>   	/* Setup the pasid table: */
>> -	sflags = (flags & SVM_FLAG_SUPERVISOR_MODE) ?
>> -			PASID_FLAG_SUPERVISOR_MODE : 0;
>> -	sflags |= cpu_feature_enabled(X86_FEATURE_LA57) ?
>> PASID_FLAG_FL5LP : 0;
>> +	sflags = PASID_FLAG_PAGE_SNOOP;
>> +	if (flags & SVM_FLAG_SUPERVISOR_MODE)
>> +		sflags |= PASID_FLAG_SUPERVISOR_MODE;
>> +	if (cpu_feature_enabled(X86_FEATURE_LA57))
>> +		sflags |= PASID_FLAG_FL5LP;
>> +
>>   	spin_lock_irqsave(&iommu->lock, iflags);
>>   	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm-
>>> pasid,
>>   					    FLPT_DEFAULT_DID, sflags);
>> --
>> 2.25.1
> 
