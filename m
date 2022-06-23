Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45213557A0A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiFWMLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiFWMLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:11:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568694DF6F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:11:13 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LTJvL5Y5wzhYc9;
        Thu, 23 Jun 2022 20:09:02 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 20:11:09 +0800
Subject: Re: [PATCH 13/16] mm/huge_memory: add helper
 __get_deferred_split_queue
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <akpm@linux-foundation.org>, <shy828301@gmail.com>,
        <willy@infradead.org>, <zokeefe@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
 <20220622170627.19786-14-linmiaohe@huawei.com>
 <YrQQNs42R519/P8X@FVFYT0MHHV2J.usts.net>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a07cb5cc-eb8c-3a01-38a8-b06c7d5427c1@huawei.com>
Date:   Thu, 23 Jun 2022 20:11:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YrQQNs42R519/P8X@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/23 15:03, Muchun Song wrote:
> On Thu, Jun 23, 2022 at 01:06:24AM +0800, Miaohe Lin wrote:
>> Add helper __get_deferred_split_queue to remove the duplicated codes of
>> getting ds_queue. No functional change intended.
>>
> 
> Sorry, I suggest dropping this change since I have reworked the code here [1].

That's all right. Thanks for your work. :)

> 
> [1] https://lore.kernel.org/all/20220621125658.64935-7-songmuchun@bytedance.com/
> 
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/huge_memory.c | 35 ++++++++++++-----------------------
>>  1 file changed, 12 insertions(+), 23 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 0030b4f67cd9..de8155ff584c 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -555,25 +555,23 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
>>  	return pmd;
>>  }
>>  
>> -#ifdef CONFIG_MEMCG
>> -static inline struct deferred_split *get_deferred_split_queue(struct page *page)
>> +static inline struct deferred_split *__get_deferred_split_queue(struct pglist_data *pgdat,
>> +								struct mem_cgroup *memcg)
>>  {
>> -	struct mem_cgroup *memcg = page_memcg(compound_head(page));
>> -	struct pglist_data *pgdat = NODE_DATA(page_to_nid(page));
>> -
>> +#ifdef CONFIG_MEMCG
>>  	if (memcg)
>>  		return &memcg->deferred_split_queue;
>> -	else
>> -		return &pgdat->deferred_split_queue;
>> +#endif
>> +	return &pgdat->deferred_split_queue;
>>  }
>> -#else
>> +
>>  static inline struct deferred_split *get_deferred_split_queue(struct page *page)
>>  {
>> +	struct mem_cgroup *memcg = page_memcg(compound_head(page));
>>  	struct pglist_data *pgdat = NODE_DATA(page_to_nid(page));
>>  
>> -	return &pgdat->deferred_split_queue;
>> +	return __get_deferred_split_queue(pgdat, memcg);
>>  }
>> -#endif
>>  
>>  void prep_transhuge_page(struct page *page)
>>  {
>> @@ -2774,31 +2772,22 @@ void deferred_split_huge_page(struct page *page)
>>  static unsigned long deferred_split_count(struct shrinker *shrink,
>>  		struct shrink_control *sc)
>>  {
>> -	struct pglist_data *pgdata = NODE_DATA(sc->nid);
>> -	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
>> +	struct deferred_split *ds_queue;
>>  
>> -#ifdef CONFIG_MEMCG
>> -	if (sc->memcg)
>> -		ds_queue = &sc->memcg->deferred_split_queue;
>> -#endif
>> +	ds_queue = __get_deferred_split_queue(NODE_DATA(sc->nid), sc->memcg);
>>  	return READ_ONCE(ds_queue->split_queue_len);
>>  }
>>  
>>  static unsigned long deferred_split_scan(struct shrinker *shrink,
>>  		struct shrink_control *sc)
>>  {
>> -	struct pglist_data *pgdata = NODE_DATA(sc->nid);
>> -	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
>> +	struct deferred_split *ds_queue;
>>  	unsigned long flags;
>>  	LIST_HEAD(list), *pos, *next;
>>  	struct page *page;
>>  	int split = 0;
>>  
>> -#ifdef CONFIG_MEMCG
>> -	if (sc->memcg)
>> -		ds_queue = &sc->memcg->deferred_split_queue;
>> -#endif
>> -
>> +	ds_queue = __get_deferred_split_queue(NODE_DATA(sc->nid), sc->memcg);
>>  	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>>  	/* Take pin on all head pages to avoid freeing them under us */
>>  	list_for_each_safe(pos, next, &ds_queue->split_queue) {
>> -- 
>> 2.23.0
>>
>>
> .
> 

