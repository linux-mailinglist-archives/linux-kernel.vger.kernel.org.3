Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96884ADD53
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381760AbiBHPp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381426AbiBHPpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:45:12 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB4E4C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:45:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 895FC11FB;
        Tue,  8 Feb 2022 07:45:11 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B25FC3F73B;
        Tue,  8 Feb 2022 07:45:09 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 2/8] firmware: arm_scmi: Review virtio free_list handling
Date:   Tue,  8 Feb 2022 15:44:46 +0000
Message-Id: <20220208154452.39428-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220208154452.39428-1-cristian.marussi@arm.com>
References: <20220208154452.39428-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new spinlock dedicated to the access of the TX free list and a couple
of helpers to get and put messages back and forth from the free_list.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
Cc: Peter Hilber <peter.hilber@opensynergy.com>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/virtio.c | 88 +++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 31 deletions(-)

diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index 112d6bd4be2e..a147fc24c4c0 100644
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
@@ -134,18 +137,49 @@ static void scmi_vio_channel_cleanup_sync(struct scmi_vio_channel *vioch)
 	wait_for_completion(vioch->shutdown_done);
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
 
@@ -162,17 +196,17 @@ static int scmi_vio_feed_vq_rx(struct scmi_vio_channel *vioch,
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
@@ -287,7 +321,6 @@ static bool virtio_chan_available(struct device *dev, int idx)
 static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 			     bool tx)
 {
-	unsigned long flags;
 	struct scmi_vio_channel *vioch;
 	int index = tx ? VIRTIO_SCMI_VQ_TX : VIRTIO_SCMI_VQ_RX;
 	int i;
@@ -317,13 +350,7 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
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
@@ -357,33 +384,31 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
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
@@ -460,6 +485,7 @@ static int scmi_vio_probe(struct virtio_device *vdev)
 		unsigned int sz;
 
 		spin_lock_init(&channels[i].lock);
+		spin_lock_init(&channels[i].free_lock);
 		INIT_LIST_HEAD(&channels[i].free_list);
 		channels[i].vqueue = vqs[i];
 
-- 
2.17.1

