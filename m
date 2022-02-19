Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575284BC950
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 17:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242599AbiBSQeL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 19 Feb 2022 11:34:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiBSQeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 11:34:09 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48F6047AEB
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 08:33:48 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-115-134YVXIbNfWUuHtnEmsqEg-1; Sat, 19 Feb 2022 16:33:46 +0000
X-MC-Unique: 134YVXIbNfWUuHtnEmsqEg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Sat, 19 Feb 2022 16:33:45 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Sat, 19 Feb 2022 16:33:44 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Miaohe Lin' <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "vitaly.wool@konsulko.com" <vitaly.wool@konsulko.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 6/9] mm/z3fold: move decrement of pool->pages_nr into
 __release_z3fold_page()
Thread-Topic: [PATCH 6/9] mm/z3fold: move decrement of pool->pages_nr into
 __release_z3fold_page()
Thread-Index: AQHYJXLUWbfrUcWr0kay123DGS2luaybEHRg
Date:   Sat, 19 Feb 2022 16:33:44 +0000
Message-ID: <dba43259e1fe4e36a0bdbe97efaaca2f@AcuMS.aculab.com>
References: <20220219092533.12596-1-linmiaohe@huawei.com>
 <20220219092533.12596-7-linmiaohe@huawei.com>
In-Reply-To: <20220219092533.12596-7-linmiaohe@huawei.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin
> Sent: 19 February 2022 09:26
> 
> The z3fold will always do atomic64_dec(&pool->pages_nr) when the
> __release_z3fold_page() is called. Thus we can move decrement of
> pool->pages_nr into __release_z3fold_page() to simplify the code.
> Also we can reduce the size of z3fold.o ~1k.
> Without this patch:
>    text	   data	    bss	    dec	    hex	filename
>   15444	   1376	      8	  16828	   41bc	mm/z3fold.o
> With this patch:
>    text	   data	    bss	    dec	    hex	filename
>   15044	   1248	      8	  16300	   3fac	mm/z3fold.o

I can't see anything obvious in this patch that would reduce the size much.
OTOH there are some large functions that are pointlessly marked 'inline'.
Maybe the compiler made a better choice?
Although it isn't al all obvious why the 'data' size changes.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/z3fold.c | 41 ++++++++++++-----------------------------
>  1 file changed, 12 insertions(+), 29 deletions(-)
> 
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index adc0b3fa4906..18a697f6fe32 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -520,6 +520,8 @@ static void __release_z3fold_page(struct z3fold_header *zhdr, bool locked)
>  	list_add(&zhdr->buddy, &pool->stale);
>  	queue_work(pool->release_wq, &pool->work);
>  	spin_unlock(&pool->stale_lock);
> +
> +	atomic64_dec(&pool->pages_nr);

Looks like you can move the decrement inside the lock.
If you can do the same for the increment you can avoid the
expensive locked bus cycle.

	David

>  }
> 
>  static void release_z3fold_page(struct kref *ref)
> @@ -737,13 +739,9 @@ static struct z3fold_header *compact_single_buddy(struct z3fold_header *zhdr)
>  	return new_zhdr;
> 
>  out_fail:
> -	if (new_zhdr) {
> -		if (kref_put(&new_zhdr->refcount, release_z3fold_page_locked))
> -			atomic64_dec(&pool->pages_nr);
> -		else {
> -			add_to_unbuddied(pool, new_zhdr);
> -			z3fold_page_unlock(new_zhdr);
> -		}
> +	if (new_zhdr && !kref_put(&new_zhdr->refcount, release_z3fold_page_locked)) {
> +		add_to_unbuddied(pool, new_zhdr);
> +		z3fold_page_unlock(new_zhdr);
>  	}
>  	return NULL;
> 
> @@ -816,10 +814,8 @@ static void do_compact_page(struct z3fold_header *zhdr, bool locked)
>  	list_del_init(&zhdr->buddy);
>  	spin_unlock(&pool->lock);
> 
> -	if (kref_put(&zhdr->refcount, release_z3fold_page_locked)) {
> -		atomic64_dec(&pool->pages_nr);
> +	if (kref_put(&zhdr->refcount, release_z3fold_page_locked))
>  		return;
> -	}
> 
>  	if (test_bit(PAGE_STALE, &page->private) ||
>  	    test_and_set_bit(PAGE_CLAIMED, &page->private)) {
> @@ -829,9 +825,7 @@ static void do_compact_page(struct z3fold_header *zhdr, bool locked)
> 
>  	if (!zhdr->foreign_handles && buddy_single(zhdr) &&
>  	    zhdr->mapped_count == 0 && compact_single_buddy(zhdr)) {
> -		if (kref_put(&zhdr->refcount, release_z3fold_page_locked))
> -			atomic64_dec(&pool->pages_nr);
> -		else {
> +		if (!kref_put(&zhdr->refcount, release_z3fold_page_locked)) {
>  			clear_bit(PAGE_CLAIMED, &page->private);
>  			z3fold_page_unlock(zhdr);
>  		}
> @@ -1089,10 +1083,8 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
>  		if (zhdr) {
>  			bud = get_free_buddy(zhdr, chunks);
>  			if (bud == HEADLESS) {
> -				if (kref_put(&zhdr->refcount,
> +				if (!kref_put(&zhdr->refcount,
>  					     release_z3fold_page_locked))
> -					atomic64_dec(&pool->pages_nr);
> -				else
>  					z3fold_page_unlock(zhdr);
>  				pr_err("No free chunks in unbuddied\n");
>  				WARN_ON(1);
> @@ -1239,10 +1231,8 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
> 
>  	if (!page_claimed)
>  		free_handle(handle, zhdr);
> -	if (kref_put(&zhdr->refcount, release_z3fold_page_locked_list)) {
> -		atomic64_dec(&pool->pages_nr);
> +	if (kref_put(&zhdr->refcount, release_z3fold_page_locked_list))
>  		return;
> -	}
>  	if (page_claimed) {
>  		/* the page has not been claimed by us */
>  		put_z3fold_header(zhdr);
> @@ -1353,9 +1343,7 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
>  				break;
>  			}
>  			if (!z3fold_page_trylock(zhdr)) {
> -				if (kref_put(&zhdr->refcount,
> -						release_z3fold_page))
> -					atomic64_dec(&pool->pages_nr);
> +				kref_put(&zhdr->refcount, release_z3fold_page);
>  				zhdr = NULL;
>  				continue; /* can't evict at this point */
>  			}
> @@ -1366,10 +1354,8 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
>  			 */
>  			if (zhdr->foreign_handles ||
>  			    test_and_set_bit(PAGE_CLAIMED, &page->private)) {
> -				if (kref_put(&zhdr->refcount,
> +				if (!kref_put(&zhdr->refcount,
>  						release_z3fold_page_locked))
> -					atomic64_dec(&pool->pages_nr);
> -				else
>  					z3fold_page_unlock(zhdr);
>  				zhdr = NULL;
>  				continue; /* can't evict such page */
> @@ -1447,7 +1433,6 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
>  			if (kref_put(&zhdr->refcount,
>  					release_z3fold_page_locked)) {
>  				kmem_cache_free(pool->c_handle, slots);
> -				atomic64_dec(&pool->pages_nr);
>  				return 0;
>  			}
>  			/*
> @@ -1669,10 +1654,8 @@ static void z3fold_page_putback(struct page *page)
>  	if (!list_empty(&zhdr->buddy))
>  		list_del_init(&zhdr->buddy);
>  	INIT_LIST_HEAD(&page->lru);
> -	if (kref_put(&zhdr->refcount, release_z3fold_page_locked)) {
> -		atomic64_dec(&pool->pages_nr);
> +	if (kref_put(&zhdr->refcount, release_z3fold_page_locked))
>  		return;
> -	}
>  	spin_lock(&pool->lock);
>  	list_add(&page->lru, &pool->lru);
>  	spin_unlock(&pool->lock);
> --
> 2.23.0

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

