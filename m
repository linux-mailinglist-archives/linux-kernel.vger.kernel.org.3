Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCD84E5F83
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348636AbiCXHfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbiCXHfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:35:16 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4F633A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:33:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V83t1Bl_1648107221;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0V83t1Bl_1648107221)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Mar 2022 15:33:42 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH] virtio_ring: remove unnecessary to_vvq call in vring hot path
Date:   Thu, 24 Mar 2022 15:33:40 +0800
Message-Id: <20220324073340.632656-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It passes '_vq' to virtqueue_use_indirect(), which still calls
to_vvq to get 'vq', let's directly pass 'vq'. It can avoid
unnecessary call of to_vvq in hot path.

Other tiny optimization:
Add unlikely to "if (vq->vq.num_free < descs_used).

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 962f1477b1fa..ab6d5f0cb579 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -205,11 +205,9 @@ struct vring_virtqueue {
 
 #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
 
-static inline bool virtqueue_use_indirect(struct virtqueue *_vq,
+static inline bool virtqueue_use_indirect(struct vring_virtqueue *vq,
 					  unsigned int total_sg)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
-
 	/*
 	 * If the host supports indirect descriptor tables, and we have multiple
 	 * buffers, then go indirect. FIXME: tune this threshold
@@ -507,7 +505,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 
 	head = vq->free_head;
 
-	if (virtqueue_use_indirect(_vq, total_sg))
+	if (virtqueue_use_indirect(vq, total_sg))
 		desc = alloc_indirect_split(_vq, total_sg, gfp);
 	else {
 		desc = NULL;
@@ -527,7 +525,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		descs_used = total_sg;
 	}
 
-	if (vq->vq.num_free < descs_used) {
+	if (unlikely(vq->vq.num_free < descs_used)) {
 		pr_debug("Can't add buf len %i - avail = %i\n",
 			 descs_used, vq->vq.num_free);
 		/* FIXME: for historical reasons, we force a notify here if
@@ -1194,7 +1192,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 
 	BUG_ON(total_sg == 0);
 
-	if (virtqueue_use_indirect(_vq, total_sg)) {
+	if (virtqueue_use_indirect(vq, total_sg)) {
 		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
 						    in_sgs, data, gfp);
 		if (err != -ENOMEM) {
-- 
2.17.1

