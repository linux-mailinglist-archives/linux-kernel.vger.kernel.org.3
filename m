Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D304542CBB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbiFHKLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbiFHKKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:10:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59B211F98D4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:55:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3857C14BF;
        Wed,  8 Jun 2022 02:55:48 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C8CA3F73B;
        Wed,  8 Jun 2022 02:55:47 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        Peter Hilber <peter.hilber@opensynergy.com>
Subject: [PATCH 3/3] firmware: arm_scmi: Use preferred strscpy to handle strings
Date:   Wed,  8 Jun 2022 10:55:30 +0100
Message-Id: <20220608095530.497879-3-cristian.marussi@arm.com>
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

Remove strlcpy calls used to collect short domain names of SCMI resources
in favour of the preferred strscpy; while doing that change also the used
count argument of strscpy to make always use of SCMI_SHORT_NAME_MAX_SIZE
while dealing with short domain names, so as to limit the possibility that
an ill-formed non-NULL terminated short reply from the SCMI platform
firmware can leak stale content laying in the underlying transport shared
memory area.

Cc: Peter Hilber <peter.hilber@opensynergy.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Fixes: ca64b719a1e66 ("firmware: arm_scmi: use strlcpy to ensure NULL-terminated strings")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c   | 2 +-
 drivers/firmware/arm_scmi/perf.c    | 2 +-
 drivers/firmware/arm_scmi/power.c   | 2 +-
 drivers/firmware/arm_scmi/reset.c   | 2 +-
 drivers/firmware/arm_scmi/sensors.c | 4 ++--
 drivers/firmware/arm_scmi/voltage.c | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 1a718faa4192..c7a83f6e38e5 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -153,7 +153,7 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 	if (!ret) {
 		u32 latency = 0;
 		attributes = le32_to_cpu(attr->attributes);
-		strlcpy(clk->name, attr->name, SCMI_MAX_STR_SIZE);
+		strscpy(clk->name, attr->name, SCMI_SHORT_NAME_MAX_SIZE);
 		/* clock_enable_latency field is present only since SCMI v3.1 */
 		if (PROTOCOL_REV_MAJOR(version) >= 0x2)
 			latency = le32_to_cpu(attr->clock_enable_latency);
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index c1f701623058..bbb0331801ff 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -252,7 +252,7 @@ scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
 			dom_info->mult_factor =
 					(dom_info->sustained_freq_khz * 1000) /
 					dom_info->sustained_perf_level;
-		strlcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
+		strscpy(dom_info->name, attr->name, SCMI_SHORT_NAME_MAX_SIZE);
 	}
 
 	ph->xops->xfer_put(ph, t);
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index 964882cc8747..356e83631664 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -122,7 +122,7 @@ scmi_power_domain_attributes_get(const struct scmi_protocol_handle *ph,
 		dom_info->state_set_notify = SUPPORTS_STATE_SET_NOTIFY(flags);
 		dom_info->state_set_async = SUPPORTS_STATE_SET_ASYNC(flags);
 		dom_info->state_set_sync = SUPPORTS_STATE_SET_SYNC(flags);
-		strlcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
+		strscpy(dom_info->name, attr->name, SCMI_SHORT_NAME_MAX_SIZE);
 	}
 	ph->xops->xfer_put(ph, t);
 
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index a420a9102094..673f3eb498f4 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -116,7 +116,7 @@ scmi_reset_domain_attributes_get(const struct scmi_protocol_handle *ph,
 		dom_info->latency_us = le32_to_cpu(attr->latency);
 		if (dom_info->latency_us == U32_MAX)
 			dom_info->latency_us = 0;
-		strlcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
+		strscpy(dom_info->name, attr->name, SCMI_SHORT_NAME_MAX_SIZE);
 	}
 
 	ph->xops->xfer_put(ph, t);
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 58fe4f0175be..42efaee27b7c 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -412,7 +412,7 @@ iter_axes_desc_process_response(const struct scmi_protocol_handle *ph,
 	attrh = le32_to_cpu(adesc->attributes_high);
 	a->scale = S32_EXT(SENSOR_SCALE(attrh));
 	a->type = SENSOR_TYPE(attrh);
-	strscpy(a->name, adesc->name, SCMI_MAX_STR_SIZE);
+	strscpy(a->name, adesc->name, SCMI_SHORT_NAME_MAX_SIZE);
 
 	if (a->extended_attrs) {
 		unsigned int ares = le32_to_cpu(adesc->resolution);
@@ -633,7 +633,7 @@ iter_sens_descr_process_response(const struct scmi_protocol_handle *ph,
 			    SUPPORTS_AXIS(attrh) ?
 			    SENSOR_AXIS_NUMBER(attrh) : 0,
 			    SCMI_MAX_NUM_SENSOR_AXIS);
-	strscpy(s->name, sdesc->name, SCMI_MAX_STR_SIZE);
+	strscpy(s->name, sdesc->name, SCMI_SHORT_NAME_MAX_SIZE);
 
 	/*
 	 * If supported overwrite short name with the extended
diff --git a/drivers/firmware/arm_scmi/voltage.c b/drivers/firmware/arm_scmi/voltage.c
index 97df6d3dd131..5de93f637bd4 100644
--- a/drivers/firmware/arm_scmi/voltage.c
+++ b/drivers/firmware/arm_scmi/voltage.c
@@ -233,7 +233,7 @@ static int scmi_voltage_descriptors_get(const struct scmi_protocol_handle *ph,
 		v = vinfo->domains + dom;
 		v->id = dom;
 		attributes = le32_to_cpu(resp_dom->attr);
-		strlcpy(v->name, resp_dom->name, SCMI_MAX_STR_SIZE);
+		strscpy(v->name, resp_dom->name, SCMI_SHORT_NAME_MAX_SIZE);
 
 		/*
 		 * If supported overwrite short name with the extended one;
-- 
2.32.0

