Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4350B50484F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 18:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiDQQbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 12:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbiDQQbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 12:31:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062422ED40
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 09:29:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 823106123F
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 16:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B4EC385A4;
        Sun, 17 Apr 2022 16:29:05 +0000 (UTC)
Date:   Sun, 17 Apr 2022 17:29:01 +0100
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
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <YlxATW56ZoNtmxlk@arm.com>
References: <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com>
 <YlkV7NtatO7KFusX@gondor.apana.org.au>
 <CAMj1kXFW_zC-U5Ox9_=4gKCwWOmkR7wPNb6UQhiz8viNWTRU-w@mail.gmail.com>
 <YlkkGpVx8rhcsBot@gondor.apana.org.au>
 <YllALIgZcQJ6asdA@arm.com>
 <YlllpH+PB8XVUn6h@arm.com>
 <YlvLqkIdrCp/rOsG@gondor.apana.org.au>
 <YlvSEHul1Rv3Ap34@arm.com>
 <YlvTNQGh+MfZFWKW@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlvTNQGh+MfZFWKW@gondor.apana.org.au>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2022 at 04:43:33PM +0800, Herbert Xu wrote:
> On Sun, Apr 17, 2022 at 09:38:40AM +0100, Catalin Marinas wrote:
> > I don't think we need to do anything here. A structure like:
> > 
> > struct x {
> > 	char y;
> > 	char z[] CRYPTO_MINALIGN_ATTR;
> > };
> > 
> > is already of size 128. Without CRYPTO_MINALIGN_ATTR, its size would be
> > 1 but otherwise the whole structure inherits the alignment of its
> > member and this translates into an aligned size.
> 
> No we should not lie to the compiler,

We won't if we ensure that a structure with sizeof() >= 128 is aligned
to 128.

> we have code elsewhere
> that uses the alignment to compute the amount of extra padding
> needed to create greater padding.  If CRYPTO_MINALIGN is misleading
> then that calculation will fall apart.

There is no direct CRYPTO_MINALIGN use for any extra padding AFAICT.
There is an indirect use via __alignof__(ctx) like in
crypto_tfm_ctx_alignment() but IIUC in that case CRYPTO_MINALIGN is a
statement of what you want rather than what you get from kmalloc(). So
if you want 128 alignment of tfm->__crt_ctx, you should say so by either
changing the attribute to __aligned(ARCH_DMA_MINALIGN) or keeping
CRYPTO_MINALIGN as 128.

There is the union padding that Ard suggested but I don't think it buys
us much, the __aligned(ARCH_DMA_MINALIGN) gives you the padding and the
kmalloc() rules the alignment (subject to removing kmalloc-192). The
code that allocates these would need to place the structure aligned
anyway, irrespective of whether we use the padding or the
__aligned(ARCH_DMA_MINALIGN).

> So keep CRYPTO_MINALIGN at whatever alignment you lower kmalloc
> to, and then add the padding you need to separate the Crypto API
> bits from the context.  In fact, that is exactly what cra_alignmask
> is supposed to do.

I disagree on the cra_alignmask intention here, though I may be wrong as
I did not write the code. Yes, you could make it ARCH_DMA_MINALIGN
everywhere but IMHO that's not what it is supposed to do. The driver
only knows about the bus master alignment requirements (typically
smaller than a cache line) while the architecture-defined
ARCH_DMA_MINALIGN cares about the non-coherent DMA requirements.

> Sure we currently limit the maximum alignment to 64 bytes because
> of stack usage but we can certainly look into increasing it as
> that's what you're doing here anyway.

I'm not actually increasing CRYPTO_MINALIGN, just trying to keep it as
the current value of 128 for arm64.

-- 
Catalin
