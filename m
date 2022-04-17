Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A6250473D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 10:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiDQIiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 04:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiDQIiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 04:38:50 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E2763F5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 01:36:16 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1ng0Nx-003jSQ-Oq; Sun, 17 Apr 2022 18:35:59 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sun, 17 Apr 2022 16:35:58 +0800
Date:   Sun, 17 Apr 2022 16:35:58 +0800
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
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <YlvRbvWSWMTtBJiN@gondor.apana.org.au>
References: <YlkkGpVx8rhcsBot@gondor.apana.org.au>
 <CAMj1kXH0x5Va7Wgs+mU1ONDwwsazOBuN4z4ihVzO2uG-n41Kbg@mail.gmail.com>
 <Ylko07++4naWJ5LE@gondor.apana.org.au>
 <CAMj1kXH=ybJWBzmMqkrkvyF8nM3UpTchUOq+oweW=BqW2TOyRw@mail.gmail.com>
 <YllE+wWqP6F+1nwa@gondor.apana.org.au>
 <CAMj1kXFjLbtpJLFh-C_k3Ydcg4M7NqrCfOXnBY2iSxusWtBLbA@mail.gmail.com>
 <YllM24eca/uxf9y7@gondor.apana.org.au>
 <CAMj1kXH5O32H1nnm6y7=3KiH7R-_oakxzBpZ20wK+8kaD46aKw@mail.gmail.com>
 <YlvK9iefUECy361O@gondor.apana.org.au>
 <YlvQTci7RP5evtTy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlvQTci7RP5evtTy@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2022 at 09:31:09AM +0100, Catalin Marinas wrote:
>
> Not with my series, the non-sharing of cache lines is preserved.
> kmalloc() still returns objects aligned to a cache-line.
> ARCH_DMA_MINALIGN was chosen as the cover-all value for all SoCs
> supported but I want to reduce the kmalloc() alignment to a cache line
> size if a platform has a cache line smaller than ARCH_DMA_MINALIGN (most
> arm64 SoCs have a cache line of 64 bytes rather than 128).

OK, but then you don't need to play with CRYPTO_MINALIGN at all,
right? All you need to do is add the padding between the Crypto
API fields and the context structure, right?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
