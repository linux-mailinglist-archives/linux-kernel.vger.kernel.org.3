Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3329493718
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353003AbiASJU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:20:26 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57526 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352985AbiASJUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:20:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A98ED21125;
        Wed, 19 Jan 2022 09:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642584024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kmxhGAX60wrjunqbjCCAgalS1xNjG4gQYc11az3AVr4=;
        b=QPnamv229lqVT8gWP1H39M9eIW1NnK6TYGnE9yq6XuKZ7/FnsTmurANTXfSOhonzXoxHub
        AiaLl+b5E4gTbuZ2PM5I3qWDW6/DVt2u+JnGKncJHOAqx/ZNSDT6e/qJv+cH9VC76/3kei
        Lh9JOg91ST+wHWyIpIWyMtEKw+l5YoU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7A47FA3B81;
        Wed, 19 Jan 2022 09:20:24 +0000 (UTC)
Date:   Wed, 19 Jan 2022 10:20:22 +0100
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
Message-ID: <YefX1t4owjlx/m5I@dhcp22.suse.cz>
References: <20211230193627.495145-1-minchan@kernel.org>
 <YeVzWlrojI1+buQx@dhcp22.suse.cz>
 <YedXhpwURNTkW1Z3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YedXhpwURNTkW1Z3@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18-01-22 16:12:54, Minchan Kim wrote:
> On Mon, Jan 17, 2022 at 02:47:06PM +0100, Michal Hocko wrote:
> > On Thu 30-12-21 11:36:27, Minchan Kim wrote:
> > > lru_cache_disable involves IPIs to drain pagevec of each core,
> > > which sometimes takes quite long time to complete depending
> > > on cpu's business, which makes allocation too slow up to
> > > sveral hundredth milliseconds. Furthermore, the repeated draining
> > > in the alloc_contig_range makes thing worse considering caller
> > > of alloc_contig_range usually tries multiple times in the loop.
> > >
> > > This patch makes the lru_cache_disable aware of the fact the
> > > pagevec was already disabled. With that, user of alloc_contig_range
> > > can disable the lru cache in advance in their context during the
> > > repeated trial so they can avoid the multiple costly draining
> > > in cma allocation.
> > 
> > Do you have any numbers on any improvements?
> 
> The LRU draining consumed above 50% overhead for the 20M CMA alloc.

This doesn't say much about the improvement itself.
 
> > Now to the change. I do not like this much to be honest. LRU cache
> > disabling is a complex synchronization scheme implemented in
> > __lru_add_drain_all now you are stacking another level on top of that.
> > 
> > More fundamentally though. I am not sure I understand the problem TBH.
> 
> The problem is that kinds of IPI using normal prority workqueue to drain
> takes much time depending on the system CPU business.

How does this patch address that problem? The IPI has to happen at some
point as we need to sync up with pcp caches.

> > What prevents you from calling lru_cache_disable at the cma level in the
> > first place?
> 
> You meant moving the call from alloc_contig_range to caller layer?

Yes.

> So, virtio_mem_fake_online, too? It could and make sense from
> performance perspective since upper layer usually calls the
> alloc_contig_range multiple times on retrial loop.
> 
> Havid said, semantically, not good in that why upper layer should
> know how alloc_contig_range works(LRU disable is too low level stuff)
> internally but I chose the performance here.
> 
> There is an example why the stacking is needed.
> cma_alloc also can be called from outside.
> A usecase is try to call
> 
>     lru_cache_disable
>     for (order = 10; order >= 0; order) {
>         page = cma_alloc(1<<order)
>         if (page)
>             break;
>     }
>     lru_cacne_enable
> 
> Here, putting the disable lru outside of cma_alloc is
> much better than inside. That's why I put it outside.

What does prevent you from calling lru_cache_{disable,enable} this way
with the existing implementation? AFAICS calls can be nested just fine.
Or am I missing something?
-- 
Michal Hocko
SUSE Labs
