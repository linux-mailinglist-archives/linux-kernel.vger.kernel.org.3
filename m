Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0C850CE96
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbiDXCoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 22:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237759AbiDXCnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:43:53 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BDD81182
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 19:40:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VAzcuZa_1650768051;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VAzcuZa_1650768051)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Apr 2022 10:40:52 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 08/16] virtio_ring: packed: extract next_idx()
Date:   Sun, 24 Apr 2022 10:40:36 +0800
Message-Id: <20220424024044.94749-9-xuanzhuo@linux.alibaba.com>
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

Separate the logic of idx growth of packed into a function. It is
convenient to share in multiple locations. Subsequent patches will also
use this logic.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fa4270e8c009..e3525d92f646 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1330,6 +1330,18 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num,
  * Packed ring specific functions - *_packed().
  */
 
+static u32 next_idx(struct vring_virtqueue *vq, u32 idx)
+{
+	if ((unlikely(++idx >= vq->packed.vring.num))) {
+		idx = 0;
+		vq->packed.avail_used_flags ^=
+			1 << VRING_PACKED_DESC_F_AVAIL |
+			1 << VRING_PACKED_DESC_F_USED;
+	}
+
+	return idx;
+}
+
 static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 				     struct vring_desc_extra *extra)
 {
@@ -1465,14 +1477,11 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	vq->vq.num_free -= 1;
 
 	/* Update free pointer */
-	n = head + 1;
-	if (n >= vq->packed.vring.num) {
-		n = 0;
+	n = next_idx(vq, head);
+
+	if (n < head)
 		vq->packed.avail_wrap_counter ^= 1;
-		vq->packed.avail_used_flags ^=
-				1 << VRING_PACKED_DESC_F_AVAIL |
-				1 << VRING_PACKED_DESC_F_USED;
-	}
+
 	vq->packed.next_avail_idx = n;
 	vq->free_head = vq->packed.desc_extra[id].next;
 
@@ -1592,12 +1601,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 			prev = curr;
 			curr = vq->packed.desc_extra[curr].next;
 
-			if ((unlikely(++i >= vq->packed.vring.num))) {
-				i = 0;
-				vq->packed.avail_used_flags ^=
-					1 << VRING_PACKED_DESC_F_AVAIL |
-					1 << VRING_PACKED_DESC_F_USED;
-			}
+			i = next_idx(vq, i);
 		}
 	}
 
-- 
2.31.0

