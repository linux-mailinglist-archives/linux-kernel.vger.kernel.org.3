Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EA64E3619
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 02:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbiCVBsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 21:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbiCVBs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 21:48:26 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC5F377CA;
        Mon, 21 Mar 2022 18:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1647913617; x=1679449617;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=LXdAWfbEEyMtMPiS0cq35JyKZEaDBL+llZxzocq1lNE=;
  b=AAAI85nzhHSrQK+pcI1rvgT3yWNAxPCnGpDN7fWTWhkb4XxR8GFGcx6T
   ZCtGkibFHtLNX3Fl1wJMoKbqqVi6ucfxEfmrSTFY9v9eMoW/bq3YruA8r
   ZHNvXHXQ5qMUeb8InMRHvnH0k87JNUeRuy9UneGuIXHXTmueVd4yk4fWx
   M=;
X-IronPort-AV: E=Sophos;i="5.90,200,1643673600"; 
   d="scan'208";a="183544633"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-ff3df2fe.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP; 22 Mar 2022 01:46:55 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-ff3df2fe.us-west-2.amazon.com (Postfix) with ESMTPS id 947E440BC2;
        Tue, 22 Mar 2022 01:46:54 +0000 (UTC)
Received: from EX13D05UWC004.ant.amazon.com (10.43.162.223) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Tue, 22 Mar 2022 01:46:54 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D05UWC004.ant.amazon.com (10.43.162.223) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Tue, 22 Mar 2022 01:46:53 +0000
Received: from localhost (10.187.171.8) by mail-relay.amazon.com
 (10.43.61.169) with Microsoft SMTP Server id 15.0.1497.32 via Frontend
 Transport; Tue, 22 Mar 2022 01:46:53 +0000
From:   Eduardo Valentin <eduval@amazon.com>
To:     Guenter Roeck <linux@roeck-us.net>, <eduval@amazon.com>
CC:     Jean Delvare <jdelvare@suse.com>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <evalenti@kernel.org>
Subject: [PATCH 1/1] drivers: hwmon: pmbus: register with thermal for PSC_TEMPERATURE
Date:   Mon, 21 Mar 2022 18:46:50 -0700
Message-ID: <20220322014650.14956-1-eduval@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-13.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some pmbus device drivers have device tree support and
may want to use of-thermal to register a thermal zone
OF sensor for those device drivers.

This way we allow describing device tree thermal zones
for pmbus device drivers with device tree support.

This patch achieves this by registering pmbus sensors
with thermal subsystem if they are PSC_TEMPERATURE
and are providing _input hwmon interface.

Cc: Guenter Roeck <linux@roeck-us.net> (maintainer:PMBUS HARDWARE MONITORING DRIVERS)
Cc: Jean Delvare <jdelvare@suse.com> (maintainer:HARDWARE MONITORING)
Cc: linux-hwmon@vger.kernel.org (open list:PMBUS HARDWARE MONITORING DRIVERS)
Cc: linux-kernel@vger.kernel.org (open list)
Signed-off-by: Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Eduardo Valentin <evalenti@kernel.org>
---
 drivers/hwmon/pmbus/pmbus_core.c | 88 +++++++++++++++++++++++++++++---
 1 file changed, 80 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 776ee2237be2..a51cdfab1c3e 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -19,6 +19,8 @@
 #include <linux/pmbus.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
+#include <linux/of.h>
+#include <linux/thermal.h>
 #include "pmbus.h"
 
 /*
@@ -1078,7 +1080,71 @@ static int pmbus_add_boolean(struct pmbus_data *data,
 	return pmbus_add_attribute(data, &a->dev_attr.attr);
 }
 
-static struct pmbus_sensor *pmbus_add_sensor(struct pmbus_data *data,
+/* of thermal for pmbus temperature sensors */
+struct pmbus_thermal_data {
+	struct i2c_client *client;
+	struct pmbus_sensor *sensor;
+};
+
+static int pmbus_thermal_get_temp(void *data, int *temp)
+{
+	struct pmbus_thermal_data *tdata = data;
+	struct i2c_client *client = tdata->client;
+	struct pmbus_sensor *sensor = tdata->sensor;
+	struct pmbus_data *pmbus_data = i2c_get_clientdata(client);
+	struct device *dev = pmbus_data->hwmon_dev;
+	int ret = 0;
+
+	if (!dev) {
+		/* May not even get to hwmon yet */
+		*temp = 0;
+		return 0;
+	}
+
+	mutex_lock(&pmbus_data->update_lock);
+	pmbus_update_sensor_data(client, sensor);
+	if (sensor->data < 0)
+		ret = sensor->data;
+	else
+		*temp = (int)pmbus_reg2data(pmbus_data, sensor);
+	mutex_unlock(&pmbus_data->update_lock);
+
+	return ret;
+}
+
+static const struct thermal_zone_of_device_ops pmbus_thermal_ops = {
+	.get_temp = pmbus_thermal_get_temp,
+};
+
+static int pmbus_thermal_add_sensor(struct i2c_client *client,
+				    struct pmbus_data *pmbus_data,
+				    struct pmbus_sensor *sensor, int index)
+{
+	struct device *dev = pmbus_data->dev;
+	struct pmbus_thermal_data *tdata;
+	struct thermal_zone_device *tzd;
+
+	tdata = devm_kzalloc(dev, sizeof(*tdata), GFP_KERNEL);
+	if (!tdata)
+		return -ENOMEM;
+
+	tdata->sensor = sensor;
+	tdata->client = client;
+
+	tzd = devm_thermal_zone_of_sensor_register(dev, index, tdata,
+						   &pmbus_thermal_ops);
+	/*
+	 * If CONFIG_THERMAL_OF is disabled, this returns -ENODEV,
+	 * so ignore that error but forward any other error.
+	 */
+	if (IS_ERR(tzd) && (PTR_ERR(tzd) != -ENODEV))
+		return PTR_ERR(tzd);
+
+	return 0;
+}
+
+static struct pmbus_sensor *pmbus_add_sensor(struct i2c_client *client,
+					     struct pmbus_data *data,
 					     const char *name, const char *type,
 					     int seq, int page, int phase,
 					     int reg,
@@ -1121,6 +1187,10 @@ static struct pmbus_sensor *pmbus_add_sensor(struct pmbus_data *data,
 	sensor->next = data->sensors;
 	data->sensors = sensor;
 
+	/* temperature sensors with _input values are registered with thermal */
+	if (class == PSC_TEMPERATURE && strcmp(type, "input") == 0)
+		pmbus_thermal_add_sensor(client, data, sensor, seq);
+
 	return sensor;
 }
 
@@ -1216,8 +1286,9 @@ static int pmbus_add_limit_attrs(struct i2c_client *client,
 
 	for (i = 0; i < nlimit; i++) {
 		if (pmbus_check_word_register(client, page, l->reg)) {
-			curr = pmbus_add_sensor(data, name, l->attr, index,
-						page, 0xff, l->reg, attr->class,
+			curr = pmbus_add_sensor(client, data, name, l->attr,
+						index, page, 0xff, l->reg,
+						attr->class,
 						attr->update || l->update,
 						false, true);
 			if (!curr)
@@ -1258,7 +1329,7 @@ static int pmbus_add_sensor_attrs_one(struct i2c_client *client,
 		if (ret)
 			return ret;
 	}
-	base = pmbus_add_sensor(data, name, "input", index, page, phase,
+	base = pmbus_add_sensor(client, data, name, "input", index, page, phase,
 				attr->reg, attr->class, true, true, true);
 	if (!base)
 		return -ENOMEM;
@@ -1887,7 +1958,7 @@ static int pmbus_add_fan_ctrl(struct i2c_client *client,
 {
 	struct pmbus_sensor *sensor;
 
-	sensor = pmbus_add_sensor(data, "fan", "target", index, page,
+	sensor = pmbus_add_sensor(client, data, "fan", "target", index, page,
 				  0xff, PMBUS_VIRT_FAN_TARGET_1 + id, PSC_FAN,
 				  false, false, true);
 
@@ -1898,14 +1969,14 @@ static int pmbus_add_fan_ctrl(struct i2c_client *client,
 			(data->info->func[page] & PMBUS_HAVE_PWM34)))
 		return 0;
 
-	sensor = pmbus_add_sensor(data, "pwm", NULL, index, page,
+	sensor = pmbus_add_sensor(client, data, "pwm", NULL, index, page,
 				  0xff, PMBUS_VIRT_PWM_1 + id, PSC_PWM,
 				  false, false, true);
 
 	if (!sensor)
 		return -ENOMEM;
 
-	sensor = pmbus_add_sensor(data, "pwm", "enable", index, page,
+	sensor = pmbus_add_sensor(client, data, "pwm", "enable", index, page,
 				  0xff, PMBUS_VIRT_PWM_ENABLE_1 + id, PSC_PWM,
 				  true, false, false);
 
@@ -1947,7 +2018,8 @@ static int pmbus_add_fan_attributes(struct i2c_client *client,
 			    (!(regval & (PB_FAN_1_INSTALLED >> ((f & 1) * 4)))))
 				continue;
 
-			if (pmbus_add_sensor(data, "fan", "input", index,
+			if (pmbus_add_sensor(client, data, "fan",
+					     "input", index,
 					     page, 0xff, pmbus_fan_registers[f],
 					     PSC_FAN, true, true, true) == NULL)
 				return -ENOMEM;
-- 
2.17.1

