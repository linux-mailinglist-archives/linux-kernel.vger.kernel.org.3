Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CAD4FDCC4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbiDLKjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352529AbiDLKdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:33:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBE224BC4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:33:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE239617DA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E77CC385A5;
        Tue, 12 Apr 2022 09:33:02 +0000 (UTC)
Date:   Tue, 12 Apr 2022 10:32:58 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <YlVHSvkyUBXZPUr2@arm.com>
References: <YkzJP6zmkAhc6CI9@gondor.apana.org.au>
 <CAMj1kXEXhFmGc4VTTcJU1YFsHJhZN44OdJ5Suf2ONG5=LR29HQ@mail.gmail.com>
 <Yk1UJs6eZMoIp3Eh@arm.com>
 <Yk5o/lNTyiJWD4Ae@gondor.apana.org.au>
 <Yk7EbvYhwnQy+pAf@arm.com>
 <Yk7Ny/iFi0NrMXTg@gondor.apana.org.au>
 <Yk8RGvF6ik34C6BO@arm.com>
 <Yk+rKWEcc9rO+A25@gondor.apana.org.au>
 <Yk/6ts5sVDMDpKj3@arm.com>
 <Yk/8QExHlggU8KgC@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk/8QExHlggU8KgC@gondor.apana.org.au>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 05:11:28PM +0800, Herbert Xu wrote:
> On Fri, Apr 08, 2022 at 10:04:54AM +0100, Catalin Marinas wrote:
> > My point is that if the crypto code kmallocs a size aligned to
> > crypto_tfm_ctx_alignment() (and CRYPTO_MINALIGN), the slab allocator
> > will return memory aligned to CRYPTO_MINALIGN even if
> > ARCH_KMALLOC_MINALIGN is smaller.
> 
> No we don't align the size to CRYPTO_MINALIGN at all.  We simply
> assume that this is the alignment returned by kmalloc.
> 
> > Would the crypto code, say, do a kmalloc(64) and expect a 128 byte
> > alignment (when CRYPTO_MINALIGN == 128)? Or does it align the size to
> > CRYPTO_MINALIGN and do a kmalloc(128) directly? If it's the latter, I
> > don't think there's a problem.
> 
> It's the former.

Does this only matter for DMA? If there other unrelated alignment
requirements, I think those drivers should be fixed for their own
cra_alignmask independent of the CPU cache line and DMA needs (e.g.
some 1024-bit vectors that would benefit from an aligned load).

With this series, the dynamic arch_kmalloc_minalign() still provides the
DMA-safe alignment even if it would be smaller than the default
CRYPTO_MINALIGN of 128. Let's say we have a structure:

struct crypto_something {
	u8	some_field;
	u8	data[] CRYPTO_MINALIGN_ATTR;
};

The sizeof(struct crypto_something) is automatically a multiple of
CRYPTO_MINALIGN (128 bytes for arm64). While kmalloc() could return a
smaller alignment, arch_kmalloc_minalign(), the data pointer above is
still aligned to arch_kmalloc_minalign() and DMA-safe since
CRYPTO_MINALIGN is a multiple of this (similar to the struct devres
case, https://lore.kernel.org/all/YlRn2Wal4ezjvomZ@arm.com/).

Even if such struct is included in another struct, the alignment and
sizeof is inherited by the containing object.

So let's assume the driver needs 64 bytes of data in addition to the
struct, it would allocate:

	kmalloc(sizeof(struct crypto_something) + 64);

Prior to this series, kmalloc() would return a 256-byte aligned pointer.
With this series, if the cache line size on a SoC is 64-byte, the
allocation falls under the kmalloc-192 cache, so 'data' would be 64-byte
aligned which is safe for DMA.

> I think you can still make the change you want, but first you need
> to modify the affected drivers to specify their actual alignment
> requirement explicitly through cra_alignmask and then use the
> correct methods to access the context pointer.

At a quick grep, most cra_alignmask values are currently 15 or smaller.
I'm not convinced the driver needs to know about the CPU cache
alignment. We could set cra_alignmask to CRYPTO_MINALIGN but that would
incur unnecessary overhead via function like setkey_unaligned() when the
arch_kmalloc_minalign() was already sufficient for DMA safety.

Maybe I miss some use-cases or I focus too much on DMA safety.

Thanks.

-- 
Catalin
