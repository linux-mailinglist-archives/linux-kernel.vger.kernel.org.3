Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191DC49761B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 23:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240396AbiAWWqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 17:46:02 -0500
Received: from foss.arm.com ([217.140.110.172]:38140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230077AbiAWWqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 17:46:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79BB71FB;
        Sun, 23 Jan 2022 14:45:59 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CD1F3F774;
        Sun, 23 Jan 2022 14:45:57 -0800 (PST)
Date:   Sun, 23 Jan 2022 22:45:54 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Peter Hilber <peter.hilber@opensynergy.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v9 09/11] firmware: arm_scmi: Add atomic mode support to
 virtio transport
Message-ID: <20220123224554.GG6113@e120937-lin>
References: <20211220195646.44498-10-cristian.marussi@arm.com>
 <20211221140027.41524-1-cristian.marussi@arm.com>
 <f231094a-6f34-3dc1-237d-97218e8fde91@opensynergy.com>
 <20220119122338.GE6113@e120937-lin>
 <2f1ea794-a0b9-2099-edc0-b2aeb3ca6b92@opensynergy.com>
 <20220120150418-mutt-send-email-mst@kernel.org>
 <20220123200254.GF6113@e120937-lin>
 <20220123172950-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123172950-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 05:40:08PM -0500, Michael S. Tsirkin wrote:
> On Sun, Jan 23, 2022 at 08:02:54PM +0000, Cristian Marussi wrote:
> > I was thinking...keeping the current virtqueue_poll interface, since our
> > possible issue arises from the used_index wrapping around exactly on top
> > of the same polled index and given that currently the API returns an
> > unsigned "opaque" value really carrying just the 16-bit index (and possibly
> > the wrap bit as bit15 for packed vq) that is supposed to be fed back as
> > it is to the virtqueue_poll() function....
> > 
> > ...why don't we just keep an internal full fledged per-virtqueue wrap-counter
> > and return that as the MSB 16-bit of the opaque value returned by
> > virtqueue_prepare_enable_cb and then check it back in virtqueue_poll when the
> > opaque is fed back ? (filtering it out from the internal helpers machinery)
> > 
> > As in the example below the scissors.
> > 
> > I mean if the internal wrap count is at that point different from the
> > one provided to virtqueue_poll() via the opaque poll_idx value previously
> > provided, certainly there is something new to fetch without even looking
> > at the indexes: at the same time, exposing an opaque index built as
> > (wraps << 16 | idx) implicitly 'binds' each index to a specific
> > wrap-iteration, so they can be distiguished (..ok until the wrap-count
> > upper 16bit wraps too....but...)
> > 
> > I am not really extremely familiar with the internals of virtio so I
> > could be missing something obvious...feel free to insult me :P
> > 
> > (..and I have not made any perf measurements or consideration at this
> > point....nor considered the redundancy of the existent packed
> > used_wrap_counter bit...)
> > 
> > Thanks,
> > Cristian
> > 
> > ----
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 00f64f2f8b72..bda6af121cd7 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -117,6 +117,8 @@ struct vring_virtqueue {
> >         /* Last used index we've seen. */
> >         u16 last_used_idx;
> >  
> > +       u16 wraps;
> > +
> >         /* Hint for event idx: already triggered no need to disable. */
> >         bool event_triggered;
> >  
> > @@ -806,6 +808,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> >         ret = vq->split.desc_state[i].data;
> >         detach_buf_split(vq, i, ctx);
> >         vq->last_used_idx++;
> > +       if (unlikely(!vq->last_used_idx))
> > +               vq->wraps++;
> 
> I wonder whether
>                vq->wraps += !vq->last_used_idx;
> is faster or slower. No branch but OTOH a dependency.
> 
> 
> >         /* If we expect an interrupt for the next entry, tell host
> >          * by writing event index and flush out the write before
> >          * the read in the next get_buf call. */
> > @@ -1508,6 +1512,7 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> >         if (unlikely(vq->last_used_idx >= vq->packed.vring.num)) {
> >                 vq->last_used_idx -= vq->packed.vring.num;
> >                 vq->packed.used_wrap_counter ^= 1;
> > +               vq->wraps++;
> >         }
> >  
> >         /*
> > @@ -1744,6 +1749,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >         vq->weak_barriers = weak_barriers;
> >         vq->broken = false;
> >         vq->last_used_idx = 0;
> > +       vq->wraps = 0;
> >         vq->event_triggered = false;
> >         vq->num_added = 0;
> >         vq->packed_ring = true;
> > @@ -2092,13 +2098,17 @@ EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
> >   */
> >  unsigned virtqueue_enable_cb_prepare(struct virtqueue *_vq)
> >  {
> > +       unsigned last_used_idx;
> >         struct vring_virtqueue *vq = to_vvq(_vq);
> >  
> >         if (vq->event_triggered)
> >                 vq->event_triggered = false;
> >  
> > -       return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) :
> > -                                virtqueue_enable_cb_prepare_split(_vq);
> > +       last_used_idx = vq->packed_ring ?
> > +                       virtqueue_enable_cb_prepare_packed(_vq) :
> > +                       virtqueue_enable_cb_prepare_split(_vq);
> > +
> > +       return VRING_BUILD_OPAQUE(last_used_idx, vq->wraps);
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
> >  
> > @@ -2118,9 +2128,13 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned last_used_idx)
> >         if (unlikely(vq->broken))
> >                 return false;
> >  
> > +       if (unlikely(vq->wraps != VRING_GET_WRAPS(last_used_idx)))
> > +               return true;
> > +
> >         virtio_mb(vq->weak_barriers);
> > -       return vq->packed_ring ? virtqueue_poll_packed(_vq, last_used_idx) :
> > -                                virtqueue_poll_split(_vq, last_used_idx);
> > +       return vq->packed_ring ?
> > +               virtqueue_poll_packed(_vq, VRING_GET_IDX(last_used_idx)) :
> > +                       virtqueue_poll_split(_vq, VRING_GET_IDX(last_used_idx));
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_poll);
> >  
> > @@ -2245,6 +2259,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> >         vq->weak_barriers = weak_barriers;
> >         vq->broken = false;
> >         vq->last_used_idx = 0;
> > +       vq->wraps = 0;
> >         vq->event_triggered = false;
> >         vq->num_added = 0;
> >         vq->use_dma_api = vring_use_dma_api(vdev);
> > diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> > index 476d3e5c0fe7..e6b03017ebd7 100644
> > --- a/include/uapi/linux/virtio_ring.h
> > +++ b/include/uapi/linux/virtio_ring.h
> > @@ -77,6 +77,17 @@
> >   */
> >  #define VRING_PACKED_EVENT_F_WRAP_CTR  15
> >  
> > +#define VRING_IDX_MASK                                 GENMASK(15, 0)
> > +#define VRING_GET_IDX(opaque)                          \
> > +       ((u16)FIELD_GET(VRING_IDX_MASK, (opaque)))
> > +
> > +#define VRING_WRAPS_MASK                               GENMASK(31, 16)
> > +#define VRING_GET_WRAPS(opaque)                                \
> > +       ((u16)FIELD_GET(VRING_WRAPS_MASK, (opaque)))
> > +
> > +#define VRING_BUILD_OPAQUE(idx, wraps)                 \
> > +       (FIELD_PREP(VRING_WRAPS_MASK, (wraps)) | ((idx) & VRING_IDX_MASK))
> > +
> >  /* We support indirect buffer descriptors */
> >  #define VIRTIO_RING_F_INDIRECT_DESC    28
> 
> Yea I think this patch increases the time it takes to wrap around from
> 2^16 to 2^32 which seems good enough.
> Need some comments to explain the logic.
> Would be interesting to see perf data.
> 

Thanks for your feedback !

I'll try to gather some perf data around it next days.
(and eventually cleanup and adding comments if it is god enough...)

Thanks,
Cristian

