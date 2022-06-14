Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9D154AB8F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbiFNIRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbiFNIRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:17:07 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16503FD94
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:17:05 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id r5so8646964iod.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ey38FOje1qhBoyFKEwgMBItTmKZu5WAMaNeKEpJx1zk=;
        b=eiTwxzyxzEyHX1n42w506ist0rSUGGsQziBRqgx3/KscVt5UHXi1WJxi41VHxh4V6Q
         NtmlnZtnVA2ZVv+Cqe7HfE2cTqRhK422gXGd5TFop+voy/p5r9qvTCrkQdRCjgj9PFO1
         SenMLkx9vipsJdRznTL5XDk7qGGv+bxJHRwOJ9KRxH3P3FrY/4S1XXqFHbBx0UgaWBSN
         eyUBx8XQ/Xac7SIRQ+3PGLqTCzNoW6dCHLmWp17XVXdtOSAOWji8b8gL8hqaU6l/vHvZ
         mb1aJO2GSFSM3cKU4xCcVtdtSxYOZYnuoVm/AgB84aurkcdbYMFIWgpktiTjxmDGr4Wp
         Vnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ey38FOje1qhBoyFKEwgMBItTmKZu5WAMaNeKEpJx1zk=;
        b=vcn2Zp32W9DZLH4o4MowuUi9MU1tFqujC9sArd9575sRjhcP7pJhJ99zHfH6QvNkhn
         ApOV2L1nSwNbGNmfEGIzC074kibvpnrvVoQiCaaEFsJQPQYOAjSpMZhxL3ugDJ4BDUu/
         etg4QQ0khUncr6kN8bSSoLKmj2CwhprWzydNwOI+ZmU+9/+QPuscsR7iWEkhqc0SsChY
         j3kI+nPYTBwOzjbRfD3lN9tFbetKXdcOgizqbhkKo4G+caWsMsm96N2j0kqun+coOc+z
         HbHhvjAm6VA+DUZLYa5ATuE4IV2OPJq5Y4P01rtPr+uUub6ECv9iDiWdrdSmjdcr3opF
         IXOA==
X-Gm-Message-State: AOAM531HaT4Rlhf/rOGKf+zxk+XQhPcbpTiOnNnUNOTg65hzoDoHdqTE
        Hdd1qq4EeRc582VoIMLofy/U/K6PqRbi/y5i7czjOA==
X-Google-Smtp-Source: ABdhPJyFs6N+2S/uhEy9HjTp1j7ZIf1O53t4W42tOEBq3BsEBHCJfES9t1ZQIrKqU3/CDBCDJNjCx7+yXdumAqUJq0c=
X-Received: by 2002:a05:6638:1c12:b0:333:ef51:ff14 with SMTP id
 ca18-20020a0566381c1200b00333ef51ff14mr2104815jab.137.1655194625062; Tue, 14
 Jun 2022 01:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220613100433-mutt-send-email-mst@kernel.org>
 <20220614053737.82453-1-huangjie.albert@bytedance.com> <CACGkMEsnvj3MR8oRu-M2D9gTD2sDUJSWkMdjdm6GPum_KUY47w@mail.gmail.com>
In-Reply-To: <CACGkMEsnvj3MR8oRu-M2D9gTD2sDUJSWkMdjdm6GPum_KUY47w@mail.gmail.com>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Tue, 14 Jun 2022 16:16:53 +0800
Message-ID: <CABKxMyMMQhbLCu8QN4ZD42802ZQdbGC+YvkQiWz_voecfM1jqw@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring : keep used_wrap_counter in vq->last_used_idx
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst <mst@redhat.com>, yuanzhu@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Jason Wang <jasowang@redhat.com> =E4=BA=8E2022=E5=B9=B46=E6=9C=8814=E6=97=
=A5=E5=91=A8=E4=BA=8C 15:45=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jun 14, 2022 at 1:38 PM Albert Huang
> <huangjie.albert@bytedance.com> wrote:
> >
> > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> >
> > the used_wrap_counter and the vq->last_used_idx may get
> > out of sync if they are separate assignment=EF=BC=8Cand interrupt
> > might use an incorrect value to check for the used index.
> >
> > for example:OOB access
> > ksoftirqd may consume the packet and it will call:
> > virtnet_poll
> >         -->virtnet_receive
> >                 -->virtqueue_get_buf_ctx
> >                         -->virtqueue_get_buf_ctx_packed
> > and in virtqueue_get_buf_ctx_packed:
> >
> > vq->last_used_idx +=3D vq->packed.desc_state[id].num;
> > if (unlikely(vq->last_used_idx >=3D vq->packed.vring.num)) {
> >          vq->last_used_idx -=3D vq->packed.vring.num;
> >          vq->packed.used_wrap_counter ^=3D 1;
> > }
> >
> > if at the same time, there comes a vring interrupt=EF=BC=8Cin vring_int=
errupt:
> > we will call:
> > vring_interrupt
> >         -->more_used
> >                 -->more_used_packed
> >                         -->is_used_desc_packed
> > in is_used_desc_packed, the last_used_idx maybe >=3D vq->packed.vring.n=
um.
> > so this could case a memory out of bounds bug.
> >
> > this patch is to keep the used_wrap_counter in vq->last_used_idx
> > so we can get the correct value to check for used index in interrupt.
> >
> > Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> > ---
> >  drivers/virtio/virtio_ring.c     | 60 ++++++++++++++++++--------------
> >  include/uapi/linux/virtio_ring.h |  6 ++++
> >  2 files changed, 40 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index 13a7348cedff..35c3750e89e1 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -111,7 +111,12 @@ struct vring_virtqueue {
> >         /* Number we've added since last sync. */
> >         unsigned int num_added;
> >
> > -       /* Last used index we've seen. */
> > +       /* Last used index  we've seen.
> > +        * for split ring, it just contains last used index
> > +        * for packed ring, it not only contains last used index, but a=
lso
> > +        * used_wrap_counter, the VRING_PACKED_USED_INDEX_F_WRAP_CTR is
> > +        * the bit shift in last_used_idx
> > +        */
> >         u16 last_used_idx;
> >
> >         /* Hint for event idx: already triggered no need to disable. */
> > @@ -154,9 +159,6 @@ struct vring_virtqueue {
> >                         /* Driver ring wrap counter. */
> >                         bool avail_wrap_counter;
> >
> > -                       /* Device ring wrap counter. */
> > -                       bool used_wrap_counter;
> > -
> >                         /* Avail used flags. */
> >                         u16 avail_used_flags;
> >
> > @@ -1397,6 +1399,9 @@ static inline bool is_used_desc_packed(const stru=
ct vring_virtqueue *vq,
> >         bool avail, used;
> >         u16 flags;
> >
> > +       if (idx >=3D vq->packed.vring.num)
> > +               return false;
>
> I wonder if we can avoid this trick, more below.

Yes, the idx pass to the is_used_desc_packed can never  >=3D
vq->packed.vring.num since we
tweak the math here :
>+       last_used +=3D vq->packed.desc_state[id].num;
>+       if (unlikely(last_used >=3D vq->packed.vring.num)) {
>+               last_used -=3D vq->packed.vring.num;
>+               used_wrap_counter ^=3D 1;
>         }
>+       last_used =3D (last_used | (used_wrap_counter << VRING_PACKED_DESC=
_F_USED));
>+       vq->last_used_idx =3D last_used;

>
> > +
> >         flags =3D le16_to_cpu(vq->packed.vring.desc[idx].flags);
> >         avail =3D !!(flags & (1 << VRING_PACKED_DESC_F_AVAIL));
> >         used =3D !!(flags & (1 << VRING_PACKED_DESC_F_USED));
> > @@ -1406,8 +1411,12 @@ static inline bool is_used_desc_packed(const str=
uct vring_virtqueue *vq,
> >
> >  static inline bool more_used_packed(const struct vring_virtqueue *vq)
> >  {
> > -       return is_used_desc_packed(vq, vq->last_used_idx,
> > -                       vq->packed.used_wrap_counter);
> > +       u16 last_used;
> > +       bool used_wrap_counter;
> > +
> > +       last_used =3D vq->last_used_idx & ~(1 << VRING_PACKED_USED_INDE=
X_F_WRAP_CTR);
> > +       used_wrap_counter =3D !!((vq->last_used_idx) >> VRING_PACKED_US=
ED_INDEX_F_WRAP_CTR);
> > +       return is_used_desc_packed(vq, last_used, used_wrap_counter);
> >  }
> >
> >  static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> > @@ -1416,6 +1425,7 @@ static void *virtqueue_get_buf_ctx_packed(struct =
virtqueue *_vq,
> >  {
> >         struct vring_virtqueue *vq =3D to_vvq(_vq);
> >         u16 last_used, id;
> > +       bool used_wrap_counter;
> >         void *ret;
> >
> >         START_USE(vq);
> > @@ -1434,7 +1444,8 @@ static void *virtqueue_get_buf_ctx_packed(struct =
virtqueue *_vq,
> >         /* Only get used elements after they have been exposed by host.=
 */
> >         virtio_rmb(vq->weak_barriers);
> >
> > -       last_used =3D vq->last_used_idx;
> > +       used_wrap_counter =3D !!((vq->last_used_idx >> VRING_PACKED_USE=
D_INDEX_F_WRAP_CTR));
> > +       last_used =3D (vq->last_used_idx) & (~(1 << VRING_PACKED_USED_I=
NDEX_F_WRAP_CTR));
> >         id =3D le16_to_cpu(vq->packed.vring.desc[last_used].id);
> >         *len =3D le32_to_cpu(vq->packed.vring.desc[last_used].len);
> >
> > @@ -1451,12 +1462,15 @@ static void *virtqueue_get_buf_ctx_packed(struc=
t virtqueue *_vq,
> >         ret =3D vq->packed.desc_state[id].data;
> >         detach_buf_packed(vq, id, ctx);
> >
> > -       vq->last_used_idx +=3D vq->packed.desc_state[id].num;
> > -       if (unlikely(vq->last_used_idx >=3D vq->packed.vring.num)) {
> > -               vq->last_used_idx -=3D vq->packed.vring.num;
> > -               vq->packed.used_wrap_counter ^=3D 1;
> > +       last_used +=3D vq->packed.desc_state[id].num;
> > +       if (unlikely(last_used >=3D vq->packed.vring.num)) {
>
> Can we tweak the math here to avoid the out of bound result?

   Yes, this can avoid the out of bound result. because of  We just
assign last_used_idx in the following code=EF=BC=9A
  vq->last_used_idx =3D last_used;
  and it is a 16bit/32bit operations,and are guaranteed to be atomic

>
> > +               last_used -=3D vq->packed.vring.num;
> > +               used_wrap_counter ^=3D 1;
> >         }
> >
> > +       last_used =3D (last_used | (used_wrap_counter << VRING_PACKED_D=
ESC_F_USED));
> > +       vq->last_used_idx =3D last_used;
> > +
> >         /*
> >          * If we expect an interrupt for the next entry, tell host
> >          * by writing event index and flush out the write before
> > @@ -1465,9 +1479,7 @@ static void *virtqueue_get_buf_ctx_packed(struct =
virtqueue *_vq,
> >         if (vq->packed.event_flags_shadow =3D=3D VRING_PACKED_EVENT_FLA=
G_DESC)
> >                 virtio_store_mb(vq->weak_barriers,
> >                                 &vq->packed.vring.driver->off_wrap,
> > -                               cpu_to_le16(vq->last_used_idx |
> > -                                       (vq->packed.used_wrap_counter <=
<
> > -                                        VRING_PACKED_EVENT_F_WRAP_CTR)=
));
> > +                               cpu_to_le16(vq->last_used_idx));
> >
> >         LAST_ADD_TIME_INVALID(vq);
> >
> > @@ -1499,9 +1511,7 @@ static unsigned int virtqueue_enable_cb_prepare_p=
acked(struct virtqueue *_vq)
> >
> >         if (vq->event) {
> >                 vq->packed.vring.driver->off_wrap =3D
> > -                       cpu_to_le16(vq->last_used_idx |
> > -                               (vq->packed.used_wrap_counter <<
> > -                                VRING_PACKED_EVENT_F_WRAP_CTR));
> > +                       cpu_to_le16(vq->last_used_idx);
> >                 /*
> >                  * We need to update event offset and event wrap
> >                  * counter first before updating event flags.
> > @@ -1518,8 +1528,7 @@ static unsigned int virtqueue_enable_cb_prepare_p=
acked(struct virtqueue *_vq)
> >         }
> >
> >         END_USE(vq);
> > -       return vq->last_used_idx | ((u16)vq->packed.used_wrap_counter <=
<
> > -                       VRING_PACKED_EVENT_F_WRAP_CTR);
> > +       return vq->last_used_idx;
> >  }
> >
> >  static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
> > @@ -1550,9 +1559,9 @@ static bool virtqueue_enable_cb_delayed_packed(st=
ruct virtqueue *_vq)
> >         if (vq->event) {
> >                 /* TODO: tune this threshold */
> >                 bufs =3D (vq->packed.vring.num - vq->vq.num_free) * 3 /=
 4;
> > -               wrap_counter =3D vq->packed.used_wrap_counter;
> > +               wrap_counter =3D !!(vq->last_used_idx >> VRING_PACKED_U=
SED_INDEX_F_WRAP_CTR);
> >
> > -               used_idx =3D vq->last_used_idx + bufs;
> > +               used_idx =3D (vq->last_used_idx & ~(1 << VRING_PACKED_U=
SED_INDEX_F_WRAP_CTR)) + bufs;
> >                 if (used_idx >=3D vq->packed.vring.num) {
> >                         used_idx -=3D vq->packed.vring.num;
> >                         wrap_counter ^=3D 1;
> > @@ -1582,9 +1591,9 @@ static bool virtqueue_enable_cb_delayed_packed(st=
ruct virtqueue *_vq)
> >          */
> >         virtio_mb(vq->weak_barriers);
> >
> > -       if (is_used_desc_packed(vq,
> > -                               vq->last_used_idx,
> > -                               vq->packed.used_wrap_counter)) {
> > +       wrap_counter =3D !!(vq->last_used_idx >> VRING_PACKED_USED_INDE=
X_F_WRAP_CTR);
> > +       used_idx =3D (vq->last_used_idx & ~(1 << VRING_PACKED_USED_INDE=
X_F_WRAP_CTR));
> > +       if (is_used_desc_packed(vq, used_idx, wrap_counter)) {
> >                 END_USE(vq);
> >                 return false;
> >         }
> > @@ -1689,7 +1698,7 @@ static struct virtqueue *vring_create_virtqueue_p=
acked(
> >         vq->notify =3D notify;
> >         vq->weak_barriers =3D weak_barriers;
> >         vq->broken =3D true;
> > -       vq->last_used_idx =3D 0;
> > +       vq->last_used_idx =3D 0 | (1 << VRING_PACKED_USED_INDEX_F_WRAP_=
CTR);
> >         vq->event_triggered =3D false;
> >         vq->num_added =3D 0;
> >         vq->packed_ring =3D true;
> > @@ -1720,7 +1729,6 @@ static struct virtqueue *vring_create_virtqueue_p=
acked(
> >
> >         vq->packed.next_avail_idx =3D 0;
> >         vq->packed.avail_wrap_counter =3D 1;
> > -       vq->packed.used_wrap_counter =3D 1;
> >         vq->packed.event_flags_shadow =3D 0;
> >         vq->packed.avail_used_flags =3D 1 << VRING_PACKED_DESC_F_AVAIL;
> >
> > diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virt=
io_ring.h
> > index 476d3e5c0fe7..96bcc4d52fce 100644
> > --- a/include/uapi/linux/virtio_ring.h
> > +++ b/include/uapi/linux/virtio_ring.h
> > @@ -77,6 +77,12 @@
> >   */
> >  #define VRING_PACKED_EVENT_F_WRAP_CTR  15
> >
> > +
> > +/*
> > + * used wrap Counter bit shift in vq->last_used_idx for packed ring
> > + */
> > +#define VRING_PACKED_USED_INDEX_F_WRAP_CTR  15
>
> Let's simply reuse VRING_PACKED_EVENT_F_WRAP_CTR ?
>
> Thanks

Although the two values are the same, I see the meanings are different,
so I redefine one. Is it possible to rename
VRING_PACKED_EVENT_F_WRAP_CTR to VRING_PACKED_F_WRAP_CTR?

Jason, what is your take?

>
> > +
> >  /* We support indirect buffer descriptors */
> >  #define VIRTIO_RING_F_INDIRECT_DESC    28
> >
> > --
> > 2.31.1
> >
>
