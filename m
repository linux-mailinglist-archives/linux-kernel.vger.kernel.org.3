Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B8150D720
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 04:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240546AbiDYCt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 22:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240469AbiDYCtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 22:49:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19E64764F
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 19:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650854759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0jKIGy9u9UhcT79RC27l/T3jO+xdvWXVUvv8mYNFcQE=;
        b=eQj86vrSIZo2dbYZDOUkwlBey1S+EC1EbD8Kp0j4k7FftVrDYJj//73pyDSOg0Elm4GWx/
        TyQl8jgnoc/00oY1JfPpaqZU9f049LmTQi9H4oXVrGl08P4Kjnvj9DaYRW4VEWeCkpimz9
        41RuyrxA9t+tArQunfTXChanZLOK+74=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-wq8hV0GEOkq2jSZNJ_zodA-1; Sun, 24 Apr 2022 22:45:56 -0400
X-MC-Unique: wq8hV0GEOkq2jSZNJ_zodA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FEAE3C01D84;
        Mon, 25 Apr 2022 02:45:54 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-160.pek2.redhat.com [10.72.13.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B95BF9E6E;
        Mon, 25 Apr 2022 02:45:31 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     jasowang@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     sgarzare@redhat.com, eperezma@redhat.com, lulu@redhat.com,
        tglx@linutronix.de, peterz@infradead.org, paulmck@kernel.org,
        maz@kernel.org, pasic@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH V3 7/9] virtio: allow to unbreak virtqueue
Date:   Mon, 25 Apr 2022 10:44:16 +0800
Message-Id: <20220425024418.8415-8-jasowang@redhat.com>
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

This patch allows the virtio_break_device() to accept a boolean value
then we can unbreak the virtqueue.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/char/virtio_console.c              | 2 +-
 drivers/crypto/virtio/virtio_crypto_core.c | 2 +-
 drivers/s390/virtio/virtio_ccw.c           | 4 ++--
 drivers/virtio/virtio_pci_common.c         | 2 +-
 drivers/virtio/virtio_ring.c               | 4 ++--
 include/linux/virtio.h                     | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index e3c430539a17..afede977f7b3 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1958,7 +1958,7 @@ static void virtcons_remove(struct virtio_device *vdev)
 	spin_unlock_irq(&pdrvdata_lock);
 
 	/* Device is going away, exit any polling for buffers */
-	virtio_break_device(vdev);
+	virtio_break_device(vdev, true);
 	if (use_multiport(portdev))
 		flush_work(&portdev->control_work);
 	else
diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index c6f482db0bc0..fd17f3f2e958 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -215,7 +215,7 @@ static int virtcrypto_update_status(struct virtio_crypto *vcrypto)
 		dev_warn(&vcrypto->vdev->dev,
 				"Unknown status bits: 0x%x\n", status);
 
-		virtio_break_device(vcrypto->vdev);
+		virtio_break_device(vcrypto->vdev, true);
 		return -EPERM;
 	}
 
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index c19f07a82d62..9a963f5af5b5 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -1211,7 +1211,7 @@ static void virtio_ccw_remove(struct ccw_device *cdev)
 
 	if (vcdev && cdev->online) {
 		if (vcdev->device_lost)
-			virtio_break_device(&vcdev->vdev);
+			virtio_break_device(&vcdev->vdev, true);
 		unregister_virtio_device(&vcdev->vdev);
 		spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
 		dev_set_drvdata(&cdev->dev, NULL);
@@ -1228,7 +1228,7 @@ static int virtio_ccw_offline(struct ccw_device *cdev)
 	if (!vcdev)
 		return 0;
 	if (vcdev->device_lost)
-		virtio_break_device(&vcdev->vdev);
+		virtio_break_device(&vcdev->vdev, true);
 	unregister_virtio_device(&vcdev->vdev);
 	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
 	dev_set_drvdata(&cdev->dev, NULL);
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index d724f676608b..39a711ddff30 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -583,7 +583,7 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
 	 * layers can abort any ongoing operation.
 	 */
 	if (!pci_device_is_present(pci_dev))
-		virtio_break_device(&vp_dev->vdev);
+		virtio_break_device(&vp_dev->vdev, true);
 
 	pci_disable_sriov(pci_dev);
 
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index cfb028ca238e..6da13495a70c 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2382,7 +2382,7 @@ EXPORT_SYMBOL_GPL(virtqueue_is_broken);
  * This should prevent the device from being used, allowing drivers to
  * recover.  You may need to grab appropriate locks to flush.
  */
-void virtio_break_device(struct virtio_device *dev)
+void virtio_break_device(struct virtio_device *dev, bool broken)
 {
 	struct virtqueue *_vq;
 
@@ -2391,7 +2391,7 @@ void virtio_break_device(struct virtio_device *dev)
 		struct vring_virtqueue *vq = to_vvq(_vq);
 
 		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
-		WRITE_ONCE(vq->broken, true);
+		WRITE_ONCE(vq->broken, broken);
 	}
 	spin_unlock(&dev->vqs_list_lock);
 }
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 5464f398912a..24bff3b314c8 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -130,7 +130,7 @@ int register_virtio_device(struct virtio_device *dev);
 void unregister_virtio_device(struct virtio_device *dev);
 bool is_virtio_device(struct device *dev);
 
-void virtio_break_device(struct virtio_device *dev);
+void virtio_break_device(struct virtio_device *dev, bool broken);
 
 void virtio_config_changed(struct virtio_device *dev);
 #ifdef CONFIG_PM_SLEEP
-- 
2.25.1

