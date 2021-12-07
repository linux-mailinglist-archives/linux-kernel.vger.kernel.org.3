Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908AE46B566
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhLGIN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:13:59 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:35008 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232195AbhLGINn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:13:43 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B71QLGN028789;
        Tue, 7 Dec 2021 09:10:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=7dwMWYSMdlELebKyY8Wrp74Lm64AOXgWkuA2NECH5CQ=;
 b=s6yuFvO1kNtBUqED75pfPHYzHLsQWlV9gU6zn2j1XK/AIzAz5KtMPuXYyGyUVMan0m+G
 2vQXNa24Gva+TA3u3Ncy0D8KUBN+dosl1HYDzarlMxBU9ohxcXxA4VxmLYBDNxgcv3ic
 JFf0YgRgrtfRXVfrWR9R3eogF7rtzAvq73VSe3ZChP1/iAeYNusPsW5N6zUOTn0vr3Xj
 hlqG0jmH7aqBm1LTkIE2KM/KbceIs8jYZyr/KsLewPljVaQkISHw8Kx2oHIeFt5btVdu
 HSlj4zSUcvLtYfHByydXL+RmK4XdmR4ZqVWXxwmOcyjXDQWCgrHlX/uZmI+RLzG8pKH4 7Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3csg5tnbcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 09:10:02 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C11B1100039;
        Tue,  7 Dec 2021 09:10:01 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B5AF5217B7D;
        Tue,  7 Dec 2021 09:10:01 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 7 Dec 2021 09:10:01
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <julien.massot@iot.bzh>, <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v8 11/13] rpmsg: char: Introduce the "rpmsg-raw" channel
Date:   Tue, 7 Dec 2021 09:08:41 +0100
Message-ID: <20211207080843.21222-12-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211207080843.21222-1-arnaud.pouliquen@foss.st.com>
References: <20211207080843.21222-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_03,2021-12-06_02,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows to probe the endpoint device on a remote name service announcement,
by registering a rpmsg_driverfor the "rpmsg-raw" channel.

With this patch the /dev/rpmsgX interface can be instantiated by the remote
firmware.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/rpmsg/rpmsg_char.c | 64 ++++++++++++++++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_ctrl.c |  7 +++--
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index cf97839f5833..92b44630e03a 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -435,6 +435,58 @@ int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent
 }
 EXPORT_SYMBOL(rpmsg_chrdev_eptdev_create);
 
+static int rpmsg_chrdev_probe(struct rpmsg_device *rpdev)
+{
+	struct rpmsg_channel_info chinfo;
+	struct rpmsg_eptdev *eptdev;
+	struct device *dev = &rpdev->dev;
+
+	memcpy(chinfo.name, rpdev->id.name, RPMSG_NAME_SIZE);
+	chinfo.src = rpdev->src;
+	chinfo.dst = rpdev->dst;
+
+	eptdev = rpmsg_chrdev_eptdev_alloc(rpdev, dev);
+	if (IS_ERR(eptdev))
+		return PTR_ERR(eptdev);
+
+	/*
+	 * Create the default endpoint associated to the rpmsg device and provide rpmsg_eptdev
+	 * structure as callback private data.
+	 * Do not allow the creation and release of an endpoint on /dev/rpmsgX open and close,
+	 * reuse the default endpoint instead
+	 */
+	eptdev->default_ept = rpmsg_create_default_ept(rpdev, rpmsg_ept_cb, eptdev, chinfo);
+	if (!eptdev->default_ept) {
+		dev_err(&rpdev->dev, "failed to create %s\n", chinfo.name);
+		put_device(dev);
+		kfree(eptdev);
+		return -EINVAL;
+	}
+
+	return rpmsg_chrdev_eptdev_add(eptdev, chinfo);
+}
+
+static void rpmsg_chrdev_remove(struct rpmsg_device *rpdev)
+{
+	int ret;
+
+	ret = device_for_each_child(&rpdev->dev, NULL, rpmsg_chrdev_eptdev_destroy);
+	if (ret)
+		dev_warn(&rpdev->dev, "failed to destroy endpoints: %d\n", ret);
+}
+
+static struct rpmsg_device_id rpmsg_chrdev_id_table[] = {
+	{ .name	= "rpmsg-raw" },
+	{ },
+};
+
+static struct rpmsg_driver rpmsg_chrdev_driver = {
+	.probe = rpmsg_chrdev_probe,
+	.remove = rpmsg_chrdev_remove,
+	.id_table = rpmsg_chrdev_id_table,
+	.drv.name = "rpmsg_chrdev",
+};
+
 static int rpmsg_chrdev_init(void)
 {
 	int ret;
@@ -445,12 +497,24 @@ static int rpmsg_chrdev_init(void)
 		return ret;
 	}
 
+	ret = register_rpmsg_driver(&rpmsg_chrdev_driver);
+	if (ret < 0) {
+		pr_err("rpmsg: failed to register rpmsg raw driver\n");
+		goto free_region;
+	}
+
 	return 0;
+
+free_region:
+	unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
+
+	return ret;
 }
 postcore_initcall(rpmsg_chrdev_init);
 
 static void rpmsg_chrdev_exit(void)
 {
+	unregister_rpmsg_driver(&rpmsg_chrdev_driver);
 	unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
 }
 module_exit(rpmsg_chrdev_exit);
diff --git a/drivers/rpmsg/rpmsg_ctrl.c b/drivers/rpmsg/rpmsg_ctrl.c
index 59d2bd264fdb..298e75dc7774 100644
--- a/drivers/rpmsg/rpmsg_ctrl.c
+++ b/drivers/rpmsg/rpmsg_ctrl.c
@@ -10,6 +10,9 @@
  * Based on rpmsg performance statistics driver by Michal Simek, which in turn
  * was based on TI & Google OMX rpmsg driver.
  */
+
+#define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
+
 #include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/fs.h>
@@ -193,13 +196,13 @@ static int rpmsg_ctrldev_init(void)
 
 	ret = alloc_chrdev_region(&rpmsg_major, 0, RPMSG_DEV_MAX, "rpmsg_ctrl");
 	if (ret < 0) {
-		pr_err("rpmsg: failed to allocate char dev region\n");
+		pr_err("failed to allocate char dev region\n");
 		return ret;
 	}
 
 	ret = register_rpmsg_driver(&rpmsg_ctrldev_driver);
 	if (ret < 0) {
-		pr_err("rpmsg ctrl: failed to register rpmsg driver\n");
+		pr_err("failed to register rpmsg driver\n");
 		unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
 	}
 
-- 
2.17.1

