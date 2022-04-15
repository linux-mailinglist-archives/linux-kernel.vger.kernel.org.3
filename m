Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DABD5027A2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351890AbiDOJyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiDOJyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:54:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D29BB8202
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 02:52:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3E186CE2E3C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 09:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884C7C385A8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 09:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650016321;
        bh=EBREfv/xjXAG8CJUnZO7ZCNWHvcAy+bC2kvoVDVVtYc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h0EaX/X5k7WmSIVOemIt7peeO6RSIhFLQqWNZUOaDwvJb/WWrn0u3GuhPJ2gBIhkb
         l89NprYd1bGn/OC7aMVxcQz1P5XR9c5XKQWBVOnfCGXTfv/jeaRzKuP9FpVVFXA6sU
         OigkrC9skcBc+F2iAgANxsyeMpr03WGe4v8g+KWsrfoam5eTJNA5g/m1sjdCXCayrZ
         lS/oqM0Or4YjXNwIWJ+0Kq1Nlm4xxH3g191uotr05Mcbve2EMH5kl6G9955mH/nXSs
         XxIJqQIRfQAniAaeHuDQXwwawJOPMZ9ZlkqptYsJAipUyppe7Roq7fZeAns4qvxIsQ
         wGHWSyu2AlS/A==
Received: by mail-oi1-f179.google.com with SMTP id r8so7981588oib.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 02:52:01 -0700 (PDT)
X-Gm-Message-State: AOAM5314jI3ywHrdGS0stHru5AE5Hfbv70YzE59em3aqviCaBaMF1JWn
        hkZaYy11cJGWd2e8UEs8rzIPtnaMeKNrO4msl38=
X-Google-Smtp-Source: ABdhPJzfxPA7NNS7cW4dM9k9tJWX2bgF6Pn7vmwUazhuO8K52EFF/Tb9PCixdfwBv6/wsqRkxzcNQWit9ryEO2Vwvd4=
X-Received: by 2002:a05:6808:1596:b0:2f7:5d89:eec7 with SMTP id
 t22-20020a056808159600b002f75d89eec7mr1279737oiw.228.1650016320681; Fri, 15
 Apr 2022 02:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <YlVJKjXkcHqkwyt4@gondor.apana.org.au> <YlVOTsaTVkBOxthG@arm.com>
 <YlVSBuEqMt2S1Gi6@gondor.apana.org.au> <YlVxGAHHD/j6lW3c@arm.com>
 <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com> <YlkV7NtatO7KFusX@gondor.apana.org.au>
 <CAMj1kXFW_zC-U5Ox9_=4gKCwWOmkR7wPNb6UQhiz8viNWTRU-w@mail.gmail.com>
 <YlkkGpVx8rhcsBot@gondor.apana.org.au> <CAMj1kXH0x5Va7Wgs+mU1ONDwwsazOBuN4z4ihVzO2uG-n41Kbg@mail.gmail.com>
 <Ylko07++4naWJ5LE@gondor.apana.org.au>
In-Reply-To: <Ylko07++4naWJ5LE@gondor.apana.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 15 Apr 2022 11:51:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH=ybJWBzmMqkrkvyF8nM3UpTchUOq+oweW=BqW2TOyRw@mail.gmail.com>
Message-ID: <CAMj1kXH=ybJWBzmMqkrkvyF8nM3UpTchUOq+oweW=BqW2TOyRw@mail.gmail.com>
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

On Fri, 15 Apr 2022 at 10:12, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Fri, Apr 15, 2022 at 10:05:21AM +0200, Ard Biesheuvel wrote:
> >
> > I guess that should be fixable. GIven that this is about padding
> > rather than alignment, we could do something like
> >
> > struct crypto_request {
> >   union {
> >       struct {
> >         ... fields ...
> >       };
> >       u8 __padding[ARCH_DMA_MINALIGN];
> >    };
> >     void __ctx[]  __align(CRYPTO_MINALIGN);
> > };
> >
> > And then hopefully, we can get rid of the padding once we fix drivers
> > doing non-cache coherent inbound DMA into those structures.
>
> Sorry, I don't think this works.  kmalloc can still return something
> that's not ARCH_DMA_MINALIGN-aligned, and therefore __ctx won't be
> aligned correctly.
>

That is the whole point, really: ARCH_DMA_MINALIGN==128 does not mean
__ctx needs to be aligned to 128 bytes, it only means that it should
not share a 128 byte cacheline with the preceding fields. So if
kmalloc() returns buffers that are aligned to whatever alignment the
platform requires (which will be 64 in most cases), the above
arrangement ensures that, without requiring that CRYPTO_MINALIGN ==
ARCH_DMA_MINALIGN.
