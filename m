Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD755735A1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbiGMLhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236301AbiGMLgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:36:54 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F14D1034D4;
        Wed, 13 Jul 2022 04:36:45 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26D8qRcj023844;
        Wed, 13 Jul 2022 13:36:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=1amBkc4Xuz2fmeyUJfLVlnyVufATTFOqWnVjRswilgY=;
 b=kxEXBMcfNpISdQVooIPL7Pg39q4ugSLor+HlQ8FtW+dtG4edd9CNEp2If00RVDWdThD0
 2XqHuB7q0DrB6ld1VnWebdmys2GRZmn2NFqYXZ77QON/z8MKv7KVHScrUAYJ9sz5enX7
 BSbOH4DkjTW77QvWytyk1METmLkPl4BSRaX2kDj+85MrE+pIk/62QZIoJGgLe3Drc3C3
 a4WYVJXa3u20VUxbg5PcrfGc2n+r6G2CjbSSKNhWrQ/g/hG4CzC9DZszscz8/IfelnvI
 ycuDC+MDR0DaD1FfShPMty0eLgLTLQKubskLLsG9jau2uZtttOBS7g/KIG3TOrgxrKhK SA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h94gugp7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 13:36:30 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7850410002A;
        Wed, 13 Jul 2022 13:36:28 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D76E021D386;
        Wed, 13 Jul 2022 13:36:28 +0200 (CEST)
Received: from localhost (10.75.127.48) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 13 Jul
 2022 13:36:28 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v7 2/4] remoteproc: core: Introduce rproc_add_rvdev function
Date:   Wed, 13 Jul 2022 13:36:10 +0200
Message-ID: <20220713113612.2117279-3-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.24.3
In-Reply-To: <20220713113612.2117279-1-arnaud.pouliquen@foss.st.com>
References: <20220713113612.2117279-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_14,2022-07-13_02,2022-06-22_01
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
remoteproc_virtio.c (i.e rproc_rvdev_add_device function),
introduce the rproc_add_rvdev and rproc_remove_rvdev functions.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
Update vs previous version
- Fix commit message by removing rproc_rvdev_remove_device reference.
---
 drivers/remoteproc/remoteproc_core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index f328d45d8376..13f0f8ef05a5 100644
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

