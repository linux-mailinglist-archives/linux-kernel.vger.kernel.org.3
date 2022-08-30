Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B045A5977
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 04:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiH3CfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 22:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiH3CfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 22:35:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA95D11A2F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 19:34:59 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MGrsg2T1dzlWJy;
        Tue, 30 Aug 2022 10:31:35 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 10:34:57 +0800
Subject: Re: [PATCH 6/8] hugetlb: add vma based lock for pmd sharing
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
 <20220824175757.20590-7-mike.kravetz@oracle.com>
 <47cc90bf-d616-5004-555d-b3d7e9b09bd1@huawei.com> <Yw08j5m62is7kqSg@monkey>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <33ed8bff-97f4-16c0-e4cb-fec18ff843c0@huawei.com>
Date:   Tue, 30 Aug 2022 10:34:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Yw08j5m62is7kqSg@monkey>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/30 6:24, Mike Kravetz wrote:
> On 08/27/22 17:30, Miaohe Lin wrote:
>> On 2022/8/25 1:57, Mike Kravetz wrote:
>>> Allocate a rw semaphore and hang off vm_private_data for
>>> synchronization use by vmas that could be involved in pmd sharing.  Only
>>> add infrastructure for the new lock here.  Actual use will be added in
>>> subsequent patch.
>>>
>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>
>> <snip>
>>
>>> +static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
>>> +{
>>> +	/*
>>> +	 * Only present in sharable vmas.  See comment in
>>> +	 * __unmap_hugepage_range_final about the neeed to check both
>>
>> s/neeed/need/
>>
>>> +	 * VM_SHARED and VM_MAYSHARE in free path
>>
>> I think there might be some wrong checks around this patch. As above comment said, we
>> need to check both flags, so we should do something like below instead?
>>
>> 	if (!(vma->vm_flags & (VM_MAYSHARE | VM_SHARED) == (VM_MAYSHARE | VM_SHARED)))
>>
>>> +	 */
> 
> Thanks.  I will update.
> 
>>> +	if (!vma || !(vma->vm_flags & (VM_MAYSHARE | VM_SHARED)))
>>> +		return;
>>> +
>>> +	if (vma->vm_private_data) {
>>> +		kfree(vma->vm_private_data);
>>> +		vma->vm_private_data = NULL;
>>> +	}
>>> +}
>>> +
>>> +static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
>>> +{
>>> +	struct rw_semaphore *vma_sema;
>>> +
>>> +	/* Only establish in (flags) sharable vmas */
>>> +	if (!vma || !(vma->vm_flags & VM_MAYSHARE))
>>> +		return;
>>> +
>>> +	/* Should never get here with non-NULL vm_private_data */
>>
>> We can get here with non-NULL vm_private_data when called from hugetlb_vm_op_open during fork?
> 
> Right!
> 
> In fork, We allocate a new semaphore in hugetlb_dup_vma_private, and then
> shortly after call hugetlb_vm_op_open.
> 
> It works as is, and I can update the comment.  However, I wonder if we should
> just clear vm_private_data in hugetlb_dup_vma_private and let hugetlb_vm_op_open
> do the allocation.

I think it's a good idea. We can also avoid allocating memory for vma_lock (via clear_vma_resv_huge_pages()) and
then free the corresponding vma right away (via do_munmap())in move_vma(). But maybe I'm miss something.

Thanks,
Miaohe Lin

> 
>>
>> Also there's one missing change on comment:
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index d0617d64d718..4bc844a1d312 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -863,7 +863,7 @@ __weak unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
>>   * faults in a MAP_PRIVATE mapping. Only the process that called mmap()
>>   * is guaranteed to have their future faults succeed.
>>   *
>> - * With the exception of reset_vma_resv_huge_pages() which is called at fork(),
>> + * With the exception of hugetlb_dup_vma_private() which is called at fork(),
>>   * the reserve counters are updated with the hugetlb_lock held. It is safe
>>   * to reset the VMA at fork() time as it is not in use yet and there is no
>>   * chance of the global counters getting corrupted as a result of the values.
>>
>>
>> Otherwise this patch looks good to me. Thanks.
> 
> Will update, Thank you!
> 

