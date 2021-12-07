Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A2946B560
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhLGINm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:13:42 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42870 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232241AbhLGINf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:13:35 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B740hsw018633;
        Tue, 7 Dec 2021 09:10:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=wPRFwNUvvvZvnP1yFH2bxx5PGqqknf2TcOuv8jRoCDs=;
 b=KdO+t4AMsinj9Cg/7HNbZpTaT7ghp6H46ALZDpy4smEx+cLpRrLScr5wpPIChaQnUef4
 xq9ttt1qSH3Wlvf083Y3KPwsQt86uTY81GD5sk8w/DgRF0hcm38baNjByN7zZ0qTo3Na
 jIMTm5Ulq3K8V1PwgphljWVTYPCM7OJdMQsQqzafE7MvGvbFV1vkVtG+IzTqYbPr1LeD
 EdKmfucmg5Ju0oTO51tx8rNKNmtJ95Nwvu+LfYjod3aMK7DvYgekXcxXgfLYMpBbaWAh
 1XcvXyFaQj8wOqAe8eXr/eiMMIYwbFZ4Tb+Antcz8qfBrTjLOuLPqyKvHxG1VDIuDc8X zQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3csp32bcgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 09:10:03 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 43EA2100039;
        Tue,  7 Dec 2021 09:10:03 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3A1F021B526;
        Tue,  7 Dec 2021 09:10:03 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 7 Dec 2021 09:10:02
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <julien.massot@iot.bzh>, <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v8 13/13] rpmsg: core: Send a ns announcement when a default endpoint is created
Date:   Tue, 7 Dec 2021 09:08:43 +0100
Message-ID: <20211207080843.21222-14-arnaud.pouliquen@foss.st.com>
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

When a channel is created by user space application with the
RPMSG_CREATE_DEV_IOCTL controls, a ns announcement has to be sent
(depending on backend) to inform the remote side that a new service
is available.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/rpmsg/rpmsg_core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 3f86512147e8..27aad6baf7c5 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -145,6 +145,9 @@ EXPORT_SYMBOL(rpmsg_destroy_ept);
  *
  * This function returns a pointer to an endpoint created and assigned as the default
  * endpoint of the rpmsg device.
+ * If we need to, we also announce about this channel to the remote
+ * processor. This announcement is needed in case the driver is exposing an rpmsg service that has
+ * been created locally.
  *
  * Drivers should provide their @rpdev channel (so the new endpoint would belong
  * to the same remote processor their channel belongs to), an rx callback
@@ -161,6 +164,7 @@ struct rpmsg_endpoint *rpmsg_create_default_ept(struct rpmsg_device *rpdev,
 						struct rpmsg_channel_info chinfo)
 {
 	struct rpmsg_endpoint *ept;
+	int err;
 
 	if (WARN_ON(!rpdev))
 		return NULL;
@@ -183,6 +187,17 @@ struct rpmsg_endpoint *rpmsg_create_default_ept(struct rpmsg_device *rpdev,
 	rpdev->ept = ept;
 	rpdev->src = ept->addr;
 
+	if (rpdev->ops->announce_create) {
+		err = rpdev->ops->announce_create(rpdev);
+		if (err) {
+			rpmsg_destroy_ept(ept);
+			rpdev->ept = NULL;
+			rpdev->src = RPMSG_ADDR_ANY;
+
+			return NULL;
+		}
+	}
+
 	return ept;
 }
 EXPORT_SYMBOL(rpmsg_create_default_ept);
-- 
2.17.1

