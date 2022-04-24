Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF6A50CEA0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbiDXCot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 22:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237766AbiDXCoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:44:01 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B287582D01
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 19:41:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VAzpPKB_1650768057;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VAzpPKB_1650768057)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Apr 2022 10:40:58 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 15/16] virtio_ring: packed: resize support re-use buffers
Date:   Sun, 24 Apr 2022 10:40:43 +0800
Message-Id: <20220424024044.94749-16-xuanzhuo@linux.alibaba.com>
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

Packed vring resize supports reusing the original buffer.

The packed vring resize function implemented earlier uses the method
of letting the upper layer recycle all the buffers. This commit will
first try to re-put it to the new vring in the order submitted to the
old vring. The remaining buffers that cannot be submitted to the new
vring will be called the recycle callback to release.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 66f71e22ece0..730c8dded4c7 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -217,7 +217,6 @@ struct vring_virtqueue {
 };
 
 static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
-static void vring_free(struct virtqueue *_vq);
 
 /*
  * Helpers.
@@ -2357,11 +2356,13 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	return NULL;
 }
 
-static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
+static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num,
+				   void (*recycle)(struct virtqueue *vq, void *buf))
 {
-	struct vring_virtqueue_packed vring = {};
+	struct vring_virtqueue_packed vring = {}, vring_old = {};
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct virtio_device *vdev = _vq->vdev;
+	void *buf;
 	int err;
 
 	if (vring_alloc_queue_packed(&vring, vdev, num))
@@ -2371,17 +2372,28 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
 	if (err)
 		goto err_state_extra;
 
-	vring_free(&vq->vq);
+	vring_virtqueue_detach_packed(vq, &vring_old);
 
 	virtqueue_init(vq, vring.vring.num);
 	virtqueue_vring_attach_packed(vq, &vring);
 	virtqueue_vring_init_packed(vq);
 
+	vring_reuse_bufs_packed(vq, &vring_old, recycle);
+	vring_free_packed(&vring_old, vdev);
+
 	return 0;
 
 err_state_extra:
 	vring_free_packed(&vring, vdev);
 err_ring:
+	/*
+	 * In the case of failure to create vring, do not try to reuse the
+	 * original buffer. Because the probability of this situation is not
+	 * high, but we have to introduce new logic.
+	 */
+	while ((buf = virtqueue_detach_unused_buf(&vq->vq)))
+		recycle(&vq->vq, buf);
+
 	virtqueue_reinit_packed(vq);
 	return -ENOMEM;
 }
@@ -2914,7 +2926,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 		recycle(_vq, buf);
 
 	if (packed)
-		err = virtqueue_resize_packed(_vq, num);
+		err = virtqueue_resize_packed(_vq, num, recycle);
 	else
 		err = virtqueue_resize_split(_vq, num, recycle);
 
-- 
2.31.0

