Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE645B0A6F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiIGQnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIGQnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:43:45 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B5575494
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:43:27 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b16so20609443edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 09:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date;
        bh=4lnCAj428Vv6Ow8aTwYtx1wIsk7OtewWVjF5ctv1La0=;
        b=i1pUefneAuDdK10thmvEh++bNXQBXaeZdOPvwnKxR6rW3lvocDO/4npjmxwGu6hcYa
         EY4WFnAFy58Y4+umzLDkSY+NDqew3fLhvCqEqxQMggKK1666Jw7BNmgPKeCjuS5GErLz
         WbUnA0M+qyBTNBSP6YI4hWf8TGA3W3EiA9zH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4lnCAj428Vv6Ow8aTwYtx1wIsk7OtewWVjF5ctv1La0=;
        b=IHp7CmKMBZgOb3hx891Rly0vahbuzVVbPtpwaHFcL58juT2dA1zEGHsd+agAmll8Qs
         oUj0xdhiMhjFmTiCyLQeHenFkfQnteylFx3C9T4cv7JNtiNtZqHwXo8HvabdjhHUveI1
         sQlCVpNvJjWHEKHt+wdPAD45WAZHm9VnEiz4UaIJ8cWdayy/MqvSr9KiTsxw14y7HbGG
         KahTkS/FmJdElsYb/ylB6xS43ovL26fTebi6e1qfuhwN/Hn0zoHJ7gZad6yQA4I+XIxp
         8SS2BJcJBNpelZ9Mvf0e9eQxOE2pqReIyuiBf5ytOODzZOTuP5CD9EeQeNKrY/AYsuYL
         Ye/Q==
X-Gm-Message-State: ACgBeo03dWYS1/FiBFSXxAmcCoYad2hWr9CZ7PD1RBXnwL7haJmZBk+c
        JrrmZxVbHKOv/wTdFhMS/jTIaA==
X-Google-Smtp-Source: AA6agR5w7xM9hdW5+VIFIyHyOetSYQPltP4O5aXP/AII3zzYVf2d/XLVm4ctVC2ZpxeQqHpFqJ3/nA==
X-Received: by 2002:aa7:d392:0:b0:44e:67f2:c79c with SMTP id x18-20020aa7d392000000b0044e67f2c79cmr3739423edq.278.1662568993448;
        Wed, 07 Sep 2022 09:43:13 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id f2-20020a05640214c200b0044eb4227bf6sm4949576edx.63.2022.09.07.09.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 09:43:12 -0700 (PDT)
Date:   Wed, 7 Sep 2022 18:43:10 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] dma-buf: Add ioctl to query mmap coherency/cache
 info
Message-ID: <YxjKHg8wBYCkQskJ@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220815211516.3169470-1-robdclark@gmail.com>
 <20220815211516.3169470-2-robdclark@gmail.com>
 <327c77d5-5812-a158-6c9f-c68e15a5a6b4@amd.com>
 <CAF6AEGu3oxM+EX_FsLpw4m0KouMyFMLN=AGGbf=6TVQGkJ7jQg@mail.gmail.com>
 <6396ccf9-a677-427d-f5f9-12d30ad2197e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6396ccf9-a677-427d-f5f9-12d30ad2197e@amd.com>
X-Operating-System: Linux phenom 5.18.0-4-amd64 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 06:50:54PM +0200, Christian König wrote:
> Am 16.08.22 um 16:26 schrieb Rob Clark:
> > On Tue, Aug 16, 2022 at 1:27 AM Christian König
> > <christian.koenig@amd.com> wrote:
> > > Am 15.08.22 um 23:15 schrieb Rob Clark:
> > > > From: Rob Clark <robdclark@chromium.org>
> > > > 
> > > > This is a fairly narrowly focused interface, providing a way for a VMM
> > > > in userspace to tell the guest kernel what pgprot settings to use when
> > > > mapping a buffer to guest userspace.
> > > > 
> > > > For buffers that get mapped into guest userspace, virglrenderer returns
> > > > a dma-buf fd to the VMM (crosvm or qemu).  In addition to mapping the
> > > > pages into the guest VM, it needs to report to drm/virtio in the guest
> > > > the cache settings to use for guest userspace.  In particular, on some
> > > > architectures, creating aliased mappings with different cache attributes
> > > > is frowned upon, so it is important that the guest mappings have the
> > > > same cache attributes as any potential host mappings.
> > > > 
> > > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > > ---
> > > > v2: Combine with coherency, as that is a related concept.. and it is
> > > >       relevant to the VMM whether coherent access without the SYNC ioctl
> > > >       is possible; set map_info at export time to make it more clear
> > > >       that it applies for the lifetime of the dma-buf (for any mmap
> > > >       created via the dma-buf)
> > > Well, exactly that's a conceptual NAK from my side.
> > > 
> > > The caching information can change at any time. For CPU mappings even
> > > without further notice from the exporter.
> > You should look before you criticize, as I left you a way out.. the
> > idea was that DMA_BUF_MAP_INCOHERENT should indicate that the buffer
> > cannot be mapped to the guest.  We could ofc add more DMA_BUF_MAP_*
> > values if something else would suit you better.  But the goal is to
> > give the VMM enough information to dtrt, or return an error if mapping
> > to guest is not possible.  That seems better than assuming mapping to
> > guest will work and guessing about cache attrs
> 
> Well I'm not rejecting the implementation, I'm rejecting this from the
> conceptual point of view.
> 
> We intentional gave the exporter full control over the CPU mappings. This
> approach here breaks that now.
> 
> I haven't seen the full detailed reason why we should do that and to be
> honest KVM seems to mess with things it is not supposed to touch.
> 
> For example the page reference count of mappings marked with VM_IO is a
> complete no-go. This is a very strong evidence that this was based on rather
> dangerous halve knowledge about the background of the handling here.

Wut?

KVM grabs page references of VM_IO vma? I thought the issue was that we
still had some bo/dma-buf vma that didn't set either VM_IO or VM_PFNMAP,
and not that kvm was just outright breaking every core mm contract there
is.

Is this really what's going on in that other thread about "fixing" ttm?
-Daniel

> So as long as I don't see a full explanation why KVM is grabbing reference
> to pages while faulting them and why we manually need to forward the caching
> while the hardware documentation indicates otherwise I will be rejecting
> this whole approach.
> 
> Regards,
> Christian.
> 
> > 
> > BR,
> > -R
> > 
> > > If the hardware can't use the caching information from the host CPU page
> > > tables directly then that pretty much completely breaks the concept that
> > > the exporter is responsible for setting up those page tables.
> > > 
> > > Regards,
> > > Christian.
> > > 
> > > >    drivers/dma-buf/dma-buf.c    | 63 +++++++++++++++++++++++++++------
> > > >    include/linux/dma-buf.h      | 11 ++++++
> > > >    include/uapi/linux/dma-buf.h | 68 ++++++++++++++++++++++++++++++++++++
> > > >    3 files changed, 132 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > > > index 32f55640890c..262c4706f721 100644
> > > > --- a/drivers/dma-buf/dma-buf.c
> > > > +++ b/drivers/dma-buf/dma-buf.c
> > > > @@ -125,6 +125,32 @@ static struct file_system_type dma_buf_fs_type = {
> > > >        .kill_sb = kill_anon_super,
> > > >    };
> > > > 
> > > > +static int __dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
> > > > +{
> > > > +     int ret;
> > > > +
> > > > +     /* check if buffer supports mmap */
> > > > +     if (!dmabuf->ops->mmap)
> > > > +             return -EINVAL;
> > > > +
> > > > +     ret = dmabuf->ops->mmap(dmabuf, vma);
> > > > +
> > > > +     /*
> > > > +      * If the exporter claims to support coherent access, ensure the
> > > > +      * pgprot flags match the claim.
> > > > +      */
> > > > +     if ((dmabuf->map_info != DMA_BUF_MAP_INCOHERENT) && !ret) {
> > > > +             pgprot_t wc_prot = pgprot_writecombine(vma->vm_page_prot);
> > > > +             if (dmabuf->map_info == DMA_BUF_COHERENT_WC) {
> > > > +                     WARN_ON_ONCE(pgprot_val(vma->vm_page_prot) != pgprot_val(wc_prot));
> > > > +             } else {
> > > > +                     WARN_ON_ONCE(pgprot_val(vma->vm_page_prot) == pgprot_val(wc_prot));
> > > > +             }
> > > > +     }
> > > > +
> > > > +     return ret;
> > > > +}
> > > > +
> > > >    static int dma_buf_mmap_internal(struct file *file, struct vm_area_struct *vma)
> > > >    {
> > > >        struct dma_buf *dmabuf;
> > > > @@ -134,16 +160,12 @@ static int dma_buf_mmap_internal(struct file *file, struct vm_area_struct *vma)
> > > > 
> > > >        dmabuf = file->private_data;
> > > > 
> > > > -     /* check if buffer supports mmap */
> > > > -     if (!dmabuf->ops->mmap)
> > > > -             return -EINVAL;
> > > > -
> > > >        /* check for overflowing the buffer's size */
> > > >        if (vma->vm_pgoff + vma_pages(vma) >
> > > >            dmabuf->size >> PAGE_SHIFT)
> > > >                return -EINVAL;
> > > > 
> > > > -     return dmabuf->ops->mmap(dmabuf, vma);
> > > > +     return __dma_buf_mmap(dmabuf, vma);
> > > >    }
> > > > 
> > > >    static loff_t dma_buf_llseek(struct file *file, loff_t offset, int whence)
> > > > @@ -326,6 +348,27 @@ static long dma_buf_set_name(struct dma_buf *dmabuf, const char __user *buf)
> > > >        return 0;
> > > >    }
> > > > 
> > > > +static long dma_buf_info(struct dma_buf *dmabuf, void __user *uarg)
> > > > +{
> > > > +     struct dma_buf_info arg;
> > > > +
> > > > +     if (copy_from_user(&arg, uarg, sizeof(arg)))
> > > > +             return -EFAULT;
> > > > +
> > > > +     switch (arg.param) {
> > > > +     case DMA_BUF_INFO_MAP_INFO:
> > > > +             arg.value = dmabuf->map_info;
> > > > +             break;
> > > > +     default:
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > > +     if (copy_to_user(uarg, &arg, sizeof(arg)))
> > > > +             return -EFAULT;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > >    static long dma_buf_ioctl(struct file *file,
> > > >                          unsigned int cmd, unsigned long arg)
> > > >    {
> > > > @@ -369,6 +412,9 @@ static long dma_buf_ioctl(struct file *file,
> > > >        case DMA_BUF_SET_NAME_B:
> > > >                return dma_buf_set_name(dmabuf, (const char __user *)arg);
> > > > 
> > > > +     case DMA_BUF_IOCTL_INFO:
> > > > +             return dma_buf_info(dmabuf, (void __user *)arg);
> > > > +
> > > >        default:
> > > >                return -ENOTTY;
> > > >        }
> > > > @@ -530,6 +576,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
> > > >        dmabuf->priv = exp_info->priv;
> > > >        dmabuf->ops = exp_info->ops;
> > > >        dmabuf->size = exp_info->size;
> > > > +     dmabuf->map_info = exp_info->map_info;
> > > >        dmabuf->exp_name = exp_info->exp_name;
> > > >        dmabuf->owner = exp_info->owner;
> > > >        spin_lock_init(&dmabuf->name_lock);
> > > > @@ -1245,10 +1292,6 @@ int dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma,
> > > >        if (WARN_ON(!dmabuf || !vma))
> > > >                return -EINVAL;
> > > > 
> > > > -     /* check if buffer supports mmap */
> > > > -     if (!dmabuf->ops->mmap)
> > > > -             return -EINVAL;
> > > > -
> > > >        /* check for offset overflow */
> > > >        if (pgoff + vma_pages(vma) < pgoff)
> > > >                return -EOVERFLOW;
> > > > @@ -1262,7 +1305,7 @@ int dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma,
> > > >        vma_set_file(vma, dmabuf->file);
> > > >        vma->vm_pgoff = pgoff;
> > > > 
> > > > -     return dmabuf->ops->mmap(dmabuf, vma);
> > > > +     return __dma_buf_mmap(dmabuf, vma);
> > > >    }
> > > >    EXPORT_SYMBOL_NS_GPL(dma_buf_mmap, DMA_BUF);
> > > > 
> > > > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > > > index 71731796c8c3..37923c8d5c24 100644
> > > > --- a/include/linux/dma-buf.h
> > > > +++ b/include/linux/dma-buf.h
> > > > @@ -23,6 +23,8 @@
> > > >    #include <linux/dma-fence.h>
> > > >    #include <linux/wait.h>
> > > > 
> > > > +#include <uapi/linux/dma-buf.h>
> > > > +
> > > >    struct device;
> > > >    struct dma_buf;
> > > >    struct dma_buf_attachment;
> > > > @@ -307,6 +309,13 @@ struct dma_buf {
> > > >         */
> > > >        size_t size;
> > > > 
> > > > +     /**
> > > > +      * @map_info:
> > > > +      *
> > > > +      * CPU mapping/coherency information for the buffer.
> > > > +      */
> > > > +     enum dma_buf_map_info map_info;
> > > > +
> > > >        /**
> > > >         * @file:
> > > >         *
> > > > @@ -533,6 +542,7 @@ struct dma_buf_attachment {
> > > >     * @ops:    Attach allocator-defined dma buf ops to the new buffer
> > > >     * @size:   Size of the buffer - invariant over the lifetime of the buffer
> > > >     * @flags:  mode flags for the file
> > > > + * @map_info:        CPU mapping/coherency information for the buffer
> > > >     * @resv:   reservation-object, NULL to allocate default one
> > > >     * @priv:   Attach private data of allocator to this buffer
> > > >     *
> > > > @@ -545,6 +555,7 @@ struct dma_buf_export_info {
> > > >        const struct dma_buf_ops *ops;
> > > >        size_t size;
> > > >        int flags;
> > > > +     enum dma_buf_map_info map_info;
> > > >        struct dma_resv *resv;
> > > >        void *priv;
> > > >    };
> > > > diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-buf.h
> > > > index b1523cb8ab30..07b403ffdb43 100644
> > > > --- a/include/uapi/linux/dma-buf.h
> > > > +++ b/include/uapi/linux/dma-buf.h
> > > > @@ -85,6 +85,72 @@ struct dma_buf_sync {
> > > > 
> > > >    #define DMA_BUF_NAME_LEN    32
> > > > 
> > > > +/**
> > > > + * enum dma_buf_map_info - CPU mapping info
> > > > + *
> > > > + * This enum describes coherency of a userspace mapping of the dmabuf.
> > > > + *
> > > > + * Importing devices should check dma_buf::map_info flag and reject an
> > > > + * import if unsupported.  For example, if the exporting device uses
> > > > + * @DMA_BUF_COHERENT_CACHED but the importing device does not support
> > > > + * CPU cache coherency, the dma-buf import should fail.
> > > > + */
> > > > +enum dma_buf_map_info {
> > > > +     /**
> > > > +      * @DMA_BUF_MAP_INCOHERENT: CPU mapping is incoherent.
> > > > +      *
> > > > +      * Use of DMA_BUF_IOCTL_SYNC is required for CPU managed coherenency.
> > > > +      */
> > > > +     DMA_BUF_MAP_INCOHERENT,
> > > > +
> > > > +     /**
> > > > +      * @DMA_BUF_COHERENT_WC: CPU mapping is coherent but not cached.
> > > > +      *
> > > > +      * A cpu mmap'ing is coherent, and DMA_BUF_IOCTL_SYNC is not required.
> > > > +      * However fences may be still required for synchronizing access.  Ie.
> > > > +      * coherency can only be relied upon by an explicit-fencing userspace.
> > > > +      * An implicit-sync userspace must still use DMA_BUF_IOCTL_SYNC.
> > > > +      *
> > > > +      * The cpu mapping is writecombine.
> > > > +      */
> > > > +     DMA_BUF_COHERENT_WC,
> > > > +
> > > > +     /**
> > > > +      * @DMA_BUF_COHERENT_CACHED: CPU mapping is coherent and CPU cached.
> > > > +      *
> > > > +      * A cpu mmap'ing is coherent, and DMA_BUF_IOCTL_SYNC is not required.
> > > > +      * However fences may be still required for synchronizing access.  Ie.
> > > > +      * coherency can only be relied upon by an explicit-fencing userspace.
> > > > +      * An implicit-sync userspace must still use DMA_BUF_IOCTL_SYNC.
> > > > +      *
> > > > +      * The cpu mapping is cached.
> > > > +      */
> > > > +     DMA_BUF_COHERENT_CACHED,
> > > > +};
> > > > +
> > > > +/**
> > > > + * struct dma_buf_info - Query info about the buffer.
> > > > + */
> > > > +struct dma_buf_info {
> > > > +
> > > > +#define DMA_BUF_INFO_MAP_INFO    1
> > > > +
> > > > +     /**
> > > > +      * @param: Which param to query
> > > > +      *
> > > > +      * DMA_BUF_INFO_MAP_INFO:
> > > > +      *     Returns enum dma_buf_map_info, describing the coherency and
> > > > +      *     caching of a CPU mapping of the buffer.
> > > > +      */
> > > > +     __u32 param;
> > > > +     __u32 pad;
> > > > +
> > > > +     /**
> > > > +      * @value: Return value of the query.
> > > > +      */
> > > > +     __u64 value;
> > > > +};
> > > > +
> > > >    #define DMA_BUF_BASE                'b'
> > > >    #define DMA_BUF_IOCTL_SYNC  _IOW(DMA_BUF_BASE, 0, struct dma_buf_sync)
> > > > 
> > > > @@ -95,4 +161,6 @@ struct dma_buf_sync {
> > > >    #define DMA_BUF_SET_NAME_A  _IOW(DMA_BUF_BASE, 1, __u32)
> > > >    #define DMA_BUF_SET_NAME_B  _IOW(DMA_BUF_BASE, 1, __u64)
> > > > 
> > > > +#define DMA_BUF_IOCTL_INFO   _IOWR(DMA_BUF_BASE, 2, struct dma_buf_info)
> > > > +
> > > >    #endif
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
