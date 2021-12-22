Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A8347CE2B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243346AbhLVIYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:24:10 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:44478 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243308AbhLVIYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:24:00 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BM3tuOY020005;
        Wed, 22 Dec 2021 09:23:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=P7z9xeCe+lCErEoJAfL9RLe1YJX0EYK88I4lHWi7/0o=;
 b=v7/+WScrmfFqElpEedTQnc89klRb7CR9gqQOkL1hM+Eiw8oCDw40a/yGTYQiLgX19MBJ
 dbbdaGp+SLrMwwqTMh9Zp0WRKqFK5pbXH3Vc8AEzHttSlIP3zVwtrogzIc93xWfDxY3w
 H+CCL5yaIR5mx6ChSgHHPLls4y3lKZAwTCvT9Yn3VimelmTt+2B/ID2tfqWMYjjwPq0U
 24rzZNSQQiFmtgjLvMLDdfqctLR4ly9bvBeGNP1IPTRbgNGrjcoDRyKSFcN8UIwNTGv0
 t4aRISLoouNOwE6st+9yjv2JH9LN+5PcKePDMPbwIW9qFXjBVXA/K02cAGJloYYOGwAs qQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3d3j39b8nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 09:23:58 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 94B8B10002A;
        Wed, 22 Dec 2021 09:23:57 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8D4A72221D6;
        Wed, 22 Dec 2021 09:23:57 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 22 Dec 2021 09:23:57
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [RFC PATCH v2 5/6] remoteproc: virtio: Add helper to create platform device
Date:   Wed, 22 Dec 2021 09:23:48 +0100
Message-ID: <20211222082349.30378-6-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211222082349.30378-1-arnaud.pouliquen@foss.st.com>
References: <20211222082349.30378-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-22_04,2021-12-21_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add capability to create platform device for the rproc virtio.
This is a step to move forward the management of the rproc virtio
as an independent device.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/remoteproc/remoteproc_internal.h |  3 ++
 drivers/remoteproc/remoteproc_virtio.c   | 36 ++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index 6f511c50a15d..3007d29a26e1 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -37,6 +37,9 @@ int rproc_of_parse_firmware(struct device *dev, int index,
 
 /* from remoteproc_virtio.c */
 int rproc_rvdev_add_device(struct rproc_vdev *rvdev);
+struct platform_device *
+rproc_virtio_register_device(struct rproc *rproc, struct rproc_vdev_pdata *vdev_data);
+void rproc_virtio_unregister_device(struct rproc_vdev *rvdev);
 irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
 void rproc_vdev_release(struct kref *ref);
 
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 5f8005caeb6e..5eef679cc520 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -578,6 +578,42 @@ void rproc_vdev_release(struct kref *ref)
 	rproc_rvdev_remove_device(rvdev);
 }
 
+/**
+ * rproc_virtio_register_device() - register a remoteproc virtio device
+ * @rproc: rproc handle to add the remoteproc virtio device to
+ * @vdev_data: platform device data
+ *
+ * Return: 0 on success, and an appropriate error value otherwise
+ */
+struct platform_device *
+rproc_virtio_register_device(struct rproc *rproc, struct rproc_vdev_pdata *vdev_data)
+{
+	struct device *dev = &rproc->dev;
+	struct platform_device *pdev;
+
+	pdev = platform_device_register_data(dev, "rproc-virtio", vdev_data->index, vdev_data,
+					     sizeof(*vdev_data));
+	if (PTR_ERR_OR_ZERO(pdev)) {
+		dev_err(rproc->dev.parent,
+			"failed to create rproc-virtio device\n");
+	}
+
+	return  pdev;
+}
+EXPORT_SYMBOL(rproc_virtio_register_device);
+
+/**
+ * rproc_virtio_unregister_device() - unregister a remoteproc virtio device
+ * @rvdev: remote proc virtio handle to unregister
+ *
+ */
+void rproc_virtio_unregister_device(struct rproc_vdev *rvdev)
+{
+	if (rvdev->pdev)
+		platform_device_unregister(rvdev->pdev);
+}
+EXPORT_SYMBOL(rproc_virtio_unregister_device);
+
 static int rproc_virtio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-- 
2.17.1

