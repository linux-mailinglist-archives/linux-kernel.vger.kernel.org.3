Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A990251D0D5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 07:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389254AbiEFFn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 01:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbiEFFnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 01:43:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA6465409
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 22:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651815608; x=1683351608;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RIVpEAtkuYO7pp01GcFGdlSw/mydcbT7MxtS5DfXDFI=;
  b=DUVyWhKP4s/TiNAejY3qz08TiYLJCpzC8OJIh0UDnA86kjj14814TuCA
   Eg/oCRs0kR4miOpHyI1H07chINF+J/O3GjWwi/nRAmYWxvClab9YJLi8C
   DedefbzJEeXURdR1hu3nzQx1pdQdcpgB1tksy7V7yN3z73oOEVA+BV+aj
   jBWf7+7Q3PbVMPMu0xquS/moqKtdj2ao2OBAbW4+mCSX/8dRe028meXU9
   qxkXrI7bhfHjloTTlbybHr8myGd+EPfEI7thoNXuXEEAd/4Kn0qjpdzls
   Ek0HhXx7vEd/L4TQ9oc+HK62YHJmt2byOVZPpA63cZJsmqUov4qNeajVI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="255840840"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="255840840"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 22:40:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="735409172"
Received: from sunyanwa-mobl1.ccr.corp.intel.com (HELO [10.255.31.183]) ([10.255.31.183])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 22:40:04 -0700
Message-ID: <5bbf6ccf-2a49-7611-b8af-143252decc1f@linux.intel.com>
Date:   Fri, 6 May 2022 13:40:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 10/12] iommu: Prepare IOMMU domain for IOPF
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-11-baolu.lu@linux.intel.com> <YnFydE8j8l7Q4m+b@myrica>
 <9144a782-04d2-a09d-4ac1-7133e5986619@linux.intel.com>
 <YnPTXwjpHnnGp4j2@myrica>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YnPTXwjpHnnGp4j2@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/5 21:38, Jean-Philippe Brucker wrote:
> Hi Baolu,
> 
> On Thu, May 05, 2022 at 04:31:38PM +0800, Baolu Lu wrote:
>> On 2022/5/4 02:20, Jean-Philippe Brucker wrote:
>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>> index 7cae631c1baa..33449523afbe 100644
>>>> --- a/drivers/iommu/iommu.c
>>>> +++ b/drivers/iommu/iommu.c
>>>> @@ -3174,3 +3174,24 @@ void iommu_detach_device_pasid(struct iommu_domain *domain,
>>>>    	iommu_group_put(group);
>>>>    }
>>>> +
>>>> +struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
>>>> +						    ioasid_t pasid)
>>>> +{
>>>> +	struct iommu_domain *domain;
>>>> +	struct iommu_group *group;
>>>> +
>>>> +	if (!pasid_valid(pasid))
>>>> +		return NULL;
>>>> +
>>>> +	group = iommu_group_get(dev);
>>>> +	if (!group)
>>>> +		return NULL;
>>>> +
>>>> +	mutex_lock(&group->mutex);
>>> Unfortunately this still causes the deadlock when unbind() flushes the
>>> IOPF queue while holding the group mutex.
>>
>> Sorry, I didn't get your point here.
>>
>> Do you mean unbind() could hold group mutex before calling this helper?
>> The group mutex is only available in iommu.c. The unbind() has no means
>> to hold this lock. Or, I missed anything?
> 
> I wasn't clear, it's iommu_detach_device_pasid() that holds the
> group->mutex:
> 
>   iommu_sva_unbind_device()          |
>    iommu_detach_device_pasid()       |
>     mutex_lock(&group->mutex)        |
>     domain->ops->detach_dev_pasid()  | iopf_handle_group()
>      iopf_queue_flush_dev()          |  iommu_get_domain_for_dev_pasid()
>       ... wait for IOPF work         |   mutex_lock(&group->mutex)
>                                      |    ... deadlock

Ah! Yes. Thank you for the clarification.

> 
> Thanks,
> Jean
> 
>>
>> Best regards,
>> baolu
>>
>>>
>>> If we make this function private to IOPF, then we can get rid of this
>>> mutex_lock(). It's OK because:
>>>
>>> * xarray protects its internal state with RCU, so we can call
>>>     xa_load() outside the lock.
>>>
>>> * The domain obtained from xa_load is finalized. Its content is valid
>>>     because xarray stores the domain using rcu_assign_pointer(), which has a
>>>     release memory barrier, which pairs with data dependencies in IOPF
>>>     (domain->sva_ioas etc).
>>>
>>>     We'll need to be careful about this when allowing other users to install
>>>     a fault handler. Should be fine as long as the handler and data are
>>>     installed before the domain is added to pasid_array.
>>>
>>> * We know the domain is valid the whole time IOPF is using it, because
>>>     unbind() waits for pending faults.
>>>
>>> We just need a comment explaining the last point, something like:
>>>
>>>          /*
>>> 	* Safe to fetch outside the group mutex because:
>>>           * - xarray protects its internal state with RCU
>>>           * - the domain obtained is either NULL or fully formed
>>> 	* - the IOPF work is the only caller and is flushed before the
>>> 	*   domain is freed.
>>>           */

Agreed. The mutex is needed only when domain could possibly be freed
before unbind(). In that case, we need this mutex and get a reference
from the domain. As we have dropped the domain user reference, this lock
is unnecessary.

>>>
>>> Thanks,
>>> Jean
>>>
>>>> +	domain = xa_load(&group->pasid_array, pasid);
>>>> +	mutex_unlock(&group->mutex);
>>>> +	iommu_group_put(group);
>>>> +
>>>> +	return domain;
>>>> +}
>>

Best regards,
baolu
