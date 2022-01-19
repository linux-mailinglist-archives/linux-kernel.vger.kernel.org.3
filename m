Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB4F4931A3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 01:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346854AbiASAM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 19:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239681AbiASAM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 19:12:58 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E9DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 16:12:58 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id l16so840426pjl.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 16:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n4TWRk7hzXbeao/XrGd6EQhvuc/9XakfdR31XJE7vm4=;
        b=DQ/2Xm/b3RE1AxpowOFz1PgfxKHvLa5vPHDCRPJmcV6DFue3OJwclq/ZC6XOInWvzh
         mvmlf1FqKToolRd8AmEp+2RkIIClj3C/EZocFF7P0YwkayrbDbeJUW2rEeC/Yt+m052t
         bcTiRIjILDvRXlPPXTy2cSMVWTdlIeatBACCYl+GB11mJmDXy5DZ5SQtWTnBhhMyRYRL
         jWPRuzqegE0Nk1TVzn5arTAcKZJOfBbgI5z+i37KDhuRw/GRv29HmkxT2LXk381uaCIG
         0OQBZRnvs+YR0Yr3xdx+v0U/jORbQhE1aCg/A03rKmNG8tVsUOepHXwTsAyqlKWpB3Pn
         UjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=n4TWRk7hzXbeao/XrGd6EQhvuc/9XakfdR31XJE7vm4=;
        b=tw3DnvChtWpxPwGx592tVz870V2144zgUKHgS04a0PhVM53khO3dg5qOLjHQSzjaF5
         3a6IqZB1P1Us3YIbW7IMpTyzQcTa4NFJQRwmq/+Wg973eHXhh5m8C8GvOLRvz0hIyvYF
         ozP7gBGjmWlqJPaJcR6mtFUp/2ZtxOGED3ktku4fIwzbNKGP9ZI0T+kgH+OphP+xueJ8
         pmoedDjbNQsbXNi3Spy4V8ejfwcv/2HptmzasSFaImv26v9ShinbidHPD7KXMn1oZfDv
         zFJsXMcoGedjspTy3cXoY6eADk/s5RH+czL/HIPaw2l87kC2FuE1WGsWSWVbYEruURkm
         GEMA==
X-Gm-Message-State: AOAM532981KQKqm0n+lxgdVJ5vHVpjnI1bKDeYc8Zr1BT5QPAXof2vRK
        jlkxYQ0rDXgwFuinWq4KMVpYiaswY3k=
X-Google-Smtp-Source: ABdhPJz7iyetZ1bxDTpsDG2A9gcCQVmadTzoPxXGkv9BY0f9kSFAV0y3H2N88xDmvO5M314d0gQvsA==
X-Received: by 2002:a17:90a:940e:: with SMTP id r14mr1200789pjo.17.1642551177468;
        Tue, 18 Jan 2022 16:12:57 -0800 (PST)
Received: from google.com ([2620:15c:211:201:f21:7e82:175f:6579])
        by smtp.gmail.com with ESMTPSA id u30sm1739978pgl.6.2022.01.18.16.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 16:12:56 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 18 Jan 2022 16:12:54 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [RESEND][PATCH v2] mm: don't call lru draining in the nested
 lru_cache_disable
Message-ID: <YedXhpwURNTkW1Z3@google.com>
References: <20211230193627.495145-1-minchan@kernel.org>
 <YeVzWlrojI1+buQx@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeVzWlrojI1+buQx@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 02:47:06PM +0100, Michal Hocko wrote:
> On Thu 30-12-21 11:36:27, Minchan Kim wrote:
> > lru_cache_disable involves IPIs to drain pagevec of each core,
> > which sometimes takes quite long time to complete depending
> > on cpu's business, which makes allocation too slow up to
> > sveral hundredth milliseconds. Furthermore, the repeated draining
> > in the alloc_contig_range makes thing worse considering caller
> > of alloc_contig_range usually tries multiple times in the loop.
> >
> > This patch makes the lru_cache_disable aware of the fact the
> > pagevec was already disabled. With that, user of alloc_contig_range
> > can disable the lru cache in advance in their context during the
> > repeated trial so they can avoid the multiple costly draining
> > in cma allocation.
> 
> Do you have any numbers on any improvements?

The LRU draining consumed above 50% overhead for the 20M CMA alloc.

> 
> Now to the change. I do not like this much to be honest. LRU cache
> disabling is a complex synchronization scheme implemented in
> __lru_add_drain_all now you are stacking another level on top of that.
> 
> More fundamentally though. I am not sure I understand the problem TBH.

The problem is that kinds of IPI using normal prority workqueue to drain
takes much time depending on the system CPU business.

> What prevents you from calling lru_cache_disable at the cma level in the
> first place?

You meant moving the call from alloc_contig_range to caller layer?
So, virtio_mem_fake_online, too? It could and make sense from
performance perspective since upper layer usually calls the
alloc_contig_range multiple times on retrial loop.

Havid said, semantically, not good in that why upper layer should
know how alloc_contig_range works(LRU disable is too low level stuff)
internally but I chose the performance here.

There is an example why the stacking is needed.
cma_alloc also can be called from outside.
A usecase is try to call

    lru_cache_disable
    for (order = 10; order >= 0; order) {
        page = cma_alloc(1<<order)
        if (page)
            break;
    }
    lru_cacne_enable

Here, putting the disable lru outside of cma_alloc is
much better than inside. That's why I put it outside.

> 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  * from v1 - https://lore.kernel.org/lkml/20211206221006.946661-1-minchan@kernel.org/
> >    * fix lru_cache_disable race - akpm
> > 
> >  include/linux/swap.h | 14 ++------------
> >  mm/cma.c             |  5 +++++
> >  mm/swap.c            | 30 ++++++++++++++++++++++++++++--
> >  3 files changed, 35 insertions(+), 14 deletions(-)
> > 
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index ba52f3a3478e..fe18e86a4f13 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -348,19 +348,9 @@ extern void lru_note_cost_page(struct page *);
> >  extern void lru_cache_add(struct page *);
> >  extern void mark_page_accessed(struct page *);
> >  
> > -extern atomic_t lru_disable_count;
> > -
> > -static inline bool lru_cache_disabled(void)
> > -{
> > -	return atomic_read(&lru_disable_count);
> > -}
> > -
> > -static inline void lru_cache_enable(void)
> > -{
> > -	atomic_dec(&lru_disable_count);
> > -}
> > -
> > +extern bool lru_cache_disabled(void);
> >  extern void lru_cache_disable(void);
> > +extern void lru_cache_enable(void);
> >  extern void lru_add_drain(void);
> >  extern void lru_add_drain_cpu(int cpu);
> >  extern void lru_add_drain_cpu_zone(struct zone *zone);
> > diff --git a/mm/cma.c b/mm/cma.c
> > index 995e15480937..60be555c5b95 100644
> > --- a/mm/cma.c
> > +++ b/mm/cma.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/cma.h>
> >  #include <linux/highmem.h>
> >  #include <linux/io.h>
> > +#include <linux/swap.h>
> >  #include <linux/kmemleak.h>
> >  #include <trace/events/cma.h>
> >  
> > @@ -453,6 +454,8 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
> >  	if (bitmap_count > bitmap_maxno)
> >  		goto out;
> >  
> > +	lru_cache_disable();
> > +
> >  	for (;;) {
> >  		spin_lock_irq(&cma->lock);
> >  		bitmap_no = bitmap_find_next_zero_area_off(cma->bitmap,
> > @@ -492,6 +495,8 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
> >  		start = bitmap_no + mask + 1;
> >  	}
> >  
> > +	lru_cache_enable();
> > +
> >  	trace_cma_alloc_finish(cma->name, pfn, page, count, align);
> >  
> >  	/*
> > diff --git a/mm/swap.c b/mm/swap.c
> > index af3cad4e5378..5f89d7c9a54e 100644
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -847,7 +847,17 @@ void lru_add_drain_all(void)
> >  }
> >  #endif /* CONFIG_SMP */
> >  
> > -atomic_t lru_disable_count = ATOMIC_INIT(0);
> > +static atomic_t lru_disable_count = ATOMIC_INIT(0);
> > +
> > +bool lru_cache_disabled(void)
> > +{
> > +	return atomic_read(&lru_disable_count) != 0;
> > +}
> > +
> > +void lru_cache_enable(void)
> > +{
> > +	atomic_dec(&lru_disable_count);
> > +}
> >  
> >  /*
> >   * lru_cache_disable() needs to be called before we start compiling
> > @@ -859,7 +869,21 @@ atomic_t lru_disable_count = ATOMIC_INIT(0);
> >   */
> >  void lru_cache_disable(void)
> >  {
> > -	atomic_inc(&lru_disable_count);
> > +	static DEFINE_MUTEX(lock);
> > +
> > +	/*
> > +	 * The lock gaurantees lru_cache is drained when the function
> > +	 * returned.
> > +	 */
> > +	mutex_lock(&lock);
> > +	/*
> > +	 * If someone is already disabled lru_cache, just return with
> > +	 * increasing the lru_disable_count.
> > +	 */
> > +	if (atomic_inc_not_zero(&lru_disable_count)) {
> > +		mutex_unlock(&lock);
> > +		return;
> > +	}
> >  #ifdef CONFIG_SMP
> >  	/*
> >  	 * lru_add_drain_all in the force mode will schedule draining on
> > @@ -873,6 +897,8 @@ void lru_cache_disable(void)
> >  #else
> >  	lru_add_and_bh_lrus_drain();
> >  #endif
> > +	atomic_inc(&lru_disable_count);
> > +	mutex_unlock(&lock);
> >  }
> >  
> >  /**
> > -- 
> > 2.34.1.448.ga2b2bfdf31-goog
> 
> -- 
> Michal Hocko
> SUSE Labs
> 
