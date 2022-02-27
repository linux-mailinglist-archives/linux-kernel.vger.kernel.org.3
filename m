Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB414C5EEF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 21:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbiB0U5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 15:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiB0U5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:57:24 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C5E43298A
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 12:56:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B755C1063;
        Sun, 27 Feb 2022 12:56:41 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BB753F66F;
        Sun, 27 Feb 2022 12:56:40 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        peter.hilber@opensynergy.com, cristian.marussi@arm.com
Subject: [RFC PATCH 12/16] firmware: arm_scmi: Add Sensor notifications testing support
Date:   Sun, 27 Feb 2022 20:56:04 +0000
Message-Id: <20220227205608.30812-13-cristian.marussi@arm.com>
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

Add a few debugfs entry to enable Sensor notifications support, namely
continuos sensor updates notifications and sensor trip point events
notifications.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 Documentation/ABI/testing/debugfs-scmi        |  50 +++++++++
 .../arm_scmi/scmi_test_driver/test_sensors.c  | 104 +++++++++++++++++-
 2 files changed, 153 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/debugfs-scmi b/Documentation/ABI/testing/debugfs-scmi
index 72835516dee8..8b3f9a12053d 100644
--- a/Documentation/ABI/testing/debugfs-scmi
+++ b/Documentation/ABI/testing/debugfs-scmi
@@ -217,3 +217,53 @@ Description:	SCMI Sensor Protocol trip points configuration operation for
 		writing a base-10 integer value configure and enable trip point
 		<YYY> for sensor <XXX>.
 Users:		KSelftest, Debugging
+
+What:		/sys/kernel/debug/scmi/protocol_0x15/<XXX>/sensor_update_notifs
+Date:		Feb 2022
+KernelVersion:	5.19
+Contact:	cristian.marussi@arm.com
+Description:	A RW entry to support SENSOR_UPDATE notifications testing.
+		Writing a true value (Y/y/1) to this entry will trigger the
+		registration of a common notifier block for the SENSOR_UPDATE
+		notification as defined in SCMI Sensor Protocol: this common
+		notifier block starts collecting all the received notification
+		payload in a circular buffer.
+		The rate at which such notifications are emitted depends on the
+		specific update interval currently selected by the resource
+		at hand using the SENSOR_CONFIG command.
+		Note that, as per SCMI specification, the related sensor
+		resource <XXX> has also to be in an enabled state for the
+		notifications to be emitted by the platform.
+		Reading from this entry will return the latest content of the
+		above mentioned circular buffer.
+		Writing a false value (N/n/0) to this entry will cause the above
+		mentioned common notifier block to be unregistered and so
+		effectively the notification emission to be stopped.
+		When the notifier is unregistered the notification circular
+		buffer is cleared empty.
+		This entry is present only if the related resource <XXX> has
+		been advertised as supporting continuos updated notifications.
+Users:		KSelftest, Debugging
+
+What:		/sys/kernel/debug/scmi/protocol_0x15/<XXX>/sensor_trip_notifs
+Date:		Feb 2022
+KernelVersion:	5.19
+Contact:	cristian.marussi@arm.com
+Description:	A RW entry to support SENSOR_TRIP_POINT_EVENT notifications
+		testing. Writing a true value (Y/y/1) to this entry will trigger
+		the registration of a common notifier block for
+		SENSOR_TRIP_POINT_EVENT notification as defined in SCMI Sensor
+		Protocol: this common notifier block starts collecting all the
+		received notification payload in a circular buffer.
+		Such notifications will be emitted once the related sensor
+		resource crosses one of the configured trip point: such trip
+		point can be cofigured using SENSOR_TRIP_POINT_CONFIG command
+		and related entries in the SCMI debugfs filesystem.
+		Reading from this entry will return the latest content of the
+		above mentioned circular buffer.
+		Writing a false value (N/n/0) to this entry will cause the above
+		mentioned common notifier block to be unregistered and so
+		effectively the notification emission to be stopped.
+		When the notifier is unregistered the notification circular
+		buffer is cleared empty.
+Users:		KSelftest, Debugging
diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/test_sensors.c b/drivers/firmware/arm_scmi/scmi_test_driver/test_sensors.c
index 23206c2bac98..2d610d84390f 100644
--- a/drivers/firmware/arm_scmi/scmi_test_driver/test_sensors.c
+++ b/drivers/firmware/arm_scmi/scmi_test_driver/test_sensors.c
@@ -284,6 +284,79 @@ static const struct file_operations test_sensor_trip_config_fops = {
 	.write = scmi_test_sensor_trip_config_write,
 };
 
+static ssize_t scmi_test_sensor_updates_write(struct file *filp,
+					      const char __user *buf,
+					      size_t count, loff_t *ppos)
+{
+	bool enabled;
+	int ret;
+	u32 src_id;
+	struct scmi_test_setup *tsp = filp->f_inode->i_private;
+	struct scmi_test_buffer *data = filp->private_data;
+
+	if (!tsp || !data)
+		return count;
+
+	ret = kstrtobool_from_user(buf, count, &enabled);
+	if (ret)
+		return ret;
+
+	src_id = data->id;
+	ret = scmi_test_notif_manage(tsp, enabled,
+				     SCMI_PROTOCOL_SENSOR,
+				     SCMI_EVENT_SENSOR_UPDATE, &src_id,
+				     sizeof(struct scmi_sensor_update_report),
+				     scmi_test_generic_notif_cb);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static const struct file_operations test_sensor_updates_fops_rw = {
+	.open = scmi_test_setup_open,
+	.release = scmi_test_release,
+	.read = scmi_test_notif_reports_read,
+	.write = scmi_test_sensor_updates_write,
+};
+
+static ssize_t scmi_test_sensor_trip_point_write(struct file *filp,
+						 const char __user *buf,
+						 size_t count, loff_t *ppos)
+{
+	bool enabled;
+	int ret;
+	u32 src_id;
+	struct scmi_test_setup *tsp = filp->f_inode->i_private;
+	struct scmi_test_buffer *data = filp->private_data;
+
+	if (!tsp || !data)
+		return count;
+
+	ret = kstrtobool_from_user(buf, count, &enabled);
+	if (ret)
+		return ret;
+
+	src_id = data->id;
+	ret = scmi_test_notif_manage(tsp, enabled,
+				     SCMI_PROTOCOL_SENSOR,
+				     SCMI_EVENT_SENSOR_TRIP_POINT_EVENT,
+				     &src_id,
+				   sizeof(struct scmi_sensor_trip_point_report),
+				     scmi_test_generic_notif_cb);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static const struct file_operations test_sensor_trips_fops_rw = {
+	.open = scmi_test_setup_open,
+	.release = scmi_test_release,
+	.read = scmi_test_notif_reports_read,
+	.write = scmi_test_sensor_trip_point_write,
+};
+
 static void scmi_test_sensor_trips_debugfs(struct dentry *pdentry,
 					   struct scmi_test_setup *tsp,
 					   unsigned int num_points)
@@ -514,10 +587,39 @@ int scmi_test_sensor_init(struct scmi_test_setup *tsp)
 					    sensor_dentry, tsp,
 					    &test_sensor_config_fops_rw);
 
-			if (sdata->sinfo[i]->num_trip_points)
+			if (sdata->sinfo[i]->update) {
+				struct scmi_test_setup *tsp_copy;
+
+				tsp_copy = scmi_test_tsp_shallow_copy(dev, tsp);
+				if (IS_ERR(tsp_copy))
+					return PTR_ERR(tsp_copy);
+
+				/* Bigger dedicated buffer for notifs */
+				tsp_copy->blen = 4096;
+				debugfs_create_file("sensor_update_notifs",
+						    0600, sensor_dentry,
+						    tsp_copy,
+						  &test_sensor_updates_fops_rw);
+			}
+
+			if (sdata->sinfo[i]->num_trip_points) {
+				struct scmi_test_setup *tsp_copy;
+
 				scmi_test_sensor_trips_debugfs(sensor_dentry,
 							       tsp,
 					      sdata->sinfo[i]->num_trip_points);
+
+				tsp_copy = scmi_test_tsp_shallow_copy(dev, tsp);
+				if (IS_ERR(tsp_copy))
+					return PTR_ERR(tsp_copy);
+
+				/* Bigger dedicated buffer for notifs */
+				tsp_copy->blen = 4096;
+				debugfs_create_file("sensor_trip_notifs",
+						    0600, sensor_dentry,
+						    tsp_copy,
+						    &test_sensor_trips_fops_rw);
+			}
 		}
 	}
 
-- 
2.17.1

