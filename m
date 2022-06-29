Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE5155FADA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbiF2InH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiF2InF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:43:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D618106
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656492183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GlGCypZ1cQvv3V+v5q9PQcrqSY8WL1ipwnqeNBFmu7E=;
        b=IIqyJ0HH3tQnZrWSofMZC0ETonb6qATlgAhC1tv8Q+Kv6ys49u7xCe/odfr63+pZpnLUPC
        aEISi9vTieyzRonlzBREzgIpXa25gH8fD7nLLPWhPaW4yOperN2Il5NMQWp3b3PhNOlVYa
        GoiIp7+s4JuUxFrzap9F3OB+G6qNyv4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-fKNGCei2Nkin5WlURfx4ZQ-1; Wed, 29 Jun 2022 04:43:00 -0400
X-MC-Unique: fKNGCei2Nkin5WlURfx4ZQ-1
Received: by mail-wm1-f71.google.com with SMTP id n15-20020a05600c4f8f00b0039c3e76d646so8386768wmq.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GlGCypZ1cQvv3V+v5q9PQcrqSY8WL1ipwnqeNBFmu7E=;
        b=qAp2cPqlpvYe4t65qa3FKRBDT7TuvBFnFGfKnxn4oRl0KXnccfZ055hf/Qc2UPur2z
         w9S0G1kSRzLoIjAJIgxVrVVm9ocWvInS0keN4p54DPPLMTvgBNXedze3y/v5PDbb6i69
         +DkvudWBp2g1uHmoZmQX+jTa+pXXVggk+6C3VwCdFIhTyMBiVHc0Ikt/I8cDGX0oS1Zq
         czCSQd+7Yc5ZUs9OjP1utzDpb3ETAlI/rJ+GR0/uyqfkvJrlo5fE2co/sKIYDMwg2XrW
         gUKD12vE3lhau5IvN7PmA7ViRU15B6TskdwCxvUpSXHjivCyEn0xDZsVX5x9Je4PalUT
         LzcQ==
X-Gm-Message-State: AJIora8LOuaWEvvbAPqdaT0v78tSiOoYFaQv67WPZQTImDa+S7L/3nq5
        sKdc2Ary0zh4yFxJFiKFfVsfg+J8nSB/uIFzx0mNQqUJvoSm9+dHXGgZwZg49Xw52LddxKSn28W
        fIAVyY/JY9IRuMlmdCkGlYq2i
X-Received: by 2002:a5d:6d46:0:b0:21b:933d:7950 with SMTP id k6-20020a5d6d46000000b0021b933d7950mr1852050wri.679.1656492179498;
        Wed, 29 Jun 2022 01:42:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uIEG67vGMX2iL8I9wiTWD5Lhbc4JZvMuvX48MEPvoxGxQdvBECJ+sJEgCSzEzGIw7mI5Hmbg==
X-Received: by 2002:a5d:6d46:0:b0:21b:933d:7950 with SMTP id k6-20020a5d6d46000000b0021b933d7950mr1852030wri.679.1656492179238;
        Wed, 29 Jun 2022 01:42:59 -0700 (PDT)
Received: from redhat.com ([2.52.23.204])
        by smtp.gmail.com with ESMTPSA id t3-20020a0560001a4300b0021b9cc87aa9sm16130444wry.111.2022.06.29.01.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 01:42:58 -0700 (PDT)
Date:   Wed, 29 Jun 2022 04:42:54 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] vduse: Support registering userspace memory for IOTLB
Message-ID: <20220629043539-mutt-send-email-mst@kernel.org>
References: <20220629082541.118-1-xieyongji@bytedance.com>
 <20220629082541.118-6-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629082541.118-6-xieyongji@bytedance.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 04:25:40PM +0800, Xie Yongji wrote:
> Introduce two ioctls: VDUSE_IOTLB_REG_UMEM and
> VDUSE_IOTLB_DEREG_UMEM to support registering
> and de-registering userspace memory for IOTLB
> in virtio-vdpa case.
> 
> Now it only supports registering userspace memory
> for IOTLB as bounce buffer.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 138 +++++++++++++++++++++++++++++
>  include/uapi/linux/vduse.h         |  28 ++++++
>  2 files changed, 166 insertions(+)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index c47a5d9765cf..7b2ea7612da9 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -21,6 +21,7 @@
>  #include <linux/uio.h>
>  #include <linux/vdpa.h>
>  #include <linux/nospec.h>
> +#include <linux/sched/mm.h>
>  #include <uapi/linux/vduse.h>
>  #include <uapi/linux/vdpa.h>
>  #include <uapi/linux/virtio_config.h>
> @@ -64,6 +65,13 @@ struct vduse_vdpa {
>  	struct vduse_dev *dev;
>  };
>  
> +struct vduse_iotlb_mem {
> +	unsigned long iova;
> +	unsigned long npages;
> +	struct page **pages;
> +	struct mm_struct *mm;
> +};
> +
>  struct vduse_dev {
>  	struct vduse_vdpa *vdev;
>  	struct device *dev;
> @@ -95,6 +103,8 @@ struct vduse_dev {
>  	u8 status;
>  	u32 vq_num;
>  	u32 vq_align;
> +	struct vduse_iotlb_mem *iotlb_mem;
> +	struct mutex mem_lock;
>  };
>  
>  struct vduse_dev_msg {
> @@ -917,6 +927,100 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
>  	return ret;
>  }
>  
> +static int vduse_dev_dereg_iotlb_mem(struct vduse_dev *dev,
> +				     u64 iova, u64 size)
> +{
> +	int ret;
> +
> +	mutex_lock(&dev->mem_lock);
> +	ret = -ENOENT;
> +	if (!dev->iotlb_mem)
> +		goto unlock;
> +
> +	ret = -EINVAL;
> +	if (dev->iotlb_mem->iova != iova || size != dev->domain->bounce_size)
> +		goto unlock;
> +
> +	vduse_domain_remove_user_bounce_pages(dev->domain);
> +	unpin_user_pages(dev->iotlb_mem->pages, dev->iotlb_mem->npages);

I notice you don't mark the pages dirty. This is going to be a problem.

> +	atomic64_sub(dev->iotlb_mem->npages, &dev->iotlb_mem->mm->pinned_vm);
> +	mmdrop(dev->iotlb_mem->mm);
> +	vfree(dev->iotlb_mem->pages);
> +	kfree(dev->iotlb_mem);
> +	dev->iotlb_mem = NULL;
> +	ret = 0;
> +unlock:
> +	mutex_unlock(&dev->mem_lock);
> +	return ret;
> +}
> +
> +static int vduse_dev_reg_iotlb_mem(struct vduse_dev *dev,
> +				   u64 iova, u64 uaddr, u64 size)
> +{
> +	struct page **page_list = NULL;
> +	struct vduse_iotlb_mem *mem = NULL;
> +	long pinned = 0;
> +	unsigned long npages, lock_limit;
> +	int ret;
> +
> +	if (size != dev->domain->bounce_size ||
> +	    iova != 0 || uaddr & ~PAGE_MASK)
> +		return -EINVAL;
> +
> +	mutex_lock(&dev->mem_lock);
> +	ret = -EEXIST;
> +	if (dev->iotlb_mem)
> +		goto unlock;
> +
> +	ret = -ENOMEM;
> +	npages = size >> PAGE_SHIFT;
> +	page_list = vmalloc(array_size(npages,
> +			    sizeof(struct page *)));

Is this basically trying to do a vmalloc with userspace-controlled size?
That's an easy DOS vector.

> +	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> +	if (!page_list || !mem)
> +		goto unlock;
> +
> +	mmap_read_lock(current->mm);
> +
> +	lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
> +	if (npages + atomic64_read(&current->mm->pinned_vm) > lock_limit)
> +		goto out;
> +
> +	pinned = pin_user_pages(uaddr, npages, FOLL_LONGTERM | FOLL_WRITE,
> +				page_list, NULL);
> +	if (pinned != npages) {
> +		ret = pinned < 0 ? pinned : -ENOMEM;
> +		goto out;
> +	}


This is a popular approach but it's problematic if multiple
devices try to pin the same page.
Can this happen here?

> +
> +	ret = vduse_domain_add_user_bounce_pages(dev->domain,
> +						 page_list, pinned);
> +	if (ret)
> +		goto out;
> +
> +	atomic64_add(npages, &current->mm->pinned_vm);
> +
> +	mem->pages = page_list;
> +	mem->npages = pinned;
> +	mem->iova = iova;
> +	mem->mm = current->mm;
> +	mmgrab(current->mm);
> +
> +	dev->iotlb_mem = mem;
> +out:
> +	if (ret && pinned > 0)
> +		unpin_user_pages(page_list, pinned);
> +
> +	mmap_read_unlock(current->mm);
> +unlock:
> +	if (ret) {
> +		vfree(page_list);
> +		kfree(mem);
> +	}
> +	mutex_unlock(&dev->mem_lock);
> +	return ret;
> +}
> +
>  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  			    unsigned long arg)
>  {
> @@ -943,6 +1047,16 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  		if (entry.start > entry.last)
>  			break;
>  
> +		if (domain->bounce_map && dev->iotlb_mem) {
> +			ret = -EEXIST;
> +			if (entry.start >= 0 &&
> +			    entry.last < domain->bounce_size)
> +				break;
> +
> +			if (entry.start < domain->bounce_size)
> +				entry.start = domain->bounce_size;
> +		}
> +
>  		spin_lock(&domain->iotlb_lock);
>  		map = vhost_iotlb_itree_first(domain->iotlb,
>  					      entry.start, entry.last);
> @@ -1102,6 +1216,28 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  		ret = 0;
>  		break;
>  	}
> +	case VDUSE_IOTLB_REG_UMEM: {
> +		struct vduse_iotlb_umem umem;
> +
> +		ret = -EFAULT;
> +		if (copy_from_user(&umem, argp, sizeof(umem)))
> +			break;
> +
> +		ret = vduse_dev_reg_iotlb_mem(dev, umem.iova,
> +					      umem.uaddr, umem.size);
> +		break;
> +	}
> +	case VDUSE_IOTLB_DEREG_UMEM: {
> +		struct vduse_iotlb_umem umem;
> +
> +		ret = -EFAULT;
> +		if (copy_from_user(&umem, argp, sizeof(umem)))
> +			break;
> +
> +		ret = vduse_dev_dereg_iotlb_mem(dev, umem.iova,
> +						umem.size);
> +		break;
> +	}
>  	default:
>  		ret = -ENOIOCTLCMD;
>  		break;
> @@ -1114,6 +1250,7 @@ static int vduse_dev_release(struct inode *inode, struct file *file)
>  {
>  	struct vduse_dev *dev = file->private_data;
>  
> +	vduse_dev_dereg_iotlb_mem(dev, 0, dev->domain->bounce_size);
>  	spin_lock(&dev->msg_lock);
>  	/* Make sure the inflight messages can processed after reconncection */
>  	list_splice_init(&dev->recv_list, &dev->send_list);
> @@ -1176,6 +1313,7 @@ static struct vduse_dev *vduse_dev_create(void)
>  		return NULL;
>  
>  	mutex_init(&dev->lock);
> +	mutex_init(&dev->mem_lock);
>  	spin_lock_init(&dev->msg_lock);
>  	INIT_LIST_HEAD(&dev->send_list);
>  	INIT_LIST_HEAD(&dev->recv_list);
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index c201b7a77c2c..1b17391e228f 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -227,6 +227,34 @@ struct vduse_iotlb_info {
>  /* Get IOTLB information, e.g. bounce buffer size */
>  #define VDUSE_IOTLB_GET_INFO    _IOR(VDUSE_BASE, 0x18, struct vduse_iotlb_info)
>  
> +/**
> + * struct vduse_iotlb_umem - userspace memory configuration
> + * @uaddr: start address of userspace memory, it must be aligned to page size
> + * @iova: IOVA of userspace memory, it must be equal to bounce iova returned
> + *        by VDUSE_IOTLB_GET_INFO now
> + * @size: size of userspace memory, it must be equal to bounce size returned
> + *        by VDUSE_IOTLB_GET_INFO now
> + * @reserved: for future use, needs to be initialized to zero

You should check that it's 0 in that case, otherwise userspace
will conveniently forget.

> + *
> + * Structure used by VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM
> + * ioctls to register/de-register userspace memory for IOTLB.
> + */
> +struct vduse_iotlb_umem {
> +	__u64 uaddr;
> +	__u64 iova;
> +	__u64 size;
> +	__u64 reserved[3];
> +};
> +
> +/*
> + * Register userspace memory for IOTLB. Now we only support registering
> + * userspace memory as bounce buffer.
> + */
> +#define VDUSE_IOTLB_REG_UMEM	_IOW(VDUSE_BASE, 0x19, struct vduse_iotlb_umem)
> +
> +/* De-register the userspace memory. Caller should set iova and size field. */
> +#define VDUSE_IOTLB_DEREG_UMEM	_IOW(VDUSE_BASE, 0x1a, struct vduse_iotlb_umem)
> +
>  /* The control messages definition for read(2)/write(2) on /dev/vduse/$NAME */
>  
>  /**
> -- 
> 2.20.1

