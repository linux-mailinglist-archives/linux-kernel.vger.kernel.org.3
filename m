Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D604E3878
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 06:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236764AbiCVFaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 01:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbiCVFaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 01:30:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086AF64EF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 22:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647926920; x=1679462920;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=APxeAEopBRCFgm1KXudSbbtliPjdlsQ/3Hia294wMx4=;
  b=I60d8tTEe7pJU9z1yINRjfijcaZuLV3QWKMkSyH3wRPsN99KBnqd6jzw
   5jI2yPt+ZcXrBFux6Z219GcgF02/uRHyvxlcJn/XQDl49RqEXuffroYPH
   3PI8ByroyBuxSs6F+eObLrFtGOrKCu1NIDZrlra9BtSxKtPvO7+5r0057
   6FkCO9DJlpV1K5phvn66+Ixo+INDDGuR69C9i/g1XhePDF6QAkze+OTZP
   27Z7S6I1Ec7LxjrmHpXhLGJt6WM4aXlTRmvjKSlmVAEHS3aiFFK4996Bv
   t9xLA07zfb19aMXRoozp133669IGz8Udfag0WTdT9csgvz8guDAPSougY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="255290672"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="255290672"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 22:28:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="560211178"
Received: from ellenyin-mobl.ccr.corp.intel.com (HELO [10.254.213.205]) ([10.254.213.205])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 22:28:35 -0700
Message-ID: <3165c557-b96e-a410-1e0d-2bea1048fb29@linux.intel.com>
Date:   Tue, 22 Mar 2022 13:28:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-11-baolu.lu@linux.intel.com>
 <Yjhj5F0fUWRRKh3v@myrica>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC 10/11] iommu: Make IOPF handling framework generic
In-Reply-To: <Yjhj5F0fUWRRKh3v@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/21 19:39, Jean-Philippe Brucker wrote:
> On Sun, Mar 20, 2022 at 02:40:29PM +0800, Lu Baolu wrote:
>> The existing IOPF handling framework only handles the I/O page faults for
>> SVA. Ginven that we are able to link iommu domain with each I/O page fault,
>> we can now make the I/O page fault handling framework more general for
>> more types of page faults.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   include/linux/iommu.h         |  4 +++
>>   drivers/iommu/io-pgfault.c    | 67 ++++++-----------------------------
>>   drivers/iommu/iommu-sva-lib.c | 59 ++++++++++++++++++++++++++++++
>>   3 files changed, 73 insertions(+), 57 deletions(-)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 803e7b07605e..11c65a7bed88 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -50,6 +50,8 @@ struct iommu_dma_cookie;
>>   typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
>>   			struct device *, unsigned long, int, void *);
>>   typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault *, void *);
>> +typedef enum iommu_page_response_code (*iommu_domain_iopf_handler_t)
>> +			(struct iommu_fault *, void *);
>>   
>>   struct iommu_domain_geometry {
>>   	dma_addr_t aperture_start; /* First address that can be mapped    */
>> @@ -101,6 +103,8 @@ struct iommu_domain {
>>   	struct iommu_domain_geometry geometry;
>>   	struct iommu_dma_cookie *iova_cookie;
>>   	struct mm_struct *sva_cookie;
>> +	iommu_domain_iopf_handler_t fault_handler;
>> +	void *fault_data;
>>   };
>>   
>>   static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
>> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
>> index 1df8c1dcae77..dad0e40cd8d2 100644
>> --- a/drivers/iommu/io-pgfault.c
>> +++ b/drivers/iommu/io-pgfault.c
>> @@ -69,62 +69,6 @@ static int iopf_complete_group(struct device *dev, struct iopf_fault *iopf,
>>   	return iommu_page_response(dev, &resp);
>>   }
>>   
>> -static enum iommu_page_response_code
>> -iopf_handle_single(struct iopf_fault *iopf)
>> -{
>> -	vm_fault_t ret;
>> -	struct mm_struct *mm;
>> -	struct vm_area_struct *vma;
>> -	unsigned int access_flags = 0;
>> -	unsigned int fault_flags = FAULT_FLAG_REMOTE;
>> -	struct iommu_fault_page_request *prm = &iopf->fault.prm;
>> -	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
>> -
>> -	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
>> -		return status;
>> -
>> -	mm = iommu_sva_find(prm->pasid);
>> -	if (IS_ERR_OR_NULL(mm))
>> -		return status;
>> -
>> -	mmap_read_lock(mm);
>> -
>> -	vma = find_extend_vma(mm, prm->addr);
>> -	if (!vma)
>> -		/* Unmapped area */
>> -		goto out_put_mm;
>> -
>> -	if (prm->perm & IOMMU_FAULT_PERM_READ)
>> -		access_flags |= VM_READ;
>> -
>> -	if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
>> -		access_flags |= VM_WRITE;
>> -		fault_flags |= FAULT_FLAG_WRITE;
>> -	}
>> -
>> -	if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
>> -		access_flags |= VM_EXEC;
>> -		fault_flags |= FAULT_FLAG_INSTRUCTION;
>> -	}
>> -
>> -	if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
>> -		fault_flags |= FAULT_FLAG_USER;
>> -
>> -	if (access_flags & ~vma->vm_flags)
>> -		/* Access fault */
>> -		goto out_put_mm;
>> -
>> -	ret = handle_mm_fault(vma, prm->addr, fault_flags, NULL);
>> -	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
>> -		IOMMU_PAGE_RESP_SUCCESS;
>> -
>> -out_put_mm:
>> -	mmap_read_unlock(mm);
>> -	mmput(mm);
>> -
>> -	return status;
>> -}
>> -
>>   static void iopf_handle_group(struct work_struct *work)
>>   {
>>   	struct iopf_group *group;
>> @@ -134,12 +78,21 @@ static void iopf_handle_group(struct work_struct *work)
>>   	group = container_of(work, struct iopf_group, work);
>>   
>>   	list_for_each_entry_safe(iopf, next, &group->faults, list) {
>> +		struct iommu_domain *domain;
>> +
>> +		domain = iommu_get_domain_for_dev_pasid(group->dev,
>> +							iopf->fault.prm.pasid);
> 
> Do we have a guarantee that the domain is not freed while we handle the
> fault?  We could prevent unbind() while there are pending faults on this
> bond. But a refcount on SVA domains could defer freeing, and would also
> help with keeping the semantics where bind() returns a single refcounted
> bond for any {dev, mm}.
> 
> Given that this path is full of circular locking pitfalls, and to keep the
> fault handler efficient (well, at least not make it worse), we should
> probably keep a getter like iommu_sva_find() that does not require
> locking.

Agreed. We need a mechanism to ensure concurrency. I will look into it.

> 
>> +
>> +		if (!domain || !domain->fault_handler)
>> +			status = IOMMU_PAGE_RESP_INVALID;
>> +
>>   		/*
>>   		 * For the moment, errors are sticky: don't handle subsequent
>>   		 * faults in the group if there is an error.
>>   		 */
>>   		if (status == IOMMU_PAGE_RESP_SUCCESS)
>> -			status = iopf_handle_single(iopf);
>> +			status = domain->fault_handler(&iopf->fault,
>> +						       domain->fault_data);
> 
> If we make this a direct call and only use a light getter for the
> PASID->mm lookup we don't need to look at the domain at all. Or are you
> planning to add external fault handlers?

Yes. I'd like the I/O page fault handling framework to work for
external domains as well, for example, the I/O page faults for user
space page table should be routed to user space.

> 
>>   
>>   		if (!(iopf->fault.prm.flags &
>>   		      IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
>> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
>> index 47cf98e661ff..01fa8096bd02 100644
>> --- a/drivers/iommu/iommu-sva-lib.c
>> +++ b/drivers/iommu/iommu-sva-lib.c
>> @@ -87,6 +87,63 @@ static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev)
>>   	return domain;
>>   }
>>   
>> +static enum iommu_page_response_code
>> +iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
>> +{
>> +	vm_fault_t ret;
>> +	struct mm_struct *mm;
>> +	struct vm_area_struct *vma;
>> +	unsigned int access_flags = 0;
>> +	struct iommu_domain *domain = data;
>> +	unsigned int fault_flags = FAULT_FLAG_REMOTE;
>> +	struct iommu_fault_page_request *prm = &fault->prm;
>> +	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
>> +
>> +	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
>> +		return status;
>> +
>> +	mm = domain->sva_cookie;
>> +	if (IS_ERR_OR_NULL(mm))
>> +		return status;
>> +
>> +	mmap_read_lock(mm);
>> +
>> +	vma = find_extend_vma(mm, prm->addr);
>> +	if (!vma)
>> +		/* Unmapped area */
>> +		goto out_put_mm;
>> +
>> +	if (prm->perm & IOMMU_FAULT_PERM_READ)
>> +		access_flags |= VM_READ;
>> +
>> +	if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
>> +		access_flags |= VM_WRITE;
>> +		fault_flags |= FAULT_FLAG_WRITE;
>> +	}
>> +
>> +	if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
>> +		access_flags |= VM_EXEC;
>> +		fault_flags |= FAULT_FLAG_INSTRUCTION;
>> +	}
>> +
>> +	if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
>> +		fault_flags |= FAULT_FLAG_USER;
>> +
>> +	if (access_flags & ~vma->vm_flags)
>> +		/* Access fault */
>> +		goto out_put_mm;
>> +
>> +	ret = handle_mm_fault(vma, prm->addr, fault_flags, NULL);
>> +	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
>> +		IOMMU_PAGE_RESP_SUCCESS;
>> +
>> +out_put_mm:
>> +	mmap_read_unlock(mm);
>> +	mmput(mm);
> 
> mmget_not_zero() is missing since iommu_sva_find() is gone. I'm guessing
> we still need it in case the process dies

Agreed.

> 
> Thanks,
> Jean

Best regards,
baolu
