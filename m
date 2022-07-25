Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CE3580319
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbiGYQsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGYQsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:48:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20568D10C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:48:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C22261FEC2;
        Mon, 25 Jul 2022 16:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658767691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WAsRhJouJkeGt0hMf4scn/nWn5ULSu40lVGx8T52zZc=;
        b=J/D7XQt0V69ZjO/Itj85p4VMdHL9bjirUy+0PNBfWYJn3TxMrjkBNEAeDqsRFE++okiy5x
        TKtF+vwhrWYXch3TFuoNaIJC3Xx7/6wARQAxXbc4YwvLrhxyEMynFot6/6JOkXOUWMkBrd
        KMX1+tXihZO2nDcTl7eIG2Ea0pDVV/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658767691;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WAsRhJouJkeGt0hMf4scn/nWn5ULSu40lVGx8T52zZc=;
        b=w54itx8gSy+srCqsSD8Yy38DCsNj+CA72YaaU0a/aIdRxjlZZ4bs13q8W/LfUTqprpD5AV
        zuwHSC7wczsSmgAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90AA513A8D;
        Mon, 25 Jul 2022 16:48:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id snSSIkvJ3mLBVAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 25 Jul 2022 16:48:11 +0000
Message-ID: <1b0fa66c-f855-1c00-e024-b2b823b18678@suse.cz>
Date:   Mon, 25 Jul 2022 18:48:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] mm/slub: extend redzone check to cover all
 allocated kmalloc space
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>
References: <20220725112025.22625-1-feng.tang@intel.com>
 <20220725112025.22625-2-feng.tang@intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220725112025.22625-2-feng.tang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/22 13:20, Feng Tang wrote:
> kmalloc will round up the request size to a fixes size (mostly power
> of 2), so there could be a extra space than what user request, whose
> size is the actual buffer size minus original request size.
> 
> To better detect out of bound access or abuse of this space, add
> redzone sannity check for it.
> 
> And in current kernel, some kmalloc user already knows the existence
> of the space and utilize it after calling 'ksize()' to know the real
> size of the allocated buffer. So we skip the sanity check for objects
> which have been called with ksize(), as treating them as legitimate
> users.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
> Hi reviewers,
> 
> I'm not sure if I should carve out the legitimizing ksize() check
> and kzalloc() zeroing buffer to separate ones, and just put them
> together as one patch. pls let me know if you think this should be
> separated.

Hm maybe separately and spell out the implications in changelog, in case it
ever becomes a bisect results. Zeroing only up to orig_size for __GFP_ZERO
can potentially break some code(but arguably one that was already broken).
I wonder if there's a user of ksize() that allocates with __GFP_ZERO and
then expects the whole be zeroed out :/

> Thanks,
> Feng
> 
>  mm/slab.c |  8 ++++----
>  mm/slab.h |  9 +++++++--
>  mm/slub.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++-------
>  3 files changed, 57 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index f8cd00f4ba13..9501510c3940 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3236,7 +3236,7 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_
>  	init = slab_want_init_on_alloc(flags, cachep);
>  
>  out_hooks:
> -	slab_post_alloc_hook(cachep, objcg, flags, 1, &ptr, init);
> +	slab_post_alloc_hook(cachep, objcg, flags, 1, &ptr, init, 0);
>  	return ptr;
>  }
>  
> @@ -3299,7 +3299,7 @@ slab_alloc(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
>  	init = slab_want_init_on_alloc(flags, cachep);
>  
>  out:
> -	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init);
> +	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init, 0);
>  	return objp;
>  }
>  
> @@ -3546,13 +3546,13 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  	 * Done outside of the IRQ disabled section.
>  	 */
>  	slab_post_alloc_hook(s, objcg, flags, size, p,
> -				slab_want_init_on_alloc(flags, s));
> +				slab_want_init_on_alloc(flags, s), 0);
>  	/* FIXME: Trace call missing. Christoph would like a bulk variant */
>  	return size;
>  error:
>  	local_irq_enable();
>  	cache_alloc_debugcheck_after_bulk(s, flags, i, p, _RET_IP_);
> -	slab_post_alloc_hook(s, objcg, flags, i, p, false);
> +	slab_post_alloc_hook(s, objcg, flags, i, p, false, 0);
>  	__kmem_cache_free_bulk(s, i, p);
>  	return 0;
>  }
> diff --git a/mm/slab.h b/mm/slab.h
> index db9fb5c8dae7..806822c78d24 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -733,12 +733,17 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
>  
>  static inline void slab_post_alloc_hook(struct kmem_cache *s,
>  					struct obj_cgroup *objcg, gfp_t flags,
> -					size_t size, void **p, bool init)
> +					size_t size, void **p, bool init,
> +					unsigned int orig_size)
>  {
>  	size_t i;
>  
>  	flags &= gfp_allowed_mask;
>  
> +	/* If original request size(kmalloc) is not set, use object_size */
> +	if (!orig_size)
> +		orig_size = s->object_size;
> +
>  	/*
>  	 * As memory initialization might be integrated into KASAN,
>  	 * kasan_slab_alloc and initialization memset must be
> @@ -749,7 +754,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
>  	for (i = 0; i < size; i++) {
>  		p[i] = kasan_slab_alloc(s, p[i], flags, init);
>  		if (p[i] && init && !kasan_has_integrated_init())
> -			memset(p[i], 0, s->object_size);
> +			memset(p[i], 0, orig_size);
>  		kmemleak_alloc_recursive(p[i], s->object_size, 1,
>  					 s->flags, flags);
>  	}
> diff --git a/mm/slub.c b/mm/slub.c
> index 9763a38bc4f0..8f3314f0725d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -193,8 +193,8 @@ static inline bool kmem_cache_debug(struct kmem_cache *s)
>  
>  static inline bool slub_debug_orig_size(struct kmem_cache *s)
>  {
> -	return (s->flags & SLAB_KMALLOC &&
> -			kmem_cache_debug_flags(s, SLAB_STORE_USER));
> +	return (kmem_cache_debug_flags(s, SLAB_STORE_USER | SLAB_RED_ZONE) &&
> +			(s->flags & SLAB_KMALLOC));

Hm now I see why patch 1/2 is done the way it is. But I think it's
legitimate to keep only storing orig_size with SLAB_STORE_USER. If only
SLAB_RED_ZONE is specified, then no orig_size is stored and the redzone
check will be as imprecise (assuming full kmalloc cache size) as it was before.

>  }
>  
>  void *fixup_red_left(struct kmem_cache *s, void *p)
> @@ -838,6 +838,11 @@ static inline void set_orig_size(struct kmem_cache *s,
>  	*(unsigned int *)p = orig_size;
>  }
>  
> +static inline void skip_orig_size_check(struct kmem_cache *s, const void *object)
> +{
> +	set_orig_size(s, (void *)object, s->object_size);
> +}
> +
>  static unsigned int get_orig_size(struct kmem_cache *s, void *object)
>  {
>  	void *p = kasan_reset_tag(object);
> @@ -970,13 +975,28 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct slab *slab,
>  static void init_object(struct kmem_cache *s, void *object, u8 val)
>  {
>  	u8 *p = kasan_reset_tag(object);
> +	unsigned int orig_size = s->object_size;
>  
>  	if (s->flags & SLAB_RED_ZONE)
>  		memset(p - s->red_left_pad, val, s->red_left_pad);
>  
> +	if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
> +		unsigned int zone_start;
> +
> +		orig_size = get_orig_size(s, object);
> +		zone_start = orig_size;
> +
> +		if (!freeptr_outside_object(s))
> +			zone_start = max_t(unsigned int, orig_size, s->offset + sizeof(void *));
> +
> +		/* Redzone the allocated by kmalloc but unused space */
> +		if (zone_start < s->object_size)
> +			memset(p + zone_start, val, s->object_size - zone_start);
> +	}
> +
>  	if (s->flags & __OBJECT_POISON) {
> -		memset(p, POISON_FREE, s->object_size - 1);
> -		p[s->object_size - 1] = POISON_END;
> +		memset(p, POISON_FREE, orig_size - 1);
> +		p[orig_size - 1] = POISON_END;
>  	}
>  
>  	if (s->flags & SLAB_RED_ZONE)
> @@ -1122,6 +1142,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>  {
>  	u8 *p = object;
>  	u8 *endobject = object + s->object_size;
> +	unsigned int orig_size;
>  
>  	if (s->flags & SLAB_RED_ZONE) {
>  		if (!check_bytes_and_report(s, slab, object, "Left Redzone",
> @@ -1139,6 +1160,20 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>  		}
>  	}
>  
> +	if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
> +		orig_size = get_orig_size(s, object);
> +
> +		if (!freeptr_outside_object(s))
> +			orig_size = max_t(unsigned int, orig_size,
> +						s->offset + sizeof(void *));
> +		if (s->object_size > orig_size  &&
> +			!check_bytes_and_report(s, slab, object,
> +				"kmalloc unused part", p + orig_size,
> +				val, s->object_size - orig_size)) {
> +			return 0;
> +		}
> +	}
> +
>  	if (s->flags & SLAB_POISON) {
>  		if (val != SLUB_RED_ACTIVE && (s->flags & __OBJECT_POISON) &&
>  			(!check_bytes_and_report(s, slab, p, "Poison", p,
> @@ -3287,7 +3322,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
>  	init = slab_want_init_on_alloc(gfpflags, s);
>  
>  out:
> -	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init);
> +	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init, orig_size);
>  
>  	return object;
>  }
> @@ -3802,11 +3837,11 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  	 * Done outside of the IRQ disabled fastpath loop.
>  	 */
>  	slab_post_alloc_hook(s, objcg, flags, size, p,
> -				slab_want_init_on_alloc(flags, s));
> +				slab_want_init_on_alloc(flags, s), 0);
>  	return i;
>  error:
>  	slub_put_cpu_ptr(s->cpu_slab);
> -	slab_post_alloc_hook(s, objcg, flags, i, p, false);
> +	slab_post_alloc_hook(s, objcg, flags, i, p, false, 0);
>  	__kmem_cache_free_bulk(s, i, p);
>  	return 0;
>  }
> @@ -4611,6 +4646,10 @@ size_t __ksize(const void *object)
>  	if (unlikely(!folio_test_slab(folio)))
>  		return folio_size(folio);
>  
> +#ifdef CONFIG_SLUB_DEBUG
> +	skip_orig_size_check(folio_slab(folio)->slab_cache, object);
> +#endif
> +
>  	return slab_ksize(folio_slab(folio)->slab_cache);
>  }
>  EXPORT_SYMBOL(__ksize);

