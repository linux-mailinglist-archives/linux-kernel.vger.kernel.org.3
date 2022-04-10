Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8964FAC74
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 08:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbiDJGyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 02:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiDJGyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 02:54:20 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343E65F27E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 23:52:08 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id f3so11985560pfe.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 23:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kiJ9APoqAB53N14utwlexldPR1v9F4okKCVpXr8jG00=;
        b=n4zvGtKXRzvGFfyO3u/RNn7kM4d6vqAkqEHKtvH94+JyXQY08F95Ae572CgcNvQt39
         QtsCxAue8NbjMVDm4IeiAEIETT1QRZIHzAvpmkpNOQA55khboNhaNJ+N8v53Xw/URXg6
         mz+jpvR2TVvxY8CWG2y7mt62Vz/CLURZL82BpHENZPLBNfBpTMEVC3PXCTPcYHJ8IlMT
         Vc2QhIyD4eo/pJZy6tGw31URtk68oNwH0himZ9JTkKtfXwAGGucL+aSSMtETLuaVrJPR
         2PN14tnO9ha1xj5JAExdib4hzuWpTxOQcQ19nIvb1bT3ni95TfExlidI0/9QwBcf1fIv
         8nOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kiJ9APoqAB53N14utwlexldPR1v9F4okKCVpXr8jG00=;
        b=1DjOSW26wN3ExtqoymZY90v4XCV2VvOR5CpU7B15rD3GnfhI8mVacwz6w67+9AVy8z
         QgmGUPQR8pgHX/hHBCliffuT3Lw0eXL6XEKRAXRJVa0Dn46skhxQXb/QLZ5u0HYRCdmO
         fPMaFpWVnBtVGEX/0PVxOfFcZ6kZGp2CPJCclehIVo7R9TZcH0Dvn9eRkEdrYHYRJv3L
         S7wwAyxXw/cYiIDI4hj28L4zEAkICDzXWGM4sgSR6KiNIN8EqF61b8fB4t1QsrD1dpkE
         ZfGUE1xM8QwLhvIoKj+58ZGE2xUORwmj4DyHtdssUS9Pm2UgBWYpaPeL+y/PXPWB1vWy
         ZkUQ==
X-Gm-Message-State: AOAM532b+w75PpLNB239/Q1GVaqTQoSHmP9mS0xjBfEXiKJYd62H0Guz
        fxgaLPjNGoGbyiaHK+wOfmk=
X-Google-Smtp-Source: ABdhPJyLDrSiTNb28nE2LmdJX9xLgOvCBSPQsqWb+YP4LtSAVp0Cq1LTlCiV+y5nX5NJXcJkRRrygQ==
X-Received: by 2002:a63:ed45:0:b0:399:5116:312a with SMTP id m5-20020a63ed45000000b003995116312amr21326806pgk.611.1649573527624;
        Sat, 09 Apr 2022 23:52:07 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id y3-20020a056a00190300b004fa2411bb92sm32594637pfi.93.2022.04.09.23.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 23:52:06 -0700 (PDT)
Date:   Sun, 10 Apr 2022 15:51:57 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Ohhoon Kwon <ohkwon1043@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jiyoup Kim <lakroforce@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>
Subject: Re: [PATCH] mm/slab_common: move dma-kmalloc caches creation into
 new_kmalloc_cache()
Message-ID: <YlJ+jeHg5CDpmWc1@hyeyoo>
References: <20220409095305.586412-1-ohkwon1043@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409095305.586412-1-ohkwon1043@gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 06:53:05PM +0900, Ohhoon Kwon wrote:
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
>  mm/slab_common.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 6ee64d6208b3..eb95512de983 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -849,6 +849,10 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
>  			return;
>  		}
>  		flags |= SLAB_ACCOUNT;
> +#ifdef CONFIG_ZONE_DMA
> +	} else if (type == KMALLOC_DMA) {
> +		flags |= SLAB_CACHE_DMA;
> +#endif

Maybe IS_ENABLED() would be better instead of ifdef for consistency?

>  	}
>  
>  	kmalloc_caches[type][idx] = create_kmalloc_cache(
> @@ -877,7 +881,7 @@ void __init create_kmalloc_caches(slab_flags_t flags)
>  	/*
>  	 * Including KMALLOC_CGROUP if CONFIG_MEMCG_KMEM defined
>  	 */
> -	for (type = KMALLOC_NORMAL; type <= KMALLOC_RECLAIM; type++) {
> +	for (type = KMALLOC_NORMAL; type < NR_KMALLOC_TYPES; type++) {
>  		for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
>  			if (!kmalloc_caches[type][i])
>  				new_kmalloc_cache(i, type, flags);
> @@ -898,20 +902,6 @@ void __init create_kmalloc_caches(slab_flags_t flags)
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

The patch overall looks good to me.

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

> -- 
> 2.25.1
> 
> 

-- 
Thanks,
Hyeonggon
