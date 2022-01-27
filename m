Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C86E49DCAD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237850AbiA0IkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:40:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59633 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231469AbiA0IkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:40:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643272801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vfnWWKEVjGKb36aA96y+8vHW4NMLWf6mwas7AEDwyAs=;
        b=Sduyj9jyRX7MBIi2xDo7B39F72GxlkRVsCgMM3RUe/sZlo9z+ajsnYt1jSZuBKDu+yeqBb
        0pw6LFASJRVyXCWyfKvImmt33sPf6xxbIje91Z/FPJOpmctWFGJsTvvlH//irD1inwc6h6
        prBFhMBharx3LdB0Ii4tu5SUHnsAwKA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-lD5VHOFKOCG8L4J1_4GgBg-1; Thu, 27 Jan 2022 03:39:59 -0500
X-MC-Unique: lD5VHOFKOCG8L4J1_4GgBg-1
Received: by mail-ej1-f69.google.com with SMTP id rl11-20020a170907216b00b006b73a611c1aso977098ejb.22
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:39:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=vfnWWKEVjGKb36aA96y+8vHW4NMLWf6mwas7AEDwyAs=;
        b=4DqRLD1qhHV34RqBj2/VdrYr9FYAe328GnEJGIVdPPhmIIATYbwEY3pzhqMtdhyrMo
         dsDnVLDsyFWt/6GEeQgwdexEG2A6JdNqJ4SeKrck1ffDUsDTvBx3hiykIUAvgVlPZ0Qe
         HwgbPFbqLHsRmZueetMFaciAz3n9ABaYaEOXiWtrvW1DyT3i3lp0xAWFTrU+sFNE2H6C
         3sNDIzBu2hRkXDt4eYSw28eyi6A6bJbM79SGGHdgVuKMZptyWfl44nr+3Aj2pVvjO4i3
         mr6DPzAFLaiekybjE56oaes5MhX0/pTkWzoy74/wp1iUAaewq2J3JP0ZXZwlqBfuyHiQ
         SkFw==
X-Gm-Message-State: AOAM5321YRY5dX0xXkmu4sZTsohKszykw6PDB6IDwN1k70iltQPVK6Zk
        mIekfznAEMtJW6rcYVvAGjkgJcd+5q5bufDpNo4fTvf/GnfX1GtizZnvMWH4mCsid7aXtG9FQTy
        UxnEBIhCf3gBkonLMkerYwiJc
X-Received: by 2002:a50:ed06:: with SMTP id j6mr2737791eds.16.1643272798155;
        Thu, 27 Jan 2022 00:39:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJZot5/alOLrnvU6fGCDgOxjmuFTxhkyvHAqTn45vj3OcrM7LhowN72mwxSsCfTAGmmI9gfw==
X-Received: by 2002:a50:ed06:: with SMTP id j6mr2737777eds.16.1643272797871;
        Thu, 27 Jan 2022 00:39:57 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:8300:4812:9d4f:6cd8:7f47? (p200300cbc70d830048129d4f6cd87f47.dip0.t-ipconnect.de. [2003:cb:c70d:8300:4812:9d4f:6cd8:7f47])
        by smtp.gmail.com with ESMTPSA id p12sm8405760ejd.180.2022.01.27.00.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 00:39:57 -0800 (PST)
Message-ID: <f23028db-a351-e6b0-6c17-f14191ab3985@redhat.com>
Date:   Thu, 27 Jan 2022 09:39:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, mhocko@suse.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220127012023.18095-1-richard.weiyang@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/memory_hotplug: build zonelist for managed_zone
In-Reply-To: <20220127012023.18095-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.22 02:20, Wei Yang wrote:
> During memory hotplug, when online/offline a zone, we need to rebuild
> the zonelist for all node. There are two checks to decide whether a zone
> would be added to zonelist:
> 
>   * one in online_pages/offline_pages to decide necessity
>   * one in build_zonerefs_node to do real add
> 
> Currently we use different criteria at these two places, which is
> different from the original behavior.
> 
> Originally during memory hotplug, zonelist is re-built when zone hasn't
> been populated. This in introduced in 'commit 6811378e7d8b ("[PATCH]
> wait_table and zonelist initializing for memory hotadd: update zonelists")'.
> And at that moment, build_zonelists_node() also use populated_zone() to
> decide whether the zone should be added to zonelist.
> 
> While in 'commit 6aa303defb74 ("mm, vmscan: only allocate and reclaim
> from zones with pages managed by the buddy allocator")',
> build_zonelists_node() changed to use managed_zone() to add zonelist.
> But we still use populated_zone() to decide the necessity.
> 
> This patch restore the original behavior by using the same criteria to
> add a zone in zonelist during memory hotplug.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Fixes: 6aa303defb74 ("mm, vmscan: only allocate and reclaim from zones with pages managed by the buddy allocator")
> CC: Mel Gorman <mgorman@techsingularity.net>
> ---
>  mm/memory_hotplug.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 2a9627dc784c..8f1906b33937 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1102,11 +1102,11 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  	spin_unlock_irqrestore(&zone->lock, flags);
>  
>  	/*
> -	 * If this zone is not populated, then it is not in zonelist.
> +	 * If this zone is not managed, then it is not in zonelist.
>  	 * This means the page allocator ignores this zone.
>  	 * So, zonelist must be updated after online.
>  	 */
> -	if (!populated_zone(zone)) {
> +	if (!managed_zone(zone)) {
>  		need_zonelists_rebuild = 1;
>  		setup_zone_pageset(zone);
>  	}
> @@ -1985,7 +1985,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  	/* reinitialise watermarks and update pcp limits */
>  	init_per_zone_wmark_min();
>  
> -	if (!populated_zone(zone)) {
> +	if (!managed_zone(zone)) {
>  		zone_pcp_reset(zone);
>  		build_all_zonelists(NULL);
>  	}

A note that managed_zone() is a moving target w.r.t. memory ballooning.
In extreme cases, we can have whole zones (temporarily) be completely
!managed for that reason.

IMHO memory hot(un)plug is usually the wrong place to check for
managed_zone(), it cares about populated_zone().

-- 
Thanks,

David / dhildenb

