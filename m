Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8601B50CE99
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbiDXCor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 22:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237780AbiDXCoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:44:00 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181E88164C
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 19:40:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VAzcuah_1650768055;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VAzcuah_1650768055)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Apr 2022 10:40:55 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 12/16] virtio_ring: packed: extract detach_from_vring_packed()
Date:   Sun, 24 Apr 2022 10:40:40 +0800
Message-Id: <20220424024044.94749-13-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220424024044.94749-1-xuanzhuo@linux.alibaba.com>
References: <20220424024044.94749-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: c42022d07dde
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To handle freeing buf from the detached vring, do a split for
detach_buf_packed().

The split function detach_buf_from_vring_packed() is used to release buf
from vring, and the vq passed in is read-only. All modifications are for
vring.

In this way, detach_buf_from_vring_packed() becomes a general function,
which can be used for detach_buf_packed() and also for handling detached
vrings.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 5e6bd9a4e648..1efb47b88b40 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1703,28 +1703,28 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
 	return needs_kick;
 }
 
-static void detach_buf_packed(struct vring_virtqueue *vq,
-			      unsigned int id, void **ctx)
+static int detach_buf_from_vring_packed(struct vring_virtqueue_packed *vring,
+					struct vring_virtqueue const *vq,
+					unsigned int id,
+					unsigned int free_head,
+					void **ctx)
 {
 	struct vring_desc_state_packed *state = NULL;
 	struct vring_packed_desc *desc;
 	unsigned int i, curr;
 
-	state = &vq->packed.desc_state[id];
+	state = &vring->desc_state[id];
 
 	/* Clear data ptr. */
 	state->data = NULL;
 
-	vq->packed.desc_extra[state->last].next = vq->free_head;
-	vq->free_head = id;
-	vq->vq.num_free += state->num;
+	vring->desc_extra[state->last].next = free_head;
 
 	if (unlikely(vq->use_dma_api)) {
 		curr = id;
 		for (i = 0; i < state->num; i++) {
-			vring_unmap_extra_packed(vq,
-						 &vq->packed.desc_extra[curr]);
-			curr = vq->packed.desc_extra[curr].next;
+			vring_unmap_extra_packed(vq, &vring->desc_extra[curr]);
+			curr = vring->desc_extra[curr].next;
 		}
 	}
 
@@ -1734,10 +1734,10 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		/* Free the indirect table, if any, now that it's unmapped. */
 		desc = state->indir_desc;
 		if (!desc)
-			return;
+			return state->num;
 
 		if (vq->use_dma_api) {
-			len = vq->packed.desc_extra[id].len;
+			len = vring->desc_extra[id].len;
 			for (i = 0; i < len / sizeof(struct vring_packed_desc);
 					i++)
 				vring_unmap_desc_packed(vq, &desc[i]);
@@ -1747,6 +1747,20 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	} else if (ctx) {
 		*ctx = state->indir_desc;
 	}
+
+	return state->num;
+}
+
+static void detach_buf_packed(struct vring_virtqueue *vq,
+			      unsigned int id, void **ctx)
+{
+	int num;
+
+	num = detach_buf_from_vring_packed(&vq->packed, vq, id, vq->free_head,
+					   ctx);
+
+	vq->free_head = id;
+	vq->vq.num_free += num;
 }
 
 static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
-- 
2.31.0

