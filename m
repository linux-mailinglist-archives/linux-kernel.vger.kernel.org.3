Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328C051E52F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 09:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446051AbiEGHZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 03:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446042AbiEGHYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 03:24:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA5FE532C4
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 00:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651908059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qX3rT7sJHZyPWGf09+6i1sokmF8fms1osD8cExNLFGo=;
        b=bruQWiUS/OOl9ZZ1tML71024RaPSqvRJ03FHCfCH7JFNXZGgECKTrTwNgA+VOKHRsh9mDZ
        tQKme2WgJBTECZ74bcVY1AsC8kx+budplrGt3qO1Fj/Lf2AvoP4s5Y1dmw/wgbd3kbFkR1
        n2dtguT0bx1tuARaijywqJioJBRIH9k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313-9_i-YX9uMSS3OsOLRs4Oog-1; Sat, 07 May 2022 03:20:56 -0400
X-MC-Unique: 9_i-YX9uMSS3OsOLRs4Oog-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 472CD3C1023B;
        Sat,  7 May 2022 07:20:56 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-216.pek2.redhat.com [10.72.13.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9523D40D2976;
        Sat,  7 May 2022 07:20:50 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     jasowang@redhat.com, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, paulmck@kernel.org,
        maz@kernel.org, pasic@linux.ibm.com, cohuck@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, sgarzare@redhat.com,
        xuanzhuo@linux.alibaba.com
Subject: [PATCH V4 8/9] virtio: harden vring IRQ
Date:   Sat,  7 May 2022 15:19:53 +0800
Message-Id: <20220507071954.14455-9-jasowang@redhat.com>
In-Reply-To: <20220507071954.14455-1-jasowang@redhat.com>
References: <20220507071954.14455-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
virtio_device_ready(). Then vring_interrupt can check and return when
vq->broken is true. And in this case, switch to return IRQ_NONE to let
the interrupt core aware of such invalid interrupt to prevent IRQ
storm.

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
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio.c       | 15 ++++++++++++---
 drivers/virtio/virtio_ring.c  | 11 +++++++----
 include/linux/virtio_config.h | 12 ++++++++++++
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 8dde44ea044a..696f5ba4f38e 100644
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
+	 * driver_ready == false.
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
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 5b7df7c455f0..9dfad2890d7a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1690,7 +1690,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->we_own_ring = true;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
-	vq->broken = false;
+	vq->broken = true;
 	vq->last_used_idx = 0;
 	vq->event_triggered = false;
 	vq->num_added = 0;
@@ -2136,8 +2136,11 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
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
@@ -2179,7 +2182,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	vq->we_own_ring = false;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
-	vq->broken = false;
+	vq->broken = true;
 	vq->last_used_idx = 0;
 	vq->event_triggered = false;
 	vq->num_added = 0;
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index d8a2340f928e..23f1694cdbd5 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -256,6 +256,18 @@ void virtio_device_ready(struct virtio_device *dev)
 	unsigned status = dev->config->get_status(dev);
 
 	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
+
+	/*
+	 * The virtio_synchronize_cbs() makes sure vring_interrupt()
+	 * will see the driver specific setup if it sees vq->broken
+	 * as false.
+	 */
+	virtio_synchronize_cbs(dev);
+	__virtio_unbreak_device(dev);
+	/*
+	 * The transport is expected ensure the visibility of
+	 * vq->broken before setting VIRTIO_CONFIG_S_DRIVER_OK.
+	 */
 	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
 }
 
-- 
2.25.1

