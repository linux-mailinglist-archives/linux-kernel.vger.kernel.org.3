Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317B4501788
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352207AbiDNPkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353649AbiDNOkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:40:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BE1B1AA3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:31:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AC4AB829D8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C5AC385AC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649946666;
        bh=sYuRIOKotPt+JjyagaULCK/sP+wsew5Z8mm0QqMhM8U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CcENbH42U2QOdZU6S5pxfFHY6fuFidAEmlWORZn+hRWfPmnkWM0khYKDmhmWy6nKE
         HcPJiYN36zT7FPyRqI0V7826IYn5fGdcB7FjOWRNIiZMsZ9NKVOz/Xb+18yc9jlnst
         XPIZRI5MU8cY+8TVgowcOOCe0R40qmduwyuSmhygD6MMJD0zhSDGUeWlvPg3K7PDdD
         joCzBvjrWmCk4tWQHRNgWUoTTqIXbJyUZYrMOqDAUB2YkBVCoN0Hp6UjATx0OPevoa
         Rne1FmfRBU/dGNko5Na1Q47migtPTwlGzi/qTui+cfR93RIXZL5oCA7dIMc/73MwHs
         eVqhUvvdEarLA==
Received: by mail-oi1-f169.google.com with SMTP id k13so5592095oiw.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:31:06 -0700 (PDT)
X-Gm-Message-State: AOAM533Yzb8K4hzTiiOIHcFuL3r946GJ4xl6q65XKiDi5GSr8LHyS5R6
        gtgBkO+ThVrtdraSHPVsbsO+KTlFUrhIwSpqzKA=
X-Google-Smtp-Source: ABdhPJz6vfhd6nZ73pd/JDo+zGftnuoYPNZ+DV4zOFApTEqq9RxSmi4R5LkRk1Vo1z8OpRtEUvrOSBaG3sSVs89sbYs=
X-Received: by 2002:a05:6808:1596:b0:2f7:5d89:eec7 with SMTP id
 t22-20020a056808159600b002f75d89eec7mr1816562oiw.228.1649946665844; Thu, 14
 Apr 2022 07:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <Yk8RGvF6ik34C6BO@arm.com> <Yk+rKWEcc9rO+A25@gondor.apana.org.au>
 <Yk/6ts5sVDMDpKj3@arm.com> <Yk/8QExHlggU8KgC@gondor.apana.org.au>
 <YlVHSvkyUBXZPUr2@arm.com> <YlVJKjXkcHqkwyt4@gondor.apana.org.au>
 <YlVOTsaTVkBOxthG@arm.com> <YlVSBuEqMt2S1Gi6@gondor.apana.org.au>
 <YlVxGAHHD/j6lW3c@arm.com> <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com>
In-Reply-To: <YlaOIbSA7B/G9222@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 14 Apr 2022 16:30:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFTV+YXVRfktnSgGt-gDAn3QBHZ16LOF++TbqkNu4Ay-Q@mail.gmail.com>
Message-ID: <CAMj1kXFTV+YXVRfktnSgGt-gDAn3QBHZ16LOF++TbqkNu4Ay-Q@mail.gmail.com>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
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

On Wed, 13 Apr 2022 at 10:47, Catalin Marinas <catalin.marinas@arm.com> wrote:
..
>
> Let's go back to restating the crypto code alignment requirements, as I
> understand them (please correct):
>
> 1. Bus master accesses (DMA, CPUs that can't do efficient unaligned
>    accesses). That's what cra_alignmask is for. If there's a driver that
>    relies on an implicit kmalloc() alignment higher than cra_alignmask,
>    it is already broken on x86 and a few other architectures that don't
>    define ARCH_DMA_MINALIGN. But it won't be any worse with this series
>    since it only brings the arm64 kmalloc() alignment down from 128 to
>    64.
>
> 2. Non-coherent DMA and cache invalidation. With my series, kmalloc'ed
>    buffers are DMA-safe for the CPU/SoC the kernel is running on.
>
> 3. DMA into buffers embedded in TFM structures. Since the offset of
>    those buffers is decided at compile-time, we need a
>    CRYPTO_MINALIGN_ATTR that covers both bus master alignment
>    requirements and the highest cache line size (CWG) for a non-coherent
>    DMA SoC. Ard's series would simplify the latter but, before then,
>    CRYPTO_MINALIGN needs to stay as the larger ARCH_DMA_MINALIGN.
>
> With my series, there is no change to the value of CRYPTO_MINALIGN for
> arm64 or any other architecture, so point 3 is unaffected. The series
> does change the kmalloc() alignment and that may be smaller than
> CRYPTO_MINALIGN but neither of points 1 or 2 above are affected since
> (a) we still have a sufficiently large ARCH_KMALLOC_MINALIGN of 64 and
> (b) the kmalloc'ed buffers are safe for non-coherent DMA.
>
> Herbert, Ard, if I missed anything please let me know but based on my
> understanding, this series is safe for the crypto code.
>

Agreed.
