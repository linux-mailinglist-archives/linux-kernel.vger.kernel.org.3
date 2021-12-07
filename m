Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD3246B545
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhLGIMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:12:47 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42060 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231543AbhLGIMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:12:38 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B743N6v019282;
        Tue, 7 Dec 2021 09:08:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=/8mhOl8RofCa/gcd5Sw/vgwh6rK5f5gsqSHmOrvc1JI=;
 b=MckttOhNGuy2Mg1eUcGv1aOfd/ptjUQpTiqawFGgQdXFrvMQ0DYumHPnTOXFqrYlQcq7
 bizHiXtiuxpU8RH5tS7fPyV9WjzjDrMXfOQxChhyiTzoE/nOrSlETl9Fl1onEocM0rq7
 /oXc49qJigQ+iLKM5TpEcZqnPmsOh046aHEYqpXSDvMJWV9KIYl0UqVhUOP78vQXI279
 2suNHsxWKPf8fUvQuoVispgGTzeAkLYzezFOeIs93VEhfMSk8LHovom3X4GqQVPKcMzW
 nAie9vofB/aCjMrCjlma160yH76zwW+jXuj72QGaArGcqxD1l7R6Llf4WRghi9m1eHMY 1w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3csp32bc9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 09:08:59 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4ADA110002A;
        Tue,  7 Dec 2021 09:08:59 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 432312220B0;
        Tue,  7 Dec 2021 09:08:59 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 7 Dec 2021 09:08:58
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <julien.massot@iot.bzh>, <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v8 08/13] rpmsg: char: Refactor rpmsg_chrdev_eptdev_create function
Date:   Tue, 7 Dec 2021 09:08:38 +0100
Message-ID: <20211207080843.21222-9-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211207080843.21222-1-arnaud.pouliquen@foss.st.com>
References: <20211207080843.21222-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_03,2021-12-06_02,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the rpmsg_chrdev_eptdev_alloc and  rpmsg_chrdev_eptdev_add
internal function to split the allocation part from the device add.

This patch prepares the introduction of a rpmsg channel device for the
char device. An default endpoint will be created,
referenced in the rpmsg_eptdev structure before adding the devices.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/rpmsg/rpmsg_char.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index fab42964bcbb..a39f19161cd6 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -328,20 +328,18 @@ static void rpmsg_eptdev_release_device(struct device *dev)
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
@@ -357,6 +355,16 @@ int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent
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
@@ -393,6 +401,21 @@ int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent
 
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
2.17.1

