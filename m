Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC1A4FF297
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbiDMIt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiDMIt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:49:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EDB4BFF9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:47:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42BD2B8214C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 08:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8518C385A4;
        Wed, 13 Apr 2022 08:47:32 +0000 (UTC)
Date:   Wed, 13 Apr 2022 09:47:29 +0100
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
Message-ID: <YlaOIbSA7B/G9222@arm.com>
References: <Yk8RGvF6ik34C6BO@arm.com>
 <Yk+rKWEcc9rO+A25@gondor.apana.org.au>
 <Yk/6ts5sVDMDpKj3@arm.com>
 <Yk/8QExHlggU8KgC@gondor.apana.org.au>
 <YlVHSvkyUBXZPUr2@arm.com>
 <YlVJKjXkcHqkwyt4@gondor.apana.org.au>
 <YlVOTsaTVkBOxthG@arm.com>
 <YlVSBuEqMt2S1Gi6@gondor.apana.org.au>
 <YlVxGAHHD/j6lW3c@arm.com>
 <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 12:01:25AM +0200, Ard Biesheuvel wrote:
> On Tue, 12 Apr 2022 at 14:31, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Tue, Apr 12, 2022 at 06:18:46PM +0800, Herbert Xu wrote:
> > > On Tue, Apr 12, 2022 at 11:02:54AM +0100, Catalin Marinas wrote:
> > > > This series does not penalise any architecture. It doesn't even make
> > > > arm64 any worse than it currently is.
> > >
> > > Right, the patch as it stands doesn't change anything.  However,
> > > it is also broken as it stands.  As I said before, CRYPTO_MINALIGN
> > > is not something that is guaranteed by the Crypto API, it is simply
> > > a statement of whatever kmalloc returns.
> >
> > I agree that CRYPTO_MINALIGN is not guaranteed by the Crypto API. What
> > I'm debating is the intended use for CRYPTO_MINALIGN in some (most?) of
> > the drivers. It's not just about kmalloc() but also a build-time offset
> > of buffers within structures to guarantee DMA safety. This can't be
> > fixed by cra_alignmask.
> >
> > We could leave CRYPTO_MINALIGN as ARCH_KMALLOC_MINALIGN and that matches
> > it being just a statement of the kmalloc() minimum alignment. But since
> > it is also overloaded with the DMA in-structure offset alignment, we'd
> > need a new CRYPTO_DMA_MINALIGN (and _ATTR) to annotate those structures.
> > I have a suspicion there'll be fewer of the original CRYPTO_MINALIGN
> > uses left, hence my approach to making this bigger from the start.
> >
> > There's also Ard's series introducing CRYPTO_REQ_MINALIGN while leaving
> > CRYPT_MINALIGN for DMA-safe offsets (IIUC):
> >
> > https://lore.kernel.org/r/20220406142715.2270256-1-ardb@kernel.org
> >
> > > So if kmalloc is no longer returning CRYPTO_MINALIGN-aligned
> > > memory, then those drivers that need this alignment for DMA
> > > will break anyway.
> 
> One thing to note here is that minimum DMA *alignment* is not the same
> as the padding to cache writeback granule (CWG) that is needed when
> dealing with non-cache coherent inbound DMA.
> 
> The former is typically a property of the peripheral IP, and is
> something that the driver needs to deal with, potentially by setting
> cra_alignmask to ensure that the input and output buffers are placed
> such that they can accessed via DMA by the peripheral.

Good point, thanks for making this clear. AFAICT, the requirement for
bus master access in the crypto code doesn't go above 16 (a
cra_alignmask of 15).

> The latter is a property of the CPU's cache hierarchy, not only the
> size of the CWG, but also whether or not DMA is cache coherent to
> begin with. This is not something the driver should usually have to
> care about if it uses the DMA API correctly.

I agree. There is also an implicit expectation that the DMA API works on
kmalloc'ed buffers and that's what ARCH_DMA_MINALIGN is for (and the
dynamic arch_kmalloc_minalign() in this series). But the key point is
that the driver doesn't need to know the CPU cache topology, coherency,
the DMA API and kmalloc() take care of these.

> The reason why CRYPTO_MINALIGN matters for DMA in spite of this is
> that some drivers not only use DMA for processing the bulk of the data
> (typically presented using scatterlists) but sometimes also use DMA to
> map parts of the request and TFM structures, which carry control data
> used by the CPU to manage the crypto requests. Doing a non-coherent
> DMA write into such a structure may blow away 64 or 128 bytes of data,
> even if the write itself is much smaller, due to the fact that we need
> to perform cache invalidation in order for the CPU to be able to
> observe what the device wrote to that memory, and the invalidated
> cache lines may be shared with other data items, and may become dirty
> while the DMA mapping is active.

Indeed.

> This is what I am addressing with my patch series, i.e., padding out
> the driver owned parts of the struct to the CWG size so that cache
> invalidation does not affect data owned by other layers in the crypto
> cake, but only at runtime. By doing this consistently for TFM and
> request structures, we should be able to disregard ARCH_DMA_MINALIGN
> entirely when it comes to defining CRYPTO_MINALIGN, as it is highly
> unlikely that any of these peripherals would require more than 8 or 16
> bytes of alignment for the DMA operations themselves.

Your series would be a nice improvement and eventually get
CRYPTO_MINALIGN to ARCH_SLAB_MINALIGN. In the meantime, with my series,
we need CRYPTO_MINALIGN to be ARCH_DMA_MINALIGN on arm64, unless we add
a new CRYPT_DMA_MINALIGN but I don't see much point, especially if you
plan to reduce this alignment anyway.


Let's go back to restating the crypto code alignment requirements, as I
understand them (please correct):

1. Bus master accesses (DMA, CPUs that can't do efficient unaligned
   accesses). That's what cra_alignmask is for. If there's a driver that
   relies on an implicit kmalloc() alignment higher than cra_alignmask,
   it is already broken on x86 and a few other architectures that don't
   define ARCH_DMA_MINALIGN. But it won't be any worse with this series
   since it only brings the arm64 kmalloc() alignment down from 128 to
   64.

2. Non-coherent DMA and cache invalidation. With my series, kmalloc'ed
   buffers are DMA-safe for the CPU/SoC the kernel is running on.

3. DMA into buffers embedded in TFM structures. Since the offset of
   those buffers is decided at compile-time, we need a
   CRYPTO_MINALIGN_ATTR that covers both bus master alignment
   requirements and the highest cache line size (CWG) for a non-coherent
   DMA SoC. Ard's series would simplify the latter but, before then,
   CRYPTO_MINALIGN needs to stay as the larger ARCH_DMA_MINALIGN.

With my series, there is no change to the value of CRYPTO_MINALIGN for
arm64 or any other architecture, so point 3 is unaffected. The series
does change the kmalloc() alignment and that may be smaller than
CRYPTO_MINALIGN but neither of points 1 or 2 above are affected since
(a) we still have a sufficiently large ARCH_KMALLOC_MINALIGN of 64 and
(b) the kmalloc'ed buffers are safe for non-coherent DMA.

Herbert, Ard, if I missed anything please let me know but based on my
understanding, this series is safe for the crypto code.

Thanks.

-- 
Catalin
