Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7694FE152
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbiDLM7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355121AbiDLM5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:57:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7368459A74
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:31:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01532B81CD8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDBAC385A5;
        Tue, 12 Apr 2022 12:31:23 +0000 (UTC)
Date:   Tue, 12 Apr 2022 13:31:20 +0100
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
Message-ID: <YlVxGAHHD/j6lW3c@arm.com>
References: <Yk7EbvYhwnQy+pAf@arm.com>
 <Yk7Ny/iFi0NrMXTg@gondor.apana.org.au>
 <Yk8RGvF6ik34C6BO@arm.com>
 <Yk+rKWEcc9rO+A25@gondor.apana.org.au>
 <Yk/6ts5sVDMDpKj3@arm.com>
 <Yk/8QExHlggU8KgC@gondor.apana.org.au>
 <YlVHSvkyUBXZPUr2@arm.com>
 <YlVJKjXkcHqkwyt4@gondor.apana.org.au>
 <YlVOTsaTVkBOxthG@arm.com>
 <YlVSBuEqMt2S1Gi6@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlVSBuEqMt2S1Gi6@gondor.apana.org.au>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 06:18:46PM +0800, Herbert Xu wrote:
> On Tue, Apr 12, 2022 at 11:02:54AM +0100, Catalin Marinas wrote:
> > This series does not penalise any architecture. It doesn't even make
> > arm64 any worse than it currently is.
> 
> Right, the patch as it stands doesn't change anything.  However,
> it is also broken as it stands.  As I said before, CRYPTO_MINALIGN
> is not something that is guaranteed by the Crypto API, it is simply
> a statement of whatever kmalloc returns.

I agree that CRYPTO_MINALIGN is not guaranteed by the Crypto API. What
I'm debating is the intended use for CRYPTO_MINALIGN in some (most?) of
the drivers. It's not just about kmalloc() but also a build-time offset
of buffers within structures to guarantee DMA safety. This can't be
fixed by cra_alignmask.

We could leave CRYPTO_MINALIGN as ARCH_KMALLOC_MINALIGN and that matches
it being just a statement of the kmalloc() minimum alignment. But since
it is also overloaded with the DMA in-structure offset alignment, we'd
need a new CRYPTO_DMA_MINALIGN (and _ATTR) to annotate those structures.
I have a suspicion there'll be fewer of the original CRYPTO_MINALIGN
uses left, hence my approach to making this bigger from the start.

There's also Ard's series introducing CRYPTO_REQ_MINALIGN while leaving
CRYPT_MINALIGN for DMA-safe offsets (IIUC):

https://lore.kernel.org/r/20220406142715.2270256-1-ardb@kernel.org

> So if kmalloc is no longer returning CRYPTO_MINALIGN-aligned
> memory, then those drivers that need this alignment for DMA
> will break anyway.

No. As per one of my previous emails, kmalloc() will preserve the DMA
alignment for an SoC even if smaller than CRYPTO_MINALIGN (or a new
CRYPTO_DMA_MINALIGN). Since kmalloc() returns DMA-safe pointers and
CRYPTO_MINALIGN (or a new CRYPTO_DMA_MINALIGN) is DMA-safe, so would an
offset from a pointer returned by kmalloc().

> If you want the Crypto API to guarantee alignment over and above
> that returned by kmalloc, the correct way is to use cra_alignmask.

For kmalloc(), this would work, but for the current CRYPTO_MINALIGN_ATTR
uses it won't.

Thanks.

-- 
Catalin
