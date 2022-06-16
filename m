Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5045454DE68
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 11:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359713AbiFPJsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 05:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiFPJse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 05:48:34 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125AD4D603
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 02:48:31 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id h7so556929ila.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 02:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WLHNcZl7kF287ad8mVEK0kZnbE////ZBs6H0knyQDXc=;
        b=LBvxXgE31WRnG96qBjsG+NoZSnddYPBaK2Hv9gKMZO2s7iHaWWSqCcJJJEOJzYrIco
         0l0oaITPaNzi/GlUcegqpfZN8yd/wlLhkN+ihbpWLN3T1sAL9SYTFb8584dDNpfGK98Z
         EzIqJ7waNMZJeyi0e7azojm48ugtMQ98X/bIpSebOJz6OcQGXHGmR28Pp3R5coceTwnN
         TLw39Hfgl4Qwbb9Xj+ol4fvvCxat/MWus0Fq/AdH6q5FujIIAcaqgHcSW0oClowRLtra
         h+fTe3xgqJc+eDwManld61Msqp+dRiNAXUt0Oj1W2+IDyEUQA2svYcf6Ea+iBxYr7Oqy
         /Juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WLHNcZl7kF287ad8mVEK0kZnbE////ZBs6H0knyQDXc=;
        b=Q2qAT9riCOwKZgzep7q7on4ccl05XN43DQmtz48Mtf43X2Cjcal1B9mBAVdS1Ul5Zq
         /blMO9/jyHvKXRJLGIdQTCuNfabHhrk+ZlfdqtEi5b6zcWaNAeeGJE37FNeAs4G2uGrz
         u78hqXcI/hxI/DqiZWjMoHt+FZD71kvh/A3iV4CB0sKuF7KQMsoxo1ipXHSlvc9h87um
         pswlof8R+OROvoVxNvyDpqQPxA/QiTxi013VpTk2fOGACwQqtKkDq1S5PDtSJbYJQpTo
         YtOMxusqjZwfAHMKfAxrmydnStDqOCtdn32UdWBNgsJKCeL9vPMC544K+6P7SE/PI1b7
         QRzg==
X-Gm-Message-State: AJIora+F1rEyeHN9zK5tSTKimiCsOI+AQEnVOg7fZIAMfu5JT7apMJua
        yIEAncQaX5lOP4vtLEl2uHdGLFCmBwDm2t2SEgkKdQ==
X-Google-Smtp-Source: AGRyM1s/zpGuvSLgPU7seG4INh+QHtQoxhL6YhuB+ra4qHILLvL6L5ZDA76Z7nbvw260b7Pe9ClzfJS9oiuPo7mHUUw=
X-Received: by 2002:a05:6e02:148c:b0:2d1:8e79:17d0 with SMTP id
 n12-20020a056e02148c00b002d18e7917d0mr2212797ilk.314.1655372910384; Thu, 16
 Jun 2022 02:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220616024148-mutt-send-email-mst@kernel.org> <20220616093703.39609-1-huangjie.albert@bytedance.com>
In-Reply-To: <20220616093703.39609-1-huangjie.albert@bytedance.com>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Thu, 16 Jun 2022 17:48:19 +0800
Message-ID: <CABKxMyPjf976Qjd8ENzxnUQzO-fVgtq0=G9hK8QUH7B7yfqfFA@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_ring : keep used_wrap_counter in vq->last_used_idx
To:     mst@redhat.com
Cc:     yuanzhu@bytedance.com, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Huang <huangjie.albert@bytedance.com> =E4=BA=8E2022=E5=B9=B46=E6=9C=
=8816=E6=97=A5=E5=91=A8=E5=9B=9B 17:37=E5=86=99=E9=81=93=EF=BC=9A
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
> v2->v3:
> - add inline function to get used_wrap_counter and last_used
> - when use vq->last_used_idx, only read once
>   if vq->last_used_idx is read twice, the values can be inconsistent.
> - use last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR))
>   to get the all bits below VRING_PACKED_EVENT_F_WRAP_CTR
>
> v1->v2:
> - reuse the VRING_PACKED_EVENT_F_WRAP_CTR
> - Remove parameter judgment in is_used_desc_packed,
> because it can't be illegal
>
> Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> ---
>  drivers/virtio/virtio_ring.c | 75 ++++++++++++++++++++++--------------
>  1 file changed, 47 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 13a7348cedff..0184b5056457 100644
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
> +        * used_wrap_counter, the VRING_PACKED_EVENT_F_WRAP_CTR is
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
> @@ -973,6 +975,15 @@ static struct virtqueue *vring_create_virtqueue_spli=
t(
>  /*
>   * Packed ring specific functions - *_packed().
>   */
> +static inline bool packed_used_wrap_counter(u16 last_used_idx)
> +{
> +       return !!(last_used_idx & (1 << VRING_PACKED_EVENT_F_WRAP_CTR));
> +}
> +
> +static inline u16 packed_last_used(u16 last_used_idx)
> +{
> +       return last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
> +}
>
>  static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
>                                      struct vring_desc_extra *extra)
> @@ -1406,8 +1417,14 @@ static inline bool is_used_desc_packed(const struc=
t vring_virtqueue *vq,
>
>  static inline bool more_used_packed(const struct vring_virtqueue *vq)
>  {
> -       return is_used_desc_packed(vq, vq->last_used_idx,
> -                       vq->packed.used_wrap_counter);
> +       u16 last_used;
> +       u16 last_used_idx;
> +       bool used_wrap_counter;
> +
> +       last_used_idx =3D vq->last_used_idx;
> +       last_used =3D packed_last_used(last_used_idx);
> +       used_wrap_counter =3D packed_used_wrap_counter(last_used_idx);
> +       return is_used_desc_packed(vq, last_used, used_wrap_counter);
>  }
>
>  static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> @@ -1415,7 +1432,8 @@ static void *virtqueue_get_buf_ctx_packed(struct vi=
rtqueue *_vq,
>                                           void **ctx)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
> -       u16 last_used, id;
> +       u16 last_used, id, last_used_idx;
> +       bool used_wrap_counter;
>         void *ret;
>
>         START_USE(vq);
> @@ -1434,7 +1452,9 @@ static void *virtqueue_get_buf_ctx_packed(struct vi=
rtqueue *_vq,
>         /* Only get used elements after they have been exposed by host. *=
/
>         virtio_rmb(vq->weak_barriers);
>
> -       last_used =3D vq->last_used_idx;
> +       last_used_idx =3D vq->last_used_idx;
> +       used_wrap_counter =3D packed_used_wrap_counter(last_used_idx);
> +       last_used =3D packed_last_used(last_used_idx);
>         id =3D le16_to_cpu(vq->packed.vring.desc[last_used].id);
>         *len =3D le32_to_cpu(vq->packed.vring.desc[last_used].len);
>
> @@ -1451,12 +1471,15 @@ static void *virtqueue_get_buf_ctx_packed(struct =
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
> +               last_used -=3D vq->packed.vring.num;
> +               used_wrap_counter ^=3D 1;
>         }
>
> +       last_used =3D (last_used | (used_wrap_counter << VRING_PACKED_EVE=
NT_F_WRAP_CTR));
> +       vq->last_used_idx =3D last_used;
> +
>         /*
>          * If we expect an interrupt for the next entry, tell host
>          * by writing event index and flush out the write before
> @@ -1465,9 +1488,7 @@ static void *virtqueue_get_buf_ctx_packed(struct vi=
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
> @@ -1499,9 +1520,7 @@ static unsigned int virtqueue_enable_cb_prepare_pac=
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
> @@ -1518,8 +1537,7 @@ static unsigned int virtqueue_enable_cb_prepare_pac=
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
> @@ -1537,7 +1555,7 @@ static bool virtqueue_poll_packed(struct virtqueue =
*_vq, u16 off_wrap)
>  static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
> -       u16 used_idx, wrap_counter;
> +       u16 used_idx, wrap_counter, last_used_idx;
>         u16 bufs;
>
>         START_USE(vq);
> @@ -1550,9 +1568,10 @@ static bool virtqueue_enable_cb_delayed_packed(str=
uct virtqueue *_vq)
>         if (vq->event) {
>                 /* TODO: tune this threshold */
>                 bufs =3D (vq->packed.vring.num - vq->vq.num_free) * 3 / 4=
;
> -               wrap_counter =3D vq->packed.used_wrap_counter;
> +               last_used_idx =3D vq->last_used_idx;
> +               wrap_counter =3D packed_used_wrap_counter(last_used_idx);
>
> -               used_idx =3D vq->last_used_idx + bufs;
> +               used_idx =3D packed_last_used(last_used_idx) + bufs;
>                 if (used_idx >=3D vq->packed.vring.num) {
>                         used_idx -=3D vq->packed.vring.num;
>                         wrap_counter ^=3D 1;
> @@ -1582,9 +1601,10 @@ static bool virtqueue_enable_cb_delayed_packed(str=
uct virtqueue *_vq)
>          */
>         virtio_mb(vq->weak_barriers);
>
> -       if (is_used_desc_packed(vq,
> -                               vq->last_used_idx,
> -                               vq->packed.used_wrap_counter)) {
> +       last_used_idx =3D READ_ONCE(vq->last_used_idx);

this is a mistake, I will repair it.

> +       wrap_counter =3D packed_used_wrap_counter(last_used_idx);
> +       used_idx =3D packed_last_used(last_used_idx);
> +       if (is_used_desc_packed(vq, used_idx, wrap_counter)) {
>                 END_USE(vq);
>                 return false;
>         }
> @@ -1689,7 +1709,7 @@ static struct virtqueue *vring_create_virtqueue_pac=
ked(
>         vq->notify =3D notify;
>         vq->weak_barriers =3D weak_barriers;
>         vq->broken =3D true;
> -       vq->last_used_idx =3D 0;
> +       vq->last_used_idx =3D 0 | (1 << VRING_PACKED_EVENT_F_WRAP_CTR);
>         vq->event_triggered =3D false;
>         vq->num_added =3D 0;
>         vq->packed_ring =3D true;
> @@ -1720,7 +1740,6 @@ static struct virtqueue *vring_create_virtqueue_pac=
ked(
>
>         vq->packed.next_avail_idx =3D 0;
>         vq->packed.avail_wrap_counter =3D 1;
> -       vq->packed.used_wrap_counter =3D 1;
>         vq->packed.event_flags_shadow =3D 0;
>         vq->packed.avail_used_flags =3D 1 << VRING_PACKED_DESC_F_AVAIL;
>
> --
> 2.31.1
>
