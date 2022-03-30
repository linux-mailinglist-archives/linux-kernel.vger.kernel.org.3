Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D964EC7D9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347996AbiC3PJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347898AbiC3PIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:08:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AA2FA66C0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:06:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18892153B;
        Wed, 30 Mar 2022 08:06:59 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF1C43F73B;
        Wed, 30 Mar 2022 08:06:57 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 19/22] firmware: arm_scmi: Add SCMIv3.1 Clock notifications
Date:   Wed, 30 Mar 2022 16:05:48 +0100
Message-Id: <20220330150551.2573938-20-cristian.marussi@arm.com>
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

Add SCMIv3.1 Clock pre and post notifications.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c | 136 ++++++++++++++++++++++++++++--
 include/linux/scmi_protocol.h     |  11 +++
 2 files changed, 142 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 48ce7ef9c74b..f72f2bb171cd 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -9,6 +9,7 @@
 #include <linux/sort.h>
 
 #include "protocols.h"
+#include "notify.h"
 
 enum scmi_clock_protocol_cmd {
 	CLOCK_ATTRIBUTES = 0x3,
@@ -17,6 +18,8 @@ enum scmi_clock_protocol_cmd {
 	CLOCK_RATE_GET = 0x6,
 	CLOCK_CONFIG_SET = 0x7,
 	CLOCK_NAME_GET = 0x8,
+	CLOCK_RATE_NOTIFY = 0x9,
+	CLOCK_RATE_CHANGE_REQUESTED_NOTIFY = 0xA,
 };
 
 struct scmi_msg_resp_clock_protocol_attributes {
@@ -28,7 +31,9 @@ struct scmi_msg_resp_clock_protocol_attributes {
 struct scmi_msg_resp_clock_attributes {
 	__le32 attributes;
 #define	CLOCK_ENABLE	BIT(0)
-#define SUPPORTS_EXTENDED_NAMES(x)	((x) & BIT(29))
+#define SUPPORTS_RATE_CHANGED_NOTIF(x)		((x) & BIT(31))
+#define SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(x)	((x) & BIT(30))
+#define SUPPORTS_EXTENDED_NAMES(x)		((x) & BIT(29))
 	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
 	__le32 clock_enable_latency;
 };
@@ -76,6 +81,18 @@ struct scmi_msg_resp_set_rate_complete {
 	__le32 rate_high;
 };
 
+struct scmi_msg_clock_rate_notify {
+	__le32 clk_id;
+	__le32 notify_enable;
+};
+
+struct scmi_clock_rate_notify_payld {
+	__le32 agent_id;
+	__le32 clock_id;
+	__le32 rate_low;
+	__le32 rate_high;
+};
+
 struct clock_info {
 	u32 version;
 	int num_clocks;
@@ -84,6 +101,11 @@ struct clock_info {
 	struct scmi_clock_info *clk;
 };
 
+static enum scmi_clock_protocol_cmd evt_2_cmd[] = {
+	CLOCK_RATE_NOTIFY,
+	CLOCK_RATE_CHANGE_REQUESTED_NOTIFY,
+};
+
 static int
 scmi_clock_protocol_attributes_get(const struct scmi_protocol_handle *ph,
 				   struct clock_info *ci)
@@ -142,10 +164,17 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 	 * If supported overwrite short name with the extended one;
 	 * on error just carry on and use already provided short name.
 	 */
-	if (!ret && PROTOCOL_REV_MAJOR(version) >= 0x2 &&
-	    SUPPORTS_EXTENDED_NAMES(attributes))
-		ph->hops->extended_name_get(ph, CLOCK_NAME_GET, clk_id,
-					    clk->name, SCMI_MAX_STR_SIZE);
+	if (!ret && PROTOCOL_REV_MAJOR(version) >= 0x2) {
+		if (SUPPORTS_EXTENDED_NAMES(attributes))
+			ph->hops->extended_name_get(ph, CLOCK_NAME_GET, clk_id,
+						    clk->name,
+						    SCMI_MAX_STR_SIZE);
+
+		if (SUPPORTS_RATE_CHANGED_NOTIF(attributes))
+			clk->rate_changed_notifications = true;
+		if (SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(attributes))
+			clk->rate_change_requested_notifications = true;
+	}
 
 	return ret;
 }
@@ -417,6 +446,102 @@ static const struct scmi_clk_proto_ops clk_proto_ops = {
 	.disable_atomic = scmi_clock_disable_atomic,
 };
 
+static int scmi_clk_rate_notify(const struct scmi_protocol_handle *ph,
+				u32 clk_id, int message_id, bool enable)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_clock_rate_notify *notify;
+
+	ret = ph->xops->xfer_get_init(ph, message_id, sizeof(*notify), 0, &t);
+	if (ret)
+		return ret;
+
+	notify = t->tx.buf;
+	notify->clk_id = cpu_to_le32(clk_id);
+	notify->notify_enable = enable ? cpu_to_le32(BIT(0)) : 0;
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
+static int scmi_clk_set_notify_enabled(const struct scmi_protocol_handle *ph,
+				       u8 evt_id, u32 src_id, bool enable)
+{
+	int ret, cmd_id;
+
+	if (evt_id >= ARRAY_SIZE(evt_2_cmd))
+		return -EINVAL;
+
+	cmd_id = evt_2_cmd[evt_id];
+	ret = scmi_clk_rate_notify(ph, src_id, cmd_id, enable);
+	if (ret)
+		pr_debug("FAIL_ENABLED - evt[%X] dom[%d] - ret:%d\n",
+			 evt_id, src_id, ret);
+
+	return ret;
+}
+
+static void *scmi_clk_fill_custom_report(const struct scmi_protocol_handle *ph,
+					 u8 evt_id, ktime_t timestamp,
+					 const void *payld, size_t payld_sz,
+					 void *report, u32 *src_id)
+{
+	const struct scmi_clock_rate_notify_payld *p = payld;
+	struct scmi_clock_rate_notif_report *r = report;
+
+	if (sizeof(*p) != payld_sz ||
+	    (evt_id != SCMI_EVENT_CLOCK_RATE_CHANGED &&
+	     evt_id != SCMI_EVENT_CLOCK_RATE_CHANGE_REQUESTED))
+		return NULL;
+
+	r->timestamp = timestamp;
+	r->agent_id = le32_to_cpu(p->agent_id);
+	r->clock_id = le32_to_cpu(p->clock_id);
+	r->rate = get_unaligned_le64(&p->rate_low);
+	*src_id = r->clock_id;
+
+	return r;
+}
+
+static int scmi_clk_get_num_sources(const struct scmi_protocol_handle *ph)
+{
+	struct clock_info *ci = ph->get_priv(ph);
+
+	if (!ci)
+		return -EINVAL;
+
+	return ci->num_clocks;
+}
+
+static const struct scmi_event clk_events[] = {
+	{
+		.id = SCMI_EVENT_CLOCK_RATE_CHANGED,
+		.max_payld_sz = sizeof(struct scmi_clock_rate_notify_payld),
+		.max_report_sz = sizeof(struct scmi_clock_rate_notif_report),
+	},
+	{
+		.id = SCMI_EVENT_CLOCK_RATE_CHANGE_REQUESTED,
+		.max_payld_sz = sizeof(struct scmi_clock_rate_notify_payld),
+		.max_report_sz = sizeof(struct scmi_clock_rate_notif_report),
+	},
+};
+
+static const struct scmi_event_ops clk_event_ops = {
+	.get_num_sources = scmi_clk_get_num_sources,
+	.set_notify_enabled = scmi_clk_set_notify_enabled,
+	.fill_custom_report = scmi_clk_fill_custom_report,
+};
+
+static const struct scmi_protocol_events clk_protocol_events = {
+	.queue_sz = SCMI_PROTO_QUEUE_SZ,
+	.ops = &clk_event_ops,
+	.evts = clk_events,
+	.num_events = ARRAY_SIZE(clk_events),
+};
+
 static int scmi_clock_protocol_init(const struct scmi_protocol_handle *ph)
 {
 	u32 version;
@@ -460,6 +585,7 @@ static const struct scmi_protocol scmi_clock = {
 	.owner = THIS_MODULE,
 	.instance_init = &scmi_clock_protocol_init,
 	.ops = &clk_proto_ops,
+	.events = &clk_protocol_events,
 };
 
 DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(clock, scmi_clock)
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 56e6f13355b8..0e20acc80d50 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -44,6 +44,8 @@ struct scmi_clock_info {
 	char name[SCMI_MAX_STR_SIZE];
 	unsigned int enable_latency;
 	bool rate_discrete;
+	bool rate_changed_notifications;
+	bool rate_change_requested_notifications;
 	union {
 		struct {
 			int num_rates;
@@ -744,6 +746,8 @@ void scmi_protocol_unregister(const struct scmi_protocol *proto);
 /* SCMI Notification API - Custom Event Reports */
 enum scmi_notification_events {
 	SCMI_EVENT_POWER_STATE_CHANGED = 0x0,
+	SCMI_EVENT_CLOCK_RATE_CHANGED = 0x0,
+	SCMI_EVENT_CLOCK_RATE_CHANGE_REQUESTED = 0x1,
 	SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED = 0x0,
 	SCMI_EVENT_PERFORMANCE_LEVEL_CHANGED = 0x1,
 	SCMI_EVENT_SENSOR_TRIP_POINT_EVENT = 0x0,
@@ -760,6 +764,13 @@ struct scmi_power_state_changed_report {
 	unsigned int	power_state;
 };
 
+struct scmi_clock_rate_notif_report {
+	ktime_t			timestamp;
+	unsigned int		agent_id;
+	unsigned int		clock_id;
+	unsigned long long	rate;
+};
+
 struct scmi_system_power_state_notifier_report {
 	ktime_t		timestamp;
 	unsigned int	agent_id;
-- 
2.32.0

