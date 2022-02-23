Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94ECC4C1C6D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244502AbiBWTmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbiBWTmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:42:42 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6DE37BEE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:42:14 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id d21so27879059yba.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0U8UlTtkfmK0Hou2Y3imiiT6/sq8O5dEjadttlqKgn4=;
        b=UB9rMJmHZommJulkQTLlEPHC5EYnj3vf+CfXN+z7murp0nGC+VFQZ52o2ckP2//4RD
         sxsCLAbILrhfbTbErqIxswlOlCCsIYYnxBMgtTm/AKaRwgsmfkCWWbjoTmXFYFmRjUtG
         nkU604QG8EFUoszWd+qJv0uYBQGlnLTgzO0E9iIXakJ8u8ZDapj3U0x4ESJu118hUgan
         25l2s/AK20WZkl5Z6Nx8kU7jj/bFNBgZ9aW9htK2EPSgX+67mD4pHLR5Bn+TT+chsTRQ
         t1RZ3TPLw/dd+q47PrOcwY13FImYOVfPtmer0rfWdJgpTfiS5MC2f2kfzbeOq/Uca2rT
         H5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0U8UlTtkfmK0Hou2Y3imiiT6/sq8O5dEjadttlqKgn4=;
        b=kyQ9XAT6Dfs7n+Y/3eRXHV1B9pJZCoexuLvkokefKsKqZgbWiPOhf0yhXSW5vrdJ3Z
         Gs29qNkxQUzzrw51e0Af5BLz89waBOYUIKJTWKQjDLKUwEn4BzMIzxh8IxHUqpuR0Kxf
         +AfhHfeOl4nNZSgTNet+O215yokVsypowpPKhH6jDXGGY+vjZZnsPnMjvTsPrqiCj/fd
         WjWRJ3e03Gz30ek7FVrexR/0/Yy37kgY+NM59Mzles4U+Dz2RexRKCNvio6hXxWSEv7g
         CXheXIqLFwG4/TYkuJzla/FKI7usKXZiScBZrQW8el0b/8vffPm3pjo8IEhfQE+9Q653
         zpzw==
X-Gm-Message-State: AOAM532bdom/vZPDQSGj12trO2Ry2kQMxk2pI+fvCXNwGm/jLE6Xvrzd
        sVPNIZBfZFiVHdiHmMC7vlzmyRDhxKzbBkh6GQDU0g==
X-Google-Smtp-Source: ABdhPJyzTmnDajT0/39OEm9br8dyCQP3abEWyUyJXSQYJnofusSMz3F9pX8dU1xoNYP70+Av85AXfgBxX7xY+q7IFfc=
X-Received: by 2002:a25:2a45:0:b0:61e:2511:5333 with SMTP id
 q66-20020a252a45000000b0061e25115333mr1089738ybq.553.1645645333264; Wed, 23
 Feb 2022 11:42:13 -0800 (PST)
MIME-Version: 1.0
References: <20220219174940.2570901-1-surenb@google.com> <YhGN7nhqRMuEC5Rg@google.com>
 <CAJuCfpF6xDzxU7JHva34F_PRwm9qXJa7a98OEuWfwJ21cMJe-Q@mail.gmail.com>
 <YhaDACTHpIT5rDB1@cmpxchg.org> <CAJuCfpEOHKnsZW+Yo-p8PEPTyO_CK-cV1FOresT+skUAuEhXRw@mail.gmail.com>
In-Reply-To: <CAJuCfpEOHKnsZW+Yo-p8PEPTyO_CK-cV1FOresT+skUAuEhXRw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 23 Feb 2022 11:42:02 -0800
Message-ID: <CAJuCfpFeKsXFpJOdwx+UhgGgqELEr89D5FpN_Qmz-5p03L_Cgw@mail.gmail.com>
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

On Wed, Feb 23, 2022 at 11:06 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Wed, Feb 23, 2022 at 10:54 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Sun, Feb 20, 2022 at 08:52:38AM -0800, Suren Baghdasaryan wrote:
> > > On Sat, Feb 19, 2022 at 4:40 PM Minchan Kim <minchan@kernel.org> wrote:
> > > >
> > > > On Sat, Feb 19, 2022 at 09:49:40AM -0800, Suren Baghdasaryan wrote:
> > > > > When page allocation in direct reclaim path fails, the system will
> > > > > make one attempt to shrink per-cpu page lists and free pages from
> > > > > high alloc reserves. Draining per-cpu pages into buddy allocator can
> > > > > be a very slow operation because it's done using workqueues and the
> > > > > task in direct reclaim waits for all of them to finish before
> > > >
> > > > Yes, drain_all_pages is serious slow(100ms - 150ms on Android)
> > > > especially when CPUs are fully packed. It was also spotted in CMA
> > > > allocation even when there was on no memory pressure.
> > >
> > > Thanks for the input, Minchan!
> > > In my tests I've seen 50-60ms delays in a single drain_all_pages but I
> > > can imagine there are cases worse than these.
> > >
> > > >
> > > > > proceeding. Currently this time is not accounted as psi memory stall.
> > > >
> > > > Good spot.
> > > >
> > > > >
> > > > > While testing mobile devices under extreme memory pressure, when
> > > > > allocations are failing during direct reclaim, we notices that psi
> > > > > events which would be expected in such conditions were not triggered.
> > > > > After profiling these cases it was determined that the reason for
> > > > > missing psi events was that a big chunk of time spent in direct
> > > > > reclaim is not accounted as memory stall, therefore psi would not
> > > > > reach the levels at which an event is generated. Further investigation
> > > > > revealed that the bulk of that unaccounted time was spent inside
> > > > > drain_all_pages call.
> > > > >
> > > > > Annotate drain_all_pages and unreserve_highatomic_pageblock during
> > > > > page allocation failure in the direct reclaim path so that delays
> > > > > caused by these calls are accounted as memory stall.
> > > > >
> > > > > Reported-by: Tim Murray <timmurray@google.com>
> > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > ---
> > > > >  mm/page_alloc.c | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > > index 3589febc6d31..7fd0d392b39b 100644
> > > > > --- a/mm/page_alloc.c
> > > > > +++ b/mm/page_alloc.c
> > > > > @@ -4639,8 +4639,12 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
> > > > >        * Shrink them and try again
> > > > >        */
> > > > >       if (!page && !drained) {
> > > > > +             unsigned long pflags;
> > > > > +
> > > > > +             psi_memstall_enter(&pflags);
> > > > >               unreserve_highatomic_pageblock(ac, false);
> > > > >               drain_all_pages(NULL);
> > > > > +             psi_memstall_leave(&pflags);
> > > >
> > > > Instead of annotating the specific drain_all_pages, how about
> > > > moving the annotation from __perform_reclaim to
> > > > __alloc_pages_direct_reclaim?
> > >
> > > I'm fine with that approach too. Let's wait for Johannes' input before
> > > I make any changes.
> >
> > I think the change makes sense, even if the workqueue fix speeds up
> > the drain. I agree with Minchan about moving the annotation upward.
> >
> > With it moved, please feel free to add
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Thanks Johannes!
> I'll move psi_memstall_enter/psi_memstall_leave from __perform_reclaim
> into __alloc_pages_direct_reclaim to cover it completely. After that
> will continue on fixing the workqueue issue.

Posted v2 at https://lore.kernel.org/all/20220223194018.1296629-1-surenb@google.com/
