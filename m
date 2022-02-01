Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D834F4A621A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240945AbiBARQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:16:28 -0500
Received: from foss.arm.com ([217.140.110.172]:53094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240664AbiBARQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:16:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D80C51476;
        Tue,  1 Feb 2022 09:16:22 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7CB93F40C;
        Tue,  1 Feb 2022 09:16:20 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 4/9] firmware: arm_scmi: Add atomic mode support to virtio transport
Date:   Tue,  1 Feb 2022 17:15:56 +0000
Message-Id: <20220201171601.53316-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220201171601.53316-1-cristian.marussi@arm.com>
References: <20220201171601.53316-1-cristian.marussi@arm.com>
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
 drivers/firmware/arm_scmi/driver.c |   9 +-
 drivers/firmware/arm_scmi/virtio.c | 278 ++++++++++++++++++++++++++++-
 3 files changed, 292 insertions(+), 10 deletions(-)

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
index c2e7897ff56e..dc972a54e93e 100644
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
@@ -680,8 +681,12 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 		xfer->rx.len = info->desc->max_msg_size;
 
 	if (priv)
-		xfer->priv = priv;
+		/* Ensure order between xfer->priv store and following ops */
+		smp_store_mb(xfer->priv, priv);
 	info->desc->ops->fetch_response(cinfo, xfer);
+	if (priv)
+		/* Ensure order between xfer->priv clear and later accesses */
+		smp_store_mb(xfer->priv, NULL);
 
 	trace_scmi_rx_done(xfer->transfer_id, xfer->hdr.id,
 			   xfer->hdr.protocol_id, xfer->hdr.seq,
diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index 22d5a632262f..46d40da7eeaa 100644
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
@@ -42,6 +42,10 @@
  * @cinfo: SCMI Tx or Rx channel
  * @free_lock: Protects access to the @free_list.
  * @free_list: List of unused scmi_vio_msg, maintained for Tx channels only
+ * @deferred_tx_work: Worker for TX deferred replies processing
+ * @deferred_tx_wq: Workqueue for TX deferred replies
+ * @pending_lock: Protects access to the @pending_cmds_list.
+ * @pending_cmds_list: List of pre-fetched commands queueud for later processing
  * @is_rx: Whether channel is an Rx channel
  * @max_msg: Maximum number of pending messages for this channel.
  * @lock: Protects access to all members except users, free_list.
@@ -54,6 +58,11 @@ struct scmi_vio_channel {
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
 	/* lock to protect access to all members except users, free_list  */
@@ -62,6 +71,12 @@ struct scmi_vio_channel {
 	refcount_t users;
 };
 
+enum poll_states {
+	VIO_MSG_NOT_POLLED,
+	VIO_MSG_POLLING,
+	VIO_MSG_POLL_DONE,
+};
+
 /**
  * struct scmi_vio_msg - Transport PDU information
  *
@@ -69,12 +84,17 @@ struct scmi_vio_channel {
  * @input: SDU used for (delayed) responses and notifications
  * @list: List which scmi_vio_msg may be part of
  * @rx_len: Input SDU size in bytes, once input has been received
+ * @poll_idx: Last used index registered for polling purposes if this message
+ *	      transaction reply was configured for polling.
+ * @poll_status: Polling state for this message.
  */
 struct scmi_vio_msg {
 	struct scmi_msg_payld *request;
 	struct scmi_msg_payld *input;
 	struct list_head list;
 	unsigned int rx_len;
+	unsigned int poll_idx;
+	enum poll_states poll_status;
 };
 
 /* Only one SCMI VirtIO device can possibly exist */
@@ -120,6 +140,7 @@ static void scmi_vio_channel_cleanup_sync(struct scmi_vio_channel *vioch)
 	unsigned long flags;
 	struct device *dev;
 	DECLARE_COMPLETION_ONSTACK(vioch_shutdown_done);
+	void *deferred_wq = NULL;
 
 	/*
 	 * Prepare to wait for the last release if not already released
@@ -130,12 +151,22 @@ static void scmi_vio_channel_cleanup_sync(struct scmi_vio_channel *vioch)
 		spin_unlock_irqrestore(&vioch->lock, flags);
 		return;
 	}
+
 	vioch->shutdown_done = &vioch_shutdown_done;
 	vq_name = vioch->is_rx ? "RX" : "TX";
 	/* vioch->cinfo could be NULLified after the release */
 	dev = vioch->cinfo->dev;
+
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
 
 	timeout = msecs_to_jiffies(VIRTIO_MAX_RX_TIMEOUT_MS + 10);
@@ -171,6 +202,8 @@ static void scmi_virtio_put_free_msg(struct scmi_vio_channel *vioch,
 {
 	unsigned long flags;
 
+	msg->poll_status = VIO_MSG_NOT_POLLED;
+
 	spin_lock_irqsave(&vioch->free_lock, flags);
 	list_add_tail(&msg->list, &vioch->free_list);
 	spin_unlock_irqrestore(&vioch->free_lock, flags);
@@ -241,6 +274,7 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
 			virtqueue_disable_cb(vqueue);
 			cb_enabled = false;
 		}
+
 		msg = virtqueue_get_buf(vqueue, &length);
 		if (!msg) {
 			if (virtqueue_enable_cb(vqueue)) {
@@ -271,6 +305,40 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
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
+	/* Process pre-fetched messages */
+	spin_lock_irqsave(&vioch->pending_lock, flags);
+
+	/* Scan the list of possibly pre-fetched messages during polling. */
+	list_for_each_entry_safe(msg, tmp, &vioch->pending_cmds_list, list) {
+		list_del(&msg->list);
+
+		/* Channel is acquired here and cannot vanish */
+		scmi_rx_callback(vioch->cinfo,
+				 msg_read_header(msg->input), msg);
+
+		/* Free the processed message once done */
+		scmi_virtio_put_free_msg(vioch, msg);
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
@@ -338,6 +406,19 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 
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
 
@@ -405,6 +486,18 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
 
 	spin_lock_irqsave(&vioch->lock, flags);
 
+	/*
+	 * If polling was requested for this transaction:
+	 *  - retrieve last used index (will be used as polling reference)
+	 *  - bind the polled message to the xfer via .priv
+	 */
+	if (xfer->hdr.poll_completion) {
+		msg->poll_idx = virtqueue_enable_cb_prepare(vioch->vqueue);
+		msg->poll_status = VIO_MSG_POLLING;
+		/* Ensure initialized msg is visibly bound to xfer */
+		smp_store_mb(xfer->priv, msg);
+	}
+
 	rc = virtqueue_add_sgs(vioch->vqueue, sgs, 1, 1, msg, GFP_ATOMIC);
 	if (rc)
 		dev_err(vioch->cinfo->dev,
@@ -414,8 +507,11 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
 
 	spin_unlock_irqrestore(&vioch->lock, flags);
 
-	if (rc)
+	if (rc) {
+		/* Ensure order between xfer->priv clear and vq feeding */
+		smp_store_mb(xfer->priv, NULL);
 		scmi_virtio_put_free_msg(vioch, msg);
+	}
 
 	scmi_vio_channel_release(vioch);
 
@@ -427,10 +523,8 @@ static void virtio_fetch_response(struct scmi_chan_info *cinfo,
 {
 	struct scmi_vio_msg *msg = xfer->priv;
 
-	if (msg) {
+	if (msg)
 		msg_fetch_response(msg->input, msg->rx_len, xfer);
-		xfer->priv = NULL;
-	}
 }
 
 static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
@@ -438,10 +532,173 @@ static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
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
+ * Note that in the SCMI VirtIO transport we never explicitly release timed-out
+ * messages by forcibly re-adding them to the free-list inside the TX code path;
+ * we instead let IRQ/RX callbacks eventually clean up such messages once,
+ * finally, a late reply is received and discarded (if ever).
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
+ * that had been somehow replied and not by chance processed on the IRQ path,
+ * since they won't be freed elsewhere; possible late replies to timed-out
+ * polled messages will be anyway freed by RX callbacks instead.
+ *
+ * @cinfo: SCMI channel info
+ * @ret: Transmission return code
+ * @xfer: Transfer descriptor
+ */
+static void virtio_mark_txdone(struct scmi_chan_info *cinfo, int ret,
+			       struct scmi_xfer *xfer)
+{
+	struct scmi_vio_channel *vioch = cinfo->transport_info;
+	struct scmi_vio_msg *msg = xfer->priv;
+
+	if (!scmi_vio_channel_acquire(vioch))
+		return;
+
+	/* Must be a polled xfer and not already freed on the IRQ path */
+	if (!xfer->hdr.poll_completion || !msg) {
+		scmi_vio_channel_release(vioch);
+		return;
+	}
+
+	/* Ensure msg is unbound from xfer anyway at this point */
+	smp_store_mb(xfer->priv, NULL);
+
+	/* Do not free timedout polled messages */
+	if (ret != -ETIMEDOUT)
+		scmi_virtio_put_free_msg(vioch, msg);
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
+	bool pending, ret = false;
+	unsigned int length, any_prefetched = 0;
+	unsigned long flags;
+	struct scmi_vio_msg *next_msg, *msg = xfer->priv;
+	struct scmi_vio_channel *vioch = cinfo->transport_info;
+
+	if (!msg)
+		return true;
+
+	/* Processed already by other polling loop on another CPU ? */
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
+		next_msg->rx_len = length;
+		/* Is the message we were polling for ? */
+		if (next_msg == msg) {
+			ret = true;
+			break;
+		}
+
+		if (next_msg->poll_status == VIO_MSG_NOT_POLLED) {
+			any_prefetched++;
+
+			spin_lock(&vioch->pending_lock);
+			list_add_tail(&next_msg->list,
+				      &vioch->pending_cmds_list);
+			spin_unlock(&vioch->pending_lock);
+		} else {
+			/* We picked another currently polled msg */
+			smp_store_mb(next_msg->poll_status, VIO_MSG_POLL_DONE);
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
+	if (ret) {
+		pending = !virtqueue_enable_cb(vioch->vqueue);
+	} else {
+		msg->poll_idx = virtqueue_enable_cb_prepare(vioch->vqueue);
+		pending = virtqueue_poll(vioch->vqueue, msg->poll_idx);
 	}
+
+	if (vioch->deferred_tx_wq && (any_prefetched || pending))
+		queue_work(vioch->deferred_tx_wq, &vioch->deferred_tx_work);
+
+	spin_unlock_irqrestore(&vioch->lock, flags);
+
+	scmi_vio_channel_release(vioch);
+
+	return ret;
 }
 
 static const struct scmi_transport_ops scmi_virtio_ops = {
@@ -453,6 +710,8 @@ static const struct scmi_transport_ops scmi_virtio_ops = {
 	.send_message = virtio_send_message,
 	.fetch_response = virtio_fetch_response,
 	.fetch_notification = virtio_fetch_notification,
+	.mark_txdone = virtio_mark_txdone,
+	.poll_done = virtio_poll_done,
 };
 
 static int scmi_vio_probe(struct virtio_device *vdev)
@@ -495,6 +754,8 @@ static int scmi_vio_probe(struct virtio_device *vdev)
 		spin_lock_init(&channels[i].lock);
 		spin_lock_init(&channels[i].free_lock);
 		INIT_LIST_HEAD(&channels[i].free_list);
+		spin_lock_init(&channels[i].pending_lock);
+		INIT_LIST_HEAD(&channels[i].pending_cmds_list);
 		channels[i].vqueue = vqs[i];
 
 		sz = virtqueue_get_vring_size(channels[i].vqueue);
@@ -584,4 +845,5 @@ const struct scmi_desc scmi_virtio_desc = {
 	.max_rx_timeout_ms = VIRTIO_MAX_RX_TIMEOUT_MS,
 	.max_msg = 0, /* overridden by virtio_get_max_msg() */
 	.max_msg_size = VIRTIO_SCMI_MAX_MSG_SIZE,
+	.atomic_enabled = IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE),
 };
-- 
2.17.1

