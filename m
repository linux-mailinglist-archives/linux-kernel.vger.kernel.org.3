Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F984FEB0E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiDLXTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiDLXTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:19:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E068F9B9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:07:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB16761A55
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DBCC385A6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649800898;
        bh=ydy77pfGsEmNO9TqK6T8vC6NHRGjR+yzvIsPTZVIUk0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pTUsq8HYKKgWnruu2r387ZlfiaNYe8bCUA04lKnWF1djMsvX3q7xmjwF97tRqQwKa
         aPjrWexfHLMGKy4Lxm39ynDkyimCrePiSv+LeSAWsNV9c3Pduj8DHlKQC+pnzrMHzw
         wUtpz2daFHJS7LfSTF9aCGH/p7BE8iW4hIsuIIFlguo+/vYCUcDsL6aTjvQcNnr0qg
         tR1Ozk2hWrO/jYzgGpt3LLsZw8ZXyEe8cEb2puJnBlyFuWbGKQMCVzoUl2sAzUrVaZ
         Nc6pggCkRz0HlyjAmYUGxOv051pl9nsmHJmTX33vqZNpy4ARJtav/vFYci5BO9vebo
         iNg5OtJiPuXuQ==
Received: by mail-oi1-f176.google.com with SMTP id w127so142589oig.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:01:38 -0700 (PDT)
X-Gm-Message-State: AOAM532GFekIcMXEPgJkDHztKjBgRgUkaSOYdY+oQelTHKkeoFRxJIOq
        iREMEzPk2iaaikGDdjO4o0JmvKScmxoyMW10SDo=
X-Google-Smtp-Source: ABdhPJwc13ovayq2njvov3t6qnbxbqC/vBF8C0cpvVrQN0L/QGvKCDndhyuRyhaeEnWznZibNtWFDf0lugthvaid4qg=
X-Received: by 2002:aca:674c:0:b0:2d9:c460:707c with SMTP id
 b12-20020aca674c000000b002d9c460707cmr2813613oiy.126.1649800897252; Tue, 12
 Apr 2022 15:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <Yk7EbvYhwnQy+pAf@arm.com> <Yk7Ny/iFi0NrMXTg@gondor.apana.org.au>
 <Yk8RGvF6ik34C6BO@arm.com> <Yk+rKWEcc9rO+A25@gondor.apana.org.au>
 <Yk/6ts5sVDMDpKj3@arm.com> <Yk/8QExHlggU8KgC@gondor.apana.org.au>
 <YlVHSvkyUBXZPUr2@arm.com> <YlVJKjXkcHqkwyt4@gondor.apana.org.au>
 <YlVOTsaTVkBOxthG@arm.com> <YlVSBuEqMt2S1Gi6@gondor.apana.org.au> <YlVxGAHHD/j6lW3c@arm.com>
In-Reply-To: <YlVxGAHHD/j6lW3c@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 13 Apr 2022 00:01:25 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
Message-ID: <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
To:     Catalin Marinas <catalin.marinas@arm.com>
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

On Tue, 12 Apr 2022 at 14:31, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Apr 12, 2022 at 06:18:46PM +0800, Herbert Xu wrote:
> > On Tue, Apr 12, 2022 at 11:02:54AM +0100, Catalin Marinas wrote:
> > > This series does not penalise any architecture. It doesn't even make
> > > arm64 any worse than it currently is.
> >
> > Right, the patch as it stands doesn't change anything.  However,
> > it is also broken as it stands.  As I said before, CRYPTO_MINALIGN
> > is not something that is guaranteed by the Crypto API, it is simply
> > a statement of whatever kmalloc returns.
>
> I agree that CRYPTO_MINALIGN is not guaranteed by the Crypto API. What
> I'm debating is the intended use for CRYPTO_MINALIGN in some (most?) of
> the drivers. It's not just about kmalloc() but also a build-time offset
> of buffers within structures to guarantee DMA safety. This can't be
> fixed by cra_alignmask.
>
> We could leave CRYPTO_MINALIGN as ARCH_KMALLOC_MINALIGN and that matches
> it being just a statement of the kmalloc() minimum alignment. But since
> it is also overloaded with the DMA in-structure offset alignment, we'd
> need a new CRYPTO_DMA_MINALIGN (and _ATTR) to annotate those structures.
> I have a suspicion there'll be fewer of the original CRYPTO_MINALIGN
> uses left, hence my approach to making this bigger from the start.
>
> There's also Ard's series introducing CRYPTO_REQ_MINALIGN while leaving
> CRYPT_MINALIGN for DMA-safe offsets (IIUC):
>
> https://lore.kernel.org/r/20220406142715.2270256-1-ardb@kernel.org
>
> > So if kmalloc is no longer returning CRYPTO_MINALIGN-aligned
> > memory, then those drivers that need this alignment for DMA
> > will break anyway.
>

One thing to note here is that minimum DMA *alignment* is not the same
as the padding to cache writeback granule (CWG) that is needed when
dealing with non-cache coherent inbound DMA.

The former is typically a property of the peripheral IP, and is
something that the driver needs to deal with, potentially by setting
cra_alignmask to ensure that the input and output buffers are placed
such that they can accessed via DMA by the peripheral.

The latter is a property of the CPU's cache hierarchy, not only the
size of the CWG, but also whether or not DMA is cache coherent to
begin with. This is not something the driver should usually have to
care about if it uses the DMA API correctly.

The reason why CRYPTO_MINALIGN matters for DMA in spite of this is
that some drivers not only use DMA for processing the bulk of the data
(typically presented using scatterlists) but sometimes also use DMA to
map parts of the request and TFM structures, which carry control data
used by the CPU to manage the crypto requests. Doing a non-coherent
DMA write into such a structure may blow away 64 or 128 bytes of data,
even if the write itself is much smaller, due to the fact that we need
to perform cache invalidation in order for the CPU to be able to
observe what the device wrote to that memory, and the invalidated
cache lines may be shared with other data items, and may become dirty
while the DMA mapping is active.

This is what I am addressing with my patch series, i.e., padding out
the driver owned parts of the struct to the CWG size so that cache
invalidation does not affect data owned by other layers in the crypto
cake, but only at runtime. By doing this consistently for TFM and
request structures, we should be able to disregard ARCH_DMA_MINALIGN
entirely when it comes to defining CRYPTO_MINALIGN, as it is highly
unlikely that any of these peripherals would require more than 8 or 16
bytes of alignment for the DMA operations themselves.




> No. As per one of my previous emails, kmalloc() will preserve the DMA
> alignment for an SoC even if smaller than CRYPTO_MINALIGN (or a new
> CRYPTO_DMA_MINALIGN). Since kmalloc() returns DMA-safe pointers and
> CRYPTO_MINALIGN (or a new CRYPTO_DMA_MINALIGN) is DMA-safe, so would an
> offset from a pointer returned by kmalloc().
>
> > If you want the Crypto API to guarantee alignment over and above
> > that returned by kmalloc, the correct way is to use cra_alignmask.
>
> For kmalloc(), this would work, but for the current CRYPTO_MINALIGN_ATTR
> uses it won't.
>
> Thanks.
>
> --
> Catalin
