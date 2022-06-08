Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679C95423E4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiFHFiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbiFHFhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:37:48 -0400
Received: from out199-2.us.a.mail.aliyun.com (out199-2.us.a.mail.aliyun.com [47.90.199.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB2312FB2A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 20:05:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VFj.fTT_1654657496;
Received: from 30.240.97.53(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VFj.fTT_1654657496)
          by smtp.aliyun-inc.com;
          Wed, 08 Jun 2022 11:04:58 +0800
Message-ID: <29723aaa-5e28-51d3-7f87-9edf0f7b9c33@linux.alibaba.com>
Date:   Wed, 8 Jun 2022 11:04:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0
Subject: Re: [PATCH 1/3] mm/slub: fix the race between validate_slab and
 slab_free
To:     Christoph Lameter <cl@gentwo.de>
Cc:     David Rientjes <rientjes@google.com>, songmuchun@bytedance.com,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, akpm@linux-foundation.org,
        vbabka@suse.cz, roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        penberg@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com>
 <YpNa4tB/jfW3MDyi@n2.us-central1-a.c.spheric-algebra-350919.internal>
 <ac9ba68f-9ee2-1611-9ff8-b486ed9c4df0@google.com>
 <alpine.DEB.2.22.394.2206021712530.2924@gentwo.de>
 <9794df4f-3ffe-4e99-0810-a1346b139ce8@linux.alibaba.com>
 <alpine.DEB.2.22.394.2206071411460.375438@gentwo.de>
Content-Language: en-US
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <alpine.DEB.2.22.394.2206071411460.375438@gentwo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/22 8:14 PM, Christoph Lameter wrote:
> On Fri, 3 Jun 2022, Rongwei Wang wrote:
> 
>> Recently, I am also find other ways to solve this. That case was provided by
>> Muchun is useful (Thanks Muchun!). Indeed, it seems that use n->list_lock here
>> is unwise. Actually, I'm not sure if you recognize the existence of such race?
>> If all agrees this race, then the next question may be: do we want to solve
>> this problem? or as David said, it would be better to deprecate validate
>> attribute directly. I have no idea about it, hope to rely on your experience.
>>
>> In fact, I mainly want to collect your views on whether or how to fix this bug
>> here. Thanks!
> 
> 
> Well validate_slab() is rarely used and should not cause the hot paths to
> incur performance penalties. Fix it in the validation logic somehow? Or
> document the issue and warn that validation may not be correct if there
If available, I think document the issue and warn this incorrect 
behavior is OK. But it still prints a large amount of confusing 
messages, and disturbs us?
> are current operations on the slab being validated.
And I am trying to fix it in following way. In a short, these changes 
only works under the slub debug mode, and not affects the normal mode 
(I'm not sure). It looks not elegant enough. And if all approve of this 
way, I can submit the next version.

Anyway, thanks for your time:).
-wrw

@@ -3304,7 +3300,7 @@ static void __slab_free(struct kmem_cache *s, 
struct slab *slab,

  {
         void *prior;
-       int was_frozen;
+       int was_frozen, to_take_off = 0;
         struct slab new;
         unsigned long counters;
         struct kmem_cache_node *n = NULL;
@@ -3315,14 +3311,23 @@ static void __slab_free(struct kmem_cache *s, 
struct slab *slab,
         if (kfence_free(head))
                 return;

-       if (kmem_cache_debug(s) &&
-           !free_debug_processing(s, slab, head, tail, cnt, addr))
-               return;
+       n = get_node(s, slab_nid(slab));
+       if (kmem_cache_debug(s)) {
+               int ret;

-       do {
-               if (unlikely(n)) {
+               spin_lock_irqsave(&n->list_lock, flags);
+               ret = free_debug_processing(s, slab, head, tail, cnt, addr);
+               if (!ret) {
                         spin_unlock_irqrestore(&n->list_lock, flags);
-                       n = NULL;
+                       return;
+               }
+       }
+
+       do {
+               if (unlikely(to_take_off)) {
+                       if (!kmem_cache_debug(s))
+                               spin_unlock_irqrestore(&n->list_lock, 
flags);
+                       to_take_off = 0;
                 }
                 prior = slab->freelist;
                 counters = slab->counters;
@@ -3343,8 +3348,6 @@ static void __slab_free(struct kmem_cache *s, 
struct slab *slab,
                                 new.frozen = 1;

                         } else { /* Needs to be taken off a list */
-
-                               n = get_node(s, slab_nid(slab));
                                 /*
                                  * Speculatively acquire the list_lock.
                                  * If the cmpxchg does not succeed then 
we may
@@ -3353,8 +3356,10 @@ static void __slab_free(struct kmem_cache *s, 
struct slab *slab,
                                  * Otherwise the list_lock will 
synchronize with
                                  * other processors updating the list 
of slabs.
                                  */
-                               spin_lock_irqsave(&n->list_lock, flags);
+                               if (!kmem_cache_debug(s))
+                                       spin_lock_irqsave(&n->list_lock, 
flags);

+                               to_take_off = 1;
                         }
                 }

@@ -3363,8 +3368,9 @@ static void __slab_free(struct kmem_cache *s, 
struct slab *slab,
                 head, new.counters,
                 "__slab_free"));

-       if (likely(!n)) {
-
+       if (likely(!to_take_off)) {
+               if (kmem_cache_debug(s))
+                       spin_unlock_irqrestore(&n->list_lock, flags);
                 if (likely(was_frozen)) {
                         /*
                          * The list lock was not taken therefore no list
> 
