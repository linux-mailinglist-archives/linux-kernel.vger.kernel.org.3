Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345CB49ED5C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 22:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344306AbiA0VX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 16:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240581AbiA0VXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 16:23:55 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA43BC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:23:54 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id j2so5500876edj.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vsZxj2n/FQH3vhW+ujW3pW+S6DvzEuQ7kVmpC7bpK4k=;
        b=Cl0nOWq7usXUtt3ClyuNJoGcfX4dh8CnVflfZzrcDXHlPXHL1bT6/PKwOHZhp24ISE
         T1nf5dlnF6DIfFFEhHEPhOL6qQdEe7QRCLsQWwfth+zmfqdRhl8xnCFXK8ipUX6EVYOA
         6qJGWWuMFlfBFC3ToIQ8aHCFia2FZWzFjKlD9o3IXirOkv9DBp4YAwhr+N2CJf0ejrgw
         Tp/bVDl9CItryv66zQnjsJ4UjZp0xLCC8FFUSk1QByIKDkfJvdhkDLTlgobuOc820jFV
         /tYkNw1Ms1a5c10atzqsBH1pQlTsvRPA5xrJo2KA4bijTpvW2R0oI9GX5hzlKbETcS6P
         ePVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vsZxj2n/FQH3vhW+ujW3pW+S6DvzEuQ7kVmpC7bpK4k=;
        b=dHPbwrUUf9rMDE4ySxJ63beFE3B17GGN2Jz+HE0SjQzRh9EawO/SEnO/5CmzZjzVt/
         cnA0zBVL5GTQvT6pZSF8hpTcPe0qtQEIHQ6nEzCT8NrkJrdPXx6Gsyn4z6uMYZh0WlaK
         KugDFDDrfpxLydx1+c3YmemKVSm+d/WBAx6TwX2PZI+xryHWAwmd1wGAJlKc6STQ3MPt
         UaOostYeSLeIFTsw2vr4vuJoeodCtq0TEiwUCpPB6bxnXtzdLP2PL5sIzvdzGDq0DIqP
         GOV8catDpuXHqeepmMtDIZhoZ08yHFYOhyqQ9V5GWifo7XXQOWRaFKVfhY7b2rVeY4cL
         iaAQ==
X-Gm-Message-State: AOAM532bYEszodQWO54AOwVB10ml/uTeiOJ5UOZy6mgXqtgncgbcTdQ9
        p5r7UdwxMQrVAy8tmV1fPcczedor4+bxRn0mMwI132eC35Q=
X-Google-Smtp-Source: ABdhPJzpHUVc73mppp42NKEBLjn1WogRWR7KLVE21G2OpChrbS0G4B78nybuuh/nEwzSP4pHeIVrsKj6rsxgdgMi12g=
X-Received: by 2002:a05:6402:270f:: with SMTP id y15mr5235743edd.409.1643318633482;
 Thu, 27 Jan 2022 13:23:53 -0800 (PST)
MIME-Version: 1.0
References: <20220126095557.32392-1-david@redhat.com> <20220126095557.32392-7-david@redhat.com>
In-Reply-To: <20220126095557.32392-7-david@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 27 Jan 2022 13:23:41 -0800
Message-ID: <CAHbLzkpRgeYkPHUc3KAUc_Fr-YexQxK1cH92Suueac5GrwZHsw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 6/9] mm/khugepaged: remove reuse_swap_page() usage
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 2:00 AM David Hildenbrand <david@redhat.com> wrote:
>
> reuse_swap_page() currently indicates if we can write to an anon page
> without COW. A COW is required if the page is shared by multiple
> processes (either already mapped or via swap entries) or if there is
> concurrent writeback that cannot tolerate concurrent page modifications.
>
> reuse_swap_page() doesn't check for pending references from other
> processes that already unmapped the page, however,
> is_refcount_suitable() essentially does the same thing in the context of
> khugepaged. khugepaged is the last remaining user of reuse_swap_page() and
> we want to remove that function.
>
> In the context of khugepaged, we are not actually going to write to the
> page and we don't really care about other processes mapping the page:
> for example, without swap, we don't care about shared pages at all.
>
> The current logic seems to be:
> * Writable: -> Not shared, but might be in the swapcache. Nobody can
>   fault it in from the swapcache as there are no other swap entries.
> * Readable and not in the swapcache: Might be shared (but nobody can
>   fault it in from the swapcache).
> * Readable and in the swapcache: Might be shared and someone might be
>   able to fault it in from the swapcache. Make sure we're the exclusive
>   owner via reuse_swap_page().
>
> Having to guess due to lack of comments and documentation, the current
> logic really only wants to make sure that a page that might be shared
> cannot be faulted in from the swapcache while khugepaged is active.
> It's hard to guess why that is that case and if it's really still required,
> but let's try keeping that logic unmodified.

I don't think it could be faulted in while khugepaged is active since
khugepaged does hold mmap_lock in write mode IIUC. So page fault is
serialized against khugepaged.

My wild guess is that collapsing shared pages was not supported before
v5.8, so we need reuse_swap_page() to tell us if the page in swap
cache is shared or not. But it is not true anymore. And khugepaged
just allocates a THP then copy the data from base pages to huge page
then replace PTEs to PMD, it doesn't change the content of the page,
so I failed to see a problem by collapsing a shared page in swap
cache. But I'm really not entirely sure, I may miss something...



>
> Instead of relying on reuse_swap_page(), let's unconditionally
> try_to_free_swap(), special casing PageKsm(). try_to_free_swap() will fail
> if there are still swap entries targeting the page or if the page is under
> writeback.
>
> After a successful try_to_free_swap() that page cannot be readded to the
> swapcache because we're keeping the page locked and removed from the LRU
> until we actually perform the copy. So once we succeeded removing a page
> from the swapcache, it cannot be re-added until we're done copying. Add a
> comment stating that.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/khugepaged.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 35f14d0a00a6..bc0ff598e98f 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -683,10 +683,10 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>                         goto out;
>                 }
>                 if (!pte_write(pteval) && PageSwapCache(page) &&
> -                               !reuse_swap_page(page)) {
> +                   (PageKsm(page) || !try_to_free_swap(page))) {
>                         /*
> -                        * Page is in the swap cache and cannot be re-used.
> -                        * It cannot be collapsed into a THP.
> +                        * Possibly shared page cannot be removed from the
> +                        * swapache. It cannot be collapsed into a THP.
>                          */
>                         unlock_page(page);
>                         result = SCAN_SWAP_CACHE_PAGE;
> @@ -702,6 +702,16 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>                         result = SCAN_DEL_PAGE_LRU;
>                         goto out;
>                 }
> +
> +               /*
> +                * We're holding the page lock and removed the page from the
> +                * LRU. Once done copying, we'll unlock and readd to the
> +                * LRU via release_pte_page(). If the page is still in the
> +                * swapcache, we're the exclusive owner. Due to the page lock
> +                * the page cannot be added to the swapcache until we're done
> +                * and consequently it cannot be faulted in from the swapcache
> +                * into another process.
> +                */
>                 mod_node_page_state(page_pgdat(page),
>                                 NR_ISOLATED_ANON + page_is_file_lru(page),
>                                 compound_nr(page));
> --
> 2.34.1
>
