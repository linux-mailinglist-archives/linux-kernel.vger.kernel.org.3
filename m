Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE49350B0ED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444573AbiDVG4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiDVG4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:56:45 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8070350E24
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:53:51 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Kl4l6299tzCrf6;
        Fri, 22 Apr 2022 14:49:22 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 14:53:49 +0800
Subject: Re: [PATCH] mm/memory_hotplug: avoid consuming corrupted data when
 offline pages
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
References: <20220421135129.19767-1-linmiaohe@huawei.com>
 <8fae51af-b12f-4232-1330-54f7b0943907@redhat.com>
 <bb011aaf-a45c-c0a8-5e5f-211900d17f19@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5b3ba7f6-64c3-4979-1791-2c8fc49e37fb@huawei.com>
Date:   Fri, 22 Apr 2022 14:53:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <bb011aaf-a45c-c0a8-5e5f-211900d17f19@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/22 6:04, Mike Kravetz wrote:
> On 4/21/22 07:20, David Hildenbrand wrote:
>> On 21.04.22 15:51, Miaohe Lin wrote:
>>> When trying to offline pages, HWPoisoned hugepage is migrated without
>>> checking PageHWPoison first. So corrupted data could be consumed. Fix
>>> it by deferring isolate_huge_page until PageHWPoison is handled.
>>>
>>
>> CCing Oscar, Mike and Naoya
>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>  mm/memory_hotplug.c | 11 +++++++----
>>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>> index 4c6065e5d274..093f85ec5c5c 100644
>>> --- a/mm/memory_hotplug.c
>>> +++ b/mm/memory_hotplug.c
>>> @@ -1600,11 +1600,9 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>>>  		folio = page_folio(page);
>>>  		head = &folio->page;
>>>  
>>> -		if (PageHuge(page)) {
>>> +		if (PageHuge(page))
>>>  			pfn = page_to_pfn(head) + compound_nr(head) - 1;
>>> -			isolate_huge_page(head, &source);
>>> -			continue;
>>> -		} else if (PageTransHuge(page))
>>> +		else if (PageTransHuge(page))
>>>  			pfn = page_to_pfn(head) + thp_nr_pages(page) - 1;
>>>  
>>>  		/*
>>> @@ -1622,6 +1620,11 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>>>  			continue;
>>>  		}
>>>  
>>> +		if (PageHuge(page)) {
>>> +			isolate_huge_page(head, &source);
>>> +			continue;
>>> +		}
>>> +
>>>  		if (!get_page_unless_zero(page))
>>>  			continue;
>>>  		/*
>>
>> The problem statement makes sense to me but I am not sure about the
>> details if we run into the "PageHWPoison" path with a huge page. I have
>> the gut feeling that we have to do more for huge pages in the
>> PageHWPoison() path, because we might be dealing with a free huge page
>> after unmap succeeds. I might be wrong.
>>
> 
> Thinking about memory errors always makes my head hurt :)

Me too. ;)

> 
> What 'state' could a poisoned hugetlb page be in here?
> - Mapped into a process address space?
> - On the hugetlb free lists?
> 
> IIUC, when poisoning a hugetlb page we try to dissolve those that are
> free and unmap those which are mapped.  So, this means those operations
> must have failed for some reason.  Is that correct?

I think you're right.

BTW: Now that PageHWPoison is set under hugetlb_lock and HPageFreed is also checked
under that lock, it should be more likely to handle the hugetlb page on the free lists
successfully because the possible race with hugetlb page allocation or demotion can be
prevented by PageHWPoison flag. So it is more likely to be a mapped hugetlb page here.
But that doesn't matter.

> 
> Now, IF the above is true this implies there is a poisoned page somewhere
> within the hugetlb page.  But, poison is only marked in the head page.
> So, we do not really know where within the page the actual error exists.
> Is my reasoning still correct?
> 

IIRC, Naoya once proposed to store the poisoned page info into subpage field.

> If my reasoning is correct, then I am not sure what we can do here.
> The code to handle poison is:
> 
>                  if (PageHWPoison(page)) {
>                         if (WARN_ON(folio_test_lru(folio)))
>                                 folio_isolate_lru(folio);
>                         if (folio_mapped(folio))
>                                 try_to_unmap(folio, TTU_IGNORE_MLOCK);
>                         continue;
>                 }
> 
> My first observation is that if a hugetlb page is passed to try_to_unmap
> as above we may BUG.  This is because we need to hold i_mmap_rwsem in
> write mode because of the possibility of calling huge_pmd_unshare.  :(

I'm sorry. I missed that case. :(

> 
> I 'think' try_to_unmap could succeed on a poisoned hugetlb page once we
> add correct locking.  So, the page would be unmapped.  I do not think anyone
> is holding a ref, so the last unmap should put the hugetlb page on the
> free list.  Correct?  We will not migrate the page, but ...

Might hugetlb page still be in the pagecache? But yes, the last unmap could put
the hugetlb page on the free list.

> 
> After the call to do_migrate_range() in offline_pages, we will call
> dissolve_free_huge_pages.  For each hugetlb page, dissolve_free_huge_pages
> will call dissolve_free_huge_page likely passing in the 'head' page.
> When dissolve_free_huge_page is called for poisoned hugetlb pages from
> the memory error handling code, it passes in the sub page which contains
> the memory error.  Before freeing the hugetlb page to buddy, there is this
> code:
> 
>                         /*
>                          * Move PageHWPoison flag from head page to the raw
>                          * error page, which makes any subpages rather than
>                          * the error page reusable.
>                          */
>                         if (PageHWPoison(head) && page != head) {
>                                 SetPageHWPoison(page);
>                                 ClearPageHWPoison(head);
>                         }
>                         update_and_free_page(h, head, false)
> 
> As previously mentioned, outside the memory error handling code we do
> not know what page within the hugetlb page contains poison.  So, this
> will likely result with a page with errors on the free list and an OK
> page marked with error.

Yes, this is possible. It's really a pity. Could we just reject to dissolve the
hugetlb page and keep the hugetlb page around? This will waste some healthy subpages
but can do the right things?

> 
> In other places, we 'bail' if we encounter a hugetlb page with poison.
> It would be unfortunate to prevent memory offline if the range contains
> a hugetlb page with poison.  After all, offlining a section with poison
> make sense.
> 

IIUC, a (hugetlb) page with poison could be offlined anytime even if it's still in the
pagecache, swapcache, i.e. still be referenced by somewhere, because memory offline will
just offline the poisoned page while ignoring the page refcnt totally. I can't figure
out a easy way to fix it yet. :(

Thanks!
