Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E198596A35
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiHQHRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238458AbiHQHRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:17:05 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F756B8D5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:17:02 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M6zlS3S6XzcfgL;
        Wed, 17 Aug 2022 15:13:56 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 15:17:00 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 15:16:59 +0800
Message-ID: <99556483-9f22-4597-8270-b4414cc97e64@huawei.com>
Date:   Wed, 17 Aug 2022 15:16:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RFC] mm, proc: add PcpFree to meminfo
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-mm@kvack.org>, Aaron Lu <aaron.lu@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Kemi Wang <kemi.wang@intel.com>
CC:     <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
References: <20220816084426.135528-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220816084426.135528-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2022/8/16 16:44, Kefeng Wang wrote:
> From: Liu Shixin <liushixin2@huawei.com>
>
> The page on pcplist could be used, but not counted into memory free or
> avaliable, and pcp_free is only showed by show_mem(). Since commit
> d8a759b57035 ("mm, page_alloc: double zone's batchsize"), there is a
> significant decrease in the display of free memory, with a large number
> of cpus and nodes, the number of pages in the percpu list can be very
> large, so it is better to let user to know the pcp count.
Add more experts according to commit d8a759b57035，
any advice would be much appreciated，thanks.
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   drivers/base/node.c | 14 +++++++++++++-
>   fs/proc/meminfo.c   |  9 +++++++++
>   2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index eb0f43784c2b..846864e45db6 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -375,6 +375,9 @@ static ssize_t node_read_meminfo(struct device *dev,
>   	struct sysinfo i;
>   	unsigned long sreclaimable, sunreclaimable;
>   	unsigned long swapcached = 0;
> +	unsigned long free_pcp = 0;
> +	struct zone *zone;
> +	int cpu;
>   
>   	si_meminfo_node(&i, nid);
>   	sreclaimable = node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B);
> @@ -382,9 +385,17 @@ static ssize_t node_read_meminfo(struct device *dev,
>   #ifdef CONFIG_SWAP
>   	swapcached = node_page_state_pages(pgdat, NR_SWAPCACHE);
>   #endif
> +	for_each_populated_zone(zone) {
> +		if (zone_to_nid(zone) != nid)
> +			continue;
> +		for_each_online_cpu(cpu)
> +			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
> +	}
> +
>   	len = sysfs_emit_at(buf, len,
>   			    "Node %d MemTotal:       %8lu kB\n"
>   			    "Node %d MemFree:        %8lu kB\n"
> +			    "Node %d PcpFree:        %8lu kB\n"
>   			    "Node %d MemUsed:        %8lu kB\n"
>   			    "Node %d SwapCached:     %8lu kB\n"
>   			    "Node %d Active:         %8lu kB\n"
> @@ -397,7 +408,8 @@ static ssize_t node_read_meminfo(struct device *dev,
>   			    "Node %d Mlocked:        %8lu kB\n",
>   			    nid, K(i.totalram),
>   			    nid, K(i.freeram),
> -			    nid, K(i.totalram - i.freeram),
> +			    nid, K(free_pcp),
> +			    nid, K(i.totalram - i.freeram - free_pcp),
>   			    nid, K(swapcached),
>   			    nid, K(node_page_state(pgdat, NR_ACTIVE_ANON) +
>   				   node_page_state(pgdat, NR_ACTIVE_FILE)),
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 6e89f0e2fd20..672c784dfc8a 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -38,6 +38,9 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>   	unsigned long pages[NR_LRU_LISTS];
>   	unsigned long sreclaimable, sunreclaim;
>   	int lru;
> +	unsigned long free_pcp = 0;
> +	struct zone *zone;
> +	int cpu;
>   
>   	si_meminfo(&i);
>   	si_swapinfo(&i);
> @@ -55,8 +58,14 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>   	sreclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B);
>   	sunreclaim = global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B);
>   
> +	for_each_populated_zone(zone) {
> +		for_each_online_cpu(cpu)
> +			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
> +	}
> +
>   	show_val_kb(m, "MemTotal:       ", i.totalram);
>   	show_val_kb(m, "MemFree:        ", i.freeram);
> +	show_val_kb(m, "PcpFree:        ", free_pcp);
>   	show_val_kb(m, "MemAvailable:   ", available);
>   	show_val_kb(m, "Buffers:        ", i.bufferram);
>   	show_val_kb(m, "Cached:         ", cached);
