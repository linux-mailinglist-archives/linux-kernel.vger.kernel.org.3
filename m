Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099214CFF1C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242539AbiCGMuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236483AbiCGMuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:50:08 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FDE4DF59
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:49:14 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id 9so11404682ily.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 04:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9GrYc8hsnuiqUpUq4p+U6Uj7Nz7C2HLLd3wOJbjr0Os=;
        b=gwPEb1iofufaaDP3mGTRtzhA12iy16bVV5/nLZnmMK8xUaTNKULm0pQZWKMl1y4eXs
         a4u8E1NaUiZKqpSj8Nk1MbNvo4g0z+Wcva5Vfn0s3bA1NlPvjCDdJ2E4f6NXNJFwDjlM
         IIMwXJAUapXRrkg6pdu+HkJ1qOo1KLg8z4LNrQT5gUtzf7Cxr9tGHr/BYesOszyaTmSc
         O2+riaHuD84ew09HmVYfhr0evnKNr+KSvD8vXGB2BEtUwqmYDi0EEFbeSbmo16TB0Yn7
         dxr8xqtOOtBAvWXHn0zxwqCNuIeGq0o5Qlr5e2BcvC2glYmMZu5aKPb0Pg/VUqe3iW9l
         t1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9GrYc8hsnuiqUpUq4p+U6Uj7Nz7C2HLLd3wOJbjr0Os=;
        b=m4kyuSYJLYnYekuQOK/+9hhOnkbXlfK1FxROVRwJzwc8YfdwxZ6r6tWO+ozilfYNYP
         +na/u+0xNoNEYk+x0b8wdK9gGyaH8+Jnx441oS6QFbMc0oDHzmbJXG0VJZkkCIZs3OrX
         gx8N3EuUvfDwL8dDRfxqx6mN7dbB6ZPj+O7NFaVnIYuy3NMRs7FP9q0nRCuC7DMmxBKZ
         0wf18PfOE8+0ZDlPw5pQX2mWOtWU/j+ehJKLN9GFnirKrrqFrjK/AqG1te+DMMgY/4fQ
         F1Dt4kP/2KMd2NaiURs/kZj4dlLVUGZE7O0dXi7V3NLad4FoSBERk5d521nIoKS0Cz6r
         rdEw==
X-Gm-Message-State: AOAM533S9IKqsP8M+5sUtlX0Ok3NbDTyFR6EfJsOybmBNxBs8PMHvx0Z
        aXEYz4g3NHfV4siYv4QPLu+tBnJSmfC4A5G0iO0=
X-Google-Smtp-Source: ABdhPJx9l9kHH+2i3yRdwQEw3b9hTIzyWQ1Gh0PiEvC+bQuWZgcDJTSUVSeK3mE/dPcLUfkaBzUred/MtQN9iriE6Vs=
X-Received: by 2002:a05:6e02:20e8:b0:2c1:e164:76e6 with SMTP id
 q8-20020a056e0220e800b002c1e16476e6mr11313553ilv.135.1646657353300; Mon, 07
 Mar 2022 04:49:13 -0800 (PST)
MIME-Version: 1.0
References: <879d62a8-91cc-d3c6-fb3b-69768236df68@google.com>
In-Reply-To: <879d62a8-91cc-d3c6-fb3b-69768236df68@google.com>
From:   Alex Shi <seakeel@gmail.com>
Date:   Mon, 7 Mar 2022 20:48:37 +0800
Message-ID: <CAJy-AmkrObF7O7CFH=9CirADEwNXTfBFpgzB8BA4JAi4J6XjhQ@mail.gmail.com>
Subject: Re: [PATCH mmotm] mm: __isolate_lru_page_prepare() in isolate_migratepages_block()
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alexs@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 5, 2022 at 1:01 PM Hugh Dickins <hughd@google.com> wrote:
>
> __isolate_lru_page_prepare() conflates two unrelated functions, with
> the flags to one disjoint from the flags to the other; and hides some
> of the important checks outside of isolate_migratepages_block(), where
> the sequence is better to be visible.  It comes from the days of lumpy
> reclaim, before compaction, when the combination made more sense.
>
> Move what's needed by mm/compaction.c isolate_migratepages_block() inline
> there, and what's needed by mm/vmscan.c isolate_lru_pages() inline there.
>
> Shorten "isolate_mode" to "mode", so the sequence of conditions is easier
> to read.  Declare a "mapping" variable, to save one call to page_mapping()
> (but not another: calling again after page is locked is necessary).
> Simplify isolate_lru_pages() with a "move_to" list pointer.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Alex Shi <alexs@kernel.org>

> ---
>
>  include/linux/swap.h |   1 -
>  mm/compaction.c      |  51 ++++++++++++++++++++++----
>  mm/vmscan.c          | 101 +++++++++------------------------------------------
>  3 files changed, 62 insertions(+), 91 deletions(-)
>
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -386,7 +386,6 @@ extern void lru_cache_add_inactive_or_unevictable(struct page *page,
>  extern unsigned long zone_reclaimable_pages(struct zone *zone);
>  extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>                                         gfp_t gfp_mask, nodemask_t *mask);
> -extern bool __isolate_lru_page_prepare(struct page *page, isolate_mode_t mode);
>  extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>                                                   unsigned long nr_pages,
>                                                   gfp_t gfp_mask,
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -785,7 +785,7 @@ static bool too_many_isolated(pg_data_t *pgdat)
>   * @cc:                Compaction control structure.
>   * @low_pfn:   The first PFN to isolate
>   * @end_pfn:   The one-past-the-last PFN to isolate, within same pageblock
> - * @isolate_mode: Isolation mode to be used.
> + * @mode:      Isolation mode to be used.
>   *
>   * Isolate all pages that can be migrated from the range specified by
>   * [low_pfn, end_pfn). The range is expected to be within same pageblock.
> @@ -798,7 +798,7 @@ static bool too_many_isolated(pg_data_t *pgdat)
>   */
>  static int
>  isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
> -                       unsigned long end_pfn, isolate_mode_t isolate_mode)
> +                       unsigned long end_pfn, isolate_mode_t mode)
>  {
>         pg_data_t *pgdat = cc->zone->zone_pgdat;
>         unsigned long nr_scanned = 0, nr_isolated = 0;
> @@ -806,6 +806,7 @@ static bool too_many_isolated(pg_data_t *pgdat)
>         unsigned long flags = 0;
>         struct lruvec *locked = NULL;
>         struct page *page = NULL, *valid_page = NULL;
> +       struct address_space *mapping;
>         unsigned long start_pfn = low_pfn;
>         bool skip_on_failure = false;
>         unsigned long next_skip_pfn = 0;
> @@ -990,7 +991,7 @@ static bool too_many_isolated(pg_data_t *pgdat)
>                                         locked = NULL;
>                                 }
>
> -                               if (!isolate_movable_page(page, isolate_mode))
> +                               if (!isolate_movable_page(page, mode))
>                                         goto isolate_success;
>                         }
>
> @@ -1002,15 +1003,15 @@ static bool too_many_isolated(pg_data_t *pgdat)
>                  * so avoid taking lru_lock and isolating it unnecessarily in an
>                  * admittedly racy check.
>                  */
> -               if (!page_mapping(page) &&
> -                   page_count(page) > page_mapcount(page))
> +               mapping = page_mapping(page);
> +               if (!mapping && page_count(page) > page_mapcount(page))
>                         goto isolate_fail;
>
>                 /*
>                  * Only allow to migrate anonymous pages in GFP_NOFS context
>                  * because those do not depend on fs locks.
>                  */
> -               if (!(cc->gfp_mask & __GFP_FS) && page_mapping(page))
> +               if (!(cc->gfp_mask & __GFP_FS) && mapping)
>                         goto isolate_fail;
>
>                 /*
> @@ -1021,9 +1022,45 @@ static bool too_many_isolated(pg_data_t *pgdat)
>                 if (unlikely(!get_page_unless_zero(page)))
>                         goto isolate_fail;
>
> -               if (!__isolate_lru_page_prepare(page, isolate_mode))
> +               /* Only take pages on LRU: a check now makes later tests safe */
> +               if (!PageLRU(page))
> +                       goto isolate_fail_put;
> +
> +               /* Compaction might skip unevictable pages but CMA takes them */
> +               if (!(mode & ISOLATE_UNEVICTABLE) && PageUnevictable(page))
> +                       goto isolate_fail_put;
> +
> +               /*
> +                * To minimise LRU disruption, the caller can indicate with
> +                * ISOLATE_ASYNC_MIGRATE that it only wants to isolate pages
> +                * it will be able to migrate without blocking - clean pages
> +                * for the most part.  PageWriteback would require blocking.
> +                */
> +               if ((mode & ISOLATE_ASYNC_MIGRATE) && PageWriteback(page))
>                         goto isolate_fail_put;
>
> +               if ((mode & ISOLATE_ASYNC_MIGRATE) && PageDirty(page)) {
> +                       bool migrate_dirty;
> +
> +                       /*
> +                        * Only pages without mappings or that have a
> +                        * ->migratepage callback are possible to migrate
> +                        * without blocking. However, we can be racing with
> +                        * truncation so it's necessary to lock the page
> +                        * to stabilise the mapping as truncation holds
> +                        * the page lock until after the page is removed
> +                        * from the page cache.
> +                        */
> +                       if (!trylock_page(page))
> +                               goto isolate_fail_put;
> +
> +                       mapping = page_mapping(page);
> +                       migrate_dirty = !mapping || mapping->a_ops->migratepage;
> +                       unlock_page(page);
> +                       if (!migrate_dirty)
> +                               goto isolate_fail_put;
> +               }
> +
>                 /* Try isolate the page */
>                 if (!TestClearPageLRU(page))
>                         goto isolate_fail_put;
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2009,69 +2009,6 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  }
>
>  /*
> - * Attempt to remove the specified page from its LRU.  Only take this page
> - * if it is of the appropriate PageActive status.  Pages which are being
> - * freed elsewhere are also ignored.
> - *
> - * page:       page to consider
> - * mode:       one of the LRU isolation modes defined above
> - *
> - * returns true on success, false on failure.
> - */
> -bool __isolate_lru_page_prepare(struct page *page, isolate_mode_t mode)
> -{
> -       /* Only take pages on the LRU. */
> -       if (!PageLRU(page))
> -               return false;
> -
> -       /* Compaction should not handle unevictable pages but CMA can do so */
> -       if (PageUnevictable(page) && !(mode & ISOLATE_UNEVICTABLE))
> -               return false;
> -
> -       /*
> -        * To minimise LRU disruption, the caller can indicate that it only
> -        * wants to isolate pages it will be able to operate on without
> -        * blocking - clean pages for the most part.
> -        *
> -        * ISOLATE_ASYNC_MIGRATE is used to indicate that it only wants to pages
> -        * that it is possible to migrate without blocking
> -        */
> -       if (mode & ISOLATE_ASYNC_MIGRATE) {
> -               /* All the caller can do on PageWriteback is block */
> -               if (PageWriteback(page))
> -                       return false;
> -
> -               if (PageDirty(page)) {
> -                       struct address_space *mapping;
> -                       bool migrate_dirty;
> -
> -                       /*
> -                        * Only pages without mappings or that have a
> -                        * ->migratepage callback are possible to migrate
> -                        * without blocking. However, we can be racing with
> -                        * truncation so it's necessary to lock the page
> -                        * to stabilise the mapping as truncation holds
> -                        * the page lock until after the page is removed
> -                        * from the page cache.
> -                        */
> -                       if (!trylock_page(page))
> -                               return false;
> -
> -                       mapping = page_mapping(page);
> -                       migrate_dirty = !mapping || mapping->a_ops->migratepage;
> -                       unlock_page(page);
> -                       if (!migrate_dirty)
> -                               return false;
> -               }
> -       }
> -
> -       if ((mode & ISOLATE_UNMAPPED) && page_mapped(page))
> -               return false;
> -
> -       return true;
> -}
> -
> -/*
>   * Update LRU sizes after isolating pages. The LRU size updates must
>   * be complete before mem_cgroup_update_lru_size due to a sanity check.
>   */
> @@ -2122,11 +2059,11 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
>         unsigned long skipped = 0;
>         unsigned long scan, total_scan, nr_pages;
>         LIST_HEAD(pages_skipped);
> -       isolate_mode_t mode = (sc->may_unmap ? 0 : ISOLATE_UNMAPPED);
>
>         total_scan = 0;
>         scan = 0;
>         while (scan < nr_to_scan && !list_empty(src)) {
> +               struct list_head *move_to = src;
>                 struct page *page;
>
>                 page = lru_to_page(src);
> @@ -2136,9 +2073,9 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
>                 total_scan += nr_pages;
>
>                 if (page_zonenum(page) > sc->reclaim_idx) {
> -                       list_move(&page->lru, &pages_skipped);
>                         nr_skipped[page_zonenum(page)] += nr_pages;
> -                       continue;
> +                       move_to = &pages_skipped;
> +                       goto move;
>                 }
>
>                 /*
> @@ -2146,37 +2083,34 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
>                  * return with no isolated pages if the LRU mostly contains
>                  * ineligible pages.  This causes the VM to not reclaim any
>                  * pages, triggering a premature OOM.
> -                *
> -                * Account all tail pages of THP.  This would not cause
> -                * premature OOM since __isolate_lru_page() returns -EBUSY
> -                * only when the page is being freed somewhere else.
> +                * Account all tail pages of THP.
>                  */
>                 scan += nr_pages;
> -               if (!__isolate_lru_page_prepare(page, mode)) {
> -                       /* It is being freed elsewhere */
> -                       list_move(&page->lru, src);
> -                       continue;
> -               }
> +
> +               if (!PageLRU(page))
> +                       goto move;
> +               if (!sc->may_unmap && page_mapped(page))
> +                       goto move;
> +
>                 /*
>                  * Be careful not to clear PageLRU until after we're
>                  * sure the page is not being freed elsewhere -- the
>                  * page release code relies on it.
>                  */
> -               if (unlikely(!get_page_unless_zero(page))) {
> -                       list_move(&page->lru, src);
> -                       continue;
> -               }
> +               if (unlikely(!get_page_unless_zero(page)))
> +                       goto move;
>
>                 if (!TestClearPageLRU(page)) {
>                         /* Another thread is already isolating this page */
>                         put_page(page);
> -                       list_move(&page->lru, src);
> -                       continue;
> +                       goto move;
>                 }
>
>                 nr_taken += nr_pages;
>                 nr_zone_taken[page_zonenum(page)] += nr_pages;
> -               list_move(&page->lru, dst);
> +               move_to = dst;
> +move:
> +               list_move(&page->lru, move_to);
>         }
>
>         /*
> @@ -2200,7 +2134,8 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
>         }
>         *nr_scanned = total_scan;
>         trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, nr_to_scan,
> -                                   total_scan, skipped, nr_taken, mode, lru);
> +                                   total_scan, skipped, nr_taken,
> +                                   sc->may_unmap ? 0 : ISOLATE_UNMAPPED, lru);
>         update_lru_sizes(lruvec, lru, nr_zone_taken);
>         return nr_taken;
>  }
