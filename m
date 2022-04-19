Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7E55061C2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245734AbiDSBnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 21:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243639AbiDSBnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 21:43:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42E9D25C6D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 18:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650332437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bYi67t2Ux3bqVGxoin0gV6WFhZicjaIMrGO5HEfCoSU=;
        b=NEnX1HgGB1CHUX303W6FpxC8rNSFSbb8nrlfA9KhNTh4Sd5SfDch0RVExbWUfRV+ka7j/V
        jkBWo20zUT8uwEEui6RoFTlHwE//tw5INnVOhYapWgqvR7KW36FhIZ3wPBo3ugD9CFyoqR
        vwz43m/GMWRb6gav4WiNyFpNs67BK4A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-sKMkY2m5Oouq5XszuUzx6w-1; Mon, 18 Apr 2022 21:40:34 -0400
X-MC-Unique: sKMkY2m5Oouq5XszuUzx6w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B774380406D;
        Tue, 19 Apr 2022 01:40:33 +0000 (UTC)
Received: from server.redhat.com (ovpn-12-92.pek2.redhat.com [10.72.12.92])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F28B5374FC;
        Tue, 19 Apr 2022 01:40:30 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, mst@redhat.com, jasowang@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v1] vdpa/vp_vdpa : add vdpa tool support in vp_vdpa
Date:   Tue, 19 Apr 2022 09:40:25 +0800
Message-Id: <20220419014025.218121-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch is to add the support for vdpa tool in vp_vdpa
here is the example steps
modprobe vp_vdpa
modprobe vhost_vdpa

echo 0000:00:06.0>/sys/bus/pci/drivers/virtio-pci/unbind
echo 1af4 1041 > /sys/bus/pci/drivers/vp-vdpa/new_id

vdpa dev add name vdpa1 mgmtdev pci/0000:00:06.0

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 86 ++++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index cce101e6a940..d8a1d2f8e9bb 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -17,6 +17,8 @@
 #include <linux/virtio_ring.h>
 #include <linux/virtio_pci.h>
 #include <linux/virtio_pci_modern.h>
+#include <uapi/linux/virtio_net.h>
+#include <uapi/linux/vdpa.h>
 
 #define VP_VDPA_QUEUE_MAX 256
 #define VP_VDPA_DRIVER_NAME "vp_vdpa"
@@ -41,6 +43,18 @@ struct vp_vdpa {
 	int vectors;
 };
 
+struct vp_vdpa_mgmtdev {
+	struct vdpa_mgmt_dev mgtdev;
+	struct vp_vdpa *vp_vdpa;
+	struct pci_dev *pdev;
+};
+
+#define VP_VDPA_NET_FEATURES                                                   \
+	((1ULL << VIRTIO_F_ANY_LAYOUT) | (1ULL << VIRTIO_F_VERSION_1) |        \
+	 (1ULL << VIRTIO_F_ACCESS_PLATFORM))
+
+#define VP_VDPA_NET_VQ_NUM 2
+
 static struct vp_vdpa *vdpa_to_vp(struct vdpa_device *vdpa)
 {
 	return container_of(vdpa, struct vp_vdpa, vdpa);
@@ -454,9 +468,14 @@ static void vp_vdpa_free_irq_vectors(void *data)
 	pci_free_irq_vectors(data);
 }
 
-static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
+			   const struct vdpa_dev_set_config *add_config)
 {
+	struct vp_vdpa_mgmtdev *vp_vdpa_mgtdev =
+		container_of(v_mdev, struct vp_vdpa_mgmtdev, mgtdev);
+
 	struct virtio_pci_modern_device *mdev;
+	struct pci_dev *pdev = vp_vdpa_mgtdev->pdev;
 	struct device *dev = &pdev->dev;
 	struct vp_vdpa *vp_vdpa;
 	int ret, i;
@@ -465,8 +484,9 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		return ret;
 
-	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
-				    dev, &vp_vdpa_ops, NULL, false);
+	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa, dev, &vp_vdpa_ops,
+				    name, false);
+
 	if (IS_ERR(vp_vdpa)) {
 		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
 		return PTR_ERR(vp_vdpa);
@@ -480,9 +500,10 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		dev_err(&pdev->dev, "Failed to probe modern PCI device\n");
 		goto err;
 	}
+	vp_vdpa_mgtdev->vp_vdpa = vp_vdpa;
 
 	pci_set_master(pdev);
-	pci_set_drvdata(pdev, vp_vdpa);
+	pci_set_drvdata(pdev, vp_vdpa_mgtdev);
 
 	vp_vdpa->vdpa.dma_dev = &pdev->dev;
 	vp_vdpa->queues = vp_modern_get_num_queues(mdev);
@@ -516,7 +537,8 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 	vp_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
 
-	ret = vdpa_register_device(&vp_vdpa->vdpa, vp_vdpa->queues);
+	vp_vdpa->vdpa.mdev = &vp_vdpa_mgtdev->mgtdev;
+	ret = _vdpa_register_device(&vp_vdpa->vdpa, vp_vdpa->queues);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register to vdpa bus\n");
 		goto err;
@@ -529,12 +551,60 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ret;
 }
 
-static void vp_vdpa_remove(struct pci_dev *pdev)
+static void vp_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev,
+			    struct vdpa_device *dev)
 {
-	struct vp_vdpa *vp_vdpa = pci_get_drvdata(pdev);
+	struct vp_vdpa_mgmtdev *vp_vdpa_mgtdev =
+		container_of(v_mdev, struct vp_vdpa_mgmtdev, mgtdev);
+
+	struct vp_vdpa *vp_vdpa = vp_vdpa_mgtdev->vp_vdpa;
 
 	vp_modern_remove(&vp_vdpa->mdev);
-	vdpa_unregister_device(&vp_vdpa->vdpa);
+	_vdpa_unregister_device(&vp_vdpa->vdpa);
+	vp_vdpa_mgtdev->vp_vdpa = NULL;
+}
+
+static const struct vdpa_mgmtdev_ops vp_vdpa_mdev_ops = {
+	.dev_add = vp_vdpa_dev_add,
+	.dev_del = vp_vdpa_dev_del,
+};
+
+static struct virtio_device_id vp_vdpa_id_table[] = {
+	{ VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct vp_vdpa_mgmtdev *vp_vdpa_mgtdev;
+	struct vdpa_mgmt_dev *mgtdev;
+	struct device *dev = &pdev->dev;
+	int err;
+
+	vp_vdpa_mgtdev = kzalloc(sizeof(*vp_vdpa_mgtdev), GFP_KERNEL);
+	if (!vp_vdpa_mgtdev)
+		return -ENOMEM;
+	mgtdev = &vp_vdpa_mgtdev->mgtdev;
+
+	mgtdev->ops = &vp_vdpa_mdev_ops;
+	mgtdev->device = dev;
+	mgtdev->id_table = vp_vdpa_id_table;
+	vp_vdpa_mgtdev->pdev = pdev;
+
+	mgtdev->max_supported_vqs = VP_VDPA_NET_VQ_NUM;
+	mgtdev->supported_features = VP_VDPA_NET_FEATURES;
+
+	err = vdpa_mgmtdev_register(mgtdev);
+
+	return err;
+}
+
+static void vp_vdpa_remove(struct pci_dev *pdev)
+{
+	struct vp_vdpa_mgmtdev *vp_vdpa_mgtdev = pci_get_drvdata(pdev);
+
+	vdpa_mgmtdev_unregister(&vp_vdpa_mgtdev->mgtdev);
+	kfree(vp_vdpa_mgtdev);
 }
 
 static struct pci_driver vp_vdpa_driver = {
-- 
2.34.1

