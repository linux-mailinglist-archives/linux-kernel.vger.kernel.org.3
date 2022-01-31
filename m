Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8E14A454D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379542AbiAaLjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:39:13 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56750 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378790AbiAaL3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:29:13 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D2EE61F381;
        Mon, 31 Jan 2022 11:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643628551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zPNgT+q/xCKlHkk0NSxMXUpAG7WHosAzjep0b1A8ezM=;
        b=lKSXmvHjOIOlrrCXwbW4K0iLQAck2LuyaNX6qflNmUAeoSr7BL5hii9qNzgMhsPfIMtOHU
        WPdoKeGRitFIxnG8yMQDhoWwKWtIiIsCFhshk6NsrDTw047ub768uwI4yOgjKshSFnzNMz
        VXExSJzB0ijMPhL+RVX/zuPaXve6UBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643628551;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zPNgT+q/xCKlHkk0NSxMXUpAG7WHosAzjep0b1A8ezM=;
        b=jjVPeQGL8OIm5kTWIXgqdb+cNASKA4AuzhPOxpzJ6YIwDwRFvTjEwnjihZ5lp7phyQVaKF
        Nw7A01/hvRTWRWAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D74413C23;
        Mon, 31 Jan 2022 11:29:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lDF5CwfI92EZTgAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 31 Jan 2022 11:29:11 +0000
Date:   Mon, 31 Jan 2022 12:29:09 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rafael Parra <rparrazo@redhat.com>
Subject: Re: [PATCH v1 2/2] drivers/base/memory: determine and store zone for
 single-zone memory blocks
Message-ID: <20220131112909.GB18027@linux>
References: <20220128152620.168715-1-david@redhat.com>
 <20220128152620.168715-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128152620.168715-3-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 04:26:20PM +0100, David Hildenbrand wrote:
> For memory hot(un)plug, we only really care about memory blocks that:
> * span a single zone (and, thereby, a single node)
> * are completely System RAM (IOW, no holes, no ZONE_DEVICE)
> If one of these conditions is not met, we reject memory offlining.
> Hotplugged memory blocks (starting out offline), always meet both
> conditions.

This has been always hard for me to follow, so bear with me.

I remember we changed the memory-hotplug policy, not long ago, wrt.
what we can online/offline so we could get rid of certain assumptions like
"there are no holes in this memblock, so it can go" etc.

AFAIR, we can only offline if the memory

1) belongs to a single node ("which is always the case for
   hotplugged-memory, boot memory is trickier")
2) does not have any holes
3) spans a single zone

These are the only requeriments we have atm, right?

By default, hotplugged memory already complies with they all three,
only in case of ZONE_DEVICE stuff we might violate 2) and 3).

> There are three scenarios to handle:
...
...

> @@ -225,6 +226,9 @@ static int memory_block_offline(struct memory_block *mem)
>  	unsigned long nr_vmemmap_pages = mem->nr_vmemmap_pages;
>  	int ret;
>  
> +	if (!mem->zone)
> +		return -EBUSY;

Should not we return -EINVAL? I mean, -EBUSY reads like this might be a
temporary error which might get fixed later on, but that isn't the case.

> @@ -234,7 +238,7 @@ static int memory_block_offline(struct memory_block *mem)
>  					  -nr_vmemmap_pages);
>  
>  	ret = offline_pages(start_pfn + nr_vmemmap_pages,
> -			    nr_pages - nr_vmemmap_pages, mem->group);
> +			    nr_pages - nr_vmemmap_pages, mem->zone, mem->group);

Why not passing the node as well? 

> +static struct zone *early_node_zone_for_memory_block(struct memory_block *mem,
> +						     int nid)
> +{
> +	const unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
> +	const unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
> +	struct zone *zone, *matching_zone = NULL;
> +	pg_data_t *pgdat = NODE_DATA(nid);

I was about to complain because in init_memory_block() you call
early_node_zone_for_memory_block() with nid == NUMA_NODE_NODE, but then
I saw that NODE_DATA on !CONFIG_NUMA falls to contig_page_data.
So, I guess we cannot really reach this on CONFIG_NUMA machines with nid
being NUMA_NO_NODE, right? (do we want to add a check just in case?)

> +#ifdef CONFIG_NUMA
> +void memory_block_set_nid(struct memory_block *mem, int nid,
> +			  enum meminit_context context)

But we also set the zone? (Only for boot memory)

> @@ -663,6 +734,17 @@ static int init_memory_block(unsigned long block_id, unsigned long state,
>  	mem->nr_vmemmap_pages = nr_vmemmap_pages;
>  	INIT_LIST_HEAD(&mem->group_next);
>  
> +#ifndef CONFIG_NUMA
> +	if (state == MEM_ONLINE)
> +		/*
> +		 * MEM_ONLINE at this point imples early memory. With NUMA,
                                            implies


-- 
Oscar Salvador
SUSE Labs
