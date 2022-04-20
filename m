Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D3C5086FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378109AbiDTLcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378102AbiDTLcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:32:19 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF364163F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:29:31 -0700 (PDT)
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MVaQW-1nX88618su-00RXol for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022
 13:29:30 +0200
Received: by mail-wr1-f45.google.com with SMTP id g18so1809442wrb.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:29:30 -0700 (PDT)
X-Gm-Message-State: AOAM533wKlqvtuQtFBTB7gY7L4BDix2jVYNFnesvGKQ53jhBOOjQMM5s
        Ujh29rE/DxZq1884Fz14UaG9tWEC41oCQsUXnSI=
X-Google-Smtp-Source: ABdhPJzx9GpLsd2URZMHa2ZS0Kp2+Vi7HGOM42v7AVvlym/TS/rzY1VDK6lrg19sKIRqohNesRW/fM91dnNHk1s4f4A=
X-Received: by 2002:a5d:6da5:0:b0:20a:8805:6988 with SMTP id
 u5-20020a5d6da5000000b0020a88056988mr13991084wrs.317.1650454169681; Wed, 20
 Apr 2022 04:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXFjLbtpJLFh-C_k3Ydcg4M7NqrCfOXnBY2iSxusWtBLbA@mail.gmail.com>
 <YllM24eca/uxf9y7@gondor.apana.org.au> <CAMj1kXH5O32H1nnm6y7=3KiH7R-_oakxzBpZ20wK+8kaD46aKw@mail.gmail.com>
 <YlvK9iefUECy361O@gondor.apana.org.au> <YlvQTci7RP5evtTy@arm.com>
 <YlvRbvWSWMTtBJiN@gondor.apana.org.au> <YlvU6ou14okbAbgW@arm.com>
 <YlvWtc/dJ6luXzZf@gondor.apana.org.au> <YlxAo5BAy+ARlvqj@arm.com>
 <Yl0jPdfdUkaStDN5@gondor.apana.org.au> <Yl2Vda/8S7qAvMjC@arm.com> <CAMj1kXEGdPageO3tb2=eLnGAR9-nZtmTGXcGf5CiTQFC4JiXOg@mail.gmail.com>
In-Reply-To: <CAMj1kXEGdPageO3tb2=eLnGAR9-nZtmTGXcGf5CiTQFC4JiXOg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Apr 2022 13:29:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1+GqbO5Kgf70nmR8rQg5OaLBsFZJWaOLuS7JRqXb-ZNA@mail.gmail.com>
Message-ID: <CAK8P3a1+GqbO5Kgf70nmR8rQg5OaLBsFZJWaOLuS7JRqXb-ZNA@mail.gmail.com>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
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
X-Provags-ID: V03:K1:FbQGnzRMGUp6v7xMxeWkNEPDfRyA1JaFCAbaC7RWmyxTt2bs4Ay
 NZFiuQ06+aKjquWu3GU5Ket5Y/1Iyfkooyoby1tLLZg0NreZ5DYjbVdaGcpoaJl9EyZBoK1
 cnBR4Zu6SipnWVG8cV18yJJTUav5bAmXW/UxjcTqbJFywok3mOtkFFbUoPzV4wKnnWvK2Y2
 hHb+F+fZzAieTGA3fg2Yw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HGLnGFU59rg=:/HO7d5VXb2KNTskQvcH35V
 XW2T30MeOntfgGxO3pAgNMFD1SbXPfCxaaLYI30AhLlgbljD57T/0eL6S+88eRRYpaMwWSrOb
 RteOWaV6QLdoYmx07Y86PEU5hZ6CVgMiWYhSzI56JmnqTh5ZKL01NAFNM10YOUv7pWBHyjHvL
 4Xg6Psc1tpMlFZolYHMKkfriFyP8yasq/1oXti7u1jNtrun0N1k8uTT6v7h4hfmMoy/HawHdY
 KFluq6Y1m5DeBhCrRjkFBkDZcfkwPBlfy0XyVCZLiHvCOakW8ImaFED9ITJP28dpVJC/Jspkt
 Q9D47wH7eh5Kvp9AnXxYF++LWyePUDDNgO9olNpB0a3eilH3GEumIGw7RqnW20VhcWpJy7shv
 1S9EDSZzXOZEFxF928d6LOB+M1ASylzrr05MNMxUzRf+vho3hdtVFLxvISlP6PTvGrPfR6mR/
 R40SeCwu4LMxw+PXP8uQyCK0P8u6ZkzuGDgO5uTUOMgAJhdquIulikLoPqJyM20HTXjRcWuw/
 iEnPENJ2KdlM0bCL56mTN9T98922cdW49TlKsNGcsRaI+x/iVmgOhkcZWv81t3p0rb/5G8Ixz
 sN+NMolmigIxM8GPtD6ES0GhXtE46QfPt44JyMUNJYm12aju5LY4FGbOLSmifXQHPapUSTkSK
 khohFfsCJ+Sd9nCfdkIFsK9U2EvKGCRmMlDyqvV5QyA0O/i43A0qm/YqRvM7Nu/xj+0E=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 11:50 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> On Mon, 18 Apr 2022 at 18:44, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Mon, Apr 18, 2022 at 04:37:17PM +0800, Herbert Xu wrote:

> > BTW before you have a go at this, there's also Linus' idea that does not
> > change the crypto code (at least not functionally). Of course, you and
> > Ard can still try to figure out how to reduce the padding but if we go
> > with Linus' idea of a new GFP_NODMA flag, there won't be any changes to
> > the crypto code as long as it doesn't pass such flag. So, the options:
> >
> > 1. Change ARCH_KMALLOC_MINALIGN to 8 (or ARCH_SLAB_MINALIGN if higher)
> >    while keeping ARCH_DMA_MINALIGN to 128. By default kmalloc() will
> >    honour the 128-byte alignment, unless GDP_NODMA is passed. This still
> >    requires changing CRYPTO_MINALIGN to ARCH_DMA_MINALIGN but there is
> >    no functional change, kmalloc() without the new flag will return
> >    CRYPTO_MINALIGN-aligned pointers.
> >
> > 2. Leave ARCH_KMALLOC_MINALIGN as ARCH_DMA_MINALIGN (128) and introduce
> >    a new GFP_PACKED (I think it fits better than 'NODMA') flag that
> >    reduces the minimum kmalloc() below ARCH_KMALLOC_MINALIGN (and
> >    probably at least ARCH_SLAB_MINALIGN). It's equivalent to (1) but
> >    does not touch the crypto code at all.
> >
> > (1) and (2) are the same, just minor naming difference. Happy to go with
> > any of them. They still have the downside that we need to add the new
> > GFP_ flag to those hotspots that allocate small objects (Arnd provided
> > an idea on how to find them with ftrace) but at least we know it won't
> > inadvertently break anything.

Right, both of these seem reasonable to me.

> I'm not sure GFP_NODMA adds much here.
>
> The way I see it, the issue in the crypto code is that we are relying
> on a ARCH_KMALLOC_ALIGN aligned zero length __ctx[] array for three
> different things:
...

Right. So as long as the crypto subsystem has additional alignment
requirement, it won't benefit from GFP_NODMA. For everything else,
GFP_NODMA would however have a very direct and measuable
impact on memory consumption.

Your proposed changes to the crypto subsystem all seem helpful
as well, just mostly orthogonal to the savings elsewhere. I don't know
how much memory is permanently tied up in overaligned crypto
data structures, but my guess is that it's not a lot on most systems.

Improving the alignment for crypto would however likely help
with stack usage on on-stack structures, and with performance
when the amount of ctx memory to clear for each operation
becomes smaller.

       Arnd
