Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA8C4C9F47
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbiCBIc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiCBIcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:32:48 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20CB3916F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:32:04 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id bt13so1875563ybb.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 00:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oJjGiYGO2BQbY6e8zA+uuD343aWYzkhY2GO9yRgddAU=;
        b=HeXKLCbV+zEEElSIJaicHHBO6ietIy1g13cnBEXlj/GULI2mjzLmjMXwL3wih8miHY
         WMc3285miFFmAmBebl3yehdDHjqzfJcYtTzu8SYEF5nkrjBMKA//gax/CAarz4DL4d9l
         Ksp5+d0CKBKacJGu40l7EK6baEkjEVTypMaQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oJjGiYGO2BQbY6e8zA+uuD343aWYzkhY2GO9yRgddAU=;
        b=XorP8jGLtXieE9SDmBgVlrOtFzoB7PLX7+5hpYMJ5zch8GEUYW/ILQrew8y9n9eWav
         UUEUY7aGH+ALJ6FotxoimneZYbrdikfu4nE4xJ5q7WyquOIhZR86QmfUzTgQo4J99Ft7
         RTt4rafAb3VCA+SXiPYUmUqEvmxw9JQdo4zmitf3LgXS2puH5YCJurBk122sc+xh3Pce
         wVrnwZYocd9hJ7HdPgeCzDLw3JJO7sWLEkBM1wasfLY2eGsCLRiepueg0ijPqZ99VrnI
         IMi5TxHJffqOMsLrRt5r1zGW9mnjOK/UlhUe98U6a9iqKm7l4UgmSAsx0J1rYUV1CPet
         M7Fw==
X-Gm-Message-State: AOAM533zthGZ8GihRjns1FpOSc9PljLquGkQsu5fKl81Wg78+sBfjlzb
        5lsJa487UnM8EZqOGHnZqBQfzqWtg9CbIweqDMWFEw==
X-Google-Smtp-Source: ABdhPJwABkQl64VjPqgFU6ptaeQD3mtBCWNeQsqrtz1w5pOSgI9ATpW57DynzvRa2DqajF1JjzMf8Tjg/MHswdIkejE=
X-Received: by 2002:a25:1181:0:b0:624:6c32:e341 with SMTP id
 123-20020a251181000000b006246c32e341mr27631504ybr.437.1646209924139; Wed, 02
 Mar 2022 00:32:04 -0800 (PST)
MIME-Version: 1.0
References: <20220219092533.12596-1-linmiaohe@huawei.com> <20220219092533.12596-7-linmiaohe@huawei.com>
 <dba43259e1fe4e36a0bdbe97efaaca2f@AcuMS.aculab.com> <baeab92c-d966-2dc2-d952-c7f3faf2a229@huawei.com>
 <03647389a32045f38ec18b090548a26d@AcuMS.aculab.com>
In-Reply-To: <03647389a32045f38ec18b090548a26d@AcuMS.aculab.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Wed, 2 Mar 2022 09:31:53 +0100
Message-ID: <CAM4kBBLoaESLRr28kZ901e-nikDbnQnUu9h47OsA2phxp-pvuA@mail.gmail.com>
Subject: Re: [PATCH 6/9] mm/z3fold: move decrement of pool->pages_nr into __release_z3fold_page()
To:     David Laight <David.Laight@aculab.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 6:17 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Miaohe Lin <linmiaohe@huawei.com>
> > Sent: 21 February 2022 02:53
> >
> > On 2022/2/20 0:33, David Laight wrote:
> > > From: Miaohe Lin
> > >> Sent: 19 February 2022 09:26
> > >>
> > >> The z3fold will always do atomic64_dec(&pool->pages_nr) when the
> > >> __release_z3fold_page() is called. Thus we can move decrement of
> > >> pool->pages_nr into __release_z3fold_page() to simplify the code.
> > >> Also we can reduce the size of z3fold.o ~1k.
> > >> Without this patch:
> > >>    text       data     bss     dec     hex filename
> > >>   15444       1376       8   16828    41bc mm/z3fold.o
> > >> With this patch:
> > >>    text       data     bss     dec     hex filename
> > >>   15044       1248       8   16300    3fac mm/z3fold.o
> > >
> > > I can't see anything obvious in this patch that would reduce the size much.
> > > OTOH there are some large functions that are pointlessly marked 'inline'.
> > > Maybe the compiler made a better choice?
> >
> > I think so too.
> >
> > > Although it isn't al all obvious why the 'data' size changes.
> >
> > I checked the header of z3fold.o. The size of .data is unchanged while
> > align is changed from 00003818 to 00003688. Maybe this is the reason
> > .data size changes.
>
> You are misreading the double line header.
> If is Offset that is changing, Align in 8 (as expected).
>
> It will be another section that gets added to the 'data' size
> reported by 'size'.
>
> >
> > Section Headers:
> >   [Nr] Name              Type             Address           Offset
> >        Size              EntSize          Flags  Link  Info  Align
> >
> > with this patch:
> > [ 3] .data             PROGBITS         0000000000000000  00003688
> >        00000000000000c0  0000000000000000  WA       0     0     8
> >
> > without this patch:
> > [ 3] .data             PROGBITS         0000000000000000  00003818
> >        00000000000000c0  0000000000000000  WA       0     0     8
> >
> > >
> > >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > >> ---
> > >>  mm/z3fold.c | 41 ++++++++++++-----------------------------
> > >>  1 file changed, 12 insertions(+), 29 deletions(-)
> > >>
> > >> diff --git a/mm/z3fold.c b/mm/z3fold.c
> > >> index adc0b3fa4906..18a697f6fe32 100644
> > >> --- a/mm/z3fold.c
> > >> +++ b/mm/z3fold.c
> > >> @@ -520,6 +520,8 @@ static void __release_z3fold_page(struct z3fold_header *zhdr, bool locked)
> > >>    list_add(&zhdr->buddy, &pool->stale);
> > >>    queue_work(pool->release_wq, &pool->work);
> > >>    spin_unlock(&pool->stale_lock);
> > >> +
> > >> +  atomic64_dec(&pool->pages_nr);
> > >
> > > Looks like you can move the decrement inside the lock.
> > > If you can do the same for the increment you can avoid the
> > > expensive locked bus cycle.
> > >
> >
> > atomic64_inc(&pool->pages_nr); is only done when init a new or reused z3fold_page.
> > There is no lock around. If we hold pool->lock there, this potential gain might be
> > nullified. Or am I miss something ?
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

It's actually *stale_lock* and it's very misleading to use it for this.
I would actually like to keep atomics but I have no problem with
making it 32-bit for 32-bit systems. Would that work for you guys?

~Vitaly

> Actually does this even need to be 64bit, should it just be 'long'.
> That will mean that any 'read' just needs a simple single memory read.
>
> I've just looked at the code.
> Some of the one line wrapper functions don't make the code any
> easier to read.
> There is no point having inline wrappers to acquire locks if you
> only use them some of the time.
>
>         David
>
>
> >
> > Many thanks for your review and reply.
> >
> > >     David
> > >
> > >>  }
> > >>
> > >>  static void release_z3fold_page(struct kref *ref)
> > >> @@ -737,13 +739,9 @@ static struct z3fold_header *compact_single_buddy(struct z3fold_header *zhdr)
> > >>    return new_zhdr;
> > >>
> > >>  out_fail:
> > >> -  if (new_zhdr) {
> > >> -          if (kref_put(&new_zhdr->refcount, release_z3fold_page_locked))
> > >> -                  atomic64_dec(&pool->pages_nr);
> > >> -          else {
> > >> -                  add_to_unbuddied(pool, new_zhdr);
> > >> -                  z3fold_page_unlock(new_zhdr);
> > >> -          }
> > >> +  if (new_zhdr && !kref_put(&new_zhdr->refcount, release_z3fold_page_locked)) {
> > >> +          add_to_unbuddied(pool, new_zhdr);
> > >> +          z3fold_page_unlock(new_zhdr);
> > >>    }
> > >>    return NULL;
> > >>
> > >> @@ -816,10 +814,8 @@ static void do_compact_page(struct z3fold_header *zhdr, bool locked)
> > >>    list_del_init(&zhdr->buddy);
> > >>    spin_unlock(&pool->lock);
> > >>
> > >> -  if (kref_put(&zhdr->refcount, release_z3fold_page_locked)) {
> > >> -          atomic64_dec(&pool->pages_nr);
> > >> +  if (kref_put(&zhdr->refcount, release_z3fold_page_locked))
> > >>            return;
> > >> -  }
> > >>
> > >>    if (test_bit(PAGE_STALE, &page->private) ||
> > >>        test_and_set_bit(PAGE_CLAIMED, &page->private)) {
> > >> @@ -829,9 +825,7 @@ static void do_compact_page(struct z3fold_header *zhdr, bool locked)
> > >>
> > >>    if (!zhdr->foreign_handles && buddy_single(zhdr) &&
> > >>        zhdr->mapped_count == 0 && compact_single_buddy(zhdr)) {
> > >> -          if (kref_put(&zhdr->refcount, release_z3fold_page_locked))
> > >> -                  atomic64_dec(&pool->pages_nr);
> > >> -          else {
> > >> +          if (!kref_put(&zhdr->refcount, release_z3fold_page_locked)) {
> > >>                    clear_bit(PAGE_CLAIMED, &page->private);
> > >>                    z3fold_page_unlock(zhdr);
> > >>            }
> > >> @@ -1089,10 +1083,8 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
> > >>            if (zhdr) {
> > >>                    bud = get_free_buddy(zhdr, chunks);
> > >>                    if (bud == HEADLESS) {
> > >> -                          if (kref_put(&zhdr->refcount,
> > >> +                          if (!kref_put(&zhdr->refcount,
> > >>                                         release_z3fold_page_locked))
> > >> -                                  atomic64_dec(&pool->pages_nr);
> > >> -                          else
> > >>                                    z3fold_page_unlock(zhdr);
> > >>                            pr_err("No free chunks in unbuddied\n");
> > >>                            WARN_ON(1);
> > >> @@ -1239,10 +1231,8 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
> > >>
> > >>    if (!page_claimed)
> > >>            free_handle(handle, zhdr);
> > >> -  if (kref_put(&zhdr->refcount, release_z3fold_page_locked_list)) {
> > >> -          atomic64_dec(&pool->pages_nr);
> > >> +  if (kref_put(&zhdr->refcount, release_z3fold_page_locked_list))
> > >>            return;
> > >> -  }
> > >>    if (page_claimed) {
> > >>            /* the page has not been claimed by us */
> > >>            put_z3fold_header(zhdr);
> > >> @@ -1353,9 +1343,7 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int
> > retries)
> > >>                            break;
> > >>                    }
> > >>                    if (!z3fold_page_trylock(zhdr)) {
> > >> -                          if (kref_put(&zhdr->refcount,
> > >> -                                          release_z3fold_page))
> > >> -                                  atomic64_dec(&pool->pages_nr);
> > >> +                          kref_put(&zhdr->refcount, release_z3fold_page);
> > >>                            zhdr = NULL;
> > >>                            continue; /* can't evict at this point */
> > >>                    }
> > >> @@ -1366,10 +1354,8 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int
> > retries)
> > >>                     */
> > >>                    if (zhdr->foreign_handles ||
> > >>                        test_and_set_bit(PAGE_CLAIMED, &page->private)) {
> > >> -                          if (kref_put(&zhdr->refcount,
> > >> +                          if (!kref_put(&zhdr->refcount,
> > >>                                            release_z3fold_page_locked))
> > >> -                                  atomic64_dec(&pool->pages_nr);
> > >> -                          else
> > >>                                    z3fold_page_unlock(zhdr);
> > >>                            zhdr = NULL;
> > >>                            continue; /* can't evict such page */
> > >> @@ -1447,7 +1433,6 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int
> > retries)
> > >>                    if (kref_put(&zhdr->refcount,
> > >>                                    release_z3fold_page_locked)) {
> > >>                            kmem_cache_free(pool->c_handle, slots);
> > >> -                          atomic64_dec(&pool->pages_nr);
> > >>                            return 0;
> > >>                    }
> > >>                    /*
> > >> @@ -1669,10 +1654,8 @@ static void z3fold_page_putback(struct page *page)
> > >>    if (!list_empty(&zhdr->buddy))
> > >>            list_del_init(&zhdr->buddy);
> > >>    INIT_LIST_HEAD(&page->lru);
> > >> -  if (kref_put(&zhdr->refcount, release_z3fold_page_locked)) {
> > >> -          atomic64_dec(&pool->pages_nr);
> > >> +  if (kref_put(&zhdr->refcount, release_z3fold_page_locked))
> > >>            return;
> > >> -  }
> > >>    spin_lock(&pool->lock);
> > >>    list_add(&page->lru, &pool->lru);
> > >>    spin_unlock(&pool->lock);
> > >> --
> > >> 2.23.0
> > >
> > > -
> > > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> > > Registration No: 1397386 (Wales)
> > >
> > > .
> > >
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
