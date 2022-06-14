Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8624154AAD5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239222AbiFNHod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiFNHo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:44:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF2625E9F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655192666; x=1686728666;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WehaGt8hJaU+Ma/bzE5/Cn87XrAOis5/aygzc+ECE0w=;
  b=BA+bv549wRi23SDSqwagbh1t9puYERGmdT57GXbYvGMSNS11rXB2feqQ
   mA/xeYC9BNNA+XECGesXnLn0mb6lruXFTQ5DtXFKBAM1VMOKlEfr7Q95X
   nsZjJ+YOMt637Zk5GLpum+FD++Lov958dOyMFYkPjo/H3GaNWBHiPs5nW
   u/+3/UAPvQcmd9F76lLa/tX5u7ZDyiiaG8PomjLfpO5Y8taG6k7P5WYYM
   0e+hwpAF+/1pIaaUA1gXOnRfdghOLoS4QRQH1Of7KjO9rsV+U65LJBaBI
   xZEyfMOPE3MA4NIeZFc1Sayf736vFfIvvFLZK1KsIJNfV0S7sWtebXkG2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="278577559"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="278577559"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:44:26 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="910847959"
Received: from gren5-mobl1.ccr.corp.intel.com (HELO [10.255.29.39]) ([10.255.29.39])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:44:23 -0700
Message-ID: <1e19074b-0f8d-b897-585c-582ff3e63367@linux.intel.com>
Date:   Tue, 14 Jun 2022 15:44:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/12] iommu/vt-d: Fold __dmar_remove_one_dev_info()
 into its caller
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
 <20220614025137.1632762-11-baolu.lu@linux.intel.com>
 <BN9PR11MB527646793F6DFD18145A455D8CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527646793F6DFD18145A455D8CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/14 15:07, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 14, 2022 10:52 AM
>>
>> Fold __dmar_remove_one_dev_info() into dmar_remove_one_dev_info()
>> which
>> is its only caller. Make the spin lock critical range only cover the
>> device list change code and remove some unnecessary checks.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 34 +++++++++-------------------------
>>   1 file changed, 9 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index af22690f44c8..8345e0c0824c 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -295,7 +295,6 @@ static LIST_HEAD(dmar_satc_units);
>>   static int g_num_of_iommus;
>>
>>   static void dmar_remove_one_dev_info(struct device *dev);
>> -static void __dmar_remove_one_dev_info(struct device_domain_info *info);
>>
>>   int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
>>   int intel_iommu_sm =
>> IS_ENABLED(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
>> @@ -4141,20 +4140,14 @@ static void domain_context_clear(struct
>> device_domain_info *info)
>>   			       &domain_context_clear_one_cb, info);
>>   }
>>
>> -static void __dmar_remove_one_dev_info(struct device_domain_info *info)
>> +static void dmar_remove_one_dev_info(struct device *dev)
>>   {
>> -	struct dmar_domain *domain;
>> -	struct intel_iommu *iommu;
>> -
>> -	assert_spin_locked(&device_domain_lock);
>> -
>> -	if (WARN_ON(!info))
>> -		return;
>> -
>> -	iommu = info->iommu;
>> -	domain = info->domain;
>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +	struct dmar_domain *domain = info->domain;
> this local variable is not required as there is just one reference
> to info->domain.

Yes. It could be removed and use info->domain directly.

> 
> btw I didn't see info->domain is cleared in this path. Is it correct?
> 

It's better to clear here. I will make this change in my in-process
blocking domain series.

But it doesn't cause any real problems because the Intel IOMMU driver
supports default domain, hence the logic here is info->domain is
replaced, but not cleared.

Best regards,
baolu
