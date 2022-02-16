Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E694B886A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbiBPNGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:06:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiBPNGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:06:00 -0500
Received: from outbound-smtp04.blacknight.com (outbound-smtp04.blacknight.com [81.17.249.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A9A261214
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 05:05:46 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp04.blacknight.com (Postfix) with ESMTPS id 4E964BED69
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 13:05:45 +0000 (GMT)
Received: (qmail 28902 invoked from network); 16 Feb 2022 13:05:45 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Feb 2022 13:05:44 -0000
Date:   Wed, 16 Feb 2022 13:05:43 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Aaron Lu <aaron.lu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 2/5] mm/page_alloc: Track range of active PCP lists
 during bulk free
Message-ID: <20220216130542.GT3366@techsingularity.net>
References: <20220215145111.27082-1-mgorman@techsingularity.net>
 <20220215145111.27082-3-mgorman@techsingularity.net>
 <d6f991f6-ce07-853a-e87b-5eda97a35733@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <d6f991f6-ce07-853a-e87b-5eda97a35733@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 01:02:01PM +0100, Vlastimil Babka wrote:
> On 2/15/22 15:51, Mel Gorman wrote:
> > free_pcppages_bulk() frees pages in a round-robin fashion. Originally,
> > this was dealing only with migratetypes but storing high-order pages
> > means that there can be many more empty lists that are uselessly
> > checked. Track the minimum and maximum active pindex to reduce the
> > search space.
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > ---
> >  mm/page_alloc.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 08de32cfd9bb..c5110fdeb115 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1450,6 +1450,8 @@ static void free_pcppages_bulk(struct zone *zone, int count,
> >  					struct per_cpu_pages *pcp)
> >  {
> >  	int pindex = 0;
> > +	int min_pindex = 0;
> > +	int max_pindex = NR_PCP_LISTS - 1;
> >  	int batch_free = 0;
> >  	int nr_freed = 0;
> >  	unsigned int order;
> > @@ -1478,10 +1480,17 @@ static void free_pcppages_bulk(struct zone *zone, int count,
> >  			if (++pindex == NR_PCP_LISTS)
> 
> Hmm, so in the very first iteration at this point pindex is already 1. This
> looks odd even before the patch, as order 0 MIGRATE_UNMOVABLE list is only
> processed after all the higher orders?
> 

Yes and this was the behaviour before and after. I don't recall why. It
might have been to preserve UNMOVABLE pages but after the series is
finished, the reasoning is weak. I'll add a specific check.

> >  				pindex = 0;
> 
> Also shouldn't this wrap-around check also use min_index/max_index instead
> of NR_PCP_LISTS and 0?
> 

Yes, it should and it's a rebasing error from an earlier prototype that
I missed. I'll fix it.

> >  			list = &pcp->lists[pindex];
> > -		} while (list_empty(list));
> > +			if (!list_empty(list))
> > +				break;
> > +
> > +			if (pindex == max_pindex)
> > +				max_pindex--;
> > +			if (pindex == min_pindex)
> 
> So with pindex 1 and min_pindex == 0 this will not trigger until
> (eventually) the first pindex wrap around, which seems suboptimal. But I can
> see the later patches change things substantially anyway so it may be moot...
> 

It could potentially be more optimal but at the cost of complexity which
I wanted to avoid in this path as much as possible. Initialising
min_pindex == pindex could result in an infinite loop if the lower lists
need to be cleared.

-- 
Mel Gorman
SUSE Labs
