Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9D850CE98
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbiDXCoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 22:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiDXCnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:43:53 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6F880201
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 19:40:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VAzcuZE_1650768050;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VAzcuZE_1650768050)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Apr 2022 10:40:51 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 07/16] virtio_ring: split: resize support re-use buffers
Date:   Sun, 24 Apr 2022 10:40:35 +0800
Message-Id: <20220424024044.94749-8-xuanzhuo@linux.alibaba.com>
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

Split vring resize supports reusing the original buffer.

The split vring resize function implemented earlier uses the method
of letting the upper layer recycle all the buffers. This commit will
first try to re-put it to the new vring in the order submitted to the
old vring. The remaining buffers that cannot be submitted to the new
vring will be called the recycle callback to release.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 02d4ffcc0a3b..fa4270e8c009 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1281,11 +1281,13 @@ static struct virtqueue *vring_create_virtqueue_split(
 	return vq;
 }
 
-static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
+static int virtqueue_resize_split(struct virtqueue *_vq, u32 num,
+				  void (*recycle)(struct virtqueue *vq, void *buf))
 {
+	struct vring_virtqueue_split vring = {}, vring_old = {};
 	struct vring_virtqueue *vq = to_vvq(_vq);
-	struct vring_virtqueue_split vring = {};
 	struct virtio_device *vdev = _vq->vdev;
+	void *buf;
 	int err;
 
 	err = vring_alloc_queue_split(&vring, vdev, num, vq->split.vring_align,
@@ -1299,15 +1301,26 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
 		goto err;
 	}
 
-	vring_free(&vq->vq);
+	virtqueue_vring_detach_split(vq, &vring_old);
 
 	virtqueue_init(vq, vring.vring.num);
 	virtqueue_vring_attach_split(vq, &vring);
 	virtqueue_vring_init_split(vq);
 
+	vring_reuse_bufs_split(vq, &vring_old, recycle);
+	vring_free_split(&vring_old, vdev);
+
 	return 0;
 
 err:
+	/*
+	 * In the case of failure to create vring, do not try to reuse the
+	 * original buffer. Because the probability of this situation is not
+	 * high, but we have to introduce new logic.
+	 */
+	while ((buf = virtqueue_detach_unused_buf(&vq->vq)))
+		recycle(&vq->vq, buf);
+
 	virtqueue_reinit_split(vq);
 	return -ENOMEM;
 }
@@ -2747,7 +2760,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 	if (packed)
 		err = virtqueue_resize_packed(_vq, num);
 	else
-		err = virtqueue_resize_split(_vq, num);
+		err = virtqueue_resize_split(_vq, num, recycle);
 
 	if (vdev->config->enable_reset_vq(_vq))
 		return -EBUSY;
-- 
2.31.0

