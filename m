Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850B65A920B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbiIAIZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbiIAIZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:25:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164EF193DA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:25:07 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id w5so5111815wrn.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 01:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=tcbWBRi6iAnXzpZ7/OAu6BZVPbwwwyPcddKIZpKIvmw=;
        b=cotNXp9I3LFIOLhqPmGpb96erSCudqQ8V43UeZ6t40jEm/I4eHgM3HYAzcqDkkUyL3
         UWQ+C/WpjQrI7NgFLXX4fkHDguIkrU/KBdxRnD7BNfbauoFH49DENerQKJeAjYCWre+K
         h6tPrXv8ZRE1X91n2iDPlRipwUlPmOsmGSwBruPOmOGRUKnDoWdv5/vqbU4mRQlw+1xS
         vTJ4rYXkZ9NzukgIR1bwmiqc42ICAW9bvUpyiJ4rtD0gnZfOukZZnXVRFV7pakyEqAfZ
         yNBdo6cnpyXPwTuRQcWg2pGALUeS8zIGt3R1EZQlR51aFmPI88yZS0IUK/mbAv5wcCW/
         /HGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tcbWBRi6iAnXzpZ7/OAu6BZVPbwwwyPcddKIZpKIvmw=;
        b=RtK3cdYqr1FGZYsQQgQM1eGRFjasojSXO34ihOrKlKZF1vrL0IfrE9YCrCRSr0V/Fh
         Z7BTxqwBns1+TqTngm++QoYJ3+o6G/WTIc9rQIWiAuznc/+PgE2iIA1ndtvLO2v7BrC3
         /zCSw1GPdemXyf71h4PZRJbFnhU6kWo9AplH0mDqy3Q0+V+yBAVoAUD9aE5OBXJcio6S
         Ajw2un3xs/ltqTe1LS7KWpedRrSvr71vhRYyn4w592Khf4YL2bRsu9S3saIVH0QZkg1B
         AyyhrwBtxhZgOlBawdgjyWcfWLcrUJRaZ6yq7qOfg54C3C8vLiTUKwy815CZxHRutmtM
         haFQ==
X-Gm-Message-State: ACgBeo3+LMaOGj6mBWkapnOOT8sZVld+1VJ1Oc0sIcZprk2TTcYct6j2
        tFp2qSloGFwXWetFFatFzlDX1Q==
X-Google-Smtp-Source: AA6agR5WNQCf74i8PrUGfD8q35GBU4+rrl8sCANxlZVsSV3Zu8/5NCoCLVFcFzwbLc1kCLvNuuOxLQ==
X-Received: by 2002:adf:e110:0:b0:226:2e2c:bfe9 with SMTP id t16-20020adfe110000000b002262e2cbfe9mr13984427wrz.432.1662020705380;
        Thu, 01 Sep 2022 01:25:05 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:401c:31df:7ab:1b94])
        by smtp.gmail.com with ESMTPSA id i17-20020a1c5411000000b003a1980d55c4sm4419310wmb.47.2022.09.01.01.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 01:25:04 -0700 (PDT)
Date:   Thu, 1 Sep 2022 10:24:58 +0200
From:   Marco Elver <elver@google.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Subject: Re: [PATCH 1/3] lib/stackdepot: Add a refcount field in stack_record
Message-ID: <YxBsWu36eqUw03Dy@elver.google.com>
References: <20220901044249.4624-1-osalvador@suse.de>
 <20220901044249.4624-2-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901044249.4624-2-osalvador@suse.de>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 06:42AM +0200, Oscar Salvador wrote:
> We want to filter out page_owner output and print only those
> stacks that have been repeated beyond a certain threshold.
> This gives us the chance to get rid of a lot of noise.
> In order to do that, we need to keep track of how many repeated stacks
> (for allocation) do we have, so we add a new refcount_t field
> in the stack_record struct.
> 
> Note that on __set_page_owner_handle(), page_owner->handle is set,
> and on __reset_page_owner(), page_owner->free_handle is set.
> 
> We are interested in page_owner->handle, so when __set_page_owner()
> gets called, we derive the stack_record struct from page_owner->handle,
> and we increment its refcount_t field; and when __reset_page_owner()
> gets called, we derive its stack_record from page_owner->handle()
> and we decrement its refcount_t field.
> 
> This is a preparation for patch#2.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  include/linux/stackdepot.h | 13 ++++++-
>  lib/stackdepot.c           | 79 +++++++++++++++++++++++++++++++-------
>  mm/kasan/common.c          |  3 +-

+Cc other kasan maintainers

>  mm/page_owner.c            | 13 +++++--
>  4 files changed, 88 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
> index bc2797955de9..5ee0cf5be88f 100644
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -15,9 +15,16 @@
>  
>  typedef u32 depot_stack_handle_t;
>  
> +typedef enum stack_action {
> +	STACK_ACTION_NONE,
> +	STACK_ACTION_INC,
> +}stack_action_t;
> +

missing space after '}'. But please no unnecessary typedef, just 'enum
stack_action' (and spelling out 'enum stack_action' elsewhere) is just
fine.

This is in the global namespace, so I'd call this
stack_depot_action+STACK_DEPOT_ACTION_*.

However, .._ACTION_INC doesn't really say what's incremented. As an
analog to stack_depot_dec_count(), perhaps .._ACTION_COUNT?

In general it'd be nicer if there was stack_depot_inc_count() instead of
this additional argument, but I see that for performance reasons you
might not like that?

>  depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>  					unsigned int nr_entries,
> -					gfp_t gfp_flags, bool can_alloc);
> +					gfp_t gfp_flags, bool can_alloc,
> +					stack_action_t action);
> +void stack_depot_dec_count(depot_stack_handle_t handle);
>  
>  /*
>   * Every user of stack depot has to call stack_depot_init() during its own init
> @@ -55,6 +62,10 @@ static inline int stack_depot_early_init(void)	{ return 0; }
>  
>  depot_stack_handle_t stack_depot_save(unsigned long *entries,
>  				      unsigned int nr_entries, gfp_t gfp_flags);
> +depot_stack_handle_t stack_depot_save_action(unsigned long *entries,
> +					     unsigned int nr_entries,
> +					     gfp_t gfp_flags,
> +					     stack_action_t action);
>  
>  unsigned int stack_depot_fetch(depot_stack_handle_t handle,
>  			       unsigned long **entries);
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 5ca0d086ef4a..aeb59d3557e2 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -63,6 +63,7 @@ struct stack_record {
>  	u32 hash;			/* Hash in the hastable */
>  	u32 size;			/* Number of frames in the stack */
>  	union handle_parts handle;
> +	refcount_t count;		/* Number of the same repeated stacks */

This will increase stack_record size for every user, even if they don't
care about the count.

Is there a way to store this out-of-line somewhere?

>  	unsigned long entries[];	/* Variable-sized array of entries. */
>  };
>  
> @@ -139,6 +140,7 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
>  	stack->handle.slabindex = depot_index;
>  	stack->handle.offset = depot_offset >> STACK_ALLOC_ALIGN;
>  	stack->handle.valid = 1;
> +	refcount_set(&stack->count, 1);
>  	memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
>  	depot_offset += required_size;
>  
> @@ -302,6 +304,29 @@ void stack_depot_print(depot_stack_handle_t stack)
>  }
>  EXPORT_SYMBOL_GPL(stack_depot_print);
>  
> +static struct stack_record *stack_depot_getstack(depot_stack_handle_t handle)
> +{
> +	union handle_parts parts = { .handle = handle };
> +	void *slab;
> +	size_t offset = parts.offset << STACK_ALLOC_ALIGN;
> +	struct stack_record *stack;
> +
> +	if(!handle)
> +		return NULL;
> +
> +	if (parts.slabindex > depot_index) {
> +		WARN(1, "slab index %d out of bounds (%d) for stack id %08x\n",
> +		     parts.slabindex, depot_index, handle);
> +		return NULL;
> +	}
> +	slab = stack_slabs[parts.slabindex];
> +	if (!slab)
> +		return NULL;
> +
> +	stack = slab + offset;
> +	return stack;
> +}
> +
>  /**
>   * stack_depot_fetch - Fetch stack entries from a depot
>   *
> @@ -314,30 +339,42 @@ EXPORT_SYMBOL_GPL(stack_depot_print);
>  unsigned int stack_depot_fetch(depot_stack_handle_t handle,
>  			       unsigned long **entries)
>  {
> -	union handle_parts parts = { .handle = handle };
> -	void *slab;
> -	size_t offset = parts.offset << STACK_ALLOC_ALIGN;
>  	struct stack_record *stack;
>  
>  	*entries = NULL;
>  	if (!handle)
>  		return 0;
>  
> -	if (parts.slabindex > depot_index) {
> -		WARN(1, "slab index %d out of bounds (%d) for stack id %08x\n",
> -			parts.slabindex, depot_index, handle);
> -		return 0;
> -	}
> -	slab = stack_slabs[parts.slabindex];
> -	if (!slab)
> +	stack = stack_depot_getstack(handle);
> +	if (!stack)
>  		return 0;
> -	stack = slab + offset;
>  
>  	*entries = stack->entries;
>  	return stack->size;
>  }
>  EXPORT_SYMBOL_GPL(stack_depot_fetch);
>  
> +static void stack_depot_inc_count(struct stack_record *stack)
> +{
> +	refcount_inc(&stack->count);
> +}
> +
> +void stack_depot_dec_count(depot_stack_handle_t handle)
> +{
> +	struct stack_record *stack = NULL;
> +
> +	stack = stack_depot_getstack(handle);
> +	if (stack) {
> +	/*
> +	 * page_owner creates some stacks via create_dummy_stack().
> +	 * We are not interested in those, so make sure we only decrement
> +	 * "valid" stacks.
> +	 */

Comment indent is wrong.

> +		if (refcount_read(&stack->count) > 1)
> +			refcount_dec(&stack->count);
> +	}
> +}
> +
>  /**
>   * __stack_depot_save - Save a stack trace from an array
>   *
> @@ -363,7 +400,8 @@ EXPORT_SYMBOL_GPL(stack_depot_fetch);
>   */
>  depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>  					unsigned int nr_entries,
> -					gfp_t alloc_flags, bool can_alloc)
> +					gfp_t alloc_flags, bool can_alloc,
> +					stack_action_t action)
>  {
>  	struct stack_record *found = NULL, **bucket;
>  	depot_stack_handle_t retval = 0;
> @@ -449,8 +487,11 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>  		/* Nobody used this memory, ok to free it. */
>  		free_pages((unsigned long)prealloc, STACK_ALLOC_ORDER);
>  	}
> -	if (found)
> +	if (found) {
>  		retval = found->handle.handle;
> +		if (action == STACK_ACTION_INC)
> +			stack_depot_inc_count(found);
> +	}
>  fast_exit:
>  	return retval;
>  }
> @@ -472,6 +513,16 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
>  				      unsigned int nr_entries,
>  				      gfp_t alloc_flags)
>  {
> -	return __stack_depot_save(entries, nr_entries, alloc_flags, true);
> +	return __stack_depot_save(entries, nr_entries, alloc_flags, true,
> +				  STACK_ACTION_NONE);
>  }
>  EXPORT_SYMBOL_GPL(stack_depot_save);
> +
> +depot_stack_handle_t stack_depot_save_action(unsigned long *entries,
> +					     unsigned int nr_entries,
> +					     gfp_t alloc_flags,
> +					     stack_action_t action)
> +{
> +	return __stack_depot_save(entries, nr_entries, alloc_flags, true, action);
> +}
> +EXPORT_SYMBOL_GPL(stack_depot_save_action);
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index c40c0e7b3b5f..f434994f3b0d 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -36,7 +36,8 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc)
>  	unsigned int nr_entries;
>  
>  	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
> -	return __stack_depot_save(entries, nr_entries, flags, can_alloc);
> +	return __stack_depot_save(entries, nr_entries, flags, can_alloc,
> +				  STACK_ACTION_NONE);
>  }
>  
>  void kasan_set_track(struct kasan_track *track, gfp_t flags)
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index e4c6f3f1695b..794f346d7520 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -106,7 +106,7 @@ static inline struct page_owner *get_page_owner(struct page_ext *page_ext)
>  	return (void *)page_ext + page_owner_ops.offset;
>  }
>  
> -static noinline depot_stack_handle_t save_stack(gfp_t flags)
> +static noinline depot_stack_handle_t save_stack(gfp_t flags, stack_action_t action)
>  {
>  	unsigned long entries[PAGE_OWNER_STACK_DEPTH];
>  	depot_stack_handle_t handle;
> @@ -125,7 +125,7 @@ static noinline depot_stack_handle_t save_stack(gfp_t flags)
>  	current->in_page_owner = 1;
>  
>  	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 2);
> -	handle = stack_depot_save(entries, nr_entries, flags);
> +	handle = stack_depot_save_action(entries, nr_entries, flags, action);
>  	if (!handle)
>  		handle = failure_handle;
>  
> @@ -138,6 +138,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
>  	int i;
>  	struct page_ext *page_ext;
>  	depot_stack_handle_t handle;
> +	depot_stack_handle_t alloc_handle;
>  	struct page_owner *page_owner;
>  	u64 free_ts_nsec = local_clock();
>  
> @@ -145,7 +146,10 @@ void __reset_page_owner(struct page *page, unsigned short order)
>  	if (unlikely(!page_ext))
>  		return;
>  
> -	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
> +	page_owner = get_page_owner(page_ext);
> +	alloc_handle = page_owner->handle;
> +
> +	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN, STACK_ACTION_NONE);
>  	for (i = 0; i < (1 << order); i++) {
>  		__clear_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
>  		page_owner = get_page_owner(page_ext);
> @@ -153,6 +157,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
>  		page_owner->free_ts_nsec = free_ts_nsec;
>  		page_ext = page_ext_next(page_ext);
>  	}
> +	stack_depot_dec_count(alloc_handle);
>  }
>  
>  static inline void __set_page_owner_handle(struct page_ext *page_ext,
> @@ -189,7 +194,7 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
>  	if (unlikely(!page_ext))
>  		return;
>  
> -	handle = save_stack(gfp_mask);
> +	handle = save_stack(gfp_mask, STACK_ACTION_INC);
>  	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
>  }
>  
> -- 
> 2.35.3
