Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08884C0A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbiBWDTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiBWDTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:19:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1110E33E86
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645586358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o10+oL16B6fHkAqAM1KRvbz+KhlX2puJg4tawglVFis=;
        b=X+X0TE6YVdT0Ka5v9UGhuT+L/KqzK2qaug3ic9THrguALHvD60jmpAQduemcWQ0LAmSD76
        P77zVPb66iVBL3Bx8vbHksW2Vt/PYmMQQuyrE/mgqCsoFVu0kotrs9E+aqI36Rk27Rkt50
        w4zwVlBWGeIzk7uEkKFyI5S0y7zd23U=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-zTaXhI0gNVCAwGqvANVyZg-1; Tue, 22 Feb 2022 22:19:16 -0500
X-MC-Unique: zTaXhI0gNVCAwGqvANVyZg-1
Received: by mail-lf1-f69.google.com with SMTP id j11-20020a19f50b000000b00443304eab91so3043142lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:19:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=o10+oL16B6fHkAqAM1KRvbz+KhlX2puJg4tawglVFis=;
        b=b7seu0rNncMhAXKBweo3CxpftuUMkIrIQAVgoI48bxmvVhz+LXDxG2CU4NqXRa4wrP
         mxjU7scE10ZtOLipEYnsR0i4Y16Xgcz0NOpShdM3Vir5HWTRb9/e3sAiaxa1NbSHaCdL
         mLCgCIt5Hd8YM/1pS0zcVRKfhRImKSyfz3VCMVM48zxyr59/wxy203Q4wUWumD6tznLv
         6qciGw0Rc0W4OKoxoUeIYt8zKNFzukLvXInIwMjub1ajMuUV4Xi63KjNuItcB5g22pXK
         L3ajJ96arqf1DT4OGI+vB6c9unhHRK0tbypj3kzjzDixCPW/3NtS8UdTTjmpE3NwPCME
         Lssw==
X-Gm-Message-State: AOAM533t+9QmkBz7vxQdG3HCHlreJnm2A/munqKrgzo/ByffsMXYiuI5
        dHKvi+ABqRJ8Ysn4DZq4ouls3tvFZYgzPeFpwQwsILqijRoChjz36IrgnRBnJjoKisPqM+OzKWv
        uAl/mqdPYMqoJl1+x/MnTSKNlWBAS+n7q7wnzHwmq
X-Received: by 2002:a05:6512:3147:b0:443:323d:179d with SMTP id s7-20020a056512314700b00443323d179dmr19712249lfi.98.1645586354933;
        Tue, 22 Feb 2022 19:19:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzC+VckbRDPD22Vw3cVRNOnTu5Dv3fTch6szAQ3aD8AdD7ESb4+dCSn4ACFp0ue/sa1Fe1eo+0wiUKb44UQGJA=
X-Received: by 2002:a05:6512:3147:b0:443:323d:179d with SMTP id
 s7-20020a056512314700b00443323d179dmr19712239lfi.98.1645586354760; Tue, 22
 Feb 2022 19:19:14 -0800 (PST)
MIME-Version: 1.0
References: <20211108081324.14204-1-jasowang@redhat.com>
In-Reply-To: <20211108081324.14204-1-jasowang@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 23 Feb 2022 11:19:03 +0800
Message-ID: <CACGkMEucnZPt_dhaSXCegeFE0gs=dSDfv7CJSq4HCW_4a4XfGg@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: aovid reading flag from the descriptor ring
To:     mst <mst@redhat.com>, jasowang <jasowang@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 8, 2021 at 4:13 PM Jason Wang <jasowang@redhat.com> wrote:
>
> Commit 72b5e8958738 ("virtio-ring: store DMA metadata in desc_extra
> for split virtqueue") tries to make it possible for the driver to not
> read from the descriptor ring to prevent the device from corrupting
> the descriptor ring. But it still read the descriptor flag from the
> descriptor ring during buffer detach.
>
> This patch fixes by always store the descriptor flag no matter whether
> DMA API is used and then we can avoid reading descriptor flag from the
> descriptor ring. This eliminates the possibly of unexpected next
> descriptor caused by the wrong flag (e.g the next flag).
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Michael, any comment for this?

Thanks

> ---
>  drivers/virtio/virtio_ring.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 00f64f2f8b72..28734f4e57d3 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -583,7 +583,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>         }
>         /* Last one doesn't continue. */
>         desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> -       if (!indirect && vq->use_dma_api)
> +       if (!indirect)
>                 vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
>                         ~VRING_DESC_F_NEXT;
>
> @@ -713,7 +713,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>         /* Put back on free list: unmap first-level descriptors and find end */
>         i = head;
>
> -       while (vq->split.vring.desc[i].flags & nextflag) {
> +       while (vq->split.desc_extra[i].flags & nextflag) {
>                 vring_unmap_one_split(vq, i);
>                 i = vq->split.desc_extra[i].next;
>                 vq->vq.num_free++;
> --
> 2.25.1
>

