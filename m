Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1042599953
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347423AbiHSJxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346618AbiHSJxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:53:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D484330E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:53:29 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M8H820Tp5znTVx;
        Fri, 19 Aug 2022 17:51:14 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 17:53:27 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 17:53:27 +0800
Subject: Re: [PATCH RFC] mm, proc: add PcpFree to meminfo
To:     Aaron Lu <aaron.lu@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20220816084426.135528-1-wangkefeng.wang@huawei.com>
 <CAC=cRTN=vbrgOsH7PNNMV+Coyabp=H_XF99MUL00kfET=K-32w@mail.gmail.com>
 <578084e8-bdc3-6e4e-f390-4202a8bc7c1d@huawei.com>
 <Yv8+bxiZ8+Rw+wu3@ziqianlu-Dell-Optiplex7000>
CC:     huang ying <huang.ying.caritas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <31718e40-51e9-c14d-f7f5-526ba26d0db8@huawei.com>
Date:   Fri, 19 Aug 2022 17:53:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <Yv8+bxiZ8+Rw+wu3@ziqianlu-Dell-Optiplex7000>
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



On 2022/8/19 15:40, Aaron Lu wrote:
> On Tue, Aug 16, 2022 at 05:24:07PM +0800, Kefeng Wang wrote:
>> On 2022/8/16 16:48, huang ying wrote:
>>> On Tue, Aug 16, 2022 at 4:38 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>>> From: Liu Shixin <liushixin2@huawei.com>
>>>>
>>>> The page on pcplist could be used, but not counted into memory free or
>>>> avaliable, and pcp_free is only showed by show_mem(). Since commit
>>>> d8a759b57035 ("mm, page_alloc: double zone's batchsize"), there is a
>>>> significant decrease in the display of free memory, with a large number
>>>> of cpus and nodes, the number of pages in the percpu list can be very
>>>> large, so it is better to let user to know the pcp count.
>>> Can you show some data?
>> 80M+ with 72cpus/2node
>>
> 80M+ for a 2 node system doesn't sound like a significant number.
>
>>> Another choice is to count PCP free pages in MemFree.  Is that OK for
>>> your use case too?
>> Yes, the user will make policy according to MemFree, we think count PCP free
>> pages
>>
>> in MemFree is better, but don't know whether it is right way.
>>
> Is there a real problem where user makes a sub-optimal policy due to the
> not accounted 80M+ free memory?
I need to explain that 80M+ is the increased after patch d8a759b57035. Actually in my test,
the pcplist is about 114M after system startup, and in high load scenarios, the pcplist memory
can reach 300M+.
The downstream has sensed the memory change after the kernel is updated, which has an
actual impact on them. That's why I sent this patch to ask if should count this
part of memory.

> Counting PCP pages as free seems natural, since they are indeed free
> pages. One concern is, there might be much more calls of
> __mod_zone_freepage_state() if you do free page counting for PCP pages,
> not sure if that would hurt performance. Also, you will need to
> differentiate in __free_one_page() whether counting for free pages are
> still needed since some pages are freed through PCP(and thus already
> counted) while some are not.
I prefer to add this part of memory into free only when calculating MemFree and
MemAvailable, without modifying other statistics to avoid directly hurt performance
or cause other performance problems. How about this way?

> BTW, since commit b92ca18e8ca59("mm/page_alloc: disassociate the pcp->high
> from pcp->batch"), pcp size is no longer associated with batch size. Is
> it that you are testing on an older kernel?
I met the problem on stable-5.10. I think this patch can't fix the problem I met. Futher,
this series of patch make pcp->high to be greater. So the problem becomes even more
acute in mainline.

Thanks,
>
> Thanks,
> Aaron
>
>>>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>> ---
>>>>   drivers/base/node.c | 14 +++++++++++++-
>>>>   fs/proc/meminfo.c   |  9 +++++++++
>>>>   2 files changed, 22 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>>>> index eb0f43784c2b..846864e45db6 100644
>>>> --- a/drivers/base/node.c
>>>> +++ b/drivers/base/node.c
>>>> @@ -375,6 +375,9 @@ static ssize_t node_read_meminfo(struct device *dev,
>>>>          struct sysinfo i;
>>>>          unsigned long sreclaimable, sunreclaimable;
>>>>          unsigned long swapcached = 0;
>>>> +       unsigned long free_pcp = 0;
>>>> +       struct zone *zone;
>>>> +       int cpu;
>>>>
>>>>          si_meminfo_node(&i, nid);
>>>>          sreclaimable = node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B);
>>>> @@ -382,9 +385,17 @@ static ssize_t node_read_meminfo(struct device *dev,
>>>>   #ifdef CONFIG_SWAP
>>>>          swapcached = node_page_state_pages(pgdat, NR_SWAPCACHE);
>>>>   #endif
>>>> +       for_each_populated_zone(zone) {
>>>> +               if (zone_to_nid(zone) != nid)
>>>> +                       continue;
>>>> +               for_each_online_cpu(cpu)
>>>> +                       free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
>>>> +       }
>>>> +
>>>>          len = sysfs_emit_at(buf, len,
>>>>                              "Node %d MemTotal:       %8lu kB\n"
>>>>                              "Node %d MemFree:        %8lu kB\n"
>>>> +                           "Node %d PcpFree:        %8lu kB\n"
>>>>                              "Node %d MemUsed:        %8lu kB\n"
>>>>                              "Node %d SwapCached:     %8lu kB\n"
>>>>                              "Node %d Active:         %8lu kB\n"
>>>> @@ -397,7 +408,8 @@ static ssize_t node_read_meminfo(struct device *dev,
>>>>                              "Node %d Mlocked:        %8lu kB\n",
>>>>                              nid, K(i.totalram),
>>>>                              nid, K(i.freeram),
>>>> -                           nid, K(i.totalram - i.freeram),
>>>> +                           nid, K(free_pcp),
>>>> +                           nid, K(i.totalram - i.freeram - free_pcp),
>>>>                              nid, K(swapcached),
>>>>                              nid, K(node_page_state(pgdat, NR_ACTIVE_ANON) +
>>>>                                     node_page_state(pgdat, NR_ACTIVE_FILE)),
>>>> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
>>>> index 6e89f0e2fd20..672c784dfc8a 100644
>>>> --- a/fs/proc/meminfo.c
>>>> +++ b/fs/proc/meminfo.c
>>>> @@ -38,6 +38,9 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>>>>          unsigned long pages[NR_LRU_LISTS];
>>>>          unsigned long sreclaimable, sunreclaim;
>>>>          int lru;
>>>> +       unsigned long free_pcp = 0;
>>>> +       struct zone *zone;
>>>> +       int cpu;
>>>>
>>>>          si_meminfo(&i);
>>>>          si_swapinfo(&i);
>>>> @@ -55,8 +58,14 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>>>>          sreclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B);
>>>>          sunreclaim = global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B);
>>>>
>>>> +       for_each_populated_zone(zone) {
>>>> +               for_each_online_cpu(cpu)
>>>> +                       free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
>>>> +       }
>>>> +
>>>>          show_val_kb(m, "MemTotal:       ", i.totalram);
>>>>          show_val_kb(m, "MemFree:        ", i.freeram);
>>>> +       show_val_kb(m, "PcpFree:        ", free_pcp);
>>>>          show_val_kb(m, "MemAvailable:   ", available);
>>>>          show_val_kb(m, "Buffers:        ", i.bufferram);
>>>>          show_val_kb(m, "Cached:         ", cached);
>>>> --
>>>> 2.35.3
>>>>
>>>>
>>> .
> .
>

