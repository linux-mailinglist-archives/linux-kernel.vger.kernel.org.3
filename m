Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6320D4A82B4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 11:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344060AbiBCKvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 05:51:24 -0500
Received: from foss.arm.com ([217.140.110.172]:38456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230016AbiBCKvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 05:51:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7738A113E;
        Thu,  3 Feb 2022 02:51:23 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBAC73F774;
        Thu,  3 Feb 2022 02:51:21 -0800 (PST)
Date:   Thu, 3 Feb 2022 10:51:19 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 3/9] [RFC] virtio_ring: Embed a wrap counter in opaque
 poll index value
Message-ID: <20220203105105.GB2535@e120937-lin>
References: <20220201171601.53316-1-cristian.marussi@arm.com>
 <20220201171601.53316-4-cristian.marussi@arm.com>
 <20220201131434-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201131434-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 01:27:38PM -0500, Michael S. Tsirkin wrote:
> Looks correct, thanks. Some minor comments below:
> 

Hi Michael,

thanks for the feedback.

> On Tue, Feb 01, 2022 at 05:15:55PM +0000, Cristian Marussi wrote:
> > Exported API virtqueue_poll() can be used to support polling mode operation
> > on top of virtio layer if needed; currently the parameter last_used_idx is
> > the opaque value that needs to be passed to the virtqueue_poll() function
> > to check if there are new pending used buffers in the queue: such opaque
> > value would have been previously obtained by a call to the API function
> > virtqueue_enable_cb_prepare().
> > 
> > Since such opaque value is indeed containing simply a snapshot in time of
> > the internal
> 
> to add: 16 bit
> 
> > last_used_index (roughly), it is possible that,
> 
> to add here: 
> 
> if another thread calls virtqueue_add_*()
> at the same time (which existing drivers don't do,
> but does not seem to be documented as prohibited anywhere), and
> 
> > if exactly
> > 2**16 buffers are marked as used between two successive calls to
> > virtqueue_poll(), the caller is fooled into thinking that nothing is
> > pending (ABA problem).
> > Keep a full fledged internal wraps counter
> 
> s/full fledged/a 16 bit/
> 
> since I don't see why is a 16 bit counter full but not e.g. a 32 bit one
> 
.. :D I wanted to stress the fact that this being a 16bits counter has a
higher rollover than a 1-bit one wrap_counter already used...but indeed
all are just counters at the end, it's justthe wrapround that changes...

I'll fix.

> > per virtqueue and embed it into
> > the upper 16bits of the returned opaque value, so that the above scenario
> > can be detected transparently by virtqueue_poll(): this way each single
> > possible last_used_idx value is really belonging to a different wrap.
> 
> Just to add here: the ABA problem can in theory still happen but
> now that's after 2^32 requests, which seems sufficient in practice.
> 

Sure, I'll fix the commit message as above advised.

> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
> > Cc: Peter Hilber <peter.hilber@opensynergy.com>
> > Cc: virtualization@lists.linux-foundation.org
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > Still no perf data on this, I was wondering what exactly to measure in
> > term of perf metrics to evaluate the impact of the rolling vq->wraps
> > counter.
> > ---
> >  drivers/virtio/virtio_ring.c | 51 +++++++++++++++++++++++++++++++++---
> >  1 file changed, 47 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 00f64f2f8b72..613ec0503509 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -12,6 +12,8 @@
> >  #include <linux/hrtimer.h>
> >  #include <linux/dma-mapping.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/bits.h>
> > +#include <linux/bitfield.h>
> >  #include <xen/xen.h>
> >  
> >  static bool force_used_validation = false;
> > @@ -69,6 +71,17 @@ module_param(force_used_validation, bool, 0444);
> >  #define LAST_ADD_TIME_INVALID(vq)
> >  #endif
> >  
> > +#define VRING_IDX_MASK					GENMASK(15, 0)
> > +#define VRING_GET_IDX(opaque)				\
> > +	((u16)FIELD_GET(VRING_IDX_MASK, (opaque)))
> > +
> > +#define VRING_WRAPS_MASK				GENMASK(31, 16)
> > +#define VRING_GET_WRAPS(opaque)				\
> > +	((u16)FIELD_GET(VRING_WRAPS_MASK, (opaque)))
> > +
> > +#define VRING_BUILD_OPAQUE(idx, wraps)			\
> > +	(FIELD_PREP(VRING_WRAPS_MASK, (wraps)) | ((idx) & VRING_IDX_MASK))
> > +
> 
> Maybe prefix with VRING_POLL_  since that is the only user.
> 

I'll do.

> 
> >  struct vring_desc_state_split {
> >  	void *data;			/* Data for callback. */
> >  	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
> > @@ -117,6 +130,8 @@ struct vring_virtqueue {
> >  	/* Last used index we've seen. */
> >  	u16 last_used_idx;
> >  
> > +	u16 wraps;
> > +
> >  	/* Hint for event idx: already triggered no need to disable. */
> >  	bool event_triggered;
> >  
> > @@ -806,6 +821,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> >  	ret = vq->split.desc_state[i].data;
> >  	detach_buf_split(vq, i, ctx);
> >  	vq->last_used_idx++;
> > +	if (unlikely(!vq->last_used_idx))
> > +		vq->wraps++;
> >  	/* If we expect an interrupt for the next entry, tell host
> >  	 * by writing event index and flush out the write before
> >  	 * the read in the next get_buf call. */
> 
> So most drivers don't call virtqueue_poll.
> Concerned about the overhead here: another option is
> with a flag that will have to be set whenever a driver
> wants to use virtqueue_poll.

Do you mean a compile time flag/Kconfig to just remove the possible
overhead instructions as a whole when not needed by the driver ?

Or do you mean at runtime since checking the flag evry time should be
less costly than checking the wrpas each time AND counting when it
happens ?

> Could you pls do a quick perf test e.g. using tools/virtio/
> to see what's faster?

Yes I'll do, thanks for the hint, I have some compilation issues in
tools/virtio due to my additions (missing mirrored hehaders) or to some
recently added stuff (missing drv_to_virtio & friends for
suppressed_used_validation thing)...anyway I fixed those now and I'll
post related tools/virtio patches with next iteration.

Anyway, do you mean perf data about vringh_test and virtio_test/vhost
right ? (ringtest/ excluded 'cause does not use any API is just
prototyping)

> 
> 
> 
> > @@ -1508,6 +1525,7 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> >  	if (unlikely(vq->last_used_idx >= vq->packed.vring.num)) {
> >  		vq->last_used_idx -= vq->packed.vring.num;
> >  		vq->packed.used_wrap_counter ^= 1;
> > +		vq->wraps++;
> >  	}
> >  
> >  	/*
> > @@ -1744,6 +1762,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >  	vq->weak_barriers = weak_barriers;
> >  	vq->broken = false;
> >  	vq->last_used_idx = 0;
> > +	vq->wraps = 0;
> >  	vq->event_triggered = false;
> >  	vq->num_added = 0;
> >  	vq->packed_ring = true;
> > @@ -2092,13 +2111,17 @@ EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
> >   */
> >  unsigned virtqueue_enable_cb_prepare(struct virtqueue *_vq)
> >  {
> > +	unsigned int last_used_idx;
> >  	struct vring_virtqueue *vq = to_vvq(_vq);
> >  
> >  	if (vq->event_triggered)
> >  		vq->event_triggered = false;
> >  
> > -	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) :
> > -				 virtqueue_enable_cb_prepare_split(_vq);
> > +	last_used_idx = vq->packed_ring ?
> > +			virtqueue_enable_cb_prepare_packed(_vq) :
> > +			virtqueue_enable_cb_prepare_split(_vq);
> > +
> > +	return VRING_BUILD_OPAQUE(last_used_idx, vq->wraps);
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
> >  
> > @@ -2107,6 +2130,21 @@ EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
> >   * @_vq: the struct virtqueue we're talking about.
> >   * @last_used_idx: virtqueue state (from call to virtqueue_enable_cb_prepare).
> >   *
> > + * The provided last_used_idx, as returned by virtqueue_enable_cb_prepare(),
> > + * is an opaque value representing the queue state and it is built as follows:
> > + *
> > + *	---------------------------------------------------------
> > + *	|	vq->wraps	|	vq->last_used_idx	|
> > + *	31------------------------------------------------------0
> > + *
> > + * The MSB 16bits embedding the wraps counter for the underlying virtqueue
> > + * is stripped out here before reaching into the lower layer helpers.
> > + *
> > + * This structure of the opaque value mitigates the scenario in which, when
> > + * exactly 2**16 messages are marked as used between two successive calls to
> > + * virtqueue_poll(), the caller is fooled into thinking nothing new has arrived
> > + * since the pure last_used_idx is exactly the same.
> > + *
> 
> Do you want to move this comment to where the macros implementing it
> are?
> 

Sure, I'll do.

Thanks,
Cristian

