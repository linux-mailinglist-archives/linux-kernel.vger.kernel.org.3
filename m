Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15159497D0D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbiAXK0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:26:13 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33332 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234162AbiAXK0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:26:04 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20O719GW017654;
        Mon, 24 Jan 2022 11:25:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=NefYGESWz63GqcOouGzA/LgiFuAClS9u7rBFOulRBlQ=;
 b=T/UZ2N34rWAhxLROQ8Z8/VfdCDcrS2Ouy6Rx2hOIdpIkGVhV50HiVievXddLXmG6NyfC
 V0TOlkm7TWL28jN5uwy4l7JNmun5MmuTQZpWgiTAkH9brukm27vCSnpbf1ZjWedMgRMp
 qdZ2B5N43NIHdv7DFTewwz/3A7AiAjEmnfVa9/ZPOD8K98UFyoBvkxnjTVVu8bMCXFWk
 YhWKtGpPvRu1ZP6kD147CJU9Li111RST5hhxJjH4LAFeQXeDuVJHL7+YQFemcaUawQHY
 t1Cv4xAp2RrTmFum8LHEam3eP0LFIefPTEpCNwgmt8yVHhTpjoYm7LL3daxZ5R5pG4K+ dQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dsqbu98jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jan 2022 11:25:55 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DF315100039;
        Mon, 24 Jan 2022 11:25:53 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D75162128B5;
        Mon, 24 Jan 2022 11:25:53 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 24 Jan 2022 11:25:53
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <julien.massot@iot.bzh>, <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v9 03/11] rpmsg: Move the rpmsg control device from rpmsg_char to rpmsg_ctrl
Date:   Mon, 24 Jan 2022 11:25:16 +0100
Message-ID: <20220124102524.295783-4-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124102524.295783-1-arnaud.pouliquen@foss.st.com>
References: <20220124102524.295783-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_06,2022-01-24_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create the rpmsg_ctrl.c module and move the code related to the
rpmsg_ctrldev device in this new module.

Add the dependency between rpmsg_char and rpmsg_ctrl in the
kconfig file:

1) RPMSG_CTRL can set as module or built-in if
  RPMSG=y || RPMSG_CHAR=y || RPMSG_CHAR=n

2) RPMSG_CTRL can not be set as built-in if
   RPMSG=m || RPMSG_CHAR=m

Note that RPMGH_CHAR and RPMSG_CTRL can be activated separately.
Therefore, the RPMSG_CTRL configuration must be set for backwards compatibility.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

---
Update vs previous revision
 - Remove Bjorn Andersson's Reviewed-by as update after rebasing on 5.17-rc1
	- fix cdev add [1]
	- Add pr_fmt() [2]
[1] https://lore.kernel.org/linux-remoteproc/164245960510.1698571.4998090450663669237.b4-ty@linaro.org/T/#t
[2] https://lore.kernel.org/lkml/20211108135945.3364-1-arnaud.pouliquen@foss.st.com/T/
---
 drivers/rpmsg/Kconfig      |   8 ++
 drivers/rpmsg/Makefile     |   1 +
 drivers/rpmsg/rpmsg_char.c | 160 +--------------------------
 drivers/rpmsg/rpmsg_ctrl.c | 215 +++++++++++++++++++++++++++++++++++++
 4 files changed, 226 insertions(+), 158 deletions(-)
 create mode 100644 drivers/rpmsg/rpmsg_ctrl.c

diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
index 0b4407abdf13..d3795860f5c0 100644
--- a/drivers/rpmsg/Kconfig
+++ b/drivers/rpmsg/Kconfig
@@ -15,6 +15,14 @@ config RPMSG_CHAR
 	  in /dev. They make it possible for user-space programs to send and
 	  receive rpmsg packets.
 
+config RPMSG_CTRL
+	tristate "RPMSG control interface"
+	depends on RPMSG && ( RPMSG_CHAR || RPMSG_CHAR=n )
+	help
+	  Say Y here to enable the support of the /dev/rpmsg_ctrlX API. This API
+	  allows user-space programs to create endpoints with specific service name,
+	  source and destination addresses.
+
 config RPMSG_NS
 	tristate "RPMSG name service announcement"
 	depends on RPMSG
diff --git a/drivers/rpmsg/Makefile b/drivers/rpmsg/Makefile
index 8d452656f0ee..58e3b382e316 100644
--- a/drivers/rpmsg/Makefile
+++ b/drivers/rpmsg/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_RPMSG)		+= rpmsg_core.o
 obj-$(CONFIG_RPMSG_CHAR)	+= rpmsg_char.o
+obj-$(CONFIG_RPMSG_CTRL)	+= rpmsg_ctrl.o
 obj-$(CONFIG_RPMSG_NS)		+= rpmsg_ns.o
 obj-$(CONFIG_RPMSG_MTK_SCP)	+= mtk_rpmsg.o
 qcom_glink-objs			:= qcom_glink_native.o qcom_glink_ssr.o
diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index fd56e7967ee3..fcd583472d5a 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -33,28 +33,12 @@
 
 static dev_t rpmsg_major;
 
-static DEFINE_IDA(rpmsg_ctrl_ida);
 static DEFINE_IDA(rpmsg_ept_ida);
 static DEFINE_IDA(rpmsg_minor_ida);
 
 #define dev_to_eptdev(dev) container_of(dev, struct rpmsg_eptdev, dev)
 #define cdev_to_eptdev(i_cdev) container_of(i_cdev, struct rpmsg_eptdev, cdev)
 
-#define dev_to_ctrldev(dev) container_of(dev, struct rpmsg_ctrldev, dev)
-#define cdev_to_ctrldev(i_cdev) container_of(i_cdev, struct rpmsg_ctrldev, cdev)
-
-/**
- * struct rpmsg_ctrldev - control device for instantiating endpoint devices
- * @rpdev:	underlaying rpmsg device
- * @cdev:	cdev for the ctrl device
- * @dev:	device for the ctrl device
- */
-struct rpmsg_ctrldev {
-	struct rpmsg_device *rpdev;
-	struct cdev cdev;
-	struct device dev;
-};
-
 /**
  * struct rpmsg_eptdev - endpoint device context
  * @dev:	endpoint device
@@ -404,162 +388,22 @@ int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent
 }
 EXPORT_SYMBOL(rpmsg_chrdev_eptdev_create);
 
-static int rpmsg_ctrldev_open(struct inode *inode, struct file *filp)
-{
-	struct rpmsg_ctrldev *ctrldev = cdev_to_ctrldev(inode->i_cdev);
-
-	get_device(&ctrldev->dev);
-	filp->private_data = ctrldev;
-
-	return 0;
-}
-
-static int rpmsg_ctrldev_release(struct inode *inode, struct file *filp)
-{
-	struct rpmsg_ctrldev *ctrldev = cdev_to_ctrldev(inode->i_cdev);
-
-	put_device(&ctrldev->dev);
-
-	return 0;
-}
-
-static long rpmsg_ctrldev_ioctl(struct file *fp, unsigned int cmd,
-				unsigned long arg)
-{
-	struct rpmsg_ctrldev *ctrldev = fp->private_data;
-	void __user *argp = (void __user *)arg;
-	struct rpmsg_endpoint_info eptinfo;
-	struct rpmsg_channel_info chinfo;
-
-	if (cmd != RPMSG_CREATE_EPT_IOCTL)
-		return -EINVAL;
-
-	if (copy_from_user(&eptinfo, argp, sizeof(eptinfo)))
-		return -EFAULT;
-
-	memcpy(chinfo.name, eptinfo.name, RPMSG_NAME_SIZE);
-	chinfo.name[RPMSG_NAME_SIZE-1] = '\0';
-	chinfo.src = eptinfo.src;
-	chinfo.dst = eptinfo.dst;
-
-	return rpmsg_chrdev_eptdev_create(ctrldev->rpdev, &ctrldev->dev, chinfo);
-};
-
-static const struct file_operations rpmsg_ctrldev_fops = {
-	.owner = THIS_MODULE,
-	.open = rpmsg_ctrldev_open,
-	.release = rpmsg_ctrldev_release,
-	.unlocked_ioctl = rpmsg_ctrldev_ioctl,
-	.compat_ioctl = compat_ptr_ioctl,
-};
-
-static void rpmsg_ctrldev_release_device(struct device *dev)
-{
-	struct rpmsg_ctrldev *ctrldev = dev_to_ctrldev(dev);
-
-	ida_simple_remove(&rpmsg_ctrl_ida, dev->id);
-	ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
-	kfree(ctrldev);
-}
-
-static int rpmsg_chrdev_probe(struct rpmsg_device *rpdev)
-{
-	struct rpmsg_ctrldev *ctrldev;
-	struct device *dev;
-	int ret;
-
-	ctrldev = kzalloc(sizeof(*ctrldev), GFP_KERNEL);
-	if (!ctrldev)
-		return -ENOMEM;
-
-	ctrldev->rpdev = rpdev;
-
-	dev = &ctrldev->dev;
-	device_initialize(dev);
-	dev->parent = &rpdev->dev;
-	dev->class = rpmsg_class;
-
-	cdev_init(&ctrldev->cdev, &rpmsg_ctrldev_fops);
-	ctrldev->cdev.owner = THIS_MODULE;
-
-	ret = ida_simple_get(&rpmsg_minor_ida, 0, RPMSG_DEV_MAX, GFP_KERNEL);
-	if (ret < 0)
-		goto free_ctrldev;
-	dev->devt = MKDEV(MAJOR(rpmsg_major), ret);
-
-	ret = ida_simple_get(&rpmsg_ctrl_ida, 0, 0, GFP_KERNEL);
-	if (ret < 0)
-		goto free_minor_ida;
-	dev->id = ret;
-	dev_set_name(&ctrldev->dev, "rpmsg_ctrl%d", ret);
-
-	ret = cdev_device_add(&ctrldev->cdev, &ctrldev->dev);
-	if (ret)
-		goto free_ctrl_ida;
-
-	/* We can now rely on the release function for cleanup */
-	dev->release = rpmsg_ctrldev_release_device;
-
-	dev_set_drvdata(&rpdev->dev, ctrldev);
-
-	return ret;
-
-free_ctrl_ida:
-	ida_simple_remove(&rpmsg_ctrl_ida, dev->id);
-free_minor_ida:
-	ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
-free_ctrldev:
-	put_device(dev);
-	kfree(ctrldev);
-
-	return ret;
-}
-
-static void rpmsg_chrdev_remove(struct rpmsg_device *rpdev)
-{
-	struct rpmsg_ctrldev *ctrldev = dev_get_drvdata(&rpdev->dev);
-	int ret;
-
-	/* Destroy all endpoints */
-	ret = device_for_each_child(&ctrldev->dev, NULL, rpmsg_chrdev_eptdev_destroy);
-	if (ret)
-		dev_warn(&rpdev->dev, "failed to nuke endpoints: %d\n", ret);
-
-	cdev_device_del(&ctrldev->cdev, &ctrldev->dev);
-	put_device(&ctrldev->dev);
-}
-
-static struct rpmsg_driver rpmsg_chrdev_driver = {
-	.probe = rpmsg_chrdev_probe,
-	.remove = rpmsg_chrdev_remove,
-	.drv = {
-		.name = "rpmsg_chrdev",
-	},
-};
-
 static int rpmsg_chrdev_init(void)
 {
 	int ret;
 
-	ret = alloc_chrdev_region(&rpmsg_major, 0, RPMSG_DEV_MAX, "rpmsg");
+	ret = alloc_chrdev_region(&rpmsg_major, 0, RPMSG_DEV_MAX, "rpmsg_char");
 	if (ret < 0) {
 		pr_err("failed to allocate char dev region\n");
 		return ret;
 	}
 
-	ret = register_rpmsg_driver(&rpmsg_chrdev_driver);
-	if (ret < 0) {
-		pr_err("failed to register rpmsg driver\n");
-		unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
-	}
-
-	return ret;
+	return 0;
 }
 postcore_initcall(rpmsg_chrdev_init);
 
 static void rpmsg_chrdev_exit(void)
 {
-	unregister_rpmsg_driver(&rpmsg_chrdev_driver);
 	unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
 }
 module_exit(rpmsg_chrdev_exit);
diff --git a/drivers/rpmsg/rpmsg_ctrl.c b/drivers/rpmsg/rpmsg_ctrl.c
new file mode 100644
index 000000000000..963e6e81a83f
--- /dev/null
+++ b/drivers/rpmsg/rpmsg_ctrl.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022, STMicroelectronics
+ * Copyright (c) 2016, Linaro Ltd.
+ * Copyright (c) 2012, Michal Simek <monstr@monstr.eu>
+ * Copyright (c) 2012, PetaLogix
+ * Copyright (c) 2011, Texas Instruments, Inc.
+ * Copyright (c) 2011, Google, Inc.
+ *
+ * Based on rpmsg performance statistics driver by Michal Simek, which in turn
+ * was based on TI & Google OMX rpmsg driver.
+ */
+
+#define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
+
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/idr.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/rpmsg.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <uapi/linux/rpmsg.h>
+
+#include "rpmsg_char.h"
+#include "rpmsg_internal.h"
+
+#define RPMSG_DEV_MAX	(MINORMASK + 1)
+
+static dev_t rpmsg_major;
+
+static DEFINE_IDA(rpmsg_ctrl_ida);
+static DEFINE_IDA(rpmsg_minor_ida);
+
+#define dev_to_ctrldev(dev) container_of(dev, struct rpmsg_ctrldev, dev)
+#define cdev_to_ctrldev(i_cdev) container_of(i_cdev, struct rpmsg_ctrldev, cdev)
+
+/**
+ * struct rpmsg_ctrldev - control device for instantiating endpoint devices
+ * @rpdev:	underlaying rpmsg device
+ * @cdev:	cdev for the ctrl device
+ * @dev:	device for the ctrl device
+ */
+struct rpmsg_ctrldev {
+	struct rpmsg_device *rpdev;
+	struct cdev cdev;
+	struct device dev;
+};
+
+static int rpmsg_ctrldev_open(struct inode *inode, struct file *filp)
+{
+	struct rpmsg_ctrldev *ctrldev = cdev_to_ctrldev(inode->i_cdev);
+
+	get_device(&ctrldev->dev);
+	filp->private_data = ctrldev;
+
+	return 0;
+}
+
+static int rpmsg_ctrldev_release(struct inode *inode, struct file *filp)
+{
+	struct rpmsg_ctrldev *ctrldev = cdev_to_ctrldev(inode->i_cdev);
+
+	put_device(&ctrldev->dev);
+
+	return 0;
+}
+
+static long rpmsg_ctrldev_ioctl(struct file *fp, unsigned int cmd,
+				unsigned long arg)
+{
+	struct rpmsg_ctrldev *ctrldev = fp->private_data;
+	void __user *argp = (void __user *)arg;
+	struct rpmsg_endpoint_info eptinfo;
+	struct rpmsg_channel_info chinfo;
+
+	if (cmd != RPMSG_CREATE_EPT_IOCTL)
+		return -EINVAL;
+
+	if (copy_from_user(&eptinfo, argp, sizeof(eptinfo)))
+		return -EFAULT;
+
+	memcpy(chinfo.name, eptinfo.name, RPMSG_NAME_SIZE);
+	chinfo.name[RPMSG_NAME_SIZE - 1] = '\0';
+	chinfo.src = eptinfo.src;
+	chinfo.dst = eptinfo.dst;
+
+	return rpmsg_chrdev_eptdev_create(ctrldev->rpdev, &ctrldev->dev, chinfo);
+};
+
+static const struct file_operations rpmsg_ctrldev_fops = {
+	.owner = THIS_MODULE,
+	.open = rpmsg_ctrldev_open,
+	.release = rpmsg_ctrldev_release,
+	.unlocked_ioctl = rpmsg_ctrldev_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
+};
+
+static void rpmsg_ctrldev_release_device(struct device *dev)
+{
+	struct rpmsg_ctrldev *ctrldev = dev_to_ctrldev(dev);
+
+	ida_simple_remove(&rpmsg_ctrl_ida, dev->id);
+	ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
+	kfree(ctrldev);
+}
+
+static int rpmsg_ctrldev_probe(struct rpmsg_device *rpdev)
+{
+	struct rpmsg_ctrldev *ctrldev;
+	struct device *dev;
+	int ret;
+
+	ctrldev = kzalloc(sizeof(*ctrldev), GFP_KERNEL);
+	if (!ctrldev)
+		return -ENOMEM;
+
+	ctrldev->rpdev = rpdev;
+
+	dev = &ctrldev->dev;
+	device_initialize(dev);
+	dev->parent = &rpdev->dev;
+	dev->class = rpmsg_class;
+
+	cdev_init(&ctrldev->cdev, &rpmsg_ctrldev_fops);
+	ctrldev->cdev.owner = THIS_MODULE;
+
+	ret = ida_simple_get(&rpmsg_minor_ida, 0, RPMSG_DEV_MAX, GFP_KERNEL);
+	if (ret < 0)
+		goto free_ctrldev;
+	dev->devt = MKDEV(MAJOR(rpmsg_major), ret);
+
+	ret = ida_simple_get(&rpmsg_ctrl_ida, 0, 0, GFP_KERNEL);
+	if (ret < 0)
+		goto free_minor_ida;
+	dev->id = ret;
+	dev_set_name(&ctrldev->dev, "rpmsg_ctrl%d", ret);
+
+	ret = cdev_device_add(&ctrldev->cdev, &ctrldev->dev);
+	if (ret)
+		goto free_ctrl_ida;
+
+	/* We can now rely on the release function for cleanup */
+	dev->release = rpmsg_ctrldev_release_device;
+
+	dev_set_drvdata(&rpdev->dev, ctrldev);
+
+	return ret;
+
+free_ctrl_ida:
+	ida_simple_remove(&rpmsg_ctrl_ida, dev->id);
+free_minor_ida:
+	ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
+free_ctrldev:
+	put_device(dev);
+	kfree(ctrldev);
+
+	return ret;
+}
+
+static void rpmsg_ctrldev_remove(struct rpmsg_device *rpdev)
+{
+	struct rpmsg_ctrldev *ctrldev = dev_get_drvdata(&rpdev->dev);
+	int ret;
+
+	/* Destroy all endpoints */
+	ret = device_for_each_child(&ctrldev->dev, NULL, rpmsg_chrdev_eptdev_destroy);
+	if (ret)
+		dev_warn(&rpdev->dev, "failed to nuke endpoints: %d\n", ret);
+
+	cdev_device_del(&ctrldev->cdev, &ctrldev->dev);
+	put_device(&ctrldev->dev);
+}
+
+static struct rpmsg_driver rpmsg_ctrldev_driver = {
+	.probe = rpmsg_ctrldev_probe,
+	.remove = rpmsg_ctrldev_remove,
+	.drv = {
+		.name = "rpmsg_chrdev",
+	},
+};
+
+static int rpmsg_ctrldev_init(void)
+{
+	int ret;
+
+	ret = alloc_chrdev_region(&rpmsg_major, 0, RPMSG_DEV_MAX, "rpmsg_ctrl");
+	if (ret < 0) {
+		pr_err("failed to allocate char dev region\n");
+		return ret;
+	}
+
+	ret = register_rpmsg_driver(&rpmsg_ctrldev_driver);
+	if (ret < 0) {
+		pr_err("failed to register rpmsg driver\n");
+		unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
+	}
+
+	return ret;
+}
+postcore_initcall(rpmsg_ctrldev_init);
+
+static void rpmsg_ctrldev_exit(void)
+{
+	unregister_rpmsg_driver(&rpmsg_ctrldev_driver);
+	unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
+}
+module_exit(rpmsg_ctrldev_exit);
+
+MODULE_DESCRIPTION("rpmsg control interface");
+MODULE_ALIAS("rpmsg:" KBUILD_MODNAME);
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

