Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A3648E91D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 12:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbiANLXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 06:23:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46637 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229879AbiANLXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 06:23:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642159427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fvSH3s2fF/DAnDQ9M47Xn9T39SNMsDgmBGmqJaED4Jg=;
        b=GUZj0Id/7vJFlPOHKehikv5bsY5DyNBQn1qjjm8BrhnbwwFFNUHLxYS2KLWf5yP5j9pr5d
        ATobdFviAtgXxndBMPzVwi3I2rx/Mt/1Veaql8w9NQhGQnjbM3V8vLskEndpHO0psnmBsy
        nG+jvAs7r29DdDxfhWmDConjhT7ScVA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-4_2ZpyxnNkKZGQccuk0vkA-1; Fri, 14 Jan 2022 06:23:46 -0500
X-MC-Unique: 4_2ZpyxnNkKZGQccuk0vkA-1
Received: by mail-ed1-f70.google.com with SMTP id r8-20020a05640251c800b003f9a52daa3fso8067910edd.22
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 03:23:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=fvSH3s2fF/DAnDQ9M47Xn9T39SNMsDgmBGmqJaED4Jg=;
        b=N6G8/PxN7xsmSEh7P9E740BX6gYzigZOY+U4JCHnZPlXHM+8MM4jDQIEqOe/umJlJ/
         QMvogQ9umukXfN14f7PdJ/AUZaxWQII4fLobwLrODpCP8Of9zPLpaTqcxPKUNHH862nb
         ym1vORA9lzseMRYHchxEuhx+NChQKQKHjJwjHmCJPhKvsVfZXHOxZJ5EAdstc2ZtaVoT
         qXWZCZS9TKZc/f/TztNKa+Hc3ILQAz5uvvP2geItmAg6go3us7niEVWHcK3Y/bqSrRp1
         wyQ7YQwqXUkU2ZZo9JAemILPLx3g4HdqXhrhRDDD8Q24D26QzJ7fCYOHJp8wcQ3qcjRV
         0eqw==
X-Gm-Message-State: AOAM531hE6R6LisPDEe6k3KGzTvWtmEJVOCxrQ2b2JX7SlEIYUwDlhEM
        EKbG6IUqkD+/qsCo1fcOczZLgmdBPfu7TksY2gPR9JTdMyk8mNO0Pul1FFpI+Ri1q5G9Q8Tyx/v
        +BtUbeMMDraHPg2PrRuzubNUK
X-Received: by 2002:aa7:c3d8:: with SMTP id l24mr8594301edr.415.1642159424836;
        Fri, 14 Jan 2022 03:23:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzR9h74CE5WeueGsxV0aNki9+ultcOb2btM/j5rMpH2rlZDkYwP1ZS7eBb099FU1drx+9lJgg==
X-Received: by 2002:aa7:c3d8:: with SMTP id l24mr8594274edr.415.1642159424499;
        Fri, 14 Jan 2022 03:23:44 -0800 (PST)
Received: from ?IPV6:2003:cb:c701:9d00:ff87:1c9b:108a:9702? (p200300cbc7019d00ff871c9b108a9702.dip0.t-ipconnect.de. [2003:cb:c701:9d00:ff87:1c9b:108a:9702])
        by smtp.gmail.com with ESMTPSA id a20sm2283634eda.21.2022.01.14.03.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 03:23:44 -0800 (PST)
Message-ID: <dc415c4a-63aa-19b0-0fbc-795989970f6d@redhat.com>
Date:   Fri, 14 Jan 2022 12:23:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     "zhangliang (AG)" <zhangliang5@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220113140318.11117-1-zhangliang5@huawei.com>
 <YeA5oP/iaxtVPHb3@casper.infradead.org>
 <CAHk-=wjB0i-B=U-DhpAajQx3f6bp1X==neLOrg0jwq29mgz=3g@mail.gmail.com>
 <172ccfbb-7e24-db21-7d84-8c8d8c3805fd@redhat.com>
 <a93988da-80fb-dd32-4717-a6a0bae9e4ee@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
In-Reply-To: <a93988da-80fb-dd32-4717-a6a0bae9e4ee@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.01.22 06:00, zhangliang (AG) wrote:
> 
> 
> On 2022/1/14 0:48, David Hildenbrand wrote:
>> On 13.01.22 17:37, Linus Torvalds wrote:
>>> On Thu, Jan 13, 2022 at 6:39 AM Matthew Wilcox <willy@infradead.org> wrote:
>>>>
>>>> Let's bring Linus in on this, but I think this reintroduces all of the
>>>> mapcount problems that we've been discussing recently.
>>>>
>>>> How about this as an alternative?
>>>
>>> No, at that point reuse_swap_page() is the better thing to do.
>>>
>>> Don't play games with page_count() (or even worse games with
>>> swap_count). The page count is only stable if it's 1. Any other value
>>> means that it can fluctuate due to concurrent lookups, some of which
>>> can be done locklessly under RCU.
>>
>> I'm pretty sure the patch as is will reintroduce the CVE. So I think in
> 
> Actually, I wonder how reuse_swap_page() in this patch can reintroduce CVE,
> I think the invoking logic here is as same as that in do_swap_page(). 
> So, could you give me some hint about this? Thanks :)

The CVE essentially is

a) Process A maps an anon page
-> refcount = 1, mapcount = 1
b) Process A forks process B
-> Page mapped R/O
-> refcount = 2, mapcount = 2
c) Process B pins the page R/O (e.g., vmsplice)
-> refcount > 2, mapcount = 2
d) Process B unmaps the page
-> refcount > 1, mapcount = 1
e) Process A writes to the page

If e) ends up reusing the page for process A (e.g., because mapcount == 1), 
process B can observe the memory modifications via the
page pinning

As I previously said, our COW logic is completely inconsistent
and should be streamlined. Regarding the CVE, what would have 
to happen is that we put the page into the swapcache and unmap
from both processes after c). Then, do_swap_page() would reuse
the page during e) similarly.

We do have a check in place that protects against pinned pages
not being able to enter the swapcache, but IIRC it can race with
GUP, so it might race with c) eventually, meaning that with swap
there might still be a small chance for the CVE in current upstream IIRC.

I think with your patch we could trick do_wp_page() do go down the 
reuse_swap_page() path and reuse the page, even though there is a pending
pin on the page from process B.


a) Process A maps an anon page
-> refcount = 1, mapcount = 1
b) Page is added to the swapcache and unmapped
-> refcount = 1, mapcount = 0
c) Process A reads page
-> do_swap_page() will map the page R/O
-> the page might remain in the swapcache
-> refcount = 2, mapcount = 1
d) Process A forks process B
-> Page mapped R/O
-> refcount = 3, mapcount = 2
e) Process B pins the page R/O (e.g., vmsplice)
-> refcount > 3, mapcount = 2
d) Process B unmaps the page
-> refcount > 2, mapcount = 1
e) Process A writes to the page

In e), we would go into reuse_swap_page() and could succeed, being left with
refcount > 1 and mapcount = 1.

But maybe I am missing something :)



There are only two real ways I know to handle the scenario above:
(1) Rely on page_count() == 1 in COW logic to decide whether we can
    reuse a page. This comes with false negatives, some being harmful,
    some just being a performance problem.
(2) Rely on mapcount(), swapcount() ... when deciding to reuse a page
    and when it's safe to take a GUP pin.

(2) was discussed in 
  https://lkml.kernel.org/r/20211217113049.23850-1-david@redhat.com
but was essentially NAKed by Linus in the current form (well, it didn't
consider the swapcount so it was just buggy, fortunately Linus pointed that
out).

To handle problematic false negatives with (1) I'm looking into marking
anon pages as exclusively owned by a single process, such that we can simply
reuse them in the COW path -- PageAnonExclusive() also discussed inside that
posting. That posting also contains a test case which tests all different
variants of the "child can observe MAP_PRIVAT  modifications of the parent"
we know of (e.g., THP, hugetlb), which you might use to verify if the issue is
reintroduced by your patch or not.


Yesterday, I played with removing reuse_swap_page() completely
and streamlining our COW logic like so:

(based on https://www.spinics.net/lists/linux-mm/msg279460.html)


commit f1fa31a40b13ade5cd93ceb40daadf1196526145
Author: David Hildenbrand <david@redhat.com>
Date:   Fri Jan 14 09:29:52 2022 +0100

    mm: optimize do_wp_page() for exclusive pages in the swapcache
    
    Let's optimize for a page with a single user that has been added to the
    swapcache. Try removing the swapcache reference if there is hope that
    we're the exclusive user, but keep the page_count(page) == 1 check in
    place.
    
    Avoid using reuse_swap_page(), we'll streamline all reuse_swap_page()
    users next.
    
    While at it, remove the superfluous page_mapcount() check: it's
    implicitly covered by the page_count() for ordinary anon pages.
    
    Signed-off-by: David Hildenbrand <david@redhat.com>

diff --git a/mm/memory.c b/mm/memory.c
index e8e2144cbfa6..bd2af7a36791 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3290,12 +3290,21 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
        if (PageAnon(vmf->page)) {
                struct page *page = vmf->page;
 
-               /* PageKsm() doesn't necessarily raise the page refcount */
-               if (PageKsm(page) || page_count(page) != 1)
+               /*
+                * PageKsm() doesn't necessarily raise the page refcount.
+                *
+                * These checks are racy as long as we haven't locked the page;
+                * they are a pure optimization to avoid trying to lock the page
+                * and trying to free the swap cache when there is little hope
+                * it will actually result in a refcount of 1.
+                */
+               if (PageKsm(page) || page_count(page) <= 1 + PageSwapCache(page))
                        goto copy;
                if (!trylock_page(page))
                        goto copy;
-               if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
+               if (PageSwapCache(page))
+                       try_to_free_swap(page);
+               if (PageKsm(page) || page_count(page) != 1) {
                        unlock_page(page);
                        goto copy;
                }



Followed by



commit 754aa8f04f7b6d1ffc2b9844be63bbf7b527929f (HEAD)
Author: David Hildenbrand <david@redhat.com>
Date:   Fri Jan 14 09:53:20 2022 +0100

    mm: streamline COW logic in do_swap_page()
    
    Let's apply the same COW logic as in do_wp_page(), conditionally trying to
    remove the page from the swapcache after freeing the swap entry, however,
    before actually mapping our page. We can change the order now that
    reuse_swap_page() is no longer used.
    
    Signed-off-by: David Hildenbrand <david@redhat.com>


diff --git a/mm/memory.c b/mm/memory.c
index bd2af7a36791..a1bd2b5c818a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3489,6 +3489,24 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
        return 0;
 }
 
+static inline bool should_try_to_free_swap(struct page *page,
+                                          struct vm_area_struct *vma,
+                                          unsigned int fault_flags)
+{
+       if (!PageSwapCache(page))
+               return false;
+       if (mem_cgroup_swap_full(page) || (vma->vm_flags & VM_LOCKED) ||
+           PageMlocked(page))
+               return true;
+       /*
+        * We must only reuse the page if the page_count() is 1. Try to
+        * free the swapcache to get rid of the swapcache reference in case
+        * it's likely that we will succeed.
+        */
+       return (fault_flags & FAULT_FLAG_WRITE) && !PageKsm(page) &&
+               page_count(page) == 2;
+}
+
 /*
  * We enter with non-exclusive mmap_lock (to exclude vma changes,
  * but allow concurrent faults), and pte mapped but not yet locked.
@@ -3612,7 +3630,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
        }
 
        /*
-        * Make sure try_to_free_swap or reuse_swap_page or swapoff did not
+        * Make sure try_to_free_swap or swapoff did not
         * release the swapcache from under us.  The page pin, and pte_same
         * test below, are not enough to exclude that.  Even if it is still
         * swapcache, we need to check that the page's swap has not changed.
@@ -3644,19 +3662,22 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
        }
 
        /*
-        * The page isn't present yet, go ahead with the fault.
-        *
-        * Be careful about the sequence of operations here.
-        * To get its accounting right, reuse_swap_page() must be called
-        * while the page is counted on swap but not yet in mapcount i.e.
-        * before page_add_anon_rmap() and swap_free(); try_to_free_swap()
-        * must be called after the swap_free(), or it will never succeed.
+        * Remove the swap entry and conditionally try to free up the swapcache.
+        * We're already holding a reference on the page but haven't mapped it
+        * yet. We won't be waiting on writeback, so if there is concurrent
+        * writeback we won't map the page writable just now.
         */
+       swap_free(entry);
+       if (should_try_to_free_swap(page, vma, vmf->flags))
+               try_to_free_swap(page);
 
        inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
        dec_mm_counter_fast(vma->vm_mm, MM_SWAPENTS);
        pte = mk_pte(page, vma->vm_page_prot);
-       if ((vmf->flags & FAULT_FLAG_WRITE) && reuse_swap_page(page)) {
+
+       /* Same logic as in do_wp_page(). */
+       if ((vmf->flags & FAULT_FLAG_WRITE) &&
+           !PageKsm(page) && page_count(page) == 1) {
                pte = maybe_mkwrite(pte_mkdirty(pte), vma);
                vmf->flags &= ~FAULT_FLAG_WRITE;
                ret |= VM_FAULT_WRITE;
@@ -3681,10 +3702,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
                do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
        }
 
-       swap_free(entry);
-       if (mem_cgroup_swap_full(page) ||
-           (vma->vm_flags & VM_LOCKED) || PageMlocked(page))
-               try_to_free_swap(page);
        unlock_page(page);
        if (page != swapcache && swapcache) {
                /*




And followed by more patches that rip out reuse_swap_page() completely.


But I still have to understand what's safe to do and not do in do_swap_page(),
and which effect it would have. Especially PTE-mapped THP are a head-scratcher
for me, and the interaction with THP in the swapcache before/after actual swap.

So consider above a WIP prototype that's mostly untested.

-- 
Thanks,

David / dhildenb

