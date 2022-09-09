Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBADE5B2BF2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 04:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiIICKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 22:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIICKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 22:10:39 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31B7AB4D0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 19:10:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VP6wNel_1662689427;
Received: from 30.240.97.206(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VP6wNel_1662689427)
          by smtp.aliyun-inc.com;
          Fri, 09 Sep 2022 10:10:28 +0800
Message-ID: <3b8f34c9-71ca-e5d8-a31d-f8b9e50bdb7e@linux.alibaba.com>
Date:   Fri, 9 Sep 2022 10:10:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH V3] mm/damon: Remove duplicate get_monitoring_region()
 definitions
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220908181931.91994-1-sj@kernel.org>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220908181931.91994-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/9 上午2:19, SeongJae Park 写道:
> Hi Xin,
>
>
> Thanks for your efforts!  But, please answer to some more comments below.
>
>> In lru_sort.c and reclaim.c, they are all defining get_monitoring_region()
>> function, there is no need to define it separately.
>>
>> BTW, this patch removes two struct 'damon_lru_sort_ram_walk_arg' and
>> 'damon_reclaim_ram_walk_arg', though the two structs are removed, if we
>> want to add more fields to these structs for other purposes later, it will
>> not too late for us to use them again.
>> For example:
>>      struct damon_reclaim_ram_walk_arg {
>> 	struct damon_addr_range raw_walk;
>> 	xxx  A;
>> 	xxx  B;
>>      }
>>      struct damon_lru_sort_ram_walk_arg {
>> 	struct damon_addr_range raw_walk;
>> 	xxx  A;
>> 	xxx  B;
>>      }
> Sorry, seems I didn't make my words clear enough.  What I'm concerning[1] is,
> any possible future change to 'struct damon_addr_range', not to
> 'struct damon_{reclaim,lru_sort}_ram_walk_arg'.
>
> Also, after all, as mentioned before, the purpose of 'struct damon_addr_range'
> is not saving the 'start' and 'end' fields of 'struct resource'.  Let's use
> different types for different purposes to avoid any unneeded dependencies.
Ok， i will define another struct.
>
> [1] https://lore.kernel.org/damon/20220907172712.61006-1-sj@kernel.org/
>
>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>> ---
>>   include/linux/damon.h |  1 +
>>   mm/damon/core.c       | 28 ++++++++++++++++++++++++++++
>>   mm/damon/lru_sort.c   | 37 ++-----------------------------------
>>   mm/damon/reclaim.c    | 37 ++-----------------------------------
>>   4 files changed, 33 insertions(+), 70 deletions(-)
>>
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index 7b1f4a488230..f27b92e5afc2 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -500,6 +500,7 @@ void damon_add_region(struct damon_region *r, struct damon_target *t);
>>   void damon_destroy_region(struct damon_region *r, struct damon_target *t);
>>   int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
>>   		unsigned int nr_ranges);
>> +bool damon_get_sram_monitoring_region(unsigned long *start, unsigned long *end);
>>
>>   struct damos *damon_new_scheme(
>>   		unsigned long min_sz_region, unsigned long max_sz_region,
>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>> index 7d25dc582fe3..05a2d1b9d03d 100644
>> --- a/mm/damon/core.c
>> +++ b/mm/damon/core.c
>> @@ -276,6 +276,34 @@ struct damos *damon_new_scheme(
>>   	return scheme;
>>   }
>>
>> +static inline int walk_system_ram(struct resource *res, void *arg)
> We will pass pointer to this function.  I guess 'inline' makes no sense?
  Ok, i will remove it.
>> +{
>> +	struct damon_addr_range *a = arg;
>> +
>> +	if (a->end - a->start < resource_size(res)) {
>> +		a->start = res->start;
>> +		a->end = res->end;
>> +	}
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Find biggest 'System RAM' resource and store its start and end address in
>> + * @start and @end, respectively.  If no System RAM is found, returns false.
>> + */
>> +bool damon_get_sram_monitoring_region(unsigned long *start, unsigned long *end)
> We should avoid too verbose name, so 'sram' looks nice, but it might be able to
> be more clear to let readers know what it does.  For an example, how about
> 'damon_find_biggest_system_ram()'?
Ok.
>
> Below parts all look good.
>
>
> Thanks,
> SJ
>
> [...]
