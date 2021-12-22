Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03A647CE27
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243316AbhLVIYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:24:03 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:40912 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239783AbhLVIX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:23:58 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BM280tg001197;
        Wed, 22 Dec 2021 09:23:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=vf8rbUJ7NxKN2ohnULxLV1BxA9EV0HlFx+7ZMG0y00k=;
 b=jBOHogAADOyORG7jyeGLkbtU3cFhcU4Zw8gmIK+ZgskKUVysqfQ/BKg9GBVCd2p3YTGO
 Xy+c21/xEwNvo/GAI1mOt8rc6lPXGiFmGYQITYxUJp3yp9+8uwfkUy5jz0imOpc1wale
 4xjpbxBcHOJ+gsJ0fzLwicWpMhatUw0zQ14jj3dfAirNrnhX+mP53D3I1JkcZMZ71s1f
 54Ip6SVAY91qsj43EDyp8bq1SuU9pZM9wONUy3G1S/WeHG3d/A49ejnlT5/dTqvxtyQv
 r3lgnPXoFxPyMxWiBvttSXyPVgOwlC5J5xPQpJh/RsdUcZ4Hnn/ehHjA+MYR3go/88Lc 2w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3d3bq05dje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 09:23:56 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0180C10002A;
        Wed, 22 Dec 2021 09:23:56 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EC12D2221D6;
        Wed, 22 Dec 2021 09:23:55 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 22 Dec 2021 09:23:55
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [RFC PATCH v2 3/6] remoteproc: Move rproc_vdev management to remoteproc_virtio.c
Date:   Wed, 22 Dec 2021 09:23:46 +0100
Message-ID: <20211222082349.30378-4-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211222082349.30378-1-arnaud.pouliquen@foss.st.com>
References: <20211222082349.30378-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-22_03,2021-12-21_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move functions related to the management of the rproc_vdev
structure in the remoteproc_virtio.c.
The aim is to decorrelate as possible the virtio management form
the core part.

Due to the strong correlation between the vrings and the resource table
the vrings management is kept in the remoteproc core.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
Update vs previous revision:
- update title
- Fix typo
- remove dma-map-ops.h and dma-direct.h useless includes in remoteproc_core.c.
---
 drivers/remoteproc/remoteproc_core.c     | 133 -----------------------
 drivers/remoteproc/remoteproc_internal.h |  19 +++-
 drivers/remoteproc/remoteproc_virtio.c   | 125 ++++++++++++++++++++-
 3 files changed, 138 insertions(+), 139 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index fcc55dbfba3b..ca2fe8d9cac8 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -23,9 +23,7 @@
 #include <linux/panic_notifier.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
-#include <linux/dma-map-ops.h>
 #include <linux/dma-mapping.h>
-#include <linux/dma-direct.h> /* XXX: pokes into bus_dma_range */
 #include <linux/firmware.h>
 #include <linux/string.h>
 #include <linux/debugfs.h>
@@ -434,123 +432,6 @@ void rproc_free_vring(struct rproc_vring *rvring)
 	}
 }
 
-static int rproc_vdev_do_start(struct rproc_subdev *subdev)
-{
-	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
-
-	return rproc_add_virtio_dev(rvdev, rvdev->id);
-}
-
-static void rproc_vdev_do_stop(struct rproc_subdev *subdev, bool crashed)
-{
-	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
-	int ret;
-
-	ret = device_for_each_child(&rvdev->dev, NULL, rproc_remove_virtio_dev);
-	if (ret)
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
-}
-
-static int copy_dma_range_map(struct device *to, struct device *from)
-{
-	const struct bus_dma_region *map = from->dma_range_map, *new_map, *r;
-	int num_ranges = 0;
-
-	if (!map)
-		return 0;
-
-	for (r = map; r->size; r++)
-		num_ranges++;
-
-	new_map = kmemdup(map, array_size(num_ranges + 1, sizeof(*map)),
-			  GFP_KERNEL);
-	if (!new_map)
-		return -ENOMEM;
-	to->dma_range_map = new_map;
-	return 0;
-}
-
-static void rproc_register_rvdev(struct rproc *rproc, struct rproc_vdev *rvdev)
-{
-	if (rvdev && rproc)
-		list_add_tail(&rvdev->node, &rproc->rvdevs);
-}
-
-static void rproc_unregister_rvdev(struct rproc_vdev *rvdev)
-{
-	if (rvdev)
-		list_del(&rvdev->node);
-}
-
-static int rproc_rvdev_add_device(struct rproc_vdev *rvdev)
-{
-	struct rproc *rproc = rvdev->rproc;
-	char name[16];
-	int ret;
-
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
-	if (ret)
-		goto free_rvdev;
-
-	/* Make device dma capable by inheriting from parent's capabilities */
-	set_dma_ops(&rvdev->dev, get_dma_ops(rproc->dev.parent));
-
-	ret = dma_coerce_mask_and_coherent(&rvdev->dev,
-					   dma_get_mask(rproc->dev.parent));
-	if (ret) {
-		dev_warn(&rvdev->dev,
-			 "Failed to set DMA mask %llx. Trying to continue... (%pe)\n",
-			 dma_get_mask(rproc->dev.parent), ERR_PTR(ret));
-	}
-
-	rproc_register_rvdev(rproc, rvdev);
-
-	rvdev->subdev.start = rproc_vdev_do_start;
-	rvdev->subdev.stop = rproc_vdev_do_stop;
-
-	rproc_add_subdev(rproc, &rvdev->subdev);
-
-	return 0;
-
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
 /**
  * rproc_handle_vdev() - handle a vdev fw resource
  * @rproc: the remote processor
@@ -650,20 +531,6 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
 	return ret;
 }
 
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
-}
-
 /**
  * rproc_handle_trace() - handle a shared trace buffer resource
  * @rproc: the remote processor
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index a328e634b1de..e9e9a551a8c2 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -26,14 +26,13 @@ struct rproc_debug_trace {
 
 /* from remoteproc_core.c */
 void rproc_release(struct kref *kref);
-irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
-void rproc_vdev_release(struct kref *ref);
 int rproc_of_parse_firmware(struct device *dev, int index,
 			    const char **fw_name);
 
 /* from remoteproc_virtio.c */
-int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id);
-int rproc_remove_virtio_dev(struct device *dev, void *data);
+int rproc_rvdev_add_device(struct rproc_vdev *rvdev);
+irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
+void rproc_vdev_release(struct kref *ref);
 
 /* from remoteproc_debugfs.c */
 void rproc_remove_trace_file(struct dentry *tfile);
@@ -196,4 +195,16 @@ bool rproc_u64_fit_in_size_t(u64 val)
 	return (val <= (size_t) -1);
 }
 
+static inline void rproc_register_rvdev(struct rproc *rproc, struct rproc_vdev *rvdev)
+{
+	if (rvdev && rproc)
+		list_add_tail(&rvdev->node, &rproc->rvdevs);
+}
+
+static inline void rproc_unregister_rvdev(struct rproc_vdev *rvdev)
+{
+	if (rvdev)
+		list_del(&rvdev->node);
+}
+
 #endif /* REMOTEPROC_INTERNAL_H */
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 70ab496d0431..51d415744fc6 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -9,7 +9,9 @@
  * Brian Swetland <swetland@google.com>
  */
 
+#include <linux/dma-direct.h>
 #include <linux/dma-map-ops.h>
+#include <linux/dma-mapping.h>
 #include <linux/export.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/remoteproc.h>
@@ -23,6 +25,25 @@
 
 #include "remoteproc_internal.h"
 
+static int copy_dma_range_map(struct device *to, struct device *from)
+{
+	const struct bus_dma_region *map = from->dma_range_map, *new_map, *r;
+	int num_ranges = 0;
+
+	if (!map)
+		return 0;
+
+	for (r = map; r->size; r++)
+		num_ranges++;
+
+	new_map = kmemdup(map, array_size(num_ranges + 1, sizeof(*map)),
+			  GFP_KERNEL);
+	if (!new_map)
+		return -ENOMEM;
+	to->dma_range_map = new_map;
+	return 0;
+}
+
 static struct rproc_vdev *vdev_to_rvdev(struct virtio_device *vdev)
 {
 	return container_of(vdev->dev.parent, struct rproc_vdev, dev);
@@ -339,7 +360,7 @@ static void rproc_virtio_dev_release(struct device *dev)
  *
  * Return: 0 on success or an appropriate error value otherwise
  */
-int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
+static int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
 {
 	struct rproc *rproc = rvdev->rproc;
 	struct device *dev = &rvdev->dev;
@@ -447,10 +468,110 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
  *
  * Return: 0
  */
-int rproc_remove_virtio_dev(struct device *dev, void *data)
+static int rproc_remove_virtio_dev(struct device *dev, void *data)
 {
 	struct virtio_device *vdev = dev_to_virtio(dev);
 
 	unregister_virtio_device(vdev);
 	return 0;
 }
+
+static int rproc_vdev_do_start(struct rproc_subdev *subdev)
+{
+	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
+
+	return rproc_add_virtio_dev(rvdev, rvdev->id);
+}
+
+static void rproc_vdev_do_stop(struct rproc_subdev *subdev, bool crashed)
+{
+	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
+	int ret;
+
+	ret = device_for_each_child(&rvdev->dev, NULL, rproc_remove_virtio_dev);
+	if (ret)
+		dev_warn(&rvdev->dev, "can't remove vdev child device: %d\n", ret);
+}
+
+/**
+ * rproc_rvdev_release() - release the existence of a rvdev
+ *
+ * @dev: the subdevice's dev
+ */
+static void rproc_rvdev_release(struct device *dev)
+{
+	struct rproc_vdev *rvdev = container_of(dev, struct rproc_vdev, dev);
+
+	of_reserved_mem_device_release(dev);
+
+	kfree(rvdev);
+}
+
+int rproc_rvdev_add_device(struct rproc_vdev *rvdev)
+{
+	struct rproc *rproc = rvdev->rproc;
+	char name[16];
+	int ret;
+
+	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
+	rvdev->dev.parent = &rproc->dev;
+	rvdev->dev.release = rproc_rvdev_release;
+	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
+	dev_set_drvdata(&rvdev->dev, rvdev);
+
+	ret = device_register(&rvdev->dev);
+	if (ret) {
+		put_device(&rvdev->dev);
+		return ret;
+	}
+	ret = copy_dma_range_map(&rvdev->dev, rproc->dev.parent);
+	if (ret)
+		goto free_rvdev;
+
+	/* Make device dma capable by inheriting from parent's capabilities */
+	set_dma_ops(&rvdev->dev, get_dma_ops(rproc->dev.parent));
+
+	ret = dma_coerce_mask_and_coherent(&rvdev->dev,
+					   dma_get_mask(rproc->dev.parent));
+	if (ret) {
+		dev_warn(&rvdev->dev,
+			 "Failed to set DMA mask %llx. Trying to continue... (%pe)\n",
+			 dma_get_mask(rproc->dev.parent), ERR_PTR(ret));
+	}
+
+	rproc_register_rvdev(rproc, rvdev);
+
+	rvdev->subdev.start = rproc_vdev_do_start;
+	rvdev->subdev.stop = rproc_vdev_do_stop;
+
+	rproc_add_subdev(rproc, &rvdev->subdev);
+
+	return 0;
+
+free_rvdev:
+	device_unregister(&rvdev->dev);
+	return ret;
+}
+
+static void rproc_rvdev_remove_device(struct rproc_vdev *rvdev)
+{
+	struct rproc *rproc = rvdev->rproc;
+
+	rproc_remove_subdev(rproc, &rvdev->subdev);
+	rproc_unregister_rvdev(rvdev);
+	device_unregister(&rvdev->dev);
+}
+
+void rproc_vdev_release(struct kref *ref)
+{
+	struct rproc_vdev *rvdev = container_of(ref, struct rproc_vdev, refcount);
+	struct rproc_vring *rvring;
+	int id;
+
+	for (id = 0; id < ARRAY_SIZE(rvdev->vring); id++) {
+		rvring = &rvdev->vring[id];
+		rproc_free_vring(rvring);
+	}
+
+	rproc_rvdev_remove_device(rvdev);
+}
-- 
2.17.1

