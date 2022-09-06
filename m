Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6884D5AE32B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbiIFIkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239671AbiIFIjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:39:22 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC4571710;
        Tue,  6 Sep 2022 01:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662453450; x=1693989450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B83zy8/Sbonf+5Qnjl59QhloJcwP7RKcwdhzViFyxfE=;
  b=wID3JtrRCKuboMcbNy1Hl47oUUeCvymRJ5Azv+y7Yu+DVH8tBH0Y1xOt
   9LldVyvjKmtCmZvphSS+DoMxLQrMJvlzruIy354/mpV8MQQPDU7DC/v5+
   qib17L/XA4DYZYaKTBw3vPzM9q+Z/ZPNr/NSHuvzHHSnNP+D4rjrnBEhI
   o=;
X-IronPort-AV: E=Sophos;i="5.93,293,1654560000"; 
   d="scan'208";a="127050136"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-4ba5c7da.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 08:34:41 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-4ba5c7da.us-east-1.amazon.com (Postfix) with ESMTPS id 4B824E05AD;
        Tue,  6 Sep 2022 08:34:38 +0000 (UTC)
Received: from EX19D013UWB003.ant.amazon.com (10.13.138.111) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 6 Sep 2022 08:33:59 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX19D013UWB003.ant.amazon.com (10.13.138.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Tue, 6 Sep 2022 08:33:59 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 6 Sep 2022 08:33:58 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id CA5424D76; Tue,  6 Sep 2022 08:33:57 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        <andriy.shevchenko@intel.com>
Subject: [PATCH v4 21/21] hwmon: (mr75203) add debugfs to read and write temperature coefficients
Date:   Tue, 6 Sep 2022 08:33:56 +0000
Message-ID: <20220906083356.21067-22-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220906083356.21067-1-farbere@amazon.com>
References: <20220906083356.21067-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds debugfs to read and write temperature sensor coefficients
- g, h, j and cal5.

The coefficients can vary between product and product, so it can be very
useful to be able to modify them on the fly during the calibration
process.

e.g.:

cat /sys/kernel/debug/940f23d0000.pvt/ts_coeff_cal5
4096

echo 83000 > sys/kernel/debug/940f23d0000.pvt/ts_coeff_g

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
V4 -> V3:
- Remove check of the debugfs_create_dir() return value.
- Use debugfs_create_u32() instead of debugfs_create_file().
- Return devm_add_action_or_reset() without checking return value and printing
  an error message on failure.

 drivers/hwmon/mr75203.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 8baa99a9ea83..e3670075fae4 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -9,6 +9,7 @@
  */
 #include <linux/bits.h>
 #include <linux/clk.h>
+#include <linux/debugfs.h>
 #include <linux/hwmon.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
@@ -170,6 +171,7 @@ struct pvt_device {
 	struct regmap		*v_map;
 	struct clk		*clk;
 	struct reset_control	*rst;
+	struct dentry		*dbgfs_dir;
 	struct voltage_device	*vd;
 	struct voltage_channels	vm_channels;
 	struct temp_coeff	ts_coeff;
@@ -179,6 +181,30 @@ struct pvt_device {
 	u32			ip_freq;
 };
 
+static void devm_pvt_ts_dbgfs_remove(void *data)
+{
+	struct pvt_device *pvt = (struct pvt_device *)data;
+
+	debugfs_remove_recursive(pvt->dbgfs_dir);
+	pvt->dbgfs_dir = NULL;
+}
+
+static int pvt_ts_dbgfs_create(struct pvt_device *pvt, struct device *dev)
+{
+	pvt->dbgfs_dir = debugfs_create_dir(dev_name(dev), NULL);
+
+	debugfs_create_u32("ts_coeff_h", 0644, pvt->dbgfs_dir,
+			   &pvt->ts_coeff.h);
+	debugfs_create_u32("ts_coeff_g", 0644, pvt->dbgfs_dir,
+			   &pvt->ts_coeff.g);
+	debugfs_create_u32("ts_coeff_j", 0644, pvt->dbgfs_dir,
+			   &pvt->ts_coeff.j);
+	debugfs_create_u32("ts_coeff_cal5", 0644, pvt->dbgfs_dir,
+			   &pvt->ts_coeff.cal5);
+
+	return devm_add_action_or_reset(dev, devm_pvt_ts_dbgfs_remove, pvt);
+}
+
 static umode_t pvt_is_visible(const void *data, enum hwmon_sensor_types type,
 			      u32 attr, int channel)
 {
@@ -803,6 +829,8 @@ static int mr75203_probe(struct platform_device *pdev)
 		memset32(temp_config, HWMON_T_INPUT, ts_num);
 		pvt_temp.config = temp_config;
 		pvt_info[index++] = &pvt_temp;
+
+		pvt_ts_dbgfs_create(pvt, dev);
 	}
 
 	if (pd_num) {
-- 
2.37.1

