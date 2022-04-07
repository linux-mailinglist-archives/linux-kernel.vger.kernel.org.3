Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552AA4F8694
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346622AbiDGRvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346587AbiDGRvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:51:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D10722EBD7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:49:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30A9CB828FF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 17:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF03C385A0;
        Thu,  7 Apr 2022 17:49:00 +0000 (UTC)
Date:   Thu, 7 Apr 2022 18:48:57 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Brown <broonie@kernel.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Rustam Kovhaev <rkovhaev@gmail.com>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH 00/10] mm, arm64: Reduce ARCH_KMALLOC_MINALIGN below the
 cache line size
Message-ID: <Yk8kCQnSa0F5yIfC@arm.com>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <0966c4b0-6fff-3283-71c3-2d4e211f7385@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0966c4b0-6fff-3283-71c3-2d4e211f7385@suse.cz>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 04:40:15PM +0200, Vlastimil Babka wrote:
> On 4/5/22 15:57, Catalin Marinas wrote:
> > This series is beneficial to arm64 even if it's only reducing the
> > kmalloc() minimum alignment to 64. While it would be nice to reduce this
> > further to 8 (or 16) on SoCs known to be fully DMA coherent, detecting
> > this is via arch_setup_dma_ops() is problematic, especially with late
> > probed devices. I'd leave it for an additional RFC series on top of
> > this (there are ideas like bounce buffering for non-coherent devices if
> > the SoC was deemed coherent).
[...]
> - due to ARCH_KMALLOC_MINALIGN and dma guarantees we should return
> allocations aligned to ARCH_KMALLOC_MINALIGN and the prepended size header
> should also not share their ARCH_KMALLOC_MINALIGN block with another
> (shorter) allocation that has a different lifetime, for the dma coherency
> reasons
> - this is very wasteful especially with the 128 bytes alignment, and seems
> we already violate it in some scenarios anyway [2]. Extending this to all
> objects would be even more wasteful.
> 
> So this series would help here, especially if we can get to the 8/16 size.

If we get to 8/16 size, it would only be for platforms that are fully
coherent. Otherwise, with non-coherent DMA, the minimum kmalloc()
alignment would still be the cache line size (typically 64) even if
ARCH_KMALLOC_MINALIGN is 8.

IIUC your point is that if ARCH_KMALLOC_MINALIGN is 8, kmalloc() could
return pointers 8-byte aligned only as long as DMA safety is preserved
(like not sharing the rest of the cache line with anything other
writers).

> But now I also wonder if keeping the name and meaning of "MINALIGN" is in
> fact misleading and unnecessarily constraining us? What this is really about
> is "granularity of exclusive access", no?

Not necessarily. Yes, in lots of cases it is about granularity of access
but there are others where the code does need the pointer returned
aligned to ARCH_DMA_MINALIGN (currently via ARCH_KMALLOC_MINALIGN).
Crypto seems to have such requirement (see the sub-thread with Herbert).
Some (all?) callers ask kmalloc() for the aligned size and there's an
expectation that if the size is a multiple of a power of two, kmalloc()
will return a pointer aligned to that power of two. I think we need to
preserve these semantics which may lead to some more wastage if you add
the header (e.g. a size of 3*64 returns a pointer either aligned to 192
or 256).

> Let's say the dma granularity is 64bytes, and there's a kmalloc(56).

In your example, the size is not a power of two (or multiple of), so I
guess there's no expectation for a 64-byte alignment (it can be 8)
unless DMA is involved. See below.

> If SLOB find a 64-bytes aligned block, uses the first 8 bytes for the
> size header and returns the remaining 56 bytes, then the returned
> pointer is not *aligned* to 64 bytes, but it's still aligned enough
> for cpu accesses (which need only e.g. 8), and non-coherent dma should
> be also safe because nobody will be accessing the 8 bytes header,
> until the user of the object calls kfree() which should happen only
> when it's done with any dma operations. Is my reasoning correct and
> would this be safe?

From the DMA perspective, it's not safe currently. Let's say we have an
inbound DMA transfer, the DMA API will invalidate the cache line prior
to DMA. In arm64 terms, it means that the cache line is discarded, not
flushed to memory. If the first 8 bytes had not been written back to
RAM, they'd be lost. If we can guarantee that no CPU write happens to
the cache line during the DMA transfer, we can change the DMA mapping
operation to do a clean+invalidate (flush the cacheline to RAM) first. I
guess this could be done with an IS_ENABLED(CONFIG_SLOB) check.

-- 
Catalin
