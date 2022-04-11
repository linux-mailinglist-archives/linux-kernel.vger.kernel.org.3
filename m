Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47A24FBA95
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245224AbiDKLNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345925AbiDKLKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:10:47 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412AD4553B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:08:04 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id j17so12825453pfi.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sLKOyEDQ94V4T7IMbKowetu23bD0e9Tu4ZHOeay0Nmw=;
        b=Z8w11YypcQClOBGXJEkE3vzocyTa84nM9++PON2DhSNRnGzR8wLsabf1eZWhjFrkLQ
         t4gZm37BQaOhYyaq6Za4OLDl5zRWURbf3+lYpuTwMRrZrKH9hLcWmERyyHXL/D1ujwkB
         TqrQ/J00olz2VGqofIzSgZsoOHlc9O0SKZywuyxbg2UARzRza79eEG6eWkc91expZqrb
         f7KtUHhHNDqOtQ+A/+WgfZaTbax3tuUrv1E/csb6EPOMxm9o0szDmysiZg8Q+D4sCjNu
         uOA4RmeMGMYP/fnskE11HyF2xUI4mrUWZ5AwDXk0cs/nwXgGJjjRtpizE4QwfO77QbVT
         aTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sLKOyEDQ94V4T7IMbKowetu23bD0e9Tu4ZHOeay0Nmw=;
        b=ZmGW4uGI+c5hVLFjM0RoONLjSa+68Ba1pbEfEXfATst9cL09jf4qyIzhKc++BjN+mL
         U27iqFSnFEERVGePtpeTYwN1rrAZ4oggL9xzf+Uu0MOpEL2s5COMngzv8D8nsktNjS6h
         Oflbh4PKh8pHoOA1UitHQ3wKX4wZGUXL2/g4AuidWNQFkKQuUWi6Lf32qtSxNQOJjqo2
         b3qcX82O+zKzsOGC8cxmSNFpiqU8GFJ1oN2NRsonoiPPy26z/Fbm3y5wbvopTFBlmrqL
         8DeVTtTQh4Y/yeJHfllyMGtE177nUEiSULG6XAF712lfqr1FKUtEVOOmMlNbCwVazbFY
         ajeA==
X-Gm-Message-State: AOAM531lU12h7Qay+PKTKIL2qQqb3Px2csWoot6OwYw8G/ZM98+dICyJ
        hZu4OiNECBPQEPyoQEZJn1I=
X-Google-Smtp-Source: ABdhPJz7/6ofoutkdPkyf59dqggkjVqNNJBtorDyZuwg3taNrLb8ll7lpbYgrDXUBoT1TBI7CHlX0A==
X-Received: by 2002:a63:db4c:0:b0:39d:18bf:7857 with SMTP id x12-20020a63db4c000000b0039d18bf7857mr9615859pgi.413.1649675283592;
        Mon, 11 Apr 2022 04:08:03 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id c74-20020a621c4d000000b00505be1ae39bsm3694138pfc.9.2022.04.11.04.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 04:08:02 -0700 (PDT)
Date:   Mon, 11 Apr 2022 20:07:55 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Ohhoon Kwon <ohkwon1043@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        JaeSang Yoo <jsyoo5b@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/slab_common: move dma-kmalloc caches creation into
 new_kmalloc_cache()
Message-ID: <YlQMC9x1hfgonJH/@hyeyoo>
References: <20220410162511.656541-1-ohkwon1043@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220410162511.656541-1-ohkwon1043@gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 01:25:11AM +0900, Ohhoon Kwon wrote:
> There are four types of kmalloc_caches: KMALLOC_NORMAL, KMALLOC_CGROUP,
> KMALLOC_RECLAIM, and KMALLOC_DMA. While the first three types are
> created using new_kmalloc_cache(), KMALLOC_DMA caches are created in a
> separate logic. Let KMALLOC_DMA caches be also created using
> new_kmalloc_cache(), to enhance readability.
> 
> Historically, there were only KMALLOC_NORMAL caches and KMALLOC_DMA
> caches in the first place, and they were initialized in two separate
> logics. However, when KMALLOC_RECLAIM was introduced in v4.20 via
> commit 1291523f2c1d ("mm, slab/slub: introduce kmalloc-reclaimable
> caches") and KMALLOC_CGROUP was introduced in v5.14 via
> commit 494c1dfe855e ("mm: memcg/slab: create a new set of kmalloc-cg-<n>
> caches"), their creations were merged with KMALLOC_NORMAL's only.
> KMALLOC_DMA creation logic should be merged with them, too.
> 
> By merging KMALLOC_DMA initialization with other types, the following
> two changes might occur:
> 1. The order dma-kmalloc-<n> caches added in slab_cache list may be
> sorted by size. i.e. the order they appear in /proc/slabinfo may change
> as well.
> 2. slab_state will be set to UP after KMALLOC_DMA is created.
> In case of slub, freelist randomization is dependent on slab_state>=UP,
> and therefore KMALLOC_DMA cache's freelist will not be randomized in
> creation, but will be deferred to init_freelist_randomization().
> 
> Co-developed-by: JaeSang Yoo <jsyoo5b@gmail.com>
> Signed-off-by: JaeSang Yoo <jsyoo5b@gmail.com>
> Signed-off-by: Ohhoon Kwon <ohkwon1043@gmail.com>
> ---
>  mm/slab_common.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 6ee64d6208b3..a959d247c27b 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -849,6 +849,8 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
>  			return;
>  		}
>  		flags |= SLAB_ACCOUNT;
> +	} else if (IS_ENABLED(CONFIG_ZONE_DMA) && (type == KMALLOC_DMA)) {
> +		flags |= SLAB_CACHE_DMA;
>  	}
>  
>  	kmalloc_caches[type][idx] = create_kmalloc_cache(
> @@ -877,7 +879,7 @@ void __init create_kmalloc_caches(slab_flags_t flags)
>  	/*
>  	 * Including KMALLOC_CGROUP if CONFIG_MEMCG_KMEM defined
>  	 */
> -	for (type = KMALLOC_NORMAL; type <= KMALLOC_RECLAIM; type++) {
> +	for (type = KMALLOC_NORMAL; type < NR_KMALLOC_TYPES; type++) {
>  		for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
>  			if (!kmalloc_caches[type][i])
>  				new_kmalloc_cache(i, type, flags);
> @@ -898,20 +900,6 @@ void __init create_kmalloc_caches(slab_flags_t flags)
>  
>  	/* Kmalloc array is now usable */
>  	slab_state = UP;
> -
> -#ifdef CONFIG_ZONE_DMA
> -	for (i = 0; i <= KMALLOC_SHIFT_HIGH; i++) {
> -		struct kmem_cache *s = kmalloc_caches[KMALLOC_NORMAL][i];
> -
> -		if (s) {
> -			kmalloc_caches[KMALLOC_DMA][i] = create_kmalloc_cache(
> -				kmalloc_info[i].name[KMALLOC_DMA],
> -				kmalloc_info[i].size,
> -				SLAB_CACHE_DMA | flags, 0,
> -				kmalloc_info[i].size);
> -		}
> -	}
> -#endif
>  }
>  #endif /* !CONFIG_SLOB */
>

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

BTW this patch may conflict with [1] (not merged yet)

[1] https://lore.kernel.org/linux-mm/20220405135758.774016-9-catalin.marinas@arm.com/

Thanks!

> -- 
> 2.25.1
> 

-- 
Thanks,
Hyeonggon
