Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C335D502871
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 12:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352365AbiDOKsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 06:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242993AbiDOKsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:48:35 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8E5BCB75
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 03:46:06 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1nfJSV-003GU9-5k; Fri, 15 Apr 2022 20:45:48 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 15 Apr 2022 18:45:47 +0800
Date:   Fri, 15 Apr 2022 18:45:47 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <YllM24eca/uxf9y7@gondor.apana.org.au>
References: <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com>
 <YlkV7NtatO7KFusX@gondor.apana.org.au>
 <CAMj1kXFW_zC-U5Ox9_=4gKCwWOmkR7wPNb6UQhiz8viNWTRU-w@mail.gmail.com>
 <YlkkGpVx8rhcsBot@gondor.apana.org.au>
 <CAMj1kXH0x5Va7Wgs+mU1ONDwwsazOBuN4z4ihVzO2uG-n41Kbg@mail.gmail.com>
 <Ylko07++4naWJ5LE@gondor.apana.org.au>
 <CAMj1kXH=ybJWBzmMqkrkvyF8nM3UpTchUOq+oweW=BqW2TOyRw@mail.gmail.com>
 <YllE+wWqP6F+1nwa@gondor.apana.org.au>
 <CAMj1kXFjLbtpJLFh-C_k3Ydcg4M7NqrCfOXnBY2iSxusWtBLbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFjLbtpJLFh-C_k3Ydcg4M7NqrCfOXnBY2iSxusWtBLbA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 12:22:27PM +0200, Ard Biesheuvel wrote:
>
> Subsequent objects are owned by the driver, and it is the
> responsibility of the driver not to modify the fields while it is also
> mapped for DMA (and we have had issues in the past where drivers
> violated this rule). So as long as ARCH_KMALLOC_ALIGN guarantees
> actual DMA minimum alignment for both the start and the end, we
> shouldn't need any explicit padding at the end.

I don't understand why this is guaranteed.  The driver context
size is arbitrary so it could end in the middle of a cacheline.
The slab allocator could well lay it out so that the next kmalloc
object starts right after the end of the context, in which case
they would share a cache-line.

The next kmalloc object could be (and in fact is likely to be)
of the same type.

Previously this wasn't possible because kmalloc guaranteed
alignment.

> I'l do a scan of drivers/crypto to figure out how much we are relying
> on this to begin with.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
