Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2495501783
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348967AbiDNPkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353168AbiDNOf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:35:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E79D0811
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:27:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3875CB829D6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F59C385A1;
        Thu, 14 Apr 2022 14:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649946475;
        bh=tv0ZyPejhNVJIC2/gOEs9RAJTEBZHd2tc7EDYWiVeWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cUFsG+ssXiitZzQH2dFqquickLykGtIy+KPcIU0tOfpS45sWP9CWaIzJVfWIvFtM4
         ks0fYXDEE3Q+El1sfA/qU4ViMelLPpb7O7/eKxuRU/Jf5uOYO1QUkJ6Qy54s3Wgsna
         vdR9JS1bR0dSAZT+ik0m6guvHz6+1R/e8N78ZEnw=
Date:   Thu, 14 Apr 2022 16:27:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <YlgvaSozV5jU49Y0@kroah.com>
References: <YlVHSvkyUBXZPUr2@arm.com>
 <YlVJKjXkcHqkwyt4@gondor.apana.org.au>
 <YlVOTsaTVkBOxthG@arm.com>
 <YlVSBuEqMt2S1Gi6@gondor.apana.org.au>
 <YlVxGAHHD/j6lW3c@arm.com>
 <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com>
 <CAHk-=wjr9-n7vHiVdm-L-KX4kXWyY45++8jenFA1QV5oc=yhZg@mail.gmail.com>
 <YlezcPbFOkSUygBJ@kroah.com>
 <CAMj1kXFWJXbT+fMEx=wzX1wS6xW1DeGxZ+mWBbY8Z4hj4kc_dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFWJXbT+fMEx=wzX1wS6xW1DeGxZ+mWBbY8Z4hj4kc_dw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 03:52:53PM +0200, Ard Biesheuvel wrote:
> On Thu, 14 Apr 2022 at 07:38, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Apr 13, 2022 at 09:53:24AM -1000, Linus Torvalds wrote:
> > > On Tue, Apr 12, 2022 at 10:47 PM Catalin Marinas
> > > <catalin.marinas@arm.com> wrote:
> > > >
> > > > I agree. There is also an implicit expectation that the DMA API works on
> > > > kmalloc'ed buffers and that's what ARCH_DMA_MINALIGN is for (and the
> > > > dynamic arch_kmalloc_minalign() in this series). But the key point is
> > > > that the driver doesn't need to know the CPU cache topology, coherency,
> > > > the DMA API and kmalloc() take care of these.
> > >
> > > Honestly, I think it would probably be worth discussing the "kmalloc
> > > DMA alignment" issues.
> > >
> > > 99.9% of kmalloc users don't want to do DMA.
> > >
> > > And there's actually a fair amount of small kmalloc for random stuff.
> > > Right now on my laptop, I have
> > >
> > >     kmalloc-8          16907  18432      8  512    1 : ...
> > >
> > > according to slabinfo, so almost 17 _thousand_ allocations of 8 bytes.
> > >
> > > It's all kinds of sad if those allocations need to be 64 bytes in size
> > > just because of some silly DMA alignment issue, when none of them want
> > > it.
> > >
> 
> Actually, the alignment for non-cache coherent DMA is 128 bytes on
> arm64, not 64 bytes.
> 
> > > Yeah, yeah, wasting a megabyte of memory is "just a megabyte" these
> > > days. Which is crazy. It's literally memory that could have been used
> > > for something much more useful than just pure and utter waste.
> > >
> > > I think we could and should just say "people who actually require DMA
> > > accesses should say so at kmalloc time". We literally have that
> > > GFP_DMA and ZOME_DMA for various historical reasons, so we've been
> > > able to do that before.
> > >
> > > No, that historical GFP_DMA isn't what arm64 wants - it's the old
> > > crazy "legacy 16MB DMA" thing that ISA DMA used to have.
> > >
> > > But the basic issue was true then, and is true now - DMA allocations
> > > are fairly special, and should not be that hard to just mark as such.
> >
> > "fairly special" == "all USB transactions", so it will take a lot of
> > auditing here.  I think also many SPI controllers require this and maybe
> > I2C?  Perhaps other bus types do as well.
> >
> > So please don't make this change without some way of figuring out just
> > what drivers need to be fixed up, as it's going to be a lot...
> >
> 
> Yeah, the current de facto contract of being able to DMA map anything
> that was allocated via the linear map makes it quite hard to enforce
> the use of dma_kmalloc() for this.
> 
> What we might do, given the fact that only inbound non-cache coherent
> DMA is problematic, is dropping the kmalloc alignment to 8 like on
> x86, and falling back to bounce buffering when a misaligned, non-cache
> coherent inbound DMA mapping is created, using the SWIOTLB bounce
> buffering code that we already have, and is already in use on most
> affected systems for other reasons (i.e., DMA addressing limits)

Ick, that's a mess.

> This will cause some performance regressions, but in a way that seems
> fixable to me: taking network drivers as an example, the RX buffers
> that are filled using inbound DMA are typically owned by the driver
> itself, which could be updated to round up its allocations and DMA
> mappings. Block devices typically operate on quantities that are
> aligned sufficiently already. In other cases, we will likely notice
> if/when this fallback is taken on a hot path, but if we don't, at
> least we know a bounce buffer is being used whenever we cannot perform
> the DMA safely in-place.

We can move to having an "allocator-per-bus" for memory like this to
allow the bus to know if this is a DMA requirement or not.

So for all USB drivers, we would have:
	usb_kmalloc(size, flags);
and then it might even be easier to verify with static tools that the
USB drivers are sending only properly allocated data.  Same for SPI and
other busses.

https://lore.kernel.org/r/230a9486fc68ea0182df46255e42a51099403642.1648032613.git.christophe.leroy@csgroup.eu
is an example of a SPI driver that has been there "for forever" yet
always got it wrong.  If we could have had some way to know "only memory
allocated with this function is allowed on the bus" that would have
fixed the issue a long time ago.

Anyway, just an idea, it's up to you all if this is worth it or not.
Adding performance regressions at the expense of memory size feels like
a rough trade-off to go through until things are fixed up.

greg k-h
