Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9112847CE2C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243353AbhLVIYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:24:12 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:40946 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243309AbhLVIYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:24:00 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BM1nx1W001281;
        Wed, 22 Dec 2021 09:23:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=cW1XKxVQ3gNR6IkwBl5MQb9itHtVpcIlflSW4RNdt+Y=;
 b=2M97OT1hsIzohmP8+yNJ7H3m1xBaFMJATFBtNrrSBOcH/x6RKy3be8cTPQ3TmMmCY1N4
 NqLVUelJMTn3h4yc+NLd2b53pXpzMcYy3XDa/5oKDada8wLbIDIaOxoE5g53z54bTLSr
 xn2BFaHx+sxCjDG6Fg4nk+/vIx3rxRGg34Re8Rp/EEqDcpnD9mwJPFiWQVDIcBrfsLMl
 AVB0MiWkRNH7fWjRGrrDVSfBXlUaWhgYfy5Bi3IBUb5rvmRLUCI4yU1EyNP36SJa3t11
 q8sJIM40TsdKP2H3USdCIrCEHpKiDnujZo7KtbqFEGPYCgVVn/NtBKhyY6/0Fan6nJqT 2g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3d3bq05djm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 09:23:58 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6D1A0100038;
        Wed, 22 Dec 2021 09:23:58 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6488F2221D6;
        Wed, 22 Dec 2021 09:23:58 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 22 Dec 2021 09:23:57
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [RFC PATCH v2 6/6] remoteproc: Instantiate the new remoteproc virtio platform device
Date:   Wed, 22 Dec 2021 09:23:49 +0100
Message-ID: <20211222082349.30378-7-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211222082349.30378-1-arnaud.pouliquen@foss.st.com>
References: <20211222082349.30378-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-22_03,2021-12-21_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migrate from the rvdev device to the rvdev platform device.
From this patch, when a vdev resource is found in the resource table
the remoteproc core register a platform device.

All reference to the rvdev->dev has been updated to rvdev-pdev->dev

The use of kref counter is replaced by get/put_device on the remoteproc
virtio device.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

---
Update vs previous revision:
  - rework comments around virtio platform device creation
---
 drivers/remoteproc/remoteproc_core.c     | 48 +++++++-----
 drivers/remoteproc/remoteproc_internal.h |  2 -
 drivers/remoteproc/remoteproc_virtio.c   | 99 ++++++------------------
 include/linux/remoteproc.h               |  4 -
 4 files changed, 52 insertions(+), 101 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index ca2fe8d9cac8..4f332ec0fdd0 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -465,6 +465,8 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
 {
 	struct fw_rsc_vdev *rsc = ptr;
 	struct device *dev = &rproc->dev;
+	struct rproc_vdev_pdata vdev_data;
+	struct platform_device *pdev;
 	struct rproc_vdev *rvdev;
 	int i, ret;
 
@@ -484,25 +486,36 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
 	dev_dbg(dev, "vdev rsc: id %d, dfeatures 0x%x, cfg len %d, %d vrings\n",
 		rsc->id, rsc->dfeatures, rsc->config_len, rsc->num_of_vrings);
 
-	/* we currently support only two vrings per rvdev */
-	if (rsc->num_of_vrings > ARRAY_SIZE(rvdev->vring)) {
-		dev_err(dev, "too many vrings: %d\n", rsc->num_of_vrings);
-		return -EINVAL;
-	}
+	/* Register a remoteproc virtio platform device in charge of the virtio device */
+	vdev_data.rsc_offset = offset;
+	vdev_data.id  = rsc->id;
+	vdev_data.index  = rproc->nb_vdev;
 
-	rvdev = kzalloc(sizeof(*rvdev), GFP_KERNEL);
-	if (!rvdev)
-		return -ENOMEM;
+	pdev = rproc_virtio_register_device(rproc, &vdev_data);
+	if (PTR_ERR_OR_ZERO(pdev)) {
+		dev_err(rproc->dev.parent,
+			"failed to create rproc-virtio device\n");
+		return PTR_ERR_OR_ZERO(pdev);
+	}
 
-	kref_init(&rvdev->refcount);
+	/*
+	 * At this point the registered remoteproc virtio platform device should has been probed.
+	 * Get the associated rproc_vdev struct to assign the vrings
+	 */
+	rvdev = platform_get_drvdata(pdev);
+	if (WARN_ON(!rvdev)) {
+		ret = -EINVAL;
+		goto free_rvdev;
+	}
 
-	rvdev->id = rsc->id;
-	rvdev->rproc = rproc;
-	rvdev->index = rproc->nb_vdev++;
+	rproc->nb_vdev++;
 
-	ret = rproc_rvdev_add_device(rvdev);
-	if (ret)
+	/* we currently support only two vrings per rvdev */
+	if (rsc->num_of_vrings > ARRAY_SIZE(rvdev->vring)) {
+		dev_err(dev, "too many vrings: %d\n", rsc->num_of_vrings);
+		ret = -EINVAL;
 		goto free_rvdev;
+	}
 
 	/* parse the vrings */
 	for (i = 0; i < rsc->num_of_vrings; i++) {
@@ -511,9 +524,6 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
 			goto free_rvdev;
 	}
 
-	/* remember the resource offset*/
-	rvdev->rsc_offset = offset;
-
 	/* allocate the vring resources */
 	for (i = 0; i < rsc->num_of_vrings; i++) {
 		ret = rproc_alloc_vring(rvdev, i);
@@ -527,7 +537,7 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
 	for (i--; i >= 0; i--)
 		rproc_free_vring(&rvdev->vring[i]);
 free_rvdev:
-	device_unregister(&rvdev->dev);
+	rproc_virtio_unregister_device(rvdev);
 	return ret;
 }
 
@@ -1266,7 +1276,7 @@ void rproc_resource_cleanup(struct rproc *rproc)
 
 	/* clean up remote vdev entries */
 	list_for_each_entry_safe(rvdev, rvtmp, &rproc->rvdevs, node)
-		kref_put(&rvdev->refcount, rproc_vdev_release);
+		rproc_virtio_unregister_device(rvdev);
 
 	rproc_coredump_cleanup(rproc);
 }
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index 3007d29a26e1..1479c5e33e2e 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -36,12 +36,10 @@ int rproc_of_parse_firmware(struct device *dev, int index,
 			    const char **fw_name);
 
 /* from remoteproc_virtio.c */
-int rproc_rvdev_add_device(struct rproc_vdev *rvdev);
 struct platform_device *
 rproc_virtio_register_device(struct rproc *rproc, struct rproc_vdev_pdata *vdev_data);
 void rproc_virtio_unregister_device(struct rproc_vdev *rvdev);
 irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
-void rproc_vdev_release(struct kref *ref);
 
 /* from remoteproc_debugfs.c */
 void rproc_remove_trace_file(struct dentry *tfile);
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 5eef679cc520..55e797095bfe 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -48,7 +48,11 @@ static int copy_dma_range_map(struct device *to, struct device *from)
 
 static struct rproc_vdev *vdev_to_rvdev(struct virtio_device *vdev)
 {
-	return container_of(vdev->dev.parent, struct rproc_vdev, dev);
+	struct platform_device *pdev;
+
+	pdev = container_of(vdev->dev.parent, struct platform_device, dev);
+
+	return platform_get_drvdata(pdev);
 }
 
 static  struct rproc *vdev_to_rproc(struct virtio_device *vdev)
@@ -343,13 +347,10 @@ static void rproc_virtio_dev_release(struct device *dev)
 {
 	struct virtio_device *vdev = dev_to_virtio(dev);
 	struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
-	struct rproc *rproc = vdev_to_rproc(vdev);
 
 	kfree(vdev);
 
-	kref_put(&rvdev->refcount, rproc_vdev_release);
-
-	put_device(&rproc->dev);
+	put_device(&rvdev->pdev->dev);
 }
 
 /**
@@ -365,7 +366,7 @@ static void rproc_virtio_dev_release(struct device *dev)
 static int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
 {
 	struct rproc *rproc = rvdev->rproc;
-	struct device *dev = &rvdev->dev;
+	struct device *dev = &rvdev->pdev->dev;
 	struct virtio_device *vdev;
 	struct rproc_mem_entry *mem;
 	int ret;
@@ -436,17 +437,15 @@ static int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
 	vdev->dev.release = rproc_virtio_dev_release;
 
 	/*
-	 * We're indirectly making a non-temporary copy of the rproc pointer
+	 * We're indirectly making a non-temporary copy of the rvdev pointer
 	 * here, because drivers probed with this vdev will indirectly
 	 * access the wrapping rproc.
 	 *
-	 * Therefore we must increment the rproc refcount here, and decrement
+	 * Therefore we must increment the rvdev refcount here, and decrement
 	 * it _only_ when the vdev is released.
 	 */
-	get_device(&rproc->dev);
+	get_device(dev);
 
-	/* Reference the vdev and vring allocations */
-	kref_get(&rvdev->refcount);
 
 	ret = register_virtio_device(vdev);
 	if (ret) {
@@ -488,56 +487,30 @@ static int rproc_vdev_do_start(struct rproc_subdev *subdev)
 static void rproc_vdev_do_stop(struct rproc_subdev *subdev, bool crashed)
 {
 	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
+	struct device *dev = &rvdev->pdev->dev;
 	int ret;
 
-	ret = device_for_each_child(&rvdev->dev, NULL, rproc_remove_virtio_dev);
+	ret = device_for_each_child(dev, NULL, rproc_remove_virtio_dev);
 	if (ret)
-		dev_warn(&rvdev->dev, "can't remove vdev child device: %d\n", ret);
-}
-
-/**
- * rproc_rvdev_release() - release the existence of a rvdev
- *
- * @dev: the subdevice's dev
- */
-static void rproc_rvdev_release(struct device *dev)
-{
-	struct rproc_vdev *rvdev = container_of(dev, struct rproc_vdev, dev);
-
-	of_reserved_mem_device_release(dev);
-
-	kfree(rvdev);
+		dev_warn(dev, "can't remove vdev child device: %d\n", ret);
 }
 
-int rproc_rvdev_add_device(struct rproc_vdev *rvdev)
+static int rproc_rvdev_add_device(struct rproc_vdev *rvdev)
 {
 	struct rproc *rproc = rvdev->rproc;
-	char name[16];
+	struct device *dev = &rvdev->pdev->dev;
 	int ret;
 
-	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
-	rvdev->dev.parent = &rproc->dev;
-	rvdev->dev.release = rproc_rvdev_release;
-	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
-	dev_set_drvdata(&rvdev->dev, rvdev);
-
-	ret = device_register(&rvdev->dev);
-	if (ret) {
-		put_device(&rvdev->dev);
-		return ret;
-	}
-	ret = copy_dma_range_map(&rvdev->dev, rproc->dev.parent);
+	ret = copy_dma_range_map(dev, rproc->dev.parent);
 	if (ret)
-		goto free_rvdev;
+		return ret;
 
 	/* Make device dma capable by inheriting from parent's capabilities */
-	set_dma_ops(&rvdev->dev, get_dma_ops(rproc->dev.parent));
+	set_dma_ops(dev, get_dma_ops(rproc->dev.parent));
 
-	ret = dma_coerce_mask_and_coherent(&rvdev->dev,
-					   dma_get_mask(rproc->dev.parent));
+	ret = dma_coerce_mask_and_coherent(dev, dma_get_mask(rproc->dev.parent));
 	if (ret) {
-		dev_warn(&rvdev->dev,
-			 "Failed to set DMA mask %llx. Trying to continue... (%pe)\n",
+		dev_warn(dev, "Failed to set DMA mask %llx. Trying to continue... (%pe)\n",
 			 dma_get_mask(rproc->dev.parent), ERR_PTR(ret));
 	}
 
@@ -548,34 +521,9 @@ int rproc_rvdev_add_device(struct rproc_vdev *rvdev)
 
 	rproc_add_subdev(rproc, &rvdev->subdev);
 
-	return 0;
+	dev_dbg(dev, "virtio dev %d added\n",  rvdev->index);
 
-free_rvdev:
-	device_unregister(&rvdev->dev);
-	return ret;
-}
-
-static void rproc_rvdev_remove_device(struct rproc_vdev *rvdev)
-{
-	struct rproc *rproc = rvdev->rproc;
-
-	rproc_remove_subdev(rproc, &rvdev->subdev);
-	rproc_unregister_rvdev(rvdev);
-	device_unregister(&rvdev->dev);
-}
-
-void rproc_vdev_release(struct kref *ref)
-{
-	struct rproc_vdev *rvdev = container_of(ref, struct rproc_vdev, refcount);
-	struct rproc_vring *rvring;
-	int id;
-
-	for (id = 0; id < ARRAY_SIZE(rvdev->vring); id++) {
-		rvring = &rvdev->vring[id];
-		rproc_free_vring(rvring);
-	}
-
-	rproc_rvdev_remove_device(rvdev);
+	return 0;
 }
 
 /**
@@ -594,8 +542,7 @@ rproc_virtio_register_device(struct rproc *rproc, struct rproc_vdev_pdata *vdev_
 	pdev = platform_device_register_data(dev, "rproc-virtio", vdev_data->index, vdev_data,
 					     sizeof(*vdev_data));
 	if (PTR_ERR_OR_ZERO(pdev)) {
-		dev_err(rproc->dev.parent,
-			"failed to create rproc-virtio device\n");
+		dev_err(rproc->dev.parent, "failed to create rproc-virtio device\n");
 	}
 
 	return  pdev;
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 542a3d4664f2..7951a3e2b62a 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -614,10 +614,8 @@ struct rproc_vring {
 
 /**
  * struct rproc_vdev - remoteproc state for a supported virtio device
- * @refcount: reference counter for the vdev and vring allocations
  * @subdev: handle for registering the vdev as a rproc subdevice
  * @pdev: remoteproc virtio platform device
- * @dev: device struct used for reference count semantics
  * @id: virtio device id (as in virtio_ids.h)
  * @node: list node
  * @rproc: the rproc handle
@@ -626,11 +624,9 @@ struct rproc_vring {
  * @index: vdev position versus other vdev declared in resource table
  */
 struct rproc_vdev {
-	struct kref refcount;
 
 	struct rproc_subdev subdev;
 	struct platform_device *pdev;
-	struct device dev;
 
 	unsigned int id;
 	struct list_head node;
-- 
2.17.1

