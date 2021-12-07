Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E41D46B95E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbhLGKsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:48:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235311AbhLGKr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638873868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OJtOGTM6hpba13AFJA6DOM5gH4zdsII7eyxr1fYY86Q=;
        b=SqoVIw4mZtZ6Vkk1kxXcSUSPMTc36uyORq2slQxUuUP2V81ibg45Ex8TkandAydWCqw2DL
        ascU3jNOIUyCENcMGhKOB8ZtfQ0dMfboq5fM0iCO1QSqhcRcudA7Y62xz7Ta/i46smceYU
        uYAtuN0nUjLd5yJ9VIwmMl4H4kQpgqc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-w2LK5OfnMQynrPuIoYWVzg-1; Tue, 07 Dec 2021 05:44:27 -0500
X-MC-Unique: w2LK5OfnMQynrPuIoYWVzg-1
Received: by mail-ed1-f70.google.com with SMTP id a3-20020a05640213c300b003e7d12bb925so11118401edx.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 02:44:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OJtOGTM6hpba13AFJA6DOM5gH4zdsII7eyxr1fYY86Q=;
        b=CbJHBaFOF9trl4OJnNzURdZklgkNVrNvR9HWmPZx4vsywUE7l2swwF8JhmxiFiW0ax
         3EqRzF3BrDNUQG4fCsUkUnwQoy3X3T0H9XOMzNDAh47viD6QlvyRIdoKGh/lcMviqvTk
         VBV7y8O4/7mE1BOvI9BCKdZv9bytGreH1M55IosaOS47Htn6MwrSUEXKIIGyqJSup17Y
         JHtk0yIy4IIAlSD+HT3YEuCE2r7z3kd1DmG0aYG90O19PLPWn/9EuIWaRy8R6JJO81ff
         1LN4WbpiI9aKuiP9xpBSrZCrH19sw+KIlu8hCXQBs4Qi7qwAr9Vd42VYCfENyBr10cIm
         ii8g==
X-Gm-Message-State: AOAM533tJGVPYbuvxriUB9cKRS6oTySUnNzLUzI5ichN7X6fQFoQZ2kZ
        Ic5WkTyIWbnjazvnyuIu/XBggfD/tYZx0NR1YNPlLUygNTr0jJcBwl6WK21SOU+wUYhNaKnyRuR
        GDhWNp4ug9ppGqbZNnReqM0QL
X-Received: by 2002:a05:6402:1e93:: with SMTP id f19mr8065711edf.60.1638873866533;
        Tue, 07 Dec 2021 02:44:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5DkMy9wFULjbVZU5J33CwH+/vEuqydZgEIfpXKY+R1VUt4hgAX2Q0wFWxDoZXGCKF1rme/A==
X-Received: by 2002:a05:6402:1e93:: with SMTP id f19mr8065681edf.60.1638873866246;
        Tue, 07 Dec 2021 02:44:26 -0800 (PST)
Received: from redhat.com ([2a0e:1c80:7::36])
        by smtp.gmail.com with ESMTPSA id j17sm10254172edj.0.2021.12.07.02.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 02:44:25 -0800 (PST)
Date:   Tue, 7 Dec 2021 05:44:21 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] virtio: make sure legacy pci device gain 32bit-pfn vq
Message-ID: <20211207053846-mutt-send-email-mst@kernel.org>
References: <b50fff4d-9f05-76b3-eba7-91241c351751@linux.alibaba.com>
 <20211207031217-mutt-send-email-mst@kernel.org>
 <8bbfd029-d969-4632-cb8e-482481d65a2f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bbfd029-d969-4632-cb8e-482481d65a2f@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 05:09:56PM +0800, 王贇 wrote:
> 
> 
> 在 2021/12/7 下午4:13, Michael S. Tsirkin 写道:
> > On Tue, Dec 07, 2021 at 03:51:45PM +0800, 王贇 wrote:
> > > We observed issues like:
> > >    virtio-pci 0000:14:00.0: platform bug: legacy virtio-mmio must
> > >    not be used with RAM above 0x4000GB
> > > 
> > > when we have a legacy pci device which desired 32bit-pfn vq
> > > but gain 64bit-pfn instead, lead into the failure of probe.
> > > 
> > > vring_use_dma_api() is playing the key role in here, to help the
> > > allocation process understand which kind of vq it should alloc,
> > > however, it failed to take care the legacy pci device, which only
> > > have 32bit feature flag and can never have VIRTIO_F_ACCESS_PLATFORM
> > > setted.
> > > 
> > > This patch introduce force_dma flag to help vring_use_dma_api()
> > > understanding the requirement better, to avoid the failing.
> > > 
> > > Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> > 
> > This will break configs where the device appears behind
> > a virtual iommu, so this won't fly.
> > Just make your device support 1.0, eh?
> 
> Hi, Michael
> 
> Thanks for the comment, unfortunately modify device is not an option for us
> :-(
> 
> Is there any idea on how to solve this issue properly?
> 
> Regards,
> Michael Wang

There's an old idea:
https://www.spinics.net/lists/kernel/msg3248800.html


> > 
> > > ---
> > >   drivers/virtio/virtio_pci_legacy.c | 10 ++++++++++
> > >   drivers/virtio/virtio_ring.c       |  3 +++
> > >   include/linux/virtio.h             |  1 +
> > >   3 files changed, 14 insertions(+)
> > > 
> > > diff --git a/drivers/virtio/virtio_pci_legacy.c
> > > b/drivers/virtio/virtio_pci_legacy.c
> > > index d62e983..11f2ebf 100644
> > > --- a/drivers/virtio/virtio_pci_legacy.c
> > > +++ b/drivers/virtio/virtio_pci_legacy.c
> > > @@ -263,6 +263,16 @@ int virtio_pci_legacy_probe(struct virtio_pci_device
> > > *vp_dev)
> > >   	vp_dev->setup_vq = setup_vq;
> > >   	vp_dev->del_vq = del_vq;
> > > 
> > > +	/*
> > > +	 * The legacy pci device requre 32bit-pfn vq,
> > > +	 * or setup_vq() will failed.
> > > +	 *
> > > +	 * Thus we make sure vring_use_dma_api() will
> > > +	 * return true during the allocation by marking
> > > +	 * force_dma here.
> > > +	 */
> > > +	vp_dev->vdev.force_dma = true;
> > > +
> > >   	return 0;
> > > 
> > >   err_iomap:
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 3035bb6..6562e01 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -245,6 +245,9 @@ static inline bool virtqueue_use_indirect(struct
> > > virtqueue *_vq,
> > > 
> > >   static bool vring_use_dma_api(struct virtio_device *vdev)
> > >   {
> > > +	if (vdev->force_dma)
> > > +		return true;
> > > +
> > >   	if (!virtio_has_dma_quirk(vdev))
> > >   		return true;
> > > 
> > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > index 41edbc0..a4eb29d 100644
> > > --- a/include/linux/virtio.h
> > > +++ b/include/linux/virtio.h
> > > @@ -109,6 +109,7 @@ struct virtio_device {
> > >   	bool failed;
> > >   	bool config_enabled;
> > >   	bool config_change_pending;
> > > +	bool force_dma;
> > >   	spinlock_t config_lock;
> > >   	spinlock_t vqs_list_lock; /* Protects VQs list access */
> > >   	struct device dev;
> > > -- 
> > > 1.8.3.1

