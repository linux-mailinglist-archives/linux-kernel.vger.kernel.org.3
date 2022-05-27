Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467BF5358FE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244568AbiE0GDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244439AbiE0GCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:02:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E14B624A
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653631367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=18WQBid1QGXVg+QHLgcRuT6xbcOBi4aseNYhzOEIOx8=;
        b=L4YXWzKbrjDjqJiVC1a4RXTzxoOpuoIujGlBBmUf/9dYWMVMJEKttyhJyYUFxLbVBOrfgd
        q9EeDZC+/Kp2taRD9ovK6oMZclW5ct2NHRNBHZZjr+IJmAxYer42wFcoQXQQ26kjY6u+oJ
        gJLlq1vUj9mMUpTdVQFCSXetAi3VN8U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-1yzvGschPfSNIFvz1rHPmQ-1; Fri, 27 May 2022 02:02:43 -0400
X-MC-Unique: 1yzvGschPfSNIFvz1rHPmQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E10038349B3;
        Fri, 27 May 2022 06:02:43 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-240.pek2.redhat.com [10.72.13.240])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 430C12166B26;
        Fri, 27 May 2022 06:02:35 +0000 (UTC)
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
Subject: [PATCH V6 8/9] virtio: harden vring IRQ
Date:   Fri, 27 May 2022 14:01:19 +0800
Message-Id: <20220527060120.20964-9-jasowang@redhat.com>
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

This is a rework on the previous IRQ hardening that is done for
virtio-pci where several drawbacks were found and were reverted:

1) try to use IRQF_NO_AUTOEN which is not friendly to affinity managed IRQ
   that is used by some device such as virtio-blk
2) done only for PCI transport

The vq->broken is re-used in this patch for implementing the IRQ
hardening. The vq->broken is set to true during both initialization
and reset. And the vq->broken is set to false in
virtio_device_ready(). Then vring_interrupt() can check and return
when vq->broken is true. And in this case, switch to return IRQ_NONE
to let the interrupt core aware of such invalid interrupt to prevent
IRQ storm.

The reason of using a per queue variable instead of a per device one
is that we may need it for per queue reset hardening in the future.

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
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/s390/virtio/virtio_ccw.c       |  4 ++++
 drivers/virtio/virtio.c                | 15 ++++++++++++---
 drivers/virtio/virtio_mmio.c           |  5 +++++
 drivers/virtio/virtio_pci_modern_dev.c |  5 +++++
 drivers/virtio/virtio_ring.c           | 11 +++++++----
 include/linux/virtio_config.h          | 20 ++++++++++++++++++++
 6 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index c188e4f20ca3..97e51c34e6cf 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -971,6 +971,10 @@ static void virtio_ccw_set_status(struct virtio_device *vdev, u8 status)
 	ccw->flags = 0;
 	ccw->count = sizeof(status);
 	ccw->cda = (__u32)(unsigned long)&vcdev->dma_area->status;
+	/* We use ssch for setting the status which is a serializing
+	 * instruction that guarantees the memory writes have
+	 * completed before ssch.
+	 */
 	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_WRITE_STATUS);
 	/* Write failed? We assume status is unchanged. */
 	if (ret)
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index aa1eb5132767..95fac4c97c8b 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -220,6 +220,15 @@ static int virtio_features_ok(struct virtio_device *dev)
  * */
 void virtio_reset_device(struct virtio_device *dev)
 {
+	/*
+	 * The below virtio_synchronize_cbs() guarantees that any
+	 * interrupt for this line arriving after
+	 * virtio_synchronize_vqs() has completed is guaranteed to see
+	 * vq->broken as true.
+	 */
+	virtio_break_device(dev);
+	virtio_synchronize_cbs(dev);
+
 	dev->config->reset(dev);
 }
 EXPORT_SYMBOL_GPL(virtio_reset_device);
@@ -428,6 +437,9 @@ int register_virtio_device(struct virtio_device *dev)
 	dev->config_enabled = false;
 	dev->config_change_pending = false;
 
+	INIT_LIST_HEAD(&dev->vqs);
+	spin_lock_init(&dev->vqs_list_lock);
+
 	/* We always start by resetting the device, in case a previous
 	 * driver messed it up.  This also tests that code path a little. */
 	virtio_reset_device(dev);
@@ -435,9 +447,6 @@ int register_virtio_device(struct virtio_device *dev)
 	/* Acknowledge that we've seen the device. */
 	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
 
-	INIT_LIST_HEAD(&dev->vqs);
-	spin_lock_init(&dev->vqs_list_lock);
-
 	/*
 	 * device_add() causes the bus infrastructure to look for a matching
 	 * driver.
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index c9699a59f93c..f9a36bc7ac27 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -253,6 +253,11 @@ static void vm_set_status(struct virtio_device *vdev, u8 status)
 	/* We should never be setting status to 0. */
 	BUG_ON(status == 0);
 
+	/*
+	 * Per memory-barriers.txt, wmb() is not needed to guarantee
+	 * that the the cache coherent memory writes have completed
+	 * before writing to the MMIO region.
+	 */
 	writel(status, vm_dev->base + VIRTIO_MMIO_STATUS);
 }
 
diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 4093f9cca7a6..a0fa14f28a7f 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -467,6 +467,11 @@ void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
 {
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 
+	/*
+	 * Per memory-barriers.txt, wmb() is not needed to guarantee
+	 * that the the cache coherent memory writes have completed
+	 * before writing to the MMIO region.
+	 */
 	vp_iowrite8(status, &cfg->device_status);
 }
 EXPORT_SYMBOL_GPL(vp_modern_set_status);
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 9c231e1fded7..13a7348cedff 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1688,7 +1688,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->we_own_ring = true;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
-	vq->broken = false;
+	vq->broken = true;
 	vq->last_used_idx = 0;
 	vq->event_triggered = false;
 	vq->num_added = 0;
@@ -2134,8 +2134,11 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
 		return IRQ_NONE;
 	}
 
-	if (unlikely(vq->broken))
-		return IRQ_HANDLED;
+	if (unlikely(vq->broken)) {
+		dev_warn_once(&vq->vq.vdev->dev,
+			      "virtio vring IRQ raised before DRIVER_OK");
+		return IRQ_NONE;
+	}
 
 	/* Just a hint for performance: so it's ok that this can be racy! */
 	if (vq->event)
@@ -2177,7 +2180,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	vq->we_own_ring = false;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
-	vq->broken = false;
+	vq->broken = true;
 	vq->last_used_idx = 0;
 	vq->event_triggered = false;
 	vq->num_added = 0;
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 25be018810a7..d4edfd7d91bb 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -256,6 +256,26 @@ void virtio_device_ready(struct virtio_device *dev)
 	unsigned status = dev->config->get_status(dev);
 
 	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
+
+	/*
+	 * The virtio_synchronize_cbs() makes sure vring_interrupt()
+	 * will see the driver specific setup if it sees vq->broken
+	 * as false (even if the notifications come before DRIVER_OK).
+	 */
+	virtio_synchronize_cbs(dev);
+	__virtio_unbreak_device(dev);
+	/*
+	 * The transport should ensure the visibility of vq->broken
+	 * before setting DRIVER_OK. See the comments for the transport
+	 * specific set_status() method.
+	 *
+	 * A well behaved device will only notify a virtqueue after
+	 * DRIVER_OK, this means the device should "see" the coherenct
+	 * memory write that set vq->broken as false which is done by
+	 * the driver when it sees DRIVER_OK, then the following
+	 * driver's vring_interrupt() will see vq->broken as false so
+	 * we won't lose any notification.
+	 */
 	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
 }
 
-- 
2.25.1

