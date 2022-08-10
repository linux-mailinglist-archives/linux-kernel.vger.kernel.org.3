Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFFA58E913
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiHJIwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiHJIwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:52:11 -0400
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B176D9CB
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:52:07 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id FIL00000;
        Wed, 10 Aug 2022 16:52:00 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server id
 15.1.2507.9; Wed, 10 Aug 2022 16:51:59 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] virtio_vdpa: support the arg sizes of find_vqs()
Date:   Wed, 10 Aug 2022 04:51:51 -0400
Message-ID: <20220810085151.7251-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   2022810165200a2904457c40897507ce56f7870dfd6b2
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtio vdpa support the new parameter sizes of find_vqs().

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/virtio/virtio_vdpa.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 832d2c5b1b19..73b130f22c11 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -131,7 +131,7 @@ static irqreturn_t virtio_vdpa_virtqueue_cb(void *private)
 static struct virtqueue *
 virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 		     void (*callback)(struct virtqueue *vq),
-		     const char *name, bool ctx)
+		     const char *name, u32 size, bool ctx)
 {
 	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
@@ -167,15 +167,18 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 		err = -ENOENT;
 		goto error_new_virtqueue;
 	}
+
+	if (!size || size > max_num)
+		size = max_num;
 
 	if (ops->get_vq_num_min)
 		min_num = ops->get_vq_num_min(vdpa);
 
-	may_reduce_num = (max_num == min_num) ? false : true;
+	may_reduce_num = (size == min_num) ? false : true;
 
 	/* Create the vring */
 	align = ops->get_vq_align(vdpa);
-	vq = vring_create_virtqueue(index, max_num, align, vdev,
+	vq = vring_create_virtqueue(index, size, align, vdev,
 				    true, may_reduce_num, ctx,
 				    virtio_vdpa_notify, callback, name);
 	if (!vq) {
@@ -285,9 +288,9 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 			continue;
 		}
 
-		vqs[i] = virtio_vdpa_setup_vq(vdev, queue_idx++,
-					      callbacks[i], names[i], ctx ?
-					      ctx[i] : false);
+		vqs[i] = virtio_vdpa_setup_vq(vdev, queue_idx++, callbacks[i],
+						  names[i], sizes ? sizes[i] : 0,
+						  ctx ? ctx[i] : false);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto err_setup_vq;
-- 
2.27.0

