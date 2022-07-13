Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FCB573619
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbiGMMKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbiGMMKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:10:21 -0400
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3A5F5D6F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:10:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VJDq.BW_1657714212;
Received: from 30.240.98.52(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VJDq.BW_1657714212)
          by smtp.aliyun-inc.com;
          Wed, 13 Jul 2022 20:10:14 +0800
Message-ID: <a97e0e17-e4cc-8cc8-673d-28966b95a42b@linux.alibaba.com>
Date:   Wed, 13 Jul 2022 20:10:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:103.0)
 Gecko/20100101 Thunderbird/103.0
Subject: Re: [PATCH v2 1/3] mm/slub: fix the race between validate_slab and
 slab_free
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@gentwo.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Feng Tang <feng.tang@intel.com>
References: <20220712022807.44113-1-rongwei.wang@linux.alibaba.com>
 <Ys6cymrtnHNlCDG9@ip-172-31-24-42.ap-northeast-1.compute.internal>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <Ys6cymrtnHNlCDG9@ip-172-31-24-42.ap-northeast-1.compute.internal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/13/22 6:22 PM, Hyeonggon Yoo wrote:
> On Tue, Jul 12, 2022 at 10:28:05AM +0800, Rongwei Wang wrote:
>> In use cases where allocating and freeing slab frequently, some
>> error messages, such as "Left Redzone overwritten", "First byte
>> 0xbb instead of 0xcc" would be printed when validating slabs.
>> That's because an object has been filled with SLAB_RED_INACTIVE,
>> but has not been added to slab's freelist. And between these
>> two states, the behaviour of validating slab is likely to occur.
>>
>> Actually, it doesn't mean the slab can not work stably. But, these
>> confusing messages will disturb slab debugging more or less.
>>
>> Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
>> ---
>>   mm/slub.c | 43 +++++++++++++++++++++++++------------------
>>   1 file changed, 25 insertions(+), 18 deletions(-)
>>
> 
> This makes the code more complex.
> 
> A part of me says it may be more pleasant to split implementation
> allocating from caches for debugging. That would make it simpler.
> 
> something like:
> 
> __slab_alloc() {
> 	if (kmem_cache_debug(s))
> 		slab_alloc_debug()
> 	else
> 		___slab_alloc()
> }
> 
> slab_free() {
> 	if (kmem_cache_debug(s))
> 		slab_free_debug()
> 	else
> 		__do_slab_free()
> }
Oh, I also have same idea, but not sure whether it is accepted because 
of it needs more changes than now. Since you agree with this way, I can
rewrite this code.

Thanks.
> 
> See also:
> 	https://lore.kernel.org/lkml/faf416b9-f46c-8534-7fb7-557c046a564d@suse.cz/
Thanks, it seems that I had missed it.
> 
>> diff --git a/mm/slub.c b/mm/slub.c
>> index b1281b8654bd..e950d8df8380 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -1391,18 +1391,16 @@ static noinline int free_debug_processing(
>>   	void *head, void *tail, int bulk_cnt,
>>   	unsigned long addr)
>>   {
>> -	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
>>   	void *object = head;
>>   	int cnt = 0;
>> -	unsigned long flags, flags2;
>> +	unsigned long flags;
>>   	int ret = 0;
>>   	depot_stack_handle_t handle = 0;
>>   
>>   	if (s->flags & SLAB_STORE_USER)
>>   		handle = set_track_prepare();
>>   
>> -	spin_lock_irqsave(&n->list_lock, flags);
>> -	slab_lock(slab, &flags2);
>> +	slab_lock(slab, &flags);
>>   
>>   	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
>>   		if (!check_slab(s, slab))
>> @@ -1435,8 +1433,7 @@ static noinline int free_debug_processing(
>>   		slab_err(s, slab, "Bulk freelist count(%d) invalid(%d)\n",
>>   			 bulk_cnt, cnt);
>>   
>> -	slab_unlock(slab, &flags2);
>> -	spin_unlock_irqrestore(&n->list_lock, flags);
>> +	slab_unlock(slab, &flags);
>>   	if (!ret)
>>   		slab_fix(s, "Object at 0x%p not freed", object);
>>   	return ret;
>> @@ -3330,7 +3327,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>>   
>>   {
>>   	void *prior;
>> -	int was_frozen;
>> +	int was_frozen, to_take_off = 0;
>>   	struct slab new;
>>   	unsigned long counters;
>>   	struct kmem_cache_node *n = NULL;
>> @@ -3341,14 +3338,23 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>>   	if (kfence_free(head))
>>   		return;
>>   
>> -	if (kmem_cache_debug(s) &&
>> -	    !free_debug_processing(s, slab, head, tail, cnt, addr))
>> -		return;
>> +	n = get_node(s, slab_nid(slab));
>> +	if (kmem_cache_debug(s)) {
>> +		int ret;
>>   
>> -	do {
>> -		if (unlikely(n)) {
>> +		spin_lock_irqsave(&n->list_lock, flags);
>> +		ret = free_debug_processing(s, slab, head, tail, cnt, addr);
>> +		if (!ret) {
>>   			spin_unlock_irqrestore(&n->list_lock, flags);
>> -			n = NULL;
>> +			return;
>> +		}
>> +	}
>> +
>> +	do {
>> +		if (unlikely(to_take_off)) {
>> +			if (!kmem_cache_debug(s))
>> +				spin_unlock_irqrestore(&n->list_lock, flags);
>> +			to_take_off = 0;
>>   		}
>>   		prior = slab->freelist;
>>   		counters = slab->counters;
>> @@ -3369,8 +3375,6 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>>   				new.frozen = 1;
>>   
>>   			} else { /* Needs to be taken off a list */
>> -
>> -				n = get_node(s, slab_nid(slab));
>>   				/*
>>   				 * Speculatively acquire the list_lock.
>>   				 * If the cmpxchg does not succeed then we may
>> @@ -3379,8 +3383,10 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>>   				 * Otherwise the list_lock will synchronize with
>>   				 * other processors updating the list of slabs.
>>   				 */
>> -				spin_lock_irqsave(&n->list_lock, flags);
>> +				if (!kmem_cache_debug(s))
>> +					spin_lock_irqsave(&n->list_lock, flags);
>>   
>> +				to_take_off = 1;
>>   			}
>>   		}
>>   
>> @@ -3389,8 +3395,9 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>>   		head, new.counters,
>>   		"__slab_free"));
>>   
>> -	if (likely(!n)) {
>> -
>> +	if (likely(!to_take_off)) {
>> +		if (kmem_cache_debug(s))
>> +			spin_unlock_irqrestore(&n->list_lock, flags);
>>   		if (likely(was_frozen)) {
>>   			/*
>>   			 * The list lock was not taken therefore no list
>> -- 
>> 2.27.0
>>
