Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A437A4F84FB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiDGQaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiDGQas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:30:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F55824951
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:28:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF68B60B4D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 16:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5421C385A0;
        Thu,  7 Apr 2022 16:28:14 +0000 (UTC)
Date:   Thu, 7 Apr 2022 17:28:10 +0100
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
Message-ID: <Yk8RGvF6ik34C6BO@arm.com>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <20220405135758.774016-8-catalin.marinas@arm.com>
 <YkzJP6zmkAhc6CI9@gondor.apana.org.au>
 <CAMj1kXEXhFmGc4VTTcJU1YFsHJhZN44OdJ5Suf2ONG5=LR29HQ@mail.gmail.com>
 <Yk1UJs6eZMoIp3Eh@arm.com>
 <Yk5o/lNTyiJWD4Ae@gondor.apana.org.au>
 <Yk7EbvYhwnQy+pAf@arm.com>
 <Yk7Ny/iFi0NrMXTg@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk7Ny/iFi0NrMXTg@gondor.apana.org.au>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 07:40:59PM +0800, Herbert Xu wrote:
> On Thu, Apr 07, 2022 at 12:01:02PM +0100, Catalin Marinas wrote:
> > The only issue is whether the compiler gets confused by a pointer to a
> > structure with a smaller alignment than alignof(struct ...). I don't see
> > a performance or correctness issue on arm64 here. It would be a problem
> > if instead of 16 we went down to 8 or 4 due to unaligned accesses but
> > from 128 to 64 (or even 16), I don't think it matters.
> 
> The issue is that there's code in the Crypto API which assumes
> that all pointers returned by kmalloc are aligned to CRYPTO_MINALIGN,
> if you break that then all that code would need to be modified.

I'm not familiar with the crypto API, trying to make sense of it now ;).

I can see in many cases that the kmalloc() caller aligns the requested
size to something like crypto_tfm_ctx_alignment(). So this would
guarantee a kmalloc() object aligned to CRYPTO_MINALIGN.

> However, I think it's better to change the code that assumes
> CRYPTO_MINALIGN guarantees DMA alignment.

I saw Ard already started to refactor some of these. But in the meantime
are there cases where the crypto code does a kmalloc() of less than
CRYPTO_MINALIGN and expects it to be CRYPTO_MINALIGN aligned?

-- 
Catalin
