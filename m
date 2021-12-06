Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CB946A55E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348248AbhLFTLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:11:43 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:42956 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242725AbhLFTLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:11:43 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B6F9w3n003232;
        Mon, 6 Dec 2021 20:08:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=3pk5K2bLOEaobNBUebhHMo5aHf9XY7QA5+jodg260G4=;
 b=uLwf6R7SN24/NQ4zuHAw4/p51jlY8ZO6kNYx+H1TGEKUHZEYkTbXFLyeouwpI2yqshuq
 2+YZ2ytvo2ug3ULyr9qwng2PT16CNq0R8MLG1vgN35pSrwjT7KVLI0w1vAQitX1sQRX2
 BWiehA76Y+Qbz6oMnrekOcCKdBc6Ev4Y3LAOI5DEVR5JGKaTXXe9tRk+FMA7awlraxpL
 uF26C8gFBsj3KEHBb0vDHVh6Ly3p3pz8RPvLcq7jvoccvAPUU1faF7fJHCNr6wfYTaLd
 N/QNysd/BCbgWtF+pH6qr3h/ZjiK6WCwvqXxhEfGSqwnow9EVw3dfggf1oBpLecpI9HF 1Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3csmx0h0bu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 20:08:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7391010002A;
        Mon,  6 Dec 2021 20:08:10 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E7334212FC4;
        Mon,  6 Dec 2021 20:08:10 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 6 Dec 2021 20:08:10
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [PATCH] rpmsg: core: Clean up resources on announce_create failure.
Date:   Mon, 6 Dec 2021 20:07:58 +0100
Message-ID: <20211206190758.10004-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_07,2021-12-06_02,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the rpmsg_dev_probe, if rpdev->ops->announce_create returns an
error, the rpmsg device and default endpoint should be freed before
exiting the function.

Fixes: 5e619b48677c ("rpmsg: Split rpmsg core and virtio backend")
Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/rpmsg/rpmsg_core.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 27aad6baf7c5..12d7b7c6e5f9 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -612,13 +612,25 @@ static int rpmsg_dev_probe(struct device *dev)
 	err = rpdrv->probe(rpdev);
 	if (err) {
 		dev_err(dev, "%s: failed: %d\n", __func__, err);
-		if (ept)
-			rpmsg_destroy_ept(ept);
-		goto out;
+		goto destroy_ept;
 	}
 
-	if (ept && rpdev->ops->announce_create)
+	if (ept && rpdev->ops->announce_create) {
 		err = rpdev->ops->announce_create(rpdev);
+		if (err) {
+			dev_err(dev, "failed to announce creation\n");
+			goto remove_rpdev;
+		}
+	}
+
+	return 0;
+
+remove_rpdev:
+	if (rpdrv->remove)
+		rpdrv->remove(rpdev);
+destroy_ept:
+	if (ept)
+		rpmsg_destroy_ept(ept);
 out:
 	return err;
 }
-- 
2.17.1

