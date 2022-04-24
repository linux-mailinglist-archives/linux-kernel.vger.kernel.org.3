Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B2850CE9B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237769AbiDXCoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 22:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237744AbiDXCnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:43:51 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9817EA09
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 19:40:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VAzbmr0_1650768049;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VAzbmr0_1650768049)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Apr 2022 10:40:49 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 05/16] virtio_ring: split: support copy from vring
Date:   Sun, 24 Apr 2022 10:40:33 +0800
Message-Id: <20220424024044.94749-6-xuanzhuo@linux.alibaba.com>
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

This process is similar to virtqueue_add_split(), but skips DMA. Use
the function virtqueue_update_split() provided by the previous patch to
update the state of the vq.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 60 ++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index aa85058978cb..167442cfdb2a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -703,6 +703,66 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	return -ENOMEM;
 }
 
+static u32 vring_copy_desc_split(struct vring_virtqueue *vq, u32 i,
+				 struct vring_virtqueue_split *vring,
+				 u32 src)
+{
+	struct vring_desc_extra *extra = vq->split.desc_extra;
+	struct vring_desc *desc = vq->split.vring.desc;
+	u16 next;
+
+	desc[i].flags = vring->vring.desc[src].flags;
+	desc[i].addr  = vring->vring.desc[src].addr;
+	desc[i].len   = vring->vring.desc[src].len;
+
+	next = extra[i].next;
+
+	desc[i].next = cpu_to_virtio16(vq->vq.vdev, next);
+
+	extra[i].addr  = vring->desc_extra[src].addr;
+	extra[i].len   = vring->desc_extra[src].len;
+	extra[i].flags = vring->desc_extra[src].flags;
+
+	return next;
+}
+
+static int vring_copy_to_vq_split(struct vring_virtqueue *vq,
+				  struct vring_virtqueue_split *vring,
+				  u32 old_index)
+{
+	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
+	struct vring_desc_state_split *state;
+	u32 i, num = 1, old_idx;
+
+	old_idx = old_index;
+	while (vring->vring.desc[old_idx].flags & nextflag) {
+		old_idx = vring->desc_extra[old_idx].next;
+		++num;
+	}
+
+	if (num > vq->vq.num_free)
+		return -ENOSPC;
+
+	i = vq->free_head;
+
+	old_idx = old_index;
+	while (vring->vring.desc[old_idx].flags & nextflag) {
+		i = vring_copy_desc_split(vq, i, vring, old_idx);
+
+		old_idx = vring->desc_extra[old_idx].next;
+	}
+
+	i = vring_copy_desc_split(vq, i, vring, old_idx);
+
+	state = &vring->desc_state[old_index];
+
+	virtqueue_update_split(vq, num, i, state->indir_desc, state->data);
+
+	state->data = NULL;
+
+	return num;
+}
+
 static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-- 
2.31.0

