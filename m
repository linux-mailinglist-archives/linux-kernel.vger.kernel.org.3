Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFD0487051
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345380AbiAGCZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:25:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28559 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345374AbiAGCZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641522304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NdLI+JY15a2+Gt1cY6WpfausBPRh25LVXAMJd9mKg3c=;
        b=icoUFjVhcpBGrEIANTqun+Od2tvnv1vfyF/xZyli/IBbgC0+9SvwsHx0RVIP2UhYAsc9dC
        WsDU8vIz2E2rtg1qBZj56rPnyU+btdWZlY2sO8pltjr2zlYghpfPWgoXnybFf3dOUHMKyk
        oP4J4Ph4ZH7Koh55OrVRDRNEdLW70h0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-ZQBGi6TNOjm6MMaLYK1L-w-1; Thu, 06 Jan 2022 21:25:03 -0500
X-MC-Unique: ZQBGi6TNOjm6MMaLYK1L-w-1
Received: by mail-lf1-f72.google.com with SMTP id g2-20020a19e042000000b00425cfac0e67so1306470lfj.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 18:25:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NdLI+JY15a2+Gt1cY6WpfausBPRh25LVXAMJd9mKg3c=;
        b=sl4O9KL0eP3+d7TCaHIKkAXQd66kTlXlNpRBv4dsaXFT1moKZPUOUSjrsmciQnPZtY
         ujWVe+5gXRxSe8PUtGAPltCwilDEsYF0Oc3tXL7QSS8Qt5/DgVXNvehgBYraBoR8SSH1
         NNZUkPkIL1sglEsKNzqV8ASFTRSeoRuM8jYUSJfW8Up5R8xk+YMFtL/QraVNIZKBKyMF
         3ZU5cvLB20LAnf4s+LXnUnPgcH/82I+k/Ump77Za0uAO2YakYt7eFpqYsRmy27au+HBn
         QOgRJXMStJGWRAA9HOfhwH6cEn+UzEtxfOM8pwRwV2L0FNhzqeLrGvsYl1hxW1ar0qQj
         4veA==
X-Gm-Message-State: AOAM533o0Nhfjl7FUm7qydhSsEFUs6LKJIbuX4w7p1jEfxCzYWCahfjk
        Ydgyw9jsDCrRivVsxAMt0keJu4y3cBM478RHBwoFc000la2MjAjXNVKe8XYtlyb0tQjjw4eMvBE
        1qL0j5UKmUqumc+7ffhuiGa2ZicS3gfh5Opn4W9SK
X-Received: by 2002:a2e:8543:: with SMTP id u3mr45052778ljj.307.1641522301427;
        Thu, 06 Jan 2022 18:25:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQdgl8Lhz6/KjVCb1IwvdC/dDvHzQIuoVfmyd1mtC2fcVs0Fp2KcMCv0CRdLYPdrAELdSHWNAe70sNvp+Z5sg=
X-Received: by 2002:a2e:8543:: with SMTP id u3mr45052762ljj.307.1641522301235;
 Thu, 06 Jan 2022 18:25:01 -0800 (PST)
MIME-Version: 1.0
References: <20220106130046.422417-1-mst@redhat.com>
In-Reply-To: <20220106130046.422417-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 7 Jan 2022 10:24:50 +0800
Message-ID: <CACGkMEtitniJqz0gMp4YY=sf_Nb0v8Z-xXyF9P_rh=+58Sn6Yg@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: mark ring unused on error
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 9:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> A recently added error path does not mark ring unused when exiting on
> OOM, which will lead to BUG on the next entry in debug builds.
>
> TODO: refactor code so we have START_USE and END_USE in the same function.
>
> Fixes: fc6d70f40b3d ("virtio_ring: check desc == NULL when using indirect with packed")
> Cc: "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>
> Cc: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/virtio_ring.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 028b05d44546..962f1477b1fa 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1197,8 +1197,10 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>         if (virtqueue_use_indirect(_vq, total_sg)) {
>                 err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
>                                                     in_sgs, data, gfp);
> -               if (err != -ENOMEM)
> +               if (err != -ENOMEM) {
> +                       END_USE(vq);
>                         return err;
> +               }
>
>                 /* fall back on direct */
>         }
> --
> MST
>

