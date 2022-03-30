Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBAF4EC7DB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348049AbiC3PJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347935AbiC3PI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:08:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1BEDA66F2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:07:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A313823A;
        Wed, 30 Mar 2022 08:07:00 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54BC63F73B;
        Wed, 30 Mar 2022 08:06:59 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 20/22] firmware: arm_scmi: Add SCMIv3.1 VOLTAGE_LEVEL_SET_COMPLETE
Date:   Wed, 30 Mar 2022 16:05:49 +0100
Message-Id: <20220330150551.2573938-21-cristian.marussi@arm.com>
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

Add SCMIv3.1 Voltage protocol support for asynchronous VOLTAGE_LEVEL_SET
command.

Note that, if a Voltage domain is advertised to support the asynchronous
version of VOLTAGE_LEVEL_SET, the command will be issued asynchronously
unless explicitly requested to use the synchronous version by setting the
mode to SCMI_VOLTAGE_LEVEL_SET_SYNC when calling voltage_ops->level_set.

The SCMI Regulator driver level_set invocation has been left unchanged
so that it will transparently use the asynchronous version if available.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/voltage.c | 51 ++++++++++++++++++++++++-----
 include/linux/scmi_protocol.h       | 12 +++++--
 2 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/arm_scmi/voltage.c b/drivers/firmware/arm_scmi/voltage.c
index e1bdce573c4f..9d195d8719ab 100644
--- a/drivers/firmware/arm_scmi/voltage.c
+++ b/drivers/firmware/arm_scmi/voltage.c
@@ -28,6 +28,7 @@ enum scmi_voltage_protocol_cmd {
 
 struct scmi_msg_resp_domain_attributes {
 	__le32 attr;
+#define SUPPORTS_ASYNC_LEVEL_SET(x)	((x) & BIT(31))
 #define SUPPORTS_EXTENDED_NAMES(x)	((x) & BIT(30))
 	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
 };
@@ -56,6 +57,11 @@ struct scmi_msg_cmd_level_set {
 	__le32 voltage_level;
 };
 
+struct scmi_resp_voltage_level_set_complete {
+	__le32 domain_id;
+	__le32 voltage_level;
+};
+
 struct voltage_info {
 	unsigned int version;
 	unsigned int num_domains;
@@ -214,6 +220,7 @@ static int scmi_voltage_descriptors_get(const struct scmi_protocol_handle *ph,
 	resp_dom = td->rx.buf;
 
 	for (dom = 0; dom < vinfo->num_domains; dom++) {
+		u32 attributes;
 		struct scmi_voltage_info *v;
 
 		/* Retrieve domain attributes at first ... */
@@ -225,18 +232,22 @@ static int scmi_voltage_descriptors_get(const struct scmi_protocol_handle *ph,
 
 		v = vinfo->domains + dom;
 		v->id = dom;
-		v->attributes = le32_to_cpu(resp_dom->attr);
+		attributes = le32_to_cpu(resp_dom->attr);
 		strlcpy(v->name, resp_dom->name, SCMI_MAX_STR_SIZE);
 
 		/*
 		 * If supported overwrite short name with the extended one;
 		 * on error just carry on and use already provided short name.
 		 */
-		if (PROTOCOL_REV_MAJOR(vinfo->version) >= 0x2 &&
-		    SUPPORTS_EXTENDED_NAMES(v->attributes))
-			ph->hops->extended_name_get(ph, VOLTAGE_DOMAIN_NAME_GET,
-						    v->id, v->name,
-						    SCMI_MAX_STR_SIZE);
+		if (PROTOCOL_REV_MAJOR(vinfo->version) >= 0x2) {
+			if (SUPPORTS_EXTENDED_NAMES(attributes))
+				ph->hops->extended_name_get(ph,
+							VOLTAGE_DOMAIN_NAME_GET,
+							v->id, v->name,
+							SCMI_MAX_STR_SIZE);
+			if (SUPPORTS_ASYNC_LEVEL_SET(attributes))
+				v->async_level_set = true;
+		}
 
 		ret = scmi_voltage_levels_get(ph, v);
 		/* Skip invalid voltage descriptors */
@@ -308,12 +319,15 @@ static int scmi_voltage_config_get(const struct scmi_protocol_handle *ph,
 }
 
 static int scmi_voltage_level_set(const struct scmi_protocol_handle *ph,
-				  u32 domain_id, u32 flags, s32 volt_uV)
+				  u32 domain_id,
+				  enum scmi_voltage_level_mode mode,
+				  s32 volt_uV)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct voltage_info *vinfo = ph->get_priv(ph);
 	struct scmi_msg_cmd_level_set *cmd;
+	struct scmi_voltage_info *v;
 
 	if (domain_id >= vinfo->num_domains)
 		return -EINVAL;
@@ -323,12 +337,31 @@ static int scmi_voltage_level_set(const struct scmi_protocol_handle *ph,
 	if (ret)
 		return ret;
 
+	v = vinfo->domains + domain_id;
+
 	cmd = t->tx.buf;
 	cmd->domain_id = cpu_to_le32(domain_id);
-	cmd->flags = cpu_to_le32(flags);
 	cmd->voltage_level = cpu_to_le32(volt_uV);
 
-	ret = ph->xops->do_xfer(ph, t);
+	if (!v->async_level_set || mode != SCMI_VOLTAGE_LEVEL_SET_AUTO) {
+		cmd->flags = cpu_to_le32(0x0);
+		ret = ph->xops->do_xfer(ph, t);
+	} else {
+		cmd->flags = cpu_to_le32(0x1);
+		ret = ph->xops->do_xfer_with_response(ph, t);
+		if (!ret) {
+			struct scmi_resp_voltage_level_set_complete *resp;
+
+			resp = t->rx.buf;
+			if (le32_to_cpu(resp->domain_id) == domain_id)
+				dev_dbg(ph->dev,
+					"Voltage domain %d set async to %d\n",
+					v->id,
+					le32_to_cpu(resp->voltage_level));
+			else
+				ret = -EPROTO;
+		}
+	}
 
 	ph->xops->xfer_put(ph, t);
 	return ret;
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 0e20acc80d50..1c58646ba381 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -495,6 +495,11 @@ struct scmi_reset_proto_ops {
 	int (*deassert)(const struct scmi_protocol_handle *ph, u32 domain);
 };
 
+enum scmi_voltage_level_mode {
+	SCMI_VOLTAGE_LEVEL_SET_AUTO,
+	SCMI_VOLTAGE_LEVEL_SET_SYNC,
+};
+
 /**
  * struct scmi_voltage_info - describe one available SCMI Voltage Domain
  *
@@ -507,7 +512,8 @@ struct scmi_reset_proto_ops {
  *	         supported voltage level
  * @negative_volts_allowed: True if any of the entries of @levels_uv represent
  *			    a negative voltage.
- * @attributes: represents Voltage Domain advertised attributes
+ * @async_level_set: True when the voltage domain supports asynchronous level
+ *		     set commands.
  * @name: name assigned to the Voltage Domain by platform
  * @num_levels: number of total entries in @levels_uv.
  * @levels_uv: array of entries describing the available voltage levels for
@@ -517,7 +523,7 @@ struct scmi_voltage_info {
 	unsigned int id;
 	bool segmented;
 	bool negative_volts_allowed;
-	unsigned int attributes;
+	bool async_level_set;
 	char name[SCMI_MAX_STR_SIZE];
 	unsigned int num_levels;
 #define SCMI_VOLTAGE_SEGMENT_LOW	0
@@ -548,7 +554,7 @@ struct scmi_voltage_proto_ops {
 	int (*config_get)(const struct scmi_protocol_handle *ph, u32 domain_id,
 			  u32 *config);
 	int (*level_set)(const struct scmi_protocol_handle *ph, u32 domain_id,
-			 u32 flags, s32 volt_uV);
+			 enum scmi_voltage_level_mode mode, s32 volt_uV);
 	int (*level_get)(const struct scmi_protocol_handle *ph, u32 domain_id,
 			 s32 *volt_uV);
 };
-- 
2.32.0

