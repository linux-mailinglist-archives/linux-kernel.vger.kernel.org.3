Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF27246F277
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241733AbhLIRyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:54:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234197AbhLIRyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639072228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cReUUZLQNrboD+IZcjBNbt6Kq531IoiXK2tkShuHR78=;
        b=D/blPJdY9HpuoKmm3h+4cnbmf9200EL8WviSC/eF9JDt9qCFbFLKf7XOkE4UEUnl4ujeh2
        sG1uwfeGC2qCEtWddCO9hmMIotI9i2vyQuaur1JgHF9VdvnZcRUXEESMrtGEln8iQWN1BW
        JcFEVycKvhDrYEhGCwYgbkcHYJYZT34=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-zvMeGRnUP2yQIj5Umf_u6g-1; Thu, 09 Dec 2021 12:50:26 -0500
X-MC-Unique: zvMeGRnUP2yQIj5Umf_u6g-1
Received: by mail-wm1-f71.google.com with SMTP id ay17-20020a05600c1e1100b0033f27b76819so3493127wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 09:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cReUUZLQNrboD+IZcjBNbt6Kq531IoiXK2tkShuHR78=;
        b=Na2BfEch+4BM8ew2WzUvtvohEFpSVcRgXhMe2zgJzUmLWSTl6Ejg7mj8q4bL4RvkD0
         KkBUjXRYptVwRYJ/vN5wtSAzcgXBpKY7+Kojb8KDlVnygulxrntehnBeEHE6ZSJoZhi7
         Av2AXSlBJL4IA8MV+ThcipmDaLSM//yLgWUZVCfLdrFFx9mJ2pl+hBXvjRFrtPjW82Xn
         hxSnd9TZ5Bdre39JlZ4s+FZPxxlahc3IpRQHUoSUcK9FI0GhA8PD/wCrgkp/yc7yFbT8
         mSejJGWzac5v8n/SfFMccivw2X0p5Ytu7iankVp9G2SJHhAK9h5Wq4bAmLbnwMyDZsVM
         OA6Q==
X-Gm-Message-State: AOAM532rO0g1cIjCtQtiY1/hNHhXEsfblbZtCRzt+KILnYIqvmerYAUY
        qOfkQ8IJpi9np0K5lVfxMZDKZEzJSebCCz7EuX5dUy/xmEaQH4XJoSoYiQb08h/xvIkFAai8ayW
        z9lcDCqfBWb/HPKKlnnMzE8nW
X-Received: by 2002:a05:600c:282:: with SMTP id 2mr9287659wmk.91.1639072225686;
        Thu, 09 Dec 2021 09:50:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1Q1ta3quvHK6VV8iOM3qPpFpOU9+4sLknPpYdPHvNEssS7b1tD5wHRrpRQoopsdw+QzPdhA==
X-Received: by 2002:a05:600c:282:: with SMTP id 2mr9287632wmk.91.1639072225451;
        Thu, 09 Dec 2021 09:50:25 -0800 (PST)
Received: from redhat.com ([2.55.18.120])
        by smtp.gmail.com with ESMTPSA id b6sm9934160wmq.45.2021.12.09.09.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 09:50:24 -0800 (PST)
Date:   Thu, 9 Dec 2021 12:50:20 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] virtio: make sure legacy pci device gain 32bit-pfn vq
Message-ID: <20211209124542-mutt-send-email-mst@kernel.org>
References: <b50fff4d-9f05-76b3-eba7-91241c351751@linux.alibaba.com>
 <20211207031217-mutt-send-email-mst@kernel.org>
 <8bbfd029-d969-4632-cb8e-482481d65a2f@linux.alibaba.com>
 <20211208021947-mutt-send-email-mst@kernel.org>
 <dfb712d7-1186-1496-9fcc-a72e23c3409b@linux.alibaba.com>
 <20211208060115-mutt-send-email-mst@kernel.org>
 <a5b62e3c-5c24-dc8f-f7a3-027a67ef3bb2@linux.alibaba.com>
 <20211209013833-mutt-send-email-mst@kernel.org>
 <22c1f3f1-beab-83cb-c7ce-d61a970d0f0e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22c1f3f1-beab-83cb-c7ce-d61a970d0f0e@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 04:26:47PM +0800, 王贇 wrote:
> 
> 
> 在 2021/12/9 下午2:40, Michael S. Tsirkin 写道:
> [snip]
> > > > > Besides, I've checked that patch but it can't address our issue, we actually
> > > > > have this legacy pci device on arm platform, and the memory layout is
> > > > > unfriendly since allocation rarely providing page-address below 44bit, we
> > > > > understand the virtio-iommu case should not do force dma, while we don't
> > > > > have that so it's just working fine.
> > > > > 
> > > > > Regards,
> > > > > Michael Wang
> > > > 
> > > > Hmm wait a sec is it a physical device or a hypervisor?
> > > > If a physical one then doesn't it need VIRTIO_F_ORDER_PLATFORM
> > > > on ARM?
> > > 
> > > The PCI device is virtual, I can't see how VIRTIO_F_ORDER_PLATFORM help
> > > address this issue, legacy pci config is 32bit but it's 36, seems like will
> > > never be included?
> > > 
> > > Regards,
> > > Michael Wang
> > 
> > Oh, if the device is virtual then I think you should just update it please.
> > virtio 0.X is architecturally limited to small VMs,
> > if your hypervisor supports more it should emulate virtio 1.0.
> 
> I see, nice to confirm the proper approach, although we don't have that
> option on the desk :-P

Don't see why, a stronger justification will be needed before everyone
takes on the maintainance burden of maintaining hacks like this.  If we
make an exception here this opens floodgates for everyone too lazy to
add virtio 1 support to instead push hacks at the linux level.


> So as long as we don't have any iommu enabled, the force dma approach could
> be safe, is this correct?
> 
> Regards,
> Michael Wang

Not unless there's an API at the DMA API level that guarantees DMA
addresses are physical addresses.

> > 
> > 
> > 
> > > > 
> > > > 
> > > > 
> > > > > > 
> > > > > > 
> > > > > > > > 
> > > > > > > > > ---
> > > > > > > > >      drivers/virtio/virtio_pci_legacy.c | 10 ++++++++++
> > > > > > > > >      drivers/virtio/virtio_ring.c       |  3 +++
> > > > > > > > >      include/linux/virtio.h             |  1 +
> > > > > > > > >      3 files changed, 14 insertions(+)
> > > > > > > > > 
> > > > > > > > > diff --git a/drivers/virtio/virtio_pci_legacy.c
> > > > > > > > > b/drivers/virtio/virtio_pci_legacy.c
> > > > > > > > > index d62e983..11f2ebf 100644
> > > > > > > > > --- a/drivers/virtio/virtio_pci_legacy.c
> > > > > > > > > +++ b/drivers/virtio/virtio_pci_legacy.c
> > > > > > > > > @@ -263,6 +263,16 @@ int virtio_pci_legacy_probe(struct virtio_pci_device
> > > > > > > > > *vp_dev)
> > > > > > > > >      	vp_dev->setup_vq = setup_vq;
> > > > > > > > >      	vp_dev->del_vq = del_vq;
> > > > > > > > > 
> > > > > > > > > +	/*
> > > > > > > > > +	 * The legacy pci device requre 32bit-pfn vq,
> > > > > > > > > +	 * or setup_vq() will failed.
> > > > > > > > > +	 *
> > > > > > > > > +	 * Thus we make sure vring_use_dma_api() will
> > > > > > > > > +	 * return true during the allocation by marking
> > > > > > > > > +	 * force_dma here.
> > > > > > > > > +	 */
> > > > > > > > > +	vp_dev->vdev.force_dma = true;
> > > > > > > > > +
> > > > > > > > >      	return 0;
> > > > > > > > > 
> > > > > > > > >      err_iomap:
> > > > > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > > > > index 3035bb6..6562e01 100644
> > > > > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > > > > @@ -245,6 +245,9 @@ static inline bool virtqueue_use_indirect(struct
> > > > > > > > > virtqueue *_vq,
> > > > > > > > > 
> > > > > > > > >      static bool vring_use_dma_api(struct virtio_device *vdev)
> > > > > > > > >      {
> > > > > > > > > +	if (vdev->force_dma)
> > > > > > > > > +		return true;
> > > > > > > > > +
> > > > > > > > >      	if (!virtio_has_dma_quirk(vdev))
> > > > > > > > >      		return true;
> > > > > > > > > 
> > > > > > > > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > > > > > > > index 41edbc0..a4eb29d 100644
> > > > > > > > > --- a/include/linux/virtio.h
> > > > > > > > > +++ b/include/linux/virtio.h
> > > > > > > > > @@ -109,6 +109,7 @@ struct virtio_device {
> > > > > > > > >      	bool failed;
> > > > > > > > >      	bool config_enabled;
> > > > > > > > >      	bool config_change_pending;
> > > > > > > > > +	bool force_dma;
> > > > > > > > >      	spinlock_t config_lock;
> > > > > > > > >      	spinlock_t vqs_list_lock; /* Protects VQs list access */
> > > > > > > > >      	struct device dev;
> > > > > > > > > -- 
> > > > > > > > > 1.8.3.1

