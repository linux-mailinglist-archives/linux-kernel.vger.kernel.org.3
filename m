Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C6B4C1B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 19:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244035AbiBWSz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 13:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiBWSz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 13:55:27 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF7C3ED16
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 10:54:59 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id x3so10115017qvd.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 10:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fK7FpqspG7jF5jtxh0YvYWB/hUstBu9iQdJkK5fSXHU=;
        b=YhQ1GZV818HFnqsC6KhMrbhbpSiJ/BaWSfoeVKso9Ev25O2AsceHCn4UhtrQQJpKdc
         O3/GQq7cM0tHeud+hWzJvxAMc8C0Jxavyt4AGrUfCfLhHxkBJuolMHDMF+O3hpCYo79p
         kCf6jPXR76CyYhhWOMBWxiV+ArjmpVhYge2P9lWDKPLwpD6EqGrYkiGRPzBmXDg/LRv+
         l/VRqcDFWSK9vBoB6/ta+iBnaoZ2KJuvbQa8sCCnng0e1Hq3Cy3ZX4CdUZQ9HKIcNsTq
         24KMf/1fIH4O7/aNNSt4jXdHlRqS4FprN/fq+hb34YMku8fKuVC0GWiQjDsJUvbZNWPp
         UyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fK7FpqspG7jF5jtxh0YvYWB/hUstBu9iQdJkK5fSXHU=;
        b=INAKR9FvGX6QQYWZ7d6uyF28h/CK77nnBdyuOvGIJkb/jpsu1PhXjIoCHqpUziZbH9
         jyBjn/2eTaO5bF7bC6NY1qTq1O73C5ORAR5+tLDGRHhweah3gOtT9K3FDVtrbpQ2gncx
         wkHqjDL/BhPcm2crZ8QYMNpHVUL0ocpfQRDNiDKlhQtgwJOJTzbGkGnfEV9dHsgt4L3X
         9mOygxvO6AGt4vxGdfPxCI3DplH3hiV4g+WyQfhNAXsifUlEnx2kM+lewpUimZpv6Hoj
         qO3ao+a7kQXRaYrEqKXdKWbv6QcxZR5SSQvssvaQfAlZ7euc8GTaUQtSrC60JLz8TcEP
         SWqg==
X-Gm-Message-State: AOAM531ImmFuOPnJmL1maV7qgjF/umUTXHeVJliMrW8zu5EVNvNnG0fi
        kD483QR6CgMLlCOCrwCBZZO+O/igfCHkzw==
X-Google-Smtp-Source: ABdhPJxyd9gKcjqoaOsHR6RiSIBFfJnWIU2vuUHflml0HohXhfTyCB+A//GMBsJpUMADcZqbN1XOHA==
X-Received: by 2002:a05:622a:1305:b0:2de:7054:2649 with SMTP id v5-20020a05622a130500b002de70542649mr1090584qtk.244.1645642497975;
        Wed, 23 Feb 2022 10:54:57 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id f207sm210953qke.22.2022.02.23.10.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:54:57 -0800 (PST)
Date:   Wed, 23 Feb 2022 13:54:56 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Minchan Kim <minchan@kernel.org>, akpm@linux-foundation.org,
        mhocko@suse.com, peterz@infradead.org, guro@fb.com,
        shakeelb@google.com, timmurray@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/1] mm: count time in drain_all_pages during direct
 reclaim as memory pressure
Message-ID: <YhaDACTHpIT5rDB1@cmpxchg.org>
References: <20220219174940.2570901-1-surenb@google.com>
 <YhGN7nhqRMuEC5Rg@google.com>
 <CAJuCfpF6xDzxU7JHva34F_PRwm9qXJa7a98OEuWfwJ21cMJe-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpF6xDzxU7JHva34F_PRwm9qXJa7a98OEuWfwJ21cMJe-Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2022 at 08:52:38AM -0800, Suren Baghdasaryan wrote:
> On Sat, Feb 19, 2022 at 4:40 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > On Sat, Feb 19, 2022 at 09:49:40AM -0800, Suren Baghdasaryan wrote:
> > > When page allocation in direct reclaim path fails, the system will
> > > make one attempt to shrink per-cpu page lists and free pages from
> > > high alloc reserves. Draining per-cpu pages into buddy allocator can
> > > be a very slow operation because it's done using workqueues and the
> > > task in direct reclaim waits for all of them to finish before
> >
> > Yes, drain_all_pages is serious slow(100ms - 150ms on Android)
> > especially when CPUs are fully packed. It was also spotted in CMA
> > allocation even when there was on no memory pressure.
> 
> Thanks for the input, Minchan!
> In my tests I've seen 50-60ms delays in a single drain_all_pages but I
> can imagine there are cases worse than these.
> 
> >
> > > proceeding. Currently this time is not accounted as psi memory stall.
> >
> > Good spot.
> >
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
> > > Annotate drain_all_pages and unreserve_highatomic_pageblock during
> > > page allocation failure in the direct reclaim path so that delays
> > > caused by these calls are accounted as memory stall.
> > >
> > > Reported-by: Tim Murray <timmurray@google.com>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  mm/page_alloc.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 3589febc6d31..7fd0d392b39b 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -4639,8 +4639,12 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
> > >        * Shrink them and try again
> > >        */
> > >       if (!page && !drained) {
> > > +             unsigned long pflags;
> > > +
> > > +             psi_memstall_enter(&pflags);
> > >               unreserve_highatomic_pageblock(ac, false);
> > >               drain_all_pages(NULL);
> > > +             psi_memstall_leave(&pflags);
> >
> > Instead of annotating the specific drain_all_pages, how about
> > moving the annotation from __perform_reclaim to
> > __alloc_pages_direct_reclaim?
> 
> I'm fine with that approach too. Let's wait for Johannes' input before
> I make any changes.

I think the change makes sense, even if the workqueue fix speeds up
the drain. I agree with Minchan about moving the annotation upward.

With it moved, please feel free to add
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
