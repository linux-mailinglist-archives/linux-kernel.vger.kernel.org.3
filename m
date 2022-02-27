Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1986C4C5EE5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 21:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiB0U5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 15:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiB0U5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:57:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E1C36D854
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 12:56:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5815A106F;
        Sun, 27 Feb 2022 12:56:35 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D35573F66F;
        Sun, 27 Feb 2022 12:56:33 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        peter.hilber@opensynergy.com, cristian.marussi@arm.com
Subject: [RFC PATCH 08/16] firmware: arm_scmi: Add SCMI Testing driver
Date:   Sun, 27 Feb 2022 20:56:00 +0000
Message-Id: <20220227205608.30812-9-cristian.marussi@arm.com>
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

Add an SCMI driver that would expose all of the available SCMI protocol
operations and resources under a debugfs rooted at /sys/kernel/debug/scmi,
so as to be then able to script generic SCMI testcases simply accessing the
available debugfs entries.

The aim is to be able to test the Kernel SCMI stack in isolation without
the constraints or interferences carried by the original SCMI drivers that
by their nature belong and are driven by a number of Kernel subsystems:
indeed, if this testing driver is enabled at compilation time, loading of
all the other regular SCMI drivers is inhibited.

Beside such generic SCMI test driver infrastructure, add also basic support
for testing SCMI Clock protocol.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 Documentation/ABI/testing/debugfs-scmi        | 101 ++++++++++++
 drivers/firmware/arm_scmi/Kconfig             |  12 ++
 drivers/firmware/arm_scmi/Makefile            |   2 +
 drivers/firmware/arm_scmi/driver.c            |   9 +
 .../arm_scmi/scmi_test_driver/Makefile        |   4 +
 .../arm_scmi/scmi_test_driver/scmi_test.c     | 154 ++++++++++++++++++
 .../arm_scmi/scmi_test_driver/test_clocks.c   | 139 ++++++++++++++++
 .../arm_scmi/scmi_test_driver/test_common.c   |  60 +++++++
 .../arm_scmi/scmi_test_driver/test_common.h   |  76 +++++++++
 9 files changed, 557 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-scmi
 create mode 100644 drivers/firmware/arm_scmi/scmi_test_driver/Makefile
 create mode 100644 drivers/firmware/arm_scmi/scmi_test_driver/scmi_test.c
 create mode 100644 drivers/firmware/arm_scmi/scmi_test_driver/test_clocks.c
 create mode 100644 drivers/firmware/arm_scmi/scmi_test_driver/test_common.c
 create mode 100644 drivers/firmware/arm_scmi/scmi_test_driver/test_common.h

diff --git a/Documentation/ABI/testing/debugfs-scmi b/Documentation/ABI/testing/debugfs-scmi
new file mode 100644
index 000000000000..85177f3723c8
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-scmi
@@ -0,0 +1,101 @@
+What:		/sys/kernel/debug/scmi/info/major_ver
+Date:		Feb 2022
+KernelVersion:	5.18
+Contact:	cristian.marussi@arm.com
+Description:	SCMI protocol stack major version
+Users:		KSelftest, Debugging
+
+What:		/sys/kernel/debug/scmi/info/minor_ver
+Date:		Feb 2022
+KernelVersion:	5.18
+Contact:	cristian.marussi@arm.com
+Description:	SCMI protocol stack minor version
+Users:		KSelftest, Debugging
+
+What:		/sys/kernel/debug/scmi/info/impl_ver
+Date:		Feb 2022
+KernelVersion:	5.18
+Contact:	cristian.marussi@arm.com
+Description:	SCMI protocol stack (vendor-specific) implementation version
+Users:		KSelftest, Debugging
+
+What:		/sys/kernel/debug/scmi/info/vendor_id
+Date:		Feb 2022
+KernelVersion:	5.18
+Contact:	cristian.marussi@arm.com
+Description:	SCMI protocol stack vendor identifier ASCII string
+Users:		KSelftest, Debugging
+
+What:		/sys/kernel/debug/scmi/info/sub_vendor_id
+Date:		Feb 2022
+KernelVersion:	5.18
+Contact:	cristian.marussi@arm.com
+Description:	SCMI protocol stack sub_vendor identifier ASCII string
+Users:		KSelftest, Debugging
+
+What:		/sys/kernel/debug/scmi/info/num_agents
+Date:		Feb 2022
+KernelVersion:	5.18
+Contact:	cristian.marussi@arm.com
+Description:	Number of detected SCMI agents on the system
+Users:		KSelftest, Debugging
+
+What:		/sys/kernel/debug/scmi/info/num_protocols
+Date:		Feb 2022
+KernelVersion:	5.18
+Contact:	cristian.marussi@arm.com
+Description:	Number of detected SCMI protocols implemented on the system
+Users:		KSelftest, Debugging
+
+What:		/sys/kernel/debug/scmi/transport/compatible
+Date:		Feb 2022
+KernelVersion:	5.18
+Contact:	cristian.marussi@arm.com
+Description:	Name of the configured underlying SCMI transport identified
+		using the same compatible strings as defined in the bindings
+		at Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+Users:		KSelftest, Debugging
+
+What:		/sys/kernel/debug/scmi/transport/is_atomic
+Date:		Feb 2022
+KernelVersion:	5.18
+Contact:	cristian.marussi@arm.com
+Description:	A boolen flag that states if the underlying SCMI transport
+		currently used is configured to support atomic mode of
+		operation.
+Users:		KSelftest, Debugging
+
+What:		/sys/kernel/debug/scmi/transport/max_rx_timeout_ms
+Date:		Feb 2022
+KernelVersion:	5.18
+Contact:	cristian.marussi@arm.com
+Description:	Represents the timeout, as configured in the underlying SCMI
+		transport, that is enforced while waiting for SCMI synchronous
+		command replies.
+Users:		KSelftest, Debugging
+
+What:		/sys/kernel/debug/scmi/transport/atomic_threshold_us
+Date:		Feb 2022
+KernelVersion:	5.18
+Contact:	cristian.marussi@arm.com
+Description:	System wide threshold optionally used to decide if honour or not
+		SCMI atomic transactions requests; its usage is described in
+		Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+Users:		KSelftest, Debugging
+
+What:		/sys/kernel/debug/scmi/protocol_0x<NN>/version
+Date:		Feb 2022
+KernelVersion:	5.18
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Protocol 0x<NN> version implemented on this system
+Users:		KSelftest, Debugging
+
+What:		/sys/kernel/debug/scmi/protocol_0x14/<XXX>/info/*
+Date:		Feb 2022
+KernelVersion:	5.18
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Clock Protocol informational RO data for clock resource
+		with id <XXX>: each entry under info/ subdir maps to an equally
+		named field of struct scmi_clock_info as documented in
+		include/scmi/protocol.h
+Users:		KSelftest, Debugging
diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index 7794bd41eaa0..a3726074c89e 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -148,4 +148,16 @@ config ARM_SCMI_POWER_DOMAIN
 	  will be called scmi_pm_domain. Note this may needed early in boot
 	  before rootfs may be available.
 
+config ARM_SCMI_TEST_DRIVER
+	tristate "SCMI Testing driver"
+	depends on (ARM_SCMI_PROTOCOL && DEBUG_FS) || (COMPILE_TEST && OF)
+	help
+	  This enables support for an SCMI testing driver.
+	  Note that this driver will register as an SCMI driver user for
+	  all SCMI standard protocols and at the same time will inhibit
+	  the registration of any of regular SCMI drivers.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called scmi_test_driver.
+
 endmenu
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 8d4afadda38c..8382a5da9e39 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -13,6 +13,8 @@ scmi-module-objs := $(scmi-bus-y) $(scmi-driver-y) $(scmi-protocols-y) \
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
 obj-$(CONFIG_ARM_SCMI_POWER_DOMAIN) += scmi_pm_domain.o
 
+obj-$(CONFIG_ARM_SCMI_TEST_DRIVER) += scmi_test_driver/
+
 ifeq ($(CONFIG_THUMB2_KERNEL)$(CONFIG_CC_IS_CLANG),yy)
 # The use of R7 in the SMCCC conflicts with the compiler's use of R7 as a frame
 # pointer in Thumb2 mode, which is forcibly enabled by Clang when profiling
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 8c5429529946..8c4706b24368 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1782,6 +1782,15 @@ static int scmi_protocol_device_request(const struct scmi_device_id *id_table)
 	pr_debug("Requesting SCMI device (%s) for protocol %x\n",
 		 id_table->name, id_table->protocol_id);
 
+#if IS_ENABLED(CONFIG_ARM_SCMI_TEST_DRIVER)
+	/* Reject non-testing SCMI drivers */
+	if (strncmp(id_table->name, "__scmi_test", strlen("__scmi_test"))) {
+		pr_warn("SCMI Test driver loaded. Rejecting '%s'/0x%X\n",
+			id_table->name, id_table->protocol_id);
+		return -EINVAL;
+	}
+#endif
+
 	/*
 	 * Search for the matching protocol rdev list and then search
 	 * of any existent equally named device...fails if any duplicate found.
diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/Makefile b/drivers/firmware/arm_scmi/scmi_test_driver/Makefile
new file mode 100644
index 000000000000..6e3ddd177827
--- /dev/null
+++ b/drivers/firmware/arm_scmi/scmi_test_driver/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+scmi_test_driver-objs := scmi_test.o test_common.o test_clocks.o
+obj-$(CONFIG_ARM_SCMI_TEST_DRIVER) += scmi_test_driver.o
+
diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/scmi_test.c b/drivers/firmware/arm_scmi/scmi_test_driver/scmi_test.c
new file mode 100644
index 000000000000..f99aa621684c
--- /dev/null
+++ b/drivers/firmware/arm_scmi/scmi_test_driver/scmi_test.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SCMI Testing Driver.
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
+#include <linux/stat.h>
+
+#include "test_common.h"
+
+static struct dentry *scmi_dentry, *scmi_info_dentry, *scmi_trans_dentry;
+DEFINE_MUTEX(scmi_test_mtx);
+
+static
+int (*scmi_test_init[SCMI_MAX_PROTOCOLS])(struct scmi_test_setup *) = {
+	[SCMI_PROTOCOL_CLOCK] = scmi_test_clock_init,
+};
+
+static void
+scmi_debugfs_common_info_create(struct scmi_revision_info *info,
+				struct dentry *parent)
+{
+	debugfs_create_u16("major_ver", 0400, parent, &info->major_ver);
+	debugfs_create_u16("minor_ver", 0400, parent, &info->minor_ver);
+	debugfs_create_u8("num_protocols", 0400, parent,
+			  &info->num_protocols);
+	debugfs_create_u8("num_agents", 0400, parent, &info->num_agents);
+	debugfs_create_x32("impl_ver", 0400, parent, &info->impl_ver);
+
+	debugfs_create_file("vendor_id", 0400, parent,
+			    info->vendor_id, &scmi_test_string_file_fops);
+	debugfs_create_file("sub_vendor_id", 0400, parent,
+			    info->sub_vendor_id, &scmi_test_string_file_fops);
+}
+
+static void
+scmi_debugfs_trans_info_create(struct scmi_transport_info *info,
+			       struct dentry *parent)
+{
+	debugfs_create_file("compatible", 0400, parent,
+			    (void *)info->compatible,
+			    &scmi_test_string_file_fops);
+	debugfs_create_bool("is_atomic", 0400, parent, &info->is_atomic);
+	debugfs_create_u32("atomic_threshold_us", 0400, parent,
+			   &info->atomic_threshold_us);
+	debugfs_create_u32("max_rx_timeout_ms", 0400, parent,
+			   &info->max_rx_timeout_ms);
+}
+
+static int scmi_testing_probe(struct scmi_device *sdev)
+{
+	int ret;
+	const void *ops;
+	struct scmi_protocol_handle *ph;
+	const struct scmi_handle *handle = sdev->handle;
+	struct device *dev = &sdev->dev;
+	struct scmi_test_setup *tsp;
+	char proto_dir[16];
+
+	if (!handle)
+		return -ENODEV;
+
+	if (sdev->protocol_id > SCMI_PROTOCOL_LAST ||
+	    !scmi_test_init[sdev->protocol_id]) {
+		dev_warn(dev, "Testing protocol 0x%X NOT supported.\n",
+			 sdev->protocol_id);
+		return -EINVAL;
+	}
+
+	ops = handle->devm_protocol_get(sdev, sdev->protocol_id, &ph);
+	if (IS_ERR(ops)) {
+		dev_err(dev, "Cannot access protocol:0x%X - err:%ld\n",
+			sdev->protocol_id, PTR_ERR(ops));
+		return PTR_ERR(ops);
+	}
+
+	tsp = devm_kzalloc(&sdev->dev, sizeof(*tsp), GFP_KERNEL);
+	if (!tsp)
+		return -ENOMEM;
+
+	tsp->sdev = sdev;
+	tsp->ops = ops;
+	tsp->ph = ph;
+
+	snprintf(proto_dir, 16, "protocol_0x%02X", sdev->protocol_id);
+	tsp->parent = debugfs_create_dir(proto_dir, scmi_dentry);
+	if (IS_ERR(tsp->parent))
+		return PTR_ERR(tsp->parent);
+
+	ret = scmi_test_init[sdev->protocol_id](tsp);
+	if (ret)
+		return ret;
+
+	/* Setup common information entries if not already done */
+	mutex_lock(&scmi_test_mtx);
+	if (!scmi_info_dentry) {
+		scmi_info_dentry = debugfs_create_dir("info", scmi_dentry);
+		if (!IS_ERR(scmi_info_dentry))
+			scmi_debugfs_common_info_create(sdev->handle->version,
+							scmi_info_dentry);
+	}
+
+	if (!scmi_trans_dentry) {
+		scmi_trans_dentry =
+			debugfs_create_dir("transport", scmi_dentry);
+		if (!IS_ERR(scmi_trans_dentry))
+			scmi_debugfs_trans_info_create(sdev->handle->transport,
+						       scmi_trans_dentry);
+	}
+	mutex_unlock(&scmi_test_mtx);
+
+	return ret;
+}
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_CLOCK, "__scmi_test-clock" },
+	{ },
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static struct scmi_driver scmi_testing_driver = {
+	.name = "scmi-testing-driver",
+	.probe = scmi_testing_probe,
+	.id_table = scmi_id_table,
+};
+
+static int __init scmi_testing_driver_init(void)
+{
+	scmi_dentry = debugfs_create_dir("scmi", NULL);
+	return scmi_driver_register(&scmi_testing_driver,
+				    THIS_MODULE, KBUILD_MODNAME);
+}
+module_init(scmi_testing_driver_init);
+
+static void __exit scmi_testing_driver_exit(void)
+{
+	debugfs_remove_recursive(scmi_dentry);
+	scmi_driver_unregister(&scmi_testing_driver);
+}
+module_exit(scmi_testing_driver_exit);
+
+MODULE_AUTHOR("Cristian Marussi <cristian.marussi@arm.com>");
+MODULE_DESCRIPTION("ARM SCMI Testing Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/test_clocks.c b/drivers/firmware/arm_scmi/scmi_test_driver/test_clocks.c
new file mode 100644
index 000000000000..3b9e92baa509
--- /dev/null
+++ b/drivers/firmware/arm_scmi/scmi_test_driver/test_clocks.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SCMI Testing Driver - Clock Protocol
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
+/* Clock Proto Test */
+struct scmi_clock_data {
+	unsigned int version;
+	int count;
+	const struct scmi_clock_info **clk_info;
+};
+
+static ssize_t scmi_test_clock_rates_read(struct file *filp, char __user *buf,
+					  size_t count, loff_t *ppos)
+{
+	struct scmi_test_buffer *data = filp->private_data;
+
+	if (!data)
+		return 0;
+
+	if (!data->used) {
+		int c;
+		struct scmi_clock_info *ci = filp->f_inode->i_private;
+
+		for (c = 0; c < ci->list.num_rates; c++)
+			data->used += scnprintf(data->buf + data->used,
+						data->len - data->used,
+						"%lld ",
+						ci->list.rates[c]);
+
+		data->used += scnprintf(data->buf + data->used,
+					data->len - data->used, "\n");
+	}
+
+	return simple_read_from_buffer(buf, count, ppos, data->buf, data->used);
+}
+
+static const struct file_operations test_clk_rates_fops = {
+	.open = scmi_test_fixed_buffer_open,
+	.release = scmi_test_release,
+	.read = scmi_test_clock_rates_read,
+};
+
+static void
+scmi_test_debugfs_clock_info_create(const struct scmi_clock_info *ci,
+				    struct dentry *top_dentry)
+{
+	struct dentry *parent;
+	struct scmi_clock_info *cinfo = (struct scmi_clock_info *)ci;
+
+	parent = debugfs_create_dir("info", top_dentry);
+	if (IS_ERR(parent))
+		return;
+
+	debugfs_create_file("name", 0400, parent, cinfo->name,
+			    &scmi_test_string_file_fops);
+	debugfs_create_u32("enable_latency", 0400, parent,
+			   &cinfo->enable_latency);
+
+	debugfs_create_bool("rate_discrete", 0400, parent,
+			    &cinfo->rate_discrete);
+
+	if (cinfo->rate_discrete) {
+		debugfs_create_u32("num_rates", 0400, parent,
+				   &cinfo->list.num_rates);
+		debugfs_create_file("rates", 0400, parent, cinfo,
+				    &test_clk_rates_fops);
+	} else {
+		debugfs_create_u64("min_rate", 0400, parent,
+				   &cinfo->range.min_rate);
+		debugfs_create_u64("max_rate", 0400, parent,
+				   &cinfo->range.max_rate);
+		debugfs_create_u64("step_size", 0400, parent,
+				   &cinfo->range.step_size);
+	}
+}
+
+int scmi_test_clock_init(struct scmi_test_setup *tsp)
+{
+	int i;
+	struct scmi_clock_data *cdata;
+	const struct scmi_clk_proto_ops *clock_ops;
+	struct device *dev = &tsp->sdev->dev;
+
+	cdata = devm_kzalloc(dev, sizeof(*cdata), GFP_KERNEL);
+	if (!cdata)
+		return -ENOMEM;
+
+	clock_ops = tsp->ops;
+	cdata->version = clock_ops->version_get(tsp->ph);
+	cdata->count = clock_ops->count_get(tsp->ph);
+
+	if (cdata->count <= 0) {
+		dev_err(dev, "number of domains invalid: %d\n",
+			cdata->count);
+		return cdata->count ?: -EINVAL;
+	}
+
+	cdata->clk_info = devm_kcalloc(dev, cdata->count,
+				       sizeof(cdata->clk_info), GFP_KERNEL);
+	if (!cdata->clk_info)
+		return -ENOMEM;
+
+	for (i = 0; i < cdata->count; i++)
+		cdata->clk_info[i] = clock_ops->info_get(tsp->ph, i);
+
+	tsp->priv = cdata;
+
+	debugfs_create_x32("version", 0400, tsp->parent, &cdata->version);
+
+	dev_info(dev, "Found %d clock resources.\n", cdata->count);
+
+	for (i = 0; i < cdata->count; i++) {
+		char clock_dir[16];
+		struct dentry *clock_dentry;
+
+		snprintf(clock_dir, 16, "%03d", i);
+		clock_dentry = debugfs_create_dir(clock_dir, tsp->parent);
+		if (!IS_ERR(clock_dentry))
+			scmi_test_debugfs_clock_info_create(cdata->clk_info[i],
+							    clock_dentry);
+	}
+
+	return 0;
+}
diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/test_common.c b/drivers/firmware/arm_scmi/scmi_test_driver/test_common.c
new file mode 100644
index 000000000000..1a4b6aa35095
--- /dev/null
+++ b/drivers/firmware/arm_scmi/scmi_test_driver/test_common.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SCMI Testing Driver.
+ *
+ * Copyright (C) 2022 ARM Ltd.
+ */
+
+#include <linux/dcache.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/kstrtox.h>
+#include <linux/notifier.h>
+#include <linux/slab.h>
+
+#include "test_common.h"
+
+/* Common File operations */
+int scmi_test_release(struct inode *ino, struct file *filp)
+{
+	kfree(filp->private_data);
+
+	return 0;
+}
+
+int scmi_test_fixed_buffer_open(struct inode *ino, struct file *filp)
+{
+	struct scmi_test_buffer *data;
+
+	data = kzalloc(sizeof(*data) + SCMI_TEST_DEFAULT_BUF_SZ, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->len = SCMI_TEST_DEFAULT_BUF_SZ;
+	filp->private_data = data;
+
+	return 0;
+}
+
+static ssize_t scmi_test_string_file_read(struct file *filp, char __user *buf,
+					  size_t count, loff_t *ppos)
+{
+	struct scmi_test_buffer *data = filp->private_data;
+
+	if (!data)
+		return 0;
+
+	if (!data->used) {
+		char *str = filp->f_inode->i_private;
+
+		data->used = scnprintf(data->buf, data->len, "%s\n", str);
+	}
+
+	return simple_read_from_buffer(buf, count, ppos, data->buf, data->used);
+}
+
+const struct file_operations scmi_test_string_file_fops = {
+	.open = scmi_test_fixed_buffer_open,
+	.release = scmi_test_release,
+	.read = scmi_test_string_file_read,
+};
diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h b/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h
new file mode 100644
index 000000000000..1ff5bbc32ae3
--- /dev/null
+++ b/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SCMI Testing Driver.
+ *
+ * Copyright (C) 2022 ARM Ltd.
+ */
+
+#ifndef __SCMI_TEST_COMMON_H
+#define __SCMI_TEST_COMMON_H
+
+#include <linux/dcache.h>
+#include <linux/debugfs.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/io.h>
+#include <linux/kstrtox.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+/**
+ * struct scmi_test_setup  - Test protocol setup descriptor
+ * @parent: A reference to the parent dentry
+ * @sdev: A reference to the related SCMI device
+ * @ops: A reference to the protocol ops
+ * @ph: A reference to the protocol handle to be used with the ops
+ * @blen: An optional minimum requested buffer length for output data; if zero
+ *	  the output test buffer is allocated of SCMI_TEST_DEFAULT_BUF_SZ bytes.
+ * @priv: A reference to optional protocol-specific data
+ * @n_priv: A reference to optional protocol-specific data needed by
+ *	    notifications
+ *
+ * This descriptor is created and initialized once per protocol in the
+ * main probe function and passed down to the testing protocol initialization
+ * functions where can be further customized before being optionally made
+ * available to the specific debugfs entries via inode i_private reference.
+ */
+struct scmi_test_setup {
+	struct dentry *parent;
+	struct scmi_device *sdev;
+	const void *ops;
+	struct scmi_protocol_handle *ph;
+	size_t blen;
+	void *priv;
+	void *n_priv;
+};
+
+/**
+ * struct scmi_test_buffer  - Output test buffer descriptor
+ * @id: An optional resource id parsed at open from the debugfs entry name
+ * @len: Size of the allocated buffer len as pointed by @buf
+ * @used: Current number of used bytes in @buf
+ * @buf: Actual buffer for output data: default allocation size (@len), if not
+ * otherwise specified in scmi_test_setup.blen, is SCMI_TEST_DEFAULT_BUF_SZ.
+ *
+ * This describes a dynamically allocated output buffer which will be made
+ * available to each r/w debugfs entry file_operations.
+ */
+struct scmi_test_buffer {
+	unsigned int id;
+	size_t len;
+	size_t used;
+#define SCMI_TEST_DEFAULT_BUF_SZ	64
+	unsigned char buf[];
+};
+
+extern const struct file_operations scmi_test_string_file_fops;
+
+int scmi_test_fixed_buffer_open(struct inode *ino, struct file *filp);
+int scmi_test_release(struct inode *ino, struct file *filp);
+
+int scmi_test_clock_init(struct scmi_test_setup *tsp);
+
+#endif /* __SCMI_TEST_COMMON_H */
-- 
2.17.1

