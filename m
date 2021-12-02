Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE08D465C90
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 04:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355107AbhLBDQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 22:16:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31969 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344910AbhLBDQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 22:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638414759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xVgflJHaF1j7g8uerCAN33DYEdhX1y5Z75xZHZOUsZ0=;
        b=TSA8C+nhJ9HdmtUA0PCtu8GezPfNzBferLUmD4K0VEZaxCpS37IteoFaJQ8/98cMOsjfoA
        e1v+lDzlZtpt8SKjfirh2QxtcisFf0jwILb1RgqRBtp1dURz0NV9d1hF6YCj/KX8iWPeaW
        mtj3BehC+4wbb8JTWysXRKOD5pcrEYI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-HYVjlgVINB6gyRAWxpCP2g-1; Wed, 01 Dec 2021 22:12:37 -0500
X-MC-Unique: HYVjlgVINB6gyRAWxpCP2g-1
Received: by mail-lf1-f72.google.com with SMTP id d26-20020ac244da000000b00417e1d212a2so5522913lfm.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 19:12:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xVgflJHaF1j7g8uerCAN33DYEdhX1y5Z75xZHZOUsZ0=;
        b=oG8ts7WSO2Qk1uWl2iu0NZoPAn2jjVaoTKtpG5ODKGSmyM7nMIuyvr7QdmHEfD3KSF
         BOk11GJ7hN73s7H9sWBtOA6+adYWUU8OXub1cLjIx7y37gi2cFrzHXylmbkOOZwNxbCt
         wmXejtKdyCBSK7Cu5BxNR1bV3+nQmb6zIPzDOdi883ZxSROSQlJckQFRwIO/jlRcKHrk
         rwvVejHc8r8/yhZlKz2ZKW0mxR8KMgiDCq5rQEADPTtgQtfAECfYPSzbxrNw/9yzzoox
         mkbIjgIREd/bFOCycdb+T4jXLpFxjCpP2Pr5FWDUduVSLBgvfNYUKJSKrudaFBX0r/O7
         bgtw==
X-Gm-Message-State: AOAM532ivc0/62EKhMpT0kvfOsY3l8UkwSQxAHVy7Bk0yXOLoQVKhwtB
        9kC+4QXLXj0g9ZksnERDsnRtxomWeBpegq8+gv82vH0eyDfVEH6M9+PfNYqdIe60W69wgpgTSWB
        c0J+kjbPGbwJ7hFb40nDsmcj7Ew7qts1R2hWIGyNV
X-Received: by 2002:a05:6512:685:: with SMTP id t5mr9795900lfe.84.1638414756391;
        Wed, 01 Dec 2021 19:12:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyw3w5n79ljGY0VlIaSf9/IlrBtw0r+CsnB6lzMaAIT72SuPP/eOUmVRb7AsYoSC0+rAFwjT0tZSpLJXhNsoDU=
X-Received: by 2002:a05:6512:685:: with SMTP id t5mr9795887lfe.84.1638414756236;
 Wed, 01 Dec 2021 19:12:36 -0800 (PST)
MIME-Version: 1.0
References: <20211201112018.25276-1-will@kernel.org>
In-Reply-To: <20211201112018.25276-1-will@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 2 Dec 2021 11:12:25 +0800
Message-ID: <CACGkMEtPaJQQxYOCP2TXXuOdtA5TLCxJQVyjNV6xzsTvycbdog@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: Fix querying of maximum DMA mapping size for
 virtio device
To:     Will Deacon <will@kernel.org>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Quentin Perret <qperret@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 7:20 PM Will Deacon <will@kernel.org> wrote:
>
> virtio_max_dma_size() returns the maximum DMA mapping size of the virtio
> device by querying dma_max_mapping_size() for the device when the DMA
> API is in use for the vring. Unfortunately, the device passed is
> initialised by register_virtio_device() and does not inherit the DMA
> configuration from its parent, resulting in SWIOTLB errors when bouncing
> is enabled and the default 256K mapping limit (IO_TLB_SEGSIZE) is not
> respected:
>
>   | virtio-pci 0000:00:01.0: swiotlb buffer is full (sz: 294912 bytes), total 1024 (slots), used 725 (slots)
>
> Follow the pattern used elsewhere in the virtio_ring code when calling
> into the DMA layer and pass the parent device to dma_max_mapping_size()
> instead.
>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Quentin Perret <qperret@google.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Will Deacon <will@kernel.org>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 6d2614e34470..028b05d44546 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -268,7 +268,7 @@ size_t virtio_max_dma_size(struct virtio_device *vdev)
>         size_t max_segment_size = SIZE_MAX;
>
>         if (vring_use_dma_api(vdev))
> -               max_segment_size = dma_max_mapping_size(&vdev->dev);
> +               max_segment_size = dma_max_mapping_size(vdev->dev.parent);
>
>         return max_segment_size;
>  }
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>

