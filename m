Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2187F4F91EA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbiDHJU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbiDHJOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:14:39 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AE812B75B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 02:11:47 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1nckeN-000Szc-Vn; Fri, 08 Apr 2022 19:11:29 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Apr 2022 17:11:28 +0800
Date:   Fri, 8 Apr 2022 17:11:28 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Message-ID: <Yk/8QExHlggU8KgC@gondor.apana.org.au>
References: <20220405135758.774016-8-catalin.marinas@arm.com>
 <YkzJP6zmkAhc6CI9@gondor.apana.org.au>
 <CAMj1kXEXhFmGc4VTTcJU1YFsHJhZN44OdJ5Suf2ONG5=LR29HQ@mail.gmail.com>
 <Yk1UJs6eZMoIp3Eh@arm.com>
 <Yk5o/lNTyiJWD4Ae@gondor.apana.org.au>
 <Yk7EbvYhwnQy+pAf@arm.com>
 <Yk7Ny/iFi0NrMXTg@gondor.apana.org.au>
 <Yk8RGvF6ik34C6BO@arm.com>
 <Yk+rKWEcc9rO+A25@gondor.apana.org.au>
 <Yk/6ts5sVDMDpKj3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk/6ts5sVDMDpKj3@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 10:04:54AM +0100, Catalin Marinas wrote:
>
> My point is that if the crypto code kmallocs a size aligned to
> crypto_tfm_ctx_alignment() (and CRYPTO_MINALIGN), the slab allocator
> will return memory aligned to CRYPTO_MINALIGN even if
> ARCH_KMALLOC_MINALIGN is smaller.

No we don't align the size to CRYPTO_MINALIGN at all.  We simply
assume that this is the alignment returned by kmalloc.

> Would the crypto code, say, do a kmalloc(64) and expect a 128 byte
> alignment (when CRYPTO_MINALIGN == 128)? Or does it align the size to
> CRYPTO_MINALIGN and do a kmalloc(128) directly? If it's the latter, I
> don't think there's a problem.

It's the former.

I think you can still make the change you want, but first you need
to modify the affected drivers to specify their actual alignment
requirement explicitly through cra_alignmask and then use the
correct methods to access the context pointer.

Basically these drivers have been broken from day one, but their
brokenness has been hidden by the extra-large KMALLOC_MINALIGN
value on arm.  So to reduce the KMALLOC_MINALIGN value, you have
to modify the drivers and set the cra_alignmask value.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
