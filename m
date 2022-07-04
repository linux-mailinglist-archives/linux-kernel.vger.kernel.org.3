Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A348A565229
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbiGDKYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbiGDKXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:23:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3936EDECC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:23:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38846150C;
        Mon,  4 Jul 2022 03:23:12 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07DE83F792;
        Mon,  4 Jul 2022 03:23:09 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        daniel.lezcano@linaro.org, tarek.el-sherbiny@arm.com,
        adrian.slatineanu@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v4 4/7] firmware: arm_scmi: Add SCMIv3.1 Powercap FastChannels support
Date:   Mon,  4 Jul 2022 11:22:38 +0100
Message-Id: <20220704102241.2988447-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220704102241.2988447-1-cristian.marussi@arm.com>
References: <20220704102241.2988447-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SCMIv3.1 Powercap protocol FastChannel support using common helpers
provided by the SCMI core with scmi_proto_helpers_ops operations.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/powercap.c | 169 +++++++++++++++++++++------
 include/linux/scmi_protocol.h        |   2 +
 2 files changed, 138 insertions(+), 33 deletions(-)

diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
index d71a1f6c2d8a..10b77c3401b5 100644
--- a/drivers/firmware/arm_scmi/powercap.c
+++ b/drivers/firmware/arm_scmi/powercap.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) "SCMI Notifications POWERCAP - " fmt
 
 #include <linux/bitfield.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/scmi_protocol.h>
 
@@ -27,6 +28,12 @@ enum scmi_powercap_protocol_cmd {
 	POWERCAP_DESCRIBE_FASTCHANNEL = 0xc,
 };
 
+enum {
+	POWERCAP_FC_CAP,
+	POWERCAP_FC_PAI,
+	POWERCAP_FC_MAX,
+};
+
 struct scmi_msg_resp_powercap_domain_attributes {
 	__le32 attributes;
 #define SUPPORTS_POWERCAP_CAP_CHANGE_NOTIFY(x)		((x) & BIT(31))
@@ -36,6 +43,7 @@ struct scmi_msg_resp_powercap_domain_attributes {
 #define SUPPORTS_POWERCAP_CAP_CONFIGURATION(x)		((x) & BIT(27))
 #define SUPPORTS_POWERCAP_MONITORING(x)			((x) & BIT(26))
 #define SUPPORTS_POWERCAP_PAI_CONFIGURATION(x)		((x) & BIT(25))
+#define SUPPORTS_POWERCAP_FASTCHANNELS(x)		((x) & BIT(22))
 #define POWERCAP_POWER_UNIT(x)				\
 		(FIELD_GET(GENMASK(24, 23), (x)))
 #define	SUPPORTS_POWER_UNITS_MW(x)			\
@@ -201,6 +209,8 @@ scmi_powercap_domain_attributes_get(const struct scmi_protocol_handle *ph,
 			SUPPORTS_POWER_UNITS_MW(flags);
 		dom_info->powercap_scale_uw =
 			SUPPORTS_POWER_UNITS_UW(flags);
+		dom_info->fastchannels =
+			SUPPORTS_POWERCAP_FASTCHANNELS(flags);
 
 		strscpy(dom_info->name, resp->name, SCMI_SHORT_NAME_MAX_SIZE);
 
@@ -280,15 +290,11 @@ scmi_powercap_dom_info_get(const struct scmi_protocol_handle *ph, u32 domain_id)
 	return pi->powercaps + domain_id;
 }
 
-static int scmi_powercap_cap_get(const struct scmi_protocol_handle *ph,
-				 u32 domain_id, u32 *power_cap)
+static int scmi_powercap_xfer_cap_get(const struct scmi_protocol_handle *ph,
+				      u32 domain_id, u32 *power_cap)
 {
 	int ret;
 	struct scmi_xfer *t;
-	struct powercap_info *pi = ph->get_priv(ph);
-
-	if (!power_cap || domain_id >= pi->num_domains)
-		return -EINVAL;
 
 	ret = ph->xops->xfer_get_init(ph, POWERCAP_CAP_GET, sizeof(u32),
 				      sizeof(u32), &t);
@@ -305,20 +311,31 @@ static int scmi_powercap_cap_get(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-static int scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
-				 u32 domain_id, u32 power_cap,
-				 bool ignore_dresp)
+static int scmi_powercap_cap_get(const struct scmi_protocol_handle *ph,
+				 u32 domain_id, u32 *power_cap)
+{
+	struct scmi_powercap_info *dom;
+	struct powercap_info *pi = ph->get_priv(ph);
+
+	if (!power_cap || domain_id >= pi->num_domains)
+		return -EINVAL;
+
+	dom = pi->powercaps + domain_id;
+	if (dom->fc_info && dom->fc_info[POWERCAP_FC_CAP].get_addr) {
+		*power_cap = ioread32(dom->fc_info[POWERCAP_FC_CAP].get_addr);
+		return 0;
+	}
+
+	return scmi_powercap_xfer_cap_get(ph, domain_id, power_cap);
+}
+
+static int scmi_powercap_xfer_cap_set(const struct scmi_protocol_handle *ph,
+				      const struct scmi_powercap_info *pc,
+				      u32 power_cap, bool ignore_dresp)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_powercap_set_cap_or_pai *msg;
-	const struct scmi_powercap_info *pc;
-
-	pc = scmi_powercap_dom_info_get(ph, domain_id);
-	if (!pc || !pc->powercap_cap_config || !power_cap ||
-	    power_cap < pc->min_power_cap ||
-	    power_cap > pc->max_power_cap)
-		return -EINVAL;
 
 	ret = ph->xops->xfer_get_init(ph, POWERCAP_CAP_SET,
 				      sizeof(*msg), 0, &t);
@@ -326,7 +343,7 @@ static int scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
 		return ret;
 
 	msg = t->tx.buf;
-	msg->domain = cpu_to_le32(domain_id);
+	msg->domain = cpu_to_le32(pc->id);
 	msg->flags =
 		cpu_to_le32(FIELD_PREP(CAP_SET_ASYNC, !!pc->async_powercap_cap_set) |
 			    FIELD_PREP(CAP_SET_IGNORE_DRESP, !!ignore_dresp));
@@ -340,10 +357,10 @@ static int scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
 			struct scmi_msg_resp_powercap_cap_set_complete *resp;
 
 			resp = t->rx.buf;
-			if (le32_to_cpu(resp->domain) == domain_id)
+			if (le32_to_cpu(resp->domain) == pc->id)
 				dev_dbg(ph->dev,
 					"Powercap ID %d CAP set async to %u\n",
-					domain_id,
+					pc->id,
 					get_unaligned_le32(&resp->power_cap));
 			else
 				ret = -EPROTO;
@@ -354,16 +371,35 @@ static int scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-static int scmi_powercap_pai_get(const struct scmi_protocol_handle *ph,
-				 u32 domain_id, u32 *pai)
+static int scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
+				 u32 domain_id, u32 power_cap,
+				 bool ignore_dresp)
 {
-	int ret;
-	struct scmi_xfer *t;
-	struct powercap_info *pi = ph->get_priv(ph);
+	const struct scmi_powercap_info *pc;
 
-	if (!pai || domain_id >= pi->num_domains)
+	pc = scmi_powercap_dom_info_get(ph, domain_id);
+	if (!pc || !pc->powercap_cap_config || !power_cap ||
+	    power_cap < pc->min_power_cap ||
+	    power_cap > pc->max_power_cap)
 		return -EINVAL;
 
+	if (pc->fc_info && pc->fc_info[POWERCAP_FC_CAP].set_addr) {
+		struct scmi_fc_info *fci = &pc->fc_info[POWERCAP_FC_CAP];
+
+		iowrite32(power_cap, fci->set_addr);
+		ph->hops->fastchannel_db_ring(fci->set_db);
+		return 0;
+	}
+
+	return scmi_powercap_xfer_cap_set(ph, pc, power_cap, ignore_dresp);
+}
+
+static int scmi_powercap_xfer_pai_get(const struct scmi_protocol_handle *ph,
+				      u32 domain_id, u32 *pai)
+{
+	int ret;
+	struct scmi_xfer *t;
+
 	ret = ph->xops->xfer_get_init(ph, POWERCAP_PAI_GET, sizeof(u32),
 				      sizeof(u32), &t);
 	if (ret)
@@ -379,18 +415,30 @@ static int scmi_powercap_pai_get(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-static int scmi_powercap_pai_set(const struct scmi_protocol_handle *ph,
-				 u32 domain_id, u32 pai)
+static int scmi_powercap_pai_get(const struct scmi_protocol_handle *ph,
+				 u32 domain_id, u32 *pai)
+{
+	struct scmi_powercap_info *dom;
+	struct powercap_info *pi = ph->get_priv(ph);
+
+	if (!pai || domain_id >= pi->num_domains)
+		return -EINVAL;
+
+	dom = pi->powercaps + domain_id;
+	if (dom->fc_info && dom->fc_info[POWERCAP_FC_PAI].get_addr) {
+		*pai = ioread32(dom->fc_info[POWERCAP_FC_PAI].get_addr);
+		return 0;
+	}
+
+	return scmi_powercap_xfer_pai_get(ph, domain_id, pai);
+}
+
+static int scmi_powercap_xfer_pai_set(const struct scmi_protocol_handle *ph,
+				      u32 domain_id, u32 pai)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_powercap_set_cap_or_pai *msg;
-	const struct scmi_powercap_info *pc;
-
-	pc = scmi_powercap_dom_info_get(ph, domain_id);
-	if (!pc || !pc->powercap_pai_config || !pai ||
-	    pai < pc->min_pai || pai > pc->max_pai)
-		return -EINVAL;
 
 	ret = ph->xops->xfer_get_init(ph, POWERCAP_PAI_SET,
 				      sizeof(*msg), 0, &t);
@@ -408,6 +456,27 @@ static int scmi_powercap_pai_set(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
+static int scmi_powercap_pai_set(const struct scmi_protocol_handle *ph,
+				 u32 domain_id, u32 pai)
+{
+	const struct scmi_powercap_info *pc;
+
+	pc = scmi_powercap_dom_info_get(ph, domain_id);
+	if (!pc || !pc->powercap_pai_config || !pai ||
+	    pai < pc->min_pai || pai > pc->max_pai)
+		return -EINVAL;
+
+	if (pc->fc_info && pc->fc_info[POWERCAP_FC_PAI].set_addr) {
+		struct scmi_fc_info *fci = &pc->fc_info[POWERCAP_FC_PAI];
+
+		iowrite32(pai, fci->set_addr);
+		ph->hops->fastchannel_db_ring(fci->set_db);
+		return 0;
+	}
+
+	return scmi_powercap_xfer_pai_set(ph, domain_id, pai);
+}
+
 static int scmi_powercap_measurements_get(const struct scmi_protocol_handle *ph,
 					  u32 domain_id, u32 *average_power,
 					  u32 *pai)
@@ -497,6 +566,36 @@ static const struct scmi_powercap_proto_ops powercap_proto_ops = {
 	.measurements_threshold_get = scmi_powercap_measurements_threshold_get,
 };
 
+static void scmi_powercap_domain_init_fc(const struct scmi_protocol_handle *ph,
+					 u32 domain, struct scmi_fc_info **p_fc)
+{
+	struct scmi_fc_info *fc;
+
+	fc = devm_kcalloc(ph->dev, POWERCAP_FC_MAX, sizeof(*fc), GFP_KERNEL);
+	if (!fc)
+		return;
+
+	ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
+				   POWERCAP_CAP_SET, 4, domain,
+				   &fc[POWERCAP_FC_CAP].set_addr,
+				   &fc[POWERCAP_FC_CAP].set_db);
+
+	ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
+				   POWERCAP_CAP_GET, 4, domain,
+				   &fc[POWERCAP_FC_CAP].get_addr, NULL);
+
+	ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
+				   POWERCAP_PAI_SET, 4, domain,
+				   &fc[POWERCAP_FC_PAI].set_addr,
+				   &fc[POWERCAP_FC_PAI].set_db);
+
+	ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
+				   POWERCAP_PAI_GET, 4, domain,
+				   &fc[POWERCAP_FC_PAI].get_addr, NULL);
+
+	*p_fc = fc;
+}
+
 static int scmi_powercap_notify(const struct scmi_protocol_handle *ph,
 				u32 domain, int message_id, bool enable)
 {
@@ -730,6 +829,10 @@ scmi_powercap_protocol_init(const struct scmi_protocol_handle *ph)
 		ret = scmi_powercap_domain_attributes_get(ph, pinfo, domain);
 		if (ret)
 			return ret;
+
+		if (pinfo->powercaps[domain].fastchannels)
+			scmi_powercap_domain_init_fc(ph, domain,
+						     &pinfo->powercaps[domain].fc_info);
 	}
 
 	pinfo->states = devm_kcalloc(ph->dev, pinfo->num_domains,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index f709c74030f4..ad9641dbdd25 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -601,6 +601,7 @@ struct scmi_powercap_info {
 	bool powercap_pai_config;
 	bool powercap_scale_mw;
 	bool powercap_scale_uw;
+	bool fastchannels;
 	char name[SCMI_MAX_STR_SIZE];
 	unsigned int min_pai;
 	unsigned int max_pai;
@@ -612,6 +613,7 @@ struct scmi_powercap_info {
 	unsigned int accuracy;
 #define SCMI_POWERCAP_ROOT_ZONE_ID     0xFFFFFFFFUL
 	unsigned int parent_id;
+	struct scmi_fc_info *fc_info;
 };
 
 /**
-- 
2.32.0

