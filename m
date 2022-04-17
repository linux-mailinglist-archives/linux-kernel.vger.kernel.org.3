Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DB250473E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 10:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbiDQIlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 04:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiDQIlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 04:41:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9162E63F5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 01:38:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 425A3B80AAD
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 08:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B32C385A4;
        Sun, 17 Apr 2022 08:38:43 +0000 (UTC)
Date:   Sun, 17 Apr 2022 09:38:40 +0100
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
Message-ID: <YlvSEHul1Rv3Ap34@arm.com>
References: <YlVSBuEqMt2S1Gi6@gondor.apana.org.au>
 <YlVxGAHHD/j6lW3c@arm.com>
 <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com>
 <YlkV7NtatO7KFusX@gondor.apana.org.au>
 <CAMj1kXFW_zC-U5Ox9_=4gKCwWOmkR7wPNb6UQhiz8viNWTRU-w@mail.gmail.com>
 <YlkkGpVx8rhcsBot@gondor.apana.org.au>
 <YllALIgZcQJ6asdA@arm.com>
 <YlllpH+PB8XVUn6h@arm.com>
 <YlvLqkIdrCp/rOsG@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlvLqkIdrCp/rOsG@gondor.apana.org.au>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2022 at 04:11:22PM +0800, Herbert Xu wrote:
> On Fri, Apr 15, 2022 at 01:31:32PM +0100, Catalin Marinas wrote:
> >
> > This needs a clarification. For the above structure, kmalloc() will
> > return a 128-byte aligned pointer since sizeof(x) is a multiple of 128.
> > The potential problem is if you have something like:
> > 
> > 	kmalloc(sizeof(struct x) + 64);
> > 
> > The above could end up as a kmalloc(192) which is available with an
> > ARCH_KMALLOC_MINALIGN of 64. If that's a real use-case, I can change the
> > slab patch to not create the 192 (or 48 if we go for an even smaller
> > ARCH_KMALLOC_MINALIGN) caches and we'd always have ARCH_DMA_MINALIGN
> > guarantee if the structure itself is correctly aligned. No lying to the
> > compiler.
> 
> Yes I suppose that should work:
> 
> 1) Enlarge each crypto API object so that they're >= 128 bytes;

I don't think we need to do anything here. A structure like:

struct x {
	char y;
	char z[] CRYPTO_MINALIGN_ATTR;
};

is already of size 128. Without CRYPTO_MINALIGN_ATTR, its size would be
1 but otherwise the whole structure inherits the alignment of its
member and this translates into an aligned size.

> 2) Modify kmalloc so that for sizes >= 128 bytes they're padded
> to multiples of 128.

This doesn't look like a hack, we want to honour the power of 2
alignments.

-- 
Catalin
