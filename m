Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0EB4FDD21
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbiDLK5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356630AbiDLKpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:45:32 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5812684EE4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:41:24 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1neD17-001sqd-Uh; Tue, 12 Apr 2022 19:40:59 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 12 Apr 2022 17:40:58 +0800
Date:   Tue, 12 Apr 2022 17:40:58 +0800
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
Message-ID: <YlVJKjXkcHqkwyt4@gondor.apana.org.au>
References: <CAMj1kXEXhFmGc4VTTcJU1YFsHJhZN44OdJ5Suf2ONG5=LR29HQ@mail.gmail.com>
 <Yk1UJs6eZMoIp3Eh@arm.com>
 <Yk5o/lNTyiJWD4Ae@gondor.apana.org.au>
 <Yk7EbvYhwnQy+pAf@arm.com>
 <Yk7Ny/iFi0NrMXTg@gondor.apana.org.au>
 <Yk8RGvF6ik34C6BO@arm.com>
 <Yk+rKWEcc9rO+A25@gondor.apana.org.au>
 <Yk/6ts5sVDMDpKj3@arm.com>
 <Yk/8QExHlggU8KgC@gondor.apana.org.au>
 <YlVHSvkyUBXZPUr2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlVHSvkyUBXZPUr2@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 10:32:58AM +0100, Catalin Marinas wrote:
>
> At a quick grep, most cra_alignmask values are currently 15 or smaller.
> I'm not convinced the driver needs to know about the CPU cache
> alignment. We could set cra_alignmask to CRYPTO_MINALIGN but that would
> incur unnecessary overhead via function like setkey_unaligned() when the
> arch_kmalloc_minalign() was already sufficient for DMA safety.
> 
> Maybe I miss some use-cases or I focus too much on DMA safety.

The alignment was never designed for DMA.  It's mainly for CPUs
that provide accelerated instructions that require a certain
amount of alignment, most commonly 16 bytes.

Therefore CRYPTO_MINALIGN was never meant to be a guarantee for
DMA alignment.  Any drivers relying on this is simply broken.

I understand that on ARM for historical reasons you have had a
situation that CRYPTO_MINALIGN happened to be large enough to
guarantee DMA alignment.  I totally agree with your patch to
try to fix this but it should not penalise other architectures
and raise the CRYPTO_MINALIGN unnecessarily.

I think if CRYPTO_MINALIGN makes those drivers work then so
should cra_alignmask.  And that would be a relatively easy
patch to do.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
