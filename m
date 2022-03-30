Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03E24EC7CC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347882AbiC3PJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347911AbiC3PIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:08:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 926189F6F2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:06:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D2E5153B;
        Wed, 30 Mar 2022 08:06:51 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C772E3F73B;
        Wed, 30 Mar 2022 08:06:49 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 14/22] firmware: arm_scmi: Use common iterators in Sensor protocol
Date:   Wed, 30 Mar 2022 16:05:43 +0100
Message-Id: <20220330150551.2573938-15-cristian.marussi@arm.com>
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

Make SCMI Sensor protocol use the common iterator protocol helpers.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/sensors.c | 582 ++++++++++++++--------------
 1 file changed, 297 insertions(+), 285 deletions(-)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 6fd8b3a874ea..e1a94463d7d8 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -64,6 +64,10 @@ struct scmi_msg_resp_attrs {
 	__le32 max_range_high;
 };
 
+struct scmi_msg_sensor_description {
+	__le32 desc_index;
+};
+
 struct scmi_msg_resp_sensor_description {
 	__le16 num_returned;
 	__le16 num_remaining;
@@ -233,346 +237,354 @@ static int scmi_sensor_attributes_get(const struct scmi_protocol_handle *ph,
 }
 
 static inline void scmi_parse_range_attrs(struct scmi_range_attrs *out,
-					  struct scmi_msg_resp_attrs *in)
+					  const struct scmi_msg_resp_attrs *in)
 {
 	out->min_range = get_unaligned_le64((void *)&in->min_range_low);
 	out->max_range = get_unaligned_le64((void *)&in->max_range_low);
 }
 
-static int scmi_sensor_update_intervals(const struct scmi_protocol_handle *ph,
-					struct scmi_sensor_info *s)
-{
-	int ret, cnt;
-	u32 desc_index = 0;
-	u16 num_returned, num_remaining;
-	struct scmi_xfer *ti;
-	struct scmi_msg_resp_sensor_list_update_intervals *buf;
-	struct scmi_msg_sensor_list_update_intervals *msg;
-
-	ret = ph->xops->xfer_get_init(ph, SENSOR_LIST_UPDATE_INTERVALS,
-				      sizeof(*msg), 0, &ti);
-	if (ret)
-		return ret;
-
-	buf = ti->rx.buf;
-	do {
-		u32 flags;
-
-		msg = ti->tx.buf;
-		/* Set the number of sensors to be skipped/already read */
-		msg->id = cpu_to_le32(s->id);
-		msg->index = cpu_to_le32(desc_index);
+struct scmi_sens_ipriv {
+	void *priv;
+	struct device *dev;
+};
 
-		ret = ph->xops->do_xfer(ph, ti);
-		if (ret)
-			break;
+static void iter_intervals_prepare_message(void *message,
+					   unsigned int desc_index,
+					   const void *p)
+{
+	struct scmi_msg_sensor_list_update_intervals *msg = message;
+	const struct scmi_sensor_info *s;
 
-		flags = le32_to_cpu(buf->num_intervals_flags);
-		num_returned = NUM_INTERVALS_RETURNED(flags);
-		num_remaining = NUM_INTERVALS_REMAINING(flags);
+	s = ((const struct scmi_sens_ipriv *)p)->priv;
+	/* Set the number of sensors to be skipped/already read */
+	msg->id = cpu_to_le32(s->id);
+	msg->index = cpu_to_le32(desc_index);
+}
 
-		/*
-		 * Max intervals is not declared previously anywhere so we
-		 * assume it's returned+remaining.
-		 */
-		if (!s->intervals.count) {
-			s->intervals.segmented = SEGMENTED_INTVL_FORMAT(flags);
-			s->intervals.count = num_returned + num_remaining;
-			/* segmented intervals are reported in one triplet */
-			if (s->intervals.segmented &&
-			    (num_remaining || num_returned != 3)) {
-				dev_err(ph->dev,
-					"Sensor ID:%d advertises an invalid segmented interval (%d)\n",
-					s->id, s->intervals.count);
+static int iter_intervals_update_state(struct scmi_iterator_state *st,
+				       const void *response, void *p)
+{
+	u32 flags;
+	struct scmi_sensor_info *s = ((struct scmi_sens_ipriv *)p)->priv;
+	struct device *dev = ((struct scmi_sens_ipriv *)p)->dev;
+	const struct scmi_msg_resp_sensor_list_update_intervals *r = response;
+
+	flags = le32_to_cpu(r->num_intervals_flags);
+	st->num_returned = NUM_INTERVALS_RETURNED(flags);
+	st->num_remaining = NUM_INTERVALS_REMAINING(flags);
+
+	/*
+	 * Max intervals is not declared previously anywhere so we
+	 * assume it's returned+remaining on first call.
+	 */
+	if (!st->max_resources) {
+		s->intervals.segmented = SEGMENTED_INTVL_FORMAT(flags);
+		s->intervals.count = st->num_returned + st->num_remaining;
+		/* segmented intervals are reported in one triplet */
+		if (s->intervals.segmented &&
+		    (st->num_remaining || st->num_returned != 3)) {
+			dev_err(dev,
+				"Sensor ID:%d advertises an invalid segmented interval (%d)\n",
+				s->id, s->intervals.count);
+			s->intervals.segmented = false;
+			s->intervals.count = 0;
+			return -EINVAL;
+		}
+		/* Direct allocation when exceeding pre-allocated */
+		if (s->intervals.count >= SCMI_MAX_PREALLOC_POOL) {
+			s->intervals.desc =
+				devm_kcalloc(dev,
+					     s->intervals.count,
+					     sizeof(*s->intervals.desc),
+					     GFP_KERNEL);
+			if (!s->intervals.desc) {
 				s->intervals.segmented = false;
 				s->intervals.count = 0;
-				ret = -EINVAL;
-				break;
-			}
-			/* Direct allocation when exceeding pre-allocated */
-			if (s->intervals.count >= SCMI_MAX_PREALLOC_POOL) {
-				s->intervals.desc =
-					devm_kcalloc(ph->dev,
-						     s->intervals.count,
-						     sizeof(*s->intervals.desc),
-						     GFP_KERNEL);
-				if (!s->intervals.desc) {
-					s->intervals.segmented = false;
-					s->intervals.count = 0;
-					ret = -ENOMEM;
-					break;
-				}
+				return -ENOMEM;
 			}
-		} else if (desc_index + num_returned > s->intervals.count) {
-			dev_err(ph->dev,
-				"No. of update intervals can't exceed %d\n",
-				s->intervals.count);
-			ret = -EINVAL;
-			break;
 		}
 
-		for (cnt = 0; cnt < num_returned; cnt++)
-			s->intervals.desc[desc_index + cnt] =
-					le32_to_cpu(buf->intervals[cnt]);
+		st->max_resources = s->intervals.count;
+	}
 
-		desc_index += num_returned;
+	return 0;
+}
 
-		ph->xops->reset_rx_to_maxsz(ph, ti);
-		/*
-		 * check for both returned and remaining to avoid infinite
-		 * loop due to buggy firmware
-		 */
-	} while (num_returned && num_remaining);
+static int
+iter_intervals_process_response(const struct scmi_protocol_handle *ph,
+				const void *response,
+				struct scmi_iterator_state *st, void *p)
+{
+	const struct scmi_msg_resp_sensor_list_update_intervals *r = response;
+	struct scmi_sensor_info *s = ((struct scmi_sens_ipriv *)p)->priv;
 
-	ph->xops->xfer_put(ph, ti);
-	return ret;
+	s->intervals.desc[st->desc_index + st->loop_idx] =
+		le32_to_cpu(r->intervals[st->loop_idx]);
+
+	return 0;
 }
 
-static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
+static int scmi_sensor_update_intervals(const struct scmi_protocol_handle *ph,
 					struct scmi_sensor_info *s)
 {
-	int ret, cnt;
-	u32 desc_index = 0;
-	u16 num_returned, num_remaining;
-	struct scmi_xfer *te;
-	struct scmi_msg_resp_sensor_axis_description *buf;
-	struct scmi_msg_sensor_axis_description_get *msg;
+	void *iter;
+	struct scmi_msg_sensor_list_update_intervals *msg;
+	struct scmi_iterator_ops ops = {
+		.prepare_message = iter_intervals_prepare_message,
+		.update_state = iter_intervals_update_state,
+		.process_response = iter_intervals_process_response,
+	};
+	struct scmi_sens_ipriv upriv = {
+		.priv = s,
+		.dev = ph->dev,
+	};
+
+	iter = ph->hops->iter_response_init(ph, &ops, s->intervals.count,
+					    SENSOR_LIST_UPDATE_INTERVALS,
+					    sizeof(*msg), &upriv);
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	return ph->hops->iter_response_run(iter);
+}
 
-	s->axis = devm_kcalloc(ph->dev, s->num_axis,
-			       sizeof(*s->axis), GFP_KERNEL);
-	if (!s->axis)
-		return -ENOMEM;
+static void iter_axes_desc_prepare_message(void *message,
+					   const unsigned int desc_index,
+					   const void *priv)
+{
+	struct scmi_msg_sensor_axis_description_get *msg = message;
+	const struct scmi_sensor_info *s = priv;
 
-	ret = ph->xops->xfer_get_init(ph, SENSOR_AXIS_DESCRIPTION_GET,
-				      sizeof(*msg), 0, &te);
-	if (ret)
-		return ret;
+	/* Set the number of sensors to be skipped/already read */
+	msg->id = cpu_to_le32(s->id);
+	msg->axis_desc_index = cpu_to_le32(desc_index);
+}
 
-	buf = te->rx.buf;
-	do {
-		u32 flags;
-		struct scmi_axis_descriptor *adesc;
+static int
+iter_axes_desc_update_state(struct scmi_iterator_state *st,
+			    const void *response, void *priv)
+{
+	u32 flags;
+	const struct scmi_msg_resp_sensor_axis_description *r = response;
 
-		msg = te->tx.buf;
-		/* Set the number of sensors to be skipped/already read */
-		msg->id = cpu_to_le32(s->id);
-		msg->axis_desc_index = cpu_to_le32(desc_index);
+	flags = le32_to_cpu(r->num_axis_flags);
+	st->num_returned = NUM_AXIS_RETURNED(flags);
+	st->num_remaining = NUM_AXIS_REMAINING(flags);
+	st->priv = (void *)&r->desc[0];
 
-		ret = ph->xops->do_xfer(ph, te);
-		if (ret)
-			break;
+	return 0;
+}
 
-		flags = le32_to_cpu(buf->num_axis_flags);
-		num_returned = NUM_AXIS_RETURNED(flags);
-		num_remaining = NUM_AXIS_REMAINING(flags);
+static int
+iter_axes_desc_process_response(const struct scmi_protocol_handle *ph,
+				const void *response,
+				struct scmi_iterator_state *st, void *priv)
+{
+	u32 attrh, attrl;
+	struct scmi_sensor_axis_info *a;
+	size_t dsize = SCMI_MSG_RESP_AXIS_DESCR_BASE_SZ;
+	struct scmi_sensor_info *s = priv;
+	const struct scmi_axis_descriptor *adesc = st->priv;
 
-		if (desc_index + num_returned > s->num_axis) {
-			dev_err(ph->dev, "No. of axis can't exceed %d\n",
-				s->num_axis);
-			break;
-		}
+	attrl = le32_to_cpu(adesc->attributes_low);
 
-		adesc = &buf->desc[0];
-		for (cnt = 0; cnt < num_returned; cnt++) {
-			u32 attrh, attrl;
-			struct scmi_sensor_axis_info *a;
-			size_t dsize = SCMI_MSG_RESP_AXIS_DESCR_BASE_SZ;
+	a = &s->axis[st->desc_index + st->loop_idx];
+	a->id = le32_to_cpu(adesc->id);
+	a->extended_attrs = SUPPORTS_EXTEND_ATTRS(attrl);
 
-			attrl = le32_to_cpu(adesc->attributes_low);
+	attrh = le32_to_cpu(adesc->attributes_high);
 
-			a = &s->axis[desc_index + cnt];
+	a->scale = S32_EXT(SENSOR_SCALE(attrh));
+	a->type = SENSOR_TYPE(attrh);
+	strscpy(a->name, adesc->name, SCMI_MAX_STR_SIZE);
 
-			a->id = le32_to_cpu(adesc->id);
-			a->extended_attrs = SUPPORTS_EXTEND_ATTRS(attrl);
+	if (a->extended_attrs) {
+		unsigned int ares = le32_to_cpu(adesc->resolution);
 
-			attrh = le32_to_cpu(adesc->attributes_high);
-			a->scale = S32_EXT(SENSOR_SCALE(attrh));
-			a->type = SENSOR_TYPE(attrh);
-			strlcpy(a->name, adesc->name, SCMI_MAX_STR_SIZE);
+		a->resolution = SENSOR_RES(ares);
+		a->exponent = S32_EXT(SENSOR_RES_EXP(ares));
+		dsize += sizeof(adesc->resolution);
 
-			if (a->extended_attrs) {
-				unsigned int ares =
-					le32_to_cpu(adesc->resolution);
+		scmi_parse_range_attrs(&a->attrs, &adesc->attrs);
+		dsize += sizeof(adesc->attrs);
+	}
 
-				a->resolution = SENSOR_RES(ares);
-				a->exponent =
-					S32_EXT(SENSOR_RES_EXP(ares));
-				dsize += sizeof(adesc->resolution);
+	st->priv = ((u8 *)adesc + dsize);
 
-				scmi_parse_range_attrs(&a->attrs,
-						       &adesc->attrs);
-				dsize += sizeof(adesc->attrs);
-			}
+	return 0;
+}
 
-			adesc = (typeof(adesc))((u8 *)adesc + dsize);
-		}
+static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
+					struct scmi_sensor_info *s)
+{
+	void *iter;
+	struct scmi_msg_sensor_axis_description_get *msg;
+	struct scmi_iterator_ops ops = {
+		.prepare_message = iter_axes_desc_prepare_message,
+		.update_state = iter_axes_desc_update_state,
+		.process_response = iter_axes_desc_process_response,
+	};
 
-		desc_index += num_returned;
+	s->axis = devm_kcalloc(ph->dev, s->num_axis,
+			       sizeof(*s->axis), GFP_KERNEL);
+	if (!s->axis)
+		return -ENOMEM;
 
-		ph->xops->reset_rx_to_maxsz(ph, te);
-		/*
-		 * check for both returned and remaining to avoid infinite
-		 * loop due to buggy firmware
-		 */
-	} while (num_returned && num_remaining);
+	iter = ph->hops->iter_response_init(ph, &ops, s->num_axis,
+					    SENSOR_AXIS_DESCRIPTION_GET,
+					    sizeof(*msg), s);
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
 
-	ph->xops->xfer_put(ph, te);
-	return ret;
+	return ph->hops->iter_response_run(iter);
 }
 
-static int scmi_sensor_description_get(const struct scmi_protocol_handle *ph,
-				       struct sensors_info *si)
+static void iter_sens_descr_prepare_message(void *message,
+					    unsigned int desc_index,
+					    const void *priv)
 {
-	int ret, cnt;
-	u32 desc_index = 0;
-	u16 num_returned, num_remaining;
-	struct scmi_xfer *t;
-	struct scmi_msg_resp_sensor_description *buf;
-
-	ret = ph->xops->xfer_get_init(ph, SENSOR_DESCRIPTION_GET,
-				      sizeof(__le32), 0, &t);
-	if (ret)
-		return ret;
-
-	buf = t->rx.buf;
-
-	do {
-		struct scmi_sensor_descriptor *sdesc;
+	struct scmi_msg_sensor_description *msg = message;
 
-		/* Set the number of sensors to be skipped/already read */
-		put_unaligned_le32(desc_index, t->tx.buf);
+	msg->desc_index = cpu_to_le32(desc_index);
+}
 
-		ret = ph->xops->do_xfer(ph, t);
-		if (ret)
-			break;
+static int iter_sens_descr_update_state(struct scmi_iterator_state *st,
+					const void *response, void *priv)
+{
+	const struct scmi_msg_resp_sensor_description *r = response;
 
-		num_returned = le16_to_cpu(buf->num_returned);
-		num_remaining = le16_to_cpu(buf->num_remaining);
+	st->num_returned = le16_to_cpu(r->num_returned);
+	st->num_remaining = le16_to_cpu(r->num_remaining);
+	st->priv = (void *)&r->desc[0];
 
-		if (desc_index + num_returned > si->num_sensors) {
-			dev_err(ph->dev, "No. of sensors can't exceed %d",
-				si->num_sensors);
-			break;
-		}
+	return 0;
+}
 
-		sdesc = &buf->desc[0];
-		for (cnt = 0; cnt < num_returned; cnt++) {
-			u32 attrh, attrl;
-			struct scmi_sensor_info *s;
-			size_t dsize = SCMI_MSG_RESP_SENS_DESCR_BASE_SZ;
-
-			s = &si->sensors[desc_index + cnt];
-			s->id = le32_to_cpu(sdesc->id);
-
-			attrl = le32_to_cpu(sdesc->attributes_low);
-			/* common bitfields parsing */
-			s->async = SUPPORTS_ASYNC_READ(attrl);
-			s->num_trip_points = NUM_TRIP_POINTS(attrl);
-			/**
-			 * only SCMIv3.0 specific bitfield below.
-			 * Such bitfields are assumed to be zeroed on non
-			 * relevant fw versions...assuming fw not buggy !
-			 */
-			s->update = SUPPORTS_UPDATE_NOTIFY(attrl);
-			s->timestamped = SUPPORTS_TIMESTAMP(attrl);
-			if (s->timestamped)
-				s->tstamp_scale =
-					S32_EXT(SENSOR_TSTAMP_EXP(attrl));
-			s->extended_scalar_attrs =
-				SUPPORTS_EXTEND_ATTRS(attrl);
-
-			attrh = le32_to_cpu(sdesc->attributes_high);
-			/* common bitfields parsing */
-			s->scale = S32_EXT(SENSOR_SCALE(attrh));
-			s->type = SENSOR_TYPE(attrh);
-			/* Use pre-allocated pool wherever possible */
-			s->intervals.desc = s->intervals.prealloc_pool;
-			if (si->version == SCMIv2_SENSOR_PROTOCOL) {
-				s->intervals.segmented = false;
-				s->intervals.count = 1;
-				/*
-				 * Convert SCMIv2.0 update interval format to
-				 * SCMIv3.0 to be used as the common exposed
-				 * descriptor, accessible via common macros.
-				 */
-				s->intervals.desc[0] =
-					(SENSOR_UPDATE_BASE(attrh) << 5) |
-					 SENSOR_UPDATE_SCALE(attrh);
-			} else {
-				/*
-				 * From SCMIv3.0 update intervals are retrieved
-				 * via a dedicated (optional) command.
-				 * Since the command is optional, on error carry
-				 * on without any update interval.
-				 */
-				if (scmi_sensor_update_intervals(ph, s))
-					dev_dbg(ph->dev,
-						"Update Intervals not available for sensor ID:%d\n",
-						s->id);
-			}
-			/**
-			 * only > SCMIv2.0 specific bitfield below.
-			 * Such bitfields are assumed to be zeroed on non
-			 * relevant fw versions...assuming fw not buggy !
-			 */
-			s->num_axis = min_t(unsigned int,
-					    SUPPORTS_AXIS(attrh) ?
-					    SENSOR_AXIS_NUMBER(attrh) : 0,
-					    SCMI_MAX_NUM_SENSOR_AXIS);
-			strlcpy(s->name, sdesc->name, SCMI_MAX_STR_SIZE);
-
-			/*
-			 * If supported overwrite short name with the extended
-			 * one; on error just carry on and use already provided
-			 * short name.
-			 */
-			if (PROTOCOL_REV_MAJOR(si->version) >= 0x3 &&
-			    SUPPORTS_EXTENDED_NAMES(attrl))
-				ph->hops->extended_name_get(ph, SENSOR_NAME_GET,
-							    s->id, s->name,
-							    SCMI_MAX_STR_SIZE);
-
-			if (s->extended_scalar_attrs) {
-				s->sensor_power = le32_to_cpu(sdesc->power);
-				dsize += sizeof(sdesc->power);
-				/* Only for sensors reporting scalar values */
-				if (s->num_axis == 0) {
-					unsigned int sres =
-						le32_to_cpu(sdesc->resolution);
-
-					s->resolution = SENSOR_RES(sres);
-					s->exponent =
-						S32_EXT(SENSOR_RES_EXP(sres));
-					dsize += sizeof(sdesc->resolution);
-
-					scmi_parse_range_attrs(&s->scalar_attrs,
-							       &sdesc->scalar_attrs);
-					dsize += sizeof(sdesc->scalar_attrs);
-				}
-			}
-			if (s->num_axis > 0) {
-				ret = scmi_sensor_axis_description(ph, s);
-				if (ret)
-					goto out;
-			}
+static int
+iter_sens_descr_process_response(const struct scmi_protocol_handle *ph,
+				 const void *response,
+				 struct scmi_iterator_state *st, void *priv)
 
-			sdesc = (typeof(sdesc))((u8 *)sdesc + dsize);
+{
+	int ret = 0;
+	u32 attrh, attrl;
+	size_t dsize = SCMI_MSG_RESP_SENS_DESCR_BASE_SZ;
+	struct scmi_sensor_info *s;
+	struct sensors_info *si = priv;
+	const struct scmi_sensor_descriptor *sdesc = st->priv;
+
+	s = &si->sensors[st->desc_index + st->loop_idx];
+	s->id = le32_to_cpu(sdesc->id);
+
+	attrl = le32_to_cpu(sdesc->attributes_low);
+	/* common bitfields parsing */
+	s->async = SUPPORTS_ASYNC_READ(attrl);
+	s->num_trip_points = NUM_TRIP_POINTS(attrl);
+	/**
+	 * only SCMIv3.0 specific bitfield below.
+	 * Such bitfields are assumed to be zeroed on non
+	 * relevant fw versions...assuming fw not buggy !
+	 */
+	s->update = SUPPORTS_UPDATE_NOTIFY(attrl);
+	s->timestamped = SUPPORTS_TIMESTAMP(attrl);
+	if (s->timestamped)
+		s->tstamp_scale = S32_EXT(SENSOR_TSTAMP_EXP(attrl));
+	s->extended_scalar_attrs = SUPPORTS_EXTEND_ATTRS(attrl);
+
+	attrh = le32_to_cpu(sdesc->attributes_high);
+	/* common bitfields parsing */
+	s->scale = S32_EXT(SENSOR_SCALE(attrh));
+	s->type = SENSOR_TYPE(attrh);
+	/* Use pre-allocated pool wherever possible */
+	s->intervals.desc = s->intervals.prealloc_pool;
+	if (si->version == SCMIv2_SENSOR_PROTOCOL) {
+		s->intervals.segmented = false;
+		s->intervals.count = 1;
+		/*
+		 * Convert SCMIv2.0 update interval format to
+		 * SCMIv3.0 to be used as the common exposed
+		 * descriptor, accessible via common macros.
+		 */
+		s->intervals.desc[0] = (SENSOR_UPDATE_BASE(attrh) << 5) |
+					SENSOR_UPDATE_SCALE(attrh);
+	} else {
+		/*
+		 * From SCMIv3.0 update intervals are retrieved
+		 * via a dedicated (optional) command.
+		 * Since the command is optional, on error carry
+		 * on without any update interval.
+		 */
+		if (scmi_sensor_update_intervals(ph, s))
+			dev_dbg(ph->dev,
+				"Update Intervals not available for sensor ID:%d\n",
+				s->id);
+	}
+	/**
+	 * only > SCMIv2.0 specific bitfield below.
+	 * Such bitfields are assumed to be zeroed on non
+	 * relevant fw versions...assuming fw not buggy !
+	 */
+	s->num_axis = min_t(unsigned int,
+			    SUPPORTS_AXIS(attrh) ?
+			    SENSOR_AXIS_NUMBER(attrh) : 0,
+			    SCMI_MAX_NUM_SENSOR_AXIS);
+	strscpy(s->name, sdesc->name, SCMI_MAX_STR_SIZE);
+
+	/*
+	 * If supported overwrite short name with the extended
+	 * one; on error just carry on and use already provided
+	 * short name.
+	 */
+	if (PROTOCOL_REV_MAJOR(si->version) >= 0x3 &&
+	    SUPPORTS_EXTENDED_NAMES(attrl))
+		ph->hops->extended_name_get(ph, SENSOR_NAME_GET, s->id,
+					    s->name, SCMI_MAX_STR_SIZE);
+
+	if (s->extended_scalar_attrs) {
+		s->sensor_power = le32_to_cpu(sdesc->power);
+		dsize += sizeof(sdesc->power);
+
+		/* Only for sensors reporting scalar values */
+		if (s->num_axis == 0) {
+			unsigned int sres = le32_to_cpu(sdesc->resolution);
+
+			s->resolution = SENSOR_RES(sres);
+			s->exponent = S32_EXT(SENSOR_RES_EXP(sres));
+			dsize += sizeof(sdesc->resolution);
+
+			scmi_parse_range_attrs(&s->scalar_attrs,
+					       &sdesc->scalar_attrs);
+			dsize += sizeof(sdesc->scalar_attrs);
 		}
+	}
 
-		desc_index += num_returned;
+	if (s->num_axis > 0)
+		ret = scmi_sensor_axis_description(ph, s);
 
-		ph->xops->reset_rx_to_maxsz(ph, t);
-		/*
-		 * check for both returned and remaining to avoid infinite
-		 * loop due to buggy firmware
-		 */
-	} while (num_returned && num_remaining);
+	st->priv = ((u8 *)sdesc + dsize);
 
-out:
-	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
+static int scmi_sensor_description_get(const struct scmi_protocol_handle *ph,
+				       struct sensors_info *si)
+{
+	void *iter;
+	struct scmi_iterator_ops ops = {
+		.prepare_message = iter_sens_descr_prepare_message,
+		.update_state = iter_sens_descr_update_state,
+		.process_response = iter_sens_descr_process_response,
+	};
+
+	iter = ph->hops->iter_response_init(ph, &ops, si->num_sensors,
+					    SENSOR_DESCRIPTION_GET,
+					    sizeof(__le32), si);
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	return ph->hops->iter_response_run(iter);
+}
+
 static inline int
 scmi_sensor_request_notify(const struct scmi_protocol_handle *ph, u32 sensor_id,
 			   u8 message_id, bool enable)
-- 
2.32.0

