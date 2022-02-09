Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17464AF1A5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiBIMaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbiBIM3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:29:12 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F08C05CB96
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 04:29:15 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V4.HsAW_1644409753;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0V4.HsAW_1644409753)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Feb 2022 20:29:13 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v4 14/14] virtio_pci: queue_reset: support VIRTIO_F_RING_RESET
Date:   Wed,  9 Feb 2022 20:29:01 +0800
Message-Id: <20220209122901.51790-15-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
References: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements virtio pci support for QUEUE RESET.

Performing reset on a queue is divided into these steps:

1. reset_vq: reset one vq
2. recycle the buffer from vq by virtqueue_detach_unused_buf()
3. release the ring of the vq by vring_release_virtqueue()
4. enable_reset_vq: re-enable the reset queue

This patch implements reset_vq, enable_reset_vq in the pci scenario

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_pci_common.c |  8 +--
 drivers/virtio/virtio_pci_modern.c | 80 ++++++++++++++++++++++++++++--
 drivers/virtio/virtio_ring.c       |  2 +
 include/linux/virtio.h             |  1 +
 4 files changed, 85 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index cb01eb0cb2e4..303637ac4914 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -255,9 +255,11 @@ static void vp_del_vq(struct virtqueue *vq)
 	struct virtio_pci_vq_info *info = vp_dev->vqs[vq->index];
 	unsigned long flags;
 
-	spin_lock_irqsave(&vp_dev->lock, flags);
-	list_del(&info->node);
-	spin_unlock_irqrestore(&vp_dev->lock, flags);
+	if (!vq->reset) {
+		spin_lock_irqsave(&vp_dev->lock, flags);
+		list_del(&info->node);
+		spin_unlock_irqrestore(&vp_dev->lock, flags);
+	}
 
 	vp_dev->del_vq(info);
 	kfree(info);
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index d29d40bf0b45..cc45515eda50 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -34,6 +34,9 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
 	if ((features & BIT_ULL(VIRTIO_F_SR_IOV)) &&
 			pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_SRIOV))
 		__virtio_set_bit(vdev, VIRTIO_F_SR_IOV);
+
+	if (features & BIT_ULL(VIRTIO_F_RING_RESET))
+		__virtio_set_bit(vdev, VIRTIO_F_RING_RESET);
 }
 
 /* virtio config->finalize_features() implementation */
@@ -176,6 +179,70 @@ static void vp_reset(struct virtio_device *vdev)
 	vp_disable_cbs(vdev);
 }
 
+static int vp_modern_reset_vq(struct virtqueue *vq)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
+	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
+	struct virtio_pci_vq_info *info;
+	unsigned long flags;
+	u16 msix_vec;
+
+	if (!virtio_has_feature(vq->vdev, VIRTIO_F_RING_RESET))
+		return -ENOENT;
+
+	vp_modern_set_queue_reset(mdev, vq->index);
+
+	info = vp_dev->vqs[vq->index];
+	msix_vec = info->msix_vector;
+
+	/* Disable VQ callback. */
+	if (vp_dev->per_vq_vectors && msix_vec != VIRTIO_MSI_NO_VECTOR)
+		disable_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec));
+
+	/* delete vq */
+	spin_lock_irqsave(&vp_dev->lock, flags);
+	list_del(&info->node);
+	spin_unlock_irqrestore(&vp_dev->lock, flags);
+
+	vq->reset = true;
+
+	INIT_LIST_HEAD(&info->node);
+
+	return 0;
+}
+
+static int vp_modern_enable_reset_vq(struct virtqueue *vq, u16 ring_num)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
+	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
+	struct virtio_pci_vq_info *info;
+	struct virtqueue *_vq;
+	u16 msix_vec;
+
+	if (!vq->reset)
+		return -EPERM;
+
+	/* check queue reset status */
+	if (vp_modern_get_queue_reset(mdev, vq->index) != 1)
+		return -EBUSY;
+
+	info = vp_dev->vqs[vq->index];
+	_vq = vp_setup_vq(vq->vdev, vq->index, NULL, NULL, NULL,
+			 info->msix_vector, ring_num);
+	if (IS_ERR(_vq)) {
+		vq->reset = true;
+		return PTR_ERR(_vq);
+	}
+
+	vp_modern_set_queue_enable(&vp_dev->mdev, vq->index, true);
+
+	msix_vec = vp_dev->vqs[vq->index]->msix_vector;
+	if (vp_dev->per_vq_vectors && msix_vec != VIRTIO_MSI_NO_VECTOR)
+		enable_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec));
+
+	return 0;
+}
+
 static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
 {
 	return vp_modern_config_vector(&vp_dev->mdev, vector);
@@ -231,10 +298,13 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				virtqueue_get_avail_addr(vq),
 				virtqueue_get_used_addr(vq));
 
-	vq->priv = (void __force *)vp_modern_map_vq_notify(mdev, index, NULL);
 	if (!vq->priv) {
-		err = -ENOMEM;
-		goto err_map_notify;
+		vq->priv = (void __force *)vp_modern_map_vq_notify(mdev, index,
+								   NULL);
+		if (!vq->priv) {
+			err = -ENOMEM;
+			goto err_map_notify;
+		}
 	}
 
 	if (msix_vec != VIRTIO_MSI_NO_VECTOR) {
@@ -402,6 +472,8 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.set_vq_affinity = vp_set_vq_affinity,
 	.get_vq_affinity = vp_get_vq_affinity,
 	.get_shm_region  = vp_get_shm_region,
+	.reset_vq	 = vp_modern_reset_vq,
+	.enable_reset_vq = vp_modern_enable_reset_vq,
 };
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
@@ -420,6 +492,8 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.set_vq_affinity = vp_set_vq_affinity,
 	.get_vq_affinity = vp_get_vq_affinity,
 	.get_shm_region  = vp_get_shm_region,
+	.reset_vq	 = vp_modern_reset_vq,
+	.enable_reset_vq = vp_modern_enable_reset_vq,
 };
 
 /* the PCI probing function */
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index b8747df8dc1f..4f6028e1e2d9 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1731,6 +1731,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->vq.vdev = vdev;
 	vq->vq.num_free = num;
 	vq->vq.index = index;
+	vq->vq.reset = false;
 	vq->we_own_ring = true;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
@@ -2220,6 +2221,7 @@ static int __vring_init_virtqueue(struct virtqueue *_vq,
 	vq->vq.vdev = vdev;
 	vq->vq.num_free = vring.num;
 	vq->vq.index = index;
+	vq->vq.reset = false;
 	vq->we_own_ring = false;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index dd1657c3a488..5d4817d79f3f 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -32,6 +32,7 @@ struct virtqueue {
 	unsigned int index;
 	unsigned int num_free;
 	void *priv;
+	bool reset;
 };
 
 int virtqueue_add_outbuf(struct virtqueue *vq,
-- 
2.31.0

