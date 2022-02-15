Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469024B6330
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 06:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbiBOF4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 00:56:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbiBOF4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:56:17 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E0190263
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644904568; x=1676440568;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HK++skmHQQ6xOlUsDveMh97GDMHjP+WEFiJn9BQ2OZE=;
  b=RvYHW2FOHhjy5cNjKmMnbI05La1qH7bq+1vYWh+r+UwDkBS+O1VRP0uD
   5kp1dagW0tbZokUOxm6zY+2StRvJ23i5hElGik21sSENJVg9tN1XpxVe9
   4CwjaF6xZ24nTjxEuppky+VaozYb9BdLSvBps1cp2favj9wW9zZ/mMf8W
   vt3DRQbAg2fc0XdvkyOQmzW6NAfhXIyPDLsYyutzCOI64Xipx1DHBnuDh
   oesRRwjpITeGvIwtKUqgLIvU/+rA9PwepJ9KTZu1ygzLu2sgbIp7oqb1a
   OSgTe5v4SqyJIjOCU7eC33nGR4kzgQPU0FiNC38kP+PLvTzyl2waCfxKS
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="247850982"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="247850982"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 21:56:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="680852152"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2022 21:56:05 -0800
Message-ID: <653f7bf3-07b3-e411-82e1-7b4892124ef7@linux.intel.com>
Date:   Tue, 15 Feb 2022 13:54:47 +0800
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
Subject: Re: [PATCH v2 10/11] iommu/vt-d: Use xarray for global
 device_domain_info
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-11-baolu.lu@linux.intel.com>
 <20220214073820.GF17411@lst.de>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220214073820.GF17411@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 2/14/22 3:38 PM, Christoph Hellwig wrote:
>>   
>>   const struct iommu_ops intel_iommu_ops;
>> @@ -903,7 +905,8 @@ static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn, u8 bus, u
>>   	struct dmar_domain *domain;
>>   	int offset, level;
>>   
>> -	info = dmar_search_domain_by_dev_info(iommu->segment, bus, devfn);
>> +	info = xa_load(&device_domain_array,
>> +		       devi_idx(iommu->segment, bus, devfn));
>>   	if (!info || !info->domain) {
>>   		pr_info("device [%02x:%02x.%d] not probed\n",
>>   			bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
>> @@ -1742,14 +1745,14 @@ static int iommu_init_domains(struct intel_iommu *iommu)
> 
> Don't we need a rcu critical section here?
> 
>> -	list_for_each_entry_safe(info, tmp, &device_domain_list, global) {
>> +	rcu_read_lock();
>> +	xa_for_each(&device_domain_array, index, info) {
>>   		if (info->iommu != iommu)
>>   			continue;
>>   
>> @@ -1758,7 +1761,7 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
>>   
>>   		__dmar_remove_one_dev_info(info);
>>   	}
>> -	spin_unlock_irqrestore(&device_domain_lock, flags);
>> +	rcu_read_unlock();
> 
> __dmar_remove_one_dev_info asserts that device_domain_lock is held,
> which these two hunks remove.
> 
>>   	spin_lock_irqsave(&device_domain_lock, flags);
>>   	dev_iommu_priv_set(dev, NULL);
>> -	list_del(&info->global);
>> +	xa_erase(&device_domain_array,
>> +		 devi_idx(info->segment, info->bus, info->devfn));
>>   	spin_unlock_irqrestore(&device_domain_lock, flags);
>>   
>>   	kfree(info);
> 
> Do we need a kfree_rcu here to allow rcu based access?

Thanks for your time and very appreciated for your comments. As replied
to Jason, I will stop 10/11 and 11/11 for now. From the current usage
scenario, the value of such refactoring is limited.

Best regards,
baolu
