Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2ECA564EF1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiGDHpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbiGDHps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:45:48 -0400
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0031E95B7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 00:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
        Content-Type; bh=q8+/RdnIU2QslZQeGZN1Ug0856w71RKRtQZViBusQZQ=; b=X8p44xXEhqrP
        3/sHKdcDu+yrohAMTj414iWxX+xH5rZ7gl8Sc8QsjPLax0kdsbUIN0Uw7UIJlOEYO3Oc5XRB5KaGs
        8ceP8kwBJBgKbq4sKqmWoMvPv6MSaQ2mO8PO+W0eOeQmvdsyW2qeOKSQHkCJ3NtBrC/oW3Y/JjtV5
        OMY4k=;
Received: from [192.168.16.236] (helo=vzdev.sw.ru)
        by relay.virtuozzo.com with esmtp (Exim 4.95)
        (envelope-from <alexander.atanasov@virtuozzo.com>)
        id 1o8GlX-008bO2-FJ;
        Mon, 04 Jul 2022 09:45:07 +0200
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     kernel@openvz.org,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] virtio: Restore semantics of vq->broken in virtqueues
Date:   Mon,  4 Jul 2022 07:44:59 +0000
Message-Id: <20220704074500.28705-1-alexander.atanasov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <CACGkMEsZHB9opC6frbSwNmE1d9=yt3npZCHWcK25Xe52VJzwGQ@mail.gmail.com>
References: <CACGkMEsZHB9opC6frbSwNmE1d9=yt3npZCHWcK25Xe52VJzwGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio: harden vring IRQ (8b4ec69d7e09) changed the meaning
of vq->broken which results in vring_interrupt handles IRQs for
broken drivers as IRQ_NONE and not IRQ_HANDLED and made impossible
to initiallize vqs before the driver is ready, i.e. in probe method.
Balloon driver does this and it can not load because it fails in
vqs_init with -EIO.

So instead of changing the original intent ot the flag introduce
a new flag vq->ready which servers the purpose to check of early IRQs
and restore the behaviour of the vq->broken flag.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
---
 drivers/virtio/virtio_ring.c  | 33 ++++++++++++++++++---------------
 include/linux/virtio.h        |  4 +++-
 include/linux/virtio_config.h | 12 ++++++------
 3 files changed, 27 insertions(+), 22 deletions(-)

V1->V2: 
  Reworked on top of config option to disable the hardening.
  

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 643ca779fcc6..f0e645e17848 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -100,6 +100,9 @@ struct vring_virtqueue {
 	/* Other side has made a mess, don't try any more. */
 	bool broken;
 
+	/* the queue is ready to handle interrupts */
+	bool ready;
+
 	/* Host supports indirect buffers */
 	bool indirect;
 
@@ -1708,10 +1711,9 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->we_own_ring = true;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
-#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
-	vq->broken = true;
-#else
 	vq->broken = false;
+#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
+	vq->ready = false;
 #endif
 	vq->last_used_idx = 0 | (1 << VRING_PACKED_EVENT_F_WRAP_CTR);
 	vq->event_triggered = false;
@@ -2157,15 +2159,16 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
 		return IRQ_NONE;
 	}
 
-	if (unlikely(vq->broken)) {
+	if (unlikely(vq->broken))
+		return IRQ_HANDLED;
+
 #ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
+	if (unlikely(!vq->ready)) {
 		dev_warn_once(&vq->vq.vdev->dev,
 			      "virtio vring IRQ raised before DRIVER_OK");
 		return IRQ_NONE;
-#else
-		return IRQ_HANDLED;
-#endif
 	}
+#endif
 
 	/* Just a hint for performance: so it's ok that this can be racy! */
 	if (vq->event)
@@ -2207,10 +2210,9 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	vq->we_own_ring = false;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
-#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
-	vq->broken = true;
-#else
 	vq->broken = false;
+#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
+	vq->ready = false;
 #endif
 	vq->last_used_idx = 0;
 	vq->event_triggered = false;
@@ -2429,14 +2431,15 @@ void virtio_break_device(struct virtio_device *dev)
 }
 EXPORT_SYMBOL_GPL(virtio_break_device);
 
+#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
 /*
  * This should allow the device to be used by the driver. You may
  * need to grab appropriate locks to flush the write to
- * vq->broken. This should only be used in some specific case e.g
+ * vq->ready. This should only be used in some specific case e.g
  * (probing and restoring). This function should only be called by the
  * core, not directly by the driver.
  */
-void __virtio_unbreak_device(struct virtio_device *dev)
+void __virtio_device_ready(struct virtio_device *dev)
 {
 	struct virtqueue *_vq;
 
@@ -2444,12 +2447,12 @@ void __virtio_unbreak_device(struct virtio_device *dev)
 	list_for_each_entry(_vq, &dev->vqs, list) {
 		struct vring_virtqueue *vq = to_vvq(_vq);
 
-		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
-		WRITE_ONCE(vq->broken, false);
+		WRITE_ONCE(vq->ready, true);
 	}
 	spin_unlock(&dev->vqs_list_lock);
 }
-EXPORT_SYMBOL_GPL(__virtio_unbreak_device);
+EXPORT_SYMBOL_GPL(__virtio_device_ready);
+#endif
 
 dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
 {
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index d8fdf170637c..a63120477ae1 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -131,7 +131,9 @@ void unregister_virtio_device(struct virtio_device *dev);
 bool is_virtio_device(struct device *dev);
 
 void virtio_break_device(struct virtio_device *dev);
-void __virtio_unbreak_device(struct virtio_device *dev);
+#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
+void __virtio_device_ready(struct virtio_device *dev);
+#endif
 
 void virtio_config_changed(struct virtio_device *dev);
 #ifdef CONFIG_PM_SLEEP
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index b47c2e7ed0ee..472d4703d499 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -260,22 +260,22 @@ void virtio_device_ready(struct virtio_device *dev)
 #ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
 	/*
 	 * The virtio_synchronize_cbs() makes sure vring_interrupt()
-	 * will see the driver specific setup if it sees vq->broken
-	 * as false (even if the notifications come before DRIVER_OK).
+	 * will see the driver specific setup if it sees vq->ready
+	 * as true (even if the notifications come before DRIVER_OK).
 	 */
 	virtio_synchronize_cbs(dev);
-	__virtio_unbreak_device(dev);
+	__virtio_device_ready(dev);
 #endif
 	/*
-	 * The transport should ensure the visibility of vq->broken
+	 * The transport should ensure the visibility of vq->ready
 	 * before setting DRIVER_OK. See the comments for the transport
 	 * specific set_status() method.
 	 *
 	 * A well behaved device will only notify a virtqueue after
 	 * DRIVER_OK, this means the device should "see" the coherenct
-	 * memory write that set vq->broken as false which is done by
+	 * memory write that set vq->ready as true which is done by
 	 * the driver when it sees DRIVER_OK, then the following
-	 * driver's vring_interrupt() will see vq->broken as false so
+	 * driver's vring_interrupt() will see vq->ready as true so
 	 * we won't lose any notification.
 	 */
 	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
-- 
2.25.1

