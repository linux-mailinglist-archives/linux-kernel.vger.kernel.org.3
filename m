Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23B14CE296
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 05:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiCEEWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 23:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiCEEWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 23:22:34 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B4B51333
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 20:21:45 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m22so8945837pja.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 20:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+WecTfOPB5EXS9NO8w7OJhZo+wpvPjeoC9Ba/0fEu0s=;
        b=V8R9hNSnyF2Wgb3QNGFSuVg0OqcmkPUclEYv4iRrpN/LDJjFvWry+/pfFYEAj2TaJm
         nnTnDiBI6eVBVhRlPMW7vawy7I/SEfbLAtyboRSrOIXkUb3pPx3o06AhJuCbhC4s7LGB
         MwhRmzeFMxdFqKSrVAxp11RMkjlhqxtLxne91Ldriqjg1AijsXb0qOaA5IkKU41sI9Yq
         vylMOaMI3e8/Yiaz6Qj1EfDRRZlV7iLG4Ehat0+xSnJ+kCoxMepfPRwZQwakJbltfaju
         TcgJqz6MN/5tzrtGzpLdqNEu6EgAOInuIpwhoVn7/EhqyFdoel6zho4b+Maty0N9T732
         UQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+WecTfOPB5EXS9NO8w7OJhZo+wpvPjeoC9Ba/0fEu0s=;
        b=oqAdQcNc4Wb8KM53adZyMhh0rGBQ79TpNoQgUJfkCEZZbouCuZYIV5f1cU18kdTVns
         4gawFyRk2Au1V4cmmloTatSj41FE45DIBWOKCRBa1mJXBNn0i8+JiCsihY9HxNDTiluL
         gcCDOb7fK0T6jbBON1yrlUkUPxbo4hasPb50nxcBD1l2V47ZCwnb4YH634DbnNbzVLpv
         kZffqN1QyJ+Id5fALm/tN5ltp3FhuEZTdpujuFaLt17xLNfqOsqZtSvLGQFj/9kSnX1p
         BXJ3nnC6Rw0Qo8KOZQxh0pI+mxIhM5PF9nup8gZ3YftZNIzWoD18gSyGpN/zzM9YvxGE
         D8ZQ==
X-Gm-Message-State: AOAM530tHV7kkXMWdyz0yovvAZP4kuoJf81u8rbnLi21NbWZwNCql4SS
        tJHipTm6ezFqfFXXacIq3+0=
X-Google-Smtp-Source: ABdhPJy0PemOG682V8NIgEbnJiFKcBnPK7RUoXhG3leKLVwaTC3SRCuJ+pZWu6KWHvJrbQ1iVc1sgA==
X-Received: by 2002:a17:90a:cf87:b0:1bd:3595:3ee4 with SMTP id i7-20020a17090acf8700b001bd35953ee4mr14182043pju.100.1646454105409;
        Fri, 04 Mar 2022 20:21:45 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id j7-20020a056a00130700b004b9f7cd94a4sm7260689pfu.56.2022.03.04.20.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 20:21:44 -0800 (PST)
Date:   Sat, 5 Mar 2022 04:21:39 +0000
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
Subject: Re: [PATCH v2 5/5] mm/slub: refactor deactivate_slab()
Message-ID: <YiLlUx0Re/A6lzfI@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220304063427.372145-1-42.hyeyoo@gmail.com>
 <20220304063427.372145-6-42.hyeyoo@gmail.com>
 <6763e97b-88bf-59b0-c80e-26c3846531fc@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6763e97b-88bf-59b0-c80e-26c3846531fc@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 08:01:20PM +0100, Vlastimil Babka wrote:
> On 3/4/22 07:34, Hyeonggon Yoo wrote:
> > Simplify deactivate_slab() by unlocking n->list_lock and retrying
> > cmpxchg_double() when cmpxchg_double() fails, and perform
> > add_{partial,full} only when it succeed.
> > 
> > Releasing and taking n->list_lock again here is not harmful as SLUB
> > avoids deactivating slabs as much as possible.
> > 
> > [ vbabka@suse.cz: perform add_{partial,full} when cmpxchg_double()
> >   succeed. ]
> > 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> Looks good, just noticed a tiny issue.
> 
> > ---
> >  mm/slub.c | 81 ++++++++++++++++++++++---------------------------------
> >  1 file changed, 32 insertions(+), 49 deletions(-)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index f9ae983a3dc6..c1a693ec5874 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2344,8 +2344,8 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
> >  {
> >  	enum slab_modes { M_NONE, M_PARTIAL, M_FULL, M_FREE };
> >  	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
> > -	int lock = 0, free_delta = 0;
> > -	enum slab_modes l = M_NONE, m = M_NONE;
> > +	int free_delta = 0;
> > +	enum slab_modes mode = M_NONE;
> >  	void *nextfree, *freelist_iter, *freelist_tail;
> >  	int tail = DEACTIVATE_TO_HEAD;
> >  	unsigned long flags = 0;
> > @@ -2387,14 +2387,10 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
> >  	 * Ensure that the slab is unfrozen while the list presence
> >  	 * reflects the actual number of objects during unfreeze.
> >  	 *
> > -	 * We setup the list membership and then perform a cmpxchg
> > -	 * with the count. If there is a mismatch then the slab
> > -	 * is not unfrozen but the slab is on the wrong list.
> > -	 *
> > -	 * Then we restart the process which may have to remove
> > -	 * the slab from the list that we just put it on again
> > -	 * because the number of objects in the slab may have
> > -	 * changed.
> > +	 * We first perform cmpxchg holding lock and insert to list
> > +	 * when it succeed. If there is mismatch then slub is not
> > +	 * unfrozen and number of objects in the slab may have changed.
> > +	 * Then release lock and retry cmpxchg again.
> >  	 */
> >  redo:
> >  
> > @@ -2414,57 +2410,44 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
> >  	new.frozen = 0;
> >  
> >  	if (!new.inuse && n->nr_partial >= s->min_partial)
> > -		m = M_FREE;
> > +		mode = M_FREE;
> >  	else if (new.freelist) {
> > -		m = M_PARTIAL;
> > -		if (!lock) {
> > -			lock = 1;
> > -			/*
> > -			 * Taking the spinlock removes the possibility that
> > -			 * acquire_slab() will see a slab that is frozen
> > -			 */
> > -			spin_lock_irqsave(&n->list_lock, flags);
> > -		}
> > -	} else {
> > -		m = M_FULL;
> > -		if (kmem_cache_debug_flags(s, SLAB_STORE_USER) && !lock) {
> 
> This used to set m = M_FULL; always.
> 
> > -			lock = 1;
> > -			/*
> > -			 * This also ensures that the scanning of full
> > -			 * slabs from diagnostic functions will not see
> > -			 * any frozen slabs.
> > -			 */
> > -			spin_lock_irqsave(&n->list_lock, flags);
> > -		}
> > +		mode = M_PARTIAL;
> > +		/*
> > +		 * Taking the spinlock removes the possibility that
> > +		 * acquire_slab() will see a slab that is frozen
> > +		 */
> > +		spin_lock_irqsave(&n->list_lock, flags);
> > +	} else if (kmem_cache_debug_flags(s, SLAB_STORE_USER)) {
> > +		mode = M_FULL;
> 
> Now you only set it for SLAB_STORE_USER caches.
> 
> > +		/*
> > +		 * This also ensures that the scanning of full
> > +		 * slabs from diagnostic functions will not see
> > +		 * any frozen slabs.
> > +		 */
> > +		spin_lock_irqsave(&n->list_lock, flags);
> >  	}
> >  
> > -	if (l != m) {
> > -		if (l == M_PARTIAL)
> > -			remove_partial(n, slab);
> > -		else if (l == M_FULL)
> > -			remove_full(s, n, slab);
> > -
> > -		if (m == M_PARTIAL)
> > -			add_partial(n, slab, tail);
> > -		else if (m == M_FULL)
> > -			add_full(s, n, slab);
> > -	}
> >  
> > -	l = m;
> >  	if (!cmpxchg_double_slab(s, slab,
> >  				old.freelist, old.counters,
> >  				new.freelist, new.counters,
> > -				"unfreezing slab"))
> > +				"unfreezing slab")) {
> > +		if (mode == M_PARTIAL || mode == M_FULL)
> > +			spin_unlock_irqrestore(&n->list_lock, flags);
> >  		goto redo;
> > +	}
> >  
> > -	if (lock)
> > -		spin_unlock_irqrestore(&n->list_lock, flags);
> >  
> > -	if (m == M_PARTIAL)
> > +	if (mode == M_PARTIAL) {
> > +		add_partial(n, slab, tail);
> > +		spin_unlock_irqrestore(&n->list_lock, flags);
> >  		stat(s, tail);
> > -	else if (m == M_FULL)
> > +	} else if (mode == M_FULL) {
> > +		add_full(s, n, slab);
> > +		spin_unlock_irqrestore(&n->list_lock, flags);
> >  		stat(s, DEACTIVATE_FULL);
> 
> As a result, full slabs without SLAB_STORE_USER will not count
> DEACTIVATE_FULL anymore.

Oh, thank you for catching this.

We usually only deactivate full slabs for debugging to track all list of slabs.

But as you pointed, in rare case when pfmemalloc flag does not match, full slabs
can be deactivated (even if they are not put on list).

> I guess the easiest way to solve it is to e.g. add a M_FULL_NOLIST mode that
> only does the DEACTIVATE_FULL counting.

That will be enough solution.

Will fix this in v3. Thank you!

> > -	else if (m == M_FREE) {
> > +	} else if (mode == M_FREE) {
> >  		stat(s, DEACTIVATE_EMPTY);
> >  		discard_slab(s, slab);
> >  		stat(s, FREE_SLAB);
> 

-- 
Thank you, You are awesome!
Hyeonggon :-)
