Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAA757B37C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbiGTJIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbiGTJIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:08:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B00E65006F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658308121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7oILNlTSBMlh/gH2dKDrMjz2QtOfJWLTXJW3TwWpCbw=;
        b=CbtFgKlXd2f9KkmkL77rWpb03pMgCi6kSP4r9R0sBQWLyUouLEL6zN+kcdZXt29Nm1kCqu
        4+gi03xnP1W1DA5zfZpbXuuBgB2p6HbPLxxoHNUPOFNXjQyeu4PTAV+z/3NjtbYIY7XbgD
        KOkuf7+I0esC0iAp1S0P7PX1TL1rC3k=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-jGnqSQQBMzGXZwJ4v8LmXg-1; Wed, 20 Jul 2022 05:08:40 -0400
X-MC-Unique: jGnqSQQBMzGXZwJ4v8LmXg-1
Received: by mail-lf1-f70.google.com with SMTP id d41-20020a0565123d2900b00489ed34ed26so6549916lfv.15
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7oILNlTSBMlh/gH2dKDrMjz2QtOfJWLTXJW3TwWpCbw=;
        b=ECKGn7V8q2AmYcr2RmuTWNLHM8I6ttzxKZ51spnUhUAWEbud90xhqmQLjCluKnHAi3
         vV4B0csfR7GLsOGrdn3/2uQ1gUkACVGhDmaD+YLw+dWv1Lm0wcvzXEXebnDZVBEr9PUF
         ZZd4DrWseYfiCv/kO0ArqXiOtk9dYddsA+Nvsb2icJxrxycI6NEvKTkxvD0WFdp6NO2W
         0Ojk09NAsjIJYkfaF7bPIXDjwahnYjnmKEjSTTnDvuLrj/JY5ucRJ3lKsT2XOjmgDuGI
         dUKEYO/R5gktmaEQuD5+Gv2mFhgfu2K1KEx0AabFdVLYxo2uozEO4cyA5C5bTIJ8fIW/
         ddDw==
X-Gm-Message-State: AJIora/n+dHjzMU1ABtsXj7kTHKZoUGwhc20Yufill0yqPUpsaMiaaEk
        oSdenGm7vnxJpZRw/u4NSiINYQlHtkekzDqsmLk9d6pgIqZz/U7kOpT4RXkUVQrxoyEQ+ZWy4Ze
        I9RMs6kifp2jidDbRqZGCHEhVWk5XygfQ0kLjBwYd
X-Received: by 2002:a05:6512:313a:b0:489:caea:7e27 with SMTP id p26-20020a056512313a00b00489caea7e27mr20155949lfd.397.1658308117693;
        Wed, 20 Jul 2022 02:08:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uP3MgRzr0/5nsB7PzeZw8pmmLpL+0+4spvO27QV/6r7awqw7CmPbBMPu0/5OuF28xrhOC8dh3GqGc9SvWIDHs=
X-Received: by 2002:a05:6512:313a:b0:489:caea:7e27 with SMTP id
 p26-20020a056512313a00b00489caea7e27mr20155939lfd.397.1658308117377; Wed, 20
 Jul 2022 02:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220720044144.90-1-xieyongji@bytedance.com> <20220720044144.90-5-xieyongji@bytedance.com>
In-Reply-To: <20220720044144.90-5-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 20 Jul 2022 17:08:26 +0800
Message-ID: <CACGkMEvTw966i2cB4u9_-SfrWG2yj7VqTXHak8YmOqpjcGfSDw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] vduse: Support registering userspace memory for
 IOVA regions
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     mst <mst@redhat.com>, Liu Xiaodong <xiaodong.liu@intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 12:42 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> Introduce two ioctls: VDUSE_IOTLB_REG_UMEM and
> VDUSE_IOTLB_DEREG_UMEM to support registering
> and de-registering userspace memory for IOVA
> regions.
>
> Now it only supports registering userspace memory
> for bounce buffer region in virtio-vdpa case.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 141 +++++++++++++++++++++++++++++
>  include/uapi/linux/vduse.h         |  23 +++++
>  2 files changed, 164 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 3bc27de58f46..eedff0a3885a 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -21,6 +21,8 @@
>  #include <linux/uio.h>
>  #include <linux/vdpa.h>
>  #include <linux/nospec.h>
> +#include <linux/vmalloc.h>
> +#include <linux/sched/mm.h>
>  #include <uapi/linux/vduse.h>
>  #include <uapi/linux/vdpa.h>
>  #include <uapi/linux/virtio_config.h>
> @@ -64,6 +66,13 @@ struct vduse_vdpa {
>         struct vduse_dev *dev;
>  };
>
> +struct vduse_umem {
> +       unsigned long iova;
> +       unsigned long npages;
> +       struct page **pages;
> +       struct mm_struct *mm;
> +};
> +
>  struct vduse_dev {
>         struct vduse_vdpa *vdev;
>         struct device *dev;
> @@ -95,6 +104,8 @@ struct vduse_dev {
>         u8 status;
>         u32 vq_num;
>         u32 vq_align;
> +       struct vduse_umem *umem;
> +       struct mutex mem_lock;
>  };
>
>  struct vduse_dev_msg {
> @@ -917,6 +928,102 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
>         return ret;
>  }
>
> +static int vduse_dev_dereg_umem(struct vduse_dev *dev,
> +                               u64 iova, u64 size)
> +{
> +       int ret;
> +
> +       mutex_lock(&dev->mem_lock);
> +       ret = -ENOENT;
> +       if (!dev->umem)
> +               goto unlock;
> +
> +       ret = -EINVAL;
> +       if (dev->umem->iova != iova || size != dev->domain->bounce_size)
> +               goto unlock;
> +
> +       vduse_domain_remove_user_bounce_pages(dev->domain);
> +       unpin_user_pages_dirty_lock(dev->umem->pages,
> +                                   dev->umem->npages, true);
> +       atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
> +       mmdrop(dev->umem->mm);
> +       vfree(dev->umem->pages);
> +       kfree(dev->umem);
> +       dev->umem = NULL;
> +       ret = 0;
> +unlock:
> +       mutex_unlock(&dev->mem_lock);
> +       return ret;
> +}
> +
> +static int vduse_dev_reg_umem(struct vduse_dev *dev,
> +                             u64 iova, u64 uaddr, u64 size)
> +{
> +       struct page **page_list = NULL;
> +       struct vduse_umem *umem = NULL;
> +       long pinned = 0;
> +       unsigned long npages, lock_limit;
> +       int ret;
> +
> +       if (!dev->domain->bounce_map ||
> +           size != dev->domain->bounce_size ||
> +           iova != 0 || uaddr & ~PAGE_MASK)
> +               return -EINVAL;
> +
> +       mutex_lock(&dev->mem_lock);
> +       ret = -EEXIST;
> +       if (dev->umem)
> +               goto unlock;
> +
> +       ret = -ENOMEM;
> +       npages = size >> PAGE_SHIFT;
> +       page_list = __vmalloc(array_size(npages, sizeof(struct page *)),
> +                             GFP_KERNEL_ACCOUNT);
> +       umem = kzalloc(sizeof(*umem), GFP_KERNEL);
> +       if (!page_list || !umem)
> +               goto unlock;
> +
> +       mmap_read_lock(current->mm);
> +
> +       lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
> +       if (npages + atomic64_read(&current->mm->pinned_vm) > lock_limit)
> +               goto out;
> +
> +       pinned = pin_user_pages(uaddr, npages, FOLL_LONGTERM | FOLL_WRITE,
> +                               page_list, NULL);
> +       if (pinned != npages) {
> +               ret = pinned < 0 ? pinned : -ENOMEM;
> +               goto out;
> +       }
> +
> +       ret = vduse_domain_add_user_bounce_pages(dev->domain,
> +                                                page_list, pinned);
> +       if (ret)
> +               goto out;
> +
> +       atomic64_add(npages, &current->mm->pinned_vm);
> +
> +       umem->pages = page_list;
> +       umem->npages = pinned;
> +       umem->iova = iova;
> +       umem->mm = current->mm;
> +       mmgrab(current->mm);
> +
> +       dev->umem = umem;
> +out:
> +       if (ret && pinned > 0)
> +               unpin_user_pages(page_list, pinned);
> +
> +       mmap_read_unlock(current->mm);
> +unlock:
> +       if (ret) {
> +               vfree(page_list);
> +               kfree(umem);
> +       }
> +       mutex_unlock(&dev->mem_lock);
> +       return ret;
> +}
> +
>  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                             unsigned long arg)
>  {
> @@ -1089,6 +1196,38 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                 ret = vduse_dev_queue_irq_work(dev, &dev->vqs[index].inject);
>                 break;
>         }
> +       case VDUSE_IOTLB_REG_UMEM: {
> +               struct vduse_iova_umem umem;
> +
> +               ret = -EFAULT;
> +               if (copy_from_user(&umem, argp, sizeof(umem)))
> +                       break;
> +
> +               ret = -EINVAL;
> +               if (!is_mem_zero((const char *)umem.reserved,
> +                                sizeof(umem.reserved)))
> +                       break;
> +
> +               ret = vduse_dev_reg_umem(dev, umem.iova,
> +                                        umem.uaddr, umem.size);
> +               break;
> +       }
> +       case VDUSE_IOTLB_DEREG_UMEM: {
> +               struct vduse_iova_umem umem;
> +
> +               ret = -EFAULT;
> +               if (copy_from_user(&umem, argp, sizeof(umem)))
> +                       break;
> +
> +               ret = -EINVAL;
> +               if (!is_mem_zero((const char *)umem.reserved,
> +                                sizeof(umem.reserved)))
> +                       break;
> +
> +               ret = vduse_dev_dereg_umem(dev, umem.iova,
> +                                          umem.size);
> +               break;
> +       }
>         default:
>                 ret = -ENOIOCTLCMD;
>                 break;
> @@ -1101,6 +1240,7 @@ static int vduse_dev_release(struct inode *inode, struct file *file)
>  {
>         struct vduse_dev *dev = file->private_data;
>
> +       vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size);
>         spin_lock(&dev->msg_lock);
>         /* Make sure the inflight messages can processed after reconncection */
>         list_splice_init(&dev->recv_list, &dev->send_list);
> @@ -1163,6 +1303,7 @@ static struct vduse_dev *vduse_dev_create(void)
>                 return NULL;
>
>         mutex_init(&dev->lock);
> +       mutex_init(&dev->mem_lock);
>         spin_lock_init(&dev->msg_lock);
>         INIT_LIST_HEAD(&dev->send_list);
>         INIT_LIST_HEAD(&dev->recv_list);
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index 7cfe1c1280c0..9885e0571f09 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -210,6 +210,29 @@ struct vduse_vq_eventfd {
>   */
>  #define VDUSE_VQ_INJECT_IRQ    _IOW(VDUSE_BASE, 0x17, __u32)
>
> +/**
> + * struct vduse_iova_umem - userspace memory configuration for one IOVA region
> + * @uaddr: start address of userspace memory, it must be aligned to page size
> + * @iova: start of the IOVA region
> + * @size: size of the IOVA region
> + * @reserved: for future use, needs to be initialized to zero
> + *
> + * Structure used by VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM
> + * ioctls to register/de-register userspace memory for IOVA regions
> + */
> +struct vduse_iova_umem {
> +       __u64 uaddr;
> +       __u64 iova;
> +       __u64 size;
> +       __u64 reserved[3];
> +};
> +
> +/* Register userspace memory for IOVA regions */
> +#define VDUSE_IOTLB_REG_UMEM   _IOW(VDUSE_BASE, 0x18, struct vduse_iova_umem)
> +
> +/* De-register the userspace memory. Caller should set iova and size field. */
> +#define VDUSE_IOTLB_DEREG_UMEM _IOW(VDUSE_BASE, 0x19, struct vduse_iova_umem)
> +
>  /* The control messages definition for read(2)/write(2) on /dev/vduse/$NAME */
>
>  /**
> --
> 2.20.1
>

