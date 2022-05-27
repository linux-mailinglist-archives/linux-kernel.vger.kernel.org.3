Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD57E535903
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243896AbiE0GCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244386AbiE0GCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:02:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D33CF2BE6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653631349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=txm7DjcKuANfsEZ3GBtdkhzXAQmx0UitZyi9sP1Io7U=;
        b=V3dRNeiDSs4JIDa4nggnIWH3cwANct2Bd2zf8zLdQ7fzl8AHkqkVewN8RXwJMWgm0hye3Q
        GBad+LRmZUKDEtvx1tPwFSiakenQWasXL53CtbnWg/+GQUZZ79R6a3LIWkN+DE93AVv8mw
        WqgKexiVJc5v9aqvkJ/kn79vnb7Dv+Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-546-7bDIP2W9Nq-RFigjdhVmww-1; Fri, 27 May 2022 02:02:26 -0400
X-MC-Unique: 7bDIP2W9Nq-RFigjdhVmww-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA90E858F0C;
        Fri, 27 May 2022 06:02:25 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-240.pek2.redhat.com [10.72.13.240])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 138CF2166B2F;
        Fri, 27 May 2022 06:02:18 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, paulmck@kernel.org,
        maz@kernel.org, pasic@linux.ibm.com, cohuck@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, sgarzare@redhat.com,
        xuanzhuo@linux.alibaba.com,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH V6 6/9] virtio-ccw: implement synchronize_cbs()
Date:   Fri, 27 May 2022 14:01:17 +0800
Message-Id: <20220527060120.20964-7-jasowang@redhat.com>
In-Reply-To: <20220527060120.20964-1-jasowang@redhat.com>
References: <20220527060120.20964-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tries to implement the synchronize_cbs() for ccw. For the
vring_interrupt() that is called via virtio_airq_handler(), the
synchronization is simply done via the airq_info's lock. For the
vring_interrupt() that is called via virtio_ccw_int_handler(), a per
device rwlock is introduced and used in the synchronization method.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/s390/virtio/virtio_ccw.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index d35e7a3f7067..c188e4f20ca3 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -62,6 +62,7 @@ struct virtio_ccw_device {
 	unsigned int revision; /* Transport revision */
 	wait_queue_head_t wait_q;
 	spinlock_t lock;
+	rwlock_t irq_lock;
 	struct mutex io_lock; /* Serializes I/O requests */
 	struct list_head virtqueues;
 	bool is_thinint;
@@ -984,6 +985,30 @@ static const char *virtio_ccw_bus_name(struct virtio_device *vdev)
 	return dev_name(&vcdev->cdev->dev);
 }
 
+static void virtio_ccw_synchronize_cbs(struct virtio_device *vdev)
+{
+	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
+	struct airq_info *info = vcdev->airq_info;
+
+	if (info) {
+		/*
+		 * This device uses adapter interrupts: synchronize with
+		 * vring_interrupt() called by virtio_airq_handler()
+		 * via the indicator area lock.
+		 */
+		write_lock_irq(&info->lock);
+		write_unlock_irq(&info->lock);
+	} else {
+		/* This device uses classic interrupts: synchronize
+		 * with vring_interrupt() called by
+		 * virtio_ccw_int_handler() via the per-device
+		 * irq_lock
+		 */
+		write_lock_irq(&vcdev->irq_lock);
+		write_unlock_irq(&vcdev->irq_lock);
+	}
+}
+
 static const struct virtio_config_ops virtio_ccw_config_ops = {
 	.get_features = virtio_ccw_get_features,
 	.finalize_features = virtio_ccw_finalize_features,
@@ -995,6 +1020,7 @@ static const struct virtio_config_ops virtio_ccw_config_ops = {
 	.find_vqs = virtio_ccw_find_vqs,
 	.del_vqs = virtio_ccw_del_vqs,
 	.bus_name = virtio_ccw_bus_name,
+	.synchronize_cbs = virtio_ccw_synchronize_cbs,
 };
 
 
@@ -1106,6 +1132,8 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
 			vcdev->err = -EIO;
 	}
 	virtio_ccw_check_activity(vcdev, activity);
+	/* Interrupts are disabled here */
+	read_lock(&vcdev->irq_lock);
 	for_each_set_bit(i, indicators(vcdev),
 			 sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
 		/* The bit clear must happen before the vring kick. */
@@ -1114,6 +1142,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
 		vq = virtio_ccw_vq_by_ind(vcdev, i);
 		vring_interrupt(0, vq);
 	}
+	read_unlock(&vcdev->irq_lock);
 	if (test_bit(0, indicators2(vcdev))) {
 		virtio_config_changed(&vcdev->vdev);
 		clear_bit(0, indicators2(vcdev));
@@ -1284,6 +1313,7 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 	init_waitqueue_head(&vcdev->wait_q);
 	INIT_LIST_HEAD(&vcdev->virtqueues);
 	spin_lock_init(&vcdev->lock);
+	rwlock_init(&vcdev->irq_lock);
 	mutex_init(&vcdev->io_lock);
 
 	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
-- 
2.25.1

