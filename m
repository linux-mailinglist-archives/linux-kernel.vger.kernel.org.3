Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6E14F914C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiDHJHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiDHJHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:07:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2FA80213
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 02:05:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1136C61C4A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 09:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEE8C385A3;
        Fri,  8 Apr 2022 09:04:58 +0000 (UTC)
Date:   Fri, 8 Apr 2022 10:04:54 +0100
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
Message-ID: <Yk/6ts5sVDMDpKj3@arm.com>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <20220405135758.774016-8-catalin.marinas@arm.com>
 <YkzJP6zmkAhc6CI9@gondor.apana.org.au>
 <CAMj1kXEXhFmGc4VTTcJU1YFsHJhZN44OdJ5Suf2ONG5=LR29HQ@mail.gmail.com>
 <Yk1UJs6eZMoIp3Eh@arm.com>
 <Yk5o/lNTyiJWD4Ae@gondor.apana.org.au>
 <Yk7EbvYhwnQy+pAf@arm.com>
 <Yk7Ny/iFi0NrMXTg@gondor.apana.org.au>
 <Yk8RGvF6ik34C6BO@arm.com>
 <Yk+rKWEcc9rO+A25@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk+rKWEcc9rO+A25@gondor.apana.org.au>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 11:25:29AM +0800, Herbert Xu wrote:
> On Thu, Apr 07, 2022 at 05:28:10PM +0100, Catalin Marinas wrote:
> > I can see in many cases that the kmalloc() caller aligns the requested
> > size to something like crypto_tfm_ctx_alignment(). So this would
> > guarantee a kmalloc() object aligned to CRYPTO_MINALIGN.
> 
> crypto_tfm_ctx_alignment is basically the same as CRYPTO_MINALIGN.
> We assume any kmalloced pointers to be aligned to that.
> 
> Specific algorithms may ask for an alignment greater than that
> and we will use the knowledge that kmalloc is aligned to
> CRYPTO_MINALIGN to derive the extra memory we need to get.
> 
> So if kmalloc no longer returns memory aligned to MINALIGN then
> we'll get memory overruns.

My point is that if the crypto code kmallocs a size aligned to
crypto_tfm_ctx_alignment() (and CRYPTO_MINALIGN), the slab allocator
will return memory aligned to CRYPTO_MINALIGN even if
ARCH_KMALLOC_MINALIGN is smaller.

Would the crypto code, say, do a kmalloc(64) and expect a 128 byte
alignment (when CRYPTO_MINALIGN == 128)? Or does it align the size to
CRYPTO_MINALIGN and do a kmalloc(128) directly? If it's the latter, I
don't think there's a problem.

-- 
Catalin
