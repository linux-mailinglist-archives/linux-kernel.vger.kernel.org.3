Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A334346B543
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbhLGIMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:12:43 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40154 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231319AbhLGIMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:12:38 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B75RNgu021902;
        Tue, 7 Dec 2021 09:08:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=nuURO2W1SWhsAI0sfv3vm7CocfSqChGxGc5QjbrslfA=;
 b=awLvh8qQICL/HqFha1BbUd6OI5hphEnErPEyteey9V5A3gf9i3jKnRWcFNLARzEEDPad
 obGX8fW+Jwd1M3Y3xo4QlyIxVhEZWReQO3DQW+Xe7hvegA2XmVCPpgZUVrBDpbhDibUA
 5x2F0LHRLuSYM1MX1EIlBgR3GwInIQdEVCGLTdCHZJchLow4IsZ353K/uUKEdFmh2uhX
 LmF5J7YWkG8TBLEI9oRg1TeE9RYMm5Ua5OCsURX8O4cMNC7JgiCNJkKVH7EzxbRtnavL
 lhXWrE7M3JnkN4fwUGos3+scAJi5oV7Zb3Ixfd9WCvLrz1GELdNsVs+JfNS2cP3E4OLf 1A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ct1fx8rgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 09:08:59 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8326F100038;
        Tue,  7 Dec 2021 09:08:58 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7B5E22220AE;
        Tue,  7 Dec 2021 09:08:58 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 7 Dec 2021 09:08:58
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <julien.massot@iot.bzh>, <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v8 07/13] rpmsg: Update rpmsg_chrdev_register_device function
Date:   Tue, 7 Dec 2021 09:08:37 +0100
Message-ID: <20211207080843.21222-8-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211207080843.21222-1-arnaud.pouliquen@foss.st.com>
References: <20211207080843.21222-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_03,2021-12-06_02,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rpmsg_chrdev driver has been replaced by the rpmsg_ctrl driver
for the /dev/rpmsg_ctrlX devices management. The reference for the
driver override is now the rpmsg_ctrl.

Update the rpmsg_chrdev_register_device function to reflect the update,
and rename the function to use the rpmsg_ctrldev prefix.

The platform drivers are updated accordingly.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/qcom_glink_native.c | 2 +-
 drivers/rpmsg/qcom_smd.c          | 2 +-
 drivers/rpmsg/rpmsg_ctrl.c        | 2 +-
 drivers/rpmsg/rpmsg_internal.h    | 8 ++++----
 drivers/rpmsg/virtio_rpmsg_bus.c  | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 1030cfa80e04..cf2c057b738c 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1715,7 +1715,7 @@ static int qcom_glink_create_chrdev(struct qcom_glink *glink)
 	rpdev->dev.parent = glink->dev;
 	rpdev->dev.release = qcom_glink_device_release;
 
-	return rpmsg_chrdev_register_device(rpdev);
+	return rpmsg_ctrldev_register_device(rpdev);
 }
 
 struct qcom_glink *qcom_glink_native_probe(struct device *dev,
diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 540e027f08c4..cd623e3e8aa9 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -1113,7 +1113,7 @@ static int qcom_smd_create_chrdev(struct qcom_smd_edge *edge)
 	qsdev->rpdev.dev.parent = &edge->dev;
 	qsdev->rpdev.dev.release = qcom_smd_release_device;
 
-	return rpmsg_chrdev_register_device(&qsdev->rpdev);
+	return rpmsg_ctrldev_register_device(&qsdev->rpdev);
 }
 
 /*
diff --git a/drivers/rpmsg/rpmsg_ctrl.c b/drivers/rpmsg/rpmsg_ctrl.c
index 33c38cbf2b83..59d2bd264fdb 100644
--- a/drivers/rpmsg/rpmsg_ctrl.c
+++ b/drivers/rpmsg/rpmsg_ctrl.c
@@ -183,7 +183,7 @@ static struct rpmsg_driver rpmsg_ctrldev_driver = {
 	.probe = rpmsg_ctrldev_probe,
 	.remove = rpmsg_ctrldev_remove,
 	.drv = {
-		.name = "rpmsg_chrdev",
+		.name = "rpmsg_ctrl",
 	},
 };
 
diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index 416316200bde..d4b23fd019a8 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -86,16 +86,16 @@ struct rpmsg_device *rpmsg_create_channel(struct rpmsg_device *rpdev,
 int rpmsg_release_channel(struct rpmsg_device *rpdev,
 			  struct rpmsg_channel_info *chinfo);
 /**
- * rpmsg_chrdev_register_device() - register chrdev device based on rpdev
+ * rpmsg_ctrldev_register_device() - register a char device for control based on rpdev
  * @rpdev:	prepared rpdev to be used for creating endpoints
  *
  * This function wraps rpmsg_register_device() preparing the rpdev for use as
  * basis for the rpmsg chrdev.
  */
-static inline int rpmsg_chrdev_register_device(struct rpmsg_device *rpdev)
+static inline int rpmsg_ctrldev_register_device(struct rpmsg_device *rpdev)
 {
-	strcpy(rpdev->id.name, "rpmsg_chrdev");
-	rpdev->driver_override = "rpmsg_chrdev";
+	strcpy(rpdev->id.name, "rpmsg_ctrl");
+	rpdev->driver_override = "rpmsg_ctrl";
 
 	return rpmsg_register_device(rpdev);
 }
diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index c37451512835..7f786cc70df9 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -849,7 +849,7 @@ static struct rpmsg_device *rpmsg_virtio_add_ctrl_dev(struct virtio_device *vdev
 	rpdev_ctrl->dev.release = virtio_rpmsg_release_device;
 	rpdev_ctrl->little_endian = virtio_is_little_endian(vrp->vdev);
 
-	err = rpmsg_chrdev_register_device(rpdev_ctrl);
+	err = rpmsg_ctrldev_register_device(rpdev_ctrl);
 	if (err) {
 		kfree(vch);
 		return ERR_PTR(err);
-- 
2.17.1

