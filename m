Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD2B4C3142
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiBXQ31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiBXQ3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:29:22 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B66198EE1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 08:28:50 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2d646fffcc2so3481407b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 08:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bluFR6fvvQhB6H6hwiDoTR3wKkQfMctdO4frcI1wEKA=;
        b=c80cR3l+ItVFxWSro6ydAMDG+tMJYBXmM/LUuf54rg+irlLzimuC/kKw7/ykBgdLKe
         knqsI+x26Pn/N1J9OEKFvL6NkfCfAet72V1SJRwHaJAJguK5klQrhLBLqyGASmfweMSy
         KOSx6YIhi59ViHoOmmyVekYzvbMC7kC7Fhk445FnIihwur7uZ1gUaHnpbLmbYtRH/6hI
         ctxOWQnF829khBaWLNyr86qOUGRtJLeBUw40Q2fPBHbori3TGzG7sbOTBaRfKWclM55G
         MH9lRTxt7Ror5bE9nWBBHctuPTlttRVq/QMoK+jJWlf5VYmTF+j7XAN8N06E55SVJRVA
         aQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bluFR6fvvQhB6H6hwiDoTR3wKkQfMctdO4frcI1wEKA=;
        b=hA41Pb8tpc3JfWl1Og1/KJZc/Sn4uUAMBPWOfvCHyJbMNFyEsCfXIdfWl65n35yNYD
         AjArnl5zhqld4XwnQffgah0r5SUxVJ2+1vy4dXqjaBZKKPH1Ov7+E957VwtvGjJ9tF/U
         /3zv0N0kkFldlMl5c1USnDbEOfkPkxmsBL9R6n86wxH40sO5a3/o84s2VqgjUV2lvtYy
         fAGoPqhH12JqKPEDRZVNwSCOqSXvDF3Jt/kxM/SaN8l73HQf3oYSTRhyQWgwZL5qGjB/
         anB/t+6iCDVqjPIFo4YZdmgS7vTcmYoNGU/wPHBrR+AXtdMAjUzvXCVswvoXDC3xPtz5
         z19A==
X-Gm-Message-State: AOAM530dBoY9PmFr15Y4rwAHBinBmECEUJv4sIsEq0F+pN4CoS0XJxub
        0mXb4GYVqm7V6s4qTjsEAIzg/ibq3Nom/k1znnx7d5JMYgL8XrHR
X-Google-Smtp-Source: ABdhPJxEyA2aqiuxyk1yiOCOVwy83TKAjG97/lB4b391E3MqmPe1r95/XVECYUnh1y1tntDGknkE0qxeeg+v1xFL/j0=
X-Received: by 2002:a81:5fc3:0:b0:2d7:ab5d:1dd8 with SMTP id
 t186-20020a815fc3000000b002d7ab5d1dd8mr3201917ywb.514.1645720129543; Thu, 24
 Feb 2022 08:28:49 -0800 (PST)
MIME-Version: 1.0
References: <20220223194812.1299646-1-surenb@google.com> <YhdHd+dXf91FP+K0@dhcp22.suse.cz>
In-Reply-To: <YhdHd+dXf91FP+K0@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 24 Feb 2022 08:28:38 -0800
Message-ID: <CAJuCfpEAb3-WP9ZRnLwMxqa3FPdhESUR_Nhv5TF6njwRKtJoSg@mail.gmail.com>
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

On Thu, Feb 24, 2022 at 12:53 AM 'Michal Hocko' via kernel-team
<kernel-team@android.com> wrote:
>
> On Wed 23-02-22 11:48:12, Suren Baghdasaryan wrote:
> > When page allocation in direct reclaim path fails, the system will
> > make one attempt to shrink per-cpu page lists and free pages from
> > high alloc reserves. Draining per-cpu pages into buddy allocator can
> > be a very slow operation because it's done using workqueues and the
> > task in direct reclaim waits for all of them to finish before
> > proceeding. Currently this time is not accounted as psi memory stall.
> >
> > While testing mobile devices under extreme memory pressure, when
> > allocations are failing during direct reclaim, we notices that psi
> > events which would be expected in such conditions were not triggered.
> > After profiling these cases it was determined that the reason for
> > missing psi events was that a big chunk of time spent in direct
> > reclaim is not accounted as memory stall, therefore psi would not
> > reach the levels at which an event is generated. Further investigation
> > revealed that the bulk of that unaccounted time was spent inside
> > drain_all_pages call.
> >
> > A typical captured case when drain_all_pages path gets activated:
> >
> > __alloc_pages_slowpath  took 44.644.613ns
> >     __perform_reclaim   took    751.668ns (1.7%)
> >     drain_all_pages     took 43.887.167ns (98.3%)
>
> Although the draining is done in the slow path these numbers suggest
> that we should really reconsider the use of WQ both for draining and
> other purposes (like vmstats).

Yep, I'm testing the kthread_create_worker_on_cpu approach suggested
by Petr. Will post it later today if nothing regresses.

>
> > PSI in this case records the time spent in __perform_reclaim but
> > ignores drain_all_pages, IOW it misses 98.3% of the time spent in
> > __alloc_pages_slowpath.
> >
> > Annotate __alloc_pages_direct_reclaim in its entirety so that delays
> > from handling page allocation failure in the direct reclaim path are
> > accounted as memory stall.
> >
> > Reported-by: Tim Murray <timmurray@google.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> Thanks!
>
> > ---
> > changes in v3:
> > - Moved psi_memstall_leave after the "out" label
> >
> >  mm/page_alloc.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 3589febc6d31..029bceb79861 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -4595,13 +4595,12 @@ __perform_reclaim(gfp_t gfp_mask, unsigned int order,
> >                                       const struct alloc_context *ac)
> >  {
> >       unsigned int noreclaim_flag;
> > -     unsigned long pflags, progress;
> > +     unsigned long progress;
> >
> >       cond_resched();
> >
> >       /* We now go into synchronous reclaim */
> >       cpuset_memory_pressure_bump();
> > -     psi_memstall_enter(&pflags);
> >       fs_reclaim_acquire(gfp_mask);
> >       noreclaim_flag = memalloc_noreclaim_save();
> >
> > @@ -4610,7 +4609,6 @@ __perform_reclaim(gfp_t gfp_mask, unsigned int order,
> >
> >       memalloc_noreclaim_restore(noreclaim_flag);
> >       fs_reclaim_release(gfp_mask);
> > -     psi_memstall_leave(&pflags);
> >
> >       cond_resched();
> >
> > @@ -4624,11 +4622,13 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
> >               unsigned long *did_some_progress)
> >  {
> >       struct page *page = NULL;
> > +     unsigned long pflags;
> >       bool drained = false;
> >
> > +     psi_memstall_enter(&pflags);
> >       *did_some_progress = __perform_reclaim(gfp_mask, order, ac);
> >       if (unlikely(!(*did_some_progress)))
> > -             return NULL;
> > +             goto out;
> >
> >  retry:
> >       page = get_page_from_freelist(gfp_mask, order, alloc_flags, ac);
> > @@ -4644,6 +4644,8 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
> >               drained = true;
> >               goto retry;
> >       }
> > +out:
> > +     psi_memstall_leave(&pflags);
> >
> >       return page;
> >  }
> > --
> > 2.35.1.473.g83b2b277ed-goog
>
> --
> Michal Hocko
> SUSE Labs
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
