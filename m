Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B825517FA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241721AbiFTMCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241377AbiFTMBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:01:48 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893601838A;
        Mon, 20 Jun 2022 05:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655726505; x=1687262505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=3YedOrNBMgpBzmEf70XxRoMrvwOwruTcI/HhSxXglXA=;
  b=r+UznJXTcMcrYam9SfRmyeWSETnLiLnQyYCQUJ70bCKXglBYarcUsYCQ
   EqzZWdq7ykaJ/MA7jMAqYKasdDR3y4LPOPk6h+ShqfQb2joVsEWCKGiAO
   Hj7omn4II57DrOZrXMWwg9GcdEkD0I8RQ6oNVFluB8gBWWM9XDUw3O8AX
   w=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Jun 2022 05:01:45 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 05:01:45 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 20 Jun 2022 05:01:44 -0700
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 20 Jun 2022 05:01:40 -0700
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
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
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v11 6/9] Coresight: Add TPDA link driver
Date:   Mon, 20 Jun 2022 20:00:58 +0800
Message-ID: <20220620120101.2906-7-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220620120101.2906-1-quic_jinlmao@quicinc.com>
References: <20220620120101.2906-1-quic_jinlmao@quicinc.com>
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

TPDA(Trace, Profiling and Diagnostics Aggregator) is
to provide packetization, funneling and timestamping of
TPDM data. Multiple monitors are connected to different
input ports of TPDA.This change is to add tpda
enable/disable/probe functions for coresight tpda driver.

 - - - -         - - - -        - - - -
| TPDM 0|      | TPDM 1 |     | TPDM 2|
 - - - -         - - - -        - - - -
    |               |             |
    |_ _ _ _ _ _    |     _ _ _ _ |
                |   |    |
                |   |    |
           ------------------
          |        TPDA      |
           ------------------

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 drivers/hwtracing/coresight/Kconfig          |  11 +
 drivers/hwtracing/coresight/Makefile         |   1 +
 drivers/hwtracing/coresight/coresight-tpda.c | 206 +++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpda.h |  35 ++++
 4 files changed, 253 insertions(+)
 create mode 100644 drivers/hwtracing/coresight/coresight-tpda.c
 create mode 100644 drivers/hwtracing/coresight/coresight-tpda.h

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index b2b72a35e416..0cbebfd0d23e 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -205,6 +205,7 @@ config CORESIGHT_TRBE
 config CORESIGHT_TPDM
 	tristate "CoreSight Trace, Profiling & Diagnostics Monitor driver"
 	select CORESIGHT_LINKS_AND_SINKS
+	select CORESIGHT_TPDA
 	help
 	  This driver provides support for configuring monitor. Monitors are
 	  primarily responsible for data set collection and support the
@@ -213,4 +214,14 @@ config CORESIGHT_TPDM
 	  To compile this driver as a module, choose M here: the module will be
 	  called coresight-tpdm.
 
+config CORESIGHT_TPDA
+	tristate "CoreSight Trace, Profiling & Diagnostics Aggregator driver"
+	help
+	  This driver provides support for configuring aggregator. This is
+	  primarily useful for pulling the data sets from one or more
+	  attached monitors and pushing the resultant data out. Multiple
+	  monitors are connected on different input ports of TPDA.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called coresight-tpda.
 endif
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 6bb9b1746bc7..1712d82e7260 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -26,5 +26,6 @@ obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
 obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
 obj-$(CONFIG_CORESIGHT_TRBE) += coresight-trbe.o
 obj-$(CONFIG_CORESIGHT_TPDM) += coresight-tpdm.o
+obj-$(CONFIG_CORESIGHT_TPDA) += coresight-tpda.o
 coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
 		   coresight-cti-sysfs.o
diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
new file mode 100644
index 000000000000..7a0478a8b63e
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/amba/bus.h>
+#include <linux/bitfield.h>
+#include <linux/coresight.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include "coresight-priv.h"
+#include "coresight-tpda.h"
+#include "coresight-trace-id.h"
+
+DEFINE_CORESIGHT_DEVLIST(tpda_devs, "tpda");
+
+/* Settings pre enabling port control register */
+static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
+{
+	u32 val;
+
+	val = readl_relaxed(drvdata->base + TPDA_CR);
+	val |= FIELD_PREP(TPDA_CR_ATID, drvdata->atid);
+	writel_relaxed(val, drvdata->base + TPDA_CR);
+}
+
+static void tpda_enable_port(struct tpda_drvdata *drvdata, int port)
+{
+	u32 val;
+
+	val = readl_relaxed(drvdata->base + TPDA_Pn_CR(port));
+	/* Enable the port */
+	val |= TPDA_Pn_CR_ENA;
+	writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
+}
+
+static void __tpda_enable(struct tpda_drvdata *drvdata, int port)
+{
+	CS_UNLOCK(drvdata->base);
+
+	if (!drvdata->csdev->enable)
+		tpda_enable_pre_port(drvdata);
+
+	tpda_enable_port(drvdata, port);
+
+	CS_LOCK(drvdata->base);
+}
+
+static int tpda_enable(struct coresight_device *csdev, int inport, int outport)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	spin_lock(&drvdata->spinlock);
+	if (atomic_read(&csdev->refcnt[inport]) == 0)
+		__tpda_enable(drvdata, inport);
+
+	atomic_inc(&csdev->refcnt[inport]);
+	spin_unlock(&drvdata->spinlock);
+
+	dev_dbg(drvdata->dev, "TPDA inport %d enabled.\n", inport);
+	return 0;
+}
+
+static void __tpda_disable(struct tpda_drvdata *drvdata, int port)
+{
+	u32 val;
+
+	CS_UNLOCK(drvdata->base);
+
+	val = readl_relaxed(drvdata->base + TPDA_Pn_CR(port));
+	val &= ~TPDA_Pn_CR_ENA;
+	writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
+
+	CS_LOCK(drvdata->base);
+}
+
+static void tpda_disable(struct coresight_device *csdev, int inport,
+			   int outport)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	spin_lock(&drvdata->spinlock);
+	if (atomic_dec_return(&csdev->refcnt[inport]) == 0)
+		__tpda_disable(drvdata, inport);
+
+	spin_unlock(&drvdata->spinlock);
+
+	dev_dbg(drvdata->dev, "TPDA inport %d disabled\n", inport);
+}
+
+static const struct coresight_ops_link tpda_link_ops = {
+	.enable		= tpda_enable,
+	.disable	= tpda_disable,
+};
+
+static const struct coresight_ops tpda_cs_ops = {
+	.link_ops	= &tpda_link_ops,
+};
+
+static int tpda_init_default_data(struct tpda_drvdata *drvdata)
+{
+	int atid;
+	/*
+	 * TPDA must has a unique atid. This atid can uniquely
+	 * identify the TPDM trace source connected to the TPDA.
+	 */
+	atid = coresight_trace_id_get_system_id(coresight_get_trace_id_map());
+	if (atid < 0)
+		return atid;
+
+	drvdata->atid = atid;
+	return 0;
+}
+
+static int tpda_probe(struct amba_device *adev, const struct amba_id *id)
+{
+	int ret;
+	struct device *dev = &adev->dev;
+	struct coresight_platform_data *pdata;
+	struct tpda_drvdata *drvdata;
+	struct coresight_desc desc = { 0 };
+	void __iomem *base;
+
+	pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+	adev->dev.platform_data = pdata;
+
+	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	drvdata->dev = &adev->dev;
+	dev_set_drvdata(dev, drvdata);
+
+	base = devm_ioremap_resource(dev, &adev->res);
+	if (!base)
+		return -ENOMEM;
+	drvdata->base = base;
+
+	spin_lock_init(&drvdata->spinlock);
+
+	ret = tpda_init_default_data(drvdata);
+	if (ret)
+		return ret;
+
+	desc.name = coresight_alloc_device_name(&tpda_devs, dev);
+	if (!desc.name)
+		return -ENOMEM;
+	desc.type = CORESIGHT_DEV_TYPE_LINK;
+	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_MERG;
+	desc.ops = &tpda_cs_ops;
+	desc.pdata = adev->dev.platform_data;
+	desc.dev = &adev->dev;
+	desc.access = CSDEV_ACCESS_IOMEM(base);
+	drvdata->csdev = coresight_register(&desc);
+	if (IS_ERR(drvdata->csdev))
+		return PTR_ERR(drvdata->csdev);
+
+	pm_runtime_put(&adev->dev);
+
+	dev_dbg(drvdata->dev, "TPDA initialized\n");
+	return 0;
+}
+
+static void __exit tpda_remove(struct amba_device *adev)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+
+	coresight_unregister(drvdata->csdev);
+}
+
+/*
+ * Different TPDA has different periph id.
+ * The difference is 0-7 bits' value. So ignore 0-7 bits.
+ */
+static struct amba_id tpda_ids[] = {
+	{
+		.id     = 0x000f0f00,
+		.mask   = 0x000fff00,
+	},
+	{ 0, 0},
+};
+
+static struct amba_driver tpda_driver = {
+	.drv = {
+		.name   = "coresight-tpda",
+		.owner	= THIS_MODULE,
+		.suppress_bind_attrs = true,
+	},
+	.probe          = tpda_probe,
+	.remove		= tpda_remove,
+	.id_table	= tpda_ids,
+};
+
+module_amba_driver(tpda_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Trace, Profiling & Diagnostic Aggregator driver");
diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
new file mode 100644
index 000000000000..4beb33263c96
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-tpda.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _CORESIGHT_CORESIGHT_TPDA_H
+#define _CORESIGHT_CORESIGHT_TPDA_H
+
+#define TPDA_CR			(0x000)
+#define TPDA_Pn_CR(n)		(0x004 + (n * 4))
+/* Aggregator port enable bit */
+#define TPDA_Pn_CR_ENA		BIT(0)
+
+#define TPDA_MAX_INPORTS	32
+
+/* Bits 6 ~ 12 is for atid value */
+#define TPDA_CR_ATID		GENMASK(12, 6)
+
+/**
+ * struct tpda_drvdata - specifics associated to an TPDA component
+ * @base:       memory mapped base address for this component.
+ * @dev:        The device entity associated to this component.
+ * @csdev:      component vitals needed by the framework.
+ * @spinlock:   lock for the drvdata value.
+ * @enable:     enable status of the component.
+ */
+struct tpda_drvdata {
+	void __iomem		*base;
+	struct device		*dev;
+	struct coresight_device	*csdev;
+	spinlock_t		spinlock;
+	u8			atid;
+};
+
+#endif  /* _CORESIGHT_CORESIGHT_TPDA_H */
-- 
2.17.1

