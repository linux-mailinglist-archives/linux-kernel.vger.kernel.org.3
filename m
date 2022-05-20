Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9392852E79D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347185AbiETIcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347172AbiETIcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:32:19 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34326A40E;
        Fri, 20 May 2022 01:31:30 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K1fHuU021302;
        Fri, 20 May 2022 10:31:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=CdJLGIQGVB3QH47VC81jXK7okrgL52nTShMQiG+y/eI=;
 b=pyWNmPkUKV7bLK7LEt6AOPvIr540TQpwFm3VA24hUouFyUk7T4ny2ixzjb9vpRC1W2IM
 89Mm+qqPajmIKndjBJpfmlbop0iqyBuHWadOm5mr8BjhIeSUFM8tWD+Ab+IxM3g2UyGL
 2xnXy+1uFLXxzbspNFa2Q4z9QpUCjE1co/Sawork0lWwxTM9yLdxVMjfgko918bKC03F
 fOocU2oKEM0gBFF2oIdw2dStKObF5Wk3JQDtoVXRWV2eR3aqGocUEdMDGupTD3X/NRJV
 bve2oMjeUGvOkWRKi8+XUNHnT1v4D+waretm2gIaP9vk5IBQ70VwxbZks2yoHbKjz9i9 DA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g23aj6vtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 10:31:12 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E8F9810002A;
        Fri, 20 May 2022 10:31:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E178921512E;
        Fri, 20 May 2022 10:31:09 +0200 (CEST)
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
Subject: [RFC PATCH 05/10] rpmsg: Introduce flow control channel driver
Date:   Fri, 20 May 2022 10:29:35 +0200
Message-ID: <20220520082940.2984914-6-arnaud.pouliquen@foss.st.com>
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

Register the channel 54 to manage flow control between endpoints.
the aim of this service is.
- to inform the local endpoint of the state of the associated remote
endpoints.
- to inform remote endpoint about the state of the local endpoint.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/rpmsg/Kconfig    |  10 ++++
 drivers/rpmsg/Makefile   |   1 +
 drivers/rpmsg/rpmsg_fc.c | 113 +++++++++++++++++++++++++++++++++++++++
 include/linux/rpmsg/fc.h |  51 ++++++++++++++++++
 4 files changed, 175 insertions(+)
 create mode 100644 drivers/rpmsg/rpmsg_fc.c
 create mode 100644 include/linux/rpmsg/fc.h

diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
index d3795860f5c0..c6659f27c617 100644
--- a/drivers/rpmsg/Kconfig
+++ b/drivers/rpmsg/Kconfig
@@ -31,6 +31,16 @@ config RPMSG_NS
 	  channel that probes the associated RPMsg device on remote endpoint
 	  service announcement.
 
+config RPMSG_FC
+	tristate "RPMSG endpoint flow control management"
+	depends on RPMSG
+	help
+	  Say Y here to enable the support of the flow control management
+	  for the rpmsg endpoints.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called rpmsg_fc.
+
 config RPMSG_MTK_SCP
 	tristate "MediaTek SCP"
 	depends on MTK_SCP
diff --git a/drivers/rpmsg/Makefile b/drivers/rpmsg/Makefile
index 58e3b382e316..c70b9864231f 100644
--- a/drivers/rpmsg/Makefile
+++ b/drivers/rpmsg/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_RPMSG)		+= rpmsg_core.o
 obj-$(CONFIG_RPMSG_CHAR)	+= rpmsg_char.o
 obj-$(CONFIG_RPMSG_CTRL)	+= rpmsg_ctrl.o
 obj-$(CONFIG_RPMSG_NS)		+= rpmsg_ns.o
+obj-$(CONFIG_RPMSG_FC)		+= rpmsg_fc.o
 obj-$(CONFIG_RPMSG_MTK_SCP)	+= mtk_rpmsg.o
 qcom_glink-objs			:= qcom_glink_native.o qcom_glink_ssr.o
 obj-$(CONFIG_RPMSG_QCOM_GLINK) += qcom_glink.o
diff --git a/drivers/rpmsg/rpmsg_fc.c b/drivers/rpmsg/rpmsg_fc.c
new file mode 100644
index 000000000000..d7e17c8cffb0
--- /dev/null
+++ b/drivers/rpmsg/rpmsg_fc.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) STMicroelectronics 2022 - All Rights Reserved
+ */
+
+#define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/rpmsg.h>
+#include <linux/rpmsg/fc.h>
+#include <linux/slab.h>
+
+#include "rpmsg_internal.h"
+
+/**
+ * rpmsg_fc_register_device() - register name service device based on rpdev
+ * @rpdev: prepared rpdev to be used catfor creating endpoints
+ *
+ * This function wraps rpmsg_register_device() preparing the rpdev for use as
+ * basis for the rpmsg name service device.
+ */
+int rpmsg_fc_register_device(struct rpmsg_device *rpdev)
+{
+	strcpy(rpdev->id.name, "rpmsg_fc");
+	rpdev->driver_override = KBUILD_MODNAME;
+	rpdev->src = RPMSG_FC_ADDR;
+	rpdev->dst = RPMSG_FC_ADDR;
+
+	return rpmsg_register_device(rpdev);
+}
+EXPORT_SYMBOL(rpmsg_fc_register_device);
+
+/* Invoked when a name service announcement arrives */
+static int rpmsg_fc_cb(struct rpmsg_device *rpdev, void *data, int len,
+		       void *priv, u32 src)
+{
+	struct rpmsg_ept_msg *msg = data;
+	struct rpmsg_channel_info chinfo;
+	struct device *dev = rpdev->dev.parent;
+	bool enable;
+	int ret;
+
+	if (len != sizeof(*msg)) {
+		dev_err(dev, "malformed fc msg (%d)\n", len);
+		return -EINVAL;
+	}
+
+	chinfo.src = rpmsg32_to_cpu(rpdev, msg->src);
+	chinfo.dst = rpmsg32_to_cpu(rpdev, msg->dst);
+	enable = rpmsg32_to_cpu(rpdev, msg->flags) & RPMSG_EPT_FC_ON;
+
+	dev_dbg(dev, "remote endpoint 0x%x in state %sable\n", chinfo.src, enable ? "en" : "dis");
+
+	ret = rpmsg_channel_remote_fc(rpdev, &chinfo, enable);
+	if (ret)
+		dev_err(dev, "rpmsg_annouce_flow_ctrl failed: %d\n", ret);
+
+	return ret;
+}
+
+static int rpmsg_fc_probe(struct rpmsg_device *rpdev)
+{
+	struct rpmsg_endpoint *fc_ept;
+	struct rpmsg_channel_info fc_chinfo = {
+		.src = RPMSG_FC_ADDR,
+		.dst = RPMSG_FC_ADDR,
+		.name = "flow_control_service",
+	};
+
+	/*
+	 * Create the Flow control (FC) service endpoint associated to the RPMsg
+	 * device. The endpoint will be automatically destroyed when the RPMsg
+	 * device will be deleted.
+	 */
+	fc_ept = rpmsg_create_ept(rpdev, rpmsg_fc_cb, NULL, fc_chinfo);
+	if (!fc_ept) {
+		dev_err(&rpdev->dev, "failed to create the FC ept\n");
+		return -ENOMEM;
+	}
+	rpdev->ept = fc_ept;
+
+	return 0;
+}
+
+static struct rpmsg_driver rpmsg_fc_driver = {
+	.drv.name = KBUILD_MODNAME,
+	.probe = rpmsg_fc_probe,
+};
+
+static int rpmsg_fc_init(void)
+{
+	int ret;
+
+	ret = register_rpmsg_driver(&rpmsg_fc_driver);
+	if (ret < 0)
+		pr_err("%s: Failed to register FC rpmsg driver\n", __func__);
+
+	return ret;
+}
+postcore_initcall(rpmsg_fc_init);
+
+static void rpmsg_fc_exit(void)
+{
+	unregister_rpmsg_driver(&rpmsg_fc_driver);
+}
+module_exit(rpmsg_fc_exit);
+
+MODULE_DESCRIPTION("Flow control service rpmsg driver");
+MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>");
+MODULE_ALIAS("rpmsg:" KBUILD_MODNAME);
+MODULE_LICENSE("GPL");
diff --git a/include/linux/rpmsg/fc.h b/include/linux/rpmsg/fc.h
new file mode 100644
index 000000000000..5284ea410673
--- /dev/null
+++ b/include/linux/rpmsg/fc.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_RPMSG_FC_H
+#define _LINUX_RPMSG_FC_H
+
+#include <linux/mod_devicetable.h>
+#include <linux/rpmsg.h>
+#include <linux/rpmsg/byteorder.h>
+#include <linux/types.h>
+
+/* The feature bitmap for the endpoint flow control flags */
+#define	RPMSG_EPT_FC_ON	 BIT(0) /* Set when endpoint is ready to communicate */
+
+/**
+ * struct rpmsg_ept_msg - dynamic endpoint announcement message
+ * @src: address of the endpoint that sends the message
+ * @dest: address of the destination endpoint.
+ * @flags: indicates the state of the endpoint based on @rpmsg_ept_flags enum.
+ *
+ * This message is sent across to inform the remote about the state of a local
+ * endpoint associated with a remote endpoint:
+ * - a RPMSG_EPT_OFF can be sent to inform that a local endpoint is suspended.
+ * - a RPMSG_EPT_ON can be sent to inform that a local endpoint is ready to communicate.
+ *
+ * When we receive these messages, the appropriate endpoint is informed.
+ */
+struct rpmsg_ept_msg {
+	__rpmsg32 src;
+	__rpmsg32 dst;
+	__rpmsg32 flags;
+} __packed;
+
+/* Address 54 is reserved for flow control advertising */
+#define RPMSG_FC_ADDR                   (54)
+
+#if IS_ENABLED(CONFIG_RPMSG_FC)
+
+int rpmsg_fc_register_device(struct rpmsg_device *rpdev);
+
+#else
+
+static inline int rpmsg_fc_register_device(struct rpmsg_device *rpdev)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return -ENXIO;
+}
+#endif /* IS_ENABLED(CONFIG_RPMSG_FC)*/
+
+#endif
-- 
2.25.1

