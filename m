Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E95149E4E4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242562AbiA0Oo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:44:27 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42318 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242557AbiA0Oo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:44:26 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5C51D1F3A9;
        Thu, 27 Jan 2022 14:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643294665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cr3ctQmKfbS4sGDuTWUwYiSQNoJONGqojhFsGxcH7XU=;
        b=HLr6Nh4iXXcg6paXWYBSgWX/X7dUFH0wcYEmVU9d3f/bR9kxvYPT9BfNP13nE0rRwMPbth
        hjTjpyOsIqzTB1I8aSnM9kpc7v6mHZls3zH+TpcKUjQz/EyA22IxKSzlbbzB+Eg1fA0FMj
        4Ku9jyRdAT06U+XqjfcEIL6jnc494HA=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0991DA3B87;
        Thu, 27 Jan 2022 14:44:24 +0000 (UTC)
Date:   Thu, 27 Jan 2022 15:44:21 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Rafael Aquini <raquini@redhat.com>
Subject: Re: [PATCH 4/6] mm, memory_hotplug: reorganize new pgdat
 initialization
Message-ID: <YfKvxVkkJ415DH4t@dhcp22.suse.cz>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-5-mhocko@kernel.org>
 <6db33bb0-c72a-5539-5873-14039702e2a3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6db33bb0-c72a-5539-5873-14039702e2a3@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27-01-22 13:46:53, David Hildenbrand wrote:
> On 27.01.22 09:53, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > When a !node_online node is brought up it needs a hotplug specific
> > initialization because the node could be either uninitialized yet or it
> > could have been recycled after previous hotremove. hotadd_init_pgdat is
> > responsible for that.
> > 
> > Internal pgdat state is initialized at two places currently
> > 	- hotadd_init_pgdat
> > 	- free_area_init_core_hotplug
> > There is no real clear cut what should go where but this patch's chosen to
> > move the whole internal state initialization into free_area_init_core_hotplug.
> > hotadd_init_pgdat is still responsible to pull all the parts together -
> > most notably to initialize zonelists because those depend on the overall topology.
> > 
> > This patch doesn't introduce any functional change.
> > 
> > Acked-by: Rafael Aquini <raquini@redhat.com>
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  include/linux/memory_hotplug.h |  2 +-
> >  mm/memory_hotplug.c            | 28 +++-------------------------
> >  mm/page_alloc.c                | 25 +++++++++++++++++++++++--
> >  3 files changed, 27 insertions(+), 28 deletions(-)
> > 
> > diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> > index 60f09d3ebb3d..76bf2de86def 100644
> > --- a/include/linux/memory_hotplug.h
> > +++ b/include/linux/memory_hotplug.h
> > @@ -319,7 +319,7 @@ extern void set_zone_contiguous(struct zone *zone);
> >  extern void clear_zone_contiguous(struct zone *zone);
> >  
> >  #ifdef CONFIG_MEMORY_HOTPLUG
> > -extern void __ref free_area_init_core_hotplug(int nid);
> > +extern void __ref free_area_init_core_hotplug(struct pglist_data *pgdat);
> >  extern int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
> >  extern int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
> >  extern int add_memory_resource(int nid, struct resource *resource,
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 875cdc7ffa58..ddc62f8b591f 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1166,39 +1166,16 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
> >  {
> >  	struct pglist_data *pgdat;
> >  
> > -	pgdat = NODE_DATA(nid);
> > -
> >  	/*
> >  	 * NODE_DATA is preallocated (free_area_init) but its internal
> >  	 * state is not allocated completely. Add missing pieces.
> >  	 * Completely offline nodes stay around and they just need
> >  	 * reintialization.
> >  	 */
> > -	if (pgdat->per_cpu_nodestats == &boot_nodestats) {
> > -		pgdat->per_cpu_nodestats =
> > -			alloc_percpu(struct per_cpu_nodestat);
> > -	} else {
> > -		int cpu;
> > -		/*
> > -		 * Reset the nr_zones, order and highest_zoneidx before reuse.
> > -		 * Note that kswapd will init kswapd_highest_zoneidx properly
> > -		 * when it starts in the near future.
> > -		 */
> > -		pgdat->nr_zones = 0;
> > -		pgdat->kswapd_order = 0;
> > -		pgdat->kswapd_highest_zoneidx = 0;
> > -		for_each_online_cpu(cpu) {
> > -			struct per_cpu_nodestat *p;
> > -
> > -			p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
> > -			memset(p, 0, sizeof(*p));
> > -		}
> > -	}
> > -
> > -	pgdat->node_start_pfn = 0;
> > +	pgdat = NODE_DATA(nid);
> >  
> >  	/* init node's zones as empty zones, we don't have any present pages.*/
> > -	free_area_init_core_hotplug(nid);
> > +	free_area_init_core_hotplug(pgdat);
> >  
> >  	/*
> >  	 * The node we allocated has no zone fallback lists. For avoiding
> > @@ -1210,6 +1187,7 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
> >  	 * When memory is hot-added, all the memory is in offline state. So
> >  	 * clear all zones' present_pages because they will be updated in
> >  	 * online_pages() and offline_pages().
> > +	 * TODO: should be in free_area_init_core_hotplug?
> >  	 */
> >  	reset_node_managed_pages(pgdat);
> >  	reset_node_present_pages(pgdat);
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 1a05669044d3..32d0189de4c5 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -7506,12 +7506,33 @@ static void __meminit zone_init_internals(struct zone *zone, enum zone_type idx,
> >   * NOTE: this function is only called during memory hotplug
> >   */
> >  #ifdef CONFIG_MEMORY_HOTPLUG
> > -void __ref free_area_init_core_hotplug(int nid)
> > +void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
> >  {
> > +	int nid = pgdat->node_id;
> >  	enum zone_type z;
> > -	pg_data_t *pgdat = NODE_DATA(nid);
> > +	int cpu;
> >  
> >  	pgdat_init_internals(pgdat);
> > +
> > +	if (pgdat->per_cpu_nodestats == &boot_nodestats)
> > +		pgdat->per_cpu_nodestats = alloc_percpu(struct per_cpu_nodestat);
> > +
> > +	/*
> > +	 * Reset the nr_zones, order and highest_zoneidx before reuse.
> > +	 * Note that kswapd will init kswapd_highest_zoneidx properly
> > +	 * when it starts in the near future.
> > +	 */
> > +	pgdat->nr_zones = 0;
> > +	pgdat->kswapd_order = 0;
> > +	pgdat->kswapd_highest_zoneidx = 0;
> > +	pgdat->node_start_pfn = 0;
> > +	for_each_online_cpu(cpu) {
> > +		struct per_cpu_nodestat *p;
> > +
> > +		p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
> > +		memset(p, 0, sizeof(*p));
> > +	}
> > +
> >  	for (z = 0; z < MAX_NR_ZONES; z++)
> >  		zone_init_internals(&pgdat->node_zones[z], z, nid, 0);
> >  }
> 
> I feel like we should be initializing all of this only once, just after
> allocating the node. There should be no difference between a node we're
> reusing and a "fresh" node. IOW, memory offlining should be resetting
> all state accordingly when the last memory goes away.
> 
> But I might be wrong and this patch looks like an improvement, as you
> say,  without functional change

Yeah, I really wanted to have this simple and straightforward. To be
completely honest I am not even sure this is necessary. Something really
woth looking at.
 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

-- 
Michal Hocko
SUSE Labs
