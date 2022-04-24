Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D074D50CE9A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbiDXCoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 22:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbiDXCnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:43:52 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DD17DE3E
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 19:40:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VAzpPIS_1650768048;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VAzpPIS_1650768048)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Apr 2022 10:40:48 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 04/16] virtio_ring: split: extract detach_from_vring_split()
Date:   Sun, 24 Apr 2022 10:40:32 +0800
Message-Id: <20220424024044.94749-5-xuanzhuo@linux.alibaba.com>
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
detach_buf_split().

The split function detach_buf_from_vring_split() is used to release buf
from vring, and the vq passed in is read-only. All modifications are for
vring.

In this way, detach_buf_from_vring_split() becomes a general function,
which can be used for detach_buf_split() and also for handling detached
vrings.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 54 +++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 6fd45c9a3517..aa85058978cb 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -734,54 +734,68 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
 	return needs_kick;
 }
 
-static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
-			     void **ctx)
+static int detach_buf_from_vring_split(struct vring_virtqueue_split *vring,
+				       struct vring_virtqueue const *vq,
+				       unsigned int head,
+				       unsigned int free_head,
+				       void **ctx)
 {
-	unsigned int i, j;
+	unsigned int i, j, num = 0;
 	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
 
 	/* Clear data ptr. */
-	vq->split.desc_state[head].data = NULL;
+	vring->desc_state[head].data = NULL;
 
 	/* Put back on free list: unmap first-level descriptors and find end */
 	i = head;
 
-	while (vq->split.vring.desc[i].flags & nextflag) {
-		vring_unmap_one_split(vq, &vq->split.desc_extra[i]);
-		i = vq->split.desc_extra[i].next;
-		vq->vq.num_free++;
+	while (vring->vring.desc[i].flags & nextflag) {
+		vring_unmap_one_split(vq, &vring->desc_extra[i]);
+		i = vring->desc_extra[i].next;
+		++num;
 	}
 
-	vring_unmap_one_split(vq, &vq->split.desc_extra[i]);
-	vq->split.desc_extra[i].next = vq->free_head;
-	vq->free_head = head;
+	vring_unmap_one_split(vq, &vring->desc_extra[i]);
+	vring->desc_extra[i].next = free_head;
 
-	/* Plus final descriptor */
-	vq->vq.num_free++;
+	++num;
 
 	if (vq->indirect) {
 		struct vring_desc *indir_desc =
-				vq->split.desc_state[head].indir_desc;
+				vring->desc_state[head].indir_desc;
 		u32 len;
 
 		/* Free the indirect table, if any, now that it's unmapped. */
 		if (!indir_desc)
-			return;
+			return num;
 
-		len = vq->split.desc_extra[head].len;
+		len = vring->desc_extra[head].len;
 
-		BUG_ON(!(vq->split.desc_extra[head].flags &
-				VRING_DESC_F_INDIRECT));
+		BUG_ON(!(vring->desc_extra[head].flags & VRING_DESC_F_INDIRECT));
 		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
 
 		for (j = 0; j < len / sizeof(struct vring_desc); j++)
 			vring_unmap_one_split_indirect(vq, &indir_desc[j]);
 
 		kfree(indir_desc);
-		vq->split.desc_state[head].indir_desc = NULL;
+		vring->desc_state[head].indir_desc = NULL;
 	} else if (ctx) {
-		*ctx = vq->split.desc_state[head].indir_desc;
+		*ctx = vring->desc_state[head].indir_desc;
 	}
+
+	return num;
+}
+
+static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
+			     void **ctx)
+{
+	int num;
+
+	num = detach_buf_from_vring_split(&vq->split, vq, head, vq->free_head,
+					  ctx);
+
+	vq->vq.num_free += num;
+	vq->free_head = head;
 }
 
 static inline bool more_used_split(const struct vring_virtqueue *vq)
-- 
2.31.0

