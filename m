Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49614FB9D5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241109AbiDKKj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbiDKKjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:39:23 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7598A43ECD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:37:10 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id 12so1676869pll.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sZ5r1Ulc6PwR+ueUKNqo2D8Zab24hQBuwaMfaw8Ofy0=;
        b=fc64tTXnjyhGNHfV0GQvoJYJRlkNoJju8a2bH+jOoLii9ffVQ8PzR/409RWEPd58II
         Ek2BaGkvbWWG3Dw/wkeS1D05l/BsPuJEzMzoSbPc8SJO7Aw883hKMKBzKisAlyJnTEzs
         UiG2jiyOxLVxmq+27F/+elTgNuy1YVxDl/EM8uAaMoMMhffcgfzUqnd4qFDkG0FXJcOm
         O2E7nImZ1DyCt9tIzxYaihygWUNomywo32J1THuGi+d5Oer13kkHMeVg2We6ou4FibWO
         yDmDW0KXvOduGY5DOEkV9WbHK55bBl6zTbAPFmZhQ1xEkKMRXjiT+oxWX6ckWIjAG+sr
         dAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sZ5r1Ulc6PwR+ueUKNqo2D8Zab24hQBuwaMfaw8Ofy0=;
        b=X2UCLf0ogcPp/6vWLJIr9UYEBMlxjINIGOha4Tq2kcBScjKdD16xoUwZKUlw0LtArh
         regxaK7ndEIszkXYULUEUqCzW7JgJJPwycITyGtR/Edk/QY369yEB7SkTON8PO6HQLH0
         sBb16uPQPu0UmUn8Xf3qdAAaepkCnrMGzsRGsEtEJ9ML0wJXhpbI6hGVwByjRaxN/Jir
         k/yy8HK8eTVEoZBEekbBcE9/PNN3zKG0etUdZRkwyoXD4P9rA2gC/eYWl0TN7FGVLdnH
         4lUILLyiCzmJc65TMUlm39CgtcgQvXopDFjVfTE4UiEVhdNyhpellU2BLWCGe6ru2Smb
         HM6Q==
X-Gm-Message-State: AOAM531FKbI+C2O/m5K7h970cn012xueXXZrcHV0G6zgwOVFh4nabT83
        NS1Lz+8xgpR1ZtwGpBX1Qfw=
X-Google-Smtp-Source: ABdhPJzqE7fdczyeXzyQeDjOMudzBySH+60ePuOE2mP9NT+DcGJhwjaFeRriNyLNylES+uJmxSfCIw==
X-Received: by 2002:a17:902:bd89:b0:156:8467:782b with SMTP id q9-20020a170902bd8900b001568467782bmr31684434pls.12.1649673429936;
        Mon, 11 Apr 2022 03:37:09 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id x39-20020a056a0018a700b004fa7e6ceafesm35865007pfh.169.2022.04.11.03.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:37:08 -0700 (PDT)
Date:   Mon, 11 Apr 2022 19:37:01 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] mm/slab: Decouple ARCH_KMALLOC_MINALIGN from
 ARCH_DMA_MINALIGN
Message-ID: <YlQEzdOtoNwDHhDi@hyeyoo>
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

Sorry for the noise I made due to misunderstanding :)
Now this patch looks good to me and I think it's worth adding.

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

and works fine with SLAB/SLOB/SLUB on my arm64 machine.

Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

-- 
Thanks,
Hyeonggon
