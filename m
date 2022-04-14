Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565185017BB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbiDNPrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357480AbiDNPbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:31:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF34BF7F49
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7290B82A3D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6217AC385AF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649949015;
        bh=zxt6JUVMzZPwH5WgJ31EFmQ0h11rAel2nJKFwtl33ow=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DxN+WjEsLnYzL2aEcpHEG28PkDhxBtQOu2L8KoF8whsFmywtJj808QiCq71XgFfNj
         zIQaMwUAcf3WwfPpMlwFfva/2fb13uHbWeLclLQlN3bds5lM8W3BNy54Oi8Nrg/Fc7
         FGPpeua2WNNzOn/F6nJGzQccZB81/U8/gYW13JpUUcFA8YKAG3U8aPpxmH3Is1SnNi
         tXmf2S/s0ci2LbiXOwl5aVjsooBwpDSDySvZhlC+1b7HM3Hzn3whjH1a/sddHA4+8i
         dLZZ4FclPEwgoEBfwXTCrVtqDzWAbJJGFBuVQgDZd8vlpuVAwJQn/Zox8l4Oo0US/a
         5LyqHORQoRLvA==
Received: by mail-oi1-f181.google.com with SMTP id r8so5697817oib.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:10:15 -0700 (PDT)
X-Gm-Message-State: AOAM533ZfQ81QEPlDXhxxH6RVaQhVopfORAkN0Py8QMzFPBhRzs2BVmN
        fDStkU8KVezXFm6CyzNchNDYhiXlMnR/opHJkLQ=
X-Google-Smtp-Source: ABdhPJx7ecZsYx8JxAkdpXF4I9NrwdRBrRftIAP1IoE986vfJjKmkfPkKWIYw+repOBNPYI4Y/NC4uHpTnzwnnR7Ihg=
X-Received: by 2002:a05:6808:1513:b0:2fa:7a40:c720 with SMTP id
 u19-20020a056808151300b002fa7a40c720mr1554006oiw.126.1649949014411; Thu, 14
 Apr 2022 08:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <YlVOTsaTVkBOxthG@arm.com> <YlVSBuEqMt2S1Gi6@gondor.apana.org.au>
 <YlVxGAHHD/j6lW3c@arm.com> <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com> <CAHk-=wjr9-n7vHiVdm-L-KX4kXWyY45++8jenFA1QV5oc=yhZg@mail.gmail.com>
 <YlezcPbFOkSUygBJ@kroah.com> <CAMj1kXFWJXbT+fMEx=wzX1wS6xW1DeGxZ+mWBbY8Z4hj4kc_dw@mail.gmail.com>
 <YlgvaSozV5jU49Y0@kroah.com> <CAMj1kXGAd7s1GU=uH+iLOwvbn1zG-=TNXw02Bf-AdiHOQvh02Q@mail.gmail.com>
 <Ylg1SCBA6lJM/k4h@kroah.com> <CAMj1kXHeYQ0=oDYT8uaHxFt1dFe3pR+H9psF8ohv5HC351NTKQ@mail.gmail.com>
In-Reply-To: <CAMj1kXHeYQ0=oDYT8uaHxFt1dFe3pR+H9psF8ohv5HC351NTKQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 14 Apr 2022 17:10:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG4WPn2QrXKAsr6npogPpDZkarJ4SXTHuUwP_arrqG1jQ@mail.gmail.com>
Message-ID: <CAMj1kXG4WPn2QrXKAsr6npogPpDZkarJ4SXTHuUwP_arrqG1jQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Thu, 14 Apr 2022 at 17:01, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 14 Apr 2022 at 16:53, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Apr 14, 2022 at 04:36:46PM +0200, Ard Biesheuvel wrote:
> > > On Thu, 14 Apr 2022 at 16:27, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Thu, Apr 14, 2022 at 03:52:53PM +0200, Ard Biesheuvel wrote:
> ...
> > > > > What we might do, given the fact that only inbound non-cache coherent
> > > > > DMA is problematic, is dropping the kmalloc alignment to 8 like on
> > > > > x86, and falling back to bounce buffering when a misaligned, non-cache
> > > > > coherent inbound DMA mapping is created, using the SWIOTLB bounce
> > > > > buffering code that we already have, and is already in use on most
> > > > > affected systems for other reasons (i.e., DMA addressing limits)
> > > >
> > > > Ick, that's a mess.
> > > >
> > > > > This will cause some performance regressions, but in a way that seems
> > > > > fixable to me: taking network drivers as an example, the RX buffers
> > > > > that are filled using inbound DMA are typically owned by the driver
> > > > > itself, which could be updated to round up its allocations and DMA
> > > > > mappings. Block devices typically operate on quantities that are
> > > > > aligned sufficiently already. In other cases, we will likely notice
> > > > > if/when this fallback is taken on a hot path, but if we don't, at
> > > > > least we know a bounce buffer is being used whenever we cannot perform
> > > > > the DMA safely in-place.
> > > >
> > > > We can move to having an "allocator-per-bus" for memory like this to
> > > > allow the bus to know if this is a DMA requirement or not.
> > > >
> > > > So for all USB drivers, we would have:
> > > >         usb_kmalloc(size, flags);
> > > > and then it might even be easier to verify with static tools that the
> > > > USB drivers are sending only properly allocated data.  Same for SPI and
> > > > other busses.
> > > >
> > >
> > > As I pointed out earlier in the thread, alignment/padding requirements
> > > for non-coherent DMA are a property of the CPU's cache hierarchy, not
> > > of the device. So I'm not sure I follow how a per-subsystem
> > > distinction would help here. In the case of USB especially, would that
> > > mean that block, media and networking subsystems would need to be
> > > aware of the USB-ness of the underlying transport?
> >
> > That's what we have required today, yes.  That's only because we knew
> > that for some USB controllers, that was a requirement and we had no way
> > of passing that information back up the stack so we just made it a
> > requirement.
> >
> > But I do agree this is messy.  It's even messier for things like USB
> > where it's not the USB device itself that matters, it's the USB
> > controller that the USB device is attached to.  And that can be _way_ up
> > the device hierarchy.  Attach something like a NFS mount over a PPP
> > network connection on a USB to serial device and ugh, where do you
> > begin?  :)
> >
>
> Exactly.
>
> > And is this always just an issue of the CPU cache hierarchy?  And not the
> > specific bridge that a device is connected to that CPU on?  Or am I
> > saying the same thing here?
> >
>
> Yes, this is a system property not a device property, and the driver
> typically doesn't have any knowledge of this. For example, if a PCI
> host bridge happens to be integrated in a non-cache coherent way, any
> PCI device plugged into it becomes non-coherent, and the associated
> driver needs to do the right thing. This is why we rely on the DMA
> layer to take care of this.
>
> > I mean take a USB controller for example.  We could have a system where
> > one USB controller is on a PCI bus, while another is on a "platform"
> > bus.  Both of those are connected to the CPU in different ways and so
> > could have different DMA rules.  Do we downgrade everything in the
> > system for the worst connection possible?
> >
>
> No, we currently support a mix of coherent and non-coherent just fine,
> and this shouldn't change. It's just that the mere fact that
> non-coherent devices might exist is increasing the memory footprint of
> all kmalloc allocations.
>
> > Again, consider a USB driver allocating memory to transfer stuff, should
> > it somehow know the cache hierarchy that it is connected to?  Right now
> > we punt and do not do that at the expense of a bit of potentially
> > wasted memory for small allocations.
> >
>
> This whole discussion is based on the premise that this is an expense
> we would prefer to avoid. Currently, every kmalloc allocation is
> rounded up to 128 bytes on arm64, while x86 uses only 8.

I guess I didn't answer that last question. Yes, I guess dma_kmalloc()
should be used in such cases. Combined with my bounce buffering hack,
the penalty for using plain kmalloc() instead would be a potential
performance hit when used for inbound DMA, instead of data corruption
(if we'd reduce the kmalloc() alignment when introducing
dma_kmalloc())
