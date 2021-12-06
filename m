Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AC44697F7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245622AbhLFOKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:10:16 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33242 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245354AbhLFOJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:09:43 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A38232114D;
        Mon,  6 Dec 2021 14:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638799573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9X4l1sD1YRYUJ9CkDXDFuXWKIb6Pwx9WTqpwVGSQoOc=;
        b=MrDhqljraOV/11SZ8aAqM+Rr0Qvgofl6ADDpTvX/S2c1RjF0Qy+xWJgEis62UVw7JTuHhb
        hRP9U5FKQoPPCOZh6tj+tW5ynoWyuIE5s++sm93voCgNiyPjOR8qjZwOmrhYPW8PpDQDHa
        CMBMJQ8/S4Ovx8vfa1ZSEk60pJ3Fil4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 53FA5A3B9A;
        Mon,  6 Dec 2021 14:06:13 +0000 (UTC)
Date:   Mon, 6 Dec 2021 15:06:11 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, shakeelb@google.com,
        ktkhai@virtuozzo.com, shy828301@gmail.com, guro@fb.com,
        vbabka@suse.cz, vdavydov.dev@gmail.com, raquini@redhat.com
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Message-ID: <Ya4Y07Iu2ygj5zwZ@dhcp22.suse.cz>
References: <20211206033338.743270-1-npache@redhat.com>
 <20211206033338.743270-3-npache@redhat.com>
 <Ya3WcYKcej8XEI0W@dhcp22.suse.cz>
 <d9d14beb-ee20-7ebb-e007-fbf58fb28535@redhat.com>
 <Ya3r3C/OpnK7OBPt@dhcp22.suse.cz>
 <840cb3d0-61fe-b6cb-9918-69146ba06cf7@redhat.com>
 <Ya3yZWkj2wGRWDMz@dhcp22.suse.cz>
 <51c65635-1dae-6ba4-daf9-db9df0ec35d8@redhat.com>
 <Ya4K0+XCmv3NBmwQ@dhcp22.suse.cz>
 <05157de4-e5df-11fc-fc46-8a9f79d0ddb4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05157de4-e5df-11fc-fc46-8a9f79d0ddb4@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06-12-21 14:47:13, David Hildenbrand wrote:
> On 06.12.21 14:06, Michal Hocko wrote:
> > On Mon 06-12-21 13:43:27, David Hildenbrand wrote:
> > [...]
> >>> Now practically speaking !node_online should not apear node_online (note
> >>> I am attentionally avoiding to say offline and online as that has a
> >>> completely different semantic) shouldn't really happen for some
> >>> architectures. x86 should allocate pgdat for each possible node. I do
> >>> not know what was the architecture in this case but we already have
> >>> another report for x86 that remains unexplained.
> >>
> >> So we'd allocate the pgdat although all we want is just a zonelist. The
> >> obvious alternative is to implement the fallback where reasonable -- for
> >> example, in the page allocator. It knows the fallback order:
> >> build_zonelists(). That's pretty much all we need the preferred_nid for.
> >>
> >> So just making prepare_alloc_pages()/node_zonelist() deal with a missing
> >> pgdat could make sense as well. Something like:
> >>
> >>
> >> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> >> index b976c4177299..2d2649e78766 100644
> >> --- a/include/linux/gfp.h
> >> +++ b/include/linux/gfp.h
> >> @@ -508,9 +508,14 @@ static inline int gfp_zonelist(gfp_t flags)
> >>   *
> >>   * For the case of non-NUMA systems the NODE_DATA() gets optimized to
> >>   * &contig_page_data at compile-time.
> >> + *
> >> + * If the node does not have a pgdat yet, returns the zonelist of the
> >> + * first online node.
> >>   */
> >>  static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
> >>  {
> >> +       if (unlikely(!NODE_DATA(nid)))
> >> +               nid = first_online_node;
> >>         return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
> >>  }
> > 
> > This is certainly possible. But it a) adds a branch to the hotpath and
> > b) it doesn't solve any other potential dereference of garbage node.
> 
> I don't think a) is  a problem but it's easy to measure. Agreed to b),
> however, the page allocator has been the most prominent source of error
> reports for this.
> 
> >  
> >> But of course, there might be value in a proper node-aware fallback list
> >> as we have in build_zonelists() -- but it remains questionable if the
> >> difference for these corner cases would be relevant in practice.
> > 
> > Only the platform knows the proper node topology and that includes
> > memory less nodes. So they should be setting up a node properly and we
> > shouldn't be dealing with this at the allocator nor any other code.
> 
> I *think* there are cases where the topology of a new node is only know
> once it actually gets used. For example, I remember talking to CXL and
> there are ideas to have a pool of possible nodes, which can get used
> dynamically for CXL memory. Of course, some kind of reconfiguration
> could be imaginable.

I am not really familiar with CXL but if a dynamic reconfiguration is
needed then this would only require to update the zonelist which should
be a trivial thing to do. The code using the node doesn't really have to
be aware of that as the pgdat will stay unchanged.

> >> Further, if we could have thousands of nodes, we'd have to update each
> >> and every one when building zone lists ...
> > 
> > Why would that be a practical problem?
> 
> We'll need at least
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c5952749ad40..e5d958abc7cc 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6382,7 +6382,7 @@ static void __build_all_zonelists(void *data)
>         if (self && !node_online(self->node_id)) {
>                 build_zonelists(self);
>         } else {
> -               for_each_online_node(nid) {
> +               for_each_node(nid) {
>                         pg_data_t *pgdat = NODE_DATA(nid);
> 
>                         build_zonelists(pgdat);

If we do have preallocated pgdat for all possible nodes that
for_each_online_node doesn't really need to exist.
 
> But there might be more missing. Onlining a new zone will get more
> expensive in setups with a lot of possible nodes (x86-64 shouldn't
> really be an issue in that regard).

Honestly, I am not really concerned by platforms with too many nodes
without any memory. If they want to shoot their feet then that's their
choice. We can optimize for those if they ever prove to be standar.
 
> If we want stable backports, we'll want something simple upfront.

For stable backports I would be fine by doing your NODE_DATA check in
the allocator. In upstream I think we should be aiming for a more robust
solution that is also easier to maintain further down the line. Even if
that is an investment at this momemnt because the initialization code is
a mess.
-- 
Michal Hocko
SUSE Labs
