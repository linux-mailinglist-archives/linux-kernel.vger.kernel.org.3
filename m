Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78D6537A31
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbiE3LxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbiE3LxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:53:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E6AD6C0D6
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:53:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1680B113E;
        Mon, 30 May 2022 04:53:14 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FE323F766;
        Mon, 30 May 2022 04:53:13 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] firmware: arm_scmi: Remove unused local variables
Date:   Mon, 30 May 2022 12:52:36 +0100
Message-Id: <20220530115237.277077-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
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

While using SCMI iterators helpers a few local automatic variables are
defined but then used only as input for sizeof operators.

cppcheck is fooled to complain about this with:

drivers/firmware/arm_scmi/sensors.c:341:48: warning: Variable 'msg' is not assigned a value. [unassignedVariable]
 struct scmi_msg_sensor_list_update_intervals *msg;

Even though this is an innocuos warning, since the uninitialized variable
is at the end never used in the reported cases, fix these occurences all
over SCMI stack to avoid keeping unneeded objects on the stack.

Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c   |  5 ++---
 drivers/firmware/arm_scmi/perf.c    |  4 ++--
 drivers/firmware/arm_scmi/sensors.c | 12 ++++++------
 drivers/firmware/arm_scmi/voltage.c |  4 ++--
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 4d36a9a133d1..1a718faa4192 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -266,9 +266,7 @@ scmi_clock_describe_rates_get(const struct scmi_protocol_handle *ph, u32 clk_id,
 			      struct scmi_clock_info *clk)
 {
 	int ret;
-
 	void *iter;
-	struct scmi_msg_clock_describe_rates *msg;
 	struct scmi_iterator_ops ops = {
 		.prepare_message = iter_clk_describe_prepare_message,
 		.update_state = iter_clk_describe_update_state,
@@ -281,7 +279,8 @@ scmi_clock_describe_rates_get(const struct scmi_protocol_handle *ph, u32 clk_id,
 
 	iter = ph->hops->iter_response_init(ph, &ops, SCMI_MAX_NUM_RATES,
 					    CLOCK_DESCRIBE_RATES,
-					    sizeof(*msg), &cpriv);
+					    sizeof(struct scmi_msg_clock_describe_rates),
+					    &cpriv);
 	if (IS_ERR(iter))
 		return PTR_ERR(iter);
 
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 8f4051aca220..c1f701623058 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -332,7 +332,6 @@ scmi_perf_describe_levels_get(const struct scmi_protocol_handle *ph, u32 domain,
 {
 	int ret;
 	void *iter;
-	struct scmi_msg_perf_describe_levels *msg;
 	struct scmi_iterator_ops ops = {
 		.prepare_message = iter_perf_levels_prepare_message,
 		.update_state = iter_perf_levels_update_state,
@@ -345,7 +344,8 @@ scmi_perf_describe_levels_get(const struct scmi_protocol_handle *ph, u32 domain,
 
 	iter = ph->hops->iter_response_init(ph, &ops, MAX_OPPS,
 					    PERF_DESCRIBE_LEVELS,
-					    sizeof(*msg), &ppriv);
+					    sizeof(struct scmi_msg_perf_describe_levels),
+					    &ppriv);
 	if (IS_ERR(iter))
 		return PTR_ERR(iter);
 
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 21e0ce89b153..75b9d716508e 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -338,7 +338,6 @@ static int scmi_sensor_update_intervals(const struct scmi_protocol_handle *ph,
 					struct scmi_sensor_info *s)
 {
 	void *iter;
-	struct scmi_msg_sensor_list_update_intervals *msg;
 	struct scmi_iterator_ops ops = {
 		.prepare_message = iter_intervals_prepare_message,
 		.update_state = iter_intervals_update_state,
@@ -351,7 +350,8 @@ static int scmi_sensor_update_intervals(const struct scmi_protocol_handle *ph,
 
 	iter = ph->hops->iter_response_init(ph, &ops, s->intervals.count,
 					    SENSOR_LIST_UPDATE_INTERVALS,
-					    sizeof(*msg), &upriv);
+					    sizeof(struct scmi_msg_sensor_list_update_intervals),
+					    &upriv);
 	if (IS_ERR(iter))
 		return PTR_ERR(iter);
 
@@ -459,7 +459,6 @@ scmi_sensor_axis_extended_names_get(const struct scmi_protocol_handle *ph,
 				    struct scmi_sensor_info *s)
 {
 	void *iter;
-	struct scmi_msg_sensor_axis_description_get *msg;
 	struct scmi_iterator_ops ops = {
 		.prepare_message = iter_axes_desc_prepare_message,
 		.update_state = iter_axes_extended_name_update_state,
@@ -468,7 +467,8 @@ scmi_sensor_axis_extended_names_get(const struct scmi_protocol_handle *ph,
 
 	iter = ph->hops->iter_response_init(ph, &ops, s->num_axis,
 					    SENSOR_AXIS_NAME_GET,
-					    sizeof(*msg), s);
+					    sizeof(struct scmi_msg_sensor_axis_description_get),
+					    s);
 	if (IS_ERR(iter))
 		return PTR_ERR(iter);
 
@@ -481,7 +481,6 @@ static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
 {
 	int ret;
 	void *iter;
-	struct scmi_msg_sensor_axis_description_get *msg;
 	struct scmi_iterator_ops ops = {
 		.prepare_message = iter_axes_desc_prepare_message,
 		.update_state = iter_axes_desc_update_state,
@@ -495,7 +494,8 @@ static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
 
 	iter = ph->hops->iter_response_init(ph, &ops, s->num_axis,
 					    SENSOR_AXIS_DESCRIPTION_GET,
-					    sizeof(*msg), s);
+					    sizeof(struct scmi_msg_sensor_axis_description_get),
+					    s);
 	if (IS_ERR(iter))
 		return PTR_ERR(iter);
 
diff --git a/drivers/firmware/arm_scmi/voltage.c b/drivers/firmware/arm_scmi/voltage.c
index 9d195d8719ab..97df6d3dd131 100644
--- a/drivers/firmware/arm_scmi/voltage.c
+++ b/drivers/firmware/arm_scmi/voltage.c
@@ -180,7 +180,6 @@ static int scmi_voltage_levels_get(const struct scmi_protocol_handle *ph,
 {
 	int ret;
 	void *iter;
-	struct scmi_msg_cmd_describe_levels *msg;
 	struct scmi_iterator_ops ops = {
 		.prepare_message = iter_volt_levels_prepare_message,
 		.update_state = iter_volt_levels_update_state,
@@ -193,7 +192,8 @@ static int scmi_voltage_levels_get(const struct scmi_protocol_handle *ph,
 
 	iter = ph->hops->iter_response_init(ph, &ops, v->num_levels,
 					    VOLTAGE_DESCRIBE_LEVELS,
-					    sizeof(*msg), &vpriv);
+					    sizeof(struct scmi_msg_cmd_describe_levels),
+					    &vpriv);
 	if (IS_ERR(iter))
 		return PTR_ERR(iter);
 
-- 
2.32.0

