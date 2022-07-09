Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5608F56C5FE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 04:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiGIC2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 22:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiGIC2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 22:28:53 -0400
Received: from smtp236.sjtu.edu.cn (smtp236.sjtu.edu.cn [202.120.2.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8025DF3E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 19:28:51 -0700 (PDT)
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp236.sjtu.edu.cn (Postfix) with ESMTPS id 871231008B38A;
        Sat,  9 Jul 2022 10:28:27 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id 725FE2009BEA0;
        Sat,  9 Jul 2022 10:28:27 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sZRFSb9s3H5X; Sat,  9 Jul 2022 10:28:27 +0800 (CST)
Received: from localhost.localdomain (unknown [202.120.40.82])
        (Authenticated sender: qtxuning1999@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id 73ED92009BEAF;
        Sat,  9 Jul 2022 10:28:18 +0800 (CST)
From:   Guo Zhi <qtxuning1999@sjtu.edu.cn>
To:     jasowang@redhat.com, mst@redhat.com
Cc:     eperezma@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, sgarzare@redhat.com,
        Guo Zhi <qtxuning1999@sjtu.edu.cn>
Subject: [PATCH v3 4/4] virtio_test: pregenerate random numbers
Date:   Sat,  9 Jul 2022 10:27:45 +0800
Message-Id: <20220709022745.21020-5-qtxuning1999@sjtu.edu.cn>
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

random numbers on data path is expensive, using a rand pool to
pregenerate them before tests start

Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
---
 tools/virtio/virtio_test.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 8f3ef3a78..7cc43e5bf 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -23,6 +23,7 @@
 #define MAX_SG_FRAGS 8UL
 #define RINGSIZE   256
 #define INDIRECT_TABLE_SIZE   (RINGSIZE * sizeof(struct vring_desc) * 8)
+#define RAND_POOL_SIZE 4096
 
 void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
 
@@ -199,6 +200,8 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
 {
 	struct scatterlist sg[MAX_SG_FRAGS];
 	int sg_size = 0;
+	int rand_pool[RAND_POOL_SIZE];
+	unsigned int rand_idx;
 	long started = 0, completed = 0, next_reset = reset_n;
 	long completed_before, started_before;
 	int r, test = 1;
@@ -213,6 +216,10 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
 		next_reset = INT_MAX;
 	}
 
+	/* Init rand pool */
+	for (rand_idx = 0; rand_idx < RAND_POOL_SIZE; ++rand_idx)
+		rand_pool[rand_idx] = random();
+
 	/* Don't kfree indirect_table. */
 	__kfree_ignore_start = dev->indirect_table;
 	__kfree_ignore_end = dev->indirect_table + dev->indirect_table_size;
@@ -225,11 +232,13 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
 		do {
 			const bool reset = completed > next_reset;
 			if (random_batch)
-				batch = (random() % vq->vring.num) + 1;
+				batch = (rand_pool[rand_idx++ % RAND_POOL_SIZE]
+						% vq->vring.num) + 1;
 
 			while (started < bufs &&
 			       (started - completed) < batch) {
-				sg_size = random() % (MAX_SG_FRAGS - 1) + 1;
+				sg_size = (rand_pool[rand_idx++ % RAND_POOL_SIZE]
+						% (MAX_SG_FRAGS - 1)) + 1;
 				sg_init_table(sg, sg_size);
 				for (int i = 0; i < sg_size; ++i)
 					sg_set_buf(&sg[i], dev->buf + i, 0x1);
-- 
2.17.1

