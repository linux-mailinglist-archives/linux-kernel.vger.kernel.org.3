Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721AE50178A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354226AbiDNPlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354747AbiDNOmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:42:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD83B10C8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:37:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 624E7B829D3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B1FC385B1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649947020;
        bh=+fX+vlRMAcznpaPYe+5+kaIB//YIVMxZzI5CN9IWnKk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hM9js4sAaVKeo0JTYlLJrCyTzbqHy/v2hSWeLGqbHzWtUpoVmjsVg6T0KUA8Sdjg5
         iAlYJ8vWQ0bDJmXbEL0Q9gz6qZvMI58e+U/9c9P0cwGvnjJGQ6wFe4FIXaLgkKxh3y
         veCga6zMwU6fZOJT3HF6I7uBXP+obIx2J+NBYlK5LIhXv0UMt5iSzCnGlIB614PWJZ
         4BZs8hD4bdGkOBTFA7hnTv9TV2GqR7RApWRC5RsHCsd4F3T29iSfHBHt2GoXdywbqw
         vcAx4IkZWMbLwBX5w8+Cq9XxWYaimrX37Sj0Or1B89NmMlingHkMjPw0UReqn0acNs
         88jTwjYyIzoRQ==
Received: by mail-oi1-f175.google.com with SMTP id q189so5568331oia.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:37:00 -0700 (PDT)
X-Gm-Message-State: AOAM531sUCKTvvd2irkdoa0FHuSCtxaKiL5iXC+KB3lslK/I372aDixJ
        TbeayN5X91tmOqfZP4J6fF7iWex0vWul/vTLHx4=
X-Google-Smtp-Source: ABdhPJyTt2gRZUSwoRqlYJLw8enun9rICcduOgNbY1CMkVli4eENqZIykyCUn6xJ3oVAVvpPmZtM2U7NAFwzYvNOYLM=
X-Received: by 2002:a05:6808:1596:b0:2f7:5d89:eec7 with SMTP id
 t22-20020a056808159600b002f75d89eec7mr1828415oiw.228.1649947019047; Thu, 14
 Apr 2022 07:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <YlVHSvkyUBXZPUr2@arm.com> <YlVJKjXkcHqkwyt4@gondor.apana.org.au>
 <YlVOTsaTVkBOxthG@arm.com> <YlVSBuEqMt2S1Gi6@gondor.apana.org.au>
 <YlVxGAHHD/j6lW3c@arm.com> <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com> <CAHk-=wjr9-n7vHiVdm-L-KX4kXWyY45++8jenFA1QV5oc=yhZg@mail.gmail.com>
 <YlezcPbFOkSUygBJ@kroah.com> <CAMj1kXFWJXbT+fMEx=wzX1wS6xW1DeGxZ+mWBbY8Z4hj4kc_dw@mail.gmail.com>
 <YlgvaSozV5jU49Y0@kroah.com>
In-Reply-To: <YlgvaSozV5jU49Y0@kroah.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 14 Apr 2022 16:36:46 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGAd7s1GU=uH+iLOwvbn1zG-=TNXw02Bf-AdiHOQvh02Q@mail.gmail.com>
Message-ID: <CAMj1kXGAd7s1GU=uH+iLOwvbn1zG-=TNXw02Bf-AdiHOQvh02Q@mail.gmail.com>
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

On Thu, 14 Apr 2022 at 16:27, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 14, 2022 at 03:52:53PM +0200, Ard Biesheuvel wrote:
> > On Thu, 14 Apr 2022 at 07:38, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Apr 13, 2022 at 09:53:24AM -1000, Linus Torvalds wrote:
...
> > > > Honestly, I think it would probably be worth discussing the "kmalloc
> > > > DMA alignment" issues.
> > > >
> > > > 99.9% of kmalloc users don't want to do DMA.
> > > >
> > > > And there's actually a fair amount of small kmalloc for random stuff.
> > > > Right now on my laptop, I have
> > > >
> > > >     kmalloc-8          16907  18432      8  512    1 : ...
> > > >
> > > > according to slabinfo, so almost 17 _thousand_ allocations of 8 bytes.
> > > >
> > > > It's all kinds of sad if those allocations need to be 64 bytes in size
> > > > just because of some silly DMA alignment issue, when none of them want
> > > > it.
> > > >
> >
> > Actually, the alignment for non-cache coherent DMA is 128 bytes on
> > arm64, not 64 bytes.
> >
> > > > Yeah, yeah, wasting a megabyte of memory is "just a megabyte" these
> > > > days. Which is crazy. It's literally memory that could have been used
> > > > for something much more useful than just pure and utter waste.
> > > >
> > > > I think we could and should just say "people who actually require DMA
> > > > accesses should say so at kmalloc time". We literally have that
> > > > GFP_DMA and ZOME_DMA for various historical reasons, so we've been
> > > > able to do that before.
> > > >
> > > > No, that historical GFP_DMA isn't what arm64 wants - it's the old
> > > > crazy "legacy 16MB DMA" thing that ISA DMA used to have.
> > > >
> > > > But the basic issue was true then, and is true now - DMA allocations
> > > > are fairly special, and should not be that hard to just mark as such.
> > >
> > > "fairly special" == "all USB transactions", so it will take a lot of
> > > auditing here.  I think also many SPI controllers require this and maybe
> > > I2C?  Perhaps other bus types do as well.
> > >
> > > So please don't make this change without some way of figuring out just
> > > what drivers need to be fixed up, as it's going to be a lot...
> > >
> >
> > Yeah, the current de facto contract of being able to DMA map anything
> > that was allocated via the linear map makes it quite hard to enforce
> > the use of dma_kmalloc() for this.
> >
> > What we might do, given the fact that only inbound non-cache coherent
> > DMA is problematic, is dropping the kmalloc alignment to 8 like on
> > x86, and falling back to bounce buffering when a misaligned, non-cache
> > coherent inbound DMA mapping is created, using the SWIOTLB bounce
> > buffering code that we already have, and is already in use on most
> > affected systems for other reasons (i.e., DMA addressing limits)
>
> Ick, that's a mess.
>
> > This will cause some performance regressions, but in a way that seems
> > fixable to me: taking network drivers as an example, the RX buffers
> > that are filled using inbound DMA are typically owned by the driver
> > itself, which could be updated to round up its allocations and DMA
> > mappings. Block devices typically operate on quantities that are
> > aligned sufficiently already. In other cases, we will likely notice
> > if/when this fallback is taken on a hot path, but if we don't, at
> > least we know a bounce buffer is being used whenever we cannot perform
> > the DMA safely in-place.
>
> We can move to having an "allocator-per-bus" for memory like this to
> allow the bus to know if this is a DMA requirement or not.
>
> So for all USB drivers, we would have:
>         usb_kmalloc(size, flags);
> and then it might even be easier to verify with static tools that the
> USB drivers are sending only properly allocated data.  Same for SPI and
> other busses.
>

As I pointed out earlier in the thread, alignment/padding requirements
for non-coherent DMA are a property of the CPU's cache hierarchy, not
of the device. So I'm not sure I follow how a per-subsystem
distinction would help here. In the case of USB especially, would that
mean that block, media and networking subsystems would need to be
aware of the USB-ness of the underlying transport?

> https://lore.kernel.org/r/230a9486fc68ea0182df46255e42a51099403642.1648032613.git.christophe.leroy@csgroup.eu
> is an example of a SPI driver that has been there "for forever" yet
> always got it wrong.  If we could have had some way to know "only memory
> allocated with this function is allowed on the bus" that would have
> fixed the issue a long time ago.
>
> Anyway, just an idea, it's up to you all if this is worth it or not.
> Adding performance regressions at the expense of memory size feels like
> a rough trade-off to go through until things are fixed up.
>

Yeah, I hear you. But we already have distinct classes of memory,
i.e., vmalloc vs kmalloc, where only the latter is permitted for DMA
(which is why VMAP stack broke that SPI driver), and I'm not sure
adding more types is going to make this tractable going forward.
