Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB7F50CE9E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbiDXCo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 22:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237796AbiDXCoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:44:01 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8AF85970
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 19:40:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VAzbmsJ_1650768056;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VAzbmsJ_1650768056)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Apr 2022 10:40:57 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 14/16] virtio_ring: packed: introduce vring_reuse_bufs_packed()
Date:   Sun, 24 Apr 2022 10:40:42 +0800
Message-Id: <20220424024044.94749-15-xuanzhuo@linux.alibaba.com>
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

vring_reuse_bufs_packed() checks vring.desc forward based on
last_used_idx. The resulting buffers are the order in which they were
committed.

It is beneficial to ensure the order of buffers in the process of reuse.
For example, under virtio-net, if the order is not guaranteed, it may
lead to out-of-order tcp streams.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 45 ++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 8ca9985ffb4b..66f71e22ece0 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2041,6 +2041,51 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
 	return true;
 }
 
+static void vring_reuse_bufs_packed(struct vring_virtqueue *vq,
+				    struct vring_virtqueue_packed *vring,
+				    void (*recycle)(struct virtqueue *vq, void *buf))
+{
+	struct vring_desc_state_packed *state;
+	u32 last_used, id, desc_num = 0;
+	int err = 0;
+	void *buf;
+
+	last_used = vring->last_used_idx;
+
+	do {
+		id = le16_to_cpu(vring->vring.desc[last_used].id);
+
+		state = &vring->desc_state[id];
+
+		if (!state->data) {
+			last_used++;
+			goto next;
+		}
+
+		/* once add to vq fail, no more try add to vq. */
+		if (err >= 0) {
+			err = vring_copy_to_vq_packed(vq, vring, id);
+			if (err >= 0)
+				goto ok;
+		}
+
+		buf = state->data;
+		detach_buf_from_vring_packed(vring, vq, id, 0, NULL);
+		recycle(&vq->vq, buf);
+
+ok:
+		last_used += state->num;
+		desc_num += state->num;
+
+next:
+		if (unlikely(last_used >= vring->vring.num))
+			last_used -= vring->vring.num;
+
+	} while (last_used != vring->last_used_idx);
+
+	WARN_ON(vring->num_left != desc_num);
+}
+
 static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-- 
2.31.0

