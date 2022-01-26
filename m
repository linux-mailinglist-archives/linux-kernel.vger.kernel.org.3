Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5DEE49C94C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241096AbiAZMJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:09:27 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38350 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241095AbiAZMJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:09:23 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AC8131F396;
        Wed, 26 Jan 2022 12:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643198961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o8XdabnDLCNlDO2a/lYlZ4HSI1ePTSue2klu5WteJII=;
        b=R8tu4jeO9BKewMpwwkbpSgTCQ+8/IckttsnoEHYl+23P/Lw751F+jDTbFD/UWupIgfO+qY
        /rQ/xgcLkdT8VKUqw3f1lU9S30U+CxGUqB9a+wLlPsgZJX4V5KiyusXAjqDqOG1Sp1/HXi
        y3kqKJzd5r25lZrZIYnTqTrqDbuqd6E=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 96382A3B83;
        Wed, 26 Jan 2022 12:09:21 +0000 (UTC)
Date:   Wed, 26 Jan 2022 13:09:21 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [RESEND][PATCH v2] mm: don't call lru draining in the nested
 lru_cache_disable
Message-ID: <YfE58abepJEppczP@dhcp22.suse.cz>
References: <YefX1t4owjlx/m5I@dhcp22.suse.cz>
 <YejkUlnnYeED1pC5@google.com>
 <YekcNmBqcpO9BYWv@dhcp22.suse.cz>
 <YenPK/JVNOhbxjtr@google.com>
 <YeqEBAKJ6NUjLQhr@dhcp22.suse.cz>
 <YessDywpsnCyrfIy@google.com>
 <Ye54ELlNBpeHoXsj@dhcp22.suse.cz>
 <Ye8mi80ObVZvLdS1@google.com>
 <Ye/Bgc1bH979cXwy@dhcp22.suse.cz>
 <YfBmSaMa826ZhFT4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfBmSaMa826ZhFT4@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25-01-22 13:06:17, Minchan Kim wrote:
> On Tue, Jan 25, 2022 at 10:23:13AM +0100, Michal Hocko wrote:
> > On Mon 24-01-22 14:22:03, Minchan Kim wrote:
> > [...]
> > >  CPU 0                               CPU 1
> > > 
> > >  lru_cache_disable                  lru_cache_disable
> > >    ret = atomic_inc_return;(ret = 1)
> > >                                      
> > >                                     ret = atomic_inc_return;(ret = 2)
> > >                                     
> > >    lru_add_drain_all(true);         
> > >                                     lru_add_drain_all(false)
> > >                                     mutex_lock() is holding
> > >    mutex_lock() is waiting
> > > 
> > >                                     IPI with !force_all_cpus
> > >                                     ...
> > >                                     ...
> > >                                     IPI done but it skipped some CPUs
> > >                
> > >      ..
> > >      ..
> > >  
> > > 
> > > Thus, lru_cache_disable on CPU 1 doesn't run with every CPUs so it
> > > introduces race of lru_disable_count so some pages on cores
> > > which didn't run the IPI could accept upcoming pages into per-cpu
> > > cache.
> > 
> > Yes, that is certainly possible but the question is whether it really
> > matters all that much. The race would require also another racer to be
> > adding a page to an _empty_ pcp list at the same time.
> > 
> > pagevec_add_and_need_flush
> >   1) pagevec_add # add to pcp list
> >   2) lru_cache_disabled
> >     atomic_read(lru_disable_count) = 0
> >   # no flush but the page is on pcp
> > 
> > There is no strong memory ordering between 1 and 2 and that is why we
> > need an IPI to enforce it in general IIRC.
> 
> Correct.
> 
> > 
> > But lru_cache_disable is not a strong synchronization primitive. It aims
> > at providing a best effort means to reduce false positives, right? IMHO
> 
> Nope. d479960e44f27, mm: disable LRU pagevec during the migration temporarily
> 
> Originally, it was designed to close the race fundamentally.

yes, but that turned out to be expensive due to additional IPIs.

> > it doesn't make much sense to aim for perfection because all users of
> > this interface already have to live with temporary failures and pcp
> > caches is not the only reason to fail - e.g. short lived page pins.
> 
> short lived pages are true but that doesn't mean we need to make the
> allocation faster. As I mentioned, the IPI takes up to hundreds
> milliseconds easily once CPUs are fully booked. If we reduce the
> cost, we could spend the time more productive works. I am working
> on making CMA more determinstic and this patch is one of parts.
> 
> > 
> > That being said, I would rather live with a best effort and simpler
> > implementation approach rather than aim for perfection in this case.
> > The scheme is already quite complex and another lock in the mix doesn't
> 
> lru_add_drain_all already hides the whole complexity inside and
> lru_cache_disable adds A simple synchroniztion to keep ordering
> on top of it. That's natural SW stack and I don't see too complication
> here.
> 
> > make it any easier to follow. If others believe that another lock makes
> 
> Disagree. lru_cache_disable is designed to guarantee closing the race
> you are opening again so the other code in allocator since disabling
> per-cpu cache doesn't need to consider the race at all. It's more
> simple/deterministic and we could make other stuff based on it(e.g.,
> zone->pcp). 

Let me repeat. The race is theoretically possible but I strongly doubt
it happens enough to warrant a more complexity to the scheme. Flush on
first lru_cache_disable sounds like a reasonable optimization to the
existing scheme without adding a ton of complexity. Adding another lock
to the picture sounds like over engineering the already complex scheme.

If you strongly disagree with that then I guess we have to agree to
disagree. I will not nak your patch but please consider practical aspect
of this whole schme. It really doesn't make much sense to make one part
of the potential failure mode absolutely bullet proof when more likely
temporary page pins are still going to be present.
-- 
Michal Hocko
SUSE Labs
