Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E755E4C5EE8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 21:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiB0U5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 15:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiB0U5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:57:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 754C56D1A0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 12:56:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56994106F;
        Sun, 27 Feb 2022 12:56:43 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECDA33F66F;
        Sun, 27 Feb 2022 12:56:41 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        peter.hilber@opensynergy.com, cristian.marussi@arm.com
Subject: [RFC PATCH 13/16] firmware: arm_scmi: Add testing Power protocol support
Date:   Sun, 27 Feb 2022 20:56:05 +0000
Message-Id: <20220227205608.30812-14-cristian.marussi@arm.com>
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

firmware: arm_scmi: Add testing Power protocol support

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 .../arm_scmi/scmi_test_driver/Makefile        |   3 +-
 .../arm_scmi/scmi_test_driver/scmi_test.c     |   2 +
 .../arm_scmi/scmi_test_driver/test_common.h   |   1 +
 .../arm_scmi/scmi_test_driver/test_powers.c   | 105 ++++++++++++++++++
 4 files changed, 110 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/arm_scmi/scmi_test_driver/test_powers.c

diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/Makefile b/drivers/firmware/arm_scmi/scmi_test_driver/Makefile
index 458883193f31..68a3d94a6a88 100644
--- a/drivers/firmware/arm_scmi/scmi_test_driver/Makefile
+++ b/drivers/firmware/arm_scmi/scmi_test_driver/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-scmi_test_driver-objs := scmi_test.o test_common.o test_clocks.o test_sensors.o
+scmi_test_driver-objs := scmi_test.o test_common.o test_clocks.o test_sensors.o \
+	test_powers.o
 obj-$(CONFIG_ARM_SCMI_TEST_DRIVER) += scmi_test_driver.o
 
diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/scmi_test.c b/drivers/firmware/arm_scmi/scmi_test_driver/scmi_test.c
index 04e01dd114c9..df0d3e572010 100644
--- a/drivers/firmware/arm_scmi/scmi_test_driver/scmi_test.c
+++ b/drivers/firmware/arm_scmi/scmi_test_driver/scmi_test.c
@@ -23,6 +23,7 @@ DEFINE_MUTEX(scmi_test_mtx);
 
 static
 int (*scmi_test_init[SCMI_MAX_PROTOCOLS])(struct scmi_test_setup *) = {
+	[SCMI_PROTOCOL_POWER] = scmi_test_power_init,
 	[SCMI_PROTOCOL_CLOCK] = scmi_test_clock_init,
 	[SCMI_PROTOCOL_SENSOR] = scmi_test_sensor_init,
 };
@@ -126,6 +127,7 @@ static int scmi_testing_probe(struct scmi_device *sdev)
 static const struct scmi_device_id scmi_id_table[] = {
 	{ SCMI_PROTOCOL_CLOCK, "__scmi_test-clock" },
 	{ SCMI_PROTOCOL_SENSOR, "__scmi_test-sensor" },
+	{ SCMI_PROTOCOL_POWER, "__scmi_test-power" },
 	{ },
 };
 MODULE_DEVICE_TABLE(scmi, scmi_id_table);
diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h b/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h
index 93c05db0ebff..9f3d35ba4477 100644
--- a/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h
+++ b/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h
@@ -102,5 +102,6 @@ int scmi_test_release(struct inode *ino, struct file *filp);
 
 int scmi_test_clock_init(struct scmi_test_setup *tsp);
 int scmi_test_sensor_init(struct scmi_test_setup *tsp);
+int scmi_test_power_init(struct scmi_test_setup *tsp);
 
 #endif /* __SCMI_TEST_COMMON_H */
diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/test_powers.c b/drivers/firmware/arm_scmi/scmi_test_driver/test_powers.c
new file mode 100644
index 000000000000..5db1662f2dc7
--- /dev/null
+++ b/drivers/firmware/arm_scmi/scmi_test_driver/test_powers.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SCMI Testing Driver - Power Protocol
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
+struct scmi_power_data {
+	unsigned int version;
+	int count;
+};
+
+static ssize_t scmi_test_power_info_read(struct file *filp, char __user *buf,
+					 size_t count, loff_t *ppos)
+{
+	struct scmi_test_buffer *data = filp->private_data;
+
+	if (!data)
+		return 0;
+
+	if (!data->used) {
+		u32 pstate;
+		char *pname;
+		struct scmi_test_setup *tsp = filp->f_inode->i_private;
+		const struct scmi_power_proto_ops *power_ops = tsp->ops;
+
+		pname = power_ops->name_get(tsp->ph, data->id);
+		power_ops->state_get(tsp->ph, data->id, &pstate);
+
+		data->used = scnprintf(data->buf, data->len,
+				       "%s -> state:%d\n",
+				       pname, pstate);
+	}
+
+	if (*ppos >= data->used)
+		return 0;
+
+	if (count > data->used)
+		count = data->used;
+
+	count -= copy_to_user(buf, data->buf + *ppos, count);
+	*ppos += count;
+
+	return count;
+}
+
+static const struct file_operations test_power_info_fops = {
+	.open = scmi_test_setup_open,
+	.release = scmi_test_release,
+	.read = scmi_test_power_info_read,
+};
+
+int scmi_test_power_init(struct scmi_test_setup *tsp)
+{
+	int i;
+	struct scmi_power_data *pdata;
+	const struct scmi_power_proto_ops *power_ops;
+	struct device *dev = &tsp->sdev->dev;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	power_ops = tsp->ops;
+	pdata->version = power_ops->version_get(tsp->ph);
+	pdata->count = power_ops->num_domains_get(tsp->ph);
+
+	if (pdata->count <= 0) {
+		dev_err(dev, "number of domains invalid: %d\n",
+			pdata->count);
+		return pdata->count ?: -EINVAL;
+	}
+
+	tsp->priv = pdata;
+	debugfs_create_x32("version", 0400, tsp->parent, &pdata->version);
+
+	dev_info(dev, "Found %d power-domain resources.\n", pdata->count);
+
+	for (i = 0; i < pdata->count; i++) {
+		char power_dir[16];
+		struct dentry *power_dentry;
+
+		snprintf(power_dir, 16, "%03d", i);
+		power_dentry = debugfs_create_dir(power_dir, tsp->parent);
+		if (!IS_ERR(power_dentry)) {
+			debugfs_create_file("info", 0400,
+					    power_dentry, tsp,
+					    &test_power_info_fops);
+		}
+	}
+
+	return 0;
+}
-- 
2.17.1

