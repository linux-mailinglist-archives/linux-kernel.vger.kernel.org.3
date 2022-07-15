Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58394575CFA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiGOIFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiGOIFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:05:37 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928B661D65
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 01:05:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VJOTsiV_1657872329;
Received: from 30.240.97.187(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VJOTsiV_1657872329)
          by smtp.aliyun-inc.com;
          Fri, 15 Jul 2022 16:05:31 +0800
Message-ID: <aceab1c8-0c10-fa5f-da39-6820294494c4@linux.alibaba.com>
Date:   Fri, 15 Jul 2022 16:05:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:103.0)
 Gecko/20100101 Thunderbird/103.0
Subject: Re: [PATCH 1/3] mm/slub: fix the race between validate_slab and
 slab_free
To:     Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     David Rientjes <rientjes@google.com>, songmuchun@bytedance.com,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        penberg@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com>
 <YpNa4tB/jfW3MDyi@n2.us-central1-a.c.spheric-algebra-350919.internal>
 <ac9ba68f-9ee2-1611-9ff8-b486ed9c4df0@google.com>
 <alpine.DEB.2.22.394.2206021712530.2924@gentwo.de>
 <9794df4f-3ffe-4e99-0810-a1346b139ce8@linux.alibaba.com>
 <alpine.DEB.2.22.394.2206071411460.375438@gentwo.de>
 <29723aaa-5e28-51d3-7f87-9edf0f7b9c33@linux.alibaba.com>
 <alpine.DEB.2.22.394.2206081417370.465021@gentwo.de>
 <faf416b9-f46c-8534-7fb7-557c046a564d@suse.cz>
Content-Language: en-US
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <faf416b9-f46c-8534-7fb7-557c046a564d@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/17/22 5:40 PM, Vlastimil Babka wrote:
> On 6/8/22 14:23, Christoph Lameter wrote:
>> On Wed, 8 Jun 2022, Rongwei Wang wrote:
>>
>>> If available, I think document the issue and warn this incorrect behavior is
>>> OK. But it still prints a large amount of confusing messages, and disturbs us?
>>
>> Correct it would be great if you could fix this in a way that does not
>> impact performance.
>>
>>>> are current operations on the slab being validated.
>>> And I am trying to fix it in following way. In a short, these changes only
>>> works under the slub debug mode, and not affects the normal mode (I'm not
>>> sure). It looks not elegant enough. And if all approve of this way, I can
>>> submit the next version.
>>
>>
>>>
>>> Anyway, thanks for your time:).
>>> -wrw
>>>
>>> @@ -3304,7 +3300,7 @@ static void __slab_free(struct kmem_cache *s,
>> struct
>>> slab *slab,
>>>
>>>   {
>>>          void *prior;
>>> -       int was_frozen;
>>> +       int was_frozen, to_take_off = 0;
>>>          struct slab new;
>>
>> to_take_off has the role of !n ? Why is that needed?
>>
>>> -       do {
>>> -               if (unlikely(n)) {
>>> +               spin_lock_irqsave(&n->list_lock, flags);
>>> +               ret = free_debug_processing(s, slab, head, tail, cnt, addr);
>>
>> Ok so the idea is to take the lock only if kmem_cache_debug. That looks
>> ok. But it still adds a number of new branches etc to the free loop.
> 
Hi, Vlastimil, sorry for missing your message long time.
> It also further complicates the already tricky code. I wonder if we should
> make more benefit from the fact that for kmem_cache_debug() caches we don't
> leave any slabs on percpu or percpu partial lists, and also in
> free_debug_processing() we aready take both list_lock and slab_lock. If we
> just did the freeing immediately there under those locks, we would be
> protected against other freeing cpus by that list_lock and don't need the
> double cmpxchg tricks.
enen, I'm not sure get your "don't need the double cmpxchg tricks" means 
completely. What you want to say is that replace cmpxchg_double_slab() 
here with following code when kmem_cache_debug(s)?

__slab_lock(slab);
if (slab->freelist == freelist_old && slab->counters == counters_old){
     slab->freelist = freelist_new;
     slab->counters = counters_new;
     __slab_unlock(slab);
     local_irq_restore(flags);
     return true;
}
__slab_unlock(slab);

If I make mistakes for your words, please let me know.
Thanks!
> 
> What about against allocating cpus? More tricky as those will currently end
> up privatizing the freelist via get_partial(), only to deactivate it again,
> so our list_lock+slab_lock in freeing path would not protect in the
> meanwhile. But the allocation is currently very inefficient for debug
> caches, as in get_partial() it will take the list_lock to take the slab from
> partial list and then in most cases again in deactivate_slab() to return it.
It seems that I need speed some time to eat these words. Anyway, thanks.
> 
> If instead the allocation path for kmem_cache_debug() cache would take a
> single object from the partial list (not whole freelist) under list_lock, it
> would be ultimately more efficient, and protect against freeing using
> list_lock. Sounds like an idea worth trying to me?

Hyeonggon had a similar advice that split freeing and allocating slab 
from debugging, likes below:


__slab_alloc() {
     if (kmem_cache_debug(s))
         slab_alloc_debug()
     else
         ___slab_alloc()
}

I guess that above code aims to solve your mentioned problem (idea)?

slab_free() {
     if (kmem_cache_debug(s))
         slab_free_debug()
     else
         __do_slab_free()
}

Currently, I only modify the code of freeing slab to fix the confusing 
messages of "slabinfo -v". If you agree, I can try to realize above 
mentioned slab_alloc_debug() code. Maybe it's also a challenge to me.

Thanks for your time.

> And of course we would stop creating the 'validate' sysfs files for
> non-debug caches.
