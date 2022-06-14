Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0E454AAD8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238986AbiFNHpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiFNHpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:45:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4586E3B3F6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655192732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=orMFX7sAwj4N76FdyVTuQqp9a2204zsl+inQH7qNPHA=;
        b=MxxCjdVIhSM4IY/XCxfmuWbvmWRbxIFQS3uappsNHrQ1ML3mqzVUukamcKfJeCBqnx+V44
        62YvgfVqTCmzxJhBj4IF9LONeskPhgGC87TRd1CXUxMbssoWYMTYMDmQGfw5SRsdGUvBQh
        qD2DOMBcGBalB9eIi1Js4+dzNJ/RX4U=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-U9Sw_3vZM2mC2Xh3q-i1rQ-1; Tue, 14 Jun 2022 03:45:31 -0400
X-MC-Unique: U9Sw_3vZM2mC2Xh3q-i1rQ-1
Received: by mail-lf1-f70.google.com with SMTP id bi42-20020a0565120eaa00b0047dc53b46edso3665647lfb.21
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=orMFX7sAwj4N76FdyVTuQqp9a2204zsl+inQH7qNPHA=;
        b=Li29JUZOjIG3ntZfaI7k9oV9GzAOMTm00Rt12hTCOPvSJBUx66Slo1qpiHVJR78gRc
         9N09HXzPyji9kNJjWQwuXCZ9NzYNhss5fLYS4BjMMsFddMix00bs2gUwp2CTf6+HQmty
         XWOMD/1A3pyIzyG2/6Qpn/Z3zdtjf4ocvHnK5Sq16hcAunvF/Aydv/U8pXIIDiiCoZDN
         D7aGESv903oeNSfNrLIDqyCSjUnh1MIFL1WqmzYShz4vIOysM3CaAmki1niC7FoBG84+
         oXDHqFXtwSzwNx5XBXj41KQna6cRK6EHVKXujlL8MTLY3zTrGJLR0RbuOr+om+95orGr
         BHSg==
X-Gm-Message-State: AJIora/+ko5EW+s/qAwggQFtUvCGQfXerFE/BeBAjE552zH49dI3hy2C
        Wzr4jmy43Y9nZ43GaOn8JoNMIiJqoRKGNNNrAIwNh7qHpZdlBB8LAtBT+ggUYVdMME0bRnq4mEE
        1UQ3586z8TY6/wD1GrCmE0mxSxh2bWgmJ8Aso8uJh
X-Received: by 2002:a05:6512:13a5:b0:47d:c1d9:dea8 with SMTP id p37-20020a05651213a500b0047dc1d9dea8mr2275935lfa.442.1655192729447;
        Tue, 14 Jun 2022 00:45:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sP4ThGHBh+rx6/j6YJRgbFZ9qwlO0cabekuZQwGQLLYfn8j+BSmsHNSnyW4hvIlIFh8tNwCghyemuRXTJjHn0=
X-Received: by 2002:a05:6512:13a5:b0:47d:c1d9:dea8 with SMTP id
 p37-20020a05651213a500b0047dc1d9dea8mr2275922lfa.442.1655192729190; Tue, 14
 Jun 2022 00:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220613100433-mutt-send-email-mst@kernel.org> <20220614053737.82453-1-huangjie.albert@bytedance.com>
In-Reply-To: <20220614053737.82453-1-huangjie.albert@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 14 Jun 2022 15:45:17 +0800
Message-ID: <CACGkMEsnvj3MR8oRu-M2D9gTD2sDUJSWkMdjdm6GPum_KUY47w@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring : keep used_wrap_counter in vq->last_used_idx
To:     Albert Huang <huangjie.albert@bytedance.com>
Cc:     mst <mst@redhat.com>, yuanzhu@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 1:38 PM Albert Huang
<huangjie.albert@bytedance.com> wrote:
>
> From: "huangjie.albert" <huangjie.albert@bytedance.com>
>
> the used_wrap_counter and the vq->last_used_idx may get
> out of sync if they are separate assignment=EF=BC=8Cand interrupt
> might use an incorrect value to check for the used index.
>
> for example:OOB access
> ksoftirqd may consume the packet and it will call:
> virtnet_poll
>         -->virtnet_receive
>                 -->virtqueue_get_buf_ctx
>                         -->virtqueue_get_buf_ctx_packed
> and in virtqueue_get_buf_ctx_packed:
>
> vq->last_used_idx +=3D vq->packed.desc_state[id].num;
> if (unlikely(vq->last_used_idx >=3D vq->packed.vring.num)) {
>          vq->last_used_idx -=3D vq->packed.vring.num;
>          vq->packed.used_wrap_counter ^=3D 1;
> }
>
> if at the same time, there comes a vring interrupt=EF=BC=8Cin vring_inter=
rupt:
> we will call:
> vring_interrupt
>         -->more_used
>                 -->more_used_packed
>                         -->is_used_desc_packed
> in is_used_desc_packed, the last_used_idx maybe >=3D vq->packed.vring.num=
.
> so this could case a memory out of bounds bug.
>
> this patch is to keep the used_wrap_counter in vq->last_used_idx
> so we can get the correct value to check for used index in interrupt.
>
> Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> ---
>  drivers/virtio/virtio_ring.c     | 60 ++++++++++++++++++--------------
>  include/uapi/linux/virtio_ring.h |  6 ++++
>  2 files changed, 40 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 13a7348cedff..35c3750e89e1 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -111,7 +111,12 @@ struct vring_virtqueue {
>         /* Number we've added since last sync. */
>         unsigned int num_added;
>
> -       /* Last used index we've seen. */
> +       /* Last used index  we've seen.
> +        * for split ring, it just contains last used index
> +        * for packed ring, it not only contains last used index, but als=
o
> +        * used_wrap_counter, the VRING_PACKED_USED_INDEX_F_WRAP_CTR is
> +        * the bit shift in last_used_idx
> +        */
>         u16 last_used_idx;
>
>         /* Hint for event idx: already triggered no need to disable. */
> @@ -154,9 +159,6 @@ struct vring_virtqueue {
>                         /* Driver ring wrap counter. */
>                         bool avail_wrap_counter;
>
> -                       /* Device ring wrap counter. */
> -                       bool used_wrap_counter;
> -
>                         /* Avail used flags. */
>                         u16 avail_used_flags;
>
> @@ -1397,6 +1399,9 @@ static inline bool is_used_desc_packed(const struct=
 vring_virtqueue *vq,
>         bool avail, used;
>         u16 flags;
>
> +       if (idx >=3D vq->packed.vring.num)
> +               return false;

I wonder if we can avoid this trick, more below.

> +
>         flags =3D le16_to_cpu(vq->packed.vring.desc[idx].flags);
>         avail =3D !!(flags & (1 << VRING_PACKED_DESC_F_AVAIL));
>         used =3D !!(flags & (1 << VRING_PACKED_DESC_F_USED));
> @@ -1406,8 +1411,12 @@ static inline bool is_used_desc_packed(const struc=
t vring_virtqueue *vq,
>
>  static inline bool more_used_packed(const struct vring_virtqueue *vq)
>  {
> -       return is_used_desc_packed(vq, vq->last_used_idx,
> -                       vq->packed.used_wrap_counter);
> +       u16 last_used;
> +       bool used_wrap_counter;
> +
> +       last_used =3D vq->last_used_idx & ~(1 << VRING_PACKED_USED_INDEX_=
F_WRAP_CTR);
> +       used_wrap_counter =3D !!((vq->last_used_idx) >> VRING_PACKED_USED=
_INDEX_F_WRAP_CTR);
> +       return is_used_desc_packed(vq, last_used, used_wrap_counter);
>  }
>
>  static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> @@ -1416,6 +1425,7 @@ static void *virtqueue_get_buf_ctx_packed(struct vi=
rtqueue *_vq,
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>         u16 last_used, id;
> +       bool used_wrap_counter;
>         void *ret;
>
>         START_USE(vq);
> @@ -1434,7 +1444,8 @@ static void *virtqueue_get_buf_ctx_packed(struct vi=
rtqueue *_vq,
>         /* Only get used elements after they have been exposed by host. *=
/
>         virtio_rmb(vq->weak_barriers);
>
> -       last_used =3D vq->last_used_idx;
> +       used_wrap_counter =3D !!((vq->last_used_idx >> VRING_PACKED_USED_=
INDEX_F_WRAP_CTR));
> +       last_used =3D (vq->last_used_idx) & (~(1 << VRING_PACKED_USED_IND=
EX_F_WRAP_CTR));
>         id =3D le16_to_cpu(vq->packed.vring.desc[last_used].id);
>         *len =3D le32_to_cpu(vq->packed.vring.desc[last_used].len);
>
> @@ -1451,12 +1462,15 @@ static void *virtqueue_get_buf_ctx_packed(struct =
virtqueue *_vq,
>         ret =3D vq->packed.desc_state[id].data;
>         detach_buf_packed(vq, id, ctx);
>
> -       vq->last_used_idx +=3D vq->packed.desc_state[id].num;
> -       if (unlikely(vq->last_used_idx >=3D vq->packed.vring.num)) {
> -               vq->last_used_idx -=3D vq->packed.vring.num;
> -               vq->packed.used_wrap_counter ^=3D 1;
> +       last_used +=3D vq->packed.desc_state[id].num;
> +       if (unlikely(last_used >=3D vq->packed.vring.num)) {

Can we tweak the math here to avoid the out of bound result?

> +               last_used -=3D vq->packed.vring.num;
> +               used_wrap_counter ^=3D 1;
>         }
>
> +       last_used =3D (last_used | (used_wrap_counter << VRING_PACKED_DES=
C_F_USED));
> +       vq->last_used_idx =3D last_used;
> +
>         /*
>          * If we expect an interrupt for the next entry, tell host
>          * by writing event index and flush out the write before
> @@ -1465,9 +1479,7 @@ static void *virtqueue_get_buf_ctx_packed(struct vi=
rtqueue *_vq,
>         if (vq->packed.event_flags_shadow =3D=3D VRING_PACKED_EVENT_FLAG_=
DESC)
>                 virtio_store_mb(vq->weak_barriers,
>                                 &vq->packed.vring.driver->off_wrap,
> -                               cpu_to_le16(vq->last_used_idx |
> -                                       (vq->packed.used_wrap_counter <<
> -                                        VRING_PACKED_EVENT_F_WRAP_CTR)))=
;
> +                               cpu_to_le16(vq->last_used_idx));
>
>         LAST_ADD_TIME_INVALID(vq);
>
> @@ -1499,9 +1511,7 @@ static unsigned int virtqueue_enable_cb_prepare_pac=
ked(struct virtqueue *_vq)
>
>         if (vq->event) {
>                 vq->packed.vring.driver->off_wrap =3D
> -                       cpu_to_le16(vq->last_used_idx |
> -                               (vq->packed.used_wrap_counter <<
> -                                VRING_PACKED_EVENT_F_WRAP_CTR));
> +                       cpu_to_le16(vq->last_used_idx);
>                 /*
>                  * We need to update event offset and event wrap
>                  * counter first before updating event flags.
> @@ -1518,8 +1528,7 @@ static unsigned int virtqueue_enable_cb_prepare_pac=
ked(struct virtqueue *_vq)
>         }
>
>         END_USE(vq);
> -       return vq->last_used_idx | ((u16)vq->packed.used_wrap_counter <<
> -                       VRING_PACKED_EVENT_F_WRAP_CTR);
> +       return vq->last_used_idx;
>  }
>
>  static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
> @@ -1550,9 +1559,9 @@ static bool virtqueue_enable_cb_delayed_packed(stru=
ct virtqueue *_vq)
>         if (vq->event) {
>                 /* TODO: tune this threshold */
>                 bufs =3D (vq->packed.vring.num - vq->vq.num_free) * 3 / 4=
;
> -               wrap_counter =3D vq->packed.used_wrap_counter;
> +               wrap_counter =3D !!(vq->last_used_idx >> VRING_PACKED_USE=
D_INDEX_F_WRAP_CTR);
>
> -               used_idx =3D vq->last_used_idx + bufs;
> +               used_idx =3D (vq->last_used_idx & ~(1 << VRING_PACKED_USE=
D_INDEX_F_WRAP_CTR)) + bufs;
>                 if (used_idx >=3D vq->packed.vring.num) {
>                         used_idx -=3D vq->packed.vring.num;
>                         wrap_counter ^=3D 1;
> @@ -1582,9 +1591,9 @@ static bool virtqueue_enable_cb_delayed_packed(stru=
ct virtqueue *_vq)
>          */
>         virtio_mb(vq->weak_barriers);
>
> -       if (is_used_desc_packed(vq,
> -                               vq->last_used_idx,
> -                               vq->packed.used_wrap_counter)) {
> +       wrap_counter =3D !!(vq->last_used_idx >> VRING_PACKED_USED_INDEX_=
F_WRAP_CTR);
> +       used_idx =3D (vq->last_used_idx & ~(1 << VRING_PACKED_USED_INDEX_=
F_WRAP_CTR));
> +       if (is_used_desc_packed(vq, used_idx, wrap_counter)) {
>                 END_USE(vq);
>                 return false;
>         }
> @@ -1689,7 +1698,7 @@ static struct virtqueue *vring_create_virtqueue_pac=
ked(
>         vq->notify =3D notify;
>         vq->weak_barriers =3D weak_barriers;
>         vq->broken =3D true;
> -       vq->last_used_idx =3D 0;
> +       vq->last_used_idx =3D 0 | (1 << VRING_PACKED_USED_INDEX_F_WRAP_CT=
R);
>         vq->event_triggered =3D false;
>         vq->num_added =3D 0;
>         vq->packed_ring =3D true;
> @@ -1720,7 +1729,6 @@ static struct virtqueue *vring_create_virtqueue_pac=
ked(
>
>         vq->packed.next_avail_idx =3D 0;
>         vq->packed.avail_wrap_counter =3D 1;
> -       vq->packed.used_wrap_counter =3D 1;
>         vq->packed.event_flags_shadow =3D 0;
>         vq->packed.avail_used_flags =3D 1 << VRING_PACKED_DESC_F_AVAIL;
>
> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio=
_ring.h
> index 476d3e5c0fe7..96bcc4d52fce 100644
> --- a/include/uapi/linux/virtio_ring.h
> +++ b/include/uapi/linux/virtio_ring.h
> @@ -77,6 +77,12 @@
>   */
>  #define VRING_PACKED_EVENT_F_WRAP_CTR  15
>
> +
> +/*
> + * used wrap Counter bit shift in vq->last_used_idx for packed ring
> + */
> +#define VRING_PACKED_USED_INDEX_F_WRAP_CTR  15

Let's simply reuse VRING_PACKED_EVENT_F_WRAP_CTR ?

Thanks

> +
>  /* We support indirect buffer descriptors */
>  #define VIRTIO_RING_F_INDIRECT_DESC    28
>
> --
> 2.31.1
>

