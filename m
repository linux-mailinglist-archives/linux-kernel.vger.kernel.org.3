Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41894AF198
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbiBIM3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbiBIM3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:29:04 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079C8C05CB9B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 04:29:07 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V4.8o.9_1644409744;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0V4.8o.9_1644409744)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Feb 2022 20:29:05 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v4 04/14] virtio_ring: queue_reset: split: add __vring_init_virtqueue()
Date:   Wed,  9 Feb 2022 20:28:51 +0800
Message-Id: <20220209122901.51790-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
References: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract vq's initialization function __vring_init_virtqueue() from
__vring_new_virtqueue()

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 61 +++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 19 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 766f4fd8cf06..30be9173c263 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2167,23 +2167,17 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
 EXPORT_SYMBOL_GPL(vring_interrupt);
 
 /* Only available for split ring */
-struct virtqueue *__vring_new_virtqueue(unsigned int index,
-					struct vring vring,
-					struct virtio_device *vdev,
-					bool weak_barriers,
-					bool context,
-					bool (*notify)(struct virtqueue *),
-					void (*callback)(struct virtqueue *),
-					const char *name)
+static int __vring_init_virtqueue(struct virtqueue *_vq,
+				  unsigned int index,
+				  struct vring vring,
+				  struct virtio_device *vdev,
+				  bool weak_barriers,
+				  bool context,
+				  bool (*notify)(struct virtqueue *),
+				  void (*callback)(struct virtqueue *),
+				  const char *name)
 {
-	struct vring_virtqueue *vq;
-
-	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
-		return NULL;
-
-	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
-	if (!vq)
-		return NULL;
+	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	vq->packed_ring = false;
 	vq->vq.callback = callback;
@@ -2243,13 +2237,42 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	spin_lock(&vdev->vqs_list_lock);
 	list_add_tail(&vq->vq.list, &vdev->vqs);
 	spin_unlock(&vdev->vqs_list_lock);
-	return &vq->vq;
+	return 0;
 
 err_extra:
 	kfree(vq->split.desc_state);
 err_state:
-	kfree(vq);
-	return NULL;
+	return -ENOMEM;
+}
+
+struct virtqueue *__vring_new_virtqueue(unsigned int index,
+					struct vring vring,
+					struct virtio_device *vdev,
+					bool weak_barriers,
+					bool context,
+					bool (*notify)(struct virtqueue *),
+					void (*callback)(struct virtqueue *),
+					const char *name)
+{
+	struct vring_virtqueue *vq;
+	int err;
+
+	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
+		return NULL;
+
+	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
+	if (!vq)
+		return NULL;
+
+	err = __vring_init_virtqueue(&vq->vq, index, vring, vdev, weak_barriers,
+				     context, notify, callback, name);
+
+	if (err) {
+		kfree(vq);
+		return NULL;
+	}
+
+	return &vq->vq;
 }
 EXPORT_SYMBOL_GPL(__vring_new_virtqueue);
 
-- 
2.31.0

