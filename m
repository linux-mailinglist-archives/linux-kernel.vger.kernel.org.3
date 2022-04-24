Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CB850CEA1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbiDXCoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 22:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237738AbiDXCnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:43:49 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253CA7DE3E
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 19:40:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VAzRZYU_1650768047;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VAzRZYU_1650768047)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Apr 2022 10:40:47 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 03/16] virtio_ring: split: extract virtqueue_update_split()
Date:   Sun, 24 Apr 2022 10:40:31 +0800
Message-Id: <20220424024044.94749-4-xuanzhuo@linux.alibaba.com>
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

Separate the logic for updating the vq state from virtqueue_add_split().

In this way, when the subsequent patch implements the logic of reusing
the buffer when resize, we can share this function.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 95 ++++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 41 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index f3ad9322b512..6fd45c9a3517 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -507,6 +507,51 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
 	return next;
 }
 
+static inline void virtqueue_update_split(struct vring_virtqueue *vq,
+					  u32 descs_used,
+					  u32 next,
+					  struct vring_desc *desc,
+					  void *data)
+{
+	struct virtqueue *_vq = &vq->vq;
+	u32 avail, head;
+
+	head = vq->free_head;
+
+	/* We're using some buffers from the free list. */
+	vq->vq.num_free -= descs_used;
+
+	/* Update free pointer */
+	vq->free_head = next;
+
+	/* Store token and indirect buffer state. */
+	vq->split.desc_state[head].data = data;
+	vq->split.desc_state[head].indir_desc = desc;
+
+	/* Put entry in available array (but don't update avail->idx until they
+	 * do sync).
+	 */
+	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
+	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
+
+	/* Descriptors and available array need to be set before we expose the
+	 * new available array entries.
+	 */
+	virtio_wmb(vq->weak_barriers);
+	vq->split.avail_idx_shadow++;
+	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
+						vq->split.avail_idx_shadow);
+	vq->num_added++;
+
+	pr_debug("Added buffer head %i to %p\n", head, vq);
+
+	/* This is very unlikely, but theoretically possible.  Kick
+	 * just in case.
+	 */
+	if (unlikely(vq->num_added == (1 << 16) - 1))
+		virtqueue_kick(_vq);
+}
+
 static inline int virtqueue_add_split(struct virtqueue *_vq,
 				      struct scatterlist *sgs[],
 				      unsigned int total_sg,
@@ -519,7 +564,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct scatterlist *sg;
 	struct vring_desc *desc;
-	unsigned int i, n, avail, descs_used, prev, err_idx;
+	unsigned int i, n, descs_used, prev, err_idx;
 	int head;
 	bool indirect;
 
@@ -619,50 +664,18 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		if (vring_mapping_error(vq, addr))
 			goto unmap_release;
 
-		virtqueue_add_desc_split(_vq, vq->split.vring.desc,
-					 head, addr,
-					 total_sg * sizeof(struct vring_desc),
-					 VRING_DESC_F_INDIRECT,
-					 false);
+		i = virtqueue_add_desc_split(_vq, vq->split.vring.desc,
+					     head, addr,
+					     total_sg * sizeof(struct vring_desc),
+					     VRING_DESC_F_INDIRECT,
+					     false);
+	} else {
+		desc = ctx;
 	}
 
-	/* We're using some buffers from the free list. */
-	vq->vq.num_free -= descs_used;
-
-	/* Update free pointer */
-	if (indirect)
-		vq->free_head = vq->split.desc_extra[head].next;
-	else
-		vq->free_head = i;
-
-	/* Store token and indirect buffer state. */
-	vq->split.desc_state[head].data = data;
-	if (indirect)
-		vq->split.desc_state[head].indir_desc = desc;
-	else
-		vq->split.desc_state[head].indir_desc = ctx;
-
-	/* Put entry in available array (but don't update avail->idx until they
-	 * do sync). */
-	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
-	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
-
-	/* Descriptors and available array need to be set before we expose the
-	 * new available array entries. */
-	virtio_wmb(vq->weak_barriers);
-	vq->split.avail_idx_shadow++;
-	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
-						vq->split.avail_idx_shadow);
-	vq->num_added++;
-
-	pr_debug("Added buffer head %i to %p\n", head, vq);
+	virtqueue_update_split(vq, descs_used, i, desc, data);
 	END_USE(vq);
 
-	/* This is very unlikely, but theoretically possible.  Kick
-	 * just in case. */
-	if (unlikely(vq->num_added == (1 << 16) - 1))
-		virtqueue_kick(_vq);
-
 	return 0;
 
 unmap_release:
-- 
2.31.0

