Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D33522205
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347806AbiEJROp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347787AbiEJROl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:14:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D378BC12;
        Tue, 10 May 2022 10:10:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 948B9B81D2E;
        Tue, 10 May 2022 17:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6860C385A6;
        Tue, 10 May 2022 17:10:37 +0000 (UTC)
Date:   Tue, 10 May 2022 18:10:34 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [RFC PATCH 2/7] crypto: api - Add crypto_tfm_ctx_dma
Message-ID: <Ynqciq2p8mtTg98n@arm.com>
References: <YnpGnsr4k7yVUR54@gondor.apana.org.au>
 <E1noNhu-00BzV4-4N@fornost.hmeau.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1noNhu-00BzV4-4N@fornost.hmeau.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

Thanks for putting this together.

On Tue, May 10, 2022 at 07:07:10PM +0800, Herbert Xu wrote:
> diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
> index f50c5d1725da5..cdf12e51c53a0 100644
> --- a/include/crypto/algapi.h
> +++ b/include/crypto/algapi.h
> @@ -189,10 +189,34 @@ static inline void crypto_xor_cpy(u8 *dst, const u8 *src1, const u8 *src2,
>  	}
>  }
>  
> +static inline void *crypto_tfm_ctx(struct crypto_tfm *tfm)
> +{
> +	return tfm->__crt_ctx;
> +}
> +
> +static inline void *crypto_tfm_ctx_align(struct crypto_tfm *tfm,
> +					 unsigned int align)
> +{
> +	if (align <= crypto_tfm_ctx_alignment())
> +		align = 1;
> +
> +	return PTR_ALIGN(crypto_tfm_ctx(tfm), align);
> +}
> +
>  static inline void *crypto_tfm_ctx_aligned(struct crypto_tfm *tfm)
>  {
> -	return PTR_ALIGN(crypto_tfm_ctx(tfm),
> -			 crypto_tfm_alg_alignmask(tfm) + 1);
> +	return crypto_tfm_ctx_align(tfm, crypto_tfm_alg_alignmask(tfm) + 1);
> +}
> +
> +static inline void *crypto_tfm_ctx_dma(struct crypto_tfm *tfm)
> +{
> +	unsigned int align = 1;
> +
> +#ifdef ARCH_DMA_MINALIGN
> +	align = ARCH_DMA_MINALIGN;
> +#endif
> +
> +	return crypto_tfm_ctx_align(tfm, align);
>  }

Is there a case where a driver needs the minimum alignment between
ARCH_DMA_MINALIGN and crypto_tfm_alg_alignmask()+1? Maybe for platforms
where ARCH_DMA_MINALIGN is 8 (fully coherent) but the device's bus
master alignment requirements are higher.

My plan is to have ARCH_DMA_MINALIGN always defined but potentially
higher than ARCH_KMALLOC_MINALIGN on specific architectures. I think
crypto_tfm_ctx_dma() should use ARCH_KMALLOC_MINALIGN (and no #ifdefs)
until I get my patches sorted and I'll replace it with ARCH_DMA_MINALIGN
once it's defined globally (still no #ifdefs). Currently in mainline
it's ARCH_KMALLOC_MINALIGN that gives the static DMA alignment.

With the explicit crypto_tfm_ctx_dma(), can CRYPTO_MINALIGN_ATTR be
dropped entirely? This may be beneficial in reducing the structure size
when no DMA is required.

-- 
Catalin
