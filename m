Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBBE55B544
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 04:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiF0Cd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 22:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbiF0Cd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 22:33:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE2ED2AEB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 19:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656297235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+hQ0SHhD7VR3KbIow09LaxxDGxuuPFKXnJAUm0Kgf9M=;
        b=hhyTKOgoG/oRy9G1iIwPUrBwmawH7u5OvDc5FbMZy7/k7EETADksAfqsE+TSp4CZKzFJTe
        C06rGVxRDVnn3t3ZstxEL/gUumsufsN0QjyQBiLYJkDCum3M0xN53lUYuZGklPRZHGIe6b
        M7yu4FhJsAwtG0jr7YFnDVdy9XFh6AE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-CLLvTk0aOnOpU5bz4HMRFA-1; Sun, 26 Jun 2022 22:33:53 -0400
X-MC-Unique: CLLvTk0aOnOpU5bz4HMRFA-1
Received: by mail-lj1-f197.google.com with SMTP id by31-20020a05651c1a1f00b00258e4d37520so689349ljb.20
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 19:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+hQ0SHhD7VR3KbIow09LaxxDGxuuPFKXnJAUm0Kgf9M=;
        b=iUUE0aMYswxERQjKB+Tcl9DWSqeHWFGVMfJ2Kmdb96b7sN05BjSpmJnTUmHNDQ4Mgf
         V+u5xx0ZursDzJAj/t+xkmnewkC7TcVIDGCl7jCtnBsDgQYY0TmVXUXkJ96C20ua/b7H
         fyhUEhpo3Hcp2bTMI9IU7afx3kbCZJf57TIaJ0OnsummNa2LVudw9sRVfdzYTJZjhrTQ
         OB/QRnRxC/CV508zATS5evnzIS++P4Nr1Rtl7DNTgK6SCfWbG3jd/XS7M9rDsxOC9ie5
         oKC/9I7CTEnJgktWGxDaE94ZhoJSz5i92fw9no564O9vrJ221UyExioxlAPesj85bXwK
         sRLA==
X-Gm-Message-State: AJIora9YsyWEk45nrqBLKZVHhvKo3Ib+cd5JJP2HwLw2Sa4BhVMp8Rkr
        aWbFQe4v0guW/g5RtQp5xTeXVIUy4e2DudNCli7/34kpgiU8/sJaZcWw2g/ojXu1e4qyycD34tL
        2glFJCqUonz/nMDlGdKQ8ToxWWbAnyC72aff4JoqW
X-Received: by 2002:a2e:b703:0:b0:25a:93d0:8a57 with SMTP id j3-20020a2eb703000000b0025a93d08a57mr5648624ljo.487.1656297231304;
        Sun, 26 Jun 2022 19:33:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1szVr5es3WAK8iYT5FsuOHqnHgagrVl+jzpzKSSG9eDybv1dT5dL0QL9YMR38u325eUGQSJPZQRYI8sPIlIFQY=
X-Received: by 2002:a2e:b703:0:b0:25a:93d0:8a57 with SMTP id
 j3-20020a2eb703000000b0025a93d08a57mr5648618ljo.487.1656297231032; Sun, 26
 Jun 2022 19:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220616101823-mutt-send-email-mst@kernel.org>
 <20220617020411.80367-1-huangjie.albert@bytedance.com> <CACGkMEutq89farjWTdPY8R8wq8gCJLU2SWJrv+x=pPA5fv6+Uw@mail.gmail.com>
 <20220622081543-mutt-send-email-mst@kernel.org> <CACGkMEtaAFN+ntKvbbGYNf2O_-wSgc+Z4VVETVBEBNJi4bz9oA@mail.gmail.com>
 <20220624022136-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220624022136-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 27 Jun 2022 10:33:39 +0800
Message-ID: <CACGkMEvAz_e--hfRFXPuc8qqcTa7i+DPwP2qr3OQ4xD2GEb3mA@mail.gmail.com>
Subject: Re: [PATCH v4] virtio_ring : keep used_wrap_counter in vq->last_used_idx
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        yuanzhu@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 2:23 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jun 23, 2022 at 09:30:47AM +0800, Jason Wang wrote:
> > On Wed, Jun 22, 2022 at 8:16 PM Michael S. Tsirkin <mst@redhat.com> wro=
te:
> > >
> > > On Wed, Jun 22, 2022 at 04:51:22PM +0800, Jason Wang wrote:
> > > > On Fri, Jun 17, 2022 at 10:04 AM Albert Huang
> > > > <huangjie.albert@bytedance.com> wrote:
> > > > >
> > > > > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> > > > >
> > > > > the used_wrap_counter and the vq->last_used_idx may get
> > > > > out of sync if they are separate assignment=EF=BC=8Cand interrupt
> > > > > might use an incorrect value to check for the used index.
> > > > >
> > > > > for example:OOB access
> > > > > ksoftirqd may consume the packet and it will call:
> > > > > virtnet_poll
> > > > >         -->virtnet_receive
> > > > >                 -->virtqueue_get_buf_ctx
> > > > >                         -->virtqueue_get_buf_ctx_packed
> > > > > and in virtqueue_get_buf_ctx_packed:
> > > > >
> > > > > vq->last_used_idx +=3D vq->packed.desc_state[id].num;
> > > > > if (unlikely(vq->last_used_idx >=3D vq->packed.vring.num)) {
> > > > >          vq->last_used_idx -=3D vq->packed.vring.num;
> > > > >          vq->packed.used_wrap_counter ^=3D 1;
> > > > > }
> > > > >
> > > > > if at the same time, there comes a vring interrupt=EF=BC=8Cin vri=
ng_interrupt:
> > > > > we will call:
> > > > > vring_interrupt
> > > > >         -->more_used
> > > > >                 -->more_used_packed
> > > > >                         -->is_used_desc_packed
> > > > > in is_used_desc_packed, the last_used_idx maybe >=3D vq->packed.v=
ring.num.
> > > > > so this could case a memory out of bounds bug.
> > > > >
> > > > > this patch is to keep the used_wrap_counter in vq->last_used_idx
> > > > > so we can get the correct value to check for used index in interr=
upt.
> > > > >
> > > > > v3->v4:
> > > > > - use READ_ONCE/WRITE_ONCE to get/set vq->last_used_idx
> > > > >
> > > > > v2->v3:
> > > > > - add inline function to get used_wrap_counter and last_used
> > > > > - when use vq->last_used_idx, only read once
> > > > >   if vq->last_used_idx is read twice, the values can be inconsist=
ent.
> > > > > - use last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR))
> > > > >   to get the all bits below VRING_PACKED_EVENT_F_WRAP_CTR
> > > > >
> > > > > v1->v2:
> > > > > - reuse the VRING_PACKED_EVENT_F_WRAP_CTR
> > > > > - Remove parameter judgment in is_used_desc_packed,
> > > > > because it can't be illegal
> > > > >
> > > > > Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> > > > > ---
> > > > >  drivers/virtio/virtio_ring.c | 75 ++++++++++++++++++++++--------=
------
> > > > >  1 file changed, 47 insertions(+), 28 deletions(-)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio=
_ring.c
> > > > > index 13a7348cedff..719fbbe716d6 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -111,7 +111,12 @@ struct vring_virtqueue {
> > > > >         /* Number we've added since last sync. */
> > > > >         unsigned int num_added;
> > > > >
> > > > > -       /* Last used index we've seen. */
> > > > > +       /* Last used index  we've seen.
> > > > > +        * for split ring, it just contains last used index
> > > > > +        * for packed ring:
> > > > > +        * bits up to VRING_PACKED_EVENT_F_WRAP_CTR include the l=
ast used index.
> > > > > +        * bits from VRING_PACKED_EVENT_F_WRAP_CTR include the us=
ed wrap counter.
> > > > > +        */
> > > > >         u16 last_used_idx;
> > > > >
> > > > >         /* Hint for event idx: already triggered no need to disab=
le. */
> > > > > @@ -154,9 +159,6 @@ struct vring_virtqueue {
> > > > >                         /* Driver ring wrap counter. */
> > > > >                         bool avail_wrap_counter;
> > > > >
> > > > > -                       /* Device ring wrap counter. */
> > > > > -                       bool used_wrap_counter;
> > > > > -
> > > > >                         /* Avail used flags. */
> > > > >                         u16 avail_used_flags;
> > > > >
> > > > > @@ -973,6 +975,15 @@ static struct virtqueue *vring_create_virtqu=
eue_split(
> > > > >  /*
> > > > >   * Packed ring specific functions - *_packed().
> > > > >   */
> > > > > +static inline bool packed_used_wrap_counter(u16 last_used_idx)
> > > > > +{
> > > > > +       return !!(last_used_idx & (1 << VRING_PACKED_EVENT_F_WRAP=
_CTR));
> > > > > +}
> > > > > +
> > > > > +static inline u16 packed_last_used(u16 last_used_idx)
> > > > > +{
> > > > > +       return last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP=
_CTR));
> > > > > +}
> > > >
> > > > Any reason we need a minus after the shift?
> > >
> > > The point is to say "all bits above VRING_PACKED_EVENT_F_WRAP_CTR".
> > > Has no effect currently but will if last_used_idx is extended to 32 b=
it.
> >
> > Ok, but we don't do this for other uses for VRING_PACKED_EVENT_F_WRAP_C=
TR.
> >
> > I wonder how much value we do it only here.
> >
> > Thanks
>
> I don't care much either way. Feel free to go ahead and play with
> different versions so see which works better.

Ok, I'm fine with either. So

Acked-by: Jason Wang <jasowang@redhat.com>

>
> > >
> > >
> > > > Others look good.
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > >  static void vring_unmap_extra_packed(const struct vring_virtqueu=
e *vq,
> > > > >                                      struct vring_desc_extra *ext=
ra)
> > > > > @@ -1406,8 +1417,14 @@ static inline bool is_used_desc_packed(con=
st struct vring_virtqueue *vq,
> > > > >
> > > > >  static inline bool more_used_packed(const struct vring_virtqueue=
 *vq)
> > > > >  {
> > > > > -       return is_used_desc_packed(vq, vq->last_used_idx,
> > > > > -                       vq->packed.used_wrap_counter);
> > > > > +       u16 last_used;
> > > > > +       u16 last_used_idx;
> > > > > +       bool used_wrap_counter;
> > > > > +
> > > > > +       last_used_idx =3D READ_ONCE(vq->last_used_idx);
> > > > > +       last_used =3D packed_last_used(last_used_idx);
> > > > > +       used_wrap_counter =3D packed_used_wrap_counter(last_used_=
idx);
> > > > > +       return is_used_desc_packed(vq, last_used, used_wrap_count=
er);
> > > > >  }
> > > > >
> > > > >  static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> > > > > @@ -1415,7 +1432,8 @@ static void *virtqueue_get_buf_ctx_packed(s=
truct virtqueue *_vq,
> > > > >                                           void **ctx)
> > > > >  {
> > > > >         struct vring_virtqueue *vq =3D to_vvq(_vq);
> > > > > -       u16 last_used, id;
> > > > > +       u16 last_used, id, last_used_idx;
> > > > > +       bool used_wrap_counter;
> > > > >         void *ret;
> > > > >
> > > > >         START_USE(vq);
> > > > > @@ -1434,7 +1452,9 @@ static void *virtqueue_get_buf_ctx_packed(s=
truct virtqueue *_vq,
> > > > >         /* Only get used elements after they have been exposed by=
 host. */
> > > > >         virtio_rmb(vq->weak_barriers);
> > > > >
> > > > > -       last_used =3D vq->last_used_idx;
> > > > > +       last_used_idx =3D READ_ONCE(vq->last_used_idx);
> > > > > +       used_wrap_counter =3D packed_used_wrap_counter(last_used_=
idx);
> > > > > +       last_used =3D packed_last_used(last_used_idx);
> > > > >         id =3D le16_to_cpu(vq->packed.vring.desc[last_used].id);
> > > > >         *len =3D le32_to_cpu(vq->packed.vring.desc[last_used].len=
);
> > > > >
> > > > > @@ -1451,12 +1471,15 @@ static void *virtqueue_get_buf_ctx_packed=
(struct virtqueue *_vq,
> > > > >         ret =3D vq->packed.desc_state[id].data;
> > > > >         detach_buf_packed(vq, id, ctx);
> > > > >
> > > > > -       vq->last_used_idx +=3D vq->packed.desc_state[id].num;
> > > > > -       if (unlikely(vq->last_used_idx >=3D vq->packed.vring.num)=
) {
> > > > > -               vq->last_used_idx -=3D vq->packed.vring.num;
> > > > > -               vq->packed.used_wrap_counter ^=3D 1;
> > > > > +       last_used +=3D vq->packed.desc_state[id].num;
> > > > > +       if (unlikely(last_used >=3D vq->packed.vring.num)) {
> > > > > +               last_used -=3D vq->packed.vring.num;
> > > > > +               used_wrap_counter ^=3D 1;
> > > > >         }
> > > > >
> > > > > +       last_used =3D (last_used | (used_wrap_counter << VRING_PA=
CKED_EVENT_F_WRAP_CTR));
> > > > > +       WRITE_ONCE(vq->last_used_idx, last_used);
> > > > > +
> > > > >         /*
> > > > >          * If we expect an interrupt for the next entry, tell hos=
t
> > > > >          * by writing event index and flush out the write before
> > > > > @@ -1465,9 +1488,7 @@ static void *virtqueue_get_buf_ctx_packed(s=
truct virtqueue *_vq,
> > > > >         if (vq->packed.event_flags_shadow =3D=3D VRING_PACKED_EVE=
NT_FLAG_DESC)
> > > > >                 virtio_store_mb(vq->weak_barriers,
> > > > >                                 &vq->packed.vring.driver->off_wra=
p,
> > > > > -                               cpu_to_le16(vq->last_used_idx |
> > > > > -                                       (vq->packed.used_wrap_cou=
nter <<
> > > > > -                                        VRING_PACKED_EVENT_F_WRA=
P_CTR)));
> > > > > +                               cpu_to_le16(vq->last_used_idx));
> > > > >
> > > > >         LAST_ADD_TIME_INVALID(vq);
> > > > >
> > > > > @@ -1499,9 +1520,7 @@ static unsigned int virtqueue_enable_cb_pre=
pare_packed(struct virtqueue *_vq)
> > > > >
> > > > >         if (vq->event) {
> > > > >                 vq->packed.vring.driver->off_wrap =3D
> > > > > -                       cpu_to_le16(vq->last_used_idx |
> > > > > -                               (vq->packed.used_wrap_counter <<
> > > > > -                                VRING_PACKED_EVENT_F_WRAP_CTR));
> > > > > +                       cpu_to_le16(vq->last_used_idx);
> > > > >                 /*
> > > > >                  * We need to update event offset and event wrap
> > > > >                  * counter first before updating event flags.
> > > > > @@ -1518,8 +1537,7 @@ static unsigned int virtqueue_enable_cb_pre=
pare_packed(struct virtqueue *_vq)
> > > > >         }
> > > > >
> > > > >         END_USE(vq);
> > > > > -       return vq->last_used_idx | ((u16)vq->packed.used_wrap_cou=
nter <<
> > > > > -                       VRING_PACKED_EVENT_F_WRAP_CTR);
> > > > > +       return vq->last_used_idx;
> > > > >  }
> > > > >
> > > > >  static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off=
_wrap)
> > > > > @@ -1537,7 +1555,7 @@ static bool virtqueue_poll_packed(struct vi=
rtqueue *_vq, u16 off_wrap)
> > > > >  static bool virtqueue_enable_cb_delayed_packed(struct virtqueue =
*_vq)
> > > > >  {
> > > > >         struct vring_virtqueue *vq =3D to_vvq(_vq);
> > > > > -       u16 used_idx, wrap_counter;
> > > > > +       u16 used_idx, wrap_counter, last_used_idx;
> > > > >         u16 bufs;
> > > > >
> > > > >         START_USE(vq);
> > > > > @@ -1550,9 +1568,10 @@ static bool virtqueue_enable_cb_delayed_pa=
cked(struct virtqueue *_vq)
> > > > >         if (vq->event) {
> > > > >                 /* TODO: tune this threshold */
> > > > >                 bufs =3D (vq->packed.vring.num - vq->vq.num_free)=
 * 3 / 4;
> > > > > -               wrap_counter =3D vq->packed.used_wrap_counter;
> > > > > +               last_used_idx =3D READ_ONCE(vq->last_used_idx);
> > > > > +               wrap_counter =3D packed_used_wrap_counter(last_us=
ed_idx);
> > > > >
> > > > > -               used_idx =3D vq->last_used_idx + bufs;
> > > > > +               used_idx =3D packed_last_used(last_used_idx) + bu=
fs;
> > > > >                 if (used_idx >=3D vq->packed.vring.num) {
> > > > >                         used_idx -=3D vq->packed.vring.num;
> > > > >                         wrap_counter ^=3D 1;
> > > > > @@ -1582,9 +1601,10 @@ static bool virtqueue_enable_cb_delayed_pa=
cked(struct virtqueue *_vq)
> > > > >          */
> > > > >         virtio_mb(vq->weak_barriers);
> > > > >
> > > > > -       if (is_used_desc_packed(vq,
> > > > > -                               vq->last_used_idx,
> > > > > -                               vq->packed.used_wrap_counter)) {
> > > > > +       last_used_idx =3D READ_ONCE(vq->last_used_idx);
> > > > > +       wrap_counter =3D packed_used_wrap_counter(last_used_idx);
> > > > > +       used_idx =3D packed_last_used(last_used_idx);
> > > > > +       if (is_used_desc_packed(vq, used_idx, wrap_counter)) {
> > > > >                 END_USE(vq);
> > > > >                 return false;
> > > > >         }
> > > > > @@ -1689,7 +1709,7 @@ static struct virtqueue *vring_create_virtq=
ueue_packed(
> > > > >         vq->notify =3D notify;
> > > > >         vq->weak_barriers =3D weak_barriers;
> > > > >         vq->broken =3D true;
> > > > > -       vq->last_used_idx =3D 0;
> > > > > +       vq->last_used_idx =3D 0 | (1 << VRING_PACKED_EVENT_F_WRAP=
_CTR);
> > > > >         vq->event_triggered =3D false;
> > > > >         vq->num_added =3D 0;
> > > > >         vq->packed_ring =3D true;
> > > > > @@ -1720,7 +1740,6 @@ static struct virtqueue *vring_create_virtq=
ueue_packed(
> > > > >
> > > > >         vq->packed.next_avail_idx =3D 0;
> > > > >         vq->packed.avail_wrap_counter =3D 1;
> > > > > -       vq->packed.used_wrap_counter =3D 1;
> > > > >         vq->packed.event_flags_shadow =3D 0;
> > > > >         vq->packed.avail_used_flags =3D 1 << VRING_PACKED_DESC_F_=
AVAIL;
> > > > >
> > > > > --
> > > > > 2.31.1
> > > > >
> > >
>

