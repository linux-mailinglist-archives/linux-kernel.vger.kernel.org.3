Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A7649E2A5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241281AbiA0Mlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:41:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21177 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241348AbiA0MlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:41:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643287281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hvAo5QlK3H5GxGbJpEb64PFxW7ROg93xTSyxmQhLPBA=;
        b=P3WepLnptQuVHVG/ez6QJfx1YU3ugqCwB1rlfle1eZbRFjoFdpb+LQD13crlDtI6DFSGzm
        LptWdelT55JiFVHVBaOCoNiA4Oh7eYkEfp6J3KfX+sajFDwlibcfE8t5RlIKcTfnI3MfzL
        94RalJhSBxlkodguU7aH5FPYFHNPwIE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-foh9CAMUOZqV46aEQRDTwQ-1; Thu, 27 Jan 2022 07:41:20 -0500
X-MC-Unique: foh9CAMUOZqV46aEQRDTwQ-1
Received: by mail-wm1-f72.google.com with SMTP id q71-20020a1ca74a000000b003507f38e330so4064191wme.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 04:41:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=hvAo5QlK3H5GxGbJpEb64PFxW7ROg93xTSyxmQhLPBA=;
        b=MPmfSKgmjvce+E17w6mWp/QifHPuWo21T2z0og9mSsbUUKL4k0tlyo/xjYSMJ2I/w0
         rrGfJkNvWW5WKo/4sTBCJMhI+/ezpNsbuBlkpgwP4wLqJ3gLN/wtkOoNWHoIm8+x//Bb
         RdYXo32QMbFhZBYbY6UzRB1Kuuyu9sy2vDql1IIzy0mFF1A8+peX0ulm9+ZRN+Pyd0/V
         GzKc/tne7it2ZLi5OybblRUe4W1QCzlnMhh55Xv0IDD07tFHrQB+FsQ2TZ7FTIiQMC3k
         MKEhoWtP+kwH3muBv0nLw+1V9Kqpl02PzOMpTH8z8BwQNtvvOTrkj2+zZIdXATF9JXe0
         qMhw==
X-Gm-Message-State: AOAM530xAyKcDGyPSDDlgLBO09TCYirHW5r25MTyqH69/obDKH1mpdg5
        Vt6M7NNJV7L0MFBmBZOgS8AbC2BsRQE/GpiBibOx1LDkeENE7+fUwN0qmQLskeLM3JGbx6Vi8u3
        4FVmSNglgZb4a748oIE1p60s9
X-Received: by 2002:adf:ff83:: with SMTP id j3mr3059683wrr.10.1643287278292;
        Thu, 27 Jan 2022 04:41:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwGAGPPvFXB/zCtCTwuXrgg1TJMTcVdhn53hlZf71PCFo8QDuDBsUivH5zYeKUopxF3p7Drvw==
X-Received: by 2002:adf:ff83:: with SMTP id j3mr3059650wrr.10.1643287277704;
        Thu, 27 Jan 2022 04:41:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:8300:4812:9d4f:6cd8:7f47? (p200300cbc70d830048129d4f6cd87f47.dip0.t-ipconnect.de. [2003:cb:c70d:8300:4812:9d4f:6cd8:7f47])
        by smtp.gmail.com with ESMTPSA id l5sm1955455wmq.7.2022.01.27.04.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 04:41:17 -0800 (PST)
Message-ID: <bd0a9f4e-d204-6a06-ba3f-11acb6ac16c0@redhat.com>
Date:   Thu, 27 Jan 2022 13:41:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
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
 <20220127085305.20890-3-mhocko@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 2/6] mm: handle uninitialized numa nodes gracefully
In-Reply-To: <20220127085305.20890-3-mhocko@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.22 09:53, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> We have had several reports [1][2][3] that page allocator blows up when
> an allocation from a possible node is requested. The underlying reason
> is that NODE_DATA for the specific node is not allocated.
> 
> NUMA specific initialization is arch specific and it can vary a lot.
> E.g. x86 tries to initialize all nodes that have some cpu affinity (see
> init_cpu_to_node) but this can be insufficient because the node might be
> cpuless for example.
> 
> One way to address this problem would be to check for !node_online nodes
> when trying to get a zonelist and silently fall back to another node.
> That is unfortunately adding a branch into allocator hot path and it
> doesn't handle any other potential NODE_DATA users.
> 
> This patch takes a different approach (following a lead of [3]) and it
> pre allocates pgdat for all possible nodes in an arch indipendent code
> - free_area_init. All uninitialized nodes are treated as memoryless
> nodes. node_state of the node is not changed because that would lead to
> other side effects - e.g. sysfs representation of such a node and from
> past discussions [4] it is known that some tools might have problems
> digesting that.
> 
> Newly allocated pgdat only gets a minimal initialization and the rest of
> the work is expected to be done by the memory hotplug - hotadd_new_pgdat
> (renamed to hotadd_init_pgdat).
> 
> generic_alloc_nodedata is changed to use the memblock allocator because
> neither page nor slab allocators are available at the stage when all
> pgdats are allocated. Hotplug doesn't allocate pgdat anymore so we can
> use the early boot allocator. The only arch specific implementation is
> ia64 and that is changed to use the early allocator as well.
> 
> Reported-by: Alexey Makhalov <amakhalov@vmware.com>
> Tested-by: Alexey Makhalov <amakhalov@vmware.com>
> Reported-by: Nico Pache <npache@redhat.com>
> Acked-by: Rafael Aquini <raquini@redhat.com>
> Tested-by: Rafael Aquini <raquini@redhat.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> [1] http://lkml.kernel.org/r/20211101201312.11589-1-amakhalov@vmware.com
> [2] http://lkml.kernel.org/r/20211207224013.880775-1-npache@redhat.com
> [3] http://lkml.kernel.org/r/20190114082416.30939-1-mhocko@kernel.org
> [4] http://lkml.kernel.org/r/20200428093836.27190-1-srikar@linux.vnet.ibm.com
> ---
>  arch/ia64/mm/discontig.c       |  4 ++--
>  include/linux/memory_hotplug.h |  2 +-
>  mm/memory_hotplug.c            | 21 +++++++++------------
>  mm/page_alloc.c                | 34 +++++++++++++++++++++++++++++++---
>  4 files changed, 43 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
> index 8dc8a554f774..dd0cf4834eaa 100644
> --- a/arch/ia64/mm/discontig.c
> +++ b/arch/ia64/mm/discontig.c
> @@ -608,11 +608,11 @@ void __init paging_init(void)
>  	zero_page_memmap_ptr = virt_to_page(ia64_imva(empty_zero_page));
>  }
>  
> -pg_data_t *arch_alloc_nodedata(int nid)
> +pg_data_t * __init arch_alloc_nodedata(int nid)
>  {
>  	unsigned long size = compute_pernodesize(nid);
>  
> -	return kzalloc(size, GFP_KERNEL);
> +	return memblock_alloc(size, SMP_CACHE_BYTES);

I feel like we should have

long arch_pgdat_size(void) instead and have a generic allocation function.

But we can clean that up in the future.

>  }
>  
>  void arch_free_nodedata(pg_data_t *pgdat)
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 4355983b364d..cdd66bfdf855 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -44,7 +44,7 @@ extern void arch_refresh_nodedata(int nid, pg_data_t *pgdat);
>   */
>  #define generic_alloc_nodedata(nid)				\
>  ({								\
> -	kzalloc(sizeof(pg_data_t), GFP_KERNEL);			\
> +	memblock_alloc(sizeof(*pgdat), SMP_CACHE_BYTES);	\
>  })
>  /*
>   * This definition is just for error path in node hotadd.
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 2a9627dc784c..fc991831d296 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1162,19 +1162,21 @@ static void reset_node_present_pages(pg_data_t *pgdat)
>  }
>  
>  /* we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG */
> -static pg_data_t __ref *hotadd_new_pgdat(int nid)
> +static pg_data_t __ref *hotadd_init_pgdat(int nid)
>  {
>  	struct pglist_data *pgdat;
>  
>  	pgdat = NODE_DATA(nid);
> -	if (!pgdat) {
> -		pgdat = arch_alloc_nodedata(nid);
> -		if (!pgdat)
> -			return NULL;
>  
> +	/*
> +	 * NODE_DATA is preallocated (free_area_init) but its internal
> +	 * state is not allocated completely. Add missing pieces.
> +	 * Completely offline nodes stay around and they just need
> +	 * reintialization.
> +	 */
> +	if (pgdat->per_cpu_nodestats == &boot_nodestats) {
>  		pgdat->per_cpu_nodestats =
>  			alloc_percpu(struct per_cpu_nodestat);
> -		arch_refresh_nodedata(nid, pgdat);
>  	} else {
>  		int cpu;
>  		/*
> @@ -1193,8 +1195,6 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid)
>  		}
>  	}
>  
> -	/* we can use NODE_DATA(nid) from here */
> -	pgdat->node_id = nid;
>  	pgdat->node_start_pfn = 0;
>  
>  	/* init node's zones as empty zones, we don't have any present pages.*/
> @@ -1246,7 +1246,7 @@ static int __try_online_node(int nid, bool set_node_online)
>  	if (node_online(nid))
>  		return 0;
>  
> -	pgdat = hotadd_new_pgdat(nid);
> +	pgdat = hotadd_init_pgdat(nid);
>  	if (!pgdat) {
>  		pr_err("Cannot online node %d due to NULL pgdat\n", nid);
>  		ret = -ENOMEM;
> @@ -1445,9 +1445,6 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  
>  	return ret;
>  error:
> -	/* rollback pgdat allocation and others */
> -	if (new_node)
> -		rollback_node_hotadd(nid);

As static rollback_node_hotadd() is unused in this patch, doesn't this
trigger a warning? IOW, maybe merge at least the rollback_node_hotadd()
removal into this patch. The arch_free_nodedata() removal can stay separate.

>  	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
>  		memblock_remove(start, size);
>  error_mem_hotplug_end:
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3589febc6d31..1a05669044d3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6402,7 +6402,11 @@ static void __build_all_zonelists(void *data)
>  	if (self && !node_online(self->node_id)) {
>  		build_zonelists(self);
>  	} else {
> -		for_each_online_node(nid) {
> +		/*
> +		 * All possible nodes have pgdat preallocated

... in free_area_init() ?

> +		 * free_area_init
> +		 */
> +		for_each_node(nid) {
>  			pg_data_t *pgdat = NODE_DATA(nid);
>  
>  			build_zonelists(pgdat);
> @@ -8096,8 +8100,32 @@ void __init free_area_init(unsigned long *max_zone_pfn)
>  	/* Initialise every node */
>  	mminit_verify_pageflags_layout();
>  	setup_nr_node_ids();
> -	for_each_online_node(nid) {
> -		pg_data_t *pgdat = NODE_DATA(nid);
> +	for_each_node(nid) {
> +		pg_data_t *pgdat;
> +
> +		if (!node_online(nid)) {
> +			pr_warn("Node %d uninitialized by the platform. Please report with boot dmesg.\n", nid);
> +
> +			/* Allocator not initialized yet */
> +			pgdat = arch_alloc_nodedata(nid);
> +			if (!pgdat) {
> +				pr_err("Cannot allocate %zuB for node %d.\n",
> +						sizeof(*pgdat), nid);
> +				continue;
> +			}
> +			arch_refresh_nodedata(nid, pgdat);

We could get rid of arch_refresh_nodedata() now and simply merge that
into arch_alloc_nodedata(). But depends on how we want to proceed with
arch_alloc_nodedata() eventually.


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

