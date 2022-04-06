Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10FA4F5E3B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiDFMg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbiDFMd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:33:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0EB32E4BB8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649234174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9fzws/TrjvfN5TEfT4l4EkTY22qMkOTX3Nn8UDj/95g=;
        b=U2jSjSPZZAGl10JXIb+4Hvb3bNyql2OIh1oR8HNVn8Of9dep/eHQQX/Xz32OiZfxO1NAEF
        KUgk7N25qgqRph5nwTxX8FqdUhpJnpADqhxOzXWbeprrdoxeaSvsVYwjqnX5Qp8YDt5SUr
        LUahedbw9xv0oLRhkdkMrARJaMk+jEU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-dyZ8qOuZMEmmn0cZcjH-8A-1; Wed, 06 Apr 2022 04:36:11 -0400
X-MC-Unique: dyZ8qOuZMEmmn0cZcjH-8A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 901B780B71C;
        Wed,  6 Apr 2022 08:36:10 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-58.pek2.redhat.com [10.72.12.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A80A112132D;
        Wed,  6 Apr 2022 08:36:05 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, sgarzare@redhat.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH V2 3/5] virtio: introduce config op to synchronize vring callbacks
Date:   Wed,  6 Apr 2022 16:35:36 +0800
Message-Id: <20220406083538.16274-4-jasowang@redhat.com>
In-Reply-To: <20220406083538.16274-1-jasowang@redhat.com>
References: <20220406083538.16274-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduce a new virtio config ops to vring
callbacks. Transport specific method is required to call
synchornize_irq() on the IRQs. For the transport that doesn't provide
synchronize_vqs(), use synchornize_rcu() as a fallback.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/virtio_config.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index b341dd62aa4d..08b73d9bbff2 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -57,6 +57,8 @@ struct virtio_shm_region {
  *		include a NULL entry for vqs unused by driver
  *	Returns 0 on success or error status
  * @del_vqs: free virtqueues found by find_vqs().
+ * @synchronize_vqs: synchronize with the virtqueue callbacks.
+ *	vdev: the virtio_device
  * @get_features: get the array of feature bits for this device.
  *	vdev: the virtio_device
  *	Returns the first 64 feature bits (all we currently need).
@@ -89,6 +91,7 @@ struct virtio_config_ops {
 			const char * const names[], const bool *ctx,
 			struct irq_affinity *desc);
 	void (*del_vqs)(struct virtio_device *);
+	void (*synchronize_vqs)(struct virtio_device *);
 	u64 (*get_features)(struct virtio_device *vdev);
 	int (*finalize_features)(struct virtio_device *vdev);
 	const char *(*bus_name)(struct virtio_device *vdev);
@@ -217,6 +220,19 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
 				      desc);
 }
 
+/**
+ * virtio_synchronize_vqs - synchronize with virtqueue callbacks
+ * @vdev: the device
+ */
+static inline
+void virtio_synchronize_vqs(struct virtio_device *dev)
+{
+	if (dev->config->synchronize_vqs)
+		dev->config->synchronize_vqs(dev);
+	else
+		synchronize_rcu();
+}
+
 /**
  * virtio_device_ready - enable vq use in probe function
  * @vdev: the device
-- 
2.25.1

