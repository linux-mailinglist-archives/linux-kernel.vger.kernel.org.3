Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7F54A6217
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240645AbiBARQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:16:22 -0500
Received: from foss.arm.com ([217.140.110.172]:53054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240610AbiBARQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:16:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6A9211FB;
        Tue,  1 Feb 2022 09:16:18 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13E0D3F40C;
        Tue,  1 Feb 2022 09:16:16 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com
Subject: [PATCH v2 2/9] firmware: arm_scmi: Review virtio free_list handling
Date:   Tue,  1 Feb 2022 17:15:54 +0000
Message-Id: <20220201171601.53316-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220201171601.53316-1-cristian.marussi@arm.com>
References: <20220201171601.53316-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new spinlock dedicated to the access of the TX free list and a couple
of helpers to get and put messages back and forth from the free_list.

Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
Cc: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/virtio.c | 88 +++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 31 deletions(-)

diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index 536e46eab462..22d5a632262f 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -40,20 +40,23 @@
  *
  * @vqueue: Associated virtqueue
  * @cinfo: SCMI Tx or Rx channel
+ * @free_lock: Protects access to the @free_list.
  * @free_list: List of unused scmi_vio_msg, maintained for Tx channels only
  * @is_rx: Whether channel is an Rx channel
  * @max_msg: Maximum number of pending messages for this channel.
- * @lock: Protects access to all members except users.
+ * @lock: Protects access to all members except users, free_list.
  * @shutdown_done: A reference to a completion used when freeing this channel.
  * @users: A reference count to currently active users of this channel.
  */
 struct scmi_vio_channel {
 	struct virtqueue *vqueue;
 	struct scmi_chan_info *cinfo;
+	/* lock to protect access to the free list. */
+	spinlock_t free_lock;
 	struct list_head free_list;
 	bool is_rx;
 	unsigned int max_msg;
-	/* lock to protect access to all members except users. */
+	/* lock to protect access to all members except users, free_list  */
 	spinlock_t lock;
 	struct completion *shutdown_done;
 	refcount_t users;
@@ -142,18 +145,49 @@ static void scmi_vio_channel_cleanup_sync(struct scmi_vio_channel *vioch)
 			 "Timeout shutting down %s VQ.\n", vq_name);
 }
 
+/* Assumes to be called with vio channel acquired already */
+static struct scmi_vio_msg *
+scmi_virtio_get_free_msg(struct scmi_vio_channel *vioch)
+{
+	unsigned long flags;
+	struct scmi_vio_msg *msg;
+
+	spin_lock_irqsave(&vioch->free_lock, flags);
+	if (list_empty(&vioch->free_list)) {
+		spin_unlock_irqrestore(&vioch->free_lock, flags);
+		return NULL;
+	}
+
+	msg = list_first_entry(&vioch->free_list, typeof(*msg), list);
+	list_del_init(&msg->list);
+	spin_unlock_irqrestore(&vioch->free_lock, flags);
+
+	return msg;
+}
+
+/* Assumes to be called with vio channel acquired already */
+static void scmi_virtio_put_free_msg(struct scmi_vio_channel *vioch,
+				     struct scmi_vio_msg *msg)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&vioch->free_lock, flags);
+	list_add_tail(&msg->list, &vioch->free_list);
+	spin_unlock_irqrestore(&vioch->free_lock, flags);
+}
+
 static bool scmi_vio_have_vq_rx(struct virtio_device *vdev)
 {
 	return virtio_has_feature(vdev, VIRTIO_SCMI_F_P2A_CHANNELS);
 }
 
 static int scmi_vio_feed_vq_rx(struct scmi_vio_channel *vioch,
-			       struct scmi_vio_msg *msg,
-			       struct device *dev)
+			       struct scmi_vio_msg *msg)
 {
 	struct scatterlist sg_in;
 	int rc;
 	unsigned long flags;
+	struct device *dev = &vioch->vqueue->vdev->dev;
 
 	sg_init_one(&sg_in, msg->input, VIRTIO_SCMI_MAX_PDU_SIZE);
 
@@ -170,17 +204,17 @@ static int scmi_vio_feed_vq_rx(struct scmi_vio_channel *vioch,
 	return rc;
 }
 
+/*
+ * Assume to be called with channel already acquired or not ready at all;
+ * vioch->lock MUST NOT have been already acquired.
+ */
 static void scmi_finalize_message(struct scmi_vio_channel *vioch,
 				  struct scmi_vio_msg *msg)
 {
-	if (vioch->is_rx) {
-		scmi_vio_feed_vq_rx(vioch, msg, vioch->cinfo->dev);
-	} else {
-		/* Here IRQs are assumed to be already disabled by the caller */
-		spin_lock(&vioch->lock);
-		list_add(&msg->list, &vioch->free_list);
-		spin_unlock(&vioch->lock);
-	}
+	if (vioch->is_rx)
+		scmi_vio_feed_vq_rx(vioch, msg);
+	else
+		scmi_virtio_put_free_msg(vioch, msg);
 }
 
 static void scmi_vio_complete_cb(struct virtqueue *vqueue)
@@ -295,7 +329,6 @@ static bool virtio_chan_available(struct device *dev, int idx)
 static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 			     bool tx)
 {
-	unsigned long flags;
 	struct scmi_vio_channel *vioch;
 	int index = tx ? VIRTIO_SCMI_VQ_TX : VIRTIO_SCMI_VQ_RX;
 	int i;
@@ -325,13 +358,7 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 		if (!msg->input)
 			return -ENOMEM;
 
-		if (tx) {
-			spin_lock_irqsave(&vioch->lock, flags);
-			list_add_tail(&msg->list, &vioch->free_list);
-			spin_unlock_irqrestore(&vioch->lock, flags);
-		} else {
-			scmi_vio_feed_vq_rx(vioch, msg, cinfo->dev);
-		}
+		scmi_finalize_message(vioch, msg);
 	}
 
 	scmi_vio_channel_ready(vioch, cinfo);
@@ -365,33 +392,31 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
 	if (!scmi_vio_channel_acquire(vioch))
 		return -EINVAL;
 
-	spin_lock_irqsave(&vioch->lock, flags);
-
-	if (list_empty(&vioch->free_list)) {
-		spin_unlock_irqrestore(&vioch->lock, flags);
+	msg = scmi_virtio_get_free_msg(vioch);
+	if (!msg) {
 		scmi_vio_channel_release(vioch);
 		return -EBUSY;
 	}
 
-	msg = list_first_entry(&vioch->free_list, typeof(*msg), list);
-	list_del(&msg->list);
-
 	msg_tx_prepare(msg->request, xfer);
 
 	sg_init_one(&sg_out, msg->request, msg_command_size(xfer));
 	sg_init_one(&sg_in, msg->input, msg_response_size(xfer));
 
+	spin_lock_irqsave(&vioch->lock, flags);
+
 	rc = virtqueue_add_sgs(vioch->vqueue, sgs, 1, 1, msg, GFP_ATOMIC);
-	if (rc) {
-		list_add(&msg->list, &vioch->free_list);
+	if (rc)
 		dev_err(vioch->cinfo->dev,
 			"failed to add to TX virtqueue (%d)\n", rc);
-	} else {
+	else
 		virtqueue_kick(vioch->vqueue);
-	}
 
 	spin_unlock_irqrestore(&vioch->lock, flags);
 
+	if (rc)
+		scmi_virtio_put_free_msg(vioch, msg);
+
 	scmi_vio_channel_release(vioch);
 
 	return rc;
@@ -468,6 +493,7 @@ static int scmi_vio_probe(struct virtio_device *vdev)
 		unsigned int sz;
 
 		spin_lock_init(&channels[i].lock);
+		spin_lock_init(&channels[i].free_lock);
 		INIT_LIST_HEAD(&channels[i].free_list);
 		channels[i].vqueue = vqs[i];
 
-- 
2.17.1

