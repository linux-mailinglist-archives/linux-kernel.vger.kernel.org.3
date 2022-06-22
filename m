Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4110B554747
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355455AbiFVIvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239184AbiFVIvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:51:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 114E337A00
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655887897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gkltbLrGQ8mmDgYD5JYBmWsZ6WjkvgUqrGhlmxetZB4=;
        b=f1JNrogk6tgABZn69tJT3RU4VQbviaToRrOVjen6jFviXRuH3EeTM4QBrrI6h6fGS5jQRE
        DJXpuu4svk6PGMtmQtzm5EnEU3mETnByANE/SR+wsPgorswVt4vg8sDvOUAUkMKsH4caa2
        4UZzVT/kEnOvNZ1Yy2b85YK5869qXr0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-P8K-e7r7Og66iOvLNUX_fA-1; Wed, 22 Jun 2022 04:51:36 -0400
X-MC-Unique: P8K-e7r7Og66iOvLNUX_fA-1
Received: by mail-lj1-f197.google.com with SMTP id x12-20020a2ea7cc000000b002556793003eso2254835ljp.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gkltbLrGQ8mmDgYD5JYBmWsZ6WjkvgUqrGhlmxetZB4=;
        b=SuzZ7pgqohO+zoYIWj+8ML1uVlTh/D+3AwKlT3TrUYd9ri2+JLW3VwvtzFc+B7pyq7
         KKHB2oSSSBX68pUxLiUjWPKnC5PbQVQfXObZcqaVS5C3EaYlr3P1plmEw++k3vkClYty
         uQXVW9Dkmd4w1uNdbMKFcMXY3nJxbgMU6nxsNVOowwn8z3FyWGvI7nSqtSh6wLXV/+Sk
         qIQCID1FbT90Xy1JV4/LR9Oc0j/1OzAsd3XQAsWpb1FBBmv9Ho+3HTS6ejeLS9HhKAe1
         ILTv013EvAFTe/jDg3mc3/I3R6bK80xvvEnTo7Pfa/DJ+fXrczwmR9ofeSyqEw/zFKMO
         Fx6g==
X-Gm-Message-State: AJIora8vB1mKkVb0sA0JhUoDINsUtYaD1HJHBcAuu1lF+lLbUB/PWhe3
        4dr/SOCBrwd3dGz5bbkSzlV5NcjqwjYLdox4q6aZ5nQEQbE1ky3PxdD3n47f2FPFac4+FyhnrBx
        My0tt8kGilSqWQPFiHmkYxFs9o9qS9q2Rc3HOQYD2
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id y15-20020a0565123f0f00b0047f6f890326mr1479639lfa.124.1655887894421;
        Wed, 22 Jun 2022 01:51:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tw3xOnAQuHg6VoT5TUnaUmeyE/BPH6hjtiGyZ141/1ME/JjMOrdCgl5a9KNto8piHei6HFGW8aCgbsYD2ZMOw=
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id
 y15-20020a0565123f0f00b0047f6f890326mr1479624lfa.124.1655887894139; Wed, 22
 Jun 2022 01:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220616101823-mutt-send-email-mst@kernel.org> <20220617020411.80367-1-huangjie.albert@bytedance.com>
In-Reply-To: <20220617020411.80367-1-huangjie.albert@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 22 Jun 2022 16:51:22 +0800
Message-ID: <CACGkMEutq89farjWTdPY8R8wq8gCJLU2SWJrv+x=pPA5fv6+Uw@mail.gmail.com>
Subject: Re: [PATCH v4] virtio_ring : keep used_wrap_counter in vq->last_used_idx
To:     Albert Huang <huangjie.albert@bytedance.com>
Cc:     mst <mst@redhat.com>, yuanzhu@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 10:04 AM Albert Huang
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
> v3->v4:
> - use READ_ONCE/WRITE_ONCE to get/set vq->last_used_idx
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
> index 13a7348cedff..719fbbe716d6 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -111,7 +111,12 @@ struct vring_virtqueue {
>         /* Number we've added since last sync. */
>         unsigned int num_added;
>
> -       /* Last used index we've seen. */
> +       /* Last used index  we've seen.
> +        * for split ring, it just contains last used index
> +        * for packed ring:
> +        * bits up to VRING_PACKED_EVENT_F_WRAP_CTR include the last used=
 index.
> +        * bits from VRING_PACKED_EVENT_F_WRAP_CTR include the used wrap =
counter.
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

Any reason we need a minus after the shift?

Others look good.

Thanks

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
> +       last_used_idx =3D READ_ONCE(vq->last_used_idx);
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
> +       last_used_idx =3D READ_ONCE(vq->last_used_idx);
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
> +       WRITE_ONCE(vq->last_used_idx, last_used);
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
> +               last_used_idx =3D READ_ONCE(vq->last_used_idx);
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

