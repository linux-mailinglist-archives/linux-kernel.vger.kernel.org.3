Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A5E50A125
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387356AbiDUNul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237031AbiDUNuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:50:39 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B182037AB6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:47:48 -0700 (PDT)
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MFsd7-1nghxd3khr-00HNYE for <linux-kernel@vger.kernel.org>; Thu, 21 Apr
 2022 15:47:46 +0200
Received: by mail-wr1-f41.google.com with SMTP id b19so6746953wrh.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:47:46 -0700 (PDT)
X-Gm-Message-State: AOAM533KbjYVV/JHC7yYiMzurxO88/YHdMKDXErIpXs8rIjUWbaMLdKx
        G/2jwiAnBpdCBxvXV5XNts0llkiUaZEXfCHE+QY=
X-Google-Smtp-Source: ABdhPJxlTD/9qBGDU0e1jg9N9/Rwj2mMB1+npoLE9MkXqDzrZ1/XxNNHg+b6aJOfUifK9Zh8DdyQ/9/LkttN0wyPoV8=
X-Received: by 2002:a5d:64a3:0:b0:20a:7931:5b84 with SMTP id
 m3-20020a5d64a3000000b0020a79315b84mr20340921wrp.407.1650548866522; Thu, 21
 Apr 2022 06:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <YlvU6ou14okbAbgW@arm.com> <YlvWtc/dJ6luXzZf@gondor.apana.org.au>
 <YlxAo5BAy+ARlvqj@arm.com> <Yl0jPdfdUkaStDN5@gondor.apana.org.au>
 <Yl2Vda/8S7qAvMjC@arm.com> <CAMj1kXEGdPageO3tb2=eLnGAR9-nZtmTGXcGf5CiTQFC4JiXOg@mail.gmail.com>
 <CAK8P3a1+GqbO5Kgf70nmR8rQg5OaLBsFZJWaOLuS7JRqXb-ZNA@mail.gmail.com>
 <YmEFttLxGbyJx8LK@infradead.org> <YmE60ufokRCYOj8W@arm.com>
 <CAK8P3a34UTmJ5Tn2vbFaJjQrvO-G5LJOqe_6oQwR6zp+PJ8fjA@mail.gmail.com> <YmFbQiSFyQ+W85Zx@arm.com>
In-Reply-To: <YmFbQiSFyQ+W85Zx@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Apr 2022 15:47:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a28NuZE628f1Bga_-gGSpHnPFx=2cBW0oDW4MFAzCSb+w@mail.gmail.com>
Message-ID: <CAK8P3a28NuZE628f1Bga_-gGSpHnPFx=2cBW0oDW4MFAzCSb+w@mail.gmail.com>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:f6Jt7MC2mWxZiJUgZrTQtPgLKdkASbBY2UAbZKWW9tkkWoCKRQs
 CZBOOErjdIn63yNlMGoT7syFsPULx9gMLO858ybjffM+xJVFHLOHeOkPuUUDoknxpTTKdHM
 Qpcr1JMXFJMmwfOLpqIRqo/QmdfSDIdSJcIdedBzdusdyO7ZbSst3RnQz+hoEvtHLO9gvG1
 6N2YjAuXegX4DNLwAZLHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7pFwCqMj0Ic=:p2hPBpxbqtgxe97RrDDZRb
 TJud/NkxbqAUTky/S2lr3ZYU5zKY1OkANUYsDX77wX1fHC4a5+nO4hgp0UWPec8Jq/BPkZsZt
 D1X2ekdkFJp1u4TsVdCVbC3CAXFsxwlW9LArmUawsrpA98Aty7hEsJnQTV89vZhnBeIxTXlyE
 15yAWv7CESrylrD9W24Mz3MrOcU1LjnpVS7oh4wxFFiMrv5Oir/BY6o2AgL/nmt4NNG/cCrNA
 mYVG6UknLsVm9llbdp71OJzGeKMIz1dzQ/u7/DrHBibDl6pSsNHR9hw4FbJvQnAI6kzhFRCjn
 SzlKtbqM1nT6g7tSM006zkK1K9xJ/julwGecPiCDKGW1RuinN70pz5WypAnc1mXnPkcCawPpF
 3fDBe9/U4cErCzFfzWffdsYXlaCRByUMXbSB7N1mlMyWTecUiajylhEC8UJUe5PzSAd0odjni
 vUl8q3GxsCrMb/ORp+N3hyiP0IiRbe2VETQvT6hTtILDXxDWbKmGvc9aNKCDAkGee/EtJYA+9
 jEXuBspdUzMNAoU1f9U/eK00MW5vr79FzDXOVlH7JbjlgqJQkCsO4pc5DRLn5pNmsdek4VcCq
 aR+MBllpkngPYB6tWpbmtSsMJG+o6qfQ2EvcE4JwJMoZiILkF0xBE9FCzZCuSmuyjdBk24hJM
 jTQVeOaTjjqhCXQULsLbbeBal1MC0BcCYTStzpCi0GNtcPAyRwYxVq1VK5t+3QJT/rLilRsqZ
 AhtM0pFGh/fNeJmBSJ+t8Dhj2bb7qcOb00qVjiR76rItdLCnzopQw5EeGNLdGWi7qMIh5oD1m
 pQ7vxm2EvlQLPOPOAwBnqy3CVbE6zYVwwL/TqnpYKB1eHQ6Lpw=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 3:25 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Thu, Apr 21, 2022 at 02:28:45PM +0200, Arnd Bergmann wrote:
> > We also know that larger slabs are all cacheline aligned, so simply
> > comparing the transfer size is enough to rule out most, in this case
> > any transfer larger than 96 bytes must come from the kmalloc-128
> > or larger cache, so that works like before.
>
> There's also the case with 128-byte cache lines and kmalloc-192.

Sure, but that's much less common, as the few machines with 128 byte
cache lines tend to also have cache coherent devices IIRC, so we'd
skip the bounce buffer entirely.

> > For transfers <=96 bytes, the possibilities are:
> >
> > 1.kmalloc-32 or smaller, always needs to bounce
> > 2. kmalloc-96, but at least one byte in partial cache line,
> >     need to bounce
> > 3. kmalloc-64, may skip the bounce.
> > 4. kmalloc-128 or larger, or not a slab cache but a partial
> >     transfer, may skip the bounce.
> >
> > I would guess that the first case is the most common here,
> > so unless bouncing one or two cache lines is extremely
> > expensive, I don't expect it to be worth optimizing for the latter
> > two cases.
>
> I think so. If someone complains of a performance regression, we can
> look at optimising the bounce. I have a suspicion the cost of copying
> two cache lines is small compared to swiotlb_find_slots() etc.

That is possible, and we'd definitely have to watch out for
performance regressions, I'm just skeptical that the cases that
suffer from the extra bouncer buffering on 33..64 byte allocations
benefit much from having a special case if the 1...32 and 65..96
byte allocations are still slow.

Another simpler way to do this might be to just not create the
kmalloc-96 (or kmalloc-192) caches, and assuming that any
transfer >=33 (or 65) bytes is safe.

       Arnd
