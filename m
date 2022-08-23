Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCE359E72C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244853AbiHWQY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244847AbiHWQYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:24:30 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6ED9F1B3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:46:46 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MBpmg2d4Cz1N7LJ;
        Tue, 23 Aug 2022 20:43:15 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 20:46:44 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 20:46:43 +0800
Subject: Re: [PATCH -next v2] mm, proc: collect percpu free pages into the
 free pages
To:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220822023311.909316-1-liushixin2@huawei.com>
 <20220822033354.952849-1-liushixin2@huawei.com>
 <20220822141207.24ff7252913a62f80ea55e90@linux-foundation.org>
 <YwSGqtEICW5AlhWr@dhcp22.suse.cz>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        huang ying <huang.ying.caritas@gmail.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kemi Wang <kemi.wang@intel.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <6b2977fc-1e4a-f3d4-db24-7c4699e0773f@huawei.com>
Date:   Tue, 23 Aug 2022 20:46:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YwSGqtEICW5AlhWr@dhcp22.suse.cz>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/23 15:50, Michal Hocko wrote:
> On Mon 22-08-22 14:12:07, Andrew Morton wrote:
>> On Mon, 22 Aug 2022 11:33:54 +0800 Liu Shixin <liushixin2@huawei.com> wrote:
>>
>>> The page on pcplist could be used, but not counted into memory free or
>>> avaliable, and pcp_free is only showed by show_mem() for now. Since commit
>>> d8a759b57035 ("mm, page_alloc: double zone's batchsize"), there is a
>>> significant decrease in the display of free memory, with a large number
>>> of cpus and zones, the number of pages in the percpu list can be very
>>> large, so it is better to let user to know the pcp count.
>>>
>>> On a machine with 3 zones and 72 CPUs. Before commit d8a759b57035, the
>>> maximum amount of pages in the pcp lists was theoretically 162MB(3*72*768KB).
>>> After the patch, the lists can hold 324MB. It has been observed to be 114MB
>>> in the idle state after system startup in practice(increased 80 MB).
>>>
>> Seems reasonable.
> I have asked in the previous incarnation of the patch but haven't really
> received any answer[1]. Is this a _real_ problem? The absolute amount of
> memory could be perceived as a lot but is this really noticeable wrt
> overall memory on those systems?
This may not obvious when the memory is sufficient. However, as products monitor the
memory to plan it. The change has caused warning. We have also considered using /proc/zoneinfo
to calculate the total number of pcplists. However, we think it is more appropriate to add
the total number of pcplists to free and available pages. After all, this part is also free pages.
> Also the patch is accounting these pcp caches as free memory but that
> can be misleading as this memory is not readily available for use in
> general. E.g. MemAvailable is documented as:
> 	An estimate of how much memory is available for starting new
> 	applications, without swapping.
> but pcp caches are drained only after direct reclaim fails which can
> imply a lot of reclaim and runtime disruption.
Maybe it makes more sense to add it only to free? Or handle it like page cache?
>
> [1] http://lkml.kernel.org/r/YwMv1A1rVNZQuuOo@dhcp22.suse.cz
>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 033f1e26d15b..f89928d3ad4e 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -5853,6 +5853,26 @@ static unsigned long nr_free_zone_pages(int offset)
>>>  	return sum;
>>>  }
>>>  
>>> +static unsigned long nr_free_zone_pcplist_pages(struct zone *zone)
>>> +{
>>> +	unsigned long sum = 0;
>>> +	int cpu;
>>> +
>>> +	for_each_online_cpu(cpu)
>>> +		sum += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
>>> +	return sum;
>>> +}
>>> +
>>> +static unsigned long nr_free_pcplist_pages(void)
>>> +{
>>> +	unsigned long sum = 0;
>>> +	struct zone *zone;
>>> +
>>> +	for_each_zone(zone)
>>> +		sum += nr_free_zone_pcplist_pages(zone);
>>> +	return sum;
>>> +}
>> Prevention of races against zone/node hotplug?
> Memory hotplug doesn't remove nodes nor its zones.
>

