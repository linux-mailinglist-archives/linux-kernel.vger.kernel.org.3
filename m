Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569FE4BCFFE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 17:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242891AbiBTQxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 11:53:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbiBTQxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 11:53:12 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34541237F8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 08:52:50 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id v186so29685929ybg.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 08:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MA9Whiv3uv/Z2j9b1Sp/UPbzEqBjJrCbfpHQf8ZeIVI=;
        b=CbG3cLeW89/CEqBp3kqySp+WTHTX48hBg44IsjG1Y9p+gAtOhOROjhrjTZK8DmoSkc
         Pfa3nLH3j5oyFdP9VO9ThumdzbCzy0ljIgpOsq4Y74Y1ACv2qBFWoJijBwu9TGRiAO8c
         FK9adg2triBntH1UXky8WEgn1wTgwOR9ZWiQ/OoNhAEcqy456YsmDpd2/+iqsN7AzwLM
         WOKcA65D+aNV6IcK6RJzPKeM5b9qHLmD5A6GPU69JrtLQoE7wlG57myAIwkYwuww3Ino
         YjYsLjQ/TmFfXvgmfGRIE6JUTeR7Psv59oqhZTd6h1o1L8F2Za4i3SQeZYxKUnUdQMYv
         jXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MA9Whiv3uv/Z2j9b1Sp/UPbzEqBjJrCbfpHQf8ZeIVI=;
        b=FpNTGLWldNLKArPJUudPwuNIhMB3G1PnBYRRTmsRoDZpybPHm7R1/ZIti2aJd6VD62
         5GSgKrUNY/CsD7eVE7ym1AoPoFCCU/sH2Fc4NguomC5d4YNSB/Sd3KfGoFtK2QZDFbpb
         U+xgzDJQ3mAAuXexat3cZluyZfZKSOb5Ev2jFczH5K3mGnCoVa4IFj2dOEcm9cAGsXsE
         HrmVyhqFwjFTXAljhEMA/JI+7Bj7rM5n0a7u6Ld0L6sqtwkSZB4GNbQhfy2YjwR7hU+6
         8KQqpYGdVRQ20yayg09WOc7nkd68HE++UVBAB2AMzfQBzcDr9urHDL8bcE3ea+PP8Bp6
         SQ3Q==
X-Gm-Message-State: AOAM530IIRNWWbIHNQG45G88BtQD6fB3sOwl9tZyM4QCZjsdkUyeM8Qs
        87kJ376SLR9dzgEUcYJZThr2L7KoDqEaVl7KkqFhCw==
X-Google-Smtp-Source: ABdhPJziD5LuicOYbpCGsTty/VQuCP14Ce8qOpqdwkwSdELHVWtwSV5mL678pxcM15MhcX/4znkByKE8eyLRgcoljE0=
X-Received: by 2002:a25:da47:0:b0:61d:9af4:c834 with SMTP id
 n68-20020a25da47000000b0061d9af4c834mr15983902ybf.441.1645375969048; Sun, 20
 Feb 2022 08:52:49 -0800 (PST)
MIME-Version: 1.0
References: <20220219174940.2570901-1-surenb@google.com> <YhGN7nhqRMuEC5Rg@google.com>
In-Reply-To: <YhGN7nhqRMuEC5Rg@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sun, 20 Feb 2022 08:52:38 -0800
Message-ID: <CAJuCfpF6xDzxU7JHva34F_PRwm9qXJa7a98OEuWfwJ21cMJe-Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: count time in drain_all_pages during direct
 reclaim as memory pressure
To:     Minchan Kim <minchan@kernel.org>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        peterz@infradead.org, guro@fb.com, shakeelb@google.com,
        timmurray@google.com, linux-mm@kvack.org,
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

On Sat, Feb 19, 2022 at 4:40 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Sat, Feb 19, 2022 at 09:49:40AM -0800, Suren Baghdasaryan wrote:
> > When page allocation in direct reclaim path fails, the system will
> > make one attempt to shrink per-cpu page lists and free pages from
> > high alloc reserves. Draining per-cpu pages into buddy allocator can
> > be a very slow operation because it's done using workqueues and the
> > task in direct reclaim waits for all of them to finish before
>
> Yes, drain_all_pages is serious slow(100ms - 150ms on Android)
> especially when CPUs are fully packed. It was also spotted in CMA
> allocation even when there was on no memory pressure.

Thanks for the input, Minchan!
In my tests I've seen 50-60ms delays in a single drain_all_pages but I
can imagine there are cases worse than these.

>
> > proceeding. Currently this time is not accounted as psi memory stall.
>
> Good spot.
>
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
> > Annotate drain_all_pages and unreserve_highatomic_pageblock during
> > page allocation failure in the direct reclaim path so that delays
> > caused by these calls are accounted as memory stall.
> >
> > Reported-by: Tim Murray <timmurray@google.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/page_alloc.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 3589febc6d31..7fd0d392b39b 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -4639,8 +4639,12 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
> >        * Shrink them and try again
> >        */
> >       if (!page && !drained) {
> > +             unsigned long pflags;
> > +
> > +             psi_memstall_enter(&pflags);
> >               unreserve_highatomic_pageblock(ac, false);
> >               drain_all_pages(NULL);
> > +             psi_memstall_leave(&pflags);
>
> Instead of annotating the specific drain_all_pages, how about
> moving the annotation from __perform_reclaim to
> __alloc_pages_direct_reclaim?

I'm fine with that approach too. Let's wait for Johannes' input before
I make any changes.
Thanks,
Suren.
