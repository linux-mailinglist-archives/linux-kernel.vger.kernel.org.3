Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392F5505C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346405AbiDRQr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346373AbiDRQrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:47:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E934CE08
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:44:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37923B80FE4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFFFC385A7;
        Mon, 18 Apr 2022 16:44:40 +0000 (UTC)
Date:   Mon, 18 Apr 2022 17:44:37 +0100
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
Message-ID: <Yl2Vda/8S7qAvMjC@arm.com>
References: <CAMj1kXFjLbtpJLFh-C_k3Ydcg4M7NqrCfOXnBY2iSxusWtBLbA@mail.gmail.com>
 <YllM24eca/uxf9y7@gondor.apana.org.au>
 <CAMj1kXH5O32H1nnm6y7=3KiH7R-_oakxzBpZ20wK+8kaD46aKw@mail.gmail.com>
 <YlvK9iefUECy361O@gondor.apana.org.au>
 <YlvQTci7RP5evtTy@arm.com>
 <YlvRbvWSWMTtBJiN@gondor.apana.org.au>
 <YlvU6ou14okbAbgW@arm.com>
 <YlvWtc/dJ6luXzZf@gondor.apana.org.au>
 <YlxAo5BAy+ARlvqj@arm.com>
 <Yl0jPdfdUkaStDN5@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl0jPdfdUkaStDN5@gondor.apana.org.au>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 04:37:17PM +0800, Herbert Xu wrote:
> On Sun, Apr 17, 2022 at 05:30:27PM +0100, Catalin Marinas wrote:
> > Do you mean as per Ard's proposal here:
> > 
> > https://lore.kernel.org/r/CAMj1kXH0x5Va7Wgs+mU1ONDwwsazOBuN4z4ihVzO2uG-n41Kbg@mail.gmail.com
> > 
> > struct crypto_request {
> > 	union {
> > 		struct {
> > 			... fields ...
> > 		};
> > 		u8 __padding[ARCH_DMA_MINALIGN];
> > 	};
> > 	void __ctx[]  __aligned(CRYPTO_MINALIGN);
> > };
> > 
> > If CRYPTO_MINALIGN is lowered to, say, 8 (to be the same as lowest
> > ARCH_KMALLOC_MINALIGN), the __alignof__(req->__ctx) would be 8.
> > Functions like crypto_tfm_ctx_alignment() will return 8 when what you
> > need is 128. We can change those functions to return ARCH_DMA_MINALIGN
> > instead or always bump cra_alignmask to ARCH_DMA_MINALIGN-1.
> 
> OK, at this point I think we need to let the code do the talking :)
> 
> I've seen Ard's patches already and I think I understand what your
> needs are.  So let me whip up some code to show you guys what I
> think needs to be done.

BTW before you have a go at this, there's also Linus' idea that does not
change the crypto code (at least not functionally). Of course, you and
Ard can still try to figure out how to reduce the padding but if we go
with Linus' idea of a new GFP_NODMA flag, there won't be any changes to
the crypto code as long as it doesn't pass such flag. So, the options:

1. Change ARCH_KMALLOC_MINALIGN to 8 (or ARCH_SLAB_MINALIGN if higher)
   while keeping ARCH_DMA_MINALIGN to 128. By default kmalloc() will
   honour the 128-byte alignment, unless GDP_NODMA is passed. This still
   requires changing CRYPTO_MINALIGN to ARCH_DMA_MINALIGN but there is
   no functional change, kmalloc() without the new flag will return
   CRYPTO_MINALIGN-aligned pointers.

2. Leave ARCH_KMALLOC_MINALIGN as ARCH_DMA_MINALIGN (128) and introduce
   a new GFP_PACKED (I think it fits better than 'NODMA') flag that
   reduces the minimum kmalloc() below ARCH_KMALLOC_MINALIGN (and
   probably at least ARCH_SLAB_MINALIGN). It's equivalent to (1) but
   does not touch the crypto code at all.

(1) and (2) are the same, just minor naming difference. Happy to go with
any of them. They still have the downside that we need to add the new
GFP_ flag to those hotspots that allocate small objects (Arnd provided
an idea on how to find them with ftrace) but at least we know it won't
inadvertently break anything.

-- 
Catalin
