Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF4055D543
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245535AbiF1G2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245343AbiF1G2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:28:22 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DE112AE7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 23:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656397701; x=1687933701;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9IUUyhkLUoG7pm0kZNfCYFqtdjz75ZQTTtDHGO+EHGI=;
  b=ls9RLgZWL2bTspO5d1OP1H+7myZCnjX8UDIIlPY8aH6Eo7ddGCgDAu5B
   F85IiYPgac6Ae3jOy/RwvBg/7MErCLU5+0aWJOhyFPc4xxiVErfksvW9a
   26nz0sH1p0I6TfW92OwlUfiJ3iq+ygJ8y8MRJKhZFEBSN9QBjIGy4mQW3
   nvXG0WP+rpYGNxoC9f1NTBKB5xLPvHwlTPc0YsdcQqDUVWAj7Olfe6RqB
   1MB/1nThl7Uh+SCT+ArsLIDIU2h+dwNOuTRFYTzkuGTQe1TRnlnC8Ylya
   7/5kO6XNoPTX1EkVAhQBJpiYWUDxWp/IgWFNLHI5IDMebgPrCl/ztpn23
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="270396815"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="270396815"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 23:28:20 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646773805"
Received: from ltang11-mobl1.ccr.corp.intel.com (HELO [10.249.169.64]) ([10.249.169.64])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 23:28:16 -0700
Message-ID: <693a3604-d70b-e08c-2621-7f0cb9bdb6ca@linux.intel.com>
Date:   Tue, 28 Jun 2022 14:28:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v9 10/11] iommu: Per-domain I/O page fault handling
Content-Language: en-US
To:     Ethan Zhao <haifeng.zhao@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-11-baolu.lu@linux.intel.com>
 <faacb997-0c0a-04e1-903d-53857f463214@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <faacb997-0c0a-04e1-903d-53857f463214@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ethan,

On 2022/6/27 21:03, Ethan Zhao wrote:
> Hi,
> 
> 在 2022/6/21 22:43, Lu Baolu 写道:
>> Tweak the I/O page fault handling framework to route the page faults to
>> the domain and call the page fault handler retrieved from the domain.
>> This makes the I/O page fault handling framework possible to serve more
>> usage scenarios as long as they have an IOMMU domain and install a page
>> fault handler in it. Some unused functions are also removed to avoid
>> dead code.
>>
>> The iommu_get_domain_for_dev_pasid() which retrieves attached domain
>> for a {device, PASID} pair is used. It will be used by the page fault
>> handling framework which knows {device, PASID} reported from the iommu
>> driver. We have a guarantee that the SVA domain doesn't go away during
>> IOPF handling, because unbind() waits for pending faults with
>> iopf_queue_flush_dev() before freeing the domain. Hence, there's no need
>> to synchronize life cycle of the iommu domains between the unbind() and
>> the interrupt threads.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> ---
>>   drivers/iommu/io-pgfault.c | 64 +++++---------------------------------
>>   1 file changed, 7 insertions(+), 57 deletions(-)
>>
>> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
>> index aee9e033012f..4f24ec703479 100644
>> --- a/drivers/iommu/io-pgfault.c
>> +++ b/drivers/iommu/io-pgfault.c
>> @@ -69,69 +69,18 @@ static int iopf_complete_group(struct device *dev, 
>> struct iopf_fault *iopf,
>>       return iommu_page_response(dev, &resp);
>>   }
>> -static enum iommu_page_response_code
>> -iopf_handle_single(struct iopf_fault *iopf)
>> -{
>> -    vm_fault_t ret;
>> -    struct mm_struct *mm;
>> -    struct vm_area_struct *vma;
>> -    unsigned int access_flags = 0;
>> -    unsigned int fault_flags = FAULT_FLAG_REMOTE;
>> -    struct iommu_fault_page_request *prm = &iopf->fault.prm;
>> -    enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
>> -
>> -    if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
>> -        return status;
>> -
>> -    mm = iommu_sva_find(prm->pasid);
>> -    if (IS_ERR_OR_NULL(mm))
>> -        return status;
>> -
>> -    mmap_read_lock(mm);
>> -
>> -    vma = find_extend_vma(mm, prm->addr);
>> -    if (!vma)
>> -        /* Unmapped area */
>> -        goto out_put_mm;
>> -
>> -    if (prm->perm & IOMMU_FAULT_PERM_READ)
>> -        access_flags |= VM_READ;
>> -
>> -    if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
>> -        access_flags |= VM_WRITE;
>> -        fault_flags |= FAULT_FLAG_WRITE;
>> -    }
>> -
>> -    if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
>> -        access_flags |= VM_EXEC;
>> -        fault_flags |= FAULT_FLAG_INSTRUCTION;
>> -    }
>> -
>> -    if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
>> -        fault_flags |= FAULT_FLAG_USER;
>> -
>> -    if (access_flags & ~vma->vm_flags)
>> -        /* Access fault */
>> -        goto out_put_mm;
>> -
>> -    ret = handle_mm_fault(vma, prm->addr, fault_flags, NULL);
>> -    status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
>> -        IOMMU_PAGE_RESP_SUCCESS;
>> -
>> -out_put_mm:
>> -    mmap_read_unlock(mm);
>> -    mmput(mm);
>> -
>> -    return status;
>> -}
>> -
> 
> Once the iopf_handle_single() is removed, the name of 
> iopf_handle_group() looks a little weired
> 
> and confused, does this group mean the iommu group (domain) ? while I 
> take some minutes to

No. This is not the iommu group. It's page request group defined by the
PCI SIG spec. Multiple page requests could be put in a group with a
same group id. All page requests in a group could be responded to device
in one shot.

Best regards,
baolu

> 
> look into the code, oh, means a batch / list / queue  of iopfs , and 
> iopf_handle_group() becomes a
> 
> generic iopf_handler() .
> 
> Doe it make sense to revise the names of iopf_handle_group(), 
> iopf_complete_group,  iopf_group in
> 
> this patch set ?
> 
> 
> Thanks,
> 
> Ethan
> 
>>   static void iopf_handle_group(struct work_struct *work)
>>   {
>>       struct iopf_group *group;
>> +    struct iommu_domain *domain;
>>       struct iopf_fault *iopf, *next;
>>       enum iommu_page_response_code status = IOMMU_PAGE_RESP_SUCCESS;
>>       group = container_of(work, struct iopf_group, work);
>> +    domain = iommu_get_domain_for_dev_pasid(group->dev,
>> +                group->last_fault.fault.prm.pasid);
>> +    if (!domain || !domain->iopf_handler)
>> +        status = IOMMU_PAGE_RESP_INVALID;
>>       list_for_each_entry_safe(iopf, next, &group->faults, list) {
>>           /*
>> @@ -139,7 +88,8 @@ static void iopf_handle_group(struct work_struct 
>> *work)
>>            * faults in the group if there is an error.
>>            */
>>           if (status == IOMMU_PAGE_RESP_SUCCESS)
>> -            status = iopf_handle_single(iopf);
>> +            status = domain->iopf_handler(&iopf->fault,
>> +                              domain->fault_data);
>>           if (!(iopf->fault.prm.flags &
>>                 IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
> 

