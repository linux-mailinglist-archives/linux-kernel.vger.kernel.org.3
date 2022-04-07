Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B854F7D74
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbiDGLDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiDGLDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:03:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702FB10FDC9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 04:01:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3688B826B8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 11:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5464BC385A4;
        Thu,  7 Apr 2022 11:01:06 +0000 (UTC)
Date:   Thu, 7 Apr 2022 12:01:02 +0100
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
Message-ID: <Yk7EbvYhwnQy+pAf@arm.com>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <20220405135758.774016-8-catalin.marinas@arm.com>
 <YkzJP6zmkAhc6CI9@gondor.apana.org.au>
 <CAMj1kXEXhFmGc4VTTcJU1YFsHJhZN44OdJ5Suf2ONG5=LR29HQ@mail.gmail.com>
 <Yk1UJs6eZMoIp3Eh@arm.com>
 <Yk5o/lNTyiJWD4Ae@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk5o/lNTyiJWD4Ae@gondor.apana.org.au>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 02:30:54PM +1000, Herbert Xu wrote:
> On Wed, Apr 06, 2022 at 09:49:42AM +0100, Catalin Marinas wrote:
> > is any change to the crypto code.
> 
> But the crypto API assumes that memory returned by kmalloc is
> automatically aligned to CRYPTO_MINALIGN, would this still be
> the case if you change it to ARCH_DMA_MINALIGN?

No but I think that's a valid point. Taking the crypto_tfm structure as
an example with ARCH_DMA_MINALIGN of 128:

#define CRYPTO_MINALIGN 128
#define CRYPTO_MINALIGN_ATTR __attribute__ ((__aligned__(CRYPTO_MINALIGN)))

struct crypto_tfm {
	u32 crt_flags;
	int node;
	void (*exit)(struct crypto_tfm *tfm);
	struct crypto_alg *__crt_alg;
	void *__crt_ctx[] CRYPTO_MINALIGN_ATTR;
};

The alignof(struct crypto_tfm) is 128. However, a kmalloc() would only
guarantee the smaller ARCH_KMALLOC_MINALIGN which, after this series,
would be 64 for arm64. From the DMA perspective there's no issue with
the smaller kmalloc() alignment since, if a crypto_tfm pointer is
DMA-aligned for the hardware it is running on, so would __ctr_ctx[] at
an offset multiple of the dynamic DMA alignment. If we used
ARCH_KMALLOC_MINALIGN instead and the hardware alignment requirement was
larger, than we would have a potential problem with non-coherent DMA.

The only issue is whether the compiler gets confused by a pointer to a
structure with a smaller alignment than alignof(struct ...). I don't see
a performance or correctness issue on arm64 here. It would be a problem
if instead of 16 we went down to 8 or 4 due to unaligned accesses but
from 128 to 64 (or even 16), I don't think it matters.

-- 
Catalin
