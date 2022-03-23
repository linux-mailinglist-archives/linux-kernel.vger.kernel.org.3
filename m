Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B994E4B56
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 04:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241449AbiCWDRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 23:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236084AbiCWDRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 23:17:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E9FB205D7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 20:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648005338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SVrjcP1lrBTCbvCHht5yAGBOLG7SBcbqKikxAiB9SAI=;
        b=JMYu/pZXOlUDEYnOt6+aSJzbqGEQoPEoToaZzxP4Y6PWl5u/TME7ymV/hdBEuRh7Oop1Xq
        mrHHVQrWv9tggJWK7S1U0/gFQ3StPrHUnwL6UdoRYn/peTgoiHmg4fWQUElOg7bWxTKSu7
        8M/FpWv+0LwCwz0sEnRYICRmDCIo8U0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-riB5se-NO0e12lAtJj5Xiw-1; Tue, 22 Mar 2022 23:15:34 -0400
X-MC-Unique: riB5se-NO0e12lAtJj5Xiw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C31685A5BC;
        Wed, 23 Mar 2022 03:15:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-49.pek2.redhat.com [10.72.12.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C1EA1427AF5;
        Wed, 23 Mar 2022 03:15:30 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 2/2] Revert "virtio_pci: harden MSI-X interrupts"
Date:   Wed, 23 Mar 2022 11:15:24 +0800
Message-Id: <20220323031524.6555-2-jasowang@redhat.com>
In-Reply-To: <20220323031524.6555-1-jasowang@redhat.com>
References: <20220323031524.6555-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9e35276a5344f74d4a3600fc4100b3dd251d5c56. Issue
were reported for the drivers that are using affinity managed IRQ
where manually toggling IRQ status is not expected. And we forget to
enable the interrupts in the restore path as well.

In the future, we will rework on the interrupt hardening.

Fixes: 9e35276a5344 ("virtio_pci: harden MSI-X interrupts")
Reported-by: Marc Zyngier <maz@kernel.org>
Reported-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 27 ++++++---------------------
 drivers/virtio/virtio_pci_common.h |  6 ++----
 drivers/virtio/virtio_pci_legacy.c |  5 ++---
 drivers/virtio/virtio_pci_modern.c |  6 ++----
 4 files changed, 12 insertions(+), 32 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 3f51fdb7be45..d724f676608b 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -24,8 +24,8 @@ MODULE_PARM_DESC(force_legacy,
 		 "Force legacy mode for transitional virtio 1 devices");
 #endif
 
-/* disable irq handlers */
-void vp_disable_cbs(struct virtio_device *vdev)
+/* wait for pending irq handlers */
+void vp_synchronize_vectors(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	int i;
@@ -34,20 +34,7 @@ void vp_disable_cbs(struct virtio_device *vdev)
 		synchronize_irq(vp_dev->pci_dev->irq);
 
 	for (i = 0; i < vp_dev->msix_vectors; ++i)
-		disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
-}
-
-/* enable irq handlers */
-void vp_enable_cbs(struct virtio_device *vdev)
-{
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	int i;
-
-	if (vp_dev->intx_enabled)
-		return;
-
-	for (i = 0; i < vp_dev->msix_vectors; ++i)
-		enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
+		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
 }
 
 /* the notify function used when creating a virt queue */
@@ -154,8 +141,7 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 	snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
 		 "%s-config", name);
 	err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
-			  vp_config_changed, IRQF_NO_AUTOEN,
-			  vp_dev->msix_names[v],
+			  vp_config_changed, 0, vp_dev->msix_names[v],
 			  vp_dev);
 	if (err)
 		goto error;
@@ -174,8 +160,7 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 		snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
 			 "%s-virtqueues", name);
 		err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
-				  vp_vring_interrupt, IRQF_NO_AUTOEN,
-				  vp_dev->msix_names[v],
+				  vp_vring_interrupt, 0, vp_dev->msix_names[v],
 				  vp_dev);
 		if (err)
 			goto error;
@@ -352,7 +337,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 			 "%s-%s",
 			 dev_name(&vp_dev->vdev.dev), names[i]);
 		err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
-				  vring_interrupt, IRQF_NO_AUTOEN,
+				  vring_interrupt, 0,
 				  vp_dev->msix_names[msix_vec],
 				  vqs[i]);
 		if (err)
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index d3c6f72c7390..eb17a29fc7ef 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -101,10 +101,8 @@ static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
 	return container_of(vdev, struct virtio_pci_device, vdev);
 }
 
-/* disable irq handlers */
-void vp_disable_cbs(struct virtio_device *vdev);
-/* enable irq handlers */
-void vp_enable_cbs(struct virtio_device *vdev);
+/* wait for pending irq handlers */
+void vp_synchronize_vectors(struct virtio_device *vdev);
 /* the notify function used when creating a virt queue */
 bool vp_notify(struct virtqueue *vq);
 /* the config->del_vqs() implementation */
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 34141b9abe27..6f4e34ce96b8 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -98,8 +98,8 @@ static void vp_reset(struct virtio_device *vdev)
 	/* Flush out the status write, and flush in device writes,
 	 * including MSi-X interrupts, if any. */
 	vp_legacy_get_status(&vp_dev->ldev);
-	/* Disable VQ/configuration callbacks. */
-	vp_disable_cbs(vdev);
+	/* Flush pending VQ/configuration callbacks. */
+	vp_synchronize_vectors(vdev);
 }
 
 static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
@@ -185,7 +185,6 @@ static void del_vq(struct virtio_pci_vq_info *info)
 }
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
-	.enable_cbs	= vp_enable_cbs,
 	.get		= vp_get,
 	.set		= vp_set,
 	.get_status	= vp_get_status,
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 5455bc041fb6..30654d3a0b41 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -172,8 +172,8 @@ static void vp_reset(struct virtio_device *vdev)
 	 */
 	while (vp_modern_get_status(mdev))
 		msleep(1);
-	/* Disable VQ/configuration callbacks. */
-	vp_disable_cbs(vdev);
+	/* Flush pending VQ/configuration callbacks. */
+	vp_synchronize_vectors(vdev);
 }
 
 static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
@@ -380,7 +380,6 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
 }
 
 static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
-	.enable_cbs	= vp_enable_cbs,
 	.get		= NULL,
 	.set		= NULL,
 	.generation	= vp_generation,
@@ -398,7 +397,6 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 };
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
-	.enable_cbs	= vp_enable_cbs,
 	.get		= vp_get,
 	.set		= vp_set,
 	.generation	= vp_generation,
-- 
2.25.1

