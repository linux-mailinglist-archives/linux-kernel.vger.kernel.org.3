Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381FE5A6D37
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiH3TXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiH3TXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:23:12 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D887B296;
        Tue, 30 Aug 2022 12:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1661887370; x=1693423370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oKBXIGtN7Cud54nf08PbP0K1g2Fts4xlETNbDNNSKNU=;
  b=rE+inkUa7MqImNoNuyXkUV1sPIlRC32dRRw6S8/gOXjh5lIwus9BMwll
   v3u1ktopEHjNvwVyHP1E0NMCfC1otV5b5plEJOqvla/keTgnRNstC8U8n
   fPQjz39FiwzsexiIi4ImRJQ6GWlRPWoMMB/VtdbjWXFLvRn+i6fdxDD9y
   g=;
X-IronPort-AV: E=Sophos;i="5.93,275,1654560000"; 
   d="scan'208";a="235792567"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-c92fe759.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 19:22:42 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-c92fe759.us-east-1.amazon.com (Postfix) with ESMTPS id E152CC0920;
        Tue, 30 Aug 2022 19:22:38 +0000 (UTC)
Received: from EX19D013UWA004.ant.amazon.com (10.13.138.207) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 30 Aug 2022 19:22:15 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX19D013UWA004.ant.amazon.com (10.13.138.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Tue, 30 Aug 2022 19:22:15 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 30 Aug 2022 19:22:14
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 628494D43; Tue, 30 Aug 2022 19:22:12 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <ronenk@amazon.com>,
        <itamark@amazon.com>, <shellykz@amazon.com>, <shorer@amazon.com>,
        <amitlavi@amazon.com>, <almogbs@amazon.com>, <dkl@amazon.com>,
        <rahul.tanwar@linux.intel.com>, <andriy.shevchenko@intel.com>
Subject: [PATCH v3 18/19] hwmon: (mr75203) add debugfs to read and write temperature coefficients
Date:   Tue, 30 Aug 2022 19:22:11 +0000
Message-ID: <20220830192212.28570-19-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830192212.28570-1-farbere@amazon.com>
References: <20220830192212.28570-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/hwmon/mr75203.c | 196 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 196 insertions(+)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index d9fc5d225868..8c30f0521452 100644
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
@@ -153,6 +154,7 @@ struct pvt_device {
 	struct regmap		*v_map;
 	struct clk		*clk;
 	struct reset_control	*rst;
+	struct dentry		*dbgfs_dir;
 	struct voltage_device	*vd;
 	struct voltage_channels	vm_channels;
 	struct temp_coeff	ts_coeff;
@@ -162,6 +164,198 @@ struct pvt_device {
 	u32			ip_freq;
 };
 
+static ssize_t pvt_ts_coeff_h_read(struct file *file,
+				   char __user *user_buf,
+				   size_t count, loff_t *ppos)
+{
+	struct pvt_device *pvt = file->private_data;
+	char buf[16];
+	unsigned int len;
+
+	len = sprintf(buf, "%u\n", pvt->ts_coeff.h);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static ssize_t pvt_ts_coeff_h_write(struct file *file,
+				    const char __user *user_buf,
+				    size_t count, loff_t *ppos)
+{
+	struct pvt_device *pvt = file->private_data;
+	int ret;
+	u32 coeff;
+
+	ret = kstrtou32_from_user(user_buf, count, 0, &coeff);
+	if (ret)
+		return ret;
+
+	pvt->ts_coeff.h = coeff;
+
+	return count;
+}
+
+static const struct file_operations pvt_ts_coeff_h_fops = {
+	.read = pvt_ts_coeff_h_read,
+	.write = pvt_ts_coeff_h_write,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static ssize_t pvt_ts_coeff_g_read(struct file *file,
+				   char __user *user_buf,
+				   size_t count, loff_t *ppos)
+{
+	struct pvt_device *pvt = file->private_data;
+	char buf[16];
+	unsigned int len;
+
+	len = sprintf(buf, "%u\n", pvt->ts_coeff.g);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static ssize_t pvt_ts_coeff_g_write(struct file *file,
+				    const char __user *user_buf,
+				    size_t count, loff_t *ppos)
+{
+	struct pvt_device *pvt = file->private_data;
+	int ret;
+	u32 coeff;
+
+	ret = kstrtou32_from_user(user_buf, count, 0, &coeff);
+	if (ret)
+		return ret;
+
+	pvt->ts_coeff.g = coeff;
+
+	return count;
+}
+
+static const struct file_operations pvt_ts_coeff_g_fops = {
+	.read = pvt_ts_coeff_g_read,
+	.write = pvt_ts_coeff_g_write,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static ssize_t pvt_ts_coeff_j_read(struct file *file,
+				   char __user *user_buf,
+				   size_t count, loff_t *ppos)
+{
+	struct pvt_device *pvt = file->private_data;
+	char buf[16];
+	unsigned int len;
+
+	len = sprintf(buf, "%d\n", pvt->ts_coeff.j);
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
+	s32 coeff;
+
+	ret = kstrtos32_from_user(user_buf, count, 0, &coeff);
+	if (ret)
+		return ret;
+
+	pvt->ts_coeff.j = coeff;
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
+static ssize_t pvt_ts_coeff_cal5_read(struct file *file,
+				      char __user *user_buf,
+				      size_t count, loff_t *ppos)
+{
+	struct pvt_device *pvt = file->private_data;
+	char buf[16];
+	unsigned int len;
+
+	len = sprintf(buf, "%u\n", pvt->ts_coeff.cal5);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static ssize_t pvt_ts_coeff_cal5_write(struct file *file,
+				       const char __user *user_buf,
+				       size_t count, loff_t *ppos)
+{
+	struct pvt_device *pvt = file->private_data;
+	int ret;
+	u32 coeff;
+
+	ret = kstrtou32_from_user(user_buf, count, 0, &coeff);
+	if (ret)
+		return ret;
+
+	if (coeff == 0)
+		return -EINVAL;
+
+	pvt->ts_coeff.cal5 = coeff;
+
+	return count;
+}
+
+static const struct file_operations pvt_ts_coeff_cal5_fops = {
+	.read = pvt_ts_coeff_cal5_read,
+	.write = pvt_ts_coeff_cal5_write,
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
+	int ret;
+
+	pvt->dbgfs_dir = debugfs_create_dir(dev_name(dev), NULL);
+	if (!pvt->dbgfs_dir) {
+		dev_err(dev, "Failed to create dbgfs_dir\n");
+		return -EINVAL;
+	}
+
+	debugfs_create_file("ts_coeff_h", 0644, pvt->dbgfs_dir, pvt,
+			    &pvt_ts_coeff_h_fops);
+	debugfs_create_file("ts_coeff_g", 0644, pvt->dbgfs_dir, pvt,
+			    &pvt_ts_coeff_g_fops);
+	debugfs_create_file("ts_coeff_j", 0644, pvt->dbgfs_dir, pvt,
+			    &pvt_ts_coeff_j_fops);
+	debugfs_create_file("ts_coeff_cal5", 0644, pvt->dbgfs_dir,  pvt,
+			    &pvt_ts_coeff_cal5_fops);
+
+	ret = devm_add_action_or_reset(dev, devm_pvt_ts_dbgfs_remove, pvt);
+	if (ret) {
+		dev_err(dev, "failed to add action to remove pvt dbgfs (%d)\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static umode_t pvt_is_visible(const void *data, enum hwmon_sensor_types type,
 			      u32 attr, int channel)
 {
@@ -814,6 +1008,8 @@ static int mr75203_probe(struct platform_device *pdev)
 		memset32(temp_config, HWMON_T_INPUT, ts_num);
 		pvt_temp.config = temp_config;
 		pvt_info[index++] = &pvt_temp;
+
+		pvt_ts_dbgfs_create(pvt, dev);
 	}
 
 	if (pd_num) {
-- 
2.37.1

