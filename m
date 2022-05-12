Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95B75243C2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 05:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345322AbiELD5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 23:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345368AbiELD5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 23:57:36 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE11D26544;
        Wed, 11 May 2022 20:57:32 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1nozwj-00CmlI-4v; Thu, 12 May 2022 13:57:02 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 12 May 2022 11:57:01 +0800
Date:   Thu, 12 May 2022 11:57:01 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Message-ID: <YnyFjSrK2DMysrCY@gondor.apana.org.au>
References: <YnpGnsr4k7yVUR54@gondor.apana.org.au>
 <E1noNhu-00BzV4-4N@fornost.hmeau.com>
 <Ynqciq2p8mtTg98n@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ynqciq2p8mtTg98n@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 06:10:34PM +0100, Catalin Marinas wrote:
>
> Is there a case where a driver needs the minimum alignment between
> ARCH_DMA_MINALIGN and crypto_tfm_alg_alignmask()+1? Maybe for platforms
> where ARCH_DMA_MINALIGN is 8 (fully coherent) but the device's bus
> master alignment requirements are higher.

Yes, for example on x86 aesni requires 16-byte alignment.

> My plan is to have ARCH_DMA_MINALIGN always defined but potentially
> higher than ARCH_KMALLOC_MINALIGN on specific architectures. I think
> crypto_tfm_ctx_dma() should use ARCH_KMALLOC_MINALIGN (and no #ifdefs)
> until I get my patches sorted and I'll replace it with ARCH_DMA_MINALIGN
> once it's defined globally (still no #ifdefs). Currently in mainline
> it's ARCH_KMALLOC_MINALIGN that gives the static DMA alignment.
> 
> With the explicit crypto_tfm_ctx_dma(), can CRYPTO_MINALIGN_ATTR be
> dropped entirely? This may be beneficial in reducing the structure size
> when no DMA is required.

We always need CRYPTO_MINALIGN to reflect what alignment kmalloc
guarantees.  It is used to minimise the amount of extra padding
for users such aesni.

This shouldn't have any impact on your plans though as once the
drivers in question switch over to the DMA helpers you can safely
lower ARCH_KMALLOC_MINALIGN.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
