Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD8F508614
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377746AbiDTKjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377741AbiDTKja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:39:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCB53FBF9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:36:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE879B81EAA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8925BC385A0;
        Wed, 20 Apr 2022 10:36:39 +0000 (UTC)
Date:   Wed, 20 Apr 2022 11:36:36 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <Yl/iNNxzR5YBUzGx@arm.com>
References: <CAMj1kXH5O32H1nnm6y7=3KiH7R-_oakxzBpZ20wK+8kaD46aKw@mail.gmail.com>
 <YlvK9iefUECy361O@gondor.apana.org.au>
 <YlvQTci7RP5evtTy@arm.com>
 <YlvRbvWSWMTtBJiN@gondor.apana.org.au>
 <YlvU6ou14okbAbgW@arm.com>
 <YlvWtc/dJ6luXzZf@gondor.apana.org.au>
 <YlxAo5BAy+ARlvqj@arm.com>
 <Yl0jPdfdUkaStDN5@gondor.apana.org.au>
 <Yl2Vda/8S7qAvMjC@arm.com>
 <CAMj1kXEGdPageO3tb2=eLnGAR9-nZtmTGXcGf5CiTQFC4JiXOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEGdPageO3tb2=eLnGAR9-nZtmTGXcGf5CiTQFC4JiXOg@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 11:50:11PM +0200, Ard Biesheuvel wrote:
> On Mon, 18 Apr 2022 at 18:44, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Mon, Apr 18, 2022 at 04:37:17PM +0800, Herbert Xu wrote:
> > > I've seen Ard's patches already and I think I understand what your
> > > needs are.  So let me whip up some code to show you guys what I
> > > think needs to be done.
> >
> > BTW before you have a go at this, there's also Linus' idea that does not
> > change the crypto code (at least not functionally). Of course, you and
> > Ard can still try to figure out how to reduce the padding but if we go
> > with Linus' idea of a new GFP_NODMA flag, there won't be any changes to
> > the crypto code as long as it doesn't pass such flag. So, the options:
> >
> > 1. Change ARCH_KMALLOC_MINALIGN to 8 (or ARCH_SLAB_MINALIGN if higher)
> >    while keeping ARCH_DMA_MINALIGN to 128. By default kmalloc() will
> >    honour the 128-byte alignment, unless GDP_NODMA is passed. This still
> >    requires changing CRYPTO_MINALIGN to ARCH_DMA_MINALIGN but there is
> >    no functional change, kmalloc() without the new flag will return
> >    CRYPTO_MINALIGN-aligned pointers.
> >
> > 2. Leave ARCH_KMALLOC_MINALIGN as ARCH_DMA_MINALIGN (128) and introduce
> >    a new GFP_PACKED (I think it fits better than 'NODMA') flag that
> >    reduces the minimum kmalloc() below ARCH_KMALLOC_MINALIGN (and
> >    probably at least ARCH_SLAB_MINALIGN). It's equivalent to (1) but
> >    does not touch the crypto code at all.
> >
> > (1) and (2) are the same, just minor naming difference. Happy to go with
> > any of them. They still have the downside that we need to add the new
> > GFP_ flag to those hotspots that allocate small objects (Arnd provided
> > an idea on how to find them with ftrace) but at least we know it won't
> > inadvertently break anything.
> 
> I'm not sure GFP_NODMA adds much here.

What it buys is that the crypto code won't need to be changed
immediately, so we can go ahead with the kmalloc() optimisation while
you and Herbert figure out how to refactor the crypto code.

Another option is to make the change but pass a new GFP_DMA_MINALIGN
flag to all kmalloc() calls in the crypto code (or a new dma_kmalloc()
that Linus suggested). This way the allocations in the crypto code are
guaranteed to be ARCH_DMA_MINALIGN (we'd still change CRYPTO_MINALIGN to
this).

> The way I see it, the issue in the crypto code is that we are relying
> on a ARCH_KMALLOC_ALIGN aligned zero length __ctx[] array for three
> different things:
> - ensuring/informing the compiler that top-level request/TFM
> structures are aligned to ARCH_KMALLOC_ALIGN,
> - adding padding to ensure that driver context structures that are
> embedded in those top-level request/TFM structures are sufficiently
> aligned so that any member C types appear at the expected alignment
> (but those structures are not usually defined as being aligned to
> ARCH_KMALLOC_ALIGN)

In this case, a void * array type would cover most structures that don't
have special alignment needs.

In both the above cases, we can get ARCH_KMALLOC_MINALIGN down to 8.

> - adding padding to ensure that these driver context structures do not
> share cache lines with the preceding top-level struct.
> 
> One thing to note here is that the padding is only necessary when the
> driver context size > 0, and has nothing to do with the alignment of
> the top-level struct.
> 
> Using a single aligned ctx member was a nice way to accomplish all of
> these when it was introduced, but I think it might be better to get
> rid of it, and move the padding logic to the static inline helpers
> instead.
> 
> So something like
> 
> struct skcipher_request {
>   ...
> } CRYPTO_MINALIGN_ATTR;
> 
> which states/ensures the alignment of the struct, and
> 
> void *skcipher_request_ctx(struct skcipher_request *req) {
>   return (void *)PTR_ALIGN(req + 1, ARCH_DMA_MINALIGN);
> }
> 
> to get at the context struct, instead of using a struct field.
> 
> Then, we could update skcipher_request_alloc() to only round up
> sizeof(struct skipher_request) to ARCH_DMA_MINALIGN if the reqsize is
> >0 to begin with, and if it is, to also round reqsize up to
> ARCH_DMA_MINALIGN when accessed. That way, we spell out the DMA
> padding requirements with relying on aligned struct members.

I think this should work and CRYPTO_MINALIGN can go down to whatever
ARCH_KMALLOC_MINALIGN without breaking the non-coherent DMA.

-- 
Catalin
