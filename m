Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394D5556FEF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 03:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343982AbiFWBbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 21:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236859AbiFWBbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 21:31:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 879C4433A4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 18:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655947862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q9hMJ74Juj7QOTlnpV3Nb5Z/yJYK0Jyh1x6LMW2nUzU=;
        b=LG2ilBTYo+9gqKJkCBCwFxgVW9xoEq9cgrJ6r1TJOjE9uGAmrQ9N18EscKjiY0TBXeoroR
        gcuiV3KxY+fRPo72Uz3MwSI9Q/9Z5EV0YnzuYuHY5hFRNR5MJ0pF1i7RkRcdACtnaGLcjd
        +0RHNoKoEX+CJHUSMjBI5q9HZQVLSSA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-GXlZSJTINI6S2naeAEZCuw-1; Wed, 22 Jun 2022 21:31:00 -0400
X-MC-Unique: GXlZSJTINI6S2naeAEZCuw-1
Received: by mail-lf1-f72.google.com with SMTP id u7-20020a05651206c700b00479723664a9so9283178lff.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 18:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q9hMJ74Juj7QOTlnpV3Nb5Z/yJYK0Jyh1x6LMW2nUzU=;
        b=7HGG3F+4ocerPlyXitITGAeIKTSLxefrgqICkjVjcTfFWHdqiXC1X+9oybIrS5Oxdy
         hRDGRVWQcx2hAs/RHAihC/qNgSROk3V73riRbV0cgyGDABpxKrSPAFA8oWSf9a9zIEvb
         OAA3EFOwX1plKdxLN+eADJ/xBGiLjAqE4vjI/ac1l6h5nQcpQ/CxMc8Q7NwHbqeFVJif
         WG1ywQEcf7LpOoKf4VqlVFovjmnjA58lElxhio2h7yls+rsDkW5tXczSnKaUhvgF65iu
         IuIU0S7p94XGcQ7W0VRte47VieKWD6DP9p3vSyH44d3v22D/+/SvDhkQxOkLs4L6IeGb
         IFXA==
X-Gm-Message-State: AJIora+8F1ilE7PmWltr+RzGZmnBSHNas1j5H5swFhUpwY2ItNe4IVB6
        QN2sk42E1T9NG1u8OoiHHoc6p5dCUgqDACt5tK3qlRqOfrh0DAQHbOSTV/Af/9Wn5eWS+3wiCsV
        XwylNtQ/g5B6cySw8k8mKtzX3a1Dy6lnJdWlceMaQ
X-Received: by 2002:a2e:9ad0:0:b0:25a:7156:26bb with SMTP id p16-20020a2e9ad0000000b0025a715626bbmr3341218ljj.141.1655947859137;
        Wed, 22 Jun 2022 18:30:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tx0v6sHlcNmOATVDHtnVNk1oyFdUiBrH8SL9+hyN0bXSkMtGhYYU+v0Oae86Wwq2iHv5NYtHl14t2giYU9aEs=
X-Received: by 2002:a2e:9ad0:0:b0:25a:7156:26bb with SMTP id
 p16-20020a2e9ad0000000b0025a715626bbmr3341213ljj.141.1655947858896; Wed, 22
 Jun 2022 18:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220616101823-mutt-send-email-mst@kernel.org>
 <20220617020411.80367-1-huangjie.albert@bytedance.com> <CACGkMEutq89farjWTdPY8R8wq8gCJLU2SWJrv+x=pPA5fv6+Uw@mail.gmail.com>
 <20220622081543-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220622081543-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 23 Jun 2022 09:30:47 +0800
Message-ID: <CACGkMEtaAFN+ntKvbbGYNf2O_-wSgc+Z4VVETVBEBNJi4bz9oA@mail.gmail.com>
Subject: Re: [PATCH v4] virtio_ring : keep used_wrap_counter in vq->last_used_idx
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        yuanzhu@bytedance.com,
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

On Wed, Jun 22, 2022 at 8:16 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jun 22, 2022 at 04:51:22PM +0800, Jason Wang wrote:
> > On Fri, Jun 17, 2022 at 10:04 AM Albert Huang
> > <huangjie.albert@bytedance.com> wrote:
> > >
> > > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> > >
> > > the used_wrap_counter and the vq->last_used_idx may get
> > > out of sync if they are separate assignment=EF=BC=8Cand interrupt
> > > might use an incorrect value to check for the used index.
> > >
> > > for example:OOB access
> > > ksoftirqd may consume the packet and it will call:
> > > virtnet_poll
> > >         -->virtnet_receive
> > >                 -->virtqueue_get_buf_ctx
> > >                         -->virtqueue_get_buf_ctx_packed
> > > and in virtqueue_get_buf_ctx_packed:
> > >
> > > vq->last_used_idx +=3D vq->packed.desc_state[id].num;
> > > if (unlikely(vq->last_used_idx >=3D vq->packed.vring.num)) {
> > >          vq->last_used_idx -=3D vq->packed.vring.num;
> > >          vq->packed.used_wrap_counter ^=3D 1;
> > > }
> > >
> > > if at the same time, there comes a vring interrupt=EF=BC=8Cin vring_i=
nterrupt:
> > > we will call:
> > > vring_interrupt
> > >         -->more_used
> > >                 -->more_used_packed
> > >                         -->is_used_desc_packed
> > > in is_used_desc_packed, the last_used_idx maybe >=3D vq->packed.vring=
.num.
> > > so this could case a memory out of bounds bug.
> > >
> > > this patch is to keep the used_wrap_counter in vq->last_used_idx
> > > so we can get the correct value to check for used index in interrupt.
> > >
> > > v3->v4:
> > > - use READ_ONCE/WRITE_ONCE to get/set vq->last_used_idx
> > >
> > > v2->v3:
> > > - add inline function to get used_wrap_counter and last_used
> > > - when use vq->last_used_idx, only read once
> > >   if vq->last_used_idx is read twice, the values can be inconsistent.
> > > - use last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR))
> > >   to get the all bits below VRING_PACKED_EVENT_F_WRAP_CTR
> > >
> > > v1->v2:
> > > - reuse the VRING_PACKED_EVENT_F_WRAP_CTR
> > > - Remove parameter judgment in is_used_desc_packed,
> > > because it can't be illegal
> > >
> > > Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 75 ++++++++++++++++++++++------------=
--
> > >  1 file changed, 47 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 13a7348cedff..719fbbe716d6 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -111,7 +111,12 @@ struct vring_virtqueue {
> > >         /* Number we've added since last sync. */
> > >         unsigned int num_added;
> > >
> > > -       /* Last used index we've seen. */
> > > +       /* Last used index  we've seen.
> > > +        * for split ring, it just contains last used index
> > > +        * for packed ring:
> > > +        * bits up to VRING_PACKED_EVENT_F_WRAP_CTR include the last =
used index.
> > > +        * bits from VRING_PACKED_EVENT_F_WRAP_CTR include the used w=
rap counter.
> > > +        */
> > >         u16 last_used_idx;
> > >
> > >         /* Hint for event idx: already triggered no need to disable. =
*/
> > > @@ -154,9 +159,6 @@ struct vring_virtqueue {
> > >                         /* Driver ring wrap counter. */
> > >                         bool avail_wrap_counter;
> > >
> > > -                       /* Device ring wrap counter. */
> > > -                       bool used_wrap_counter;
> > > -
> > >                         /* Avail used flags. */
> > >                         u16 avail_used_flags;
> > >
> > > @@ -973,6 +975,15 @@ static struct virtqueue *vring_create_virtqueue_=
split(
> > >  /*
> > >   * Packed ring specific functions - *_packed().
> > >   */
> > > +static inline bool packed_used_wrap_counter(u16 last_used_idx)
> > > +{
> > > +       return !!(last_used_idx & (1 << VRING_PACKED_EVENT_F_WRAP_CTR=
));
> > > +}
> > > +
> > > +static inline u16 packed_last_used(u16 last_used_idx)
> > > +{
> > > +       return last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR=
));
> > > +}
> >
> > Any reason we need a minus after the shift?
>
> The point is to say "all bits above VRING_PACKED_EVENT_F_WRAP_CTR".
> Has no effect currently but will if last_used_idx is extended to 32 bit.

Ok, but we don't do this for other uses for VRING_PACKED_EVENT_F_WRAP_CTR.

I wonder how much value we do it only here.

Thanks

>
>
> > Others look good.
> >
> > Thanks
> >
> > >
> > >  static void vring_unmap_extra_packed(const struct vring_virtqueue *v=
q,
> > >                                      struct vring_desc_extra *extra)
> > > @@ -1406,8 +1417,14 @@ static inline bool is_used_desc_packed(const s=
truct vring_virtqueue *vq,
> > >
> > >  static inline bool more_used_packed(const struct vring_virtqueue *vq=
)
> > >  {
> > > -       return is_used_desc_packed(vq, vq->last_used_idx,
> > > -                       vq->packed.used_wrap_counter);
> > > +       u16 last_used;
> > > +       u16 last_used_idx;
> > > +       bool used_wrap_counter;
> > > +
> > > +       last_used_idx =3D READ_ONCE(vq->last_used_idx);
> > > +       last_used =3D packed_last_used(last_used_idx);
> > > +       used_wrap_counter =3D packed_used_wrap_counter(last_used_idx)=
;
> > > +       return is_used_desc_packed(vq, last_used, used_wrap_counter);
> > >  }
> > >
> > >  static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> > > @@ -1415,7 +1432,8 @@ static void *virtqueue_get_buf_ctx_packed(struc=
t virtqueue *_vq,
> > >                                           void **ctx)
> > >  {
> > >         struct vring_virtqueue *vq =3D to_vvq(_vq);
> > > -       u16 last_used, id;
> > > +       u16 last_used, id, last_used_idx;
> > > +       bool used_wrap_counter;
> > >         void *ret;
> > >
> > >         START_USE(vq);
> > > @@ -1434,7 +1452,9 @@ static void *virtqueue_get_buf_ctx_packed(struc=
t virtqueue *_vq,
> > >         /* Only get used elements after they have been exposed by hos=
t. */
> > >         virtio_rmb(vq->weak_barriers);
> > >
> > > -       last_used =3D vq->last_used_idx;
> > > +       last_used_idx =3D READ_ONCE(vq->last_used_idx);
> > > +       used_wrap_counter =3D packed_used_wrap_counter(last_used_idx)=
;
> > > +       last_used =3D packed_last_used(last_used_idx);
> > >         id =3D le16_to_cpu(vq->packed.vring.desc[last_used].id);
> > >         *len =3D le32_to_cpu(vq->packed.vring.desc[last_used].len);
> > >
> > > @@ -1451,12 +1471,15 @@ static void *virtqueue_get_buf_ctx_packed(str=
uct virtqueue *_vq,
> > >         ret =3D vq->packed.desc_state[id].data;
> > >         detach_buf_packed(vq, id, ctx);
> > >
> > > -       vq->last_used_idx +=3D vq->packed.desc_state[id].num;
> > > -       if (unlikely(vq->last_used_idx >=3D vq->packed.vring.num)) {
> > > -               vq->last_used_idx -=3D vq->packed.vring.num;
> > > -               vq->packed.used_wrap_counter ^=3D 1;
> > > +       last_used +=3D vq->packed.desc_state[id].num;
> > > +       if (unlikely(last_used >=3D vq->packed.vring.num)) {
> > > +               last_used -=3D vq->packed.vring.num;
> > > +               used_wrap_counter ^=3D 1;
> > >         }
> > >
> > > +       last_used =3D (last_used | (used_wrap_counter << VRING_PACKED=
_EVENT_F_WRAP_CTR));
> > > +       WRITE_ONCE(vq->last_used_idx, last_used);
> > > +
> > >         /*
> > >          * If we expect an interrupt for the next entry, tell host
> > >          * by writing event index and flush out the write before
> > > @@ -1465,9 +1488,7 @@ static void *virtqueue_get_buf_ctx_packed(struc=
t virtqueue *_vq,
> > >         if (vq->packed.event_flags_shadow =3D=3D VRING_PACKED_EVENT_F=
LAG_DESC)
> > >                 virtio_store_mb(vq->weak_barriers,
> > >                                 &vq->packed.vring.driver->off_wrap,
> > > -                               cpu_to_le16(vq->last_used_idx |
> > > -                                       (vq->packed.used_wrap_counter=
 <<
> > > -                                        VRING_PACKED_EVENT_F_WRAP_CT=
R)));
> > > +                               cpu_to_le16(vq->last_used_idx));
> > >
> > >         LAST_ADD_TIME_INVALID(vq);
> > >
> > > @@ -1499,9 +1520,7 @@ static unsigned int virtqueue_enable_cb_prepare=
_packed(struct virtqueue *_vq)
> > >
> > >         if (vq->event) {
> > >                 vq->packed.vring.driver->off_wrap =3D
> > > -                       cpu_to_le16(vq->last_used_idx |
> > > -                               (vq->packed.used_wrap_counter <<
> > > -                                VRING_PACKED_EVENT_F_WRAP_CTR));
> > > +                       cpu_to_le16(vq->last_used_idx);
> > >                 /*
> > >                  * We need to update event offset and event wrap
> > >                  * counter first before updating event flags.
> > > @@ -1518,8 +1537,7 @@ static unsigned int virtqueue_enable_cb_prepare=
_packed(struct virtqueue *_vq)
> > >         }
> > >
> > >         END_USE(vq);
> > > -       return vq->last_used_idx | ((u16)vq->packed.used_wrap_counter=
 <<
> > > -                       VRING_PACKED_EVENT_F_WRAP_CTR);
> > > +       return vq->last_used_idx;
> > >  }
> > >
> > >  static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wra=
p)
> > > @@ -1537,7 +1555,7 @@ static bool virtqueue_poll_packed(struct virtqu=
eue *_vq, u16 off_wrap)
> > >  static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq=
)
> > >  {
> > >         struct vring_virtqueue *vq =3D to_vvq(_vq);
> > > -       u16 used_idx, wrap_counter;
> > > +       u16 used_idx, wrap_counter, last_used_idx;
> > >         u16 bufs;
> > >
> > >         START_USE(vq);
> > > @@ -1550,9 +1568,10 @@ static bool virtqueue_enable_cb_delayed_packed=
(struct virtqueue *_vq)
> > >         if (vq->event) {
> > >                 /* TODO: tune this threshold */
> > >                 bufs =3D (vq->packed.vring.num - vq->vq.num_free) * 3=
 / 4;
> > > -               wrap_counter =3D vq->packed.used_wrap_counter;
> > > +               last_used_idx =3D READ_ONCE(vq->last_used_idx);
> > > +               wrap_counter =3D packed_used_wrap_counter(last_used_i=
dx);
> > >
> > > -               used_idx =3D vq->last_used_idx + bufs;
> > > +               used_idx =3D packed_last_used(last_used_idx) + bufs;
> > >                 if (used_idx >=3D vq->packed.vring.num) {
> > >                         used_idx -=3D vq->packed.vring.num;
> > >                         wrap_counter ^=3D 1;
> > > @@ -1582,9 +1601,10 @@ static bool virtqueue_enable_cb_delayed_packed=
(struct virtqueue *_vq)
> > >          */
> > >         virtio_mb(vq->weak_barriers);
> > >
> > > -       if (is_used_desc_packed(vq,
> > > -                               vq->last_used_idx,
> > > -                               vq->packed.used_wrap_counter)) {
> > > +       last_used_idx =3D READ_ONCE(vq->last_used_idx);
> > > +       wrap_counter =3D packed_used_wrap_counter(last_used_idx);
> > > +       used_idx =3D packed_last_used(last_used_idx);
> > > +       if (is_used_desc_packed(vq, used_idx, wrap_counter)) {
> > >                 END_USE(vq);
> > >                 return false;
> > >         }
> > > @@ -1689,7 +1709,7 @@ static struct virtqueue *vring_create_virtqueue=
_packed(
> > >         vq->notify =3D notify;
> > >         vq->weak_barriers =3D weak_barriers;
> > >         vq->broken =3D true;
> > > -       vq->last_used_idx =3D 0;
> > > +       vq->last_used_idx =3D 0 | (1 << VRING_PACKED_EVENT_F_WRAP_CTR=
);
> > >         vq->event_triggered =3D false;
> > >         vq->num_added =3D 0;
> > >         vq->packed_ring =3D true;
> > > @@ -1720,7 +1740,6 @@ static struct virtqueue *vring_create_virtqueue=
_packed(
> > >
> > >         vq->packed.next_avail_idx =3D 0;
> > >         vq->packed.avail_wrap_counter =3D 1;
> > > -       vq->packed.used_wrap_counter =3D 1;
> > >         vq->packed.event_flags_shadow =3D 0;
> > >         vq->packed.avail_used_flags =3D 1 << VRING_PACKED_DESC_F_AVAI=
L;
> > >
> > > --
> > > 2.31.1
> > >
>

