Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CFC4C5EE4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 21:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiB0U5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 15:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiB0U5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:57:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39A6B6E360
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 12:56:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA12C11FB;
        Sun, 27 Feb 2022 12:56:36 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D0713F66F;
        Sun, 27 Feb 2022 12:56:35 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        peter.hilber@opensynergy.com, cristian.marussi@arm.com
Subject: [RFC PATCH 09/16] firmware: arm_scmi: testing: Add Clock protocol full support
Date:   Sun, 27 Feb 2022 20:56:01 +0000
Message-Id: <20220227205608.30812-10-cristian.marussi@arm.com>
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

Add SCMI Clock protocol testing support exposing SCMI Clock protocol
operations under debugfs /sys/kernel/debug/scmi/protocol_0x14/<XXX>/, where
the subdirectories <XXX> represents each a distinct clock resource with
ID equal <XXX>.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 Documentation/ABI/testing/debugfs-scmi        |  56 +++++++
 .../arm_scmi/scmi_test_driver/test_clocks.c   | 150 +++++++++++++++++-
 .../arm_scmi/scmi_test_driver/test_common.c   |  48 ++++++
 .../arm_scmi/scmi_test_driver/test_common.h   |   1 +
 4 files changed, 254 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/debugfs-scmi b/Documentation/ABI/testing/debugfs-scmi
index 85177f3723c8..e91c19e7a323 100644
--- a/Documentation/ABI/testing/debugfs-scmi
+++ b/Documentation/ABI/testing/debugfs-scmi
@@ -99,3 +99,59 @@ Description:	SCMI Clock Protocol informational RO data for clock resource
 		named field of struct scmi_clock_info as documented in
 		include/scmi/protocol.h
 Users:		KSelftest, Debugging
+
+What:		/sys/kernel/debug/scmi/protocol_0x14/<XXX>/rate_get_set
+Date:		Feb 2022
+KernelVersion:	5.19
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Clock Protocol rate get/set operation for clock resource
+		with id <XXX>; a read returns the currently set clock rate value
+		as a base-10 integer while the write of a base-10 integer sets a
+		new clock rate value.
+		Each R/W access invokes the corresponding SCMI Clock protocol
+		operations and issuing of needed SCMI commands.
+Users:		KSelftest, Debugging
+
+What:		/sys/kernel/debug/scmi/protocol_0x14/<XXX>/enable
+Date:		Feb 2022
+KernelVersion:	5.19
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Clock Protocol enable operation for clock resource with id
+		<XXX>; writing a boolean value causes that specific clock to be
+		enabled or disabled.
+		No reference counting is kept: each write access invokes the
+		corresponding SCMI Clock protocol operations and issuing of
+		needed SCMI commands.
+Users:		KSelftest, Debugging
+
+What:		/sys/kernel/debug/scmi/protocol_0x14/<XXX>/enable_atomic_irqs_on
+Date:		Feb 2022
+KernelVersion:	5.19
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Clock Protocol enable atomic operation for clock resource
+		with id <XXX>; writing a boolean value causes that specific
+		clock to be enabled or disabled using SCMI transport in polling
+		mode, if allowed by the underlying SCMI transport.
+		No reference counting is kept: each write access invokes the
+		corresponding SCMI Clock protocol operations and issuing of
+		needed SCMI commands.
+		Available only if the underlying SCMI transport is atomic
+		capable (/sys/kernel/debug/scmi/transport/is_atomic is True).
+Users:		KSelftest, Debugging
+
+What:		/sys/kernel/debug/scmi/protocol_0x14/<XXX>/enable_atomic_irqs_off
+Date:		Feb 2022
+KernelVersion:	5.19
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Clock Protocol enable atomic operation for clock resource
+		with id <XXX>; writing a boolean value causes that specific
+		clock to be enabled or disabled using SCMI transport in polling
+		mode, if allowed by the underlying SCMI transport.
+		Local IRQs are disabled while the SCMI command transaction is
+		executed.
+		No reference counting is kept: each write access invokes the
+		corresponding SCMI Clock protocol operations and issuing of
+		needed SCMI commands.
+		Available only if the underlying SCMI transport is atomic
+		capable (/sys/kernel/debug/scmi/transport/is_atomic is True).
+Users:		KSelftest, Debugging
diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/test_clocks.c b/drivers/firmware/arm_scmi/scmi_test_driver/test_clocks.c
index 3b9e92baa509..ae5b1af88f60 100644
--- a/drivers/firmware/arm_scmi/scmi_test_driver/test_clocks.c
+++ b/drivers/firmware/arm_scmi/scmi_test_driver/test_clocks.c
@@ -24,6 +24,139 @@ struct scmi_clock_data {
 	const struct scmi_clock_info **clk_info;
 };
 
+static ssize_t scmi_test_clk_rate_get_read(struct file *filp, char __user *buf,
+					   size_t count, loff_t *ppos)
+{
+	int ret;
+	struct scmi_test_buffer *data = filp->private_data;
+
+	if (!data)
+		return 0;
+
+	if (!data->used) {
+		u64 rate;
+		struct scmi_test_setup *tsp = filp->f_inode->i_private;
+		const struct scmi_clk_proto_ops *clock_ops = tsp->ops;
+
+		ret = clock_ops->rate_get(tsp->ph, data->id, &rate);
+		if (ret)
+			return ret;
+
+		data->used = scnprintf(data->buf, data->len, "%lld\n", rate);
+	}
+
+	return simple_read_from_buffer(buf, count, ppos, data->buf, data->used);
+}
+
+static ssize_t scmi_test_clk_rate_get_write(struct file *filp,
+					    const char __user *buf,
+					    size_t count, loff_t *ppos)
+{
+	int ret;
+	u64 rate;
+	struct scmi_test_setup *tsp = filp->f_inode->i_private;
+	const struct scmi_clk_proto_ops *clock_ops = tsp->ops;
+	struct scmi_test_buffer *data = filp->private_data;
+
+	if (!data)
+		return 0;
+
+	ret = kstrtou64_from_user(buf, count, 10, &rate);
+	if (ret < 0)
+		return ret;
+
+	ret = clock_ops->rate_set(tsp->ph, data->id, rate);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static const struct file_operations test_clk_rate_get_set_fops = {
+	.open = scmi_test_setup_open,
+	.release = scmi_test_release,
+	.read = scmi_test_clk_rate_get_read,
+	.write = scmi_test_clk_rate_get_write,
+};
+
+static ssize_t scmi_test_clk_enable_write(struct file *filp,
+					  const char __user *buf,
+					  size_t count, loff_t *ppos)
+{
+	bool enabled, irqs_off;
+	int ret;
+	unsigned long flags;
+	struct scmi_test_setup *tsp = filp->f_inode->i_private;
+	const struct scmi_clk_proto_ops *clock_ops = tsp->ops;
+	struct scmi_test_buffer *data = filp->private_data;
+
+	if (!data)
+		return 0;
+
+	ret = kstrtobool_from_user(buf, count, &enabled);
+	if (ret)
+		return ret;
+
+	irqs_off = !strncmp(filp->f_path.dentry->d_name.name,
+			    "enable_atomic_irqs_off",
+			    strlen("enable_atomic_irqs_off"));
+	if (irqs_off)
+		local_irq_save(flags);
+
+	if (enabled)
+		ret = clock_ops->enable_atomic(tsp->ph, data->id);
+	else
+		ret = clock_ops->disable_atomic(tsp->ph, data->id);
+
+	if (irqs_off)
+		local_irq_restore(flags);
+
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static const struct file_operations test_clk_enable_fops = {
+	.open = scmi_test_setup_open,
+	.release = scmi_test_release,
+	.write = scmi_test_clk_enable_write,
+};
+
+static ssize_t scmi_test_clk_prepare_enable_write(struct file *filp,
+						  const char __user *buf,
+						  size_t count, loff_t *ppos)
+{
+	bool enabled;
+	int ret;
+	struct scmi_test_setup *tsp = filp->f_inode->i_private;
+	const struct scmi_clk_proto_ops *clock_ops = tsp->ops;
+	struct scmi_test_buffer *data = filp->private_data;
+
+	if (!data)
+		return 0;
+
+	ret = kstrtobool_from_user(buf, count, &enabled);
+	if (ret)
+		return ret;
+
+	if (enabled)
+		ret = clock_ops->enable(tsp->ph, data->id);
+	else
+		ret = clock_ops->disable(tsp->ph, data->id);
+
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static const struct file_operations test_clk_prepare_enable_fops = {
+	.open = scmi_test_setup_open,
+	.release = scmi_test_release,
+	.write = scmi_test_clk_prepare_enable_write,
+};
+
 static ssize_t scmi_test_clock_rates_read(struct file *filp, char __user *buf,
 					  size_t count, loff_t *ppos)
 {
@@ -130,9 +263,24 @@ int scmi_test_clock_init(struct scmi_test_setup *tsp)
 
 		snprintf(clock_dir, 16, "%03d", i);
 		clock_dentry = debugfs_create_dir(clock_dir, tsp->parent);
-		if (!IS_ERR(clock_dentry))
+		if (!IS_ERR(clock_dentry)) {
 			scmi_test_debugfs_clock_info_create(cdata->clk_info[i],
 							    clock_dentry);
+			debugfs_create_file("rate_get_set", 0600,
+					    clock_dentry, tsp,
+					    &test_clk_rate_get_set_fops);
+			if (tsp->sdev->handle->transport->is_atomic) {
+				debugfs_create_file("enable_atomic_irqs_off",
+						    0200, clock_dentry, tsp,
+						    &test_clk_enable_fops);
+				debugfs_create_file("enable_atomic_irqs_on",
+						    0200, clock_dentry, tsp,
+						    &test_clk_enable_fops);
+			}
+			debugfs_create_file("enable", 0200,
+					    clock_dentry, tsp,
+					    &test_clk_prepare_enable_fops);
+		}
 	}
 
 	return 0;
diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/test_common.c b/drivers/firmware/arm_scmi/scmi_test_driver/test_common.c
index 1a4b6aa35095..cbe2eec4f2ac 100644
--- a/drivers/firmware/arm_scmi/scmi_test_driver/test_common.c
+++ b/drivers/firmware/arm_scmi/scmi_test_driver/test_common.c
@@ -15,6 +15,54 @@
 #include "test_common.h"
 
 /* Common File operations */
+
+/**
+ * scmi_test_setup_open  - A common open helper
+ * @ino: Related inode reference
+ * @filp: Related file pointer reference
+ *
+ * Expects to receive a struct scmi_test_setup via inode i_private reference and
+ * then allocate a properly sized buffer; it also tries to parse the parent
+ * directory name in search for a base10 integer and, if found, stores it into
+ * the buffer descriptor @id field: this comes handy since most of the SCMI
+ * protocol operations and data are bound to some specific SCMI resource id and
+ * the SCMI debugfs directory tree is structured to mirror this layout, so that,
+ * as an example, protocol <NN> would expose <operation_AAA> about its resource
+ * with id <XXX> as:
+ *
+ *	/sys/kernel/debug/scmi/protocol_0x<NN>/<XXX>/<operation_AAA>
+ *
+ * As as result this open would allocate a data buffer, parse the dentry and
+ * set data->id = <XXX>
+ *
+ * Return: 0 on Success
+ */
+int scmi_test_setup_open(struct inode *ino, struct file *filp)
+{
+	unsigned int id;
+	size_t blen;
+	struct scmi_test_buffer *data;
+	struct scmi_test_setup *tsp = filp->f_inode->i_private;
+	const char *id_str = filp->f_path.dentry->d_parent->d_name.name;
+
+	if (!tsp)
+		return -EINVAL;
+
+	blen = tsp->blen ?: SCMI_TEST_DEFAULT_BUF_SZ;
+	data = kzalloc(sizeof(*data) + blen, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->len = blen;
+	/* Grab clk ID from debugfs entry naming if any */
+	if (!kstrtouint(id_str, 10, &id))
+		data->id = id;
+
+	filp->private_data = data;
+
+	return 0;
+}
+
 int scmi_test_release(struct inode *ino, struct file *filp)
 {
 	kfree(filp->private_data);
diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h b/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h
index 1ff5bbc32ae3..3c64cae9fae9 100644
--- a/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h
+++ b/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h
@@ -68,6 +68,7 @@ struct scmi_test_buffer {
 
 extern const struct file_operations scmi_test_string_file_fops;
 
+int scmi_test_setup_open(struct inode *ino, struct file *filp);
 int scmi_test_fixed_buffer_open(struct inode *ino, struct file *filp);
 int scmi_test_release(struct inode *ino, struct file *filp);
 
-- 
2.17.1

