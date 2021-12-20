Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F90847B537
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhLTVau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:30:50 -0500
Received: from foss.arm.com ([217.140.110.172]:36448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhLTVas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:30:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B6AA1FB;
        Mon, 20 Dec 2021 13:30:48 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 411BF3F718;
        Mon, 20 Dec 2021 13:30:45 -0800 (PST)
Date:   Mon, 20 Dec 2021 21:30:42 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, "Michael S. Tsirkin" <mst@redhat.com>,
        Igor Skalkin <igor.skalkin@opensynergy.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v7 14/16] firmware: arm_scmi: Add atomic mode support to
 virtio transport
Message-ID: <20211220213042.GL6207@e120937-lin>
References: <20211129191156.29322-1-cristian.marussi@arm.com>
 <20211129191156.29322-15-cristian.marussi@arm.com>
 <75e651e9-a273-5bd1-c7f7-37a072ad6608@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75e651e9-a273-5bd1-c7f7-37a072ad6608@opensynergy.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 01:12:18PM +0100, Peter Hilber wrote:
> On 29.11.21 20:11, Cristian Marussi wrote:
> > Add support for .mark_txdone and .poll_done transport operations to SCMI
> > VirtIO transport as pre-requisites to enable atomic operations.
> > 
> 
> Hi Cristian,

Hi Peter,

> 
> I see no conceptual problems with this patch. Please find some inline
> remarks below.

Thanks a lot for your feedback, I addressed (hopefully) some of your
concerns in V8; see down below my replies inline.

> 
> Best regards,
> 
> Peter
> 
> > Add a Kernel configuration option to enable SCMI VirtIO transport polling
> > and atomic mode for selected SCMI transactions while leaving it default
> > disabled.
> > 
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
> > Cc: Peter Hilber <peter.hilber@opensynergy.com>
> > Cc: virtualization@lists.linux-foundation.org
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > V6 --> V7
> > - added a few comments about virtio polling internals
> > - fixed missing list_del on pending_cmds_list processing
> > - shrinked spinlocked areas in virtio_poll_done
> > - added proper spinlocking to scmi_vio_complete_cb while scanning list
> >   of pending cmds
> > ---
> >  drivers/firmware/arm_scmi/Kconfig  |  15 ++
> >  drivers/firmware/arm_scmi/virtio.c | 241 +++++++++++++++++++++++++++--
> >  2 files changed, 243 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> > index d429326433d1..7794bd41eaa0 100644
> > --- a/drivers/firmware/arm_scmi/Kconfig
> > +++ b/drivers/firmware/arm_scmi/Kconfig
> > @@ -118,6 +118,21 @@ config ARM_SCMI_TRANSPORT_VIRTIO_VERSION1_COMPLIANCE
> >  	  the ones implemented by kvmtool) and let the core Kernel VirtIO layer
> >  	  take care of the needed conversions, say N.
> >  
> > +config ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
> > +	bool "Enable atomic mode for SCMI VirtIO transport"
> > +	depends on ARM_SCMI_TRANSPORT_VIRTIO
> > +	help
> > +	  Enable support of atomic operation for SCMI VirtIO based transport.
> > +
> > +	  If you want the SCMI VirtIO based transport to operate in atomic
> > +	  mode, avoiding any kind of sleeping behaviour for selected
> > +	  transactions on the TX path, answer Y.
> > +
> > +	  Enabling atomic mode operations allows any SCMI driver using this
> > +	  transport to optionally ask for atomic SCMI transactions and operate
> > +	  in atomic context too, at the price of using a number of busy-waiting
> > +	  primitives all over instead. If unsure say N.
> > +
> >  endif #ARM_SCMI_PROTOCOL
> >  
> >  config ARM_SCMI_POWER_DOMAIN
> > diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
> > index fd0f6f91fc0b..0598e185a786 100644
> > --- a/drivers/firmware/arm_scmi/virtio.c
> > +++ b/drivers/firmware/arm_scmi/virtio.c
> > @@ -38,6 +38,7 @@
> >   * @vqueue: Associated virtqueue
> >   * @cinfo: SCMI Tx or Rx channel
> >   * @free_list: List of unused scmi_vio_msg, maintained for Tx channels only
> > + * @pending_cmds_list: List of pre-fetched commands queueud for later processing
> >   * @is_rx: Whether channel is an Rx channel
> >   * @ready: Whether transport user is ready to hear about channel
> >   * @max_msg: Maximum number of pending messages for this channel.
> > @@ -49,6 +50,9 @@ struct scmi_vio_channel {
> >  	struct virtqueue *vqueue;
> >  	struct scmi_chan_info *cinfo;
> >  	struct list_head free_list;
> > +#ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
> > +	struct list_head pending_cmds_list;
> > +#endif
> >  	bool is_rx;
> >  	bool ready;
> >  	unsigned int max_msg;
> > @@ -65,12 +69,22 @@ struct scmi_vio_channel {
> >   * @input: SDU used for (delayed) responses and notifications
> >   * @list: List which scmi_vio_msg may be part of
> >   * @rx_len: Input SDU size in bytes, once input has been received
> > + * @poll_idx: Last used index registered for polling purposes if this message
> > + *	      transaction reply was configured for polling.
> > + *	      Note that virtqueue used index is an unsigned 16-bit.
> > + * @poll_lock: Protect access to @poll_idx.
> >   */
> >  struct scmi_vio_msg {
> >  	struct scmi_msg_payld *request;
> >  	struct scmi_msg_payld *input;
> >  	struct list_head list;
> >  	unsigned int rx_len;
> > +#ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
> > +#define VIO_MSG_POLL_DONE	0xffffffffUL
> 
> virtqueue_enable_cb_prepare() returns an "opaque unsigned value", so
> this special value should not be used for .poll_idx.
> 

Yes you are right, but looking at comments in virtqueue_enable_cb_prepare()
and virtqueue_poll()

/**
 * virtqueue_enable_cb_prepare - restart callbacks after disable_cb
 *
 * This re-enables callbacks; it returns current queue state
 * in an opaque unsigned value. This value should be later tested by
 * virtqueue_poll, to detect a possible race between the driver
 * checking for more work, and enabling callbacks.


/**
 * virtqueue_poll - query pending used buffers
 * @_vq: the struct virtqueue we're talking about.
 * @last_used_idx: virtqueue state (from call to virtqueue_enable_cb_prepare).

... it seems to me that is exactly how I'm using it, and moreover I
don't see any other way via the VirtIO API to grab that last_used_idx
that I need for virtqueu_poll.


> > +	unsigned int poll_idx;
> > +	/* lock to protect access to poll_idx. */
> > +	spinlock_t poll_lock;
> > +#endif
> >  };
> >  
> >  /* Only one SCMI VirtIO device can possibly exist */
> > @@ -104,17 +118,22 @@ static int scmi_vio_feed_vq_rx(struct scmi_vio_channel *vioch,
> >  	return rc;
> >  }
> >  
> > +static inline void scmi_vio_feed_vq_tx(struct scmi_vio_channel *vioch,
> > +				       struct scmi_vio_msg *msg)
> > +{
> > +	/* Here IRQs are assumed to be already disabled by the caller */
> > +	spin_lock(&vioch->lock);
> > +	list_add(&msg->list, &vioch->free_list);
> > +	spin_unlock(&vioch->lock);
> > +}
> > +
> >  static void scmi_finalize_message(struct scmi_vio_channel *vioch,
> >  				  struct scmi_vio_msg *msg)
> >  {
> > -	if (vioch->is_rx) {
> > +	if (vioch->is_rx)
> >  		scmi_vio_feed_vq_rx(vioch, msg, vioch->cinfo->dev);
> > -	} else {
> > -		/* Here IRQs are assumed to be already disabled by the caller */
> > -		spin_lock(&vioch->lock);
> > -		list_add(&msg->list, &vioch->free_list);
> > -		spin_unlock(&vioch->lock);
> > -	}
> > +	else
> > +		scmi_vio_feed_vq_tx(vioch, msg);
> >  }
> >  
> >  static void scmi_vio_complete_cb(struct virtqueue *vqueue)
> > @@ -140,6 +159,26 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
> 
> Looks like this function could also scmi_rx_callback() for polled
> messages, which should probably not happen.
> 

Yes indeed, but that is by design :P ... let me explain.

Using VirtIO API I can poll on the last used index waiting for something
new to arrive but I cannot suppress IRQ/notify on selected messages
(like the one I poll..) because the only way to do it would be to
request IRQ/notify suppression for the whole virtqueue and this is
something I don't want to do since it would forcibly move to busy
waiting all the traffic on that vqueue. (...even though certainly IRQs
are suppressed when I disable/enable CBs...)

So, as a matter of fact, even while I am polling buisy-waiting for a
specific message to come back, maybe with IRQ locally disabled, it could
happen that my polled message is delivered on some other CPUs where IRQs
are not disabled (during that window in which CBs are enabled...)...

...but this is fine, since the whole SCMI stack accesses to the xfers
have been serialized with locks and if an scmi_rx_callback is called on
an xfer which I was polling on due to the IRQ being deliverd on another
CPU, the xfer will be properly filled with the data from the message
buffer AND the polling loop will be terminated too by scmi_rx_callback
(this was introduced since needed to handle  Out of Order message
delivery).

In other words even though most probably you'll complete your polling
transaction via poll_done, it is possible and handled that a polling
transaction is orderly completed instead by an IRQs delivered on another
core.

> >  
> >  		/* IRQs already disabled here no need to irqsave */
> >  		spin_lock(&vioch->lock);
> > +#ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
> > +		/* At first scan the list of possibly pre-fetched messages */
> > +		if (!vioch->is_rx) {
> > +			struct scmi_vio_msg *tmp;
> > +
> > +			list_for_each_entry_safe(msg, tmp,
> > +						 &vioch->pending_cmds_list,
> > +						 list) {
> > +				list_del(&msg->list);
> > +				spin_unlock(&vioch->lock);
> > +
> > +				scmi_rx_callback(vioch->cinfo,
> > +						 msg_read_header(msg->input),
> > +						 msg);
> > +				/* Free the processed message once done */
> > +				spin_lock(&vioch->lock);
> > +				list_add(&msg->list, &vioch->free_list);
> > +			}
> > +		}
> > +#endif
> >  		if (cb_enabled) {
> >  			virtqueue_disable_cb(vqueue);
> >  			cb_enabled = false;
> > @@ -257,6 +296,9 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
> >  						    GFP_KERNEL);
> >  			if (!msg->request)
> >  				return -ENOMEM;
> > +#ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
> > +			spin_lock_init(&msg->poll_lock);
> > +#endif
> >  		}
> >  
> >  		msg->input = devm_kzalloc(cinfo->dev, VIRTIO_SCMI_MAX_PDU_SIZE,
> > @@ -324,7 +366,8 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
> >  	}
> >  
> >  	msg = list_first_entry(&vioch->free_list, typeof(*msg), list);
> > -	list_del(&msg->list);
> > +	/* Re-init element so we can discern anytime if it is still in-flight */
> > +	list_del_init(&msg->list);
> >  
> >  	msg_tx_prepare(msg->request, xfer);
> >  
> > @@ -337,6 +380,20 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
> >  		dev_err(vioch->cinfo->dev,
> >  			"failed to add to TX virtqueue (%d)\n", rc);
> >  	} else {
> > +#ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
> > +		/*
> > +		 * If polling was requested for this transaction:
> > +		 *  - retrieve last used index (will be used as polling reference)
> > +		 *  - bind the polled message to the xfer via .priv
> > +		 */
> > +		if (xfer->hdr.poll_completion) {
> > +			spin_lock(&msg->poll_lock);
> > +			msg->poll_idx =
> > +				virtqueue_enable_cb_prepare(vioch->vqueue);
> > +			spin_unlock(&msg->poll_lock);
> > +			xfer->priv = msg;
> > +		}
> > +#endif
> >  		virtqueue_kick(vioch->vqueue);
> >  	}
> >  
> > @@ -350,10 +407,8 @@ static void virtio_fetch_response(struct scmi_chan_info *cinfo,
> >  {
> >  	struct scmi_vio_msg *msg = xfer->priv;
> >  
> > -	if (msg) {
> > +	if (msg)
> >  		msg_fetch_response(msg->input, msg->rx_len, xfer);
> > -		xfer->priv = NULL;
> > -	}
> >  }
> >  
> >  static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
> > @@ -361,11 +416,163 @@ static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
> >  {
> >  	struct scmi_vio_msg *msg = xfer->priv;
> >  
> > -	if (msg) {
> > +	if (msg)
> >  		msg_fetch_notification(msg->input, msg->rx_len, max_len, xfer);
> > -		xfer->priv = NULL;
> > +}
> > +
> > +#ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
> > +/**
> > + * virtio_mark_txdone  - Mark transmission done
> > + *
> > + * Free only successfully completed polling transfer messages.
> > + *
> > + * Note that in the SCMI VirtIO transport we never explicitly release timed-out
> > + * messages by forcibly re-adding them to the free-list on timeout inside the TX
> > + * code path; we instead let IRQ/RX callbacks eventually clean up such messages
> > + * once, finally, a late reply is received and discarded (if ever).
> > + *
> > + * This approach was deemed preferable since those pending timed-out buffers are
> > + * still effectively owned by the SCMI platform VirtIO device even after timeout
> > + * expiration: forcibly freeing and reusing them before they had beeen returned
> > + * by the SCMI platform could lead to subtle bugs due to message corruption.
> > + * An SCMI platform VirtIO device which never returns message buffers is
> > + * anyway broken and it will quickly lead to message exhaustion.
> > + *
> > + * For this same reason, here, we take care to free only the successfully
> > + * completed polled messages, since they won't be freed elsewhere; late replies
> > + * to timed-out polled messages would be anyway freed by RX callbacks instead.
> > + *
> > + * @cinfo: SCMI channel info
> > + * @ret: Transmission return code
> > + * @xfer: Transfer descriptor
> > + */
> > +static void virtio_mark_txdone(struct scmi_chan_info *cinfo, int ret,
> > +			       struct scmi_xfer *xfer)
> > +{
> > +	unsigned long flags;
> > +	struct scmi_vio_channel *vioch = cinfo->transport_info;
> > +	struct scmi_vio_msg *msg = xfer->priv;
> > +
> > +	if (!msg)
> > +		return;
> > +
> > +	/* Is a successfully completed polled message still to be finalized ? */
> > +	spin_lock_irqsave(&msg->poll_lock, flags);
> 
> .poll_lock is acquired before vioch->lock (in scmi_vio_feed_vq_tx()),
> but e. g. virtio_poll_done() uses the reverse locking order.
> 

Right good catch ! Indeed is not even needed..I have rewoked all the
spinlocking around feed_vq_tx/rx in V8.

> > +	if (!ret && xfer->hdr.poll_completion && list_empty(&msg->list))
> > +		scmi_vio_feed_vq_tx(vioch, msg);
> > +	spin_unlock_irqrestore(&msg->poll_lock, flags);
> > +
> > +	xfer->priv = NULL;
> > +}
> > +
> > +/**
> > + * virtio_poll_done  - Provide polling support for VirtIO transport
> > + *
> > + * @cinfo: SCMI channel info
> > + * @xfer: Reference to the transfer being poll for.
> > + *
> > + * VirtIO core provides a polling mechanism based only on last used indexes:
> > + * this means that it is possible to poll the virtqueues waiting for something
> > + * new to arrive from the host side but the only way to check if the freshly
> > + * arrived buffer was what we were waiting for is to compare the newly arrived
> > + * message descriptors with the one we are polling on.
> > + *
> > + * As a consequence it can happen to dequeue something different from the buffer
> > + * we were poll-waiting for: if that is the case such early fetched buffers are
> > + * then added to a the @pending_cmds_list list for later processing within the
> > + * usual VirtIO callbacks; so, basically, once something new is spotted we
> > + * proceed to de-queue all the freshly received used buffers until we found the
> > + * one we were polling on, or we empty the virtqueue.
> > + *
> > + * Note that we do NOT suppress notification with VIRTQ_USED_F_NO_NOTIFY even
> > + * when polling since such flag is per-virtqueues and we do not want to
> > + * suppress notifications as a whole: so, if the message we are polling for is
> > + * delivered via usual IRQs callbacks, it will be handled as such and the
> > + * polling loop in the SCMI Core TX path will be transparently terminated
> > + * anyway.
> > + *
> > + * Return: True once polling has successfully completed.
> > + */
> > +static bool virtio_poll_done(struct scmi_chan_info *cinfo,
> > +			     struct scmi_xfer *xfer)
> > +{
> > +	bool ret;
> > +	unsigned int poll_idx;
> > +	unsigned long flags;
> > +	struct scmi_vio_msg *msg = xfer->priv;
> > +	struct scmi_vio_channel *vioch = cinfo->transport_info;
> > +
> > +	if (!msg)
> > +		return true;
> > +
> > +	/*
> > +	 * Keep the spinlocked region as small as possible: don't care if
> > +	 * missing something this time it will be polled again next.
> > +	 */
> > +	spin_lock_irqsave(&msg->poll_lock, flags);
> > +	poll_idx = msg->poll_idx;
> > +	spin_unlock_irqrestore(&msg->poll_lock, flags);
> > +
> > +	/* Processed already by other polling loop on another CPU ? */
> > +	if (poll_idx == VIO_MSG_POLL_DONE)
> > +		return true;
> > +
> > +	/* Has cmdq index moved at all ? */
> > +	ret = virtqueue_poll(vioch->vqueue, poll_idx);
> 
> In theory, if polling gets delayed, virtqueue_poll() might run into an
> ABA problem, if 2**16 descriptors have been used in the meantime (and
> activity stops after this).
> 
> I think this could be avoided by clearing .poll_idx of each returned
> message everywhere (also in scmi_vio_complete_cb()).
> 

Indeed I'm doing just that in V8...if I go it right what you meant.

> > +	if (ret) {
> > +		struct scmi_vio_msg *next_msg;
> > +
> > +		spin_lock_irqsave(&vioch->lock, flags);
> > +		virtqueue_disable_cb(vioch->vqueue);
> > +		/*
> > +		 * If something arrived we cannot be sure if it was the reply to
> > +		 * the xfer we are polling for, or some replies to other, even
> > +		 * possibly non-polling, pending xfers: process all new messages
> > +		 * till the polled-for message is found OR the vqueue is empty.
> > +		 */
> > +		do {
> > +			unsigned int length;
> > +
> > +			next_msg = virtqueue_get_buf(vioch->vqueue, &length);
> > +			if (next_msg) {
> > +				next_msg->rx_len = length;
> > +				if (next_msg == msg) {
> > +					ret = true;
> > +					break;
> > +				}
> > +
> > +				list_add_tail(&next_msg->list,
> > +					      &vioch->pending_cmds_list);
> > +				spin_lock(&next_msg->poll_lock);
> > +				next_msg->poll_idx = VIO_MSG_POLL_DONE;
> > +				spin_unlock(&next_msg->poll_lock);
> > +				ret = false;
> > +			}
> > +		} while (next_msg);
> > +
> > +		/*
> > +		 * When the polling loop has successfully terminated simply
> > +		 * restart the vqueue, no matter if something else was queued
> 
> "restart the vqueue" should better be phrased as "re-enable the vqueue
> callbacks".
> 

Missed this in V8...I'll in v9 (which will be due for other reasons
related to the Clock frwm anyway :D)

> > +		 * in the meantime, it will be served by normal IRQ/callback
> > +		 * or by the next poll loop.
> > +		 *
> > +		 * Update the polling index to the current vqueue last used
> > +		 * index, if still looking for a reply.
> > +		 */
> > +		if (ret) {
> > +			virtqueue_enable_cb(vioch->vqueue);
> 
> If this function returns false, how is the race described in the
> function documentation handled? (The same comment might also apply in
> other places.)
> 

Good point.
I had wrong assumptions about this behvaiour indeed: what I was missing
is the fact that any pending message in the vqueue at this point won't
be signalled anymore until the next message possibly arrives; in v8 I
check for pending buffers when re-enabling and then I have them processed
by a deferred workqueue together with pre-fetched non-polled ones; this
way I also avoid to loop too much de-queuing non-polled messages within
the poll loop.

Thanks,
Cristian
