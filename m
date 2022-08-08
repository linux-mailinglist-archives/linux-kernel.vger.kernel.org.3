Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8E358C8F2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242978AbiHHNED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237483AbiHHNEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:04:00 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5935F49;
        Mon,  8 Aug 2022 06:03:58 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id i84so7009001ioa.6;
        Mon, 08 Aug 2022 06:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ZvT8zFSaN4+LwwHuSYqMb23PG3MGFvgeXxhuTYLZpLA=;
        b=bIV76remtNAYQAeCdeb3qJ3+b164qBdDrAh+RltF+dOCvtut76rYCFEeN05QWNkUuV
         AoVR5s8C364z0ybC7ibjDVnQDDa4asxYupQ5SMfZiDM9z7fodmeKYug3z8bzjsmQ+3Q0
         qoVud6QDZ7mOFNA9ESM5uAe9aFWlBDDNZvrbWyYB/qpn8LHm+33J2ADJwdmpnZZq2SW2
         BGrRUXM5imEq8M5Kiman/R0HF9ju5F9Y9WoiHfQxom2ElQLBXRg6lBPQBHG3rly+3UYV
         YSHbTbM5eTZT5Yhyfldvmq7YR1Hldk21TeWy52szjq0pmCwdvTf7O4OogCI1Lni7YdY3
         dP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZvT8zFSaN4+LwwHuSYqMb23PG3MGFvgeXxhuTYLZpLA=;
        b=KKJEHmBg9crAMoF/IrRz7ST2T/45ccICfFkp64TkV++7ca44q7mAoxA2z2ktEiW/67
         b7KEBWHCF2cKc3NUuLj42d0g5msPrLmSPI+xJ/DA3AUpKk1+UXPcjZj5AsH45FriyMqk
         08xq1zToElnsuP8C54DOzfr7uukePgURbcopaWXa990oBg5cIoCYX3pJEa3Z/tYuDyFO
         vsiT9OksQlVioNzpJtGinlESTs058G4NHRfrzeBbUbCjPWFOZYgeuom/WZKqqjx1mDCh
         24una+xlkqYnyCZ4vaJfFgpFNjwXPQcl/ObdCtCxEI+aOeaJmPhM229N+tIsvAtz4/gU
         t0rw==
X-Gm-Message-State: ACgBeo055YTEggnR+GRaPZLYxuEVw+nuZj6lCkXsmlTw3llO0Thpdgv6
        bbmvk5C6FKN6cKLWih8wjG2cSWYd+lB8ZpeZyw8=
X-Google-Smtp-Source: AA6agR60DUrBizeFAOIl0MFBBFVK7rm5XRv8HCDKfsPieaM8O+nIy31LtUASY2Py2R3HzanJm6GnC6zPInf13BA0Rpo=
X-Received: by 2002:a05:6638:f8f:b0:342:cb21:f6d6 with SMTP id
 h15-20020a0566380f8f00b00342cb21f6d6mr5560379jal.138.1659963837491; Mon, 08
 Aug 2022 06:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220729170744.1301044-1-robdclark@gmail.com> <20220729170744.1301044-2-robdclark@gmail.com>
 <62afe47a-1a50-80ef-400d-8c238f1cb332@quicinc.com>
In-Reply-To: <62afe47a-1a50-80ef-400d-8c238f1cb332@quicinc.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 8 Aug 2022 06:04:19 -0700
Message-ID: <CAF6AEGuRnnjXN-sFeBkgF+ZiHQsABUEXBRLTO+jibHFk7RumSg@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH 1/3] dma-buf: Add ioctl to query mmap info
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
        open list <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>, freedreno@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 7, 2022 at 1:25 PM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>
> On 7/29/2022 10:37 PM, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > This is a fairly narrowly focused interface, providing a way for a VMM
> > in userspace to tell the guest kernel what pgprot settings to use when
> > mapping a buffer to guest userspace.
> >
> > For buffers that get mapped into guest userspace, virglrenderer returns
> > a dma-buf fd to the VMM (crosvm or qemu).  In addition to mapping the
> > pages into the guest VM, it needs to report to drm/virtio in the guest
> > the cache settings to use for guest userspace.  In particular, on some
> > architectures, creating aliased mappings with different cache attributes
> > is frowned upon, so it is important that the guest mappings have the
> > same cache attributes as any potential host mappings.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   drivers/dma-buf/dma-buf.c    | 26 ++++++++++++++++++++++++++
> >   include/linux/dma-buf.h      |  7 +++++++
> >   include/uapi/linux/dma-buf.h | 28 ++++++++++++++++++++++++++++
> >   3 files changed, 61 insertions(+)
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index 32f55640890c..d02d6c2a3b49 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -326,6 +326,29 @@ static long dma_buf_set_name(struct dma_buf *dmabuf, const char __user *buf)
> >       return 0;
> >   }
> >
> > +static long dma_buf_info(struct dma_buf *dmabuf, const void __user *uarg)
> > +{
> > +     struct dma_buf_info arg;
> > +
> > +     if (copy_from_user(&arg, uarg, sizeof(arg)))
> > +             return -EFAULT;
> > +
> > +     switch (arg.param) {
> > +     case DMA_BUF_INFO_VM_PROT:
> > +             if (!dmabuf->ops->mmap_info)
> > +                     return -ENOSYS;
> > +             arg.value = dmabuf->ops->mmap_info(dmabuf);
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (copy_to_user(uarg, &arg, sizeof(arg)))
> > +             return -EFAULT;
> > +
> > +     return 0;
> > +}
> > +
> >   static long dma_buf_ioctl(struct file *file,
> >                         unsigned int cmd, unsigned long arg)
> >   {
> > @@ -369,6 +392,9 @@ static long dma_buf_ioctl(struct file *file,
> >       case DMA_BUF_SET_NAME_B:
> >               return dma_buf_set_name(dmabuf, (const char __user *)arg);
> >
> > +     case DMA_BUF_IOCTL_INFO:
> > +             return dma_buf_info(dmabuf, (const void __user *)arg);
> > +
> >       default:
> >               return -ENOTTY;
> >       }
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index 71731796c8c3..6f4de64a5937 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -283,6 +283,13 @@ struct dma_buf_ops {
> >        */
> >       int (*mmap)(struct dma_buf *, struct vm_area_struct *vma);
> >
> > +     /**
> > +      * @mmap_info:
> > +      *
> > +      * Return mmapping info for the buffer.  See DMA_BUF_INFO_VM_PROT.
> > +      */
> > +     int (*mmap_info)(struct dma_buf *);
> > +
> >       int (*vmap)(struct dma_buf *dmabuf, struct iosys_map *map);
> >       void (*vunmap)(struct dma_buf *dmabuf, struct iosys_map *map);
> >   };
> > diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-buf.h
> > index b1523cb8ab30..a41adac0f46a 100644
> > --- a/include/uapi/linux/dma-buf.h
> > +++ b/include/uapi/linux/dma-buf.h
> > @@ -85,6 +85,32 @@ struct dma_buf_sync {
> >
> >   #define DMA_BUF_NAME_LEN    32
> >
> > +
> > +/**
> > + * struct dma_buf_info - Query info about the buffer.
> > + */
> > +struct dma_buf_info {
> > +
> > +#define DMA_BUF_INFO_VM_PROT      1
> > +#  define DMA_BUF_VM_PROT_WC      0
> > +#  define DMA_BUF_VM_PROT_CACHED  1
> > +
> > +     /**
> > +      * @param: Which param to query
> > +      *
> > +      * DMA_BUF_INFO_BM_PROT:
> Is there a typo here? BM -> VM ?

yes, fixed locally

>
> -Akhil.
> > +      *     Query the access permissions of userspace mmap's of this buffer.
> > +      *     Returns one of DMA_BUF_VM_PROT_x
> > +      */
> > +     __u32 param;
> > +     __u32 pad;
> > +
> > +     /**
> > +      * @value: Return value of the query.
> > +      */
> > +     __u64 value;
> > +};
> > +
> >   #define DMA_BUF_BASE                'b'
> >   #define DMA_BUF_IOCTL_SYNC  _IOW(DMA_BUF_BASE, 0, struct dma_buf_sync)
> >
> > @@ -95,4 +121,6 @@ struct dma_buf_sync {
> >   #define DMA_BUF_SET_NAME_A  _IOW(DMA_BUF_BASE, 1, __u32)
> >   #define DMA_BUF_SET_NAME_B  _IOW(DMA_BUF_BASE, 1, __u64)
> >
> > +#define DMA_BUF_IOCTL_INFO   _IOWR(DMA_BUF_BASE, 2, struct dma_buf_info)
> > +
> >   #endif
>
