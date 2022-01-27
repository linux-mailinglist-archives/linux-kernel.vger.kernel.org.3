Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC2B49DE41
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238709AbiA0Jlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiA0Jls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:41:48 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228A7C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 01:41:48 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id v74so2162877pfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 01:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FwGYXa/4Ke/nl7w6rwwFT93Jqd/KRsceKw3bmpTizd0=;
        b=c7f7zsHi9kFYEI3DLIcZJNkTZ6mwWpT5jJzA3XquJWSc3nVDPyVjgD2LDaCRl2f49L
         E8jlbenDE0bp4V7semQXNIXUMfqgcbPy4QzrW1xm3E1yq4f80G0IKO2ZnQJGUKgAEqKN
         VXG0hltwq4W/ZVrupfCfQ+uI3sCzmcdEzRr4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FwGYXa/4Ke/nl7w6rwwFT93Jqd/KRsceKw3bmpTizd0=;
        b=Fzh7bdWWuiZKcWrcyqOoPVHFNJRcsou9Yz9aA4btIW5wMnUN1jjXpyMZ0+33+lbQut
         1V7mJMolE+7BAwmIBX+3hvFTUrh937pAnxl3dYTsLX2wmR5BSnGbkLVOf6Q5tsOw7O6w
         XhmO3bhdcaDlhq2sZg5iVKWh+6DC81bcY4ih3nQhD0l5bMwGbv7V0A6Kab+id1q50oJO
         9uf1sCV7+8GOpcPAVHIL2bnvK5DL78SZzf/CUYOkMI1q07xJqJYLqO++tjAsn1QiAa61
         nVl/4mDKD68BImG+E5xKaWY3kdTdDhhKShzLCwalYPu5HWltmjxC8sftkSpEzQi96jQH
         kRpg==
X-Gm-Message-State: AOAM531Xx591JubLV/lRZnWsxmP7gxzRQjF26B+GaXSh3E8psH7njc9+
        QsUxYAv23pt0Jo5V4O6QQ0SkOQ==
X-Google-Smtp-Source: ABdhPJyqApfUm7sSZ0dQD2FVycwOL7CDbEG0tcN66TiQouXhJL6YT0Y3ygdGR6HPOBbUNgizsWukrw==
X-Received: by 2002:a63:d54:: with SMTP id 20mr2276891pgn.442.1643276507407;
        Thu, 27 Jan 2022 01:41:47 -0800 (PST)
Received: from swarm08 ([210.107.197.32])
        by smtp.gmail.com with ESMTPSA id t17sm5695302pgm.69.2022.01.27.01.41.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jan 2022 01:41:46 -0800 (PST)
Date:   Thu, 27 Jan 2022 18:41:42 +0900
From:   Jonghyeon Kim <tome01@ajou.ac.kr>
To:     David Hildenbrand <david@redhat.com>
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, akpm@linux-foundation.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm/memory_hotplug: Export shrink span functions for
 zone and node
Message-ID: <20220127094142.GA31409@swarm08>
References: <20220126170002.19754-1-tome01@ajou.ac.kr>
 <5d02ea0e-aca6-a64b-23de-bc9307572d17@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d02ea0e-aca6-a64b-23de-bc9307572d17@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 06:04:50PM +0100, David Hildenbrand wrote:
> On 26.01.22 18:00, Jonghyeon Kim wrote:
> > Export shrink_zone_span() and update_pgdat_span() functions to head
> > file. We need to update real number of spanned pages for NUMA nodes and
> > zones when we add memory device node such as device dax memory.
> > 
> 
> Can you elaborate a bit more what you intend to fix?
> 
> Memory onlining/offlining is reponsible for updating the node/zone span,
> and that's triggered when the dax/kmem mamory gets onlined/offlined.
> 
Sure, sorry for the lack of explanation of the intended fix.

Before onlining nvdimm memory using dax(devdax or fsdax), these memory belong to
cpu NUMA nodes, which extends span pages of node/zone as a ZONE_DEVICE. So there
is no problem because node/zone contain these additional non-visible memory
devices to the system.
But, if we online dax-memory, zone[ZONE_DEVICE] of CPU NUMA node is hot-plugged
to new NUMA node(but CPU-less). I think there is no need to hold
zone[ZONE_DEVICE] pages on the original node.

Additionally, spanned pages are also used to calculate the end pfn of a node.
Thus, it is needed to maintain accurate page stats for node/zone.

My machine contains two CPU-socket consisting of DRAM and Intel DCPMM
(DC persistent memory modules) with App-Direct mode.

Below are my test results.

Before memory onlining:

	# ndctl create-namespace --mode=devdax
	# ndctl create-namespace --mode=devdax
	# cat /proc/zoneinfo | grep -E "Node|spanned" | paste - -
	Node 0, zone      DMA	        spanned  4095
	Node 0, zone    DMA32	        spanned  1044480
	Node 0, zone   Normal	        spanned  7864320
	Node 0, zone  Movable	        spanned  0
	Node 0, zone   Device	        spanned  66060288
	Node 1, zone      DMA	        spanned  0
	Node 1, zone    DMA32	        spanned  0
	Node 1, zone   Normal	        spanned  8388608
	Node 1, zone  Movable	        spanned  0
	Node 1, zone   Device	        spanned  66060288

After memory onlining:

	# daxctl reconfigure-device --mode=system-ram --no-online dax0.0
	# daxctl reconfigure-device --mode=system-ram --no-online dax1.0

	# cat /proc/zoneinfo | grep -E "Node|spanned" | paste - -
	Node 0, zone      DMA	        spanned  4095
	Node 0, zone    DMA32	        spanned  1044480
	Node 0, zone   Normal	        spanned  7864320
	Node 0, zone  Movable	        spanned  0
	Node 0, zone   Device	        spanned  66060288
	Node 1, zone      DMA	        spanned  0
	Node 1, zone    DMA32	        spanned  0
	Node 1, zone   Normal	        spanned  8388608
	Node 1, zone  Movable	        spanned  0
	Node 1, zone   Device	        spanned  66060288
	Node 2, zone      DMA	        spanned  0
	Node 2, zone    DMA32	        spanned  0
	Node 2, zone   Normal	        spanned  65011712
	Node 2, zone  Movable	        spanned  0
	Node 2, zone   Device	        spanned  0
	Node 3, zone      DMA	        spanned  0
	Node 3, zone    DMA32	        spanned  0
	Node 3, zone   Normal	        spanned  65011712
	Node 3, zone  Movable	        spanned  0
	Node 3, zone   Device	        spanned  0

As we can see, Node 0 and 1 still have zone_device pages after memory onlining.
This causes problem that Node 0 and Node 2 have same end of pfn values, also 
Node 1 and Node 3 have same problem.

> > Signed-off-by: Jonghyeon Kim <tome01@ajou.ac.kr>
> > ---
> >  include/linux/memory_hotplug.h | 3 +++
> >  mm/memory_hotplug.c            | 6 ++++--
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> > index be48e003a518..25c7f60c317e 100644
> > --- a/include/linux/memory_hotplug.h
> > +++ b/include/linux/memory_hotplug.h
> > @@ -337,6 +337,9 @@ extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
> >  extern void remove_pfn_range_from_zone(struct zone *zone,
> >  				       unsigned long start_pfn,
> >  				       unsigned long nr_pages);
> > +extern void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
> > +			     unsigned long end_pfn);
> > +extern void update_pgdat_span(struct pglist_data *pgdat);
> >  extern bool is_memblock_offlined(struct memory_block *mem);
> >  extern int sparse_add_section(int nid, unsigned long pfn,
> >  		unsigned long nr_pages, struct vmem_altmap *altmap);
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 2a9627dc784c..38f46a9ef853 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -389,7 +389,7 @@ static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
> >  	return 0;
> >  }
> >  
> > -static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
> > +void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
> >  			     unsigned long end_pfn)
> >  {
> >  	unsigned long pfn;
> > @@ -428,8 +428,9 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
> >  		}
> >  	}
> >  }
> > +EXPORT_SYMBOL_GPL(shrink_zone_span);
> 
> Exporting both as symbols feels very wrong. This is memory
> onlining/offlining internal stuff.

I agree with you that your comment. I will find another approach to avoid
directly using onlining/offlining internal stuff while updating node/zone span.


Thanks,
Jonghyeon
> 
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
