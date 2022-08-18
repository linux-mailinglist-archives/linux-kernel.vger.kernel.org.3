Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8643597E38
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 07:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243446AbiHRFu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 01:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243329AbiHRFuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 01:50:52 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C067EFF0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 22:50:50 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id t11so428723qkt.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 22:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=KnXVfj+T4u59u5J2KygjH6Rp2ec5Yoi6AW22Q/4H+6I=;
        b=gYFJGDKAZN34/WoR5EjsSipswRGwu4w7Ht8XDPDeVPSVtQHCznF5MPwovMhqc8OC8u
         8THI+3cp0xPYujus/2EiU0efdwxnIE5LnwRoH/V8aNGE7bdRG1C7p2AH6QjaM1p/3xVQ
         aYAT62RdhRis0COJDJJ5ZL5+dKJu7zqxUmYmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=KnXVfj+T4u59u5J2KygjH6Rp2ec5Yoi6AW22Q/4H+6I=;
        b=3xDmj5nyV2sou3BiHTmqNcMjDNhWw6TZrfZH/1uio4uT9LU+/k8Y0pu9EudXoSARWN
         sHvdY78W6iz8RzrGlxVVax43UOI5AgT7tLNwhFvzQLAQK9x1IOKylcB9/GhvjGDGnTsw
         kzLg0J2vwxcDhWm39yIenlHBSh76ePVstWvGxltYLFBIUkmnzlwYC/nHyPf6KGbqc5xJ
         XIF3GgsXXpRoTeCGGyuJ3xBqY+XHRv356Dv+RIP93j/bwfPkjYND2S7RSq0zSfWpPtgm
         fewiLAGFl/cULMTkaF8bIiYiWk7S24dwD0K7uXLFvfNS725dMHdDX7Q9gBAMoOmOhmuy
         zw6A==
X-Gm-Message-State: ACgBeo3IwVcV1IF5J79VYnxc3MHW8Whvi5LCMcUDeOyx7zNf7s5612GF
        Puzsj5UCk87U4HMj8asyMlvRv+qMjPI32A==
X-Google-Smtp-Source: AA6agR5QlJ8eu3z8oAYe2YDW8jxFBTNdzltVzKMClcgcg+X8KDxr4Tcu/NKGwo3H5dHSvlX5GKzViA==
X-Received: by 2002:a05:620a:40cf:b0:6b1:41dd:9710 with SMTP id g15-20020a05620a40cf00b006b141dd9710mr949436qko.727.1660801849587;
        Wed, 17 Aug 2022 22:50:49 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id b26-20020ac86bda000000b0034454aff529sm357112qtt.80.2022.08.17.22.50.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 22:50:48 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-333a4a5d495so14157237b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 22:50:47 -0700 (PDT)
X-Received: by 2002:a25:6a46:0:b0:67b:66ad:ae40 with SMTP id
 f67-20020a256a46000000b0067b66adae40mr1387247ybc.261.1660801846946; Wed, 17
 Aug 2022 22:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAAFQd5AL=OejdaubnYDRF4M1EKyStZP_FAMPz4CJ=KCa_8QjaA@mail.gmail.com>
 <CF192A87-1664-45B2-B26C-A9B8B6A52523@soulik.info> <CAAFQd5DTNDkZ7W0Rs8Xfq-x+y+cmHZHkDYQys29aNt2YvCJc1A@mail.gmail.com>
 <7c7c2c49-a0e4-cda8-be29-0d143851b9fd@synaptics.com>
In-Reply-To: <7c7c2c49-a0e4-cda8-be29-0d143851b9fd@synaptics.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 18 Aug 2022 14:50:35 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BDWBwYH=hfQBmvuyB6xSgXhHKhv2093w2irz4C4_kX5w@mail.gmail.com>
Message-ID: <CAAFQd5BDWBwYH=hfQBmvuyB6xSgXhHKhv2093w2irz4C4_kX5w@mail.gmail.com>
Subject: Re: [PATCH] [Draft]: media: videobuf2-dma-heap: add a vendor defined
 memory runtine
To:     Hsia-Jun Li <Randy.Li@synaptics.com>
Cc:     linux-media@vger.kernel.org, m.szyprowski@samsung.com,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, ayaka <ayaka@soulik.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Sorry for the late reply, I went on vacation last week.

On Sun, Aug 7, 2022 at 12:23 AM Hsia-Jun Li <Randy.Li@synaptics.com> wrote:
>
>
>
> On 8/5/22 18:09, Tomasz Figa wrote:
> > CAUTION: Email originated externally, do not click links or open attach=
ments unless you recognize the sender and know the content is safe.
> >
> >
> > On Tue, Aug 2, 2022 at 9:21 PM ayaka <ayaka@soulik.info> wrote:
> >>
> >> Sorry, the previous one contains html data.
> >>
> >>> On Aug 2, 2022, at 3:33 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> >>>
> >>> =EF=BB=BFOn Mon, Aug 1, 2022 at 8:43 PM ayaka <ayaka@soulik.info> wro=
te:
> >>>> Sent from my iPad
> >>>>>> On Aug 1, 2022, at 5:46 PM, Tomasz Figa <tfiga@chromium.org> wrote=
:
> >>>>> =EF=BB=BFCAUTION: Email originated externally, do not click links o=
r open attachments unless you recognize the sender and know the content is =
safe.
> >>>>>> On Mon, Aug 1, 2022 at 3:44 PM Hsia-Jun Li <Randy.Li@synaptics.com=
> wrote:
> >>>>>>> On 8/1/22 14:19, Tomasz Figa wrote:
> >>>>>> Hello Tomasz
> >>>>>>> ?Hi Randy,
> >>>>>>> On Mon, Aug 1, 2022 at 5:21 AM <ayaka@soulik.info> wrote:
> >>>>>>>> From: Randy Li <ayaka@soulik.info>
> >>>>>>>> This module is still at a early stage, I wrote this for showing =
what
> >>>>>>>> APIs we need here.
> >>>>>>>> Let me explain why we need such a module here.
> >>>>>>>> If you won't allocate buffers from a V4L2 M2M device, this modul=
e
> >>>>>>>> may not be very useful. I am sure the most of users won't know a
> >>>>>>>> device would require them allocate buffers from a DMA-Heap then
> >>>>>>>> import those buffers into a V4L2's queue.
> >>>>>>>> Then the question goes back to why DMA-Heap. From the Android's
> >>>>>>>> description, we know it is about the copyright's DRM.
> >>>>>>>> When we allocate a buffer in a DMA-Heap, it may register that bu=
ffer
> >>>>>>>> in the trusted execution environment so the firmware which is ru=
nning
> >>>>>>>> or could only be acccesed from there could use that buffer later=
.
> >>>>>>>> The answer above leads to another thing which is not done in thi=
s
> >>>>>>>> version, the DMA mapping. Although in some platforms, a DMA-Heap
> >>>>>>>> responses a IOMMU device as well. For the genernal purpose, we w=
ould
> >>>>>>>> be better assuming the device mapping should be done for each de=
vice
> >>>>>>>> itself. The problem here we only know alloc_devs in those DMAbuf
> >>>>>>>> methods, which are DMA-heaps in my design, the device from the q=
ueue
> >>>>>>>> is not enough, a plane may requests another IOMMU device or tabl=
e
> >>>>>>>> for mapping.
> >>>>>>>> Signed-off-by: Randy Li <ayaka@soulik.info>
> >>>>>>>> ---
> >>>>>>>> drivers/media/common/videobuf2/Kconfig        |   6 +
> >>>>>>>> drivers/media/common/videobuf2/Makefile       |   1 +
> >>>>>>>> .../common/videobuf2/videobuf2-dma-heap.c     | 350 ++++++++++++=
++++++
> >>>>>>>> include/media/videobuf2-dma-heap.h            |  30 ++
> >>>>>>>> 4 files changed, 387 insertions(+)
> >>>>>>>> create mode 100644 drivers/media/common/videobuf2/videobuf2-dma-=
heap.c
> >>>>>>>> create mode 100644 include/media/videobuf2-dma-heap.h
> >>>>>>> First of all, thanks for the series.
> >>>>>>> Possibly a stupid question, but why not just allocate the DMA-buf=
s
> >>>>>>> directly from the DMA-buf heap device in the userspace and just i=
mport
> >>>>>>> the buffers to the V4L2 device using V4L2_MEMORY_DMABUF?
> >>>>>> Sometimes the allocation policy could be very complex, let's suppo=
se a
> >>>>>> multiple planes pixel format enabling with frame buffer compressio=
n.
> >>>>>> Its luma, chroma data could be allocated from a pool which is dele=
gated
> >>>>>> for large buffers while its metadata would come from a pool which =
many
> >>>>>> users could take some few slices from it(likes system pool).
> >>>>>> Then when we have a new users knowing nothing about this platform,=
 if we
> >>>>>> just configure the alloc_devs in each queues well. The user won't =
need
> >>>>>> to know those complex rules.
> >>>>>> The real situation could be more complex, Samsung MFC's left and r=
ight
> >>>>>> banks could be regarded as two pools, many devices would benefit f=
rom
> >>>>>> this either from the allocation times or the security buffers poli=
cy.
> >>>>>> In our design, when we need to do some security decoding(DRM video=
),
> >>>>>> codecs2 would allocate buffers from the pool delegated for that. W=
hile
> >>>>>> the non-DRM video, users could not care about this.
> >>>>> I'm a little bit surprised about this, because on Android all the
> >>>>> graphics buffers are allocated from the system IAllocator and impor=
ted
> >>>>> to the specific devices.
> >>>> In the non-tunnel mode, yes it is. While the tunnel mode is complete=
ly vendor defined. Neither HWC nor codec2 cares about where the buffers com=
ing from, you could do what ever you want.
> >>>> Besides there are DRM video in GNU Linux platform, I heard the webki=
t has made huge effort here and Playready is one could work in non-Android =
Linux.
> >>>>> Would it make sense to instead extend the UAPI to expose enough
> >>>>> information about the allocation requirements to the userspace, so =
it
> >>>>> can allocate correctly?
> >>>> Yes, it could. But as I said it would need the users to do more work=
s.
> >>>>> My reasoning here is that it's not a driver's decision to allocate
> >>>>> from a DMA-buf heap (and which one) or not. It's the userspace whic=
h
> >>>>> knows that, based on the specific use case that it wants to fulfill=
.
> >>>> Although I would like to let the users decide that, users just can=
=E2=80=99t do that which would violate the security rules in some platforms=
.
> >>>> For example,  video codec and display device could only access a reg=
ion of memory, any other device or trusted apps can=E2=80=99t access it. Us=
ers have to allocate the buffer from the pool the vendor decided.
> >>>> So why not we offer a quick way that users don=E2=80=99t need to try=
 and error.
> >>>
> >>> In principle, I'm not against integrating DMA-buf heap with vb2,
> >>> however I see some problems I mentioned before:
> >>>
> >>> 1) How would the driver know if it should allocate from a DMA-buf hea=
p or not?
> >>
> >> struct vb2_queue.mem_ops
> >>
> >> int (*queue_setup)(struct vb2_queue *q,unsigned int *num_buffers, unsi=
gned int *num_planes, unsigned int sizes[], struct device *alloc_devs[]);
> >
> > Sorry, I don't understand what you mean here.
> >
> > Just to make sure we're on the same page - what I'm referring to is
> > that whether DMA-buf heap is used or not is specific to a given use
> > case, which is controlled by the userspace. So the userspace must be
> > able to control whether the driver allocates from a DMA-buf heap or
> > the regular way.
> No, it does not depend on the use case here. We don't accept any buffers
> beyond the region we decided. Even for the non-DRM, non-security video,
> our codec devices are running under the secure mode.
>
> You MUST allocate the buffer for a device from the DMA-heap we(SYNA)
> decided.

That's your use case, but there could be use cases which work
differently. In fact, in ChromeOS we only use the secure allocation
path for protected content, because it imposes some overhead.

>
> I believe some other devices may have much limitation for not the
> security reason, for example, it can't access the memory above 4 GiB or
> for the performance's reason.

For such limitations, there is the shared DMA pool or restricted DMA
pool functionality, which can be given to a device in DT and then the
DMA mapping API would just allocate within that area for that device.
Maybe that's what you need here?

> >
> >>
> >>> 2) How would the driver know which heap to allocate from?
> >>
> >>  From vb2_queue.alloc_devs
> >>
> >> What I did now is likes what MFC does, create some mem_alloc_devs.
> >> It would be better that we could retrieve the DMA-heaps=E2=80=99 devic=
es from kernel, but that is not enough, we need a place to store the heap f=
lags although none of them are defined yet.
> >>
> >>  From Android documents, I think it is unlikely we would have heap fla=
gs.
> >> =E2=80=9CStandardization: The DMA-BUF heaps framework offers a well-de=
fined UAPI. ION allowed custom flags and heap IDs that prevented developing=
 a common testing framework because each device=E2=80=99s ION implementatio=
n could behave differently.=E2=80=9D
> >>
> >
> > alloc_devs is something that the driver sets and it's a struct device
> > for which the DMA API can be called to manage the DMA buffers for this
> > video device. It's not a way to select a use case-dependent allocation
> > method.
> >
> I see, then move to the last question, we need to expand the V4L2
> framework's structure.
> >>> 3) How would the heap know how to allocate properly for the device?
> >>>
> >> Because =E2=80=9Ceach DMA-BUF heap is a separate character device=E2=
=80=9D.
> >
> > Could you elaborate? Sorry, I'm not sure how this answers my question.
> Because a DMA-heap, a heap device itself is enough here, may plus HEAP
> flag when there is.
>
> I don't know what else would be need to do here.
> If you allocate a buffer from a heap which is delegated for security
> memory of that device, the heap driver itself would inform the TEE the
> pages occupied by it or the memory allocated from the pool which is in a
> region of memory reserved for this purpose.

So the heap is only for the video device?

> >
> >> But as I said in the first draft I am not sure about the DMA mapping p=
art. alloc_devs responds for the heap, we have a device variable in the que=
ue that mapping function could access, but that may not be enough. A plane =
may apply a different mapping policy or IOMMU here.
> >>
> >> Would it be better that I create a interface here that creating a memd=
ev with DMA-heap description ?
> >
> > My intuition still tells me that it would be universally better to
> > just let the userspace allocate the buffers independently (like with
> > gralloc/Ion) and import to V4L2 using V4L2_MEM_DMABUF. It was possible
> > to do things this way nicely with regular Android graphics buffers, so
> > could you explain what difference of your use case makes it
> > impossible?
> Without keeping the backward compatibility, it won't have any problem IF
> we could tell the users the acceptable DMA-heap for each of planes and
> DMA-heap's heap flags.
>
> We don't have an ioctl for this yet, the most possible for the decoder
> is doing that at GET_FMT ioctl()?.

Do we need the kernel to tell the userspace which heap to use? As you
mentioned above, the heap would be specific for the video device and
the userspace would also be specific for your use case, so why
couldn't it just find the right heap on its own (e.g. by name)?

As for heap flags, could you elaborate on what kind of flags you
imagine could be decided by a V4L2 driver?

Best regards,
Tomasz
