Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BCA54D996
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 07:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349850AbiFPFMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 01:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349947AbiFPFMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 01:12:37 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB1EE84
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 22:12:35 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d5so379009plo.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 22:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K6APsq4tDt5m1rhkx9pZrHgR500bi3xDgnHBj5n4EMQ=;
        b=TIBenbp8Lia2BrKRt56lOsK3MDAI7WgM5mYRNztVQ8gfUhzV/40GkOSKSUXKasdJk3
         zhc6Sa35szjnlxP1uSy+jXCh2sB23ycd5FHDArJ1B91nSDK65yaNYnGgOvZyQUNIPbmb
         zyvp3KWLPy8ww3NcEYg3gaONpadfQ+mD+ECQqJHc/D0DPiHk6I99vo5VHfvnKuGXNJse
         cPYKtdX/VS0IiGspFBTKHiSt1VaOE3XsEdd72L1AZgaG2eMrKzLWebDVmJU/tTl0DCeE
         EdqvtgfopThIHDARTojy1BPJMI7DXI2WQZEv270wgI172YsxR4PDRa/0jYeoM3hTnlmw
         orxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K6APsq4tDt5m1rhkx9pZrHgR500bi3xDgnHBj5n4EMQ=;
        b=A5WLHSaSPL5xvsSmv00EVWglz4xVfu0sdVVG4UHzeZCIvqQBsaMUXnE8tZ3VbCNY+Z
         pxz9aqUV5u8LKzZSOWgStN86EpWESAn1YV6Qi9E2FkyZ0NAU7SjFtBVEWgL8EHJmEzMW
         vGufiJelCP+aIJzdKuKYRCJg0m/3sjWpW8PX3IGW0RbBBPkPH0IYFXTr0prC0MfcWYJF
         r4bXvLJQV1d6DFeupmx1Jvul68+1S9dds+FoPAzwsjOc2qqvpldFpJyXIImMEwUFuxWd
         OHlttTaGSs0FiysXGWXk7EeWcyjN12Ok3XzAo7IU+k9ukp1osz5N6dL/I4yPHa4u8byU
         Nvyw==
X-Gm-Message-State: AJIora+utS0B2QrrAZXcWsOS+0i5TI6mAHlvT+7PHaKnhKXYxkwkNasV
        s1O4jpvLKH8z7Rgml1G2nXRTcg==
X-Google-Smtp-Source: AGRyM1sRqvWrg7X/3wcNRnIDfi7SbqTvE3OmebHqZ8KZBCtjnkv7jpB+f75t/qpwQOha2Pw88CLutQ==
X-Received: by 2002:a17:90a:738d:b0:1ea:c598:20b3 with SMTP id j13-20020a17090a738d00b001eac59820b3mr12918436pjg.88.1655356354925;
        Wed, 15 Jun 2022 22:12:34 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id s10-20020a62e70a000000b0051ba2c0ff24sm603663pfh.144.2022.06.15.22.12.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jun 2022 22:12:34 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
To:     jasowang@redhat.com
Cc:     yuanzhu@bytedance.com,
        "huangjie.albert" <huangjie.albert@bytedance.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] virtio_ring : keep used_wrap_counter in vq->last_used_idx
Date:   Thu, 16 Jun 2022 13:12:21 +0800
Message-Id: <20220616051221.28506-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <CACGkMEtz-1=3=+zUZvc+CX4LrufZZfZO=_zONo5GuAUX+BrpAQ@mail.gmail.com>
References: <CACGkMEtz-1=3=+zUZvc+CX4LrufZZfZO=_zONo5GuAUX+BrpAQ@mail.gmail.com>
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

v1->v2:
- reuse the VRING_PACKED_EVENT_F_WRAP_CTR
- Remove parameter judgment in is_used_desc_packed,
because it can't be illegal

Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
---
 drivers/virtio/virtio_ring.c | 57 ++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 13a7348cedff..b22d97c9a755 100644
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
 
@@ -1406,8 +1408,12 @@ static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
 
 static inline bool more_used_packed(const struct vring_virtqueue *vq)
 {
-	return is_used_desc_packed(vq, vq->last_used_idx,
-			vq->packed.used_wrap_counter);
+	u16 last_used;
+	bool used_wrap_counter;
+
+	last_used = vq->last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR);
+	used_wrap_counter = !!((vq->last_used_idx) >> VRING_PACKED_EVENT_F_WRAP_CTR);
+	return is_used_desc_packed(vq, last_used, used_wrap_counter);
 }
 
 static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
@@ -1416,6 +1422,7 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	u16 last_used, id;
+	bool used_wrap_counter;
 	void *ret;
 
 	START_USE(vq);
@@ -1434,7 +1441,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 	/* Only get used elements after they have been exposed by host. */
 	virtio_rmb(vq->weak_barriers);
 
-	last_used = vq->last_used_idx;
+	used_wrap_counter = !!((vq->last_used_idx >> VRING_PACKED_EVENT_F_WRAP_CTR));
+	last_used = (vq->last_used_idx) & (~(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
 	id = le16_to_cpu(vq->packed.vring.desc[last_used].id);
 	*len = le32_to_cpu(vq->packed.vring.desc[last_used].len);
 
@@ -1451,12 +1459,15 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
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
@@ -1465,9 +1476,7 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
 		virtio_store_mb(vq->weak_barriers,
 				&vq->packed.vring.driver->off_wrap,
-				cpu_to_le16(vq->last_used_idx |
-					(vq->packed.used_wrap_counter <<
-					 VRING_PACKED_EVENT_F_WRAP_CTR)));
+				cpu_to_le16(vq->last_used_idx));
 
 	LAST_ADD_TIME_INVALID(vq);
 
@@ -1499,9 +1508,7 @@ static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
 
 	if (vq->event) {
 		vq->packed.vring.driver->off_wrap =
-			cpu_to_le16(vq->last_used_idx |
-				(vq->packed.used_wrap_counter <<
-				 VRING_PACKED_EVENT_F_WRAP_CTR));
+			cpu_to_le16(vq->last_used_idx);
 		/*
 		 * We need to update event offset and event wrap
 		 * counter first before updating event flags.
@@ -1518,8 +1525,7 @@ static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
 	}
 
 	END_USE(vq);
-	return vq->last_used_idx | ((u16)vq->packed.used_wrap_counter <<
-			VRING_PACKED_EVENT_F_WRAP_CTR);
+	return vq->last_used_idx;
 }
 
 static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
@@ -1550,9 +1556,9 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
 	if (vq->event) {
 		/* TODO: tune this threshold */
 		bufs = (vq->packed.vring.num - vq->vq.num_free) * 3 / 4;
-		wrap_counter = vq->packed.used_wrap_counter;
+		wrap_counter = !!(vq->last_used_idx >> VRING_PACKED_EVENT_F_WRAP_CTR);
 
-		used_idx = vq->last_used_idx + bufs;
+		used_idx = (vq->last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR)) + bufs;
 		if (used_idx >= vq->packed.vring.num) {
 			used_idx -= vq->packed.vring.num;
 			wrap_counter ^= 1;
@@ -1582,9 +1588,9 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
 	 */
 	virtio_mb(vq->weak_barriers);
 
-	if (is_used_desc_packed(vq,
-				vq->last_used_idx,
-				vq->packed.used_wrap_counter)) {
+	wrap_counter = !!(vq->last_used_idx >> VRING_PACKED_EVENT_F_WRAP_CTR);
+	used_idx = (vq->last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
+	if (is_used_desc_packed(vq, used_idx, wrap_counter)) {
 		END_USE(vq);
 		return false;
 	}
@@ -1689,7 +1695,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
 	vq->broken = true;
-	vq->last_used_idx = 0;
+	vq->last_used_idx = 0 | (1 << VRING_PACKED_EVENT_F_WRAP_CTR);
 	vq->event_triggered = false;
 	vq->num_added = 0;
 	vq->packed_ring = true;
@@ -1720,7 +1726,6 @@ static struct virtqueue *vring_create_virtqueue_packed(
 
 	vq->packed.next_avail_idx = 0;
 	vq->packed.avail_wrap_counter = 1;
-	vq->packed.used_wrap_counter = 1;
 	vq->packed.event_flags_shadow = 0;
 	vq->packed.avail_used_flags = 1 << VRING_PACKED_DESC_F_AVAIL;
 
-- 
2.31.1

