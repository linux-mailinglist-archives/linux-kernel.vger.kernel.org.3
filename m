Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1C64F7B8B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243741AbiDGJ1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241322AbiDGJ1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:27:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B21F8BE14
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:25:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 323EBCE26CD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77837C385A0;
        Thu,  7 Apr 2022 09:25:13 +0000 (UTC)
Date:   Thu, 7 Apr 2022 10:25:10 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <Yk6t9jhof9MJV6TG@arm.com>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <20220405135758.774016-8-catalin.marinas@arm.com>
 <Yk5/FpCR10sndTR1@n131-248-037.byted.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk5/FpCR10sndTR1@n131-248-037.byted.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 02:14:15PM +0800, Muchun Song wrote:
> On Tue, Apr 05, 2022 at 02:57:55PM +0100, Catalin Marinas wrote:
> > ARCH_DMA_MINALIGN represents the minimum (static) alignment for safe DMA
> > operations while ARCH_KMALLOC_MINALIGN is the minimum kmalloc() objects
> > alignment.
> > 
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > ---
> >  include/linux/crypto.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/crypto.h b/include/linux/crypto.h
> > index 2324ab6f1846..654b9c355575 100644
> > --- a/include/linux/crypto.h
> > +++ b/include/linux/crypto.h
> > @@ -167,7 +167,7 @@
> >   * maintenance for non-coherent DMA (cache invalidation in particular) does not
> >   * affect data that may be accessed by the CPU concurrently.
> >   */
> > -#define CRYPTO_MINALIGN ARCH_KMALLOC_MINALIGN
> > +#define CRYPTO_MINALIGN ARCH_DMA_MINALIGN
> 
> I don't think this should be changed since ARCH_KMALLOC_MINALIGN is
> already aligned with the size what you need.

With this series, ARCH_KMALLOC_MINALIGN is no longer safe for
non-coherent DMA on all arm64 SoCs, that's what ARCH_DMA_MINALIGN will
cover.

Now, looking at the comment for CRYPTO_MINALIGN, one aspect it covers is
the minimum alignment required by C for the crypto_tfm structure access.
So a smaller ARCH_KMALLOC_MINALIGN would do. But the other part of the
comment mentions in-structure alignment for non-coherent DMA. Here we'd
need the upper bound alignment, ARCH_DMA_MINALIGN.

I'll follow up on Herbert's email as I think he has a good point on
structure vs kmalloc() alignment.

-- 
Catalin
