Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAB456C5FD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 04:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiGIC2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 22:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiGIC2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 22:28:40 -0400
Received: from smtp236.sjtu.edu.cn (smtp236.sjtu.edu.cn [202.120.2.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA1818E0B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 19:28:38 -0700 (PDT)
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp236.sjtu.edu.cn (Postfix) with ESMTPS id B1AC51008B388;
        Sat,  9 Jul 2022 10:28:23 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id 6E1A32009BEB2;
        Sat,  9 Jul 2022 10:28:18 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nVtFykjv01sq; Sat,  9 Jul 2022 10:28:18 +0800 (CST)
Received: from localhost.localdomain (unknown [202.120.40.82])
        (Authenticated sender: qtxuning1999@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id 415902009BEAF;
        Sat,  9 Jul 2022 10:28:10 +0800 (CST)
From:   Guo Zhi <qtxuning1999@sjtu.edu.cn>
To:     jasowang@redhat.com, mst@redhat.com
Cc:     eperezma@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, sgarzare@redhat.com,
        Guo Zhi <qtxuning1999@sjtu.edu.cn>
Subject: [PATCH v3 3/4] virtio_test: enable indirection feature
Date:   Sat,  9 Jul 2022 10:27:44 +0800
Message-Id: <20220709022745.21020-4-qtxuning1999@sjtu.edu.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220709022745.21020-1-qtxuning1999@sjtu.edu.cn>
References: <20220709022745.21020-1-qtxuning1999@sjtu.edu.cn>
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
v3:
- use C style comment
- changed INDIRECT_TABLE name
- add comment for __kmalloc_fake
---
 tools/virtio/virtio_test.c | 56 ++++++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 9 deletions(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 1408a4a20..8f3ef3a78 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -21,8 +21,9 @@
 
 #define RANDOM_BATCH -1
 #define MAX_SG_FRAGS 8UL
+#define RINGSIZE   256
+#define INDIRECT_TABLE_SIZE   (RINGSIZE * sizeof(struct vring_desc) * 8)
 
-/* Unused */
 void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
 
 struct vq_info {
@@ -44,6 +45,8 @@ struct vdev_info {
 	int nvqs;
 	void *buf;
 	size_t buf_size;
+	void *indirect_table;
+	size_t indirect_table_size;
 	struct vhost_memory *mem;
 };
 
@@ -128,6 +131,8 @@ static void vq_info_add(struct vdev_info *dev, int num)
 static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
 {
 	int r;
+	int nregions = 2;
+
 	memset(dev, 0, sizeof *dev);
 	dev->vdev.features = features;
 	INIT_LIST_HEAD(&dev->vdev.vqs);
@@ -135,19 +140,25 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
 	dev->buf_size = 1024;
 	dev->buf = malloc(dev->buf_size);
 	assert(dev->buf);
-        dev->control = open("/dev/vhost-test", O_RDWR);
+	dev->indirect_table_size = INDIRECT_TABLE_SIZE;
+	dev->indirect_table = malloc(dev->indirect_table_size);
+	assert(dev->indirect_table);
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
+	dev->mem->regions[1].guest_phys_addr = (long)dev->indirect_table;
+	dev->mem->regions[1].userspace_addr = (long)dev->indirect_table;
+	dev->mem->regions[1].memory_size = dev->indirect_table_size;
 	r = ioctl(dev->control, VHOST_SET_MEM_TABLE, dev->mem);
 	assert(r >= 0);
 }
@@ -167,6 +178,22 @@ static void wait_for_interrupt(struct vdev_info *dev)
 		}
 }
 
+static int test_virtqueue_add_outbuf(struct virtqueue *vq,
+				     struct scatterlist *sg, unsigned int num,
+				     void *data, void *indirect_table)
+{
+	int r;
+
+	/* Allocate an indirect, force it to allocate user addr
+	 * exists in vhost iotlb, otherwise vhost can't access
+	 */
+	__kmalloc_fake = indirect_table;
+	r = virtqueue_add_outbuf(vq, sg, num, data,
+				 GFP_ATOMIC);
+	__kmalloc_fake = NULL;
+	return r;
+}
+
 static void run_test(struct vdev_info *dev, struct vq_info *vq,
 		     bool delayed, int batch, int reset_n, int bufs)
 {
@@ -178,6 +205,7 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
 	unsigned len;
 	long long spurious = 0;
 	const bool random_batch = batch == RANDOM_BATCH;
+	void *indirect_table;
 
 	r = ioctl(dev->control, VHOST_TEST_RUN, &test);
 	assert(r >= 0);
@@ -185,10 +213,15 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
 		next_reset = INT_MAX;
 	}
 
+	/* Don't kfree indirect_table. */
+	__kfree_ignore_start = dev->indirect_table;
+	__kfree_ignore_end = dev->indirect_table + dev->indirect_table_size;
+
 	for (;;) {
 		virtqueue_disable_cb(vq->vq);
 		completed_before = completed;
 		started_before = started;
+		indirect_table = dev->indirect_table;
 		do {
 			const bool reset = completed > next_reset;
 			if (random_batch)
@@ -200,9 +233,13 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
 				sg_init_table(sg, sg_size);
 				for (int i = 0; i < sg_size; ++i)
 					sg_set_buf(&sg[i], dev->buf + i, 0x1);
-				r = virtqueue_add_outbuf(vq->vq, sg, sg_size,
-							 dev->buf + started,
-							 GFP_ATOMIC);
+
+				/* use indirect_table buffer repeatedly */
+				if (indirect_table + sg_size * sizeof(struct vring_desc) >
+						dev->indirect_table + dev->indirect_table_size)
+					indirect_table = dev->indirect_table;
+				r = test_virtqueue_add_outbuf(vq->vq, sg, sg_size,
+							      dev->buf + started, indirect_table);
 				if (unlikely(r != 0)) {
 					if (r == -ENOSPC &&
 					    started > started_before)
@@ -213,6 +250,7 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
 				}
 
 				++started;
+				indirect_table += sg_size * sizeof(struct vring_desc);
 			}
 			if (unlikely(!virtqueue_kick(vq->vq))) {
 				r = -1;
@@ -401,7 +439,7 @@ int main(int argc, char **argv)
 
 done:
 	vdev_info_init(&dev, features);
-	vq_info_add(&dev, 256);
+	vq_info_add(&dev, RINGSIZE);
 	run_test(&dev, &dev.vqs[0], delayed, batch, reset, 0x100000);
 	return 0;
 }
-- 
2.17.1

