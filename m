Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC005587C4F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbiHBMVh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 Aug 2022 08:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236905AbiHBMVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:21:34 -0400
Received: from kozue.soulik.info (kozue.soulik.info [IPv6:2001:19f0:7000:8404:5054:ff:fe75:428f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD094F1BE;
        Tue,  2 Aug 2022 05:21:33 -0700 (PDT)
Received: from [192.168.10.77] (unknown [140.207.23.88])
        by kozue.soulik.info (Postfix) with ESMTPSA id 18E6D100DB3;
        Tue,  2 Aug 2022 21:15:17 +0900 (JST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] [Draft]: media: videobuf2-dma-heap: add a vendor defined memory runtine
From:   ayaka <ayaka@soulik.info>
In-Reply-To: <CAAFQd5AL=OejdaubnYDRF4M1EKyStZP_FAMPz4CJ=KCa_8QjaA@mail.gmail.com>
Cc:     Hsia-Jun Li <randy.li@synaptics.com>, linux-media@vger.kernel.org,
        m.szyprowski@samsung.com, sumit.semwal@linaro.org,
        christian.koenig@amd.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Date:   Tue, 2 Aug 2022 20:21:22 +0800
Message-Id: <CF192A87-1664-45B2-B26C-A9B8B6A52523@soulik.info>
References: <CAAFQd5AL=OejdaubnYDRF4M1EKyStZP_FAMPz4CJ=KCa_8QjaA@mail.gmail.com>
To:     Tomasz Figa <tfiga@chromium.org>
X-Mailer: iPad Mail (18D61)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MIME_QP_LONG_LINE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, the previous one contains html data.

> On Aug 2, 2022, at 3:33 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> 
> ﻿On Mon, Aug 1, 2022 at 8:43 PM ayaka <ayaka@soulik.info> wrote:
>> Sent from my iPad
>>>> On Aug 1, 2022, at 5:46 PM, Tomasz Figa <tfiga@chromium.org> wrote:
>>> ﻿CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>> On Mon, Aug 1, 2022 at 3:44 PM Hsia-Jun Li <Randy.Li@synaptics.com> wrote:
>>>>> On 8/1/22 14:19, Tomasz Figa wrote:
>>>> Hello Tomasz
>>>>> ?Hi Randy,
>>>>> On Mon, Aug 1, 2022 at 5:21 AM <ayaka@soulik.info> wrote:
>>>>>> From: Randy Li <ayaka@soulik.info>
>>>>>> This module is still at a early stage, I wrote this for showing what
>>>>>> APIs we need here.
>>>>>> Let me explain why we need such a module here.
>>>>>> If you won't allocate buffers from a V4L2 M2M device, this module
>>>>>> may not be very useful. I am sure the most of users won't know a
>>>>>> device would require them allocate buffers from a DMA-Heap then
>>>>>> import those buffers into a V4L2's queue.
>>>>>> Then the question goes back to why DMA-Heap. From the Android's
>>>>>> description, we know it is about the copyright's DRM.
>>>>>> When we allocate a buffer in a DMA-Heap, it may register that buffer
>>>>>> in the trusted execution environment so the firmware which is running
>>>>>> or could only be acccesed from there could use that buffer later.
>>>>>> The answer above leads to another thing which is not done in this
>>>>>> version, the DMA mapping. Although in some platforms, a DMA-Heap
>>>>>> responses a IOMMU device as well. For the genernal purpose, we would
>>>>>> be better assuming the device mapping should be done for each device
>>>>>> itself. The problem here we only know alloc_devs in those DMAbuf
>>>>>> methods, which are DMA-heaps in my design, the device from the queue
>>>>>> is not enough, a plane may requests another IOMMU device or table
>>>>>> for mapping.
>>>>>> Signed-off-by: Randy Li <ayaka@soulik.info>
>>>>>> ---
>>>>>> drivers/media/common/videobuf2/Kconfig        |   6 +
>>>>>> drivers/media/common/videobuf2/Makefile       |   1 +
>>>>>> .../common/videobuf2/videobuf2-dma-heap.c     | 350 ++++++++++++++++++
>>>>>> include/media/videobuf2-dma-heap.h            |  30 ++
>>>>>> 4 files changed, 387 insertions(+)
>>>>>> create mode 100644 drivers/media/common/videobuf2/videobuf2-dma-heap.c
>>>>>> create mode 100644 include/media/videobuf2-dma-heap.h
>>>>> First of all, thanks for the series.
>>>>> Possibly a stupid question, but why not just allocate the DMA-bufs
>>>>> directly from the DMA-buf heap device in the userspace and just import
>>>>> the buffers to the V4L2 device using V4L2_MEMORY_DMABUF?
>>>> Sometimes the allocation policy could be very complex, let's suppose a
>>>> multiple planes pixel format enabling with frame buffer compression.
>>>> Its luma, chroma data could be allocated from a pool which is delegated
>>>> for large buffers while its metadata would come from a pool which many
>>>> users could take some few slices from it(likes system pool).
>>>> Then when we have a new users knowing nothing about this platform, if we
>>>> just configure the alloc_devs in each queues well. The user won't need
>>>> to know those complex rules.
>>>> The real situation could be more complex, Samsung MFC's left and right
>>>> banks could be regarded as two pools, many devices would benefit from
>>>> this either from the allocation times or the security buffers policy.
>>>> In our design, when we need to do some security decoding(DRM video),
>>>> codecs2 would allocate buffers from the pool delegated for that. While
>>>> the non-DRM video, users could not care about this.
>>> I'm a little bit surprised about this, because on Android all the
>>> graphics buffers are allocated from the system IAllocator and imported
>>> to the specific devices.
>> In the non-tunnel mode, yes it is. While the tunnel mode is completely vendor defined. Neither HWC nor codec2 cares about where the buffers coming from, you could do what ever you want.
>> Besides there are DRM video in GNU Linux platform, I heard the webkit has made huge effort here and Playready is one could work in non-Android Linux.
>>> Would it make sense to instead extend the UAPI to expose enough
>>> information about the allocation requirements to the userspace, so it
>>> can allocate correctly?
>> Yes, it could. But as I said it would need the users to do more works.
>>> My reasoning here is that it's not a driver's decision to allocate
>>> from a DMA-buf heap (and which one) or not. It's the userspace which
>>> knows that, based on the specific use case that it wants to fulfill.
>> Although I would like to let the users decide that, users just can’t do that which would violate the security rules in some platforms.
>> For example,  video codec and display device could only access a region of memory, any other device or trusted apps can’t access it. Users have to allocate the buffer from the pool the vendor decided.
>> So why not we offer a quick way that users don’t need to try and error.
> 
> In principle, I'm not against integrating DMA-buf heap with vb2,
> however I see some problems I mentioned before:
> 
> 1) How would the driver know if it should allocate from a DMA-buf heap or not?

struct vb2_queue.mem_ops

int (*queue_setup)(struct vb2_queue *q,unsigned int *num_buffers, unsigned int *num_planes, unsigned int sizes[], struct device *alloc_devs[]);

> 2) How would the driver know which heap to allocate from?

From vb2_queue.alloc_devs

What I did now is likes what MFC does, create some mem_alloc_devs.
It would be better that we could retrieve the DMA-heaps’ devices from kernel, but that is not enough, we need a place to store the heap flags although none of them are defined yet.

From Android documents, I think it is unlikely we would have heap flags.
“Standardization: The DMA-BUF heaps framework offers a well-defined UAPI. ION allowed custom flags and heap IDs that prevented developing a common testing framework because each device’s ION implementation could behave differently.”

> 3) How would the heap know how to allocate properly for the device?
> 
Because “each DMA-BUF heap is a separate character device”.
But as I said in the first draft I am not sure about the DMA mapping part. alloc_devs responds for the heap, we have a device variable in the queue that mapping function could access, but that may not be enough. A plane may apply a different mapping policy or IOMMU here.

Would it be better that I create a interface here that creating a memdev with DMA-heap description ? 

> Best regards,
> Tomasz

