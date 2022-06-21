Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D3E552E4B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348807AbiFUJ3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348739AbiFUJ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:29:53 -0400
Received: from outbound-smtp40.blacknight.com (outbound-smtp40.blacknight.com [46.22.139.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BF4DBF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:29:53 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp40.blacknight.com (Postfix) with ESMTPS id 9E49A1C466F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:29:51 +0100 (IST)
Received: (qmail 21487 invoked from network); 21 Jun 2022 09:29:51 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Jun 2022 09:29:51 -0000
Date:   Tue, 21 Jun 2022 10:29:50 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 7/7] mm/page_alloc: Replace local_lock with normal
 spinlock
Message-ID: <20220621092950.GF15453@techsingularity.net>
References: <20220613125622.18628-1-mgorman@techsingularity.net>
 <20220613125622.18628-8-mgorman@techsingularity.net>
 <04709b2d0dc702c9bf50f57cde125b07cdf54363.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <04709b2d0dc702c9bf50f57cde125b07cdf54363.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 11:39:03AM +0200, Nicolas Saenz Julienne wrote:
> Hi Mel,
> 
> On Mon, 2022-06-13 at 13:56 +0100, Mel Gorman wrote:
> > @@ -3446,12 +3490,16 @@ void free_unref_page(struct page *page, unsigned int order)
> >  		migratetype = MIGRATE_MOVABLE;
> >  	}
> >  
> > -	local_lock_irqsave(&pagesets.lock, flags);
> > -	freed_pcp = free_unref_page_commit(page, migratetype, order, false);
> > -	local_unlock_irqrestore(&pagesets.lock, flags);
> > -
> > -	if (unlikely(!freed_pcp))
> > +	zone = page_zone(page);
> > +	pcp_trylock_prepare(UP_flags);
> 
> Now that you're calling the *_irqsave() family of function you can drop
> pcp_trylock_prepare/finish()
> 
> For the record in UP:
> 
> #define spin_trylock_irqsave(lock, flags) \
> ({ \
> 	local_irq_save(flags); \
> 	1;
> })
> 

The missing patch that is deferred for a later release uses spin_trylock
so unless that is never merged because there is an unfixable flaw in it,
I'd prefer to leave the preparation in place.

> > +	pcp = pcpu_spin_trylock_irqsave(struct per_cpu_pages, lock, zone->per_cpu_pageset, flags);
> > +	if (pcp) {
> > +		free_unref_page_commit(pcp, zone, page, migratetype, order);
> > +		pcp_spin_unlock_irqrestore(pcp, flags);
> > +	} else {
> >  		free_one_page(page_zone(page), page, pfn, order, migratetype, FPI_NONE);
> > +	}
> > +	pcp_trylock_finish(UP_flags);
> >  }
> >  
> >  /*
> 
> As Vlastimil mentioned elsewhere, I also wonder if it makes sense to just
> bypass patch #5. Especially as its intent isn't true anymore:
> 
> "As preparation for dealing with both of those problems, protect the lists
> with a spinlock.  The IRQ-unsafe version of the lock is used because IRQs
> are already disabled by local_lock_irqsave.  spin_trylock is used in
> preparation for a time when local_lock could be used instead of
> lock_lock_irqsave."
> 

It's still true, the patch just isn't included as I wanted them to be
separated by time so a bisection that points to it is "obvious" instead
of pointing at the whole series as being a potential problem.

-- 
Mel Gorman
SUSE Labs
