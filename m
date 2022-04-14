Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6246501715
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241929AbiDNPUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347776AbiDNN7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:59:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52142ADD78
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 06:53:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFB9761E36
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 13:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7D2C385A9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 13:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649944386;
        bh=fGiKea3HNEw5JXDV2PTTJNXYtHuJBrMkih6xGRJRshY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=twNoeCqMgJ0nWqHCGUfbSz+ef1tYvn4jyhWEWnrk9vXIJwo8la4yhcnWAxHNi9jd9
         jzW+xApAezra8KYbvz2uDAbbhUy3PsbzS9IbmJJDLd3xcZyJJibki9MIa6WCwDQ900
         2UuVy1S+aIsjdfVkKCACSEj0aAuJp8mrrTaHBFx5f3/dAgTcNF8ExhOLSY7I6ntOUs
         F8bfII7DZU12RV7/7IyX3HMIqApj8ghOnZ7yjhB962qDyjdA1dv0+qWuCQZSwa6fVA
         Lj46M8RK799c+iBNnzrvSAyFD6XusJ2hEDDBV5VT8bo56wYZ838J36A9s5K2LBjCL4
         asTMnt9rgBndA==
Received: by mail-oi1-f182.google.com with SMTP id w127so5415159oig.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 06:53:06 -0700 (PDT)
X-Gm-Message-State: AOAM532CInd+alplxGutAgoj2qKbgRFNNdrgjTExHhBKZFfWJr0Sgh1Q
        St/fJxP1anx3Dr5NVtB0HF0HEYb3t4CgRTYwmcw=
X-Google-Smtp-Source: ABdhPJw5QtE/GX85YaVo/7SirG8M1THNaumOcNkM0p8q2w5uHOUPZSpdDXTGiIo2++Em9HgRc3WS+wxVtmIzZrwuASo=
X-Received: by 2002:a05:6808:1513:b0:2fa:7a40:c720 with SMTP id
 u19-20020a056808151300b002fa7a40c720mr1379987oiw.126.1649944385403; Thu, 14
 Apr 2022 06:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <Yk/6ts5sVDMDpKj3@arm.com> <Yk/8QExHlggU8KgC@gondor.apana.org.au>
 <YlVHSvkyUBXZPUr2@arm.com> <YlVJKjXkcHqkwyt4@gondor.apana.org.au>
 <YlVOTsaTVkBOxthG@arm.com> <YlVSBuEqMt2S1Gi6@gondor.apana.org.au>
 <YlVxGAHHD/j6lW3c@arm.com> <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com> <CAHk-=wjr9-n7vHiVdm-L-KX4kXWyY45++8jenFA1QV5oc=yhZg@mail.gmail.com>
 <YlezcPbFOkSUygBJ@kroah.com>
In-Reply-To: <YlezcPbFOkSUygBJ@kroah.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 14 Apr 2022 15:52:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFWJXbT+fMEx=wzX1wS6xW1DeGxZ+mWBbY8Z4hj4kc_dw@mail.gmail.com>
Message-ID: <CAMj1kXFWJXbT+fMEx=wzX1wS6xW1DeGxZ+mWBbY8Z4hj4kc_dw@mail.gmail.com>
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

On Thu, 14 Apr 2022 at 07:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Apr 13, 2022 at 09:53:24AM -1000, Linus Torvalds wrote:
> > On Tue, Apr 12, 2022 at 10:47 PM Catalin Marinas
> > <catalin.marinas@arm.com> wrote:
> > >
> > > I agree. There is also an implicit expectation that the DMA API works on
> > > kmalloc'ed buffers and that's what ARCH_DMA_MINALIGN is for (and the
> > > dynamic arch_kmalloc_minalign() in this series). But the key point is
> > > that the driver doesn't need to know the CPU cache topology, coherency,
> > > the DMA API and kmalloc() take care of these.
> >
> > Honestly, I think it would probably be worth discussing the "kmalloc
> > DMA alignment" issues.
> >
> > 99.9% of kmalloc users don't want to do DMA.
> >
> > And there's actually a fair amount of small kmalloc for random stuff.
> > Right now on my laptop, I have
> >
> >     kmalloc-8          16907  18432      8  512    1 : ...
> >
> > according to slabinfo, so almost 17 _thousand_ allocations of 8 bytes.
> >
> > It's all kinds of sad if those allocations need to be 64 bytes in size
> > just because of some silly DMA alignment issue, when none of them want
> > it.
> >

Actually, the alignment for non-cache coherent DMA is 128 bytes on
arm64, not 64 bytes.

> > Yeah, yeah, wasting a megabyte of memory is "just a megabyte" these
> > days. Which is crazy. It's literally memory that could have been used
> > for something much more useful than just pure and utter waste.
> >
> > I think we could and should just say "people who actually require DMA
> > accesses should say so at kmalloc time". We literally have that
> > GFP_DMA and ZOME_DMA for various historical reasons, so we've been
> > able to do that before.
> >
> > No, that historical GFP_DMA isn't what arm64 wants - it's the old
> > crazy "legacy 16MB DMA" thing that ISA DMA used to have.
> >
> > But the basic issue was true then, and is true now - DMA allocations
> > are fairly special, and should not be that hard to just mark as such.
>
> "fairly special" == "all USB transactions", so it will take a lot of
> auditing here.  I think also many SPI controllers require this and maybe
> I2C?  Perhaps other bus types do as well.
>
> So please don't make this change without some way of figuring out just
> what drivers need to be fixed up, as it's going to be a lot...
>

Yeah, the current de facto contract of being able to DMA map anything
that was allocated via the linear map makes it quite hard to enforce
the use of dma_kmalloc() for this.

What we might do, given the fact that only inbound non-cache coherent
DMA is problematic, is dropping the kmalloc alignment to 8 like on
x86, and falling back to bounce buffering when a misaligned, non-cache
coherent inbound DMA mapping is created, using the SWIOTLB bounce
buffering code that we already have, and is already in use on most
affected systems for other reasons (i.e., DMA addressing limits)

This will cause some performance regressions, but in a way that seems
fixable to me: taking network drivers as an example, the RX buffers
that are filled using inbound DMA are typically owned by the driver
itself, which could be updated to round up its allocations and DMA
mappings. Block devices typically operate on quantities that are
aligned sufficiently already. In other cases, we will likely notice
if/when this fallback is taken on a hot path, but if we don't, at
least we know a bounce buffer is being used whenever we cannot perform
the DMA safely in-place.
