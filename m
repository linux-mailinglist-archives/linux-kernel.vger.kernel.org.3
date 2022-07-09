Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B091756C5FC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 04:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiGIC23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 22:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiGIC21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 22:28:27 -0400
Received: from smtp236.sjtu.edu.cn (smtp236.sjtu.edu.cn [202.120.2.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E3C255
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 19:28:26 -0700 (PDT)
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp236.sjtu.edu.cn (Postfix) with ESMTPS id 40C141008B389;
        Sat,  9 Jul 2022 10:28:16 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id 79B272009BEC5;
        Sat,  9 Jul 2022 10:28:10 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9XYm2DB9fy6l; Sat,  9 Jul 2022 10:28:10 +0800 (CST)
Received: from localhost.localdomain (unknown [202.120.40.82])
        (Authenticated sender: qtxuning1999@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id B88C5200C91EC;
        Sat,  9 Jul 2022 10:28:03 +0800 (CST)
From:   Guo Zhi <qtxuning1999@sjtu.edu.cn>
To:     jasowang@redhat.com, mst@redhat.com
Cc:     eperezma@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, sgarzare@redhat.com,
        Guo Zhi <qtxuning1999@sjtu.edu.cn>
Subject: [PATCH v3 2/4] virtio_test: use random length scatterlists to test descriptor chain
Date:   Sat,  9 Jul 2022 10:27:43 +0800
Message-Id: <20220709022745.21020-3-qtxuning1999@sjtu.edu.cn>
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

Prior implementation only use one descriptor for each io event, which
does't test code of descriptor chain. More importantly, one descriptor
will not use indirect feature even indirect feature is specified. Use
random length scatterlists here to test descriptor chain.

Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
---
v3:
- drop fda270fcd virtio_test: move magic number in code as defined constant
---
 tools/virtio/virtio_test.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 95f78b311..1408a4a20 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -20,6 +20,7 @@
 #include "../../drivers/vhost/test.h"
 
 #define RANDOM_BATCH -1
+#define MAX_SG_FRAGS 8UL
 
 /* Unused */
 void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
@@ -169,7 +170,8 @@ static void wait_for_interrupt(struct vdev_info *dev)
 static void run_test(struct vdev_info *dev, struct vq_info *vq,
 		     bool delayed, int batch, int reset_n, int bufs)
 {
-	struct scatterlist sl;
+	struct scatterlist sg[MAX_SG_FRAGS];
+	int sg_size = 0;
 	long started = 0, completed = 0, next_reset = reset_n;
 	long completed_before, started_before;
 	int r, test = 1;
@@ -194,8 +196,11 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
 
 			while (started < bufs &&
 			       (started - completed) < batch) {
-				sg_init_one(&sl, dev->buf, dev->buf_size);
-				r = virtqueue_add_outbuf(vq->vq, &sl, 1,
+				sg_size = random() % (MAX_SG_FRAGS - 1) + 1;
+				sg_init_table(sg, sg_size);
+				for (int i = 0; i < sg_size; ++i)
+					sg_set_buf(&sg[i], dev->buf + i, 0x1);
+				r = virtqueue_add_outbuf(vq->vq, sg, sg_size,
 							 dev->buf + started,
 							 GFP_ATOMIC);
 				if (unlikely(r != 0)) {
-- 
2.17.1

