Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0624C5EEC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 21:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiB0U6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 15:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbiB0U52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:57:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BD2F6E2B2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 12:56:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E786C1063;
        Sun, 27 Feb 2022 12:56:44 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C7BD3F66F;
        Sun, 27 Feb 2022 12:56:43 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        peter.hilber@opensynergy.com, cristian.marussi@arm.com
Subject: [RFC PATCH 14/16] firmware: arm_scmi: Add testing Voltage protocol support
Date:   Sun, 27 Feb 2022 20:56:06 +0000
Message-Id: <20220227205608.30812-15-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220227205608.30812-1-cristian.marussi@arm.com>
References: <20220227205608.30812-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

firmware: arm_scmi: Add testing Voltage protocol support

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 .../arm_scmi/scmi_test_driver/Makefile        |  2 +-
 .../arm_scmi/scmi_test_driver/scmi_test.c     |  2 +
 .../arm_scmi/scmi_test_driver/test_common.h   |  1 +
 .../arm_scmi/scmi_test_driver/test_voltages.c | 51 +++++++++++++++++++
 4 files changed, 55 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/arm_scmi/scmi_test_driver/test_voltages.c

diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/Makefile b/drivers/firmware/arm_scmi/scmi_test_driver/Makefile
index 68a3d94a6a88..3b7df18de250 100644
--- a/drivers/firmware/arm_scmi/scmi_test_driver/Makefile
+++ b/drivers/firmware/arm_scmi/scmi_test_driver/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 scmi_test_driver-objs := scmi_test.o test_common.o test_clocks.o test_sensors.o \
-	test_powers.o
+	test_powers.o test_voltages.o
 obj-$(CONFIG_ARM_SCMI_TEST_DRIVER) += scmi_test_driver.o
 
diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/scmi_test.c b/drivers/firmware/arm_scmi/scmi_test_driver/scmi_test.c
index df0d3e572010..2ca9f82c5bf3 100644
--- a/drivers/firmware/arm_scmi/scmi_test_driver/scmi_test.c
+++ b/drivers/firmware/arm_scmi/scmi_test_driver/scmi_test.c
@@ -26,6 +26,7 @@ int (*scmi_test_init[SCMI_MAX_PROTOCOLS])(struct scmi_test_setup *) = {
 	[SCMI_PROTOCOL_POWER] = scmi_test_power_init,
 	[SCMI_PROTOCOL_CLOCK] = scmi_test_clock_init,
 	[SCMI_PROTOCOL_SENSOR] = scmi_test_sensor_init,
+	[SCMI_PROTOCOL_VOLTAGE] = scmi_test_voltage_init,
 };
 
 static void
@@ -125,6 +126,7 @@ static int scmi_testing_probe(struct scmi_device *sdev)
 }
 
 static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_VOLTAGE, "__scmi_test-voltage" },
 	{ SCMI_PROTOCOL_CLOCK, "__scmi_test-clock" },
 	{ SCMI_PROTOCOL_SENSOR, "__scmi_test-sensor" },
 	{ SCMI_PROTOCOL_POWER, "__scmi_test-power" },
diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h b/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h
index 9f3d35ba4477..338b65da593f 100644
--- a/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h
+++ b/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h
@@ -102,6 +102,7 @@ int scmi_test_release(struct inode *ino, struct file *filp);
 
 int scmi_test_clock_init(struct scmi_test_setup *tsp);
 int scmi_test_sensor_init(struct scmi_test_setup *tsp);
+int scmi_test_voltage_init(struct scmi_test_setup *tsp);
 int scmi_test_power_init(struct scmi_test_setup *tsp);
 
 #endif /* __SCMI_TEST_COMMON_H */
diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/test_voltages.c b/drivers/firmware/arm_scmi/scmi_test_driver/test_voltages.c
new file mode 100644
index 000000000000..ab91080e3a0f
--- /dev/null
+++ b/drivers/firmware/arm_scmi/scmi_test_driver/test_voltages.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SCMI Testing Driver - Voltage Protocol
+ *
+ * Copyright (C) 2022 ARM Ltd.
+ */
+
+#include <linux/dcache.h>
+#include <linux/debugfs.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/io.h>
+#include <linux/kstrtox.h>
+#include <linux/module.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+
+#include "test_common.h"
+
+struct scmi_voltage_data {
+	unsigned int version;
+	int count;
+};
+
+int scmi_test_voltage_init(struct scmi_test_setup *tsp)
+{
+	struct scmi_voltage_data *vdata;
+	struct device *dev = &tsp->sdev->dev;
+	const struct scmi_voltage_proto_ops *voltage_ops;
+
+	vdata = devm_kzalloc(dev, sizeof(*vdata), GFP_KERNEL);
+	if (!vdata)
+		return -ENOMEM;
+
+	voltage_ops = tsp->ops;
+	vdata->version = voltage_ops->version_get(tsp->ph);
+	vdata->count = voltage_ops->num_domains_get(tsp->ph);
+
+	if (vdata->count <= 0) {
+		dev_err(dev, "number of voltage doms invalid: %d\n",
+			vdata->count);
+		return vdata->count ?: -EINVAL;
+	}
+
+	dev_info(dev, "Found %d voltage resources.\n", vdata->count);
+
+	tsp->priv = vdata;
+	debugfs_create_x32("version", 0400, tsp->parent, &vdata->version);
+
+	return 0;
+}
-- 
2.17.1

