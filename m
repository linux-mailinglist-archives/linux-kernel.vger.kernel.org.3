Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F0346D1A8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhLHLMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:12:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58356 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232143AbhLHLMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638961748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B444APunhjQQI7ewweOzGaGNLCo2wF23Z1jHaRUgWMM=;
        b=XBFFtt+oo9B73ZiWfukcDiv8B/+DDYEPqYSaCX892Qc//skudafaS+LE0jrXPW7MA1sTWf
        rmd9WwFcUsL52hjRs3AqEnDJ2yLUEHYYiUPuDxLiuZz5qEL6k/7/t0CWOrv8HCXDpJqPBh
        Nwsy4kleVsM3PwGi5LhoO1S6WtM2GXw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-mYGi-1_mPieFa6-EkxgiOA-1; Wed, 08 Dec 2021 06:09:06 -0500
X-MC-Unique: mYGi-1_mPieFa6-EkxgiOA-1
Received: by mail-ed1-f70.google.com with SMTP id b15-20020aa7c6cf000000b003e7cf0f73daso1780420eds.22
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 03:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=B444APunhjQQI7ewweOzGaGNLCo2wF23Z1jHaRUgWMM=;
        b=RWjdXhkokH1qL/CJ7oqyzaccyNAL2cJF6tz9Fs25LPbzu3ExhFPv0sITJYPAOnhRwB
         p+MR4IIPX03jLn/bwNJZx2vzftEe51/+xWHMVSR2vALoqGQFsvhJTEqlWwGSs5dhZa+J
         Z6Z9TIpeCa+v+yWoxoQHS9ee0+k5RPTdHjsKMxVB06iGf8ztFY47yP0Yq0R9QzwaxO+3
         xg2VicM9ukZeUWfxg+WHwP5Cey5M5XfmX+B1/Uk5iOgROllGqujfhBaZxOWyQqK5U8lb
         lWUaHLSPXY7TDLOHJX9BI0iORhW05rG5KIbj7vUMUhDJ/TJ+xk+TBhNk23AL87L7jFWH
         x7Ww==
X-Gm-Message-State: AOAM531DOq/0qVwQG9g7Geo5mkT0uPoOuE054KqGw5LZ+2cK+SgiA8hJ
        rNBLEi8tOnxPb6n1Ut/pVm9+w5IhqimeXbNTrKBB3Sxm6U8qGfCOpvauRrbHebS0wMd8NUE9UT5
        PVK6Pv3nmc5gFJ4N08tMUiEP1
X-Received: by 2002:a17:906:3b54:: with SMTP id h20mr6540135ejf.468.1638961745786;
        Wed, 08 Dec 2021 03:09:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzh9GMkBKKw7RyCq/4YuJ3MnnteCYuC//FXO9Hp9hK7sQEDVB83XOPsN2aHFE3+S8gTgOzaHA==
X-Received: by 2002:a17:906:3b54:: with SMTP id h20mr6540100ejf.468.1638961745442;
        Wed, 08 Dec 2021 03:09:05 -0800 (PST)
Received: from redhat.com ([147.161.9.141])
        by smtp.gmail.com with ESMTPSA id s16sm1758274edt.30.2021.12.08.03.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 03:09:02 -0800 (PST)
Date:   Wed, 8 Dec 2021 06:08:58 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] virtio: make sure legacy pci device gain 32bit-pfn vq
Message-ID: <20211208060115-mutt-send-email-mst@kernel.org>
References: <b50fff4d-9f05-76b3-eba7-91241c351751@linux.alibaba.com>
 <20211207031217-mutt-send-email-mst@kernel.org>
 <8bbfd029-d969-4632-cb8e-482481d65a2f@linux.alibaba.com>
 <20211208021947-mutt-send-email-mst@kernel.org>
 <dfb712d7-1186-1496-9fcc-a72e23c3409b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dfb712d7-1186-1496-9fcc-a72e23c3409b@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:04:19PM +0800, 王贇 wrote:
> 
> 
> 在 2021/12/8 下午3:23, Michael S. Tsirkin 写道:
> > On Tue, Dec 07, 2021 at 05:09:56PM +0800, 王贇 wrote:
> > > 
> > > 
> > > 在 2021/12/7 下午4:13, Michael S. Tsirkin 写道:
> > > > On Tue, Dec 07, 2021 at 03:51:45PM +0800, 王贇 wrote:
> > > > > We observed issues like:
> > > > >     virtio-pci 0000:14:00.0: platform bug: legacy virtio-mmio must
> > > > >     not be used with RAM above 0x4000GB
> > > > > 
> > > > > when we have a legacy pci device which desired 32bit-pfn vq
> > > > > but gain 64bit-pfn instead, lead into the failure of probe.
> > > > > 
> > > > > vring_use_dma_api() is playing the key role in here, to help the
> > > > > allocation process understand which kind of vq it should alloc,
> > > > > however, it failed to take care the legacy pci device, which only
> > > > > have 32bit feature flag and can never have VIRTIO_F_ACCESS_PLATFORM
> > > > > setted.
> > > > > 
> > > > > This patch introduce force_dma flag to help vring_use_dma_api()
> > > > > understanding the requirement better, to avoid the failing.
> > > > > 
> > > > > Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> > > > 
> > > > This will break configs where the device appears behind
> > > > a virtual iommu, so this won't fly.
> > > > Just make your device support 1.0, eh?
> > > 
> > > Hi, Michael
> > > 
> > > Thanks for the comment, unfortunately modify device is not an option for us
> > > :-(
> > > 
> > > Is there any idea on how to solve this issue properly?
> > > 
> > > Regards,
> > > Michael Wang
> > 
> > By the way, there is a bug in the error message. Want to fix that?
> 
> Could you please provide more detail about the bug? We'd like to help fixing
> it :-)

virtio-pci 0000:14:00.0: platform bug: legacy virtio-mmio must ...

should be virtio-pci not virtio-mmio



> Besides, I've checked that patch but it can't address our issue, we actually
> have this legacy pci device on arm platform, and the memory layout is
> unfriendly since allocation rarely providing page-address below 44bit, we
> understand the virtio-iommu case should not do force dma, while we don't
> have that so it's just working fine.
> 
> Regards,
> Michael Wang

Hmm wait a sec is it a physical device or a hypervisor?
If a physical one then doesn't it need VIRTIO_F_ORDER_PLATFORM
on ARM?



> > 
> > 
> > > > 
> > > > > ---
> > > > >    drivers/virtio/virtio_pci_legacy.c | 10 ++++++++++
> > > > >    drivers/virtio/virtio_ring.c       |  3 +++
> > > > >    include/linux/virtio.h             |  1 +
> > > > >    3 files changed, 14 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/virtio/virtio_pci_legacy.c
> > > > > b/drivers/virtio/virtio_pci_legacy.c
> > > > > index d62e983..11f2ebf 100644
> > > > > --- a/drivers/virtio/virtio_pci_legacy.c
> > > > > +++ b/drivers/virtio/virtio_pci_legacy.c
> > > > > @@ -263,6 +263,16 @@ int virtio_pci_legacy_probe(struct virtio_pci_device
> > > > > *vp_dev)
> > > > >    	vp_dev->setup_vq = setup_vq;
> > > > >    	vp_dev->del_vq = del_vq;
> > > > > 
> > > > > +	/*
> > > > > +	 * The legacy pci device requre 32bit-pfn vq,
> > > > > +	 * or setup_vq() will failed.
> > > > > +	 *
> > > > > +	 * Thus we make sure vring_use_dma_api() will
> > > > > +	 * return true during the allocation by marking
> > > > > +	 * force_dma here.
> > > > > +	 */
> > > > > +	vp_dev->vdev.force_dma = true;
> > > > > +
> > > > >    	return 0;
> > > > > 
> > > > >    err_iomap:
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > index 3035bb6..6562e01 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -245,6 +245,9 @@ static inline bool virtqueue_use_indirect(struct
> > > > > virtqueue *_vq,
> > > > > 
> > > > >    static bool vring_use_dma_api(struct virtio_device *vdev)
> > > > >    {
> > > > > +	if (vdev->force_dma)
> > > > > +		return true;
> > > > > +
> > > > >    	if (!virtio_has_dma_quirk(vdev))
> > > > >    		return true;
> > > > > 
> > > > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > > > index 41edbc0..a4eb29d 100644
> > > > > --- a/include/linux/virtio.h
> > > > > +++ b/include/linux/virtio.h
> > > > > @@ -109,6 +109,7 @@ struct virtio_device {
> > > > >    	bool failed;
> > > > >    	bool config_enabled;
> > > > >    	bool config_change_pending;
> > > > > +	bool force_dma;
> > > > >    	spinlock_t config_lock;
> > > > >    	spinlock_t vqs_list_lock; /* Protects VQs list access */
> > > > >    	struct device dev;
> > > > > -- 
> > > > > 1.8.3.1

