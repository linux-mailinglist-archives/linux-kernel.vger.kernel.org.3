Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BDD54A8CD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 07:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbiFNFiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 01:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiFNFiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 01:38:09 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836262B251
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 22:38:06 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id g186so7587138pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 22:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wrFl2G+hkUtcp/3Vlj+LmYcQESAuGWOLSXjlf9A2klo=;
        b=tT3fi+/7d8uz+0XimxefGDrn3vU4X7bOJSBN2eCf6E3fbn6RybqzlBNqfvsYftix1b
         r1Xr6QSvj8Ga0D1AqM9/oQw8Qwyj9HEbmhJKoxZHtsWDoxpF9PJMFNq0iC6u1Nf61af3
         YB5cY17QOOawlIgAYxB01bBGM6NVVuZlR2lRTMPAVSJ91QFQKRN6sEGDxtX77M9lULXN
         4tF2Vtx0YHB0Xt0E9v41sf64Pa5tn0Nsk38LjovSHubWF2CRPuA1VWauMkmlGvIOEGqH
         xBfr5EMcToNJ4BGVAywv59HBb/g95oNkr+rQ/KsiAHc3PzNnB03Jct2qHMZJMOp3gqhg
         nLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wrFl2G+hkUtcp/3Vlj+LmYcQESAuGWOLSXjlf9A2klo=;
        b=yw9HiUyL5dNhpuQ1drLtdZ+F5Qk4w4biHhyFNLux7uxSQ+x0esOw8DSm8QltQqTXg3
         V0AGFSYsOgXEc3EI9F6/u1Sq1nM0yArEKsjtUGuUh4iILGjpuRIA/t2w44FsCPcEjXFe
         jyw/w0NNiW5FWfUL9ILxF7tHKAO5OQOQNRhamzwSvoBFPrUyiDHuNKymKfew8Zdt8dwb
         aetWUe5YJjEkYXjaO2Vju8e+2ff+YMViQl7jKfUkZv4WJiJI0zFE8PF3yL0FSH+M0c7L
         X3vtLXJaxl4+sdJhdiit2Xzio63tXDuDs56/IetYvsp4KgVWeR71hH1wVAMoSLHS2llg
         Awkg==
X-Gm-Message-State: AOAM5330DxH5sX+tG9WFNVOpkiq0QmoVm4xEReb6dhIBi+elDncSKFNr
        XiJMUxaKAq0LGUKOHQjuidcneUupbfy+Sfc7
X-Google-Smtp-Source: ABdhPJzfqdobm0NeU7Je8P9eFOIQrCeJeFbuFnGob07rUGrJnN1C90rwNzLHiy1/WMtX6/NbIk+DXg==
X-Received: by 2002:a63:296:0:b0:3fc:aa42:5e8b with SMTP id 144-20020a630296000000b003fcaa425e8bmr2972169pgc.519.1655185085937;
        Mon, 13 Jun 2022 22:38:05 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id jj18-20020a170903049200b001634d581adfsm6119814plb.157.2022.06.13.22.38.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jun 2022 22:38:05 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
To:     mst@redhat.com
Cc:     yuanzhu@bytedance.com,
        "huangjie.albert" <huangjie.albert@bytedance.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_ring : keep used_wrap_counter in vq->last_used_idx
Date:   Tue, 14 Jun 2022 13:37:37 +0800
Message-Id: <20220614053737.82453-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220613100433-mutt-send-email-mst@kernel.org>
References: <20220613100433-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "huangjie.albert" <huangjie.albert@bytedance.com>

the used_wrap_counter and the vq->last_used_idx may get
out of sync if they are separate assignment，and interrupt
might use an incorrect value to check for the used index.

for example:OOB access
ksoftirqd may consume the packet and it will call:
virtnet_poll
	-->virtnet_receive
		-->virtqueue_get_buf_ctx
			-->virtqueue_get_buf_ctx_packed
and in virtqueue_get_buf_ctx_packed:

vq->last_used_idx += vq->packed.desc_state[id].num;
if (unlikely(vq->last_used_idx >= vq->packed.vring.num)) {
         vq->last_used_idx -= vq->packed.vring.num;
         vq->packed.used_wrap_counter ^= 1;
}

if at the same time, there comes a vring interrupt，in vring_interrupt:
we will call:
vring_interrupt
	-->more_used
		-->more_used_packed
			-->is_used_desc_packed
in is_used_desc_packed, the last_used_idx maybe >= vq->packed.vring.num.
so this could case a memory out of bounds bug.

this patch is to keep the used_wrap_counter in vq->last_used_idx
so we can get the correct value to check for used index in interrupt.

Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
---
 drivers/virtio/virtio_ring.c     | 60 ++++++++++++++++++--------------
 include/uapi/linux/virtio_ring.h |  6 ++++
 2 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 13a7348cedff..35c3750e89e1 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -111,7 +111,12 @@ struct vring_virtqueue {
 	/* Number we've added since last sync. */
 	unsigned int num_added;
 
-	/* Last used index we've seen. */
+	/* Last used index  we've seen.
+	 * for split ring, it just contains last used index
+	 * for packed ring, it not only contains last used index, but also
+	 * used_wrap_counter, the VRING_PACKED_USED_INDEX_F_WRAP_CTR is
+	 * the bit shift in last_used_idx
+	 */
 	u16 last_used_idx;
 
 	/* Hint for event idx: already triggered no need to disable. */
@@ -154,9 +159,6 @@ struct vring_virtqueue {
 			/* Driver ring wrap counter. */
 			bool avail_wrap_counter;
 
-			/* Device ring wrap counter. */
-			bool used_wrap_counter;
-
 			/* Avail used flags. */
 			u16 avail_used_flags;
 
@@ -1397,6 +1399,9 @@ static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
 	bool avail, used;
 	u16 flags;
 
+	if (idx >= vq->packed.vring.num)
+		return false;
+
 	flags = le16_to_cpu(vq->packed.vring.desc[idx].flags);
 	avail = !!(flags & (1 << VRING_PACKED_DESC_F_AVAIL));
 	used = !!(flags & (1 << VRING_PACKED_DESC_F_USED));
@@ -1406,8 +1411,12 @@ static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
 
 static inline bool more_used_packed(const struct vring_virtqueue *vq)
 {
-	return is_used_desc_packed(vq, vq->last_used_idx,
-			vq->packed.used_wrap_counter);
+	u16 last_used;
+	bool used_wrap_counter;
+
+	last_used = vq->last_used_idx & ~(1 << VRING_PACKED_USED_INDEX_F_WRAP_CTR);
+	used_wrap_counter = !!((vq->last_used_idx) >> VRING_PACKED_USED_INDEX_F_WRAP_CTR);
+	return is_used_desc_packed(vq, last_used, used_wrap_counter);
 }
 
 static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
@@ -1416,6 +1425,7 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	u16 last_used, id;
+	bool used_wrap_counter;
 	void *ret;
 
 	START_USE(vq);
@@ -1434,7 +1444,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 	/* Only get used elements after they have been exposed by host. */
 	virtio_rmb(vq->weak_barriers);
 
-	last_used = vq->last_used_idx;
+	used_wrap_counter = !!((vq->last_used_idx >> VRING_PACKED_USED_INDEX_F_WRAP_CTR));
+	last_used = (vq->last_used_idx) & (~(1 << VRING_PACKED_USED_INDEX_F_WRAP_CTR));
 	id = le16_to_cpu(vq->packed.vring.desc[last_used].id);
 	*len = le32_to_cpu(vq->packed.vring.desc[last_used].len);
 
@@ -1451,12 +1462,15 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 	ret = vq->packed.desc_state[id].data;
 	detach_buf_packed(vq, id, ctx);
 
-	vq->last_used_idx += vq->packed.desc_state[id].num;
-	if (unlikely(vq->last_used_idx >= vq->packed.vring.num)) {
-		vq->last_used_idx -= vq->packed.vring.num;
-		vq->packed.used_wrap_counter ^= 1;
+	last_used += vq->packed.desc_state[id].num;
+	if (unlikely(last_used >= vq->packed.vring.num)) {
+		last_used -= vq->packed.vring.num;
+		used_wrap_counter ^= 1;
 	}
 
+	last_used = (last_used | (used_wrap_counter << VRING_PACKED_DESC_F_USED));
+	vq->last_used_idx = last_used;
+
 	/*
 	 * If we expect an interrupt for the next entry, tell host
 	 * by writing event index and flush out the write before
@@ -1465,9 +1479,7 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
 		virtio_store_mb(vq->weak_barriers,
 				&vq->packed.vring.driver->off_wrap,
-				cpu_to_le16(vq->last_used_idx |
-					(vq->packed.used_wrap_counter <<
-					 VRING_PACKED_EVENT_F_WRAP_CTR)));
+				cpu_to_le16(vq->last_used_idx));
 
 	LAST_ADD_TIME_INVALID(vq);
 
@@ -1499,9 +1511,7 @@ static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
 
 	if (vq->event) {
 		vq->packed.vring.driver->off_wrap =
-			cpu_to_le16(vq->last_used_idx |
-				(vq->packed.used_wrap_counter <<
-				 VRING_PACKED_EVENT_F_WRAP_CTR));
+			cpu_to_le16(vq->last_used_idx);
 		/*
 		 * We need to update event offset and event wrap
 		 * counter first before updating event flags.
@@ -1518,8 +1528,7 @@ static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
 	}
 
 	END_USE(vq);
-	return vq->last_used_idx | ((u16)vq->packed.used_wrap_counter <<
-			VRING_PACKED_EVENT_F_WRAP_CTR);
+	return vq->last_used_idx;
 }
 
 static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
@@ -1550,9 +1559,9 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
 	if (vq->event) {
 		/* TODO: tune this threshold */
 		bufs = (vq->packed.vring.num - vq->vq.num_free) * 3 / 4;
-		wrap_counter = vq->packed.used_wrap_counter;
+		wrap_counter = !!(vq->last_used_idx >> VRING_PACKED_USED_INDEX_F_WRAP_CTR);
 
-		used_idx = vq->last_used_idx + bufs;
+		used_idx = (vq->last_used_idx & ~(1 << VRING_PACKED_USED_INDEX_F_WRAP_CTR)) + bufs;
 		if (used_idx >= vq->packed.vring.num) {
 			used_idx -= vq->packed.vring.num;
 			wrap_counter ^= 1;
@@ -1582,9 +1591,9 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
 	 */
 	virtio_mb(vq->weak_barriers);
 
-	if (is_used_desc_packed(vq,
-				vq->last_used_idx,
-				vq->packed.used_wrap_counter)) {
+	wrap_counter = !!(vq->last_used_idx >> VRING_PACKED_USED_INDEX_F_WRAP_CTR);
+	used_idx = (vq->last_used_idx & ~(1 << VRING_PACKED_USED_INDEX_F_WRAP_CTR));
+	if (is_used_desc_packed(vq, used_idx, wrap_counter)) {
 		END_USE(vq);
 		return false;
 	}
@@ -1689,7 +1698,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
 	vq->broken = true;
-	vq->last_used_idx = 0;
+	vq->last_used_idx = 0 | (1 << VRING_PACKED_USED_INDEX_F_WRAP_CTR);
 	vq->event_triggered = false;
 	vq->num_added = 0;
 	vq->packed_ring = true;
@@ -1720,7 +1729,6 @@ static struct virtqueue *vring_create_virtqueue_packed(
 
 	vq->packed.next_avail_idx = 0;
 	vq->packed.avail_wrap_counter = 1;
-	vq->packed.used_wrap_counter = 1;
 	vq->packed.event_flags_shadow = 0;
 	vq->packed.avail_used_flags = 1 << VRING_PACKED_DESC_F_AVAIL;
 
diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index 476d3e5c0fe7..96bcc4d52fce 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -77,6 +77,12 @@
  */
 #define VRING_PACKED_EVENT_F_WRAP_CTR	15
 
+
+/*
+ * used wrap Counter bit shift in vq->last_used_idx for packed ring
+ */
+#define VRING_PACKED_USED_INDEX_F_WRAP_CTR  15
+
 /* We support indirect buffer descriptors */
 #define VIRTIO_RING_F_INDIRECT_DESC	28
 
-- 
2.31.1

