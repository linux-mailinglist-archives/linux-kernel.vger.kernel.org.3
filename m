Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04EF4A4083
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbiAaKxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:53:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34145 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233361AbiAaKxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:53:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643626423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZJSmtJHqRe6UWSawn0lfqQ7m14tlGuxizEluP0CLcAc=;
        b=XHwAHwUtBjTGNy8Wzgs/ncvR/ejq5CQEwpKGAHJtjK+HdoYnOeUubIG2IMsA6e7wURbICX
        TK8W1FNLDZqU8pTj3wz2TOzRDZ+w4wm2fMTCSLFl+Kc9S7zlVMR75IY2qjS2CJoC62URTd
        GjTq8Q9ql1RSzh5DaWtqYlGyM0Broi4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-B1-c81W4P_GCKgcDLHlcRA-1; Mon, 31 Jan 2022 05:53:38 -0500
X-MC-Unique: B1-c81W4P_GCKgcDLHlcRA-1
Received: by mail-ed1-f70.google.com with SMTP id h11-20020a05640250cb00b003fa024f87c2so6752337edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 02:53:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ZJSmtJHqRe6UWSawn0lfqQ7m14tlGuxizEluP0CLcAc=;
        b=zc6mBfK85QUmVbLXKNJAyOoJtz5KSMun5GsK06L0gEWGc1BLXr6QtDor1rPurT4ciK
         3NqF6jG2CfhXCuRAh5SYBZ/1ZMvj6nFrpa6u+X0tKYQWyoZfKZd/oQvo0X3yJ3tgI7iW
         wK4K+TmRFmdV4K8pBBrIZ+SGshU9MUNsv6zXB0OdVZBYGyzztcqec5mc6l4X7Hj2+Cxv
         tGDYWur72PPEqJN8dWxtGlUyMsM3+Kp251Ne+DxknK2/WN6JaCv3qMZVmzyNSfs9igOB
         PmvKBPVy0bf7klDisYrIU3xeJWJv1lq3SRg7zaApuvJxjIVhBiXLlWcrzdML+KDA1gqb
         7FhA==
X-Gm-Message-State: AOAM533TQ2IwpBlQdkGtdCQUNJZAQkd4NY4bNZ8xRTypWH4v//qP/T1E
        0HkmVeKe4fNGKlz9Q+8gtadSTuJsITiJZr9R9ohVVCrtCFoH1bJbKZb86Gy1U/hqM5tzGE5atz9
        RZXtnJbanseqUqJtKzcpHn9yI
X-Received: by 2002:a17:907:168b:: with SMTP id hc11mr16922487ejc.676.1643626417408;
        Mon, 31 Jan 2022 02:53:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwiuoBf/CdDeAJ2fRaf8To9VDeqG7nGDfM2XYzvI4L7KxNtIpltzTcQIVY2KEhypriRTptmLg==
X-Received: by 2002:a17:907:168b:: with SMTP id hc11mr16922467ejc.676.1643626417146;
        Mon, 31 Jan 2022 02:53:37 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:b200:f007:5a26:32e7:8ef5? (p200300cbc709b200f0075a2632e78ef5.dip0.t-ipconnect.de. [2003:cb:c709:b200:f007:5a26:32e7:8ef5])
        by smtp.gmail.com with ESMTPSA id w22sm5646209ejc.137.2022.01.31.02.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 02:53:36 -0800 (PST)
Message-ID: <cd03f758-6b0e-13d7-504d-4c889e14c39e@redhat.com>
Date:   Mon, 31 Jan 2022 11:53:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] mm/memory_hotplug: build zonelist for managed_zone
Content-Language: en-US
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220127012023.18095-1-richard.weiyang@gmail.com>
 <f23028db-a351-e6b0-6c17-f14191ab3985@redhat.com>
 <20220129002738.ofoewhgb4mwfwqfj@master>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220129002738.ofoewhgb4mwfwqfj@master>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.01.22 01:27, Wei Yang wrote:
> On Thu, Jan 27, 2022 at 09:39:56AM +0100, David Hildenbrand wrote:
>> On 27.01.22 02:20, Wei Yang wrote:
>>> During memory hotplug, when online/offline a zone, we need to rebuild
>>> the zonelist for all node. There are two checks to decide whether a zone
>>> would be added to zonelist:
>>>
>>>   * one in online_pages/offline_pages to decide necessity
>>>   * one in build_zonerefs_node to do real add
>>>
>>> Currently we use different criteria at these two places, which is
>>> different from the original behavior.
>>>
>>> Originally during memory hotplug, zonelist is re-built when zone hasn't
>>> been populated. This in introduced in 'commit 6811378e7d8b ("[PATCH]
>>> wait_table and zonelist initializing for memory hotadd: update zonelists")'.
>>> And at that moment, build_zonelists_node() also use populated_zone() to
>>> decide whether the zone should be added to zonelist.
>>>
>>> While in 'commit 6aa303defb74 ("mm, vmscan: only allocate and reclaim
>>> from zones with pages managed by the buddy allocator")',
>>> build_zonelists_node() changed to use managed_zone() to add zonelist.
>>> But we still use populated_zone() to decide the necessity.
>>>
>>> This patch restore the original behavior by using the same criteria to
>>> add a zone in zonelist during memory hotplug.
>>>
>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>> Fixes: 6aa303defb74 ("mm, vmscan: only allocate and reclaim from zones with pages managed by the buddy allocator")
>>> CC: Mel Gorman <mgorman@techsingularity.net>
>>> ---
>>>  mm/memory_hotplug.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>> index 2a9627dc784c..8f1906b33937 100644
>>> --- a/mm/memory_hotplug.c
>>> +++ b/mm/memory_hotplug.c
>>> @@ -1102,11 +1102,11 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>>>  	spin_unlock_irqrestore(&zone->lock, flags);
>>>  
>>>  	/*
>>> -	 * If this zone is not populated, then it is not in zonelist.
>>> +	 * If this zone is not managed, then it is not in zonelist.
>>>  	 * This means the page allocator ignores this zone.
>>>  	 * So, zonelist must be updated after online.
>>>  	 */
>>> -	if (!populated_zone(zone)) {
>>> +	if (!managed_zone(zone)) {
>>>  		need_zonelists_rebuild = 1;
>>>  		setup_zone_pageset(zone);
>>>  	}
>>> @@ -1985,7 +1985,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>>>  	/* reinitialise watermarks and update pcp limits */
>>>  	init_per_zone_wmark_min();
>>>  
>>> -	if (!populated_zone(zone)) {
>>> +	if (!managed_zone(zone)) {
>>>  		zone_pcp_reset(zone);
>>>  		build_all_zonelists(NULL);
>>>  	}
>>
>> A note that managed_zone() is a moving target w.r.t. memory ballooning.
>> In extreme cases, we can have whole zones (temporarily) be completely
>> !managed for that reason.
>>
>> IMHO memory hot(un)plug is usually the wrong place to check for
>> managed_zone(), it cares about populated_zone().
>>
> 
> So we need to check populated_zone when building zonelist?

I think the issue is that

a) We can have zones without any managed pages put present page during
boot, for example, if all pages in the zone were allocated via memblock.

b) We can have zones without any managed pages temporarily -- extreme
cases of memory ballooning / virtio-mem.


I tend to think that populated_zone() might actually be the right check
whenever building a zonelist. Because even in case of a) we might end up
freeing a memblock allocation later, suddenly having free pages in such
a zone, but the zone not in any zonelist.

-- 
Thanks,

David / dhildenb

