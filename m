Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39D94C1C6E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244168AbiBWTnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbiBWTnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:43:50 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CB34B1EC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:43:22 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id v186so50267464ybg.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=54/HvN726MqlsO96lMqmuncnL9Vx07+xIyR2b+fR3E4=;
        b=idFqy/xi+TvmjfT97O7inoduMChq7SC1fgF33ncJ50t98jHo5FawhJS6mMzdk2uynV
         xttWSREB3IWif7VVM95t1+Ydu4dO8MRhBdilJBDbsY2oIaUWT9iVd/b6wLcpdDrhq+ms
         AM0CKs9Nh1aSSTjOPL0fU7zOJW/O+7jIU0bMrG7mcl62ydAIfNRGGrNka/V3Jqg9IEKs
         m4B3uQHRDs846Y469RIZkV/6kaV+3DuYC5qCUFLnQy3Dy6KdC/r54DYX0W63lstgu3xz
         suOfMrBlcm1T1QARcV1X1atZecFuJCRSVU38+OLR7bdzzwVYeHsFOkpp9nsafE7R4cQF
         d33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=54/HvN726MqlsO96lMqmuncnL9Vx07+xIyR2b+fR3E4=;
        b=8GuV3fjewDsFx48nNes7B4ROV6tH/2YjlhGXOlHyN1Ixap8QbFEBw/EMH2ksg4gWBP
         PLQ9ar4tOoRtdaq3cN7FWZkKg9GDtczsOEz7h/JUuYUE/9YPsl5MV8OF+ye/yPFjIOqe
         PBlnC/+a6QFds3GKOF0ThibLpz0kJxEtTLACwYyYEs/rF3+EymZpAEb95oXkYfb//G9t
         wbrHacJcXGuH3nxJ73hIiRMlez5t42XzCkgr3QiyEm1g7H4GOZsmilZAYy7ZFpjscsoV
         YWN1G0P6tDNqb/+Pf3BADYaF24KYwyFGDbAwmrUBsWNXjFx1VAmhYdtkP8p6j1m/S7Ay
         quWQ==
X-Gm-Message-State: AOAM5329e+wyMPWPK76pwZfFHscXdgDWhwxuKb59ITfDyKglTnFj3jkB
        KQdsGX5Xn9L7s7QXXknEzFXql0kAUoU82cABbvHDxQ==
X-Google-Smtp-Source: ABdhPJxXoRWS8X+v/OApN513fsdXy5xIoRE2m6FSI7EuUKMpgwxXNlDcmngcr37rxM4DzMMuBTydk7yfJInMTgWbo2E=
X-Received: by 2002:a25:d986:0:b0:624:ddc:ff9 with SMTP id q128-20020a25d986000000b006240ddc0ff9mr1103775ybg.509.1645645401836;
 Wed, 23 Feb 2022 11:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20220223194018.1296629-1-surenb@google.com>
In-Reply-To: <20220223194018.1296629-1-surenb@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 23 Feb 2022 11:43:10 -0800
Message-ID: <CAJuCfpEpvndCEh5xiCGTLJGsjB4mA7xzFQcU9EBWtPAezyu3tw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: count time in drain_all_pages during direct
 reclaim as memory pressure
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, mhocko@suse.com, pmladek@suse.com,
        peterz@infradead.org, guro@fb.com, shakeelb@google.com,
        minchan@kernel.org, timmurray@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 11:40 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> When page allocation in direct reclaim path fails, the system will
> make one attempt to shrink per-cpu page lists and free pages from
> high alloc reserves. Draining per-cpu pages into buddy allocator can
> be a very slow operation because it's done using workqueues and the
> task in direct reclaim waits for all of them to finish before
> proceeding. Currently this time is not accounted as psi memory stall.
>
> While testing mobile devices under extreme memory pressure, when
> allocations are failing during direct reclaim, we notices that psi
> events which would be expected in such conditions were not triggered.
> After profiling these cases it was determined that the reason for
> missing psi events was that a big chunk of time spent in direct
> reclaim is not accounted as memory stall, therefore psi would not
> reach the levels at which an event is generated. Further investigation
> revealed that the bulk of that unaccounted time was spent inside
> drain_all_pages call.
>
> A typical captured case when drain_all_pages path gets activated:
>
> __alloc_pages_slowpath  took 44.644.613ns
>     __perform_reclaim   took    751.668ns (1.7%)
>     drain_all_pages     took 43.887.167ns (98.3%)
>
> PSI in this case records the time spent in __perform_reclaim but
> ignores drain_all_pages, IOW it misses 98.3% of the time spent in
> __alloc_pages_slowpath.
>
> Annotate __alloc_pages_direct_reclaim in its entirety so that delays
> from handling page allocation failure in the direct reclaim path are
> accounted as memory stall.
>
> Reported-by: Tim Murray <timmurray@google.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
> changes in v2:
> - Added captured sample case to show the delay numbers, per Michal Hocko
> - Moved annotation from __perform_reclaim into __alloc_pages_direct_reclaim,
> per Minchan Kim
>
>  mm/page_alloc.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3589febc6d31..2e9fbf28938f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4595,13 +4595,12 @@ __perform_reclaim(gfp_t gfp_mask, unsigned int order,
>                                         const struct alloc_context *ac)
>  {
>         unsigned int noreclaim_flag;
> -       unsigned long pflags, progress;
> +       unsigned long progress;
>
>         cond_resched();
>
>         /* We now go into synchronous reclaim */
>         cpuset_memory_pressure_bump();
> -       psi_memstall_enter(&pflags);
>         fs_reclaim_acquire(gfp_mask);
>         noreclaim_flag = memalloc_noreclaim_save();
>
> @@ -4610,7 +4609,6 @@ __perform_reclaim(gfp_t gfp_mask, unsigned int order,
>
>         memalloc_noreclaim_restore(noreclaim_flag);
>         fs_reclaim_release(gfp_mask);
> -       psi_memstall_leave(&pflags);
>
>         cond_resched();
>
> @@ -4624,11 +4622,13 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
>                 unsigned long *did_some_progress)
>  {
>         struct page *page = NULL;
> +       unsigned long pflags;
>         bool drained = false;
>
> +       psi_memstall_enter(&pflags);
>         *did_some_progress = __perform_reclaim(gfp_mask, order, ac);
>         if (unlikely(!(*did_some_progress)))
> -               return NULL;
> +               goto out;
>
>  retry:
>         page = get_page_from_freelist(gfp_mask, order, alloc_flags, ac);
> @@ -4644,7 +4644,8 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
>                 drained = true;
>                 goto retry;
>         }
> -
> +       psi_memstall_leave(&pflags);

Oh, psi_memstall_leave should have been *after* the "out" label. Will
fix and repost.

> +out:
>         return page;
>  }
>
> --
> 2.35.1.473.g83b2b277ed-goog
>
