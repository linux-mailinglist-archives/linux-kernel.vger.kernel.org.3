Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3979947CE28
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243323AbhLVIYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:24:05 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:40904 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239650AbhLVIX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:23:58 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BM1nx1V001281;
        Wed, 22 Dec 2021 09:23:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=9ytmNnktSgVcuMCUmEYOymJn3t8Et23yx7c3IzTty6g=;
 b=5KU4qsQVDtTLBYAw2HnnmNy4z0VLLYthPk9ZNEqphJb1+eUkcKDRrnh2Nxy/ZNxISKxE
 zV+gM5DiibnRkmMk3SIqSlu5B6tzox9z+5JgdKXXPa39cV3ABlR3YxHswoPh8QqCofql
 043shR9rt1W3O/ENOw0hJWlw70XFHX/+vIZZaUdwiklQT/RSo2hmfECP0J+3dI37UECv
 Toxod5EA5URwsxf3jVasiM9rD5bagrux9+L2GUrHhj+ibozDe7wA7wKNBh1ag0d1Yxa/
 MDoVY1/kAADr5jojvC9aSWLNGSdyTNqfqTCSDXusHAv2C8b9zUfkoQToMVcfcSObTSBm Rw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3d3bq05djb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 09:23:56 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3D46A100038;
        Wed, 22 Dec 2021 09:23:55 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 34D162221DB;
        Wed, 22 Dec 2021 09:23:55 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 22 Dec 2021 09:23:54
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [RFC PATCH v2 2/6] remoteproc: core: Introduce rproc_register_rvdev function
Date:   Wed, 22 Dec 2021 09:23:45 +0100
Message-ID: <20211222082349.30378-3-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211222082349.30378-1-arnaud.pouliquen@foss.st.com>
References: <20211222082349.30378-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-22_03,2021-12-21_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rproc structure contains a list of registered rproc_vdev structure.
To be able to move the management of the rproc_vdev structure in
remoteproc_virtio.c (i.e rproc_rvdev_add_device and
rproc_rvdev_remove_device functions), introduce the rproc_register_rvdev
and rproc_unregister_rvdev functions.
These functions will be exported by the remoteproc_core.c.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
Update vs previous revision:
  - add rproc struct as parameter of the rproc_register_rvdev function
---
 drivers/remoteproc/remoteproc_core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index d1f1c5c25bd7..fcc55dbfba3b 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -484,6 +484,18 @@ static int copy_dma_range_map(struct device *to, struct device *from)
 	return 0;
 }
 
+static void rproc_register_rvdev(struct rproc *rproc, struct rproc_vdev *rvdev)
+{
+	if (rvdev && rproc)
+		list_add_tail(&rvdev->node, &rproc->rvdevs);
+}
+
+static void rproc_unregister_rvdev(struct rproc_vdev *rvdev)
+{
+	if (rvdev)
+		list_del(&rvdev->node);
+}
+
 static int rproc_rvdev_add_device(struct rproc_vdev *rvdev)
 {
 	struct rproc *rproc = rvdev->rproc;
@@ -516,7 +528,7 @@ static int rproc_rvdev_add_device(struct rproc_vdev *rvdev)
 			 dma_get_mask(rproc->dev.parent), ERR_PTR(ret));
 	}
 
-	list_add_tail(&rvdev->node, &rproc->rvdevs);
+	rproc_register_rvdev(rproc, rvdev);
 
 	rvdev->subdev.start = rproc_vdev_do_start;
 	rvdev->subdev.stop = rproc_vdev_do_stop;
@@ -535,7 +547,7 @@ static void rproc_rvdev_remove_device(struct rproc_vdev *rvdev)
 	struct rproc *rproc = rvdev->rproc;
 
 	rproc_remove_subdev(rproc, &rvdev->subdev);
-	list_del(&rvdev->node);
+	rproc_unregister_rvdev(rvdev);
 	device_unregister(&rvdev->dev);
 }
 
-- 
2.17.1

