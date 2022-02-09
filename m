Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BE64AF1A7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbiBIM3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbiBIM3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:29:10 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4FFC05CB96
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 04:29:13 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V4.8o04_1644409748;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0V4.8o04_1644409748)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Feb 2022 20:29:09 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v4 09/14] virtio: queue_reset: struct virtio_config_ops add callbacks for queue_reset
Date:   Wed,  9 Feb 2022 20:28:56 +0800
Message-Id: <20220209122901.51790-10-xuanzhuo@linux.alibaba.com>
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

Performing reset on a queue is divided into four steps:

1. reset_vq: reset one vq
2. recycle the buffer from vq by virtqueue_detach_unused_buf()
3. release the ring of the vq by vring_release_virtqueue()
4. enable_reset_vq: re-enable the reset queue

So add two callbacks reset_vq, enable_reset_vq to struct
virtio_config_ops.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/linux/virtio_config.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 4d107ad31149..0d01a64f2576 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -74,6 +74,17 @@ struct virtio_shm_region {
  * @set_vq_affinity: set the affinity for a virtqueue (optional).
  * @get_vq_affinity: get the affinity for a virtqueue (optional).
  * @get_shm_region: get a shared memory region based on the index.
+ * @reset_vq: reset a queue individually
+ *	vq: the virtqueue
+ *	Returns 0 on success or error status
+ *	After successfully calling this, be sure to call
+ *	virtqueue_detach_unused_buf() to recycle the buffer in the ring, and
+ *	then call vring_release_virtqueue() to release the vq ring.
+ * @enable_reset_vq: enable a reset queue
+ *	vq: the virtqueue
+ *	ring_num: specify ring num for the vq to be re-enabled. 0 means use the
+ *	          default value. MUST be a power of 2.
+ *	Returns 0 on success or error status
  */
 typedef void vq_callback_t(struct virtqueue *);
 struct virtio_config_ops {
@@ -100,6 +111,8 @@ struct virtio_config_ops {
 			int index);
 	bool (*get_shm_region)(struct virtio_device *vdev,
 			       struct virtio_shm_region *region, u8 id);
+	int (*reset_vq)(struct virtqueue *vq);
+	int (*enable_reset_vq)(struct virtqueue *vq, u16 ring_num);
 };
 
 /* If driver didn't advertise the feature, it will never appear. */
-- 
2.31.0

