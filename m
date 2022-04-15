Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A8D5029F7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353706AbiDOMfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353634AbiDOMfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:35:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F60C8BF1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:31:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2402A61CEE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 12:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78417C385A6;
        Fri, 15 Apr 2022 12:31:35 +0000 (UTC)
Date:   Fri, 15 Apr 2022 13:31:32 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <YlllpH+PB8XVUn6h@arm.com>
References: <YlVJKjXkcHqkwyt4@gondor.apana.org.au>
 <YlVOTsaTVkBOxthG@arm.com>
 <YlVSBuEqMt2S1Gi6@gondor.apana.org.au>
 <YlVxGAHHD/j6lW3c@arm.com>
 <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com>
 <YlkV7NtatO7KFusX@gondor.apana.org.au>
 <CAMj1kXFW_zC-U5Ox9_=4gKCwWOmkR7wPNb6UQhiz8viNWTRU-w@mail.gmail.com>
 <YlkkGpVx8rhcsBot@gondor.apana.org.au>
 <YllALIgZcQJ6asdA@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YllALIgZcQJ6asdA@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 10:51:40AM +0100, Catalin Marinas wrote:
> On Fri, Apr 15, 2022 at 03:51:54PM +0800, Herbert Xu wrote:
> > On Fri, Apr 15, 2022 at 09:49:12AM +0200, Ard Biesheuvel wrote:
> > > I'm not sure I understand what would go wrong if that assumption no
> > > longer holds.
> > 
> > It's very simple, we don't do anything to the pointer returned
> > by kmalloc before returning it as a tfm or other object with
> > an alignment of CRYPTO_MINALIGN.  IOW if kmalloc starts returning
> > pointers that are not aligned to CRYPTO_MINALIGN then we'd be
> > lying to the compiler.
> 
> I agree that it would be lying to the compiler, but I don't think this
> matters for arm64 where the CPU can do unaligned accesses just fine. We
> don't even end up with unaligned accesses here. Let's say we have:
> 
> struct x {
> 	...
> } __attribute__ ((__aligned__ (128)));
> 
> and the kmalloc(sizeof(struct x)) returns a 64-byte aligned pointer.

This needs a clarification. For the above structure, kmalloc() will
return a 128-byte aligned pointer since sizeof(x) is a multiple of 128.
The potential problem is if you have something like:

	kmalloc(sizeof(struct x) + 64);

The above could end up as a kmalloc(192) which is available with an
ARCH_KMALLOC_MINALIGN of 64. If that's a real use-case, I can change the
slab patch to not create the 192 (or 48 if we go for an even smaller
ARCH_KMALLOC_MINALIGN) caches and we'd always have ARCH_DMA_MINALIGN
guarantee if the structure itself is correctly aligned. No lying to the
compiler.

-- 
Catalin
