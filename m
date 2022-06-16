Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A7754DE45
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 11:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiFPJhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 05:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiFPJhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 05:37:46 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4BF6591
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 02:37:42 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t2so858914pld.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 02:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8TR8ONYNxS2yof19BmDJUJD8HxOk6Zh+FqQICXsXPXs=;
        b=ZyqPpKhCZIyy6oigjxAM7+Hfsd8fEu3UTSEnhn6wUv7Blw7aBA6SAusoVJTFTs3Dla
         DOrD1Xge8Hq2a/GMRx4d8TT+j6nkrqGHzcBT2M6kTuD+PRv5vHzV8UEzkihhQLeDbe5o
         6eMHfAthkK+ZoTdTWLKeay7CJxy4P4hc95Ae5/JNMWboEDv0aig2mraNMRHSWpY9eaym
         Ihy3g0paeflsFnMrdoHHzcqiwRzbG4vK3Fx6R2xIngPY9VPdWApdqvEIiGs2vr4B0Rim
         264FacCS5cO3Wz7E6MxPnzfhiLJsZPCQwZBZGfBTqc6gVnrDilMuGG/pzzjSzrANdnBb
         0V1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8TR8ONYNxS2yof19BmDJUJD8HxOk6Zh+FqQICXsXPXs=;
        b=jGhXBtPpSKWZuJpFcwKHM3aohq/jWnyWB8rUAZT0s12z0NN7ReN0QC2WuRXQuDn7Xg
         uI12F4eIoHWvobFb7Tw93CT54L8mesYeK9F9rX8oof+/Vvn+qfpSvn1E6DK9FoX9VKY6
         kG5DmCEFKabIEk/dgDs0t8yaB82WNE3NmY+Ag7RGuZ+/YwiIVYFu6Cga+vH1Gw7k1faZ
         D1uR43zwfP/OiIvzqBqetWJ2W0+T+wBsjeahnfdwQht3DhDmVk2HLnTPZm20qGvPjns7
         yD02896ulcurx3qhU9ceFFXBJmdYvx7lzTOIbvQfbKy4UQ+S4j4oR7jqu/XNzeNSYM+A
         3zcA==
X-Gm-Message-State: AJIora8OrhCfTcnjJw33spRCJK6ysU3TjQWd4d5tmKaVONlJ0toRcdev
        euNkzgroMz81rCrq4nHqle/+qv1X17DtG/mx
X-Google-Smtp-Source: AGRyM1uBxY5pSjJi4t8oGVMgMRfevSN4nbd6JsziLBQZzyH+o3dOv62F6u4/b5Zl0zvawpU3EWzbdA==
X-Received: by 2002:a17:902:b714:b0:168:f72d:b8d5 with SMTP id d20-20020a170902b71400b00168f72db8d5mr3776071pls.66.1655372262270;
        Thu, 16 Jun 2022 02:37:42 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id v24-20020a170902e8d800b0015e8d4eb246sm1196415plg.144.2022.06.16.02.37.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jun 2022 02:37:41 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
To:     mst@redhat.com
Cc:     yuanzhu@bytedance.com,
        "huangjie.albert" <huangjie.albert@bytedance.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] virtio_ring : keep used_wrap_counter in vq->last_used_idx
Date:   Thu, 16 Jun 2022 17:37:02 +0800
Message-Id: <20220616093703.39609-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220616024148-mutt-send-email-mst@kernel.org>
References: <20220616024148-mutt-send-email-mst@kernel.org>
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

v2->v3:
- add inline function to get used_wrap_counter and last_used
- when use vq->last_used_idx, only read once
  if vq->last_used_idx is read twice, the values can be inconsistent.
- use last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR))
  to get the all bits below VRING_PACKED_EVENT_F_WRAP_CTR

v1->v2:
- reuse the VRING_PACKED_EVENT_F_WRAP_CTR
- Remove parameter judgment in is_used_desc_packed,
because it can't be illegal

Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
---
 drivers/virtio/virtio_ring.c | 75 ++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 28 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 13a7348cedff..0184b5056457 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -111,7 +111,12 @@ struct vring_virtqueue {
 	/* Number we've added since last sync. */
 	unsigned int num_added;
 
-	/* Last used index we've seen. */
+	/* Last used index  we've seen.
+	 * for split ring, it just contains last used index
+	 * for packed ring, it not only contains last used index, but also
+	 * used_wrap_counter, the VRING_PACKED_EVENT_F_WRAP_CTR is
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
 
@@ -973,6 +975,15 @@ static struct virtqueue *vring_create_virtqueue_split(
 /*
  * Packed ring specific functions - *_packed().
  */
+static inline bool packed_used_wrap_counter(u16 last_used_idx)
+{
+	return !!(last_used_idx & (1 << VRING_PACKED_EVENT_F_WRAP_CTR));
+}
+
+static inline u16 packed_last_used(u16 last_used_idx)
+{
+	return last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
+}
 
 static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 				     struct vring_desc_extra *extra)
@@ -1406,8 +1417,14 @@ static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
 
 static inline bool more_used_packed(const struct vring_virtqueue *vq)
 {
-	return is_used_desc_packed(vq, vq->last_used_idx,
-			vq->packed.used_wrap_counter);
+	u16 last_used;
+	u16 last_used_idx;
+	bool used_wrap_counter;
+
+	last_used_idx = vq->last_used_idx;
+	last_used = packed_last_used(last_used_idx);
+	used_wrap_counter = packed_used_wrap_counter(last_used_idx);
+	return is_used_desc_packed(vq, last_used, used_wrap_counter);
 }
 
 static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
@@ -1415,7 +1432,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 					  void **ctx)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-	u16 last_used, id;
+	u16 last_used, id, last_used_idx;
+	bool used_wrap_counter;
 	void *ret;
 
 	START_USE(vq);
@@ -1434,7 +1452,9 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 	/* Only get used elements after they have been exposed by host. */
 	virtio_rmb(vq->weak_barriers);
 
-	last_used = vq->last_used_idx;
+	last_used_idx = vq->last_used_idx;
+	used_wrap_counter = packed_used_wrap_counter(last_used_idx);
+	last_used = packed_last_used(last_used_idx);
 	id = le16_to_cpu(vq->packed.vring.desc[last_used].id);
 	*len = le32_to_cpu(vq->packed.vring.desc[last_used].len);
 
@@ -1451,12 +1471,15 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
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
 
+	last_used = (last_used | (used_wrap_counter << VRING_PACKED_EVENT_F_WRAP_CTR));
+	vq->last_used_idx = last_used;
+
 	/*
 	 * If we expect an interrupt for the next entry, tell host
 	 * by writing event index and flush out the write before
@@ -1465,9 +1488,7 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
 		virtio_store_mb(vq->weak_barriers,
 				&vq->packed.vring.driver->off_wrap,
-				cpu_to_le16(vq->last_used_idx |
-					(vq->packed.used_wrap_counter <<
-					 VRING_PACKED_EVENT_F_WRAP_CTR)));
+				cpu_to_le16(vq->last_used_idx));
 
 	LAST_ADD_TIME_INVALID(vq);
 
@@ -1499,9 +1520,7 @@ static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
 
 	if (vq->event) {
 		vq->packed.vring.driver->off_wrap =
-			cpu_to_le16(vq->last_used_idx |
-				(vq->packed.used_wrap_counter <<
-				 VRING_PACKED_EVENT_F_WRAP_CTR));
+			cpu_to_le16(vq->last_used_idx);
 		/*
 		 * We need to update event offset and event wrap
 		 * counter first before updating event flags.
@@ -1518,8 +1537,7 @@ static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
 	}
 
 	END_USE(vq);
-	return vq->last_used_idx | ((u16)vq->packed.used_wrap_counter <<
-			VRING_PACKED_EVENT_F_WRAP_CTR);
+	return vq->last_used_idx;
 }
 
 static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
@@ -1537,7 +1555,7 @@ static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
 static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-	u16 used_idx, wrap_counter;
+	u16 used_idx, wrap_counter, last_used_idx;
 	u16 bufs;
 
 	START_USE(vq);
@@ -1550,9 +1568,10 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
 	if (vq->event) {
 		/* TODO: tune this threshold */
 		bufs = (vq->packed.vring.num - vq->vq.num_free) * 3 / 4;
-		wrap_counter = vq->packed.used_wrap_counter;
+		last_used_idx = vq->last_used_idx;
+		wrap_counter = packed_used_wrap_counter(last_used_idx);
 
-		used_idx = vq->last_used_idx + bufs;
+		used_idx = packed_last_used(last_used_idx) + bufs;
 		if (used_idx >= vq->packed.vring.num) {
 			used_idx -= vq->packed.vring.num;
 			wrap_counter ^= 1;
@@ -1582,9 +1601,10 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
 	 */
 	virtio_mb(vq->weak_barriers);
 
-	if (is_used_desc_packed(vq,
-				vq->last_used_idx,
-				vq->packed.used_wrap_counter)) {
+	last_used_idx = READ_ONCE(vq->last_used_idx);
+	wrap_counter = packed_used_wrap_counter(last_used_idx);
+	used_idx = packed_last_used(last_used_idx);
+	if (is_used_desc_packed(vq, used_idx, wrap_counter)) {
 		END_USE(vq);
 		return false;
 	}
@@ -1689,7 +1709,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
 	vq->broken = true;
-	vq->last_used_idx = 0;
+	vq->last_used_idx = 0 | (1 << VRING_PACKED_EVENT_F_WRAP_CTR);
 	vq->event_triggered = false;
 	vq->num_added = 0;
 	vq->packed_ring = true;
@@ -1720,7 +1740,6 @@ static struct virtqueue *vring_create_virtqueue_packed(
 
 	vq->packed.next_avail_idx = 0;
 	vq->packed.avail_wrap_counter = 1;
-	vq->packed.used_wrap_counter = 1;
 	vq->packed.event_flags_shadow = 0;
 	vq->packed.avail_used_flags = 1 << VRING_PACKED_DESC_F_AVAIL;
 
-- 
2.31.1

