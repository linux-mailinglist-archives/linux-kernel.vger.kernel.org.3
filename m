Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D6658A93D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 12:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbiHEKJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 06:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239543AbiHEKJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 06:09:53 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7FF6715E
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 03:09:51 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id y11so1438943qvn.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 03:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8osKs3XHWs2tJshTy51ciuxCpaj0R2ycT8OfaZIOWNQ=;
        b=Wux8wYgJ+wtdOYj6/wLNTMNtVsjmK6vhZFf4SpuJ5w5bV7UGZQ1ODQTPVja2hW1nwv
         QgUs9HzuV1/ZtfI+iJGCQR5A4oz8ElXQKwCIjVPoecshhsQ+d4a9hjiRKIz2+KCoyBQ7
         49OwqChszzHDLl7bviXz2rTxmIKZvQAZCz+gU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8osKs3XHWs2tJshTy51ciuxCpaj0R2ycT8OfaZIOWNQ=;
        b=bOVoJMx7DyAyxFXeOjZgUunN87jNLlVEyeCr9FZzhTRZm9xkp8T4wlbrm8Z/deaoKh
         6gnMXSFRsMzdZgC/VjFk765m3Xp9lqTheZomMg0Iv0aYU5FfKnpcbkVe4FIrcxaUpF1L
         PqjmFmChW/MHjoafJ0zWCmCnv1qLRO9AMOYibFIuJzgjKXKkvZtZ56qW9rQ91tQ2+0it
         JepxgPUldL6oxFfNklEBPQoEOac8k3qOmUu8NQ4nHMm9f2NkLl3leCtmUJtcmdVgbLCz
         a5l2Y5BiSKFL2Tyx7a4C+HT7IkoL6tLrXb3B+YhwKSUQyWekYElBtVXHO2buxxNBvNWZ
         lb3A==
X-Gm-Message-State: ACgBeo3wFPvtO3GBRbeE3whDzgShbnk5rXNyxtvGgIFP8QxoBPUleMv2
        6/NM/eiW/+HO2Izwe+vjEtaUaZT0c/z4PQ==
X-Google-Smtp-Source: AA6agR4XjncOxX9YknPvQhYhjPqvbE7dHkGa4NVgk+N78MgRyWS9zjJxzrlN/gYeQjDr89Iar5Kmbw==
X-Received: by 2002:a05:6214:d81:b0:45a:e07e:6bcb with SMTP id e1-20020a0562140d8100b0045ae07e6bcbmr4954954qve.29.1659694190445;
        Fri, 05 Aug 2022 03:09:50 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id ew7-20020a05622a514700b0031eb65e1cb6sm2339868qtb.5.2022.08.05.03.09.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 03:09:48 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 123so3077797ybv.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 03:09:47 -0700 (PDT)
X-Received: by 2002:a05:6902:1382:b0:66f:f9fe:79d6 with SMTP id
 x2-20020a056902138200b0066ff9fe79d6mr4625654ybu.493.1659694187287; Fri, 05
 Aug 2022 03:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAAFQd5AL=OejdaubnYDRF4M1EKyStZP_FAMPz4CJ=KCa_8QjaA@mail.gmail.com>
 <CF192A87-1664-45B2-B26C-A9B8B6A52523@soulik.info>
In-Reply-To: <CF192A87-1664-45B2-B26C-A9B8B6A52523@soulik.info>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 5 Aug 2022 19:09:35 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DTNDkZ7W0Rs8Xfq-x+y+cmHZHkDYQys29aNt2YvCJc1A@mail.gmail.com>
Message-ID: <CAAFQd5DTNDkZ7W0Rs8Xfq-x+y+cmHZHkDYQys29aNt2YvCJc1A@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 9:21 PM ayaka <ayaka@soulik.info> wrote:
>
> Sorry, the previous one contains html data.
>
> > On Aug 2, 2022, at 3:33 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> >
> > =EF=BB=BFOn Mon, Aug 1, 2022 at 8:43 PM ayaka <ayaka@soulik.info> wrote=
:
> >> Sent from my iPad
> >>>> On Aug 1, 2022, at 5:46 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> >>> =EF=BB=BFCAUTION: Email originated externally, do not click links or =
open attachments unless you recognize the sender and know the content is sa=
fe.
> >>>> On Mon, Aug 1, 2022 at 3:44 PM Hsia-Jun Li <Randy.Li@synaptics.com> =
wrote:
> >>>>> On 8/1/22 14:19, Tomasz Figa wrote:
> >>>> Hello Tomasz
> >>>>> ?Hi Randy,
> >>>>> On Mon, Aug 1, 2022 at 5:21 AM <ayaka@soulik.info> wrote:
> >>>>>> From: Randy Li <ayaka@soulik.info>
> >>>>>> This module is still at a early stage, I wrote this for showing wh=
at
> >>>>>> APIs we need here.
> >>>>>> Let me explain why we need such a module here.
> >>>>>> If you won't allocate buffers from a V4L2 M2M device, this module
> >>>>>> may not be very useful. I am sure the most of users won't know a
> >>>>>> device would require them allocate buffers from a DMA-Heap then
> >>>>>> import those buffers into a V4L2's queue.
> >>>>>> Then the question goes back to why DMA-Heap. From the Android's
> >>>>>> description, we know it is about the copyright's DRM.
> >>>>>> When we allocate a buffer in a DMA-Heap, it may register that buff=
er
> >>>>>> in the trusted execution environment so the firmware which is runn=
ing
> >>>>>> or could only be acccesed from there could use that buffer later.
> >>>>>> The answer above leads to another thing which is not done in this
> >>>>>> version, the DMA mapping. Although in some platforms, a DMA-Heap
> >>>>>> responses a IOMMU device as well. For the genernal purpose, we wou=
ld
> >>>>>> be better assuming the device mapping should be done for each devi=
ce
> >>>>>> itself. The problem here we only know alloc_devs in those DMAbuf
> >>>>>> methods, which are DMA-heaps in my design, the device from the que=
ue
> >>>>>> is not enough, a plane may requests another IOMMU device or table
> >>>>>> for mapping.
> >>>>>> Signed-off-by: Randy Li <ayaka@soulik.info>
> >>>>>> ---
> >>>>>> drivers/media/common/videobuf2/Kconfig        |   6 +
> >>>>>> drivers/media/common/videobuf2/Makefile       |   1 +
> >>>>>> .../common/videobuf2/videobuf2-dma-heap.c     | 350 ++++++++++++++=
++++
> >>>>>> include/media/videobuf2-dma-heap.h            |  30 ++
> >>>>>> 4 files changed, 387 insertions(+)
> >>>>>> create mode 100644 drivers/media/common/videobuf2/videobuf2-dma-he=
ap.c
> >>>>>> create mode 100644 include/media/videobuf2-dma-heap.h
> >>>>> First of all, thanks for the series.
> >>>>> Possibly a stupid question, but why not just allocate the DMA-bufs
> >>>>> directly from the DMA-buf heap device in the userspace and just imp=
ort
> >>>>> the buffers to the V4L2 device using V4L2_MEMORY_DMABUF?
> >>>> Sometimes the allocation policy could be very complex, let's suppose=
 a
> >>>> multiple planes pixel format enabling with frame buffer compression.
> >>>> Its luma, chroma data could be allocated from a pool which is delega=
ted
> >>>> for large buffers while its metadata would come from a pool which ma=
ny
> >>>> users could take some few slices from it(likes system pool).
> >>>> Then when we have a new users knowing nothing about this platform, i=
f we
> >>>> just configure the alloc_devs in each queues well. The user won't ne=
ed
> >>>> to know those complex rules.
> >>>> The real situation could be more complex, Samsung MFC's left and rig=
ht
> >>>> banks could be regarded as two pools, many devices would benefit fro=
m
> >>>> this either from the allocation times or the security buffers policy=
.
> >>>> In our design, when we need to do some security decoding(DRM video),
> >>>> codecs2 would allocate buffers from the pool delegated for that. Whi=
le
> >>>> the non-DRM video, users could not care about this.
> >>> I'm a little bit surprised about this, because on Android all the
> >>> graphics buffers are allocated from the system IAllocator and importe=
d
> >>> to the specific devices.
> >> In the non-tunnel mode, yes it is. While the tunnel mode is completely=
 vendor defined. Neither HWC nor codec2 cares about where the buffers comin=
g from, you could do what ever you want.
> >> Besides there are DRM video in GNU Linux platform, I heard the webkit =
has made huge effort here and Playready is one could work in non-Android Li=
nux.
> >>> Would it make sense to instead extend the UAPI to expose enough
> >>> information about the allocation requirements to the userspace, so it
> >>> can allocate correctly?
> >> Yes, it could. But as I said it would need the users to do more works.
> >>> My reasoning here is that it's not a driver's decision to allocate
> >>> from a DMA-buf heap (and which one) or not. It's the userspace which
> >>> knows that, based on the specific use case that it wants to fulfill.
> >> Although I would like to let the users decide that, users just can=E2=
=80=99t do that which would violate the security rules in some platforms.
> >> For example,  video codec and display device could only access a regio=
n of memory, any other device or trusted apps can=E2=80=99t access it. User=
s have to allocate the buffer from the pool the vendor decided.
> >> So why not we offer a quick way that users don=E2=80=99t need to try a=
nd error.
> >
> > In principle, I'm not against integrating DMA-buf heap with vb2,
> > however I see some problems I mentioned before:
> >
> > 1) How would the driver know if it should allocate from a DMA-buf heap =
or not?
>
> struct vb2_queue.mem_ops
>
> int (*queue_setup)(struct vb2_queue *q,unsigned int *num_buffers, unsigne=
d int *num_planes, unsigned int sizes[], struct device *alloc_devs[]);

Sorry, I don't understand what you mean here.

Just to make sure we're on the same page - what I'm referring to is
that whether DMA-buf heap is used or not is specific to a given use
case, which is controlled by the userspace. So the userspace must be
able to control whether the driver allocates from a DMA-buf heap or
the regular way.

>
> > 2) How would the driver know which heap to allocate from?
>
> From vb2_queue.alloc_devs
>
> What I did now is likes what MFC does, create some mem_alloc_devs.
> It would be better that we could retrieve the DMA-heaps=E2=80=99 devices =
from kernel, but that is not enough, we need a place to store the heap flag=
s although none of them are defined yet.
>
> From Android documents, I think it is unlikely we would have heap flags.
> =E2=80=9CStandardization: The DMA-BUF heaps framework offers a well-defin=
ed UAPI. ION allowed custom flags and heap IDs that prevented developing a =
common testing framework because each device=E2=80=99s ION implementation c=
ould behave differently.=E2=80=9D
>

alloc_devs is something that the driver sets and it's a struct device
for which the DMA API can be called to manage the DMA buffers for this
video device. It's not a way to select a use case-dependent allocation
method.

> > 3) How would the heap know how to allocate properly for the device?
> >
> Because =E2=80=9Ceach DMA-BUF heap is a separate character device=E2=80=
=9D.

Could you elaborate? Sorry, I'm not sure how this answers my question.

> But as I said in the first draft I am not sure about the DMA mapping part=
. alloc_devs responds for the heap, we have a device variable in the queue =
that mapping function could access, but that may not be enough. A plane may=
 apply a different mapping policy or IOMMU here.
>
> Would it be better that I create a interface here that creating a memdev =
with DMA-heap description ?

My intuition still tells me that it would be universally better to
just let the userspace allocate the buffers independently (like with
gralloc/Ion) and import to V4L2 using V4L2_MEM_DMABUF. It was possible
to do things this way nicely with regular Android graphics buffers, so
could you explain what difference of your use case makes it
impossible?

Best regards,
Tomasz
