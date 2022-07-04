Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFB656522C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiGDKYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbiGDKXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:23:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA2003BC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:23:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 000B71480;
        Mon,  4 Jul 2022 03:23:07 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CA1D3F792;
        Mon,  4 Jul 2022 03:23:05 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        daniel.lezcano@linaro.org, tarek.el-sherbiny@arm.com,
        adrian.slatineanu@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v4 2/7] firmware: arm_scmi: Add SCMIv3.1 Powercap protocol basic support
Date:   Mon,  4 Jul 2022 11:22:36 +0100
Message-Id: <20220704102241.2988447-3-cristian.marussi@arm.com>
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

Add support for SCMIv3.1 Powercap protocol, with the exception of Powercap
FastChannels, exposing all the new related Powercap protocol operations as
usual in include/linux/scmi_protocol.h.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v3 --> v4
- fix GENMASK usage on 32 bit systems

v2 --> v3
- use strscpy

v1 --> v2:
- fixed measurements thresholds updates to trigger notification
  enable update commands
- added a bit more comments
- using bitfield macros
---
 drivers/firmware/arm_scmi/Makefile    |   2 +-
 drivers/firmware/arm_scmi/driver.c    |   2 +
 drivers/firmware/arm_scmi/powercap.c  | 753 ++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h |   1 +
 include/linux/scmi_protocol.h         | 125 +++++
 5 files changed, 882 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/arm_scmi/powercap.c

diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 8d4afadda38c..a02dc8ce5a7f 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -7,7 +7,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += smc.o
 scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
-scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o
+scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
 scmi-module-objs := $(scmi-bus-y) $(scmi-driver-y) $(scmi-protocols-y) \
 		    $(scmi-transport-y)
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 8b7ac6663d57..6ba1faaf5422 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2401,6 +2401,7 @@ static int __init scmi_driver_init(void)
 	scmi_sensors_register();
 	scmi_voltage_register();
 	scmi_system_register();
+	scmi_powercap_register();
 
 	return platform_driver_register(&scmi_driver);
 }
@@ -2417,6 +2418,7 @@ static void __exit scmi_driver_exit(void)
 	scmi_sensors_unregister();
 	scmi_voltage_unregister();
 	scmi_system_unregister();
+	scmi_powercap_unregister();
 
 	scmi_bus_exit();
 
diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
new file mode 100644
index 000000000000..d71a1f6c2d8a
--- /dev/null
+++ b/drivers/firmware/arm_scmi/powercap.c
@@ -0,0 +1,753 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Management Interface (SCMI) Powercap Protocol
+ *
+ * Copyright (C) 2022 ARM Ltd.
+ */
+
+#define pr_fmt(fmt) "SCMI Notifications POWERCAP - " fmt
+
+#include <linux/bitfield.h>
+#include <linux/module.h>
+#include <linux/scmi_protocol.h>
+
+#include "protocols.h"
+#include "notify.h"
+
+enum scmi_powercap_protocol_cmd {
+	POWERCAP_DOMAIN_ATTRIBUTES = 0x3,
+	POWERCAP_CAP_GET = 0x4,
+	POWERCAP_CAP_SET = 0x5,
+	POWERCAP_PAI_GET = 0x6,
+	POWERCAP_PAI_SET = 0x7,
+	POWERCAP_DOMAIN_NAME_GET = 0x8,
+	POWERCAP_MEASUREMENTS_GET = 0x9,
+	POWERCAP_CAP_NOTIFY = 0xa,
+	POWERCAP_MEASUREMENTS_NOTIFY = 0xb,
+	POWERCAP_DESCRIBE_FASTCHANNEL = 0xc,
+};
+
+struct scmi_msg_resp_powercap_domain_attributes {
+	__le32 attributes;
+#define SUPPORTS_POWERCAP_CAP_CHANGE_NOTIFY(x)		((x) & BIT(31))
+#define SUPPORTS_POWERCAP_MEASUREMENTS_CHANGE_NOTIFY(x)	((x) & BIT(30))
+#define SUPPORTS_ASYNC_POWERCAP_CAP_SET(x)		((x) & BIT(29))
+#define SUPPORTS_EXTENDED_NAMES(x)			((x) & BIT(28))
+#define SUPPORTS_POWERCAP_CAP_CONFIGURATION(x)		((x) & BIT(27))
+#define SUPPORTS_POWERCAP_MONITORING(x)			((x) & BIT(26))
+#define SUPPORTS_POWERCAP_PAI_CONFIGURATION(x)		((x) & BIT(25))
+#define POWERCAP_POWER_UNIT(x)				\
+		(FIELD_GET(GENMASK(24, 23), (x)))
+#define	SUPPORTS_POWER_UNITS_MW(x)			\
+		(POWERCAP_POWER_UNIT(x) == 0x2)
+#define	SUPPORTS_POWER_UNITS_UW(x)			\
+		(POWERCAP_POWER_UNIT(x) == 0x1)
+	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
+	__le32 min_pai;
+	__le32 max_pai;
+	__le32 pai_step;
+	__le32 min_power_cap;
+	__le32 max_power_cap;
+	__le32 power_cap_step;
+	__le32 sustainable_power;
+	__le32 accuracy;
+	__le32 parent_id;
+};
+
+struct scmi_msg_powercap_set_cap_or_pai {
+	__le32 domain;
+	__le32 flags;
+#define CAP_SET_ASYNC		BIT(1)
+#define CAP_SET_IGNORE_DRESP	BIT(0)
+	__le32 value;
+};
+
+struct scmi_msg_resp_powercap_cap_set_complete {
+	__le32 domain;
+	__le32 power_cap;
+};
+
+struct scmi_msg_resp_powercap_meas_get {
+	__le32 power;
+	__le32 pai;
+};
+
+struct scmi_msg_powercap_notify_cap {
+	__le32 domain;
+	__le32 notify_enable;
+};
+
+struct scmi_msg_powercap_notify_thresh {
+	__le32 domain;
+	__le32 notify_enable;
+	__le32 power_thresh_low;
+	__le32 power_thresh_high;
+};
+
+struct scmi_powercap_cap_changed_notify_payld {
+	__le32 agent_id;
+	__le32 domain_id;
+	__le32 power_cap;
+	__le32 pai;
+};
+
+struct scmi_powercap_meas_changed_notify_payld {
+	__le32 agent_id;
+	__le32 domain_id;
+	__le32 power;
+};
+
+struct scmi_powercap_state {
+	bool meas_notif_enabled;
+	u64 thresholds;
+#define THRESH_LOW(p, id)				\
+	(lower_32_bits((p)->states[(id)].thresholds))
+#define THRESH_HIGH(p, id)				\
+	(upper_32_bits((p)->states[(id)].thresholds))
+};
+
+struct powercap_info {
+	u32 version;
+	int num_domains;
+	struct scmi_powercap_state *states;
+	struct scmi_powercap_info *powercaps;
+};
+
+static enum scmi_powercap_protocol_cmd evt_2_cmd[] = {
+	POWERCAP_CAP_NOTIFY,
+	POWERCAP_MEASUREMENTS_NOTIFY,
+};
+
+static int scmi_powercap_notify(const struct scmi_protocol_handle *ph,
+				u32 domain, int message_id, bool enable);
+
+static int
+scmi_powercap_attributes_get(const struct scmi_protocol_handle *ph,
+			     struct powercap_info *pi)
+{
+	int ret;
+	struct scmi_xfer *t;
+
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0,
+				      sizeof(u32), &t);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		u32 attributes;
+
+		attributes = get_unaligned_le32(t->rx.buf);
+		pi->num_domains = FIELD_GET(GENMASK(15, 0), attributes);
+	}
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
+static inline int
+scmi_powercap_validate(unsigned int min_val, unsigned int max_val,
+		       unsigned int step_val, bool configurable)
+{
+	if (!min_val || !max_val)
+		return -EPROTO;
+
+	if ((configurable && min_val == max_val) ||
+	    (!configurable && min_val != max_val))
+		return -EPROTO;
+
+	if (min_val != max_val && !step_val)
+		return -EPROTO;
+
+	return 0;
+}
+
+static int
+scmi_powercap_domain_attributes_get(const struct scmi_protocol_handle *ph,
+				    struct powercap_info *pinfo, u32 domain)
+{
+	int ret;
+	u32 flags;
+	struct scmi_xfer *t;
+	struct scmi_powercap_info *dom_info = pinfo->powercaps + domain;
+	struct scmi_msg_resp_powercap_domain_attributes *resp;
+
+	ret = ph->xops->xfer_get_init(ph, POWERCAP_DOMAIN_ATTRIBUTES,
+				      sizeof(domain), sizeof(*resp), &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(domain, t->tx.buf);
+	resp = t->rx.buf;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		flags = le32_to_cpu(resp->attributes);
+
+		dom_info->id = domain;
+		dom_info->notify_powercap_cap_change =
+			SUPPORTS_POWERCAP_CAP_CHANGE_NOTIFY(flags);
+		dom_info->notify_powercap_measurement_change =
+			SUPPORTS_POWERCAP_MEASUREMENTS_CHANGE_NOTIFY(flags);
+		dom_info->async_powercap_cap_set =
+			SUPPORTS_ASYNC_POWERCAP_CAP_SET(flags);
+		dom_info->powercap_cap_config =
+			SUPPORTS_POWERCAP_CAP_CONFIGURATION(flags);
+		dom_info->powercap_monitoring =
+			SUPPORTS_POWERCAP_MONITORING(flags);
+		dom_info->powercap_pai_config =
+			SUPPORTS_POWERCAP_PAI_CONFIGURATION(flags);
+		dom_info->powercap_scale_mw =
+			SUPPORTS_POWER_UNITS_MW(flags);
+		dom_info->powercap_scale_uw =
+			SUPPORTS_POWER_UNITS_UW(flags);
+
+		strscpy(dom_info->name, resp->name, SCMI_SHORT_NAME_MAX_SIZE);
+
+		dom_info->min_pai = le32_to_cpu(resp->min_pai);
+		dom_info->max_pai = le32_to_cpu(resp->max_pai);
+		dom_info->pai_step = le32_to_cpu(resp->pai_step);
+		ret = scmi_powercap_validate(dom_info->min_pai,
+					     dom_info->max_pai,
+					     dom_info->pai_step,
+					     dom_info->powercap_pai_config);
+		if (ret) {
+			dev_err(ph->dev,
+				"Platform reported inconsistent PAI config for domain %d - %s\n",
+				dom_info->id, dom_info->name);
+			goto clean;
+		}
+
+		dom_info->min_power_cap = le32_to_cpu(resp->min_power_cap);
+		dom_info->max_power_cap = le32_to_cpu(resp->max_power_cap);
+		dom_info->power_cap_step = le32_to_cpu(resp->power_cap_step);
+		ret = scmi_powercap_validate(dom_info->min_power_cap,
+					     dom_info->max_power_cap,
+					     dom_info->power_cap_step,
+					     dom_info->powercap_cap_config);
+		if (ret) {
+			dev_err(ph->dev,
+				"Platform reported inconsistent CAP config for domain %d - %s\n",
+				dom_info->id, dom_info->name);
+			goto clean;
+		}
+
+		dom_info->sustainable_power =
+			le32_to_cpu(resp->sustainable_power);
+		dom_info->accuracy = le32_to_cpu(resp->accuracy);
+
+		dom_info->parent_id = le32_to_cpu(resp->parent_id);
+		if (dom_info->parent_id != SCMI_POWERCAP_ROOT_ZONE_ID &&
+		    (dom_info->parent_id >= pinfo->num_domains ||
+		     dom_info->parent_id == dom_info->id)) {
+			dev_err(ph->dev,
+				"Platform reported inconsistent parent ID for domain %d - %s\n",
+				dom_info->id, dom_info->name);
+			ret = -ENODEV;
+		}
+	}
+
+clean:
+	ph->xops->xfer_put(ph, t);
+
+	/*
+	 * If supported overwrite short name with the extended one;
+	 * on error just carry on and use already provided short name.
+	 */
+	if (!ret && SUPPORTS_EXTENDED_NAMES(flags))
+		ph->hops->extended_name_get(ph, POWERCAP_DOMAIN_NAME_GET,
+					    domain, dom_info->name,
+					    SCMI_MAX_STR_SIZE);
+
+	return ret;
+}
+
+static int scmi_powercap_num_domains_get(const struct scmi_protocol_handle *ph)
+{
+	struct powercap_info *pi = ph->get_priv(ph);
+
+	return pi->num_domains;
+}
+
+static const struct scmi_powercap_info *
+scmi_powercap_dom_info_get(const struct scmi_protocol_handle *ph, u32 domain_id)
+{
+	struct powercap_info *pi = ph->get_priv(ph);
+
+	if (domain_id >= pi->num_domains)
+		return NULL;
+
+	return pi->powercaps + domain_id;
+}
+
+static int scmi_powercap_cap_get(const struct scmi_protocol_handle *ph,
+				 u32 domain_id, u32 *power_cap)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct powercap_info *pi = ph->get_priv(ph);
+
+	if (!power_cap || domain_id >= pi->num_domains)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, POWERCAP_CAP_GET, sizeof(u32),
+				      sizeof(u32), &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(domain_id, t->tx.buf);
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret)
+		*power_cap = get_unaligned_le32(t->rx.buf);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
+				 u32 domain_id, u32 power_cap,
+				 bool ignore_dresp)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_powercap_set_cap_or_pai *msg;
+	const struct scmi_powercap_info *pc;
+
+	pc = scmi_powercap_dom_info_get(ph, domain_id);
+	if (!pc || !pc->powercap_cap_config || !power_cap ||
+	    power_cap < pc->min_power_cap ||
+	    power_cap > pc->max_power_cap)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, POWERCAP_CAP_SET,
+				      sizeof(*msg), 0, &t);
+	if (ret)
+		return ret;
+
+	msg = t->tx.buf;
+	msg->domain = cpu_to_le32(domain_id);
+	msg->flags =
+		cpu_to_le32(FIELD_PREP(CAP_SET_ASYNC, !!pc->async_powercap_cap_set) |
+			    FIELD_PREP(CAP_SET_IGNORE_DRESP, !!ignore_dresp));
+	msg->value = cpu_to_le32(power_cap);
+
+	if (!pc->async_powercap_cap_set || ignore_dresp) {
+		ret = ph->xops->do_xfer(ph, t);
+	} else {
+		ret = ph->xops->do_xfer_with_response(ph, t);
+		if (!ret) {
+			struct scmi_msg_resp_powercap_cap_set_complete *resp;
+
+			resp = t->rx.buf;
+			if (le32_to_cpu(resp->domain) == domain_id)
+				dev_dbg(ph->dev,
+					"Powercap ID %d CAP set async to %u\n",
+					domain_id,
+					get_unaligned_le32(&resp->power_cap));
+			else
+				ret = -EPROTO;
+		}
+	}
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
+static int scmi_powercap_pai_get(const struct scmi_protocol_handle *ph,
+				 u32 domain_id, u32 *pai)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct powercap_info *pi = ph->get_priv(ph);
+
+	if (!pai || domain_id >= pi->num_domains)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, POWERCAP_PAI_GET, sizeof(u32),
+				      sizeof(u32), &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(domain_id, t->tx.buf);
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret)
+		*pai = get_unaligned_le32(t->rx.buf);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_powercap_pai_set(const struct scmi_protocol_handle *ph,
+				 u32 domain_id, u32 pai)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_powercap_set_cap_or_pai *msg;
+	const struct scmi_powercap_info *pc;
+
+	pc = scmi_powercap_dom_info_get(ph, domain_id);
+	if (!pc || !pc->powercap_pai_config || !pai ||
+	    pai < pc->min_pai || pai > pc->max_pai)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, POWERCAP_PAI_SET,
+				      sizeof(*msg), 0, &t);
+	if (ret)
+		return ret;
+
+	msg = t->tx.buf;
+	msg->domain = cpu_to_le32(domain_id);
+	msg->flags = cpu_to_le32(0);
+	msg->value = cpu_to_le32(pai);
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
+static int scmi_powercap_measurements_get(const struct scmi_protocol_handle *ph,
+					  u32 domain_id, u32 *average_power,
+					  u32 *pai)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_resp_powercap_meas_get *resp;
+	const struct scmi_powercap_info *pc;
+
+	pc = scmi_powercap_dom_info_get(ph, domain_id);
+	if (!pc || !pc->powercap_monitoring || !pai || !average_power)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, POWERCAP_MEASUREMENTS_GET,
+				      sizeof(u32), sizeof(*resp), &t);
+	if (ret)
+		return ret;
+
+	resp = t->rx.buf;
+	put_unaligned_le32(domain_id, t->tx.buf);
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		*average_power = le32_to_cpu(resp->power);
+		*pai = le32_to_cpu(resp->pai);
+	}
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
+static int
+scmi_powercap_measurements_threshold_get(const struct scmi_protocol_handle *ph,
+					 u32 domain_id, u32 *power_thresh_low,
+					 u32 *power_thresh_high)
+{
+	struct powercap_info *pi = ph->get_priv(ph);
+
+	if (!power_thresh_low || !power_thresh_high ||
+	    domain_id >= pi->num_domains)
+		return -EINVAL;
+
+	*power_thresh_low =  THRESH_LOW(pi, domain_id);
+	*power_thresh_high = THRESH_HIGH(pi, domain_id);
+
+	return 0;
+}
+
+static int
+scmi_powercap_measurements_threshold_set(const struct scmi_protocol_handle *ph,
+					 u32 domain_id, u32 power_thresh_low,
+					 u32 power_thresh_high)
+{
+	int ret = 0;
+	struct powercap_info *pi = ph->get_priv(ph);
+
+	if (domain_id >= pi->num_domains ||
+	    power_thresh_low > power_thresh_high)
+		return -EINVAL;
+
+	/* Anything to do ? */
+	if (THRESH_LOW(pi, domain_id) == power_thresh_low &&
+	    THRESH_HIGH(pi, domain_id) == power_thresh_high)
+		return ret;
+
+	pi->states[domain_id].thresholds =
+		(FIELD_PREP(GENMASK_ULL(31, 0), power_thresh_low) |
+		 FIELD_PREP(GENMASK_ULL(63, 32), power_thresh_high));
+
+	/* Update thresholds if notification already enabled */
+	if (pi->states[domain_id].meas_notif_enabled)
+		ret = scmi_powercap_notify(ph, domain_id,
+					   POWERCAP_MEASUREMENTS_NOTIFY,
+					   true);
+
+	return ret;
+}
+
+static const struct scmi_powercap_proto_ops powercap_proto_ops = {
+	.num_domains_get = scmi_powercap_num_domains_get,
+	.info_get = scmi_powercap_dom_info_get,
+	.cap_get = scmi_powercap_cap_get,
+	.cap_set = scmi_powercap_cap_set,
+	.pai_get = scmi_powercap_pai_get,
+	.pai_set = scmi_powercap_pai_set,
+	.measurements_get = scmi_powercap_measurements_get,
+	.measurements_threshold_set = scmi_powercap_measurements_threshold_set,
+	.measurements_threshold_get = scmi_powercap_measurements_threshold_get,
+};
+
+static int scmi_powercap_notify(const struct scmi_protocol_handle *ph,
+				u32 domain, int message_id, bool enable)
+{
+	int ret;
+	struct scmi_xfer *t;
+
+	switch (message_id) {
+	case POWERCAP_CAP_NOTIFY:
+	{
+		struct scmi_msg_powercap_notify_cap *notify;
+
+		ret = ph->xops->xfer_get_init(ph, message_id,
+					      sizeof(*notify), 0, &t);
+		if (ret)
+			return ret;
+
+		notify = t->tx.buf;
+		notify->domain = cpu_to_le32(domain);
+		notify->notify_enable = cpu_to_le32(enable ? BIT(0) : 0);
+		break;
+	}
+	case POWERCAP_MEASUREMENTS_NOTIFY:
+	{
+		u32 low, high;
+		struct scmi_msg_powercap_notify_thresh *notify;
+
+		/*
+		 * Note that we have to pick the most recently configured
+		 * thresholds to build a proper POWERCAP_MEASUREMENTS_NOTIFY
+		 * enable request and we fail, complaining, if no thresholds
+		 * were ever set, since this is an indication the API has been
+		 * used wrongly.
+		 */
+		ret = scmi_powercap_measurements_threshold_get(ph, domain,
+							       &low, &high);
+		if (ret)
+			return ret;
+
+		if (enable && !low && !high) {
+			dev_err(ph->dev,
+				"Invalid Measurements Notify thresholds: %u/%u\n",
+				low, high);
+			return -EINVAL;
+		}
+
+		ret = ph->xops->xfer_get_init(ph, message_id,
+					      sizeof(*notify), 0, &t);
+		if (ret)
+			return ret;
+
+		notify = t->tx.buf;
+		notify->domain = cpu_to_le32(domain);
+		notify->notify_enable = cpu_to_le32(enable ? BIT(0) : 0);
+		notify->power_thresh_low = cpu_to_le32(low);
+		notify->power_thresh_high = cpu_to_le32(high);
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
+static int
+scmi_powercap_set_notify_enabled(const struct scmi_protocol_handle *ph,
+				 u8 evt_id, u32 src_id, bool enable)
+{
+	int ret, cmd_id;
+	struct powercap_info *pi = ph->get_priv(ph);
+
+	if (evt_id >= ARRAY_SIZE(evt_2_cmd) || src_id >= pi->num_domains)
+		return -EINVAL;
+
+	cmd_id = evt_2_cmd[evt_id];
+	ret = scmi_powercap_notify(ph, src_id, cmd_id, enable);
+	if (ret)
+		pr_debug("FAIL_ENABLED - evt[%X] dom[%d] - ret:%d\n",
+			 evt_id, src_id, ret);
+	else if (cmd_id == POWERCAP_MEASUREMENTS_NOTIFY)
+		/*
+		 * On success save the current notification enabled state, so
+		 * as to be able to properly update the notification thresholds
+		 * when they are modified on a domain for which measurement
+		 * notifications were currently enabled.
+		 *
+		 * This is needed because the SCMI Notification core machinery
+		 * and API does not support passing per-notification custom
+		 * arguments at callback registration time.
+		 *
+		 * Note that this can be done here with a simple flag since the
+		 * SCMI core Notifications code takes care of keeping proper
+		 * per-domain enables refcounting, so that this helper function
+		 * will be called only once (for enables) when the first user
+		 * registers a callback on this domain and once more (disable)
+		 * when the last user de-registers its callback.
+		 */
+		pi->states[src_id].meas_notif_enabled = enable;
+
+	return ret;
+}
+
+static void *
+scmi_powercap_fill_custom_report(const struct scmi_protocol_handle *ph,
+				 u8 evt_id, ktime_t timestamp,
+				 const void *payld, size_t payld_sz,
+				 void *report, u32 *src_id)
+{
+	void *rep = NULL;
+
+	switch (evt_id) {
+	case SCMI_EVENT_POWERCAP_CAP_CHANGED:
+	{
+		const struct scmi_powercap_cap_changed_notify_payld *p = payld;
+		struct scmi_powercap_cap_changed_report *r = report;
+
+		if (sizeof(*p) != payld_sz)
+			break;
+
+		r->timestamp = timestamp;
+		r->agent_id = le32_to_cpu(p->agent_id);
+		r->domain_id = le32_to_cpu(p->domain_id);
+		r->power_cap = le32_to_cpu(p->power_cap);
+		r->pai = le32_to_cpu(p->pai);
+		*src_id = r->domain_id;
+		rep = r;
+		break;
+	}
+	case SCMI_EVENT_POWERCAP_MEASUREMENTS_CHANGED:
+	{
+		const struct scmi_powercap_meas_changed_notify_payld *p = payld;
+		struct scmi_powercap_meas_changed_report *r = report;
+
+		if (sizeof(*p) != payld_sz)
+			break;
+
+		r->timestamp = timestamp;
+		r->agent_id = le32_to_cpu(p->agent_id);
+		r->domain_id = le32_to_cpu(p->domain_id);
+		r->power = le32_to_cpu(p->power);
+		*src_id = r->domain_id;
+		rep = r;
+		break;
+	}
+	default:
+		break;
+	}
+
+	return rep;
+}
+
+static int
+scmi_powercap_get_num_sources(const struct scmi_protocol_handle *ph)
+{
+	struct powercap_info *pi = ph->get_priv(ph);
+
+	if (!pi)
+		return -EINVAL;
+
+	return pi->num_domains;
+}
+
+static const struct scmi_event powercap_events[] = {
+	{
+		.id = SCMI_EVENT_POWERCAP_CAP_CHANGED,
+		.max_payld_sz =
+			sizeof(struct scmi_powercap_cap_changed_notify_payld),
+		.max_report_sz =
+			sizeof(struct scmi_powercap_cap_changed_report),
+	},
+	{
+		.id = SCMI_EVENT_POWERCAP_MEASUREMENTS_CHANGED,
+		.max_payld_sz =
+			sizeof(struct scmi_powercap_meas_changed_notify_payld),
+		.max_report_sz =
+			sizeof(struct scmi_powercap_meas_changed_report),
+	},
+};
+
+static const struct scmi_event_ops powercap_event_ops = {
+	.get_num_sources = scmi_powercap_get_num_sources,
+	.set_notify_enabled = scmi_powercap_set_notify_enabled,
+	.fill_custom_report = scmi_powercap_fill_custom_report,
+};
+
+static const struct scmi_protocol_events powercap_protocol_events = {
+	.queue_sz = SCMI_PROTO_QUEUE_SZ,
+	.ops = &powercap_event_ops,
+	.evts = powercap_events,
+	.num_events = ARRAY_SIZE(powercap_events),
+};
+
+static int
+scmi_powercap_protocol_init(const struct scmi_protocol_handle *ph)
+{
+	int domain, ret;
+	u32 version;
+	struct powercap_info *pinfo;
+
+	ret = ph->xops->version_get(ph, &version);
+	if (ret)
+		return ret;
+
+	dev_dbg(ph->dev, "Powercap Version %d.%d\n",
+		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	pinfo = devm_kzalloc(ph->dev, sizeof(*pinfo), GFP_KERNEL);
+	if (!pinfo)
+		return -ENOMEM;
+
+	ret = scmi_powercap_attributes_get(ph, pinfo);
+	if (ret)
+		return ret;
+
+	pinfo->powercaps = devm_kcalloc(ph->dev, pinfo->num_domains,
+					sizeof(*pinfo->powercaps),
+					GFP_KERNEL);
+	if (!pinfo->powercaps)
+		return -ENOMEM;
+
+	/*
+	 * Note that any failure in retrieving any domain attribute leads to
+	 * the whole Powercap protocol initialization failure: this way the
+	 * reported Powercap domains are all assured, when accessed, to be well
+	 * formed and correlated by sane parent-child relationship (if any).
+	 */
+	for (domain = 0; domain < pinfo->num_domains; domain++) {
+		ret = scmi_powercap_domain_attributes_get(ph, pinfo, domain);
+		if (ret)
+			return ret;
+	}
+
+	pinfo->states = devm_kcalloc(ph->dev, pinfo->num_domains,
+				     sizeof(*pinfo->states), GFP_KERNEL);
+	if (!pinfo->states)
+		return -ENOMEM;
+
+	pinfo->version = version;
+
+	return ph->set_priv(ph, pinfo);
+}
+
+static const struct scmi_protocol scmi_powercap = {
+	.id = SCMI_PROTOCOL_POWERCAP,
+	.owner = THIS_MODULE,
+	.instance_init = &scmi_powercap_protocol_init,
+	.ops = &powercap_proto_ops,
+	.events = &powercap_protocol_events,
+};
+
+DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(powercap, scmi_powercap)
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index 51c31379f9b3..99d36d503d1e 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -315,5 +315,6 @@ DECLARE_SCMI_REGISTER_UNREGISTER(reset);
 DECLARE_SCMI_REGISTER_UNREGISTER(sensors);
 DECLARE_SCMI_REGISTER_UNREGISTER(voltage);
 DECLARE_SCMI_REGISTER_UNREGISTER(system);
+DECLARE_SCMI_REGISTER_UNREGISTER(powercap);
 
 #endif /* _SCMI_PROTOCOLS_H */
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 704111f63993..f709c74030f4 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -560,6 +560,114 @@ struct scmi_voltage_proto_ops {
 			 s32 *volt_uV);
 };
 
+/**
+ * struct scmi_powercap_info  - Describe one available Powercap domain
+ *
+ * @id: Domain ID as advertised by the platform.
+ * @notify_powercap_cap_change: CAP change notification support.
+ * @notify_powercap_measurement_change: MEASUREMENTS change notifications
+ *				       support.
+ * @async_powercap_cap_set: Asynchronous CAP set support.
+ * @powercap_cap_config: CAP configuration support.
+ * @powercap_monitoring: Monitoring (measurements) support.
+ * @powercap_pai_config: PAI configuration support.
+ * @powercap_scale_mw: Domain reports power data in milliwatt units.
+ * @powercap_scale_uw: Domain reports power data in microwatt units.
+ *		       Note that, when both @powercap_scale_mw and
+ *		       @powercap_scale_uw are set to false, the domain
+ *		       reports power data on an abstract linear scale.
+ * @name: name assigned to the Powercap Domain by platform.
+ * @min_pai: Minimum configurable PAI.
+ * @max_pai: Maximum configurable PAI.
+ * @pai_step: Step size between two consecutive PAI values.
+ * @min_power_cap: Minimum configurable CAP.
+ * @max_power_cap: Maximum configurable CAP.
+ * @power_cap_step: Step size between two consecutive CAP values.
+ * @sustainable_power: Maximum sustainable power consumption for this domain
+ *		       under normal conditions.
+ * @accuracy: The accuracy with which the power is measured and reported in
+ *	      integral multiples of 0.001 percent.
+ * @parent_id: Identifier of the containing parent power capping domain, or the
+ *	       value 0xFFFFFFFF if this powercap domain is a root domain not
+ *	       contained in any other domain.
+ */
+struct scmi_powercap_info {
+	unsigned int id;
+	bool notify_powercap_cap_change;
+	bool notify_powercap_measurement_change;
+	bool async_powercap_cap_set;
+	bool powercap_cap_config;
+	bool powercap_monitoring;
+	bool powercap_pai_config;
+	bool powercap_scale_mw;
+	bool powercap_scale_uw;
+	char name[SCMI_MAX_STR_SIZE];
+	unsigned int min_pai;
+	unsigned int max_pai;
+	unsigned int pai_step;
+	unsigned int min_power_cap;
+	unsigned int max_power_cap;
+	unsigned int power_cap_step;
+	unsigned int sustainable_power;
+	unsigned int accuracy;
+#define SCMI_POWERCAP_ROOT_ZONE_ID     0xFFFFFFFFUL
+	unsigned int parent_id;
+};
+
+/**
+ * struct scmi_powercap_proto_ops - represents the various operations provided
+ * by SCMI Powercap Protocol
+ *
+ * @num_domains_get: get the count of powercap domains provided by SCMI.
+ * @info_get: get the information for the specified domain.
+ * @cap_get: get the current CAP value for the specified domain.
+ * @cap_set: set the CAP value for the specified domain to the provided value;
+ *	     if the domain supports setting the CAP with an asynchronous command
+ *	     this request will finally trigger an asynchronous transfer, but, if
+ *	     @ignore_dresp here is set to true, this call will anyway return
+ *	     immediately without waiting for the related delayed response.
+ * @pai_get: get the current PAI value for the specified domain.
+ * @pai_set: set the PAI value for the specified domain to the provided value.
+ * @measurements_get: retrieve the current average power measurements for the
+ *		      specified domain and the related PAI upon which is
+ *		      calculated.
+ * @measurements_threshold_set: set the desired low and high power thresholds
+ *				to be used when registering for notification
+ *				of type POWERCAP_MEASUREMENTS_NOTIFY with this
+ *				powercap domain.
+ *				Note that this must be called at least once
+ *				before registering any callback with the usual
+ *				@scmi_notify_ops; moreover, in case this method
+ *				is called with measurement notifications already
+ *				enabled it will also trigger, transparently, a
+ *				proper update of the power thresholds configured
+ *				in the SCMI backend server.
+ * @measurements_threshold_get: get the currently configured low and high power
+ *				thresholds used when registering callbacks for
+ *				notification POWERCAP_MEASUREMENTS_NOTIFY.
+ */
+struct scmi_powercap_proto_ops {
+	int (*num_domains_get)(const struct scmi_protocol_handle *ph);
+	const struct scmi_powercap_info __must_check *(*info_get)
+		(const struct scmi_protocol_handle *ph, u32 domain_id);
+	int (*cap_get)(const struct scmi_protocol_handle *ph, u32 domain_id,
+		       u32 *power_cap);
+	int (*cap_set)(const struct scmi_protocol_handle *ph, u32 domain_id,
+		       u32 power_cap, bool ignore_dresp);
+	int (*pai_get)(const struct scmi_protocol_handle *ph, u32 domain_id,
+		       u32 *pai);
+	int (*pai_set)(const struct scmi_protocol_handle *ph, u32 domain_id,
+		       u32 pai);
+	int (*measurements_get)(const struct scmi_protocol_handle *ph,
+				u32 domain_id, u32 *average_power, u32 *pai);
+	int (*measurements_threshold_set)(const struct scmi_protocol_handle *ph,
+					  u32 domain_id, u32 power_thresh_low,
+					  u32 power_thresh_high);
+	int (*measurements_threshold_get)(const struct scmi_protocol_handle *ph,
+					  u32 domain_id, u32 *power_thresh_low,
+					  u32 *power_thresh_high);
+};
+
 /**
  * struct scmi_notify_ops  - represents notifications' operations provided by
  * SCMI core
@@ -661,6 +769,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_SENSOR = 0x15,
 	SCMI_PROTOCOL_RESET = 0x16,
 	SCMI_PROTOCOL_VOLTAGE = 0x17,
+	SCMI_PROTOCOL_POWERCAP = 0x18,
 };
 
 enum scmi_system_events {
@@ -762,6 +871,8 @@ enum scmi_notification_events {
 	SCMI_EVENT_RESET_ISSUED = 0x0,
 	SCMI_EVENT_BASE_ERROR_EVENT = 0x0,
 	SCMI_EVENT_SYSTEM_POWER_STATE_NOTIFIER = 0x0,
+	SCMI_EVENT_POWERCAP_CAP_CHANGED = 0x0,
+	SCMI_EVENT_POWERCAP_MEASUREMENTS_CHANGED = 0x1,
 };
 
 struct scmi_power_state_changed_report {
@@ -830,4 +941,18 @@ struct scmi_base_error_report {
 	unsigned long long	reports[];
 };
 
+struct scmi_powercap_cap_changed_report {
+	ktime_t		timestamp;
+	unsigned int	agent_id;
+	unsigned int	domain_id;
+	unsigned int	power_cap;
+	unsigned int	pai;
+};
+
+struct scmi_powercap_meas_changed_report {
+	ktime_t		timestamp;
+	unsigned int	agent_id;
+	unsigned int	domain_id;
+	unsigned int	power;
+};
 #endif /* _LINUX_SCMI_PROTOCOL_H */
-- 
2.32.0

