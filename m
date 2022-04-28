Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E538513812
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349001AbiD1PVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349041AbiD1PU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:20:57 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC5DB6D24
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:17:21 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id z126so3857215qkb.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E9UW1bag0U6JwSp2lSKEFTQPx6fxwp66hBJxsfKUM1Q=;
        b=gRA6hbtN/01k4+k22fV/ZVyh8d/v1uJ8gcamYPxonMAcJx8uuQTXaMsl2cAvgDzKIc
         T30+pFpIeJOxFtaGF4H5w4QDpMhBfMSa/IRig4pA91KK2J2EJzCeU/kvPwG9qeMDkqSF
         0M1jjIIyWzHmkshwPgA9MnNY7YW688hDVNGtwpEeV2ReIGCcLZH4TNUWSoGDgPJVmYn4
         kgSq4l7TidxAF7IByp5uYg3VTk2iRG6Ry6VhBr65yYljjeJzuHfdY5/1+38fgLYlR5R8
         QNRygU8Tuw7ukszTHI58UOlwMgnF/uUo5NrUz0ocjhfKfbeQGWiHY7eplLvMEXdnC0mD
         OkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E9UW1bag0U6JwSp2lSKEFTQPx6fxwp66hBJxsfKUM1Q=;
        b=R971owcXsrYKnjF8CzWGxWETHjNJxAQkt56k7wpSI/dusjRRl8+MaSgobyhT+5Xhur
         JmjDqd2kkTGvkCksFTjhtfC82NmD0Je7J498ssw15SAN3Iikw1QNNhzm2wHaxSM5BJhe
         VN0qrdzpIWVX1jh+uyR2mm5yAbFdOFkhAIa55snJs3aK+z8/kLvb0Fb2We1mC7d+Yxgr
         yBIBGZLSN6iWaSty+SEk4FO//zduhuctk4j3v3IqQwnnXiEfvlOSKQ4JBVt4g2Xcg/A+
         mUXj2JbxFsHRthlUbMWqitHsZTwIt17qo6kSP5eQlSDlqKc7AyknA+0hi3FRQiEiahjo
         uvow==
X-Gm-Message-State: AOAM533C8JYC8znqZzeEzNR76SJVtO+oMpVl7oEmBURSbbEM9o6RoAMl
        zMYPUJiXv1H1QE+vware3UolDA==
X-Google-Smtp-Source: ABdhPJz0uD0Y4GikJduMeS7kngfPj/NeqmtNRrLdYE+UuoiwDoiYWKCJ9epVPC+Wehgv4PrxA1EH1w==
X-Received: by 2002:a37:c44:0:b0:69f:9a59:43c1 with SMTP id 65-20020a370c44000000b0069f9a5943c1mr4298447qkm.616.1651159040310;
        Thu, 28 Apr 2022 08:17:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:d588])
        by smtp.gmail.com with ESMTPSA id r7-20020a05622a034700b002f337000725sm140413qtw.42.2022.04.28.08.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 08:17:19 -0700 (PDT)
Date:   Thu, 28 Apr 2022 11:16:43 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH 4/5] mm: zswap: add basic meminfo and vmstat coverage
Message-ID: <Ymqv25+8IX2wqKzu@cmpxchg.org>
References: <20220427160016.144237-1-hannes@cmpxchg.org>
 <20220427160016.144237-5-hannes@cmpxchg.org>
 <Ymmnrkn0mSWcuvmH@google.com>
 <YmmznQ8AO5RLxicA@cmpxchg.org>
 <Ymm3WpvJWby4gaD/@cmpxchg.org>
 <CALvZod5LBi5V6q1uHUTSNnLz64HbD499a+OZvdYsUcmcWSt8Jg@mail.gmail.com>
 <YmqmWPrIagEEceN1@cmpxchg.org>
 <CALvZod7wOyXpA3pycM2dav9_F9sW5ezC84or-75u8GdQyu30nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7wOyXpA3pycM2dav9_F9sW5ezC84or-75u8GdQyu30nw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 07:49:33AM -0700, Shakeel Butt wrote:
> On Thu, Apr 28, 2022 at 7:36 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Wed, Apr 27, 2022 at 04:36:22PM -0700, Shakeel Butt wrote:
> > > On Wed, Apr 27, 2022 at 3:32 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > >
> > > > On Wed, Apr 27, 2022 at 05:20:31PM -0400, Johannes Weiner wrote:
> > > > > On Wed, Apr 27, 2022 at 01:29:34PM -0700, Minchan Kim wrote:
> > > > > > Hi Johannes,
> > > > > >
> > > > > > On Wed, Apr 27, 2022 at 12:00:15PM -0400, Johannes Weiner wrote:
> > > > > > > Currently it requires poking at debugfs to figure out the size and
> > > > > > > population of the zswap cache on a host. There are no counters for
> > > > > > > reads and writes against the cache. As a result, it's difficult to
> > > > > > > understand zswap behavior on production systems.
> > > > > > >
> > > > > > > Print zswap memory consumption and how many pages are zswapped out in
> > > > > > > /proc/meminfo. Count zswapouts and zswapins in /proc/vmstat.
> > > > > > >
> > > > > > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > > > > ---
> > > > > > >  fs/proc/meminfo.c             |  7 +++++++
> > > > > > >  include/linux/swap.h          |  5 +++++
> > > > > > >  include/linux/vm_event_item.h |  4 ++++
> > > > > > >  mm/vmstat.c                   |  4 ++++
> > > > > > >  mm/zswap.c                    | 13 ++++++-------
> > > > > > >  5 files changed, 26 insertions(+), 7 deletions(-)
> > > > > > >
> > > > > > > diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> > > > > > > index 6fa761c9cc78..6e89f0e2fd20 100644
> > > > > > > --- a/fs/proc/meminfo.c
> > > > > > > +++ b/fs/proc/meminfo.c
> > > > > > > @@ -86,6 +86,13 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> > > > > > >
> > > > > > >   show_val_kb(m, "SwapTotal:      ", i.totalswap);
> > > > > > >   show_val_kb(m, "SwapFree:       ", i.freeswap);
> > > > > > > +#ifdef CONFIG_ZSWAP
> > > > > > > + seq_printf(m,  "Zswap:          %8lu kB\n",
> > > > > > > +            (unsigned long)(zswap_pool_total_size >> 10));
> > > > > > > + seq_printf(m,  "Zswapped:       %8lu kB\n",
> > > > > > > +            (unsigned long)atomic_read(&zswap_stored_pages) <<
> > > > > > > +            (PAGE_SHIFT - 10));
> > > > > > > +#endif
> > > > > >
> > > > > > I agree it would be very handy to have the memory consumption in meminfo
> > > > > >
> > > > > > https://lore.kernel.org/all/YYwZXrL3Fu8%2FvLZw@google.com/
> > > > > >
> > > > > > If we really go this Zswap only metric instead of general term
> > > > > > "Compressed", I'd like to post maybe "Zram:" with same reason
> > > > > > in this patchset. Do you think that's better idea instead of
> > > > > > introducing general term like "Compressed:" or something else?
> > > > >
> > > > > I'm fine with changing it to Compressed. If somebody cares about a
> > > > > more detailed breakdown, we can add Zswap, Zram subsets as needed.
> > > >
> > > > It does raise the question what to do about cgroup, though. Should the
> > > > control files (memory.zswap.current & memory.zswap.max) apply to zram
> > > > in the future? If so, we should rename them, too.
> > > >
> > > > I'm not too familiar with zram, maybe you can provide some
> > > > background. AFAIU, Google uses zram quite widely; all the more
> > > > confusing why there is no container support for it yet.
> > > >
> > > > Could you shed some light?
> > > >
> > >
> > > I can shed light on the datacenter workloads. We use cgroup (still on
> > > v1) and zswap. For the workloads/applications, the swap (or zswap) is
> > > transparent in the sense that they are charged exactly the same
> > > irrespective of how much their memory is zswapped-out. Basically the
> > > applications see the same usage which is actually v1's
> > > memsw.usage_in_bytes. We dynamically increase the swap size if it is
> > > low, so we are not really worried about one job hogging the swap
> > > space.
> > >
> > > Regarding stats we actually do have them internally representing
> > > compressed size and number of pages in zswap. The compressed size is
> > > actually used for OOM victim selection. The memsw or v2's swap usage
> > > in the presence of compression based swap does not actually tell how
> > > much memory can potentially be released by evicting a job. For example
> > > if there are two jobs 'A' and 'B'. Both of them have 100 pages
> > > compressed but A's 100 pages are compressed to let's say 10 pages
> > > while B's 100 pages are compressed to 70 pages. It is preferable to
> > > kill B as that will release 70 pages. (This is a very simplified
> > > explanation of what we actually do).
> >
> > Ah, so zram is really only used by the mobile stuff after all.
> >
> > In the DC, I guess you don't use disk swap in conjunction with zswap,
> > so those writeback cache controls are less interesting to you?
> 
> Yes, we have some modifications to zswap to make it work without any
> backing real swap.

Not sure if you can share them, but I would be interested in those
changes. We have real backing swap, but because of the way swap
entries are allocated, pages stored in zswap will consume physical
disk slots. So on top of regular swap, you need to provision disk
space for zswap as well, which is unfortunate.

What could be useful is a separate swap entry address space that maps
zswap slots and disk slots alike. This would fix the above problem. It
would have the added benefit of making swapoff much simpler and faster
too, as it doesn't need to chase down page tables to free disk slots.

> > But it sounds like you would benefit from the zswap(ped) counters in
> > memory.stat at least.
> 
> Yes and I think if we need zram specific counters/stats in future,
> those can be added then.

I agree.
