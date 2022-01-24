Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B73497D1E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiAXK1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:27:05 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:54606 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234177AbiAXK1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:27:01 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20O72PVc025630;
        Mon, 24 Jan 2022 11:26:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=kN+Qgo+0RDqY66NGKZnkxYmBBwK4wLmm/g2d1LTo5lI=;
 b=0hDSiFDRfQ8XqWFsO9/JftEE0OUmSx87DR+ovf00I1aozf9I4epZ6p9eRVzGLoN2PxE6
 QtckqaxMtqGZCDElpdvBEmoFrSdLvUZhurcZ8vVa7KgM0DJNXnkItZ1OSVRvO5bpuFFY
 garEtEr4YgieHFOPmwT7qEZMYPbAnbfDkrAKjr00X9/ttE3g2NlmCilQy3RgeCQn9v9q
 xeR1lBR7U/FDz4AOj4JVnrdtoAPYDtYVDxW5moX6JSqDQmPAo3CRhke/CAVQPEyWQs4m
 cnIQf5c1hSLYKmxoqnadSSEKL4HUwxnxD3vOxS5uAUfoLc99AjJIhEIWGgTz42maUWeb Rw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ds9v1kcsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jan 2022 11:26:59 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 848DD10002A;
        Mon, 24 Jan 2022 11:26:57 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2A6192128BC;
        Mon, 24 Jan 2022 11:26:57 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 24 Jan 2022 11:26:56
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <julien.massot@iot.bzh>, <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v9 08/11] rpmsg: char: Refactor rpmsg_chrdev_eptdev_create function
Date:   Mon, 24 Jan 2022 11:25:21 +0100
Message-ID: <20220124102524.295783-9-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124102524.295783-1-arnaud.pouliquen@foss.st.com>
References: <20220124102524.295783-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_06,2022-01-24_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the rpmsg_chrdev_eptdev_alloc and rpmsg_chrdev_eptdev_add
internal function to split the allocation part from the device add.

This patch prepares the introduction of a rpmsg channel device for the
char device. An default endpoint will be created,
referenced in the rpmsg_eptdev structure before adding the devices.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/rpmsg/rpmsg_char.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index fcd583472d5a..e7bc7dcdba63 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -327,20 +327,18 @@ static void rpmsg_eptdev_release_device(struct device *dev)
 	kfree(eptdev);
 }
 
-int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent,
-			       struct rpmsg_channel_info chinfo)
+static struct rpmsg_eptdev *rpmsg_chrdev_eptdev_alloc(struct rpmsg_device *rpdev,
+						      struct device *parent)
 {
 	struct rpmsg_eptdev *eptdev;
 	struct device *dev;
-	int ret;
 
 	eptdev = kzalloc(sizeof(*eptdev), GFP_KERNEL);
 	if (!eptdev)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	dev = &eptdev->dev;
 	eptdev->rpdev = rpdev;
-	eptdev->chinfo = chinfo;
 
 	mutex_init(&eptdev->ept_lock);
 	spin_lock_init(&eptdev->queue_lock);
@@ -356,6 +354,16 @@ int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent
 	cdev_init(&eptdev->cdev, &rpmsg_eptdev_fops);
 	eptdev->cdev.owner = THIS_MODULE;
 
+	return eptdev;
+}
+
+static int rpmsg_chrdev_eptdev_add(struct rpmsg_eptdev *eptdev, struct rpmsg_channel_info chinfo)
+{
+	struct device *dev = &eptdev->dev;
+	int ret;
+
+	eptdev->chinfo = chinfo;
+
 	ret = ida_simple_get(&rpmsg_minor_ida, 0, RPMSG_DEV_MAX, GFP_KERNEL);
 	if (ret < 0)
 		goto free_eptdev;
@@ -386,6 +394,21 @@ int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent
 
 	return ret;
 }
+
+int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent,
+			       struct rpmsg_channel_info chinfo)
+{
+	struct rpmsg_eptdev *eptdev;
+	int ret;
+
+	eptdev = rpmsg_chrdev_eptdev_alloc(rpdev, parent);
+	if (IS_ERR(eptdev))
+		return PTR_ERR(eptdev);
+
+	ret = rpmsg_chrdev_eptdev_add(eptdev, chinfo);
+
+	return ret;
+}
 EXPORT_SYMBOL(rpmsg_chrdev_eptdev_create);
 
 static int rpmsg_chrdev_init(void)
-- 
2.25.1

