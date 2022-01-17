Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5DFA49001E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 03:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbiAQCLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 21:11:11 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:35845 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbiAQCLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 21:11:11 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jcb363j6czccNj;
        Mon, 17 Jan 2022 10:10:26 +0800 (CST)
Received: from dggpemm500003.china.huawei.com (7.185.36.56) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 17 Jan 2022 10:11:09 +0800
Received: from [10.174.185.129] (10.174.185.129) by
 dggpemm500003.china.huawei.com (7.185.36.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 17 Jan 2022 10:11:08 +0800
Message-ID: <fb02087a-b102-c91e-ab65-fb02cc8ee0a2@huawei.com>
Date:   Mon, 17 Jan 2022 10:11:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <wangzhigang17@huawei.com>, Matthew Wilcox <willy@infradead.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
References: <20220113140318.11117-1-zhangliang5@huawei.com>
 <YeA5oP/iaxtVPHb3@casper.infradead.org>
 <CAHk-=wjB0i-B=U-DhpAajQx3f6bp1X==neLOrg0jwq29mgz=3g@mail.gmail.com>
 <172ccfbb-7e24-db21-7d84-8c8d8c3805fd@redhat.com>
 <a93988da-80fb-dd32-4717-a6a0bae9e4ee@huawei.com>
 <dc415c4a-63aa-19b0-0fbc-795989970f6d@redhat.com>
From:   "zhangliang (AG)" <zhangliang5@huawei.com>
In-Reply-To: <dc415c4a-63aa-19b0-0fbc-795989970f6d@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.129]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500003.china.huawei.com (7.185.36.56)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thank you very much for your patient reply, and I completely agree with the viewpoint from you and Linus about COW and reuse_swap_page(). :)

On 2022/1/14 19:23, David Hildenbrand wrote:
> On 14.01.22 06:00, zhangliang (AG) wrote:
>>
>>
>> On 2022/1/14 0:48, David Hildenbrand wrote:
>>> On 13.01.22 17:37, Linus Torvalds wrote:
>>>> On Thu, Jan 13, 2022 at 6:39 AM Matthew Wilcox <willy@infradead.org> wrote:
>>>>>
>>>>> Let's bring Linus in on this, but I think this reintroduces all of the
>>>>> mapcount problems that we've been discussing recently.
>>>>>
>>>>> How about this as an alternative?
>>>>
>>>> No, at that point reuse_swap_page() is the better thing to do.
>>>>
>>>> Don't play games with page_count() (or even worse games with
>>>> swap_count). The page count is only stable if it's 1. Any other value
>>>> means that it can fluctuate due to concurrent lookups, some of which
>>>> can be done locklessly under RCU.
>>>
>>> I'm pretty sure the patch as is will reintroduce the CVE. So I think in
>>
>> Actually, I wonder how reuse_swap_page() in this patch can reintroduce CVE,
>> I think the invoking logic here is as same as that in do_swap_page(). 
>> So, could you give me some hint about this? Thanks :)
> 
> The CVE essentially is
> 
> a) Process A maps an anon page
> -> refcount = 1, mapcount = 1
> b) Process A forks process B
> -> Page mapped R/O
> -> refcount = 2, mapcount = 2
> c) Process B pins the page R/O (e.g., vmsplice)
> -> refcount > 2, mapcount = 2
> d) Process B unmaps the page
> -> refcount > 1, mapcount = 1
> e) Process A writes to the page
> 
> If e) ends up reusing the page for process A (e.g., because mapcount == 1), 
> process B can observe the memory modifications via the
> page pinning
> 
> As I previously said, our COW logic is completely inconsistent
> and should be streamlined. Regarding the CVE, what would have 
> to happen is that we put the page into the swapcache and unmap
> from both processes after c). Then, do_swap_page() would reuse
> the page during e) similarly.
> 
> We do have a check in place that protects against pinned pages
> not being able to enter the swapcache, but IIRC it can race with
> GUP, so it might race with c) eventually, meaning that with swap
> there might still be a small chance for the CVE in current upstream IIRC.
> 
> I think with your patch we could trick do_wp_page() do go down the 
> reuse_swap_page() path and reuse the page, even though there is a pending
> pin on the page from process B.
> 
> 
> a) Process A maps an anon page
> -> refcount = 1, mapcount = 1
> b) Page is added to the swapcache and unmapped
> -> refcount = 1, mapcount = 0
> c) Process A reads page
> -> do_swap_page() will map the page R/O
> -> the page might remain in the swapcache
> -> refcount = 2, mapcount = 1
> d) Process A forks process B
> -> Page mapped R/O
> -> refcount = 3, mapcount = 2
> e) Process B pins the page R/O (e.g., vmsplice)
> -> refcount > 3, mapcount = 2
> d) Process B unmaps the page
> -> refcount > 2, mapcount = 1
> e) Process A writes to the page
> 
> In e), we would go into reuse_swap_page() and could succeed, being left with
> refcount > 1 and mapcount = 1.
> 
> But maybe I am missing something :)
> 
> 
> 
> There are only two real ways I know to handle the scenario above:
> (1) Rely on page_count() == 1 in COW logic to decide whether we can
>     reuse a page. This comes with false negatives, some being harmful,
>     some just being a performance problem.
> (2) Rely on mapcount(), swapcount() ... when deciding to reuse a page
>     and when it's safe to take a GUP pin.
> 
> (2) was discussed in 
>   https://lkml.kernel.org/r/20211217113049.23850-1-david@redhat.com
> but was essentially NAKed by Linus in the current form (well, it didn't
> consider the swapcount so it was just buggy, fortunately Linus pointed that
> out).
> 
> To handle problematic false negatives with (1) I'm looking into marking
> anon pages as exclusively owned by a single process, such that we can simply
> reuse them in the COW path -- PageAnonExclusive() also discussed inside that
> posting. That posting also contains a test case which tests all different
> variants of the "child can observe MAP_PRIVAT  modifications of the parent"
> we know of (e.g., THP, hugetlb), which you might use to verify if the issue is
> reintroduced by your patch or not.
> 
> 
> Yesterday, I played with removing reuse_swap_page() completely
> and streamlining our COW logic like so:
> 
> (based on https://www.spinics.net/lists/linux-mm/msg279460.html)
> 
> 
> commit f1fa31a40b13ade5cd93ceb40daadf1196526145
> Author: David Hildenbrand <david@redhat.com>
> Date:   Fri Jan 14 09:29:52 2022 +0100
> 
>     mm: optimize do_wp_page() for exclusive pages in the swapcache
>     
>     Let's optimize for a page with a single user that has been added to the
>     swapcache. Try removing the swapcache reference if there is hope that
>     we're the exclusive user, but keep the page_count(page) == 1 check in
>     place.
>     
>     Avoid using reuse_swap_page(), we'll streamline all reuse_swap_page()
>     users next.
>     
>     While at it, remove the superfluous page_mapcount() check: it's
>     implicitly covered by the page_count() for ordinary anon pages.
>     
>     Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index e8e2144cbfa6..bd2af7a36791 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3290,12 +3290,21 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>         if (PageAnon(vmf->page)) {
>                 struct page *page = vmf->page;
>  
> -               /* PageKsm() doesn't necessarily raise the page refcount */
> -               if (PageKsm(page) || page_count(page) != 1)
> +               /*
> +                * PageKsm() doesn't necessarily raise the page refcount.
> +                *
> +                * These checks are racy as long as we haven't locked the page;
> +                * they are a pure optimization to avoid trying to lock the page
> +                * and trying to free the swap cache when there is little hope
> +                * it will actually result in a refcount of 1.
> +                */
> +               if (PageKsm(page) || page_count(page) <= 1 + PageSwapCache(page))
>                         goto copy;
>                 if (!trylock_page(page))
>                         goto copy;
> -               if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
> +               if (PageSwapCache(page))
> +                       try_to_free_swap(page);
> +               if (PageKsm(page) || page_count(page) != 1) {
>                         unlock_page(page);
>                         goto copy;
>                 }
> 
> 
> 
> Followed by
> 
> 
> 
> commit 754aa8f04f7b6d1ffc2b9844be63bbf7b527929f (HEAD)
> Author: David Hildenbrand <david@redhat.com>
> Date:   Fri Jan 14 09:53:20 2022 +0100
> 
>     mm: streamline COW logic in do_swap_page()
>     
>     Let's apply the same COW logic as in do_wp_page(), conditionally trying to
>     remove the page from the swapcache after freeing the swap entry, however,
>     before actually mapping our page. We can change the order now that
>     reuse_swap_page() is no longer used.
>     
>     Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index bd2af7a36791..a1bd2b5c818a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3489,6 +3489,24 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
>         return 0;
>  }
>  
> +static inline bool should_try_to_free_swap(struct page *page,
> +                                          struct vm_area_struct *vma,
> +                                          unsigned int fault_flags)
> +{
> +       if (!PageSwapCache(page))
> +               return false;
> +       if (mem_cgroup_swap_full(page) || (vma->vm_flags & VM_LOCKED) ||
> +           PageMlocked(page))
> +               return true;
> +       /*
> +        * We must only reuse the page if the page_count() is 1. Try to
> +        * free the swapcache to get rid of the swapcache reference in case
> +        * it's likely that we will succeed.
> +        */
> +       return (fault_flags & FAULT_FLAG_WRITE) && !PageKsm(page) &&
> +               page_count(page) == 2;
> +}
> +
>  /*
>   * We enter with non-exclusive mmap_lock (to exclude vma changes,
>   * but allow concurrent faults), and pte mapped but not yet locked.
> @@ -3612,7 +3630,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         }
>  
>         /*
> -        * Make sure try_to_free_swap or reuse_swap_page or swapoff did not
> +        * Make sure try_to_free_swap or swapoff did not
>          * release the swapcache from under us.  The page pin, and pte_same
>          * test below, are not enough to exclude that.  Even if it is still
>          * swapcache, we need to check that the page's swap has not changed.
> @@ -3644,19 +3662,22 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         }
>  
>         /*
> -        * The page isn't present yet, go ahead with the fault.
> -        *
> -        * Be careful about the sequence of operations here.
> -        * To get its accounting right, reuse_swap_page() must be called
> -        * while the page is counted on swap but not yet in mapcount i.e.
> -        * before page_add_anon_rmap() and swap_free(); try_to_free_swap()
> -        * must be called after the swap_free(), or it will never succeed.
> +        * Remove the swap entry and conditionally try to free up the swapcache.
> +        * We're already holding a reference on the page but haven't mapped it
> +        * yet. We won't be waiting on writeback, so if there is concurrent
> +        * writeback we won't map the page writable just now.
>          */
> +       swap_free(entry);
> +       if (should_try_to_free_swap(page, vma, vmf->flags))
> +               try_to_free_swap(page);
>  
>         inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
>         dec_mm_counter_fast(vma->vm_mm, MM_SWAPENTS);
>         pte = mk_pte(page, vma->vm_page_prot);
> -       if ((vmf->flags & FAULT_FLAG_WRITE) && reuse_swap_page(page)) {
> +
> +       /* Same logic as in do_wp_page(). */
> +       if ((vmf->flags & FAULT_FLAG_WRITE) &&
> +           !PageKsm(page) && page_count(page) == 1) {
>                 pte = maybe_mkwrite(pte_mkdirty(pte), vma);
>                 vmf->flags &= ~FAULT_FLAG_WRITE;
>                 ret |= VM_FAULT_WRITE;
> @@ -3681,10 +3702,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                 do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
>         }
>  
> -       swap_free(entry);
> -       if (mem_cgroup_swap_full(page) ||
> -           (vma->vm_flags & VM_LOCKED) || PageMlocked(page))
> -               try_to_free_swap(page);
>         unlock_page(page);
>         if (page != swapcache && swapcache) {
>                 /*
> 
> 
> 
> 
> And followed by more patches that rip out reuse_swap_page() completely.
> 
> 
> But I still have to understand what's safe to do and not do in do_swap_page(),
> and which effect it would have. Especially PTE-mapped THP are a head-scratcher
> for me, and the interaction with THP in the swapcache before/after actual swap.
> 
> So consider above a WIP prototype that's mostly untested.
> 

-- 
Best Regards,
Liang Zhang
