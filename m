Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D8850D96D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbiDYGbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiDYGa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:30:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6BA55C64F
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 23:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650868069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oyrzonQQXBIQINkOUKYQ7zVRV1aNMaEMlygj9cC6uO0=;
        b=TCmH3GUKZlxqIsMFqhGvsB+ItnqXI3SqSRYsLhtAfJaLpNFTFb6lZXxtecerZpF9ET3R6U
        nuzAccpetYBAeqGdKwUpGSlmhUOk7KTCzwY2LGYSIKeIrf/U8D6IxqabZfEwmIwjzsDqa1
        wKuXp609FSRxoRqOa0ZAPAkWoFet9Sw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-XCFsmtCeOqGoruZymLIm4A-1; Mon, 25 Apr 2022 02:27:48 -0400
X-MC-Unique: XCFsmtCeOqGoruZymLIm4A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F340280159B;
        Mon, 25 Apr 2022 06:27:47 +0000 (UTC)
Received: from server.redhat.com (ovpn-12-110.pek2.redhat.com [10.72.12.110])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6886F4047295;
        Mon, 25 Apr 2022 06:27:45 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, lulu@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] vdpa/vp_vdpa : add vdpa tool support in vp_vdpa
Date:   Mon, 25 Apr 2022 14:27:34 +0800
Message-Id: <20220425062735.172576-2-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/vdpa/virtio_pci/vp_vdpa.c | 138 +++++++++++++++++++++++-------
 1 file changed, 106 insertions(+), 32 deletions(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index cce101e6a940..873402977543 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -32,7 +32,8 @@ struct vp_vring {
 
 struct vp_vdpa {
 	struct vdpa_device vdpa;
-	struct virtio_pci_modern_device mdev;
+	/* this is an pointer point to the mdev in vp_vdpa_mgmtdev*/
+	struct virtio_pci_modern_device *mdev;
 	struct vp_vring *vring;
 	struct vdpa_callback config_cb;
 	char msix_name[VP_VDPA_NAME_SIZE];
@@ -41,6 +42,12 @@ struct vp_vdpa {
 	int vectors;
 };
 
+struct vp_vdpa_mgmtdev {
+	struct vdpa_mgmt_dev mgtdev;
+	struct virtio_pci_modern_device mdev;
+	struct vp_vdpa *vp_vdpa;
+};
+
 static struct vp_vdpa *vdpa_to_vp(struct vdpa_device *vdpa)
 {
 	return container_of(vdpa, struct vp_vdpa, vdpa);
@@ -50,7 +57,12 @@ static struct virtio_pci_modern_device *vdpa_to_mdev(struct vdpa_device *vdpa)
 {
 	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
 
-	return &vp_vdpa->mdev;
+	return vp_vdpa->mdev;
+}
+
+static struct virtio_pci_modern_device *vp_vdpa_to_mdev(struct vp_vdpa *vp_vdpa)
+{
+	return vp_vdpa->mdev;
 }
 
 static u64 vp_vdpa_get_device_features(struct vdpa_device *vdpa)
@@ -96,7 +108,7 @@ static int vp_vdpa_get_vq_irq(struct vdpa_device *vdpa, u16 idx)
 
 static void vp_vdpa_free_irq(struct vp_vdpa *vp_vdpa)
 {
-	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
+	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
 	struct pci_dev *pdev = mdev->pci_dev;
 	int i;
 
@@ -143,7 +155,7 @@ static irqreturn_t vp_vdpa_config_handler(int irq, void *arg)
 
 static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
 {
-	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
+	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
 	struct pci_dev *pdev = mdev->pci_dev;
 	int i, ret, irq;
 	int queues = vp_vdpa->queues;
@@ -198,7 +210,7 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
 static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
 {
 	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
-	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
+	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
 	u8 s = vp_vdpa_get_status(vdpa);
 
 	if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
@@ -212,7 +224,7 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
 static int vp_vdpa_reset(struct vdpa_device *vdpa)
 {
 	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
-	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
+	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
 	u8 s = vp_vdpa_get_status(vdpa);
 
 	vp_modern_set_status(mdev, 0);
@@ -372,7 +384,7 @@ static void vp_vdpa_get_config(struct vdpa_device *vdpa,
 			       void *buf, unsigned int len)
 {
 	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
-	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
+	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
 	u8 old, new;
 	u8 *p;
 	int i;
@@ -392,7 +404,7 @@ static void vp_vdpa_set_config(struct vdpa_device *vdpa,
 			       unsigned int len)
 {
 	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
-	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
+	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
 	const u8 *p = buf;
 	int i;
 
@@ -412,7 +424,7 @@ static struct vdpa_notification_area
 vp_vdpa_get_vq_notification(struct vdpa_device *vdpa, u16 qid)
 {
 	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
-	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
+	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
 	struct vdpa_notification_area notify;
 
 	notify.addr = vp_vdpa->vring[qid].notify_pa;
@@ -454,38 +466,31 @@ static void vp_vdpa_free_irq_vectors(void *data)
 	pci_free_irq_vectors(data);
 }
 
-static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
+			   const struct vdpa_dev_set_config *add_config)
 {
-	struct virtio_pci_modern_device *mdev;
+	struct vp_vdpa_mgmtdev *vp_vdpa_mgtdev =
+		container_of(v_mdev, struct vp_vdpa_mgmtdev, mgtdev);
+
+	struct virtio_pci_modern_device *mdev = &vp_vdpa_mgtdev->mdev;
+	struct pci_dev *pdev = mdev->pci_dev;
 	struct device *dev = &pdev->dev;
-	struct vp_vdpa *vp_vdpa;
+	struct vp_vdpa *vp_vdpa = NULL;
 	int ret, i;
 
-	ret = pcim_enable_device(pdev);
-	if (ret)
-		return ret;
+	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa, dev, &vp_vdpa_ops,
+				    name, false);
 
-	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
-				    dev, &vp_vdpa_ops, NULL, false);
 	if (IS_ERR(vp_vdpa)) {
 		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
 		return PTR_ERR(vp_vdpa);
 	}
 
-	mdev = &vp_vdpa->mdev;
-	mdev->pci_dev = pdev;
-
-	ret = vp_modern_probe(mdev);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to probe modern PCI device\n");
-		goto err;
-	}
-
-	pci_set_master(pdev);
-	pci_set_drvdata(pdev, vp_vdpa);
+	vp_vdpa_mgtdev->vp_vdpa = vp_vdpa;
 
 	vp_vdpa->vdpa.dma_dev = &pdev->dev;
 	vp_vdpa->queues = vp_modern_get_num_queues(mdev);
+	vp_vdpa->mdev = mdev;
 
 	ret = devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors, pdev);
 	if (ret) {
@@ -516,7 +521,8 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 	vp_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
 
-	ret = vdpa_register_device(&vp_vdpa->vdpa, vp_vdpa->queues);
+	vp_vdpa->vdpa.mdev = &vp_vdpa_mgtdev->mgtdev;
+	ret = _vdpa_register_device(&vp_vdpa->vdpa, vp_vdpa->queues);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register to vdpa bus\n");
 		goto err;
@@ -529,12 +535,80 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ret;
 }
 
+static void vp_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev,
+			    struct vdpa_device *dev)
+{
+	struct vp_vdpa_mgmtdev *vp_vdpa_mgtdev =
+		container_of(v_mdev, struct vp_vdpa_mgmtdev, mgtdev);
+
+	struct vp_vdpa *vp_vdpa = vp_vdpa_mgtdev->vp_vdpa;
+
+	_vdpa_unregister_device(&vp_vdpa->vdpa);
+	vp_vdpa_mgtdev->vp_vdpa = NULL;
+}
+
+static const struct vdpa_mgmtdev_ops vp_vdpa_mdev_ops = {
+	.dev_add = vp_vdpa_dev_add,
+	.dev_del = vp_vdpa_dev_del,
+};
+
+static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct vp_vdpa_mgmtdev *vp_vdpa_mgtdev = NULL;
+	struct vdpa_mgmt_dev *mgtdev;
+	struct device *dev = &pdev->dev;
+	struct virtio_pci_modern_device *mdev;
+	int err;
+
+	vp_vdpa_mgtdev = kzalloc(sizeof(*vp_vdpa_mgtdev), GFP_KERNEL);
+	if (!vp_vdpa_mgtdev)
+		return -ENOMEM;
+
+	mgtdev = &vp_vdpa_mgtdev->mgtdev;
+	mgtdev->ops = &vp_vdpa_mdev_ops;
+	mgtdev->device = dev;
+	/* only dynamic ids */
+	mgtdev->id_table = NULL;
+	mdev = &vp_vdpa_mgtdev->mdev;
+	mdev->pci_dev = pdev;
+
+	err = pcim_enable_device(pdev);
+	if (err) {
+		goto err;
+	}
+
+	err = vp_modern_probe(mdev);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to probe modern PCI device\n");
+		goto err;
+	}
+
+	mgtdev->max_supported_vqs = vp_modern_get_num_queues(mdev);
+	mgtdev->supported_features = vp_modern_get_features(mdev);
+	pci_set_master(pdev);
+	pci_set_drvdata(pdev, vp_vdpa_mgtdev);
+
+	err = vdpa_mgmtdev_register(mgtdev);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to register vdpa mgmtdev device\n");
+		vp_modern_remove(&vp_vdpa_mgtdev->mdev);
+		goto err;
+	}
+
+	return 0;
+err:
+
+	kfree(vp_vdpa_mgtdev);
+	return err;
+}
+
 static void vp_vdpa_remove(struct pci_dev *pdev)
 {
-	struct vp_vdpa *vp_vdpa = pci_get_drvdata(pdev);
+	struct vp_vdpa_mgmtdev *vp_vdpa_mgtdev = pci_get_drvdata(pdev);
 
-	vp_modern_remove(&vp_vdpa->mdev);
-	vdpa_unregister_device(&vp_vdpa->vdpa);
+	vp_modern_remove(&vp_vdpa_mgtdev->mdev);
+	vdpa_mgmtdev_unregister(&vp_vdpa_mgtdev->mgtdev);
+	kfree(vp_vdpa_mgtdev);
 }
 
 static struct pci_driver vp_vdpa_driver = {
-- 
2.34.1

