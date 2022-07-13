Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2CA573304
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbiGMJj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbiGMJjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:39:54 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B19F54EF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:39:54 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y141so9758802pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J2J2u1LkrsbKi6YvldfMoSvbAoYgO95fp1M0s8Wr27g=;
        b=q3Ou4++fA1E2GW1K5dfL+/AMScnGCdQYEknNYdOhQfS2mca12EWg6stFGOlyqhACDx
         k9c6851FVlb/I+2EbEH2vk4abOpPhBNTeqS+AvSdFmbd0rr1sXumTOnhx+t85req/oQZ
         7D8u6VwHoMJYWsGu/PUtFaAKyS5Ph29TpNxqXkXEPO+EoPGW46bDfz7+PNyFyRx9qulq
         Yt2mUCrwsGhPtcO+IboNh8xwBdtuaKcpp8uqeg5ULghfTggd2AfXE/dWB3KsMVFtkW6M
         ZXb34Pa82FmnmzLydjm9jQIAZrAhgvzXV6AIMKeIgqlR7i3xQIZkvuu0cUfdDrJpa8Go
         1gpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J2J2u1LkrsbKi6YvldfMoSvbAoYgO95fp1M0s8Wr27g=;
        b=KM22Cdj9tsbkaAj2E3JIhVsgSw4Xm+k2JT+aopvI4rOWhYodfkA8IJD3d2JYjJ5wG4
         omSvLIkpUtG1kE60JxJOBvBQjA4oGwUE5Ij7+73bigdG39aI0z0L2n7o+nI8fvZKhpnQ
         OED4tTM1Ut6yMyk36YjW4tn2wGDk6pjxoC1WlaE+9mv0DUz0odDpiONQOKGVC/YpHAZy
         jZk5qmOpAhGXk+FiEXhevGJmWI8e8AT3HdqmeMM+QIJ27+VVEA3jDGrS7vIpXkmS+XHZ
         YyHfoOX5XpVwLCGJsZB55/kI27n6r3UHimVk1JDsjUmOV2IsKNeN0SdN0QTa6BNbg95u
         eOTQ==
X-Gm-Message-State: AJIora8b1bhClZ5MCGlNbAjO/YIUpVgIhBlc2PpCzSGWZGGzPXWIUcwa
        bixg9ppAeuFkjgwJJAwMQls=
X-Google-Smtp-Source: AGRyM1seFzWdcIfrPjmiqtO38PN1ilMVEJJ4f2IK2QQJ04vBjZCyutuvF1ySjmoy7Fu7GgsTchsKGA==
X-Received: by 2002:a05:6a00:889:b0:510:91e6:6463 with SMTP id q9-20020a056a00088900b0051091e66463mr2516118pfj.58.1657705193789;
        Wed, 13 Jul 2022 02:39:53 -0700 (PDT)
Received: from ip-172-31-24-42.ap-northeast-1.compute.internal (ec2-35-77-58-189.ap-northeast-1.compute.amazonaws.com. [35.77.58.189])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902ee8300b001640aad2f71sm8335113pld.180.2022.07.13.02.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 02:39:53 -0700 (PDT)
Date:   Wed, 13 Jul 2022 09:39:48 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joe Perches <joe@perches.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Matthew WilCox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/15] mm/slab: move NUMA-related code to
 __do_cache_alloc()
Message-ID: <Ys6S5ALolh0z1JjJ@ip-172-31-24-42.ap-northeast-1.compute.internal>
References: <20220712133946.307181-1-42.hyeyoo@gmail.com>
 <20220712133946.307181-2-42.hyeyoo@gmail.com>
 <alpine.DEB.2.22.394.2207121626530.55992@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2207121626530.55992@gentwo.de>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 04:29:10PM +0200, Christoph Lameter wrote:
> On Tue, 12 Jul 2022, Hyeonggon Yoo wrote:
> 
> > @@ -3241,31 +3219,46 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_
> >  }
> >
> >  static __always_inline void *
> > -__do_cache_alloc(struct kmem_cache *cache, gfp_t flags)
> > +__do_cache_alloc(struct kmem_cache *cachep, gfp_t flags, int nodeid)
> >  {
> > -	void *objp;
> > +	void *objp = NULL;
> > +	int slab_node = numa_mem_id();
> >
> > -	if (current->mempolicy || cpuset_do_slab_mem_spread()) {
> > -		objp = alternate_node_alloc(cache, flags);
> > -		if (objp)
> > -			goto out;
> > +	if (nodeid == NUMA_NO_NODE) {
> > +		if (current->mempolicy || cpuset_do_slab_mem_spread()) {
> > +			objp = alternate_node_alloc(cachep, flags);
> > +			if (objp)
> > +				goto out;
> > +		}
> > +		/*
> > +		 * Use the locally cached objects if possible.
> > +		 * However ____cache_alloc does not allow fallback
> > +		 * to other nodes. It may fail while we still have
> > +		 * objects on other nodes available.
> > +		 */
> > +		objp = ____cache_alloc(cachep, flags);
> > +		nodeid = slab_node;
> > +	} else if (nodeid == slab_node) {
> > +		objp = ____cache_alloc(cachep, flags);
> > +	} else if (!get_node(cachep, nodeid)) {
> > +		/* Node not bootstrapped yet */
> > +		objp = fallback_alloc(cachep, flags);
> > +		goto out;
> >  	}
> > -	objp = ____cache_alloc(cache, flags);
> >
> >  	/*
> >  	 * We may just have run out of memory on the local node.
> >  	 * ____cache_alloc_node() knows how to locate memory on other nodes
> >  	 */
> >  	if (!objp)
> > -		objp = ____cache_alloc_node(cache, flags, numa_mem_id());
> > -
> > +		objp = ____cache_alloc_node(cachep, flags, nodeid);
> 
> 
> Does this preserve the original behavior? nodeid is the parameter passed
> to __do_cache_alloc(). numa_mem_id() is the nearest memory node.

Yes it does preserve the original behavior.

nodeid equals to value of numa_mem_id() when nodeid was NUMA_NO_NODE and
____cache_alloc() failed to allocate.
