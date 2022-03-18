Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89954DD796
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbiCRKBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbiCRKBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:01:38 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4EE1017EB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:00:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V7W8-4F_1647597616;
Received: from 30.0.159.17(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V7W8-4F_1647597616)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 18 Mar 2022 18:00:17 +0800
Message-ID: <5cb98e07-1e51-e376-8e67-dffc92f24941@linux.alibaba.com>
Date:   Fri, 18 Mar 2022 18:01:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] mm/damon: Make the sampling more accurate
To:     sj@kernel.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220318094041.26315-1-sj@kernel.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220318094041.26315-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/18/2022 5:40 PM, sj@kernel.org wrote:
> Hi Baolin,
> 
> On Fri, 18 Mar 2022 17:23:13 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>> When I try to sample the physical address with DAMON to migrate pages
>> on tiered memory system, I found it will demote some cold regions mistakenly.
>> Now we will choose an physical address in the region randomly, but if
>> its corresponding page is not an online LRU page, we will ignore the
>> accessing status in this cycle of sampling, and actually will be treated
>> as a non-accessed region. Suppose a region including some non-LRU pages,
>> it will be treated as a cold region with a high probability, and may be
>> merged with adjacent cold regions, but there are some pages may be
>> accessed we missed.
>>
>> So instead of ignoring the access status of this region if we did not find
>> a valid page according to current sampling address, we can use last valid
>> sampling address to help to make the sampling more accurate, then we can do
>> a better decision.
> 
> Well...  Offlined pages are also a valid part of the memory region, so treating
> those as not accessed and making the memory region containing the offlined
> pages looks colder seems legal to me.  IOW, this approach could make memory
> regions containing many non-online-LRU pages as hot.

IMO I don't think this is a problem, since if this region containing 
many non-online-LRU pages is treated as hot, which means threre are aome 
pages are hot, right? We can find them and promote them to fast memory 
(or do other schemes). Meanwhile, for non-online-LRU pages, we can 
filter them and do nothing for them, since we can not get a valid page 
struct for them.

>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   include/linux/damon.h |  2 ++
>>   mm/damon/core.c       |  2 ++
>>   mm/damon/paddr.c      | 15 ++++++++++++---
>>   3 files changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index f23cbfa..3311e15 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -38,6 +38,7 @@ struct damon_addr_range {
>>    * struct damon_region - Represents a monitoring target region.
>>    * @ar:			The address range of the region.
>>    * @sampling_addr:	Address of the sample for the next access check.
>> + * @last_sampling_addr:	Last valid address of the sampling.
>>    * @nr_accesses:	Access frequency of this region.
>>    * @list:		List head for siblings.
>>    * @age:		Age of this region.
>> @@ -50,6 +51,7 @@ struct damon_addr_range {
>>   struct damon_region {
>>   	struct damon_addr_range ar;
>>   	unsigned long sampling_addr;
>> +	unsigned long last_sampling_addr;
>>   	unsigned int nr_accesses;
>>   	struct list_head list;
>>   
>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>> index c1e0fed..957704f 100644
>> --- a/mm/damon/core.c
>> +++ b/mm/damon/core.c
>> @@ -108,6 +108,7 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
>>   	region->ar.start = start;
>>   	region->ar.end = end;
>>   	region->nr_accesses = 0;
>> +	region->last_sampling_addr = 0;
>>   	INIT_LIST_HEAD(&region->list);
>>   
>>   	region->age = 0;
>> @@ -848,6 +849,7 @@ static void damon_split_region_at(struct damon_ctx *ctx,
>>   		return;
>>   
>>   	r->ar.end = new->ar.start;
>> +	r->last_sampling_addr = 0;
>>   
>>   	new->age = r->age;
>>   	new->last_nr_accesses = r->last_nr_accesses;
>> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
>> index 21474ae..5f15068 100644
>> --- a/mm/damon/paddr.c
>> +++ b/mm/damon/paddr.c
>> @@ -31,10 +31,9 @@ static bool __damon_pa_mkold(struct folio *folio, struct vm_area_struct *vma,
>>   	return true;
>>   }
>>   
>> -static void damon_pa_mkold(unsigned long paddr)
>> +static void damon_pa_mkold(struct page *page)
>>   {
>>   	struct folio *folio;
>> -	struct page *page = damon_get_page(PHYS_PFN(paddr));
>>   	struct rmap_walk_control rwc = {
>>   		.rmap_one = __damon_pa_mkold,
>>   		.anon_lock = folio_lock_anon_vma_read,
>> @@ -66,9 +65,19 @@ static void damon_pa_mkold(unsigned long paddr)
>>   static void __damon_pa_prepare_access_check(struct damon_ctx *ctx,
>>   					    struct damon_region *r)
>>   {
>> +	struct page *page;
>> +
>>   	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
>>   
>> -	damon_pa_mkold(r->sampling_addr);
>> +	page = damon_get_page(PHYS_PFN(r->sampling_addr));
>> +	if (page) {
>> +		r->last_sampling_addr = r->sampling_addr;
>> +	} else if (r->last_sampling_addr) {
>> +		r->sampling_addr = r->last_sampling_addr;
>> +		page = damon_get_page(PHYS_PFN(r->last_sampling_addr));
>> +	}
>> +
>> +	damon_pa_mkold(page);
>>   }
>>   
>>   static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
>> -- 
>> 1.8.3.1
