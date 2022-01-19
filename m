Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62437493A37
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 13:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354451AbiASMXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 07:23:49 -0500
Received: from foss.arm.com ([217.140.110.172]:55322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345736AbiASMXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 07:23:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B3A0ED1;
        Wed, 19 Jan 2022 04:23:47 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5967D3F73D;
        Wed, 19 Jan 2022 04:23:45 -0800 (PST)
Date:   Wed, 19 Jan 2022 12:23:38 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v9 09/11] firmware: arm_scmi: Add atomic mode support to
 virtio transport
Message-ID: <20220119122338.GE6113@e120937-lin>
References: <20211220195646.44498-10-cristian.marussi@arm.com>
 <20211221140027.41524-1-cristian.marussi@arm.com>
 <f231094a-6f34-3dc1-237d-97218e8fde91@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f231094a-6f34-3dc1-237d-97218e8fde91@opensynergy.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 03:21:03PM +0100, Peter Hilber wrote:
> On 21.12.21 15:00, Cristian Marussi wrote:
> > Add support for .mark_txdone and .poll_done transport operations to SCMI
> > VirtIO transport as pre-requisites to enable atomic operations.
> > 
> > Add a Kernel configuration option to enable SCMI VirtIO transport polling
> > and atomic mode for selected SCMI transactions while leaving it default
> > disabled.
> > 
> 
> Hi Cristian,
> 
> thanks for the update. I have some more remarks inline below.
> 

Hi Peter,

thanks for your review, much appreciated, please see my replies online.

> My impression is that the virtio core does not expose helper functions suitable
> to busy-poll for used buffers. But changing this might not be difficult. Maybe
> more_used() from virtio_ring.c could be exposed via a wrapper?
> 

While I definitely agree that the virtio core support for polling is far from
ideal, some support is provided and my point was at first to try implement SCMI
virtio polling leveraging what we have now in the core and see if it was attainable
(indeed I tried early in this series to avoid as a whole to have to support polling
at the SCMI transport layer to attain SCMI cmds atomicity..but that was an ill
attempt that led nowhere good...)

Btw, I was planning to post a new series next week (after merge-windows) with some
fixes I did already, at this point I'll include also some fixes derived
from some of your remarks.

> Best regards,
> 
> Peter
> 
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
> > Cc: Peter Hilber <peter.hilber@opensynergy.com>
> > Cc: virtualization@lists.linux-foundation.org
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v8 --> v9
> > - check for deferred_wq existence before queueing work to avoid
> >   race at driver removal time
> > ---
> >  drivers/firmware/arm_scmi/Kconfig  |  15 ++
> >  drivers/firmware/arm_scmi/virtio.c | 298 ++++++++++++++++++++++++++---
> >  2 files changed, 287 insertions(+), 26 deletions(-)
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
> > index fd0f6f91fc0b..e54d14971c07 100644
> > --- a/drivers/firmware/arm_scmi/virtio.c
> > +++ b/drivers/firmware/arm_scmi/virtio.c
> > @@ -3,8 +3,8 @@
> >   * Virtio Transport driver for Arm System Control and Management Interface
> >   * (SCMI).
> >   *
> > - * Copyright (C) 2020-2021 OpenSynergy.
> > - * Copyright (C) 2021 ARM Ltd.
> > + * Copyright (C) 2020-2022 OpenSynergy.
> > + * Copyright (C) 2021-2022 ARM Ltd.
> >   */
> >  
> >  /**
> > @@ -38,6 +38,9 @@
> >   * @vqueue: Associated virtqueue
> >   * @cinfo: SCMI Tx or Rx channel
> >   * @free_list: List of unused scmi_vio_msg, maintained for Tx channels only
> > + * @deferred_tx_work: Worker for TX deferred replies processing
> > + * @deferred_tx_wq: Workqueue for TX deferred replies
> > + * @pending_cmds_list: List of pre-fetched commands queueud for later processing
> >   * @is_rx: Whether channel is an Rx channel
> >   * @ready: Whether transport user is ready to hear about channel
> >   * @max_msg: Maximum number of pending messages for this channel.
> > @@ -49,6 +52,9 @@ struct scmi_vio_channel {
> >  	struct virtqueue *vqueue;
> >  	struct scmi_chan_info *cinfo;
> >  	struct list_head free_list;
> > +	struct list_head pending_cmds_list;
> > +	struct work_struct deferred_tx_work;
> > +	struct workqueue_struct *deferred_tx_wq;
> >  	bool is_rx;
> >  	bool ready;
> >  	unsigned int max_msg;
> > @@ -65,12 +71,22 @@ struct scmi_vio_channel {
> >   * @input: SDU used for (delayed) responses and notifications
> >   * @list: List which scmi_vio_msg may be part of
> >   * @rx_len: Input SDU size in bytes, once input has been received
> > + * @poll_idx: Last used index registered for polling purposes if this message
> > + *	      transaction reply was configured for polling.
> > + *	      Note that since virtqueue used index is an unsigned 16-bit we can
> > + *	      use some out-of-scale values to signify particular conditions.
> > + * @poll_lock: Protect access to @poll_idx.
> >   */
> >  struct scmi_vio_msg {
> >  	struct scmi_msg_payld *request;
> >  	struct scmi_msg_payld *input;
> >  	struct list_head list;
> >  	unsigned int rx_len;
> > +#define VIO_MSG_NOT_POLLED	0xeeeeeeeeUL
> > +#define VIO_MSG_POLL_DONE	0xffffffffUL
> > +	unsigned int poll_idx;
> > +	/* lock to protect access to poll_idx. */
> > +	spinlock_t poll_lock;
> >  };
> >  
> >  /* Only one SCMI VirtIO device can possibly exist */
> > @@ -81,40 +97,43 @@ static bool scmi_vio_have_vq_rx(struct virtio_device *vdev)
> >  	return virtio_has_feature(vdev, VIRTIO_SCMI_F_P2A_CHANNELS);
> >  }
> >  
> > +/* Expect to be called with vioch->lock acquired by the caller and IRQs off */
> >  static int scmi_vio_feed_vq_rx(struct scmi_vio_channel *vioch,
> >  			       struct scmi_vio_msg *msg,
> >  			       struct device *dev)
> >  {
> >  	struct scatterlist sg_in;
> >  	int rc;
> > -	unsigned long flags;
> >  
> >  	sg_init_one(&sg_in, msg->input, VIRTIO_SCMI_MAX_PDU_SIZE);
> >  
> > -	spin_lock_irqsave(&vioch->lock, flags);
> > -
> >  	rc = virtqueue_add_inbuf(vioch->vqueue, &sg_in, 1, msg, GFP_ATOMIC);
> >  	if (rc)
> >  		dev_err(dev, "failed to add to RX virtqueue (%d)\n", rc);
> >  	else
> >  		virtqueue_kick(vioch->vqueue);
> >  
> > -	spin_unlock_irqrestore(&vioch->lock, flags);
> > -
> >  	return rc;
> >  }
> >  
> > +/* Expect to be called with vioch->lock acquired by the caller and IRQs off */
> > +static inline void scmi_vio_feed_vq_tx(struct scmi_vio_channel *vioch,
> > +				       struct scmi_vio_msg *msg)
> > +{
> > +	spin_lock(&msg->poll_lock);
> > +	msg->poll_idx = VIO_MSG_NOT_POLLED;
> > +	spin_unlock(&msg->poll_lock);
> > +
> > +	list_add(&msg->list, &vioch->free_list);
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
> > @@ -144,6 +163,7 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
> >  			virtqueue_disable_cb(vqueue);
> >  			cb_enabled = false;
> >  		}
> > +
> >  		msg = virtqueue_get_buf(vqueue, &length);
> >  		if (!msg) {
> >  			if (virtqueue_enable_cb(vqueue))
> > @@ -157,7 +177,9 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
> >  			scmi_rx_callback(vioch->cinfo,
> >  					 msg_read_header(msg->input), msg);
> >  
> > +			spin_lock(&vioch->lock);
> >  			scmi_finalize_message(vioch, msg);
> > +			spin_unlock(&vioch->lock);
> >  		}
> >  
> >  		/*
> > @@ -176,6 +198,34 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
> >  	spin_unlock_irqrestore(&vioch->ready_lock, ready_flags);
> >  }
> >  
> > +static void scmi_vio_deferred_tx_worker(struct work_struct *work)
> > +{
> > +	unsigned long flags;
> > +	struct scmi_vio_channel *vioch;
> > +	struct scmi_vio_msg *msg, *tmp;
> > +
> > +	vioch = container_of(work, struct scmi_vio_channel, deferred_tx_work);
> > +
> > +	/* Process pre-fetched messages */
> > +	spin_lock_irqsave(&vioch->lock, flags);
> > +
> > +	/* Scan the list of possibly pre-fetched messages during polling. */
> > +	list_for_each_entry_safe(msg, tmp, &vioch->pending_cmds_list, list) {
> > +		list_del(&msg->list);
> > +
> > +		scmi_rx_callback(vioch->cinfo,
> > +				 msg_read_header(msg->input), msg);
> > +
> > +		/* Free the processed message once done */
> > +		scmi_vio_feed_vq_tx(vioch, msg);
> > +	}
> > +
> > +	spin_unlock_irqrestore(&vioch->lock, flags);
> > +
> > +	/* Process possibly still pending messages */
> > +	scmi_vio_complete_cb(vioch->vqueue);
> > +}
> > +
> >  static const char *const scmi_vio_vqueue_names[] = { "tx", "rx" };
> >  
> >  static vq_callback_t *scmi_vio_complete_callbacks[] = {
> > @@ -244,6 +294,19 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
> >  
> >  	vioch = &((struct scmi_vio_channel *)scmi_vdev->priv)[index];
> >  
> > +	/* Setup a deferred worker for polling. */
> > +	if (tx && !vioch->deferred_tx_wq) {
> > +		vioch->deferred_tx_wq =
> > +			alloc_workqueue(dev_name(&scmi_vdev->dev),
> > +					WQ_UNBOUND | WQ_FREEZABLE | WQ_SYSFS,
> > +					0);
> > +		if (!vioch->deferred_tx_wq)
> > +			return -ENOMEM;
> > +
> > +		INIT_WORK(&vioch->deferred_tx_work,
> > +			  scmi_vio_deferred_tx_worker);
> > +	}
> > +
> >  	for (i = 0; i < vioch->max_msg; i++) {
> >  		struct scmi_vio_msg *msg;
> >  
> > @@ -257,6 +320,7 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
> >  						    GFP_KERNEL);
> >  			if (!msg->request)
> >  				return -ENOMEM;
> > +			spin_lock_init(&msg->poll_lock);
> >  		}
> >  
> >  		msg->input = devm_kzalloc(cinfo->dev, VIRTIO_SCMI_MAX_PDU_SIZE,
> > @@ -264,13 +328,12 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
> >  		if (!msg->input)
> >  			return -ENOMEM;
> >  
> > -		if (tx) {
> > -			spin_lock_irqsave(&vioch->lock, flags);
> > -			list_add_tail(&msg->list, &vioch->free_list);
> > -			spin_unlock_irqrestore(&vioch->lock, flags);
> > -		} else {
> > +		spin_lock_irqsave(&vioch->lock, flags);
> > +		if (tx)
> > +			scmi_vio_feed_vq_tx(vioch, msg);
> > +		else
> >  			scmi_vio_feed_vq_rx(vioch, msg, cinfo->dev);
> > -		}
> > +		spin_unlock_irqrestore(&vioch->lock, flags);
> >  	}
> >  
> >  	spin_lock_irqsave(&vioch->lock, flags);
> > @@ -291,11 +354,22 @@ static int virtio_chan_free(int id, void *p, void *data)
> >  	unsigned long flags;
> >  	struct scmi_chan_info *cinfo = p;
> >  	struct scmi_vio_channel *vioch = cinfo->transport_info;
> > +	void *deferred_wq = NULL;
> >  
> >  	spin_lock_irqsave(&vioch->ready_lock, flags);
> >  	vioch->ready = false;
> >  	spin_unlock_irqrestore(&vioch->ready_lock, flags);
> >  
> > +	spin_lock_irqsave(&vioch->lock, flags);
> > +	if (!vioch->is_rx && vioch->deferred_tx_wq) {
> > +		deferred_wq = vioch->deferred_tx_wq;
> > +		vioch->deferred_tx_wq = NULL;
> > +	}
> > +	spin_unlock_irqrestore(&vioch->lock, flags);
> > +
> > +	if (deferred_wq)
> > +		destroy_workqueue(deferred_wq);
> > +
> >  	scmi_free_channel(cinfo, data, id);
> >  
> >  	spin_lock_irqsave(&vioch->lock, flags);
> > @@ -324,7 +398,8 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
> >  	}
> >  
> >  	msg = list_first_entry(&vioch->free_list, typeof(*msg), list);
> > -	list_del(&msg->list);
> > +	/* Re-init element so we can discern anytime if it is still in-flight */
> > +	list_del_init(&msg->list);
> >  
> >  	msg_tx_prepare(msg->request, xfer);
> >  
> > @@ -337,6 +412,19 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
> >  		dev_err(vioch->cinfo->dev,
> >  			"failed to add to TX virtqueue (%d)\n", rc);
> >  	} else {
> > +		/*
> > +		 * If polling was requested for this transaction:
> > +		 *  - retrieve last used index (will be used as polling reference)
> 
> The virtqueue_add_sgs() called before already exposed the message to the virtio
> device, so a fast response might have arrived already, so the reference value
> might unexpectedly correspond to the current message.
> 

Good point I have wrongly considered the kick as the only trigger but if
indeed the device was already kicked and processing the queues the scenario
you depicted is possible. I'll move this logic earlier.

> > +		 *  - bind the polled message to the xfer via .priv
> > +		 */
> > +		if (xfer->hdr.poll_completion) {
> > +			spin_lock(&msg->poll_lock);
> > +			msg->poll_idx =
> > +				virtqueue_enable_cb_prepare(vioch->vqueue);
> > +			spin_unlock(&msg->poll_lock);
> > +			/* Ensure initialized msg is visibly bound to xfer */
> > +			smp_store_mb(xfer->priv, msg);
> > +		}
> >  		virtqueue_kick(vioch->vqueue);
> >  	}
> >  
> > @@ -350,10 +438,8 @@ static void virtio_fetch_response(struct scmi_chan_info *cinfo,
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
> > @@ -361,10 +447,166 @@ static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
> >  {
> >  	struct scmi_vio_msg *msg = xfer->priv;
> >  
> > -	if (msg) {
> > +	if (msg)
> >  		msg_fetch_notification(msg->input, msg->rx_len, max_len, xfer);
> > -		xfer->priv = NULL;
> > +}
> > +
> > +/**
> > + * virtio_mark_txdone  - Mark transmission done
> > + *
> > + * Free only successfully completed polling transfer messages.
> > + *
> > + * Note that in the SCMI VirtIO transport we never explicitly release timed-out
> > + * messages by forcibly re-adding them to the free-list, even on timeout, inside
> > + * the TX code path; we instead let IRQ/RX callbacks eventually clean up such
> > + * messages once, finally, a late reply is received and discarded (if ever).
> > + *
> > + * This approach was deemed preferable since those pending timed-out buffers are
> > + * still effectively owned by the SCMI platform VirtIO device even after timeout
> > + * expiration: forcibly freeing and reusing them before they had been returned
> > + * explicitly by the SCMI platform could lead to subtle bugs due to message
> > + * corruption.
> > + * An SCMI platform VirtIO device which never returns message buffers is
> > + * anyway broken and it will quickly lead to exhaustion of available messages.
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
> > +	/* Ensure msg is unbound from xfer before pushing onto the free list  */
> > +	smp_store_mb(xfer->priv, NULL);
> > +
> > +	/* Is a successfully completed polled message still to be finalized ? */
> > +	spin_lock_irqsave(&vioch->lock, flags);
> > +	if (!ret && xfer->hdr.poll_completion && list_empty(&msg->list))
> 
> Could this not also be a message which was already finalized and then
> immediately reused for another polling xfer?
> 

Fist of all, in the upcoming series there is already a fix here, because I do
not want (as in non-polling mode and as stated in the comment above) to forcibly
release -ETIMEOUT xfer here. New check being like:

	if (ret != -ETIMEDOUT && xfer->hdr.poll_completion && list_empty(&msg->list))

BUT, if I understood correctly what you meant you are talking about a polled
message which had been received by chance on the IRQ path and there finalized
already, and so subsequently happily picked up from the free list for another
polled transfer....I think you are right, even if remote, this is a possibility
to account for (and the list_empty() check fails at this): I'll take care to clear
xfer->priv after a command is fetched BUT only if received across the IRQ path,
and drop the list_empty() check above which at this point is redundant: in this
way mark_tx_done will be skip even for polled cmds that have already been
finalized on the IRQ path. (notifications/delayed responses are unaffected
since not handled on this path...)

Thanks for spotting this.

> > +		scmi_vio_feed_vq_tx(vioch, msg);
> > +	spin_unlock_irqrestore(&vioch->lock, flags);
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
> > + * then added to a the @pending_cmds_list list for later processing by a
> > + * dedicated deferred worker.
> > + *
> > + * So, basically, once something new is spotted we proceed to de-queue all the
> > + * freshly received used buffers until we found the one we were polling on, or,
> > + * we have 'seemingly' emptied the virtqueue; if some buffers are still pending
> > + * in the vqueue at the end of the polling loop (possible due to inherent races
> > + * in virtqueues handling mechanisms), we similarly kick the deferred worker
> > + * and let it process those, to avoid indefinitely looping in the .poll_done
> > + * helper.
> > + *
> > + * Note that we do NOT suppress notification with VIRTQ_USED_F_NO_NOTIFY even
> > + * when polling since such flag is per-virtqueues and we do not want to
> > + * suppress notifications as a whole: so, if the message we are polling for is
> > + * delivered via usual IRQs callbacks, on another core which are IRQs-on, it
> > + * will be handled as such by scmi_rx_callback() and the polling loop in the
> > + * SCMI Core TX path will be transparently terminated anyway.
> 
> Why is VIRTQ_USED_F_NO_NOTIFY mentioned? It is a flag associated with only one
> of two buffer notification suppression methods, which are transparently handled
> by the virtio core. Cf. `Driver Requirements: Used Buffer Notification
> Suppression' in the virtio spec.
> 

I saw that paragraph on the spec, what I wanted to stress was that we have no
way to implement a per-message notification suppression (and probably neither a
per-channel one since VIRTQ_USED_F_NO_NOTIFY is not really exposed), so that
a polled message could be indeed received instead through the usual IRQ based
callbacks if it happens to be delivered on a different core or if the
current polling core is not running such loops with IRQs off, but such
behaviour is supported and handled.

Anyway it is probably confusing mentioning the presence of the
VIRTQ_USED_F_NO_NOTIFY flag, so I'll drop that mention.

> > + *
> > + * Return: True once polling has successfully completed.
> > + */
> > +static bool virtio_poll_done(struct scmi_chan_info *cinfo,
> > +			     struct scmi_xfer *xfer)
> > +{
> > +	bool pending, ret = false;
> > +	unsigned int length, any_prefetched = 0;
> > +	unsigned long flags;
> > +	struct scmi_vio_msg *next_msg, *msg = xfer->priv;
> > +	struct scmi_vio_channel *vioch = cinfo->transport_info;
> > +
> > +	if (!msg)
> > +		return true;
> > +
> > +	spin_lock_irqsave(&msg->poll_lock, flags);
> > +	/* Processed already by other polling loop on another CPU ? */
> > +	if (msg->poll_idx == VIO_MSG_POLL_DONE) {
> > +		spin_unlock_irqrestore(&msg->poll_lock, flags);
> > +		return true;
> > +	}
> > +
> > +	/* Has cmdq index moved at all ? */
> > +	pending = virtqueue_poll(vioch->vqueue, msg->poll_idx);
> 
> In my understanding, the polling comparison could still be subject to the ABA
> problem when exactly 2**16 messages have been marked as used since
> msg->poll_idx was set (unlikely scenario, granted).
> 
> I think this would be a lot simpler if the virtio core exported some
> concurrency-safe helper function for such polling (similar to more_used() from
> virtio_ring.c), as discussed at the top.

So this is the main limitation indeed of the current implementation, I
cannot distinguish if there was an exact full wrap and I'm reading the same
last_idx as before but a whoppying 2**16 messages have instead gone through...

The tricky part seems to me here that even introducing dedicated helpers
for polling in order to account for such wrapping (similar to more_used())
those would be based by current VirtIO spec on a single bit wrap counter,
so how do you discern if 2 whole wraps have happened (even more unlikely..) ?

Maybe I'm missing something though...

I'll have a though about this, but in my opinion this seems something so
unlikely that we could live with it, for the moment at least...

> 
> > +	spin_unlock_irqrestore(&msg->poll_lock, flags);
> > +	if (!pending)
> > +		return false;
> > +
> > +	spin_lock_irqsave(&vioch->lock, flags);
> > +	virtqueue_disable_cb(vioch->vqueue);
> > +
> > +	/*
> > +	 * If something arrived we cannot be sure, without dequeueing, if it
> > +	 * was the reply to the xfer we are polling for, or, to other, even
> > +	 * possibly non-polling, pending xfers: process all new messages
> > +	 * till the polled-for message is found OR the vqueue is empty.
> > +	 */
> > +	while ((next_msg = virtqueue_get_buf(vioch->vqueue, &length))) {
> > +		next_msg->rx_len = length;
> > +		/* Is the message we were polling for ? */
> > +		if (next_msg == msg) {
> > +			ret = true;
> > +			break;
> > +		}
> > +
> > +		spin_lock(&next_msg->poll_lock);
> > +		if (next_msg->poll_idx == VIO_MSG_NOT_POLLED) {
> > +			any_prefetched++;
> > +			list_add_tail(&next_msg->list,
> > +				      &vioch->pending_cmds_list);
> > +		} else {
> > +			next_msg->poll_idx = VIO_MSG_POLL_DONE;
> > +		}
> > +		spin_unlock(&next_msg->poll_lock);
> >  	}
> > +
> > +	/*
> > +	 * When the polling loop has successfully terminated if something
> > +	 * else was queued in the meantime, it will be served by a deferred
> > +	 * worker OR by the normal IRQ/callback OR by other poll loops.
> > +	 *
> > +	 * If we are still looking for the polled reply, the polling index has
> > +	 * to be updated to the current vqueue last used index.
> > +	 */
> > +	if (ret) {
> > +		pending = !virtqueue_enable_cb(vioch->vqueue);
> > +	} else {
> > +		spin_lock(&msg->poll_lock);
> > +		msg->poll_idx = virtqueue_enable_cb_prepare(vioch->vqueue);
> > +		pending = virtqueue_poll(vioch->vqueue, msg->poll_idx);
> > +		spin_unlock(&msg->poll_lock);
> > +	}
> > +
> > +	if (vioch->deferred_tx_wq && (any_prefetched || pending))
> > +		queue_work(vioch->deferred_tx_wq, &vioch->deferred_tx_work);
> 
> What if queue_work() returns false because the single work item for the channel
> was already pending? Couldn't it then happen that the worker CPU will not yet
> see the updates implied by `any_prefetched || pending'?
> 

The short asnwer is, no this can't happen: I had an extensive discussion in the
past around similar concerns about this about SCMI notifs dispatching (which use
workqueues:
https://lore.kernel.org/linux-arm-kernel/0234c256-2e29-69f8-99ae-2599f982961e@arm.com/).

In a nutshell all bails down to how the Kenrel cmwq susbsystem works
internally.

queue_work() does fail if the same work item was already queued recently
and suck work is still marked as WORK_PENDING, BUT that flag happens to be set
only if such queued work is still fully pending in the sense that the worker
thread has still not even being waken by the Kernel cmwq subsystem.

The above flag is indeed cleared right before the related worker
thread is started, roughly:

> kernel/workqueue.c:process_one_work()
> 
> 	set_work_pool_and_clear_pending(work, pool->id);
> 	....
> 	worker->current_func(work);
> 

So queue_work() return false only if a previous work was pending AND the
worker thread was still dormient; it is not possible that the worker
thread was running and, say, had already emptied the above @pending_cmds_list
but was still marked pending since it still has to terminate (that would be
indeed a problem and you would end up with this new work items not seen
till the next worker run is kicked)

Moreover, here the work items are really contained in a spinlocked list
whose spinlock is hold here while filling up the list and in the worker
thread while emptying it, so that it is neither possible to
modify/corrupt the list while the worker is consuming it, in case you
successfully queue more work while the worker is running.

Thanks again for your feedback,
Cristian

P.S: .. from the other thread..
> ... it seems to me that is exactly how I'm using it, and moreover I
> don't see any other way via the VirtIO API to grab that last_used_idx
> that I need for virtqueu_poll.

>> I meant to say that the VIO_MSG_POLL_DONE special value should best not be put
>> into the .poll_idx (since the special value might in theory overlap with an
>> opaque value). Another variable could hold the special states VIO_MSG_POLL_DONE
>> and VIO_MSG_NOT_POLLED.

Yes indeed, I was trying to avoid to keep one more variable ignoring indeed
the opaqueness :D ... I'll find a better way.
