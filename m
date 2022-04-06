Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B014F5F46
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbiDFNJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiDFNJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:09:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D13D4DFABC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 02:42:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C37D161610
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 09:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CEFC385A9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 09:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649238130;
        bh=XzVxpBsHw3+lhhtvnfC+mj1Qwrhv5YqoiAyqzFtUD5c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EXCqvy/CnsUDmgpBZpBUyYOoMRigOSbEcWbSekemHlLuP/NeGZv3GnXF6zKtYN4T6
         j2ilPqi6ypmKfsqtq07//UBu6eXYdNc3iDQn9U89kspijrH5KZdJr26UiJvKxRrc0T
         R40M+6Sn4X6XlGahw6Dzkuh+aDEupMBSUFIUtV3lzbWDeO/vfMlQJ0qeDhjbIcPQhp
         pnlEUPykGf5vxGnLRIf/1HSusoMyTAVQvMyZ1MG1E0dc17JFtKr2ImJejx7HKAYYoT
         THYRZnThLw3bRzIbgKrJL/lmmAxxyGcpnTjCapuNNQZcLnOpDDr5pkD/oRf6yJi65e
         8u3T0W7mYlhBA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-e1dcc0a327so2341571fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 02:42:10 -0700 (PDT)
X-Gm-Message-State: AOAM531t5lSWZA0Q0Lx4L7JJM3s+r0TaxO/L3AR2Yu56xlXLmf0D1tUu
        /CZcTYkjTe1xonoXHXmG13UfXW1/hxs7RrIYVW4=
X-Google-Smtp-Source: ABdhPJwwHH5A0PBmv1nZ8cSGrgFifDCeI9KaFOyeonSom2CtrOcrp6GXsNRKDdTSY+arKNjYbJZc0uwe9QynX2Cqj+M=
X-Received: by 2002:a05:6870:b027:b0:de:7fcd:fabf with SMTP id
 y39-20020a056870b02700b000de7fcdfabfmr3489495oae.126.1649238129370; Wed, 06
 Apr 2022 02:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <20220405135758.774016-8-catalin.marinas@arm.com> <YkzJP6zmkAhc6CI9@gondor.apana.org.au>
 <CAMj1kXEXhFmGc4VTTcJU1YFsHJhZN44OdJ5Suf2ONG5=LR29HQ@mail.gmail.com> <Yk1UJs6eZMoIp3Eh@arm.com>
In-Reply-To: <Yk1UJs6eZMoIp3Eh@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 6 Apr 2022 11:41:58 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHGb1GY2AFUYrzn484wf5SJSbMNgNcdmh=MrRvONakuBQ@mail.gmail.com>
Message-ID: <CAMj1kXHGb1GY2AFUYrzn484wf5SJSbMNgNcdmh=MrRvONakuBQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Apr 2022 at 10:49, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Wed, Apr 06, 2022 at 08:53:33AM +0200, Ard Biesheuvel wrote:
> > On Wed, 6 Apr 2022 at 00:57, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > > On Tue, Apr 05, 2022 at 02:57:55PM +0100, Catalin Marinas wrote:
> > > > ARCH_DMA_MINALIGN represents the minimum (static) alignment for safe DMA
> > > > operations while ARCH_KMALLOC_MINALIGN is the minimum kmalloc() objects
> > > > alignment.
> > > >
> > > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > > > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > > > Cc: "David S. Miller" <davem@davemloft.net>
> > > > ---
> > > >  include/linux/crypto.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/linux/crypto.h b/include/linux/crypto.h
> > > > index 2324ab6f1846..654b9c355575 100644
> > > > --- a/include/linux/crypto.h
> > > > +++ b/include/linux/crypto.h
> > > > @@ -167,7 +167,7 @@
> > > >   * maintenance for non-coherent DMA (cache invalidation in particular) does not
> > > >   * affect data that may be accessed by the CPU concurrently.
> > > >   */
> > > > -#define CRYPTO_MINALIGN ARCH_KMALLOC_MINALIGN
> > > > +#define CRYPTO_MINALIGN ARCH_DMA_MINALIGN
> > >
> > > I think this should remain as ARCH_KMALLOC_MINALIGN with the
> > > comment above modified.  The reason is that we assume memory
> > > returned by kmalloc is already aligned to this value.
> > >
> > > Ard, you added the comment regarding the DMA requirement, so
> > > does anything actually rely on this? If they do, they now need
> > > to do their own alignment.
> >
> > This patch looks incorrect to me, as ARCH_DMA_MINALIGN is not
> > #define'd on all architectures.
>
> It is after the first patch:
>
> https://lore.kernel.org/all/20220405135758.774016-2-catalin.marinas@arm.com/
>

I wasn't cc'ed on that :-)

> The series makes both ARCH_*_MINALIGN available irrespective of what an
> arch defines. If one needs guaranteed static alignment for DMA, use the
> DMA macro. If the minimum kmalloc() alignment is needed (e.g. to store
> some flags in the lower pointer bits), use the KMALLOC macro. I grep'ed
> through drivers/ and I've seen both cases (e.g.
> drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c for the latter use-case).
>
> > But I am fine with the intent: ARCH_DMA_MINALIGN will be >=
> > ARCH_KMALLOC_MINALIGN, and so the compile time layout of structs will
> > take the worst cast minimum DMA alignment into account, whereas their
> > placement in memory when they allocated dynamically may be aligned to
> > ARCH_KMALLOC_MINALIGN only. Since the latter will be based on the
> > actual cache geometry, this should be fine.
>
> That's the idea.
>
> > Apart from the 'shash desc on stack' issue solved by the patch that
> > also introduced the above comment(660d2062190d), I've never looked
> > into the actual memory footprint of the crypto related data structures
> > resulting from this alignment, but it seems to me that /if/ this is
> > significant, we should be able to punt this to the drivers that
> > actually need this, rather than impose it for the whole system. (This
> > would involve over-allocating the context struct, and aligning up the
> > pointer in the various xxx_ctx() getters iff needed by the driver in
> > question)
>
> Since ARCH_KMALLOC_MINALIGN on arm64 prior to this series is 128, there
> is any change to the crypto code.
>

No, not currently. But what I started looking into today is avoiding
the need to impose DMA alignment on every single data structure
allocated by the crypto API, even if it is never used for DMA or
touched by a device. That seems rather wasteful as well.
