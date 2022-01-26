Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C23D49CF9C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243108AbiAZQYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:24:33 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:57544 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236787AbiAZQYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:24:30 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20QCbu9K017387;
        Wed, 26 Jan 2022 17:24:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=PqSgHehRXT9z6NjwUWn4LDcO+RgcjoZI7N2Lc7qu6Gk=;
 b=b0JAnK2SAswixoMsatpzIQGHcUsGVD9iW/r7GeS7pfSYw/CAO2i7GDCy+DPBFnnb1crV
 rNF5ZTpNv+90X7vACfuXBnB6hhqyFMpQjSl1JIuY+8CSSk5z3SMUxqzMZaJtnhnY5hqk
 OJKFbk6hEMbcLVy34s3PYyRBnRMSqWhD9VpbQCQ8uuQ50denNdDz6MePe2BRgCJJ//Ck
 w3mBfeQYkHQLYUPg90MOhs3Yde2rY6DTc2q7qz/Zv0jYn2o65PZIsnhFmRSYvpICQOwA
 n9FvBRUiRfV3qGWzekqL91teDme8P+kP7W0NV3+LA/3Am85ph2WZ2wlS1VLof8OXD3Kl ZA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3du26mjr16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 17:24:16 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EEAB810002A;
        Wed, 26 Jan 2022 17:24:15 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E6A362291D2;
        Wed, 26 Jan 2022 17:24:15 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 26 Jan 2022 17:24:15
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [RFC PATCH v3 2/4] remoteproc: core: Introduce rproc_register_rvdev function
Date:   Wed, 26 Jan 2022 17:24:03 +0100
Message-ID: <20220126162405.1131323-3-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126162405.1131323-1-arnaud.pouliquen@foss.st.com>
References: <20220126162405.1131323-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_05,2022-01-26_01,2021-12-02_01
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
 drivers/remoteproc/remoteproc_core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 83ff44a6a4db..7a091f860c82 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -491,6 +491,18 @@ static int copy_dma_range_map(struct device *to, struct device *from)
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
 static struct rproc_vdev *
 rproc_rvdev_add_device(struct rproc *rproc, struct rproc_vdev_data *rvdev_data)
 {
@@ -554,7 +566,7 @@ rproc_rvdev_add_device(struct rproc *rproc, struct rproc_vdev_data *rvdev_data)
 			goto unwind_vring_allocations;
 	}
 
-	list_add_tail(&rvdev->node, &rproc->rvdevs);
+	rproc_register_rvdev(rproc, rvdev);
 
 	rvdev->subdev.start = rproc_vdev_do_start;
 	rvdev->subdev.stop = rproc_vdev_do_stop;
@@ -583,7 +595,7 @@ static void rproc_rvdev_remove_device(struct rproc_vdev *rvdev)
 	}
 
 	rproc_remove_subdev(rproc, &rvdev->subdev);
-	list_del(&rvdev->node);
+	rproc_unregister_rvdev(rvdev);
 	device_unregister(&rvdev->dev);
 }
 
-- 
2.25.1

