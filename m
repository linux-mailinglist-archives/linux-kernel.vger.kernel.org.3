Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F78E4EC7CB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348051AbiC3PJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347888AbiC3PIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:08:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0ABA4A0BDF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:06:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C68A323A;
        Wed, 30 Mar 2022 08:06:52 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 793253F73B;
        Wed, 30 Mar 2022 08:06:51 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 15/22] firmware: arm_scmi: Add SCMIv3.1 SENSOR_AXIS_NAME_GET support
Date:   Wed, 30 Mar 2022 16:05:44 +0100
Message-Id: <20220330150551.2573938-16-cristian.marussi@arm.com>
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

Add support for SCMIv3.1 SENSOR_AXIS_NAME_GET multi-part command using the
common iterator protocol helpers.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/sensors.c | 82 ++++++++++++++++++++++++++---
 1 file changed, 76 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index e1a94463d7d8..21e0ce89b153 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -28,6 +28,7 @@ enum scmi_sensor_protocol_cmd {
 	SENSOR_CONFIG_SET = 0xA,
 	SENSOR_CONTINUOUS_UPDATE_NOTIFY = 0xB,
 	SENSOR_NAME_GET = 0xC,
+	SENSOR_AXIS_NAME_GET = 0xD,
 };
 
 struct scmi_msg_resp_sensor_attributes {
@@ -117,13 +118,22 @@ struct scmi_msg_resp_sensor_axis_description {
 	struct scmi_axis_descriptor {
 		__le32 id;
 		__le32 attributes_low;
+#define SUPPORTS_EXTENDED_AXIS_NAMES(x)	FIELD_GET(BIT(9), (x))
 		__le32 attributes_high;
-		u8 name[SCMI_MAX_STR_SIZE];
+		u8 name[SCMI_SHORT_NAME_MAX_SIZE];
 		__le32 resolution;
 		struct scmi_msg_resp_attrs attrs;
 	} desc[];
 };
 
+struct scmi_msg_resp_sensor_axis_names_description {
+	__le32 num_axis_flags;
+	struct scmi_sensor_axis_name_descriptor {
+		__le32 axis_id;
+		u8 name[SCMI_MAX_STR_SIZE];
+	} desc[];
+};
+
 /* Base scmi_axis_descriptor size excluding extended attrs after name */
 #define SCMI_MSG_RESP_AXIS_DESCR_BASE_SZ	28
 
@@ -393,7 +403,6 @@ iter_axes_desc_process_response(const struct scmi_protocol_handle *ph,
 	a->extended_attrs = SUPPORTS_EXTEND_ATTRS(attrl);
 
 	attrh = le32_to_cpu(adesc->attributes_high);
-
 	a->scale = S32_EXT(SENSOR_SCALE(attrh));
 	a->type = SENSOR_TYPE(attrh);
 	strscpy(a->name, adesc->name, SCMI_MAX_STR_SIZE);
@@ -408,15 +417,69 @@ iter_axes_desc_process_response(const struct scmi_protocol_handle *ph,
 		scmi_parse_range_attrs(&a->attrs, &adesc->attrs);
 		dsize += sizeof(adesc->attrs);
 	}
-
 	st->priv = ((u8 *)adesc + dsize);
 
 	return 0;
 }
 
+static int
+iter_axes_extended_name_update_state(struct scmi_iterator_state *st,
+				     const void *response, void *priv)
+{
+	u32 flags;
+	const struct scmi_msg_resp_sensor_axis_names_description *r = response;
+
+	flags = le32_to_cpu(r->num_axis_flags);
+	st->num_returned = NUM_AXIS_RETURNED(flags);
+	st->num_remaining = NUM_AXIS_REMAINING(flags);
+	st->priv = (void *)&r->desc[0];
+
+	return 0;
+}
+
+static int
+iter_axes_extended_name_process_response(const struct scmi_protocol_handle *ph,
+					 const void *response,
+					 struct scmi_iterator_state *st,
+					 void *priv)
+{
+	struct scmi_sensor_axis_info *a;
+	const struct scmi_sensor_info *s = priv;
+	struct scmi_sensor_axis_name_descriptor *adesc = st->priv;
+
+	a = &s->axis[st->desc_index + st->loop_idx];
+	strscpy(a->name, adesc->name, SCMI_MAX_STR_SIZE);
+	st->priv = ++adesc;
+
+	return 0;
+}
+
+static int
+scmi_sensor_axis_extended_names_get(const struct scmi_protocol_handle *ph,
+				    struct scmi_sensor_info *s)
+{
+	void *iter;
+	struct scmi_msg_sensor_axis_description_get *msg;
+	struct scmi_iterator_ops ops = {
+		.prepare_message = iter_axes_desc_prepare_message,
+		.update_state = iter_axes_extended_name_update_state,
+		.process_response = iter_axes_extended_name_process_response,
+	};
+
+	iter = ph->hops->iter_response_init(ph, &ops, s->num_axis,
+					    SENSOR_AXIS_NAME_GET,
+					    sizeof(*msg), s);
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	return ph->hops->iter_response_run(iter);
+}
+
 static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
-					struct scmi_sensor_info *s)
+					struct scmi_sensor_info *s,
+					u32 version)
 {
+	int ret;
 	void *iter;
 	struct scmi_msg_sensor_axis_description_get *msg;
 	struct scmi_iterator_ops ops = {
@@ -436,7 +499,14 @@ static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
 	if (IS_ERR(iter))
 		return PTR_ERR(iter);
 
-	return ph->hops->iter_response_run(iter);
+	ret = ph->hops->iter_response_run(iter);
+	if (ret)
+		return ret;
+
+	if (PROTOCOL_REV_MAJOR(version) >= 0x3)
+		ret = scmi_sensor_axis_extended_names_get(ph, s);
+
+	return ret;
 }
 
 static void iter_sens_descr_prepare_message(void *message,
@@ -559,7 +629,7 @@ iter_sens_descr_process_response(const struct scmi_protocol_handle *ph,
 	}
 
 	if (s->num_axis > 0)
-		ret = scmi_sensor_axis_description(ph, s);
+		ret = scmi_sensor_axis_description(ph, s, si->version);
 
 	st->priv = ((u8 *)sdesc + dsize);
 
-- 
2.32.0

