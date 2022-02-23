Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3504C1B65
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244127AbiBWTHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244120AbiBWTHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:07:00 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52EE388C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:06:30 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id e140so49966694ybh.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4xZqFmgf5/y8vSfdSXKXHJcVwPPK/T+ncXD/Q/6tYGs=;
        b=SdOczIhsiozsDQKULdBWj+vfCmfMwIq/TcMjZnslL6+RJVqTDPbo/VmZqa1IK9y1rO
         gvWavvEgs24VLisDTz3ETDhfYpLHwH2J0Hh2q0d8x1TOiGoUjc8oG6QPptFrZAg3jl2F
         w+v7qqxMf/XiKM7YSlk3LIytHLzLjVkAzwAGnwuZQGxZKrQ8sOdc6nvcgYJrvl/rrdad
         DQtOKFWBcmLDf1F+KI6x7I9yU3dSTLN8P6nHK2lqoAuGBMF3ojRFwBb6o7/LP9K4aoHz
         8WQarOhHIzKoVkCkJJxHcEYRM096dT5tIhzDKzoDrxL4TYWTRxtNYEWh5xesLwulGvGo
         rLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4xZqFmgf5/y8vSfdSXKXHJcVwPPK/T+ncXD/Q/6tYGs=;
        b=bRiGl+ksIIM3dPnIYecUY7vWjFrMkCRSlq5Z1dScEKqHlAzbp2B7RheleRf4uXCHPP
         lXvsBK70IpLsPdgbq+/aC5znzBnAQrwcoShXbTG44nmOoWkUc5fWbI9mqruam0aSGanT
         5zMIkaZiL9xMaWvvRkGEM4yNIysrDDg0XQ0bIESSc9c/U6DnVkY6FbTdltex5pzD3gTJ
         sQT8c5HP6Btxn7+SRZ2pXYOgpxrC04MkcC6asdJXH6VhOXQnPvPMyyEFUm8oaFgtR1Zt
         OhE0rcbNlXFz5QAUxzPYUgzC/T4F37ocxj2V6iusr1my5w/eaWGlCQ4fTFnIH9CAGlcJ
         8NoQ==
X-Gm-Message-State: AOAM5323FdHNXE83zupUxMPIwCmIL+632a3HyoCCUjy3sn5MjEQZkyw5
        znuwyBtNnos6h63cOhPSF+CONDsQwe1mJx9cm26Kfw==
X-Google-Smtp-Source: ABdhPJz64yAvdnJk1+Xmpn0rwuJJGqln3QrsMUh4KE/EdaMATdk2S7A5EDux1DopRlcc+Ztlo+jG4OAgerZ5VKeQZpI=
X-Received: by 2002:a25:d986:0:b0:624:ddc:ff9 with SMTP id q128-20020a25d986000000b006240ddc0ff9mr990227ybg.509.1645643189482;
 Wed, 23 Feb 2022 11:06:29 -0800 (PST)
MIME-Version: 1.0
References: <20220219174940.2570901-1-surenb@google.com> <YhGN7nhqRMuEC5Rg@google.com>
 <CAJuCfpF6xDzxU7JHva34F_PRwm9qXJa7a98OEuWfwJ21cMJe-Q@mail.gmail.com> <YhaDACTHpIT5rDB1@cmpxchg.org>
In-Reply-To: <YhaDACTHpIT5rDB1@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 23 Feb 2022 11:06:18 -0800
Message-ID: <CAJuCfpEOHKnsZW+Yo-p8PEPTyO_CK-cV1FOresT+skUAuEhXRw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: count time in drain_all_pages during direct
 reclaim as memory pressure
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Minchan Kim <minchan@kernel.org>, akpm@linux-foundation.org,
        mhocko@suse.com, peterz@infradead.org, guro@fb.com,
        shakeelb@google.com, timmurray@google.com, linux-mm@kvack.org,
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

On Wed, Feb 23, 2022 at 10:54 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Sun, Feb 20, 2022 at 08:52:38AM -0800, Suren Baghdasaryan wrote:
> > On Sat, Feb 19, 2022 at 4:40 PM Minchan Kim <minchan@kernel.org> wrote:
> > >
> > > On Sat, Feb 19, 2022 at 09:49:40AM -0800, Suren Baghdasaryan wrote:
> > > > When page allocation in direct reclaim path fails, the system will
> > > > make one attempt to shrink per-cpu page lists and free pages from
> > > > high alloc reserves. Draining per-cpu pages into buddy allocator can
> > > > be a very slow operation because it's done using workqueues and the
> > > > task in direct reclaim waits for all of them to finish before
> > >
> > > Yes, drain_all_pages is serious slow(100ms - 150ms on Android)
> > > especially when CPUs are fully packed. It was also spotted in CMA
> > > allocation even when there was on no memory pressure.
> >
> > Thanks for the input, Minchan!
> > In my tests I've seen 50-60ms delays in a single drain_all_pages but I
> > can imagine there are cases worse than these.
> >
> > >
> > > > proceeding. Currently this time is not accounted as psi memory stall.
> > >
> > > Good spot.
> > >
> > > >
> > > > While testing mobile devices under extreme memory pressure, when
> > > > allocations are failing during direct reclaim, we notices that psi
> > > > events which would be expected in such conditions were not triggered.
> > > > After profiling these cases it was determined that the reason for
> > > > missing psi events was that a big chunk of time spent in direct
> > > > reclaim is not accounted as memory stall, therefore psi would not
> > > > reach the levels at which an event is generated. Further investigation
> > > > revealed that the bulk of that unaccounted time was spent inside
> > > > drain_all_pages call.
> > > >
> > > > Annotate drain_all_pages and unreserve_highatomic_pageblock during
> > > > page allocation failure in the direct reclaim path so that delays
> > > > caused by these calls are accounted as memory stall.
> > > >
> > > > Reported-by: Tim Murray <timmurray@google.com>
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > ---
> > > >  mm/page_alloc.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > index 3589febc6d31..7fd0d392b39b 100644
> > > > --- a/mm/page_alloc.c
> > > > +++ b/mm/page_alloc.c
> > > > @@ -4639,8 +4639,12 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
> > > >        * Shrink them and try again
> > > >        */
> > > >       if (!page && !drained) {
> > > > +             unsigned long pflags;
> > > > +
> > > > +             psi_memstall_enter(&pflags);
> > > >               unreserve_highatomic_pageblock(ac, false);
> > > >               drain_all_pages(NULL);
> > > > +             psi_memstall_leave(&pflags);
> > >
> > > Instead of annotating the specific drain_all_pages, how about
> > > moving the annotation from __perform_reclaim to
> > > __alloc_pages_direct_reclaim?
> >
> > I'm fine with that approach too. Let's wait for Johannes' input before
> > I make any changes.
>
> I think the change makes sense, even if the workqueue fix speeds up
> the drain. I agree with Minchan about moving the annotation upward.
>
> With it moved, please feel free to add
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks Johannes!
I'll move psi_memstall_enter/psi_memstall_leave from __perform_reclaim
into __alloc_pages_direct_reclaim to cover it completely. After that
will continue on fixing the workqueue issue.
