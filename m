Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3FE49D38A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 21:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiAZUgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 15:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiAZUgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:36:17 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD2FC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 12:36:17 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id c24so821819edy.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 12:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wHSZGcqASjvkDHfsWnxtZXfgdyFpTFjH+EicTP6DUw0=;
        b=A1glERp8hCYBWE0s6Te6kySPMXGfZTwbtiiz/dCOcPbUse+bVmCxGmO4uUTeZd8knA
         H2yxCCBdKS3zQpXpvS/87lgCI+WV/PNj8cBYIwQwrkgBHtMOd5M148yu51TuuHBzZ/Vg
         VIFu5s+0RUbBhbQDZHU4DwQe9XC9QU6NnKugmw2mV+R+Fnl+9Q+668FpCFjnGilMYEAz
         kPl384LKwJmW/sVXQDzzJftBLxl30IEzGCYMsPCHQv02Cql+xoXrQ3KMtroJu79sqUGt
         8kS96HN66s/g/Dl3IgrFaMw2GoKwflqumvPjALvV54g2jcpLLVPH1F+Jj7razSbPCqkQ
         80Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wHSZGcqASjvkDHfsWnxtZXfgdyFpTFjH+EicTP6DUw0=;
        b=ZTd9XHoUpD3UNvM5hqkjbn+VVKF5342Vs8SeJfklnGrXy/jiBIif5b8qmi6Tjz3APJ
         CC/kkZXjIREdTFCPUpq/z8BHuGfYFgvgL/1ukm44M9B0i7Nxr40D0H1EivWATL4VjGIV
         r6Apyi9ctU+UwbqkSc5HLNE+cwJ7PtVmprju4H5w9ceUobywaRarA4dgh2VDcoc8Omp5
         zkX3W+B1QZKoMIYP5No/d62RsdWEVB5c9VH9NwQsPI+OJL1IXVZiYv3xq6Yuez+sI5y9
         2S95MAlCUHUC3rAvf0lV6q3xw/r+PB33b5i1mUfwaNy8mWcUe3g6NwZtxlkK9R9OAQ4D
         gMuQ==
X-Gm-Message-State: AOAM533lXbQDfVwOkEYgq6EAOVsC5xxNomyvl9+e+hNs/5D2DdORqyHy
        tZ9/IqszIGoDBWYUxcoJXwUukT7MB01NIJCf7H8=
X-Google-Smtp-Source: ABdhPJymQFRnl1th966BHdwXeL7L1vz9+yol/C1udrCqwHSfpfpXGUAZ6980aKl2ej25WDZZ5uBbh89MkQ1nnNVaJnw=
X-Received: by 2002:aa7:df16:: with SMTP id c22mr658273edy.177.1643229375413;
 Wed, 26 Jan 2022 12:36:15 -0800 (PST)
MIME-Version: 1.0
References: <20220126095557.32392-1-david@redhat.com> <20220126095557.32392-6-david@redhat.com>
In-Reply-To: <20220126095557.32392-6-david@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 26 Jan 2022 12:36:03 -0800
Message-ID: <CAHbLzkqmxSTkh4WOQr8xzzMO94Gr8GuqH8Vn4T5q8rW7gkabYQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/9] mm/huge_memory: streamline COW logic in do_huge_pmd_wp_page()
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
> We currently have a different COW logic for anon THP than we have for
> ordinary anon pages in do_wp_page(): the effect is that the issue reported
> in CVE-2020-29374 is currently still possible for anon THP: an unintended
> information leak from the parent to the child.
>
> Let's apply the same logic (page_count() == 1), with similar
> optimizations to remove additional references first as we really want to
> avoid PTE-mapping the THP and copying individual pages best we can.
>
> If we end up with a page that has page_count() != 1, we'll have to PTE-map
> the THP and fallback to do_wp_page(), which will always copy the page.
>
> Note that KSM does not apply to THP.
>
> I. Interaction with the swapcache and writeback
>
> While a THP is in the swapcache, the swapcache holds one reference on each
> subpage of the THP. So with PageSwapCache() set, we expect as many
> additional references as we have subpages. If we manage to remove the
> THP from the swapcache, all these references will be gone.
>
> Usually, a THP is not split when entered into the swapcache and stays a
> compound page. However, try_to_unmap() will PTE-map the THP and use PTE
> swap entries. There are no PMD swap entries for that purpose, consequently,
> we always only swapin subpages into PTEs.
>
> Removing a page from the swapcache can fail either when there are remaining
> swap entries (in which case COW is the right thing to do) or if the page is
> currently under writeback.
>
> Having a locked, R/O PMD-mapped THP that is in the swapcache seems to be
> possible only in corner cases, for example, if try_to_unmap() failed
> after adding the page to the swapcache. However, it's comparatively easy to
> handle.
>
> As we have to fully unmap a THP before starting writeback, and swapin is
> always done on the PTE level, we shouldn't find a R/O PMD-mapped THP in the
> swapcache that is under writeback. This should at least leave writeback
> out of the picture.
>
> II. Interaction with GUP references
>
> Having a R/O PMD-mapped THP with GUP references (i.e., R/O references)
> will result in PTE-mapping the THP on a write fault. Similar to ordinary
> anon pages, do_wp_page() will have to copy sub-pages and result in a
> disconnect between the GUP references and the pages actually mapped into
> the page tables. To improve the situation in the future, we'll need
> additional handling to mark anonymous pages as definitely exclusive to a
> single process, only allow GUP pins on exclusive anon pages, and
> disallow sharing of exclusive anon pages with GUP pins e.g., during
> fork().
>
> III. Interaction with references from LRU pagevecs
>
> Similar to ordinary anon pages, we can have LRU pagevecs referencing our
> THP. Reliably removing such references requires draining LRU pagevecs on
> all CPUs -- lru_add_drain_all() -- a possibly expensive operation that can
> sleep. For now, similar do do_wp_page(), let's conditionally drain the
> local LRU pagevecs only if we detect !PageLRU().
>
> IV. Interaction with speculative/temporary references
>
> Similar to ordinary anon pages, other speculative/temporary references on
> the THP, for example, from the pagecache or page migration code, will
> disallow exclusive reuse of the page. We'll have to PTE-map the THP.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/huge_memory.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 406a3c28c026..b6ba88a98266 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1286,6 +1286,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
>         struct page *page;
>         unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>         pmd_t orig_pmd = vmf->orig_pmd;
> +       int swapcache_refs = 0;
>
>         vmf->ptl = pmd_lockptr(vma->vm_mm, vmf->pmd);
>         VM_BUG_ON_VMA(!vma->anon_vma, vma);
> @@ -1303,7 +1304,6 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
>         page = pmd_page(orig_pmd);
>         VM_BUG_ON_PAGE(!PageHead(page), page);
>
> -       /* Lock page for reuse_swap_page() */
>         if (!trylock_page(page)) {
>                 get_page(page);
>                 spin_unlock(vmf->ptl);
> @@ -1319,10 +1319,20 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
>         }
>
>         /*
> -        * We can only reuse the page if nobody else maps the huge page or it's
> -        * part.
> +        * See do_wp_page(): we can only map the page writable if there are
> +        * no additional references.
>          */
> -       if (reuse_swap_page(page)) {
> +       if (PageSwapCache(page))
> +               swapcache_refs = thp_nr_pages(page);
> +       if (page_count(page) > 1 + swapcache_refs + !PageLRU(page))
> +               goto unlock_fallback;
> +       if (!PageLRU(page))
> +               lru_add_drain();

IMHO, draining lru doesn't help out too much for THP since THP will be
drained to LRU immediately once it is added into pagevec.

> +       if (page_count(page) > 1 + swapcache_refs)
> +               goto unlock_fallback;
> +       if (swapcache_refs)
> +               try_to_free_swap(page);
> +       if (page_count(page) == 1) {
>                 pmd_t entry;
>                 entry = pmd_mkyoung(orig_pmd);
>                 entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
> @@ -1333,6 +1343,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
>                 return VM_FAULT_WRITE;
>         }
>
> +unlock_fallback:
>         unlock_page(page);
>         spin_unlock(vmf->ptl);
>  fallback:
> --
> 2.34.1
>
