Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B2A4E616C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349359AbiCXKBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 06:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiCXKBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:01:22 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6CD5BE70
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:59:51 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n18so4191708plg.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nfj33Z1hktxCveFcrncNdeDrZFsHaZSKxlrG2enCzhs=;
        b=fQJlJL6WKmTT59FYIIPj5Vv4XET4DURA1AsmtUAdpJ+bPjJcIKiePcS3JV3l3pIwyX
         Qp9Ic25l9h449RHfrzvqV6zDtZnA1gtIz9wsZ0lVroSSz5h9jP73E5U4LPwgAOAR+WQz
         TASx+JrUUDcLIkQQYo3ZsDUZC3qfn0xYBoGwyelyf6z877AROqq/71mMTH1vvV1bBnAf
         IjKMRmCfwR2jlyS5VOuvwLZdc3tj9Y+EPaL+acbWtXv+0SZAzmH6tCBwIDapTdERv4QR
         akbHEry33JYmhb2c8L7sWMgLirEK2UqwcnTLqzePlWg6ptCw1LhrBRLJ9qtiTWs1HZuQ
         0MOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nfj33Z1hktxCveFcrncNdeDrZFsHaZSKxlrG2enCzhs=;
        b=LTVQ1MHJ/342AqP0CXUGiVXmsCFXDlYxEqN04W+CV3ctiHaHyB4dJX5BTTb23IAAKt
         D1iODiq8+BQY4IZCqXSdyaw2/Vvbexi6vyy8uYUNIPFb8Xt+BoOPkTNYc5gKIgITBbaO
         IxZLtepHmC9iABKTwhM1xBB4ARYb7H3S1Jmruvcb2hdg+NZsUdlOvCxDUWjm///7NWS+
         fMq+m2xaMpMr6vvGoHo7JooJ8TEFtAuiNH6487xB7IuJGfpSRUHlkLngqKH4rbzJg6GF
         Ng+XPCsP1HZukoy1TgWm6Xz+CU941SBCyO1IdPxuj/nr0rhp07xLiGwqrFfA3hMnz+Jy
         iKpg==
X-Gm-Message-State: AOAM532b9j92Q74t962q9q5R/VGNFDPRvVuRQsgNnkQQyVglM7ejpUGK
        Rb3h+w0cHww96YMFBrD+iCGMiqW6R9Q=
X-Google-Smtp-Source: ABdhPJzBPKz5IAtGBay48ozd9g2P9e0MAM3KBnkFbXW0riCLGFTj3lIZpW5HqidyW7ONiHvSzjOd8g==
X-Received: by 2002:a17:90a:e50c:b0:1c7:c5e2:36e3 with SMTP id t12-20020a17090ae50c00b001c7c5e236e3mr1322634pjy.245.1648115991128;
        Thu, 24 Mar 2022 02:59:51 -0700 (PDT)
Received: from odroid ([114.29.23.97])
        by smtp.gmail.com with ESMTPSA id h2-20020a056a00218200b004f6519ce666sm2825812pfi.170.2022.03.24.02.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 02:59:50 -0700 (PDT)
Date:   Thu, 24 Mar 2022 09:59:43 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 15/15] mm/sl[au]b: check if large object is valid
 in __ksize()
Message-ID: <20220324095943.GB2108184@odroid>
References: <20220308114142.1744229-1-42.hyeyoo@gmail.com>
 <20220308114142.1744229-16-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308114142.1744229-16-42.hyeyoo@gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vlastimil wrote:
> On 3/8/22 12:41, Hyeonggon Yoo wrote:
> > +
> >  static __always_inline void *
> > -slab_alloc(struct kmem_cache *cachep, gfp_t flags, size_t orig_size, unsigned long caller)
> > +slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_size,
> > +		   unsigned long caller)
> >  {
> >  	unsigned long save_flags;
> > -	void *objp;
> > +	void *ptr;
> > +	int slab_node = numa_mem_id();
> >  	struct obj_cgroup *objcg = NULL;
> >  	bool init = false;
> >
> > @@ -3299,21 +3255,49 @@ slab_alloc(struct kmem_cache *cachep, gfp_t flags, size_t orig_size, unsigned lo
> >  	if (unlikely(!cachep))
> >  		return NULL;
> >
> > -	objp = kfence_alloc(cachep, orig_size, flags);
> > -	if (unlikely(objp))
> > -		goto out;
> > +	ptr = kfence_alloc(cachep, orig_size, flags);
> > +	if (unlikely(ptr))
> > +		goto out_hooks;
> >
> >  	cache_alloc_debugcheck_before(cachep, flags);
> >  	local_irq_save(save_flags);
> > -	objp = __do_cache_alloc(cachep, flags);
> 
> Looks like after this patch, slab_alloc() (without a node specified)
> will not end up in __do_cache_alloc() anymore, so there's no more
> possibility of alternate_node_alloc(), which looks like a functional
> regression?
>

Ah, that was not intended. Thank you for catching this!
Will fix in v2.

Thank you so much.

> > +
> > +	if (node_match(nodeid, slab_node)) {
> > +		/*
> > +		 * Use the locally cached objects if possible.
> > +		 * However ____cache_alloc does not allow fallback
> > +		 * to other nodes. It may fail while we still have
> > +		 * objects on other nodes available.
> > +		 */
> > +		ptr = ____cache_alloc(cachep, flags);
> > +		if (ptr)
> > +			goto out;
> > +	}
> > +#ifdef CONFIG_NUMA
> > +	else if (unlikely(!get_node(cachep, nodeid))) {
> > +		/* Node not bootstrapped yet */
> > +		ptr = fallback_alloc(cachep, flags);
> > +		goto out;
> > +	}
> > +
> > +	/* ___cache_alloc_node can fall back to other nodes */
> > +	ptr = ____cache_alloc_node(cachep, flags, nodeid);
> > +#endif
> > +out:
> >  	local_irq_restore(save_flags);
> > -	objp = cache_alloc_debugcheck_after(cachep, flags, objp, caller);
> > -	prefetchw(objp);
> > +	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, caller);
> > +	prefetchw(ptr);
> >  	init = slab_want_init_on_alloc(flags, cachep);
> >
> > -out:
> > -	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init);
> > -	return objp;
> > +out_hooks:
> > +	slab_post_alloc_hook(cachep, objcg, flags, 1, &ptr, init);
> > +	return ptr;
> > +}
> > +
> > +static __always_inline void *
> > +slab_alloc(struct kmem_cache *cachep, gfp_t flags, size_t orig_size, unsigned long caller)
> > +{
> > +	return slab_alloc_node(cachep, flags, NUMA_NO_NODE, orig_size, caller);
> >  }
> >
> >  /*

--
Thank you, You are awesome!
Hyeonggon :-)
