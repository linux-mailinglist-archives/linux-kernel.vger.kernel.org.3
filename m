Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E384550CEA2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbiDXCpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 22:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237792AbiDXCoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:44:01 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3076C84EE1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 19:40:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VAzcub1_1650768055;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VAzcub1_1650768055)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Apr 2022 10:40:56 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 13/16] virtio_ring: packed: support copy from vring
Date:   Sun, 24 Apr 2022 10:40:41 +0800
Message-Id: <20220424024044.94749-14-xuanzhuo@linux.alibaba.com>
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

To support reusing old buffers during resize.

This patch implements copying a buffer from the detached vring to the vq
where the new vring is attached.

This process is similar to virtqueue_add_packed(), but skips DMA. Use
the function virtqueue_update_packed() provided by the previous patch to
update the state of the vq.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 76 ++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 1efb47b88b40..8ca9985ffb4b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1654,6 +1654,82 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	return -EIO;
 }
 
+static u32 vring_copy_desc_packed(struct vring_virtqueue *vq,
+				  u32 idx,
+				  u16 curr,
+				  __le16 *head_flags,
+				  struct vring_virtqueue_packed *vring,
+				  u32 src)
+{
+	u16 old_flags = vring->desc_extra[src].flags;
+	u16 flags = vq->packed.avail_used_flags;
+	struct vring_packed_desc *desc;
+	struct vring_desc_extra *extra;
+
+	if (old_flags & VRING_DESC_F_NEXT)
+		flags |= VRING_DESC_F_NEXT;
+
+	if (old_flags & VRING_DESC_F_WRITE)
+		flags |= VRING_DESC_F_WRITE;
+
+	if (old_flags & VRING_DESC_F_INDIRECT)
+		flags |= VRING_DESC_F_INDIRECT;
+
+	desc = vq->packed.vring.desc + idx;
+	extra = vq->packed.desc_extra + curr;
+
+	if (head_flags)
+		*head_flags = cpu_to_le16(flags);
+	else
+		desc->flags = cpu_to_le16(flags);
+
+	desc->addr = cpu_to_le64(vring->desc_extra[src].addr);
+	desc->len  = cpu_to_le32(vring->desc_extra[src].len);
+	desc->id   = cpu_to_le16(vq->free_head);
+
+	extra->addr  = vring->desc_extra[src].addr;
+	extra->len   = vring->desc_extra[src].len;
+	extra->flags = vring->desc_extra[src].flags;
+
+	return vq->packed.desc_extra[curr].next;
+}
+
+static int vring_copy_to_vq_packed(struct vring_virtqueue *vq,
+				   struct vring_virtqueue_packed *vring,
+				   u32 old_id)
+{
+	struct vring_desc_state_packed *state;
+	__le16 head_flags;
+	u16 prev, curr;
+	u32 i, n;
+
+	state = &vring->desc_state[old_id];
+
+	if (state->num > vq->vq.num_free)
+		return -ENOSPC;
+
+	i = vq->packed.next_avail_idx;
+	curr = vq->free_head;
+
+	for (n = 0; n < state->num; n++) {
+		prev = curr;
+		curr = vring_copy_desc_packed(vq, i, curr,
+					      n ? NULL : &head_flags,
+					      vring, old_id);
+
+		old_id = vring->desc_extra[old_id].next;
+
+		i = next_idx(vq, i);
+	}
+
+	virtqueue_update_packed(vq, state->num, curr, prev, i, head_flags,
+				state->indir_desc, state->data);
+
+	state->data = NULL;
+
+	return state->num;
+}
+
 static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-- 
2.31.0

