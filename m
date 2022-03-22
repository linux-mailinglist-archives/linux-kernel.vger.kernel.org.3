Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E7D4E37EA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 05:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbiCVE13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 00:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236388AbiCVE1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 00:27:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B09E25
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647923154; x=1679459154;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2wm+AQCGQMSPpw6TOJJave+CNOORE2KLol5wKDyuV1Q=;
  b=G1GsAN/v90gfCeWbKvYQ2JqWhdtKfk5RSx4OwnqRJGDL0BMeLiJBhUNo
   uMrrNjSBfJgMuvV3pLa+UzJeJcytuNZs1dJfiQcnd7y0VPXZCzSUXcHL2
   ZG/ThmTLKIdf7oXvvv/0GQUzKKnb8Kmu1zqM2PAtYu2Y0k30AIwCIXxlb
   dyQn6qN7JT3Ey5JdPKLUS4AjYQ+igz6ydztF88pN9bloJb77NaCV2pSBQ
   Tfhj+gb2Pc0+q9SBonp8oJ8zpcsVLTInqFCS39Mhn5MaCh81zmhIS6pV2
   3GlJ5pt8mZGsJSVtmtXvE5wHfexcn3v7mExAK5EINRPlV4ATCAdbgnBLn
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="282551505"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="282551505"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 21:25:54 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="518717895"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.186]) ([10.254.209.186])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 21:25:49 -0700
Message-ID: <3bf53e76-65cc-6975-c95f-c0f2ed66b8a5@linux.intel.com>
Date:   Tue, 22 Mar 2022 12:25:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 04/11] iommu/vt-d: Add SVA domain support
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-5-baolu.lu@linux.intel.com>
 <20220321115637.GK11336@nvidia.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220321115637.GK11336@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/21 19:56, Jason Gunthorpe wrote:
> On Sun, Mar 20, 2022 at 02:40:23PM +0800, Lu Baolu wrote:
>> Add support for SVA domain allocation and provide an SVA-specific
>> iommu_domain_ops.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>   include/linux/intel-iommu.h |  1 +
>>   drivers/iommu/intel/iommu.c | 12 ++++++++++++
>>   drivers/iommu/intel/svm.c   | 34 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 47 insertions(+)
>>
>> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
>> index 2f9891cb3d00..c14283137fb5 100644
>> +++ b/include/linux/intel-iommu.h
>> @@ -744,6 +744,7 @@ void intel_svm_unbind(struct iommu_sva *handle);
>>   u32 intel_svm_get_pasid(struct iommu_sva *handle);
>>   int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
>>   			    struct iommu_page_response *msg);
>> +extern const struct iommu_domain_ops intel_svm_domain_ops;
>>   
>>   struct intel_svm_dev {
>>   	struct list_head list;
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index c1b91bce1530..d55dca3eacf8 100644
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4318,6 +4318,18 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
>>   		return domain;
>>   	case IOMMU_DOMAIN_IDENTITY:
>>   		return &si_domain->domain;
>> +#ifdef CONFIG_INTEL_IOMMU_SVM
>> +	case IOMMU_DOMAIN_SVA:
>> +		dmar_domain = alloc_domain(type);
>> +		if (!dmar_domain) {
>> +			pr_err("Can't allocate sva domain\n");
> 
> Don't put random pr_err's/etc in drivers. At least try to use dev_err
> 
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
>> +	return IS_ERR_OR_NULL(sva);
> 
> Never use IS_ERR_OR_NULL(), fix whatever is wrong in intel_svm_bind_mm()
> that it can return NULL on failure.
> 
>> +const struct iommu_domain_ops intel_svm_domain_ops = {
>> +	.attach_dev_pasid	= intel_svm_attach_dev_pasid,
>> +	.detach_dev_pasid	= intel_svm_detach_dev_pasid,
> 
> Lets have consistent language either this is called SVA or SVM but not
> both.

Thanks a lot for above comments. All make sense to me.

Best regards,
baolu
