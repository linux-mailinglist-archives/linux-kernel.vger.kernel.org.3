Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC755017AF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242483AbiDNPn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245722AbiDNPMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:12:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E4C31DD9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:53:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1F3D1CE29FC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7833C385A1;
        Thu, 14 Apr 2022 14:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649947979;
        bh=7wBvgJpF3gpTDEaBw8M6NVW1pKfEKmS9VKFCBRVMztw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LPmYH2iT0QZ4tB6UBujEhh7Eg/K3MbH8ONOTxDJzjn0PQwlRt6sROBkzqb4DVSuKA
         mGsPTmLdoMR7m4rdpz61ntXbr938FMRUXpzogl+Jm9ThXWDoTVAYdgHwA3nIYc+3Sy
         pSy0c784oh4qySyDqMJSdHxaYK+g2pkyXEx70UVA=
Date:   Thu, 14 Apr 2022 16:52:56 +0200
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
Message-ID: <Ylg1SCBA6lJM/k4h@kroah.com>
References: <YlVOTsaTVkBOxthG@arm.com>
 <YlVSBuEqMt2S1Gi6@gondor.apana.org.au>
 <YlVxGAHHD/j6lW3c@arm.com>
 <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com>
 <CAHk-=wjr9-n7vHiVdm-L-KX4kXWyY45++8jenFA1QV5oc=yhZg@mail.gmail.com>
 <YlezcPbFOkSUygBJ@kroah.com>
 <CAMj1kXFWJXbT+fMEx=wzX1wS6xW1DeGxZ+mWBbY8Z4hj4kc_dw@mail.gmail.com>
 <YlgvaSozV5jU49Y0@kroah.com>
 <CAMj1kXGAd7s1GU=uH+iLOwvbn1zG-=TNXw02Bf-AdiHOQvh02Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGAd7s1GU=uH+iLOwvbn1zG-=TNXw02Bf-AdiHOQvh02Q@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 04:36:46PM +0200, Ard Biesheuvel wrote:
> On Thu, 14 Apr 2022 at 16:27, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Apr 14, 2022 at 03:52:53PM +0200, Ard Biesheuvel wrote:
> > > On Thu, 14 Apr 2022 at 07:38, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, Apr 13, 2022 at 09:53:24AM -1000, Linus Torvalds wrote:
> ...
> > > > > Honestly, I think it would probably be worth discussing the "kmalloc
> > > > > DMA alignment" issues.
> > > > >
> > > > > 99.9% of kmalloc users don't want to do DMA.
> > > > >
> > > > > And there's actually a fair amount of small kmalloc for random stuff.
> > > > > Right now on my laptop, I have
> > > > >
> > > > >     kmalloc-8          16907  18432      8  512    1 : ...
> > > > >
> > > > > according to slabinfo, so almost 17 _thousand_ allocations of 8 bytes.
> > > > >
> > > > > It's all kinds of sad if those allocations need to be 64 bytes in size
> > > > > just because of some silly DMA alignment issue, when none of them want
> > > > > it.
> > > > >
> > >
> > > Actually, the alignment for non-cache coherent DMA is 128 bytes on
> > > arm64, not 64 bytes.
> > >
> > > > > Yeah, yeah, wasting a megabyte of memory is "just a megabyte" these
> > > > > days. Which is crazy. It's literally memory that could have been used
> > > > > for something much more useful than just pure and utter waste.
> > > > >
> > > > > I think we could and should just say "people who actually require DMA
> > > > > accesses should say so at kmalloc time". We literally have that
> > > > > GFP_DMA and ZOME_DMA for various historical reasons, so we've been
> > > > > able to do that before.
> > > > >
> > > > > No, that historical GFP_DMA isn't what arm64 wants - it's the old
> > > > > crazy "legacy 16MB DMA" thing that ISA DMA used to have.
> > > > >
> > > > > But the basic issue was true then, and is true now - DMA allocations
> > > > > are fairly special, and should not be that hard to just mark as such.
> > > >
> > > > "fairly special" == "all USB transactions", so it will take a lot of
> > > > auditing here.  I think also many SPI controllers require this and maybe
> > > > I2C?  Perhaps other bus types do as well.
> > > >
> > > > So please don't make this change without some way of figuring out just
> > > > what drivers need to be fixed up, as it's going to be a lot...
> > > >
> > >
> > > Yeah, the current de facto contract of being able to DMA map anything
> > > that was allocated via the linear map makes it quite hard to enforce
> > > the use of dma_kmalloc() for this.
> > >
> > > What we might do, given the fact that only inbound non-cache coherent
> > > DMA is problematic, is dropping the kmalloc alignment to 8 like on
> > > x86, and falling back to bounce buffering when a misaligned, non-cache
> > > coherent inbound DMA mapping is created, using the SWIOTLB bounce
> > > buffering code that we already have, and is already in use on most
> > > affected systems for other reasons (i.e., DMA addressing limits)
> >
> > Ick, that's a mess.
> >
> > > This will cause some performance regressions, but in a way that seems
> > > fixable to me: taking network drivers as an example, the RX buffers
> > > that are filled using inbound DMA are typically owned by the driver
> > > itself, which could be updated to round up its allocations and DMA
> > > mappings. Block devices typically operate on quantities that are
> > > aligned sufficiently already. In other cases, we will likely notice
> > > if/when this fallback is taken on a hot path, but if we don't, at
> > > least we know a bounce buffer is being used whenever we cannot perform
> > > the DMA safely in-place.
> >
> > We can move to having an "allocator-per-bus" for memory like this to
> > allow the bus to know if this is a DMA requirement or not.
> >
> > So for all USB drivers, we would have:
> >         usb_kmalloc(size, flags);
> > and then it might even be easier to verify with static tools that the
> > USB drivers are sending only properly allocated data.  Same for SPI and
> > other busses.
> >
> 
> As I pointed out earlier in the thread, alignment/padding requirements
> for non-coherent DMA are a property of the CPU's cache hierarchy, not
> of the device. So I'm not sure I follow how a per-subsystem
> distinction would help here. In the case of USB especially, would that
> mean that block, media and networking subsystems would need to be
> aware of the USB-ness of the underlying transport?

That's what we have required today, yes.  That's only because we knew
that for some USB controllers, that was a requirement and we had no way
of passing that information back up the stack so we just made it a
requirement.

But I do agree this is messy.  It's even messier for things like USB
where it's not the USB device itself that matters, it's the USB
controller that the USB device is attached to.  And that can be _way_ up
the device hierarchy.  Attach something like a NFS mount over a PPP
network connection on a USB to serial device and ugh, where do you
begin?  :)

And is this always just an issue of the CPU cache hierarchy?  And not the
specific bridge that a device is connected to that CPU on?  Or am I
saying the same thing here?

I mean take a USB controller for example.  We could have a system where
one USB controller is on a PCI bus, while another is on a "platform"
bus.  Both of those are connected to the CPU in different ways and so
could have different DMA rules.  Do we downgrade everything in the
system for the worst connection possible?

Again, consider a USB driver allocating memory to transfer stuff, should
it somehow know the cache hierarchy that it is connected to?  Right now
we punt and do not do that at the expense of a bit of potentially
wasted memory for small allocations.


> > https://lore.kernel.org/r/230a9486fc68ea0182df46255e42a51099403642.1648032613.git.christophe.leroy@csgroup.eu
> > is an example of a SPI driver that has been there "for forever" yet
> > always got it wrong.  If we could have had some way to know "only memory
> > allocated with this function is allowed on the bus" that would have
> > fixed the issue a long time ago.
> >
> > Anyway, just an idea, it's up to you all if this is worth it or not.
> > Adding performance regressions at the expense of memory size feels like
> > a rough trade-off to go through until things are fixed up.
> >
> 
> Yeah, I hear you. But we already have distinct classes of memory,
> i.e., vmalloc vs kmalloc, where only the latter is permitted for DMA
> (which is why VMAP stack broke that SPI driver), and I'm not sure
> adding more types is going to make this tractable going forward.

Sorry, it would not be a "real" type of memory at all, just something
with a static tag on it at the compiler level (like we do for endian
stuff with sparse today).  The real memory would be allocated with the
normal kmalloc() and friends it's just that static tools can be run to
verify "yes, all of the calls to usb_submit_urb() were done with memory
allocated with usb_kmalloc(), and not from the stack"

No runtime changes needed for different types, that would be a mess.
Let's lean on static tools when we can.

thanks,

greg k-h
