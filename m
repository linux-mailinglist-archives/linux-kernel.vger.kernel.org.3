Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD3B4D0E80
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 04:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243164AbiCHD7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 22:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbiCHD7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 22:59:38 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E583E26D6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 19:58:42 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id z11so15918903pla.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 19:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iM+PV4fpxYW+ye1hFiFOovw7UPOtpG0DgMDRwiqD2pI=;
        b=n/TquMYDiCS5XjFnrqg2Rfynuci2nh/x9QjaQhiXqLLqPStY3bnxMEPjbLiw6cZoGp
         A9otGqZJeMd6QGFiV/WNAeCfNIDR7ISElcUT49MAqD/QjwZFCvK4eP8dXpJXCUbWbc9h
         uEteC7JvE5XvAdQRtp13A+i0HoYrpaB/J5UgctQgpbHN4rbjmiy7vjZ61ROpwvnJUoEk
         bq4138IxI9XWGpynxni7wJhx5OCIejex8YoIJAc5Q/3JPSiO6iWszBoEBkHDVhDlesgQ
         Kqsa1qmSA9bwHrzY3zoOjWR4Ue9q574rukZgL12erl1XBX3nhjvwfv9vUqYnonEcxHn6
         9xGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iM+PV4fpxYW+ye1hFiFOovw7UPOtpG0DgMDRwiqD2pI=;
        b=sfbJsgExoBwksfMxjdibxNBtH+deSW819uGdCgiJRtoRjB66RQL5fCQqp9nGnRt3z5
         uf0TzeznMexycr71hfdfvqGw2u+e6D77Crs4ZwidBbAY7GVB8Ynqv+lRi0ae2L2BaTQy
         uIhV0rKKiwA/OrZpRMFPC9U87ideGvqAkuv1YTt8Plw4u2WfExW3Mw4Qu9V9MnrL3F47
         bbNNtOUO2dugIjz+lnNe+pHesHChH6KDm93d/0D7LSr4EIRSRhRSRPIGVt7fNerllDP8
         F7wzVpcUUxruRUpvaTPr9vZLOeRelGH5Usv14zFSNrO6hFUa8+a1H/KJ5SCfKz71q05J
         oVbQ==
X-Gm-Message-State: AOAM5329BmRw90CjSmjSJI2iTQ9eIYtNtIBAOJchv8zSSqVpJwOdtj0a
        K2u5RulisNLn+wJb+yfROPA=
X-Google-Smtp-Source: ABdhPJzJPZcseuHrMrdVO5mr7+LcGX6jZWezgCPAs/E3Ubo62ruRz2MrzGgdUxgq7qTTe/ZD/Irr1g==
X-Received: by 2002:a17:902:7802:b0:150:baa:bc1a with SMTP id p2-20020a170902780200b001500baabc1amr15501161pll.110.1646711922412;
        Mon, 07 Mar 2022 19:58:42 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id x9-20020aa79409000000b004f704d33ca0sm4909272pfo.136.2022.03.07.19.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 19:58:41 -0800 (PST)
Date:   Tue, 8 Mar 2022 03:58:37 +0000
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
Subject: Re: [PATCH v3 2/2] mm/slub: refactor deactivate_slab()
Message-ID: <YibUbZeTSqMyE2rM@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220307074057.902222-1-42.hyeyoo@gmail.com>
 <20220307074057.902222-3-42.hyeyoo@gmail.com>
 <07d4f687-544f-17d4-51cd-7b86aa23fb21@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07d4f687-544f-17d4-51cd-7b86aa23fb21@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 05:40:42PM +0100, Vlastimil Babka wrote:
> On 3/7/22 08:40, Hyeonggon Yoo wrote:
> > Simplify deactivate_slab() by unlocking n->list_lock and retrying
> > cmpxchg_double() when cmpxchg_double() fails, and perform
> > add_{partial,full} only when it succeed.
> > 
> > Releasing and taking n->list_lock again here is not harmful as SLUB
> > avoids deactivating slabs as much as possible.
> > 
> > [ vbabka@suse.cz: perform add_{partial,full} when cmpxchg_double()
> >   succeed.
> > 
> >   count deactivating full slabs even if debugging flag is not set. ]
> > 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> adding both to slab-next. Fixed up some nits myself, see below:
> 
> >  
> > @@ -2420,61 +2416,50 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
> >  	new.frozen = 0;
> >  
> >  	if (!new.inuse && n->nr_partial >= s->min_partial)
> > -		m = M_FREE;
> > +		mode = M_FREE;
> >  	else if (new.freelist) {
> 
> This was against kernel style even before the patch - we use { } in the
> 'else if' branch, thus all branches should use { } even if one-line.
>

Ah, you are right. Agree with this change.
"Remove unnecessary brace" rule does not apply here.

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
> > -	}
> > -
> > -	if (l != m) {
> > -		if (l == M_PARTIAL)
> > -			remove_partial(n, slab);
> > -		else if (l == M_FULL)
> > -			remove_full(s, n, slab);
> > +		mode = M_PARTIAL;
> > +		/*
> > +		 * Taking the spinlock removes the possibility that
> > +		 * acquire_slab() will see a slab that is frozen
> > +		 */
> > +		spin_lock_irqsave(&n->list_lock, flags);
> > +	} else if (kmem_cache_debug_flags(s, SLAB_STORE_USER)) {
> > +		mode = M_FULL;
> > +		/*
> > +		 * This also ensures that the scanning of full
> > +		 * slabs from diagnostic functions will not see
> > +		 * any frozen slabs.
> > +		 */
> > +		spin_lock_irqsave(&n->list_lock, flags);
> > +	} else
> > +		mode = M_FULL_NOLIST;
> 
> Ditto here (this is new).

Yes.

> 
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
> > -		stat(s, DEACTIVATE_FULL);
> > -	else if (m == M_FREE) {
> > +	} else if (mode == M_FREE) {
> >  		stat(s, DEACTIVATE_EMPTY);
> >  		discard_slab(s, slab);
> >  		stat(s, FREE_SLAB);
> > -	}
> > +	} else if (mode == M_FULL) {
> > +		add_full(s, n, slab);
> > +		spin_unlock_irqrestore(&n->list_lock, flags);
> > +		stat(s, DEACTIVATE_FULL);
> > +	} else if (mode == M_FULL_NOLIST)
> > +		stat(s, DEACTIVATE_FULL);
> 
> And here.
>

Yes.

> >  }
> >  
> >  #ifdef CONFIG_SLUB_CPU_PARTIAL
> 

Thanks!

-- 
Thank you, You are awesome!
Hyeonggon :-)
