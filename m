Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87E35AE512
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbiIFKMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbiIFKM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:12:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18511E3EC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 03:12:26 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MMLgn34dCzkWy2;
        Tue,  6 Sep 2022 18:08:37 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 6 Sep 2022 18:12:24 +0800
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 6 Sep 2022 18:12:23 +0800
Message-ID: <c69a00c8-99d5-7a55-0861-1559764bd26c@huawei.com>
Date:   Tue, 6 Sep 2022 18:12:23 +0800
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
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <20220905092619.2533krnnx632hswc@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/5 17:26, Mel Gorman wrote:
> On Mon, Sep 05, 2022 at 11:28:57AM +0800, Wupeng Ma wrote:
>> From: Ma Wupeng <mawupeng1@huawei.com>
>>
>> Since min_free_kbytes is based on gfp_zone(GFP_USER) which does not include
>> zone movable. However zone movable will get its min share in
>> __setup_per_zone_wmarks() which does not make any sense.
>>
>> And like highmem pages, __GFP_HIGH and PF_MEMALLOC allocations usually
>> don't need movable pages, so there is no need to assign min pages for zone
>> movable.
>>
>> Let's cap pages_min for zone movable to a small value here just link
>> highmem pages.
>>
> 
> I think there is a misunderstanding why the higher zones have a watermark
> and why it might be large.
> 
> It's not about a __GFP_HIGH or PF_MEMALLOC allocations because it's known
> that few of those allocations may be movable. It's because high memory
> allocations indirectly pin pages in lower zones. User-mapped memory allocated
> from ZONE_MOVABLE still needs page table pages allocated from a lower zone
> so there is a ratio between the size of ZONE_MOVABLE and lower zones
> that limits the total amount of memory that can be allocated. Similarly,
> file backed pages that may be allocated from ZONE_MOVABLE still requires
> pages from lower memory for the inode and other associated kernel
> objects that are allocated from lower zones.
> 
> The intent behind the higher zones having a large min watermark is so
> that kswapd reclaims pages from there first to *potentially* release
> pages from lower memory. By capping pages_min for zone_movable, there is
> the potential for lower memory pressure to be higher and to reach a point
> where a ZONE_MOVABLE page cannot be allocated simply because there isn't
> enough low memory available. Once the lower zones are all unreclaimable
> (e.g. page table pages or the movable pages are not been reclaimed to free
> the associated kernel structures), the system goes OOM.

This i do agree with you, lower zone is actually "more important" than the
higher one.

But higher min watermark for zone movable will not work since no memory
allocation can use this reserve memory below min. Memory allocation
with specify watermark modifier(__GFP_ATOMIC ,__GFP_HIGH ...) can use this
in slowpath, however the standard movable memory allocation
(gfp flag: GFP_HIGHUSER_MOVABLE) does not contain this.

Second, lowmem_reserve_ratio is used to "reserve" memory for lower zone.
And the second patch introduce per zone watermark_scale_factor to boost
normal/movable zone's watermark which can trigger early kswapd for zone
movable.

> 
> It's possible that there are safe adjustments that could be made that
> would detect when there is no choice except to reclaim zone reclaimable
> but it would be tricky and it's not this patch. This patch changelog states
> 
> 	However zone movable will get its min share in
> 	__setup_per_zone_wmarks() which does not make any sense.
> 
> It makes sense, higher zones allocations indirectly pin pages in lower
> zones and there is a bias in reclaim to free the higher zone pages first
> on the *possibility* that lower zone pages get indirectly released later.
> 

In our Test vm with 16G of mirrored memory(normal zone) and 256 of normal
momory(Movable zone), the min share for normal zone is too few since the
size of min watermark is calc by zone dma/normal while this will be shared
by zones(include zone movable) based on managed pages.

Node 0, zone      DMA
        min      39
        low      743
        high     1447
Node 0, zone   Normal
        min      180
        low      3372
        high     6564
Node 1, zone  Movable
        min      3728
        low      69788
        high     135848
