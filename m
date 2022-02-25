Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5084C4184
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbiBYJeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239129AbiBYJeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:34:46 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A351F7679
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 01:34:14 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id z4so4142522pgh.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 01:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tqMGqrqHK8AVpDD13+dSLGIZ+3NiwdwsQ9lsn9h58z0=;
        b=WLKO/Ry8t7EFyUrGi/IstJzQcWz3CC9AsoRiWb0w2NgXSoZgzFG+HLaMja33LbQd/S
         EDMfStIhP2JkNrNyjGz6idkVR2qvntZ+x5FteZcrdT7w0lomxrtlIEACoqsTzpkJUhJ/
         nyG002U4lsaVHvLGtFpg1+uGRKTA/o5BJOSz9bYUnlwvwYOb+iASrMbNHETpOxeTyVpN
         DGqZVLO6MphSnJLZPviSm59WT64D42mQJQ6G3DflNesxnNdh2OfG+cGGATOmiHFdZ7kz
         4+sZhmV76QJ/rW+Wir/JhIL95voOX4lFEPeyqycAWt6ChgH+rf2BSpvkA80JP8SkLz5d
         8qUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tqMGqrqHK8AVpDD13+dSLGIZ+3NiwdwsQ9lsn9h58z0=;
        b=PYPT5j4wdq+v6LXWxarTZDbGjrvRSVk82YYyV7l/Z1OEsPBhYOeg9ZtkKmbK686Ggq
         4uaHJ6ZE5qGEQLKrfN7nFIi54McvT9MO4gifTAVCm8n/UF+xJ4XZ2B67n5CFpWrGdJHZ
         SIIspGVZ0hvrxqnkERwFh3QcBjAQzytjprIV559QodGL/x8D0e7d3gXaKZJSo8+28UK9
         /D9Hg205oISBNLh6++kr62SHrH74X9n8hO6oRFjXl27wuRT5kprRUQm4pmyyiPz/l17R
         WjFON0kz9YAHSb9bjZL6gPSFlj4CzzDSw8NJGRx+nEQGS6iY/JodqnQK+wrOX+qXpdi7
         RYvA==
X-Gm-Message-State: AOAM5304s+qqCo1zmW0Se4UFOIlDi8f48DSDT7g740bw0V1D2bs5aLGB
        kpJBJFkRm8EFM+GTtzn7NeFlC4qAztfsGQ==
X-Google-Smtp-Source: ABdhPJyfs7KvmiXuploXDBjcyYGyefiqGG5bz5Zi6y5IpP3+tWsqqOdQjlpA7IX09YY1G1Z8KcT2Ow==
X-Received: by 2002:a63:a17:0:b0:364:9963:851f with SMTP id 23-20020a630a17000000b003649963851fmr5476023pgk.402.1645781653958;
        Fri, 25 Feb 2022 01:34:13 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id q9-20020a056a00088900b004e03b051040sm2510493pfj.112.2022.02.25.01.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 01:34:13 -0800 (PST)
Date:   Fri, 25 Feb 2022 09:34:09 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 5/5] mm/slub: Refactor deactivate_slab()
Message-ID: <YhiikbXALDX6fFyr@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220221105336.522086-1-42.hyeyoo@gmail.com>
 <20220221105336.522086-6-42.hyeyoo@gmail.com>
 <cd4144f5-e769-cf73-ca25-b36f2c4bbf35@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd4144f5-e769-cf73-ca25-b36f2c4bbf35@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 07:16:11PM +0100, Vlastimil Babka wrote:
> On 2/21/22 11:53, Hyeonggon Yoo wrote:
> > Simply deactivate_slab() by removing variable 'lock' and replacing
> > 'l' and 'm' with 'mode'. Instead, remove slab from list and unlock
> > n->list_lock when cmpxchg_double() fails, and then retry.
> > 
> > One slight functional change is releasing and taking n->list_lock again
> > when cmpxchg_double() fails. This is not harmful because SLUB avoids
> > deactivating slabs as much as possible.
> > 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> Hm I wonder if we could simplify even a bit more. Do we have to actually
> place the slab on a partial (full) list before the cmpxchg, only to remove
> it when cmpxchg fails? Seems it's to avoid anyone else seeing the slab
> un-frozen, but not on the list, which would be unexpected. However if anyone
> sees such slab, they have to take the list_lock first to start working with
> the slab... so this should be safe, because we hold the list_lock here, and
> will place the slab on the list before we release it. But it thus shouldn't
> matter if the placement happens before or after a successful cmpxchg, no? So
> we can only do it once after a successful cmpxchg and need no undo's?
>

My thought was similar. But after testing I noticed that &n->list_lock prevents
race between __slab_free() and deactivate_slab().

> Specifically AFAIK the only possible race should be with a __slab_free()
> which might observe !was_frozen after we succeed an unfreezing cmpxchg and
> go through the
> "} else { /* Needs to be taken off a list */"
> branch but then it takes the list_lock as the first thing, so will be able
> to proceed only after the slab is actually on the list.
> 
> Do I miss anything or would you agree?
>

It's so tricky.

I tried to simplify more as you said. Seeing frozen slab on list was not
problem. But the problem was that something might interfere between
cmpxchg_double() and taking spinlock.

This is what I faced:

	CPU A				CPU B
deactivate_slab() {			__slab_free() {
	/* slab is full */
	slab.frozen = 0;
	cmpxchg_double();
						/* Hmm... 
						slab->frozen == 0 &&
						slab->freelist != NULL?
						Oh This must be on the list.. */
						
						spin_lock_irqsave();
						cmpxchg_double();
						/* Corruption: slab
						 * was not yet inserted to
						 * list but try removing */
						remove_full();
						spin_unlock_irqrestore();
					}
	spin_lock_irqsave();
	add_full();
	spin_unlock_irqrestore();
}

I think it's quite confusing because it's protecting code, not data.

Would you have an idea to solve it, or should we add a comment for this?

> > ---
> >  mm/slub.c | 74 +++++++++++++++++++++++++------------------------------
> >  1 file changed, 33 insertions(+), 41 deletions(-)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index a4964deccb61..2d0663befb9e 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2350,8 +2350,8 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
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
> > @@ -2420,57 +2420,49 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
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
> > +		add_partial(n, slab, tail);
> > +	} else if (kmem_cache_debug_flags(s, SLAB_STORE_USER)) {
> > +		mode = M_FULL;
> > +		/*
> > +		 * This also ensures that the scanning of full
> > +		 * slabs from diagnostic functions will not see
> > +		 * any frozen slabs.
> > +		 */
> > +		spin_lock_irqsave(&n->list_lock, flags);
> > +		add_full(s, n, slab);
> >  	}
> >  
> > -	if (l != m) {
> > -		if (l == M_PARTIAL)
> > -			remove_partial(n, slab);
> > -		else if (l == M_FULL)
> > -			remove_full(s, n, slab);
> >  
> > -		if (m == M_PARTIAL)
> > -			add_partial(n, slab, tail);
> > -		else if (m == M_FULL)
> > -			add_full(s, n, slab);
> > -	}
> > -
> > -	l = m;
> >  	if (!cmpxchg_double_slab(s, slab,
> >  				old.freelist, old.counters,
> >  				new.freelist, new.counters,
> > -				"unfreezing slab"))
> > +				"unfreezing slab")) {
> > +		if (mode == M_PARTIAL) {
> > +			remove_partial(n, slab);
> > +			spin_unlock_irqrestore(&n->list_lock, flags);
> > +		} else if (mode == M_FULL) {
> > +			remove_full(s, n, slab);
> > +			spin_unlock_irqrestore(&n->list_lock, flags);
> > +		}
> >  		goto redo;
> > +	}
> >  
> > -	if (lock)
> > -		spin_unlock_irqrestore(&n->list_lock, flags);
> >  
> > -	if (m == M_PARTIAL)
> > +	if (mode == M_PARTIAL) {
> > +		spin_unlock_irqrestore(&n->list_lock, flags);
> >  		stat(s, tail);
> > -	else if (m == M_FULL)
> > +	} else if (mode == M_FULL) {
> > +		spin_unlock_irqrestore(&n->list_lock, flags);
> >  		stat(s, DEACTIVATE_FULL);
> > -	else if (m == M_FREE) {
> > +	} else if (mode == M_FREE) {
> >  		stat(s, DEACTIVATE_EMPTY);
> >  		discard_slab(s, slab);
> >  		stat(s, FREE_SLAB);
> 

-- 
Thank you, You are awesome!
Hyeonggon :-)
