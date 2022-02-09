Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A6E4AF1A4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiBIMaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbiBIM3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:29:12 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C31BC05CB9E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 04:29:15 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V4.E4Dp_1644409752;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0V4.E4Dp_1644409752)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Feb 2022 20:29:12 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v4 13/14] virtio_pci: queue_reset: vp_setup_vq() support ring_num
Date:   Wed,  9 Feb 2022 20:29:00 +0800
Message-Id: <20220209122901.51790-14-xuanzhuo@linux.alibaba.com>
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

vp_setup_vq() adds parameter ring_num to allow specifying ring num
during setup.

This can be used to implement virtio-net support set_ringparm(ethtool
-G eth0 rx 128 tx 128)

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_pci_common.c | 8 ++++----
 drivers/virtio/virtio_pci_common.h | 5 +++--
 drivers/virtio/virtio_pci_legacy.c | 3 ++-
 drivers/virtio/virtio_pci_modern.c | 9 ++++++++-
 4 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 5a4f750a0b97..cb01eb0cb2e4 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -209,7 +209,7 @@ struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned int index,
 			      void (*callback)(struct virtqueue *vq),
 			      const char *name,
 			      bool ctx,
-			      u16 msix_vec)
+			      u16 msix_vec, u16 ring_num)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtio_pci_vq_info *info;
@@ -226,7 +226,7 @@ struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned int index,
 	}
 
 	vq = vp_dev->setup_vq(vp_dev, info, index, callback, name, ctx,
-			      msix_vec, info->vq);
+			      msix_vec, info->vq, ring_num);
 	if (IS_ERR(vq))
 		goto out_info;
 
@@ -375,7 +375,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 			msix_vec = VP_MSIX_VQ_VECTOR;
 		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
 				     ctx ? ctx[i] : false,
-				     msix_vec);
+				     msix_vec, 0);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto error_find;
@@ -430,7 +430,7 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned nvqs,
 		}
 		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
 				     ctx ? ctx[i] : false,
-				     VIRTIO_MSI_NO_VECTOR);
+				     VIRTIO_MSI_NO_VECTOR, 0);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto out_del_vqs;
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 696e3f6a493b..41051d29152c 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -85,7 +85,8 @@ struct virtio_pci_device {
 				      const char *name,
 				      bool ctx,
 				      u16 msix_vec,
-				      struct virtqueue *vq);
+				      struct virtqueue *vq,
+				      u16 ring_num);
 	void (*del_vq)(struct virtio_pci_vq_info *info);
 
 	u16 (*config_vector)(struct virtio_pci_device *vp_dev, u16 vector);
@@ -122,7 +123,7 @@ struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned int index,
 			      void (*callback)(struct virtqueue *vq),
 			      const char *name,
 			      bool ctx,
-			      u16 msix_vec);
+			      u16 msix_vec, u16 ring_num);
 const char *vp_bus_name(struct virtio_device *vdev);
 
 /* Setup the affinity for a virtqueue:
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index aa28a02d11f2..9bc41b764624 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -114,7 +114,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				  const char *name,
 				  bool ctx,
 				  u16 msix_vec,
-				  struct virtqueue *vq)
+				  struct virtqueue *vq,
+				  u16 ring_num)
 {
 	u16 num;
 	int err;
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 5af82948f0ae..d29d40bf0b45 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -188,7 +188,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				  const char *name,
 				  bool ctx,
 				  u16 msix_vec,
-				  struct virtqueue *vq)
+				  struct virtqueue *vq,
+				  u16 ring_num)
 {
 
 	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
@@ -203,6 +204,12 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	if (!num || vp_modern_get_queue_enable(mdev, index))
 		return ERR_PTR(-ENOENT);
 
+	if (ring_num) {
+		if (ring_num > num)
+			return ERR_PTR(-ENOENT);
+		num = ring_num;
+	}
+
 	if (num & (num - 1)) {
 		dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u", num);
 		return ERR_PTR(-EINVAL);
-- 
2.31.0

