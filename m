Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203A94F75CB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 08:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240944AbiDGGQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 02:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbiDGGQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:16:26 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64C11E4607
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 23:14:26 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so7963954pjn.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 23:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9N4jsdU05tKreDLVah25wg1i7nENvALZm4gukKaaig8=;
        b=5jJ9+CMbyb2iFD+qTV2tJtsDc/mOXZoAPjNuA5DLCisob818XbBaJxr3vFKSt1fNga
         QlKnt06xJWIstN/aGRxyIc8svaetKNtRKTL6gLA0c5Fp38Slz9CGVySEoc6s9zMZnBw9
         Kd/3ynto8sG7mDU53YCTDV9lRMrO1EOl3Cx8nFvgpR03RWiPh6bb/Wf4CL5HPnbYSKzZ
         EYl9Cwo49fFCyCJBH/BXXneuEb+lAov/CRSdRhfQw8VxwCE1foKBVDR7M9LKqNB1dFz5
         E6C4GgkfLUUl8CsuNnrWKRGJVkTqGPju9eTnWBw+XmVskOHJaNgv2pI+19SjxA9wYmDV
         cI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9N4jsdU05tKreDLVah25wg1i7nENvALZm4gukKaaig8=;
        b=mDUE9NYKlam/dweZukMrKCOGjEcUsI5GP/iIYqPkN0lSyEbsCzMznk5iwA0K3zCtbp
         JY2G7vImYBBHMnKwsiQh+iWMojM4HAJ0kIfuqgQxem/nPUMYQIWSWJBwcMTJ37Pb4DgD
         sdcFtYuI9vs8Cohi3DB7QOWG4dxRGa7HPtDOkZHMgSgbZ14FR1zKRpUWKi4X2Lwa4owV
         y4qULZ+SQ7cAUP7X1RlN2BZbiH/HiOmbv+ePK0oatmp+afmUXfTpAln25srGZe/YZdpT
         QVPGbuFF4IegMGE7pYCXSKiW6PNGu4L/zoZSKQY/2RnFIje9MkaiLwPQMmOesmxwAl4j
         C5eQ==
X-Gm-Message-State: AOAM531Ru/og8fbYvQizWDuB/xak76qAsRp75He15Cg/KZxFMj2TwRf/
        eJdMhohbENukinWwL0OqZgv4ZQ==
X-Google-Smtp-Source: ABdhPJwqwrt3yylNOY5TwewC48e923ECRFAFR//J3YtxR4O8b0X+RI5+jDZD3P9hg1TOKqajaMU5MQ==
X-Received: by 2002:a17:90b:1a85:b0:1c9:d81b:33f1 with SMTP id ng5-20020a17090b1a8500b001c9d81b33f1mr14014349pjb.212.1649312066234;
        Wed, 06 Apr 2022 23:14:26 -0700 (PDT)
Received: from localhost ([121.30.179.114])
        by smtp.gmail.com with ESMTPSA id nn7-20020a17090b38c700b001c9ba103530sm7555309pjb.48.2022.04.06.23.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 23:14:25 -0700 (PDT)
Date:   Thu, 7 Apr 2022 14:14:15 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <Yk5/FpCR10sndTR1@n131-248-037.byted.org>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <20220405135758.774016-8-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405135758.774016-8-catalin.marinas@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 02:57:55PM +0100, Catalin Marinas wrote:
> ARCH_DMA_MINALIGN represents the minimum (static) alignment for safe DMA
> operations while ARCH_KMALLOC_MINALIGN is the minimum kmalloc() objects
> alignment.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> ---
>  include/linux/crypto.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/crypto.h b/include/linux/crypto.h
> index 2324ab6f1846..654b9c355575 100644
> --- a/include/linux/crypto.h
> +++ b/include/linux/crypto.h
> @@ -167,7 +167,7 @@
>   * maintenance for non-coherent DMA (cache invalidation in particular) does not
>   * affect data that may be accessed by the CPU concurrently.
>   */
> -#define CRYPTO_MINALIGN ARCH_KMALLOC_MINALIGN
> +#define CRYPTO_MINALIGN ARCH_DMA_MINALIGN
>

I don't think this should be changed since ARCH_KMALLOC_MINALIGN is
already aligned with the size what you need.

Thanks.

