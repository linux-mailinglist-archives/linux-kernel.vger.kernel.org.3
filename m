Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D387E597516
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 19:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241116AbiHQR2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 13:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241078AbiHQR1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 13:27:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8C04A1D0F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:27:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8ECB01570;
        Wed, 17 Aug 2022 10:27:55 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 003563F66F;
        Wed, 17 Aug 2022 10:27:53 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com
Subject: [PATCH 2/6] firmware: arm_scmi: Improve checks on .info_get operations
Date:   Wed, 17 Aug 2022 18:27:27 +0100
Message-Id: <20220817172731.1185305-3-cristian.marussi@arm.com>
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

SCMI protocols abstract and expose a number of protocol specific resources
like clocks, sensors and so on: information about such specific domain
resources are generally exposed via an .info_get protocol operation.

Improve the sanity check on these .info_get operations where needed.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c   | 6 +++++-
 drivers/firmware/arm_scmi/sensors.c | 3 +++
 include/linux/scmi_protocol.h       | 4 ++--
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 3ed7ae0d6781..96060bf90a24 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -450,9 +450,13 @@ static int scmi_clock_count_get(const struct scmi_protocol_handle *ph)
 static const struct scmi_clock_info *
 scmi_clock_info_get(const struct scmi_protocol_handle *ph, u32 clk_id)
 {
+	struct scmi_clock_info *clk;
 	struct clock_info *ci = ph->get_priv(ph);
-	struct scmi_clock_info *clk = ci->clk + clk_id;
 
+	if (clk_id >= ci->num_clocks)
+		return NULL;
+
+	clk = ci->clk + clk_id;
 	if (!clk->name[0])
 		return NULL;
 
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 7288c6117838..7d0c7476d206 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -948,6 +948,9 @@ scmi_sensor_info_get(const struct scmi_protocol_handle *ph, u32 sensor_id)
 {
 	struct sensors_info *si = ph->get_priv(ph);
 
+	if (sensor_id >= si->num_sensors)
+		return NULL;
+
 	return si->sensors + sensor_id;
 }
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index a193884ecf2b..4f765bc788ff 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -84,7 +84,7 @@ struct scmi_protocol_handle;
 struct scmi_clk_proto_ops {
 	int (*count_get)(const struct scmi_protocol_handle *ph);
 
-	const struct scmi_clock_info *(*info_get)
+	const struct scmi_clock_info __must_check *(*info_get)
 		(const struct scmi_protocol_handle *ph, u32 clk_id);
 	int (*rate_get)(const struct scmi_protocol_handle *ph, u32 clk_id,
 			u64 *rate);
@@ -466,7 +466,7 @@ enum scmi_sensor_class {
  */
 struct scmi_sensor_proto_ops {
 	int (*count_get)(const struct scmi_protocol_handle *ph);
-	const struct scmi_sensor_info *(*info_get)
+	const struct scmi_sensor_info __must_check *(*info_get)
 		(const struct scmi_protocol_handle *ph, u32 sensor_id);
 	int (*trip_point_config)(const struct scmi_protocol_handle *ph,
 				 u32 sensor_id, u8 trip_id, u64 trip_value);
-- 
2.32.0

