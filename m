Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B5851BA83
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349284AbiEEIfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245568AbiEEIf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:35:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA00DF51
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651739509; x=1683275509;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=roh0ARsU0A0vGZ1wvEez4gzYA90rB5c2aWwIVA4MWDc=;
  b=ZX4xoxoFxFi7W0qH0LGW3/waUotLisH8j0s6bjK0+xOl87sV0CUbdeXR
   NJya+2A6LAEy/GQTWQ6XSDGZxnbHwHiJv3AaOzaCcQAFwdbznBHBukm6J
   0BabLdbV8Qdhw79o312JBzdHEmOydJsMdIMxhfnwL9tU0WnheA6wkDX8d
   xogmUxYZL/23fcvQipUcnC94NF3+3B+cMTU49Dv1KULCHBLRPuwXwJnUq
   FhM/6b/mqbZErSD2oUfwN69d46HStZH19pLfxFMJ1e9iKy3VRT93YeSlt
   1MDdO65TjQ80Tvu8TYZMXe7nYeVJX7p0Pb+ZOf+v1402IgAbVxlRxCe4N
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="267638993"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="267638993"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 01:31:48 -0700
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="563139126"
Received: from minhaowa-mobl.ccr.corp.intel.com (HELO [10.255.30.75]) ([10.255.30.75])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 01:31:41 -0700
Message-ID: <9144a782-04d2-a09d-4ac1-7133e5986619@linux.intel.com>
Date:   Thu, 5 May 2022 16:31:38 +0800
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
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YnFydE8j8l7Q4m+b@myrica>
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

On 2022/5/4 02:20, Jean-Philippe Brucker wrote:
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 7cae631c1baa..33449523afbe 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -3174,3 +3174,24 @@ void iommu_detach_device_pasid(struct iommu_domain *domain,
>>   
>>   	iommu_group_put(group);
>>   }
>> +
>> +struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
>> +						    ioasid_t pasid)
>> +{
>> +	struct iommu_domain *domain;
>> +	struct iommu_group *group;
>> +
>> +	if (!pasid_valid(pasid))
>> +		return NULL;
>> +
>> +	group = iommu_group_get(dev);
>> +	if (!group)
>> +		return NULL;
>> +
>> +	mutex_lock(&group->mutex);
> Unfortunately this still causes the deadlock when unbind() flushes the
> IOPF queue while holding the group mutex.

Sorry, I didn't get your point here.

Do you mean unbind() could hold group mutex before calling this helper?
The group mutex is only available in iommu.c. The unbind() has no means
to hold this lock. Or, I missed anything?

Best regards,
baolu

> 
> If we make this function private to IOPF, then we can get rid of this
> mutex_lock(). It's OK because:
> 
> * xarray protects its internal state with RCU, so we can call
>    xa_load() outside the lock.
> 
> * The domain obtained from xa_load is finalized. Its content is valid
>    because xarray stores the domain using rcu_assign_pointer(), which has a
>    release memory barrier, which pairs with data dependencies in IOPF
>    (domain->sva_ioas etc).
> 
>    We'll need to be careful about this when allowing other users to install
>    a fault handler. Should be fine as long as the handler and data are
>    installed before the domain is added to pasid_array.
> 
> * We know the domain is valid the whole time IOPF is using it, because
>    unbind() waits for pending faults.
> 
> We just need a comment explaining the last point, something like:
> 
>         /*
> 	* Safe to fetch outside the group mutex because:
>          * - xarray protects its internal state with RCU
>          * - the domain obtained is either NULL or fully formed
> 	* - the IOPF work is the only caller and is flushed before the
> 	*   domain is freed.
>          */
> 
> Thanks,
> Jean
> 
>> +	domain = xa_load(&group->pasid_array, pasid);
>> +	mutex_unlock(&group->mutex);
>> +	iommu_group_put(group);
>> +
>> +	return domain;
>> +}

