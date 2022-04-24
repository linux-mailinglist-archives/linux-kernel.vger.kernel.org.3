Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1BE50CE9C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbiDXCod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 22:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237788AbiDXCn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:43:57 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1119782D2E
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 19:40:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VAzv5F-_1650768054;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VAzv5F-_1650768054)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Apr 2022 10:40:54 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 11/16] virtio_ring: packed: extract virtqueue_update_packed()
Date:   Sun, 24 Apr 2022 10:40:39 +0800
Message-Id: <20220424024044.94749-12-xuanzhuo@linux.alibaba.com>
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

Separate the logic for updating the vq state from virtqueue_add_packed()
and virtqueue_add_indirect_packed().

In this way, when the subsequent patch implements the logic of reusing
the buffer when resize, we can share this function.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 96 ++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 49 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 219e008a4633..5e6bd9a4e648 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1403,6 +1403,47 @@ static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
 	return desc;
 }
 
+static inline void virtqueue_update_packed(struct vring_virtqueue *vq,
+					   u32 descs_used,
+					   u16 curr,
+					   u16 prev,
+					   u32 idx,
+					   __le16 head_flags,
+					   struct vring_packed_desc *desc,
+					   void *data)
+{
+	u16 head, id;
+
+	id = vq->free_head;
+	head = vq->packed.next_avail_idx;
+
+	if (idx < head)
+		vq->packed.avail_wrap_counter ^= 1;
+
+	/* We're using some buffers from the free list. */
+	vq->vq.num_free -= descs_used;
+
+	/* Update free pointer */
+	vq->packed.next_avail_idx = idx;
+	vq->free_head = curr;
+
+	/* Store token. */
+	vq->packed.desc_state[id].num = descs_used;
+	vq->packed.desc_state[id].data = data;
+	vq->packed.desc_state[id].indir_desc = desc;
+	vq->packed.desc_state[id].last = prev;
+
+	/*
+	 * A driver MUST NOT make the first descriptor in the list
+	 * available before all subsequent descriptors comprising
+	 * the list are made available.
+	 */
+	virtio_wmb(vq->weak_barriers);
+	vq->packed.vring.desc[head].flags = head_flags;
+	vq->num_added += descs_used;
+
+}
+
 static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 					 struct scatterlist *sgs[],
 					 unsigned int total_sg,
@@ -1414,6 +1455,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
 	unsigned int i, n, err_idx;
+	__le16 head_flags;
 	u16 head, id;
 	dma_addr_t addr;
 
@@ -1466,34 +1508,13 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	vq->packed.desc_extra[id].flags = VRING_DESC_F_INDIRECT |
 		vq->packed.avail_used_flags;
 
-	/*
-	 * A driver MUST NOT make the first descriptor in the list
-	 * available before all subsequent descriptors comprising
-	 * the list are made available.
-	 */
-	virtio_wmb(vq->weak_barriers);
-	vq->packed.vring.desc[head].flags = cpu_to_le16(VRING_DESC_F_INDIRECT |
-						vq->packed.avail_used_flags);
-
-	/* We're using some buffers from the free list. */
-	vq->vq.num_free -= 1;
+	head_flags = cpu_to_le16(VRING_DESC_F_INDIRECT | vq->packed.avail_used_flags);
 
 	/* Update free pointer */
 	n = next_idx(vq, head);
 
-	if (n < head)
-		vq->packed.avail_wrap_counter ^= 1;
-
-	vq->packed.next_avail_idx = n;
-	vq->free_head = vq->packed.desc_extra[id].next;
-
-	/* Store token and indirect buffer state. */
-	vq->packed.desc_state[id].num = 1;
-	vq->packed.desc_state[id].data = data;
-	vq->packed.desc_state[id].indir_desc = desc;
-	vq->packed.desc_state[id].last = id;
-
-	vq->num_added += 1;
+	virtqueue_update_packed(vq, 1, vq->packed.desc_extra[id].next, id, n,
+				head_flags, desc, data);
 
 	pr_debug("Added buffer head %i to %p\n", head, vq);
 	END_USE(vq);
@@ -1605,31 +1626,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 		}
 	}
 
-	if (i < head)
-		vq->packed.avail_wrap_counter ^= 1;
-
-	/* We're using some buffers from the free list. */
-	vq->vq.num_free -= descs_used;
-
-	/* Update free pointer */
-	vq->packed.next_avail_idx = i;
-	vq->free_head = curr;
-
-	/* Store token. */
-	vq->packed.desc_state[id].num = descs_used;
-	vq->packed.desc_state[id].data = data;
-	vq->packed.desc_state[id].indir_desc = ctx;
-	vq->packed.desc_state[id].last = prev;
-
-	/*
-	 * A driver MUST NOT make the first descriptor in the list
-	 * available before all subsequent descriptors comprising
-	 * the list are made available.
-	 */
-	virtio_wmb(vq->weak_barriers);
-	vq->packed.vring.desc[head].flags = head_flags;
-	vq->num_added += descs_used;
-
+	virtqueue_update_packed(vq, descs_used, curr, prev, i, head_flags,
+				ctx, data);
 	pr_debug("Added buffer head %i to %p\n", head, vq);
 	END_USE(vq);
 
-- 
2.31.0

