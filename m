Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B7C59750F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 19:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241195AbiHQR2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 13:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241097AbiHQR14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 13:27:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7377A0634
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:27:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74CAB1576;
        Wed, 17 Aug 2022 10:27:56 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAE903F66F;
        Wed, 17 Aug 2022 10:27:54 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com
Subject: [PATCH 3/6] firmware: arm_scmi: Harden accesses to Sensor domains
Date:   Wed, 17 Aug 2022 18:27:28 +0100
Message-Id: <20220817172731.1185305-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220817172731.1185305-1-cristian.marussi@arm.com>
References: <20220817172731.1185305-1-cristian.marussi@arm.com>
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

Accessing Sensor domains descriptors by index upon SCMI drivers requests
through the SCMI sensor operations interface can potentially lead to
out-of-bound violations if the SCMI driver misbehave.

Add an internal consistency check in front of such domains descriptors
accesses.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/sensors.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 7d0c7476d206..0b5853fa9d87 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -762,6 +762,10 @@ static int scmi_sensor_config_get(const struct scmi_protocol_handle *ph,
 {
 	int ret;
 	struct scmi_xfer *t;
+	struct sensors_info *si = ph->get_priv(ph);
+
+	if (sensor_id >= si->num_sensors)
+		return -EINVAL;
 
 	ret = ph->xops->xfer_get_init(ph, SENSOR_CONFIG_GET,
 				      sizeof(__le32), sizeof(__le32), &t);
@@ -771,7 +775,6 @@ static int scmi_sensor_config_get(const struct scmi_protocol_handle *ph,
 	put_unaligned_le32(sensor_id, t->tx.buf);
 	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
-		struct sensors_info *si = ph->get_priv(ph);
 		struct scmi_sensor_info *s = si->sensors + sensor_id;
 
 		*sensor_config = get_unaligned_le64(t->rx.buf);
@@ -788,6 +791,10 @@ static int scmi_sensor_config_set(const struct scmi_protocol_handle *ph,
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_sensor_config_set *msg;
+	struct sensors_info *si = ph->get_priv(ph);
+
+	if (sensor_id >= si->num_sensors)
+		return -EINVAL;
 
 	ret = ph->xops->xfer_get_init(ph, SENSOR_CONFIG_SET,
 				      sizeof(*msg), 0, &t);
@@ -800,7 +807,6 @@ static int scmi_sensor_config_set(const struct scmi_protocol_handle *ph,
 
 	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
-		struct sensors_info *si = ph->get_priv(ph);
 		struct scmi_sensor_info *s = si->sensors + sensor_id;
 
 		s->sensor_config = sensor_config;
@@ -831,8 +837,11 @@ static int scmi_sensor_reading_get(const struct scmi_protocol_handle *ph,
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_sensor_reading_get *sensor;
+	struct scmi_sensor_info *s;
 	struct sensors_info *si = ph->get_priv(ph);
-	struct scmi_sensor_info *s = si->sensors + sensor_id;
+
+	if (sensor_id >= si->num_sensors)
+		return -EINVAL;
 
 	ret = ph->xops->xfer_get_init(ph, SENSOR_READING_GET,
 				      sizeof(*sensor), 0, &t);
@@ -841,6 +850,7 @@ static int scmi_sensor_reading_get(const struct scmi_protocol_handle *ph,
 
 	sensor = t->tx.buf;
 	sensor->id = cpu_to_le32(sensor_id);
+	s = si->sensors + sensor_id;
 	if (s->async) {
 		sensor->flags = cpu_to_le32(SENSOR_READ_ASYNC);
 		ret = ph->xops->do_xfer_with_response(ph, t);
@@ -895,9 +905,13 @@ scmi_sensor_reading_get_timestamped(const struct scmi_protocol_handle *ph,
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_sensor_reading_get *sensor;
+	struct scmi_sensor_info *s;
 	struct sensors_info *si = ph->get_priv(ph);
-	struct scmi_sensor_info *s = si->sensors + sensor_id;
 
+	if (sensor_id >= si->num_sensors)
+		return -EINVAL;
+
+	s = si->sensors + sensor_id;
 	if (!count || !readings ||
 	    (!s->num_axis && count > 1) || (s->num_axis && count > s->num_axis))
 		return -EINVAL;
-- 
2.32.0

