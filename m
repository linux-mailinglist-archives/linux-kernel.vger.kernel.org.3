Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D095133BA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346285AbiD1Md5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346243AbiD1Mdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:33:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 684264D61D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 05:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651149024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oQusaVIg93+Tlv4h0c+4weA+EMDGjUagRjJTAiVmMsw=;
        b=VDxjkhiwzwBmAnM6iG8tPdGO5bXzyDzFWsGEG1xkALi4F7BiDiniXNzBD52ax0hcR2JFw8
        0M8yb9z5vNwyb31SCnD0BtLAd8gdsHCpFwmLcvytLeGoGQjZnK0fTPQ16+rAVOwvznVwoc
        5He2cMQ4jhcEmfrf69HlMoXWVgjJyME=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-324-kWfO9GuAPnC3a-suhkTwvA-1; Thu, 28 Apr 2022 08:30:23 -0400
X-MC-Unique: kWfO9GuAPnC3a-suhkTwvA-1
Received: by mail-ej1-f69.google.com with SMTP id sg44-20020a170907a42c00b006f3a40146e8so2874029ejc.19
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 05:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=oQusaVIg93+Tlv4h0c+4weA+EMDGjUagRjJTAiVmMsw=;
        b=3HsWjWxseqyd+AAxsfPQqtgIyJjoOXLJlLnz1JPxzwE5uOq1OsWDOTsare72IZx4Dl
         tpZcwERo8egKw4t/Re1CgKOX+rL+t1dKruI2/fAUmzDx16+nkAnF+cdrS0L1Na2m0qxF
         0zORgT9V8ABqMfmzYktb4iednT5a7Ampe11YIr1Bfm34FGEXjbB253unNOkTkqxr+4tk
         SoeNcxiN+u/IvjyGRD+bWhizeJcZ4HJQNKa8m8PQ+zsmZtv4GQsvp3NA7Kfm16JYN/0J
         Y0rNvd7ddJ0KJGGPY7AVlCRjymRKU/vw1+q0wwETZwoNaGslgY1n5qqQUM1wMooRVRmu
         30Sw==
X-Gm-Message-State: AOAM532rNSjpqkCes9RAcQMP7G91Gco43QKyMq8K+/kesFvnfkk4CM+v
        QgRqzoyvObhPKi31KaaHH5NKC1O7IKCvufOxdrMj5OVhwiWwIO9P/GjLva0XXFzUdm8Ri/cMVsl
        pSYWJ7/EusgW1aJXgjkoL5MK6
X-Received: by 2002:a17:906:9744:b0:6da:9e49:9fe3 with SMTP id o4-20020a170906974400b006da9e499fe3mr31988073ejy.319.1651149021709;
        Thu, 28 Apr 2022 05:30:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgM6CXARkhxBVDo76Fxiue3UpS1luqEJQPI8qpVG1JKfBOaRqKQqWC3DKXqhrRWMFclZijBA==
X-Received: by 2002:a17:906:9744:b0:6da:9e49:9fe3 with SMTP id o4-20020a170906974400b006da9e499fe3mr31988043ejy.319.1651149021388;
        Thu, 28 Apr 2022 05:30:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:ef00:7443:a23c:26b8:b96? (p200300cbc708ef007443a23c26b80b96.dip0.t-ipconnect.de. [2003:cb:c708:ef00:7443:a23c:26b8:b96])
        by smtp.gmail.com with ESMTPSA id bd28-20020a056402207c00b0042617ba6391sm1509589edb.27.2022.04.28.05.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 05:30:20 -0700 (PDT)
Message-ID: <0d2853f6-66e5-251a-2d9e-c229f0ebcd5e@redhat.com>
Date:   Thu, 28 Apr 2022 14:30:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220307150725.6810-1-osalvador@suse.de>
 <20220307150725.6810-3-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 2/3] mm/memory_hotplug: Reset node's state when empty
 during offline
In-Reply-To: <20220307150725.6810-3-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.22 16:07, Oscar Salvador wrote:
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
>  mm/memory_hotplug.c            | 58 +++++++++++++++++++++-------------
>  mm/page_alloc.c                | 49 +++++-----------------------
>  3 files changed, 45 insertions(+), 64 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 76bf2de86def..fcf4c9a023cc 100644
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
> index ddc62f8b591f..07cece9e22e4 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1164,18 +1164,18 @@ static void reset_node_present_pages(pg_data_t *pgdat)
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
> @@ -1183,15 +1183,6 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
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
> @@ -1799,6 +1790,30 @@ static void node_states_clear_node(int node, struct memory_notify *arg)
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
> +	reset_node_managed_pages(pgdat);
> +	reset_node_present_pages(pgdat);
> +
> +	pgdat->nr_zones = 0;
> +	pgdat->kswapd_order = 0;
> +	pgdat->kswapd_highest_zoneidx = 0;
> +	pgdat->node_start_pfn = 0;


I'm confused why we have to mess with
* present pages
* managed pages
* node_start_pfn

here at all.

1) If there would be any present page left, calling node_reset_state()
would be a BUG.
2) If there would be any manged page left, calling node_reset_state()
would be a BUG.
3) node_start_pfn will be properly updated by
remove_pfn_range_from_zone()->update_pgdat_span()


To make it clearer, I *think* touching node_start_pfn is very wrong.

What if the node still has ZONE_DEVICE? They don't account towards
present pages but only towards spanned pages, and we're messing with the
start range.

remove_pfn_range_from_zone()->update_pgdat_span() should be the only
place that modifies the spanned range when offlining.

-- 
Thanks,

David / dhildenb

