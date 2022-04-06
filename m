Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C07B4F5E3D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiDFMg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiDFMeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:34:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C1641B29C3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649234201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RXRl5yVraFjtAHNeuo8Tj/7VeEPbPvmJda7LXPVTN00=;
        b=RikE92o/kxvWj/75Bxg+5qCSXgMeey8Qg6d3qciE8i9a0yibFBXxNWiBSr6ZfJ/wqIoq/p
        mpHk5XDGV45RM3z5YI4lvPi+21VpuL8mjV6EIRu+PT7/TBsHe8kQg6Pt9h3FyTPKEiJpaJ
        dAYcwlMbYR3/6h5l4F0CwnBijmdw/6E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-ipVoKGptOI24T9gwiW2-gA-1; Wed, 06 Apr 2022 04:36:38 -0400
X-MC-Unique: ipVoKGptOI24T9gwiW2-gA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBC763822204;
        Wed,  6 Apr 2022 08:36:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-58.pek2.redhat.com [10.72.12.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97A9F1121319;
        Wed,  6 Apr 2022 08:36:20 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, sgarzare@redhat.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH V2 5/5] virtio: harden vring IRQ
Date:   Wed,  6 Apr 2022 16:35:38 +0800
Message-Id: <20220406083538.16274-6-jasowang@redhat.com>
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

This is a rework on the previous IRQ hardening that is done for
virtio-pci where several drawbacks were found and were reverted:

1) try to use IRQF_NO_AUTOEN which is not friendly to affinity managed IRQ
   that is used by some device such as virtio-blk
2) done only for PCI transport

In this patch, we tries to borrow the idea from the INTX IRQ hardening
in the reverted commit 080cd7c3ac87 ("virtio-pci: harden INTX interrupts")
by introducing a global device_ready variable for each
virtio_device. Then we can to toggle it during
virtio_reset_device()/virtio_device_ready(). A
virtio_synchornize_vqs() is used in both virtio_device_ready() and
virtio_reset_device() to synchronize with the vring callbacks. With
this, vring_interrupt() can return check and early if driver_ready is
false.

Note that the hardening is only done for vring interrupt since the
config interrupt hardening is already done in commit 22b7050a024d7
("virtio: defer config changed notifications"). But the method that is
used by config interrupt can't be reused by the vring interrupt
handler because it uses spinlock to do the synchronization which is
expensive.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio.c       | 11 +++++++++++
 drivers/virtio/virtio_ring.c  |  9 ++++++++-
 include/linux/virtio.h        |  2 ++
 include/linux/virtio_config.h |  8 ++++++++
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 8dde44ea044a..2f3a6f8e3d9c 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -220,6 +220,17 @@ static int virtio_features_ok(struct virtio_device *dev)
  * */
 void virtio_reset_device(struct virtio_device *dev)
 {
+	if (READ_ONCE(dev->driver_ready)) {
+		/*
+		 * The below virtio_synchronize_vqs() guarantees that any
+		 * interrupt for this line arriving after
+		 * virtio_synchronize_vqs() has completed is guaranteed to see
+		 * driver_ready == false.
+		 */
+		WRITE_ONCE(dev->driver_ready, false);
+		virtio_synchronize_vqs(dev);
+	}
+
 	dev->config->reset(dev);
 }
 EXPORT_SYMBOL_GPL(virtio_reset_device);
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index cfb028ca238e..a4592e55c9f8 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2127,10 +2127,17 @@ static inline bool more_used(const struct vring_virtqueue *vq)
 	return vq->packed_ring ? more_used_packed(vq) : more_used_split(vq);
 }
 
-irqreturn_t vring_interrupt(int irq, void *_vq)
+irqreturn_t vring_interrupt(int irq, void *v)
 {
+	struct virtqueue *_vq = v;
+	struct virtio_device *vdev = _vq->vdev;
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
+	if (!READ_ONCE(vdev->driver_ready)) {
+		dev_warn_once(&vdev->dev, "virtio vring IRQ raised before DRIVER_OK");
+		return IRQ_NONE;
+	}
+
 	if (!more_used(vq)) {
 		pr_debug("virtqueue interrupt with no work for %p\n", vq);
 		return IRQ_NONE;
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 5464f398912a..dfa2638a293e 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -95,6 +95,7 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
  * @failed: saved value for VIRTIO_CONFIG_S_FAILED bit (for restore)
  * @config_enabled: configuration change reporting enabled
  * @config_change_pending: configuration change reported while disabled
+ * @driver_ready: whehter the driver is ready (e.g for vring callbacks)
  * @config_lock: protects configuration change reporting
  * @dev: underlying device.
  * @id: the device type identification (used to match it with a driver).
@@ -109,6 +110,7 @@ struct virtio_device {
 	bool failed;
 	bool config_enabled;
 	bool config_change_pending;
+	bool driver_ready;
 	spinlock_t config_lock;
 	spinlock_t vqs_list_lock; /* Protects VQs list access */
 	struct device dev;
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 08b73d9bbff2..c9e207bf2c9c 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -246,6 +246,14 @@ void virtio_device_ready(struct virtio_device *dev)
 {
 	unsigned status = dev->config->get_status(dev);
 
+	virtio_synchronize_vqs(dev);
+        /*
+         * The above virtio_synchronize_vqs() make sure
+         * vring_interrupt() will see the driver specific setup if it
+         * see driver_ready as true.
+         */
+	WRITE_ONCE(dev->driver_ready, true);
+
 	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
 	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
 }
-- 
2.25.1

