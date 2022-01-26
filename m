Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA4A49CF94
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbiAZQY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:24:26 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42550 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236713AbiAZQYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:24:24 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20QFkgHG012928;
        Wed, 26 Jan 2022 17:24:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=ZBqzN37n4oHnaQ9yq2tHkyXow3WAYt50NT11daFbdQ0=;
 b=MDmusndUpqJXX2bmyNIKQ6ODjDA6nf7kEjIDG/4vIyBED1n99EYZqZwGPA3th1hoXWjW
 CgyZKYhg7S9pdg5t+q3R4tcJTmHRWMeyeg3cQrgx5gxhSPpipxh5luRyx2NAIBcHdIJR
 yc65g0DsM/1NCCe7Pwajv6cnyrRK+/DXo4rtHMIJhlHaKHvm4r8OatSxHJiJ/rWJGZrG
 Q/5zSjF2a6PE4PEaqJr8c1TQ4i7fCO0GsoX6r7nTZuvS6y1a/8fahNyDJML2uvK++WyV
 mHF4OV6dlzxioUHyiBN1wx95jhYc6/FtBzyEQ/lnKO2oPk1ix5qX5EHCnzQgaSrWEOWY 9Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3du40nhw5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 17:24:15 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B9C3610002A;
        Wed, 26 Jan 2022 17:24:14 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B01B62291D2;
        Wed, 26 Jan 2022 17:24:14 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 26 Jan 2022 17:24:14
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [RFC PATCH v3 1/4] remoteproc: core: Introduce virtio device add/remove functions
Date:   Wed, 26 Jan 2022 17:24:02 +0100
Message-ID: <20220126162405.1131323-2-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126162405.1131323-1-arnaud.pouliquen@foss.st.com>
References: <20220126162405.1131323-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_05,2022-01-26_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of the migration of the management of rvdev in
remoteproc_virtio.c, this patch spins off new functions to manage the
remoteproc virtio device.
 - rproc_rvdev_add_device
 - rproc_rvdev_remove_device

The rproc_rvdev_add_device and rproc_rvdev_remove_device will be
moved to remoteproc_virtio.c.

The rproc_vdev_data structure is introduced to provide information for
the rvdev creation. This structure allows to manage the rvdev and vrings
allocation in the rproc_rvdev_add_device function.
Then the rproc_vdev_data structure will be reused in a next patch as
platform data structure when the rvdev will rely on a platform device.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
update vs previous revision:
 - rework rproc_rvdev_add_device function to better manage error cases
	- introduce rproc_vdev_data struct
	- allocate rvdev in rproc_rvdev_add_device
---
 drivers/remoteproc/remoteproc_core.c | 164 ++++++++++++++++-----------
 1 file changed, 98 insertions(+), 66 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 69f51acf235e..83ff44a6a4db 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -66,6 +66,13 @@ static const char * const rproc_crash_names[] = {
 	[RPROC_FATAL_ERROR]	= "fatal error",
 };
 
+struct rproc_vdev_data {
+	struct fw_rsc_vdev *rsc;
+	u32 rsc_offset;
+	unsigned int id;
+	unsigned int index;
+};
+
 /* translate rproc_crash_type to string */
 static const char *rproc_crash_to_string(enum rproc_crash_type type)
 {
@@ -484,74 +491,23 @@ static int copy_dma_range_map(struct device *to, struct device *from)
 	return 0;
 }
 
-/**
- * rproc_handle_vdev() - handle a vdev fw resource
- * @rproc: the remote processor
- * @ptr: the vring resource descriptor
- * @offset: offset of the resource entry
- * @avail: size of available data (for sanity checking the image)
- *
- * This resource entry requests the host to statically register a virtio
- * device (vdev), and setup everything needed to support it. It contains
- * everything needed to make it possible: the virtio device id, virtio
- * device features, vrings information, virtio config space, etc...
- *
- * Before registering the vdev, the vrings are allocated from non-cacheable
- * physically contiguous memory. Currently we only support two vrings per
- * remote processor (temporary limitation). We might also want to consider
- * doing the vring allocation only later when ->find_vqs() is invoked, and
- * then release them upon ->del_vqs().
- *
- * Note: @da is currently not really handled correctly: we dynamically
- * allocate it using the DMA API, ignoring requested hard coded addresses,
- * and we don't take care of any required IOMMU programming. This is all
- * going to be taken care of when the generic iommu-based DMA API will be
- * merged. Meanwhile, statically-addressed iommu-based firmware images should
- * use RSC_DEVMEM resource entries to map their required @da to the physical
- * address of their base CMA region (ouch, hacky!).
- *
- * Return: 0 on success, or an appropriate error code otherwise
- */
-static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
-			     int offset, int avail)
+static struct rproc_vdev *
+rproc_rvdev_add_device(struct rproc *rproc, struct rproc_vdev_data *rvdev_data)
 {
-	struct fw_rsc_vdev *rsc = ptr;
-	struct device *dev = &rproc->dev;
 	struct rproc_vdev *rvdev;
-	int i, ret;
+	struct fw_rsc_vdev *rsc = rvdev_data->rsc;
 	char name[16];
-
-	/* make sure resource isn't truncated */
-	if (struct_size(rsc, vring, rsc->num_of_vrings) + rsc->config_len >
-			avail) {
-		dev_err(dev, "vdev rsc is truncated\n");
-		return -EINVAL;
-	}
-
-	/* make sure reserved bytes are zeroes */
-	if (rsc->reserved[0] || rsc->reserved[1]) {
-		dev_err(dev, "vdev rsc has non zero reserved bytes\n");
-		return -EINVAL;
-	}
-
-	dev_dbg(dev, "vdev rsc: id %d, dfeatures 0x%x, cfg len %d, %d vrings\n",
-		rsc->id, rsc->dfeatures, rsc->config_len, rsc->num_of_vrings);
-
-	/* we currently support only two vrings per rvdev */
-	if (rsc->num_of_vrings > ARRAY_SIZE(rvdev->vring)) {
-		dev_err(dev, "too many vrings: %d\n", rsc->num_of_vrings);
-		return -EINVAL;
-	}
+	int i, ret;
 
 	rvdev = kzalloc(sizeof(*rvdev), GFP_KERNEL);
 	if (!rvdev)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	kref_init(&rvdev->refcount);
 
-	rvdev->id = rsc->id;
+	rvdev->id = rvdev_data->id;
 	rvdev->rproc = rproc;
-	rvdev->index = rproc->nb_vdev++;
+	rvdev->index = rvdev_data->index;
 
 	/* Initialise vdev subdevice */
 	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
@@ -563,7 +519,7 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
 	ret = device_register(&rvdev->dev);
 	if (ret) {
 		put_device(&rvdev->dev);
-		return ret;
+		return ERR_PTR(ret);
 	}
 
 	ret = copy_dma_range_map(&rvdev->dev, rproc->dev.parent);
@@ -576,7 +532,7 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
 	ret = dma_coerce_mask_and_coherent(&rvdev->dev,
 					   dma_get_mask(rproc->dev.parent));
 	if (ret) {
-		dev_warn(dev,
+		dev_warn(&rvdev->dev,
 			 "Failed to set DMA mask %llx. Trying to continue... (%pe)\n",
 			 dma_get_mask(rproc->dev.parent), ERR_PTR(ret));
 	}
@@ -589,7 +545,7 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
 	}
 
 	/* remember the resource offset*/
-	rvdev->rsc_offset = offset;
+	rvdev->rsc_offset = rvdev_data->rsc_offset;
 
 	/* allocate the vring resources */
 	for (i = 0; i < rsc->num_of_vrings; i++) {
@@ -605,21 +561,20 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
 
 	rproc_add_subdev(rproc, &rvdev->subdev);
 
-	return 0;
+	return rvdev;
 
 unwind_vring_allocations:
 	for (i--; i >= 0; i--)
 		rproc_free_vring(&rvdev->vring[i]);
 free_rvdev:
 	device_unregister(&rvdev->dev);
-	return ret;
+	return ERR_PTR(ret);
 }
 
-void rproc_vdev_release(struct kref *ref)
+static void rproc_rvdev_remove_device(struct rproc_vdev *rvdev)
 {
-	struct rproc_vdev *rvdev = container_of(ref, struct rproc_vdev, refcount);
-	struct rproc_vring *rvring;
 	struct rproc *rproc = rvdev->rproc;
+	struct rproc_vring *rvring;
 	int id;
 
 	for (id = 0; id < ARRAY_SIZE(rvdev->vring); id++) {
@@ -632,6 +587,83 @@ void rproc_vdev_release(struct kref *ref)
 	device_unregister(&rvdev->dev);
 }
 
+/**
+ * rproc_handle_vdev() - handle a vdev fw resource
+ * @rproc: the remote processor
+ * @ptr: the vring resource descriptor
+ * @offset: offset of the resource entry
+ * @avail: size of available data (for sanity checking the image)
+ *
+ * This resource entry requests the host to statically register a virtio
+ * device (vdev), and setup everything needed to support it. It contains
+ * everything needed to make it possible: the virtio device id, virtio
+ * device features, vrings information, virtio config space, etc...
+ *
+ * Before registering the vdev, the vrings are allocated from non-cacheable
+ * physically contiguous memory. Currently we only support two vrings per
+ * remote processor (temporary limitation). We might also want to consider
+ * doing the vring allocation only later when ->find_vqs() is invoked, and
+ * then release them upon ->del_vqs().
+ *
+ * Note: @da is currently not really handled correctly: we dynamically
+ * allocate it using the DMA API, ignoring requested hard coded addresses,
+ * and we don't take care of any required IOMMU programming. This is all
+ * going to be taken care of when the generic iommu-based DMA API will be
+ * merged. Meanwhile, statically-addressed iommu-based firmware images should
+ * use RSC_DEVMEM resource entries to map their required @da to the physical
+ * address of their base CMA region (ouch, hacky!).
+ *
+ * Return: 0 on success, or an appropriate error code otherwise
+ */
+static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
+			     int offset, int avail)
+{
+	struct fw_rsc_vdev *rsc = ptr;
+	struct device *dev = &rproc->dev;
+	struct rproc_vdev *rvdev;
+	struct rproc_vdev_data rvdev_data;
+
+	/* make sure resource isn't truncated */
+	if (struct_size(rsc, vring, rsc->num_of_vrings) + rsc->config_len >
+			avail) {
+		dev_err(dev, "vdev rsc is truncated\n");
+		return -EINVAL;
+	}
+
+	/* make sure reserved bytes are zeroes */
+	if (rsc->reserved[0] || rsc->reserved[1]) {
+		dev_err(dev, "vdev rsc has non zero reserved bytes\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "vdev rsc: id %d, dfeatures 0x%x, cfg len %d, %d vrings\n",
+		rsc->id, rsc->dfeatures, rsc->config_len, rsc->num_of_vrings);
+
+	/* we currently support only two vrings per rvdev */
+	if (rsc->num_of_vrings > ARRAY_SIZE(rvdev->vring)) {
+		dev_err(dev, "too many vrings: %d\n", rsc->num_of_vrings);
+		return -EINVAL;
+	}
+
+	rvdev_data.id = rsc->id;
+	rvdev_data.index = rproc->nb_vdev++;
+	rvdev_data.rsc_offset = offset;
+	rvdev_data.rsc = rsc;
+
+	rvdev = rproc_rvdev_add_device(rproc, &rvdev_data);
+	if (IS_ERR(rvdev))
+		return PTR_ERR(rvdev);
+
+	return 0;
+}
+
+void rproc_vdev_release(struct kref *ref)
+{
+	struct rproc_vdev *rvdev = container_of(ref, struct rproc_vdev, refcount);
+
+	rproc_rvdev_remove_device(rvdev);
+}
+
 /**
  * rproc_handle_trace() - handle a shared trace buffer resource
  * @rproc: the remote processor
-- 
2.25.1

