Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D8050D723
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 04:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240454AbiDYCtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 22:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240460AbiDYCs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 22:48:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBD4568F8C
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 19:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650854735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+al2fiXXU0vjk8q/5nG8AAQak1KF6qUR+2F8mIs7uXQ=;
        b=EzRKh9neQSlQA+2j8ESQezyKdaWYsjP7SNu2neEKnwnAlkdQO0J3VLqSt0cCnnSTtdViyB
        BT74yjYQLybTr0vt7QMZzbgFkqJy75kGjKHlo19nMlzsIVGhAaraYVUe3bbGo3u0Tf7vQi
        idb5osopQR7yUMfl9zXY5yifZsocsU0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-dWRY6sgtNhmAPXKr45H4Cw-1; Sun, 24 Apr 2022 22:45:32 -0400
X-MC-Unique: dWRY6sgtNhmAPXKr45H4Cw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94669803D65;
        Mon, 25 Apr 2022 02:45:31 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-160.pek2.redhat.com [10.72.13.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 650389E75;
        Mon, 25 Apr 2022 02:45:18 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     jasowang@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     sgarzare@redhat.com, eperezma@redhat.com, lulu@redhat.com,
        tglx@linutronix.de, peterz@infradead.org, paulmck@kernel.org,
        maz@kernel.org, pasic@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Date:   Mon, 25 Apr 2022 10:44:15 +0800
Message-Id: <20220425024418.8415-7-jasowang@redhat.com>
In-Reply-To: <20220425024418.8415-1-jasowang@redhat.com>
References: <20220425024418.8415-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tries to implement the synchronize_cbs() for ccw. For the
vring_interrupt() that is called via virtio_airq_handler(), the
synchronization is simply done via the airq_info's lock. For the
vring_interrupt() that is called via virtio_ccw_int_handler(), a per
device spinlock for irq is introduced ans used in the synchronization
method.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/s390/virtio/virtio_ccw.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index d35e7a3f7067..c19f07a82d62 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -62,6 +62,7 @@ struct virtio_ccw_device {
 	unsigned int revision; /* Transport revision */
 	wait_queue_head_t wait_q;
 	spinlock_t lock;
+	spinlock_t irq_lock;
 	struct mutex io_lock; /* Serializes I/O requests */
 	struct list_head virtqueues;
 	bool is_thinint;
@@ -984,6 +985,27 @@ static const char *virtio_ccw_bus_name(struct virtio_device *vdev)
 	return dev_name(&vcdev->cdev->dev);
 }
 
+static void virtio_ccw_synchronize_cbs(struct virtio_device *vdev)
+{
+	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
+	struct airq_info *info = vcdev->airq_info;
+
+	/*
+	 * Synchronize with the vring_interrupt() called by
+	 * virtio_ccw_int_handler().
+	 */
+	spin_lock(&vcdev->irq_lock);
+	spin_unlock(&vcdev->irq_lock);
+
+	if (info) {
+		/*
+		 * Synchronize with the vring_interrupt() with airq indicator
+		 */
+		write_lock(&info->lock);
+		write_unlock(&info->lock);
+	}
+}
+
 static const struct virtio_config_ops virtio_ccw_config_ops = {
 	.get_features = virtio_ccw_get_features,
 	.finalize_features = virtio_ccw_finalize_features,
@@ -995,6 +1017,7 @@ static const struct virtio_config_ops virtio_ccw_config_ops = {
 	.find_vqs = virtio_ccw_find_vqs,
 	.del_vqs = virtio_ccw_del_vqs,
 	.bus_name = virtio_ccw_bus_name,
+	.synchronize_cbs = virtio_ccw_synchronize_cbs,
 };
 
 
@@ -1079,6 +1102,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
 {
 	__u32 activity = intparm & VIRTIO_CCW_INTPARM_MASK;
 	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
+	unsigned long flags;
 	int i;
 	struct virtqueue *vq;
 
@@ -1106,6 +1130,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
 			vcdev->err = -EIO;
 	}
 	virtio_ccw_check_activity(vcdev, activity);
+	spin_lock_irqsave(&vcdev->irq_lock, flags);
 	for_each_set_bit(i, indicators(vcdev),
 			 sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
 		/* The bit clear must happen before the vring kick. */
@@ -1114,6 +1139,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
 		vq = virtio_ccw_vq_by_ind(vcdev, i);
 		vring_interrupt(0, vq);
 	}
+	spin_unlock_irqrestore(&vcdev->irq_lock, flags);
 	if (test_bit(0, indicators2(vcdev))) {
 		virtio_config_changed(&vcdev->vdev);
 		clear_bit(0, indicators2(vcdev));
@@ -1284,6 +1310,7 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 	init_waitqueue_head(&vcdev->wait_q);
 	INIT_LIST_HEAD(&vcdev->virtqueues);
 	spin_lock_init(&vcdev->lock);
+	spin_lock_init(&vcdev->irq_lock);
 	mutex_init(&vcdev->io_lock);
 
 	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
-- 
2.25.1

