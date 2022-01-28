Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC5349F79A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347905AbiA1KvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:51:13 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58774 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347899AbiA1KvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:51:11 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 089201F384;
        Fri, 28 Jan 2022 10:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643367070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HXXJUsVu6KBr05BEsphBBuc05n3TkmH3M4jO3RzpAqk=;
        b=NgUhm/d9bqu531yCEK62+OTM9mebsemP65eo+WHcK3EfPbF9roInXCu75Xe8axqNykAWu2
        3Bfz49eMO3paQyPtuGMI+tIujKD/wfn+FubKFMqRTvZp2rO+AgItaRZ1cN5rcQn/z9ZGJK
        zg3Qic/BrFkrIZuPdeT89NYm7r1K9Fs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643367070;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HXXJUsVu6KBr05BEsphBBuc05n3TkmH3M4jO3RzpAqk=;
        b=VuJ1GI3HaFOXTrIa3HdqNd//4z/jIq1uH3uKh1y3sELROUwVJ5ebrp5Gga+7QjeHLBEuni
        U5Ppm2HddaT7kQAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E58BB13D17;
        Fri, 28 Jan 2022 10:51:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UZp+N53K82EoJwAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 28 Jan 2022 10:51:09 +0000
MIME-Version: 1.0
Date:   Fri, 28 Jan 2022 11:51:09 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Rafael Aquini <raquini@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 4/6] mm, memory_hotplug: reorganize new pgdat
 initialization
In-Reply-To: <20220127085305.20890-5-mhocko@kernel.org>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-5-mhocko@kernel.org>
User-Agent: Roundcube Webmail
Message-ID: <75e6aca7611ec2942b139aec0a437e7f@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-27 09:53, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> When a !node_online node is brought up it needs a hotplug specific
> initialization because the node could be either uninitialized yet or it
> could have been recycled after previous hotremove. hotadd_init_pgdat is
> responsible for that.
> 
> Internal pgdat state is initialized at two places currently
> 	- hotadd_init_pgdat
> 	- free_area_init_core_hotplug
> There is no real clear cut what should go where but this patch's chosen 
> to
> move the whole internal state initialization into 
> free_area_init_core_hotplug.
> hotadd_init_pgdat is still responsible to pull all the parts together -
> most notably to initialize zonelists because those depend on the
> overall topology.
> 
> This patch doesn't introduce any functional change.
> 
> Acked-by: Rafael Aquini <raquini@redhat.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

I have some comments below:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

>  	/*
>  	 * The node we allocated has no zone fallback lists. For avoiding
> @@ -1210,6 +1187,7 @@ static pg_data_t __ref *hotadd_init_pgdat(int 
> nid)
>  	 * When memory is hot-added, all the memory is in offline state. So
>  	 * clear all zones' present_pages because they will be updated in
>  	 * online_pages() and offline_pages().
> +	 * TODO: should be in free_area_init_core_hotplug?
>  	 */
>  	reset_node_managed_pages(pgdat);
>  	reset_node_present_pages(pgdat);

Most likely yes, but more below.

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1a05669044d3..32d0189de4c5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7506,12 +7506,33 @@ static void __meminit
> zone_init_internals(struct zone *zone, enum zone_type idx,
>   * NOTE: this function is only called during memory hotplug
>   */
>  #ifdef CONFIG_MEMORY_HOTPLUG
> -void __ref free_area_init_core_hotplug(int nid)
> +void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
>  {
> +	int nid = pgdat->node_id;
>  	enum zone_type z;
> -	pg_data_t *pgdat = NODE_DATA(nid);
> +	int cpu;
> 
>  	pgdat_init_internals(pgdat);
> +
> +	if (pgdat->per_cpu_nodestats == &boot_nodestats)
> +		pgdat->per_cpu_nodestats = alloc_percpu(struct per_cpu_nodestat);
> +
> +	/*
> +	 * Reset the nr_zones, order and highest_zoneidx before reuse.
> +	 * Note that kswapd will init kswapd_highest_zoneidx properly
> +	 * when it starts in the near future.
> +	 */
> +	pgdat->nr_zones = 0;
> +	pgdat->kswapd_order = 0;
> +	pgdat->kswapd_highest_zoneidx = 0;
> +	pgdat->node_start_pfn = 0;
> +	for_each_online_cpu(cpu) {
> +		struct per_cpu_nodestat *p;
> +
> +		p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
> +		memset(p, 0, sizeof(*p));
> +	}
> +

I am with David that the cleanest way would be to initialize all of this
(pgdat internals) only once at boot time now that we are initializing 
the
node anyway, and memory-offlining would have to wipe it out once last 
pgdat's
chunk of memory goes away.

I guess free_area_init_core_hotplug() would still need to allocate
alloc_percpu(struct per_cpu_nodestat) for the "new" node since doing it 
at
boot time is not desirable because of the memory waste on unused nodes.

As you said, probably worth looking at but not really something to cover 
on
this patchset at all.

-- 
Oscar Salvador
SUSE Labs
