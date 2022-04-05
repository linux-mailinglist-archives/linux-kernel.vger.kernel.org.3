Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D914F5283
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1850680AbiDFCy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449305AbiDFAyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 20:54:11 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C6919E3AB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 15:57:28 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1nbs6h-000qES-8W; Wed, 06 Apr 2022 08:57:04 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 06 Apr 2022 08:57:03 +1000
Date:   Wed, 6 Apr 2022 08:57:03 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <YkzJP6zmkAhc6CI9@gondor.apana.org.au>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <20220405135758.774016-8-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405135758.774016-8-catalin.marinas@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

I think this should remain as ARCH_KMALLOC_MINALIGN with the
comment above modified.  The reason is that we assume memory
returned by kmalloc is already aligned to this value.

Ard, you added the comment regarding the DMA requirement, so
does anything actually rely on this? If they do, they now need
to do their own alignment.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
