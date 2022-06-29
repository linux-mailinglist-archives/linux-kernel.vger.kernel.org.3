Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A04755FD01
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiF2KTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiF2KTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:19:44 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4352BB37
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:19:43 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id d2so19859571ejy.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1UldF0e+qJzCUv0ebE2gILAibPvmQ5TmWWnAkcNFdt4=;
        b=1bvDBEPk3nP4RzWNOkUaZKlS6hAz5XeGNEepl9k9gLZ0PT+BRuY/ef30s6JawvNUfU
         TxB1GH/Mn638pTIqP1JPX+jWz5zL+IaRIq2h/SRw1XJFhLW3dHMXYUEtv9brLwNgNjg4
         mrF9cWYvMVFM8R/C/L4w25n6eSBUFLAJoaF98uRno+fW7xN5Me/1bBPdbmv2WswKqRT8
         91odyb6/3BOJ06pADQXyX5kZi2OheimXxXkfmYKpYq9k69dc5jzknmcIh3vAAKzoaE+f
         aMIDKynwO93w8yEkYrqfI5V1pTexcLNUK4NdwLlJL+iSnQiycDUlzOhf5SxWgFV58tPw
         qtxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1UldF0e+qJzCUv0ebE2gILAibPvmQ5TmWWnAkcNFdt4=;
        b=H5arMJWBJIHWTo5axYvcsQVoiypDTo+dAZL1eDWL77Jsj2gUZVnK07JUuTwiudUhbC
         4KzBw/9cc+zF0ICawsRX7iETVFzPexXRZS96SoQbjVXtaitMgLfC5/1gSYlFtHjwSBes
         SNRlQbyqqOWkBN0WKKkyZh7d8wzWzhJbL8OJZ3bdShVQ2d1+/yINI6iAANU1MD0Z+HEl
         6rgi3O3HHTVpHufGh3z8vY/pCequT7VAl+efgn7EYA8zqQQaunADP1AwrO6HnBnVAaRG
         YKrssucK8X2sWBYKKbWbqpvrgxcav0Ay5OyHbLy10UmxOwulEnHCGkcY2/VCHa3D3zBP
         2QBg==
X-Gm-Message-State: AJIora9iDgW2YzlYexWNh8YMIT7e7jROzDfHVr7E43IWUJbDHQwf1gez
        PHHSLZ5V7B0BAQ7ufjz1coBWqvYvlWsr8Doyftg8
X-Google-Smtp-Source: AGRyM1sRBC0/qHrzfO5XUsgULVqTxGGCmYLAoedTByRp6eZvVAkGI4P74Vm8ysvMefGyyYSQfwHbHa3BkIgQCZy8wb0=
X-Received: by 2002:a17:907:3f0a:b0:726:324c:5bc2 with SMTP id
 hq10-20020a1709073f0a00b00726324c5bc2mr2770697ejc.32.1656497981640; Wed, 29
 Jun 2022 03:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220629082541.118-1-xieyongji@bytedance.com> <20220629082541.118-6-xieyongji@bytedance.com>
 <20220629043539-mutt-send-email-mst@kernel.org> <CACycT3sAcH-b40hORjSOQb67jZ0Fd-fxdzmZNwt=4iZdX6gLeA@mail.gmail.com>
 <20220629055241-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220629055241-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 29 Jun 2022 18:19:31 +0800
Message-ID: <CACycT3vaNLYRid5SsT11LuVCaGXbBfV=q7c7SUp1+r9BcRpwkw@mail.gmail.com>
Subject: Re: [PATCH 5/6] vduse: Support registering userspace memory for IOTLB
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        songmuchun@bytedance.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 5:54 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jun 29, 2022 at 05:26:04PM +0800, Yongji Xie wrote:
> > On Wed, Jun 29, 2022 at 4:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Wed, Jun 29, 2022 at 04:25:40PM +0800, Xie Yongji wrote:
> > > > Introduce two ioctls: VDUSE_IOTLB_REG_UMEM and
> > > > VDUSE_IOTLB_DEREG_UMEM to support registering
> > > > and de-registering userspace memory for IOTLB
> > > > in virtio-vdpa case.
> > > >
> > > > Now it only supports registering userspace memory
> > > > for IOTLB as bounce buffer.
> > > >
> > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > ---
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 138 +++++++++++++++++++++++++++++
> > > >  include/uapi/linux/vduse.h         |  28 ++++++
> > > >  2 files changed, 166 insertions(+)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > index c47a5d9765cf..7b2ea7612da9 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -21,6 +21,7 @@
> > > >  #include <linux/uio.h>
> > > >  #include <linux/vdpa.h>
> > > >  #include <linux/nospec.h>
> > > > +#include <linux/sched/mm.h>
> > > >  #include <uapi/linux/vduse.h>
> > > >  #include <uapi/linux/vdpa.h>
> > > >  #include <uapi/linux/virtio_config.h>
> > > > @@ -64,6 +65,13 @@ struct vduse_vdpa {
> > > >       struct vduse_dev *dev;
> > > >  };
> > > >
> > > > +struct vduse_iotlb_mem {
> > > > +     unsigned long iova;
> > > > +     unsigned long npages;
> > > > +     struct page **pages;
> > > > +     struct mm_struct *mm;
> > > > +};
> > > > +
> > > >  struct vduse_dev {
> > > >       struct vduse_vdpa *vdev;
> > > >       struct device *dev;
> > > > @@ -95,6 +103,8 @@ struct vduse_dev {
> > > >       u8 status;
> > > >       u32 vq_num;
> > > >       u32 vq_align;
> > > > +     struct vduse_iotlb_mem *iotlb_mem;
> > > > +     struct mutex mem_lock;
> > > >  };
> > > >
> > > >  struct vduse_dev_msg {
> > > > @@ -917,6 +927,100 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
> > > >       return ret;
> > > >  }
> > > >
> > > > +static int vduse_dev_dereg_iotlb_mem(struct vduse_dev *dev,
> > > > +                                  u64 iova, u64 size)
> > > > +{
> > > > +     int ret;
> > > > +
> > > > +     mutex_lock(&dev->mem_lock);
> > > > +     ret = -ENOENT;
> > > > +     if (!dev->iotlb_mem)
> > > > +             goto unlock;
> > > > +
> > > > +     ret = -EINVAL;
> > > > +     if (dev->iotlb_mem->iova != iova || size != dev->domain->bounce_size)
> > > > +             goto unlock;
> > > > +
> > > > +     vduse_domain_remove_user_bounce_pages(dev->domain);
> > > > +     unpin_user_pages(dev->iotlb_mem->pages, dev->iotlb_mem->npages);
> > >
> > > I notice you don't mark the pages dirty. This is going to be a problem.
> > >
> >
> > Thanks for pointing out this, I will use unpin_user_pages_dirty_lock() instead.
> >
> > > > +     atomic64_sub(dev->iotlb_mem->npages, &dev->iotlb_mem->mm->pinned_vm);
> > > > +     mmdrop(dev->iotlb_mem->mm);
> > > > +     vfree(dev->iotlb_mem->pages);
> > > > +     kfree(dev->iotlb_mem);
> > > > +     dev->iotlb_mem = NULL;
> > > > +     ret = 0;
> > > > +unlock:
> > > > +     mutex_unlock(&dev->mem_lock);
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static int vduse_dev_reg_iotlb_mem(struct vduse_dev *dev,
> > > > +                                u64 iova, u64 uaddr, u64 size)
> > > > +{
> > > > +     struct page **page_list = NULL;
> > > > +     struct vduse_iotlb_mem *mem = NULL;
> > > > +     long pinned = 0;
> > > > +     unsigned long npages, lock_limit;
> > > > +     int ret;
> > > > +
> > > > +     if (size != dev->domain->bounce_size ||
> > > > +         iova != 0 || uaddr & ~PAGE_MASK)
> > > > +             return -EINVAL;
> > > > +
> > > > +     mutex_lock(&dev->mem_lock);
> > > > +     ret = -EEXIST;
> > > > +     if (dev->iotlb_mem)
> > > > +             goto unlock;
> > > > +
> > > > +     ret = -ENOMEM;
> > > > +     npages = size >> PAGE_SHIFT;
> > > > +     page_list = vmalloc(array_size(npages,
> > > > +                         sizeof(struct page *)));
> > >
> > > Is this basically trying to do a vmalloc with userspace-controlled size?
> > > That's an easy DOS vector.
> > >
> >
> > We already checked the size before. The size must equal to (64MB >>
> > PAGE_SHIFT) now.
>
> That's not a small amount. Can this be accounted e.g. through cgroups at least?
>

Make sense, will use __vmalloc(__GFP_ACCOUNT) instead.

> > > > +     mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> > > > +     if (!page_list || !mem)
> > > > +             goto unlock;
> > > > +
> > > > +     mmap_read_lock(current->mm);
> > > > +
> > > > +     lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
> > > > +     if (npages + atomic64_read(&current->mm->pinned_vm) > lock_limit)
> > > > +             goto out;
> > > > +
> > > > +     pinned = pin_user_pages(uaddr, npages, FOLL_LONGTERM | FOLL_WRITE,
> > > > +                             page_list, NULL);
> > > > +     if (pinned != npages) {
> > > > +             ret = pinned < 0 ? pinned : -ENOMEM;
> > > > +             goto out;
> > > > +     }
> > >
> > >
> > > This is a popular approach but it's problematic if multiple
> > > devices try to pin the same page.
> >
> > Do you mean the data would be corrupted if multiple devices use the
> > same page as bounce buffer? This is indeed a problem.
>
> No i mean you decrement the lock twice. Question is can two bounce
> buffers share a page?
>

I think we can't. I will find a way to prevent it.

Thanks,
Yongji
