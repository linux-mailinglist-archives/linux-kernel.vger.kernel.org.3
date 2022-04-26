Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD3850FC17
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349578AbiDZLpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbiDZLpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:45:03 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B123B2B4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 04:41:55 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KnfxZ01fvzCs2d;
        Tue, 26 Apr 2022 19:37:21 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 19:41:53 +0800
Subject: Re: [PATCH] mm/memory_hotplug: avoid consuming corrupted data when
 offline pages
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
References: <20220421135129.19767-1-linmiaohe@huawei.com>
 <8fae51af-b12f-4232-1330-54f7b0943907@redhat.com>
 <bb011aaf-a45c-c0a8-5e5f-211900d17f19@oracle.com>
 <5b3ba7f6-64c3-4979-1791-2c8fc49e37fb@huawei.com>
 <20220425135555.GA3767079@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3613e166-41a9-62b2-81a3-c775b531a9c7@huawei.com>
Date:   Tue, 26 Apr 2022 19:41:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220425135555.GA3767079@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/25 21:55, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Fri, Apr 22, 2022 at 02:53:48PM +0800, Miaohe Lin wrote:
>> On 2022/4/22 6:04, Mike Kravetz wrote:
>>> On 4/21/22 07:20, David Hildenbrand wrote:
>>>> On 21.04.22 15:51, Miaohe Lin wrote:
>>>>> When trying to offline pages, HWPoisoned hugepage is migrated without
>>>>> checking PageHWPoison first. So corrupted data could be consumed. Fix
>>>>> it by deferring isolate_huge_page until PageHWPoison is handled.
>>>>>
>>>>
>>>> CCing Oscar, Mike and Naoya
>>>>
>>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>>> ---
>>>>>  mm/memory_hotplug.c | 11 +++++++----
>>>>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>>>> index 4c6065e5d274..093f85ec5c5c 100644
>>>>> --- a/mm/memory_hotplug.c
>>>>> +++ b/mm/memory_hotplug.c
>>>>> @@ -1600,11 +1600,9 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>>>>>  		folio = page_folio(page);
>>>>>  		head = &folio->page;
>>>>>  
>>>>> -		if (PageHuge(page)) {
>>>>> +		if (PageHuge(page))
>>>>>  			pfn = page_to_pfn(head) + compound_nr(head) - 1;
>>>>> -			isolate_huge_page(head, &source);
>>>>> -			continue;
>>>>> -		} else if (PageTransHuge(page))
>>>>> +		else if (PageTransHuge(page))
>>>>>  			pfn = page_to_pfn(head) + thp_nr_pages(page) - 1;
>>>>>  
>>>>>  		/*
>>>>> @@ -1622,6 +1620,11 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>>>>>  			continue;
>>>>>  		}
>>>>>  
>>>>> +		if (PageHuge(page)) {
>>>>> +			isolate_huge_page(head, &source);
>>>>> +			continue;
>>>>> +		}
>>>>> +
>>>>>  		if (!get_page_unless_zero(page))
>>>>>  			continue;
>>>>>  		/*
>>>>
>>>> The problem statement makes sense to me but I am not sure about the
>>>> details if we run into the "PageHWPoison" path with a huge page. I have
>>>> the gut feeling that we have to do more for huge pages in the
>>>> PageHWPoison() path, because we might be dealing with a free huge page
>>>> after unmap succeeds. I might be wrong.
>>>>
>>>
>>> Thinking about memory errors always makes my head hurt :)
>>
>> Me too. ;)
>>
>>>
>>> What 'state' could a poisoned hugetlb page be in here?
>>> - Mapped into a process address space?
>>> - On the hugetlb free lists?
> 
> There seems at least 2 cases where a hwpoisoned hugetlb page keeps undissolved.
>   (1) Hwpoisoned hugepage in free hugepage list
>   (2) Hwpoisoned hugepage belonging to a hugetlbfs file
> 
>>>
>>> IIUC, when poisoning a hugetlb page we try to dissolve those that are
>>> free and unmap those which are mapped.  So, this means those operations
>>> must have failed for some reason.  Is that correct?
> 
> Yes, (1) is made by failure in error handling, but (2) can be made even
> when memory error on in-use hugepage is successfully handled.

Could you please explain 2 more detailed? IIUC, in-use hugepage belonging to a hugetlbfs
file will be removed from pagecache via hugetlbfs_error_remove_page. So when successfully
handled, hugepage->mapping will be NULL and thus not belonging to a hugetlbfs file. Or am
I miss something?

> 
>>
>> I think you're right.
>>
>> BTW: Now that PageHWPoison is set under hugetlb_lock and HPageFreed is also checked
>> under that lock, it should be more likely to handle the hugetlb page on the free lists
>> successfully because the possible race with hugetlb page allocation or demotion can be
>> prevented by PageHWPoison flag. So it is more likely to be a mapped hugetlb page here.
>> But that doesn't matter.
>>
>>>
>>> Now, IF the above is true this implies there is a poisoned page somewhere
>>> within the hugetlb page.  But, poison is only marked in the head page.
>>> So, we do not really know where within the page the actual error exists.
>>> Is my reasoning still correct?
>>>
>>
>> IIRC, Naoya once proposed to store the poisoned page info into subpage field.
> 
> Yes, it's important to keep the offset of raw page.  I have a "storing raw
> error info" patch for this, but it's still immature to submit.
> 
>>
>>> If my reasoning is correct, then I am not sure what we can do here.
>>> The code to handle poison is:
>>>
>>>                  if (PageHWPoison(page)) {
>>>                         if (WARN_ON(folio_test_lru(folio)))
>>>                                 folio_isolate_lru(folio);
>>>                         if (folio_mapped(folio))
>>>                                 try_to_unmap(folio, TTU_IGNORE_MLOCK);
>>>                         continue;
>>>                 }
>>>
>>> My first observation is that if a hugetlb page is passed to try_to_unmap
>>> as above we may BUG.  This is because we need to hold i_mmap_rwsem in
>>> write mode because of the possibility of calling huge_pmd_unshare.  :(
>>
>> I'm sorry. I missed that case. :(
> 
> OK, so the above check should not be called for hugetlb pages.
> 
>>
>>>
>>> I 'think' try_to_unmap could succeed on a poisoned hugetlb page once we
>>> add correct locking.  So, the page would be unmapped.  I do not think anyone
>>> is holding a ref, so the last unmap should put the hugetlb page on the
>>> free list.  Correct?  We will not migrate the page, but ...
> 
> That seems depends on whether the hugepage is anonymous or file.
> If we consider anonymous hugepage, the above statement is correct.
> 
> As for what we can do, for (1) we can simply skip the hwpoisoned hugepage
> in do_migrate_range() (i.e. no need to call isolate_huge_page()), because in
> the outer while-loop in offline_pages() we call dissolve_free_huge_pages()
> so free hugepage can be handled here.  The above "storing raw error info"
> patch will also enable dissolve_free_huge_pages() to handle hwpoisoned free
> hugepage (by moving PG_hwpoison flag to the raw error page), so I assume
> to have the patch.

Yes, I think (1) will be fixed this way.

> 
> As for (2), I think that making such hugepages unmovable (by clearing
> HPageMigratable) could work.  With that change, scan_movable_pages() detects
> unmovable pages so do_migrate_range is not called for the hugepages.
> Moreover, scan_movable_pages() should return -EBUSY if an unmovable page is found,
> so offline_pages() fails without trying to touch the hwpoisoned hugepage.

Yes, it seems work but this will lead to the memory offline fails. Could this be too overkill?

> Anyway the reported problem (try to migrate hwpoisoned hugepage) would to be solved.
> 
> # Maybe we might optionally try to free the hwpoisoned hugepage by removing
> # the affected hugetlbfs file, but it's not unclear to me taht that's acceptable
> # (a file is gone when doing memory hotremove?).
> 
>>
>> Might hugetlb page still be in the pagecache? But yes, the last unmap could put
>> the hugetlb page on the free list.
>>
>>>
>>> After the call to do_migrate_range() in offline_pages, we will call
>>> dissolve_free_huge_pages.  For each hugetlb page, dissolve_free_huge_pages
>>> will call dissolve_free_huge_page likely passing in the 'head' page.
>>> When dissolve_free_huge_page is called for poisoned hugetlb pages from
>>> the memory error handling code, it passes in the sub page which contains
>>> the memory error.  Before freeing the hugetlb page to buddy, there is this
>>> code:
>>>
>>>                         /*
>>>                          * Move PageHWPoison flag from head page to the raw
>>>                          * error page, which makes any subpages rather than
>>>                          * the error page reusable.
>>>                          */
>>>                         if (PageHWPoison(head) && page != head) {
>>>                                 SetPageHWPoison(page);
>>>                                 ClearPageHWPoison(head);
>>>                         }
>>>                         update_and_free_page(h, head, false)
>>>
>>> As previously mentioned, outside the memory error handling code we do
>>> not know what page within the hugetlb page contains poison.  So, this
>>> will likely result with a page with errors on the free list and an OK
>>> page marked with error.
>>
>> Yes, this is possible. It's really a pity. Could we just reject to dissolve the
>> hugetlb page and keep the hugetlb page around? This will waste some healthy subpages
>> but can do the right things?
> 
> Could you let me try writing patches in my approach?
> I'll try to submit the fix with the "storing raw error info" patch.

Sure, I will wait for that. Many thanks for your hard work! :)

> 
>>
>>>
>>> In other places, we 'bail' if we encounter a hugetlb page with poison.
>>> It would be unfortunate to prevent memory offline if the range contains
>>> a hugetlb page with poison.  After all, offlining a section with poison
>>> make sense.
>>>
>>
>> IIUC, a (hugetlb) page with poison could be offlined anytime even if it's still in the
>> pagecache, swapcache, i.e. still be referenced by somewhere, because memory offline will
>> just offline the poisoned page while ignoring the page refcnt totally. I can't figure
>> out a easy way to fix it yet. :(
> 
> Yes, that's finally expected behavior, but unlike normal pagecache we need
> pay extra attention for hugetlbfs file because it's not storage-backed.
> 
> Thank you for valuable comments, everyone.

BTW: There is another possible problem about hwpoison. Think about the below scene:

offline_pages
do {
  scan_movable_pages
    __PageMovable /* Page is also hwpoisoned. */
      goto found; /* So ret is always 0. */
  do_migrate_range
     if (PageHWPoison(page)) /* PageMovable hwpoisoned page is not handled. */
        continue;
 } while (!ret); /* We will meet that page again and again. */

So we might busy-loop until a signal is pending. Or am I miss something? And I think this could be fixed by
deferring set hwpoisoned flag until page refcnt is successfully incremented for normal page in memory_failure()
which is already in your to-do list. So this possible issue could be left alone now?

Thanks!

> 
> - Naoya Horiguchi
> 
