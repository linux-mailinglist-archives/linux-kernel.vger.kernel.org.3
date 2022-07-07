Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C76569867
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 04:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbiGGCzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 22:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbiGGCzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 22:55:31 -0400
Received: from smtp236.sjtu.edu.cn (smtp236.sjtu.edu.cn [202.120.2.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036612E9FE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 19:55:30 -0700 (PDT)
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp236.sjtu.edu.cn (Postfix) with ESMTPS id 8A4131008B388;
        Thu,  7 Jul 2022 10:44:39 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id 6F06F200A5BFF;
        Thu,  7 Jul 2022 10:44:39 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id e5TwBO-loqPR; Thu,  7 Jul 2022 10:44:39 +0800 (CST)
Received: from localhost.localdomain (unknown [202.120.40.82])
        (Authenticated sender: qtxuning1999@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id 464792009BEA0;
        Thu,  7 Jul 2022 10:44:30 +0800 (CST)
From:   Guo Zhi <qtxuning1999@sjtu.edu.cn>
To:     jasowang@redhat.com, mst@redhat.com
Cc:     eperezma@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, sgarzare@redhat.com,
        Guo Zhi <qtxuning1999@sjtu.edu.cn>
Subject: [PATCH v2 2/4] virtio_test: move magic number in code as defined constant
Date:   Thu,  7 Jul 2022 10:44:07 +0800
Message-Id: <20220707024409.1869-3-qtxuning1999@sjtu.edu.cn>
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

We should avoid using magic numbers directly.

Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
---
 tools/virtio/virtio_test.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 95f78b311..1ecd64271 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -20,7 +20,10 @@
 #include "../../drivers/vhost/test.h"
 
 #define RANDOM_BATCH -1
-
+#define ALIGN 4096
+#define RINGSIZE   256
+#define TEST_BUF_NUM 0x100000
+#define BUF_SIZE   1024
 /* Unused */
 void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
 
@@ -100,8 +103,8 @@ static void vq_reset(struct vq_info *info, int num, struct virtio_device *vdev)
 	if (info->vq)
 		vring_del_virtqueue(info->vq);
 
-	memset(info->ring, 0, vring_size(num, 4096));
-	vring_init(&info->vring, num, info->ring, 4096);
+	memset(info->ring, 0, vring_size(num, ALIGN));
+	vring_init(&info->vring, num, info->ring, ALIGN);
 	info->vq = __vring_new_virtqueue(info->idx, info->vring, vdev, true,
 					 false, vq_notify, vq_callback, "test");
 	assert(info->vq);
@@ -115,7 +118,7 @@ static void vq_info_add(struct vdev_info *dev, int num)
 	info->idx = dev->nvqs;
 	info->kick = eventfd(0, EFD_NONBLOCK);
 	info->call = eventfd(0, EFD_NONBLOCK);
-	r = posix_memalign(&info->ring, 4096, vring_size(num, 4096));
+	r = posix_memalign(&info->ring, PAGE_SIZE, vring_size(num, ALIGN));
 	assert(r >= 0);
 	vq_reset(info, num, &dev->vdev);
 	vhost_vq_setup(dev, info);
@@ -131,7 +134,7 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
 	dev->vdev.features = features;
 	INIT_LIST_HEAD(&dev->vdev.vqs);
 	spin_lock_init(&dev->vdev.vqs_list_lock);
-	dev->buf_size = 1024;
+	dev->buf_size = BUF_SIZE;
 	dev->buf = malloc(dev->buf_size);
 	assert(dev->buf);
         dev->control = open("/dev/vhost-test", O_RDWR);
@@ -396,7 +399,8 @@ int main(int argc, char **argv)
 
 done:
 	vdev_info_init(&dev, features);
-	vq_info_add(&dev, 256);
-	run_test(&dev, &dev.vqs[0], delayed, batch, reset, 0x100000);
+	vq_info_add(&dev, RINGSIZE);
+
+	run_test(&dev, &dev.vqs[0], delayed, batch, reset, TEST_BUF_NUM);
 	return 0;
 }
-- 
2.17.1

