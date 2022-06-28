Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752CA55C897
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344101AbiF1JP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242975AbiF1JPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:15:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC0D183B0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656407753; x=1687943753;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OHaCPTb3tQJyC9jPefSdwGvmT4LNH8ytKUBKidFJYOM=;
  b=O2QdoiSKWsZJ0PWcwPmRP13J12WEDQPKg9b54+3cEBvA7v8mYdkYPF61
   DnhnVtosTFJjtFox9oBe2diyxTznTXrnKGGDlVCsG+ck6Z1baaKQO1wdr
   /jfWhlMjeupnY+epMAK/na5bl17xSMuf0K5Vq2bXhY+reDQm/hiMWIwgW
   nrs1OF6ZmCaLvjlVv2x2jZd/5OXLNdVpFgdLsmYnGjXOplDKGKlSI+oTA
   XAukG8i/zDP9DC/Ic1/voPKwFr6C8YAEqys637BZb2jxcYHAcfpJJvwar
   uqPd+y+K4P65lmIUh85gat5eGXxc2Ihp4LdnBUgdaP0jGJ79vcwnTDhrF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="282778867"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="282778867"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 02:10:19 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="594708620"
Received: from zhaohaif-mobl1.ccr.corp.intel.com (HELO [10.254.212.145]) ([10.254.212.145])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 02:10:14 -0700
Message-ID: <75b17c70-1658-91ea-0992-1be769550943@linux.intel.com>
Date:   Tue, 28 Jun 2022 17:10:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v9 10/11] iommu: Per-domain I/O page fault handling
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-11-baolu.lu@linux.intel.com>
 <faacb997-0c0a-04e1-903d-53857f463214@linux.intel.com>
 <693a3604-d70b-e08c-2621-7f0cb9bdb6ca@linux.intel.com>
From:   Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <693a3604-d70b-e08c-2621-7f0cb9bdb6ca@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Baolu

在 2022/6/28 14:28, Baolu Lu 写道:
> Hi Ethan,
>
> On 2022/6/27 21:03, Ethan Zhao wrote:
>> Hi,
>>
>> 在 2022/6/21 22:43, Lu Baolu 写道:
>>> Tweak the I/O page fault handling framework to route the page faults to
>>> the domain and call the page fault handler retrieved from the domain.
>>> This makes the I/O page fault handling framework possible to serve more
>>> usage scenarios as long as they have an IOMMU domain and install a page
>>> fault handler in it. Some unused functions are also removed to avoid
>>> dead code.
>>>
>>> The iommu_get_domain_for_dev_pasid() which retrieves attached domain
>>> for a {device, PASID} pair is used. It will be used by the page fault
>>> handling framework which knows {device, PASID} reported from the iommu
>>> driver. We have a guarantee that the SVA domain doesn't go away during
>>> IOPF handling, because unbind() waits for pending faults with
>>> iopf_queue_flush_dev() before freeing the domain. Hence, there's no 
>>> need
>>> to synchronize life cycle of the iommu domains between the unbind() and
>>> the interrupt threads.
>>>
>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>> ---
>>>   drivers/iommu/io-pgfault.c | 64 
>>> +++++---------------------------------
>>>   1 file changed, 7 insertions(+), 57 deletions(-)
>>>
>>> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
>>> index aee9e033012f..4f24ec703479 100644
>>> --- a/drivers/iommu/io-pgfault.c
>>> +++ b/drivers/iommu/io-pgfault.c
>>> @@ -69,69 +69,18 @@ static int iopf_complete_group(struct device 
>>> *dev, struct iopf_fault *iopf,
>>>       return iommu_page_response(dev, &resp);
>>>   }
>>> -static enum iommu_page_response_code
>>> -iopf_handle_single(struct iopf_fault *iopf)
>>> -{
>>> -    vm_fault_t ret;
>>> -    struct mm_struct *mm;
>>> -    struct vm_area_struct *vma;
>>> -    unsigned int access_flags = 0;
>>> -    unsigned int fault_flags = FAULT_FLAG_REMOTE;
>>> -    struct iommu_fault_page_request *prm = &iopf->fault.prm;
>>> -    enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
>>> -
>>> -    if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
>>> -        return status;
>>> -
>>> -    mm = iommu_sva_find(prm->pasid);
>>> -    if (IS_ERR_OR_NULL(mm))
>>> -        return status;
>>> -
>>> -    mmap_read_lock(mm);
>>> -
>>> -    vma = find_extend_vma(mm, prm->addr);
>>> -    if (!vma)
>>> -        /* Unmapped area */
>>> -        goto out_put_mm;
>>> -
>>> -    if (prm->perm & IOMMU_FAULT_PERM_READ)
>>> -        access_flags |= VM_READ;
>>> -
>>> -    if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
>>> -        access_flags |= VM_WRITE;
>>> -        fault_flags |= FAULT_FLAG_WRITE;
>>> -    }
>>> -
>>> -    if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
>>> -        access_flags |= VM_EXEC;
>>> -        fault_flags |= FAULT_FLAG_INSTRUCTION;
>>> -    }
>>> -
>>> -    if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
>>> -        fault_flags |= FAULT_FLAG_USER;
>>> -
>>> -    if (access_flags & ~vma->vm_flags)
>>> -        /* Access fault */
>>> -        goto out_put_mm;
>>> -
>>> -    ret = handle_mm_fault(vma, prm->addr, fault_flags, NULL);
>>> -    status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
>>> -        IOMMU_PAGE_RESP_SUCCESS;
>>> -
>>> -out_put_mm:
>>> -    mmap_read_unlock(mm);
>>> -    mmput(mm);
>>> -
>>> -    return status;
>>> -}
>>> -
>>
>> Once the iopf_handle_single() is removed, the name of 
>> iopf_handle_group() looks a little weired
>>
>> and confused, does this group mean the iommu group (domain) ? while I 
>> take some minutes to
>
> No. This is not the iommu group. It's page request group defined by the
> PCI SIG spec. Multiple page requests could be put in a group with a
> same group id. All page requests in a group could be responded to device
> in one shot.

Thanks your explaination, understand the concept of PCIe PRG.  I meant

do we still have the necessity to mention the "group" here in the name

iopf_handle_group(),  which one is better ? iopf_handle_prg() or

iopf_handler(),  perhaps none of them ? :)


Thanks，

Ethan

>
> Best regards,
> baolu
>
>>
>> look into the code, oh, means a batch / list / queue  of iopfs , and 
>> iopf_handle_group() becomes a
>>
>> generic iopf_handler() .
>>
>> Doe it make sense to revise the names of iopf_handle_group(), 
>> iopf_complete_group,  iopf_group in
>>
>> this patch set ?
>>
>>
>> Thanks,
>>
>> Ethan
>>
>>>   static void iopf_handle_group(struct work_struct *work)
>>>   {
>>>       struct iopf_group *group;
>>> +    struct iommu_domain *domain;
>>>       struct iopf_fault *iopf, *next;
>>>       enum iommu_page_response_code status = IOMMU_PAGE_RESP_SUCCESS;
>>>       group = container_of(work, struct iopf_group, work);
>>> +    domain = iommu_get_domain_for_dev_pasid(group->dev,
>>> +                group->last_fault.fault.prm.pasid);
>>> +    if (!domain || !domain->iopf_handler)
>>> +        status = IOMMU_PAGE_RESP_INVALID;
>>>       list_for_each_entry_safe(iopf, next, &group->faults, list) {
>>>           /*
>>> @@ -139,7 +88,8 @@ static void iopf_handle_group(struct work_struct 
>>> *work)
>>>            * faults in the group if there is an error.
>>>            */
>>>           if (status == IOMMU_PAGE_RESP_SUCCESS)
>>> -            status = iopf_handle_single(iopf);
>>> +            status = domain->iopf_handler(&iopf->fault,
>>> +                              domain->fault_data);
>>>           if (!(iopf->fault.prm.flags &
>>>                 IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
>>
>
-- 
"firm, enduring, strong, and long-lived"

