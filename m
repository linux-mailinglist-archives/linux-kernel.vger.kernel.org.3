Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD734F7C4D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 12:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbiDGKCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 06:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbiDGKCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 06:02:47 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2C24553C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 03:00:47 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2eba37104a2so56396667b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 03:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6Ev7blcHibxt4QrE14OlVoKgZfCOo8YZprXV+hduag=;
        b=GgOM1DdLoxc5bK8Qlz10R0LhEAPbToMvRENNSe/5QtM8XxI6v1RyTk/WVzg8TqruNe
         1P9N8a8z5LKP+EBP9jSyGJrkkFZ1sPnmaaSdMuNZ9MFmdllEZ6eE4N8ZfYfZOAbF7Xpu
         ZPp6WuGbxS96xg8msKumgP2GqiVfedJshtT8A0cxdA7OoojhV8ne4J5enKIEN7VQa3sV
         L+t2L7ngtAkQctAGqcN9rAEwg964FPUykWvIF9ZdgRUVg4BZoDYWw3nu02yI0VtaSOYr
         /DrqU/Zf9Jw/eUaHrtgU9HOfIBunbady22c7m8/78vbjnCplxMth+YRIcrGHjqz2mKYa
         jFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6Ev7blcHibxt4QrE14OlVoKgZfCOo8YZprXV+hduag=;
        b=afRUwdbGXyFcRTH/ri3USXfx7WvSDP310fxnzGqBRBRP2B/p1dOVA7+GZljirOjpB+
         f4DikRTKNn8FM/GAF09Y5Lhv54gqYtU08yo+WtrdIpUS3K9jvCcRhmH4vXza4DLetUwa
         abqSDkLqwchL0p2b1DYLUSdw51ffh3YGGsmN5U9BzYhIkUnG7GnwyRC2lU5qXKWiLlRr
         vgZ5t6AK7p/KcPnzasn8FeliAhnahJlTjh6eWcLF0sJSVYb4CC0UMVaV2Hd5I93XsUQt
         0I1dlOwHFw2+bpXOKooyjNeX2qnweCQNINRlv2hQs58IlT21TvcuN/8YRkv0/6vo6m1E
         o4lQ==
X-Gm-Message-State: AOAM533FS6EfBojQLqRlSEEEn+w3nEkDBbIGS2kVUz5zyrEuZMYUzBXM
        T11rdJ1eW6RkTm5rJdX6WH5S8HBx0VAc7opuO/TWI3e6BYmguQ==
X-Google-Smtp-Source: ABdhPJy3W5pSmjFRsgmmpgg9SUIB7+1TAzHrvFI6Un0vTSR4I/mqJlc1GpvqT+xDAS5U35/rZNsUDL6nZ1T8HPTTypc=
X-Received: by 2002:a81:5dd6:0:b0:2d6:3041:12e0 with SMTP id
 r205-20020a815dd6000000b002d6304112e0mr10893961ywb.331.1649325647122; Thu, 07
 Apr 2022 03:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <20220405135758.774016-8-catalin.marinas@arm.com> <Yk5/FpCR10sndTR1@n131-248-037.byted.org>
 <Yk6t9jhof9MJV6TG@arm.com>
In-Reply-To: <Yk6t9jhof9MJV6TG@arm.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 7 Apr 2022 18:00:10 +0800
Message-ID: <CAMZfGtUWGkMNndjWFRqwimzV4m+Z63ZpLdyrFAFn3oV+EXGSZw@mail.gmail.com>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 5:25 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Apr 07, 2022 at 02:14:15PM +0800, Muchun Song wrote:
> > On Tue, Apr 05, 2022 at 02:57:55PM +0100, Catalin Marinas wrote:
> > > ARCH_DMA_MINALIGN represents the minimum (static) alignment for safe DMA
> > > operations while ARCH_KMALLOC_MINALIGN is the minimum kmalloc() objects
> > > alignment.
> > >
> > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > > Cc: "David S. Miller" <davem@davemloft.net>
> > > ---
> > >  include/linux/crypto.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/crypto.h b/include/linux/crypto.h
> > > index 2324ab6f1846..654b9c355575 100644
> > > --- a/include/linux/crypto.h
> > > +++ b/include/linux/crypto.h
> > > @@ -167,7 +167,7 @@
> > >   * maintenance for non-coherent DMA (cache invalidation in particular) does not
> > >   * affect data that may be accessed by the CPU concurrently.
> > >   */
> > > -#define CRYPTO_MINALIGN ARCH_KMALLOC_MINALIGN
> > > +#define CRYPTO_MINALIGN ARCH_DMA_MINALIGN
> >
> > I don't think this should be changed since ARCH_KMALLOC_MINALIGN is
> > already aligned with the size what you need.
>
> With this series, ARCH_KMALLOC_MINALIGN is no longer safe for
> non-coherent DMA on all arm64 SoCs, that's what ARCH_DMA_MINALIGN will
> cover.
>
> Now, looking at the comment for CRYPTO_MINALIGN, one aspect it covers is
> the minimum alignment required by C for the crypto_tfm structure access.
> So a smaller ARCH_KMALLOC_MINALIGN would do. But the other part of the
> comment mentions in-structure alignment for non-coherent DMA. Here we'd
> need the upper bound alignment, ARCH_DMA_MINALIGN.
>
> I'll follow up on Herbert's email as I think he has a good point on
> structure vs kmalloc() alignment.

Got it. Now I know what you want to do. You want to set
ARCH_KMALLOC_MINALIGN to 64, however, the smallest
size of kmem_cache depends on the cache line size at
runtime.  But we have to know the safe alignment at building
time.  So we have to make those align with ARCH_DMA_MINALIGN.
Right?  I think you are on the right road since most CPUs have
a 64-byte cache line.

Thanks.
