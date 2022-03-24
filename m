Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3F24E630E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347310AbiCXMT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346416AbiCXMTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:19:46 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43792CC80;
        Thu, 24 Mar 2022 05:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648124294; x=1679660294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=TrOebLAqyT9HE+wBykQ5A6GHPyKNRIX32XnDb3uzGkY=;
  b=GLJWOnJqcE9lOrnRzxvebCZaqtGMoTglKPWiOyZYaYTQA2ddJtJQ/n82
   cpiIA2caFBJTyIhye5Ud9u8sTDiBpW1hG1n1qfK6BrJAR5ix0T2nURF+e
   xRSQsRcv1C6yknCQ1c3udQytfxuXt7JXpaSZ2Qv53oZp/PFRoeBYCkNSr
   0=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 24 Mar 2022 05:18:13 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 05:18:12 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 24 Mar 2022 05:18:12 -0700
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 24 Mar 2022 05:18:08 -0700
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v4 02/10] Coresight: Add coresight TPDM source driver
Date:   Thu, 24 Mar 2022 20:17:26 +0800
Message-ID: <20220324121734.21531-3-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220324121734.21531-1-quic_jinlmao@quicinc.com>
References: <20220324121734.21531-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver to support Coresight device TPDM (Trace, Profiling and
Diagnostics Monitor). TPDM is a monitor to collect data from
different datasets. This change is to add probe/enable/disable
functions for tpdm source.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 drivers/hwtracing/coresight/Kconfig          |  13 ++
 drivers/hwtracing/coresight/Makefile         |   1 +
 drivers/hwtracing/coresight/coresight-core.c |   4 +-
 drivers/hwtracing/coresight/coresight-tpdm.c | 145 +++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpdm.h |  27 ++++
 include/linux/coresight.h                    |   1 +
 6 files changed, 190 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.c
 create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.h

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 514a9b8086e3..5c506a1cd08f 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -201,4 +201,17 @@ config CORESIGHT_TRBE
 
 	  To compile this driver as a module, choose M here: the module will be
 	  called coresight-trbe.
+
+config CORESIGHT_TPDM
+	tristate "CoreSight Trace, Profiling & Diagnostics Monitor driver"
+	select CORESIGHT_LINKS_AND_SINKS
+	help
+	  This driver provides support for configuring monitor. Monitors are
+	  primarily responsible for data set collection and support the
+	  ability to collect any permutation of data set types. Monitors are
+	  also responsible for interaction with system cross triggering.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called coresight-tpdm.
+
 endif
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 329a0c704b87..6bb9b1746bc7 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -25,5 +25,6 @@ obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
 obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
 obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
 obj-$(CONFIG_CORESIGHT_TRBE) += coresight-trbe.o
+obj-$(CONFIG_CORESIGHT_TPDM) += coresight-tpdm.o
 coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
 		   coresight-cti-sysfs.o
diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 8ff94d020893..d80d01f4237b 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -398,6 +398,7 @@ static void coresight_disable_link(struct coresight_device *csdev,
 static int coresight_enable_source(struct coresight_device *csdev, u32 mode)
 {
 	int ret;
+	u32 subtype;
 
 	if (!csdev->enable) {
 		if (source_ops(csdev)->enable) {
@@ -1040,7 +1041,8 @@ static int coresight_validate_source(struct coresight_device *csdev,
 	}
 
 	if (subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_PROC &&
-	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE) {
+	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE &&
+	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_DATA_ONLY) {
 		dev_err(&csdev->dev, "wrong device subtype in %s\n", function);
 		return -EINVAL;
 	}
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
new file mode 100644
index 000000000000..3900ae50670a
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/amba/bus.h>
+#include <linux/bitmap.h>
+#include <linux/coresight.h>
+#include <linux/coresight-pmu.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+
+#include "coresight-priv.h"
+#include "coresight-tpdm.h"
+
+DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
+
+/* TPDM enable operations */
+static int tpdm_enable(struct coresight_device *csdev,
+		       struct perf_event *event, u32 mode)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	mutex_lock(&drvdata->lock);
+	if (drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EBUSY;
+	}
+
+	drvdata->enable = true;
+	mutex_unlock(&drvdata->lock);
+
+	dev_info(drvdata->dev, "TPDM tracing enabled\n");
+	return 0;
+}
+
+/* TPDM disable operations */
+static void tpdm_disable(struct coresight_device *csdev,
+			 struct perf_event *event)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	mutex_lock(&drvdata->lock);
+	if (!drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return;
+	}
+
+	drvdata->enable = false;
+	mutex_unlock(&drvdata->lock);
+
+	dev_info(drvdata->dev, "TPDM tracing disabled\n");
+}
+
+static const struct coresight_ops_source tpdm_source_ops = {
+	.enable		= tpdm_enable,
+	.disable	= tpdm_disable,
+};
+
+static const struct coresight_ops tpdm_cs_ops = {
+	.source_ops	= &tpdm_source_ops,
+};
+
+static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
+{
+	struct device *dev = &adev->dev;
+	struct coresight_platform_data *pdata;
+	struct tpdm_drvdata *drvdata;
+	struct coresight_desc desc = { 0 };
+
+	pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+	adev->dev.platform_data = pdata;
+
+	/* driver data*/
+	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+	drvdata->dev = &adev->dev;
+	dev_set_drvdata(dev, drvdata);
+
+	drvdata->base = devm_ioremap_resource(dev, &adev->res);
+	if (!drvdata->base)
+		return -ENOMEM;
+
+	mutex_init(&drvdata->lock);
+
+	/* Set up coresight component description */
+	desc.name = coresight_alloc_device_name(&tpdm_devs, dev);
+	if (!desc.name)
+		return -ENOMEM;
+	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
+	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_DATA_ONLY;
+	desc.ops = &tpdm_cs_ops;
+	desc.pdata = adev->dev.platform_data;
+	desc.dev = &adev->dev;
+	drvdata->csdev = coresight_register(&desc);
+	if (IS_ERR(drvdata->csdev))
+		return PTR_ERR(drvdata->csdev);
+
+	/* Decrease pm refcount when probe is done.*/
+	pm_runtime_put(&adev->dev);
+
+	return 0;
+}
+
+static void __exit tpdm_remove(struct amba_device *adev)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+
+	coresight_unregister(drvdata->csdev);
+}
+
+/*
+ * Different TPDM has different periph id.
+ * The difference is 0-7 bits' value. So ignore 0-7 bits.
+ */
+static struct amba_id tpdm_ids[] = {
+	{
+		.id = 0x000f0e00,
+		.mask = 0x000fff00,
+	},
+	{ 0, 0},
+};
+
+static struct amba_driver tpdm_driver = {
+	.drv = {
+		.name   = "coresight-tpdm",
+		.owner	= THIS_MODULE,
+		.suppress_bind_attrs = true,
+	},
+	.probe          = tpdm_probe,
+	.id_table	= tpdm_ids,
+};
+
+module_amba_driver(tpdm_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Trace, Profiling & Diagnostic Monitor driver");
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
new file mode 100644
index 000000000000..3429fca9f2d7
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _CORESIGHT_CORESIGHT_TPDM_H
+#define _CORESIGHT_CORESIGHT_TPDM_H
+
+/**
+ * struct tpdm_drvdata - specifics associated to an TPDM component
+ * @base:       memory mapped base address for this component.
+ * @dev:        The device entity associated to this component.
+ * @csdev:      component vitals needed by the framework.
+ * @lock:       lock for the enable value.
+ * @enable:     enable status of the component.
+ * @traceid:    value of the current ID for this component.
+ */
+
+struct tpdm_drvdata {
+	void __iomem		*base;
+	struct device		*dev;
+	struct coresight_device	*csdev;
+	struct mutex		lock;
+	bool			enable;
+};
+
+#endif  /* _CORESIGHT_CORESIGHT_TPDM_H */
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 0154b057b965..7614275162f6 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -65,6 +65,7 @@ enum coresight_dev_subtype_source {
 	CORESIGHT_DEV_SUBTYPE_SOURCE_PROC,
 	CORESIGHT_DEV_SUBTYPE_SOURCE_BUS,
 	CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE,
+	CORESIGHT_DEV_SUBTYPE_SOURCE_DATA_ONLY,
 };
 
 enum coresight_dev_subtype_helper {
-- 
2.17.1

