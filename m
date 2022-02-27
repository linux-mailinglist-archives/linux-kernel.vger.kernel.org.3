Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3704C5EE2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 21:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiB0U5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 15:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiB0U5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:57:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7C653298D
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 12:56:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DF5D1424;
        Sun, 27 Feb 2022 12:56:28 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20C7D3F66F;
        Sun, 27 Feb 2022 12:56:27 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        peter.hilber@opensynergy.com, cristian.marussi@arm.com
Subject: [RFC PATCH 04/16] firmware: arm_scmi: Add .version_get protocol operation
Date:   Sun, 27 Feb 2022 20:55:56 +0000
Message-Id: <20220227205608.30812-5-cristian.marussi@arm.com>
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

Add new .version_get protocol operation so as to allow interested SCMI
driver users to lookup protocol versions implemented by the underlying
SCMI platform.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c   |  1 +
 drivers/firmware/arm_scmi/common.h  | 20 ++++++++++++++++++++
 drivers/firmware/arm_scmi/perf.c    |  1 +
 drivers/firmware/arm_scmi/power.c   |  1 +
 drivers/firmware/arm_scmi/reset.c   |  1 +
 drivers/firmware/arm_scmi/sensors.c |  1 +
 drivers/firmware/arm_scmi/system.c  |  6 +++++-
 drivers/firmware/arm_scmi/voltage.c |  1 +
 include/linux/scmi_protocol.h       | 22 ++++++++++++++++++++++
 9 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index e2059d2025a2..c19b6bff370d 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -344,6 +344,7 @@ scmi_clock_info_get(const struct scmi_protocol_handle *ph, u32 clk_id)
 }
 
 static const struct scmi_clk_proto_ops clk_proto_ops = {
+	.version_get = scmi_protocol_version_get,
 	.count_get = scmi_clock_count_get,
 	.info_get = scmi_clock_info_get,
 	.rate_get = scmi_clock_rate_get,
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index ffaf74a36b30..e7e9c8c5d48c 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -269,6 +269,26 @@ struct scmi_xfer_ops {
 			 struct scmi_xfer *xfer);
 };
 
+/**
+ * scmi_protocol_version_get  - Common helper to get protocol version
+ *
+ * @ph: A reference to an initialized protocol handle
+ *
+ * Exposed as .version_get for each protocol operations, it can be called by
+ * SCMI drivers only on initialized protocol instances so it cannot fail.
+ *
+ * Return: Protocol version for the specified protocol handle
+ */
+static inline
+unsigned int scmi_protocol_version_get(struct scmi_protocol_handle *ph)
+{
+	u32 version = 0;
+
+	ph->xops->version_get(ph, &version);
+
+	return version;
+}
+
 struct scmi_revision_info *
 scmi_revision_area_get(const struct scmi_protocol_handle *ph);
 int scmi_handle_put(const struct scmi_handle *handle);
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index e9f68b91580c..e58490a8d0e7 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -756,6 +756,7 @@ static bool scmi_power_scale_mw_get(const struct scmi_protocol_handle *ph)
 }
 
 static const struct scmi_perf_proto_ops perf_proto_ops = {
+	.version_get = scmi_protocol_version_get,
 	.limits_set = scmi_perf_limits_set,
 	.limits_get = scmi_perf_limits_get,
 	.level_set = scmi_perf_level_set,
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index 0f0b94f0b624..c14bdb9a9ccd 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -184,6 +184,7 @@ static char *scmi_power_name_get(const struct scmi_protocol_handle *ph,
 }
 
 static const struct scmi_power_proto_ops power_proto_ops = {
+	.version_get = scmi_protocol_version_get,
 	.num_domains_get = scmi_power_num_domains_get,
 	.name_get = scmi_power_name_get,
 	.state_set = scmi_power_state_set,
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index 9cdbd133db10..acf83ea361ed 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -196,6 +196,7 @@ scmi_reset_domain_deassert(const struct scmi_protocol_handle *ph, u32 domain)
 }
 
 static const struct scmi_reset_proto_ops reset_proto_ops = {
+	.version_get = scmi_protocol_version_get,
 	.num_domains_get = scmi_reset_num_domains_get,
 	.name_get = scmi_reset_name_get,
 	.latency_get = scmi_reset_latency_get,
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index f37ac9824a87..4ee578cf0c23 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -828,6 +828,7 @@ static int scmi_sensor_count_get(const struct scmi_protocol_handle *ph)
 }
 
 static const struct scmi_sensor_proto_ops sensor_proto_ops = {
+	.version_get = scmi_protocol_version_get,
 	.count_get = scmi_sensor_count_get,
 	.info_get = scmi_sensor_info_get,
 	.trip_point_config = scmi_sensor_trip_point_config,
diff --git a/drivers/firmware/arm_scmi/system.c b/drivers/firmware/arm_scmi/system.c
index cbfc19f7a463..90157d7f45bc 100644
--- a/drivers/firmware/arm_scmi/system.c
+++ b/drivers/firmware/arm_scmi/system.c
@@ -33,6 +33,10 @@ struct scmi_system_info {
 	u32 version;
 };
 
+static struct scmi_system_proto_ops system_proto_ops = {
+	.version_get = scmi_protocol_version_get,
+};
+
 static int scmi_system_request_notify(const struct scmi_protocol_handle *ph,
 				      bool enable)
 {
@@ -136,7 +140,7 @@ static const struct scmi_protocol scmi_system = {
 	.id = SCMI_PROTOCOL_SYSTEM,
 	.owner = THIS_MODULE,
 	.instance_init = &scmi_system_protocol_init,
-	.ops = NULL,
+	.ops = &system_proto_ops,
 	.events = &system_protocol_events,
 };
 
diff --git a/drivers/firmware/arm_scmi/voltage.c b/drivers/firmware/arm_scmi/voltage.c
index ac08e819088b..c9a7cbdc9164 100644
--- a/drivers/firmware/arm_scmi/voltage.c
+++ b/drivers/firmware/arm_scmi/voltage.c
@@ -324,6 +324,7 @@ static int scmi_voltage_domains_num_get(const struct scmi_protocol_handle *ph)
 }
 
 static struct scmi_voltage_proto_ops voltage_proto_ops = {
+	.version_get = scmi_protocol_version_get,
 	.num_domains_get = scmi_voltage_domains_num_get,
 	.info_get = scmi_voltage_info_get,
 	.config_set = scmi_voltage_config_set,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index b0652f1411b9..c5881d15f7d9 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -65,6 +65,7 @@ struct scmi_protocol_handle;
  * struct scmi_clk_proto_ops - represents the various operations provided
  *	by SCMI Clock Protocol
  *
+ * @version_get: get the protocol version implemented by this SCMI instance
  * @count_get: get the count of clocks provided by SCMI
  * @info_get: get the information of the specified clock
  * @rate_get: request the current clock rate of a clock
@@ -73,6 +74,7 @@ struct scmi_protocol_handle;
  * @disable: disables the specified clock
  */
 struct scmi_clk_proto_ops {
+	unsigned int (*version_get)(struct scmi_protocol_handle *ph);
 	int (*count_get)(const struct scmi_protocol_handle *ph);
 
 	const struct scmi_clock_info *(*info_get)
@@ -92,6 +94,7 @@ struct scmi_clk_proto_ops {
  * struct scmi_perf_proto_ops - represents the various operations provided
  *	by SCMI Performance Protocol
  *
+ * @version_get: get the protocol version implemented by this SCMI instance
  * @limits_set: sets limits on the performance level of a domain
  * @limits_get: gets limits on the performance level of a domain
  * @level_set: sets the performance level of a domain
@@ -111,6 +114,7 @@ struct scmi_clk_proto_ops {
  *	or in some other (abstract) scale
  */
 struct scmi_perf_proto_ops {
+	unsigned int (*version_get)(struct scmi_protocol_handle *ph);
 	int (*limits_set)(const struct scmi_protocol_handle *ph, u32 domain,
 			  u32 max_perf, u32 min_perf);
 	int (*limits_get)(const struct scmi_protocol_handle *ph, u32 domain,
@@ -139,12 +143,14 @@ struct scmi_perf_proto_ops {
  * struct scmi_power_proto_ops - represents the various operations provided
  *	by SCMI Power Protocol
  *
+ * @version_get: get the protocol version implemented by this SCMI instance
  * @num_domains_get: get the count of power domains provided by SCMI
  * @name_get: gets the name of a power domain
  * @state_set: sets the power state of a power domain
  * @state_get: gets the power state of a power domain
  */
 struct scmi_power_proto_ops {
+	unsigned int (*version_get)(struct scmi_protocol_handle *ph);
 	int (*num_domains_get)(const struct scmi_protocol_handle *ph);
 	char *(*name_get)(const struct scmi_protocol_handle *ph, u32 domain);
 #define SCMI_POWER_STATE_TYPE_SHIFT	30
@@ -442,6 +448,7 @@ enum scmi_sensor_class {
  * struct scmi_sensor_proto_ops - represents the various operations provided
  *	by SCMI Sensor Protocol
  *
+ * @version_get: get the protocol version implemented by this SCMI instance
  * @count_get: get the count of sensors provided by SCMI
  * @info_get: get the information of the specified sensor
  * @trip_point_config: selects and configures a trip-point of interest
@@ -455,6 +462,7 @@ enum scmi_sensor_class {
  * @config_set: Set sensor current configuration
  */
 struct scmi_sensor_proto_ops {
+	unsigned int (*version_get)(struct scmi_protocol_handle *ph);
 	int (*count_get)(const struct scmi_protocol_handle *ph);
 	const struct scmi_sensor_info *(*info_get)
 		(const struct scmi_protocol_handle *ph, u32 sensor_id);
@@ -475,6 +483,7 @@ struct scmi_sensor_proto_ops {
  * struct scmi_reset_proto_ops - represents the various operations provided
  *	by SCMI Reset Protocol
  *
+ * @version_get: get the protocol version implemented by this SCMI instance
  * @num_domains_get: get the count of reset domains provided by SCMI
  * @name_get: gets the name of a reset domain
  * @latency_get: gets the reset latency for the specified reset domain
@@ -483,6 +492,7 @@ struct scmi_sensor_proto_ops {
  * @deassert: explicitly deassert reset signal of the specified reset domain
  */
 struct scmi_reset_proto_ops {
+	unsigned int (*version_get)(struct scmi_protocol_handle *ph);
 	int (*num_domains_get)(const struct scmi_protocol_handle *ph);
 	char *(*name_get)(const struct scmi_protocol_handle *ph, u32 domain);
 	int (*latency_get)(const struct scmi_protocol_handle *ph, u32 domain);
@@ -526,6 +536,7 @@ struct scmi_voltage_info {
  * struct scmi_voltage_proto_ops - represents the various operations provided
  * by SCMI Voltage Protocol
  *
+ * @version_get: get the protocol version implemented by this SCMI instance
  * @num_domains_get: get the count of voltage domains provided by SCMI
  * @info_get: get the information of the specified domain
  * @config_set: set the config for the specified domain
@@ -534,6 +545,7 @@ struct scmi_voltage_info {
  * @level_get: get the voltage level of the specified domain
  */
 struct scmi_voltage_proto_ops {
+	unsigned int (*version_get)(struct scmi_protocol_handle *ph);
 	int (*num_domains_get)(const struct scmi_protocol_handle *ph);
 	const struct scmi_voltage_info __must_check *(*info_get)
 		(const struct scmi_protocol_handle *ph, u32 domain_id);
@@ -549,6 +561,16 @@ struct scmi_voltage_proto_ops {
 			 s32 *volt_uV);
 };
 
+/**
+ * struct scmi_system_proto_ops - represents the various operations provided
+ * by SCMI System Power Protocol
+ *
+ * @version_get: get the protocol version implemented by this SCMI instance
+ */
+struct scmi_system_proto_ops {
+	unsigned int (*version_get)(struct scmi_protocol_handle *ph);
+};
+
 /**
  * struct scmi_notify_ops  - represents notifications' operations provided by
  * SCMI core
-- 
2.17.1

