Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8038D535902
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244303AbiE0GCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244014AbiE0GCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:02:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C199A25C6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653631318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OVF7ZOKQjlZaNtrOn5007e/TWK4CcFV8q+LPrrFaKRw=;
        b=SxbdWtSj0EdOOQSKHxUhotr7qMArGJDJJN77SIycB6V19zuHutbl4cPILkIRDQKOXFI7SM
        syARxJ/T8LCurzOyVSd0uQHtb6Q90QGy2+G6lHqNbkLw+4DGbuNtboZGglyzhIhICHee0O
        9Ywhx0+yYfut9RsaxlPWRns6VRtvo/4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-gElugDpbOLqiMMZF789AsA-1; Fri, 27 May 2022 02:01:57 -0400
X-MC-Unique: gElugDpbOLqiMMZF789AsA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80D05382ECD2;
        Fri, 27 May 2022 06:01:56 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-240.pek2.redhat.com [10.72.13.240])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7CD52166B26;
        Fri, 27 May 2022 06:01:49 +0000 (UTC)
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
Subject: [PATCH V6 3/9] virtio: introduce config op to synchronize vring callbacks
Date:   Fri, 27 May 2022 14:01:14 +0800
Message-Id: <20220527060120.20964-4-jasowang@redhat.com>
In-Reply-To: <20220527060120.20964-1-jasowang@redhat.com>
References: <20220527060120.20964-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces new virtio config op to vring
callbacks. Transport specific method is required to make sure the
write before this function is visible to the vring_interrupt() that is
called after the return of this function. For the transport that
doesn't provide synchronize_vqs(), use synchornize_rcu() which
synchronize with IRQ implicitly as a fallback.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/virtio_config.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index b341dd62aa4d..25be018810a7 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -57,6 +57,11 @@ struct virtio_shm_region {
  *		include a NULL entry for vqs unused by driver
  *	Returns 0 on success or error status
  * @del_vqs: free virtqueues found by find_vqs().
+ * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
+ *      The function guarantees that all memory operations on the
+ *      queue before it are visible to the vring_interrupt() that is
+ *      called after it.
+ *      vdev: the virtio_device
  * @get_features: get the array of feature bits for this device.
  *	vdev: the virtio_device
  *	Returns the first 64 feature bits (all we currently need).
@@ -89,6 +94,7 @@ struct virtio_config_ops {
 			const char * const names[], const bool *ctx,
 			struct irq_affinity *desc);
 	void (*del_vqs)(struct virtio_device *);
+	void (*synchronize_cbs)(struct virtio_device *);
 	u64 (*get_features)(struct virtio_device *vdev);
 	int (*finalize_features)(struct virtio_device *vdev);
 	const char *(*bus_name)(struct virtio_device *vdev);
@@ -217,6 +223,25 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
 				      desc);
 }
 
+/**
+ * virtio_synchronize_cbs - synchronize with virtqueue callbacks
+ * @vdev: the device
+ */
+static inline
+void virtio_synchronize_cbs(struct virtio_device *dev)
+{
+	if (dev->config->synchronize_cbs) {
+		dev->config->synchronize_cbs(dev);
+	} else {
+		/*
+		 * A best effort fallback to synchronize with
+		 * interrupts, preemption and softirq disabled
+		 * regions. See comment above synchronize_rcu().
+		 */
+		synchronize_rcu();
+	}
+}
+
 /**
  * virtio_device_ready - enable vq use in probe function
  * @vdev: the device
-- 
2.25.1

