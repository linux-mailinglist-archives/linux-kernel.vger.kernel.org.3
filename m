Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5AB4F7449
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 05:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240661AbiDGDsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 23:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbiDGDsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:48:43 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052F9A1A1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 20:46:45 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id w7so4286906pfu.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 20:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=afe3P8RqNChPkxC3rOsgiNHx8HENBTi8Jfkw7G43ebM=;
        b=d1JMhD/H3yQw+VDKVizT9O7dnKTJtEGUjWxAsZVvSWWX88idfpSfbtGxnDr/P4LgeU
         MSaR4wx92K/Dwt151SdmS8ARTGgEIlyYD8Uti2RpEAQmvmkQp5uRr3s/u03Xmi+JCPdR
         fDaD9L4rD9sPoUyRVE4MHIh5879MW7Uwr8pNOiSAz/yliO/91jmGIC755eKO835uEpTm
         E/EMRQ5wSWbaRQqXB2NFaKojrDBedxO1WFc7MuspaimbZVksUrzrJ4X8Rk1tVNh2dU0W
         VWMCXcCHs2SXBgBmoEePa/ZgzI8swxUYboPY0wpg+wD9DF6z7UAS6xiGvv55cZSi2OdW
         Cwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=afe3P8RqNChPkxC3rOsgiNHx8HENBTi8Jfkw7G43ebM=;
        b=ln8U7Dphyh7io50cfw2nBx4pX1nQ6q/vRs/Cujj8bPUVm1kKInueJ7wwoOcP4ZKAZI
         ewR1hneVJ0MghskrLS4HBzMDYrcpCw8FfJHnlghm5LBdmhOR09urgbLoCQdiqz+9e3v9
         V/M3P5jeC+5UqYKoL1hc/ySxOecO0lcLelgOGfIp4ufdkIKSqnUIaZ22+h45tQBDeotk
         el2o3bTRkzVJgbKvNuac+/yexuKUTTOq+E/kRD1uGRljEXDGRzdJMSzwCLgr3IDF2PCS
         FobcApRU4GHB9Z0bj5jKF03yyOztaoKbxkjdacn2hMAO93YqoCdoFQRdWVID2jd0/3qn
         he3g==
X-Gm-Message-State: AOAM532lTNM47y9lR5LBAKoKgun/Zvj+SgR8pGm7soOYHt3IWNDSl2YA
        cGzbmNy4lXwwE6VcwuUb4qQ=
X-Google-Smtp-Source: ABdhPJyAPXTXgV2oaMugw/XVi258KT6BhPySFoGDVPM27Hjv6I1XE4AM7kPPITDYhuOowocmGQ1WhA==
X-Received: by 2002:a63:214c:0:b0:381:1a27:fe1 with SMTP id s12-20020a63214c000000b003811a270fe1mr9516290pgm.328.1649303204413;
        Wed, 06 Apr 2022 20:46:44 -0700 (PDT)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id mn22-20020a17090b189600b001ca86a1e41dsm6782727pjb.52.2022.04.06.20.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 20:46:42 -0700 (PDT)
Date:   Thu, 7 Apr 2022 03:46:37 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] mm/slab: Allow dynamic kmalloc() minimum alignment
Message-ID: <Yk5endPQFHc/pB1W@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <20220405135758.774016-9-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405135758.774016-9-catalin.marinas@arm.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 02:57:56PM +0100, Catalin Marinas wrote:
> ARCH_KMALLOC_MINALIGN represents the minimum guaranteed kmalloc()
> alignment but an architecture may require a larger run-time alignment.
> Do not create kmalloc caches smaller than arch_kmalloc_minalign().
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  include/linux/slab.h |  2 ++
>  mm/slab.c            |  6 +-----
>  mm/slab.h            |  2 ++
>  mm/slab_common.c     | 33 +++++++++++++++++++++++----------
>  4 files changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index d58211bdeceb..2137dba85691 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -332,6 +332,8 @@ enum kmalloc_cache_type {
>  extern struct kmem_cache *
>  kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
>  
> +unsigned int arch_kmalloc_minalign(void);
> +
>  /*
>   * Define gfp bits that should not be set for KMALLOC_NORMAL.
>   */
> diff --git a/mm/slab.c b/mm/slab.c
> index b04e40078bdf..4aaeeb9c994d 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1256,11 +1256,7 @@ void __init kmem_cache_init(void)
>  	 * Initialize the caches that provide memory for the  kmem_cache_node
>  	 * structures first.  Without this, further allocations will bug.
>  	 */
> -	kmalloc_caches[KMALLOC_NORMAL][INDEX_NODE] = create_kmalloc_cache(
> -				kmalloc_info[INDEX_NODE].name[KMALLOC_NORMAL],
> -				kmalloc_info[INDEX_NODE].size,
> -				ARCH_KMALLOC_FLAGS, 0,
> -				kmalloc_info[INDEX_NODE].size);
> +	new_kmalloc_cache(INDEX_NODE, KMALLOC_NORMAL, ARCH_KMALLOC_FLAGS);
>  	slab_state = PARTIAL_NODE;
>  	setup_kmalloc_cache_index_table();
>  
> diff --git a/mm/slab.h b/mm/slab.h
> index fd7ae2024897..e9238406602a 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -283,6 +283,8 @@ int __kmem_cache_create(struct kmem_cache *, slab_flags_t flags);
>  struct kmem_cache *create_kmalloc_cache(const char *name, unsigned int size,
>  			slab_flags_t flags, unsigned int useroffset,
>  			unsigned int usersize);
> +void __init new_kmalloc_cache(int idx, enum kmalloc_cache_type type,
> +			      slab_flags_t flags);
>  extern void create_boot_cache(struct kmem_cache *, const char *name,
>  			unsigned int size, slab_flags_t flags,
>  			unsigned int useroffset, unsigned int usersize);
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 6ee64d6208b3..594d8a8a68d0 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -838,9 +838,18 @@ void __init setup_kmalloc_cache_index_table(void)
>  	}
>  }
>  
> -static void __init
> +unsigned int __weak arch_kmalloc_minalign(void)
> +{
> +	return ARCH_KMALLOC_MINALIGN;
> +}
> +

As ARCH_KMALLOC_ALIGN and arch_kmalloc_minalign() may not be same after
patch 10, I think s/ARCH_KMALLOC_ALIGN/arch_kmalloc_minalign/g
for every user of it would be more correct?

> +void __init
>  new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
>  {
> +	unsigned int minalign = arch_kmalloc_minalign();
> +	unsigned int aligned_size = kmalloc_info[idx].size;
> +	int aligned_idx = idx;
> +
>  	if (type == KMALLOC_RECLAIM) {
>  		flags |= SLAB_RECLAIM_ACCOUNT;
>  	} else if (IS_ENABLED(CONFIG_MEMCG_KMEM) && (type == KMALLOC_CGROUP)) {
> @@ -851,10 +860,17 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
>  		flags |= SLAB_ACCOUNT;
>  	}
>  
> -	kmalloc_caches[type][idx] = create_kmalloc_cache(
> -					kmalloc_info[idx].name[type],
> -					kmalloc_info[idx].size, flags, 0,
> -					kmalloc_info[idx].size);
> +	if (minalign > ARCH_KMALLOC_MINALIGN) {
> +		aligned_size = ALIGN(aligned_size, minalign);
> +		aligned_idx = __kmalloc_index(aligned_size, false);
> +	}
> +
> +	if (!kmalloc_caches[type][aligned_idx])
> +		kmalloc_caches[type][aligned_idx] = create_kmalloc_cache(
> +					kmalloc_info[aligned_idx].name[type],
> +					aligned_size, flags, 0, aligned_size);
> +	if (idx != aligned_idx)
> +		kmalloc_caches[type][idx] = kmalloc_caches[type][aligned_idx];

I would prefer detecting minimum kmalloc size in create_kmalloc_caches()
in runtime instead of changing behavior of new_kmalloc_cache().

>  	/*
>  	 * If CONFIG_MEMCG_KMEM is enabled, disable cache merging for
> @@ -904,11 +920,8 @@ void __init create_kmalloc_caches(slab_flags_t flags)
>  		struct kmem_cache *s = kmalloc_caches[KMALLOC_NORMAL][i];
>  
>  		if (s) {
> -			kmalloc_caches[KMALLOC_DMA][i] = create_kmalloc_cache(
> -				kmalloc_info[i].name[KMALLOC_DMA],
> -				kmalloc_info[i].size,
> -				SLAB_CACHE_DMA | flags, 0,
> -				kmalloc_info[i].size);
> +			new_kmalloc_cache(i, KMALLOC_DMA,
> +					  SLAB_CACHE_DMA | flags);
>  		}
>  	}
>  #endif

-- 
Thank you, You are awesome!
Hyeonggon :-)
