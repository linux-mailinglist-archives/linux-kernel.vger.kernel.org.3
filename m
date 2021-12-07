Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C80D46B570
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhLGIR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:17:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52512 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232243AbhLGIR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638864837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tfh+QsbeI8c1JR4COebwKOvc8pVH47OrkczPHaMTbLA=;
        b=gszwmyMGib3hY//sNNl8jI2bHpNVDq4WRMCUsiLIH5D1nVIlfBFJcXjutqgQcmMWvS9uOc
        x5spHxPzVsLYIfrqYt2qx8+TG8I9dUOGDNFarxi0qIfm+hP4G5H2nc2PEFdl2L8jKIKqQ0
        HEvKMy4v8YrhSJrzyVXwbFbAdsZRFoo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593--NeWXcF1OD-JrpeZXGeILA-1; Tue, 07 Dec 2021 03:13:56 -0500
X-MC-Unique: -NeWXcF1OD-JrpeZXGeILA-1
Received: by mail-ed1-f72.google.com with SMTP id k7-20020aa7c387000000b003e7ed87fb31so10819188edq.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 00:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Tfh+QsbeI8c1JR4COebwKOvc8pVH47OrkczPHaMTbLA=;
        b=FKMUGGWCNO0432hlyK8QyP1xHaZy5I01fJN7DEKnO7vRF6dZs/cQ/DpiMDRJQAnO3f
         9iHdWUgE8Vhg8qCsa9LoVaPJiM/hOo1BXux55fQ6OlR04PoC1KL0XDzFifDXZoYkqnPQ
         eniXdq11Qm5vdHl4WKsrJjOacpJxx2VHNJiOLDJkGdy9GNebdsX2elD59EMLbbCC8xcp
         HATIX8g+WDYjFWAFx1SVxtr+NRhehmHSSPvcGPNTcqprG/2Q49Rj6Ac62nFOHcs89V4k
         a9PAYUItnHW/DdmuFA0s/t842vhu6vKfvYJ6+s1vYUH/r3EeOFHS6K27/zYB9rCsiILI
         sMAg==
X-Gm-Message-State: AOAM533CIxNKBkvdK419Efn9CsTQW2C/FhZ/+BQUZeOhL8hlXgjKBKtN
        L4poXgoH/M2jq912SjNZdLEg5CaBB1hf31i0yxm55F5z7A31l5jo2CLi6JYzF81DAxgzmgQUEcl
        POJ9fEZB6pP6yJSkzYLFy64NX
X-Received: by 2002:a17:907:97cd:: with SMTP id js13mr49671356ejc.357.1638864835237;
        Tue, 07 Dec 2021 00:13:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwkLJFFjVjY3FRN1uhVjLJGZguhtCSutl5YZnvuynKj2YXvkZ7hKACHe+2K6EpHxaXmI2R1aQ==
X-Received: by 2002:a17:907:97cd:: with SMTP id js13mr49671335ejc.357.1638864835028;
        Tue, 07 Dec 2021 00:13:55 -0800 (PST)
Received: from redhat.com ([2a0e:1c80:7::36])
        by smtp.gmail.com with ESMTPSA id a13sm9482177edk.29.2021.12.07.00.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 00:13:54 -0800 (PST)
Date:   Tue, 7 Dec 2021 03:13:50 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] virtio: make sure legacy pci device gain 32bit-pfn vq
Message-ID: <20211207031217-mutt-send-email-mst@kernel.org>
References: <b50fff4d-9f05-76b3-eba7-91241c351751@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b50fff4d-9f05-76b3-eba7-91241c351751@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 03:51:45PM +0800, 王贇 wrote:
> We observed issues like:
>   virtio-pci 0000:14:00.0: platform bug: legacy virtio-mmio must
>   not be used with RAM above 0x4000GB
> 
> when we have a legacy pci device which desired 32bit-pfn vq
> but gain 64bit-pfn instead, lead into the failure of probe.
> 
> vring_use_dma_api() is playing the key role in here, to help the
> allocation process understand which kind of vq it should alloc,
> however, it failed to take care the legacy pci device, which only
> have 32bit feature flag and can never have VIRTIO_F_ACCESS_PLATFORM
> setted.
> 
> This patch introduce force_dma flag to help vring_use_dma_api()
> understanding the requirement better, to avoid the failing.
> 
> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>

This will break configs where the device appears behind
a virtual iommu, so this won't fly.
Just make your device support 1.0, eh?

> ---
>  drivers/virtio/virtio_pci_legacy.c | 10 ++++++++++
>  drivers/virtio/virtio_ring.c       |  3 +++
>  include/linux/virtio.h             |  1 +
>  3 files changed, 14 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_pci_legacy.c
> b/drivers/virtio/virtio_pci_legacy.c
> index d62e983..11f2ebf 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -263,6 +263,16 @@ int virtio_pci_legacy_probe(struct virtio_pci_device
> *vp_dev)
>  	vp_dev->setup_vq = setup_vq;
>  	vp_dev->del_vq = del_vq;
> 
> +	/*
> +	 * The legacy pci device requre 32bit-pfn vq,
> +	 * or setup_vq() will failed.
> +	 *
> +	 * Thus we make sure vring_use_dma_api() will
> +	 * return true during the allocation by marking
> +	 * force_dma here.
> +	 */
> +	vp_dev->vdev.force_dma = true;
> +
>  	return 0;
> 
>  err_iomap:
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 3035bb6..6562e01 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -245,6 +245,9 @@ static inline bool virtqueue_use_indirect(struct
> virtqueue *_vq,
> 
>  static bool vring_use_dma_api(struct virtio_device *vdev)
>  {
> +	if (vdev->force_dma)
> +		return true;
> +
>  	if (!virtio_has_dma_quirk(vdev))
>  		return true;
> 
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 41edbc0..a4eb29d 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -109,6 +109,7 @@ struct virtio_device {
>  	bool failed;
>  	bool config_enabled;
>  	bool config_change_pending;
> +	bool force_dma;
>  	spinlock_t config_lock;
>  	spinlock_t vqs_list_lock; /* Protects VQs list access */
>  	struct device dev;
> -- 
> 1.8.3.1

