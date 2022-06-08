Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCD4542CC7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbiFHKLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236455AbiFHKKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:10:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80E751F98C3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:55:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A3CB143D;
        Wed,  8 Jun 2022 02:55:47 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A8433F73B;
        Wed,  8 Jun 2022 02:55:46 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        Peter Hilber <peter.hilber@opensynergy.com>
Subject: [PATCH 2/3] firmware: arm_scmi: Fix SENSOR_AXIS_NAME_GET behaviour when unsupported
Date:   Wed,  8 Jun 2022 10:55:29 +0100
Message-Id: <20220608095530.497879-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220608095530.497879-1-cristian.marussi@arm.com>
References: <20220608095530.497879-1-cristian.marussi@arm.com>
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

Avoid to invoke SENSOR_AXIS_NAME_GET on sensors that have not declared at
least one of their axes as supporting extended names.

Since the returned list of axes supporting extended names is not
necessarily comprising all the existing axes of the specified sensor,
take care also to properly pick the ax descriptor from the id embedded
in the reply.

Cc: Peter Hilber <peter.hilber@opensynergy.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Fixes: 802b0bed011e ("firmware: arm_scmi: Add SCMI v3.1 SENSOR_AXIS_NAME_GET support")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/sensors.c | 55 +++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 75b9d716508e..58fe4f0175be 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -358,15 +358,20 @@ static int scmi_sensor_update_intervals(const struct scmi_protocol_handle *ph,
 	return ph->hops->iter_response_run(iter);
 }
 
+struct scmi_apriv {
+	bool any_axes_support_extended_names;
+	struct scmi_sensor_info *s;
+};
+
 static void iter_axes_desc_prepare_message(void *message,
 					   const unsigned int desc_index,
 					   const void *priv)
 {
 	struct scmi_msg_sensor_axis_description_get *msg = message;
-	const struct scmi_sensor_info *s = priv;
+	const struct scmi_apriv *apriv = priv;
 
 	/* Set the number of sensors to be skipped/already read */
-	msg->id = cpu_to_le32(s->id);
+	msg->id = cpu_to_le32(apriv->s->id);
 	msg->axis_desc_index = cpu_to_le32(desc_index);
 }
 
@@ -393,12 +398,14 @@ iter_axes_desc_process_response(const struct scmi_protocol_handle *ph,
 	u32 attrh, attrl;
 	struct scmi_sensor_axis_info *a;
 	size_t dsize = SCMI_MSG_RESP_AXIS_DESCR_BASE_SZ;
-	struct scmi_sensor_info *s = priv;
+	struct scmi_apriv *apriv = priv;
 	const struct scmi_axis_descriptor *adesc = st->priv;
 
 	attrl = le32_to_cpu(adesc->attributes_low);
+	if (SUPPORTS_EXTENDED_AXIS_NAMES(attrl))
+		apriv->any_axes_support_extended_names = true;
 
-	a = &s->axis[st->desc_index + st->loop_idx];
+	a = &apriv->s->axis[st->desc_index + st->loop_idx];
 	a->id = le32_to_cpu(adesc->id);
 	a->extended_attrs = SUPPORTS_EXTEND_ATTRS(attrl);
 
@@ -444,10 +451,18 @@ iter_axes_extended_name_process_response(const struct scmi_protocol_handle *ph,
 					 void *priv)
 {
 	struct scmi_sensor_axis_info *a;
-	const struct scmi_sensor_info *s = priv;
+	const struct scmi_apriv *apriv = priv;
 	struct scmi_sensor_axis_name_descriptor *adesc = st->priv;
 
-	a = &s->axis[st->desc_index + st->loop_idx];
+	if (adesc->axis_id >= st->max_resources)
+		return -EPROTO;
+
+	/*
+	 * Pick the corresponding descriptor based on the axis_id embedded
+	 * in the reply since the list of axes supporting extended names
+	 * can be a subset of all the axes.
+	 */
+	a = &apriv->s->axis[adesc->axis_id];
 	strscpy(a->name, adesc->name, SCMI_MAX_STR_SIZE);
 	st->priv = ++adesc;
 
@@ -458,21 +473,36 @@ static int
 scmi_sensor_axis_extended_names_get(const struct scmi_protocol_handle *ph,
 				    struct scmi_sensor_info *s)
 {
+	int ret;
 	void *iter;
 	struct scmi_iterator_ops ops = {
 		.prepare_message = iter_axes_desc_prepare_message,
 		.update_state = iter_axes_extended_name_update_state,
 		.process_response = iter_axes_extended_name_process_response,
 	};
+	struct scmi_apriv apriv = {
+		.any_axes_support_extended_names = false,
+		.s = s,
+	};
 
 	iter = ph->hops->iter_response_init(ph, &ops, s->num_axis,
 					    SENSOR_AXIS_NAME_GET,
 					    sizeof(struct scmi_msg_sensor_axis_description_get),
-					    s);
+					    &apriv);
 	if (IS_ERR(iter))
 		return PTR_ERR(iter);
 
-	return ph->hops->iter_response_run(iter);
+	/*
+	 * Do not cause whole protocol initialization failure when failing to
+	 * get extended names for axes.
+	 */
+	ret = ph->hops->iter_response_run(iter);
+	if (ret)
+		dev_warn(ph->dev,
+			 "Failed to get axes extended names for %s (ret:%d).\n",
+			 s->name, ret);
+
+	return 0;
 }
 
 static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
@@ -486,6 +516,10 @@ static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
 		.update_state = iter_axes_desc_update_state,
 		.process_response = iter_axes_desc_process_response,
 	};
+	struct scmi_apriv apriv = {
+		.any_axes_support_extended_names = false,
+		.s = s,
+	};
 
 	s->axis = devm_kcalloc(ph->dev, s->num_axis,
 			       sizeof(*s->axis), GFP_KERNEL);
@@ -495,7 +529,7 @@ static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
 	iter = ph->hops->iter_response_init(ph, &ops, s->num_axis,
 					    SENSOR_AXIS_DESCRIPTION_GET,
 					    sizeof(struct scmi_msg_sensor_axis_description_get),
-					    s);
+					    &apriv);
 	if (IS_ERR(iter))
 		return PTR_ERR(iter);
 
@@ -503,7 +537,8 @@ static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
 	if (ret)
 		return ret;
 
-	if (PROTOCOL_REV_MAJOR(version) >= 0x3)
+	if (PROTOCOL_REV_MAJOR(version) >= 0x3 &&
+	    apriv.any_axes_support_extended_names)
 		ret = scmi_sensor_axis_extended_names_get(ph, s);
 
 	return ret;
-- 
2.32.0

