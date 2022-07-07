Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E300B569866
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 04:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbiGGCzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 22:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbiGGCzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 22:55:19 -0400
X-Greylist: delayed 653 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Jul 2022 19:55:17 PDT
Received: from smtp236.sjtu.edu.cn (smtp236.sjtu.edu.cn [202.120.2.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CB82ED6B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 19:55:17 -0700 (PDT)
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp236.sjtu.edu.cn (Postfix) with ESMTPS id 13BF41008B392;
        Thu,  7 Jul 2022 10:44:57 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id 35268200C91EC;
        Thu,  7 Jul 2022 10:44:57 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Tnu6H11dLAu7; Thu,  7 Jul 2022 10:44:57 +0800 (CST)
Received: from localhost.localdomain (unknown [202.120.40.82])
        (Authenticated sender: qtxuning1999@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id 474E4200A4ED3;
        Thu,  7 Jul 2022 10:44:49 +0800 (CST)
From:   Guo Zhi <qtxuning1999@sjtu.edu.cn>
To:     jasowang@redhat.com, mst@redhat.com
Cc:     eperezma@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, sgarzare@redhat.com,
        Guo Zhi <qtxuning1999@sjtu.edu.cn>
Subject: [PATCH v2 4/4] virtio_test: enable indirection feature
Date:   Thu,  7 Jul 2022 10:44:09 +0800
Message-Id: <20220707024409.1869-5-qtxuning1999@sjtu.edu.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220707024409.1869-1-qtxuning1999@sjtu.edu.cn>
References: <20220707024409.1869-1-qtxuning1999@sjtu.edu.cn>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior implementation don't use indirection feature because there is only
one descriptor for every io event, actually prior implementation don't
support indirection because vhost can't translate and find the indirect
descriptors. This commit enable virtio_test malloc indirect descriptors
in a indirect buffer and map this buffer to vhost, thus resolve this
problem.

Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
---
 tools/virtio/virtio_test.c | 50 ++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 363695b33..dca408a5c 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -25,7 +25,7 @@
 #define RINGSIZE   256
 #define TEST_BUF_NUM 0x100000
 #define BUF_SIZE   1024
-/* Unused */
+#define INDIRECTS_SIZE   (RINGSIZE * sizeof(struct vring_desc) * 8)
 void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
 
 struct vq_info {
@@ -47,6 +47,8 @@ struct vdev_info {
 	int nvqs;
 	void *buf;
 	size_t buf_size;
+	void *indirects;
+	size_t indirects_size;
 	struct vhost_memory *mem;
 };
 
@@ -131,6 +133,8 @@ static void vq_info_add(struct vdev_info *dev, int num)
 static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
 {
 	int r;
+	int nregions = 2;
+
 	memset(dev, 0, sizeof *dev);
 	dev->vdev.features = features;
 	INIT_LIST_HEAD(&dev->vdev.vqs);
@@ -138,19 +142,25 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
 	dev->buf_size = BUF_SIZE;
 	dev->buf = malloc(dev->buf_size);
 	assert(dev->buf);
-        dev->control = open("/dev/vhost-test", O_RDWR);
+	dev->indirects_size = INDIRECTS_SIZE;
+	dev->indirects = malloc(dev->indirects_size);
+	assert(dev->indirects);
+	dev->control = open("/dev/vhost-test", O_RDWR);
 	assert(dev->control >= 0);
 	r = ioctl(dev->control, VHOST_SET_OWNER, NULL);
 	assert(r >= 0);
 	dev->mem = malloc(offsetof(struct vhost_memory, regions) +
-			  sizeof dev->mem->regions[0]);
+			(sizeof(dev->mem->regions[0])) * nregions);
 	assert(dev->mem);
 	memset(dev->mem, 0, offsetof(struct vhost_memory, regions) +
-                          sizeof dev->mem->regions[0]);
-	dev->mem->nregions = 1;
+			(sizeof(dev->mem->regions[0])) * nregions);
+	dev->mem->nregions = nregions;
 	dev->mem->regions[0].guest_phys_addr = (long)dev->buf;
 	dev->mem->regions[0].userspace_addr = (long)dev->buf;
 	dev->mem->regions[0].memory_size = dev->buf_size;
+	dev->mem->regions[1].guest_phys_addr = (long)dev->indirects;
+	dev->mem->regions[1].userspace_addr = (long)dev->indirects;
+	dev->mem->regions[1].memory_size = dev->indirects_size;
 	r = ioctl(dev->control, VHOST_SET_MEM_TABLE, dev->mem);
 	assert(r >= 0);
 }
@@ -170,6 +180,19 @@ static void wait_for_interrupt(struct vdev_info *dev)
 		}
 }
 
+static int test_virtqueue_add_outbuf(struct virtqueue *vq,
+				     struct scatterlist *sg, unsigned int num,
+				     void *data, void *indirects)
+{
+	int r;
+
+	__kmalloc_fake = indirects;
+	r = virtqueue_add_outbuf(vq, sg, num, data,
+				 GFP_ATOMIC);
+	__kmalloc_fake = NULL;
+	return r;
+}
+
 static void run_test(struct vdev_info *dev, struct vq_info *vq,
 		     bool delayed, int batch, int reset_n, int bufs)
 {
@@ -181,6 +204,7 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
 	unsigned len;
 	long long spurious = 0;
 	const bool random_batch = batch == RANDOM_BATCH;
+	void *indirects;
 
 	r = ioctl(dev->control, VHOST_TEST_RUN, &test);
 	assert(r >= 0);
@@ -188,10 +212,15 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
 		next_reset = INT_MAX;
 	}
 
+	/* Don't kfree indirects. */
+	__kfree_ignore_start = dev->indirects;
+	__kfree_ignore_end = dev->indirects + dev->indirects_size;
+
 	for (;;) {
 		virtqueue_disable_cb(vq->vq);
 		completed_before = completed;
 		started_before = started;
+		indirects = dev->indirects;
 		do {
 			const bool reset = completed > next_reset;
 			if (random_batch)
@@ -203,9 +232,13 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
 				sg_init_table(sg, sg_size);
 				for (int i = 0; i < sg_size; ++i)
 					sg_set_buf(&sg[i], dev->buf + i, 0x1);
-				r = virtqueue_add_outbuf(vq->vq, sg, sg_size,
-							 dev->buf + started,
-							 GFP_ATOMIC);
+
+				// use indirects buffer repeatedly
+				if (indirects + sg_size * sizeof(struct vring_desc) >
+						dev->indirects + dev->indirects_size)
+					indirects = dev->indirects;
+				r = test_virtqueue_add_outbuf(vq->vq, sg, sg_size,
+							      dev->buf + started, indirects);
 				if (unlikely(r != 0)) {
 					if (r == -ENOSPC &&
 					    started > started_before)
@@ -216,6 +249,7 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
 				}
 
 				++started;
+				indirects += sg_size * sizeof(struct vring_desc);
 			}
 			if (unlikely(!virtqueue_kick(vq->vq))) {
 				r = -1;
-- 
2.17.1

