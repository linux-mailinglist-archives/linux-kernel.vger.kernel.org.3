Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77864EC7D1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348018AbiC3PJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347946AbiC3PIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:08:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46FA4A27CA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:06:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE2F823A;
        Wed, 30 Mar 2022 08:06:55 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97A083F73B;
        Wed, 30 Mar 2022 08:06:54 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 17/22] firmware: arm_scmi: Use common iterators in Voltage protocol
Date:   Wed, 30 Mar 2022 16:05:46 +0100
Message-Id: <20220330150551.2573938-18-cristian.marussi@arm.com>
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

Make SCMI Voltage protocol use the common iterator protocol helpers.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/voltage.c | 161 ++++++++++++++++------------
 1 file changed, 93 insertions(+), 68 deletions(-)

diff --git a/drivers/firmware/arm_scmi/voltage.c b/drivers/firmware/arm_scmi/voltage.c
index 5d58ba724eeb..e1bdce573c4f 100644
--- a/drivers/firmware/arm_scmi/voltage.c
+++ b/drivers/firmware/arm_scmi/voltage.c
@@ -112,14 +112,100 @@ static int scmi_init_voltage_levels(struct device *dev,
 	return 0;
 }
 
+struct scmi_volt_ipriv {
+	struct device *dev;
+	struct scmi_voltage_info *v;
+};
+
+static void iter_volt_levels_prepare_message(void *message,
+					     unsigned int desc_index,
+					     const void *priv)
+{
+	struct scmi_msg_cmd_describe_levels *msg = message;
+	const struct scmi_volt_ipriv *p = priv;
+
+	msg->domain_id = cpu_to_le32(p->v->id);
+	msg->level_index = cpu_to_le32(desc_index);
+}
+
+static int iter_volt_levels_update_state(struct scmi_iterator_state *st,
+					 const void *response, void *priv)
+{
+	int ret = 0;
+	u32 flags;
+	const struct scmi_msg_resp_describe_levels *r = response;
+	struct scmi_volt_ipriv *p = priv;
+
+	flags = le32_to_cpu(r->flags);
+	st->num_returned = NUM_RETURNED_LEVELS(flags);
+	st->num_remaining = NUM_REMAINING_LEVELS(flags);
+
+	/* Allocate space for num_levels if not already done */
+	if (!p->v->num_levels) {
+		ret = scmi_init_voltage_levels(p->dev, p->v, st->num_returned,
+					       st->num_remaining,
+					      SUPPORTS_SEGMENTED_LEVELS(flags));
+		if (!ret)
+			st->max_resources = p->v->num_levels;
+	}
+
+	return ret;
+}
+
+static int
+iter_volt_levels_process_response(const struct scmi_protocol_handle *ph,
+				  const void *response,
+				  struct scmi_iterator_state *st, void *priv)
+{
+	s32 val;
+	const struct scmi_msg_resp_describe_levels *r = response;
+	struct scmi_volt_ipriv *p = priv;
+
+	val = (s32)le32_to_cpu(r->voltage[st->loop_idx]);
+	p->v->levels_uv[st->desc_index + st->loop_idx] = val;
+	if (val < 0)
+		p->v->negative_volts_allowed = true;
+
+	return 0;
+}
+
+static int scmi_voltage_levels_get(const struct scmi_protocol_handle *ph,
+				   struct scmi_voltage_info *v)
+{
+	int ret;
+	void *iter;
+	struct scmi_msg_cmd_describe_levels *msg;
+	struct scmi_iterator_ops ops = {
+		.prepare_message = iter_volt_levels_prepare_message,
+		.update_state = iter_volt_levels_update_state,
+		.process_response = iter_volt_levels_process_response,
+	};
+	struct scmi_volt_ipriv vpriv = {
+		.dev = ph->dev,
+		.v = v,
+	};
+
+	iter = ph->hops->iter_response_init(ph, &ops, v->num_levels,
+					    VOLTAGE_DESCRIBE_LEVELS,
+					    sizeof(*msg), &vpriv);
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	ret = ph->hops->iter_response_run(iter);
+	if (ret) {
+		v->num_levels = 0;
+		devm_kfree(ph->dev, v->levels_uv);
+	}
+
+	return ret;
+}
+
 static int scmi_voltage_descriptors_get(const struct scmi_protocol_handle *ph,
 					struct voltage_info *vinfo)
 {
 	int ret, dom;
-	struct scmi_xfer *td, *tl;
-	struct device *dev = ph->dev;
+	struct scmi_xfer *td;
 	struct scmi_msg_resp_domain_attributes *resp_dom;
-	struct scmi_msg_resp_describe_levels *resp_levels;
 
 	ret = ph->xops->xfer_get_init(ph, VOLTAGE_DOMAIN_ATTRIBUTES,
 				      sizeof(__le32), sizeof(*resp_dom), &td);
@@ -127,16 +213,7 @@ static int scmi_voltage_descriptors_get(const struct scmi_protocol_handle *ph,
 		return ret;
 	resp_dom = td->rx.buf;
 
-	ret = ph->xops->xfer_get_init(ph, VOLTAGE_DESCRIBE_LEVELS,
-				      sizeof(__le64), 0, &tl);
-	if (ret)
-		goto outd;
-	resp_levels = tl->rx.buf;
-
 	for (dom = 0; dom < vinfo->num_domains; dom++) {
-		u32 desc_index = 0;
-		u16 num_returned = 0, num_remaining = 0;
-		struct scmi_msg_cmd_describe_levels *cmd;
 		struct scmi_voltage_info *v;
 
 		/* Retrieve domain attributes at first ... */
@@ -161,66 +238,14 @@ static int scmi_voltage_descriptors_get(const struct scmi_protocol_handle *ph,
 						    v->id, v->name,
 						    SCMI_MAX_STR_SIZE);
 
-		cmd = tl->tx.buf;
-		/* ...then retrieve domain levels descriptions */
-		do {
-			u32 flags;
-			int cnt;
-
-			cmd->domain_id = cpu_to_le32(v->id);
-			cmd->level_index = cpu_to_le32(desc_index);
-			ret = ph->xops->do_xfer(ph, tl);
-			if (ret)
-				break;
-
-			flags = le32_to_cpu(resp_levels->flags);
-			num_returned = NUM_RETURNED_LEVELS(flags);
-			num_remaining = NUM_REMAINING_LEVELS(flags);
-
-			/* Allocate space for num_levels if not already done */
-			if (!v->num_levels) {
-				ret = scmi_init_voltage_levels(dev, v,
-							       num_returned,
-							       num_remaining,
-					      SUPPORTS_SEGMENTED_LEVELS(flags));
-				if (ret)
-					break;
-			}
-
-			if (desc_index + num_returned > v->num_levels) {
-				dev_err(ph->dev,
-					"No. of voltage levels can't exceed %d\n",
-					v->num_levels);
-				ret = -EINVAL;
-				break;
-			}
-
-			for (cnt = 0; cnt < num_returned; cnt++) {
-				s32 val;
-
-				val =
-				    (s32)le32_to_cpu(resp_levels->voltage[cnt]);
-				v->levels_uv[desc_index + cnt] = val;
-				if (val < 0)
-					v->negative_volts_allowed = true;
-			}
-
-			desc_index += num_returned;
-
-			ph->xops->reset_rx_to_maxsz(ph, tl);
-			/* check both to avoid infinite loop due to buggy fw */
-		} while (num_returned && num_remaining);
-
-		if (ret) {
-			v->num_levels = 0;
-			devm_kfree(dev, v->levels_uv);
-		}
+		ret = scmi_voltage_levels_get(ph, v);
+		/* Skip invalid voltage descriptors */
+		if (ret)
+			continue;
 
 		ph->xops->reset_rx_to_maxsz(ph, td);
 	}
 
-	ph->xops->xfer_put(ph, tl);
-outd:
 	ph->xops->xfer_put(ph, td);
 
 	return ret;
-- 
2.32.0

