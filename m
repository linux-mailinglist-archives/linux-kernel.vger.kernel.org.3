Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C93538D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 10:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244995AbiEaIvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 04:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245033AbiEaIuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 04:50:51 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AF68BD02
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 01:50:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VEuUt9n_1653987042;
Received: from 30.240.97.90(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VEuUt9n_1653987042)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 31 May 2022 16:50:43 +0800
Message-ID: <a8441001-46f3-6bf1-8c4d-984e1abd448b@linux.alibaba.com>
Date:   Tue, 31 May 2022 16:50:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:101.0)
 Gecko/20100101 Thunderbird/101.0
Subject: Re: [PATCH 1/3] mm/slub: fix the race between validate_slab and
 slab_free
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@linux.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com>
 <YpNa4tB/jfW3MDyi@n2.us-central1-a.c.spheric-algebra-350919.internal>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <YpNa4tB/jfW3MDyi@n2.us-central1-a.c.spheric-algebra-350919.internal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/29/22 7:37 PM, Hyeonggon Yoo wrote:
> On Sun, May 29, 2022 at 04:15:33PM +0800, Rongwei Wang wrote:
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
> 
> Have you observed it or it's from code inspection?
Hi, Hyeonggon

I try to build a module to trigger the race:

#define SLUB_KTHREAD_MAX 1
static int do_slub_alloc(void *data)
{
         char *mm = NULL;
         char *mm1 = NULL;
         char *mm2 = NULL;
         char *mm3 = NULL;

         allow_signal(SIGTERM);

         while (1) {
                 mm = kmalloc(2048, GFP_KERNEL);
                 if (mm)
                         mm[0x100] = 0x21;

                 if (mm)
                         kfree(mm);

                 mm = NULL;
                 if (kthread_should_stop())
                         break;
         }

         return 0;
}

static int __init mini_init(void)
{
         char *mm;
         int i = 0;
         unsigned int index;
         char kth_name[11] = "do_slub_00";

         for (i = 0; i < SLUB_KTHREAD_MAX; i++) {
                 kth_name[9] = '0' + i%10;
                 kth_name[8] = '0' + i/10;
                 slub_thread[i] = kthread_run(do_slub_alloc, NULL, 
kth_name);
         }

         return 0;
}
module_init(mini_init);

And in my system, I add 'slub_debug=UFPZ' to the boot options. Next, the 
error messages will be printed when I test "slabinfo -v" or "echo 1 > 
/sys/kernel/slab/kmalloc-2048/validate".

> 
>> ---
>>   mm/slub.c | 40 +++++++++++++++++-----------------------
>>   1 file changed, 17 insertions(+), 23 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index ed5c2c03a47a..310e56d99116 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -1374,15 +1374,12 @@ static noinline int free_debug_processing(
>>   	void *head, void *tail, int bulk_cnt,
>>   	unsigned long addr)
>>   {
>> -	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
>>   	void *object = head;
>>   	int cnt = 0;
>> -	unsigned long flags, flags2;
>> +	unsigned long flags;
>>   	int ret = 0;
>>   
>> -	spin_lock_irqsave(&n->list_lock, flags);
>> -	slab_lock(slab, &flags2);
>> -
>> +	slab_lock(slab, &flags);
>>   	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
>>   		if (!check_slab(s, slab))
>>   			goto out;
>> @@ -1414,8 +1411,7 @@ static noinline int free_debug_processing(
>>   		slab_err(s, slab, "Bulk freelist count(%d) invalid(%d)\n",
>>   			 bulk_cnt, cnt);
>>   
>> -	slab_unlock(slab, &flags2);
>> -	spin_unlock_irqrestore(&n->list_lock, flags);
>> +	slab_unlock(slab, &flags);
>>   	if (!ret)
>>   		slab_fix(s, "Object at 0x%p not freed", object);
>>   	return ret;
>> @@ -3304,7 +3300,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>>   
>>   {
>>   	void *prior;
>> -	int was_frozen;
>> +	int was_frozen, to_take_off = 0;
>>   	struct slab new;
>>   	unsigned long counters;
>>   	struct kmem_cache_node *n = NULL;
>> @@ -3315,15 +3311,19 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>>   	if (kfence_free(head))
>>   		return;
>>   
>> +	n = get_node(s, slab_nid(slab));
>> +	spin_lock_irqsave(&n->list_lock, flags);
>> +
> 
> Oh please don't do this.
> 
> SLUB free slowpath can be hit a lot depending on workload.
Thanks, your words remind me. Actually, I put the original in 
free_debug_processing() lock on the outside of it. Looks this change is 
small. Indeed, it will degrade performance more or less.

And do you have other ideas?:)

-wrw
> 
> __slab_free() try its best not to take n->list_lock. currently takes n->list_lock
> only when the slab need to be taken from list.
> 
> Unconditionally taking n->list_lock will degrade performance.
> 
>>   	if (kmem_cache_debug(s) &&
>> -	    !free_debug_processing(s, slab, head, tail, cnt, addr))
>> +	    !free_debug_processing(s, slab, head, tail, cnt, addr)) {
>> +
>> +		spin_unlock_irqrestore(&n->list_lock, flags);
>>   		return;
>> +	}
>>   
>>   	do {
>> -		if (unlikely(n)) {
>> -			spin_unlock_irqrestore(&n->list_lock, flags);
>> -			n = NULL;
>> -		}
>> +		if (unlikely(to_take_off))
>> +			to_take_off = 0;
>>   		prior = slab->freelist;
>>   		counters = slab->counters;
>>   		set_freepointer(s, tail, prior);
>> @@ -3343,18 +3343,11 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>>   				new.frozen = 1;
>>   
>>   			} else { /* Needs to be taken off a list */
>> -
>> -				n = get_node(s, slab_nid(slab));
>>   				/*
>> -				 * Speculatively acquire the list_lock.
>>   				 * If the cmpxchg does not succeed then we may
>> -				 * drop the list_lock without any processing.
>> -				 *
>> -				 * Otherwise the list_lock will synchronize with
>> -				 * other processors updating the list of slabs.
>> +				 * drop this behavior without any processing.
>>   				 */
>> -				spin_lock_irqsave(&n->list_lock, flags);
>> -
>> +				to_take_off = 1;
>>   			}
>>   		}
>>   
>> @@ -3363,8 +3356,9 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>>   		head, new.counters,
>>   		"__slab_free"));
>>   
>> -	if (likely(!n)) {
>> +	if (likely(!to_take_off)) {
>>   
>> +		spin_unlock_irqrestore(&n->list_lock, flags);
>>   		if (likely(was_frozen)) {
>>   			/*
>>   			 * The list lock was not taken therefore no list
>>
>> -- 
>> 2.27.0
>>
