Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8F649B94B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1585812AbiAYQpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:45:01 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:23715 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346610AbiAYQg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643128588; x=1674664588;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=0WnV+EmPb8krky3QwTcyyzwQkQl+BhKbWAGWV4smPyc=;
  b=vpfVJVu+lgJADXsRNAEROAPp5JNr06ci5m9H4ewteMbsUWuo98ICNeuO
   vDrMQud3MwG4G1kTJyH1y1JJ/iPGISu0pVHUGhiKGvkX9qxh27Okkprn2
   E43mgQ8LF5MTCtHiCVE7Hf40HAVGYGY3O31X+GRPi/yWu9+hdL5TFuyXr
   w=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 Jan 2022 08:36:24 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 08:36:24 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 25 Jan 2022 08:36:24 -0800
Received: from codeaurora.org (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 25 Jan
 2022 08:36:21 -0800
From:   Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
To:     Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Amit Kucheria" <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Manaf Meethalavalappu Pallikunhi" <quic_manafm@quicinc.com>
Subject: [PATCH v4] drivers: thermal: clear all mitigation when thermal zone is disabled
Date:   Tue, 25 Jan 2022 22:06:05 +0530
Message-ID: <1643128565-22838-1-git-send-email-quic_manafm@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever a thermal zone is in trip violated state, there is a chance
that the same thermal zone mode can be disabled either via
thermal core API or via thermal zone sysfs. Once it is disabled,
the framework bails out any re-evaluation of thermal zone. It leads
to a case where if it is already in mitigation state, it will stay
the same state forever.

To avoid above mentioned issue, add support to bind/unbind
governor from thermal zone during thermal zone mode change request
and clear all existing throttling in governor unbind_from_tz()
callback.

Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
---
 drivers/thermal/gov_power_allocator.c |  3 +++
 drivers/thermal/gov_step_wise.c       | 26 ++++++++++++++++++++++++++
 drivers/thermal/thermal_core.c        | 31 +++++++++++++++++++++++++++----
 3 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 13e3757..9ff0c5f 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -696,6 +696,9 @@ static void power_allocator_unbind(struct thermal_zone_device *tz)
 
 	dev_dbg(&tz->device, "Unbinding from thermal zone %d\n", tz->id);
 
+	tz->passive = 0;
+	allow_maximum_power(tz, true);
+
 	if (params->allocated_tzp) {
 		kfree(tz->tzp);
 		tz->tzp = NULL;
diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index 12acb12..2132c14 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -168,6 +168,31 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 }
 
 /**
+ * step_wise_unbind() - unbind the step_wise governor to a thermal zone
+ * @tz:	thermal zone to unbind it to
+ *
+ * Clear all previous throttling and reset passive counter.
+ *
+ */
+static void step_wise_unbind(struct thermal_zone_device *tz)
+{
+	struct thermal_instance *instance;
+
+	dev_dbg(&tz->device, "Unbinding from thermal zone %d\n", tz->id);
+
+	mutex_lock(&tz->lock);
+	tz->passive = 0;
+	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+		instance->initialized = false;
+		instance->target = THERMAL_NO_TARGET;
+		mutex_lock(&instance->cdev->lock);
+		 __thermal_cdev_update(instance->cdev);
+		mutex_unlock(&instance->cdev->lock);
+	}
+	mutex_unlock(&tz->lock);
+}
+
+/**
  * step_wise_throttle - throttles devices associated with the given zone
  * @tz: thermal_zone_device
  * @trip: trip point index
@@ -196,6 +221,7 @@ static int step_wise_throttle(struct thermal_zone_device *tz, int trip)
 
 static struct thermal_governor thermal_gov_step_wise = {
 	.name		= "step_wise",
+	.unbind_from_tz	= step_wise_unbind,
 	.throttle	= step_wise_throttle,
 };
 THERMAL_GOVERNOR_DECLARE(thermal_gov_step_wise);
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 1389174..9828eb3 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -274,6 +274,26 @@ static int __init thermal_register_governors(void)
 	return ret;
 }
 
+static void thermal_governor_attach(struct thermal_zone_device *tz)
+{
+	mutex_lock(&thermal_governor_lock);
+	if (tz->governor && tz->governor->bind_to_tz) {
+		if (tz->governor->bind_to_tz(tz))
+			dev_err(&tz->device,
+				"governor %s failed to bind to thermal zone %s\n",
+				tz->governor->name, tz->type);
+	}
+	mutex_unlock(&thermal_governor_lock);
+}
+
+static void thermal_governor_detach(struct thermal_zone_device *tz)
+{
+	mutex_lock(&thermal_governor_lock);
+	if (tz->governor && tz->governor->unbind_from_tz)
+		tz->governor->unbind_from_tz(tz);
+	mutex_unlock(&thermal_governor_lock);
+}
+
 /*
  * Zone update section: main control loop applied to each zone while monitoring
  *
@@ -447,12 +467,15 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 
 	mutex_unlock(&tz->lock);
 
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
-
-	if (mode == THERMAL_DEVICE_ENABLED)
+	if (mode == THERMAL_DEVICE_ENABLED) {
+		thermal_governor_attach(tz);
+		thermal_zone_device_init(tz);
+		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 		thermal_notify_tz_enable(tz->id);
-	else
+	} else {
+		thermal_governor_detach(tz);
 		thermal_notify_tz_disable(tz->id);
+	}
 
 	return ret;
 }
