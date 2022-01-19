Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A77493316
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 03:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351050AbiASCpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 21:45:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26316 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344162AbiASCpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 21:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642560317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2QbQg6mxiZtW68ExHgyVdc/QMifv6KYOVGiXP5EWIls=;
        b=YJoLfA/rvI57FrBPt1NlOJ5OJ8wSWZAuB/cHlxPXyntHblWZJLEip03e0dXgTg9YZyLGoU
        OR0SD74FsHuCioYdkBQq8xJOD8YemvOIajLS2zkMfr0lbDm4AQMgwsIULCFuZAXSEc2pb0
        ro+6vCg6XW4MVgVnqOq971xGfbHnL90=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-GvCh6WxRMpeZ5vt4YUeEbQ-1; Tue, 18 Jan 2022 21:45:16 -0500
X-MC-Unique: GvCh6WxRMpeZ5vt4YUeEbQ-1
Received: by mail-lf1-f69.google.com with SMTP id v7-20020a056512048700b0042d99b3a962so513602lfq.23
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 18:45:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2QbQg6mxiZtW68ExHgyVdc/QMifv6KYOVGiXP5EWIls=;
        b=TopnhnIsB3Xf+W6FwdiXxwi77rChZlssV3+T9QbkKgHqdRbLiJRD+UFjsmkQC06A+J
         3PWbnTZGba2i6MOjQT7I8xHrZ9k5phmDwVtP+ol3KjlgWhKQcaXcgl370tW6c3IvO8SP
         AAJHIKurj9xxPoSW1/7Xi9K/waENAnNsLLzKjhY4irnkRPwPg1GPpCz0NN+Pa/M6AQ+T
         H7MNxkcMRJtzBzOnjtZ6036rtcsb0BsZ+SblOWZxe8wiFufHhQkBckvo3RDUcFud1rWz
         Gr8DaDsBLs6zrLawvv9E/8C7waSHDjgyfeqLAn5dcnr24OmljXtkNM3uxTU0qQurrrQk
         aREw==
X-Gm-Message-State: AOAM533gIsAIrgvahXGpYG5y/8g02n2MYX9gY/GqAubaav4iwoUKqcLD
        JLc3VTbFoDw44KD+MaGts3MIasR/wf3XafAX/D2WhETxW1ZPXkJ2RoBVNPi0qvg1RllJ0bR/7rB
        CDwo5224Cmu2y5k4nwNDhp5mYrze+bSZJgUjvq6OV
X-Received: by 2002:a2e:9843:: with SMTP id e3mr21777387ljj.277.1642560314285;
        Tue, 18 Jan 2022 18:45:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzB9BW6WWCim9vDYU4kum1F16AkR869KEeJaKkIEYwrn5RQkE5MqxGYI12cabpygmhempbvUOpSdSvSn6zf90Q=
X-Received: by 2002:a2e:9843:: with SMTP id e3mr21777377ljj.277.1642560314113;
 Tue, 18 Jan 2022 18:45:14 -0800 (PST)
MIME-Version: 1.0
References: <20220118150631.167015-1-sgarzare@redhat.com>
In-Reply-To: <20220118150631.167015-1-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 19 Jan 2022 10:45:03 +0800
Message-ID: <CACGkMEtrH5dy7WxqEg7vNARUu3tsYZBtP8MX7a60VR+ZyWvVrw@mail.gmail.com>
Subject: Re: [PATCH] tools/virtio: fix virtio_test execution
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 11:06 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> virtio_test hangs on __vring_new_virtqueue() because `vqs_list_lock`
> is not initialized.
>
> Let's initialize it in vdev_info_init().
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  tools/virtio/virtio_test.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> index cb3f29c09aff..23f142af544a 100644
> --- a/tools/virtio/virtio_test.c
> +++ b/tools/virtio/virtio_test.c
> @@ -130,6 +130,7 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
>         memset(dev, 0, sizeof *dev);
>         dev->vdev.features = features;
>         INIT_LIST_HEAD(&dev->vdev.vqs);
> +       spin_lock_init(&dev->vdev.vqs_list_lock);
>         dev->buf_size = 1024;
>         dev->buf = malloc(dev->buf_size);
>         assert(dev->buf);
> --
> 2.31.1
>

