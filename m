Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9DC47BF68
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbhLUMJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:09:26 -0500
Received: from foss.arm.com ([217.140.110.172]:50478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhLUMJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:09:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B587E1FB;
        Tue, 21 Dec 2021 04:09:25 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1BDC3F774;
        Tue, 21 Dec 2021 04:09:22 -0800 (PST)
Date:   Tue, 21 Dec 2021 12:09:16 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com,
        Igor Skalkin <igor.skalkin@opensynergy.com>,
        Peter Hilber <peter.hilber@opensynergy.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v8 09/11] firmware: arm_scmi: Add atomic mode support to
 virtio transport
Message-ID: <20211221120916.GM6207@e120937-lin>
References: <20211220195646.44498-1-cristian.marussi@arm.com>
 <20211220195646.44498-10-cristian.marussi@arm.com>
 <20211220181455-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220181455-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 06:17:03PM -0500, Michael S. Tsirkin wrote:
> On Mon, Dec 20, 2021 at 07:56:44PM +0000, Cristian Marussi wrote:
> > Add support for .mark_txdone and .poll_done transport operations to SCMI
> > VirtIO transport as pre-requisites to enable atomic operations.
> > 
> > Add a Kernel configuration option to enable SCMI VirtIO transport polling
> > and atomic mode for selected SCMI transactions while leaving it default
> > disabled.
> > 

Hi Michael,

thanks for your review.

> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
> > Cc: Peter Hilber <peter.hilber@opensynergy.com>
> > Cc: virtualization@lists.linux-foundation.org
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v7 --> v8
> > - removed ifdeffery
> > - reviewed comments
> > - simplified spinlocking aroung scmi_feed_vq_tx/rx
> > - added deferred worker for TX replies to aid while polling mode is active
> > V6 --> V7
> > - added a few comments about virtio polling internals
> > - fixed missing list_del on pending_cmds_list processing
> > - shrinked spinlocked areas in virtio_poll_done
> > - added proper spinlocking to scmi_vio_complete_cb while scanning list
> >   of pending cmds
> > ---
> >  drivers/firmware/arm_scmi/Kconfig  |  15 ++
> >  drivers/firmware/arm_scmi/virtio.c | 291 ++++++++++++++++++++++++++---
> >  2 files changed, 280 insertions(+), 26 deletions(-)
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
> > index fd0f6f91fc0b..f589bbcc5db9 100644
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
> > @@ -296,6 +359,11 @@ static int virtio_chan_free(int id, void *p, void *data)
> >  	vioch->ready = false;
> >  	spin_unlock_irqrestore(&vioch->ready_lock, flags);
> >  
> > +	if (!vioch->is_rx && vioch->deferred_tx_wq) {
> > +		destroy_workqueue(vioch->deferred_tx_wq);
> > +		vioch->deferred_tx_wq = NULL;
> > +	}
> > +
> >  	scmi_free_channel(cinfo, data, id);
> >  
> >  	spin_lock_irqsave(&vioch->lock, flags);
> > @@ -324,7 +392,8 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
> >  	}
> >  
> >  	msg = list_first_entry(&vioch->free_list, typeof(*msg), list);
> > -	list_del(&msg->list);
> > +	/* Re-init element so we can discern anytime if it is still in-flight */
> > +	list_del_init(&msg->list);
> >  
> >  	msg_tx_prepare(msg->request, xfer);
> >  
> > @@ -337,6 +406,19 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
> >  		dev_err(vioch->cinfo->dev,
> >  			"failed to add to TX virtqueue (%d)\n", rc);
> >  	} else {
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
> > +			/* Ensure initialized msg is visibly bound to xfer */
> > +			smp_store_mb(xfer->priv, msg);
> > +		}
> >  		virtqueue_kick(vioch->vqueue);
> >  	}
> >  
> > @@ -350,10 +432,8 @@ static void virtio_fetch_response(struct scmi_chan_info *cinfo,
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
> > @@ -361,10 +441,165 @@ static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
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
> >  	}
> > +
> > +	/* Has cmdq index moved at all ? */
> > +	pending = virtqueue_poll(vioch->vqueue, msg->poll_idx);
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
> > +	}
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
> > +	spin_unlock_irqrestore(&vioch->lock, flags);
> > +
> > +	if (any_prefetched || pending)
> > +		queue_work(vioch->deferred_tx_wq, &vioch->deferred_tx_work);
> 
> I don't see any attempt to make sure the queued work is no longer
> running on e.g. device or driver removal.
> 

Right, I destroy the workqueue and nullify the deferred_tx_wq pointer in
chan_free, I'll add a check here within the spinlocking area to avoid the
race with the destroy in chan_free.

Thanks,
Cristian

