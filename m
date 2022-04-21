Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2537509E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388702AbiDULJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388612AbiDULJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:09:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C801036
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 04:07:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20A9A61B04
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDB7C385A5;
        Thu, 21 Apr 2022 11:07:01 +0000 (UTC)
Date:   Thu, 21 Apr 2022 12:06:58 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <YmE60ufokRCYOj8W@arm.com>
References: <YlvQTci7RP5evtTy@arm.com>
 <YlvRbvWSWMTtBJiN@gondor.apana.org.au>
 <YlvU6ou14okbAbgW@arm.com>
 <YlvWtc/dJ6luXzZf@gondor.apana.org.au>
 <YlxAo5BAy+ARlvqj@arm.com>
 <Yl0jPdfdUkaStDN5@gondor.apana.org.au>
 <Yl2Vda/8S7qAvMjC@arm.com>
 <CAMj1kXEGdPageO3tb2=eLnGAR9-nZtmTGXcGf5CiTQFC4JiXOg@mail.gmail.com>
 <CAK8P3a1+GqbO5Kgf70nmR8rQg5OaLBsFZJWaOLuS7JRqXb-ZNA@mail.gmail.com>
 <YmEFttLxGbyJx8LK@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmEFttLxGbyJx8LK@infradead.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 12:20:22AM -0700, Christoph Hellwig wrote:
> Btw, there is another option:  Most real systems already require having
> swiotlb to bounce buffer in some cases.  We could simply force bounce
> buffering in the dma mapping code for too small or not properly aligned
> transfers and just decrease the dma alignment.

We can force bounce if size is small but checking the alignment is
trickier. Normally the beginning of the buffer is aligned but the end is
at some sizeof() distance. We need to know whether the end is in a
kmalloc-128 cache and that requires reaching out to the slab internals.
That's doable and not expensive but it needs to be done for every small
size getting to the DMA API, something like (for mm/slub.c):

	folio = virt_to_folio(x);
	slab = folio_slab(folio);
	if (slab->slab_cache->align < ARCH_DMA_MINALIGN)
		... bounce ...

(and a bit different for mm/slab.c)

If we scrap ARCH_DMA_MINALIGN altogether from arm64, we can check the
alignment against cache_line_size(), though I'd rather keep it for code
that wants to avoid bouncing and goes for this compile-time alignment.

I think we are down to four options (1 and 2 can be combined):

1. ARCH_DMA_MINALIGN == 128, dynamic arch_kmalloc_minalign() to reduce
   kmalloc() alignment to 64 on most arm64 SoC - this series.

2. ARCH_DMA_MINALIGN == 128, ARCH_KMALLOC_MINALIGN == 128, add explicit
   __GFP_PACKED for small allocations. It can be combined with (1) so
   that allocations without __GFP_PACKED can still get 64-byte
   alignment.

3. ARCH_DMA_MINALIGN == 128, ARCH_KMALLOC_MINALIGN == 8, swiotlb bounce.

4. undef ARCH_DMA_MINALIGN, ARCH_KMALLOC_MINALIGN == 8, swiotlb bounce.

(3) and (4) don't require histogram analysis. Between them, I have a
preference for (3) as it gives drivers a chance to avoid the bounce.

If (2) is feasible, we don't need to bother with any bouncing or
structure alignments, it's an opt-in by the driver/subsystem. However,
it may be tedious to analyse the hot spots. While there are a few
obvious places (kstrdup), I don't have access to a multitude of devices
that may exercise the drivers and subsystems.

With (3) the risk is someone complaining about performance or even
running out of swiotlb space on some SoCs (I guess the fall-back can be
another kmalloc() with an appropriate size).

I guess we can limit the choice to either (2) or (3). I have (2) already
(needs some more testing). I can attempt (3) and try to run it on some
real hardware to see the perf impact.

-- 
Catalin
