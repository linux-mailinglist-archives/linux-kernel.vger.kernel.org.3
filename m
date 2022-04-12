Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1004FDE13
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345409AbiDLLPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354444AbiDLLPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:15:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AFC939D9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:03:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57BC561530
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946C8C385A5;
        Tue, 12 Apr 2022 10:02:58 +0000 (UTC)
Date:   Tue, 12 Apr 2022 11:02:54 +0100
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
Message-ID: <YlVOTsaTVkBOxthG@arm.com>
References: <Yk1UJs6eZMoIp3Eh@arm.com>
 <Yk5o/lNTyiJWD4Ae@gondor.apana.org.au>
 <Yk7EbvYhwnQy+pAf@arm.com>
 <Yk7Ny/iFi0NrMXTg@gondor.apana.org.au>
 <Yk8RGvF6ik34C6BO@arm.com>
 <Yk+rKWEcc9rO+A25@gondor.apana.org.au>
 <Yk/6ts5sVDMDpKj3@arm.com>
 <Yk/8QExHlggU8KgC@gondor.apana.org.au>
 <YlVHSvkyUBXZPUr2@arm.com>
 <YlVJKjXkcHqkwyt4@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlVJKjXkcHqkwyt4@gondor.apana.org.au>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 05:40:58PM +0800, Herbert Xu wrote:
> On Tue, Apr 12, 2022 at 10:32:58AM +0100, Catalin Marinas wrote:
> > At a quick grep, most cra_alignmask values are currently 15 or smaller.
> > I'm not convinced the driver needs to know about the CPU cache
> > alignment. We could set cra_alignmask to CRYPTO_MINALIGN but that would
> > incur unnecessary overhead via function like setkey_unaligned() when the
> > arch_kmalloc_minalign() was already sufficient for DMA safety.
> > 
> > Maybe I miss some use-cases or I focus too much on DMA safety.
> 
> The alignment was never designed for DMA.  It's mainly for CPUs
> that provide accelerated instructions that require a certain
> amount of alignment, most commonly 16 bytes.
> 
> Therefore CRYPTO_MINALIGN was never meant to be a guarantee for
> DMA alignment.  Any drivers relying on this is simply broken.

Thanks for the clarification (the comment in crypto.h implies that it
covers this aspect as well).

> I understand that on ARM for historical reasons you have had a
> situation that CRYPTO_MINALIGN happened to be large enough to
> guarantee DMA alignment.  I totally agree with your patch to
> try to fix this but it should not penalise other architectures
> and raise the CRYPTO_MINALIGN unnecessarily.

This series does not penalise any architecture. It doesn't even make
arm64 any worse than it currently is.

For arm64, before the series:

  ARCH_DMA_MINALIGN == 128
  ARCH_KMALLOC_MINALIGN == 128
  CRYPTO_MINALIGN == 128

After the series, on arm64:

  ARCH_DMA_MINALIGN == 128
  ARCH_KMALLOC_MINALIGN == 64
  CRYPTO_MINALIGN == 128

For x86, before the series:

  ARCH_DMA_MINALIGN undefined
  ARCH_KMALLOC_MINALIGN == 8
  CRYPTO_MINALIGN == 8

After the series, on x86 (or any architecture that doesn't define
ARCH_DMA_MINALIGN):

  ARCH_DMA_MINALIGN == 8
  ARCH_KMALLOC_MINALIGN == 8
  CRYPTO_MINALIGN == 8

For other architectures that define ARCH_DMA_MINALIGN to 'N' but do not
define ARCH_KMALLOC_MINALIGN, before and after this series:

  ARCH_DMA_MINALIGN == N
  ARCH_KMALLOC_MINALIGN == N
  CRYPTO_MINALIGN == N

> I think if CRYPTO_MINALIGN makes those drivers work then so
> should cra_alignmask.  And that would be a relatively easy
> patch to do.

Yes, the patch would be simple, subject to figuring out which drivers
and what alignment they actually need (any help appreciated).

There are already arm64 vendor kernels that change ARCH_DMA_MINALIGN to
64, hence ARCH_KMALLOC_MINALIGN and CRYPTO_MINALIGN become 64. We also
discussed a Kconfig option for this in the past. Would that have broken
any crypto drivers that rely on a strict 128 byte alignment?

Thanks.

-- 
Catalin
