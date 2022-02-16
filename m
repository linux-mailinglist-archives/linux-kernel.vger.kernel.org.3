Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B004B8BC3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbiBPOq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:46:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiBPOq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:46:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5809F2A64FC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 06:46:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DBFA113E;
        Wed, 16 Feb 2022 06:46:13 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B78C3F718;
        Wed, 16 Feb 2022 06:46:11 -0800 (PST)
Date:   Wed, 16 Feb 2022 14:46:01 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 3/8] firmware: arm_scmi: Add atomic mode support to
 virtio transport
Message-ID: <20220216144457.GC6072@e120937-lin>
References: <20220213195832.27932-1-cristian.marussi@arm.com>
 <20220213195832.27932-4-cristian.marussi@arm.com>
 <6c3920d9-798b-2a5a-46d1-011152002251@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c3920d9-798b-2a5a-46d1-011152002251@opensynergy.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 10:12:10AM +0100, Peter Hilber wrote:
> On 13.02.22 20:58, Cristian Marussi wrote:
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
> please find some minor remarks below.
> 
> Best regards,
> 
> Peter
> 

Hi Peter,

thanks for the review.

> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
> > Cc: Peter Hilber <peter.hilber@opensynergy.com>
> > Cc: virtualization@lists.linux-foundation.org
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v1 --> v2
> > - shrinked spinlocked section within virtio_poll_done to exclude
> >   virtqueue_poll
> > - removed poll_lock
> > - use vio channel refcount acquire/release logic when polling
> > - using new free_list accessors
> > - added new dedicated pending_lock to access pending_cmds_list
> > - fixed a few comments
> > 
> > v0 --> v1
> > - check for deferred_wq existence before queueing work to avoid
> >   race at driver removal time
> > - changed mark_txdone decision-logic about message release
> > - fixed race while checking for msg polled from another thread
> > - using dedicated poll_status instead of poll_idx upper bits
> > - pick initial poll_idx earlier inside send_message to avoid missing
> >   early replies
> > - removed F_NOTIFY mention in comment
> > - clearing xfer->priv on the IRQ tx path once message has been fetched
> > - added some store barriers
> > - updated some comments
> > ---
> >  drivers/firmware/arm_scmi/Kconfig  |  15 ++
> >  drivers/firmware/arm_scmi/driver.c |   9 +-
> >  drivers/firmware/arm_scmi/virtio.c | 277 ++++++++++++++++++++++++++++-
> >  3 files changed, 291 insertions(+), 10 deletions(-)
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
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index c2e7897ff56e..dc972a54e93e 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -648,7 +648,8 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
> >  
> >  	unpack_scmi_header(msg_hdr, &xfer->hdr);
> >  	if (priv)
> > -		xfer->priv = priv;
> > +		/* Ensure order between xfer->priv store and following ops */
> > +		smp_store_mb(xfer->priv, priv);
> >  	info->desc->ops->fetch_notification(cinfo, info->desc->max_msg_size,
> >  					    xfer);
> >  	scmi_notify(cinfo->handle, xfer->hdr.protocol_id,
> > @@ -680,8 +681,12 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
> >  		xfer->rx.len = info->desc->max_msg_size;
> >  
> >  	if (priv)
> > -		xfer->priv = priv;
> > +		/* Ensure order between xfer->priv store and following ops */
> > +		smp_store_mb(xfer->priv, priv);
> >  	info->desc->ops->fetch_response(cinfo, xfer);
> > +	if (priv)
> > +		/* Ensure order between xfer->priv clear and later accesses */
> > +		smp_store_mb(xfer->priv, NULL);
> >  
> >  	trace_scmi_rx_done(xfer->transfer_id, xfer->hdr.id,
> >  			   xfer->hdr.protocol_id, xfer->hdr.seq,
> > diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
> > index a147fc24c4c0..9fa337a4e464 100644
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
> > @@ -42,6 +42,10 @@
> >   * @cinfo: SCMI Tx or Rx channel
> >   * @free_lock: Protects access to the @free_list.
> >   * @free_list: List of unused scmi_vio_msg, maintained for Tx channels only
> > + * @deferred_tx_work: Worker for TX deferred replies processing
> > + * @deferred_tx_wq: Workqueue for TX deferred replies
> > + * @pending_lock: Protects access to the @pending_cmds_list.
> > + * @pending_cmds_list: List of pre-fetched commands queueud for later processing
> >   * @is_rx: Whether channel is an Rx channel
> >   * @max_msg: Maximum number of pending messages for this channel.
> >   * @lock: Protects access to all members except users, free_list.
> 
> ... and also doesn't protect pending_cmds_list.
> 

Right. I'll fix.

> > @@ -54,6 +58,11 @@ struct scmi_vio_channel {
> >  	/* lock to protect access to the free list. */
> >  	spinlock_t free_lock;
> >  	struct list_head free_list;
> > +	/* lock to protect access to the pending list. */
> > +	spinlock_t pending_lock;
> > +	struct list_head pending_cmds_list;
> > +	struct work_struct deferred_tx_work;
> > +	struct workqueue_struct *deferred_tx_wq;
> >  	bool is_rx;
> >  	unsigned int max_msg;
> >  	/* lock to protect access to all members except users, free_list  */
> 
> ... and also doesn't protect pending_cmds_list.
> 

Right. I'll fix.

> > @@ -62,6 +71,12 @@ struct scmi_vio_channel {
> >  	refcount_t users;
> >  };
> >  
> > +enum poll_states {
> > +	VIO_MSG_NOT_POLLED,
> > +	VIO_MSG_POLLING,
> > +	VIO_MSG_POLL_DONE,
> > +};
> > +
> >  /**
> >   * struct scmi_vio_msg - Transport PDU information
> >   *
> > @@ -69,12 +84,17 @@ struct scmi_vio_channel {
> >   * @input: SDU used for (delayed) responses and notifications
> >   * @list: List which scmi_vio_msg may be part of
> >   * @rx_len: Input SDU size in bytes, once input has been received
> > + * @poll_idx: Last used index registered for polling purposes if this message
> > + *	      transaction reply was configured for polling.
> > + * @poll_status: Polling state for this message.
> >   */
> >  struct scmi_vio_msg {
> >  	struct scmi_msg_payld *request;
> >  	struct scmi_msg_payld *input;
> >  	struct list_head list;
> >  	unsigned int rx_len;
> > +	unsigned int poll_idx;
> > +	enum poll_states poll_status;
> >  };
> >  
> >  /* Only one SCMI VirtIO device can possibly exist */
> > @@ -117,6 +137,7 @@ static void scmi_vio_channel_cleanup_sync(struct scmi_vio_channel *vioch)
> >  {
> >  	unsigned long flags;
> >  	DECLARE_COMPLETION_ONSTACK(vioch_shutdown_done);
> > +	void *deferred_wq = NULL;
> >  
> >  	/*
> >  	 * Prepare to wait for the last release if not already released
> > @@ -127,10 +148,19 @@ static void scmi_vio_channel_cleanup_sync(struct scmi_vio_channel *vioch)
> >  		spin_unlock_irqrestore(&vioch->lock, flags);
> >  		return;
> >  	}
> > +
> >  	vioch->shutdown_done = &vioch_shutdown_done;
> >  	virtio_break_device(vioch->vqueue->vdev);
> > +	if (!vioch->is_rx && vioch->deferred_tx_wq) {
> > +		deferred_wq = vioch->deferred_tx_wq;
> > +		/* Cannot be kicked anymore after this...*/
> > +		vioch->deferred_tx_wq = NULL;
> > +	}
> >  	spin_unlock_irqrestore(&vioch->lock, flags);
> >  
> > +	if (deferred_wq)
> > +		destroy_workqueue(deferred_wq);
> > +
> >  	scmi_vio_channel_release(vioch);
> >  
> >  	/* Let any possibly concurrent RX path release the channel */
> > @@ -163,6 +193,8 @@ static void scmi_virtio_put_free_msg(struct scmi_vio_channel *vioch,
> >  {
> >  	unsigned long flags;
> >  
> > +	msg->poll_status = VIO_MSG_NOT_POLLED;
> > +
> >  	spin_lock_irqsave(&vioch->free_lock, flags);
> >  	list_add_tail(&msg->list, &vioch->free_list);
> >  	spin_unlock_irqrestore(&vioch->free_lock, flags);
> > @@ -233,6 +265,7 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
> >  			virtqueue_disable_cb(vqueue);
> >  			cb_enabled = false;
> >  		}
> > +
> >  		msg = virtqueue_get_buf(vqueue, &length);
> >  		if (!msg) {
> >  			if (virtqueue_enable_cb(vqueue)) {
> > @@ -263,6 +296,40 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
> >  	}
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
> > +	if (!scmi_vio_channel_acquire(vioch))
> > +		return;
> > +
> > +	/* Process pre-fetched messages */
> > +	spin_lock_irqsave(&vioch->pending_lock, flags);
> > +
> > +	/* Scan the list of possibly pre-fetched messages during polling. */
> > +	list_for_each_entry_safe(msg, tmp, &vioch->pending_cmds_list, list) {
> > +		list_del(&msg->list);
> > +
> > +		/* Channel is acquired here and cannot vanish */
> > +		scmi_rx_callback(vioch->cinfo,
> > +				 msg_read_header(msg->input), msg);
> > +
> > +		/* Free the processed message once done */
> > +		scmi_virtio_put_free_msg(vioch, msg);
> > +	}
> > +
> > +	spin_unlock_irqrestore(&vioch->pending_lock, flags);
> > +
> > +	/* Process possibly still pending messages */
> > +	scmi_vio_complete_cb(vioch->vqueue);
> > +
> > +	scmi_vio_channel_release(vioch);
> > +}
> > +
> >  static const char *const scmi_vio_vqueue_names[] = { "tx", "rx" };
> >  
> >  static vq_callback_t *scmi_vio_complete_callbacks[] = {
> > @@ -330,6 +397,19 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
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
> > @@ -397,6 +477,18 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
> >  
> >  	spin_lock_irqsave(&vioch->lock, flags);
> >  
> > +	/*
> > +	 * If polling was requested for this transaction:
> > +	 *  - retrieve last used index (will be used as polling reference)
> > +	 *  - bind the polled message to the xfer via .priv
> > +	 */
> > +	if (xfer->hdr.poll_completion) {
> > +		msg->poll_idx = virtqueue_enable_cb_prepare(vioch->vqueue);
> > +		msg->poll_status = VIO_MSG_POLLING;
> > +		/* Ensure initialized msg is visibly bound to xfer */
> > +		smp_store_mb(xfer->priv, msg);
> > +	}
> > +
> >  	rc = virtqueue_add_sgs(vioch->vqueue, sgs, 1, 1, msg, GFP_ATOMIC);
> >  	if (rc)
> >  		dev_err(vioch->cinfo->dev,
> > @@ -406,8 +498,11 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
> >  
> >  	spin_unlock_irqrestore(&vioch->lock, flags);
> >  
> > -	if (rc)
> > +	if (rc) {
> > +		/* Ensure order between xfer->priv clear and vq feeding */
> > +		smp_store_mb(xfer->priv, NULL);
> >  		scmi_virtio_put_free_msg(vioch, msg);
> > +	}
> >  
> >  	scmi_vio_channel_release(vioch);
> >  
> > @@ -419,10 +514,8 @@ static void virtio_fetch_response(struct scmi_chan_info *cinfo,
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
> > @@ -430,10 +523,173 @@ static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
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
> > + * Free only completed polling transfer messages.
> > + *
> > + * Note that in the SCMI VirtIO transport we never explicitly release timed-out
> > + * messages by forcibly re-adding them to the free-list inside the TX code path;
> > + * we instead let IRQ/RX callbacks eventually clean up such messages once,
> > + * finally, a late reply is received and discarded (if ever).
> > + *
> > + * This approach was deemed preferable since those pending timed-out buffers are
> > + * still effectively owned by the SCMI platform VirtIO device even after timeout
> > + * expiration: forcibly freeing and reusing them before they had been returned
> > + * explicitly by the SCMI platform could lead to subtle bugs due to message
> > + * corruption.
> > + * An SCMI platform VirtIO device which never returns message buffers is
> > + * anyway broken and it will quickly lead to exhaustion of available messages.
> > + *
> > + * For this same reason, here, we take care to free only the polled messages
> > + * that had been somehow replied and not by chance processed on the IRQ path,
> > + * since they won't be freed elsewhere; possible late replies to timed-out
> > + * polled messages will be anyway freed by RX callbacks instead.
> > + *
> > + * @cinfo: SCMI channel info
> > + * @ret: Transmission return code
> > + * @xfer: Transfer descriptor
> > + */
> > +static void virtio_mark_txdone(struct scmi_chan_info *cinfo, int ret,
> > +			       struct scmi_xfer *xfer)
> > +{
> > +	struct scmi_vio_channel *vioch = cinfo->transport_info;
> > +	struct scmi_vio_msg *msg = xfer->priv;
> > +
> > +	if (!scmi_vio_channel_acquire(vioch))
> > +		return;
> > +
> > +	/* Must be a polled xfer and not already freed on the IRQ path */
> > +	if (!xfer->hdr.poll_completion || !msg) {
> > +		scmi_vio_channel_release(vioch);
> > +		return;
> >  	}
> > +
> > +	/* Ensure msg is unbound from xfer anyway at this point */
> > +	smp_store_mb(xfer->priv, NULL);
> > +
> > +	/* Do not free timedout polled messages */
> > +	if (ret != -ETIMEDOUT)
> > +		scmi_virtio_put_free_msg(vioch, msg);
> > +
> > +	scmi_vio_channel_release(vioch);
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
> > + * new to arrive from the host side, but the only way to check if the freshly
> > + * arrived buffer was indeed what we were waiting for is to compare the newly
> > + * arrived message descriptor with the one we are polling on.
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
> > + * busy-waiting helper.
> > + *
> > + * Note that, since we do NOT have per-message suppress notification mechanism,
> > + * the message we are polling for could be alternatively delivered via usual
> > + * IRQs callbacks on another core which happened to have IRQs enabled while we
> > + * are actively polling for it here: in such a case it will be handled as such
> > + * by scmi_rx_callback() and the polling loop in the SCMI Core TX path will be
> > + * transparently terminated anyway.
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
> > +	/* Processed already by other polling loop on another CPU ? */
> > +	if (msg->poll_status == VIO_MSG_POLL_DONE)
> > +		return true;
> > +
> > +	if (!scmi_vio_channel_acquire(vioch))
> > +		return true;
> > +
> > +	/* Has cmdq index moved at all ? */
> > +	pending = virtqueue_poll(vioch->vqueue, msg->poll_idx);
> > +	if (!pending) {
> > +		scmi_vio_channel_release(vioch);
> > +		return false;
> > +	}
> > +
> > +	spin_lock_irqsave(&vioch->lock, flags);
> > +	virtqueue_disable_cb(vioch->vqueue);
> > +
> > +	/*
> > +	 * Process all new messages till the polled-for message is found OR
> > +	 * the vqueue is empty.
> > +	 */
> > +	while ((next_msg = virtqueue_get_buf(vioch->vqueue, &length))) {
> > +		next_msg->rx_len = length;
> > +		/* Is the message we were polling for ? */
> > +		if (next_msg == msg) {
> > +			ret = true;
> > +			break;
> > +		}
> > +
> > +		if (next_msg->poll_status == VIO_MSG_NOT_POLLED) {
> > +			any_prefetched++;
> > +
> > +			spin_lock(&vioch->pending_lock);
> > +			list_add_tail(&next_msg->list,
> > +				      &vioch->pending_cmds_list);
> > +			spin_unlock(&vioch->pending_lock);
> > +		} else {
> > +			/* We picked another currently polled msg */
> > +			smp_store_mb(next_msg->poll_status, VIO_MSG_POLL_DONE);
> 
> What if the polling is just about to time out? Then no thread of execution
> might pick up the message and feed back the buffers.
> 

I think this is another bloody race.. :< .. and it is even worst than
you pointed out since on a system that heavily uses polling, it could
also happen that a very late reply (already timed out fully) is picked
up (dequeud) by another polling thread (instead of the IRQ path) and
so it won't be processed anymore too (neither the buffer fed back).

All seems to boil down to the fact that dequeued messages on the polling
path are not properly handled in every circumstance (i.e. on timeout); in
order to make it work I would:

 - assure that every polled message effectively dequeued is marked as
   VIO_MSG_POLL_DONE in poll_done and freed anyway in mark_txdone()

 - assure each finally timed-out message is marked as such in mark_txdone
   (new poll_status = VIO_MSG_POLL_TIMEOUT)
   
 mark_txdone()
   	if (ret != -ETIMEDOUT || msg->poll_status == VIO_MSG_POLL_DONE)
		scmi_virtio_put_free_msg(vioch, msg);
	else
		msg->poll_status = VIO_MSG_POLL_TIMEOUT;

 - assure in poll_done that any possibly late reply received on a message
   marked already as VIO_MSG_POLL_TIMEOUT will be handled too using the
   deferred worker and pending_cmds_list. (worker which would just free
   the timed out buffer in this case ...)

This way:

- if a message was dequeued on the polling path BUT reaches mark_txdone
  as timed-out is freed there in mark_txdone() anyway

- if instead a message is still inflight (not dequeud) but timed-out when
  it reaches mark_txdone(), it is marked as VIO_MSG_POLL_TIMEOUT and this
  will assure any future received reply to be pushed to the deferred worker
  for final buffer fed back
  
I would avoid the possibly easier solution of pushing every other-polled
still-not-timedout message on the deferred worker because it would slow
down polling path processing.

Now...the bloody hell which I'm trying to address this afternoon is that
all of the above would need to reintroduce the poll_lock to protect the
poll_status flag from being touched by multiple threads of execution
(thing that I recently removed...:<)

Any further thoughts on this are welcome...

Thanks,
Cristian
