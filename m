Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7704E5537
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245165AbiCWPaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237924AbiCWPaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:30:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD1E6E7B8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:28:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2D849210F0;
        Wed, 23 Mar 2022 15:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648049310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3D1yfbWb9Pw0dyRZ3yvsjxWufPpIaywjGWQ03KWgohQ=;
        b=td80NtyObKyxXWfyLdvp/JLKax4JKPNaff6tRF2kimlz3s5KaRyq5TsgRxJa80ibsnsx1i
        Lu624OkAWJio42ALNOSL3zUF1lc1kRiXWwR4FiJuq5Wcq8cokaN0tF3xUnZeX9IWPaZpWU
        06ABMx1RhkdhNEakmHvabhTbr8r7fE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648049310;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3D1yfbWb9Pw0dyRZ3yvsjxWufPpIaywjGWQ03KWgohQ=;
        b=NLeu1uoiQAZCyRGh4iyAXS8pvacMgg1kXJ2aMbuK7ITMRBHHl0oOTG1MLUyKak1yaZ1Qke
        L2vYhKSK7pzMcJAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6EAE12FC5;
        Wed, 23 Mar 2022 15:28:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0vLZMp08O2KfagAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 23 Mar 2022 15:28:29 +0000
Message-ID: <5833607a-4444-206d-db4f-9f958653c5b0@suse.cz>
Date:   Wed, 23 Mar 2022 16:28:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v1 01/15] mm/slab: cleanup slab_alloc() and
 slab_alloc_node()
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org
References: <20220308114142.1744229-1-42.hyeyoo@gmail.com>
 <20220308114142.1744229-2-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220308114142.1744229-2-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/22 12:41, Hyeonggon Yoo wrote:
> +
>  static __always_inline void *
> -slab_alloc(struct kmem_cache *cachep, gfp_t flags, size_t orig_size, unsigned long caller)
> +slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_size,
> +		   unsigned long caller)
>  {
>  	unsigned long save_flags;
> -	void *objp;
> +	void *ptr;
> +	int slab_node = numa_mem_id();
>  	struct obj_cgroup *objcg = NULL;
>  	bool init = false;
>  
> @@ -3299,21 +3255,49 @@ slab_alloc(struct kmem_cache *cachep, gfp_t flags, size_t orig_size, unsigned lo
>  	if (unlikely(!cachep))
>  		return NULL;
>  
> -	objp = kfence_alloc(cachep, orig_size, flags);
> -	if (unlikely(objp))
> -		goto out;
> +	ptr = kfence_alloc(cachep, orig_size, flags);
> +	if (unlikely(ptr))
> +		goto out_hooks;
>  
>  	cache_alloc_debugcheck_before(cachep, flags);
>  	local_irq_save(save_flags);
> -	objp = __do_cache_alloc(cachep, flags);

Looks like after this patch, slab_alloc() (without a node specified)
will not end up in __do_cache_alloc() anymore, so there's no more
possibility of alternate_node_alloc(), which looks like a functional
regression?

> +
> +	if (node_match(nodeid, slab_node)) {
> +		/*
> +		 * Use the locally cached objects if possible.
> +		 * However ____cache_alloc does not allow fallback
> +		 * to other nodes. It may fail while we still have
> +		 * objects on other nodes available.
> +		 */
> +		ptr = ____cache_alloc(cachep, flags);
> +		if (ptr)
> +			goto out;
> +	}
> +#ifdef CONFIG_NUMA
> +	else if (unlikely(!get_node(cachep, nodeid))) {
> +		/* Node not bootstrapped yet */
> +		ptr = fallback_alloc(cachep, flags);
> +		goto out;
> +	}
> +
> +	/* ___cache_alloc_node can fall back to other nodes */
> +	ptr = ____cache_alloc_node(cachep, flags, nodeid);
> +#endif
> +out:
>  	local_irq_restore(save_flags);
> -	objp = cache_alloc_debugcheck_after(cachep, flags, objp, caller);
> -	prefetchw(objp);
> +	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, caller);
> +	prefetchw(ptr);
>  	init = slab_want_init_on_alloc(flags, cachep);
>  
> -out:
> -	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init);
> -	return objp;
> +out_hooks:
> +	slab_post_alloc_hook(cachep, objcg, flags, 1, &ptr, init);
> +	return ptr;
> +}
> +
> +static __always_inline void *
> +slab_alloc(struct kmem_cache *cachep, gfp_t flags, size_t orig_size, unsigned long caller)
> +{
> +	return slab_alloc_node(cachep, flags, NUMA_NO_NODE, orig_size, caller);
>  }
>  
>  /*

