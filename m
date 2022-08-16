Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0BE595B74
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbiHPMMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiHPMLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:11:40 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3D917E15
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:03:39 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M6V8f3ps0zlVtw;
        Tue, 16 Aug 2022 20:00:34 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 20:03:36 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 20:03:36 +0800
Message-ID: <03f465ca-cf8e-bbd1-1083-099fd2ce026d@huawei.com>
Date:   Tue, 16 Aug 2022 20:03:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RFC] mm, proc: add PcpFree to meminfo
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Shakeel Butt <shakeelb@google.com>
References: <20220816084426.135528-1-wangkefeng.wang@huawei.com>
 <YvtggZeUF9+xQu7D@kroah.com>
 <7bdc252f-15dd-8d92-9e08-1ba7dd8308ad@huawei.com>
 <Yvt2dhNhLX5fH/nH@kroah.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Yvt2dhNhLX5fH/nH@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/8/16 18:50, Greg Kroah-Hartman wrote:
> On Tue, Aug 16, 2022 at 06:11:18PM +0800, Kefeng Wang wrote:
>> On 2022/8/16 17:16, Greg Kroah-Hartman wrote:
>>> On Tue, Aug 16, 2022 at 04:44:26PM +0800, Kefeng Wang wrote:
>>>> From: Liu Shixin <liushixin2@huawei.com>
>>>>
>>>> The page on pcplist could be used, but not counted into memory free or
>>>> avaliable, and pcp_free is only showed by show_mem(). Since commit
>>>> d8a759b57035 ("mm, page_alloc: double zone's batchsize"), there is a
>>>> significant decrease in the display of free memory, with a large number
>>>> of cpus and nodes, the number of pages in the percpu list can be very
>>>> large, so it is better to let user to know the pcp count.
>>>>
>>>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>> ---
>>>>    drivers/base/node.c | 14 +++++++++++++-
>>>>    fs/proc/meminfo.c   |  9 +++++++++
>>>>    2 files changed, 22 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>>>> index eb0f43784c2b..846864e45db6 100644
>>>> --- a/drivers/base/node.c
>>>> +++ b/drivers/base/node.c
>>>> @@ -375,6 +375,9 @@ static ssize_t node_read_meminfo(struct device *dev,
>>>>    	struct sysinfo i;
>>>>    	unsigned long sreclaimable, sunreclaimable;
>>>>    	unsigned long swapcached = 0;
>>>> +	unsigned long free_pcp = 0;
>>>> +	struct zone *zone;
>>>> +	int cpu;
>>>>    	si_meminfo_node(&i, nid);
>>>>    	sreclaimable = node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B);
>>>> @@ -382,9 +385,17 @@ static ssize_t node_read_meminfo(struct device *dev,
>>>>    #ifdef CONFIG_SWAP
>>>>    	swapcached = node_page_state_pages(pgdat, NR_SWAPCACHE);
>>>>    #endif
>>>> +	for_each_populated_zone(zone) {
>>>> +		if (zone_to_nid(zone) != nid)
>>>> +			continue;
>>>> +		for_each_online_cpu(cpu)
>>>> +			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
>>>> +	}
>>>> +
>>>>    	len = sysfs_emit_at(buf, len,
>>>>    			    "Node %d MemTotal:       %8lu kB\n"
>>>>    			    "Node %d MemFree:        %8lu kB\n"
>>>> +			    "Node %d PcpFree:        %8lu kB\n"
>>> First off, this sysfs file is a huge violation of the normal sysfs
>>> rules, so I will not allow any new entries to be added.  In fact, the
>>> whole thing should just be removed and multiple files created in its
>>> place.
>> Hi Greg, do you mean to remove all /sys/devices/system/node/node*/meminfo,
>>
>> but this will beak ABI, is it acceptable?
> I do not know, what tool relies on this file?  Any userspace tool should
> always be able to handle a sysfs file being removed, so you should
> probably work with the tool authors to fix this up before removing it.

https://github.com/numactl/numactl/blob/93867c59b0bb29470873a427dc7f06ebaf305221/numastat.c#L841

It seems numastat use this file, but there are maybe more tools,

Cc'ed more mm experts to see more comments.

>
> thanks,
>
> gre gk-h
> .
