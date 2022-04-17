Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39D0504854
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 18:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbiDQQdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 12:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbiDQQdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 12:33:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627CEA199
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 09:30:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EF8DB80CBF
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 16:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B171CC385A4;
        Sun, 17 Apr 2022 16:30:30 +0000 (UTC)
Date:   Sun, 17 Apr 2022 17:30:27 +0100
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
Message-ID: <YlxAo5BAy+ARlvqj@arm.com>
References: <CAMj1kXH=ybJWBzmMqkrkvyF8nM3UpTchUOq+oweW=BqW2TOyRw@mail.gmail.com>
 <YllE+wWqP6F+1nwa@gondor.apana.org.au>
 <CAMj1kXFjLbtpJLFh-C_k3Ydcg4M7NqrCfOXnBY2iSxusWtBLbA@mail.gmail.com>
 <YllM24eca/uxf9y7@gondor.apana.org.au>
 <CAMj1kXH5O32H1nnm6y7=3KiH7R-_oakxzBpZ20wK+8kaD46aKw@mail.gmail.com>
 <YlvK9iefUECy361O@gondor.apana.org.au>
 <YlvQTci7RP5evtTy@arm.com>
 <YlvRbvWSWMTtBJiN@gondor.apana.org.au>
 <YlvU6ou14okbAbgW@arm.com>
 <YlvWtc/dJ6luXzZf@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlvWtc/dJ6luXzZf@gondor.apana.org.au>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2022 at 04:58:29PM +0800, Herbert Xu wrote:
> On Sun, Apr 17, 2022 at 09:50:50AM +0100, Catalin Marinas wrote:
> >
> > Right, if that's what you prefer. Something like:
> > 
> > diff --git a/include/linux/crypto.h b/include/linux/crypto.h
> > index 2324ab6f1846..bb645b2f2718 100644
> > --- a/include/linux/crypto.h
> > +++ b/include/linux/crypto.h
> > @@ -645,7 +645,7 @@ struct crypto_tfm {
> >  	
> >  	struct crypto_alg *__crt_alg;
> >  
> > -	void *__crt_ctx[] CRYPTO_MINALIGN_ATTR;
> > +	void *__crt_ctx[] __aligned(ARCH_DMA_MINALIGN);
> >  };
> > 
> > But once we do that, are there any other CRYPTO_MINALIGN left around?
> 
> This is still implying the whole structure is aligned to the given
> value, which it is not.
> 
> Please just add the padding as needed.

Do you mean as per Ard's proposal here:

https://lore.kernel.org/r/CAMj1kXH0x5Va7Wgs+mU1ONDwwsazOBuN4z4ihVzO2uG-n41Kbg@mail.gmail.com

struct crypto_request {
	union {
		struct {
			... fields ...
		};
		u8 __padding[ARCH_DMA_MINALIGN];
	};
	void __ctx[]  __aligned(CRYPTO_MINALIGN);
};

If CRYPTO_MINALIGN is lowered to, say, 8 (to be the same as lowest
ARCH_KMALLOC_MINALIGN), the __alignof__(req->__ctx) would be 8.
Functions like crypto_tfm_ctx_alignment() will return 8 when what you
need is 128. We can change those functions to return ARCH_DMA_MINALIGN
instead or always bump cra_alignmask to ARCH_DMA_MINALIGN-1.

-- 
Catalin
