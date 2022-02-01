Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082104A6718
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 22:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiBAVba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 16:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiBAVb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 16:31:28 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C9CC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 13:31:28 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id u24so36925429eds.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 13:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S9lNa69aK/8vUL9n02wvSyCGjVDmqQna9TX/zBr/ys0=;
        b=QrhqksDyHOFRKPb0vfkDGlm+V5uj4BnwW/A7kb1iVUX/M37YdFaGQ2X6pK9W/v1o+a
         Q/jcsrfL9MvI18gSRnUraSNq2NoKdMdcP2sW/yvHe1FupDH5l3p2908nvKja3iO16Z2B
         B8d4bimRbcq9Y+9uJboDNiF2vFKJwHTE3v5Kc6WIP3sKUMSfk4JITDWvrmsY6QCrzquo
         pjc4lBxuTFDZKwdH8TdpK9y362hy6H05dOh6y3kYPigmtbXnRUBkaVxOk686AxMtiTL1
         AQiV7INkC7e6VFb2EvBU/M/A7gVLA3IqvGactZTe7jUUBc9tNXWRiUzJGJb9lAdlG1Hd
         ABfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S9lNa69aK/8vUL9n02wvSyCGjVDmqQna9TX/zBr/ys0=;
        b=Txs8zIKI3vzgTPqJXWpnpjRJAEaT2PUant1+41StOgDnmK1JtvImOpwetJ99qpxGgA
         FV16wDfqtiJEDalMPQNLcCGO/27ZYmiAwHE9d3SiDqld2bS9nxDGutifZ72muMYlD7x9
         qZEZAKFL5ijFwbEG4L2djTKU9UxcFQ9pA1PDMFr3+HR8gVR/pn5SZ7s1SRVww+D8gMKa
         VP4VFZ6ApgYSwlOQc0Nz93NUbaEUwaEaXTT7pMp/iC4JczwcDpxVkrLVdfpxSuoqgxkM
         fMreQv7aid63C7PAX6hB4SalaBNs0m2FpaGXOxvMxyO7+qLOSREegNzZwlNLNhrzW3xy
         nwvQ==
X-Gm-Message-State: AOAM530MW7LGRQ74V5jqHEB/jsoYNDp98VRSPtKbgizzozGq2lv2nDSk
        xRHoXaj7YcsP06/EdZ8n2g3FTT/oeZJcmvFVRgE=
X-Google-Smtp-Source: ABdhPJyP99qXgzmwdrP/3OeAwaj6wWvdxYGmpx/oAUSkJlbw+u9nwLPNf1AlnL0aoF6iq0hV9BTUApeqcqK/Xgpbl1U=
X-Received: by 2002:a50:fd91:: with SMTP id o17mr27530607edt.127.1643751086964;
 Tue, 01 Feb 2022 13:31:26 -0800 (PST)
MIME-Version: 1.0
References: <20220131162940.210846-1-david@redhat.com> <20220131162940.210846-7-david@redhat.com>
In-Reply-To: <20220131162940.210846-7-david@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 1 Feb 2022 13:31:14 -0800
Message-ID: <CAHbLzko4zHdWyZ86cv_gZOyTTg5G5RDqVx2m6eUVW+HYpR3Caw@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] mm/khugepaged: remove reuse_swap_page() usage
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

On Mon, Jan 31, 2022 at 8:33 AM David Hildenbrand <david@redhat.com> wrote:
>
> reuse_swap_page() currently indicates if we can write to an anon page
> without COW. A COW is required if the page is shared by multiple
> processes (either already mapped or via swap entries) or if there is
> concurrent writeback that cannot tolerate concurrent page modifications.
>
> However, in the context of khugepaged we're not actually going to write
> to a read-only mapped page, we'll copy the page content to our newly
> allocated THP and map that THP writable. All we have to make sure
> is that the read-only mapped page we're about to copy won't get reused
> by another process sharing the page, otherwise, page content would
> get modified. But that is already guaranteed via multiple mechanisms
> (e.g., holding a reference, holding the page lock, removing the rmap after
>  copying the page).
>
> The swapcache handling was introduced in commit 10359213d05a ("mm:
> incorporate read-only pages into transparent huge pages") and it sounds
> like it merely wanted to mimic what do_swap_page() would do when trying
> to map a page obtained via the swapcache writable.
>
> As that logic is unnecessary, let's just remove it, removing the last
> user of reuse_swap_page().

Thanks for cleaning this up. I didn't spot anything wrong. You could
add Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/trace/events/huge_memory.h |  1 -
>  mm/khugepaged.c                    | 11 -----------
>  2 files changed, 12 deletions(-)
>
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index 4fdb14a81108..d651f3437367 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -29,7 +29,6 @@
>         EM( SCAN_VMA_NULL,              "vma_null")                     \
>         EM( SCAN_VMA_CHECK,             "vma_check_failed")             \
>         EM( SCAN_ADDRESS_RANGE,         "not_suitable_address_range")   \
> -       EM( SCAN_SWAP_CACHE_PAGE,       "page_swap_cache")              \
>         EM( SCAN_DEL_PAGE_LRU,          "could_not_delete_page_from_lru")\
>         EM( SCAN_ALLOC_HUGE_PAGE_FAIL,  "alloc_huge_page_failed")       \
>         EM( SCAN_CGROUP_CHARGE_FAIL,    "ccgroup_charge_failed")        \
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 35f14d0a00a6..9da9325ab4d4 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -45,7 +45,6 @@ enum scan_result {
>         SCAN_VMA_NULL,
>         SCAN_VMA_CHECK,
>         SCAN_ADDRESS_RANGE,
> -       SCAN_SWAP_CACHE_PAGE,
>         SCAN_DEL_PAGE_LRU,
>         SCAN_ALLOC_HUGE_PAGE_FAIL,
>         SCAN_CGROUP_CHARGE_FAIL,
> @@ -682,16 +681,6 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>                         result = SCAN_PAGE_COUNT;
>                         goto out;
>                 }
> -               if (!pte_write(pteval) && PageSwapCache(page) &&
> -                               !reuse_swap_page(page)) {
> -                       /*
> -                        * Page is in the swap cache and cannot be re-used.
> -                        * It cannot be collapsed into a THP.
> -                        */
> -                       unlock_page(page);
> -                       result = SCAN_SWAP_CACHE_PAGE;
> -                       goto out;
> -               }
>
>                 /*
>                  * Isolate the page to avoid collapsing an hugepage
> --
> 2.34.1
>
