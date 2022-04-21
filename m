Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4419B509937
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385997AbiDUHlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385966AbiDUHkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:40:47 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907B91B7AD
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:37:04 -0700 (PDT)
Received: from mail-wm1-f53.google.com ([209.85.128.53]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MLiPA-1nPuWM2jZY-00Hda4 for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022
 09:37:02 +0200
Received: by mail-wm1-f53.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso2771692wml.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:37:02 -0700 (PDT)
X-Gm-Message-State: AOAM532NMEu6Zd2deFTMOYOLvZNfVornnIyqk+TBUpUV2o6n+daIv0W4
        ayIqs1DFCBM9XGLEFfzA2OZKB94Uv37r4lrWkjA=
X-Google-Smtp-Source: ABdhPJwHFANIhlSxRKH9yHfX8gB2Ane77t+Nbt2ag7w+sIPoSWj1s9wj3aJHPT4PYoCntWM2lk8INTR7f05YbnZQfyw=
X-Received: by 2002:a05:600c:4e4a:b0:392:88e1:74a7 with SMTP id
 e10-20020a05600c4e4a00b0039288e174a7mr7297619wmq.174.1650526622334; Thu, 21
 Apr 2022 00:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <YlvK9iefUECy361O@gondor.apana.org.au> <YlvQTci7RP5evtTy@arm.com>
 <YlvRbvWSWMTtBJiN@gondor.apana.org.au> <YlvU6ou14okbAbgW@arm.com>
 <YlvWtc/dJ6luXzZf@gondor.apana.org.au> <YlxAo5BAy+ARlvqj@arm.com>
 <Yl0jPdfdUkaStDN5@gondor.apana.org.au> <Yl2Vda/8S7qAvMjC@arm.com>
 <CAMj1kXEGdPageO3tb2=eLnGAR9-nZtmTGXcGf5CiTQFC4JiXOg@mail.gmail.com>
 <CAK8P3a1+GqbO5Kgf70nmR8rQg5OaLBsFZJWaOLuS7JRqXb-ZNA@mail.gmail.com> <YmEFttLxGbyJx8LK@infradead.org>
In-Reply-To: <YmEFttLxGbyJx8LK@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Apr 2022 09:36:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3MVZ=QGcU8DaZbc5eaAt_FvoEEnqLqTYa=+9w__VYEig@mail.gmail.com>
Message-ID: <CAK8P3a3MVZ=QGcU8DaZbc5eaAt_FvoEEnqLqTYa=+9w__VYEig@mail.gmail.com>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
X-Provags-ID: V03:K1:d6W7v/3igwX/zZm34omNjccVPDecVuaklHaUXH1wdujkgAdcT/2
 ABiDP1z+AtMpoG3Zl2MTVgp4bCjp8JQ3ASv9XaNTmT5m2Fexs3P0HO9xVWoTC8gLQCtyAyU
 m5tv7Llu6VWx0Ebyp75DxjaAj9O1DkeHh7dEN6RoDswdX6nfha/fmtuIcAgMYMs6nEJe3U0
 pa1tG/WUB2eWQGoQ2UVOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QkUimz+hco0=:KyCd3bMtxlvq7krKCVuLFZ
 ubpPcegUrKMnuIOCYZtifZVmNB6dqsQoNa33M6Q221q0vvszH+XRFJCskrv6RnHyVQ142HiLX
 Glq3k7+XNtYoWFZO+16gGQrPsoA/c+P7Li3AqsZcY7BXQ8j0V2us89V7vy2AKUS3SNjL01CZV
 ksCg5zRExXnZgpcczkWYXgKIQiuM0rtf+Hu38m9M/bE07GuSwPJvQMA5bf/WQVSVK5mL7WwU8
 H8phCtUN2iJYHuWgPOIO6X5NBMyY1Wc7ZMGRd/JfIOTWzwXgvx791YXXdeBns5VQlX4YwwlGa
 RwPBFbjqJW+ZmNTL4LNt5rGMp80RtL7jCcOOnIOr74xsrxDiy7i3RyEyOETVnurM2RCthtA0s
 937hvvBuQ8yJ9ukc5Gt7yOV+7HyB4/vYL2ZqUqPjqDNsb+8lHT1NhI01AeDjTl/Jt49nuAkQu
 HJkxi6gKX+GvkrfaQ+rCTBJdUrbsoSmrzc3FeO9JQeKqINdqLc6m91ZG7sr1qtAJzDJAJTgDK
 TEs2zam5iPyZQELZ7LAv2PJCzIzEbJb1R5eFP9leZ3lZlvHEcyl6hleKmhHg/5y1xD2mnpM9c
 H0IONps0a8WVTr9F4OuvvH4FBBvctifLGObNUdkiH9U5X88S6qRP5BbTPPItZeQkFsVOYx+Py
 +dDjOUSdwXbqsGQyoLVbIRD0VHZ8QRGxT204WjIvZXIX2XMaW4p/5oiA4aN24OdpuF/FfIC/b
 UjFXnrjI2zTwNnvxwTU7G3tiktkDvKYe700I8oofu/QRmUtjatrPHiABj05kYEUCxswxs2fvb
 NB1DERlQuyIKdtsOp4rcEkWOFWtaoFWDB0yMOXY2vdBjSSXjuc=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 9:20 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> Btw, there is another option:  Most real systems already require having
> swiotlb to bounce buffer in some cases.  We could simply force bounce
> buffering in the dma mapping code for too small or not properly aligned
> transfers and just decrease the dma alignment.

I like the idea because these days we already rely on bounce buffering
for sub-page buffers in many iommu based cases for strict isolation
purposes, as well as most 64-bit machines that lack an iommu.

Does this work on all 32-bit architectures as well? I see that you added
swiotlb for ARM LPASE systems in 2019, but I don't know if that has any
additional requirements for the other 32-bit architectures that don't
select SWIOTLB today.

      Arnd
