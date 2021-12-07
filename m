Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEE146B53C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhLGIMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:12:40 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42030 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229505AbhLGIMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:12:38 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B740hsf018633;
        Tue, 7 Dec 2021 09:08:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=7zsTBnorEjnmZcdGM+XPvc3la6MYGPR+Rw5pvL82FAI=;
 b=JwRv/QvOw4khR4XFOMTIIsLwAQl8co6Cts0qibLPJhVTZloIs6uxL20FBJ6R0xnqOH99
 jqinwiKxArZMMGxBzXYb/BWIgz4DNmcg0RuczFmG8eZOK+lKzpJojP0NbeNmohLkHUC5
 5jyBlpoi5sNq/iarLxgM3ZZo9W4fpu/b5odBCVVa2ZKa4ThOIIQrzISciyR2eyEE48M+
 ejrJcxxPIDQM85XIjB74oLQY63SmRKxUN69AlY5rOouSckWr5eeXvmFzJ2za+ih4aYRx
 9hJ/DlXuU3Q28Mbir9ph725I0ymc7siiq0JRW/0fV8SK7vn/OLYYj2W7+uCwQuqHeaHc aw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3csp32bc8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 09:08:54 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B42B7100034;
        Tue,  7 Dec 2021 09:08:53 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A1DBC2220AF;
        Tue,  7 Dec 2021 09:08:53 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 7 Dec 2021 09:08:53
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <julien.massot@iot.bzh>, <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v8 01/13] rpmsg: char: Export eptdev create an destroy functions
Date:   Tue, 7 Dec 2021 09:08:31 +0100
Message-ID: <20211207080843.21222-2-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211207080843.21222-1-arnaud.pouliquen@foss.st.com>
References: <20211207080843.21222-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_03,2021-12-06_02,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare the split of the code related to the control (ctrldev)
and the endpoint (eptdev) devices in 2 separate files:

- Rename and export the functions in rpmsg_char.h.

- Suppress the dependency with the rpmsg_ctrldev struct in the
  rpmsg_eptdev_create function.

Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
Update vs previous revision:
- suppress WARN_ON when CONFIG_RPMSG_CHAR not defined and return -ENXIO
---
 drivers/rpmsg/rpmsg_char.c | 18 +++++++++------
 drivers/rpmsg/rpmsg_char.h | 46 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 7 deletions(-)
 create mode 100644 drivers/rpmsg/rpmsg_char.h

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index d6214cb66026..f7aa2dd302a5 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (C) 2021, STMicroelectronics
  * Copyright (c) 2016, Linaro Ltd.
  * Copyright (c) 2012, Michal Simek <monstr@monstr.eu>
  * Copyright (c) 2012, PetaLogix
@@ -25,6 +26,8 @@
 #include <linux/uaccess.h>
 #include <uapi/linux/rpmsg.h>
 
+#include "rpmsg_char.h"
+
 #define RPMSG_DEV_MAX	(MINORMASK + 1)
 
 static dev_t rpmsg_major;
@@ -79,7 +82,7 @@ struct rpmsg_eptdev {
 	wait_queue_head_t readq;
 };
 
-static int rpmsg_eptdev_destroy(struct device *dev, void *data)
+int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
 {
 	struct rpmsg_eptdev *eptdev = dev_to_eptdev(dev);
 
@@ -98,6 +101,7 @@ static int rpmsg_eptdev_destroy(struct device *dev, void *data)
 
 	return 0;
 }
+EXPORT_SYMBOL(rpmsg_chrdev_eptdev_destroy);
 
 static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
 			void *priv, u32 addr)
@@ -281,7 +285,7 @@ static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
 	if (cmd != RPMSG_DESTROY_EPT_IOCTL)
 		return -EINVAL;
 
-	return rpmsg_eptdev_destroy(&eptdev->dev, NULL);
+	return rpmsg_chrdev_eptdev_destroy(&eptdev->dev, NULL);
 }
 
 static const struct file_operations rpmsg_eptdev_fops = {
@@ -340,10 +344,9 @@ static void rpmsg_eptdev_release_device(struct device *dev)
 	kfree(eptdev);
 }
 
-static int rpmsg_eptdev_create(struct rpmsg_ctrldev *ctrldev,
+int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent,
 			       struct rpmsg_channel_info chinfo)
 {
-	struct rpmsg_device *rpdev = ctrldev->rpdev;
 	struct rpmsg_eptdev *eptdev;
 	struct device *dev;
 	int ret;
@@ -363,7 +366,7 @@ static int rpmsg_eptdev_create(struct rpmsg_ctrldev *ctrldev,
 
 	device_initialize(dev);
 	dev->class = rpmsg_class;
-	dev->parent = &ctrldev->dev;
+	dev->parent = parent;
 	dev->groups = rpmsg_eptdev_groups;
 	dev_set_drvdata(dev, eptdev);
 
@@ -406,6 +409,7 @@ static int rpmsg_eptdev_create(struct rpmsg_ctrldev *ctrldev,
 
 	return ret;
 }
+EXPORT_SYMBOL(rpmsg_chrdev_eptdev_create);
 
 static int rpmsg_ctrldev_open(struct inode *inode, struct file *filp)
 {
@@ -445,7 +449,7 @@ static long rpmsg_ctrldev_ioctl(struct file *fp, unsigned int cmd,
 	chinfo.src = eptinfo.src;
 	chinfo.dst = eptinfo.dst;
 
-	return rpmsg_eptdev_create(ctrldev, chinfo);
+	return rpmsg_chrdev_eptdev_create(ctrldev->rpdev, &ctrldev->dev, chinfo);
 };
 
 static const struct file_operations rpmsg_ctrldev_fops = {
@@ -531,7 +535,7 @@ static void rpmsg_chrdev_remove(struct rpmsg_device *rpdev)
 	int ret;
 
 	/* Destroy all endpoints */
-	ret = device_for_each_child(&ctrldev->dev, NULL, rpmsg_eptdev_destroy);
+	ret = device_for_each_child(&ctrldev->dev, NULL, rpmsg_chrdev_eptdev_destroy);
 	if (ret)
 		dev_warn(&rpdev->dev, "failed to nuke endpoints: %d\n", ret);
 
diff --git a/drivers/rpmsg/rpmsg_char.h b/drivers/rpmsg/rpmsg_char.h
new file mode 100644
index 000000000000..dd0a16f2acd1
--- /dev/null
+++ b/drivers/rpmsg/rpmsg_char.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) STMicroelectronics 2021.
+ */
+
+#ifndef __RPMSG_CHRDEV_H__
+#define __RPMSG_CHRDEV_H__
+
+#if IS_ENABLED(CONFIG_RPMSG_CHAR)
+/**
+ * rpmsg_chrdev_eptdev_create() - register char device based on an endpoint
+ * @rpdev:  prepared rpdev to be used for creating endpoints
+ * @parent: parent device
+ * @chinfo: associated endpoint channel information.
+ *
+ * This function create a new rpmsg char endpoint device to instantiate a new
+ * endpoint based on chinfo information.
+ */
+int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent,
+			       struct rpmsg_channel_info chinfo);
+
+/**
+ * rpmsg_chrdev_eptdev_destroy() - destroy created char device endpoint.
+ * @data: private data associated to the endpoint device
+ *
+ * This function destroys a rpmsg char endpoint device created by the RPMSG_DESTROY_EPT_IOCTL
+ * control.
+ */
+int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data);
+
+#else  /*IS_ENABLED(CONFIG_RPMSG_CHAR) */
+
+static inline int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent,
+					     struct rpmsg_channel_info chinfo)
+{
+	return -ENXIO;
+}
+
+static inline int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
+{
+	return -ENXIO;
+}
+
+#endif /*IS_ENABLED(CONFIG_RPMSG_CHAR) */
+
+#endif /*__RPMSG_CHRDEV_H__ */
-- 
2.17.1

