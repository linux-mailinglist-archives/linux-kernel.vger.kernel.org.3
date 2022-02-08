Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0010F4ADC90
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380282AbiBHPZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380054AbiBHPZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:25:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFAE8C061578
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:25:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E5622B;
        Tue,  8 Feb 2022 07:25:35 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F3F03F73B;
        Tue,  8 Feb 2022 07:25:34 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org
Cc:     sudeep.holla@arm.com, mst@redhat.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com
Subject: [PATCH 3/4] virtio_ring: Embed a wrap counter in opaque poll index value
Date:   Tue,  8 Feb 2022 15:25:19 +0000
Message-Id: <20220208152520.52983-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220208152520.52983-1-cristian.marussi@arm.com>
References: <20220208152520.52983-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exported API virtqueue_poll() can be used to support polling mode operation
on top of virtio layer if needed; currently the parameter last_used_idx is
the opaque value that needs to be passed to the virtqueue_poll() function
to check if there are new pending used buffers in the queue: such opaque
value would have been previously obtained by a call to the API function
virtqueue_enable_cb_prepare().

Since such opaque value is indeed containing simply a snapshot in time of
the internal 16bit last_used_index (roughly), it is possible that, if
another thread calls virtqueue_add_*() at the same time (which existing
drivers don't do, but does not seem to be documented as prohibited
anywhere), and if exactly 2**16 buffers are marked as used between two
successive calls to virtqueue_poll(), the caller is fooled into thinking
that nothing is pending (ABA problem).

Keep a 16bit internal wraps counter per virtqueue and embed it into
the upper 16bits of the returned opaque value, so that the above scenario
can be detected transparently by virtqueue_poll(): this way each single
possible last_used_idx value is really belonging to a different wrap.
The ABA problem is still theoretically possible but this mitigation make
it possibly happen only after 2^32 requests, which seems sufficient in
practice.

Since most drivers usually do not use virtqueue_poll() API in this way to
access the virtqueues in polling mode, make the above behaviour optional
using an internal flag that a driver can set, if desired, calling the new
API virtqueue_use_wrap_counters().

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
Cc: Peter Hilber <peter.hilber@opensynergy.com>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
---
 drivers/virtio/virtio_ring.c | 88 ++++++++++++++++++++++++++++++++++--
 include/linux/virtio.h       |  2 +
 2 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 962f1477b1fa..00a84b93f4a7 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -12,6 +12,8 @@
 #include <linux/hrtimer.h>
 #include <linux/dma-mapping.h>
 #include <linux/spinlock.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
 #include <xen/xen.h>
 
 #ifdef DEBUG
@@ -66,6 +68,34 @@
 #define LAST_ADD_TIME_INVALID(vq)
 #endif
 
+/*
+ * The provided last_used_idx, as returned by virtqueue_enable_cb_prepare(),
+ * is an opaque value representing the queue state and it is built as follows:
+ *
+ *	---------------------------------------------------------
+ *	|	vq->wraps	|	vq->last_used_idx	|
+ *	31------------------------------------------------------0
+ *
+ * The MSB 16bits embedding the wraps counter for the underlying virtqueue
+ * is stripped out, using these macros, before reaching into the lower layer
+ * helpers.
+ *
+ * This structure of the opaque value mitigates the scenario in which, when
+ * exactly 2**16 messages are marked as used between two successive calls to
+ * virtqueue_poll(), the caller is fooled into thinking nothing new has arrived
+ * since the pure last_used_idx is exactly the same.
+ */
+#define VRING_IDX_MASK					GENMASK(15, 0)
+#define VRING_POLL_GET_IDX(opaque)				\
+	((u16)FIELD_GET(VRING_IDX_MASK, (opaque)))
+
+#define VRING_WRAPS_MASK				GENMASK(31, 16)
+#define VRING_POLL_GET_WRAPS(opaque)				\
+	((u16)FIELD_GET(VRING_WRAPS_MASK, (opaque)))
+
+#define VRING_POLL_BUILD_OPAQUE(idx, wraps)			\
+	(FIELD_PREP(VRING_WRAPS_MASK, (wraps)) | ((idx) & VRING_IDX_MASK))
+
 struct vring_desc_state_split {
 	void *data;			/* Data for callback. */
 	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
@@ -114,6 +144,11 @@ struct vring_virtqueue {
 	/* Last used index we've seen. */
 	u16 last_used_idx;
 
+	/* Should we count wraparounds? */
+	bool use_wrap_counter;
+	/* Number of wraparounds */
+	u16 wraps;
+
 	/* Hint for event idx: already triggered no need to disable. */
 	bool event_triggered;
 
@@ -789,6 +824,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 	ret = vq->split.desc_state[i].data;
 	detach_buf_split(vq, i, ctx);
 	vq->last_used_idx++;
+	if (unlikely(vq->use_wrap_counter))
+		vq->wraps += !vq->last_used_idx;
 	/* If we expect an interrupt for the next entry, tell host
 	 * by writing event index and flush out the write before
 	 * the read in the next get_buf call. */
@@ -1474,6 +1511,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 	if (unlikely(vq->last_used_idx >= vq->packed.vring.num)) {
 		vq->last_used_idx -= vq->packed.vring.num;
 		vq->packed.used_wrap_counter ^= 1;
+		if (unlikely(vq->use_wrap_counter))
+			vq->wraps++;
 	}
 
 	/*
@@ -1709,6 +1748,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->weak_barriers = weak_barriers;
 	vq->broken = false;
 	vq->last_used_idx = 0;
+	vq->use_wrap_counter = false;
+	vq->wraps = 0;
 	vq->event_triggered = false;
 	vq->num_added = 0;
 	vq->packed_ring = true;
@@ -2046,16 +2087,49 @@ EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
  */
 unsigned virtqueue_enable_cb_prepare(struct virtqueue *_vq)
 {
+	unsigned int last_used_idx;
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	if (vq->event_triggered)
 		vq->event_triggered = false;
 
-	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) :
-				 virtqueue_enable_cb_prepare_split(_vq);
+	last_used_idx = vq->packed_ring ?
+			virtqueue_enable_cb_prepare_packed(_vq) :
+			virtqueue_enable_cb_prepare_split(_vq);
+
+	return VRING_POLL_BUILD_OPAQUE(last_used_idx, vq->wraps);
 }
 EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
 
+/**
+ * virtqueue_use_wrap_counter  - Enable the virtqueue use_wrap_counter flag
+ * @_vq: the struct virtqueue we're talking about.
+ *
+ * After calling this the core will keep track of virtqueues last_used_idx
+ * in a dedicated wraps counter and such value will be reported embedded in the
+ * MSB 16bit of the opaque value returned by virtqueue_enable_cb_prepare.
+ *
+ * Return: 0 on Success
+ */
+int virtqueue_use_wrap_counter(struct virtqueue *_vq)
+{
+	u8 status;
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	if (unlikely(vq->broken))
+		return -EINVAL;
+
+	status = _vq->vdev->config->get_status(_vq->vdev);
+	if (!status || status >= VIRTIO_CONFIG_S_DRIVER_OK)
+		return -EBUSY;
+
+	vq->use_wrap_counter = true;
+	virtio_mb(vq->weak_barriers);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(virtqueue_use_wrap_counter);
+
 /**
  * virtqueue_poll - query pending used buffers
  * @_vq: the struct virtqueue we're talking about.
@@ -2072,9 +2146,13 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned last_used_idx)
 	if (unlikely(vq->broken))
 		return false;
 
+	if (unlikely(vq->wraps != VRING_POLL_GET_WRAPS(last_used_idx)))
+		return true;
+
 	virtio_mb(vq->weak_barriers);
-	return vq->packed_ring ? virtqueue_poll_packed(_vq, last_used_idx) :
-				 virtqueue_poll_split(_vq, last_used_idx);
+	return vq->packed_ring ?
+		virtqueue_poll_packed(_vq, VRING_POLL_GET_IDX(last_used_idx)) :
+		   virtqueue_poll_split(_vq, VRING_POLL_GET_IDX(last_used_idx));
 }
 EXPORT_SYMBOL_GPL(virtqueue_poll);
 
@@ -2198,6 +2276,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	vq->weak_barriers = weak_barriers;
 	vq->broken = false;
 	vq->last_used_idx = 0;
+	vq->use_wrap_counter = false;
+	vq->wraps = 0;
 	vq->event_triggered = false;
 	vq->num_added = 0;
 	vq->use_dma_api = vring_use_dma_api(vdev);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 72292a62cd90..3cd428c09f54 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -74,6 +74,8 @@ bool virtqueue_enable_cb(struct virtqueue *vq);
 
 unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
 
+int virtqueue_use_wrap_counter(struct virtqueue *vq);
+
 bool virtqueue_poll(struct virtqueue *vq, unsigned);
 
 bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
-- 
2.17.1

