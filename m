Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77604A6218
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240621AbiBARQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:16:24 -0500
Received: from foss.arm.com ([217.140.110.172]:53074 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240599AbiBARQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:16:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B16F81424;
        Tue,  1 Feb 2022 09:16:20 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCE863F40C;
        Tue,  1 Feb 2022 09:16:18 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 3/9] [RFC] virtio_ring: Embed a wrap counter in opaque poll index value
Date:   Tue,  1 Feb 2022 17:15:55 +0000
Message-Id: <20220201171601.53316-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220201171601.53316-1-cristian.marussi@arm.com>
References: <20220201171601.53316-1-cristian.marussi@arm.com>
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
the internal last_used_index (roughly), it is possible that, if exactly
2**16 buffers are marked as used between two successive calls to
virtqueue_poll(), the caller is fooled into thinking that nothing is
pending (ABA problem).

Keep a full fledged internal wraps counter per virtqueue and embed it into
the upper 16bits of the returned opaque value, so that the above scenario
can be detected transparently by virtqueue_poll(): this way each single
possible last_used_idx value is really belonging to a different wrap.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
Cc: Peter Hilber <peter.hilber@opensynergy.com>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Still no perf data on this, I was wondering what exactly to measure in
term of perf metrics to evaluate the impact of the rolling vq->wraps
counter.
---
 drivers/virtio/virtio_ring.c | 51 +++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 00f64f2f8b72..613ec0503509 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -12,6 +12,8 @@
 #include <linux/hrtimer.h>
 #include <linux/dma-mapping.h>
 #include <linux/spinlock.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
 #include <xen/xen.h>
 
 static bool force_used_validation = false;
@@ -69,6 +71,17 @@ module_param(force_used_validation, bool, 0444);
 #define LAST_ADD_TIME_INVALID(vq)
 #endif
 
+#define VRING_IDX_MASK					GENMASK(15, 0)
+#define VRING_GET_IDX(opaque)				\
+	((u16)FIELD_GET(VRING_IDX_MASK, (opaque)))
+
+#define VRING_WRAPS_MASK				GENMASK(31, 16)
+#define VRING_GET_WRAPS(opaque)				\
+	((u16)FIELD_GET(VRING_WRAPS_MASK, (opaque)))
+
+#define VRING_BUILD_OPAQUE(idx, wraps)			\
+	(FIELD_PREP(VRING_WRAPS_MASK, (wraps)) | ((idx) & VRING_IDX_MASK))
+
 struct vring_desc_state_split {
 	void *data;			/* Data for callback. */
 	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
@@ -117,6 +130,8 @@ struct vring_virtqueue {
 	/* Last used index we've seen. */
 	u16 last_used_idx;
 
+	u16 wraps;
+
 	/* Hint for event idx: already triggered no need to disable. */
 	bool event_triggered;
 
@@ -806,6 +821,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 	ret = vq->split.desc_state[i].data;
 	detach_buf_split(vq, i, ctx);
 	vq->last_used_idx++;
+	if (unlikely(!vq->last_used_idx))
+		vq->wraps++;
 	/* If we expect an interrupt for the next entry, tell host
 	 * by writing event index and flush out the write before
 	 * the read in the next get_buf call. */
@@ -1508,6 +1525,7 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 	if (unlikely(vq->last_used_idx >= vq->packed.vring.num)) {
 		vq->last_used_idx -= vq->packed.vring.num;
 		vq->packed.used_wrap_counter ^= 1;
+		vq->wraps++;
 	}
 
 	/*
@@ -1744,6 +1762,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->weak_barriers = weak_barriers;
 	vq->broken = false;
 	vq->last_used_idx = 0;
+	vq->wraps = 0;
 	vq->event_triggered = false;
 	vq->num_added = 0;
 	vq->packed_ring = true;
@@ -2092,13 +2111,17 @@ EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
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
+	return VRING_BUILD_OPAQUE(last_used_idx, vq->wraps);
 }
 EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
 
@@ -2107,6 +2130,21 @@ EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
  * @_vq: the struct virtqueue we're talking about.
  * @last_used_idx: virtqueue state (from call to virtqueue_enable_cb_prepare).
  *
+ * The provided last_used_idx, as returned by virtqueue_enable_cb_prepare(),
+ * is an opaque value representing the queue state and it is built as follows:
+ *
+ *	---------------------------------------------------------
+ *	|	vq->wraps	|	vq->last_used_idx	|
+ *	31------------------------------------------------------0
+ *
+ * The MSB 16bits embedding the wraps counter for the underlying virtqueue
+ * is stripped out here before reaching into the lower layer helpers.
+ *
+ * This structure of the opaque value mitigates the scenario in which, when
+ * exactly 2**16 messages are marked as used between two successive calls to
+ * virtqueue_poll(), the caller is fooled into thinking nothing new has arrived
+ * since the pure last_used_idx is exactly the same.
+ *
  * Returns "true" if there are pending used buffers in the queue.
  *
  * This does not need to be serialized.
@@ -2118,9 +2156,13 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned last_used_idx)
 	if (unlikely(vq->broken))
 		return false;
 
+	if (unlikely(vq->wraps != VRING_GET_WRAPS(last_used_idx)))
+		return true;
+
 	virtio_mb(vq->weak_barriers);
-	return vq->packed_ring ? virtqueue_poll_packed(_vq, last_used_idx) :
-				 virtqueue_poll_split(_vq, last_used_idx);
+	return vq->packed_ring ?
+		virtqueue_poll_packed(_vq, VRING_GET_IDX(last_used_idx)) :
+			virtqueue_poll_split(_vq, VRING_GET_IDX(last_used_idx));
 }
 EXPORT_SYMBOL_GPL(virtqueue_poll);
 
@@ -2245,6 +2287,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	vq->weak_barriers = weak_barriers;
 	vq->broken = false;
 	vq->last_used_idx = 0;
+	vq->wraps = 0;
 	vq->event_triggered = false;
 	vq->num_added = 0;
 	vq->use_dma_api = vring_use_dma_api(vdev);
-- 
2.17.1

