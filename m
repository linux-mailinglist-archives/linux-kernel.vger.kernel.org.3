Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9029552C7C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347867AbiFUH7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiFUH7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:59:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6EAF112A83
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655798351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6sBJMo2yP9mbpru/Lrr+JO5k5YegdQGzkOBh7aOl8JM=;
        b=QOugknWdgt9b8u5/NjkgV8tSxEuc7nqm8bc2WE4QzWroX0HyxF1NBxzvD19GXpc/ZqZLaC
        DQOaCOi/UVhgd4yEAiqOzVccR7cpvGJkHbE4Ur1rPoRf0V2SVxTv9RzQAMC1ZQeWgp+Dnm
        n4nBghMD3Djh4c8RpC+ot6mg5D3YtVE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-153-Gx_GJ4c9PticNR4S0LRq7w-1; Tue, 21 Jun 2022 03:59:10 -0400
X-MC-Unique: Gx_GJ4c9PticNR4S0LRq7w-1
Received: by mail-wm1-f71.google.com with SMTP id p24-20020a05600c1d9800b0039c51c2da19so6532002wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=6sBJMo2yP9mbpru/Lrr+JO5k5YegdQGzkOBh7aOl8JM=;
        b=0wp/21ym6IYVH1i+hGeqvcmnaAMAVSuiYM2Fj8Bk+V4Dw4kKsjLWeo3Xjkyy9kBUaO
         jH6nsL9Z2koPWnYcKHi8YUU4fAvkGaMmmlQ/KiRAkSiQgxZLrECTHYW6R1PlfHV1ADQV
         FBgVd0Whpw1+rtitSQb7LKno/wanKBGFeSlNWE0eil5yhDU1oUJJ1cxg+iYGYUYPnKry
         Ia/gzMDSjrbrul3PI65UiR5Uq2Z9kIbAEXXyg/CcSQx78D5NGoAUTdX9I6OcnofTmxXH
         tz6GI0UuDOoLnbryFi4uPZXws1QkCwst5nxHjiBEBLo+3oa/AkW59s7PnvqVzlR5JGNT
         Jyog==
X-Gm-Message-State: AOAM530Nd7wwLrSksesH2BCMbaOgHymmQ+B8z/PiDoWULyEQp8MyIoi0
        c13Os5nrTv55/oMFb0NVxtqCE0p/UJiYZ+8cWPVz/4Xg636I07iLb1WpjLnmbh95vBrENbbj9Rl
        XaR6GI3pogULczwZSGC8vOX6W
X-Received: by 2002:a05:600c:25cd:b0:39c:6bc0:a1fb with SMTP id 13-20020a05600c25cd00b0039c6bc0a1fbmr39426080wml.179.1655798348677;
        Tue, 21 Jun 2022 00:59:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrL+fSNo0qboO7cLCQ5BtrNAnW4HzEiFBXXy7Ff3nGoezwEquujpy5H+JROgYvTo0OWdSDPQ==
X-Received: by 2002:a05:600c:25cd:b0:39c:6bc0:a1fb with SMTP id 13-20020a05600c25cd00b0039c6bc0a1fbmr39426055wml.179.1655798348376;
        Tue, 21 Jun 2022 00:59:08 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f04:2500:cdb0:9b78:d423:43f? (p200300d82f042500cdb09b78d423043f.dip0.t-ipconnect.de. [2003:d8:2f04:2500:cdb0:9b78:d423:43f])
        by smtp.gmail.com with ESMTPSA id c14-20020a7bc84e000000b0039c4d022a44sm17295191wml.1.2022.06.21.00.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 00:59:07 -0700 (PDT)
Message-ID: <139fc140-142f-c467-a5e3-0a0954dca127@redhat.com>
Date:   Tue, 21 Jun 2022 09:59:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220621041717.6355-1-osalvador@suse.de>
 <20220621041717.6355-3-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/2] mm/memory_hotplug: Reset node's state when empty
 during offline
In-Reply-To: <20220621041717.6355-3-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.06.22 06:17, Oscar Salvador wrote:
> All possible nodes are now pre-allocated at boot time by free_area_init()->
> free_area_init_node(), and those which are to be hot-plugged are initialized
> later on by hotadd_init_pgdat()->free_area_init_core_hotplug() when they
> become online.
> 
> free_area_init_core_hotplug() calls pgdat_init_internals() and
> zone_init_internals() to initialize some internal data structures
> and zeroes a few pgdat fields.
> 
> But we do already call pgdat_init_internals() and zone_init_internals()
> for all possible nodes back in free_area_init_core(), and pgdat fields
> are already zeroed because the pre-allocation memsets with 0s the
> structure, meaning we do not need to repeat the process when
> the node becomes online.
> 
> So initialize it only once when booting, and make sure to reset
> the fields we care about to 0 when the node goes empty.
> The only thing we need to check for is to allocate per_cpu_nodestats
> struct the very first time this node goes online.
> 
> node_reset_state() is the function in charge of resetting pgdat's fields,
> and it is called when offline_pages() detects that the node becomes empty
> worth of memory.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  include/linux/memory_hotplug.h |  2 +-
>  mm/memory_hotplug.c            | 54 ++++++++++++++++++++--------------
>  mm/page_alloc.c                | 49 +++++-------------------------
>  3 files changed, 41 insertions(+), 64 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 20d7edf62a6a..917112661b5c 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -319,7 +319,7 @@ extern void set_zone_contiguous(struct zone *zone);
>  extern void clear_zone_contiguous(struct zone *zone);
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
> -extern void __ref free_area_init_core_hotplug(struct pglist_data *pgdat);
> +extern bool pgdat_has_boot_nodestats(pg_data_t *pgdat);
>  extern int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
>  extern int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
>  extern int add_memory_resource(int nid, struct resource *resource,
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 1213d0c67a53..8a464cdd44ad 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1176,18 +1176,18 @@ static void reset_node_present_pages(pg_data_t *pgdat)
>  /* we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG */
>  static pg_data_t __ref *hotadd_init_pgdat(int nid)
>  {
> -	struct pglist_data *pgdat;
> +	struct pglist_data *pgdat = NODE_DATA(nid);
>  
>  	/*
> -	 * NODE_DATA is preallocated (free_area_init) but its internal
> -	 * state is not allocated completely. Add missing pieces.
> -	 * Completely offline nodes stay around and they just need
> -	 * reintialization.
> +	 * NODE_DATA is preallocated (free_area_init), the only thing missing
> +	 * is to allocate its per_cpu_nodestats struct and to build node's
> +	 * zonelists. The allocation of per_cpu_nodestats only needs to be done
> +	 * the very first time this node is brought up, as we reset its state
> +	 * when all node's memory goes offline.
>  	 */
> -	pgdat = NODE_DATA(nid);
> -
> -	/* init node's zones as empty zones, we don't have any present pages.*/
> -	free_area_init_core_hotplug(pgdat);
> +	if (pgdat_has_boot_nodestats(pgdat))
> +		pgdat->per_cpu_nodestats = alloc_percpu_gfp(struct per_cpu_nodestat,
> +							    __GFP_ZERO);
>  
>  	/*
>  	 * The node we allocated has no zone fallback lists. For avoiding
> @@ -1195,15 +1195,6 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
>  	 */
>  	build_all_zonelists(pgdat);
>  
> -	/*
> -	 * When memory is hot-added, all the memory is in offline state. So
> -	 * clear all zones' present_pages because they will be updated in
> -	 * online_pages() and offline_pages().
> -	 * TODO: should be in free_area_init_core_hotplug?
> -	 */
> -	reset_node_managed_pages(pgdat);
> -	reset_node_present_pages(pgdat);
> -
>  	return pgdat;
>  }
>  
> @@ -1780,6 +1771,26 @@ static void node_states_clear_node(int node, struct memory_notify *arg)
>  		node_clear_state(node, N_MEMORY);
>  }
>  
> +static void node_reset_state(int node)
> +{
> +	pg_data_t *pgdat = NODE_DATA(node);
> +	int cpu;
> +
> +	kswapd_stop(node);
> +	kcompactd_stop(node);
> +
> +	pgdat->nr_zones = 0;

^ what is that? it should be "highest_zone_idx" and I don't see any
reason that we really need this.

To detect if a node is empty we can use pgdat_is_empty(). To detect if a
zone is empty we can use zone_is_empty().

The usage of "pgdat->nr_zones" as an optimization is questionable,
especially when iterating over our handful of zones where most nodes
miss the *lower* zones like ZONE_DMA* in practice and have ZONE_NORMAL.

Can we get rid of that and just check pgdat_is_empty() and
zone_is_empty() and iterate all applicable zones from 0..X?


If it amkes sense what I'm saying, that could be done before this patch.

-- 
Thanks,

David / dhildenb

