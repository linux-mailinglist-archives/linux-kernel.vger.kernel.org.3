Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5A250D716
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 04:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240412AbiDYCsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 22:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240444AbiDYCsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 22:48:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3FA42BE6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 19:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650854701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tfSu6KrqWUap3cnUn9mXIRBQNV5IMT/hsaDS1Qe8rF0=;
        b=dD2SVIk11tYT5ETh5UF8JobSDHHFX7J+II2LGcYmB/Q+zJ1P4aWY6rn9zE9VxZxThkGW4C
        ZHggxz5HuY8pzsighznr7PXR9/B1JUYJGcYK8EX1HlWSYryHnD2qMtwyLGLfLKT23XwMfi
        o8N8+GmvpdZ5xEMbOZPdf4WhrBr4apk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-LT8PTN37N5a4jbvSb7fDjg-1; Sun, 24 Apr 2022 22:44:58 -0400
X-MC-Unique: LT8PTN37N5a4jbvSb7fDjg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 318A2811E76;
        Mon, 25 Apr 2022 02:44:57 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-160.pek2.redhat.com [10.72.13.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECDC89E6E;
        Mon, 25 Apr 2022 02:44:51 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     jasowang@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     sgarzare@redhat.com, eperezma@redhat.com, lulu@redhat.com,
        tglx@linutronix.de, peterz@infradead.org, paulmck@kernel.org,
        maz@kernel.org, pasic@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH V3 3/9] virtio: introduce config op to synchronize vring callbacks
Date:   Mon, 25 Apr 2022 10:44:12 +0800
Message-Id: <20220425024418.8415-4-jasowang@redhat.com>
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
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/virtio_config.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index b341dd62aa4d..14fe89ff99c7 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -57,6 +57,10 @@ struct virtio_shm_region {
  *		include a NULL entry for vqs unused by driver
  *	Returns 0 on success or error status
  * @del_vqs: free virtqueues found by find_vqs().
+ * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
+ *      Make sure the writes commited before this method is visible to
+ *      vring_interrupt() which is called after this method.
+ *      vdev: the virtio_device
  * @get_features: get the array of feature bits for this device.
  *	vdev: the virtio_device
  *	Returns the first 64 feature bits (all we currently need).
@@ -89,6 +93,7 @@ struct virtio_config_ops {
 			const char * const names[], const bool *ctx,
 			struct irq_affinity *desc);
 	void (*del_vqs)(struct virtio_device *);
+	void (*synchronize_cbs)(struct virtio_device *);
 	u64 (*get_features)(struct virtio_device *vdev);
 	int (*finalize_features)(struct virtio_device *vdev);
 	const char *(*bus_name)(struct virtio_device *vdev);
@@ -217,6 +222,25 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
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
+		 * interrupts, preemption and softirq. See comment
+		 * above synchronize_rcu().
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

