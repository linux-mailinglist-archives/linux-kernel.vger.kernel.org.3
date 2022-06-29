Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289D355FCA0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbiF2Jye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbiF2Jyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:54:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC0EE3D4B8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656496470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=36O/Gzs2sswpRmDBZoRkMoKcl0+wQgegUageWIRbuPE=;
        b=Fbqksv7PorjxAsjEKRtxXTu2XVsaSmfly1GhMc43DJTtmgB3nG8jQ9GqevjvkwJVR2/jkO
        MsHJAJx4rv7/6oxdcHRHRkcP4JnCo3zwhEBPuETgto8WTk/kruFyJYN28kevjugWRyEdYk
        yNJyPX4STzQE0xsMpU/1whaHKH97X8M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-hQr6LUtqOPiQU27BVglquw-1; Wed, 29 Jun 2022 05:54:29 -0400
X-MC-Unique: hQr6LUtqOPiQU27BVglquw-1
Received: by mail-wm1-f71.google.com with SMTP id be8-20020a05600c1e8800b003a069fe18ffso1263775wmb.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=36O/Gzs2sswpRmDBZoRkMoKcl0+wQgegUageWIRbuPE=;
        b=oCxmwFiF/+jVE+iMGTM2sF8mbEPfjraEi2qkut6ew7joHxXihmSsX1DyjrKX/5dWuS
         FaazcWPsa73hVadA0uXcVl2atg4GIuYXzhk7BfX2ksvd45WRj09BKV+FIggwha1nW90f
         8BqXzQk8oKJhB2ip+i7v5sgcLtJH+jPzxXn4KPkrM6HLmZ2U6AFHbCPmXPgeILBDpr62
         8K/SBlKLBB6PG2YxnmfV3pspV7tKGJiO1avTawNHk/PK242E6cpuwvSIRnBi3qiQn+2S
         MtrESUJkmutB1yTZgpc5rpHxW7hTGYHPo1wgQf4J1HVdS/9lEHKxOPvMhOdr4dl36nmx
         J0Cw==
X-Gm-Message-State: AJIora/iRu8J3P2xfSxRkFZAdu0qsZE/K1FHCOejp/2cj6JjIhSdRiZH
        FhN+k8NoXmzXXqF9tQtadx1mk9xDyP879HlCXzCbc5TRCjCWlbbCvEvWMTzXoW9YBB8cuXfqGvB
        8uG6DvioHbYGMQUcXjpi97N9e
X-Received: by 2002:a05:600c:d0:b0:39c:5927:3fa7 with SMTP id u16-20020a05600c00d000b0039c59273fa7mr2675272wmm.36.1656496467954;
        Wed, 29 Jun 2022 02:54:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sKqYhDGRn42oJUC9GK4iLPx/KWw+hJS0QGL/AKJfgjnQJxjz/dRnaJ+S5h9tADAL8A2HvpdQ==
X-Received: by 2002:a05:600c:d0:b0:39c:5927:3fa7 with SMTP id u16-20020a05600c00d000b0039c59273fa7mr2675239wmm.36.1656496467655;
        Wed, 29 Jun 2022 02:54:27 -0700 (PDT)
Received: from redhat.com ([2.52.23.204])
        by smtp.gmail.com with ESMTPSA id 190-20020a1c19c7000000b003a04912351fsm2684729wmz.17.2022.06.29.02.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 02:54:27 -0700 (PDT)
Date:   Wed, 29 Jun 2022 05:54:23 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] vduse: Support registering userspace memory for IOTLB
Message-ID: <20220629055241-mutt-send-email-mst@kernel.org>
References: <20220629082541.118-1-xieyongji@bytedance.com>
 <20220629082541.118-6-xieyongji@bytedance.com>
 <20220629043539-mutt-send-email-mst@kernel.org>
 <CACycT3sAcH-b40hORjSOQb67jZ0Fd-fxdzmZNwt=4iZdX6gLeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACycT3sAcH-b40hORjSOQb67jZ0Fd-fxdzmZNwt=4iZdX6gLeA@mail.gmail.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 05:26:04PM +0800, Yongji Xie wrote:
> On Wed, Jun 29, 2022 at 4:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jun 29, 2022 at 04:25:40PM +0800, Xie Yongji wrote:
> > > Introduce two ioctls: VDUSE_IOTLB_REG_UMEM and
> > > VDUSE_IOTLB_DEREG_UMEM to support registering
> > > and de-registering userspace memory for IOTLB
> > > in virtio-vdpa case.
> > >
> > > Now it only supports registering userspace memory
> > > for IOTLB as bounce buffer.
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 138 +++++++++++++++++++++++++++++
> > >  include/uapi/linux/vduse.h         |  28 ++++++
> > >  2 files changed, 166 insertions(+)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > index c47a5d9765cf..7b2ea7612da9 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -21,6 +21,7 @@
> > >  #include <linux/uio.h>
> > >  #include <linux/vdpa.h>
> > >  #include <linux/nospec.h>
> > > +#include <linux/sched/mm.h>
> > >  #include <uapi/linux/vduse.h>
> > >  #include <uapi/linux/vdpa.h>
> > >  #include <uapi/linux/virtio_config.h>
> > > @@ -64,6 +65,13 @@ struct vduse_vdpa {
> > >       struct vduse_dev *dev;
> > >  };
> > >
> > > +struct vduse_iotlb_mem {
> > > +     unsigned long iova;
> > > +     unsigned long npages;
> > > +     struct page **pages;
> > > +     struct mm_struct *mm;
> > > +};
> > > +
> > >  struct vduse_dev {
> > >       struct vduse_vdpa *vdev;
> > >       struct device *dev;
> > > @@ -95,6 +103,8 @@ struct vduse_dev {
> > >       u8 status;
> > >       u32 vq_num;
> > >       u32 vq_align;
> > > +     struct vduse_iotlb_mem *iotlb_mem;
> > > +     struct mutex mem_lock;
> > >  };
> > >
> > >  struct vduse_dev_msg {
> > > @@ -917,6 +927,100 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
> > >       return ret;
> > >  }
> > >
> > > +static int vduse_dev_dereg_iotlb_mem(struct vduse_dev *dev,
> > > +                                  u64 iova, u64 size)
> > > +{
> > > +     int ret;
> > > +
> > > +     mutex_lock(&dev->mem_lock);
> > > +     ret = -ENOENT;
> > > +     if (!dev->iotlb_mem)
> > > +             goto unlock;
> > > +
> > > +     ret = -EINVAL;
> > > +     if (dev->iotlb_mem->iova != iova || size != dev->domain->bounce_size)
> > > +             goto unlock;
> > > +
> > > +     vduse_domain_remove_user_bounce_pages(dev->domain);
> > > +     unpin_user_pages(dev->iotlb_mem->pages, dev->iotlb_mem->npages);
> >
> > I notice you don't mark the pages dirty. This is going to be a problem.
> >
> 
> Thanks for pointing out this, I will use unpin_user_pages_dirty_lock() instead.
> 
> > > +     atomic64_sub(dev->iotlb_mem->npages, &dev->iotlb_mem->mm->pinned_vm);
> > > +     mmdrop(dev->iotlb_mem->mm);
> > > +     vfree(dev->iotlb_mem->pages);
> > > +     kfree(dev->iotlb_mem);
> > > +     dev->iotlb_mem = NULL;
> > > +     ret = 0;
> > > +unlock:
> > > +     mutex_unlock(&dev->mem_lock);
> > > +     return ret;
> > > +}
> > > +
> > > +static int vduse_dev_reg_iotlb_mem(struct vduse_dev *dev,
> > > +                                u64 iova, u64 uaddr, u64 size)
> > > +{
> > > +     struct page **page_list = NULL;
> > > +     struct vduse_iotlb_mem *mem = NULL;
> > > +     long pinned = 0;
> > > +     unsigned long npages, lock_limit;
> > > +     int ret;
> > > +
> > > +     if (size != dev->domain->bounce_size ||
> > > +         iova != 0 || uaddr & ~PAGE_MASK)
> > > +             return -EINVAL;
> > > +
> > > +     mutex_lock(&dev->mem_lock);
> > > +     ret = -EEXIST;
> > > +     if (dev->iotlb_mem)
> > > +             goto unlock;
> > > +
> > > +     ret = -ENOMEM;
> > > +     npages = size >> PAGE_SHIFT;
> > > +     page_list = vmalloc(array_size(npages,
> > > +                         sizeof(struct page *)));
> >
> > Is this basically trying to do a vmalloc with userspace-controlled size?
> > That's an easy DOS vector.
> >
> 
> We already checked the size before. The size must equal to (64MB >>
> PAGE_SHIFT) now.

That's not a small amount. Can this be accounted e.g. through cgroups at least?

> > > +     mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> > > +     if (!page_list || !mem)
> > > +             goto unlock;
> > > +
> > > +     mmap_read_lock(current->mm);
> > > +
> > > +     lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
> > > +     if (npages + atomic64_read(&current->mm->pinned_vm) > lock_limit)
> > > +             goto out;
> > > +
> > > +     pinned = pin_user_pages(uaddr, npages, FOLL_LONGTERM | FOLL_WRITE,
> > > +                             page_list, NULL);
> > > +     if (pinned != npages) {
> > > +             ret = pinned < 0 ? pinned : -ENOMEM;
> > > +             goto out;
> > > +     }
> >
> >
> > This is a popular approach but it's problematic if multiple
> > devices try to pin the same page.
> 
> Do you mean the data would be corrupted if multiple devices use the
> same page as bounce buffer? This is indeed a problem.

No i mean you decrement the lock twice. Question is can two bounce
buffers share a page?

> > Can this happen here?
> >
> 
> I think we can't prevent this case now. I will do it in v2.
> 
> > > +
> > > +     ret = vduse_domain_add_user_bounce_pages(dev->domain,
> > > +                                              page_list, pinned);
> > > +     if (ret)
> > > +             goto out;
> > > +
> > > +     atomic64_add(npages, &current->mm->pinned_vm);
> > > +
> > > +     mem->pages = page_list;
> > > +     mem->npages = pinned;
> > > +     mem->iova = iova;
> > > +     mem->mm = current->mm;
> > > +     mmgrab(current->mm);
> > > +
> > > +     dev->iotlb_mem = mem;
> > > +out:
> > > +     if (ret && pinned > 0)
> > > +             unpin_user_pages(page_list, pinned);
> > > +
> > > +     mmap_read_unlock(current->mm);
> > > +unlock:
> > > +     if (ret) {
> > > +             vfree(page_list);
> > > +             kfree(mem);
> > > +     }
> > > +     mutex_unlock(&dev->mem_lock);
> > > +     return ret;
> > > +}
> > > +
> > >  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> > >                           unsigned long arg)
> > >  {
> > > @@ -943,6 +1047,16 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> > >               if (entry.start > entry.last)
> > >                       break;
> > >
> > > +             if (domain->bounce_map && dev->iotlb_mem) {
> > > +                     ret = -EEXIST;
> > > +                     if (entry.start >= 0 &&
> > > +                         entry.last < domain->bounce_size)
> > > +                             break;
> > > +
> > > +                     if (entry.start < domain->bounce_size)
> > > +                             entry.start = domain->bounce_size;
> > > +             }
> > > +
> > >               spin_lock(&domain->iotlb_lock);
> > >               map = vhost_iotlb_itree_first(domain->iotlb,
> > >                                             entry.start, entry.last);
> > > @@ -1102,6 +1216,28 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> > >               ret = 0;
> > >               break;
> > >       }
> > > +     case VDUSE_IOTLB_REG_UMEM: {
> > > +             struct vduse_iotlb_umem umem;
> > > +
> > > +             ret = -EFAULT;
> > > +             if (copy_from_user(&umem, argp, sizeof(umem)))
> > > +                     break;
> > > +
> > > +             ret = vduse_dev_reg_iotlb_mem(dev, umem.iova,
> > > +                                           umem.uaddr, umem.size);
> > > +             break;
> > > +     }
> > > +     case VDUSE_IOTLB_DEREG_UMEM: {
> > > +             struct vduse_iotlb_umem umem;
> > > +
> > > +             ret = -EFAULT;
> > > +             if (copy_from_user(&umem, argp, sizeof(umem)))
> > > +                     break;
> > > +
> > > +             ret = vduse_dev_dereg_iotlb_mem(dev, umem.iova,
> > > +                                             umem.size);
> > > +             break;
> > > +     }
> > >       default:
> > >               ret = -ENOIOCTLCMD;
> > >               break;
> > > @@ -1114,6 +1250,7 @@ static int vduse_dev_release(struct inode *inode, struct file *file)
> > >  {
> > >       struct vduse_dev *dev = file->private_data;
> > >
> > > +     vduse_dev_dereg_iotlb_mem(dev, 0, dev->domain->bounce_size);
> > >       spin_lock(&dev->msg_lock);
> > >       /* Make sure the inflight messages can processed after reconncection */
> > >       list_splice_init(&dev->recv_list, &dev->send_list);
> > > @@ -1176,6 +1313,7 @@ static struct vduse_dev *vduse_dev_create(void)
> > >               return NULL;
> > >
> > >       mutex_init(&dev->lock);
> > > +     mutex_init(&dev->mem_lock);
> > >       spin_lock_init(&dev->msg_lock);
> > >       INIT_LIST_HEAD(&dev->send_list);
> > >       INIT_LIST_HEAD(&dev->recv_list);
> > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > > index c201b7a77c2c..1b17391e228f 100644
> > > --- a/include/uapi/linux/vduse.h
> > > +++ b/include/uapi/linux/vduse.h
> > > @@ -227,6 +227,34 @@ struct vduse_iotlb_info {
> > >  /* Get IOTLB information, e.g. bounce buffer size */
> > >  #define VDUSE_IOTLB_GET_INFO    _IOR(VDUSE_BASE, 0x18, struct vduse_iotlb_info)
> > >
> > > +/**
> > > + * struct vduse_iotlb_umem - userspace memory configuration
> > > + * @uaddr: start address of userspace memory, it must be aligned to page size
> > > + * @iova: IOVA of userspace memory, it must be equal to bounce iova returned
> > > + *        by VDUSE_IOTLB_GET_INFO now
> > > + * @size: size of userspace memory, it must be equal to bounce size returned
> > > + *        by VDUSE_IOTLB_GET_INFO now
> > > + * @reserved: for future use, needs to be initialized to zero
> >
> > You should check that it's 0 in that case, otherwise userspace
> > will conveniently forget.
> >
> 
> OK, I will fix it.
> 
> Thanks,
> Yongji

