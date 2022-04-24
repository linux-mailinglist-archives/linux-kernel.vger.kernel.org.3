Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68B350CE95
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbiDXCoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 22:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237783AbiDXCn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:43:57 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CFF82D01
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 19:40:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VAzbmry_1650768053;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VAzbmry_1650768053)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Apr 2022 10:40:53 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 10/16] virtio_ring: packed: introduce vring_virtqueue_detach_packed()
Date:   Sun, 24 Apr 2022 10:40:38 +0800
Message-Id: <20220424024044.94749-11-xuanzhuo@linux.alibaba.com>
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

The function vring_virtqueue_detach_packed() is introduced to detach the
vring of the current vq.

Add two new members. last_used_idx is used to record the position where
the current vring desc is used, which can be used to obtain buffers from
the vring in order. Another num_left records how many buffers there are,
which can be used to check the recovery of buffers completed.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 436b18184dfe..219e008a4633 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -154,6 +154,10 @@ struct vring_virtqueue_packed {
 	dma_addr_t device_event_dma_addr;
 	size_t ring_size_in_bytes;
 	size_t event_size_in_bytes;
+
+	/* for vring detach */
+	u16 last_used_idx;
+	u32 num_left;
 };
 
 struct vring_virtqueue {
@@ -2090,6 +2094,25 @@ static int vring_alloc_state_extra_packed(struct vring_virtqueue_packed *vring)
 	return -ENOMEM;
 }
 
+static void vring_virtqueue_detach_packed(struct vring_virtqueue *vq,
+					  struct vring_virtqueue_packed *vring)
+{
+	vring->vring = vq->packed.vring;
+
+	vring->ring_dma_addr         = vq->packed.ring_dma_addr;
+	vring->driver_event_dma_addr = vq->packed.driver_event_dma_addr;
+	vring->device_event_dma_addr = vq->packed.device_event_dma_addr;
+
+	vring->ring_size_in_bytes    = vq->packed.ring_size_in_bytes;
+	vring->event_size_in_bytes   = vq->packed.event_size_in_bytes;
+
+	vring->desc_state = vq->packed.desc_state;
+	vring->desc_extra = vq->packed.desc_extra;
+
+	vring->last_used_idx = vq->last_used_idx;
+	vring->num_left = vq->packed.vring.num - vq->vq.num_free;
+}
+
 static void virtqueue_vring_attach_packed(struct vring_virtqueue *vq,
 					  struct vring_virtqueue_packed *vring)
 {
-- 
2.31.0

