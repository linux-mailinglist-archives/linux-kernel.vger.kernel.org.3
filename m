Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854234BA0C3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240789AbiBQNNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:13:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240713AbiBQNNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:13:21 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38A632AE299
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:13:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 010C01480;
        Thu, 17 Feb 2022 05:12:58 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CCC83F66F;
        Thu, 17 Feb 2022 05:12:55 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v5 3/8] firmware: arm_scmi: Add atomic mode support to virtio transport
Date:   Thu, 17 Feb 2022 13:12:29 +0000
Message-Id: <20220217131234.50328-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220217131234.50328-1-cristian.marussi@arm.com>
References: <20220217131234.50328-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for .mark_txdone and .poll_done transport operations to SCMI
VirtIO transport as pre-requisites to enable atomic operations.

Add a Kernel configuration option to enable SCMI VirtIO transport polling
and atomic mode for selected SCMI transactions while leaving it default
disabled.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
Cc: Peter Hilber <peter.hilber@opensynergy.com>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v4 --> v5
- introduced vio_msg refcounts and helpers to avoid premature reuse of
  freed messages when both poling and IRQ path are active on a buffer
- better handling of timed out polled messages on late replies using new
  VIO_MSG_POLL_TIMEOUT state
- fixed comments on locks

v1 --> v2
- shrinked spinlocked section within virtio_poll_done to exclude
  virtqueue_poll
- removed poll_lock
- use vio channel refcount acquire/release logic when polling
- using new free_list accessors
- added new dedicated pending_lock to access pending_cmds_list
- fixed a few comments

v0 --> v1
- check for deferred_wq existence before queueing work to avoid
  race at driver removal time
- changed mark_txdone decision-logic about message release
- fixed race while checking for msg polled from another thread
- using dedicated poll_status instead of poll_idx upper bits
- pick initial poll_idx earlier inside send_message to avoid missing
  early replies
- removed F_NOTIFY mention in comment
- clearing xfer->priv on the IRQ tx path once message has been fetched
- added some store barriers
- updated some comments
---
 drivers/firmware/arm_scmi/Kconfig  |  15 ++
 drivers/firmware/arm_scmi/driver.c |   6 +-
 drivers/firmware/arm_scmi/virtio.c | 390 +++++++++++++++++++++++++++--
 3 files changed, 391 insertions(+), 20 deletions(-)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index d429326433d1..7794bd41eaa0 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -118,6 +118,21 @@ config ARM_SCMI_TRANSPORT_VIRTIO_VERSION1_COMPLIANCE
 	  the ones implemented by kvmtool) and let the core Kernel VirtIO layer
 	  take care of the needed conversions, say N.
 
+config ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
+	bool "Enable atomic mode for SCMI VirtIO transport"
+	depends on ARM_SCMI_TRANSPORT_VIRTIO
+	help
+	  Enable support of atomic operation for SCMI VirtIO based transport.
+
+	  If you want the SCMI VirtIO based transport to operate in atomic
+	  mode, avoiding any kind of sleeping behaviour for selected
+	  transactions on the TX path, answer Y.
+
+	  Enabling atomic mode operations allows any SCMI driver using this
+	  transport to optionally ask for atomic SCMI transactions and operate
+	  in atomic context too, at the price of using a number of busy-waiting
+	  primitives all over instead. If unsure say N.
+
 endif #ARM_SCMI_PROTOCOL
 
 config ARM_SCMI_POWER_DOMAIN
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index c2e7897ff56e..4fd5a35ffa2f 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -648,7 +648,8 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
 
 	unpack_scmi_header(msg_hdr, &xfer->hdr);
 	if (priv)
-		xfer->priv = priv;
+		/* Ensure order between xfer->priv store and following ops */
+		smp_store_mb(xfer->priv, priv);
 	info->desc->ops->fetch_notification(cinfo, info->desc->max_msg_size,
 					    xfer);
 	scmi_notify(cinfo->handle, xfer->hdr.protocol_id,
@@ -680,7 +681,8 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 		xfer->rx.len = info->desc->max_msg_size;
 
 	if (priv)
-		xfer->priv = priv;
+		/* Ensure order between xfer->priv store and following ops */
+		smp_store_mb(xfer->priv, priv);
 	info->desc->ops->fetch_response(cinfo, xfer);
 
 	trace_scmi_rx_done(xfer->transfer_id, xfer->hdr.id,
diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index 7ec4085cee7e..f69442e97389 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -3,8 +3,8 @@
  * Virtio Transport driver for Arm System Control and Management Interface
  * (SCMI).
  *
- * Copyright (C) 2020-2021 OpenSynergy.
- * Copyright (C) 2021 ARM Ltd.
+ * Copyright (C) 2020-2022 OpenSynergy.
+ * Copyright (C) 2021-2022 ARM Ltd.
  */
 
 /**
@@ -42,9 +42,14 @@
  * @cinfo: SCMI Tx or Rx channel
  * @free_lock: Protects access to the @free_list.
  * @free_list: List of unused scmi_vio_msg, maintained for Tx channels only
+ * @deferred_tx_work: Worker for TX deferred replies processing
+ * @deferred_tx_wq: Workqueue for TX deferred replies
+ * @pending_lock: Protects access to the @pending_cmds_list.
+ * @pending_cmds_list: List of pre-fetched commands queueud for later processing
  * @is_rx: Whether channel is an Rx channel
  * @max_msg: Maximum number of pending messages for this channel.
- * @lock: Protects access to all members except users, free_list.
+ * @lock: Protects access to all members except users, free_list and
+ *	  pending_cmds_list.
  * @shutdown_done: A reference to a completion used when freeing this channel.
  * @users: A reference count to currently active users of this channel.
  */
@@ -54,14 +59,29 @@ struct scmi_vio_channel {
 	/* lock to protect access to the free list. */
 	spinlock_t free_lock;
 	struct list_head free_list;
+	/* lock to protect access to the pending list. */
+	spinlock_t pending_lock;
+	struct list_head pending_cmds_list;
+	struct work_struct deferred_tx_work;
+	struct workqueue_struct *deferred_tx_wq;
 	bool is_rx;
 	unsigned int max_msg;
-	/* lock to protect access to all members except users, free_list  */
+	/*
+	 * Lock to protect access to all members except users, free_list and
+	 * pending_cmds_list
+	 */
 	spinlock_t lock;
 	struct completion *shutdown_done;
 	refcount_t users;
 };
 
+enum poll_states {
+	VIO_MSG_NOT_POLLED,
+	VIO_MSG_POLL_TIMEOUT,
+	VIO_MSG_POLLING,
+	VIO_MSG_POLL_DONE,
+};
+
 /**
  * struct scmi_vio_msg - Transport PDU information
  *
@@ -69,12 +89,23 @@ struct scmi_vio_channel {
  * @input: SDU used for (delayed) responses and notifications
  * @list: List which scmi_vio_msg may be part of
  * @rx_len: Input SDU size in bytes, once input has been received
+ * @poll_idx: Last used index registered for polling purposes if this message
+ *	      transaction reply was configured for polling.
+ * @poll_status: Polling state for this message.
+ * @poll_lock: A lock to protect @poll_status
+ * @users: A reference count to track this message users and avoid premature
+ *	   freeing (and reuse) when polling and IRQ execution paths interleave.
  */
 struct scmi_vio_msg {
 	struct scmi_msg_payld *request;
 	struct scmi_msg_payld *input;
 	struct list_head list;
 	unsigned int rx_len;
+	unsigned int poll_idx;
+	enum poll_states poll_status;
+	/* Lock to protect access to poll_status */
+	spinlock_t poll_lock;
+	refcount_t users;
 };
 
 /* Only one SCMI VirtIO device can possibly exist */
@@ -117,6 +148,7 @@ static void scmi_vio_channel_cleanup_sync(struct scmi_vio_channel *vioch)
 {
 	unsigned long flags;
 	DECLARE_COMPLETION_ONSTACK(vioch_shutdown_done);
+	void *deferred_wq = NULL;
 
 	/*
 	 * Prepare to wait for the last release if not already released
@@ -127,10 +159,19 @@ static void scmi_vio_channel_cleanup_sync(struct scmi_vio_channel *vioch)
 		spin_unlock_irqrestore(&vioch->lock, flags);
 		return;
 	}
+
 	vioch->shutdown_done = &vioch_shutdown_done;
 	virtio_break_device(vioch->vqueue->vdev);
+	if (!vioch->is_rx && vioch->deferred_tx_wq) {
+		deferred_wq = vioch->deferred_tx_wq;
+		/* Cannot be kicked anymore after this...*/
+		vioch->deferred_tx_wq = NULL;
+	}
 	spin_unlock_irqrestore(&vioch->lock, flags);
 
+	if (deferred_wq)
+		destroy_workqueue(deferred_wq);
+
 	scmi_vio_channel_release(vioch);
 
 	/* Let any possibly concurrent RX path release the channel */
@@ -154,18 +195,34 @@ scmi_virtio_get_free_msg(struct scmi_vio_channel *vioch)
 	list_del_init(&msg->list);
 	spin_unlock_irqrestore(&vioch->free_lock, flags);
 
+	/* Still no users, no need to acquire poll_lock */
+	msg->poll_status = VIO_MSG_NOT_POLLED;
+	refcount_set(&msg->users, 1);
+
 	return msg;
 }
 
+static inline bool scmi_vio_msg_acquire(struct scmi_vio_msg *msg)
+{
+	return refcount_inc_not_zero(&msg->users);
+}
+
 /* Assumes to be called with vio channel acquired already */
-static void scmi_virtio_put_free_msg(struct scmi_vio_channel *vioch,
-				     struct scmi_vio_msg *msg)
+static inline bool scmi_vio_msg_release(struct scmi_vio_channel *vioch,
+					struct scmi_vio_msg *msg)
 {
-	unsigned long flags;
+	bool ret;
 
-	spin_lock_irqsave(&vioch->free_lock, flags);
-	list_add_tail(&msg->list, &vioch->free_list);
-	spin_unlock_irqrestore(&vioch->free_lock, flags);
+	ret = refcount_dec_and_test(&msg->users);
+	if (ret) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&vioch->free_lock, flags);
+		list_add_tail(&msg->list, &vioch->free_list);
+		spin_unlock_irqrestore(&vioch->free_lock, flags);
+	}
+
+	return ret;
 }
 
 static bool scmi_vio_have_vq_rx(struct virtio_device *vdev)
@@ -206,7 +263,7 @@ static void scmi_finalize_message(struct scmi_vio_channel *vioch,
 	if (vioch->is_rx)
 		scmi_vio_feed_vq_rx(vioch, msg);
 	else
-		scmi_virtio_put_free_msg(vioch, msg);
+		scmi_vio_msg_release(vioch, msg);
 }
 
 static void scmi_vio_complete_cb(struct virtqueue *vqueue)
@@ -230,6 +287,7 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
 			virtqueue_disable_cb(vqueue);
 			cb_enabled = false;
 		}
+
 		msg = virtqueue_get_buf(vqueue, &length);
 		if (!msg) {
 			if (virtqueue_enable_cb(vqueue)) {
@@ -260,6 +318,49 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
 	}
 }
 
+static void scmi_vio_deferred_tx_worker(struct work_struct *work)
+{
+	unsigned long flags;
+	struct scmi_vio_channel *vioch;
+	struct scmi_vio_msg *msg, *tmp;
+
+	vioch = container_of(work, struct scmi_vio_channel, deferred_tx_work);
+
+	if (!scmi_vio_channel_acquire(vioch))
+		return;
+
+	/*
+	 * Process pre-fetched messages: these could be non-polled messages or
+	 * late timed-out replies to polled messages dequeued by chance while
+	 * polling for some other messages: this worker is in charge to process
+	 * the valid non-expired messages and anyway finally free all of them.
+	 */
+	spin_lock_irqsave(&vioch->pending_lock, flags);
+
+	/* Scan the list of possibly pre-fetched messages during polling. */
+	list_for_each_entry_safe(msg, tmp, &vioch->pending_cmds_list, list) {
+		list_del(&msg->list);
+
+		/*
+		 * Channel is acquired here (cannot vanish) and this message
+		 * is no more processed elsewhere so no poll_lock needed.
+		 */
+		if (msg->poll_status == VIO_MSG_NOT_POLLED)
+			scmi_rx_callback(vioch->cinfo,
+					 msg_read_header(msg->input), msg);
+
+		/* Free the processed message once done */
+		scmi_vio_msg_release(vioch, msg);
+	}
+
+	spin_unlock_irqrestore(&vioch->pending_lock, flags);
+
+	/* Process possibly still pending messages */
+	scmi_vio_complete_cb(vioch->vqueue);
+
+	scmi_vio_channel_release(vioch);
+}
+
 static const char *const scmi_vio_vqueue_names[] = { "tx", "rx" };
 
 static vq_callback_t *scmi_vio_complete_callbacks[] = {
@@ -327,6 +428,19 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 
 	vioch = &((struct scmi_vio_channel *)scmi_vdev->priv)[index];
 
+	/* Setup a deferred worker for polling. */
+	if (tx && !vioch->deferred_tx_wq) {
+		vioch->deferred_tx_wq =
+			alloc_workqueue(dev_name(&scmi_vdev->dev),
+					WQ_UNBOUND | WQ_FREEZABLE | WQ_SYSFS,
+					0);
+		if (!vioch->deferred_tx_wq)
+			return -ENOMEM;
+
+		INIT_WORK(&vioch->deferred_tx_work,
+			  scmi_vio_deferred_tx_worker);
+	}
+
 	for (i = 0; i < vioch->max_msg; i++) {
 		struct scmi_vio_msg *msg;
 
@@ -340,6 +454,8 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 						    GFP_KERNEL);
 			if (!msg->request)
 				return -ENOMEM;
+			spin_lock_init(&msg->poll_lock);
+			refcount_set(&msg->users, 1);
 		}
 
 		msg->input = devm_kzalloc(cinfo->dev, VIRTIO_SCMI_MAX_PDU_SIZE,
@@ -394,6 +510,21 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
 
 	spin_lock_irqsave(&vioch->lock, flags);
 
+	/*
+	 * If polling was requested for this transaction:
+	 *  - retrieve last used index (will be used as polling reference)
+	 *  - bind the polled message to the xfer via .priv
+	 *  - grab an additional msg refcount for the poll-path
+	 */
+	if (xfer->hdr.poll_completion) {
+		msg->poll_idx = virtqueue_enable_cb_prepare(vioch->vqueue);
+		/* Still no users, no need to acquire poll_lock */
+		msg->poll_status = VIO_MSG_POLLING;
+		scmi_vio_msg_acquire(msg);
+		/* Ensure initialized msg is visibly bound to xfer */
+		smp_store_mb(xfer->priv, msg);
+	}
+
 	rc = virtqueue_add_sgs(vioch->vqueue, sgs, 1, 1, msg, GFP_ATOMIC);
 	if (rc)
 		dev_err(vioch->cinfo->dev,
@@ -403,8 +534,13 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
 
 	spin_unlock_irqrestore(&vioch->lock, flags);
 
-	if (rc)
-		scmi_virtio_put_free_msg(vioch, msg);
+	if (rc) {
+		/* Ensure order between xfer->priv clear and vq feeding */
+		smp_store_mb(xfer->priv, NULL);
+		if (xfer->hdr.poll_completion)
+			scmi_vio_msg_release(vioch, msg);
+		scmi_vio_msg_release(vioch, msg);
+	}
 
 	scmi_vio_channel_release(vioch);
 
@@ -416,10 +552,8 @@ static void virtio_fetch_response(struct scmi_chan_info *cinfo,
 {
 	struct scmi_vio_msg *msg = xfer->priv;
 
-	if (msg) {
+	if (msg)
 		msg_fetch_response(msg->input, msg->rx_len, xfer);
-		xfer->priv = NULL;
-	}
 }
 
 static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
@@ -427,10 +561,225 @@ static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
 {
 	struct scmi_vio_msg *msg = xfer->priv;
 
-	if (msg) {
+	if (msg)
 		msg_fetch_notification(msg->input, msg->rx_len, max_len, xfer);
-		xfer->priv = NULL;
+}
+
+/**
+ * virtio_mark_txdone  - Mark transmission done
+ *
+ * Free only completed polling transfer messages.
+ *
+ * Note that in the SCMI VirtIO transport we never explicitly release still
+ * outstanding but timed-out messages by forcibly re-adding them to the
+ * free-list inside the TX code path; we instead let IRQ/RX callbacks, or the
+ * TX deferred worker, eventually clean up such messages once, finally, a late
+ * reply is received and discarded (if ever).
+ *
+ * This approach was deemed preferable since those pending timed-out buffers are
+ * still effectively owned by the SCMI platform VirtIO device even after timeout
+ * expiration: forcibly freeing and reusing them before they had been returned
+ * explicitly by the SCMI platform could lead to subtle bugs due to message
+ * corruption.
+ * An SCMI platform VirtIO device which never returns message buffers is
+ * anyway broken and it will quickly lead to exhaustion of available messages.
+ *
+ * For this same reason, here, we take care to free only the polled messages
+ * that had been somehow replied (only if not by chance already processed on the
+ * IRQ path - the initial scmi_vio_msg_release() takes care of this) and also
+ * any timed-out polled message if that indeed appears to have been at least
+ * dequeued from the virtqueues (VIO_MSG_POLL_DONE): this is needed since such
+ * messages won't be freed elsewhere. Any other polled message is marked as
+ * VIO_MSG_POLL_TIMEOUT.
+ *
+ * Possible late replies to timed-out polled messages will be eventually freed
+ * by RX callbacks if delivered on the IRQ path or by the deferred TX worker if
+ * dequeued on some other polling path.
+ *
+ * @cinfo: SCMI channel info
+ * @ret: Transmission return code
+ * @xfer: Transfer descriptor
+ */
+static void virtio_mark_txdone(struct scmi_chan_info *cinfo, int ret,
+			       struct scmi_xfer *xfer)
+{
+	unsigned long flags;
+	struct scmi_vio_channel *vioch = cinfo->transport_info;
+	struct scmi_vio_msg *msg = xfer->priv;
+
+	if (!msg || !scmi_vio_channel_acquire(vioch))
+		return;
+
+	/* Ensure msg is unbound from xfer anyway at this point */
+	smp_store_mb(xfer->priv, NULL);
+
+	/* Must be a polled xfer and not already freed on the IRQ path */
+	if (!xfer->hdr.poll_completion || scmi_vio_msg_release(vioch, msg)) {
+		scmi_vio_channel_release(vioch);
+		return;
 	}
+
+	spin_lock_irqsave(&msg->poll_lock, flags);
+	/* Do not free timedout polled messages only if still inflight */
+	if (ret != -ETIMEDOUT || msg->poll_status == VIO_MSG_POLL_DONE)
+		scmi_vio_msg_release(vioch, msg);
+	else if (msg->poll_status == VIO_MSG_POLLING)
+		msg->poll_status = VIO_MSG_POLL_TIMEOUT;
+	spin_unlock_irqrestore(&msg->poll_lock, flags);
+
+	scmi_vio_channel_release(vioch);
+}
+
+/**
+ * virtio_poll_done  - Provide polling support for VirtIO transport
+ *
+ * @cinfo: SCMI channel info
+ * @xfer: Reference to the transfer being poll for.
+ *
+ * VirtIO core provides a polling mechanism based only on last used indexes:
+ * this means that it is possible to poll the virtqueues waiting for something
+ * new to arrive from the host side, but the only way to check if the freshly
+ * arrived buffer was indeed what we were waiting for is to compare the newly
+ * arrived message descriptor with the one we are polling on.
+ *
+ * As a consequence it can happen to dequeue something different from the buffer
+ * we were poll-waiting for: if that is the case such early fetched buffers are
+ * then added to a the @pending_cmds_list list for later processing by a
+ * dedicated deferred worker.
+ *
+ * So, basically, once something new is spotted we proceed to de-queue all the
+ * freshly received used buffers until we found the one we were polling on, or,
+ * we have 'seemingly' emptied the virtqueue; if some buffers are still pending
+ * in the vqueue at the end of the polling loop (possible due to inherent races
+ * in virtqueues handling mechanisms), we similarly kick the deferred worker
+ * and let it process those, to avoid indefinitely looping in the .poll_done
+ * busy-waiting helper.
+ *
+ * Finally, we delegate to the deferred worker also the final free of any timed
+ * out reply to a polled message that we should dequeue.
+ *
+ * Note that, since we do NOT have per-message suppress notification mechanism,
+ * the message we are polling for could be alternatively delivered via usual
+ * IRQs callbacks on another core which happened to have IRQs enabled while we
+ * are actively polling for it here: in such a case it will be handled as such
+ * by scmi_rx_callback() and the polling loop in the SCMI Core TX path will be
+ * transparently terminated anyway.
+ *
+ * Return: True once polling has successfully completed.
+ */
+static bool virtio_poll_done(struct scmi_chan_info *cinfo,
+			     struct scmi_xfer *xfer)
+{
+	bool pending, found = false;
+	unsigned int length, any_prefetched = 0;
+	unsigned long flags;
+	struct scmi_vio_msg *next_msg, *msg = xfer->priv;
+	struct scmi_vio_channel *vioch = cinfo->transport_info;
+
+	if (!msg)
+		return true;
+
+	/*
+	 * Processed already by other polling loop on another CPU ?
+	 *
+	 * Note that this message is acquired on the poll path so cannot vanish
+	 * while inside this loop iteration even if concurrently processed on
+	 * the IRQ path.
+	 *
+	 * Avoid to acquire poll_lock since polled_status can be changed
+	 * in a relevant manner only later in this same thread of execution:
+	 * any other possible changes made concurrently by other polling loops
+	 * or by a reply delivered on the IRQ path have no meaningful impact on
+	 * this loop iteration: in other words it is harmless to allow this
+	 * possible race but let has avoid spinlocking with irqs off in this
+	 * initial part of the polling loop.
+	 */
+	if (msg->poll_status == VIO_MSG_POLL_DONE)
+		return true;
+
+	if (!scmi_vio_channel_acquire(vioch))
+		return true;
+
+	/* Has cmdq index moved at all ? */
+	pending = virtqueue_poll(vioch->vqueue, msg->poll_idx);
+	if (!pending) {
+		scmi_vio_channel_release(vioch);
+		return false;
+	}
+
+	spin_lock_irqsave(&vioch->lock, flags);
+	virtqueue_disable_cb(vioch->vqueue);
+
+	/*
+	 * Process all new messages till the polled-for message is found OR
+	 * the vqueue is empty.
+	 */
+	while ((next_msg = virtqueue_get_buf(vioch->vqueue, &length))) {
+		bool next_msg_done = false;
+
+		/*
+		 * Mark any dequeued buffer message as VIO_MSG_POLL_DONE so
+		 * that can be properly freed even on timeout in mark_txdone.
+		 */
+		spin_lock(&next_msg->poll_lock);
+		if (next_msg->poll_status == VIO_MSG_POLLING) {
+			next_msg->poll_status = VIO_MSG_POLL_DONE;
+			next_msg_done = true;
+		}
+		spin_unlock(&next_msg->poll_lock);
+
+		next_msg->rx_len = length;
+		/* Is the message we were polling for ? */
+		if (next_msg == msg) {
+			found = true;
+			break;
+		} else if (next_msg_done) {
+			/* Skip the rest if this was another polled msg */
+			continue;
+		}
+
+		/*
+		 * Enqueue for later processing any non-polled message and any
+		 * timed-out polled one that we happen to have dequeued.
+		 */
+		spin_lock(&next_msg->poll_lock);
+		if (next_msg->poll_status == VIO_MSG_NOT_POLLED ||
+		    next_msg->poll_status == VIO_MSG_POLL_TIMEOUT) {
+			spin_unlock(&next_msg->poll_lock);
+
+			any_prefetched++;
+			spin_lock(&vioch->pending_lock);
+			list_add_tail(&next_msg->list,
+				      &vioch->pending_cmds_list);
+			spin_unlock(&vioch->pending_lock);
+		} else {
+			spin_unlock(&next_msg->poll_lock);
+		}
+	}
+
+	/*
+	 * When the polling loop has successfully terminated if something
+	 * else was queued in the meantime, it will be served by a deferred
+	 * worker OR by the normal IRQ/callback OR by other poll loops.
+	 *
+	 * If we are still looking for the polled reply, the polling index has
+	 * to be updated to the current vqueue last used index.
+	 */
+	if (found) {
+		pending = !virtqueue_enable_cb(vioch->vqueue);
+	} else {
+		msg->poll_idx = virtqueue_enable_cb_prepare(vioch->vqueue);
+		pending = virtqueue_poll(vioch->vqueue, msg->poll_idx);
+	}
+
+	if (vioch->deferred_tx_wq && (any_prefetched || pending))
+		queue_work(vioch->deferred_tx_wq, &vioch->deferred_tx_work);
+
+	spin_unlock_irqrestore(&vioch->lock, flags);
+
+	scmi_vio_channel_release(vioch);
+
+	return found;
 }
 
 static const struct scmi_transport_ops scmi_virtio_ops = {
@@ -442,6 +791,8 @@ static const struct scmi_transport_ops scmi_virtio_ops = {
 	.send_message = virtio_send_message,
 	.fetch_response = virtio_fetch_response,
 	.fetch_notification = virtio_fetch_notification,
+	.mark_txdone = virtio_mark_txdone,
+	.poll_done = virtio_poll_done,
 };
 
 static int scmi_vio_probe(struct virtio_device *vdev)
@@ -484,6 +835,8 @@ static int scmi_vio_probe(struct virtio_device *vdev)
 		spin_lock_init(&channels[i].lock);
 		spin_lock_init(&channels[i].free_lock);
 		INIT_LIST_HEAD(&channels[i].free_list);
+		spin_lock_init(&channels[i].pending_lock);
+		INIT_LIST_HEAD(&channels[i].pending_cmds_list);
 		channels[i].vqueue = vqs[i];
 
 		sz = virtqueue_get_vring_size(channels[i].vqueue);
@@ -573,4 +926,5 @@ const struct scmi_desc scmi_virtio_desc = {
 	.max_rx_timeout_ms = VIRTIO_MAX_RX_TIMEOUT_MS,
 	.max_msg = 0, /* overridden by virtio_get_max_msg() */
 	.max_msg_size = VIRTIO_SCMI_MAX_MSG_SIZE,
+	.atomic_enabled = IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE),
 };
-- 
2.17.1

