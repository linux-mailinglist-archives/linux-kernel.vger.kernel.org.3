Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD544C5EE6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 21:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiB0U5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 15:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiB0U5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:57:18 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7E0C66F8C
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 12:56:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 875E012FC;
        Sun, 27 Feb 2022 12:56:38 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B9C23F66F;
        Sun, 27 Feb 2022 12:56:37 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        peter.hilber@opensynergy.com, cristian.marussi@arm.com
Subject: [RFC PATCH 10/16] firmware: arm_scmi: testing: Add Sensor protocol basic support
Date:   Sun, 27 Feb 2022 20:56:02 +0000
Message-Id: <20220227205608.30812-11-cristian.marussi@arm.com>
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

Add SCMI Sensor protocol testing support exposing SCMI Sensor protocol
operations under debugfs /sys/kernel/debug/scmi/protocol_0x15/<XXX>/,
where the subdirectories <XXX> represents each a distinct sensor resource
with ID equal <XXX>.

Still without any support for testing SCMI Sensor notifications.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 Documentation/ABI/testing/debugfs-scmi        |  62 +++
 .../arm_scmi/scmi_test_driver/Makefile        |   2 +-
 .../arm_scmi/scmi_test_driver/scmi_test.c     |   2 +
 .../arm_scmi/scmi_test_driver/test_common.h   |   1 +
 .../arm_scmi/scmi_test_driver/test_sensors.c  | 525 ++++++++++++++++++
 5 files changed, 591 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/arm_scmi/scmi_test_driver/test_sensors.c

diff --git a/Documentation/ABI/testing/debugfs-scmi b/Documentation/ABI/testing/debugfs-scmi
index e91c19e7a323..72835516dee8 100644
--- a/Documentation/ABI/testing/debugfs-scmi
+++ b/Documentation/ABI/testing/debugfs-scmi
@@ -155,3 +155,65 @@ Description:	SCMI Clock Protocol enable atomic operation for clock resource
 		Available only if the underlying SCMI transport is atomic
 		capable (/sys/kernel/debug/scmi/transport/is_atomic is True).
 Users:		KSelftest, Debugging
+
+What:		/sys/kernel/debug/scmi/protocol_0x15/<XXX>/info/*
+Date:		Feb 2022
+KernelVersion:	5.19
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Sensor Protocol informational RO data for sensor resource
+		with id <XXX>: each entry under info/ subdir maps to an equally
+		named field of struct scmi_sensor_info as documented in
+		include/scmi/protocol.h
+Users:		KSelftest, Debugging
+
+What:		/sys/kernel/debug/scmi/protocol_0x15/<XXX>/reading_get
+Date:		Feb 2022
+KernelVersion:	5.19
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Sensor Protocol reading_get operation for sensor resource
+		with id <XXX>; a read returns an u64 integer value representing
+		the current sensor reading.
+Users:		KSelftest, Debugging
+
+What:		/sys/kernel/debug/scmi/protocol_0x15/<XXX>/reading_get_timestamped
+Date:		Feb 2022
+KernelVersion:	5.19
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Sensor Protocol reading_get_timestamped operation for sensor
+		resource with id <XXX>; a read returns a list of pair of values
+		in the form <TSTAMP_u64>:<READING_S64>, where the TSTAMP_u64
+		represents a timestamp taken by the platform when the sensor
+		reading <READING_s64> was sampled.
+Users:		KSelftest, Debugging
+
+What:		/sys/kernel/debug/scmi/protocol_0x15/<XXX>/enable
+Date:		Feb 2022
+KernelVersion:	5.19
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Sensor Protocol enable operation for sensor resource with
+		id <XXX>; a read returns a boolen value representing the current
+		enable state of the sensor, while writing a boolean value causes
+		that specific sensor to be enabled or disabled.
+Users:		KSelftest, Debugging
+
+What:		/sys/kernel/debug/scmi/protocol_0x15/<XXX>/sensor_config
+Date:		Feb 2022
+KernelVersion:	5.19
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Sensor Protocol config operation for sensor resource with
+		id <XXX>; a read returns a base-16 integer representing the
+		current sensor configuration as described in the relevant SCMI
+	        specification (SENSOR_CONFIG_GET), while writing a base-16
+		integer value sets the sensor configuration as per the relevant
+		SCMI specification (SENSOR_CONFIG_SET).
+Users:		KSelftest, Debugging
+
+What:		/sys/kernel/debug/scmi/protocol_0x15/<XXX>/trips/<YYY>/set
+Date:		Feb 2022
+KernelVersion:	5.19
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Sensor Protocol trip points configuration operation for
+		sensor resource with id <XXX> and trip point number <YYY>;
+		writing a base-10 integer value configure and enable trip point
+		<YYY> for sensor <XXX>.
+Users:		KSelftest, Debugging
diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/Makefile b/drivers/firmware/arm_scmi/scmi_test_driver/Makefile
index 6e3ddd177827..458883193f31 100644
--- a/drivers/firmware/arm_scmi/scmi_test_driver/Makefile
+++ b/drivers/firmware/arm_scmi/scmi_test_driver/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-scmi_test_driver-objs := scmi_test.o test_common.o test_clocks.o
+scmi_test_driver-objs := scmi_test.o test_common.o test_clocks.o test_sensors.o
 obj-$(CONFIG_ARM_SCMI_TEST_DRIVER) += scmi_test_driver.o
 
diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/scmi_test.c b/drivers/firmware/arm_scmi/scmi_test_driver/scmi_test.c
index f99aa621684c..04e01dd114c9 100644
--- a/drivers/firmware/arm_scmi/scmi_test_driver/scmi_test.c
+++ b/drivers/firmware/arm_scmi/scmi_test_driver/scmi_test.c
@@ -24,6 +24,7 @@ DEFINE_MUTEX(scmi_test_mtx);
 static
 int (*scmi_test_init[SCMI_MAX_PROTOCOLS])(struct scmi_test_setup *) = {
 	[SCMI_PROTOCOL_CLOCK] = scmi_test_clock_init,
+	[SCMI_PROTOCOL_SENSOR] = scmi_test_sensor_init,
 };
 
 static void
@@ -124,6 +125,7 @@ static int scmi_testing_probe(struct scmi_device *sdev)
 
 static const struct scmi_device_id scmi_id_table[] = {
 	{ SCMI_PROTOCOL_CLOCK, "__scmi_test-clock" },
+	{ SCMI_PROTOCOL_SENSOR, "__scmi_test-sensor" },
 	{ },
 };
 MODULE_DEVICE_TABLE(scmi, scmi_id_table);
diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h b/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h
index 3c64cae9fae9..e02c2521f090 100644
--- a/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h
+++ b/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h
@@ -73,5 +73,6 @@ int scmi_test_fixed_buffer_open(struct inode *ino, struct file *filp);
 int scmi_test_release(struct inode *ino, struct file *filp);
 
 int scmi_test_clock_init(struct scmi_test_setup *tsp);
+int scmi_test_sensor_init(struct scmi_test_setup *tsp);
 
 #endif /* __SCMI_TEST_COMMON_H */
diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/test_sensors.c b/drivers/firmware/arm_scmi/scmi_test_driver/test_sensors.c
new file mode 100644
index 000000000000..23206c2bac98
--- /dev/null
+++ b/drivers/firmware/arm_scmi/scmi_test_driver/test_sensors.c
@@ -0,0 +1,525 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SCMI Testing Driver - Clock Protocol
+ *
+ * Copyright (C) 2022 ARM Ltd.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/dcache.h>
+#include <linux/debugfs.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/kstrtox.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+#include <linux/stat.h>
+
+#include "test_common.h"
+
+struct scmi_sensor_data {
+	unsigned int version;
+	int count;
+	const struct scmi_sensor_info **sinfo;
+};
+
+static int scmi_test_sensor_reading_open(struct inode *ino, struct file *filp)
+{
+	unsigned int id;
+	size_t blen;
+	struct scmi_test_buffer *data;
+	struct scmi_test_setup *tsp = filp->f_inode->i_private;
+	struct scmi_sensor_data *sdata = tsp->priv;
+	const char *id_str = filp->f_path.dentry->d_parent->d_name.name;
+
+	/* Grab clk ID from debugfs entry naming if any */
+	if (kstrtouint(id_str, 10, &id))
+		return -EINVAL;
+
+	if (!sdata->sinfo[id]->num_axis)
+		blen = SCMI_TEST_DEFAULT_BUF_SZ;
+	else
+		blen = 48 * sdata->sinfo[id]->num_axis;
+
+	data = kzalloc(sizeof(*data) + blen, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->id = id;
+	data->len = blen;
+	filp->private_data = data;
+
+	return 0;
+}
+
+static ssize_t scmi_test_sensor_reading_get(struct file *filp, char __user *buf,
+					    size_t count, loff_t *ppos)
+{
+	struct scmi_test_buffer *data = filp->private_data;
+
+	if (!data)
+		return 0;
+
+	if (!data->used) {
+		int ret;
+		bool tstamp_req;
+		u64 value;
+		struct scmi_test_setup *tsp = filp->f_inode->i_private;
+		const struct scmi_sensor_proto_ops *sensor_ops = tsp->ops;
+
+		tstamp_req = !strncmp(filp->f_path.dentry->d_name.name,
+				      "reading_get_timestamped",
+				      strlen("reading_get_timestamped"));
+
+		if (!tstamp_req) {
+			ret = sensor_ops->reading_get(tsp->ph, data->id,
+						      &value);
+			if (ret)
+				return ret;
+
+			data->used = scnprintf(data->buf, data->len, "%llu\n",
+					       value);
+		} else {
+			u8 count;
+			int i;
+			struct scmi_sensor_reading *readings;
+			const struct scmi_sensor_info *sinfo;
+			struct scmi_sensor_data *sdata = tsp->priv;
+
+			sinfo = sdata->sinfo[data->id];
+			if (!sinfo)
+				return -EINVAL;
+
+			count = sinfo->num_axis ?: 1;
+			readings = kcalloc(count, sizeof(*readings),
+					   GFP_KERNEL);
+			if (!readings)
+				return -ENOMEM;
+
+			ret = sensor_ops->reading_get_timestamped(tsp->ph,
+								  data->id,
+								  count,
+								  readings);
+			if (ret) {
+				kfree(readings);
+				return ret;
+			}
+
+			for (i = 0; i < count; i++)
+				data->used += scnprintf(data->buf + data->used,
+							data->len - data->used,
+							"%llu:%lld ",
+							readings[i].timestamp,
+							readings[i].value);
+
+			data->used += scnprintf(data->buf + data->used,
+						data->len - data->used, "\n");
+
+			kfree(readings);
+		}
+	}
+
+	return simple_read_from_buffer(buf, count, ppos, data->buf, data->used);
+}
+
+static const struct file_operations test_sensor_reading_get_fops_ro = {
+	.open = scmi_test_sensor_reading_open,
+	.release = scmi_test_release,
+	.read = scmi_test_sensor_reading_get,
+};
+
+static ssize_t scmi_test_sensor_enable_read(struct file *filp, char __user *buf,
+					    size_t count, loff_t *ppos)
+{
+	int ret;
+	struct scmi_test_buffer *data = filp->private_data;
+
+	if (!data)
+		return 0;
+
+	if (!data->used) {
+		u32 sensor_config;
+		struct scmi_test_setup *tsp = filp->f_inode->i_private;
+		const struct scmi_sensor_proto_ops *sensor_ops = tsp->ops;
+
+		ret = sensor_ops->config_get(tsp->ph, data->id, &sensor_config);
+		if (ret)
+			return ret;
+
+		data->used = scnprintf(data->buf, data->len, "%lu\n",
+				       SCMI_SENS_CFG_IS_ENABLED(sensor_config));
+	}
+
+	return simple_read_from_buffer(buf, count, ppos, data->buf, data->used);
+}
+
+static ssize_t scmi_test_sensor_enable_write(struct file *filp,
+					     const char __user *buf,
+					     size_t count, loff_t *ppos)
+{
+	bool enabled;
+	int ret;
+	u32 sensor_config;
+	struct scmi_test_setup *tsp = filp->f_inode->i_private;
+	const struct scmi_sensor_proto_ops *sensor_ops = tsp->ops;
+	struct scmi_test_buffer *data = filp->private_data;
+
+	if (!data)
+		return 0;
+
+	ret = kstrtobool_from_user(buf, count, &enabled);
+	if (ret)
+		return ret;
+
+	ret = sensor_ops->config_get(tsp->ph, data->id, &sensor_config);
+	if (ret)
+		return ret;
+
+	sensor_config &= ~SCMI_SENS_CFG_SENSOR_ENABLED_MASK;
+	sensor_config |= FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK, enabled);
+
+	ret = sensor_ops->config_set(tsp->ph, data->id, sensor_config);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static const struct file_operations test_sensor_enable_fops_rw = {
+	.open = scmi_test_setup_open,
+	.release = scmi_test_release,
+	.read = scmi_test_sensor_enable_read,
+	.write = scmi_test_sensor_enable_write,
+};
+
+static ssize_t scmi_test_sensor_config_read(struct file *filp, char __user *buf,
+					    size_t count, loff_t *ppos)
+{
+	int ret;
+	struct scmi_test_buffer *data = filp->private_data;
+
+	if (!data)
+		return 0;
+
+	if (!data->used) {
+		u32 sensor_config;
+		struct scmi_test_setup *tsp = filp->f_inode->i_private;
+		const struct scmi_sensor_proto_ops *sensor_ops = tsp->ops;
+
+		ret = sensor_ops->config_get(tsp->ph, data->id, &sensor_config);
+		if (ret)
+			return ret;
+
+		data->used = scnprintf(data->buf, data->len, "0x%X\n",
+				       sensor_config);
+	}
+
+	return simple_read_from_buffer(buf, count, ppos, data->buf, data->used);
+}
+
+static ssize_t scmi_test_sensor_config_write(struct file *filp,
+					     const char __user *buf,
+					     size_t count, loff_t *ppos)
+{
+	int ret;
+	u32 sensor_config;
+	struct scmi_test_setup *tsp = filp->f_inode->i_private;
+	const struct scmi_sensor_proto_ops *sensor_ops = tsp->ops;
+	struct scmi_test_buffer *data = filp->private_data;
+
+	if (!data)
+		return 0;
+
+	ret = kstrtou32_from_user(buf, count, 16, &sensor_config);
+	if (ret)
+		return ret;
+
+	ret = sensor_ops->config_set(tsp->ph, data->id, sensor_config);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static const struct file_operations test_sensor_config_fops_rw = {
+	.open = scmi_test_setup_open,
+	.release = scmi_test_release,
+	.read = scmi_test_sensor_config_read,
+	.write = scmi_test_sensor_config_write,
+};
+
+static ssize_t scmi_test_sensor_trip_config_write(struct file *filp,
+						  const char __user *buf,
+						  size_t count, loff_t *ppos)
+{
+	int ret;
+	unsigned int sid;
+	u64 trip_config;
+	struct scmi_test_setup *tsp = filp->f_inode->i_private;
+	const struct scmi_sensor_proto_ops *sensor_ops = tsp->ops;
+	struct scmi_test_buffer *data = filp->private_data;
+	/* protocol_0x15/008/trips/001/set */
+	const char *sid_str =
+		filp->f_path.dentry->d_parent->d_parent->d_parent->d_name.name;
+
+	if (!data || kstrtouint(sid_str, 10, &sid))
+		return 0;
+
+	/* Cannot clear !!! Not supported by .trip_point_config */
+	ret = kstrtou64_from_user(buf, count, 10, &trip_config);
+	if (ret)
+		return ret;
+
+	ret = sensor_ops->trip_point_config(tsp->ph, sid,
+					    data->id, trip_config);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static const struct file_operations test_sensor_trip_config_fops = {
+	.open = scmi_test_setup_open,
+	.release = scmi_test_release,
+	.write = scmi_test_sensor_trip_config_write,
+};
+
+static void scmi_test_sensor_trips_debugfs(struct dentry *pdentry,
+					   struct scmi_test_setup *tsp,
+					   unsigned int num_points)
+{
+	struct dentry *trips_dentry;
+
+	trips_dentry = debugfs_create_dir("trips", pdentry);
+
+	if (!IS_ERR(trips_dentry)) {
+		int i;
+
+		for (i = 0; i < num_points; i++) {
+			char point_dir[16];
+			struct dentry *point_dentry;
+
+			snprintf(point_dir, 16, "%03d", i);
+			point_dentry =
+				debugfs_create_dir(point_dir, trips_dentry);
+			if (!IS_ERR(point_dentry))
+				debugfs_create_file("set", 0200,
+						    point_dentry, tsp,
+						&test_sensor_trip_config_fops);
+		}
+	}
+}
+
+static int scmi_test_sensor_intervals_open(struct inode *ino, struct file *filp)
+{
+	size_t ilen;
+	struct scmi_test_buffer *data;
+	struct scmi_sensor_intervals_info *i = filp->f_inode->i_private;
+
+	/* 65536^-16\n */
+	ilen = i->count * 16;
+	data = kzalloc(sizeof(*data) + ilen, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->len = ilen;
+	filp->private_data = data;
+
+	return 0;
+}
+
+static ssize_t scmi_test_sensor_intervals_read(struct file *filp,
+					       char __user *buf,
+					       size_t count, loff_t *ppos)
+{
+	struct scmi_test_buffer *data = filp->private_data;
+
+	if (!data)
+		return 0;
+
+	if (!data->used) {
+		int c;
+		struct scmi_sensor_intervals_info *i = filp->f_inode->i_private;
+
+		for (c = 0; c < i->count; c++)
+			data->used += scnprintf(data->buf + data->used,
+						data->len - data->used,
+						"%lu^%d ",
+					SCMI_SENS_INTVL_GET_SECS(i->desc[c]),
+					SCMI_SENS_INTVL_GET_EXP(i->desc[c]));
+
+		data->used += scnprintf(data->buf + data->used,
+					data->len - data->used, "\n");
+	}
+
+	return simple_read_from_buffer(buf, count, ppos, data->buf, data->used);
+}
+
+static const struct file_operations test_sensor_intervals_fops = {
+	.open = scmi_test_sensor_intervals_open,
+	.release = scmi_test_release,
+	.read = scmi_test_sensor_intervals_read,
+};
+
+static void
+scmi_test_debugfs_sensor_info_create(const struct scmi_sensor_info *si,
+				     struct dentry *top_dentry)
+{
+	struct dentry *parent;
+	struct scmi_sensor_info *sinfo = (struct scmi_sensor_info *)si;
+
+	parent = debugfs_create_dir("info", top_dentry);
+	if (IS_ERR(parent))
+		return;
+
+	debugfs_create_u32("type", 0400, parent, &sinfo->type);
+	debugfs_create_s32("scale", 0400, parent, &sinfo->scale);
+	debugfs_create_u32("num_trip_points", 0400, parent,
+			   &sinfo->num_trip_points);
+	debugfs_create_bool("async", 0400, parent, &sinfo->async);
+	debugfs_create_bool("continuos_updates", 0400, parent,
+			    &sinfo->update);
+	debugfs_create_bool("timestamped", 0400, parent,
+			    &sinfo->timestamped);
+	debugfs_create_s32("tstamp_scale", 0400, parent,
+			   &sinfo->tstamp_scale);
+
+	debugfs_create_u32("num_axis", 0400, parent, &sinfo->num_axis);
+	if (sinfo->num_axis) {
+		int i;
+		struct dentry *axes;
+
+		axes = debugfs_create_dir("axes", parent);
+		if (IS_ERR(axes))
+			return;
+
+		for (i = 0; i < sinfo->num_axis; i++) {
+			char axis_dir[16];
+			struct dentry *axis;
+
+			snprintf(axis_dir, 16, "%03d", i);
+			axis = debugfs_create_dir(axis_dir, axes);
+			if (IS_ERR(axis))
+				return;
+
+			debugfs_create_u32("type", 0400, axis,
+					   &sinfo->axis[i].type);
+			debugfs_create_s32("scale", 0400, axis,
+					   &sinfo->axis[i].scale);
+			debugfs_create_file("name", 0400, axis,
+					    sinfo->axis[i].name,
+					    &scmi_test_string_file_fops);
+			if (sinfo->axis[i].extended_attrs) {
+				debugfs_create_u32("resolution", 0400, axis,
+						   &sinfo->axis[i].resolution);
+				debugfs_create_s32("exponent", 0400, axis,
+						   &sinfo->axis[i].exponent);
+				debugfs_create_s64("min_range", 0400, axis,
+						   &sinfo->axis[i].attrs.min_range);
+				debugfs_create_s64("max_range", 0400, axis,
+						   &sinfo->axis[i].attrs.max_range);
+			}
+		}
+	}
+
+	if (sinfo->intervals.segmented && sinfo->intervals.count == 3) {
+		debugfs_create_u32("interval_low", 0400, parent,
+				   &sinfo->intervals.desc[SCMI_SENS_INTVL_SEGMENT_LOW]);
+		debugfs_create_u32("interval_high", 0400, parent,
+				   &sinfo->intervals.desc[SCMI_SENS_INTVL_SEGMENT_HIGH]);
+		debugfs_create_u32("interval_step", 0400, parent,
+				   &sinfo->intervals.desc[SCMI_SENS_INTVL_SEGMENT_STEP]);
+	} else {
+		debugfs_create_file("intervals", 0400, parent,
+				    &sinfo->intervals,
+				    &test_sensor_intervals_fops);
+	}
+
+	debugfs_create_u32("sensor_config", 0400, parent,
+			   &sinfo->sensor_config);
+
+	debugfs_create_file("name", 0400, parent, sinfo->name,
+			    &scmi_test_string_file_fops);
+
+	if (sinfo->extended_scalar_attrs) {
+		debugfs_create_u32("sensor_power", 0400, parent,
+				   &sinfo->sensor_power);
+		debugfs_create_u32("resolution", 0400, parent,
+				   &sinfo->resolution);
+		debugfs_create_s32("exponent", 0400, parent,
+				   &sinfo->exponent);
+		debugfs_create_s64("min_range", 0400, parent,
+				   &sinfo->scalar_attrs.min_range);
+		debugfs_create_s64("max_range", 0400, parent,
+				   &sinfo->scalar_attrs.max_range);
+	}
+}
+
+int scmi_test_sensor_init(struct scmi_test_setup *tsp)
+{
+	int i;
+	struct scmi_sensor_data *sdata;
+	const struct scmi_sensor_proto_ops *sensor_ops;
+	struct device *dev = &tsp->sdev->dev;
+
+	sdata = devm_kzalloc(dev, sizeof(*sdata), GFP_KERNEL);
+	if (!sdata)
+		return -ENOMEM;
+
+	sensor_ops = tsp->ops;
+	sdata->version = sensor_ops->version_get(tsp->ph);
+	sdata->count = sensor_ops->count_get(tsp->ph);
+
+	if (sdata->count <= 0) {
+		dev_err(dev, "number of domains invalid: %d\n",
+			sdata->count);
+		return sdata->count ?: -EINVAL;
+	}
+
+	sdata->sinfo = devm_kcalloc(dev, sdata->count,
+				    sizeof(sdata->sinfo), GFP_KERNEL);
+	if (!sdata->sinfo)
+		return -ENOMEM;
+
+	for (i = 0; i < sdata->count; i++)
+		sdata->sinfo[i] = sensor_ops->info_get(tsp->ph, i);
+
+	tsp->priv = sdata;
+	debugfs_create_x32("version", 0400, tsp->parent, &sdata->version);
+
+	dev_info(dev, "Found %d sensor resources.\n", sdata->count);
+
+	for (i = 0; i < sdata->count; i++) {
+		char sensor_dir[16];
+		struct dentry *sensor_dentry;
+
+		if (!sdata->sinfo[i])
+			continue;
+
+		snprintf(sensor_dir, 16, "%03d", i);
+		sensor_dentry = debugfs_create_dir(sensor_dir, tsp->parent);
+		if (!IS_ERR(sensor_dentry)) {
+			scmi_test_debugfs_sensor_info_create(sdata->sinfo[i],
+							     sensor_dentry);
+			debugfs_create_file("reading_get", 0400,
+					    sensor_dentry, tsp,
+					    &test_sensor_reading_get_fops_ro);
+			debugfs_create_file("reading_get_timestamped", 0400,
+					    sensor_dentry, tsp,
+					    &test_sensor_reading_get_fops_ro);
+			debugfs_create_file("enable", 0600,
+					    sensor_dentry, tsp,
+					    &test_sensor_enable_fops_rw);
+			debugfs_create_file("sensor_config", 0600,
+					    sensor_dentry, tsp,
+					    &test_sensor_config_fops_rw);
+
+			if (sdata->sinfo[i]->num_trip_points)
+				scmi_test_sensor_trips_debugfs(sensor_dentry,
+							       tsp,
+					      sdata->sinfo[i]->num_trip_points);
+		}
+	}
+
+	return 0;
+}
-- 
2.17.1

