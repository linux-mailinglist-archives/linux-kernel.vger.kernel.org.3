Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5923554AAE6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354132AbiFNHr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353068AbiFNHr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:47:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5774D19FA0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655192846; x=1686728846;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bBWV4mimAXM6dNrx6MgT/rmjeGVJLaL37ecgW/HcuLQ=;
  b=hRShD65K/hRmYCCz5qrVZHio908EslTJyhE3OeNv/vCHSg3Wxonvl+Tr
   SQYTvgKIOgt04YGnw8rIMSo9MSDFrUk4hm+lHAr8VrTKJVkWeqKYZDmQ9
   zvz7jzv6vZzRAjq3OoxAjbWHfYIastWUnFObbT/6gKWNhL2S+jbI4bwjf
   qiF/Orq0lPBUClG4h1VwRGkzMCDvo4bSBrQYOoZ8xsrU2bDdqhvsU/FPn
   OkmdhO2QAwdYEx+kStm5bcXFaTtmmGtfBUK6vYJYj7LviK92hDKNHRfXl
   IhxRWNTZm76rIL1H4DC3/3Q4iByUzo+GT3K90pkE9bp0BQ28+WAT6I0Wd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="277321728"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="277321728"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:47:26 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="910848704"
Received: from gren5-mobl1.ccr.corp.intel.com (HELO [10.255.29.39]) ([10.255.29.39])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:47:23 -0700
Message-ID: <76dfe89b-67a1-bbea-0c63-18790adb7b9d@linux.intel.com>
Date:   Tue, 14 Jun 2022 15:47:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/12] iommu/vt-d: Use device_domain_lock accurately
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
 <20220614025137.1632762-12-baolu.lu@linux.intel.com>
 <BN9PR11MB52764D7CD86448C5E4EB46668CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52764D7CD86448C5E4EB46668CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/14 15:16, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 14, 2022 10:52 AM
>>
>> The device_domain_lock is used to protect the device tracking list of
>> a domain. Remove unnecessary spin_lock/unlock()'s and move the necessary
>> ones around the list access.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 68 +++++++++++++++----------------------
>>   1 file changed, 27 insertions(+), 41 deletions(-)
>>
> [...]
>> +iommu_support_dev_iotlb(struct dmar_domain *domain, struct
>> intel_iommu *iommu,
>> +			u8 bus, u8 devfn)
>>   {
>> -	struct device_domain_info *info;
>> -
>> -	assert_spin_locked(&device_domain_lock);
>> +	struct device_domain_info *info = NULL, *tmp;
>> +	unsigned long flags;
>>
>>   	if (!iommu->qi)
>>   		return NULL;
>>
>> -	list_for_each_entry(info, &domain->devices, link)
>> -		if (info->iommu == iommu && info->bus == bus &&
>> -		    info->devfn == devfn) {
>> -			if (info->ats_supported && info->dev)
>> -				return info;
>> +	spin_lock_irqsave(&device_domain_lock, flags);
>> +	list_for_each_entry(tmp, &domain->devices, link) {
>> +		if (tmp->iommu == iommu && tmp->bus == bus &&
>> +		    tmp->devfn == devfn) {
>> +			if (tmp->ats_supported)
>> +				info = tmp;
> 
> Directly returning with unlock here is clearer than adding
> another tmp variable...

Sure.

> 
>> @@ -2460,15 +2450,14 @@ static int domain_add_dev_info(struct
>> dmar_domain *domain, struct device *dev)
>>   	if (!iommu)
>>   		return -ENODEV;
>>
>> -	spin_lock_irqsave(&device_domain_lock, flags);
>> -	info->domain = domain;
>>   	ret = domain_attach_iommu(domain, iommu);
>> -	if (ret) {
>> -		spin_unlock_irqrestore(&device_domain_lock, flags);
>> +	if (ret)
>>   		return ret;
>> -	}
>> +
>> +	spin_lock_irqsave(&device_domain_lock, flags);
>>   	list_add(&info->link, &domain->devices);
>>   	spin_unlock_irqrestore(&device_domain_lock, flags);
>> +	info->domain = domain;
>>
> 
> This is incorrect. You need fully initialize the object before adding
> it to the list. Otherwise a search right after above unlock and
> before assigning info->domain will get a wrong data

Fair enough. Will fix it in the next version.

Best regards,
baolu
