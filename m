Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81B650A0C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352992AbiDUN2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348045AbiDUN2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:28:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4C0E016
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:25:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CCDEB82488
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 13:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6746C385A5;
        Thu, 21 Apr 2022 13:25:25 +0000 (UTC)
Date:   Thu, 21 Apr 2022 14:25:22 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
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
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <YmFbQiSFyQ+W85Zx@arm.com>
References: <YlvU6ou14okbAbgW@arm.com>
 <YlvWtc/dJ6luXzZf@gondor.apana.org.au>
 <YlxAo5BAy+ARlvqj@arm.com>
 <Yl0jPdfdUkaStDN5@gondor.apana.org.au>
 <Yl2Vda/8S7qAvMjC@arm.com>
 <CAMj1kXEGdPageO3tb2=eLnGAR9-nZtmTGXcGf5CiTQFC4JiXOg@mail.gmail.com>
 <CAK8P3a1+GqbO5Kgf70nmR8rQg5OaLBsFZJWaOLuS7JRqXb-ZNA@mail.gmail.com>
 <YmEFttLxGbyJx8LK@infradead.org>
 <YmE60ufokRCYOj8W@arm.com>
 <CAK8P3a34UTmJ5Tn2vbFaJjQrvO-G5LJOqe_6oQwR6zp+PJ8fjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a34UTmJ5Tn2vbFaJjQrvO-G5LJOqe_6oQwR6zp+PJ8fjA@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 02:28:45PM +0200, Arnd Bergmann wrote:
> On Thu, Apr 21, 2022 at 1:06 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Thu, Apr 21, 2022 at 12:20:22AM -0700, Christoph Hellwig wrote:
> > > Btw, there is another option:  Most real systems already require having
> > > swiotlb to bounce buffer in some cases.  We could simply force bounce
> > > buffering in the dma mapping code for too small or not properly aligned
> > > transfers and just decrease the dma alignment.
> >
> > We can force bounce if size is small but checking the alignment is
> > trickier. Normally the beginning of the buffer is aligned but the end is
> > at some sizeof() distance. We need to know whether the end is in a
> > kmalloc-128 cache and that requires reaching out to the slab internals.
> > That's doable and not expensive but it needs to be done for every small
> > size getting to the DMA API, something like (for mm/slub.c):
> >
> >         folio = virt_to_folio(x);
> >         slab = folio_slab(folio);
> >         if (slab->slab_cache->align < ARCH_DMA_MINALIGN)
> >                 ... bounce ...
> >
> > (and a bit different for mm/slab.c)
> 
> I think the decision to bounce or not can be based on the actual
> cache line size at runtime, so most commonly 64 bytes on arm64,
> even though the compile-time limit is 128 bytes.
> 
> We also know that larger slabs are all cacheline aligned, so simply
> comparing the transfer size is enough to rule out most, in this case
> any transfer larger than 96 bytes must come from the kmalloc-128
> or larger cache, so that works like before.

There's also the case with 128-byte cache lines and kmalloc-192.

> For transfers <=96 bytes, the possibilities are:
> 
> 1.kmalloc-32 or smaller, always needs to bounce
> 2. kmalloc-96, but at least one byte in partial cache line,
>     need to bounce
> 3. kmalloc-64, may skip the bounce.
> 4. kmalloc-128 or larger, or not a slab cache but a partial
>     transfer, may skip the bounce.
> 
> I would guess that the first case is the most common here,
> so unless bouncing one or two cache lines is extremely
> expensive, I don't expect it to be worth optimizing for the latter
> two cases.

I think so. If someone complains of a performance regression, we can
look at optimising the bounce. I have a suspicion the cost of copying
two cache lines is small compared to swiotlb_find_slots() etc.

-- 
Catalin
