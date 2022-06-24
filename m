Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5024755934B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 08:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiFXGXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 02:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiFXGXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 02:23:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52B8F38B7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 23:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656051799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e/ivYxAMfggPbkQhef/AlBbsVkIIj7YA57YGPWnP6cg=;
        b=GzYuVFuiILJzJ9eJRfk/VyWM0GD6FFrCO+32q80B1FnQLgCU3Ki/BrDNudLajdxRxaWANH
        /rYQnKIeaOmeg7F6XXg9E+8qUJ42Bz6NaVzBZeOIbx14R+jb091Y60j+l1AAb76yL4Bc2v
        5OfUYmLGImJ7WKUrDSLLilR4vw9+6nA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43-ZAGXRt44NXirtFEcP6Yptw-1; Fri, 24 Jun 2022 02:23:17 -0400
X-MC-Unique: ZAGXRt44NXirtFEcP6Yptw-1
Received: by mail-wm1-f72.google.com with SMTP id j20-20020a05600c1c1400b0039c747a1e5aso980199wms.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 23:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=e/ivYxAMfggPbkQhef/AlBbsVkIIj7YA57YGPWnP6cg=;
        b=ldqPX5YC+GmaBxaRYkUU2tVIv7PFhh+2AjZOqFx74A5INVKunF/d1mx+VZrQzXhOwL
         t1neETCAJvdXaIunjsRPUVduw8Q/J1L3b/NOtqTjN1p8Ak4H8YeLA8kUan0y0hzlw7IG
         rW7EwyBaidadd5O3Rwe5uJ77zyZPvBJORkkC1dSEnpaWU0PyA575SkFMGlmGWthLaJVV
         ApYN+tIfyigs/aUFLkt4QYpwijuDDsh6iScioVE3lzWw8zzvtmoqHSpWp/hN6QOku44n
         WbrRZBvJq/xJIqQocrK/7ZxPIoJQrUbvAyp8WXHXnlyJYrV1MX7e9iuFJ7YBGFlBN42D
         vPew==
X-Gm-Message-State: AJIora8r3gdJNOTQr1eZRuc+zQXjO7AGwwdBQPRp0vUh2fL1GigUBqit
        0mwu98qDCOGK/ngWHafeOiW/sDwUKYAjnggWPdt8VU9O8RsfoQZ1W7Ols6zFivwWUX+6zi15gww
        wgsGN4noCTitoogsy3plVPNfn
X-Received: by 2002:a1c:4d0a:0:b0:3a0:2d95:49d3 with SMTP id o10-20020a1c4d0a000000b003a02d9549d3mr1832917wmh.44.1656051796385;
        Thu, 23 Jun 2022 23:23:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vXk8MoM3bKuxlq8MYAnwn3uELmc7TcCW0NDyFVgA6fjBwDNdzTxw+OdBRVCVTmghHkUr8QeA==
X-Received: by 2002:a1c:4d0a:0:b0:3a0:2d95:49d3 with SMTP id o10-20020a1c4d0a000000b003a02d9549d3mr1832887wmh.44.1656051796045;
        Thu, 23 Jun 2022 23:23:16 -0700 (PDT)
Received: from redhat.com ([2.55.188.216])
        by smtp.gmail.com with ESMTPSA id l17-20020a5d5611000000b002101ed6e70fsm1350571wrv.37.2022.06.23.23.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 23:23:15 -0700 (PDT)
Date:   Fri, 24 Jun 2022 02:23:11 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        yuanzhu@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] virtio_ring : keep used_wrap_counter in
 vq->last_used_idx
Message-ID: <20220624022136-mutt-send-email-mst@kernel.org>
References: <20220616101823-mutt-send-email-mst@kernel.org>
 <20220617020411.80367-1-huangjie.albert@bytedance.com>
 <CACGkMEutq89farjWTdPY8R8wq8gCJLU2SWJrv+x=pPA5fv6+Uw@mail.gmail.com>
 <20220622081543-mutt-send-email-mst@kernel.org>
 <CACGkMEtaAFN+ntKvbbGYNf2O_-wSgc+Z4VVETVBEBNJi4bz9oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtaAFN+ntKvbbGYNf2O_-wSgc+Z4VVETVBEBNJi4bz9oA@mail.gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 09:30:47AM +0800, Jason Wang wrote:
> On Wed, Jun 22, 2022 at 8:16 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jun 22, 2022 at 04:51:22PM +0800, Jason Wang wrote:
> > > On Fri, Jun 17, 2022 at 10:04 AM Albert Huang
> > > <huangjie.albert@bytedance.com> wrote:
> > > >
> > > > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> > > >
> > > > the used_wrap_counter and the vq->last_used_idx may get
> > > > out of sync if they are separate assignment，and interrupt
> > > > might use an incorrect value to check for the used index.
> > > >
> > > > for example:OOB access
> > > > ksoftirqd may consume the packet and it will call:
> > > > virtnet_poll
> > > >         -->virtnet_receive
> > > >                 -->virtqueue_get_buf_ctx
> > > >                         -->virtqueue_get_buf_ctx_packed
> > > > and in virtqueue_get_buf_ctx_packed:
> > > >
> > > > vq->last_used_idx += vq->packed.desc_state[id].num;
> > > > if (unlikely(vq->last_used_idx >= vq->packed.vring.num)) {
> > > >          vq->last_used_idx -= vq->packed.vring.num;
> > > >          vq->packed.used_wrap_counter ^= 1;
> > > > }
> > > >
> > > > if at the same time, there comes a vring interrupt，in vring_interrupt:
> > > > we will call:
> > > > vring_interrupt
> > > >         -->more_used
> > > >                 -->more_used_packed
> > > >                         -->is_used_desc_packed
> > > > in is_used_desc_packed, the last_used_idx maybe >= vq->packed.vring.num.
> > > > so this could case a memory out of bounds bug.
> > > >
> > > > this patch is to keep the used_wrap_counter in vq->last_used_idx
> > > > so we can get the correct value to check for used index in interrupt.
> > > >
> > > > v3->v4:
> > > > - use READ_ONCE/WRITE_ONCE to get/set vq->last_used_idx
> > > >
> > > > v2->v3:
> > > > - add inline function to get used_wrap_counter and last_used
> > > > - when use vq->last_used_idx, only read once
> > > >   if vq->last_used_idx is read twice, the values can be inconsistent.
> > > > - use last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR))
> > > >   to get the all bits below VRING_PACKED_EVENT_F_WRAP_CTR
> > > >
> > > > v1->v2:
> > > > - reuse the VRING_PACKED_EVENT_F_WRAP_CTR
> > > > - Remove parameter judgment in is_used_desc_packed,
> > > > because it can't be illegal
> > > >
> > > > Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> > > > ---
> > > >  drivers/virtio/virtio_ring.c | 75 ++++++++++++++++++++++--------------
> > > >  1 file changed, 47 insertions(+), 28 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > index 13a7348cedff..719fbbe716d6 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -111,7 +111,12 @@ struct vring_virtqueue {
> > > >         /* Number we've added since last sync. */
> > > >         unsigned int num_added;
> > > >
> > > > -       /* Last used index we've seen. */
> > > > +       /* Last used index  we've seen.
> > > > +        * for split ring, it just contains last used index
> > > > +        * for packed ring:
> > > > +        * bits up to VRING_PACKED_EVENT_F_WRAP_CTR include the last used index.
> > > > +        * bits from VRING_PACKED_EVENT_F_WRAP_CTR include the used wrap counter.
> > > > +        */
> > > >         u16 last_used_idx;
> > > >
> > > >         /* Hint for event idx: already triggered no need to disable. */
> > > > @@ -154,9 +159,6 @@ struct vring_virtqueue {
> > > >                         /* Driver ring wrap counter. */
> > > >                         bool avail_wrap_counter;
> > > >
> > > > -                       /* Device ring wrap counter. */
> > > > -                       bool used_wrap_counter;
> > > > -
> > > >                         /* Avail used flags. */
> > > >                         u16 avail_used_flags;
> > > >
> > > > @@ -973,6 +975,15 @@ static struct virtqueue *vring_create_virtqueue_split(
> > > >  /*
> > > >   * Packed ring specific functions - *_packed().
> > > >   */
> > > > +static inline bool packed_used_wrap_counter(u16 last_used_idx)
> > > > +{
> > > > +       return !!(last_used_idx & (1 << VRING_PACKED_EVENT_F_WRAP_CTR));
> > > > +}
> > > > +
> > > > +static inline u16 packed_last_used(u16 last_used_idx)
> > > > +{
> > > > +       return last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
> > > > +}
> > >
> > > Any reason we need a minus after the shift?
> >
> > The point is to say "all bits above VRING_PACKED_EVENT_F_WRAP_CTR".
> > Has no effect currently but will if last_used_idx is extended to 32 bit.
> 
> Ok, but we don't do this for other uses for VRING_PACKED_EVENT_F_WRAP_CTR.
> 
> I wonder how much value we do it only here.
> 
> Thanks

I don't care much either way. Feel free to go ahead and play with
different versions so see which works better.

> >
> >
> > > Others look good.
> > >
> > > Thanks
> > >
> > > >
> > > >  static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
> > > >                                      struct vring_desc_extra *extra)
> > > > @@ -1406,8 +1417,14 @@ static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
> > > >
> > > >  static inline bool more_used_packed(const struct vring_virtqueue *vq)
> > > >  {
> > > > -       return is_used_desc_packed(vq, vq->last_used_idx,
> > > > -                       vq->packed.used_wrap_counter);
> > > > +       u16 last_used;
> > > > +       u16 last_used_idx;
> > > > +       bool used_wrap_counter;
> > > > +
> > > > +       last_used_idx = READ_ONCE(vq->last_used_idx);
> > > > +       last_used = packed_last_used(last_used_idx);
> > > > +       used_wrap_counter = packed_used_wrap_counter(last_used_idx);
> > > > +       return is_used_desc_packed(vq, last_used, used_wrap_counter);
> > > >  }
> > > >
> > > >  static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> > > > @@ -1415,7 +1432,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> > > >                                           void **ctx)
> > > >  {
> > > >         struct vring_virtqueue *vq = to_vvq(_vq);
> > > > -       u16 last_used, id;
> > > > +       u16 last_used, id, last_used_idx;
> > > > +       bool used_wrap_counter;
> > > >         void *ret;
> > > >
> > > >         START_USE(vq);
> > > > @@ -1434,7 +1452,9 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> > > >         /* Only get used elements after they have been exposed by host. */
> > > >         virtio_rmb(vq->weak_barriers);
> > > >
> > > > -       last_used = vq->last_used_idx;
> > > > +       last_used_idx = READ_ONCE(vq->last_used_idx);
> > > > +       used_wrap_counter = packed_used_wrap_counter(last_used_idx);
> > > > +       last_used = packed_last_used(last_used_idx);
> > > >         id = le16_to_cpu(vq->packed.vring.desc[last_used].id);
> > > >         *len = le32_to_cpu(vq->packed.vring.desc[last_used].len);
> > > >
> > > > @@ -1451,12 +1471,15 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> > > >         ret = vq->packed.desc_state[id].data;
> > > >         detach_buf_packed(vq, id, ctx);
> > > >
> > > > -       vq->last_used_idx += vq->packed.desc_state[id].num;
> > > > -       if (unlikely(vq->last_used_idx >= vq->packed.vring.num)) {
> > > > -               vq->last_used_idx -= vq->packed.vring.num;
> > > > -               vq->packed.used_wrap_counter ^= 1;
> > > > +       last_used += vq->packed.desc_state[id].num;
> > > > +       if (unlikely(last_used >= vq->packed.vring.num)) {
> > > > +               last_used -= vq->packed.vring.num;
> > > > +               used_wrap_counter ^= 1;
> > > >         }
> > > >
> > > > +       last_used = (last_used | (used_wrap_counter << VRING_PACKED_EVENT_F_WRAP_CTR));
> > > > +       WRITE_ONCE(vq->last_used_idx, last_used);
> > > > +
> > > >         /*
> > > >          * If we expect an interrupt for the next entry, tell host
> > > >          * by writing event index and flush out the write before
> > > > @@ -1465,9 +1488,7 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> > > >         if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
> > > >                 virtio_store_mb(vq->weak_barriers,
> > > >                                 &vq->packed.vring.driver->off_wrap,
> > > > -                               cpu_to_le16(vq->last_used_idx |
> > > > -                                       (vq->packed.used_wrap_counter <<
> > > > -                                        VRING_PACKED_EVENT_F_WRAP_CTR)));
> > > > +                               cpu_to_le16(vq->last_used_idx));
> > > >
> > > >         LAST_ADD_TIME_INVALID(vq);
> > > >
> > > > @@ -1499,9 +1520,7 @@ static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
> > > >
> > > >         if (vq->event) {
> > > >                 vq->packed.vring.driver->off_wrap =
> > > > -                       cpu_to_le16(vq->last_used_idx |
> > > > -                               (vq->packed.used_wrap_counter <<
> > > > -                                VRING_PACKED_EVENT_F_WRAP_CTR));
> > > > +                       cpu_to_le16(vq->last_used_idx);
> > > >                 /*
> > > >                  * We need to update event offset and event wrap
> > > >                  * counter first before updating event flags.
> > > > @@ -1518,8 +1537,7 @@ static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
> > > >         }
> > > >
> > > >         END_USE(vq);
> > > > -       return vq->last_used_idx | ((u16)vq->packed.used_wrap_counter <<
> > > > -                       VRING_PACKED_EVENT_F_WRAP_CTR);
> > > > +       return vq->last_used_idx;
> > > >  }
> > > >
> > > >  static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
> > > > @@ -1537,7 +1555,7 @@ static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
> > > >  static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
> > > >  {
> > > >         struct vring_virtqueue *vq = to_vvq(_vq);
> > > > -       u16 used_idx, wrap_counter;
> > > > +       u16 used_idx, wrap_counter, last_used_idx;
> > > >         u16 bufs;
> > > >
> > > >         START_USE(vq);
> > > > @@ -1550,9 +1568,10 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
> > > >         if (vq->event) {
> > > >                 /* TODO: tune this threshold */
> > > >                 bufs = (vq->packed.vring.num - vq->vq.num_free) * 3 / 4;
> > > > -               wrap_counter = vq->packed.used_wrap_counter;
> > > > +               last_used_idx = READ_ONCE(vq->last_used_idx);
> > > > +               wrap_counter = packed_used_wrap_counter(last_used_idx);
> > > >
> > > > -               used_idx = vq->last_used_idx + bufs;
> > > > +               used_idx = packed_last_used(last_used_idx) + bufs;
> > > >                 if (used_idx >= vq->packed.vring.num) {
> > > >                         used_idx -= vq->packed.vring.num;
> > > >                         wrap_counter ^= 1;
> > > > @@ -1582,9 +1601,10 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
> > > >          */
> > > >         virtio_mb(vq->weak_barriers);
> > > >
> > > > -       if (is_used_desc_packed(vq,
> > > > -                               vq->last_used_idx,
> > > > -                               vq->packed.used_wrap_counter)) {
> > > > +       last_used_idx = READ_ONCE(vq->last_used_idx);
> > > > +       wrap_counter = packed_used_wrap_counter(last_used_idx);
> > > > +       used_idx = packed_last_used(last_used_idx);
> > > > +       if (is_used_desc_packed(vq, used_idx, wrap_counter)) {
> > > >                 END_USE(vq);
> > > >                 return false;
> > > >         }
> > > > @@ -1689,7 +1709,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
> > > >         vq->notify = notify;
> > > >         vq->weak_barriers = weak_barriers;
> > > >         vq->broken = true;
> > > > -       vq->last_used_idx = 0;
> > > > +       vq->last_used_idx = 0 | (1 << VRING_PACKED_EVENT_F_WRAP_CTR);
> > > >         vq->event_triggered = false;
> > > >         vq->num_added = 0;
> > > >         vq->packed_ring = true;
> > > > @@ -1720,7 +1740,6 @@ static struct virtqueue *vring_create_virtqueue_packed(
> > > >
> > > >         vq->packed.next_avail_idx = 0;
> > > >         vq->packed.avail_wrap_counter = 1;
> > > > -       vq->packed.used_wrap_counter = 1;
> > > >         vq->packed.event_flags_shadow = 0;
> > > >         vq->packed.avail_used_flags = 1 << VRING_PACKED_DESC_F_AVAIL;
> > > >
> > > > --
> > > > 2.31.1
> > > >
> >

