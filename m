Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7F05029AE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240741AbiDOM2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353467AbiDOM2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:28:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB10BF946
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:25:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B0AA61771
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 12:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA82CC385A6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 12:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650025534;
        bh=peoji69cmwuartQe2i8D75ZJFCK0CFwaXH4nduVKmKI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tOHxKo7/rNGCwK41O/fR8wXFKYKKKZ0wQ0CZFboPixfg+fU9canaSUDY+bA8bdFmi
         jkKUDq43xMCjzuq7VJjgfCzszITzQ4scBSJ3y0Fs0VgiCfXD720S0ihI2rQHX3VQ0K
         dFoaBmZp3SJSnFVeuiXRooCOpQ1hm9f0WO4a/vwEzvJl1AhXgf24e9TnyEN3NJjktH
         t6VNXOUh4xvPfy3/9zBmMmtNurk7chYHBab/sE7+XYl2KJ0lgkLESTDypXDW7kBQYY
         NNLGCwpAeutGw1JDJGKQpGyTXTvKoOakUp9DnSETCD7cqe7fESVtQgXm5Ycu5AecUs
         SfQPKmK0a8vrQ==
Received: by mail-ot1-f43.google.com with SMTP id i23-20020a9d6117000000b005cb58c354e6so5279982otj.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:25:33 -0700 (PDT)
X-Gm-Message-State: AOAM530qPr2dhV9PSbd3+s6FnziiZ0KVs4XnRgs0iIWaNQk56VoInTT7
        hlmBY9Gw+IMCILQDKSUykGXEl7vZYtiTABU96Ls=
X-Google-Smtp-Source: ABdhPJyq39krpe9z+Gp7B5aYHY58HMPsCZSR8rk8R3+dy4FhmDm7RCJ4PRkY/ftj0dMkr/QFZfSuIwG7hhI/028eLpo=
X-Received: by 2002:a05:6830:2e7:b0:5b2:68c1:182a with SMTP id
 r7-20020a05683002e700b005b268c1182amr2547283ote.71.1650025533158; Fri, 15 Apr
 2022 05:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <YlVJKjXkcHqkwyt4@gondor.apana.org.au> <YlVOTsaTVkBOxthG@arm.com>
 <YlVSBuEqMt2S1Gi6@gondor.apana.org.au> <YlVxGAHHD/j6lW3c@arm.com>
 <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com> <YlkV7NtatO7KFusX@gondor.apana.org.au>
 <CAMj1kXFW_zC-U5Ox9_=4gKCwWOmkR7wPNb6UQhiz8viNWTRU-w@mail.gmail.com>
 <YlkkGpVx8rhcsBot@gondor.apana.org.au> <CAMj1kXH0x5Va7Wgs+mU1ONDwwsazOBuN4z4ihVzO2uG-n41Kbg@mail.gmail.com>
 <YllirUEhaxCDaV3X@arm.com>
In-Reply-To: <YllirUEhaxCDaV3X@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 15 Apr 2022 14:25:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH6r+Yf348-0uWu+9wFjnufKb7f970UgdMmoRbve7g_SA@mail.gmail.com>
Message-ID: <CAMj1kXH6r+Yf348-0uWu+9wFjnufKb7f970UgdMmoRbve7g_SA@mail.gmail.com>
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

On Fri, 15 Apr 2022 at 14:19, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Fri, Apr 15, 2022 at 10:05:21AM +0200, Ard Biesheuvel wrote:
> > On Fri, 15 Apr 2022 at 09:52, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > > On Fri, Apr 15, 2022 at 09:49:12AM +0200, Ard Biesheuvel wrote:
> > > > I'm not sure I understand what would go wrong if that assumption no
> > > > longer holds.
> > >
> > > It's very simple, we don't do anything to the pointer returned
> > > by kmalloc before returning it as a tfm or other object with
> > > an alignment of CRYPTO_MINALIGN.  IOW if kmalloc starts returning
> > > pointers that are not aligned to CRYPTO_MINALIGN then we'd be
> > > lying to the compiler.
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
> But if we keep CRYPTO_MINALIGN as 128, don't we get the padding
> automatically?
>

I suppose, yes.

> struct crypto_request {
>         ...
>         void *__ctx[] CRYPTO_MINALIGN_ATTR;
> };
>
> __alignof__(struct crypto_request) == 128;
> sizeof(struct crypto_request) == N * 128
>
> The same alignment and size is true for a structure like:
>
> struct crypto_alg {
>         ...
> } CRYPTO_MINALIGN_ATTR;
>
> Any kmalloc() of sizeof(the above structures) will return a pointer
> aligned to 128, irrespective of what ARCH_KMALLOC_MINALIGN is.
>
> The problem is if you have a structure without any alignment attribute
> (just ABI default), making its sizeof() smaller than ARCH_DMA_MINALIGN.
> In this case kmalloc() could return a pointer aligned to something
> smaller. Is this the case in the crypto code today? I can see it uses
> the right alignment annotations already, no need for kmalloc() hacks.
>

As long as CRYPTO_MINALIGN >= ARCH_KMALLOC_MINALIGN, we won't be lying
to the compiler when casting kmalloc buffers to these struct types.

I'd still like to fix the bad DMA behavior but I suppose it is a separate issue.
