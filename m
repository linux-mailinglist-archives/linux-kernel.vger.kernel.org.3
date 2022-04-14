Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5E0501C33
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345951AbiDNTwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345914AbiDNTwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:52:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5C63CA7B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:49:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE17CB82BAB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A81FC385A1;
        Thu, 14 Apr 2022 19:49:43 +0000 (UTC)
Date:   Thu, 14 Apr 2022 20:49:40 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <Ylh61CCMkESmurIp@arm.com>
References: <Yk/6ts5sVDMDpKj3@arm.com>
 <Yk/8QExHlggU8KgC@gondor.apana.org.au>
 <YlVHSvkyUBXZPUr2@arm.com>
 <YlVJKjXkcHqkwyt4@gondor.apana.org.au>
 <YlVOTsaTVkBOxthG@arm.com>
 <YlVSBuEqMt2S1Gi6@gondor.apana.org.au>
 <YlVxGAHHD/j6lW3c@arm.com>
 <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com>
 <CAHk-=wjr9-n7vHiVdm-L-KX4kXWyY45++8jenFA1QV5oc=yhZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjr9-n7vHiVdm-L-KX4kXWyY45++8jenFA1QV5oc=yhZg@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 09:53:24AM -1000, Linus Torvalds wrote:
> On Tue, Apr 12, 2022 at 10:47 PM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > I agree. There is also an implicit expectation that the DMA API works on
> > kmalloc'ed buffers and that's what ARCH_DMA_MINALIGN is for (and the
> > dynamic arch_kmalloc_minalign() in this series). But the key point is
> > that the driver doesn't need to know the CPU cache topology, coherency,
> > the DMA API and kmalloc() take care of these.
> 
> Honestly, I think it would probably be worth discussing the "kmalloc
> DMA alignment" issues.
> 
> 99.9% of kmalloc users don't want to do DMA.
> 
> And there's actually a fair amount of small kmalloc for random stuff.
> Right now on my laptop, I have
> 
>     kmalloc-8          16907  18432      8  512    1 : ...
> 
> according to slabinfo, so almost 17 _thousand_ allocations of 8 bytes.
> 
> It's all kinds of sad if those allocations need to be 64 bytes in size
> just because of some silly DMA alignment issue, when none of them want
> it.

It's a lot worse, ARCH_KMALLOC_MINALIGN is currently 128 bytes on arm64.
I want to at least get it down to 64 with this series while preserving
the current kmalloc() semantics.

If we know the SoC is fully coherent (a bit tricky with late probed
devices), we could get the alignment down to 8. In the mobile space,
unfortunately, most DMA is non-coherent.

I think it's worth investigating the __dma annotations that Greg
suggested, though I have a suspicion it either is too difficult to track
or we just end up with this annotation everywhere. There are cases where
the memory is allocated outside the driver that knows the DMA needs,
though I guess these are either full page allocations or
kmem_cache_alloc() (e.g. page cache pages, skb).

There's also Ard's suggestion to bounce the (inbound DMA) buffer if not
aligned. That's doable but dma_map_single(), for example, only gets the
size of some random structure/buffer. If the size is below
ARCH_DMA_MINALIGN (or cache_line_size()), the DMA API implementation
would have to retrieve the slab cache, check the real allocation size
and then bounce if necessary.

Irrespective of which option we go for, I think at least part of this
series decoupling ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINALIGN is still
needed since currently the minalign is used in some compile time
attributes. Even getting the kmalloc() size down to 64 is a significant
improvement over 128.

Subsequently I'd attempt Ard's bouncing idea as a quick workaround and
assess the bouncing overhead on some real platforms. This may be needed
before we track down all places to use dma_kmalloc().

I need to think some more on Greg's __dma annotation, as I said the
allocation may be decoupled from the driver in some cases.

-- 
Catalin
