Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323AF5B2215
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiIHP0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiIHPZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:25:25 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCC89C516;
        Thu,  8 Sep 2022 08:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662650724; x=1694186724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IX5UEpdtuF5NN7hdB2SMbfncKVJ+CsfmQwFgfWwMAO0=;
  b=FDeImJAE79j9bxzAhYBGjrBQeiG6TTLZL7kCdWsORgzl/DlTBzZLskP0
   ioThxfIsFLhl4d4j01I6qbOBnpgqZCEdPOGgiRD5lgQlTmBH+/u8i3F4C
   KFZfkMfQp/45rpz++rVH8rwgfE3q3FLcX/cnG8uVE+PvWobSpLgn8sJV3
   4=;
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-b27d4a00.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 15:25:12 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-b27d4a00.us-east-1.amazon.com (Postfix) with ESMTPS id 6318E81116;
        Thu,  8 Sep 2022 15:25:10 +0000 (UTC)
Received: from EX19D013UWB004.ant.amazon.com (10.13.138.62) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 8 Sep 2022 15:24:53 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D013UWB004.ant.amazon.com (10.13.138.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.12; Thu, 8 Sep 2022 15:24:52 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Thu, 8 Sep 2022 15:24:52 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 863AB4D39; Thu,  8 Sep 2022 15:24:49 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <andriy.shevchenko@intel.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>
Subject: [PATCH v5 20/21] hwmon: (mr75203) add debugfs to read and write temperature coefficients
Date:   Thu, 8 Sep 2022 15:24:48 +0000
Message-ID: <20220908152449.35457-21-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220908152449.35457-1-farbere@amazon.com>
References: <20220908152449.35457-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
V5 -> V4:
- Return j coefficient to use debugfs_create_file() instead of
  debugfs_create_u32() because j is signed.

V4 -> V3:
- Remove check of the debugfs_create_dir() return value.
- Use debugfs_create_u32() instead of debugfs_create_file().
- Return devm_add_action_or_reset() without checking return value and printing
  an error message on failure.

 drivers/hwmon/mr75203.c | 62 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 07668545c3ae..e6b49f810307 100644
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
@@ -179,6 +181,64 @@ struct pvt_device {
 	u32			ip_freq;
 };
 
+static ssize_t pvt_ts_coeff_j_read(struct file *file, char __user *user_buf,
+				   size_t count, loff_t *ppos)
+{
+	struct pvt_device *pvt = file->private_data;
+	unsigned int len;
+	char buf[13];
+
+	len = scnprintf(buf, sizeof(buf), "%d\n", pvt->ts_coeff.j);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static ssize_t pvt_ts_coeff_j_write(struct file *file,
+				    const char __user *user_buf,
+				    size_t count, loff_t *ppos)
+{
+	struct pvt_device *pvt = file->private_data;
+	int ret;
+
+	ret = kstrtos32_from_user(user_buf, count, 0, &pvt->ts_coeff.j);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static const struct file_operations pvt_ts_coeff_j_fops = {
+	.read = pvt_ts_coeff_j_read,
+	.write = pvt_ts_coeff_j_write,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
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
+	debugfs_create_u32("ts_coeff_cal5", 0644, pvt->dbgfs_dir,
+			   &pvt->ts_coeff.cal5);
+	debugfs_create_file("ts_coeff_j", 0644, pvt->dbgfs_dir, pvt,
+			    &pvt_ts_coeff_j_fops);
+
+	return devm_add_action_or_reset(dev, devm_pvt_ts_dbgfs_remove, pvt);
+}
+
 static umode_t pvt_is_visible(const void *data, enum hwmon_sensor_types type,
 			      u32 attr, int channel)
 {
@@ -813,6 +873,8 @@ static int mr75203_probe(struct platform_device *pdev)
 		memset32(temp_config, HWMON_T_INPUT, ts_num);
 		pvt_temp.config = temp_config;
 		pvt_info[index++] = &pvt_temp;
+
+		pvt_ts_dbgfs_create(pvt, dev);
 	}
 
 	if (pd_num) {
-- 
2.37.1

