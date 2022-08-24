Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B8E59F6E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbiHXJxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiHXJxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:53:14 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DF29751B
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 02:52:01 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MCLrh3Gv8zlWPp;
        Wed, 24 Aug 2022 17:48:36 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 17:51:50 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 17:51:50 +0800
Message-ID: <f481a92a-faeb-e108-8538-647b9d3cb395@huawei.com>
Date:   Wed, 24 Aug 2022 17:51:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] mm: slince possible data races about pgdat->kswapd
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <muchun.song@linux.dev>, <linux-kernel@vger.kernel.org>
References: <20220824071909.192535-1-wangkefeng.wang@huawei.com>
 <20220824071909.192535-2-wangkefeng.wang@huawei.com>
 <e5223895-6319-1911-28bf-09449ded96c9@redhat.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <e5223895-6319-1911-28bf-09449ded96c9@redhat.com>
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


On 2022/8/24 16:24, David Hildenbrand wrote:
> On 24.08.22 09:19, Kefeng Wang wrote:
>> The pgdat->kswapd could be accessed concurrently by kswapd_run() and
>> kcompactd(), it don't be protected by any lock, which could leads to
>> data races, adding READ/WRITE_ONCE() to slince it.
> Okay, I think this patch here makes it clearer that we really just want
> proper synchronization instead of hacking around it.
>
> What speaks against protecting pgdat->kswapd this using some proper
> locking primitive?

So add a new lock into struct pglist_data to protect pgdat->kswapd，other

option, thanks.

>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   mm/compaction.c | 4 +++-
>>   mm/vmscan.c     | 8 ++++----
>>   2 files changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 640fa76228dd..aa1cfe47f046 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -1983,7 +1983,9 @@ static inline bool is_via_compact_memory(int order)
>>   
>>   static bool kswapd_is_running(pg_data_t *pgdat)
>>   {
>> -	return pgdat->kswapd && task_is_running(pgdat->kswapd);
>> +	struct task_struct *t = READ_ONCE(pgdat->kswapd);
>> +
>> +	return t && task_is_running(t);
>>   }
>>   
>>   /*
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 08c6497f76c3..65b19ca8c8ee 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -4644,7 +4644,7 @@ void kswapd_run(int nid)
>>   	pg_data_t *pgdat = NODE_DATA(nid);
>>   	struct task_struct *t;
>>   
>> -	if (pgdat->kswapd)
>> +	if (READ_ONCE(pgdat->kswapd))
>>   		return;
>>   
>>   	t = kthread_run(kswapd, pgdat, "kswapd%d", nid);
>> @@ -4653,7 +4653,7 @@ void kswapd_run(int nid)
>>   		BUG_ON(system_state < SYSTEM_RUNNING);
>>   		pr_err("Failed to start kswapd on node %d\n", nid);
>>   	} else {
>> -		pgdat->kswapd = t;
>> +		WRITE_ONCE(pgdat->kswapd, t);
>>   	}
>>   }
>>   
>> @@ -4663,11 +4663,11 @@ void kswapd_run(int nid)
>>    */
>>   void kswapd_stop(int nid)
>>   {
>> -	struct task_struct *kswapd = NODE_DATA(nid)->kswapd;
>> +	struct task_struct *kswapd = READ_ONCE(NODE_DATA(nid)->kswapd);
>>   
>>   	if (kswapd) {
>>   		kthread_stop(kswapd);
>> -		NODE_DATA(nid)->kswapd = NULL;
>> +		WRITE_ONCE(NODE_DATA(nid)->kswapd, NULL);
>>   	}
>>   }
>>   
>
