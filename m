Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A830449E51B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242682AbiA0OuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:50:17 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38014 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiA0OuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:50:15 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CEEC3218DF;
        Thu, 27 Jan 2022 14:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643295014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IuUPkX2GjY5TwlCLKPLhoFT3kWymrWBCGUXDzqDp9Qc=;
        b=fsz8fEASQyPrKePs+n5wUNpLOdcgsxAYjPgggj9H5SYoP+0exdnDqJxsrCtczPFdwvg0Nq
        gdRArV9p9PIes4HMU7Cvz4ntg2aI5Tbc/TC3Ar1GqGvUMDR9RRcyYHya+6gxV0glRMpzVP
        qeDJ/xoaacpwaSlL091MzsFIgEapBTU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9EEF7A3B81;
        Thu, 27 Jan 2022 14:50:14 +0000 (UTC)
Date:   Thu, 27 Jan 2022 15:50:14 +0100
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
Subject: Re: [PATCH 2/6] mm: handle uninitialized numa nodes gracefully
Message-ID: <YfKxJl7HF4rJeVp7@dhcp22.suse.cz>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-3-mhocko@kernel.org>
 <bd0a9f4e-d204-6a06-ba3f-11acb6ac16c0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd0a9f4e-d204-6a06-ba3f-11acb6ac16c0@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27-01-22 13:41:16, David Hildenbrand wrote:
> On 27.01.22 09:53, Michal Hocko wrote:
[...]
> > diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
> > index 8dc8a554f774..dd0cf4834eaa 100644
> > --- a/arch/ia64/mm/discontig.c
> > +++ b/arch/ia64/mm/discontig.c
> > @@ -608,11 +608,11 @@ void __init paging_init(void)
> >  	zero_page_memmap_ptr = virt_to_page(ia64_imva(empty_zero_page));
> >  }
> >  
> > -pg_data_t *arch_alloc_nodedata(int nid)
> > +pg_data_t * __init arch_alloc_nodedata(int nid)
> >  {
> >  	unsigned long size = compute_pernodesize(nid);
> >  
> > -	return kzalloc(size, GFP_KERNEL);
> > +	return memblock_alloc(size, SMP_CACHE_BYTES);
> 
> I feel like we should have
> 
> long arch_pgdat_size(void) instead and have a generic allocation function.
> 
> But we can clean that up in the future.

I can have a look later (unless somebody beat me to it). I am not even
sure this whole ia64 weirdness is useful these days.

[...]
> > @@ -1445,9 +1445,6 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
> >  
> >  	return ret;
> >  error:
> > -	/* rollback pgdat allocation and others */
> > -	if (new_node)
> > -		rollback_node_hotadd(nid);
> 
> As static rollback_node_hotadd() is unused in this patch, doesn't this
> trigger a warning? IOW, maybe merge at least the rollback_node_hotadd()
> removal into this patch. The arch_free_nodedata() removal can stay separate.

It is my slight preference to have this patch smaller to be easier to
review and therefore I have removed all parts in a follow up. If a
warning is a real deal at this stage then I can change that of course.

> 
> >  	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
> >  		memblock_remove(start, size);
> >  error_mem_hotplug_end:
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 3589febc6d31..1a05669044d3 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -6402,7 +6402,11 @@ static void __build_all_zonelists(void *data)
> >  	if (self && !node_online(self->node_id)) {
> >  		build_zonelists(self);
> >  	} else {
> > -		for_each_online_node(nid) {
> > +		/*
> > +		 * All possible nodes have pgdat preallocated
> 
> ... in free_area_init() ?

Will fix it up.

> > +		 * free_area_init
> > +		 */
> > +		for_each_node(nid) {
> >  			pg_data_t *pgdat = NODE_DATA(nid);
> >  
> >  			build_zonelists(pgdat);
> > @@ -8096,8 +8100,32 @@ void __init free_area_init(unsigned long *max_zone_pfn)
> >  	/* Initialise every node */
> >  	mminit_verify_pageflags_layout();
> >  	setup_nr_node_ids();
> > -	for_each_online_node(nid) {
> > -		pg_data_t *pgdat = NODE_DATA(nid);
> > +	for_each_node(nid) {
> > +		pg_data_t *pgdat;
> > +
> > +		if (!node_online(nid)) {
> > +			pr_warn("Node %d uninitialized by the platform. Please report with boot dmesg.\n", nid);
> > +
> > +			/* Allocator not initialized yet */
> > +			pgdat = arch_alloc_nodedata(nid);
> > +			if (!pgdat) {
> > +				pr_err("Cannot allocate %zuB for node %d.\n",
> > +						sizeof(*pgdat), nid);
> > +				continue;
> > +			}
> > +			arch_refresh_nodedata(nid, pgdat);
> 
> We could get rid of arch_refresh_nodedata() now and simply merge that
> into arch_alloc_nodedata(). But depends on how we want to proceed with
> arch_alloc_nodedata() eventually.

yeah, I will postpone that to a later follow ups.
 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

Btw now I have realized that I have lost the following hung somewhere:

diff --git a/mm/internal.h b/mm/internal.h
index d80300392a19..43b8ccf56b7f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -718,4 +718,6 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
 int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 		      unsigned long addr, int page_nid, int *flags);
 
+DECLARE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1a05669044d3..4120cc855673 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6380,7 +6380,7 @@ static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonesta
 #define BOOT_PAGESET_BATCH	1
 static DEFINE_PER_CPU(struct per_cpu_pages, boot_pageset);
 static DEFINE_PER_CPU(struct per_cpu_zonestat, boot_zonestats);
-static DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
+DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
 
 static void __build_all_zonelists(void *data)
 {
-- 
Michal Hocko
SUSE Labs
