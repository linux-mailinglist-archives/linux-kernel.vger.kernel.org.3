Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE07B544C51
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245715AbiFIMmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238255AbiFIMmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:42:07 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2DB6456
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:42:05 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k16so32252331wrg.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 05:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=arApoAXBepq4URi/Em9A+yWgPjBE5I/lG8/rZgaEm2s=;
        b=gtgWlr41apWxTAxePw5sx8l0Eq6vLaOo960XyM1n8vl78eKEX90Fig8gAVHfTbukaC
         jlmqn1LCjVlmKtc/b0RstRuieFLXl2mnmDDBAnvvotHy2f5+CKeBjHGVCYizy/hQ1G4Y
         h528vgXuUxHE411w42ZkJbIbGsAlmgxA//9JQOqSuD/Xs3rkGF0zgTf57mafQNQpNvNN
         cI41EYLqrKEbINLqSzDIrCueCupLojy2ysKXHqwGC6JY0wGSsSSRO4k811QG6EZEhXPi
         fLZrG+nyrIr32byd9rMgLrf0DL55yr3a5sMflvVD+GmwvRLe97Sctc3hBg45Qmv14uP3
         CPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=arApoAXBepq4URi/Em9A+yWgPjBE5I/lG8/rZgaEm2s=;
        b=yeMGPoiqybyClviM703wiquzrJWAzuuUChicdUYoKRr5p01D71xRE5nGqjOg1EEbzM
         bV+Em91mgQilxa1BeApQDFfIXcZ6TIj6hbH9HaffUy2JlfW5uh8fqpap2wDVAvg2vawd
         LPkqTgAiGcAxZO9oLpvo7E8qn2P0Eg629DwmVt8WQLgy1ESHRXGaPQ7SGDGpx95kk5Nr
         YeQ7gnIWdpqlzFhSe42pVXBlT/0h3kvmO1lGsppKFjkd2ONYm9057rBAuYX71zj2hY2M
         X+MmubX5usFAWwPJM1+VBf7hI7SlwR81phMcgSeBh/9jagKqFeIxZoviSxRPgPt1O9fR
         UJbg==
X-Gm-Message-State: AOAM5316VTWpaW6EyEPlGbSapxFHiW2xGeMULXBolItgMf62oFOcFm9I
        zpR4eT19/4gGIMsXPiAYwscMTQ==
X-Google-Smtp-Source: ABdhPJzsvlFFwojqzqF4WptJLBDEbavVSgkyF5zQg2pxAhFuor7IcXL+vLqcs0XTvbk6FRYDPhgJAg==
X-Received: by 2002:adf:dd0a:0:b0:213:ba65:73fa with SMTP id a10-20020adfdd0a000000b00213ba6573famr33219503wrm.521.1654778524190;
        Thu, 09 Jun 2022 05:42:04 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:dcf:e5ba:10a5:1ea5])
        by smtp.gmail.com with ESMTPSA id j37-20020a05600c1c2500b0039c235fb6a5sm28367506wms.8.2022.06.09.05.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 05:42:03 -0700 (PDT)
Date:   Thu, 9 Jun 2022 14:41:56 +0200
From:   Marco Elver <elver@google.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        John Ogness <john.ogness@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2] mm/kfence: select random number before taking raw lock
Message-ID: <YqHqlC9gvYl2vAiE@elver.google.com>
References: <CAHmME9rkQDnsTu-8whevtBa_J6aOKT=gQO7kBAxwWrBgKgcyUQ@mail.gmail.com>
 <20220609123319.17576-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609123319.17576-1-Jason@zx2c4.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
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

On Thu, Jun 09, 2022 at 02:33PM +0200, Jason A. Donenfeld wrote:
> The RNG uses vanilla spinlocks, not raw spinlocks, so kfence should pick
> its random numbers before taking its raw spinlocks. This also has the
> nice effect of doing less work inside the lock. It should fix a splat
> that Geert saw with CONFIG_PROVE_RAW_LOCK_NESTING:
> 
>      dump_backtrace.part.0+0x98/0xc0
>      show_stack+0x14/0x28
>      dump_stack_lvl+0xac/0xec
>      dump_stack+0x14/0x2c
>      __lock_acquire+0x388/0x10a0
>      lock_acquire+0x190/0x2c0
>      _raw_spin_lock_irqsave+0x6c/0x94
>      crng_make_state+0x148/0x1e4
>      _get_random_bytes.part.0+0x4c/0xe8
>      get_random_u32+0x4c/0x140
>      __kfence_alloc+0x460/0x5c4
>      kmem_cache_alloc_trace+0x194/0x1dc
>      __kthread_create_on_node+0x5c/0x1a8
>      kthread_create_on_node+0x58/0x7c
>      printk_start_kthread.part.0+0x34/0xa8
>      printk_activate_kthreads+0x4c/0x54
>      do_one_initcall+0xec/0x278
>      kernel_init_freeable+0x11c/0x214
>      kernel_init+0x24/0x124
>      ret_from_fork+0x10/0x20
> 
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Marco Elver <elver@google.com>

Thank you.

> ---
> Changes v1->v2:
> - Make the bools const to help compiler elide branch when possible,
>   suggested by Marco.
> 
>  mm/kfence/core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 4e7cd4c8e687..4b5e5a3d3a63 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -360,6 +360,9 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
>  	unsigned long flags;
>  	struct slab *slab;
>  	void *addr;
> +	const bool random_right_allocate = prandom_u32_max(2);
> +	const bool random_fault = CONFIG_KFENCE_STRESS_TEST_FAULTS &&
> +				  !prandom_u32_max(CONFIG_KFENCE_STRESS_TEST_FAULTS);
>  
>  	/* Try to obtain a free object. */
>  	raw_spin_lock_irqsave(&kfence_freelist_lock, flags);
> @@ -404,7 +407,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
>  	 * is that the out-of-bounds accesses detected are deterministic for
>  	 * such allocations.
>  	 */
> -	if (prandom_u32_max(2)) {
> +	if (random_right_allocate) {
>  		/* Allocate on the "right" side, re-calculate address. */
>  		meta->addr += PAGE_SIZE - size;
>  		meta->addr = ALIGN_DOWN(meta->addr, cache->align);
> @@ -444,7 +447,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
>  	if (cache->ctor)
>  		cache->ctor(addr);
>  
> -	if (CONFIG_KFENCE_STRESS_TEST_FAULTS && !prandom_u32_max(CONFIG_KFENCE_STRESS_TEST_FAULTS))
> +	if (random_fault)
>  		kfence_protect(meta->addr); /* Random "faults" by protecting the object. */
>  
>  	atomic_long_inc(&counters[KFENCE_COUNTER_ALLOCATED]);
> -- 
> 2.35.1
> 
