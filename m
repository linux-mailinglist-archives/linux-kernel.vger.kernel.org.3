Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58B246131A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240226AbhK2LJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:09:18 -0500
Received: from comms.puri.sm ([159.203.221.185]:40264 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240713AbhK2LHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:07:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id DE16CE1137;
        Mon, 29 Nov 2021 03:03:59 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id evOY7719MzEi; Mon, 29 Nov 2021 03:03:59 -0800 (PST)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, kernel@puri.sm,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Subject: [PATCH] thermal: qoriq: Only enable sites that actually exist
Date:   Mon, 29 Nov 2021 12:02:53 +0100
Message-Id: <20211129110252.1699112-1-sebastian.krzyszkowiak@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX8MQ, enabling monitoring sites that aren't connected to anything
can cause unwanted side effects on some units. This seems to happen
once some of these sites report out-of-range readings and results in
sensor misbehavior, such as thermal zone readings getting stuck or even
suddenly reporting an impossibly high value, triggering emergency
shutdowns.

The datasheet lists all non-existent sites as "reserved" and doesn't
make any guarantees about being able to enable them at all, so let's
not do that.

Fixes: 45038e03d633 ("thermal: qoriq: Enable all sensors before registering them")

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 drivers/thermal/qoriq_thermal.c | 63 ++++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 73049f9bea25..ef0848849ee2 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -32,7 +32,6 @@
 #define TMR_DISABLE	0x0
 #define TMR_ME		0x80000000
 #define TMR_ALPF	0x0c000000
-#define TMR_MSITE_ALL	GENMASK(15, 0)
 
 #define REGS_TMTMIR	0x008	/* Temperature measurement interval Register */
 #define TMTMIR_DEFAULT	0x0000000f
@@ -129,33 +128,51 @@ static const struct thermal_zone_of_device_ops tmu_tz_ops = {
 static int qoriq_tmu_register_tmu_zone(struct device *dev,
 				       struct qoriq_tmu_data *qdata)
 {
-	int id;
+	int ret = 0;
+	struct device_node *np, *child, *sensor_np;
 
-	if (qdata->ver == TMU_VER1) {
-		regmap_write(qdata->regmap, REGS_TMR,
-			     TMR_MSITE_ALL | TMR_ME | TMR_ALPF);
-	} else {
-		regmap_write(qdata->regmap, REGS_V2_TMSR, TMR_MSITE_ALL);
-		regmap_write(qdata->regmap, REGS_TMR, TMR_ME | TMR_ALPF_V2);
-	}
+	np = of_find_node_by_name(NULL, "thermal-zones");
+	if (!np)
+		return -ENODEV;
+
+	sensor_np = of_node_get(dev->of_node);
 
-	for (id = 0; id < SITES_MAX; id++) {
+	for_each_available_child_of_node(np, child) {
 		struct thermal_zone_device *tzd;
-		struct qoriq_sensor *sensor = &qdata->sensor[id];
-		int ret;
+		struct qoriq_sensor *sensor;
+		int id, site;
+
+		ret = thermal_zone_of_get_sensor_id(child, sensor_np, &id);
+
+		if (ret < 0) {
+			dev_err(dev, "failed to get valid sensor id: %d\n", ret);
+			of_node_put(child);
+			break;
+		}
 
+		sensor = &qdata->sensor[id];
 		sensor->id = id;
 
+		/* Enable monitoring */
+		if (qdata->ver == TMU_VER1) {
+			site = 0x1 << (15 - id);
+			regmap_update_bits(qdata->regmap, REGS_TMR,
+					   site | TMR_ME | TMR_ALPF,
+					   site | TMR_ME | TMR_ALPF);
+		} else {
+			site = 0x1 << id;
+			regmap_update_bits(qdata->regmap, REGS_V2_TMSR, site, site);
+			regmap_write(qdata->regmap, REGS_TMR, TMR_ME | TMR_ALPF_V2);
+		}
+
 		tzd = devm_thermal_zone_of_sensor_register(dev, id,
 							   sensor,
 							   &tmu_tz_ops);
-		ret = PTR_ERR_OR_ZERO(tzd);
-		if (ret) {
-			if (ret == -ENODEV)
-				continue;
-
-			regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);
-			return ret;
+		if (IS_ERR(tzd)) {
+			ret = PTR_ERR(tzd);
+			dev_err(dev, "failed to register thermal zone: %d\n", ret);
+			of_node_put(child);
+			break;
 		}
 
 		if (devm_thermal_add_hwmon_sysfs(tzd))
@@ -164,7 +181,13 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 
 	}
 
-	return 0;
+	of_node_put(sensor_np);
+	of_node_put(np);
+
+	if (ret)
+		regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);
+
+	return ret;
 }
 
 static int qoriq_tmu_calibration(struct device *dev,
-- 
2.34.1

