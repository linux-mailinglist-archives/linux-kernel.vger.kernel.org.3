Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB084F5CB6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiDFLuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiDFLuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:50:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEABC5AB658
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:49:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48EF261380
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C3EC385A3;
        Wed,  6 Apr 2022 08:49:46 +0000 (UTC)
Date:   Wed, 6 Apr 2022 09:49:42 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <Yk1UJs6eZMoIp3Eh@arm.com>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <20220405135758.774016-8-catalin.marinas@arm.com>
 <YkzJP6zmkAhc6CI9@gondor.apana.org.au>
 <CAMj1kXEXhFmGc4VTTcJU1YFsHJhZN44OdJ5Suf2ONG5=LR29HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEXhFmGc4VTTcJU1YFsHJhZN44OdJ5Suf2ONG5=LR29HQ@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 08:53:33AM +0200, Ard Biesheuvel wrote:
> On Wed, 6 Apr 2022 at 00:57, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > On Tue, Apr 05, 2022 at 02:57:55PM +0100, Catalin Marinas wrote:
> > > ARCH_DMA_MINALIGN represents the minimum (static) alignment for safe DMA
> > > operations while ARCH_KMALLOC_MINALIGN is the minimum kmalloc() objects
> > > alignment.
> > >
> > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > > Cc: "David S. Miller" <davem@davemloft.net>
> > > ---
> > >  include/linux/crypto.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/crypto.h b/include/linux/crypto.h
> > > index 2324ab6f1846..654b9c355575 100644
> > > --- a/include/linux/crypto.h
> > > +++ b/include/linux/crypto.h
> > > @@ -167,7 +167,7 @@
> > >   * maintenance for non-coherent DMA (cache invalidation in particular) does not
> > >   * affect data that may be accessed by the CPU concurrently.
> > >   */
> > > -#define CRYPTO_MINALIGN ARCH_KMALLOC_MINALIGN
> > > +#define CRYPTO_MINALIGN ARCH_DMA_MINALIGN
> >
> > I think this should remain as ARCH_KMALLOC_MINALIGN with the
> > comment above modified.  The reason is that we assume memory
> > returned by kmalloc is already aligned to this value.
> >
> > Ard, you added the comment regarding the DMA requirement, so
> > does anything actually rely on this? If they do, they now need
> > to do their own alignment.
> 
> This patch looks incorrect to me, as ARCH_DMA_MINALIGN is not
> #define'd on all architectures.

It is after the first patch:

https://lore.kernel.org/all/20220405135758.774016-2-catalin.marinas@arm.com/

The series makes both ARCH_*_MINALIGN available irrespective of what an
arch defines. If one needs guaranteed static alignment for DMA, use the
DMA macro. If the minimum kmalloc() alignment is needed (e.g. to store
some flags in the lower pointer bits), use the KMALLOC macro. I grep'ed
through drivers/ and I've seen both cases (e.g.
drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c for the latter use-case).

> But I am fine with the intent: ARCH_DMA_MINALIGN will be >=
> ARCH_KMALLOC_MINALIGN, and so the compile time layout of structs will
> take the worst cast minimum DMA alignment into account, whereas their
> placement in memory when they allocated dynamically may be aligned to
> ARCH_KMALLOC_MINALIGN only. Since the latter will be based on the
> actual cache geometry, this should be fine.

That's the idea.

> Apart from the 'shash desc on stack' issue solved by the patch that
> also introduced the above comment(660d2062190d), I've never looked
> into the actual memory footprint of the crypto related data structures
> resulting from this alignment, but it seems to me that /if/ this is
> significant, we should be able to punt this to the drivers that
> actually need this, rather than impose it for the whole system. (This
> would involve over-allocating the context struct, and aligning up the
> pointer in the various xxx_ctx() getters iff needed by the driver in
> question)

Since ARCH_KMALLOC_MINALIGN on arm64 prior to this series is 128, there
is any change to the crypto code.

-- 
Catalin
