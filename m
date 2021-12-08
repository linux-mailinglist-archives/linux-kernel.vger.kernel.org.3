Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA6946CE55
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 08:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbhLHH0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 02:26:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50331 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235777AbhLHH0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 02:26:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638948186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3thlSuxgxJVb1tUf+MaBSf1hCp/SSFCI7BQN+d2CnYY=;
        b=SCGAfoRFUQef5y/AAGfqzizGqObi5AUmoAFubqFRe0nRQDc+TD36ay13G1WEWF9qr3QQf3
        kJEtJQ8Ke7W52V7JabrWy20ZFoAz5tcoLdiYbgvUwAkHp/ubAiaiQHjKDOmezGmc9OOQZe
        pvMLWMaEjXvATjjw+tcTTTq54+MgoeY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-369-0xqDp8XYOyC-CaudOpM3Pg-1; Wed, 08 Dec 2021 02:23:05 -0500
X-MC-Unique: 0xqDp8XYOyC-CaudOpM3Pg-1
Received: by mail-ed1-f70.google.com with SMTP id s12-20020a50ab0c000000b003efdf5a226fso1344783edc.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 23:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3thlSuxgxJVb1tUf+MaBSf1hCp/SSFCI7BQN+d2CnYY=;
        b=2CGbI+pFku1W5I+Y2Pu1EBpSqJaKtdLtnHpjbCu+MEBCUIJmon5tZFiAY6srfN6sL8
         wG0nsnVVpTPNy1xcEW0TB3ITwOIRFxBeE064c8Uuiz094TmLHwxiE7aY5EZgtj5HNJQr
         HWwjmdd2lRv1eQgy+gtMpGeibiCfso5NMVQjRJ9jhXiHl3x/tSfmB5lz4W9Pp83iKaOW
         gYfVmdBfBqEchL3Dh7aooR1XOc29rbKEcq6ufUkZ4Mkj/dXgNGtGiqWXMITttQ0ie3qY
         TbXogm9MDvUFdCNNwvxKv+/6RFTBEFzm1H1FvC6XTUtQ3EPOl8T14KRUyWMUP02Sq9xX
         OXqg==
X-Gm-Message-State: AOAM533x+Im2rV4rdijjMHAe7V9rYadpuSiY/PsDaBdEZgKLSGj79Qvf
        Y4481pP7W2dtR92N92E0DvIMN7K85k7EhLAfOQJHdna/6OTqP2jsR8tKKucHWJQAmTbfgnM3Fwa
        IUAgQ2Mghj+dRcDlyBwh9Grn1
X-Received: by 2002:a17:906:b304:: with SMTP id n4mr5534802ejz.116.1638948184419;
        Tue, 07 Dec 2021 23:23:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx8fXmI2eQ4qLExw30n20BX0hhCuV0j8jCtUu6YqJCm4I3Lf9fKB5w67aZxdmFwHaxkpaof4Q==
X-Received: by 2002:a17:906:b304:: with SMTP id n4mr5534779ejz.116.1638948184203;
        Tue, 07 Dec 2021 23:23:04 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:107e:ebdb:5cc6:c351:b05:514f])
        by smtp.gmail.com with ESMTPSA id jg32sm1059703ejc.43.2021.12.07.23.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 23:23:03 -0800 (PST)
Date:   Wed, 8 Dec 2021 02:23:00 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] virtio: make sure legacy pci device gain 32bit-pfn vq
Message-ID: <20211208021947-mutt-send-email-mst@kernel.org>
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

By the way, there is a bug in the error message. Want to fix that?


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

