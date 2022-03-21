Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D731E4E2475
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 11:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346402AbiCUKij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 06:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243611AbiCUKih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:38:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B03013F8DE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 03:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647859032; x=1679395032;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=S1/tQ9SiaSd0WTXMnIOTQ55ZL/Kc6bpKG4dk8f2YTH8=;
  b=VrFD+q1uk13p36IInUvCobwYsoxJOge3G+36LJA/CoCGnpbte4Ef7U30
   JUSZPgNXQyib1LFQjQ3YYRJZHo1Wyp+q6p4vgg3/Wr39tBj9lqeifo1UF
   5m3zxdIDbDHbdsVSR2GN58RZe5s7JBmItrW0ydPWEVjT2khS7ymKdKpto
   Aq10SpV5Ea4vpVXru6814cxvzFx8m1FD82dXsgsfbqWpS3xX56yojhftA
   ZS1LiYSm99Vy/CeNoiehQIxlphHE7huoOEClkzh7NDVYKyDIoNRpRv2qI
   I7jp/eOI1YP2BF4TjbVWZ2qHgG6dA2Gfq2ZLhY0Dgj6jFzyzXEagg7vNl
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="320723546"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="320723546"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 03:37:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="559810191"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.169]) ([10.254.213.169])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 03:37:08 -0700
Message-ID: <5c4f0b10-1aa6-74cd-333d-46619aa9b27b@linux.intel.com>
Date:   Mon, 21 Mar 2022 18:37:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-5-baolu.lu@linux.intel.com>
 <BL1PR11MB527146393985BC3EE2EAF7648C169@BL1PR11MB5271.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC 04/11] iommu/vt-d: Add SVA domain support
In-Reply-To: <BL1PR11MB527146393985BC3EE2EAF7648C169@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/21 15:45, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Sunday, March 20, 2022 2:40 PM
>>
>> Add support for SVA domain allocation and provide an SVA-specific
>> iommu_domain_ops.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   include/linux/intel-iommu.h |  1 +
>>   drivers/iommu/intel/iommu.c | 12 ++++++++++++
>>   drivers/iommu/intel/svm.c   | 34 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 47 insertions(+)
>>
>> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
>> index 2f9891cb3d00..c14283137fb5 100644
>> --- a/include/linux/intel-iommu.h
>> +++ b/include/linux/intel-iommu.h
>> @@ -744,6 +744,7 @@ void intel_svm_unbind(struct iommu_sva *handle);
>>   u32 intel_svm_get_pasid(struct iommu_sva *handle);
>>   int intel_svm_page_response(struct device *dev, struct iommu_fault_event
>> *evt,
>>   			    struct iommu_page_response *msg);
>> +extern const struct iommu_domain_ops intel_svm_domain_ops;
>>
>>   struct intel_svm_dev {
>>   	struct list_head list;
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index c1b91bce1530..d55dca3eacf8 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4318,6 +4318,18 @@ static struct iommu_domain
>> *intel_iommu_domain_alloc(unsigned type)
>>   		return domain;
>>   	case IOMMU_DOMAIN_IDENTITY:
>>   		return &si_domain->domain;
>> +#ifdef CONFIG_INTEL_IOMMU_SVM
>> +	case IOMMU_DOMAIN_SVA:
>> +		dmar_domain = alloc_domain(type);
>> +		if (!dmar_domain) {
>> +			pr_err("Can't allocate sva domain\n");
>> +			return NULL;
>> +		}
>> +		domain = &dmar_domain->domain;
>> +		domain->ops = &intel_svm_domain_ops;
>> +
>> +		return domain;
>> +#endif /* CONFIG_INTEL_IOMMU_SVM */
>>   	default:
>>   		return NULL;
>>   	}
>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>> index ee5ecde5b318..b9f4dd7057d1 100644
>> --- a/drivers/iommu/intel/svm.c
>> +++ b/drivers/iommu/intel/svm.c
>> @@ -932,3 +932,37 @@ int intel_svm_page_response(struct device *dev,
>>   	mutex_unlock(&pasid_mutex);
>>   	return ret;
>>   }
>> +
>> +static int intel_svm_attach_dev_pasid(struct iommu_domain *domain,
>> +				      struct device *dev, ioasid_t pasid)
>> +{
>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +	struct mm_struct *mm = domain->sva_cookie;
>> +	struct intel_iommu *iommu = info->iommu;
>> +	struct iommu_sva *sva;
>> +
>> +	mutex_lock(&pasid_mutex);
>> +	sva = intel_svm_bind_mm(iommu, dev, mm);
>> +	mutex_unlock(&pasid_mutex);
>> +
> 
> I'm not sure whether this is the right implementation of this callback.
> In last patch you said it will be used for multiple usages but here it
> is fixed to mm binding.

It is for svm domain ops so it should be mm binding only. For other
usages, they should have different domain ops.

> Also the pasid argument is not used at all
> and instead it is retrieved from mm struct implicitly.

The pasid is not used here because it has already been stored in
mm->pasid. Since it's only for SVM domain, I think it's okay.

> 
> Basically SVA requires three steps:
> 
> 1) alloc a SVA-type domain;
> 2) construct the domain to wrap mm;
> 3) attach the domain to a PASID;
> 
> If we aim .attach_dev_pasid to be generic it may suggest that 1) and 2)
> should be done before .attach_dev_pasid then within this callback it
> just deals with domain/pasid attach in a generic way.

You are right. This code does have room for further cleanup. I would
like to put that in a separated series so that we could focus on the
generic SVA and IOPF refactoring.

> 
>> +	return IS_ERR_OR_NULL(sva);
>> +}
>> +
>> +static void intel_svm_detach_dev_pasid(struct iommu_domain *domain,
>> +				       struct device *dev, ioasid_t pasid)
>> +{
>> +	mutex_lock(&pasid_mutex);
>> +	intel_svm_unbind_mm(dev, pasid);
>> +	mutex_unlock(&pasid_mutex);
>> +}
>> +
>> +static void intel_svm_domain_free(struct iommu_domain *domain)
>> +{
>> +	kfree(domain);
>> +}
>> +
>> +const struct iommu_domain_ops intel_svm_domain_ops = {
>> +	.attach_dev_pasid	= intel_svm_attach_dev_pasid,
>> +	.detach_dev_pasid	= intel_svm_detach_dev_pasid,
>> +	.free			= intel_svm_domain_free,
>> +};
>> --
>> 2.25.1
> 

Best regards,
baolu
