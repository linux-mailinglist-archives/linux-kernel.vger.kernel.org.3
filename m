Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E664A5769
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 08:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiBAHAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 02:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiBAHAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 02:00:47 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17832C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 23:00:47 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id s5so50786800ejx.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 23:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kYBByq3Zzj+Iaw3bMHZH5j2OnG+wKZuSP9VniKuuN0M=;
        b=GggLvrlsjF9yszwZd+41yT8BpCPmBuOA8YQqQjjhB02p/bwEeQa0rXfqszR7fD/AfL
         0e/LaDAXm6ykU/uZFRCwT8U9GOwPUAfTghf9a+vGJzqAYi8vKPNe2iqDxXogdMnLGLhi
         W8iiAyMkY+tuUnAzG4v0kS6fzzanli6F+ymd6cW3544A8CNXKs0My596iH9cbg/MghhB
         Wv7Y4wVuH6QuSxDFLnPfADo/zUATBBGvx9IUoJLsaPW00R7hInHqZfoFG3Q7Eqz8PEJd
         IbmTuqOgEiN1/9kRWIm/OmKT39yebpAS89RUSFXEywyjcv3HoXnx4EO3uKVQTm4RvOdZ
         sEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kYBByq3Zzj+Iaw3bMHZH5j2OnG+wKZuSP9VniKuuN0M=;
        b=7w73FTUI2eGqCh953izdjeNLrBrp8nNnLLPbK/tbt8DnVCqaKyKUr/FpDdpqYRwlD/
         5U+bf+dawgJJLyO1+pUyUIx5zsdIeuZWhcfRtwI+1s2c+Qe1WJOQzEEEWJ+v59UkL6w4
         Qjp7k8HbrS/nXzEraU76F3d0s8ovrj+QA6jgFQLVPhz6hCxHyJ59CwvTxjQjyFL1YMx7
         hGcU/uh7MtEYmKWiXQ2xDLVBag2wK+PhCMUkQX8QrsypAgfePe2PQ5Z324osDgby/LKI
         nmBTJnZV6aDTjfuYz3KhL2H6GpWY5J9BEGn+3Fyx3TJDJ/Z1bl3wNOlHTco0Ft5ASQfe
         bwLw==
X-Gm-Message-State: AOAM532wTErHSl94O0Q3Zqq+p1PG+xTH26MUXg24wuMsHFwaZfHoFXdh
        SiQ9hh5S9Btk3ZXwD0RUZtw=
X-Google-Smtp-Source: ABdhPJzcVUNVqP+ebuiVF2wCV/dZPnvf7j4L3m9+AM1uf03hk765Ney8aulwI7NSVDglN9Vrj/eRCA==
X-Received: by 2002:a17:907:96aa:: with SMTP id hd42mr11057655ejc.13.1643698845447;
        Mon, 31 Jan 2022 23:00:45 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id z19sm14311826eji.87.2022.01.31.23.00.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Jan 2022 23:00:44 -0800 (PST)
Date:   Tue, 1 Feb 2022 07:00:44 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory_hotplug: build zonelist for managed_zone
Message-ID: <20220201070044.zbm3obsoimhz3xd3@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220127012023.18095-1-richard.weiyang@gmail.com>
 <f23028db-a351-e6b0-6c17-f14191ab3985@redhat.com>
 <20220129002738.ofoewhgb4mwfwqfj@master>
 <cd03f758-6b0e-13d7-504d-4c889e14c39e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd03f758-6b0e-13d7-504d-4c889e14c39e@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 11:53:36AM +0100, David Hildenbrand wrote:
>On 29.01.22 01:27, Wei Yang wrote:
>> On Thu, Jan 27, 2022 at 09:39:56AM +0100, David Hildenbrand wrote:
>>> On 27.01.22 02:20, Wei Yang wrote:
>>>> During memory hotplug, when online/offline a zone, we need to rebuild
>>>> the zonelist for all node. There are two checks to decide whether a zone
>>>> would be added to zonelist:
>>>>
>>>>   * one in online_pages/offline_pages to decide necessity
>>>>   * one in build_zonerefs_node to do real add
>>>>
>>>> Currently we use different criteria at these two places, which is
>>>> different from the original behavior.
>>>>
>>>> Originally during memory hotplug, zonelist is re-built when zone hasn't
>>>> been populated. This in introduced in 'commit 6811378e7d8b ("[PATCH]
>>>> wait_table and zonelist initializing for memory hotadd: update zonelists")'.
>>>> And at that moment, build_zonelists_node() also use populated_zone() to
>>>> decide whether the zone should be added to zonelist.
>>>>
>>>> While in 'commit 6aa303defb74 ("mm, vmscan: only allocate and reclaim
>>>> from zones with pages managed by the buddy allocator")',
>>>> build_zonelists_node() changed to use managed_zone() to add zonelist.
>>>> But we still use populated_zone() to decide the necessity.
>>>>
>>>> This patch restore the original behavior by using the same criteria to
>>>> add a zone in zonelist during memory hotplug.
>>>>
>>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>>> Fixes: 6aa303defb74 ("mm, vmscan: only allocate and reclaim from zones with pages managed by the buddy allocator")
>>>> CC: Mel Gorman <mgorman@techsingularity.net>
>>>> ---
>>>>  mm/memory_hotplug.c | 6 +++---
>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>>> index 2a9627dc784c..8f1906b33937 100644
>>>> --- a/mm/memory_hotplug.c
>>>> +++ b/mm/memory_hotplug.c
>>>> @@ -1102,11 +1102,11 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>>>>  	spin_unlock_irqrestore(&zone->lock, flags);
>>>>  
>>>>  	/*
>>>> -	 * If this zone is not populated, then it is not in zonelist.
>>>> +	 * If this zone is not managed, then it is not in zonelist.
>>>>  	 * This means the page allocator ignores this zone.
>>>>  	 * So, zonelist must be updated after online.
>>>>  	 */
>>>> -	if (!populated_zone(zone)) {
>>>> +	if (!managed_zone(zone)) {
>>>>  		need_zonelists_rebuild = 1;
>>>>  		setup_zone_pageset(zone);
>>>>  	}
>>>> @@ -1985,7 +1985,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>>>>  	/* reinitialise watermarks and update pcp limits */
>>>>  	init_per_zone_wmark_min();
>>>>  
>>>> -	if (!populated_zone(zone)) {
>>>> +	if (!managed_zone(zone)) {
>>>>  		zone_pcp_reset(zone);
>>>>  		build_all_zonelists(NULL);
>>>>  	}
>>>
>>> A note that managed_zone() is a moving target w.r.t. memory ballooning.
>>> In extreme cases, we can have whole zones (temporarily) be completely
>>> !managed for that reason.
>>>
>>> IMHO memory hot(un)plug is usually the wrong place to check for
>>> managed_zone(), it cares about populated_zone().
>>>
>> 
>> So we need to check populated_zone when building zonelist?
>
>I think the issue is that
>
>a) We can have zones without any managed pages put present page during
>boot, for example, if all pages in the zone were allocated via memblock.
>
>b) We can have zones without any managed pages temporarily -- extreme
>cases of memory ballooning / virtio-mem.
>
>
>I tend to think that populated_zone() might actually be the right check
>whenever building a zonelist. Because even in case of a) we might end up
>freeing a memblock allocation later, suddenly having free pages in such
>a zone, but the zone not in any zonelist.

I agree with you for this point.

>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
