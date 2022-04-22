Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F21850B787
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447612AbiDVMnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbiDVMnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:43:50 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3C456C3C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:40:57 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id j8so10567124pll.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pzu5nPeYFuyp+BbiKouz255dg3ILpGYMNucTBkoz/wc=;
        b=YQ9ua00FpLvBDBR7qJzt/QKCcbJ72WK1ydLeZ6kJBHfYa64pBTSMfnAcjJ9EJ9/55A
         GnvPiz+7+mp/IjkiIB33owOEFJfdUEXNtda2bMY/mSASCoIgzgojTmZ7mWkLKK33bf5w
         ljo3p0xR2gfOuesWVCG2iNBk0ZOI8+Uf8rG/xyqTBdySeYNwFasZo+n6G65DUeBZsCcy
         ZC31wyFcEgJgwHi2N96lqEn5vIRTAb7crSw2Ui7BQxpNpkNv7NJ6js61V1Lou6/Jz9mP
         kEVth1R7dkw8aQkd6txBKwcjcUMdPK2GTaffnyxhmZY4lA+rxzSjG42LVXnnjwK7lGz5
         RXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pzu5nPeYFuyp+BbiKouz255dg3ILpGYMNucTBkoz/wc=;
        b=F2P7Euk2OvWdbmKuq9S6MHu39BOv2587edZYG9CvKTv3JRM0N5siJlKSz02KMftjIc
         gu7DoBiliK6VWcFK9xzHdz27AoAVMLmrLDkNfbrNYtwtjou9P7bMKl4r5rwWdG++V2P4
         eB8nQRNF9Mt/ao1Dq/sW2yAtf1J9YGNVvfgUzyWTXYP4U8DQlNf4SVnZVtomzHX33xTX
         7xzmO2sQ1A7I87FSGjFC0h4owKdMLH7MxI3BlU8bHoYU3Un/omX1DijpugI7N74ENozX
         ZcDl0Gju9xIBBbY7nYmaw+30R4uyJDC1Ex+ZjJwjuxSmScmNOrJVKtwHZSTnWceYGMrt
         Ir5Q==
X-Gm-Message-State: AOAM5337SHWRFd2J+6Adtls4yv0j+uW40E4A3J+FDGqbGAkZC0DQUrHW
        Rac4oyhNPrPNx5qZtpmjhV8=
X-Google-Smtp-Source: ABdhPJzrvFrzqYvQmsQRNhD4rGLoSgFvU2KggKFje+cVCXWjPyceKDPcncech0MkGzNdlllRQCaNfA==
X-Received: by 2002:a17:902:a417:b0:158:ed2c:3740 with SMTP id p23-20020a170902a41700b00158ed2c3740mr4323649plq.121.1650631256895;
        Fri, 22 Apr 2022 05:40:56 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id by8-20020a056a00400800b0050a96357226sm2394117pfb.40.2022.04.22.05.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 05:40:55 -0700 (PDT)
Date:   Fri, 22 Apr 2022 21:40:48 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 09/15] mm/slab: kmalloc: pass requests larger than
 order-1 page to page allocator
Message-ID: <YmKiUOVw9i1Uw1Gb@hyeyoo>
References: <20220308114142.1744229-1-42.hyeyoo@gmail.com>
 <20220308114142.1744229-10-42.hyeyoo@gmail.com>
 <9b808582-3a64-b626-14a4-55e7d9040261@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b808582-3a64-b626-14a4-55e7d9040261@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 07:08:27PM +0100, Vlastimil Babka wrote:
> On 3/8/22 12:41, Hyeonggon Yoo wrote:
> > There is not much benefit for serving large objects in kmalloc().
> > Let's pass large requests to page allocator like SLUB for better
> > maintenance of common code.
> > 
> > [ vbabka@suse.cz: Enable and disable irq around free_large_kmalloc().
> >   Do not lose NUMA locality in __do_kmalloc_node().
> >   Use folio_slab(folio)->slab_cache instead of virt_to_cache().
> >   Remove large sizes in __kmalloc_index(). ]

A bit late to reply but better late than never...

> 
> Thanks for the mention but that's generally only done like this if I took
> your patch and made those changes myself. But I just suggested them. Small
> suggested changes like this are usually just mentioned in e.g. v1->v2
> changelogs.

Ah, okay. I didn't know about the convention. thanks for letting me
know!

> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > ---
> >  include/linux/slab.h | 23 +++++-----------------
> >  mm/slab.c            | 45 ++++++++++++++++++++++++++++++--------------
> >  mm/slab.h            |  3 +++
> >  mm/slab_common.c     | 25 +++++++++++++++++-------
> >  mm/slub.c            | 19 -------------------
> >  5 files changed, 57 insertions(+), 58 deletions(-)
> > 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index dfcc8301d969..9ced225a3ea3 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -226,27 +226,17 @@ void kmem_dump_obj(void *object);
> >  
> >  #ifdef CONFIG_SLAB
> >  /*
> > - * The largest kmalloc size supported by the SLAB allocators is
> > - * 32 megabyte (2^25) or the maximum allocatable page order if that is
> > - * less than 32 MB.
> > - *
> > - * WARNING: Its not easy to increase this value since the allocators have
> > - * to do various tricks to work around compiler limitations in order to
> > - * ensure proper constant folding.
> > + * SLAB and SLUB directly allocates requests fitting in to an order-1 page
> > + * (PAGE_SIZE*2).  Larger requests are passed to the page allocator.
> >   */
> > -#define KMALLOC_SHIFT_HIGH	((MAX_ORDER + PAGE_SHIFT - 1) <= 25 ? \
> > -				(MAX_ORDER + PAGE_SHIFT - 1) : 25)
> > -#define KMALLOC_SHIFT_MAX	KMALLOC_SHIFT_HIGH
> > +#define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
> > +#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT - 1)
> >  #ifndef KMALLOC_SHIFT_LOW
> >  #define KMALLOC_SHIFT_LOW	5
> >  #endif
> >  #endif
> >  
> >  #ifdef CONFIG_SLUB
> > -/*
> > - * SLUB directly allocates requests fitting in to an order-1 page
> > - * (PAGE_SIZE*2).  Larger requests are passed to the page allocator.
> > - */
> >  #define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
> >  #define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT - 1)
> >  #ifndef KMALLOC_SHIFT_LOW
> > @@ -398,10 +388,6 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
> >  	if (size <= 512 * 1024) return 19;
> >  	if (size <= 1024 * 1024) return 20;
> >  	if (size <=  2 * 1024 * 1024) return 21;
> > -	if (size <=  4 * 1024 * 1024) return 22;
> > -	if (size <=  8 * 1024 * 1024) return 23;
> > -	if (size <=  16 * 1024 * 1024) return 24;
> > -	if (size <=  32 * 1024 * 1024) return 25;
> >  
> >  	if (!IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES) && size_is_constant)
> >  		BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
> > @@ -411,6 +397,7 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
> >  	/* Will never be reached. Needed because the compiler may complain */
> >  	return -1;
> >  }
> > +static_assert(PAGE_SHIFT <= 20);
> >  #define kmalloc_index(s) __kmalloc_index(s, true)
> >  #endif /* !CONFIG_SLOB */
> >  
> > diff --git a/mm/slab.c b/mm/slab.c
> > index 6ebf509bf2de..f0041f0125ba 100644
> > --- a/mm/slab.c
> > +++ b/mm/slab.c
> > @@ -3568,7 +3568,7 @@ __do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
> >  	void *ret;
> >  
> >  	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> > -		return NULL;
> > +		return kmalloc_large_node(size, flags, node);
> 
> Similar issue with caller not traced.
>

Actually I moved tracepoint into kmalloc_large_node(),
but the problem I think was I write patches hard to review.

in v2 I split some patches to be more reviewable. thanks!!

> >  	cachep = kmalloc_slab(size, flags);
> >  	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
> >  		return cachep;
> > @@ -3642,15 +3642,25 @@ void kmem_cache_free_bulk(struct kmem_cache *orig_s, size_t size, void **p)
> >  {
> >  	struct kmem_cache *s;
> >  	size_t i;
> > +	struct folio *folio;
> >  
> >  	local_irq_disable();
> >  	for (i = 0; i < size; i++) {
> >  		void *objp = p[i];
> >  
> > -		if (!orig_s) /* called via kfree_bulk */
> > -			s = virt_to_cache(objp);
> > -		else
> > +		if (!orig_s) {
> > +			folio = virt_to_folio(objp);
> > +			/* called via kfree_bulk */
> > +			if (!folio_test_slab(folio)) {
> > +				local_irq_enable();
> > +				free_large_kmalloc(folio, objp);
> > +				local_irq_disable();
> > +				continue;
> > +			}
> > +			s = folio_slab(folio)->slab_cache;
> > +		} else
> >  			s = cache_from_obj(orig_s, objp);
> > +
> >  		if (!s)
> >  			continue;
> >  
> > @@ -3679,20 +3689,25 @@ void kfree(const void *objp)
> >  {
> >  	struct kmem_cache *c;
> >  	unsigned long flags;
> > +	struct folio *folio;
> > +	void *x = (void *) objp;
> 
> I think you don't need to add 'x', just do the cast while calling
> free_large_kmalloc(), same as done for __cache_free().
>

in fact also SLUB's kfree defines x. But your suggestion sounds better.
Anyway did it in v2. thanks!

> >  
> >  	trace_kfree(_RET_IP_, objp);
> >  
> >  	if (unlikely(ZERO_OR_NULL_PTR(objp)))
> >  		return;
> > -	local_irq_save(flags);
> > -	kfree_debugcheck(objp);
> > -	c = virt_to_cache(objp);
> > -	if (!c) {
> > -		local_irq_restore(flags);
> > +
> > +	folio = virt_to_folio(objp);
> > +	if (!folio_test_slab(folio)) {
> > +		free_large_kmalloc(folio, x);
> >  		return;
> >  	}
> > -	debug_check_no_locks_freed(objp, c->object_size);
> >  
> > +	c = folio_slab(folio)->slab_cache;
> > +
> > +	local_irq_save(flags);
> > +	kfree_debugcheck(objp);
> > +	debug_check_no_locks_freed(objp, c->object_size);
> >  	debug_check_no_obj_freed(objp, c->object_size);
> >  	__cache_free(c, (void *)objp, _RET_IP_);
> >  	local_irq_restore(flags);

-- 
Thanks,
Hyeonggon
