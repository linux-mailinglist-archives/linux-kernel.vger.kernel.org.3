Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2B9504DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 10:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbiDRIk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 04:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiDRIk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:40:26 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0796A1903C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 01:37:47 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1ngMsn-003w82-F8; Mon, 18 Apr 2022 18:37:18 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 18 Apr 2022 16:37:17 +0800
Date:   Mon, 18 Apr 2022 16:37:17 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Message-ID: <Yl0jPdfdUkaStDN5@gondor.apana.org.au>
References: <YllE+wWqP6F+1nwa@gondor.apana.org.au>
 <CAMj1kXFjLbtpJLFh-C_k3Ydcg4M7NqrCfOXnBY2iSxusWtBLbA@mail.gmail.com>
 <YllM24eca/uxf9y7@gondor.apana.org.au>
 <CAMj1kXH5O32H1nnm6y7=3KiH7R-_oakxzBpZ20wK+8kaD46aKw@mail.gmail.com>
 <YlvK9iefUECy361O@gondor.apana.org.au>
 <YlvQTci7RP5evtTy@arm.com>
 <YlvRbvWSWMTtBJiN@gondor.apana.org.au>
 <YlvU6ou14okbAbgW@arm.com>
 <YlvWtc/dJ6luXzZf@gondor.apana.org.au>
 <YlxAo5BAy+ARlvqj@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlxAo5BAy+ARlvqj@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2022 at 05:30:27PM +0100, Catalin Marinas wrote:
>
> Do you mean as per Ard's proposal here:
> 
> https://lore.kernel.org/r/CAMj1kXH0x5Va7Wgs+mU1ONDwwsazOBuN4z4ihVzO2uG-n41Kbg@mail.gmail.com
> 
> struct crypto_request {
> 	union {
> 		struct {
> 			... fields ...
> 		};
> 		u8 __padding[ARCH_DMA_MINALIGN];
> 	};
> 	void __ctx[]  __aligned(CRYPTO_MINALIGN);
> };
> 
> If CRYPTO_MINALIGN is lowered to, say, 8 (to be the same as lowest
> ARCH_KMALLOC_MINALIGN), the __alignof__(req->__ctx) would be 8.
> Functions like crypto_tfm_ctx_alignment() will return 8 when what you
> need is 128. We can change those functions to return ARCH_DMA_MINALIGN
> instead or always bump cra_alignmask to ARCH_DMA_MINALIGN-1.

OK, at this point I think we need to let the code do the talking :)

I've seen Ard's patches already and I think I understand what your
needs are.  So let me whip up some code to show you guys what I
think needs to be done.

Please bear with me for a few days.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
