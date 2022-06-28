Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78D955DC7A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345037AbiF1Lxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbiF1Lxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:53:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3C330F7F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656417226; x=1687953226;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ajn0hyQvZuCFAHtCWj0xQ7s0Zvw6UN66/hjKZRjJUTE=;
  b=L7LDzEAWQHQBWE0ACEy0GicvnRSUxcK/muW/fhiNj/n5dqTlfBrQktta
   fRmR5quhed6kHIryOn295rhFiLHV3NwbcFKRhfpeamtwSOQ++eY98EJN3
   fnAMszuC8iEXpKV9GOxLlluQZp/yUfsWUOnqdECCi8jbJ3jZgseiMotQk
   C/4Zxd7wHJQkjbl/7vKynH1HgLi2SkBDgvh2on3/vxZa+lCt/FKpG8pKc
   OKgTlSDsb2ppEQ2/70PR+K6zJxA7PdzOCMyLwO2aucc+O54tr2dpmynPY
   RrvyIlNjYKRbjqE6leBPnMhF3zSw3XNUct7K+9uceLmAl1OBRNRDqRuj+
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="345715747"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="345715747"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 04:53:46 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646882963"
Received: from ltang11-mobl1.ccr.corp.intel.com (HELO [10.249.169.64]) ([10.249.169.64])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 04:53:41 -0700
Message-ID: <935ca9e3-28c9-99af-5609-41bb1500b2b3@linux.intel.com>
Date:   Tue, 28 Jun 2022 19:53:39 +0800
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
 <693a3604-d70b-e08c-2621-7f0cb9bdb6ca@linux.intel.com>
 <75b17c70-1658-91ea-0992-1be769550943@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <75b17c70-1658-91ea-0992-1be769550943@linux.intel.com>
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

On 2022/6/28 17:10, Ethan Zhao wrote:
> Hi, Baolu
> 
> 在 2022/6/28 14:28, Baolu Lu 写道:
>> Hi Ethan,
>>
>> On 2022/6/27 21:03, Ethan Zhao wrote:
>>> Hi,
>>>
>>> 在 2022/6/21 22:43, Lu Baolu 写道:
>>>> Tweak the I/O page fault handling framework to route the page faults to
>>>> the domain and call the page fault handler retrieved from the domain.
>>>> This makes the I/O page fault handling framework possible to serve more
>>>> usage scenarios as long as they have an IOMMU domain and install a page
>>>> fault handler in it. Some unused functions are also removed to avoid
>>>> dead code.
>>>>
>>>> The iommu_get_domain_for_dev_pasid() which retrieves attached domain
>>>> for a {device, PASID} pair is used. It will be used by the page fault
>>>> handling framework which knows {device, PASID} reported from the iommu
>>>> driver. We have a guarantee that the SVA domain doesn't go away during
>>>> IOPF handling, because unbind() waits for pending faults with
>>>> iopf_queue_flush_dev() before freeing the domain. Hence, there's no 
>>>> need
>>>> to synchronize life cycle of the iommu domains between the unbind() and
>>>> the interrupt threads.
>>>>
>>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>>> ---
>>>>   drivers/iommu/io-pgfault.c | 64 
>>>> +++++---------------------------------
>>>>   1 file changed, 7 insertions(+), 57 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
>>>> index aee9e033012f..4f24ec703479 100644
>>>> --- a/drivers/iommu/io-pgfault.c
>>>> +++ b/drivers/iommu/io-pgfault.c
>>>> @@ -69,69 +69,18 @@ static int iopf_complete_group(struct device 
>>>> *dev, struct iopf_fault *iopf,
>>>>       return iommu_page_response(dev, &resp);
>>>>   }
>>>> -static enum iommu_page_response_code
>>>> -iopf_handle_single(struct iopf_fault *iopf)
>>>> -{
>>>> -    vm_fault_t ret;
>>>> -    struct mm_struct *mm;
>>>> -    struct vm_area_struct *vma;
>>>> -    unsigned int access_flags = 0;
>>>> -    unsigned int fault_flags = FAULT_FLAG_REMOTE;
>>>> -    struct iommu_fault_page_request *prm = &iopf->fault.prm;
>>>> -    enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
>>>> -
>>>> -    if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
>>>> -        return status;
>>>> -
>>>> -    mm = iommu_sva_find(prm->pasid);
>>>> -    if (IS_ERR_OR_NULL(mm))
>>>> -        return status;
>>>> -
>>>> -    mmap_read_lock(mm);
>>>> -
>>>> -    vma = find_extend_vma(mm, prm->addr);
>>>> -    if (!vma)
>>>> -        /* Unmapped area */
>>>> -        goto out_put_mm;
>>>> -
>>>> -    if (prm->perm & IOMMU_FAULT_PERM_READ)
>>>> -        access_flags |= VM_READ;
>>>> -
>>>> -    if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
>>>> -        access_flags |= VM_WRITE;
>>>> -        fault_flags |= FAULT_FLAG_WRITE;
>>>> -    }
>>>> -
>>>> -    if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
>>>> -        access_flags |= VM_EXEC;
>>>> -        fault_flags |= FAULT_FLAG_INSTRUCTION;
>>>> -    }
>>>> -
>>>> -    if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
>>>> -        fault_flags |= FAULT_FLAG_USER;
>>>> -
>>>> -    if (access_flags & ~vma->vm_flags)
>>>> -        /* Access fault */
>>>> -        goto out_put_mm;
>>>> -
>>>> -    ret = handle_mm_fault(vma, prm->addr, fault_flags, NULL);
>>>> -    status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
>>>> -        IOMMU_PAGE_RESP_SUCCESS;
>>>> -
>>>> -out_put_mm:
>>>> -    mmap_read_unlock(mm);
>>>> -    mmput(mm);
>>>> -
>>>> -    return status;
>>>> -}
>>>> -
>>>
>>> Once the iopf_handle_single() is removed, the name of 
>>> iopf_handle_group() looks a little weired
>>>
>>> and confused, does this group mean the iommu group (domain) ? while I 
>>> take some minutes to
>>
>> No. This is not the iommu group. It's page request group defined by the
>> PCI SIG spec. Multiple page requests could be put in a group with a
>> same group id. All page requests in a group could be responded to device
>> in one shot.
> 
> Thanks your explaination, understand the concept of PCIe PRG.  I meant
> 
> do we still have the necessity to mention the "group" here in the name
> 
> iopf_handle_group(),  which one is better ? iopf_handle_prg() or
> 
> iopf_handler(),  perhaps none of them ? :)

Oh! Sorry for the misunderstanding.

I have no strong feeling to change this naming. :-) All the names
express what the helper does. Jean is the author of this framework. If
he has the same idea as you, I don't mind renaming it in this patch.

Best regards,
baolu
