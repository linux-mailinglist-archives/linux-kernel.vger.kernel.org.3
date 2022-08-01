Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F012658670A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiHAJqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiHAJqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:46:14 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FB22B26D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:46:13 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id i4so8018179qvv.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 02:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VPFHdbaBa7EI6frsIzdNt1TytQNWZ647AsxmmEjKTPQ=;
        b=KBLk2hLPWZ2S1nksjkH8x/bB+Y29Jirw7u4KrBzQ9xMJhZoqD+jPkf9T92AYBVh2Kl
         dFSa3AyYu4pCFNOUgY+s83zy1H8wbJ8MO8sIk535NCVMAkYCBsDrWM2qnSQtx+/tip3d
         eV9qOEECz1l0UiiLdP816Ar7+v8mzBHMwrSq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VPFHdbaBa7EI6frsIzdNt1TytQNWZ647AsxmmEjKTPQ=;
        b=LL0dy6aXCqEl9GWV84x42QqASb9puSaUPcdpnKuFDksFXhhT8NwQuwNwnLA3vM1UcJ
         LlhsXLGs1UE6sjlWqnX3MQJZPi5FAYZnm584RNVYFFRlI+zdUbGpyoApAibXVbsItMA/
         PhEqCeFMbuqyhA3Y31xslrBv8CiMACfUnh/qp3Ya4V5Tsnt+hDsEjvIDiITvw5K+Ajg/
         7bXs7pwLOniaH4Ysz4XLooarEVr3OAPClXTe1guC76IanBGrwhIxo21okkTzdVPmAnaB
         w6mA1I4ijXLL6/NuljWhJvN1IJEHQCC4w073MDf/gS983vwAOaNUcuzXELvaU+deVXCJ
         zQBA==
X-Gm-Message-State: ACgBeo0Ya7nnMAp376fPsEyzVsHLi484+/RdFjTz1bsrb9UbLxkcgYag
        Qvk3t8S6LE+ivx+U27Fkp0xV1ESZKc1RBg==
X-Google-Smtp-Source: AA6agR5ZDvl8enSAPky5N2DLgSbMJqvQqTh/R/ruPOtvotjY+tp7KvImVFUpW6DQLFSqucIIkAZ7tg==
X-Received: by 2002:a0c:f1c7:0:b0:474:725e:753e with SMTP id u7-20020a0cf1c7000000b00474725e753emr13423663qvl.49.1659347171883;
        Mon, 01 Aug 2022 02:46:11 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id h3-20020ac81383000000b00304efba3d84sm6891824qtj.25.2022.08.01.02.46.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 02:46:10 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id c131so18045497ybf.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 02:46:10 -0700 (PDT)
X-Received: by 2002:a05:6902:1148:b0:677:dd8:5a06 with SMTP id
 p8-20020a056902114800b006770dd85a06mr3743396ybu.261.1659347170310; Mon, 01
 Aug 2022 02:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220731202116.820516-1-ayaka@soulik.info> <CAAFQd5C95W-2=oLTmbgQCBoYq1Ef3hKgpmk=ij4+nFPY3XVWPg@mail.gmail.com>
 <ec08ac1d-dc03-097e-dcb4-0ea0e86c612c@synaptics.com>
In-Reply-To: <ec08ac1d-dc03-097e-dcb4-0ea0e86c612c@synaptics.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 1 Aug 2022 18:45:59 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CKfv6F6cgN95SE42HWQYynsSuYFcU_8aePgtawXyey1g@mail.gmail.com>
Message-ID: <CAAFQd5CKfv6F6cgN95SE42HWQYynsSuYFcU_8aePgtawXyey1g@mail.gmail.com>
Subject: Re: [PATCH] [Draft]: media: videobuf2-dma-heap: add a vendor defined
 memory runtine
To:     Hsia-Jun Li <Randy.Li@synaptics.com>
Cc:     linux-media@vger.kernel.org, m.szyprowski@samsung.com,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, ayaka@soulik.info
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 3:44 PM Hsia-Jun Li <Randy.Li@synaptics.com> wrote:
>
>
>
> On 8/1/22 14:19, Tomasz Figa wrote:
> >
> Hello Tomasz
> >
> > ?Hi Randy,
> >
> > On Mon, Aug 1, 2022 at 5:21 AM <ayaka@soulik.info> wrote:
> >>
> >> From: Randy Li <ayaka@soulik.info>
> >>
> >> This module is still at a early stage, I wrote this for showing what
> >> APIs we need here.
> >>
> >> Let me explain why we need such a module here.
> >> If you won't allocate buffers from a V4L2 M2M device, this module
> >> may not be very useful. I am sure the most of users won't know a
> >> device would require them allocate buffers from a DMA-Heap then
> >> import those buffers into a V4L2's queue.
> >>
> >> Then the question goes back to why DMA-Heap. From the Android's
> >> description, we know it is about the copyright's DRM.
> >> When we allocate a buffer in a DMA-Heap, it may register that buffer
> >> in the trusted execution environment so the firmware which is running
> >> or could only be acccesed from there could use that buffer later.
> >>
> >> The answer above leads to another thing which is not done in this
> >> version, the DMA mapping. Although in some platforms, a DMA-Heap
> >> responses a IOMMU device as well. For the genernal purpose, we would
> >> be better assuming the device mapping should be done for each device
> >> itself. The problem here we only know alloc_devs in those DMAbuf
> >> methods, which are DMA-heaps in my design, the device from the queue
> >> is not enough, a plane may requests another IOMMU device or table
> >> for mapping.
> >>
> >> Signed-off-by: Randy Li <ayaka@soulik.info>
> >> ---
> >>   drivers/media/common/videobuf2/Kconfig        |   6 +
> >>   drivers/media/common/videobuf2/Makefile       |   1 +
> >>   .../common/videobuf2/videobuf2-dma-heap.c     | 350 ++++++++++++++++++
> >>   include/media/videobuf2-dma-heap.h            |  30 ++
> >>   4 files changed, 387 insertions(+)
> >>   create mode 100644 drivers/media/common/videobuf2/videobuf2-dma-heap.c
> >>   create mode 100644 include/media/videobuf2-dma-heap.h
> >>
> >
> > First of all, thanks for the series.
> >
> > Possibly a stupid question, but why not just allocate the DMA-bufs
> > directly from the DMA-buf heap device in the userspace and just import
> > the buffers to the V4L2 device using V4L2_MEMORY_DMABUF?
> Sometimes the allocation policy could be very complex, let's suppose a
> multiple planes pixel format enabling with frame buffer compression.
> Its luma, chroma data could be allocated from a pool which is delegated
> for large buffers while its metadata would come from a pool which many
> users could take some few slices from it(likes system pool).
>
> Then when we have a new users knowing nothing about this platform, if we
> just configure the alloc_devs in each queues well. The user won't need
> to know those complex rules.
>
> The real situation could be more complex, Samsung MFC's left and right
> banks could be regarded as two pools, many devices would benefit from
> this either from the allocation times or the security buffers policy.
>
> In our design, when we need to do some security decoding(DRM video),
> codecs2 would allocate buffers from the pool delegated for that. While
> the non-DRM video, users could not care about this.

I'm a little bit surprised about this, because on Android all the
graphics buffers are allocated from the system IAllocator and imported
to the specific devices.

Would it make sense to instead extend the UAPI to expose enough
information about the allocation requirements to the userspace, so it
can allocate correctly?
My reasoning here is that it's not a driver's decision to allocate
from a DMA-buf heap (and which one) or not. It's the userspace which
knows that, based on the specific use case that it wants to fulfill.

Also, FWIW, dma_heap_ioctl_allocate() is a static function not exposed
to other kernel modules:
https://elixir.bootlin.com/linux/v5.19/source/drivers/dma-buf/dma-heap.c#L52

By the way, the MFC left/right port requirement was gone long ago, it
was only one of the earliest Exynos SoCs which required that.

Best regards,
Tomasz

> >
> > Best regards,
> > Tomasz
> >
> >> diff --git a/drivers/media/common/videobuf2/Kconfig b/drivers/media/common/videobuf2/Kconfig
> >> index d2223a12c95f..02235077f07e 100644
> >> --- a/drivers/media/common/videobuf2/Kconfig
> >> +++ b/drivers/media/common/videobuf2/Kconfig
> >> @@ -30,3 +30,9 @@ config VIDEOBUF2_DMA_SG
> >>   config VIDEOBUF2_DVB
> >>          tristate
> >>          select VIDEOBUF2_CORE
> >> +
> >> +config VIDEOBUF2_DMA_HEAP
> >> +       tristate
> >> +       select VIDEOBUF2_CORE
> >> +       select VIDEOBUF2_MEMOPS
> >> +       select DMABUF_HEAPS
> >> diff --git a/drivers/media/common/videobuf2/Makefile b/drivers/media/common/videobuf2/Makefile
> >> index a6fe3f304685..7fe65f93117f 100644
> >> --- a/drivers/media/common/videobuf2/Makefile
> >> +++ b/drivers/media/common/videobuf2/Makefile
> >> @@ -10,6 +10,7 @@ endif
> >>   # (e. g. LC_ALL=C sort Makefile)
> >>   obj-$(CONFIG_VIDEOBUF2_CORE) += videobuf2-common.o
> >>   obj-$(CONFIG_VIDEOBUF2_DMA_CONTIG) += videobuf2-dma-contig.o
> >> +obj-$(CONFIG_VIDEOBUF2_DMA_HEAP) += videobuf2-dma-heap.o
> >>   obj-$(CONFIG_VIDEOBUF2_DMA_SG) += videobuf2-dma-sg.o
> >>   obj-$(CONFIG_VIDEOBUF2_DVB) += videobuf2-dvb.o
> >>   obj-$(CONFIG_VIDEOBUF2_MEMOPS) += videobuf2-memops.o
> >> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-heap.c b/drivers/media/common/videobuf2/videobuf2-dma-heap.c
> >> new file mode 100644
> >> index 000000000000..377b82ab8f5a
> >> --- /dev/null
> >> +++ b/drivers/media/common/videobuf2/videobuf2-dma-heap.c
> >> @@ -0,0 +1,350 @@
> >> +/*
> >> + * Copyright (C) 2022 Randy Li <ayaka@soulik.info>
> >> + *
> >> + * This software is licensed under the terms of the GNU General Public
> >> + * License version 2, as published by the Free Software Foundation, and
> >> + * may be copied, distributed, and modified under those terms.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> + * GNU General Public License for more details.
> >> + *
> >> + */
> >> +
> >> +#include <linux/dma-buf.h>
> >> +#include <linux/dma-heap.h>
> >> +#include <linux/refcount.h>
> >> +#include <linux/scatterlist.h>
> >> +#include <linux/sched.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/dma-mapping.h>
> >> +
> >> +#include <media/videobuf2-v4l2.h>
> >> +#include <media/videobuf2-memops.h>
> >> +#include <media/videobuf2-dma-heap.h>
> >> +
> >> +struct vb2_dmaheap_buf {
> >> +       struct device *dev;
> >> +       void *vaddr;
> >> +       unsigned long size;
> >> +       struct dma_buf *dmabuf;
> >> +       dma_addr_t dma_addr;
> >> +       unsigned long attrs;
> >> +       enum dma_data_direction dma_dir;
> >> +       struct sg_table *dma_sgt;
> >> +
> >> +       /* MMAP related */
> >> +       struct vb2_vmarea_handler handler;
> >> +       refcount_t refcount;
> >> +
> >> +       /* DMABUF related */
> >> +       struct dma_buf_attachment *db_attach;
> >> +};
> >> +
> >> +/*********************************************/
> >> +/*         callbacks for all buffers         */
> >> +/*********************************************/
> >> +
> >> +void *vb2_dmaheap_cookie(struct vb2_buffer *vb, void *buf_priv)
> >> +{
> >> +       struct vb2_dmaheap_buf *buf = buf_priv;
> >> +
> >> +       return &buf->dma_addr;
> >> +}
> >> +
> >> +static void *vb2_dmaheap_vaddr(struct vb2_buffer *vb, void *buf_priv)
> >> +{
> >> +       struct vb2_dmaheap_buf *buf = buf_priv;
> >> +       struct iosys_map map;
> >> +
> >> +       if (buf->vaddr)
> >> +           return buf->vaddr;
> >> +
> >> +       if (buf->db_attach) {
> >> +               if (!dma_buf_vmap(buf->db_attach->dmabuf, &map))
> >> +                       buf->vaddr = map.vaddr;
> >> +       }
> >> +
> >> +       return buf->vaddr;
> >> +}
> >> +
> >> +static unsigned int vb2_dmaheap_num_users(void *buf_priv)
> >> +{
> >> +       struct vb2_dmaheap_buf *buf = buf_priv;
> >> +
> >> +       return refcount_read(&buf->refcount);
> >> +}
> >> +
> >> +static void vb2_dmaheap_prepare(void *buf_priv)
> >> +{
> >> +       struct vb2_dmaheap_buf *buf = buf_priv;
> >> +
> >> +       /* TODO: DMABUF exporter will flush the cache for us */
> >> +       if (buf->db_attach)
> >> +               return;
> >> +
> >> +       dma_buf_end_cpu_access(buf->dmabuf, buf->dma_dir);
> >> +}
> >> +
> >> +static void vb2_dmaheap_finish(void *buf_priv)
> >> +{
> >> +       struct vb2_dmaheap_buf *buf = buf_priv;
> >> +
> >> +       /* TODO: DMABUF exporter will flush the cache for us */
> >> +       if (buf->db_attach)
> >> +               return;
> >> +
> >> +       dma_buf_begin_cpu_access(buf->dmabuf, buf->dma_dir);
> >> +}
> >> +
> >> +/*********************************************/
> >> +/*        callbacks for MMAP buffers         */
> >> +/*********************************************/
> >> +
> >> +void vb2_dmaheap_put(void *buf_priv)
> >> +{
> >> +       struct vb2_dmaheap_buf *buf = buf_priv;
> >> +
> >> +       if (!refcount_dec_and_test(&buf->refcount))
> >> +               return;
> >> +
> >> +       dma_buf_put(buf->dmabuf);
> >> +
> >> +       put_device(buf->dev);
> >> +       kfree(buf);
> >> +}
> >> +
> >> +static void *vb2_dmaheap_alloc(struct vb2_buffer *vb,
> >> +                              struct device *dev,
> >> +                              unsigned long size)
> >> +{
> >> +       struct vb2_queue *q = vb->vb2_queue;
> >> +       struct dma_heap *heap;
> >> +       struct vb2_dmaheap_buf *buf;
> >> +       const char *heap_name;
> >> +       int ret;
> >> +
> >> +       if (WARN_ON(!dev))
> >> +               return ERR_PTR(-EINVAL);
> >> +
> >> +       heap_name = dev_name(dev);
> >> +       if (!heap_name)
> >> +               return ERR_PTR(-EINVAL);
> >> +
> >> +       heap = dma_heap_find(heap_name);
> >> +       if (!heap) {
> >> +               dev_err(dev, "is not a DMA-heap device\n");
> >> +               return ERR_PTR(-EINVAL);
> >> +       }
> >> +
> >> +       buf = kzalloc(sizeof *buf, GFP_KERNEL);
> >> +       if (!buf)
> >> +               return ERR_PTR(-ENOMEM);
> >> +
> >> +       /* Prevent the device from being released while the buffer is used */
> >> +       buf->dev = get_device(dev);
> >> +       buf->attrs = vb->vb2_queue->dma_attrs;
> >> +       buf->dma_dir = vb->vb2_queue->dma_dir;
> >> +
> >> +       /* TODO: heap flags */
> >> +       ret = dma_heap_buffer_alloc(heap, size, 0, 0);
> >> +       if (ret < 0) {
> >> +               dev_err(dev, "is not a DMA-heap device\n");
> >> +               put_device(buf->dev);
> >> +               kfree(buf);
> >> +               return ERR_PTR(ret);
> >> +       }
> >> +       buf->dmabuf = dma_buf_get(ret);
> >> +
> >> +       /* FIXME */
> >> +       buf->dma_addr = 0;
> >> +
> >> +       if ((q->dma_attrs & DMA_ATTR_NO_KERNEL_MAPPING) == 0)
> >> +               buf->vaddr = buf->dmabuf;
> >> +
> >> +       buf->handler.refcount = &buf->refcount;
> >> +       buf->handler.put = vb2_dmaheap_put;
> >> +       buf->handler.arg = buf;
> >> +
> >> +       refcount_set(&buf->refcount, 1);
> >> +
> >> +       return buf;
> >> +}
> >> +
> >> +static int vb2_dmaheap_mmap(void *buf_priv, struct vm_area_struct *vma)
> >> +{
> >> +       struct vb2_dmaheap_buf *buf = buf_priv;
> >> +       int ret;
> >> +
> >> +       if (!buf) {
> >> +               printk(KERN_ERR "No buffer to map\n");
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       vma->vm_flags &= ~VM_PFNMAP;
> >> +
> >> +       ret = dma_buf_mmap(buf->dmabuf, vma, 0);
> >> +       if (ret) {
> >> +               pr_err("Remapping memory failed, error: %d\n", ret);
> >> +               return ret;
> >> +       }
> >> +       vma->vm_flags           |= VM_DONTEXPAND | VM_DONTDUMP;
> >> +       vma->vm_private_data    = &buf->handler;
> >> +       vma->vm_ops             = &vb2_common_vm_ops;
> >> +
> >> +       vma->vm_ops->open(vma);
> >> +
> >> +       pr_debug("%s: mapped memid 0x%08lx at 0x%08lx, size %ld\n",
> >> +                __func__, (unsigned long)buf->dma_addr, vma->vm_start,
> >> +                buf->size);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +/*********************************************/
> >> +/*         DMABUF ops for exporters          */
> >> +/*********************************************/
> >> +
> >> +static struct dma_buf *vb2_dmaheap_get_dmabuf(struct vb2_buffer *vb,
> >> +                                             void *buf_priv,
> >> +                                             unsigned long flags)
> >> +{
> >> +       struct vb2_dmaheap_buf *buf = buf_priv;
> >> +       struct dma_buf *dbuf;
> >> +
> >> +       dbuf = buf->dmabuf;
> >> +
> >> +       return dbuf;
> >> +}
> >> +
> >> +/*********************************************/
> >> +/*       callbacks for DMABUF buffers        */
> >> +/*********************************************/
> >> +
> >> +static int vb2_dmaheap_map_dmabuf(void *mem_priv)
> >> +{
> >> +       struct vb2_dmaheap_buf *buf = mem_priv;
> >> +       struct sg_table *sgt;
> >> +
> >> +       if (WARN_ON(!buf->db_attach)) {
> >> +               pr_err("trying to pin a non attached buffer\n");
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       if (WARN_ON(buf->dma_sgt)) {
> >> +               pr_err("dmabuf buffer is already pinned\n");
> >> +               return 0;
> >> +       }
> >> +
> >> +       /* get the associated scatterlist for this buffer */
> >> +       sgt = dma_buf_map_attachment(buf->db_attach, buf->dma_dir);
> >> +       if (IS_ERR(sgt)) {
> >> +               pr_err("Error getting dmabuf scatterlist\n");
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       buf->dma_addr = sg_dma_address(sgt->sgl);
> >> +       buf->dma_sgt = sgt;
> >> +       buf->vaddr = NULL;
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static void vb2_dmaheap_unmap_dmabuf(void *mem_priv)
> >> +{
> >> +       struct vb2_dmaheap_buf *buf = mem_priv;
> >> +       struct sg_table *sgt = buf->dma_sgt;
> >> +       struct iosys_map map = IOSYS_MAP_INIT_VADDR(buf->vaddr);
> >> +
> >> +       if (WARN_ON(!buf->db_attach)) {
> >> +               pr_err("trying to unpin a not attached buffer\n");
> >> +               return;
> >> +       }
> >> +
> >> +       if (WARN_ON(!sgt)) {
> >> +               pr_err("dmabuf buffer is already unpinned\n");
> >> +               return;
> >> +       }
> >> +
> >> +       if (buf->vaddr) {
> >> +               dma_buf_vunmap(buf->db_attach->dmabuf, &map);
> >> +               buf->vaddr = NULL;
> >> +       }
> >> +       dma_buf_unmap_attachment(buf->db_attach, sgt, buf->dma_dir);
> >> +
> >> +       buf->dma_addr = 0;
> >> +       buf->dma_sgt = NULL;
> >> +}
> >> +
> >> +static void vb2_dmaheap_detach_dmabuf(void *mem_priv)
> >> +{
> >> +       struct vb2_dmaheap_buf *buf = mem_priv;
> >> +
> >> +       /* if vb2 works correctly you should never detach mapped buffer */
> >> +       if (WARN_ON(buf->dma_addr))
> >> +               vb2_dmaheap_unmap_dmabuf(buf);
> >> +
> >> +       /* detach this attachment */
> >> +       dma_buf_detach(buf->db_attach->dmabuf, buf->db_attach);
> >> +       kfree(buf);
> >> +}
> >> +
> >> +static void *vb2_dmaheap_attach_dmabuf(struct vb2_buffer *vb, struct device *dev,
> >> +                                      struct dma_buf *dbuf, unsigned long size)
> >> +{
> >> +       struct vb2_dmaheap_buf *buf;
> >> +       struct dma_buf_attachment *dba;
> >> +
> >> +       if (dbuf->size < size)
> >> +               return ERR_PTR(-EFAULT);
> >> +
> >> +       if (WARN_ON(!dev))
> >> +               return ERR_PTR(-EINVAL);
> >> +       /*
> >> +        * TODO: A better way to check whether the buffer is coming
> >> +        * from this heap or this heap could accept this buffer
> >> +        */
> >> +       if (strcmp(dbuf->exp_name, dev_name(dev)))
> >> +               return ERR_PTR(-EINVAL);
> >> +
> >> +       buf = kzalloc(sizeof(*buf), GFP_KERNEL);
> >> +       if (!buf)
> >> +               return ERR_PTR(-ENOMEM);
> >> +
> >> +       buf->dev = dev;
> >> +       /* create attachment for the dmabuf with the user device */
> >> +       dba = dma_buf_attach(dbuf, buf->dev);
> >> +       if (IS_ERR(dba)) {
> >> +               pr_err("failed to attach dmabuf\n");
> >> +               kfree(buf);
> >> +               return dba;
> >> +       }
> >> +
> >> +       buf->dma_dir = vb->vb2_queue->dma_dir;
> >> +       buf->size = size;
> >> +       buf->db_attach = dba;
> >> +
> >> +       return buf;
> >> +}
> >> +
> >> +const struct vb2_mem_ops vb2_dmaheap_memops = {
> >> +       .alloc = vb2_dmaheap_alloc,
> >> +       .put = vb2_dmaheap_put,
> >> +       .get_dmabuf = vb2_dmaheap_get_dmabuf,
> >> +       .cookie = vb2_dmaheap_cookie,
> >> +       .vaddr = vb2_dmaheap_vaddr,
> >> +       .prepare = vb2_dmaheap_prepare,
> >> +       .finish = vb2_dmaheap_finish,
> >> +       .map_dmabuf = vb2_dmaheap_map_dmabuf,
> >> +       .unmap_dmabuf = vb2_dmaheap_unmap_dmabuf,
> >> +       .attach_dmabuf = vb2_dmaheap_attach_dmabuf,
> >> +       .detach_dmabuf = vb2_dmaheap_detach_dmabuf,
> >> +       .num_users = vb2_dmaheap_num_users,
> >> +       .mmap = vb2_dmaheap_mmap,
> >> +};
> >> +
> >> +MODULE_DESCRIPTION("DMA-Heap memory handling routines for videobuf2");
> >> +MODULE_AUTHOR("Randy Li <ayaka@soulik.info>");
> >> +MODULE_LICENSE("GPL");
> >> +MODULE_IMPORT_NS(DMA_BUF);
> >> diff --git a/include/media/videobuf2-dma-heap.h b/include/media/videobuf2-dma-heap.h
> >> new file mode 100644
> >> index 000000000000..fa057f67d6e9
> >> --- /dev/null
> >> +++ b/include/media/videobuf2-dma-heap.h
> >> @@ -0,0 +1,30 @@
> >> +/*
> >> + * Copyright (C) 2022 Randy Li <ayaka@soulik.info>
> >> + *
> >> + * This software is licensed under the terms of the GNU General Public
> >> + * License version 2, as published by the Free Software Foundation, and
> >> + * may be copied, distributed, and modified under those terms.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> + * GNU General Public License for more details.
> >> + *
> >> + */
> >> +
> >> +#ifndef _MEDIA_VIDEOBUF2_DMA_HEAP_H
> >> +#define _MEDIA_VIDEOBUF2_DMA_HEAP_H
> >> +
> >> +#include <media/videobuf2-v4l2.h>
> >> +#include <linux/dma-mapping.h>
> >> +
> >> +static inline dma_addr_t
> >> +vb2_dmaheap_plane_dma_addr(struct vb2_buffer *vb, unsigned int plane_no)
> >> +{
> >> +       dma_addr_t *addr = vb2_plane_cookie(vb, plane_no);
> >> +
> >> +       return *addr;
> >> +}
> >> +
> >> +extern const struct vb2_mem_ops vb2_dmaheap_memops;
> >> +#endif
> >> --
> >> 2.17.1
> >>
>
> --
> Hsia-Jun(Randy) Li
