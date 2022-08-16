Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26774595923
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbiHPLAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbiHPK7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:59:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F2715FCA
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:11:22 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M6Rfm016PzkWQK;
        Tue, 16 Aug 2022 18:07:59 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 18:11:19 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 18:11:19 +0800
Message-ID: <7bdc252f-15dd-8d92-9e08-1ba7dd8308ad@huawei.com>
Date:   Tue, 16 Aug 2022 18:11:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RFC] mm, proc: add PcpFree to meminfo
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
References: <20220816084426.135528-1-wangkefeng.wang@huawei.com>
 <YvtggZeUF9+xQu7D@kroah.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YvtggZeUF9+xQu7D@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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


On 2022/8/16 17:16, Greg Kroah-Hartman wrote:
> On Tue, Aug 16, 2022 at 04:44:26PM +0800, Kefeng Wang wrote:
>> From: Liu Shixin <liushixin2@huawei.com>
>>
>> The page on pcplist could be used, but not counted into memory free or
>> avaliable, and pcp_free is only showed by show_mem(). Since commit
>> d8a759b57035 ("mm, page_alloc: double zone's batchsize"), there is a
>> significant decrease in the display of free memory, with a large number
>> of cpus and nodes, the number of pages in the percpu list can be very
>> large, so it is better to let user to know the pcp count.
>>
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   drivers/base/node.c | 14 +++++++++++++-
>>   fs/proc/meminfo.c   |  9 +++++++++
>>   2 files changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>> index eb0f43784c2b..846864e45db6 100644
>> --- a/drivers/base/node.c
>> +++ b/drivers/base/node.c
>> @@ -375,6 +375,9 @@ static ssize_t node_read_meminfo(struct device *dev,
>>   	struct sysinfo i;
>>   	unsigned long sreclaimable, sunreclaimable;
>>   	unsigned long swapcached = 0;
>> +	unsigned long free_pcp = 0;
>> +	struct zone *zone;
>> +	int cpu;
>>   
>>   	si_meminfo_node(&i, nid);
>>   	sreclaimable = node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B);
>> @@ -382,9 +385,17 @@ static ssize_t node_read_meminfo(struct device *dev,
>>   #ifdef CONFIG_SWAP
>>   	swapcached = node_page_state_pages(pgdat, NR_SWAPCACHE);
>>   #endif
>> +	for_each_populated_zone(zone) {
>> +		if (zone_to_nid(zone) != nid)
>> +			continue;
>> +		for_each_online_cpu(cpu)
>> +			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
>> +	}
>> +
>>   	len = sysfs_emit_at(buf, len,
>>   			    "Node %d MemTotal:       %8lu kB\n"
>>   			    "Node %d MemFree:        %8lu kB\n"
>> +			    "Node %d PcpFree:        %8lu kB\n"
> First off, this sysfs file is a huge violation of the normal sysfs
> rules, so I will not allow any new entries to be added.  In fact, the
> whole thing should just be removed and multiple files created in its
> place.

Hi Greg, do you mean to remove all /sys/devices/system/node/node*/meminfo,

but this will beak ABI, is it acceptable?

>
> Can you send a patch to do that instead please?
>
> thanks,
>
> greg k-h
> .
