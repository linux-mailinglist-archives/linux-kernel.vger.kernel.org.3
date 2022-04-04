Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADED94F0FAB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 08:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358661AbiDDGy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 02:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiDDGy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 02:54:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBC92F013
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 23:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649055150; x=1680591150;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d4EJgpI31PmWN0B47m6JWWP0qRkrjMfsasKfOoqk9Po=;
  b=nG0xrc+JDqNF1TOsBEUHdsJnwhLcdXUY4PomUG+N9+V/fnk7mJcfSWGd
   6HzcmlwEgUiDGwkS5nElGX/POJBnwfa1JyoQAprx8Kx4R7iAbZDpnllU8
   cY6DaV4he6bObRXdPtMmAYkOmd2wpZ7qsxBGzmrORyZSCuw5+CBCfqQdF
   KWwFnHwHgOC8q+AQvDeqTV5GjsLsL9xdIqoRyu/Bu+zpFY7pKgswnnX3V
   e6TnECwYoJyaIgSO3CAAc/xG5YNl0J7U+BvxKiHZ7HdxsLbd1rWafFk/l
   Esdkw8D77OYQNrkz+vl4MLyLBC0fqx9spJAluLicAyWUX+XzxgRCMT6ws
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="285399005"
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="285399005"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 23:52:30 -0700
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="548545493"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.140]) ([10.254.214.140])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 23:52:27 -0700
Message-ID: <970aac17-5ea5-881f-47df-4c66595917d8@linux.intel.com>
Date:   Mon, 4 Apr 2022 14:52:24 +0800
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
Subject: Re: [PATCH RFC v2 06/11] iommu/vt-d: Add SVA domain support
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-7-baolu.lu@linux.intel.com>
 <20220330190956.GD2120790@nvidia.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220330190956.GD2120790@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/31 3:09, Jason Gunthorpe wrote:
> On Tue, Mar 29, 2022 at 01:37:55PM +0800, Lu Baolu wrote:
>> Add support for SVA domain allocation and provide an SVA-specific
>> iommu_domain_ops.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>   include/linux/intel-iommu.h |  1 +
>>   drivers/iommu/intel/iommu.c | 10 ++++++++++
>>   drivers/iommu/intel/svm.c   | 37 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 48 insertions(+)
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
>> index c1b91bce1530..5eae7cf9bee5 100644
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4318,6 +4318,16 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
>>   		return domain;
>>   	case IOMMU_DOMAIN_IDENTITY:
>>   		return &si_domain->domain;
>> +#ifdef CONFIG_INTEL_IOMMU_SVM
>> +	case IOMMU_DOMAIN_SVA:
>> +		dmar_domain = alloc_domain(type);
>> +		if (!dmar_domain)
>> +			return NULL;
>> +		domain = &dmar_domain->domain;
>> +		domain->ops = &intel_svm_domain_ops;
>> +
>> +		return domain;
>> +#endif /* CONFIG_INTEL_IOMMU_SVM */
> 
> If this is the usual pattern for drivers I would prefer to see an
> alloc_sva op instead of more and more types.
> 
> Multiplexing functions is often not a great idea...

Robin mentioned that the iommu domain alloc/free interfaces are under
reforming. These cleanups need to wait to see what the final code looks
like.

Best regards,
baolu
