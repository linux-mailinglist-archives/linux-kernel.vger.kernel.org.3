Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A982D5AFF6F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiIGIoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiIGIoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:44:13 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BBAAFAFA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:44:00 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MMwh65SxSzHnnp;
        Wed,  7 Sep 2022 16:40:54 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 7 Sep 2022 16:42:49 +0800
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 7 Sep 2022 16:42:48 +0800
Message-ID: <0da1757b-5e54-de64-7afb-a0c6caf35d11@huawei.com>
Date:   Wed, 7 Sep 2022 16:42:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
CC:     <mawupeng1@huawei.com>, <akpm@linux-foundation.org>,
        <david@redhat.com>, <ying.huang@intel.com>, <hannes@cmpxchg.org>,
        <corbet@lwn.net>, <mcgrof@kernel.org>, <keescook@chromium.org>,
        <yzaikin@google.com>, <songmuchun@bytedance.com>,
        <mike.kravetz@oracle.com>, <osalvador@suse.de>,
        <surenb@google.com>, <rppt@kernel.org>, <charante@codeaurora.org>,
        <jsavitz@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH -next v3 1/2] mm: Cap zone movable's min wmark to small
 value
Content-Language: en-US
To:     <mgorman@suse.de>
References: <20220905032858.1462927-1-mawupeng1@huawei.com>
 <20220905032858.1462927-2-mawupeng1@huawei.com>
 <20220905092619.2533krnnx632hswc@suse.de>
 <c69a00c8-99d5-7a55-0861-1559764bd26c@huawei.com>
 <20220906122226.ro7coxxiatvctyth@suse.de>
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <20220906122226.ro7coxxiatvctyth@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/6 20:22, Mel Gorman wrote:
> On Tue, Sep 06, 2022 at 06:12:23PM +0800, mawupeng wrote:
>>> I think there is a misunderstanding why the higher zones have a watermark
>>> and why it might be large.
>>>
>>> It's not about a __GFP_HIGH or PF_MEMALLOC allocations because it's known
>>> that few of those allocations may be movable. It's because high memory
>>> allocations indirectly pin pages in lower zones. User-mapped memory allocated
>>> from ZONE_MOVABLE still needs page table pages allocated from a lower zone
>>> so there is a ratio between the size of ZONE_MOVABLE and lower zones
>>> that limits the total amount of memory that can be allocated. Similarly,
>>> file backed pages that may be allocated from ZONE_MOVABLE still requires
>>> pages from lower memory for the inode and other associated kernel
>>> objects that are allocated from lower zones.
>>>
>>> The intent behind the higher zones having a large min watermark is so
>>> that kswapd reclaims pages from there first to *potentially* release
>>> pages from lower memory. By capping pages_min for zone_movable, there is
>>> the potential for lower memory pressure to be higher and to reach a point
>>> where a ZONE_MOVABLE page cannot be allocated simply because there isn't
>>> enough low memory available. Once the lower zones are all unreclaimable
>>> (e.g. page table pages or the movable pages are not been reclaimed to free
>>> the associated kernel structures), the system goes OOM.
>>
>> This i do agree with you, lower zone is actually "more important" than the
>> higher one.
>>
> 
> Very often yes.
> 
>> But higher min watermark for zone movable will not work since no memory
>> allocation can use this reserve memory below min. Memory allocation
>> with specify watermark modifier(__GFP_ATOMIC ,__GFP_HIGH ...) can use this
>> in slowpath, however the standard movable memory allocation
>> (gfp flag: GFP_HIGHUSER_MOVABLE) does not contain this.
>>
> 
> Then a more appropriate solution may be to alter how the gap between min
> and low is calculated. That gap determines when kswapd is active but
> allocations are still allowed.
> 
>> Second, lowmem_reserve_ratio is used to "reserve" memory for lower zone.
>> And the second patch introduce per zone watermark_scale_factor to boost
>> normal/movable zone's watermark which can trigger early kswapd for zone
>> movable.
>>
> 
> The problem with the tunable is that this patch introduces a potentially
> seriously problem that must then be corrected by a system administrator and
> it'll be non-obvious what the root of the problem is or the solution. For
> some users, they will only be able to determine is that OOM triggers
> when there is plenty of free memory or kswapd is consuming a lot more
> CPU than expected. They will not necessarily be able to determine that
> watermark_scale_factor is the solution.
> 
>>>
>>> It's possible that there are safe adjustments that could be made that
>>> would detect when there is no choice except to reclaim zone reclaimable
>>> but it would be tricky and it's not this patch. This patch changelog states
>>>
>>> 	However zone movable will get its min share in
>>> 	__setup_per_zone_wmarks() which does not make any sense.
>>>
>>> It makes sense, higher zones allocations indirectly pin pages in lower
>>> zones and there is a bias in reclaim to free the higher zone pages first
>>> on the *possibility* that lower zone pages get indirectly released later.
>>>
>>
>> In our Test vm with 16G of mirrored memory(normal zone) and 256 of normal
>> momory(Movable zone), the min share for normal zone is too few since the
>> size of min watermark is calc by zone dma/normal while this will be shared
>> by zones(include zone movable) based on managed pages.
>>
>> Node 0, zone      DMA
>>         min      39
>>         low      743
>>         high     1447
>> Node 0, zone   Normal
>>         min      180
>>         low      3372
>>         high     6564
>> Node 1, zone  Movable
>>         min      3728
>>         low      69788
>>         high     135848
> 
> The gap between min and low is massive so either adjust how that gap is
> calculated or to avoid side-effects for other users, consider special
> casing the gap for ZONE_MOVABLE with a comment explaining why it is
> treated differently. To mitigate the risk further, it could be further
> special cased to only apply when there is a massive ratio between
> ALL_ZONES_EXCEPT_MOVABLE:ZONE_MOVABLE. Document in the changelog the
> potential downside of more lowmem potentially getting pinned by MOVABLE
> allocations leading to excessive kswapd activity or premature OOM.
What I'm trying to say is that the min watermark is too low for zone normal
since it is shared by other zone based on manager pages.

        Vanilla          |         Modified         
Node 0, zone      DMA    | Node 0, zone      DMA    
        min      39      |         min      713     
        low      743     |         low      1417    
        high     1447    |         high     2121    
Node 0, zone   Normal    | Node 0, zone   Normal    
        min    **180**   |         min    **3234**    
        low      3372    |         low      6426    
        high     6564    |         high     9618    
Node 1, zone  Movable    | Node 1, zone  Movable    
        min    **3728**  |         min    **128**     
        low      69788   |         low      66188   
        high     135848  |         high     132248 

You can see, after this patch, the min watermark is set to small value(128) while zone
dma/normal's min watermark increase a lot which be useful if the system is low on memory.

The gap between min and low is about 1/1000 of the zone's memory which will not be
effected by this patch.
  
This patch, I am to do something for the min watermark for zone movable, In the next
patch I want to do something to reserve memory for zone normal or just make 
watermark_scale_factor more flexible for little normal zone and huge movable zone.

What is you idea on "Cap zone movable to small value"?


> 
