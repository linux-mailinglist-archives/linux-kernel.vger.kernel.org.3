Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66AA4F5B0F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345455AbiDFKax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 06:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382591AbiDFK34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 06:29:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9780B3DF34A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 23:53:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 443EEB82104
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 06:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034B5C385AA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 06:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649228026;
        bh=tO8JMyLzIZ8EITkhp2PubbOl10W7/jlZTi8jH9cyTLA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k0dPNLOFXD0NO7pwwnpOcM17yCmaDTXu/JTYP0X6yByGl0JOQucrjAtJzkKILFDgt
         DSTQSo8yPhjvPvBmNbyel6rRrt4/15PnMN2lQziq+CZsz+70pBbIMzzgV+x68fasH+
         4kdp54NwrvPrw4kBJvX/ZZd5D/AHZ8ZYujG4Q50Rytum/nCOH6J4D19SSUqnLyq444
         YfdmhdsqppJBjydZK5tzib2BZGfDrLMND8tWRVc9Us67lKdqeXFuCfY8+CV8AvO3Ll
         WevPFimEj1/yXJ0a5UbDE/hDXuJAFcXSo0VdeqeNdudgysy1K5L8cmk8egw2FN9s4x
         /UryyMD+J4sxA==
Received: by mail-ot1-f49.google.com with SMTP id i11-20020a9d4a8b000000b005cda3b9754aso1124875otf.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 23:53:45 -0700 (PDT)
X-Gm-Message-State: AOAM530CPeRsdj3/mAcKPM0g5lLTlvWl6FvUTzSjqsNu6vrAT4rFAbvz
        la2jJwomShCMy8cv4xUu1HRfzvNhG7QKgQ1GwTA=
X-Google-Smtp-Source: ABdhPJwt+MqYoXIE9XnpjhA1n4uGXTgDOGNThyoHryIuaDZN64VMoEbM5En07e+MLJhoR+DsVsRXvaQFlGgRZfSRASs=
X-Received: by 2002:a05:6830:1e9c:b0:5cd:8c15:5799 with SMTP id
 n28-20020a0568301e9c00b005cd8c155799mr2506585otr.265.1649228025072; Tue, 05
 Apr 2022 23:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <20220405135758.774016-8-catalin.marinas@arm.com> <YkzJP6zmkAhc6CI9@gondor.apana.org.au>
In-Reply-To: <YkzJP6zmkAhc6CI9@gondor.apana.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 6 Apr 2022 08:53:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEXhFmGc4VTTcJU1YFsHJhZN44OdJ5Suf2ONG5=LR29HQ@mail.gmail.com>
Message-ID: <CAMj1kXEXhFmGc4VTTcJU1YFsHJhZN44OdJ5Suf2ONG5=LR29HQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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

On Wed, 6 Apr 2022 at 00:57, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Tue, Apr 05, 2022 at 02:57:55PM +0100, Catalin Marinas wrote:
> > ARCH_DMA_MINALIGN represents the minimum (static) alignment for safe DMA
> > operations while ARCH_KMALLOC_MINALIGN is the minimum kmalloc() objects
> > alignment.
> >
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > ---
> >  include/linux/crypto.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/crypto.h b/include/linux/crypto.h
> > index 2324ab6f1846..654b9c355575 100644
> > --- a/include/linux/crypto.h
> > +++ b/include/linux/crypto.h
> > @@ -167,7 +167,7 @@
> >   * maintenance for non-coherent DMA (cache invalidation in particular) does not
> >   * affect data that may be accessed by the CPU concurrently.
> >   */
> > -#define CRYPTO_MINALIGN ARCH_KMALLOC_MINALIGN
> > +#define CRYPTO_MINALIGN ARCH_DMA_MINALIGN
>
> I think this should remain as ARCH_KMALLOC_MINALIGN with the
> comment above modified.  The reason is that we assume memory
> returned by kmalloc is already aligned to this value.
>
> Ard, you added the comment regarding the DMA requirement, so
> does anything actually rely on this? If they do, they now need
> to do their own alignment.
>

This patch looks incorrect to me, as ARCH_DMA_MINALIGN is not
#define'd on all architectures.

But I am fine with the intent: ARCH_DMA_MINALIGN will be >=
ARCH_KMALLOC_MINALIGN, and so the compile time layout of structs will
take the worst cast minimum DMA alignment into account, whereas their
placement in memory when they allocated dynamically may be aligned to
ARCH_KMALLOC_MINALIGN only. Since the latter will be based on the
actual cache geometry, this should be fine.

Apart from the 'shash desc on stack' issue solved by the patch that
also introduced the above comment(660d2062190d), I've never looked
into the actual memory footprint of the crypto related data structures
resulting from this alignment, but it seems to me that /if/ this is
significant, we should be able to punt this to the drivers that
actually need this, rather than impose it for the whole system. (This
would involve over-allocating the context struct, and aligning up the
pointer in the various xxx_ctx() getters iff needed by the driver in
question)

I'll put this on my list of things to look at.
