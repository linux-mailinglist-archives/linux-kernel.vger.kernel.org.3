Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC95497570
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 21:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbiAWUDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 15:03:10 -0500
Received: from foss.arm.com ([217.140.110.172]:34486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235124AbiAWUDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 15:03:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70EA9ED1;
        Sun, 23 Jan 2022 12:03:07 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 312C63F766;
        Sun, 23 Jan 2022 12:03:04 -0800 (PST)
Date:   Sun, 23 Jan 2022 20:02:54 +0000
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
Message-ID: <20220123200254.GF6113@e120937-lin>
References: <20211220195646.44498-10-cristian.marussi@arm.com>
 <20211221140027.41524-1-cristian.marussi@arm.com>
 <f231094a-6f34-3dc1-237d-97218e8fde91@opensynergy.com>
 <20220119122338.GE6113@e120937-lin>
 <2f1ea794-a0b9-2099-edc0-b2aeb3ca6b92@opensynergy.com>
 <20220120150418-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120150418-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 03:39:12PM -0500, Michael S. Tsirkin wrote:
> On Thu, Jan 20, 2022 at 08:09:56PM +0100, Peter Hilber wrote:
> > On 19.01.22 13:23, Cristian Marussi wrote:
> > > On Tue, Jan 18, 2022 at 03:21:03PM +0100, Peter Hilber wrote:
> > >> On 21.12.21 15:00, Cristian Marussi wrote:
> > >>> Add support for .mark_txdone and .poll_done transport operations to SCMI
> > >>> VirtIO transport as pre-requisites to enable atomic operations.
> > >>>
> > >>> Add a Kernel configuration option to enable SCMI VirtIO transport polling
> > >>> and atomic mode for selected SCMI transactions while leaving it default
> > >>> disabled.
> > >>>
> > >>
> > >> Hi Cristian,
> > >>
> > >> thanks for the update. I have some more remarks inline below.
> > >>
> > > 
> > > Hi Peter,
> > > 
> > > thanks for your review, much appreciated, please see my replies online.
> > > 
> > >> My impression is that the virtio core does not expose helper functions suitable
> > >> to busy-poll for used buffers. But changing this might not be difficult. Maybe
> > >> more_used() from virtio_ring.c could be exposed via a wrapper?
> > >>
> > > 
> > > While I definitely agree that the virtio core support for polling is far from
> > > ideal, some support is provided and my point was at first to try implement SCMI
> > > virtio polling leveraging what we have now in the core and see if it was attainable
> > > (indeed I tried early in this series to avoid as a whole to have to support polling
> > > at the SCMI transport layer to attain SCMI cmds atomicity..but that was an ill
> > > attempt that led nowhere good...)
> > > 
> > > Btw, I was planning to post a new series next week (after merge-windows) with some
> > > fixes I did already, at this point I'll include also some fixes derived
> > > from some of your remarks.
> > > 
> > >> Best regards,
> > >>
> > >> Peter
> > >>
> > [snip]>>> + *

Hi Michael, Peter

I'm gonna post another iteration of this (and some other dependent
patches) with a few fixes as pointed out by Peter but still without addressing
the ABA style race/issue we are talkig about.

A few comments iand a proposal on this ABA race below, though.

> > >>> + * Return: True once polling has successfully completed.
> > >>> + */
> > >>> +static bool virtio_poll_done(struct scmi_chan_info *cinfo,
> > >>> +			     struct scmi_xfer *xfer)
> > >>> +{
> > >>> +	bool pending, ret = false;
> > >>> +	unsigned int length, any_prefetched = 0;
> > >>> +	unsigned long flags;
> > >>> +	struct scmi_vio_msg *next_msg, *msg = xfer->priv;
> > >>> +	struct scmi_vio_channel *vioch = cinfo->transport_info;
> > >>> +
> > >>> +	if (!msg)
> > >>> +		return true;
> > >>> +
> > >>> +	spin_lock_irqsave(&msg->poll_lock, flags);
> > >>> +	/* Processed already by other polling loop on another CPU ? */
> > >>> +	if (msg->poll_idx == VIO_MSG_POLL_DONE) {
> > >>> +		spin_unlock_irqrestore(&msg->poll_lock, flags);
> > >>> +		return true;
> > >>> +	}
> > >>> +
> > >>> +	/* Has cmdq index moved at all ? */
> > >>> +	pending = virtqueue_poll(vioch->vqueue, msg->poll_idx);
> > >>
> > >> In my understanding, the polling comparison could still be subject to the ABA
> > >> problem when exactly 2**16 messages have been marked as used since
> > >> msg->poll_idx was set (unlikely scenario, granted).
> > >>
> > >> I think this would be a lot simpler if the virtio core exported some
> > >> concurrency-safe helper function for such polling (similar to more_used() from
> > >> virtio_ring.c), as discussed at the top.
> > > 
> > > So this is the main limitation indeed of the current implementation, I
> > > cannot distinguish if there was an exact full wrap and I'm reading the same
> > > last_idx as before but a whoppying 2**16 messages have instead gone through...
> > > 
> > > The tricky part seems to me here that even introducing dedicated helpers
> > > for polling in order to account for such wrapping (similar to more_used())
> > > those would be based by current VirtIO spec on a single bit wrap counter,
> > > so how do you discern if 2 whole wraps have happened (even more unlikely..) ?
> > > 
> > > Maybe I'm missing something though...
> > > 
> > 
> > In my understanding, there is no need to keep track of the old state. We
> > actually only want to check whether the device has marked any buffers as `used'
> > which we did not retrieve yet via virtqueue_get_buf_ctx().
> > 
> > This is what more_used() checks in my understanding. One would just need to
> > translate the external `struct virtqueue' param to the virtio_ring.c internal
> > representation `struct vring_virtqueue' and then call `more_used()'.
> > 
> > There would be no need to keep `poll_idx` then.
> > 
> > Best regards,
> > 
> > Peter
> 
> Not really, I don't think so.
> 
> There's no magic in more_used. No synchronization happens.
> more_used is exactly like virtqueue_poll except
> you get to maintain your own index.
> 
> As it is, it is quite possible to read the cached index,
> then another thread makes 2^16 bufs available, then device
> uses them all, and presto you get a false positive.
> 
> I guess we can play with memory barriers such that cache
> read happens after the index read - but it seems that
> will just lead to the same wrap around problem
> in reverse. So IIUC it's quite a bit more involved than
> just translating structures.
> 
> And yes, a more_used like API would remove the need to pass
> the index around, but it will also obscure the fact that
> there's internal state here and that it's inherently racy
> wrt wrap arounds. Whereas I'm happy to see that virtqueue_poll
> seems to have made it clear enough that people get it.
> 
> 
> It's not hard to handle wrap around in the driver if you like though:
> just have a 32 bit atomic counter and increment it each time you are
> going to make 2^16 buffers available. That gets you to 2^48 with an
> overhead of an atomic read and that should be enough short term. Make
> sure the cache line where you put the counter is not needed elsewhere -
> checking it in a tight loop with an atomic will force it to the local
> CPU. And if you are doing that virtqueue_poll will be enough.
> 
>

I was thinking...keeping the current virtqueue_poll interface, since our
possible issue arises from the used_index wrapping around exactly on top
of the same polled index and given that currently the API returns an
unsigned "opaque" value really carrying just the 16-bit index (and possibly
the wrap bit as bit15 for packed vq) that is supposed to be fed back as
it is to the virtqueue_poll() function....

...why don't we just keep an internal full fledged per-virtqueue wrap-counter
and return that as the MSB 16-bit of the opaque value returned by
virtqueue_prepare_enable_cb and then check it back in virtqueue_poll when the
opaque is fed back ? (filtering it out from the internal helpers machinery)

As in the example below the scissors.

I mean if the internal wrap count is at that point different from the
one provided to virtqueue_poll() via the opaque poll_idx value previously
provided, certainly there is something new to fetch without even looking
at the indexes: at the same time, exposing an opaque index built as
(wraps << 16 | idx) implicitly 'binds' each index to a specific
wrap-iteration, so they can be distiguished (..ok until the wrap-count
upper 16bit wraps too....but...)

I am not really extremely familiar with the internals of virtio so I
could be missing something obvious...feel free to insult me :P

(..and I have not made any perf measurements or consideration at this
point....nor considered the redundancy of the existent packed
used_wrap_counter bit...)

Thanks,
Cristian

----

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 00f64f2f8b72..bda6af121cd7 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -117,6 +117,8 @@ struct vring_virtqueue {
        /* Last used index we've seen. */
        u16 last_used_idx;
 
+       u16 wraps;
+
        /* Hint for event idx: already triggered no need to disable. */
        bool event_triggered;
 
@@ -806,6 +808,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
        ret = vq->split.desc_state[i].data;
        detach_buf_split(vq, i, ctx);
        vq->last_used_idx++;
+       if (unlikely(!vq->last_used_idx))
+               vq->wraps++;
        /* If we expect an interrupt for the next entry, tell host
         * by writing event index and flush out the write before
         * the read in the next get_buf call. */
@@ -1508,6 +1512,7 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
        if (unlikely(vq->last_used_idx >= vq->packed.vring.num)) {
                vq->last_used_idx -= vq->packed.vring.num;
                vq->packed.used_wrap_counter ^= 1;
+               vq->wraps++;
        }
 
        /*
@@ -1744,6 +1749,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
        vq->weak_barriers = weak_barriers;
        vq->broken = false;
        vq->last_used_idx = 0;
+       vq->wraps = 0;
        vq->event_triggered = false;
        vq->num_added = 0;
        vq->packed_ring = true;
@@ -2092,13 +2098,17 @@ EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
  */
 unsigned virtqueue_enable_cb_prepare(struct virtqueue *_vq)
 {
+       unsigned last_used_idx;
        struct vring_virtqueue *vq = to_vvq(_vq);
 
        if (vq->event_triggered)
                vq->event_triggered = false;
 
-       return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) :
-                                virtqueue_enable_cb_prepare_split(_vq);
+       last_used_idx = vq->packed_ring ?
+                       virtqueue_enable_cb_prepare_packed(_vq) :
+                       virtqueue_enable_cb_prepare_split(_vq);
+
+       return VRING_BUILD_OPAQUE(last_used_idx, vq->wraps);
 }
 EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
 
@@ -2118,9 +2128,13 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned last_used_idx)
        if (unlikely(vq->broken))
                return false;
 
+       if (unlikely(vq->wraps != VRING_GET_WRAPS(last_used_idx)))
+               return true;
+
        virtio_mb(vq->weak_barriers);
-       return vq->packed_ring ? virtqueue_poll_packed(_vq, last_used_idx) :
-                                virtqueue_poll_split(_vq, last_used_idx);
+       return vq->packed_ring ?
+               virtqueue_poll_packed(_vq, VRING_GET_IDX(last_used_idx)) :
+                       virtqueue_poll_split(_vq, VRING_GET_IDX(last_used_idx));
 }
 EXPORT_SYMBOL_GPL(virtqueue_poll);
 
@@ -2245,6 +2259,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
        vq->weak_barriers = weak_barriers;
        vq->broken = false;
        vq->last_used_idx = 0;
+       vq->wraps = 0;
        vq->event_triggered = false;
        vq->num_added = 0;
        vq->use_dma_api = vring_use_dma_api(vdev);
diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index 476d3e5c0fe7..e6b03017ebd7 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -77,6 +77,17 @@
  */
 #define VRING_PACKED_EVENT_F_WRAP_CTR  15
 
+#define VRING_IDX_MASK                                 GENMASK(15, 0)
+#define VRING_GET_IDX(opaque)                          \
+       ((u16)FIELD_GET(VRING_IDX_MASK, (opaque)))
+
+#define VRING_WRAPS_MASK                               GENMASK(31, 16)
+#define VRING_GET_WRAPS(opaque)                                \
+       ((u16)FIELD_GET(VRING_WRAPS_MASK, (opaque)))
+
+#define VRING_BUILD_OPAQUE(idx, wraps)                 \
+       (FIELD_PREP(VRING_WRAPS_MASK, (wraps)) | ((idx) & VRING_IDX_MASK))
+
 /* We support indirect buffer descriptors */
 #define VIRTIO_RING_F_INDIRECT_DESC    28

