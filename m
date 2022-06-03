Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A1353CD3B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 18:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343925AbiFCQcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 12:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244687AbiFCQcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 12:32:13 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A80C2A730;
        Fri,  3 Jun 2022 09:32:12 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253GIOk9013105;
        Fri, 3 Jun 2022 18:32:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=IYOFufpA10V0EHmZjJA7uNTFMBaZouDi4e6EJ4sRj9A=;
 b=TldCEU0v2aoExGYzJ+YBuDLOKLZXRHO3cmVoBwswpk0uFWQBKwlVJ6gb3JShBEPgWFII
 ALxIp0t46C4hARccca9uEYqgBz/IbLaegnY5bIXQ61FY3fRYNAoJw/V4odtCiysUFvRF
 hckES/U8rE0j6Agr2Fy+qxv0RUghyjy7VqymFTkQaG5lQTR/ZPCulvIehQ1wXXbMNDD6
 tT+iYtR7tBBT4BMDwzC7bx8mhONZzlpttL99ccRB/eZW1dfHXZg6GCmlHFe9oHQ5sZRM
 DjJi7Fc+QI2hZDCf1k9egjWikAouc7lNGqw2tLwg9Znf4HfRhIO4MvjxKgXNXEN056zT cg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gespq8w9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 18:32:04 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A496F100038;
        Fri,  3 Jun 2022 18:32:03 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9BE1B231533;
        Fri,  3 Jun 2022 18:32:03 +0200 (CEST)
Received: from localhost (10.75.127.48) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 3 Jun
 2022 18:32:02 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v6 2/4] remoteproc: core: Introduce rproc_add_rvdev function
Date:   Fri, 3 Jun 2022 18:31:56 +0200
Message-ID: <20220603163158.612513-3-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.24.3
In-Reply-To: <20220603163158.612513-1-arnaud.pouliquen@foss.st.com>
References: <20220603163158.612513-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_05,2022-06-03_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rproc structure contains a list of registered rproc_vdev structure.
To be able to move the management of the rproc_vdev structure in
remoteproc_virtio.c (i.e rproc_rvdev_add_device and
rproc_rvdev_remove_device functions), introduce the rproc_add_rvdev
and rproc_remove_rvdev functions.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
Updates vs previous revision (based on Mathieu Poirier's comments):
- Fix function name in commit message and add Mathieu's Reviewed-by.
---
 drivers/remoteproc/remoteproc_core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index c438c32f7f0d..86147efc0aad 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -484,6 +484,18 @@ static int copy_dma_range_map(struct device *to, struct device *from)
 	return 0;
 }
 
+static void rproc_add_rvdev(struct rproc *rproc, struct rproc_vdev *rvdev)
+{
+	if (rvdev && rproc)
+		list_add_tail(&rvdev->node, &rproc->rvdevs);
+}
+
+static void rproc_remove_rvdev(struct rproc_vdev *rvdev)
+{
+	if (rvdev)
+		list_del(&rvdev->node);
+}
+
 static struct rproc_vdev *
 rproc_rvdev_add_device(struct rproc *rproc, struct rproc_vdev_data *rvdev_data)
 {
@@ -547,7 +559,7 @@ rproc_rvdev_add_device(struct rproc *rproc, struct rproc_vdev_data *rvdev_data)
 			goto unwind_vring_allocations;
 	}
 
-	list_add_tail(&rvdev->node, &rproc->rvdevs);
+	rproc_add_rvdev(rproc, rvdev);
 
 	rvdev->subdev.start = rproc_vdev_do_start;
 	rvdev->subdev.stop = rproc_vdev_do_stop;
@@ -577,7 +589,7 @@ void rproc_vdev_release(struct kref *ref)
 	}
 
 	rproc_remove_subdev(rproc, &rvdev->subdev);
-	list_del(&rvdev->node);
+	rproc_remove_rvdev(rvdev);
 	device_unregister(&rvdev->dev);
 }
 
-- 
2.24.3

