Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF35504747
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 10:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbiDQIxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 04:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiDQIxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 04:53:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10621A388
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 01:50:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B3C3B808C0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 08:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D38C385A4;
        Sun, 17 Apr 2022 08:50:54 +0000 (UTC)
Date:   Sun, 17 Apr 2022 09:50:50 +0100
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
Message-ID: <YlvU6ou14okbAbgW@arm.com>
References: <CAMj1kXH0x5Va7Wgs+mU1ONDwwsazOBuN4z4ihVzO2uG-n41Kbg@mail.gmail.com>
 <Ylko07++4naWJ5LE@gondor.apana.org.au>
 <CAMj1kXH=ybJWBzmMqkrkvyF8nM3UpTchUOq+oweW=BqW2TOyRw@mail.gmail.com>
 <YllE+wWqP6F+1nwa@gondor.apana.org.au>
 <CAMj1kXFjLbtpJLFh-C_k3Ydcg4M7NqrCfOXnBY2iSxusWtBLbA@mail.gmail.com>
 <YllM24eca/uxf9y7@gondor.apana.org.au>
 <CAMj1kXH5O32H1nnm6y7=3KiH7R-_oakxzBpZ20wK+8kaD46aKw@mail.gmail.com>
 <YlvK9iefUECy361O@gondor.apana.org.au>
 <YlvQTci7RP5evtTy@arm.com>
 <YlvRbvWSWMTtBJiN@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlvRbvWSWMTtBJiN@gondor.apana.org.au>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2022 at 04:35:58PM +0800, Herbert Xu wrote:
> On Sun, Apr 17, 2022 at 09:31:09AM +0100, Catalin Marinas wrote:
> >
> > Not with my series, the non-sharing of cache lines is preserved.
> > kmalloc() still returns objects aligned to a cache-line.
> > ARCH_DMA_MINALIGN was chosen as the cover-all value for all SoCs
> > supported but I want to reduce the kmalloc() alignment to a cache line
> > size if a platform has a cache line smaller than ARCH_DMA_MINALIGN (most
> > arm64 SoCs have a cache line of 64 bytes rather than 128).
> 
> OK, but then you don't need to play with CRYPTO_MINALIGN at all,
> right? All you need to do is add the padding between the Crypto
> API fields and the context structure, right?

Right, if that's what you prefer. Something like:

diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 2324ab6f1846..bb645b2f2718 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -645,7 +645,7 @@ struct crypto_tfm {
 	
 	struct crypto_alg *__crt_alg;
 
-	void *__crt_ctx[] CRYPTO_MINALIGN_ATTR;
+	void *__crt_ctx[] __aligned(ARCH_DMA_MINALIGN);
 };

But once we do that, are there any other CRYPTO_MINALIGN left around?

-- 
Catalin
