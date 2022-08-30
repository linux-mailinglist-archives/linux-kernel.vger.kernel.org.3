Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6915A5982
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 04:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiH3Cqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 22:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiH3Cqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 22:46:50 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F183867461
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 19:46:48 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MGs713TSyz1N7by;
        Tue, 30 Aug 2022 10:43:09 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 10:46:46 +0800
Subject: Re: [PATCH 7/8] hugetlb: create hugetlb_unmap_file_folio to unmap
 single file folio
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
 <20220824175757.20590-8-mike.kravetz@oracle.com>
 <0e31f9da-5953-2f44-1a59-888e3313e919@huawei.com> <Yw0/w0u+4qBHyy5u@monkey>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <304a6d9a-9029-8ee8-7205-d0ef4a5403bd@huawei.com>
Date:   Tue, 30 Aug 2022 10:46:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Yw0/w0u+4qBHyy5u@monkey>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2022/8/30 6:37, Mike Kravetz wrote:
> On 08/29/22 10:44, Miaohe Lin wrote:
>> On 2022/8/25 1:57, Mike Kravetz wrote:
>>> Create the new routine hugetlb_unmap_file_folio that will unmap a single
>>> file folio.  This is refactored code from hugetlb_vmdelete_list.  It is
>>> modified to do locking within the routine itself and check whether the
>>> page is mapped within a specific vma before unmapping.
>>>
>>> This refactoring will be put to use and expanded upon in a subsequent
>>> patch adding vma specific locking.
>>>
>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>> ---
>>>  fs/hugetlbfs/inode.c | 123 +++++++++++++++++++++++++++++++++----------
>>>  1 file changed, 94 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>>> index e83fd31671b3..b93d131b0cb5 100644
>>> --- a/fs/hugetlbfs/inode.c
>>> +++ b/fs/hugetlbfs/inode.c
>>> @@ -371,6 +371,94 @@ static void hugetlb_delete_from_page_cache(struct page *page)
>>>  	delete_from_page_cache(page);
>>>  }
>>>  
>>> +/*
>>> + * Called with i_mmap_rwsem held for inode based vma maps.  This makes
>>> + * sure vma (and vm_mm) will not go away.  We also hold the hugetlb fault
>>> + * mutex for the page in the mapping.  So, we can not race with page being
>>> + * faulted into the vma.
>>> + */
>>> +static bool hugetlb_vma_maps_page(struct vm_area_struct *vma,
>>> +				unsigned long addr, struct page *page)
>>> +{
>>> +	pte_t *ptep, pte;
>>> +
>>> +	ptep = huge_pte_offset(vma->vm_mm, addr,
>>> +			huge_page_size(hstate_vma(vma)));
>>> +
>>> +	if (!ptep)
>>> +		return false;
>>> +
>>> +	pte = huge_ptep_get(ptep);
>>> +	if (huge_pte_none(pte) || !pte_present(pte))
>>> +		return false;
>>> +
>>> +	if (pte_page(pte) == page)
>>> +		return true;
>>
>> I'm thinking whether pte entry could change after we check it since huge_pte_lock is not held here.
>> But I think holding i_mmap_rwsem in writelock mode should give us such a guarantee, e.g. migration
>> entry is changed back to huge pte entry while holding i_mmap_rwsem in readlock mode.
>> Or am I miss something?
> 
> Let me think about this.  I do not think it is possible, but you ask good
> questions.
> 
> Do note that this is the same locking sequence used at the beginning of the
> page fault code where the decision to call hugetlb_no_page() is made.

Yes, hugetlb_fault() can tolerate the stale pte entry because pte entry will be re-checked later under the page table lock.
However if we see a stale pte entry here, the page might be leftover after truncated and thus break truncation? But I'm not
sure whether this will occur. Maybe the i_mmap_rwsem writelock and hugetlb_fault_mutex can prevent this issue.

Thanks,
Miaohe Lin


> 
>>
>>> +
>>> +	return false;
>>> +}
>>> +
>>> +/*
>>> + * Can vma_offset_start/vma_offset_end overflow on 32-bit arches?
>>> + * No, because the interval tree returns us only those vmas
>>> + * which overlap the truncated area starting at pgoff,
>>> + * and no vma on a 32-bit arch can span beyond the 4GB.
>>> + */
>>> +static unsigned long vma_offset_start(struct vm_area_struct *vma, pgoff_t start)
>>> +{
>>> +	if (vma->vm_pgoff < start)
>>> +		return (start - vma->vm_pgoff) << PAGE_SHIFT;
>>> +	else
>>> +		return 0;
>>> +}
>>> +
>>> +static unsigned long vma_offset_end(struct vm_area_struct *vma, pgoff_t end)
>>> +{
>>> +	unsigned long t_end;
>>> +
>>> +	if (!end)
>>> +		return vma->vm_end;
>>> +
>>> +	t_end = ((end - vma->vm_pgoff) << PAGE_SHIFT) + vma->vm_start;
>>> +	if (t_end > vma->vm_end)
>>> +		t_end = vma->vm_end;
>>> +	return t_end;
>>> +}
>>> +
>>> +/*
>>> + * Called with hugetlb fault mutex held.  Therefore, no more mappings to
>>> + * this folio can be created while executing the routine.
>>> + */
>>> +static void hugetlb_unmap_file_folio(struct hstate *h,
>>> +					struct address_space *mapping,
>>> +					struct folio *folio, pgoff_t index)
>>> +{
>>> +	struct rb_root_cached *root = &mapping->i_mmap;
>>> +	struct page *page = &folio->page;
>>> +	struct vm_area_struct *vma;
>>> +	unsigned long v_start;
>>> +	unsigned long v_end;
>>> +	pgoff_t start, end;
>>> +
>>> +	start = index * pages_per_huge_page(h);
>>> +	end = ((index + 1) * pages_per_huge_page(h));
>>
>> It seems the outer parentheses is unneeded?
> 
> Correct.  Thanks.
> 

