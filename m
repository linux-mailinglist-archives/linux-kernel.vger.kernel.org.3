Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8DC4E6217
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 12:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349642AbiCXLHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 07:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347198AbiCXLHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 07:07:43 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B989A9BA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 04:06:11 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id s8so3703077pfk.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 04:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=nfj33Z1hktxCveFcrncNdeDrZFsHaZSKxlrG2enCzhs=;
        b=mFOzrh1axEwQuzE2GV7dILxkSQgWZSfAQT60rT8MNVqC0HoIz7RpNrzcm0OnMeZhF6
         o2lvwUA+E6XQP2dyHjMAD5QvtNwm4zvXSRlI5aHTwMigKPWyh/FlTIg0T/Ux2FZnrF40
         YO5xCSrfV9X3fWvWcHw7v72sWd3wBcvpXO7hyx9wK6u1x5hcOdGQ1QW100p/7zFUtvcm
         PvMF1Rwjf9iPdfFqq5KpXOQk4hxU4NKAIA+7WrBpqfasIhkbegC4v3+MhcyVuHHW7I+E
         qF1C/fYhPGp0gZepDLQgiaT+pxg/XYBmTELmqRusvkOr9Wt2I7K29Ke90I7jLDD87HLr
         QKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=nfj33Z1hktxCveFcrncNdeDrZFsHaZSKxlrG2enCzhs=;
        b=5bQBEB4frs7G9Upq7CXUTXHCfRr2qHiqA4S1O8OgjlxwasKuA8ksiGZdmJKvNksf9x
         59mGKzhmTzJ+OPB7Ib/mZlLuzb4tuTEuta+lM1hEyhAX2PrcSvgGstILhl5tbSVYV6tP
         7WBxP0/7TpSzNF1hzo/KMZFhZGiZ+D3ExjqAVvLcD3obz6gvX/ls3GIG/WHT40pSDBm7
         9opceB8T/RcaqvwP0RAKOC5aXLC5h+pL23XpAraZiJmDMX5+2j0DSPTdiPzgxe/3PITn
         bIOV6MAXBLwqzEzw0Y9oGIMLwLnvCKfUMYwxs9O3/xullMTlZg2+SyvrVPspJpeDeMCk
         vO+g==
X-Gm-Message-State: AOAM532RgdO2R7p10EUqJnMugOJ7btoPTcIoC+OYhdnppLjGRDYgSq7O
        PqquxdMlr7bhF2SoKEmhF2BTIb0Grmo=
X-Google-Smtp-Source: ABdhPJwXczoeV5tsZAaiZHkZgYJgmG+n/zkaAI/QS5VhUeAxcUXHTDna6Qh9Qah8aQuS7w+duKJLLg==
X-Received: by 2002:a05:6a00:2485:b0:4f7:37cd:d040 with SMTP id c5-20020a056a00248500b004f737cdd040mr4751618pfv.55.1648119971193;
        Thu, 24 Mar 2022 04:06:11 -0700 (PDT)
Received: from odroid ([114.29.23.97])
        by smtp.gmail.com with ESMTPSA id u126-20020a637984000000b0038147b4f53esm2294799pgc.93.2022.03.24.04.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 04:06:10 -0700 (PDT)
Date:   Thu, 24 Mar 2022 11:06:03 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 01/15] mm/slab: cleanup slab_alloc() and
 slab_alloc_node()
Message-ID: <20220324110603.GA2112827@odroid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5833607a-4444-206d-db4f-9f958653c5b0@suse.cz>
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
