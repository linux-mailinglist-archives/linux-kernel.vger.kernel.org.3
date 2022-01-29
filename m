Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F834A2A92
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 01:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241450AbiA2A1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 19:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344709AbiA2A1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 19:27:41 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E733DC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:27:40 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id u24so13058122eds.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DzlKGdu63oR5Np89nKMxqPFykzScyAGBA+0JycwAsUY=;
        b=e5pWhHvhSjsub44oqXp71+F6yp3o0iasEVgUl3tMiNyMhFZh6PPZur6H+E8xPpVXPu
         xvPloJ6qhhQWB0QuSpGR4JogJcMY7a/MT3ex3V1O5weKwVwhP3a1hQ9yXAo1suVQJksR
         Jv4kvfYKBAQTe2Z5kK37ecw3EbiwRdxIUefJ/WTcOrQ+XqTmvXDxZU7v9NSa50UPAGTU
         n3P9Cmm0EwPJbeVFH6St8toBJetsFQaF+QR3N4DuKu3jZhhXgcV2nGDNzR0LWMieQHSF
         9IewkQcVt0WV3WTwo39GvtxwoNdNxfp/o1JYpoi4BTzxFYjJagBBN6c0uU9FWOTF5Fq6
         L02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DzlKGdu63oR5Np89nKMxqPFykzScyAGBA+0JycwAsUY=;
        b=gLUeIVZG3oKvXG2P31jhklQ14gyi8DA1cjOMi/6CXaKKC/1Vi0Sj6aRENXz4lHk1mv
         Agb+PbzXqNZZCH+loL1Yu13e6OQDnmSEt5R43qUdEK/0dw+KkXb7FnD0e9C14W1XsVY9
         GxmeHESYR18XDqwg8xLypgvzAuic1oiemBRvAR4DfzoY2tEy1Fuo9bPMD8V6l61tPDhF
         RMbzkD5DN2uF5WFxW0Cn9/pMpneeYV50aAJvszfZWNKjpOUvgdrCmv1ody2FRFdIU6s1
         Y1C0aKSoav8dIy3QnKBx7cETbKeRRiEObza7+ldZtGEqy2YoUvXZHtzr/aQ+ZmozMuWJ
         es2g==
X-Gm-Message-State: AOAM532u8hMj2LuhzQhPFQPFMJDRXUGlJb4nn49NFFTPSSLScO96hZFM
        AqYLjBP6m8gsU5Bn6G2mqrA=
X-Google-Smtp-Source: ABdhPJwX8z9eqiBRQJF5SXr/wIsd4M54RJcw2Tp7MzJeoErFVPYzTqy3eEgcJpyLS8RJuaaWUWKQLA==
X-Received: by 2002:a05:6402:1ac5:: with SMTP id ba5mr10591620edb.337.1643416059486;
        Fri, 28 Jan 2022 16:27:39 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id d16sm10385885ejy.135.2022.01.28.16.27.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jan 2022 16:27:39 -0800 (PST)
Date:   Sat, 29 Jan 2022 00:27:38 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory_hotplug: build zonelist for managed_zone
Message-ID: <20220129002738.ofoewhgb4mwfwqfj@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220127012023.18095-1-richard.weiyang@gmail.com>
 <f23028db-a351-e6b0-6c17-f14191ab3985@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f23028db-a351-e6b0-6c17-f14191ab3985@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:39:56AM +0100, David Hildenbrand wrote:
>On 27.01.22 02:20, Wei Yang wrote:
>> During memory hotplug, when online/offline a zone, we need to rebuild
>> the zonelist for all node. There are two checks to decide whether a zone
>> would be added to zonelist:
>> 
>>   * one in online_pages/offline_pages to decide necessity
>>   * one in build_zonerefs_node to do real add
>> 
>> Currently we use different criteria at these two places, which is
>> different from the original behavior.
>> 
>> Originally during memory hotplug, zonelist is re-built when zone hasn't
>> been populated. This in introduced in 'commit 6811378e7d8b ("[PATCH]
>> wait_table and zonelist initializing for memory hotadd: update zonelists")'.
>> And at that moment, build_zonelists_node() also use populated_zone() to
>> decide whether the zone should be added to zonelist.
>> 
>> While in 'commit 6aa303defb74 ("mm, vmscan: only allocate and reclaim
>> from zones with pages managed by the buddy allocator")',
>> build_zonelists_node() changed to use managed_zone() to add zonelist.
>> But we still use populated_zone() to decide the necessity.
>> 
>> This patch restore the original behavior by using the same criteria to
>> add a zone in zonelist during memory hotplug.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> Fixes: 6aa303defb74 ("mm, vmscan: only allocate and reclaim from zones with pages managed by the buddy allocator")
>> CC: Mel Gorman <mgorman@techsingularity.net>
>> ---
>>  mm/memory_hotplug.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 2a9627dc784c..8f1906b33937 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1102,11 +1102,11 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>>  	spin_unlock_irqrestore(&zone->lock, flags);
>>  
>>  	/*
>> -	 * If this zone is not populated, then it is not in zonelist.
>> +	 * If this zone is not managed, then it is not in zonelist.
>>  	 * This means the page allocator ignores this zone.
>>  	 * So, zonelist must be updated after online.
>>  	 */
>> -	if (!populated_zone(zone)) {
>> +	if (!managed_zone(zone)) {
>>  		need_zonelists_rebuild = 1;
>>  		setup_zone_pageset(zone);
>>  	}
>> @@ -1985,7 +1985,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>>  	/* reinitialise watermarks and update pcp limits */
>>  	init_per_zone_wmark_min();
>>  
>> -	if (!populated_zone(zone)) {
>> +	if (!managed_zone(zone)) {
>>  		zone_pcp_reset(zone);
>>  		build_all_zonelists(NULL);
>>  	}
>
>A note that managed_zone() is a moving target w.r.t. memory ballooning.
>In extreme cases, we can have whole zones (temporarily) be completely
>!managed for that reason.
>
>IMHO memory hot(un)plug is usually the wrong place to check for
>managed_zone(), it cares about populated_zone().
>

So we need to check populated_zone when building zonelist?

>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
