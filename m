Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5245B522B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 07:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiEKFNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 01:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiEKFNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 01:13:05 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8F42297D9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 22:13:02 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x88so1192540pjj.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 22:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=muchCbIST8CyazuMb2Tg5TYhrbA5UHp4Q53GXoBGlLg=;
        b=doOz+BgPF18Bg3tSulZJ3yWh3PEMfvVeL14hl+TBSbVibcnvqPXwbdFZ1uuyBf0x9/
         4/YnsHef7mQMcfraHB9ccw0sjMt231gPEMpcGkwEAy+D+ErzKD7o6iQhnrIu29s5Qrol
         66CyR+R0LpNYRE8PJRmToihMPjzKRky2wsdWnoudveqIvm7Q0QPf0rTkt5UvskxtO0V3
         hKSmXYqnpQ6eCP5T7OU51OI/WNX0uPAIV/z/P84RrRxRHNv8miscrXYyrjc4J7qe+PRu
         ssym9c6YtBNECvAEeKmfmdZmRCnq1hmerN1SWH2rxwJZnuzs+E8cYZC29ZIQ6oQzX5mA
         ixTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=muchCbIST8CyazuMb2Tg5TYhrbA5UHp4Q53GXoBGlLg=;
        b=mDeeYVjD8Rae5kZe+67Khz3eqbMzrgNfgGVpwbdG80MWJ3p9lTDM9f6ccgsZVQethc
         qEXyyJQPo2kInXcc4PX/7y6kyJyBoA1T/sScmFv0ExVB228F90m9sx3Igz/HY02CZ/RL
         E2U+4OC1X5qJ72gQ+1k30nWUSfF+TQQSsd8I9978bdryJORHWxOOosBFGx457QFgvuId
         yRAy0AgnBSAXJjSYWaM9TfZlLPe0ST8+oYCY+hMseJd8kGt1up8G6+oDrK1zYsqQM8lc
         6M+AbLlE+jW9tIg8f36InAhK0ITlueMX/YDf8tzmxiNy920yT0X1/CJp+2DZmSk8AlsE
         bHUA==
X-Gm-Message-State: AOAM533R0X/oFv3H/MTVs92IS2Jc01iaV/MxFFhvPOHkgfHQGsmB7TPU
        1D6WzR8klctUH0gbj7+V0SvlhQ==
X-Google-Smtp-Source: ABdhPJzGqMVbnyHBk+BhSzTl7IFFvsN8ZyzwAY1jD2lcfIeCi28OIfvNufz9fEzoAu8UVWVd+U+Zrw==
X-Received: by 2002:a17:902:db05:b0:15e:b542:3f23 with SMTP id m5-20020a170902db0500b0015eb5423f23mr23636870plx.143.1652245981709;
        Tue, 10 May 2022 22:13:01 -0700 (PDT)
Received: from [10.254.203.126] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id a4-20020aa794a4000000b0050dc76281edsm486928pfl.199.2022.05.10.22.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 22:13:01 -0700 (PDT)
Message-ID: <ed212c6b-a10a-0267-fb20-9a1691b9ba45@bytedance.com>
Date:   Wed, 11 May 2022 13:12:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] mm: fix missing handler for __GFP_NOWARN
Content-Language: en-US
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akinobu.mita@gmail.com, vbabka@suse.cz, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rostedt@goodmis.org
References: <20220510113809.80626-1-zhengqi.arch@bytedance.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20220510113809.80626-1-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/5/10 7:38 PM, Qi Zheng wrote:
> We expect no warnings to be issued when we specify __GFP_NOWARN, but
> currently in paths like alloc_pages() and kmalloc(), there are still
> some warnings printed, fix it.

Hi Andrew,

Maybe we only need to deal with memory allocation failures, such as
should_fail() (This leads to deadlock in PATCH[2/2]). These 
WARN_ON_ONCE()s report usage problems and should not be printed. If they
are printed, we should fix these usage problems.

Thanks,
Qi


> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   include/linux/fault-inject.h |  2 ++
>   lib/fault-inject.c           |  3 +++
>   mm/failslab.c                |  3 +++
>   mm/internal.h                | 11 +++++++++++
>   mm/page_alloc.c              | 22 ++++++++++++----------
>   5 files changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
> index 2d04f6448cde..9f6e25467844 100644
> --- a/include/linux/fault-inject.h
> +++ b/include/linux/fault-inject.h
> @@ -20,6 +20,7 @@ struct fault_attr {
>   	atomic_t space;
>   	unsigned long verbose;
>   	bool task_filter;
> +	bool no_warn;
>   	unsigned long stacktrace_depth;
>   	unsigned long require_start;
>   	unsigned long require_end;
> @@ -39,6 +40,7 @@ struct fault_attr {
>   		.ratelimit_state = RATELIMIT_STATE_INIT_DISABLED,	\
>   		.verbose = 2,						\
>   		.dname = NULL,						\
> +		.no_warn = false,					\
>   	}
>   
>   #define DECLARE_FAULT_ATTR(name) struct fault_attr name = FAULT_ATTR_INITIALIZER
> diff --git a/lib/fault-inject.c b/lib/fault-inject.c
> index ce12621b4275..423784d9c058 100644
> --- a/lib/fault-inject.c
> +++ b/lib/fault-inject.c
> @@ -41,6 +41,9 @@ EXPORT_SYMBOL_GPL(setup_fault_attr);
>   
>   static void fail_dump(struct fault_attr *attr)
>   {
> +	if (attr->no_warn)
> +		return;
> +
>   	if (attr->verbose > 0 && __ratelimit(&attr->ratelimit_state)) {
>   		printk(KERN_NOTICE "FAULT_INJECTION: forcing a failure.\n"
>   		       "name %pd, interval %lu, probability %lu, "
> diff --git a/mm/failslab.c b/mm/failslab.c
> index f92fed91ac23..58df9789f1d2 100644
> --- a/mm/failslab.c
> +++ b/mm/failslab.c
> @@ -30,6 +30,9 @@ bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags)
>   	if (failslab.cache_filter && !(s->flags & SLAB_FAILSLAB))
>   		return false;
>   
> +	if (gfpflags & __GFP_NOWARN)
> +		failslab.attr.no_warn = true;
> +
>   	return should_fail(&failslab.attr, s->object_size);
>   }
>   
> diff --git a/mm/internal.h b/mm/internal.h
> index cf16280ce132..7a268fac6559 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -35,6 +35,17 @@ struct folio_batch;
>   /* Do not use these with a slab allocator */
>   #define GFP_SLAB_BUG_MASK (__GFP_DMA32|__GFP_HIGHMEM|~__GFP_BITS_MASK)
>   
> +#define WARN_ON_ONCE_GFP(cond, gfp)	({				\
> +	static bool __section(".data.once") __warned;			\
> +	int __ret_warn_once = !!(cond);					\
> +									\
> +	if (unlikely(!(gfp & __GFP_NOWARN) && __ret_warn_once && !__warned)) { \
> +		__warned = true;					\
> +		WARN_ON(1);						\
> +	}								\
> +	unlikely(__ret_warn_once);					\
> +})
> +
>   void page_writeback_init(void);
>   
>   static inline void *folio_raw_mapping(struct folio *folio)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0e42038382c1..2bf4ce4d0e2f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3722,7 +3722,7 @@ struct page *rmqueue(struct zone *preferred_zone,
>   	 * We most definitely don't want callers attempting to
>   	 * allocate greater than order-1 page units with __GFP_NOFAIL.
>   	 */
> -	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
> +	WARN_ON_ONCE_GFP((gfp_flags & __GFP_NOFAIL) && (order > 1), gfp_flags);
>   
>   	do {
>   		page = NULL;
> @@ -3799,6 +3799,9 @@ static bool __should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
>   			(gfp_mask & __GFP_DIRECT_RECLAIM))
>   		return false;
>   
> +	if (gfp_mask & __GFP_NOWARN)
> +		fail_page_alloc.attr.no_warn = true;
> +
>   	return should_fail(&fail_page_alloc.attr, 1 << order);
>   }
>   
> @@ -4346,7 +4349,8 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>   	 */
>   
>   	/* Exhausted what can be done so it's blame time */
> -	if (out_of_memory(&oc) || WARN_ON_ONCE(gfp_mask & __GFP_NOFAIL)) {
> +	if (out_of_memory(&oc) ||
> +	    WARN_ON_ONCE_GFP(gfp_mask & __GFP_NOFAIL, gfp_mask)) {
>   		*did_some_progress = 1;
>   
>   		/*
> @@ -4902,8 +4906,8 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>   	 * We also sanity check to catch abuse of atomic reserves being used by
>   	 * callers that are not in atomic context.
>   	 */
> -	if (WARN_ON_ONCE((gfp_mask & (__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)) ==
> -				(__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)))
> +	if (WARN_ON_ONCE_GFP((gfp_mask & (__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)) ==
> +				(__GFP_ATOMIC|__GFP_DIRECT_RECLAIM), gfp_mask))
>   		gfp_mask &= ~__GFP_ATOMIC;
>   
>   retry_cpuset:
> @@ -5117,7 +5121,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>   		 * All existing users of the __GFP_NOFAIL are blockable, so warn
>   		 * of any new users that actually require GFP_NOWAIT
>   		 */
> -		if (WARN_ON_ONCE(!can_direct_reclaim))
> +		if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
>   			goto fail;
>   
>   		/*
> @@ -5125,7 +5129,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>   		 * because we cannot reclaim anything and only can loop waiting
>   		 * for somebody to do a work for us
>   		 */
> -		WARN_ON_ONCE(current->flags & PF_MEMALLOC);
> +		WARN_ON_ONCE_GFP(current->flags & PF_MEMALLOC, gfp_mask);
>   
>   		/*
>   		 * non failing costly orders are a hard requirement which we
> @@ -5133,7 +5137,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>   		 * so that we can identify them and convert them to something
>   		 * else.
>   		 */
> -		WARN_ON_ONCE(order > PAGE_ALLOC_COSTLY_ORDER);
> +		WARN_ON_ONCE_GFP(order > PAGE_ALLOC_COSTLY_ORDER, gfp_mask);
>   
>   		/*
>   		 * Help non-failing allocations by giving them access to memory
> @@ -5379,10 +5383,8 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
>   	 * There are several places where we assume that the order value is sane
>   	 * so bail out early if the request is out of bound.
>   	 */
> -	if (unlikely(order >= MAX_ORDER)) {
> -		WARN_ON_ONCE(!(gfp & __GFP_NOWARN));
> +	if (WARN_ON_ONCE_GFP(order >= MAX_ORDER, gfp))
>   		return NULL;
> -	}
>   
>   	gfp &= gfp_allowed_mask;
>   	/*

-- 
Thanks,
Qi
