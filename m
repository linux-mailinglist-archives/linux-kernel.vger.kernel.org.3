Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26392513B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 19:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350635AbiD1Rww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 13:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240271AbiD1Rwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 13:52:50 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B73BAB8C;
        Thu, 28 Apr 2022 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1651168176; x=1682704176;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=qo6jg5LipZrMgiLJ4jQ6Jvz7qThlbvhz0K01yeV8P5I=;
  b=JESb1nSFuEq8xC3spN54Tm0lQyb3JFhbAA3jAfHfVAF+W9C4mwO/30p6
   FVzcZgC23m7XWGyNdzZLlaXHQPoKRPL+Y0zSnt1bm4MnpV5MBThKXR+Hj
   MTvKqaJwVrPewKO7lJdlKL8F2cOY+Ew6x1C3yISuUOI809EgOTpgWIkKg
   I=;
X-IronPort-AV: E=Sophos;i="5.91,296,1647302400"; 
   d="scan'208";a="214791997"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-90d70b14.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 28 Apr 2022 17:49:35 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-90d70b14.us-east-1.amazon.com (Postfix) with ESMTPS id EEC4FC08BA;
        Thu, 28 Apr 2022 17:49:32 +0000 (UTC)
Received: from EX13D05UWC004.ant.amazon.com (10.43.162.223) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Thu, 28 Apr 2022 17:49:32 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D05UWC004.ant.amazon.com (10.43.162.223) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Thu, 28 Apr 2022 17:49:31 +0000
Received: from localhost (10.107.60.87) by mail-relay.amazon.com
 (10.43.60.234) with Microsoft SMTP Server id 15.0.1497.32 via Frontend
 Transport; Thu, 28 Apr 2022 17:49:30 +0000
From:   Eduardo Valentin <eduval@amazon.com>
To:     Guenter Roeck <linux@roeck-us.net>, <eduval@amazon.com>
CC:     Jean Delvare <jdelvare@suse.com>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <evalenti@kernel.org>
Subject: [PATCHv2 1/1] drivers: hwmon: pmbus: register with thermal for PSC_TEMPERATURE
Date:   Thu, 28 Apr 2022 10:49:26 -0700
Message-ID: <20220428174926.2150-1-eduval@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-15.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL autolearn=ham
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
V2: Incorporated Guenter's suggestion to use pmbus_data as field of pmbus_thermal_data.

---
 drivers/hwmon/pmbus/pmbus_core.c | 68 ++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 776ee2237be2..371d16e3bac6 100644
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
@@ -1078,6 +1080,68 @@ static int pmbus_add_boolean(struct pmbus_data *data,
 	return pmbus_add_attribute(data, &a->dev_attr.attr);
 }
 
+/* of thermal for pmbus temperature sensors */
+struct pmbus_thermal_data {
+	struct pmbus_data *pmbus_data;
+	struct pmbus_sensor *sensor;
+};
+
+static int pmbus_thermal_get_temp(void *data, int *temp)
+{
+	struct pmbus_thermal_data *tdata = data;
+	struct pmbus_sensor *sensor = tdata->sensor;
+	struct pmbus_data *pmbus_data = tdata->pmbus_data;
+	struct i2c_client *client = to_i2c_client(pmbus_data->dev);
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
+static int pmbus_thermal_add_sensor(struct pmbus_data *pmbus_data,
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
+	tdata->pmbus_data = pmbus_data;
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
 static struct pmbus_sensor *pmbus_add_sensor(struct pmbus_data *data,
 					     const char *name, const char *type,
 					     int seq, int page, int phase,
@@ -1121,6 +1185,10 @@ static struct pmbus_sensor *pmbus_add_sensor(struct pmbus_data *data,
 	sensor->next = data->sensors;
 	data->sensors = sensor;
 
+	/* temperature sensors with _input values are registered with thermal */
+	if (class == PSC_TEMPERATURE && strcmp(type, "input") == 0)
+		pmbus_thermal_add_sensor(data, sensor, seq);
+
 	return sensor;
 }
 
-- 
2.17.1

