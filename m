Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E122D522C40
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239936AbiEKGYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiEKGYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:24:47 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AF521333E
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:24:45 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id v11so1131328pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4zqtIBImcyHLL9Tc/oW4yDkc5aMRTyCtWMqUHcmloj0=;
        b=HycIQXNS2m9V3MJ/RxfFqSQ1dNGbPq2hsqXt3N+/5/4n1GxevoeG9C0LQod72HP6Rs
         da2JXtDaTr2kiEI9cqaSS4ctWsu7D8PFy7LCTt0HOgxbto38vsoe5Xu/eIOkQTp/daXi
         Q7ExLiKfo2obFFw7Dd5m0nhlcSQ+p4vAF8Ne6PNKpyjydvtd/8xwK6HLTpE1pGM17PQh
         SE6+eyq1i74pYJiHbSAQUOd4vcH7Illk6eGPcS1dHoWmjqRvywIzBguSe7T+vuM7PS+W
         yjB0NasFpFQR1mBZ5Dv8qWozKSMXAJs1aAztvPaUta34bZkKDC2Rk2wgmlwIz8TqH7WY
         uuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4zqtIBImcyHLL9Tc/oW4yDkc5aMRTyCtWMqUHcmloj0=;
        b=2KBHKATUpCq+QdHvSWnuJyCGL1wVdUiFDYGYFfDtWsfsAB4w4tF21VvocePKiR00L4
         PMYRvFkONU8IehINlK+NgeBhFu0wQaxVO0vw1fqtFgiwEyg1GzRW7lhMtkT5qJ+Wp+p9
         fmN9wN0Enf0qoXNRt83V3Csp1Mkj+GvpLw54UQq7mGZXAaM8l1YgncRPJFSmGIcWSeDR
         7/oaZ/aJVqfI6X2Btg9dQhKZkh7LJ7QWrTI+Kc5JdEdfND1/FgPcYp+/ddjFi3EBMc5T
         iXjauFEUR72YzXmH3l1by1tLK92NNW2LM+5BYVyzaEbMMHNlWBeGFcgVzwIhXXUF0fg7
         Cv3w==
X-Gm-Message-State: AOAM532UKf5r7QaexzjnjkMnXq6uVteVt8w9i0BVgQA/lYtfEvAmqTX+
        rM8OiEY5XulkmGuoJaIgCdoNqA==
X-Google-Smtp-Source: ABdhPJx9zGROrNwYSZvhPjwrVU3mGUauq8w0wmlDTj7rDU82fX0V8EALKUq5p8NE8ZuKZScEgsv6gQ==
X-Received: by 2002:a05:6a00:996:b0:505:b6d2:abc8 with SMTP id u22-20020a056a00099600b00505b6d2abc8mr23981495pfg.11.1652250285267;
        Tue, 10 May 2022 23:24:45 -0700 (PDT)
Received: from [10.254.203.126] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id y65-20020a638a44000000b003c1ee2c4242sm822832pgd.33.2022.05.10.23.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 23:24:44 -0700 (PDT)
Message-ID: <ec946373-ec15-e1a6-e8b4-b22dfb222e9c@bytedance.com>
Date:   Wed, 11 May 2022 14:24:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v2 1/2] mm: fix missing handler for __GFP_NOWARN
Content-Language: en-US
To:     akpm@linux-foundation.org, jirislaby@kernel.org,
        akinobu.mita@gmail.com, vbabka@suse.cz, gregkh@linuxfoundation.org,
        rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220511061951.1114-1-zhengqi.arch@bytedance.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20220511061951.1114-1-zhengqi.arch@bytedance.com>
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



On 2022/5/11 2:19 PM, Qi Zheng wrote:
> We expect no warnings to be issued when we specify __GFP_NOWARN, but
> currently in paths like alloc_pages() and kmalloc(), there are still
> some warnings printed, fix it.
> 
> But for some warnings that report usage problems, we don't deal with
> them. If such warnings are printed, then we should fix the usage
> problems. Such as the following case:
> 
> 	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---

Changelog in v1 -> v2:
  - add comment to WARN_ON_ONCE_GFP
  - handle __alloc_contig_migrate_range() case
  - do not deal with:
	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));

>   include/linux/fault-inject.h |  2 ++
>   lib/fault-inject.c           |  3 +++
>   mm/failslab.c                |  3 +++
>   mm/internal.h                | 15 +++++++++++++++
>   mm/page_alloc.c              | 18 ++++++++++--------
>   5 files changed, 33 insertions(+), 8 deletions(-)
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
> index e3e50af20706..34fdedb9986f 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -35,6 +35,21 @@ struct folio_batch;
>   /* Do not use these with a slab allocator */
>   #define GFP_SLAB_BUG_MASK (__GFP_DMA32|__GFP_HIGHMEM|~__GFP_BITS_MASK)
>   
> +/*
> + * Different from WARN_ON_ONCE(), no warning will be issued
> + * when we specify __GFP_NOWARN.
> + */
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
> index 65f892af1d4f..f9f329403d76 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3789,6 +3789,9 @@ static bool __should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
>   			(gfp_mask & __GFP_DIRECT_RECLAIM))
>   		return false;
>   
> +	if (gfp_mask & __GFP_NOWARN)
> +		fail_page_alloc.attr.no_warn = true;
> +
>   	return should_fail(&fail_page_alloc.attr, 1 << order);
>   }
>   
> @@ -4337,7 +4340,8 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>   	 */
>   
>   	/* Exhausted what can be done so it's blame time */
> -	if (out_of_memory(&oc) || WARN_ON_ONCE(gfp_mask & __GFP_NOFAIL)) {
> +	if (out_of_memory(&oc) ||
> +	    WARN_ON_ONCE_GFP(gfp_mask & __GFP_NOFAIL, gfp_mask)) {
>   		*did_some_progress = 1;
>   
>   		/*
> @@ -5103,7 +5107,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>   		 * All existing users of the __GFP_NOFAIL are blockable, so warn
>   		 * of any new users that actually require GFP_NOWAIT
>   		 */
> -		if (WARN_ON_ONCE(!can_direct_reclaim))
> +		if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
>   			goto fail;
>   
>   		/*
> @@ -5111,7 +5115,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>   		 * because we cannot reclaim anything and only can loop waiting
>   		 * for somebody to do a work for us
>   		 */
> -		WARN_ON_ONCE(current->flags & PF_MEMALLOC);
> +		WARN_ON_ONCE_GFP(current->flags & PF_MEMALLOC, gfp_mask);
>   
>   		/*
>   		 * non failing costly orders are a hard requirement which we
> @@ -5119,7 +5123,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>   		 * so that we can identify them and convert them to something
>   		 * else.
>   		 */
> -		WARN_ON_ONCE(order > PAGE_ALLOC_COSTLY_ORDER);
> +		WARN_ON_ONCE_GFP(order > PAGE_ALLOC_COSTLY_ORDER, gfp_mask);
>   
>   		/*
>   		 * Help non-failing allocations by giving them access to memory
> @@ -5365,10 +5369,8 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
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
> @@ -9020,7 +9022,7 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
>   
>   	lru_cache_enable();
>   	if (ret < 0) {
> -		if (ret == -EBUSY)
> +		if (!(cc->gfp_mask & __GFP_NOWARN) && ret == -EBUSY)
>   			alloc_contig_dump_pages(&cc->migratepages);
>   		putback_movable_pages(&cc->migratepages);
>   		return ret;

-- 
Thanks,
Qi
