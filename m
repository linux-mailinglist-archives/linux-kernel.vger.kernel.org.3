Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF4E5027F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 12:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352112AbiDOKG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 06:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbiDOKGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:06:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8C4306
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 03:04:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC7D862201
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 10:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3128BC385AC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 10:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650017064;
        bh=fufug+gcC7ZO4O5R0DBgcSd0Eygy++xXyqo7O+o4vUw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FrQNqMYQG2MSiKwACMPKXrfcXEz35ecDQaAe8ZYwbJsQdainmqHvBG6PlUEw9YnHW
         cNufHNHXTi/2AQcabJlwOC6PUBIwM3lkvp5Ep6kGa7KaQS8wlMHdlVMyUoGO+K4I3j
         W1+9jKz4oH+9P9y6g7Iy4QADzFRiH0t/czGOCi+bO3GWEgwdtNfnt1oAgEBG+uNqKS
         mb3abvGL40VHXu+efI676EUP0Zie8lfZifTzYitcvlzX6cT7yaoJUe7Yt5LEZNOLzP
         ZMDvVuqh1VlLklfqo6BzfUuYy5OtU3ERfv/0qqW/+FADdUOcK206zMDCNstrl3UAYx
         Xl3lbg8dZkolQ==
Received: by mail-ot1-f52.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso5140262otj.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 03:04:24 -0700 (PDT)
X-Gm-Message-State: AOAM532Mni7iaEmJpMPL7kY11DaMfZzPPXFXTYUZhJGVZoc0tI6kMQVQ
        wNFd7zvm9mRYJ6SHpsE2bQqfJ2UdMp7hI53rDuA=
X-Google-Smtp-Source: ABdhPJwU70pH3XY/94+KsBUHK1RylEVUJE34qOIC68RiNARuOX/QRwjDCFRpG1e7QtV7WGvz2X6ufQrKLfnI3dRh9ng=
X-Received: by 2002:a05:6830:2e7:b0:5b2:68c1:182a with SMTP id
 r7-20020a05683002e700b005b268c1182amr2389611ote.71.1650017063343; Fri, 15 Apr
 2022 03:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <YlVJKjXkcHqkwyt4@gondor.apana.org.au> <YlVOTsaTVkBOxthG@arm.com>
 <YlVSBuEqMt2S1Gi6@gondor.apana.org.au> <YlVxGAHHD/j6lW3c@arm.com>
 <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com> <YlkV7NtatO7KFusX@gondor.apana.org.au>
 <CAMj1kXFW_zC-U5Ox9_=4gKCwWOmkR7wPNb6UQhiz8viNWTRU-w@mail.gmail.com>
 <YlkkGpVx8rhcsBot@gondor.apana.org.au> <CAMj1kXH0x5Va7Wgs+mU1ONDwwsazOBuN4z4ihVzO2uG-n41Kbg@mail.gmail.com>
 <Ylko07++4naWJ5LE@gondor.apana.org.au> <CAMj1kXH=ybJWBzmMqkrkvyF8nM3UpTchUOq+oweW=BqW2TOyRw@mail.gmail.com>
In-Reply-To: <CAMj1kXH=ybJWBzmMqkrkvyF8nM3UpTchUOq+oweW=BqW2TOyRw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 15 Apr 2022 12:04:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHbr5tJJdun8DcU89Qcgzn1epm_VaedpLMXO1PG6sQ1fA@mail.gmail.com>
Message-ID: <CAMj1kXHbr5tJJdun8DcU89Qcgzn1epm_VaedpLMXO1PG6sQ1fA@mail.gmail.com>
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

On Fri, 15 Apr 2022 at 11:51, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 15 Apr 2022 at 10:12, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> >
> > On Fri, Apr 15, 2022 at 10:05:21AM +0200, Ard Biesheuvel wrote:
> > >
> > > I guess that should be fixable. GIven that this is about padding
> > > rather than alignment, we could do something like
> > >
> > > struct crypto_request {
> > >   union {
> > >       struct {
> > >         ... fields ...
> > >       };
> > >       u8 __padding[ARCH_DMA_MINALIGN];
> > >    };
> > >     void __ctx[]  __align(CRYPTO_MINALIGN);
> > > };
> > >
> > > And then hopefully, we can get rid of the padding once we fix drivers
> > > doing non-cache coherent inbound DMA into those structures.
> >
> > Sorry, I don't think this works.  kmalloc can still return something
> > that's not ARCH_DMA_MINALIGN-aligned, and therefore __ctx won't be
> > aligned correctly.
> >
>
> That is the whole point, really: ARCH_DMA_MINALIGN==128 does not mean
> __ctx needs to be aligned to 128 bytes, it only means that it should
> not share a 128 byte cacheline with the preceding fields.

Let's rephrase that as 'must not share a cacheline with the preceding
fields, and the worst case we expect to have to deal with is a
cacheline size of 128 bytes'
