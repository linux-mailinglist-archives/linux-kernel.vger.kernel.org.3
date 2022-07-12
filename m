Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E4C571086
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 04:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiGLC5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 22:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGLC5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 22:57:35 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12032AC48
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:57:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VJ6Y.O0_1657594647;
Received: from 30.240.98.134(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VJ6Y.O0_1657594647)
          by smtp.aliyun-inc.com;
          Tue, 12 Jul 2022 10:57:29 +0800
Message-ID: <c46f8d03-ace2-330c-349a-f274aadb79de@linux.alibaba.com>
Date:   Tue, 12 Jul 2022 10:57:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:103.0)
 Gecko/20100101 Thunderbird/103.0
Subject: Re: [PATCH v2 1/3] mm/slub: fix the race between validate_slab and
 slab_free
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, vbabka@suse.cz, 42.hyeyoo@gmail.com,
        roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@gentwo.de
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220712022807.44113-1-rongwei.wang@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20220712022807.44113-1-rongwei.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

According to all's point in PATCH v1 [1], I rewrote the first patch
"mm/slub: fix the race between validate_slab and slab_free". And now, 
these changes only works when DEBUG SLUB enabled. Plus, here some 
performance test can been found in [2] (Thanks Christoph's suggestion).

changelog
v1->v2:
*mm/slub: fix the race between validate_slab and slab_free
make these changes can work when debug slub enabled.

*mm/slub: improve consistency of nr_slabs count
nothing

*mm/slub: delete confusing pr_err when debugging slub
only deleting the confusing pr_err().

For convenient, showing the latest test data here (copy from [2]):

testcase used: https://github.com/netoptimizer/prototype-kernel.git
(slab_test)

Single thread testing
1. Kmalloc: Repeatedly allocate then free test
                    before                fix
                    kmalloc    kfree      kmalloc     kfree
10000 times 8     4 cycles   5 cycles	4 cycles    5 cycles
10000 times 16    3 cycles   5 cycles	3 cycles    5 cycles
10000 times 32    3 cycles   5 cycles	3 cycles    5 cycles
10000 times 64    3 cycles   5 cycles	3 cycles    5 cycles
10000 times 128   3 cycles   5 cycles	3 cycles    5 cycles
10000 times 256   14 cycles  9 cycles	6 cycles    8 cycles
10000 times 512   9 cycles   8 cycles	9 cycles    10 cycles
10000 times 1024  48 cycles  10 cycles	6 cycles    10 cycles
10000 times 2048  31 cycles  12 cycles	35 cycles   13 cycles
10000 times 4096  96 cycles  17 cycles	96 cycles   18 cycles
10000 times 8192  188 cycles 27 cycles	190 cycles  27 cycles
10000 times 16384 117 cycles 38 cycles  115 cycles  38 cycles
			
2. Kmalloc: alloc/free test
                                    before        fix
10000 times kmalloc(8)/kfree      3 cycles      3 cycles
10000 times kmalloc(16)/kfree     3 cycles      3 cycles
10000 times kmalloc(32)/kfree     3 cycles      3 cycles
10000 times kmalloc(64)/kfree     3 cycles      3 cycles
10000 times kmalloc(128)/kfree    3 cycles      3 cycles
10000 times kmalloc(256)/kfree    3 cycles      3 cycles
10000 times kmalloc(512)/kfree    3 cycles      3 cycles
10000 times kmalloc(1024)/kfree   3 cycles      3 cycles
10000 times kmalloc(2048)/kfree   3 cycles      3 cycles
10000 times kmalloc(4096)/kfree   3 cycles      3 cycles
10000 times kmalloc(8192)/kfree   3 cycles      3 cycles
10000 times kmalloc(16384)/kfree  33 cycles     33 cycles

Concurrent allocs
                                  before            fix
Kmalloc N*alloc N*free(8)       Average=13/14     Average=14/15
Kmalloc N*alloc N*free(16)      Average=13/15     Average=13/15
Kmalloc N*alloc N*free(32)      Average=13/15     Average=13/15
Kmalloc N*alloc N*free(64)      Average=13/15     Average=13/15
Kmalloc N*alloc N*free(128)     Average=13/15     Average=13/15
Kmalloc N*alloc N*free(256)     Average=137/29    Average=134/39
Kmalloc N*alloc N*free(512)     Average=61/29     Average=64/28
Kmalloc N*alloc N*free(1024)    Average=465/50    Average=656/55
Kmalloc N*alloc N*free(2048)    Average=503/97    Average=422/97
Kmalloc N*alloc N*free(4096)    Average=1592/206  Average=1624/207
		
Kmalloc N*(alloc free)(8)       Average=3         Average=3
Kmalloc N*(alloc free)(16)      Average=3         Average=3
Kmalloc N*(alloc free)(32)      Average=3         Average=3
Kmalloc N*(alloc free)(64)      Average=3         Average=3
Kmalloc N*(alloc free)(128)     Average=3         Average=3
Kmalloc N*(alloc free)(256)     Average=3         Average=3
Kmalloc N*(alloc free)(512)     Average=3         Average=3
Kmalloc N*(alloc free)(1024)    Average=3         Average=3
Kmalloc N*(alloc free)(2048)    Average=3         Average=3
Kmalloc N*(alloc free)(4096)    Average=3         Average=3

The above data seems indicate that this modification (only works when
kmem_cache_debug(s) is true) does not introduce significant performance
impact. And if you have better suggestion of testcase, please let me 
know, Thanks!

[1] 
https://lore.kernel.org/linux-mm/alpine.DEB.2.22.394.2206081417370.465021@gentwo.de/T/#m2832b1983a229183aabfd6eb71a2eb39ecd0d08a

[2] 
https://lore.kernel.org/linux-mm/alpine.DEB.2.22.394.2206081417370.465021@gentwo.de/T/#m75f1f32ad590fb13ac9e771030fafd15c7db8cb1

Thanks for your time!

On 7/12/22 10:28 AM, Rongwei Wang wrote:
> In use cases where allocating and freeing slab frequently, some
> error messages, such as "Left Redzone overwritten", "First byte
> 0xbb instead of 0xcc" would be printed when validating slabs.
> That's because an object has been filled with SLAB_RED_INACTIVE,
> but has not been added to slab's freelist. And between these
> two states, the behaviour of validating slab is likely to occur.
> 
> Actually, it doesn't mean the slab can not work stably. But, these
> confusing messages will disturb slab debugging more or less.
> 
> Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
> ---
>   mm/slub.c | 43 +++++++++++++++++++++++++------------------
>   1 file changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index b1281b8654bd..e950d8df8380 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1391,18 +1391,16 @@ static noinline int free_debug_processing(
>   	void *head, void *tail, int bulk_cnt,
>   	unsigned long addr)
>   {
> -	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
>   	void *object = head;
>   	int cnt = 0;
> -	unsigned long flags, flags2;
> +	unsigned long flags;
>   	int ret = 0;
>   	depot_stack_handle_t handle = 0;
>   
>   	if (s->flags & SLAB_STORE_USER)
>   		handle = set_track_prepare();
>   
> -	spin_lock_irqsave(&n->list_lock, flags);
> -	slab_lock(slab, &flags2);
> +	slab_lock(slab, &flags);
>   
>   	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
>   		if (!check_slab(s, slab))
> @@ -1435,8 +1433,7 @@ static noinline int free_debug_processing(
>   		slab_err(s, slab, "Bulk freelist count(%d) invalid(%d)\n",
>   			 bulk_cnt, cnt);
>   
> -	slab_unlock(slab, &flags2);
> -	spin_unlock_irqrestore(&n->list_lock, flags);
> +	slab_unlock(slab, &flags);
>   	if (!ret)
>   		slab_fix(s, "Object at 0x%p not freed", object);
>   	return ret;
> @@ -3330,7 +3327,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>   
>   {
>   	void *prior;
> -	int was_frozen;
> +	int was_frozen, to_take_off = 0;
>   	struct slab new;
>   	unsigned long counters;
>   	struct kmem_cache_node *n = NULL;
> @@ -3341,14 +3338,23 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>   	if (kfence_free(head))
>   		return;
>   
> -	if (kmem_cache_debug(s) &&
> -	    !free_debug_processing(s, slab, head, tail, cnt, addr))
> -		return;
> +	n = get_node(s, slab_nid(slab));
> +	if (kmem_cache_debug(s)) {
> +		int ret;
>   
> -	do {
> -		if (unlikely(n)) {
> +		spin_lock_irqsave(&n->list_lock, flags);
> +		ret = free_debug_processing(s, slab, head, tail, cnt, addr);
> +		if (!ret) {
>   			spin_unlock_irqrestore(&n->list_lock, flags);
> -			n = NULL;
> +			return;
> +		}
> +	}
> +
> +	do {
> +		if (unlikely(to_take_off)) {
> +			if (!kmem_cache_debug(s))
> +				spin_unlock_irqrestore(&n->list_lock, flags);
> +			to_take_off = 0;
>   		}
>   		prior = slab->freelist;
>   		counters = slab->counters;
> @@ -3369,8 +3375,6 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>   				new.frozen = 1;
>   
>   			} else { /* Needs to be taken off a list */
> -
> -				n = get_node(s, slab_nid(slab));
>   				/*
>   				 * Speculatively acquire the list_lock.
>   				 * If the cmpxchg does not succeed then we may
> @@ -3379,8 +3383,10 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>   				 * Otherwise the list_lock will synchronize with
>   				 * other processors updating the list of slabs.
>   				 */
> -				spin_lock_irqsave(&n->list_lock, flags);
> +				if (!kmem_cache_debug(s))
> +					spin_lock_irqsave(&n->list_lock, flags);
>   
> +				to_take_off = 1;
>   			}
>   		}
>   
> @@ -3389,8 +3395,9 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>   		head, new.counters,
>   		"__slab_free"));
>   
> -	if (likely(!n)) {
> -
> +	if (likely(!to_take_off)) {
> +		if (kmem_cache_debug(s))
> +			spin_unlock_irqrestore(&n->list_lock, flags);
>   		if (likely(was_frozen)) {
>   			/*
>   			 * The list lock was not taken therefore no list
