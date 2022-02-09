Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC42C4AF1AA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbiBIM3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbiBIM3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:29:09 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B996EC05CB86
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 04:29:12 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V4.YQgF_1644409749;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0V4.YQgF_1644409749)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Feb 2022 20:29:10 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v4 10/14] virtio_pci: queue_reset: update struct virtio_pci_common_cfg and option functions
Date:   Wed,  9 Feb 2022 20:28:57 +0800
Message-Id: <20220209122901.51790-11-xuanzhuo@linux.alibaba.com>
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

Add queue_reset in virtio_pci_common_cfg, and add related operation
functions.

For not breaks uABI, add a new struct virtio_pci_common_cfg_reset.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 36 ++++++++++++++++++++++++++
 include/linux/virtio_pci_modern.h      |  2 ++
 include/uapi/linux/virtio_pci.h        |  7 +++++
 3 files changed, 45 insertions(+)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index e11ed748e661..a35106edb27b 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -3,6 +3,7 @@
 #include <linux/virtio_pci_modern.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/delay.h>
 
 /*
  * vp_modern_map_capability - map a part of virtio pci capability
@@ -463,6 +464,41 @@ void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
 }
 EXPORT_SYMBOL_GPL(vp_modern_set_status);
 
+/*
+ * vp_modern_get_queue_reset - get the queue reset status
+ * @mdev: the modern virtio-pci device
+ * @index: queue index
+ */
+int vp_modern_get_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
+{
+	struct virtio_pci_common_cfg_reset __iomem *cfg;
+
+	cfg = (struct virtio_pci_common_cfg_reset *)mdev->common;
+
+	vp_iowrite16(index, &cfg->cfg.queue_select);
+	return vp_ioread16(&cfg->queue_reset);
+}
+EXPORT_SYMBOL_GPL(vp_modern_get_queue_reset);
+
+/*
+ * vp_modern_set_queue_reset - reset the queue
+ * @mdev: the modern virtio-pci device
+ * @index: queue index
+ */
+void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
+{
+	struct virtio_pci_common_cfg_reset __iomem *cfg;
+
+	cfg = (struct virtio_pci_common_cfg_reset *)mdev->common;
+
+	vp_iowrite16(index, &cfg->cfg.queue_select);
+	vp_iowrite16(1, &cfg->queue_reset);
+
+	while (vp_ioread16(&cfg->queue_reset) != 1)
+		msleep(1);
+}
+EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
+
 /*
  * vp_modern_queue_vector - set the MSIX vector for a specific virtqueue
  * @mdev: the modern virtio-pci device
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index eb2bd9b4077d..cc4154dd7b28 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -106,4 +106,6 @@ void __iomem * vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
 				       u16 index, resource_size_t *pa);
 int vp_modern_probe(struct virtio_pci_modern_device *mdev);
 void vp_modern_remove(struct virtio_pci_modern_device *mdev);
+int vp_modern_get_queue_reset(struct virtio_pci_modern_device *mdev, u16 index);
+void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index);
 #endif
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index 22bec9bd0dfc..d9462efd6ce8 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -173,6 +173,13 @@ struct virtio_pci_common_cfg_notify {
 	__le16 padding;
 };
 
+struct virtio_pci_common_cfg_reset {
+	struct virtio_pci_common_cfg cfg;
+
+	__le16 queue_notify_data;	/* read-write */
+	__le16 queue_reset;		/* read-write */
+};
+
 /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
 struct virtio_pci_cfg_cap {
 	struct virtio_pci_cap cap;
-- 
2.31.0

