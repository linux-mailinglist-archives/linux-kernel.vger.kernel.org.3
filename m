Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB57502665
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 09:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351227AbiDOHv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 03:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiDOHv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 03:51:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFEF13F6D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 00:49:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10279B82BA2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 07:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08B9C385AB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 07:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650008965;
        bh=eUOjRVyTAm6jKWk8U3u/0yQXmGiR3R5Y9bZ0+t0UrtQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tgeo6+Clc418620BErs3GyqutJjfjRqL0t9r6nifTXUraL7SJSk7tYwedEMXDuXI4
         zOKU2Ffi7IRo2g6XNcZJl1ZkATSIY3khnW00JjuEGnZmJla4EXIRb3Qq509B2eN+HV
         VHnD0FN50CVIDCfxCEx+L7uW8JQ2DxpEJZXYKSJT1HLLh43qPdd1kFkmN3b1JOEiIk
         +yIubk07HJ/u9JqFEznxezUiGrKuOmQ+bvXNjuOXRM3Cw37wz6qHqqTtNzCTOPsIcb
         XejXR8iBGPbPTEy9IRTFC87D8/ZGKhE3VRhLWfhV2aTfosu9pk/idNlqUhYU59l24d
         074EhqW0Uq71w==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-deb9295679so7501751fac.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 00:49:25 -0700 (PDT)
X-Gm-Message-State: AOAM530ONzeWbaRI8ZBArLRq6sWFXnKQz+g27SFFZ1z3jyXlC8qZvIwO
        m8hDW6ghWxXLNNpvhfgiam4Y/TkL6d6P2uYDLHQ=
X-Google-Smtp-Source: ABdhPJx0lEA3e7WZ7cSEpjFA0JVG8HISWN9TfswZhcy4XaorGyyF3eX+1q+lZphMFO5POQFTd5DpcRU8cQKweCLTWxI=
X-Received: by 2002:a05:6870:eaa5:b0:da:b3f:2b45 with SMTP id
 s37-20020a056870eaa500b000da0b3f2b45mr982816oap.228.1650008964845; Fri, 15
 Apr 2022 00:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <Yk+rKWEcc9rO+A25@gondor.apana.org.au> <Yk/6ts5sVDMDpKj3@arm.com>
 <Yk/8QExHlggU8KgC@gondor.apana.org.au> <YlVHSvkyUBXZPUr2@arm.com>
 <YlVJKjXkcHqkwyt4@gondor.apana.org.au> <YlVOTsaTVkBOxthG@arm.com>
 <YlVSBuEqMt2S1Gi6@gondor.apana.org.au> <YlVxGAHHD/j6lW3c@arm.com>
 <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com> <YlkV7NtatO7KFusX@gondor.apana.org.au>
In-Reply-To: <YlkV7NtatO7KFusX@gondor.apana.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 15 Apr 2022 09:49:12 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFW_zC-U5Ox9_=4gKCwWOmkR7wPNb6UQhiz8viNWTRU-w@mail.gmail.com>
Message-ID: <CAMj1kXFW_zC-U5Ox9_=4gKCwWOmkR7wPNb6UQhiz8viNWTRU-w@mail.gmail.com>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2022 at 08:51, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Wed, Apr 13, 2022 at 09:47:29AM +0100, Catalin Marinas wrote:
> >
> > With my series, there is no change to the value of CRYPTO_MINALIGN for
> > arm64 or any other architecture, so point 3 is unaffected. The series
> > does change the kmalloc() alignment and that may be smaller than
> > CRYPTO_MINALIGN but neither of points 1 or 2 above are affected since
> > (a) we still have a sufficiently large ARCH_KMALLOC_MINALIGN of 64 and
> > (b) the kmalloc'ed buffers are safe for non-coherent DMA.
> >
> > Herbert, Ard, if I missed anything please let me know but based on my
> > understanding, this series is safe for the crypto code.
>
> Sorry, but you can't change CRYPTO_MINALIGN to a value greater
> than the minimum alignment returned by kmalloc.  That simply
> doesn't work.  There is no magic in the Crypto API that makes
> this work.
>

I'm not sure I understand what would go wrong if that assumption no
longer holds, but if CRYPTO_MINALIGN needs to remain equal to
ARCH_KMALLOC_MINALIGN, let's at least decouple it from
ARCH_DMA_MINALIGN, as I do in my series. As I pointed out before,
ARCH_DMA_MINALIGN has nothing to do with DMA addressing capabilities
of individual masters, it is simply a worst case cacheline size that
needs to be taken into account to avoid corruption when doing cache
invalidation for non-cache coherent inbound DMA.

I'll rename the flag I proposed from CRYPTO_ALG_NEED_DMA_ALIGNMENT to
CRYPTO_ALG_NEED_DMA_PADDING to make this clearer, and given that only
a few drivers should be relying on DMA to write into request/TFM
context structures, hopefully we can fix those to stop doing that, and
get rid of this flag again entirely.
