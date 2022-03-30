Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDA94EC7CD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348014AbiC3PJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347914AbiC3PId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:08:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D06D9E9F0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:06:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66446153B;
        Wed, 30 Mar 2022 08:06:46 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 183AB3F73B;
        Wed, 30 Mar 2022 08:06:44 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 11/22] firmware: arm_scmi: Add SCMIv3.1 extended names protocols support
Date:   Wed, 30 Mar 2022 16:05:40 +0100
Message-Id: <20220330150551.2573938-12-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220330150551.2573938-1-cristian.marussi@arm.com>
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the common protocol helper implementation add support for all new
SCMIv3.1 extended names commands related to all protocols with the
exception of SENSOR_AXIS_GET_NAME.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c     | 21 ++++++++++++++++++---
 drivers/firmware/arm_scmi/perf.c      | 22 ++++++++++++++++++----
 drivers/firmware/arm_scmi/power.c     | 25 ++++++++++++++++++++-----
 drivers/firmware/arm_scmi/protocols.h |  2 ++
 drivers/firmware/arm_scmi/reset.c     | 22 ++++++++++++++++++----
 drivers/firmware/arm_scmi/sensors.c   | 15 ++++++++++++++-
 drivers/firmware/arm_scmi/voltage.c   | 14 +++++++++++++-
 include/linux/scmi_protocol.h         |  2 +-
 8 files changed, 104 insertions(+), 19 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index d78339dc2fdc..6dd4150b761b 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -16,6 +16,7 @@ enum scmi_clock_protocol_cmd {
 	CLOCK_RATE_SET = 0x5,
 	CLOCK_RATE_GET = 0x6,
 	CLOCK_CONFIG_SET = 0x7,
+	CLOCK_NAME_GET = 0x8,
 };
 
 struct scmi_msg_resp_clock_protocol_attributes {
@@ -27,7 +28,8 @@ struct scmi_msg_resp_clock_protocol_attributes {
 struct scmi_msg_resp_clock_attributes {
 	__le32 attributes;
 #define	CLOCK_ENABLE	BIT(0)
-	u8 name[SCMI_MAX_STR_SIZE];
+#define SUPPORTS_EXTENDED_NAMES(x)	((x) & BIT(29))
+	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
 	__le32 clock_enable_latency;
 };
 
@@ -108,9 +110,11 @@ scmi_clock_protocol_attributes_get(const struct scmi_protocol_handle *ph,
 }
 
 static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
-				     u32 clk_id, struct scmi_clock_info *clk)
+				     u32 clk_id, struct scmi_clock_info *clk,
+				     u32 version)
 {
 	int ret;
+	u32 attributes;
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_clock_attributes *attr;
 
@@ -124,6 +128,7 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 
 	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
+		attributes = le32_to_cpu(attr->attributes);
 		strlcpy(clk->name, attr->name, SCMI_MAX_STR_SIZE);
 		/* Is optional field clock_enable_latency provided ? */
 		if (t->rx.len == sizeof(*attr))
@@ -132,6 +137,16 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 	}
 
 	ph->xops->xfer_put(ph, t);
+
+	/*
+	 * If supported overwrite short name with the extended one;
+	 * on error just carry on and use already provided short name.
+	 */
+	if (!ret && PROTOCOL_REV_MAJOR(version) >= 0x2 &&
+	    SUPPORTS_EXTENDED_NAMES(attributes))
+		ph->hops->extended_name_get(ph, CLOCK_NAME_GET, clk_id,
+					    clk->name, SCMI_MAX_STR_SIZE);
+
 	return ret;
 }
 
@@ -401,7 +416,7 @@ static int scmi_clock_protocol_init(const struct scmi_protocol_handle *ph)
 	for (clkid = 0; clkid < cinfo->num_clocks; clkid++) {
 		struct scmi_clock_info *clk = cinfo->clk + clkid;
 
-		ret = scmi_clock_attributes_get(ph, clkid, clk);
+		ret = scmi_clock_attributes_get(ph, clkid, clk, version);
 		if (!ret)
 			scmi_clock_describe_rates_get(ph, clkid, clk);
 	}
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 0e9703310758..9e046fd121b9 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -32,6 +32,7 @@ enum scmi_performance_protocol_cmd {
 	PERF_NOTIFY_LIMITS = 0x9,
 	PERF_NOTIFY_LEVEL = 0xa,
 	PERF_DESCRIBE_FASTCHANNEL = 0xb,
+	PERF_DOMAIN_NAME_GET = 0xc,
 };
 
 struct scmi_opp {
@@ -56,10 +57,11 @@ struct scmi_msg_resp_perf_domain_attributes {
 #define SUPPORTS_PERF_LIMIT_NOTIFY(x)	((x) & BIT(29))
 #define SUPPORTS_PERF_LEVEL_NOTIFY(x)	((x) & BIT(28))
 #define SUPPORTS_PERF_FASTCHANNELS(x)	((x) & BIT(27))
+#define SUPPORTS_EXTENDED_NAMES(x)	((x) & BIT(26))
 	__le32 rate_limit_us;
 	__le32 sustained_freq_khz;
 	__le32 sustained_perf_level;
-	    u8 name[SCMI_MAX_STR_SIZE];
+	    u8 name[SCMI_SHORT_NAME_MAX_SIZE];
 };
 
 struct scmi_msg_perf_describe_levels {
@@ -209,9 +211,11 @@ static int scmi_perf_attributes_get(const struct scmi_protocol_handle *ph,
 
 static int
 scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
-				u32 domain, struct perf_dom_info *dom_info)
+				u32 domain, struct perf_dom_info *dom_info,
+				u32 version)
 {
 	int ret;
+	u32 flags;
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_perf_domain_attributes *attr;
 
@@ -225,7 +229,7 @@ scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
 
 	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
-		u32 flags = le32_to_cpu(attr->flags);
+		flags = le32_to_cpu(attr->flags);
 
 		dom_info->set_limits = SUPPORTS_SET_LIMITS(flags);
 		dom_info->set_perf = SUPPORTS_SET_PERF_LVL(flags);
@@ -248,6 +252,16 @@ scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
 	}
 
 	ph->xops->xfer_put(ph, t);
+
+	/*
+	 * If supported overwrite short name with the extended one;
+	 * on error just carry on and use already provided short name.
+	 */
+	if (!ret && PROTOCOL_REV_MAJOR(version) >= 0x3 &&
+	    SUPPORTS_EXTENDED_NAMES(flags))
+		ph->hops->extended_name_get(ph, PERF_DOMAIN_NAME_GET, domain,
+					    dom_info->name, SCMI_MAX_STR_SIZE);
+
 	return ret;
 }
 
@@ -902,7 +916,7 @@ static int scmi_perf_protocol_init(const struct scmi_protocol_handle *ph)
 	for (domain = 0; domain < pinfo->num_domains; domain++) {
 		struct perf_dom_info *dom = pinfo->dom_info + domain;
 
-		scmi_perf_domain_attributes_get(ph, domain, dom);
+		scmi_perf_domain_attributes_get(ph, domain, dom, version);
 		scmi_perf_describe_levels_get(ph, domain, dom);
 
 		if (dom->perf_fastchannels)
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index e378a3eb0d07..964882cc8747 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -18,6 +18,7 @@ enum scmi_power_protocol_cmd {
 	POWER_STATE_SET = 0x4,
 	POWER_STATE_GET = 0x5,
 	POWER_STATE_NOTIFY = 0x6,
+	POWER_DOMAIN_NAME_GET = 0x8,
 };
 
 struct scmi_msg_resp_power_attributes {
@@ -33,7 +34,8 @@ struct scmi_msg_resp_power_domain_attributes {
 #define SUPPORTS_STATE_SET_NOTIFY(x)	((x) & BIT(31))
 #define SUPPORTS_STATE_SET_ASYNC(x)	((x) & BIT(30))
 #define SUPPORTS_STATE_SET_SYNC(x)	((x) & BIT(29))
-	    u8 name[SCMI_MAX_STR_SIZE];
+#define SUPPORTS_EXTENDED_NAMES(x)	((x) & BIT(27))
+	    u8 name[SCMI_SHORT_NAME_MAX_SIZE];
 };
 
 struct scmi_power_set_state {
@@ -97,9 +99,11 @@ static int scmi_power_attributes_get(const struct scmi_protocol_handle *ph,
 
 static int
 scmi_power_domain_attributes_get(const struct scmi_protocol_handle *ph,
-				 u32 domain, struct power_dom_info *dom_info)
+				 u32 domain, struct power_dom_info *dom_info,
+				 u32 version)
 {
 	int ret;
+	u32 flags;
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_power_domain_attributes *attr;
 
@@ -113,15 +117,26 @@ scmi_power_domain_attributes_get(const struct scmi_protocol_handle *ph,
 
 	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
-		u32 flags = le32_to_cpu(attr->flags);
+		flags = le32_to_cpu(attr->flags);
 
 		dom_info->state_set_notify = SUPPORTS_STATE_SET_NOTIFY(flags);
 		dom_info->state_set_async = SUPPORTS_STATE_SET_ASYNC(flags);
 		dom_info->state_set_sync = SUPPORTS_STATE_SET_SYNC(flags);
 		strlcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
 	}
-
 	ph->xops->xfer_put(ph, t);
+
+	/*
+	 * If supported overwrite short name with the extended one;
+	 * on error just carry on and use already provided short name.
+	 */
+	if (!ret && PROTOCOL_REV_MAJOR(version) >= 0x3 &&
+	    SUPPORTS_EXTENDED_NAMES(flags)) {
+		ph->hops->extended_name_get(ph, POWER_DOMAIN_NAME_GET,
+					    domain, dom_info->name,
+					    SCMI_MAX_STR_SIZE);
+	}
+
 	return ret;
 }
 
@@ -308,7 +323,7 @@ static int scmi_power_protocol_init(const struct scmi_protocol_handle *ph)
 	for (domain = 0; domain < pinfo->num_domains; domain++) {
 		struct power_dom_info *dom = pinfo->dom_info + domain;
 
-		scmi_power_domain_attributes_get(ph, domain, dom);
+		scmi_power_domain_attributes_get(ph, domain, dom, version);
 	}
 
 	pinfo->version = version;
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index 5461fa333152..60ea880b3855 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -24,6 +24,8 @@
 
 #include <asm/unaligned.h>
 
+#define SCMI_SHORT_NAME_MAX_SIZE	16
+
 #define PROTOCOL_REV_MINOR_MASK	GENMASK(15, 0)
 #define PROTOCOL_REV_MAJOR_MASK	GENMASK(31, 16)
 #define PROTOCOL_REV_MAJOR(x)	((u16)(FIELD_GET(PROTOCOL_REV_MAJOR_MASK, (x))))
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index cc465632aa1a..a420a9102094 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -17,6 +17,7 @@ enum scmi_reset_protocol_cmd {
 	RESET_DOMAIN_ATTRIBUTES = 0x3,
 	RESET = 0x4,
 	RESET_NOTIFY = 0x5,
+	RESET_DOMAIN_NAME_GET = 0x6,
 };
 
 #define NUM_RESET_DOMAIN_MASK	0xffff
@@ -26,8 +27,9 @@ struct scmi_msg_resp_reset_domain_attributes {
 	__le32 attributes;
 #define SUPPORTS_ASYNC_RESET(x)		((x) & BIT(31))
 #define SUPPORTS_NOTIFY_RESET(x)	((x) & BIT(30))
+#define SUPPORTS_EXTENDED_NAMES(x)	((x) & BIT(29))
 	__le32 latency;
-	    u8 name[SCMI_MAX_STR_SIZE];
+	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
 };
 
 struct scmi_msg_reset_domain_reset {
@@ -89,9 +91,11 @@ static int scmi_reset_attributes_get(const struct scmi_protocol_handle *ph,
 
 static int
 scmi_reset_domain_attributes_get(const struct scmi_protocol_handle *ph,
-				 u32 domain, struct reset_dom_info *dom_info)
+				 u32 domain, struct reset_dom_info *dom_info,
+				 u32 version)
 {
 	int ret;
+	u32 attributes;
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_reset_domain_attributes *attr;
 
@@ -105,7 +109,7 @@ scmi_reset_domain_attributes_get(const struct scmi_protocol_handle *ph,
 
 	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
-		u32 attributes = le32_to_cpu(attr->attributes);
+		attributes = le32_to_cpu(attr->attributes);
 
 		dom_info->async_reset = SUPPORTS_ASYNC_RESET(attributes);
 		dom_info->reset_notify = SUPPORTS_NOTIFY_RESET(attributes);
@@ -116,6 +120,16 @@ scmi_reset_domain_attributes_get(const struct scmi_protocol_handle *ph,
 	}
 
 	ph->xops->xfer_put(ph, t);
+
+	/*
+	 * If supported overwrite short name with the extended one;
+	 * on error just carry on and use already provided short name.
+	 */
+	if (!ret && PROTOCOL_REV_MAJOR(version) >= 0x3 &&
+	    SUPPORTS_EXTENDED_NAMES(attributes))
+		ph->hops->extended_name_get(ph, RESET_DOMAIN_NAME_GET, domain,
+					    dom_info->name, SCMI_MAX_STR_SIZE);
+
 	return ret;
 }
 
@@ -320,7 +334,7 @@ static int scmi_reset_protocol_init(const struct scmi_protocol_handle *ph)
 	for (domain = 0; domain < pinfo->num_domains; domain++) {
 		struct reset_dom_info *dom = pinfo->dom_info + domain;
 
-		scmi_reset_domain_attributes_get(ph, domain, dom);
+		scmi_reset_domain_attributes_get(ph, domain, dom, version);
 	}
 
 	pinfo->version = version;
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 07c28e249f0c..6fd8b3a874ea 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -27,6 +27,7 @@ enum scmi_sensor_protocol_cmd {
 	SENSOR_CONFIG_GET = 0x9,
 	SENSOR_CONFIG_SET = 0xA,
 	SENSOR_CONTINUOUS_UPDATE_NOTIFY = 0xB,
+	SENSOR_NAME_GET = 0xC,
 };
 
 struct scmi_msg_resp_sensor_attributes {
@@ -71,6 +72,7 @@ struct scmi_msg_resp_sensor_description {
 		__le32 attributes_low;
 /* Common attributes_low macros */
 #define SUPPORTS_ASYNC_READ(x)		FIELD_GET(BIT(31), (x))
+#define SUPPORTS_EXTENDED_NAMES(x)	FIELD_GET(BIT(29), (x))
 #define NUM_TRIP_POINTS(x)		FIELD_GET(GENMASK(7, 0), (x))
 		__le32 attributes_high;
 /* Common attributes_high macros */
@@ -78,7 +80,7 @@ struct scmi_msg_resp_sensor_description {
 #define SENSOR_SCALE_SIGN		BIT(4)
 #define SENSOR_SCALE_EXTEND		GENMASK(31, 5)
 #define SENSOR_TYPE(x)			FIELD_GET(GENMASK(7, 0), (x))
-		u8 name[SCMI_MAX_STR_SIZE];
+		u8 name[SCMI_SHORT_NAME_MAX_SIZE];
 		/* only for version > 2.0 */
 		__le32 power;
 		__le32 resolution;
@@ -519,6 +521,17 @@ static int scmi_sensor_description_get(const struct scmi_protocol_handle *ph,
 					    SCMI_MAX_NUM_SENSOR_AXIS);
 			strlcpy(s->name, sdesc->name, SCMI_MAX_STR_SIZE);
 
+			/*
+			 * If supported overwrite short name with the extended
+			 * one; on error just carry on and use already provided
+			 * short name.
+			 */
+			if (PROTOCOL_REV_MAJOR(si->version) >= 0x3 &&
+			    SUPPORTS_EXTENDED_NAMES(attrl))
+				ph->hops->extended_name_get(ph, SENSOR_NAME_GET,
+							    s->id, s->name,
+							    SCMI_MAX_STR_SIZE);
+
 			if (s->extended_scalar_attrs) {
 				s->sensor_power = le32_to_cpu(sdesc->power);
 				dsize += sizeof(sdesc->power);
diff --git a/drivers/firmware/arm_scmi/voltage.c b/drivers/firmware/arm_scmi/voltage.c
index 7aa887a7cbd2..5d58ba724eeb 100644
--- a/drivers/firmware/arm_scmi/voltage.c
+++ b/drivers/firmware/arm_scmi/voltage.c
@@ -21,13 +21,15 @@ enum scmi_voltage_protocol_cmd {
 	VOLTAGE_CONFIG_GET = 0x6,
 	VOLTAGE_LEVEL_SET = 0x7,
 	VOLTAGE_LEVEL_GET = 0x8,
+	VOLTAGE_DOMAIN_NAME_GET = 0x09,
 };
 
 #define NUM_VOLTAGE_DOMAINS(x)	((u16)(FIELD_GET(VOLTAGE_DOMS_NUM_MASK, (x))))
 
 struct scmi_msg_resp_domain_attributes {
 	__le32 attr;
-	u8 name[SCMI_MAX_STR_SIZE];
+#define SUPPORTS_EXTENDED_NAMES(x)	((x) & BIT(30))
+	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
 };
 
 struct scmi_msg_cmd_describe_levels {
@@ -149,6 +151,16 @@ static int scmi_voltage_descriptors_get(const struct scmi_protocol_handle *ph,
 		v->attributes = le32_to_cpu(resp_dom->attr);
 		strlcpy(v->name, resp_dom->name, SCMI_MAX_STR_SIZE);
 
+		/*
+		 * If supported overwrite short name with the extended one;
+		 * on error just carry on and use already provided short name.
+		 */
+		if (PROTOCOL_REV_MAJOR(vinfo->version) >= 0x2 &&
+		    SUPPORTS_EXTENDED_NAMES(v->attributes))
+			ph->hops->extended_name_get(ph, VOLTAGE_DOMAIN_NAME_GET,
+						    v->id, v->name,
+						    SCMI_MAX_STR_SIZE);
+
 		cmd = tl->tx.buf;
 		/* ...then retrieve domain levels descriptions */
 		do {
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index ced37d1de1fe..56e6f13355b8 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -13,7 +13,7 @@
 #include <linux/notifier.h>
 #include <linux/types.h>
 
-#define SCMI_MAX_STR_SIZE	16
+#define SCMI_MAX_STR_SIZE	64
 #define SCMI_MAX_NUM_RATES	16
 
 /**
-- 
2.32.0

