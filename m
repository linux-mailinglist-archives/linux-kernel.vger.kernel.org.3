Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD3C4BE990
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356520AbiBULiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:38:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiBULiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:38:18 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D7E1AD98
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 03:37:52 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K2KtV4HH1zbbdV;
        Mon, 21 Feb 2022 19:33:22 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 19:37:50 +0800
Subject: Re: [PATCH 6/9] mm/z3fold: move decrement of pool->pages_nr into
 __release_z3fold_page()
To:     David Laight <David.Laight@ACULAB.COM>
CC:     "vitaly.wool@konsulko.com" <vitaly.wool@konsulko.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20220219092533.12596-1-linmiaohe@huawei.com>
 <20220219092533.12596-7-linmiaohe@huawei.com>
 <dba43259e1fe4e36a0bdbe97efaaca2f@AcuMS.aculab.com>
 <baeab92c-d966-2dc2-d952-c7f3faf2a229@huawei.com>
 <03647389a32045f38ec18b090548a26d@AcuMS.aculab.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <45b4d937-af08-536e-1a54-6fa367fc4753@huawei.com>
Date:   Mon, 21 Feb 2022 19:37:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <03647389a32045f38ec18b090548a26d@AcuMS.aculab.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/21 13:17, David Laight wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
>> Sent: 21 February 2022 02:53
>>
>> On 2022/2/20 0:33, David Laight wrote:
>>> From: Miaohe Lin
>>>> Sent: 19 February 2022 09:26
>>>>
>>>> The z3fold will always do atomic64_dec(&pool->pages_nr) when the
>>>> __release_z3fold_page() is called. Thus we can move decrement of
>>>> pool->pages_nr into __release_z3fold_page() to simplify the code.
>>>> Also we can reduce the size of z3fold.o ~1k.
>>>> Without this patch:
>>>>    text	   data	    bss	    dec	    hex	filename
>>>>   15444	   1376	      8	  16828	   41bc	mm/z3fold.o
>>>> With this patch:
>>>>    text	   data	    bss	    dec	    hex	filename
>>>>   15044	   1248	      8	  16300	   3fac	mm/z3fold.o
>>>
>>> I can't see anything obvious in this patch that would reduce the size much.
>>> OTOH there are some large functions that are pointlessly marked 'inline'.
>>> Maybe the compiler made a better choice?
>>
>> I think so too.
>>
>>> Although it isn't al all obvious why the 'data' size changes.
>>
>> I checked the header of z3fold.o. The size of .data is unchanged while
>> align is changed from 00003818 to 00003688. Maybe this is the reason
>> .data size changes.
> 
> You are misreading the double line header.
> If is Offset that is changing, Align in 8 (as expected).
> 

So embarrassing... I should have taken a coffee first. :(

> It will be another section that gets added to the 'data' size
> reported by 'size'.

I think you're right. It seems __jump_table changed from 3e0 -> 360 (0x80)
which is the same value for data size (from 1376 -> 1248). __jump_table section
might gets added to the .data section.

with this patch:
[11] __jump_table      PROGBITS         0000000000000000  00003870
     0000000000000360  0000000000000000  WA       0     0     8

without this patch:
[11] __jump_table      PROGBITS         0000000000000000  00003a00
     00000000000003e0  0000000000000000  WA       0     0     8
> 
>>
>> Section Headers:
>>   [Nr] Name              Type             Address           Offset
>>        Size              EntSize          Flags  Link  Info  Align
>>
>> with this patch:
>> [ 3] .data             PROGBITS         0000000000000000  00003688
>>        00000000000000c0  0000000000000000  WA       0     0     8
>>
>> without this patch:
>> [ 3] .data             PROGBITS         0000000000000000  00003818
>>        00000000000000c0  0000000000000000  WA       0     0     8
>>
>>>
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>> ---
>>>>  mm/z3fold.c | 41 ++++++++++++-----------------------------
>>>>  1 file changed, 12 insertions(+), 29 deletions(-)
>>>>
>>>> diff --git a/mm/z3fold.c b/mm/z3fold.c
>>>> index adc0b3fa4906..18a697f6fe32 100644
>>>> --- a/mm/z3fold.c
>>>> +++ b/mm/z3fold.c
>>>> @@ -520,6 +520,8 @@ static void __release_z3fold_page(struct z3fold_header *zhdr, bool locked)
>>>>  	list_add(&zhdr->buddy, &pool->stale);
>>>>  	queue_work(pool->release_wq, &pool->work);
>>>>  	spin_unlock(&pool->stale_lock);
>>>> +
>>>> +	atomic64_dec(&pool->pages_nr);
>>>
>>> Looks like you can move the decrement inside the lock.
>>> If you can do the same for the increment you can avoid the
>>> expensive locked bus cycle.
>>>
>>
>> atomic64_inc(&pool->pages_nr); is only done when init a new or reused z3fold_page.
>> There is no lock around. If we hold pool->lock there, this potential gain might be
>> nullified. Or am I miss something ?
> 
> Atomic operations aren't magic.
> Atomic operations are (at best) one slow locked bus cycle.
> Acquiring a lock is the same.
> Releasing a lock might be cheaper, but is probably a locked bus cycle.
> 
> So if you use state_lock to protect pages_nr then you lose an atomic
> operation for the decrement and gain one (for the unlock) in the increment.
> That is even or maybe a slight gain.
> OTOH a 64bit atomic is a PITA on some 32bit systems.
> (In fact any atomic is a PITA on sparc32.)

Do you mean something like below ?

diff --git a/mm/z3fold.c b/mm/z3fold.c
index db41b4227ec7..f30bff5e0092 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -161,7 +161,7 @@ struct z3fold_pool {
        struct list_head *unbuddied;
        struct list_head lru;
        struct list_head stale;
-       atomic64_t pages_nr;
+       long pages_nr;
        struct kmem_cache *c_handle;
        const struct z3fold_ops *ops;
        struct zpool *zpool;
@@ -516,9 +516,8 @@ static void __release_z3fold_page(struct z3fold_header *zhdr, bool locked)
        spin_lock(&pool->stale_lock);
        list_add(&zhdr->buddy, &pool->stale);
        queue_work(pool->release_wq, &pool->work);
+       pool->pages_nr--;
        spin_unlock(&pool->stale_lock);
-
-       atomic64_dec(&pool->pages_nr);
 }

 static void release_z3fold_page(struct kref *ref)
@@ -983,7 +982,7 @@ static struct z3fold_pool *z3fold_create_pool(const char *name, gfp_t gfp,
        }
        INIT_LIST_HEAD(&pool->lru);
        INIT_LIST_HEAD(&pool->stale);
-       atomic64_set(&pool->pages_nr, 0);
+       pool->pages_nr = 0;
        pool->name = name;
        pool->compact_wq = create_singlethread_workqueue(pool->name);
        if (!pool->compact_wq)
@@ -1119,7 +1118,9 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
                __free_page(page);
                return -ENOMEM;
        }
-       atomic64_inc(&pool->pages_nr);
+       spin_lock(&pool->stale_lock);
+       pool->pages_nr++;
+       spin_unlock(&pool->stale_lock);

        if (bud == HEADLESS) {
                set_bit(PAGE_HEADLESS, &page->private);
@@ -1197,7 +1198,7 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
                        spin_unlock(&pool->lock);
                        put_z3fold_header(zhdr);
                        free_z3fold_page(page, true);
-                       atomic64_dec(&pool->pages_nr);
+                       pool->pages_nr--;
                }
                return;
        }
@@ -1410,7 +1411,7 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
                if (test_bit(PAGE_HEADLESS, &page->private)) {
                        if (ret == 0) {
                                free_z3fold_page(page, true);
-                               atomic64_dec(&pool->pages_nr);
+                               pool->pages_nr--;
                                return 0;
                        }
                        spin_lock(&pool->lock);
@@ -1526,7 +1527,7 @@ static void z3fold_unmap(struct z3fold_pool *pool, unsigned long handle)
  */
 static u64 z3fold_get_pool_size(struct z3fold_pool *pool)
 {
-       return atomic64_read(&pool->pages_nr);
+       return pool->pages_nr;
 }

 static bool z3fold_page_isolate(struct page *page, isolate_mode_t mode)


Are we expected to hold page->stale lock when we fetch pages_nr in the z3fold_get_pool_size?
Anyway, I think this could be another separate patch. What do you think ?

> 
> Actually does this even need to be 64bit, should it just be 'long'.
> That will mean that any 'read' just needs a simple single memory read.

'long' should be enough. I think there can't be that many z3fold pages.

> 
> I've just looked at the code.
> Some of the one line wrapper functions don't make the code any
> easier to read.
> There is no point having inline wrappers to acquire locks if you
> only use them some of the time.
> 
> 	David

Many thanks for your comment.

> 
> 
>>
>> Many thanks for your review and reply.
>>
>>> 	David
>>>
>>>>  }
>>>>
>>>>  static void release_z3fold_page(struct kref *ref)
>>>> @@ -737,13 +739,9 @@ static struct z3fold_header *compact_single_buddy(struct z3fold_header *zhdr)
>>>>  	return new_zhdr;
>>>>
>>>>  out_fail:
>>>> -	if (new_zhdr) {
>>>> -		if (kref_put(&new_zhdr->refcount, release_z3fold_page_locked))
>>>> -			atomic64_dec(&pool->pages_nr);
>>>> -		else {
>>>> -			add_to_unbuddied(pool, new_zhdr);
>>>> -			z3fold_page_unlock(new_zhdr);
>>>> -		}
>>>> +	if (new_zhdr && !kref_put(&new_zhdr->refcount, release_z3fold_page_locked)) {
>>>> +		add_to_unbuddied(pool, new_zhdr);
>>>> +		z3fold_page_unlock(new_zhdr);
>>>>  	}
>>>>  	return NULL;
>>>>
>>>> @@ -816,10 +814,8 @@ static void do_compact_page(struct z3fold_header *zhdr, bool locked)
>>>>  	list_del_init(&zhdr->buddy);
>>>>  	spin_unlock(&pool->lock);
>>>>
>>>> -	if (kref_put(&zhdr->refcount, release_z3fold_page_locked)) {
>>>> -		atomic64_dec(&pool->pages_nr);
>>>> +	if (kref_put(&zhdr->refcount, release_z3fold_page_locked))
>>>>  		return;
>>>> -	}
>>>>
>>>>  	if (test_bit(PAGE_STALE, &page->private) ||
>>>>  	    test_and_set_bit(PAGE_CLAIMED, &page->private)) {
>>>> @@ -829,9 +825,7 @@ static void do_compact_page(struct z3fold_header *zhdr, bool locked)
>>>>
>>>>  	if (!zhdr->foreign_handles && buddy_single(zhdr) &&
>>>>  	    zhdr->mapped_count == 0 && compact_single_buddy(zhdr)) {
>>>> -		if (kref_put(&zhdr->refcount, release_z3fold_page_locked))
>>>> -			atomic64_dec(&pool->pages_nr);
>>>> -		else {
>>>> +		if (!kref_put(&zhdr->refcount, release_z3fold_page_locked)) {
>>>>  			clear_bit(PAGE_CLAIMED, &page->private);
>>>>  			z3fold_page_unlock(zhdr);
>>>>  		}
>>>> @@ -1089,10 +1083,8 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
>>>>  		if (zhdr) {
>>>>  			bud = get_free_buddy(zhdr, chunks);
>>>>  			if (bud == HEADLESS) {
>>>> -				if (kref_put(&zhdr->refcount,
>>>> +				if (!kref_put(&zhdr->refcount,
>>>>  					     release_z3fold_page_locked))
>>>> -					atomic64_dec(&pool->pages_nr);
>>>> -				else
>>>>  					z3fold_page_unlock(zhdr);
>>>>  				pr_err("No free chunks in unbuddied\n");
>>>>  				WARN_ON(1);
>>>> @@ -1239,10 +1231,8 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
>>>>
>>>>  	if (!page_claimed)
>>>>  		free_handle(handle, zhdr);
>>>> -	if (kref_put(&zhdr->refcount, release_z3fold_page_locked_list)) {
>>>> -		atomic64_dec(&pool->pages_nr);
>>>> +	if (kref_put(&zhdr->refcount, release_z3fold_page_locked_list))
>>>>  		return;
>>>> -	}
>>>>  	if (page_claimed) {
>>>>  		/* the page has not been claimed by us */
>>>>  		put_z3fold_header(zhdr);
>>>> @@ -1353,9 +1343,7 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int
>> retries)
>>>>  				break;
>>>>  			}
>>>>  			if (!z3fold_page_trylock(zhdr)) {
>>>> -				if (kref_put(&zhdr->refcount,
>>>> -						release_z3fold_page))
>>>> -					atomic64_dec(&pool->pages_nr);
>>>> +				kref_put(&zhdr->refcount, release_z3fold_page);
>>>>  				zhdr = NULL;
>>>>  				continue; /* can't evict at this point */
>>>>  			}
>>>> @@ -1366,10 +1354,8 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int
>> retries)
>>>>  			 */
>>>>  			if (zhdr->foreign_handles ||
>>>>  			    test_and_set_bit(PAGE_CLAIMED, &page->private)) {
>>>> -				if (kref_put(&zhdr->refcount,
>>>> +				if (!kref_put(&zhdr->refcount,
>>>>  						release_z3fold_page_locked))
>>>> -					atomic64_dec(&pool->pages_nr);
>>>> -				else
>>>>  					z3fold_page_unlock(zhdr);
>>>>  				zhdr = NULL;
>>>>  				continue; /* can't evict such page */
>>>> @@ -1447,7 +1433,6 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int
>> retries)
>>>>  			if (kref_put(&zhdr->refcount,
>>>>  					release_z3fold_page_locked)) {
>>>>  				kmem_cache_free(pool->c_handle, slots);
>>>> -				atomic64_dec(&pool->pages_nr);
>>>>  				return 0;
>>>>  			}
>>>>  			/*
>>>> @@ -1669,10 +1654,8 @@ static void z3fold_page_putback(struct page *page)
>>>>  	if (!list_empty(&zhdr->buddy))
>>>>  		list_del_init(&zhdr->buddy);
>>>>  	INIT_LIST_HEAD(&page->lru);
>>>> -	if (kref_put(&zhdr->refcount, release_z3fold_page_locked)) {
>>>> -		atomic64_dec(&pool->pages_nr);
>>>> +	if (kref_put(&zhdr->refcount, release_z3fold_page_locked))
>>>>  		return;
>>>> -	}
>>>>  	spin_lock(&pool->lock);
>>>>  	list_add(&page->lru, &pool->lru);
>>>>  	spin_unlock(&pool->lock);
>>>> --
>>>> 2.23.0
>>>
>>> -
>>> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
>>> Registration No: 1397386 (Wales)
>>>
>>> .
>>>
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

