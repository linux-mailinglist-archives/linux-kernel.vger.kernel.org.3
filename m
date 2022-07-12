Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD3B571C88
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbiGLO3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbiGLO3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:29:13 -0400
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60038D8F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:29:12 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id C672CB00422; Tue, 12 Jul 2022 16:29:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1657636150; bh=XqZSR6vsTCgGnza0thiZL4p41K1Z4arAxxg+LT4Q08U=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=chNsj66T6C5Yjk38kP6Y0X+r2jkn6hvDNBcnA8D90YmilYAEo5d6zRTUSGwXkkFGD
         o4lGaT7bKF3qaMOK3o4XvxNYZsUEBs1pY/ZziLN5sFaKAjqCqQ+SEMquPrZ1LRpyDv
         ohhlK1pLjQW8JhhsSAZpI74oGAorx26f9mV7Q0TpRt3h0iDUPNuSHyPZkYHpnTRci8
         ifnorxskQC3dnoBIMmxhQMIof19CKPgpELRmSpY0MoGwy/UnfTmO02wdywBKRYBs/i
         m6V9lhor16N7I5+uS6nL7N3YF6S5RAz2NwBUGR3ilCR2WNNUjiGFstbqKSKcbaN4OV
         ldKCg7YAdQfmg==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id C2A03B0026E;
        Tue, 12 Jul 2022 16:29:10 +0200 (CEST)
Date:   Tue, 12 Jul 2022 16:29:10 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
cc:     Pekka Enberg <penberg@kernel.org>,
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
In-Reply-To: <20220712133946.307181-2-42.hyeyoo@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2207121626530.55992@gentwo.de>
References: <20220712133946.307181-1-42.hyeyoo@gmail.com> <20220712133946.307181-2-42.hyeyoo@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022, Hyeonggon Yoo wrote:

> @@ -3241,31 +3219,46 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_
>  }
>
>  static __always_inline void *
> -__do_cache_alloc(struct kmem_cache *cache, gfp_t flags)
> +__do_cache_alloc(struct kmem_cache *cachep, gfp_t flags, int nodeid)
>  {
> -	void *objp;
> +	void *objp = NULL;
> +	int slab_node = numa_mem_id();
>
> -	if (current->mempolicy || cpuset_do_slab_mem_spread()) {
> -		objp = alternate_node_alloc(cache, flags);
> -		if (objp)
> -			goto out;
> +	if (nodeid == NUMA_NO_NODE) {
> +		if (current->mempolicy || cpuset_do_slab_mem_spread()) {
> +			objp = alternate_node_alloc(cachep, flags);
> +			if (objp)
> +				goto out;
> +		}
> +		/*
> +		 * Use the locally cached objects if possible.
> +		 * However ____cache_alloc does not allow fallback
> +		 * to other nodes. It may fail while we still have
> +		 * objects on other nodes available.
> +		 */
> +		objp = ____cache_alloc(cachep, flags);
> +		nodeid = slab_node;
> +	} else if (nodeid == slab_node) {
> +		objp = ____cache_alloc(cachep, flags);
> +	} else if (!get_node(cachep, nodeid)) {
> +		/* Node not bootstrapped yet */
> +		objp = fallback_alloc(cachep, flags);
> +		goto out;
>  	}
> -	objp = ____cache_alloc(cache, flags);
>
>  	/*
>  	 * We may just have run out of memory on the local node.
>  	 * ____cache_alloc_node() knows how to locate memory on other nodes
>  	 */
>  	if (!objp)
> -		objp = ____cache_alloc_node(cache, flags, numa_mem_id());
> -
> +		objp = ____cache_alloc_node(cachep, flags, nodeid);


Does this preserve the original behavior? nodeid is the parameter passed
to __do_cache_alloc(). numa_mem_id() is the nearest memory node.

