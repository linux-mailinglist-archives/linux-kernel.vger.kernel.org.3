Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409E849760A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 23:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbiAWWkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 17:40:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38057 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229944AbiAWWkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 17:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642977619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0pIY2RGPU7KzoGfuQNFBNefJk1n5vPd00tDnIcgg4Dg=;
        b=YwxVEsV57fMrfv1SN5dH9IO4/3wPe25g1qxFG+X+pHW69XLqVrp5w3tSTkxcrtPKXbhrKk
        SmtKvNDoEy8BCsl7lOa7Ufp81Zpzge0kGtz+9O71TfwK4WmN5S8jq6KvnvdXGz6Dev4sBy
        /j4VepHmvxfDhbRo57Xd2gnXBdb4FWM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-SrWurUCEPWa_zm98K0ox6A-1; Sun, 23 Jan 2022 17:40:17 -0500
X-MC-Unique: SrWurUCEPWa_zm98K0ox6A-1
Received: by mail-wm1-f70.google.com with SMTP id a3-20020a05600c348300b0034a0dfc86aaso13839765wmq.6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 14:40:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0pIY2RGPU7KzoGfuQNFBNefJk1n5vPd00tDnIcgg4Dg=;
        b=bX3nlYrCOm43be5dSXVJ7oKAWuZDvLftdU0RLtrMGKjOshAMd0EbO5Fpk4OxbwkIsI
         wjqHYjvqHBE6oesU/KeoJArWaWySPPXeQV/9SBV2BLBU+OK2FRN4QryZPbjAEM2hUh26
         xJ7tWcSWn1UZJGq5yiyE6Qg3UorBtiQcojw3F7gabfg+uu1vSpjBpOWkMVeFZbM6WCC8
         mR3fH+SkQp8Sh7W9BUmGX4TB2nXH+YwzlOqVTG9YC58Xf2KGzTmKD0g8AZpE+j55PIbC
         HNPi2y9TEmvR27jBDp+F0n48edS43jrsh+CDxp96dyIEbDYfbwivzGOhgij1wErKbCZa
         46CQ==
X-Gm-Message-State: AOAM5311eNEv4hyPu1ZHXd00u54nLeOlx4oLi0MQs1JQHwIT+LY9AqFU
        fxNTynehH/irh6e9AarjTNRx8AxP1AJ+rKWb7AJVc02rlVI5kPpcUv51FbhLcUapzSB4nCnQln1
        513EtqK5kKqg/RGUntHD0tP7k
X-Received: by 2002:a5d:4604:: with SMTP id t4mr3028635wrq.285.1642977616274;
        Sun, 23 Jan 2022 14:40:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjwwX6XBQA8gamPuGltOrFWIbtbUNwx90Lv8LABa1RXJtgWg+iT3fUgdTQUtIQR89XV0agPQ==
X-Received: by 2002:a5d:4604:: with SMTP id t4mr3028621wrq.285.1642977616041;
        Sun, 23 Jan 2022 14:40:16 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:107d:3855:f057:7883:a28a:5e3c])
        by smtp.gmail.com with ESMTPSA id i8sm19203233wry.45.2022.01.23.14.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 14:40:15 -0800 (PST)
Date:   Sun, 23 Jan 2022 17:40:08 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Peter Hilber <peter.hilber@opensynergy.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v9 09/11] firmware: arm_scmi: Add atomic mode support to
 virtio transport
Message-ID: <20220123172950-mutt-send-email-mst@kernel.org>
References: <20211220195646.44498-10-cristian.marussi@arm.com>
 <20211221140027.41524-1-cristian.marussi@arm.com>
 <f231094a-6f34-3dc1-237d-97218e8fde91@opensynergy.com>
 <20220119122338.GE6113@e120937-lin>
 <2f1ea794-a0b9-2099-edc0-b2aeb3ca6b92@opensynergy.com>
 <20220120150418-mutt-send-email-mst@kernel.org>
 <20220123200254.GF6113@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123200254.GF6113@e120937-lin>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 08:02:54PM +0000, Cristian Marussi wrote:
> I was thinking...keeping the current virtqueue_poll interface, since our
> possible issue arises from the used_index wrapping around exactly on top
> of the same polled index and given that currently the API returns an
> unsigned "opaque" value really carrying just the 16-bit index (and possibly
> the wrap bit as bit15 for packed vq) that is supposed to be fed back as
> it is to the virtqueue_poll() function....
> 
> ...why don't we just keep an internal full fledged per-virtqueue wrap-counter
> and return that as the MSB 16-bit of the opaque value returned by
> virtqueue_prepare_enable_cb and then check it back in virtqueue_poll when the
> opaque is fed back ? (filtering it out from the internal helpers machinery)
> 
> As in the example below the scissors.
> 
> I mean if the internal wrap count is at that point different from the
> one provided to virtqueue_poll() via the opaque poll_idx value previously
> provided, certainly there is something new to fetch without even looking
> at the indexes: at the same time, exposing an opaque index built as
> (wraps << 16 | idx) implicitly 'binds' each index to a specific
> wrap-iteration, so they can be distiguished (..ok until the wrap-count
> upper 16bit wraps too....but...)
> 
> I am not really extremely familiar with the internals of virtio so I
> could be missing something obvious...feel free to insult me :P
> 
> (..and I have not made any perf measurements or consideration at this
> point....nor considered the redundancy of the existent packed
> used_wrap_counter bit...)
> 
> Thanks,
> Cristian
> 
> ----
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 00f64f2f8b72..bda6af121cd7 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -117,6 +117,8 @@ struct vring_virtqueue {
>         /* Last used index we've seen. */
>         u16 last_used_idx;
>  
> +       u16 wraps;
> +
>         /* Hint for event idx: already triggered no need to disable. */
>         bool event_triggered;
>  
> @@ -806,6 +808,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>         ret = vq->split.desc_state[i].data;
>         detach_buf_split(vq, i, ctx);
>         vq->last_used_idx++;
> +       if (unlikely(!vq->last_used_idx))
> +               vq->wraps++;

I wonder whether
               vq->wraps += !vq->last_used_idx;
is faster or slower. No branch but OTOH a dependency.


>         /* If we expect an interrupt for the next entry, tell host
>          * by writing event index and flush out the write before
>          * the read in the next get_buf call. */
> @@ -1508,6 +1512,7 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>         if (unlikely(vq->last_used_idx >= vq->packed.vring.num)) {
>                 vq->last_used_idx -= vq->packed.vring.num;
>                 vq->packed.used_wrap_counter ^= 1;
> +               vq->wraps++;
>         }
>  
>         /*
> @@ -1744,6 +1749,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
>         vq->weak_barriers = weak_barriers;
>         vq->broken = false;
>         vq->last_used_idx = 0;
> +       vq->wraps = 0;
>         vq->event_triggered = false;
>         vq->num_added = 0;
>         vq->packed_ring = true;
> @@ -2092,13 +2098,17 @@ EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
>   */
>  unsigned virtqueue_enable_cb_prepare(struct virtqueue *_vq)
>  {
> +       unsigned last_used_idx;
>         struct vring_virtqueue *vq = to_vvq(_vq);
>  
>         if (vq->event_triggered)
>                 vq->event_triggered = false;
>  
> -       return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) :
> -                                virtqueue_enable_cb_prepare_split(_vq);
> +       last_used_idx = vq->packed_ring ?
> +                       virtqueue_enable_cb_prepare_packed(_vq) :
> +                       virtqueue_enable_cb_prepare_split(_vq);
> +
> +       return VRING_BUILD_OPAQUE(last_used_idx, vq->wraps);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
>  
> @@ -2118,9 +2128,13 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned last_used_idx)
>         if (unlikely(vq->broken))
>                 return false;
>  
> +       if (unlikely(vq->wraps != VRING_GET_WRAPS(last_used_idx)))
> +               return true;
> +
>         virtio_mb(vq->weak_barriers);
> -       return vq->packed_ring ? virtqueue_poll_packed(_vq, last_used_idx) :
> -                                virtqueue_poll_split(_vq, last_used_idx);
> +       return vq->packed_ring ?
> +               virtqueue_poll_packed(_vq, VRING_GET_IDX(last_used_idx)) :
> +                       virtqueue_poll_split(_vq, VRING_GET_IDX(last_used_idx));
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_poll);
>  
> @@ -2245,6 +2259,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>         vq->weak_barriers = weak_barriers;
>         vq->broken = false;
>         vq->last_used_idx = 0;
> +       vq->wraps = 0;
>         vq->event_triggered = false;
>         vq->num_added = 0;
>         vq->use_dma_api = vring_use_dma_api(vdev);
> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> index 476d3e5c0fe7..e6b03017ebd7 100644
> --- a/include/uapi/linux/virtio_ring.h
> +++ b/include/uapi/linux/virtio_ring.h
> @@ -77,6 +77,17 @@
>   */
>  #define VRING_PACKED_EVENT_F_WRAP_CTR  15
>  
> +#define VRING_IDX_MASK                                 GENMASK(15, 0)
> +#define VRING_GET_IDX(opaque)                          \
> +       ((u16)FIELD_GET(VRING_IDX_MASK, (opaque)))
> +
> +#define VRING_WRAPS_MASK                               GENMASK(31, 16)
> +#define VRING_GET_WRAPS(opaque)                                \
> +       ((u16)FIELD_GET(VRING_WRAPS_MASK, (opaque)))
> +
> +#define VRING_BUILD_OPAQUE(idx, wraps)                 \
> +       (FIELD_PREP(VRING_WRAPS_MASK, (wraps)) | ((idx) & VRING_IDX_MASK))
> +
>  /* We support indirect buffer descriptors */
>  #define VIRTIO_RING_F_INDIRECT_DESC    28

Yea I think this patch increases the time it takes to wrap around from
2^16 to 2^32 which seems good enough.
Need some comments to explain the logic.
Would be interesting to see perf data.

-- 
MST

