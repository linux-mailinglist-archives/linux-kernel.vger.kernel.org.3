Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92684F5BE2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbiDFLDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241614AbiDFLCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:02:17 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A20528D10
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 00:29:37 -0700 (PDT)
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mw9Lu-1nsZaW0HZ6-00s6Zi for <linux-kernel@vger.kernel.org>; Wed, 06 Apr
 2022 09:29:36 +0200
Received: by mail-wr1-f45.google.com with SMTP id m30so1847161wrb.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 00:29:36 -0700 (PDT)
X-Gm-Message-State: AOAM532P/fXUxY7BOSmVH0Q7fTc8Mn3OTAWZhdzEpjf6x/jNxBHoXUyH
        WMjNQBKtDmaY+PcNTBUV2FDMqSD8SNNB6pw1u4k=
X-Google-Smtp-Source: ABdhPJzyKGu3dTz7c5wCMIgY8RrIo/iPoFC4jg/w0bCaH/HFgYzcAZoBaAjqJoBHz9Ym+MjmIi1iL6FIKFnTMAWf6Vc=
X-Received: by 2002:a05:6000:178c:b0:204:648:b4c4 with SMTP id
 e12-20020a056000178c00b002040648b4c4mr5325019wrg.219.1649230175681; Wed, 06
 Apr 2022 00:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <20220405135758.774016-2-catalin.marinas@arm.com> <YkzX1nM0Ca7apVBt@hyeyoo>
In-Reply-To: <YkzX1nM0Ca7apVBt@hyeyoo>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Apr 2022 09:29:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1K0=jwYEHVu=X7oAWk9dzaOYAdFsidwVRKCJVReSV3+g@mail.gmail.com>
Message-ID: <CAK8P3a1K0=jwYEHVu=X7oAWk9dzaOYAdFsidwVRKCJVReSV3+g@mail.gmail.com>
Subject: Re: [PATCH 01/10] mm/slab: Decouple ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINALIGN
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>, roman.gushchin@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:So8h0q9ZQICwqajKA7j398ySPx4gnTPbhPGpZie+33Zigmexopl
 wSZmniBKQ0uIGXvbmFrT9K+Y10U4VM+UL6jXszHDMaveFq3nGa3woJDbH3+KLk9N8qU7FWW
 HWLS84Ip/+/TSIwnuKhOBrm9kA77xV7hK4SFos1xlP+0qm9E/zhBKv5t3fHiIhRz7E7T1iJ
 SC4KVpTMICvFF7Fa2Z/UA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:easS4jZt73c=:R0u25Ml8TVTrQg81cUg1Kd
 UbE1c4mBHm5Ub9TSNuIFb1Q+cNHVGZtAQI7t0Ajf4q3SA8dk+YiHiFBE6tWhCCBXkblq4D2Zf
 0oA3RPzv/WARltUFvidfFzHDgx8Htwxqf893dEE8xvRcfY3B+cM3z5i4clWXash6h2KCZo2ga
 dhmgry5dvnhb1UjI+A/pxv6NL/aameEgGnuGrPt6/WNvuzWn8E3nHopWY32ruwx4yRjk3rV4l
 uGM65pBTfuZP86pAGBtnIgRld74YIjD6u6thEEdcC3G5Ly1417/B7Dw1MVfv1NzFbBbfEhEiU
 vQ2RXYqmEtDx8oKSTzE3POV1KkDPZaAACH57jBiD8Z6Xi5M0v+vnOGJNJHSr+8Is2hT8VFON/
 3KbNE45omKqeVSPTPVw8l4oKXtMYDgk69eH4Nm+KW00aTxnctVuPJfeCNjIr8PtQ2hbvzLtSc
 q5GVnNr/oO0w9/OWiLvNSXh62PzeM2U5oVk5hri3F1470byaRK+/BdXIphxpCDOpm1yk0XrAX
 2redUoIRjS8pdplL5q5HhivImHlLVG0p6n9IkDIKH8BdU4kew/4yBWikMtnJLHpwbOElZSejE
 3LuOUV3/KDfSb1a/gv6NU7QIKrtDVXp58w6t8bHe2NihfUtD2LOORPgKNTQQm3IoeKqpRZ1hl
 wbzrmKPOc1PHOfqCnWVJud2PSSIZuhxTYVZx3aoNICarJgqf6M0CAh6wCwQa/YZ+CalKjAJ3T
 IEiEU3JGzuQJAkBSLqnLh91YReh/dWOO8sY9x1V2Jlp5TLTS40CAWsUSs3YWf4QNr13aaZwTK
 ThJo3/VIr5FFMgMt5D9vEf8kQzZx2cxFcJBsfM2BkvSMleEeDA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 6, 2022 at 1:59 AM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> On Tue, Apr 05, 2022 at 02:57:49PM +0100, Catalin Marinas wrote:
> > In preparation for supporting a dynamic kmalloc() minimum alignment,
> > allow architectures to define ARCH_KMALLOC_MINALIGN independently of
> > ARCH_DMA_MINALIGN. In addition, always define ARCH_DMA_MINALIGN even if
> > an architecture does not override it.
> >
>
> [ +Cc slab maintainer/reviewers ]
>
> I get why you want to set minimum alignment of kmalloc() dynamically.
> That's because cache line size can be different and we cannot statically
> know that, right?
>
> But I don't get why you are trying to decouple ARCH_KMALLOC_MINALIGN
> from ARCH_DMA_MINALIGN. kmalloc'ed buffer is always supposed to be DMA-safe.
>
> I'm afraid this series may break some archs/drivers.
>
> in Documentation/dma-api-howto.rst:
> > 2) ARCH_DMA_MINALIGN
> >
> >   Architectures must ensure that kmalloc'ed buffer is
> >   DMA-safe. Drivers and subsystems depend on it. If an architecture
> >   isn't fully DMA-coherent (i.e. hardware doesn't ensure that data in
> >   the CPU cache is identical to data in main memory),
> >   ARCH_DMA_MINALIGN must be set so that the memory allocator
> >   makes sure that kmalloc'ed buffer doesn't share a cache line with
> >   the others. See arch/arm/include/asm/cache.h as an example.
> >
> >   Note that ARCH_DMA_MINALIGN is about DMA memory alignment
> >   constraints. You don't need to worry about the architecture data
> >   alignment constraints (e.g. the alignment constraints about 64-bit
> >   objects).
>
> If I'm missing something, please let me know :)

It helps in two ways:

- you can start with a relatively large hardcoded ARCH_DMA_MINALIGN
  of 128 or 256 bytes, depending on what the largest possible line size
  is for any machine you want to support, and then drop that down to
  32 or 64 bytes based on runtime detection. This should always be safe,
  and it means a very sizable chunk of wasted memory can be recovered.

- On systems that are fully cache coherent, there is no need to align
  kmallloc() allocations for DMA safety at all, on these, we can drop the
  size even below the cache line. This does not apply on most of the
  cheaper embedded or mobile SoCs, but it helps a lot on the machines
  you'd find in a data center.

        Arnd
