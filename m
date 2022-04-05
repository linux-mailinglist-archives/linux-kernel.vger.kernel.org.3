Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D94F4F535A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 06:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443529AbiDFDeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 23:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446436AbiDFDEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 23:04:53 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A584C403DF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:59:28 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id s2so942110pfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 16:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+pKWlLT8OBUODk8YNvFLSMhBfA/iojejnVtSVsASRAk=;
        b=YXBL1QT1SI7i+Bh2c/Dc8P9v+q9zH8NYCPf0bo/FnxGd06vvrjm+O0FsoJBk0fLEbN
         TaQbFXB8NNZ5nHIWMYME2kE1OjLFWBJxGzKfqq81r6V+XTnnibuYyxUjQDDC1SvWvxZh
         ZmGZTT02QcLWDCHdVr7gAerq/tjYtPmAx7wIvPAAVsLt56zt8AXu8yuNmg1JanvGP+x9
         vpdZfL07mSEahEQOb/pPxEelhv2k4QH8DOCgTRmA8ssHD5rbeiGZ7EDjvLzqiSTf81Z9
         c1S5njgI/BUvyLBAbpVZNDPhZH69GLSVdZ+WHHdLvA57R4MqqDkvpKVvRvDnzLutqjII
         7cqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+pKWlLT8OBUODk8YNvFLSMhBfA/iojejnVtSVsASRAk=;
        b=hDvmEXB9XTv4f1+o8ZIm+SpIQFSBvA5C8J3o83e+igOQ0KynfDVeEPFnSE64w8z5xj
         cAJ643i3yKUThehAI3n5yev9f5J//X4O480AZEnJlBichcI+bdtSGvdsXULzhoRjOUI4
         1JwAygYJLs0JF7n4Q6gUnqpk84tVQIuG5xAyC30I9SmZgSMhAgevK7ZF/ro5ULqQMFJ3
         fatgdiHz5luLfCMfgI+ptxPRctle2WbSyzOEHBGrFpNZbkxJ5PJTwAP6F7kUoLCbwC95
         MMRAVX0ptn4iiFC5zhTpGPPVRZhqLWv0+YBY9nyFsjOjyOD6Q5Gnz/MbouelrwTGIc1Z
         QhuQ==
X-Gm-Message-State: AOAM532xkeuF8rPmjm7UEZMZy4UZQamBrE/4JMSd9royTZlXVJzMatKP
        tCzD3WaSBgMGWVBOMRsVa8E=
X-Google-Smtp-Source: ABdhPJwr8lCDx3qo0NcIt/6xVkEHW9WW1AsHFqpf8jte3twaF6gnt2JTp/x1cETmV5k6VXwhRd9jwQ==
X-Received: by 2002:a05:6a00:130e:b0:4cc:3c7d:4dec with SMTP id j14-20020a056a00130e00b004cc3c7d4decmr6050466pfu.32.1649203168112;
        Tue, 05 Apr 2022 16:59:28 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id s135-20020a63778d000000b0038259e54389sm13949197pgc.19.2022.04.05.16.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 16:59:27 -0700 (PDT)
Date:   Wed, 6 Apr 2022 08:59:18 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, cl@linux.com, vbabka@suse.cz,
        iamjoonsoo.kim@lge.com, rientjes@google.com, penberg@kernel.org,
        roman.gushchin@linux.dev
Subject: Re: [PATCH 01/10] mm/slab: Decouple ARCH_KMALLOC_MINALIGN from
 ARCH_DMA_MINALIGN
Message-ID: <YkzX1nM0Ca7apVBt@hyeyoo>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <20220405135758.774016-2-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405135758.774016-2-catalin.marinas@arm.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 02:57:49PM +0100, Catalin Marinas wrote:
> In preparation for supporting a dynamic kmalloc() minimum alignment,
> allow architectures to define ARCH_KMALLOC_MINALIGN independently of
> ARCH_DMA_MINALIGN. In addition, always define ARCH_DMA_MINALIGN even if
> an architecture does not override it.
>

[ +Cc slab maintainer/reviewers ]

I get why you want to set minimum alignment of kmalloc() dynamically.
That's because cache line size can be different and we cannot statically
know that, right?

But I don't get why you are trying to decouple ARCH_KMALLOC_MINALIGN
from ARCH_DMA_MINALIGN. kmalloc'ed buffer is always supposed to be DMA-safe.

I'm afraid this series may break some archs/drivers.

in Documentation/dma-api-howto.rst:
> 2) ARCH_DMA_MINALIGN
> 
>   Architectures must ensure that kmalloc'ed buffer is
>   DMA-safe. Drivers and subsystems depend on it. If an architecture
>   isn't fully DMA-coherent (i.e. hardware doesn't ensure that data in
>   the CPU cache is identical to data in main memory),
>   ARCH_DMA_MINALIGN must be set so that the memory allocator
>   makes sure that kmalloc'ed buffer doesn't share a cache line with
>   the others. See arch/arm/include/asm/cache.h as an example.
>
>   Note that ARCH_DMA_MINALIGN is about DMA memory alignment
>   constraints. You don't need to worry about the architecture data
>   alignment constraints (e.g. the alignment constraints about 64-bit
>   objects).

If I'm missing something, please let me know :)

Thanks,
Hyeonggon

> After this patch, ARCH_DMA_MINALIGN is expected to be used in static
> alignment annotations and defined by an architecture to be the maximum
> alignment for all supported configurations/SoCs in a single Image.
> ARCH_KMALLOC_MINALIGN, if different, is the minimum alignment guaranteed
> by kmalloc().
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  include/linux/slab.h | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 373b3ef99f4e..d58211bdeceb 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -187,17 +187,30 @@ bool kmem_valid_obj(void *object);
>  void kmem_dump_obj(void *object);
>  #endif
>  
> +/*
> + * slob does not support independent control of ARCH_KMALLOC_MINALIGN and
> + * ARCH_DMA_MINALIGN.
> + */
> +#ifdef CONFIG_SLOB
> +#undef ARCH_KMALLOC_MINALIGN
> +#endif
> +
>  /*
>   * Some archs want to perform DMA into kmalloc caches and need a guaranteed
>   * alignment larger than the alignment of a 64-bit integer.
> - * Setting ARCH_KMALLOC_MINALIGN in arch headers allows that.
> + * Setting ARCH_DMA_MINALIGN in arch headers allows that.
>   */
> -#if defined(ARCH_DMA_MINALIGN) && ARCH_DMA_MINALIGN > 8
> +#ifndef ARCH_DMA_MINALIGN
> +#define ARCH_DMA_MINALIGN __alignof__(unsigned long long)
> +#elif ARCH_DMA_MINALIGN > 8 && !defined(ARCH_KMALLOC_MINALIGN)
>  #define ARCH_KMALLOC_MINALIGN ARCH_DMA_MINALIGN
> -#define KMALLOC_MIN_SIZE ARCH_DMA_MINALIGN
> -#define KMALLOC_SHIFT_LOW ilog2(ARCH_DMA_MINALIGN)
> -#else
> +#endif
> +
> +#ifndef ARCH_KMALLOC_MINALIGN
>  #define ARCH_KMALLOC_MINALIGN __alignof__(unsigned long long)
> +#else
> +#define KMALLOC_MIN_SIZE ARCH_KMALLOC_MINALIGN
> +#define KMALLOC_SHIFT_LOW ilog2(KMALLOC_MIN_SIZE)
>  #endif
>  
>  /*
> 
