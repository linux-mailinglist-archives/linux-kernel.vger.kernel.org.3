Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAF04AD06B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 05:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346966AbiBHEjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 23:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbiBHEjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 23:39:46 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DF7C0401DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 20:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644295185; x=1675831185;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FB5zW1A6N8AXgDD9DV4LEXmGsNGVLpUJmNLzebZDg1k=;
  b=bCeefMrd/8i8v2a/Cu/any5vYQjgFrGZZgulER4p1yjgLVcerht/6MFH
   DWW2F6KTkfJH/m/c6+c8ZPqVs7OrdqBMsbjP5/aZl0SDgKAuglhf3iXcH
   qQOO/WE3Due24WA+M3CQERf0xcCStkbH6qQ8bqxEmsD+sAOPBzRha0sWl
   9auBT1ZrrMu6YdUYcmg2hSQwajmNTnOJkBsAbqd+Klddxsl8a7oKUzACU
   OuPwxZI4w7IDWptThbK0cxQhdiIj6Ix/+4nuKNScoFlzF4nu31wcXmJ/0
   MclyOHIJu/jm7ejhnJlcEQB89w5zaEpEzvMTQT0d5BkXifUog5FMyiyuk
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="229517963"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="229517963"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 20:39:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="677986757"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 20:39:43 -0800
Message-ID: <762360b8-57ca-ab48-c454-25b9c0aec5de@linux.intel.com>
Date:   Tue, 8 Feb 2022 12:38:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/10] iommu/vt-d: Use an xarray for global
 device_domain_info
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
 <20220207064142.1092846-8-baolu.lu@linux.intel.com>
 <20220207071420.GG23941@lst.de>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220207071420.GG23941@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/22 3:14 PM, Christoph Hellwig wrote:
>> + #define DEVI_IDX(seg, bus, devfn) ((((u16)(seg)) << 16) | PCI_DEVID(bus, devfn))
> 
> Please turn this into an real function.

Sure.

>>   /*
>> - * Iterate over elements in device_domain_list and call the specified
>> + * Iterate over elements in device_domain_array and call the specified
>>    * callback @fn against each element.
>>    */
>>   int for_each_device_domain(int (*fn)(struct device_domain_info *info,
>>   				     void *data), void *data)
>>   {
>>   	struct device_domain_info *info;
>> +	unsigned long index;
>> +	int ret = 0;
>>   
>> +	rcu_read_lock();
>> +	xa_for_each(&device_domain_array, index, info) {
>>   		ret = fn(info, data);
>> +		if (ret)
>> +			break;
>>   	}
>> +	rcu_read_unlock();
> 
> Can't we just open code this in the caller now?

That's better. I will remove this helper and make iteration in the only
caller.

> 
>>   const struct iommu_ops intel_iommu_ops;
>> @@ -900,7 +898,8 @@ static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn, u8 bus, u
>>   	struct dmar_domain *domain;
>>   	int offset, level;
>>   
>> -	info = dmar_search_domain_by_dev_info(iommu->segment, bus, devfn);
>> +	info = xa_load(&device_domain_array,
>> +		       DEVI_IDX(iommu->segment, bus, devfn));
>>   	if (!info || !info->domain) {
>>   		pr_info("device [%02x:%02x.%d] not probed\n",
>>   			bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
> 
> Is there any refcounting or other life time protection for the info
> structures?

The info structure's life is managed by iommu_probe/release_device(). It
is created in probe() and freed in release().

Best regards,
baolu
