Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AEF4FBB66
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244768AbiDKL6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345938AbiDKL5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:57:40 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602779FD7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:55:26 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a42so7838644pfx.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=82gVUh8gnKeXybAiTt57HzFnopNYccmXtzF9SfZ4Vxg=;
        b=MrbutK91B5gE1Lfe9f2oXE7IIQUY5qagvW7J73BSGymYOO7Rt0fBNmu6yh61B256yS
         pO3JkbJQ+PPl5OeFjSe12cdjFDlSNGmdb0NiNONW/J7x+7Tthuv5xOp4RUKCb+RSJqGT
         Ama7KyneWdWiaItYGwp9R9AgfIcN780Zzlo42x2W39bCbCO7liJIc+p/iwNvh7FUNwl4
         2NnNYvE+3KbsCFxkscBrtvSrvNUfhtkJ6tCZVmsiAEylRtG2DpclBP+By5iizYZl6e9H
         3o1iP4DGtd9dJuUtLKjpbCy78rzAb97kwm/KVb3zTyMUdlgKg7hZPilV7y71BlPl4wi4
         y8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=82gVUh8gnKeXybAiTt57HzFnopNYccmXtzF9SfZ4Vxg=;
        b=qZhODYczSqxzUEHuwFufAjBLrGy6PzKsDh6yxiRyiuao6zb2KK7yHWGA7bH5TC7zPd
         uPTd84kIKRFIYNlLxA+XIKIzOiH94CaRLnWkAIIZRq3qNhgvg32eV7m//ZYiexIc0XKB
         4C5YM6rNjAGvAMcScXNmADyOJbDTFRXryesIdX2gsfQ4PfFfWTS7ilpITmlrIUiKZ8O+
         TAjQSu5zo7TFSz4c32+5zHj0o3SjolWMSdEuXxOSxZSjiLulKu672XCQnEi+pu2/alzZ
         YR0f51MgZrk9dZc56/HuOweu7jfl/T83M4dp8olbAH+byrYv28LxzYo8rkBojn7CZADs
         S/qQ==
X-Gm-Message-State: AOAM530hJsrAEfpZqHYAvBD5LhpUn1bk+rtU7mXkt2pEf1RrEpTzkFIn
        mr+IybTAEp3vHt7gjUQPeBg=
X-Google-Smtp-Source: ABdhPJwbA2NlCPpqgcpUwFItnl5yCrSHk1NE6ceLzNf+8T/LbYgi3GwzQRX8CrI5CdowF2UV6c9r9g==
X-Received: by 2002:a63:d1e:0:b0:399:8cc:e86f with SMTP id c30-20020a630d1e000000b0039908cce86fmr25416528pgl.230.1649678125882;
        Mon, 11 Apr 2022 04:55:25 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id x124-20020a627c82000000b00505aece5638sm5300482pfc.130.2022.04.11.04.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 04:55:24 -0700 (PDT)
Date:   Mon, 11 Apr 2022 20:55:18 +0900
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
Message-ID: <YlQXJoQc3kDbbE6j@hyeyoo>
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
>  
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

Looks good to me.

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

And works fine with SLAB/SLUB/SLOB on my arm64 machine.

Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

-- 
Thanks,
Hyeonggon
