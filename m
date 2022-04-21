Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6B8509FA4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384562AbiDUMbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238064AbiDUMbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:31:53 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF90830F5F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:29:03 -0700 (PDT)
Received: from mail-wr1-f46.google.com ([209.85.221.46]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mz9d7-1o3sCr0PUh-00wFuh for <linux-kernel@vger.kernel.org>; Thu, 21 Apr
 2022 14:29:02 +0200
Received: by mail-wr1-f46.google.com with SMTP id c10so6497701wrb.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:29:02 -0700 (PDT)
X-Gm-Message-State: AOAM5303eIhiHW2OXcNvzULmxK1/MO2JJpDPRHDIOxH7Z4J8lDj+5por
        ZlA1N/FssBU9dPTeriklK9O5uPKBSxbPFqtIvCU=
X-Google-Smtp-Source: ABdhPJyqadYzTr9CaMW4jeErNFMhrlpnJnMzlYtnkkJzwlVSfKj0lvPip/UlnRxOq/t4hd40yydjrwOeor7u8jKdAIA=
X-Received: by 2002:a5d:6da5:0:b0:20a:8805:6988 with SMTP id
 u5-20020a5d6da5000000b0020a88056988mr17868464wrs.317.1650544141749; Thu, 21
 Apr 2022 05:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <YlvQTci7RP5evtTy@arm.com> <YlvRbvWSWMTtBJiN@gondor.apana.org.au>
 <YlvU6ou14okbAbgW@arm.com> <YlvWtc/dJ6luXzZf@gondor.apana.org.au>
 <YlxAo5BAy+ARlvqj@arm.com> <Yl0jPdfdUkaStDN5@gondor.apana.org.au>
 <Yl2Vda/8S7qAvMjC@arm.com> <CAMj1kXEGdPageO3tb2=eLnGAR9-nZtmTGXcGf5CiTQFC4JiXOg@mail.gmail.com>
 <CAK8P3a1+GqbO5Kgf70nmR8rQg5OaLBsFZJWaOLuS7JRqXb-ZNA@mail.gmail.com>
 <YmEFttLxGbyJx8LK@infradead.org> <YmE60ufokRCYOj8W@arm.com>
In-Reply-To: <YmE60ufokRCYOj8W@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Apr 2022 14:28:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a34UTmJ5Tn2vbFaJjQrvO-G5LJOqe_6oQwR6zp+PJ8fjA@mail.gmail.com>
Message-ID: <CAK8P3a34UTmJ5Tn2vbFaJjQrvO-G5LJOqe_6oQwR6zp+PJ8fjA@mail.gmail.com>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:XTyVPEm3RsEN9JtE8woFm8LpifiPwRnHjaL++GMBK3CPFEt8qv4
 yt8D8LEzYWO10ceT9RaimWtbWGQGyN1fqBZmEU+Thg4nm48MD4Csty9R68pclElugMaRdN6
 mnbjghDgd+7jXCiv99p1mbleZt0+DPtFYmv92ai1aojcOEs64agfyWlO33OZOoZuV2OBJiR
 838Nz7A71YTlEuuAgiIjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/4hb8++/ZaA=:xpqKLOkTxF0CERdiBM78jf
 b/qVe5maEnBMuwmSTtg78X0RKh6YF0cDoRElJmTHhGyqTlNiHM0auWTrgzS/IGMT6Ik78xPrr
 d30Xh+37YglrgoTQCn5lGnzRT93iMhD/FxhMdvyDD38FvggidlKpJQSerpXpxyS5YDdmN1IPU
 DSELY2AVX9YrxjbuG3tOhlWeC0Js2Nac8+DAmIKAemjxqH24eCGns8UkvO2O36B6FcWikTL4C
 E/8hdDh8T7OkhGvUiA3PRGzZseHpO1Zp0donPISqKUc2IU99yJiTtT9pc5nQXpkyDxgHZ2wnr
 Iztp2gJKgHiJBF+lpw7xTfRV3bF9NDVI4bk8qmqrlzEnGhS+4d0B5CoMg0MDfcI4AtYKTMMPE
 /spy/rJ9OeOP8vcv9XwrarnOGuzL5LSqEgqmYWIT2GQBe2sIB3XaQLJTuM+FwiznTeOmQ//4s
 zKN2k0jwMmq3doXQIBTW5eBRnVVW8Ru6V8xopZqO15oKi0Y4WxbbzqISxXB/TBfa0WnCBOSgm
 GoUvaHYi8NctKwFn2t/Z/0uHyD7jpNAHMEk+wkEsSGLLLJKzKIcc2iL64L2DTKhEJ0zjPxM6M
 R+X7z3Uq8dKjxBb9eDN1gLhgbbmbnE1yVrM8BJKG+oNVBIJ82bVgsHt+x0n8SCG4e/LaQVNfn
 zEEHNM7rA6xG5sPVuM8FD7ssM118/2qH5j6dTCDoTPEd9LnxC6aEwmPHXIt1kZ3xQKgpIgydz
 1CbUF2j+ttYRQ5uINHLXQN52kk1f9/SNkleyh7ayCBCIHa8nP0O8GV81OCe7pVatMXjaX8rjk
 FlpxWnZBVjjNATrlfo3p05g+wdLoBQiMfO4Tr/y999sSUbCr5k=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 1:06 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Apr 21, 2022 at 12:20:22AM -0700, Christoph Hellwig wrote:
> > Btw, there is another option:  Most real systems already require having
> > swiotlb to bounce buffer in some cases.  We could simply force bounce
> > buffering in the dma mapping code for too small or not properly aligned
> > transfers and just decrease the dma alignment.
>
> We can force bounce if size is small but checking the alignment is
> trickier. Normally the beginning of the buffer is aligned but the end is
> at some sizeof() distance. We need to know whether the end is in a
> kmalloc-128 cache and that requires reaching out to the slab internals.
> That's doable and not expensive but it needs to be done for every small
> size getting to the DMA API, something like (for mm/slub.c):
>
>         folio = virt_to_folio(x);
>         slab = folio_slab(folio);
>         if (slab->slab_cache->align < ARCH_DMA_MINALIGN)
>                 ... bounce ...
>
> (and a bit different for mm/slab.c)

I think the decision to bounce or not can be based on the actual
cache line size at runtime, so most commonly 64 bytes on arm64,
even though the compile-time limit is 128 bytes.

We also know that larger slabs are all cacheline aligned, so simply
comparing the transfer size is enough to rule out most, in this case
any transfer larger than 96 bytes must come from the kmalloc-128
or larger cache, so that works like before.

For transfers <=96 bytes, the possibilities are:

1.kmalloc-32 or smaller, always needs to bounce
2. kmalloc-96, but at least one byte in partial cache line,
    need to bounce
3. kmalloc-64, may skip the bounce.
4. kmalloc-128 or larger, or not a slab cache but a partial
    transfer, may skip the bounce.

I would guess that the first case is the most common here,
so unless bouncing one or two cache lines is extremely
expensive, I don't expect it to be worth optimizing for the latter
two cases.

       Arnd
