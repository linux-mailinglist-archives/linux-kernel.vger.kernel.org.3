Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8364D50A329
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389656AbiDUOui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389639AbiDUOuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:50:35 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4B34338B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:47:42 -0700 (PDT)
Received: from mail-wm1-f43.google.com ([209.85.128.43]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MlsWZ-1o8K8k1yNf-00j55e for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022
 16:47:41 +0200
Received: by mail-wm1-f43.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso6075325wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:47:41 -0700 (PDT)
X-Gm-Message-State: AOAM531+JEcwKbfBKT+gDx3J5LoQsdjjMZ3pmqFDUBrxlBFfEeaPCHxh
        No5DqENg74HeMpT0mA7H6g7A3bum6XN4WIMSI38=
X-Google-Smtp-Source: ABdhPJxpfQyeJ8FFSSRAVYsP7tX4SxkGVm3S8a1k62CpNiV8J87SliJxnOrtPTeyRtS6VZ24MDqHdm2WtoHwOU8AJN4=
X-Received: by 2002:a7b:ce15:0:b0:38e:b7b0:79be with SMTP id
 m21-20020a7bce15000000b0038eb7b079bemr8870300wmc.71.1650552461083; Thu, 21
 Apr 2022 07:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <YlxAo5BAy+ARlvqj@arm.com> <Yl0jPdfdUkaStDN5@gondor.apana.org.au>
 <Yl2Vda/8S7qAvMjC@arm.com> <CAMj1kXEGdPageO3tb2=eLnGAR9-nZtmTGXcGf5CiTQFC4JiXOg@mail.gmail.com>
 <CAK8P3a1+GqbO5Kgf70nmR8rQg5OaLBsFZJWaOLuS7JRqXb-ZNA@mail.gmail.com>
 <YmEFttLxGbyJx8LK@infradead.org> <YmE60ufokRCYOj8W@arm.com>
 <CAK8P3a34UTmJ5Tn2vbFaJjQrvO-G5LJOqe_6oQwR6zp+PJ8fjA@mail.gmail.com>
 <YmFbQiSFyQ+W85Zx@arm.com> <CAK8P3a28NuZE628f1Bga_-gGSpHnPFx=2cBW0oDW4MFAzCSb+w@mail.gmail.com>
 <YmFtuJmdMZcsoWnO@arm.com>
In-Reply-To: <YmFtuJmdMZcsoWnO@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Apr 2022 16:47:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Z83TbY6N_TCA-VtE9g6HzP5sySnqqP-D27Uqng3nu9w@mail.gmail.com>
Message-ID: <CAK8P3a2Z83TbY6N_TCA-VtE9g6HzP5sySnqqP-D27Uqng3nu9w@mail.gmail.com>
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
X-Provags-ID: V03:K1:LVaoYcR/yzXToY4XQaCHMihnNd9WPKphM0R6+jq7LKxEFQeaGVz
 cvs2k21UEkXLzY/XqUx8f4IMkeeLQG54lmzG6HtZXAleGsvaSS9jAgAjxvvq8JTwyd0JGAh
 ZTJHaLED0VjixU//FV6R+JGvWRDiFsEvEKcPkhosUupCAFsjfQ46mjoOSmHYJID+yKwMZjy
 uWN9YKdQQLG5ZXzBU216A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N7gcqfY2yGQ=:zUyyN9MiHDuco6NNg9SUIw
 xORNvRLX1N6Z/yt+sk6TaqePLr5pe6bxx/pM5+PQVaKjSjeESkJK0Jbrr9TEHJCJrvTVXBPZ7
 Mrgm34m+NAbmgD5M31kAaqnZhBC6VuAsApd52OnQ7z+jR6TNiZ8fCP714ZDWb704PuGQh0BhG
 G9FJTGl8qKOIMR34aHEwjWuQT32x/Ndwttcn9kvVimdQnnpCsvEQzuR4DGHBvrCUoSjoEnIbC
 Tz54sUiVvnJixr6BcO5egJjPAGgPEwwNRK5gj9eWOMxDsHH2MFvszx8BbrxDIedI+41jG91wK
 IC3wLzFZ9Nfva3+BmjAfwrMM3NO17s429zb2HmTzvHhppF1tf0k1b2D69IfzaVTk0fNRBViTz
 pM3G8yEBhdpeWe9GVJdTuw1V4TNlixr2UZQa2P+tKkKk3+DN4sP0rNR/mtxV8bFkHH3J2xdNF
 yJAvqB1TBFHzDgqRkLyqsRMGnrFqzthSAG14WmJ59v45COBBCC0vtUBt/hi2A8MPDApOn9she
 k66v1ENFHdrcdYTpw568RjSA1wWnyt0BNMBvHrjumufjRHIGT4hWpe5uZhMsl+JqqrvI59Fx5
 L8RXOYq8I2/PZ1OGSww8sNTF1PZiksfc4WtTFD43yG/nyTgvhX5mBQbxeEjjY86GXDMrIl7sO
 4EzRv2jmrCi3TgrtAUbamXjKpzILPOtbZwbq7dxkl2Aejs3peoumymiSwjZsby2+1opf550xh
 bNhosKnEHpuaBu6I9IL9koQF8QQywFZy2ZoRhf3f94vgINcxhuJA0s5Q50IKtl9oIuBT8Fe25
 EqF/CWUsnUzkzEcqa9E0rUKGikGWalJ2WI/CEQDOYWhkTPzOJ4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 4:44 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Thu, Apr 21, 2022 at 03:47:30PM +0200, Arnd Bergmann wrote:
> > On Thu, Apr 21, 2022 at 3:25 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Thu, Apr 21, 2022 at 02:28:45PM +0200, Arnd Bergmann wrote:
> > > > We also know that larger slabs are all cacheline aligned, so simply
> > > > comparing the transfer size is enough to rule out most, in this case
> > > > any transfer larger than 96 bytes must come from the kmalloc-128
> > > > or larger cache, so that works like before.
> > >
> > > There's also the case with 128-byte cache lines and kmalloc-192.
> >
> > Sure, but that's much less common, as the few machines with 128 byte
> > cache lines tend to also have cache coherent devices IIRC, so we'd
> > skip the bounce buffer entirely.
>
> Do you know which machines still have 128-byte cache lines _and_
> non-coherent DMA? If there isn't any that matters, I'd reduce
> ARCH_DMA_MINALIGN to 64 now (while trying to get to even smaller kmalloc
> caches).

I think the last time this came up, someone pointed out one of the
Qualcomm Snapdragon phone chips with their custom cores.

        Arnd
