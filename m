Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EC74BA0C4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240798AbiBQNNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:13:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240729AbiBQNNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:13:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A3412AE285
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:13:09 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCAD11396;
        Thu, 17 Feb 2022 05:12:53 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4E8F3F66F;
        Thu, 17 Feb 2022 05:12:51 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v5 1/8] firmware: arm_scmi: Add a virtio channel refcount
Date:   Thu, 17 Feb 2022 13:12:27 +0000
Message-Id: <20220217131234.50328-2-cristian.marussi@arm.com>
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

Currently SCMI VirtIO channels are marked with a ready flag and related
lock to track channel lifetime and support proper synchronization at
shutdown when virtqueues have to be stopped.

This leads to some extended spinlocked sections with IRQs off on the RX
path to keep hold of the ready flag and does not scale well especially when
SCMI VirtIO polling mode will be introduced.

Add an SCMI VirtIO channel dedicated refcount to track active users on both
the TX and the RX path and properly enforce synchronization and cleanup at
shutdown, inhibiting further usage of the channel once freed.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
Cc: Peter Hilber <peter.hilber@opensynergy.com>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v4 --> v5
- removed unneeded virtqueue re-enable when fail to acquire channel in
  complete_cb
v2 --> v3
- Break virtio device at shutdown while cleaning up SCMI channel
---
 drivers/firmware/arm_scmi/virtio.c | 143 +++++++++++++++++++----------
 1 file changed, 92 insertions(+), 51 deletions(-)

diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index fd0f6f91fc0b..ed00b072e981 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -17,7 +17,9 @@
  * virtqueue. Access to each virtqueue is protected by spinlocks.
  */
 
+#include <linux/completion.h>
 #include <linux/errno.h>
+#include <linux/refcount.h>
 #include <linux/slab.h>
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
@@ -27,6 +29,7 @@
 
 #include "common.h"
 
+#define VIRTIO_MAX_RX_TIMEOUT_MS	60000
 #define VIRTIO_SCMI_MAX_MSG_SIZE 128 /* Value may be increased. */
 #define VIRTIO_SCMI_MAX_PDU_SIZE \
 	(VIRTIO_SCMI_MAX_MSG_SIZE + SCMI_MSG_MAX_PROT_OVERHEAD)
@@ -39,23 +42,21 @@
  * @cinfo: SCMI Tx or Rx channel
  * @free_list: List of unused scmi_vio_msg, maintained for Tx channels only
  * @is_rx: Whether channel is an Rx channel
- * @ready: Whether transport user is ready to hear about channel
  * @max_msg: Maximum number of pending messages for this channel.
- * @lock: Protects access to all members except ready.
- * @ready_lock: Protects access to ready. If required, it must be taken before
- *              lock.
+ * @lock: Protects access to all members except users.
+ * @shutdown_done: A reference to a completion used when freeing this channel.
+ * @users: A reference count to currently active users of this channel.
  */
 struct scmi_vio_channel {
 	struct virtqueue *vqueue;
 	struct scmi_chan_info *cinfo;
 	struct list_head free_list;
 	bool is_rx;
-	bool ready;
 	unsigned int max_msg;
-	/* lock to protect access to all members except ready. */
+	/* lock to protect access to all members except users. */
 	spinlock_t lock;
-	/* lock to rotects access to ready flag. */
-	spinlock_t ready_lock;
+	struct completion *shutdown_done;
+	refcount_t users;
 };
 
 /**
@@ -76,6 +77,63 @@ struct scmi_vio_msg {
 /* Only one SCMI VirtIO device can possibly exist */
 static struct virtio_device *scmi_vdev;
 
+static void scmi_vio_channel_ready(struct scmi_vio_channel *vioch,
+				   struct scmi_chan_info *cinfo)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&vioch->lock, flags);
+	cinfo->transport_info = vioch;
+	/* Indirectly setting channel not available any more */
+	vioch->cinfo = cinfo;
+	spin_unlock_irqrestore(&vioch->lock, flags);
+
+	refcount_set(&vioch->users, 1);
+}
+
+static inline bool scmi_vio_channel_acquire(struct scmi_vio_channel *vioch)
+{
+	return refcount_inc_not_zero(&vioch->users);
+}
+
+static inline void scmi_vio_channel_release(struct scmi_vio_channel *vioch)
+{
+	if (refcount_dec_and_test(&vioch->users)) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&vioch->lock, flags);
+		if (vioch->shutdown_done) {
+			vioch->cinfo = NULL;
+			complete(vioch->shutdown_done);
+		}
+		spin_unlock_irqrestore(&vioch->lock, flags);
+	}
+}
+
+static void scmi_vio_channel_cleanup_sync(struct scmi_vio_channel *vioch)
+{
+	unsigned long flags;
+	DECLARE_COMPLETION_ONSTACK(vioch_shutdown_done);
+
+	/*
+	 * Prepare to wait for the last release if not already released
+	 * or in progress.
+	 */
+	spin_lock_irqsave(&vioch->lock, flags);
+	if (!vioch->cinfo || vioch->shutdown_done) {
+		spin_unlock_irqrestore(&vioch->lock, flags);
+		return;
+	}
+	vioch->shutdown_done = &vioch_shutdown_done;
+	virtio_break_device(vioch->vqueue->vdev);
+	spin_unlock_irqrestore(&vioch->lock, flags);
+
+	scmi_vio_channel_release(vioch);
+
+	/* Let any possibly concurrent RX path release the channel */
+	wait_for_completion(vioch->shutdown_done);
+}
+
 static bool scmi_vio_have_vq_rx(struct virtio_device *vdev)
 {
 	return virtio_has_feature(vdev, VIRTIO_SCMI_F_P2A_CHANNELS);
@@ -119,7 +177,7 @@ static void scmi_finalize_message(struct scmi_vio_channel *vioch,
 
 static void scmi_vio_complete_cb(struct virtqueue *vqueue)
 {
-	unsigned long ready_flags;
+	unsigned long flags;
 	unsigned int length;
 	struct scmi_vio_channel *vioch;
 	struct scmi_vio_msg *msg;
@@ -130,27 +188,24 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
 	vioch = &((struct scmi_vio_channel *)vqueue->vdev->priv)[vqueue->index];
 
 	for (;;) {
-		spin_lock_irqsave(&vioch->ready_lock, ready_flags);
-
-		if (!vioch->ready) {
-			if (!cb_enabled)
-				(void)virtqueue_enable_cb(vqueue);
-			goto unlock_ready_out;
-		}
+		if (!scmi_vio_channel_acquire(vioch))
+			return;
 
-		/* IRQs already disabled here no need to irqsave */
-		spin_lock(&vioch->lock);
+		spin_lock_irqsave(&vioch->lock, flags);
 		if (cb_enabled) {
 			virtqueue_disable_cb(vqueue);
 			cb_enabled = false;
 		}
 		msg = virtqueue_get_buf(vqueue, &length);
 		if (!msg) {
-			if (virtqueue_enable_cb(vqueue))
-				goto unlock_out;
+			if (virtqueue_enable_cb(vqueue)) {
+				spin_unlock_irqrestore(&vioch->lock, flags);
+				scmi_vio_channel_release(vioch);
+				return;
+			}
 			cb_enabled = true;
 		}
-		spin_unlock(&vioch->lock);
+		spin_unlock_irqrestore(&vioch->lock, flags);
 
 		if (msg) {
 			msg->rx_len = length;
@@ -161,19 +216,14 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
 		}
 
 		/*
-		 * Release ready_lock and re-enable IRQs between loop iterations
-		 * to allow virtio_chan_free() to possibly kick in and set the
-		 * flag vioch->ready to false even in between processing of
-		 * messages, so as to force outstanding messages to be ignored
-		 * when system is shutting down.
+		 * Release vio channel between loop iterations to allow
+		 * virtio_chan_free() to eventually fully release it when
+		 * shutting down; in such a case, any outstanding message will
+		 * be ignored since this loop will bail out at the next
+		 * iteration.
 		 */
-		spin_unlock_irqrestore(&vioch->ready_lock, ready_flags);
+		scmi_vio_channel_release(vioch);
 	}
-
-unlock_out:
-	spin_unlock(&vioch->lock);
-unlock_ready_out:
-	spin_unlock_irqrestore(&vioch->ready_lock, ready_flags);
 }
 
 static const char *const scmi_vio_vqueue_names[] = { "tx", "rx" };
@@ -273,35 +323,20 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 		}
 	}
 
-	spin_lock_irqsave(&vioch->lock, flags);
-	cinfo->transport_info = vioch;
-	/* Indirectly setting channel not available any more */
-	vioch->cinfo = cinfo;
-	spin_unlock_irqrestore(&vioch->lock, flags);
-
-	spin_lock_irqsave(&vioch->ready_lock, flags);
-	vioch->ready = true;
-	spin_unlock_irqrestore(&vioch->ready_lock, flags);
+	scmi_vio_channel_ready(vioch, cinfo);
 
 	return 0;
 }
 
 static int virtio_chan_free(int id, void *p, void *data)
 {
-	unsigned long flags;
 	struct scmi_chan_info *cinfo = p;
 	struct scmi_vio_channel *vioch = cinfo->transport_info;
 
-	spin_lock_irqsave(&vioch->ready_lock, flags);
-	vioch->ready = false;
-	spin_unlock_irqrestore(&vioch->ready_lock, flags);
+	scmi_vio_channel_cleanup_sync(vioch);
 
 	scmi_free_channel(cinfo, data, id);
 
-	spin_lock_irqsave(&vioch->lock, flags);
-	vioch->cinfo = NULL;
-	spin_unlock_irqrestore(&vioch->lock, flags);
-
 	return 0;
 }
 
@@ -316,10 +351,14 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
 	int rc;
 	struct scmi_vio_msg *msg;
 
+	if (!scmi_vio_channel_acquire(vioch))
+		return -EINVAL;
+
 	spin_lock_irqsave(&vioch->lock, flags);
 
 	if (list_empty(&vioch->free_list)) {
 		spin_unlock_irqrestore(&vioch->lock, flags);
+		scmi_vio_channel_release(vioch);
 		return -EBUSY;
 	}
 
@@ -342,6 +381,8 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
 
 	spin_unlock_irqrestore(&vioch->lock, flags);
 
+	scmi_vio_channel_release(vioch);
+
 	return rc;
 }
 
@@ -416,7 +457,6 @@ static int scmi_vio_probe(struct virtio_device *vdev)
 		unsigned int sz;
 
 		spin_lock_init(&channels[i].lock);
-		spin_lock_init(&channels[i].ready_lock);
 		INIT_LIST_HEAD(&channels[i].free_list);
 		channels[i].vqueue = vqs[i];
 
@@ -503,7 +543,8 @@ const struct scmi_desc scmi_virtio_desc = {
 	.transport_init = virtio_scmi_init,
 	.transport_exit = virtio_scmi_exit,
 	.ops = &scmi_virtio_ops,
-	.max_rx_timeout_ms = 60000, /* for non-realtime virtio devices */
+	/* for non-realtime virtio devices */
+	.max_rx_timeout_ms = VIRTIO_MAX_RX_TIMEOUT_MS,
 	.max_msg = 0, /* overridden by virtio_get_max_msg() */
 	.max_msg_size = VIRTIO_SCMI_MAX_MSG_SIZE,
 };
-- 
2.17.1

