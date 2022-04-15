Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7D65027A1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351875AbiDOJyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiDOJyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:54:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE24B6E6B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 02:51:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B52876219F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 09:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5D7C385A6;
        Fri, 15 Apr 2022 09:51:43 +0000 (UTC)
Date:   Fri, 15 Apr 2022 10:51:40 +0100
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
Message-ID: <YllALIgZcQJ6asdA@arm.com>
References: <YlVHSvkyUBXZPUr2@arm.com>
 <YlVJKjXkcHqkwyt4@gondor.apana.org.au>
 <YlVOTsaTVkBOxthG@arm.com>
 <YlVSBuEqMt2S1Gi6@gondor.apana.org.au>
 <YlVxGAHHD/j6lW3c@arm.com>
 <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com>
 <YlkV7NtatO7KFusX@gondor.apana.org.au>
 <CAMj1kXFW_zC-U5Ox9_=4gKCwWOmkR7wPNb6UQhiz8viNWTRU-w@mail.gmail.com>
 <YlkkGpVx8rhcsBot@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlkkGpVx8rhcsBot@gondor.apana.org.au>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 03:51:54PM +0800, Herbert Xu wrote:
> On Fri, Apr 15, 2022 at 09:49:12AM +0200, Ard Biesheuvel wrote:
> > I'm not sure I understand what would go wrong if that assumption no
> > longer holds.
> 
> It's very simple, we don't do anything to the pointer returned
> by kmalloc before returning it as a tfm or other object with
> an alignment of CRYPTO_MINALIGN.  IOW if kmalloc starts returning
> pointers that are not aligned to CRYPTO_MINALIGN then we'd be
> lying to the compiler.

I agree that it would be lying to the compiler, but I don't think this
matters for arm64 where the CPU can do unaligned accesses just fine. We
don't even end up with unaligned accesses here. Let's say we have:

struct x {
	...
} __attribute__ ((__aligned__ (128)));

and the kmalloc(sizeof(struct x)) returns a 64-byte aligned pointer. The
compiler-generated code won't have any problem on arm64 accessing the
struct x members. As I said a few times, it's not affecting any other
architecture and not breaking arm64 either.

Anyway, let's agree to disagree. I'll look into keeping CRYPTO_MINALIGN
as ARCH_KMALLOC_MINALIGN and introduce a CRYPTO_DMA_MINALIGN (or just
use ARCH_DMA_MINALIGN directly) together with something like Linus'
dma_kmalloc() in places where an object aligned to ARCH_DMA_MINALIGN is
needed in the crypto code.

-- 
Catalin
