Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFD352E797
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347208AbiETIcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347041AbiETIbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:31:19 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC7347540;
        Fri, 20 May 2022 01:31:17 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K8N4uh009064;
        Fri, 20 May 2022 10:31:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=jJqFYr/2kSFBBvwcNFQzdXYzRLTYOhwzMWQZ47+U0eM=;
 b=1XaD9oxWSDAZuwmh7yhFRShcHlu+fvFhvXpJz/oo8hD3a7v0J2mq6Rm/eV8txz8T+SwR
 rAj65pGe6ERCgwXiOHVIakgmCZ3qSPqQFCgVqVtyqUN/VQTZU78WNHue9ztxxVfBnKxH
 Ys1MphcL0EHDWTTZNTOVLL2ez7qTrE60UYYa/a8squWkyRDajojYWw4k11WkAz995zkp
 hLPdjQZaceAQlDUj9cSbPUMjDlK0UURBD5obFgLBXD3l6Deo8F8kNEEumF2TgGCxbfIt
 2JIEhWP+Fl10LB7/PptxBxoSuzSQOfDks4mTEBepYeqFOi0pjMu/aOOZFyWQbONYUyUl zA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g21j9f7h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 10:31:12 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 52836100038;
        Fri, 20 May 2022 10:31:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 49418215131;
        Fri, 20 May 2022 10:31:10 +0200 (CEST)
Received: from localhost (10.75.127.47) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 20 May
 2022 10:31:09 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Chris Lew <quic_clew@quicinc.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [RFC PATCH 06/10] rpmsg: virtio: Add support of the VIRTIO_RPMSG_F_FC feature
Date:   Fri, 20 May 2022 10:29:36 +0200
Message-ID: <20220520082940.2984914-7-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520082940.2984914-1-arnaud.pouliquen@foss.st.com>
References: <20220520082940.2984914-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_03,2022-05-19_03,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the VIRTIO_RPMSG_F_FC feature in charge of the end
point flow control management.
The virtio feature is negotiated. If the remote side supports it,
the rpmsg_fc device is probed.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/rpmsg/Kconfig            |  1 +
 drivers/rpmsg/virtio_rpmsg_bus.c | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
index c6659f27c617..e39cf32483de 100644
--- a/drivers/rpmsg/Kconfig
+++ b/drivers/rpmsg/Kconfig
@@ -89,6 +89,7 @@ config RPMSG_VIRTIO
 	depends on HAS_DMA
 	select RPMSG
 	select RPMSG_NS
+	select RPMSG_FC
 	select VIRTIO
 
 endmenu
diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 785fda77984e..40d2ab86b395 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -19,6 +19,7 @@
 #include <linux/mutex.h>
 #include <linux/rpmsg.h>
 #include <linux/rpmsg/byteorder.h>
+#include <linux/rpmsg/fc.h>
 #include <linux/rpmsg/ns.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
@@ -70,6 +71,7 @@ struct virtproc_info {
 
 /* The feature bitmap for virtio rpmsg */
 #define VIRTIO_RPMSG_F_NS	0 /* RP supports name service notifications */
+#define VIRTIO_RPMSG_F_FC	1 /* RP supports endpoint flow control notifications */
 
 /**
  * struct rpmsg_hdr - common header for all rpmsg messages
@@ -909,7 +911,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
 	struct virtqueue *vqs[2];
 	struct virtproc_info *vrp;
 	struct virtio_rpmsg_channel *vch = NULL;
-	struct rpmsg_device *rpdev_ns, *rpdev_ctrl;
+	struct rpmsg_device *rpdev_ns = NULL, *rpdev_ctrl, *rpdev_fc;
 	void *bufs_va;
 	int err = 0, i;
 	size_t total_buf_space;
@@ -1013,6 +1015,30 @@ static int rpmsg_probe(struct virtio_device *vdev)
 			goto free_ctrldev;
 	}
 
+	/* If supported by the remote processor, enable the flow control service */
+	if (virtio_has_feature(vdev, VIRTIO_RPMSG_F_FC)) {
+		vch = kzalloc(sizeof(*vch), GFP_KERNEL);
+		if (!vch) {
+			err = -ENOMEM;
+			goto free_ns;
+		}
+
+		/* Link the channel to our vrp */
+		vch->vrp = vrp;
+
+		/* Assign public information to the rpmsg_device */
+		rpdev_fc = &vch->rpdev;
+		rpdev_fc->ops = &virtio_rpmsg_ops;
+		rpdev_fc->little_endian = virtio_is_little_endian(vrp->vdev);
+
+		rpdev_fc->dev.parent = &vrp->vdev->dev;
+		rpdev_fc->dev.release = virtio_rpmsg_release_device;
+
+		err = rpmsg_fc_register_device(rpdev_fc);
+		if (err)
+			goto free_ns;
+	}
+
 	/*
 	 * Prepare to kick but don't notify yet - we can't do this before
 	 * device is ready.
@@ -1034,6 +1060,9 @@ static int rpmsg_probe(struct virtio_device *vdev)
 
 	return 0;
 
+free_ns:
+	if (rpdev_ns)
+		device_unregister(&rpdev_ns->dev);
 free_ctrldev:
 	rpmsg_virtio_del_ctrl_dev(rpdev_ctrl);
 free_coherent:
@@ -1082,6 +1111,7 @@ static struct virtio_device_id id_table[] = {
 
 static unsigned int features[] = {
 	VIRTIO_RPMSG_F_NS,
+	VIRTIO_RPMSG_F_FC,
 };
 
 static struct virtio_driver virtio_ipc_driver = {
-- 
2.25.1

