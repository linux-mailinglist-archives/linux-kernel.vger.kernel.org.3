Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157CF49E2D2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241311AbiA0Mq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:46:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47664 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229689AbiA0Mq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643287618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ALFiThAZRei2Ll9xqqRD4pC1dm+F070gAZM4sCDYH80=;
        b=Z01l5c3vzXqj4q2pXscLHL0+2vXvuGtvRCe5U6fsxnz/Q9Inuq4LV40AuSc7pYSglxIivZ
        KNwVnrMCZDFHQv/axYNc1ZQD/cI/oon3CSVwfkge4WSnxQAgWwDgAISBKuLaMaOiv+4b+J
        eRKJa9+AnJ2mZfOpeI8axiav0vw7VwE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-EepEBd15O4KWNsbF8KEWzw-1; Thu, 27 Jan 2022 07:46:57 -0500
X-MC-Unique: EepEBd15O4KWNsbF8KEWzw-1
Received: by mail-ej1-f71.google.com with SMTP id q19-20020a1709064c9300b006b39291ff3eso1291735eju.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 04:46:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ALFiThAZRei2Ll9xqqRD4pC1dm+F070gAZM4sCDYH80=;
        b=p15KtOeQSO+9TpH/EveT0Vnh6ii/TteauLyFYkvKn9GiL8UMCzlJK80E/Jj4EhZHEy
         q1+dbvHsaVr2gCcJI0bUjLnUcv8XrZupVX++wYURJLXXqWP+zrw/m7WG/H0SWCrQxaIB
         U2iw/9iwuBCYnn+ecRRgjdqWEGaDfcOVn0zS0UGdSCYqZXcMVQVJNTL8nc+CCOibo649
         BgqbCflpKV6AvtUgJZROvhLu4pxZMCj7Ck5H2A+UlaZujXnBI+znj1+5KGlW6AA7wlWc
         whCv+lWmEFyuAKjGys4kiohVLJvFExqbcx/p31vPfJKAZhbGgAHcTMRInwAN3JYVfUqJ
         JG/g==
X-Gm-Message-State: AOAM531EQ2stcRLkbAzkrH9dQPOwLk+H8Bi1yNBDOpydlhGeR24BQEL7
        aWPP2fkBzu01m1YqBqxag+EJnraJ92xbFA0bESjkOr3OP+HnfK+HxSTDeYLtstVRXGxltoszHWI
        Qsjcmlei8SU4i2OjFgglt/dvt
X-Received: by 2002:a17:907:a089:: with SMTP id hu9mr2860958ejc.680.1643287615798;
        Thu, 27 Jan 2022 04:46:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyKNRDuVEw6gMC+JHMbjWpjotLdKjF4OPfTstmx43Retq5GPIkHdVhIpby1+MaA873czLwcvg==
X-Received: by 2002:a17:907:a089:: with SMTP id hu9mr2860944ejc.680.1643287615503;
        Thu, 27 Jan 2022 04:46:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:8300:4812:9d4f:6cd8:7f47? (p200300cbc70d830048129d4f6cd87f47.dip0.t-ipconnect.de. [2003:cb:c70d:8300:4812:9d4f:6cd8:7f47])
        by smtp.gmail.com with ESMTPSA id kq16sm8632834ejb.163.2022.01.27.04.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 04:46:54 -0800 (PST)
Message-ID: <6db33bb0-c72a-5539-5873-14039702e2a3@redhat.com>
Date:   Thu, 27 Jan 2022 13:46:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 4/6] mm, memory_hotplug: reorganize new pgdat
 initialization
Content-Language: en-US
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Rafael Aquini <raquini@redhat.com>,
        Michal Hocko <mhocko@suse.com>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-5-mhocko@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220127085305.20890-5-mhocko@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.22 09:53, Michal Hocko wrote:
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
> There is no real clear cut what should go where but this patch's chosen to
> move the whole internal state initialization into free_area_init_core_hotplug.
> hotadd_init_pgdat is still responsible to pull all the parts together -
> most notably to initialize zonelists because those depend on the overall topology.
> 
> This patch doesn't introduce any functional change.
> 
> Acked-by: Rafael Aquini <raquini@redhat.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  include/linux/memory_hotplug.h |  2 +-
>  mm/memory_hotplug.c            | 28 +++-------------------------
>  mm/page_alloc.c                | 25 +++++++++++++++++++++++--
>  3 files changed, 27 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 60f09d3ebb3d..76bf2de86def 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -319,7 +319,7 @@ extern void set_zone_contiguous(struct zone *zone);
>  extern void clear_zone_contiguous(struct zone *zone);
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
> -extern void __ref free_area_init_core_hotplug(int nid);
> +extern void __ref free_area_init_core_hotplug(struct pglist_data *pgdat);
>  extern int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
>  extern int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
>  extern int add_memory_resource(int nid, struct resource *resource,
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 875cdc7ffa58..ddc62f8b591f 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1166,39 +1166,16 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
>  {
>  	struct pglist_data *pgdat;
>  
> -	pgdat = NODE_DATA(nid);
> -
>  	/*
>  	 * NODE_DATA is preallocated (free_area_init) but its internal
>  	 * state is not allocated completely. Add missing pieces.
>  	 * Completely offline nodes stay around and they just need
>  	 * reintialization.
>  	 */
> -	if (pgdat->per_cpu_nodestats == &boot_nodestats) {
> -		pgdat->per_cpu_nodestats =
> -			alloc_percpu(struct per_cpu_nodestat);
> -	} else {
> -		int cpu;
> -		/*
> -		 * Reset the nr_zones, order and highest_zoneidx before reuse.
> -		 * Note that kswapd will init kswapd_highest_zoneidx properly
> -		 * when it starts in the near future.
> -		 */
> -		pgdat->nr_zones = 0;
> -		pgdat->kswapd_order = 0;
> -		pgdat->kswapd_highest_zoneidx = 0;
> -		for_each_online_cpu(cpu) {
> -			struct per_cpu_nodestat *p;
> -
> -			p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
> -			memset(p, 0, sizeof(*p));
> -		}
> -	}
> -
> -	pgdat->node_start_pfn = 0;
> +	pgdat = NODE_DATA(nid);
>  
>  	/* init node's zones as empty zones, we don't have any present pages.*/
> -	free_area_init_core_hotplug(nid);
> +	free_area_init_core_hotplug(pgdat);
>  
>  	/*
>  	 * The node we allocated has no zone fallback lists. For avoiding
> @@ -1210,6 +1187,7 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
>  	 * When memory is hot-added, all the memory is in offline state. So
>  	 * clear all zones' present_pages because they will be updated in
>  	 * online_pages() and offline_pages().
> +	 * TODO: should be in free_area_init_core_hotplug?
>  	 */
>  	reset_node_managed_pages(pgdat);
>  	reset_node_present_pages(pgdat);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1a05669044d3..32d0189de4c5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7506,12 +7506,33 @@ static void __meminit zone_init_internals(struct zone *zone, enum zone_type idx,
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
>  	for (z = 0; z < MAX_NR_ZONES; z++)
>  		zone_init_internals(&pgdat->node_zones[z], z, nid, 0);
>  }

I feel like we should be initializing all of this only once, just after
allocating the node. There should be no difference between a node we're
reusing and a "fresh" node. IOW, memory offlining should be resetting
all state accordingly when the last memory goes away.

But I might be wrong and this patch looks like an improvement, as you
say,  without functional change

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

