Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DA250CE9F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237808AbiDXCoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 22:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237748AbiDXCnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:43:52 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9709F7F213
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 19:40:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VAzpPIr_1650768049;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VAzpPIr_1650768049)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Apr 2022 10:40:50 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 06/16] virtio_ring: split: introduce vring_reuse_bufs_split()
Date:   Sun, 24 Apr 2022 10:40:34 +0800
Message-Id: <20220424024044.94749-7-xuanzhuo@linux.alibaba.com>
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

This patch will resubmit the buffers to the new vq in the order in which
they were submitted.

In order to get these buffers in order, the patch will get the buffers
from the avail ring. We can know the current position of the avail ring
from vring.avail->idx.

First, check backward from idx. If a state appears repeatedly, it means
that the buffer corresponding to this state has been consumed by the
device and resubmitted. We will remove the subsequent state from the
queue. Then move forward from the position where idx ends, the buffers
encountered at this time are the order in which they were submitted.

It is beneficial to ensure the order of buffers in the process of reuse.
For example, under virtio-net, if the order is not guaranteed, it may
lead to out-of-order tcp streams.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 65 ++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 167442cfdb2a..02d4ffcc0a3b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -69,6 +69,7 @@
 struct vring_desc_state_split {
 	void *data;			/* Data for callback. */
 	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
+	bool checked;
 };
 
 struct vring_desc_state_packed {
@@ -1007,6 +1008,70 @@ static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
 	return true;
 }
 
+static void vring_reuse_bufs_split(struct vring_virtqueue *vq,
+				   struct vring_virtqueue_split *vring,
+				   void (*recycle)(struct virtqueue *vq, void *buf))
+{
+	u32 head, num, idx, oidx, i, desc_num = 0;
+	u16 null, *p;
+	int err = 0;
+	void *buf;
+
+	num = vring->vring.num;
+
+	oidx = le16_to_cpu(vring->vring.avail->idx) - 1;
+	null = vring->vring.avail->ring[oidx & (num - 1)];
+
+	/*
+	 * Check in the opposite direction in the avail ring. If a state appears
+	 * repeatedly, it means that the state has been used and rejoined the
+	 * avail ring.
+	 */
+	for (i = 0, idx = oidx; i < num; ++i, --idx) {
+		p = &vring->vring.avail->ring[idx & (num - 1)];
+
+		head = virtio32_to_cpu(vq->vq.vdev, *p);
+
+		if (vring->desc_state[head].checked) {
+			*p = null;
+			continue;
+		}
+
+		vring->desc_state[head].checked = true;
+	}
+
+	/*
+	 * Checking the avail ring forward, the non-null states encountered are
+	 * the order in which they were added to the avail ring.
+	 */
+	for (i = 0, ++idx; i < num; ++i, ++idx) {
+		p = &vring->vring.avail->ring[idx & (num - 1)];
+		if (*p == null && idx != oidx)
+			continue;
+
+		head = virtio32_to_cpu(vq->vq.vdev, *p);
+
+		if (!vring->desc_state[head].data)
+			continue;
+
+		/* once add to vq fail, no more try add to vq. */
+		if (err >= 0) {
+			err = vring_copy_to_vq_split(vq, vring, head);
+			if (err >= 0) {
+				desc_num += err;
+				continue;
+			}
+		}
+
+		buf = vring->desc_state[head].data;
+		desc_num += detach_buf_from_vring_split(vring, vq, head, 0,
+							NULL);
+		recycle(&vq->vq, buf);
+	}
+
+	WARN_ON(vring->num_left != desc_num);
+}
+
 static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-- 
2.31.0

