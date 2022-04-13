Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AA04FFFA3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiDMT4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238606AbiDMT4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:56:37 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783437B563
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:53:46 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id u19so5458414lff.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q/DBgAkv4OQEV7GLgkTJlWv+q3kLHi60Bd65fMkiVGg=;
        b=dxlaLoqslihL0u5ALJQQNQLkyAJAatT6/BflQltbOe8/sf91WvaHNbi7GO1b9Fv7ym
         eGx41ozm92iUi2qBs53105A6bIUDq03qjk/3IVzSMTq9V8X0glNvjMmX3ZXtjpTtmSaa
         IGbV8DgLGUxm4m7Y3DonNhNx06/iV90eFeUS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q/DBgAkv4OQEV7GLgkTJlWv+q3kLHi60Bd65fMkiVGg=;
        b=b2VACvzvZQNsfz0TnXAzK14/tL2m8a00ckmKGNN3CHex6u4QX0SEecSSqXwJYjPqQX
         FYW5hDxJpkfnnu8JlpNqPaC3D9HCa1H3zK6cBhfSMuen1Na4npCD5kl0gaAcFhlk4S1p
         8Eqj+EzlYubbow7qH/bO2R3wVGAZzuhLEvNlo68QhtH/JSJFSuGuJm3zn70mbt0jKRJn
         K+6HBnW+t+gRfCDlISLzXEXiv79sJ6glB5bLIUm/MBZoxMMaNwqwxKSlDKMiOjIxy8Ke
         PJTWqYd3lM4yra0A/epsi3p6ggxJOl1uGnle2hZONaB4JVH+E37bKVjwMbrdaqQQPwxh
         f97w==
X-Gm-Message-State: AOAM530cVY85/Q4SFLAvXEvCjQHLgMg+qQyG9VHQ9MlEE1hdH8IbA9Qj
        nP9aoVuOT7N8waZ89JfGIeB382++XvktiqJW
X-Google-Smtp-Source: ABdhPJwoNVDW4F9tz17pPGrjyGYpnUES8L9ltDS++SOk6/JsMp4Esn805q2ZHYEwOUN2PYFCuz0ivA==
X-Received: by 2002:a05:6512:3d08:b0:46b:a03f:6896 with SMTP id d8-20020a0565123d0800b0046ba03f6896mr13768385lfv.120.1649879624522;
        Wed, 13 Apr 2022 12:53:44 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id q14-20020a0565123a8e00b0044a7b26ae1dsm4232016lfu.109.2022.04.13.12.53.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 12:53:41 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id k5so5434498lfg.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:53:40 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr28805493lfh.687.1649879620574; Wed, 13
 Apr 2022 12:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <Yk8RGvF6ik34C6BO@arm.com> <Yk+rKWEcc9rO+A25@gondor.apana.org.au>
 <Yk/6ts5sVDMDpKj3@arm.com> <Yk/8QExHlggU8KgC@gondor.apana.org.au>
 <YlVHSvkyUBXZPUr2@arm.com> <YlVJKjXkcHqkwyt4@gondor.apana.org.au>
 <YlVOTsaTVkBOxthG@arm.com> <YlVSBuEqMt2S1Gi6@gondor.apana.org.au>
 <YlVxGAHHD/j6lW3c@arm.com> <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com>
In-Reply-To: <YlaOIbSA7B/G9222@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Apr 2022 09:53:24 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjr9-n7vHiVdm-L-KX4kXWyY45++8jenFA1QV5oc=yhZg@mail.gmail.com>
Message-ID: <CAHk-=wjr9-n7vHiVdm-L-KX4kXWyY45++8jenFA1QV5oc=yhZg@mail.gmail.com>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 10:47 PM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> I agree. There is also an implicit expectation that the DMA API works on
> kmalloc'ed buffers and that's what ARCH_DMA_MINALIGN is for (and the
> dynamic arch_kmalloc_minalign() in this series). But the key point is
> that the driver doesn't need to know the CPU cache topology, coherency,
> the DMA API and kmalloc() take care of these.

Honestly, I think it would probably be worth discussing the "kmalloc
DMA alignment" issues.

99.9% of kmalloc users don't want to do DMA.

And there's actually a fair amount of small kmalloc for random stuff.
Right now on my laptop, I have

    kmalloc-8          16907  18432      8  512    1 : ...

according to slabinfo, so almost 17 _thousand_ allocations of 8 bytes.

It's all kinds of sad if those allocations need to be 64 bytes in size
just because of some silly DMA alignment issue, when none of them want
it.

Yeah, yeah, wasting a megabyte of memory is "just a megabyte" these
days. Which is crazy. It's literally memory that could have been used
for something much more useful than just pure and utter waste.

I think we could and should just say "people who actually require DMA
accesses should say so at kmalloc time". We literally have that
GFP_DMA and ZOME_DMA for various historical reasons, so we've been
able to do that before.

No, that historical GFP_DMA isn't what arm64 wants - it's the old
crazy "legacy 16MB DMA" thing that ISA DMA used to have.

But the basic issue was true then, and is true now - DMA allocations
are fairly special, and should not be that hard to just mark as such.

We could add a trivial wrapper function like

     static void *dma_kmalloc(size_t size)
     { return kmalloc(size | (ARCH_DMA_MINALIGN-1); }

which now means that the size argument is guaranteed to be big enough
(not not overflow to zero) that you get that aligned memory
allocation.

We could perhaps even have other special rules. Including really
specific ones, like saying

 - allocations smaller than 32 bytes are not DMA coherent, because we pack them

which would allow those small allocations to not pointlessly waste memory.

I dunno. But it's ridiculous that arm64 wastes so much memory when
it's approximately never needed.

                 Linus
