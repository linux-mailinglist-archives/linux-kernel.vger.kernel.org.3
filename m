Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594E3587803
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbiHBHjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbiHBHjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:39:41 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F0EBC02
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:39:39 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id d1so8626438qvs.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 00:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hhcgsu7pbFk3suHOsUAkZjFxR6sHopCCyzmd+tYb3mU=;
        b=S6FbYWQQKXtg4ok4vdYbKa5GaZYWTO2CevZjnWopy+Dm+6SK5gNtTOtbi19WzsAIcl
         OwLz14MaZkxviJt+5urLHCTqjgDrQKZZSS8RaVsga61n22mvj4RUiUXTwCdHek4sz0eU
         VQYqVf5+/T+Q9L4+2rgYGkfpsTww3u39mQpLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hhcgsu7pbFk3suHOsUAkZjFxR6sHopCCyzmd+tYb3mU=;
        b=rHg2vD3yVjH15KNUNCRZHzTIhyW8zQUvUbM0gq6Mch3OB3TOxo7yXjmi3Yxz+b0rRB
         eggkRvD/UG8c692eIrK962YUngaAllPCYMMS6S1UO/4Bj4e4awzOKljYGFBT4J6OZwpk
         vLJVqIRoOLArZVJpfALxC8DRK9zFHAJRBsEY5rG8YYecUKP+kh3ZWiUM1kQoFQX9Qsp2
         yeuxt4ReAg+rpNB3f7Grjbs1wz3A7AXltS5REKtcsDi+OpZxhv2olTEi773HjfebcPzt
         vHIkY3a/65PIwGqXdsK8cpfGVzHVeJ7Z+2FJavGXg/qa+bttAKbEFQkq3vg3jC8eDW1d
         b7Dw==
X-Gm-Message-State: ACgBeo0clKTF6Pmaceb7cplFM5ML6X5DLvcr9Qnx89zL3X4JGs9pyI/b
        Yn+eB3oBVKBCNSP0Z4zvKU6TnxJALuq3Fw==
X-Google-Smtp-Source: AA6agR7Fj6DoSVMafQX14efvSrQKAhr8d/2sh5YU5EEWulFRN63u47lxkLt3QL01NEMm8OfEpn2rTQ==
X-Received: by 2002:a0c:8c82:0:b0:473:164b:c5eb with SMTP id p2-20020a0c8c82000000b00473164bc5ebmr17156132qvb.7.1659425978893;
        Tue, 02 Aug 2022 00:39:38 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id cd4-20020a05622a418400b0031f27b82268sm8641085qtb.71.2022.08.02.00.39.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 00:39:37 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id y127so22432598yby.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 00:39:36 -0700 (PDT)
X-Received: by 2002:a25:268d:0:b0:671:7030:f9d7 with SMTP id
 m135-20020a25268d000000b006717030f9d7mr14820256ybm.513.1659425976578; Tue, 02
 Aug 2022 00:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <B4B3306F-C3B4-4594-BDF9-4BBC59C628C9@soulik.info>
In-Reply-To: <B4B3306F-C3B4-4594-BDF9-4BBC59C628C9@soulik.info>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 2 Aug 2022 16:39:25 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AL=OejdaubnYDRF4M1EKyStZP_FAMPz4CJ=KCa_8QjaA@mail.gmail.com>
Message-ID: <CAAFQd5AL=OejdaubnYDRF4M1EKyStZP_FAMPz4CJ=KCa_8QjaA@mail.gmail.com>
Subject: Re: [PATCH] [Draft]: media: videobuf2-dma-heap: add a vendor defined
 memory runtine
To:     ayaka <ayaka@soulik.info>
Cc:     Hsia-Jun Li <randy.li@synaptics.com>, linux-media@vger.kernel.org,
        m.szyprowski@samsung.com, sumit.semwal@linaro.org,
        christian.koenig@amd.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 8:43 PM ayaka <ayaka@soulik.info> wrote:
>
>
>
> Sent from my iPad
>
> > On Aug 1, 2022, at 5:46 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> >
> > =EF=BB=BFCAUTION: Email originated externally, do not click links or op=
en attachments unless you recognize the sender and know the content is safe=
.
> >
> >
> >> On Mon, Aug 1, 2022 at 3:44 PM Hsia-Jun Li <Randy.Li@synaptics.com> wr=
ote:
> >>> On 8/1/22 14:19, Tomasz Figa wrote:
> >> Hello Tomasz
> >>> ?Hi Randy,
> >>> On Mon, Aug 1, 2022 at 5:21 AM <ayaka@soulik.info> wrote:
> >>>> From: Randy Li <ayaka@soulik.info>
> >>>> This module is still at a early stage, I wrote this for showing what
> >>>> APIs we need here.
> >>>> Let me explain why we need such a module here.
> >>>> If you won't allocate buffers from a V4L2 M2M device, this module
> >>>> may not be very useful. I am sure the most of users won't know a
> >>>> device would require them allocate buffers from a DMA-Heap then
> >>>> import those buffers into a V4L2's queue.
> >>>> Then the question goes back to why DMA-Heap. From the Android's
> >>>> description, we know it is about the copyright's DRM.
> >>>> When we allocate a buffer in a DMA-Heap, it may register that buffer
> >>>> in the trusted execution environment so the firmware which is runnin=
g
> >>>> or could only be acccesed from there could use that buffer later.
> >>>> The answer above leads to another thing which is not done in this
> >>>> version, the DMA mapping. Although in some platforms, a DMA-Heap
> >>>> responses a IOMMU device as well. For the genernal purpose, we would
> >>>> be better assuming the device mapping should be done for each device
> >>>> itself. The problem here we only know alloc_devs in those DMAbuf
> >>>> methods, which are DMA-heaps in my design, the device from the queue
> >>>> is not enough, a plane may requests another IOMMU device or table
> >>>> for mapping.
> >>>> Signed-off-by: Randy Li <ayaka@soulik.info>
> >>>> ---
> >>>> drivers/media/common/videobuf2/Kconfig        |   6 +
> >>>> drivers/media/common/videobuf2/Makefile       |   1 +
> >>>> .../common/videobuf2/videobuf2-dma-heap.c     | 350 ++++++++++++++++=
++
> >>>> include/media/videobuf2-dma-heap.h            |  30 ++
> >>>> 4 files changed, 387 insertions(+)
> >>>> create mode 100644 drivers/media/common/videobuf2/videobuf2-dma-heap=
.c
> >>>> create mode 100644 include/media/videobuf2-dma-heap.h
> >>> First of all, thanks for the series.
> >>> Possibly a stupid question, but why not just allocate the DMA-bufs
> >>> directly from the DMA-buf heap device in the userspace and just impor=
t
> >>> the buffers to the V4L2 device using V4L2_MEMORY_DMABUF?
> >> Sometimes the allocation policy could be very complex, let's suppose a
> >> multiple planes pixel format enabling with frame buffer compression.
> >> Its luma, chroma data could be allocated from a pool which is delegate=
d
> >> for large buffers while its metadata would come from a pool which many
> >> users could take some few slices from it(likes system pool).
> >> Then when we have a new users knowing nothing about this platform, if =
we
> >> just configure the alloc_devs in each queues well. The user won't need
> >> to know those complex rules.
> >> The real situation could be more complex, Samsung MFC's left and right
> >> banks could be regarded as two pools, many devices would benefit from
> >> this either from the allocation times or the security buffers policy.
> >> In our design, when we need to do some security decoding(DRM video),
> >> codecs2 would allocate buffers from the pool delegated for that. While
> >> the non-DRM video, users could not care about this.
> >
> > I'm a little bit surprised about this, because on Android all the
> > graphics buffers are allocated from the system IAllocator and imported
> > to the specific devices.
> In the non-tunnel mode, yes it is. While the tunnel mode is completely ve=
ndor defined. Neither HWC nor codec2 cares about where the buffers coming f=
rom, you could do what ever you want.
>
> Besides there are DRM video in GNU Linux platform, I heard the webkit has=
 made huge effort here and Playready is one could work in non-Android Linux=
.
> > Would it make sense to instead extend the UAPI to expose enough
> > information about the allocation requirements to the userspace, so it
> > can allocate correctly?
> Yes, it could. But as I said it would need the users to do more works.
> > My reasoning here is that it's not a driver's decision to allocate
> > from a DMA-buf heap (and which one) or not. It's the userspace which
> > knows that, based on the specific use case that it wants to fulfill.
> Although I would like to let the users decide that, users just can=E2=80=
=99t do that which would violate the security rules in some platforms.
> For example,  video codec and display device could only access a region o=
f memory, any other device or trusted apps can=E2=80=99t access it. Users h=
ave to allocate the buffer from the pool the vendor decided.
>
> So why not we offer a quick way that users don=E2=80=99t need to try and =
error.

In principle, I'm not against integrating DMA-buf heap with vb2,
however I see some problems I mentioned before:

1) How would the driver know if it should allocate from a DMA-buf heap or n=
ot?
2) How would the driver know which heap to allocate from?
3) How would the heap know how to allocate properly for the device?

Best regards,
Tomasz
