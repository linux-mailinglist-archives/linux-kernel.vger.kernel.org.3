Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43D04C3AF5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbiBYBcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbiBYBcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:32:08 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B28525EBB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:31:36 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id g6so2926898ybe.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pm5OlqNMoBPPLPWK+AwvvZMbTJ1tBSbLkY52q0F+S3s=;
        b=bOlI1N1e1eCyEuqehuh15D0Gvy9b/v1c8b2gf0lYKV1iM3k3Z6JoSe5FjlGKfWXb/2
         NaCdwCt+jOSQaqL4vQSLgfDew5hHTISv6Tw1YYrcs201HsFkh3NcGILcOWQ5G3g+M9Fa
         rjECSe7kLLlqQnimD4Jx5oHgrY/Vsh33TXLtusWOHgyV5JJrNcT4r9MRrIXsID5+lN0U
         YgIFJQZ/WFLmL0mQqkhgKLqBh5l4blEc4KugH/+7+LUqYIlYx19+9z5P/Wib4EM2iMwR
         MYdLKq9/cXjFQNqeC0p0PLk5ttHyex3Ztf60cKD+JFiOqDtFITK+XZ9E6Uo0mRykHKBn
         i1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pm5OlqNMoBPPLPWK+AwvvZMbTJ1tBSbLkY52q0F+S3s=;
        b=iETHlMlx8YgOkOamAmhpgHs23hUR35xrBuIvLeO5WxvxGl9Ru5ETkWVxdvFBnI4jsT
         /q3zBaQNjZcFTmkgONaT7ilFPEzLCjGINet0AvH1hNjnouXIx0doJ2rssKozPEkOvGgx
         74ccPc/j1M8sb992DuOycSiAFj5M6DBe9dg1NhULCaTf9xp0UsOR1T/yktjc74po64vk
         MibvJIg34sl3cgO4Cq/3dLEtsu5iM2ozZpyjoVzNvdrw7B2Won8A+h+AkQD1a8vENQRN
         5dFha/orpEK+VrdYKFcdoK8u5ZsLoDAdbpLnYaebUOHWM/D59DFKm3YE79niqOBVVtRQ
         d/MQ==
X-Gm-Message-State: AOAM531+pJKRzkBHac5aO2Tn1jyt8VIqYkAuAB9eCuME0Cw1nE2BwR+h
        mWggAliO76fuDy5k3XfG3Oet279mmZ0CPe6cpvK3KA==
X-Google-Smtp-Source: ABdhPJxq5UTgxzncAC66DrJulLZMUIXudiXu4IBLN9DiTh43HDSCyrVMnOnXtB5URROdeuNlxLRInLknigMHXy1fXdU=
X-Received: by 2002:a25:2693:0:b0:624:50a8:fee9 with SMTP id
 m141-20020a252693000000b0062450a8fee9mr4975330ybm.348.1645752695454; Thu, 24
 Feb 2022 17:31:35 -0800 (PST)
MIME-Version: 1.0
References: <20220223194812.1299646-1-surenb@google.com> <YhdHd+dXf91FP+K0@dhcp22.suse.cz>
 <CAJuCfpEAb3-WP9ZRnLwMxqa3FPdhESUR_Nhv5TF6njwRKtJoSg@mail.gmail.com>
In-Reply-To: <CAJuCfpEAb3-WP9ZRnLwMxqa3FPdhESUR_Nhv5TF6njwRKtJoSg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 24 Feb 2022 17:31:24 -0800
Message-ID: <CAJuCfpFAUUBLkHfp82fKh1YXpwm36aDFZ8adBTw2tH77x72eng@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] mm: count time in drain_all_pages during direct
 reclaim as memory pressure
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, pmladek@suse.com,
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

On Thu, Feb 24, 2022 at 8:28 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Thu, Feb 24, 2022 at 12:53 AM 'Michal Hocko' via kernel-team
> <kernel-team@android.com> wrote:
> >
> > On Wed 23-02-22 11:48:12, Suren Baghdasaryan wrote:
> > > When page allocation in direct reclaim path fails, the system will
> > > make one attempt to shrink per-cpu page lists and free pages from
> > > high alloc reserves. Draining per-cpu pages into buddy allocator can
> > > be a very slow operation because it's done using workqueues and the
> > > task in direct reclaim waits for all of them to finish before
> > > proceeding. Currently this time is not accounted as psi memory stall.
> > >
> > > While testing mobile devices under extreme memory pressure, when
> > > allocations are failing during direct reclaim, we notices that psi
> > > events which would be expected in such conditions were not triggered.
> > > After profiling these cases it was determined that the reason for
> > > missing psi events was that a big chunk of time spent in direct
> > > reclaim is not accounted as memory stall, therefore psi would not
> > > reach the levels at which an event is generated. Further investigation
> > > revealed that the bulk of that unaccounted time was spent inside
> > > drain_all_pages call.
> > >
> > > A typical captured case when drain_all_pages path gets activated:
> > >
> > > __alloc_pages_slowpath  took 44.644.613ns
> > >     __perform_reclaim   took    751.668ns (1.7%)
> > >     drain_all_pages     took 43.887.167ns (98.3%)
> >
> > Although the draining is done in the slow path these numbers suggest
> > that we should really reconsider the use of WQ both for draining and
> > other purposes (like vmstats).
>
> Yep, I'm testing the kthread_create_worker_on_cpu approach suggested
> by Petr. Will post it later today if nothing regresses.

An RFC for kthreads approach is posted at
https://lore.kernel.org/all/20220225012819.1807147-1-surenb@google.com/

>
> >
> > > PSI in this case records the time spent in __perform_reclaim but
> > > ignores drain_all_pages, IOW it misses 98.3% of the time spent in
> > > __alloc_pages_slowpath.
> > >
> > > Annotate __alloc_pages_direct_reclaim in its entirety so that delays
> > > from handling page allocation failure in the direct reclaim path are
> > > accounted as memory stall.
> > >
> > > Reported-by: Tim Murray <timmurray@google.com>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> >
> > Acked-by: Michal Hocko <mhocko@suse.com>
> >
> > Thanks!
> >
> > > ---
> > > changes in v3:
> > > - Moved psi_memstall_leave after the "out" label
> > >
> > >  mm/page_alloc.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 3589febc6d31..029bceb79861 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -4595,13 +4595,12 @@ __perform_reclaim(gfp_t gfp_mask, unsigned int order,
> > >                                       const struct alloc_context *ac)
> > >  {
> > >       unsigned int noreclaim_flag;
> > > -     unsigned long pflags, progress;
> > > +     unsigned long progress;
> > >
> > >       cond_resched();
> > >
> > >       /* We now go into synchronous reclaim */
> > >       cpuset_memory_pressure_bump();
> > > -     psi_memstall_enter(&pflags);
> > >       fs_reclaim_acquire(gfp_mask);
> > >       noreclaim_flag = memalloc_noreclaim_save();
> > >
> > > @@ -4610,7 +4609,6 @@ __perform_reclaim(gfp_t gfp_mask, unsigned int order,
> > >
> > >       memalloc_noreclaim_restore(noreclaim_flag);
> > >       fs_reclaim_release(gfp_mask);
> > > -     psi_memstall_leave(&pflags);
> > >
> > >       cond_resched();
> > >
> > > @@ -4624,11 +4622,13 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
> > >               unsigned long *did_some_progress)
> > >  {
> > >       struct page *page = NULL;
> > > +     unsigned long pflags;
> > >       bool drained = false;
> > >
> > > +     psi_memstall_enter(&pflags);
> > >       *did_some_progress = __perform_reclaim(gfp_mask, order, ac);
> > >       if (unlikely(!(*did_some_progress)))
> > > -             return NULL;
> > > +             goto out;
> > >
> > >  retry:
> > >       page = get_page_from_freelist(gfp_mask, order, alloc_flags, ac);
> > > @@ -4644,6 +4644,8 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
> > >               drained = true;
> > >               goto retry;
> > >       }
> > > +out:
> > > +     psi_memstall_leave(&pflags);
> > >
> > >       return page;
> > >  }
> > > --
> > > 2.35.1.473.g83b2b277ed-goog
> >
> > --
> > Michal Hocko
> > SUSE Labs
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> >
