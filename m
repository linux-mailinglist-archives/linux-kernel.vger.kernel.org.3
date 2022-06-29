Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4D155FBE3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiF2J0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiF2J0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:26:18 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97C838D82
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:26:16 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id fi2so31280250ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2OEF+FUWpp9LU3bh3O3cqqHV3R5M6UBiKbSUid8K01w=;
        b=KEOOZxSnkAH+rhaCzs8yw0iXTvKGYZsp0BpLhelfz52cOCfycmBQ20HbRB7PPwIwCl
         KnvaW+fYwZmc35bW1Ww6K2qsNkM0TLRmZPglINGFEKtt8Nul3xlmfECBw5x2A28pV2J6
         +JUPaP8Y09NHJf6ra5YNtsS+OqXEeXhwLm5eAXWLfVF4Ac12V6RQsfYHXq9PDtSJLSou
         2nqHGQKK4IYAu04uTlhQ0cJwVsPyVpgi4Q54gPZqH3KWE/GQ69m8AwAopeafmcEIeeWd
         Sdv0kXf9Mb0becqUBZXsCknlIkmduiFFEySukVGrsR6v+C35gIqGNAbT9/PnBu5ZOjSM
         bzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2OEF+FUWpp9LU3bh3O3cqqHV3R5M6UBiKbSUid8K01w=;
        b=DS9sBQP+F22/g5bWlTWEeaTkts2tHJ40/tM2qJNObv1dYcOmppkePItIIQpvcYbwNR
         4QZZIKczhWaQnz8Gh6adYoDdiLkOmsEZ3HgqkoGCwapWsXiHo9Dt3ngZS1C/fjSLlBGJ
         yxm3xlFK3U0m1FeVeApLXGNkqqltCj44b2ZErGZCpWEv3BeFXydG16UWNjuJMYnmd2fL
         yqwol3FYEConTvsnmd3nEELVKZy2b+bewjIFg7QEdFXtP/xSjoeBrdRD8RrE5GLcl9CE
         wTuuH6DWfa07RBLgtcyrkRY7EfjbkbLdtMHGu2ymYsCEsJcYg5jAZ9Wr9aNtfrDnJ1Kz
         63WQ==
X-Gm-Message-State: AJIora+8hj3nLndhiEXWdS+9NXkzZtoZoh5RvqXaBTTFerPtpk7SnfFh
        rYg/pO3qRxspGmKhSYYj2WvpknePLVmsEl1q1E5q
X-Google-Smtp-Source: AGRyM1sflLD1FObztm4LcH67uIURt/HfMy6UlTmk4qCQrmBLP7Ws1JI8Ul+5ztNzQzio6IaFina4f3BR2GvP9TIZuVQ=
X-Received: by 2002:a17:906:794a:b0:722:efd0:862f with SMTP id
 l10-20020a170906794a00b00722efd0862fmr2299695ejo.650.1656494775302; Wed, 29
 Jun 2022 02:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220629082541.118-1-xieyongji@bytedance.com> <20220629082541.118-6-xieyongji@bytedance.com>
 <20220629043539-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220629043539-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 29 Jun 2022 17:26:04 +0800
Message-ID: <CACycT3sAcH-b40hORjSOQb67jZ0Fd-fxdzmZNwt=4iZdX6gLeA@mail.gmail.com>
Subject: Re: [PATCH 5/6] vduse: Support registering userspace memory for IOTLB
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 4:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jun 29, 2022 at 04:25:40PM +0800, Xie Yongji wrote:
> > Introduce two ioctls: VDUSE_IOTLB_REG_UMEM and
> > VDUSE_IOTLB_DEREG_UMEM to support registering
> > and de-registering userspace memory for IOTLB
> > in virtio-vdpa case.
> >
> > Now it only supports registering userspace memory
> > for IOTLB as bounce buffer.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 138 +++++++++++++++++++++++++++++
> >  include/uapi/linux/vduse.h         |  28 ++++++
> >  2 files changed, 166 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > index c47a5d9765cf..7b2ea7612da9 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/uio.h>
> >  #include <linux/vdpa.h>
> >  #include <linux/nospec.h>
> > +#include <linux/sched/mm.h>
> >  #include <uapi/linux/vduse.h>
> >  #include <uapi/linux/vdpa.h>
> >  #include <uapi/linux/virtio_config.h>
> > @@ -64,6 +65,13 @@ struct vduse_vdpa {
> >       struct vduse_dev *dev;
> >  };
> >
> > +struct vduse_iotlb_mem {
> > +     unsigned long iova;
> > +     unsigned long npages;
> > +     struct page **pages;
> > +     struct mm_struct *mm;
> > +};
> > +
> >  struct vduse_dev {
> >       struct vduse_vdpa *vdev;
> >       struct device *dev;
> > @@ -95,6 +103,8 @@ struct vduse_dev {
> >       u8 status;
> >       u32 vq_num;
> >       u32 vq_align;
> > +     struct vduse_iotlb_mem *iotlb_mem;
> > +     struct mutex mem_lock;
> >  };
> >
> >  struct vduse_dev_msg {
> > @@ -917,6 +927,100 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
> >       return ret;
> >  }
> >
> > +static int vduse_dev_dereg_iotlb_mem(struct vduse_dev *dev,
> > +                                  u64 iova, u64 size)
> > +{
> > +     int ret;
> > +
> > +     mutex_lock(&dev->mem_lock);
> > +     ret = -ENOENT;
> > +     if (!dev->iotlb_mem)
> > +             goto unlock;
> > +
> > +     ret = -EINVAL;
> > +     if (dev->iotlb_mem->iova != iova || size != dev->domain->bounce_size)
> > +             goto unlock;
> > +
> > +     vduse_domain_remove_user_bounce_pages(dev->domain);
> > +     unpin_user_pages(dev->iotlb_mem->pages, dev->iotlb_mem->npages);
>
> I notice you don't mark the pages dirty. This is going to be a problem.
>

Thanks for pointing out this, I will use unpin_user_pages_dirty_lock() instead.

> > +     atomic64_sub(dev->iotlb_mem->npages, &dev->iotlb_mem->mm->pinned_vm);
> > +     mmdrop(dev->iotlb_mem->mm);
> > +     vfree(dev->iotlb_mem->pages);
> > +     kfree(dev->iotlb_mem);
> > +     dev->iotlb_mem = NULL;
> > +     ret = 0;
> > +unlock:
> > +     mutex_unlock(&dev->mem_lock);
> > +     return ret;
> > +}
> > +
> > +static int vduse_dev_reg_iotlb_mem(struct vduse_dev *dev,
> > +                                u64 iova, u64 uaddr, u64 size)
> > +{
> > +     struct page **page_list = NULL;
> > +     struct vduse_iotlb_mem *mem = NULL;
> > +     long pinned = 0;
> > +     unsigned long npages, lock_limit;
> > +     int ret;
> > +
> > +     if (size != dev->domain->bounce_size ||
> > +         iova != 0 || uaddr & ~PAGE_MASK)
> > +             return -EINVAL;
> > +
> > +     mutex_lock(&dev->mem_lock);
> > +     ret = -EEXIST;
> > +     if (dev->iotlb_mem)
> > +             goto unlock;
> > +
> > +     ret = -ENOMEM;
> > +     npages = size >> PAGE_SHIFT;
> > +     page_list = vmalloc(array_size(npages,
> > +                         sizeof(struct page *)));
>
> Is this basically trying to do a vmalloc with userspace-controlled size?
> That's an easy DOS vector.
>

We already checked the size before. The size must equal to (64MB >>
PAGE_SHIFT) now.

> > +     mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> > +     if (!page_list || !mem)
> > +             goto unlock;
> > +
> > +     mmap_read_lock(current->mm);
> > +
> > +     lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
> > +     if (npages + atomic64_read(&current->mm->pinned_vm) > lock_limit)
> > +             goto out;
> > +
> > +     pinned = pin_user_pages(uaddr, npages, FOLL_LONGTERM | FOLL_WRITE,
> > +                             page_list, NULL);
> > +     if (pinned != npages) {
> > +             ret = pinned < 0 ? pinned : -ENOMEM;
> > +             goto out;
> > +     }
>
>
> This is a popular approach but it's problematic if multiple
> devices try to pin the same page.

Do you mean the data would be corrupted if multiple devices use the
same page as bounce buffer? This is indeed a problem.

> Can this happen here?
>

I think we can't prevent this case now. I will do it in v2.

> > +
> > +     ret = vduse_domain_add_user_bounce_pages(dev->domain,
> > +                                              page_list, pinned);
> > +     if (ret)
> > +             goto out;
> > +
> > +     atomic64_add(npages, &current->mm->pinned_vm);
> > +
> > +     mem->pages = page_list;
> > +     mem->npages = pinned;
> > +     mem->iova = iova;
> > +     mem->mm = current->mm;
> > +     mmgrab(current->mm);
> > +
> > +     dev->iotlb_mem = mem;
> > +out:
> > +     if (ret && pinned > 0)
> > +             unpin_user_pages(page_list, pinned);
> > +
> > +     mmap_read_unlock(current->mm);
> > +unlock:
> > +     if (ret) {
> > +             vfree(page_list);
> > +             kfree(mem);
> > +     }
> > +     mutex_unlock(&dev->mem_lock);
> > +     return ret;
> > +}
> > +
> >  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> >                           unsigned long arg)
> >  {
> > @@ -943,6 +1047,16 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> >               if (entry.start > entry.last)
> >                       break;
> >
> > +             if (domain->bounce_map && dev->iotlb_mem) {
> > +                     ret = -EEXIST;
> > +                     if (entry.start >= 0 &&
> > +                         entry.last < domain->bounce_size)
> > +                             break;
> > +
> > +                     if (entry.start < domain->bounce_size)
> > +                             entry.start = domain->bounce_size;
> > +             }
> > +
> >               spin_lock(&domain->iotlb_lock);
> >               map = vhost_iotlb_itree_first(domain->iotlb,
> >                                             entry.start, entry.last);
> > @@ -1102,6 +1216,28 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> >               ret = 0;
> >               break;
> >       }
> > +     case VDUSE_IOTLB_REG_UMEM: {
> > +             struct vduse_iotlb_umem umem;
> > +
> > +             ret = -EFAULT;
> > +             if (copy_from_user(&umem, argp, sizeof(umem)))
> > +                     break;
> > +
> > +             ret = vduse_dev_reg_iotlb_mem(dev, umem.iova,
> > +                                           umem.uaddr, umem.size);
> > +             break;
> > +     }
> > +     case VDUSE_IOTLB_DEREG_UMEM: {
> > +             struct vduse_iotlb_umem umem;
> > +
> > +             ret = -EFAULT;
> > +             if (copy_from_user(&umem, argp, sizeof(umem)))
> > +                     break;
> > +
> > +             ret = vduse_dev_dereg_iotlb_mem(dev, umem.iova,
> > +                                             umem.size);
> > +             break;
> > +     }
> >       default:
> >               ret = -ENOIOCTLCMD;
> >               break;
> > @@ -1114,6 +1250,7 @@ static int vduse_dev_release(struct inode *inode, struct file *file)
> >  {
> >       struct vduse_dev *dev = file->private_data;
> >
> > +     vduse_dev_dereg_iotlb_mem(dev, 0, dev->domain->bounce_size);
> >       spin_lock(&dev->msg_lock);
> >       /* Make sure the inflight messages can processed after reconncection */
> >       list_splice_init(&dev->recv_list, &dev->send_list);
> > @@ -1176,6 +1313,7 @@ static struct vduse_dev *vduse_dev_create(void)
> >               return NULL;
> >
> >       mutex_init(&dev->lock);
> > +     mutex_init(&dev->mem_lock);
> >       spin_lock_init(&dev->msg_lock);
> >       INIT_LIST_HEAD(&dev->send_list);
> >       INIT_LIST_HEAD(&dev->recv_list);
> > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > index c201b7a77c2c..1b17391e228f 100644
> > --- a/include/uapi/linux/vduse.h
> > +++ b/include/uapi/linux/vduse.h
> > @@ -227,6 +227,34 @@ struct vduse_iotlb_info {
> >  /* Get IOTLB information, e.g. bounce buffer size */
> >  #define VDUSE_IOTLB_GET_INFO    _IOR(VDUSE_BASE, 0x18, struct vduse_iotlb_info)
> >
> > +/**
> > + * struct vduse_iotlb_umem - userspace memory configuration
> > + * @uaddr: start address of userspace memory, it must be aligned to page size
> > + * @iova: IOVA of userspace memory, it must be equal to bounce iova returned
> > + *        by VDUSE_IOTLB_GET_INFO now
> > + * @size: size of userspace memory, it must be equal to bounce size returned
> > + *        by VDUSE_IOTLB_GET_INFO now
> > + * @reserved: for future use, needs to be initialized to zero
>
> You should check that it's 0 in that case, otherwise userspace
> will conveniently forget.
>

OK, I will fix it.

Thanks,
Yongji
