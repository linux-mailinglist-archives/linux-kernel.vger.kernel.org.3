Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E2B5616D3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbiF3JyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiF3JyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:54:14 -0400
X-Greylist: delayed 919 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Jun 2022 02:54:13 PDT
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325EC22BFB;
        Thu, 30 Jun 2022 02:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
        Content-Type; bh=eP1sj3XLEhD8H0WwbeboKYvAKhfYwTvFMo2H6hCECIY=; b=FvOXx8wCxRCi
        G6aAQCyB2O0Rs+02kUuiNOhqdQjCy8aMvJ2S+xudaMcHf4dnMRFd50KgW6SAZzluXTcfg+3W1YX/u
        LnhNuu495fVk3LwJtEclMd5vuiJ2BBv3i2/EwhcDjW6+sESMkSdiFZjMYyQO9MMF3A+kpxDWf1Smp
        UoZdo=;
Received: from [192.168.16.236] (helo=vzdev.sw.ru)
        by relay.virtuozzo.com with esmtp (Exim 4.94.2)
        (envelope-from <alexander.atanasov@virtuozzo.com>)
        id 1o6qbC-007yyH-Lu; Thu, 30 Jun 2022 11:37:09 +0200
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     kernel@openvz.org,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] virtio: Restore semantics of vq->broken in virtqueues
Date:   Thu, 30 Jun 2022 09:36:46 +0000
Message-Id: <20220630093651.25981-1-alexander.atanasov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
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

virtio: harden vring IRQ (8b4ec69d7e09) changed the use
of vq->broken. As result vring_interrupt handles IRQs for
broken drivers as IRQ_NONE and not IRQ_HANDLED and made impossible
to initiallize vqs before the driver is ready, i.e. in probe method.
Balloon driver does this and it can not load because it fails in
vqs_init with -EIO.

So instead of changing the original intent ot the flag introduce
a new flag vq->ready which servers the purpose to check of early IRQs
and restore the behaviour of the vq->broken flag.

Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
---
 drivers/virtio/virtio_ring.c  | 20 ++++++++++++++------
 include/linux/virtio.h        |  2 +-
 include/linux/virtio_config.h | 10 +++++-----
 3 files changed, 20 insertions(+), 12 deletions(-)

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 13a7348cedff..dca3cc774584 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -100,6 +100,9 @@ struct vring_virtqueue {
 	/* Other side has made a mess, don't try any more. */
 	bool broken;
 
+	/* the queue is ready to handle interrupts  */
+	bool ready;
+
 	/* Host supports indirect buffers */
 	bool indirect;
 
@@ -1688,7 +1691,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->we_own_ring = true;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
-	vq->broken = true;
+	vq->broken = false;
+	vq->ready = false;
 	vq->last_used_idx = 0;
 	vq->event_triggered = false;
 	vq->num_added = 0;
@@ -2134,7 +2138,10 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
 		return IRQ_NONE;
 	}
 
-	if (unlikely(vq->broken)) {
+	if (unlikely(vq->broken))
+		return IRQ_HANDLED;
+
+	if (unlikely(!vq->ready)) {
 		dev_warn_once(&vq->vq.vdev->dev,
 			      "virtio vring IRQ raised before DRIVER_OK");
 		return IRQ_NONE;
@@ -2180,7 +2187,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	vq->we_own_ring = false;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
-	vq->broken = true;
+	vq->broken = false;
+	vq->ready = false;
 	vq->last_used_idx = 0;
 	vq->event_triggered = false;
 	vq->num_added = 0;
@@ -2405,7 +2413,7 @@ EXPORT_SYMBOL_GPL(virtio_break_device);
  * (probing and restoring). This function should only be called by the
  * core, not directly by the driver.
  */
-void __virtio_unbreak_device(struct virtio_device *dev)
+void __virtio_device_ready(struct virtio_device *dev)
 {
 	struct virtqueue *_vq;
 
@@ -2414,11 +2422,11 @@ void __virtio_unbreak_device(struct virtio_device *dev)
 		struct vring_virtqueue *vq = to_vvq(_vq);
 
 		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
-		WRITE_ONCE(vq->broken, false);
+		WRITE_ONCE(vq->ready, true);
 	}
 	spin_unlock(&dev->vqs_list_lock);
 }
-EXPORT_SYMBOL_GPL(__virtio_unbreak_device);
+EXPORT_SYMBOL_GPL(__virtio_device_ready);
 
 dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
 {
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index d8fdf170637c..538c5959949a 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -131,7 +131,7 @@ void unregister_virtio_device(struct virtio_device *dev);
 bool is_virtio_device(struct device *dev);
 
 void virtio_break_device(struct virtio_device *dev);
-void __virtio_unbreak_device(struct virtio_device *dev);
+void __virtio_device_ready(struct virtio_device *dev);
 
 void virtio_config_changed(struct virtio_device *dev);
 #ifdef CONFIG_PM_SLEEP
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 49c7c32815f1..35cf1b26e05a 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -259,21 +259,21 @@ void virtio_device_ready(struct virtio_device *dev)
 
 	/*
 	 * The virtio_synchronize_cbs() makes sure vring_interrupt()
-	 * will see the driver specific setup if it sees vq->broken
+	 * will see the driver specific setup if it sees vq->ready
 	 * as false (even if the notifications come before DRIVER_OK).
 	 */
 	virtio_synchronize_cbs(dev);
-	__virtio_unbreak_device(dev);
+	__virtio_device_ready(dev);
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
+	 * driver's vring_interrupt() will see vq->true as true so
 	 * we won't lose any notification.
 	 */
 	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
-- 
2.25.1

