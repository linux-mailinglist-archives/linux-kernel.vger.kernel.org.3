Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935325968CF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbiHQFni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbiHQFng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:43:36 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7DD78239;
        Tue, 16 Aug 2022 22:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1660715015; x=1692251015;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yKQWTXqsUyX4LcBeXNBnNfziaCies5UNS/o5L6A+j78=;
  b=u0DleJAOdusBA0p2iSE3hazDm1b0h2N9uRVKaCeeKFhAudxv3x3V3bF4
   7QZao+uZyNjS/cMdvgth3wvcW9E6vLNnffICx+dC/0kA6dWIR9kHO+6pI
   hTB97lZAMOgLSYa2crdP6iLiGxsjPxWm0GJcgI/VRQr3nzjpLkZyhiqKM
   8=;
X-IronPort-AV: E=Sophos;i="5.93,242,1654560000"; 
   d="scan'208";a="1045102089"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-388992e0.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 05:43:23 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-388992e0.us-west-2.amazon.com (Postfix) with ESMTPS id BF1F6E07AA;
        Wed, 17 Aug 2022 05:43:23 +0000 (UTC)
Received: from EX19D013UWB002.ant.amazon.com (10.13.138.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 17 Aug 2022 05:43:23 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D013UWB002.ant.amazon.com (10.13.138.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Wed, 17 Aug 2022 05:43:23 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Wed, 17 Aug 2022 05:43:22
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 9EC4E4CC3; Wed, 17 Aug 2022 05:43:21 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <ronenk@amazon.com>,
        <itamark@amazon.com>, <shellykz@amazon.com>, <shorer@amazon.com>,
        <amitlavi@amazon.com>, <almogbs@amazon.com>, <dwmw@amazon.co.uk>,
        <rtanwar@maxlinear.com>
Subject: [PATCH v2 16/16] hwmon: (mr75203) add debugfs to read and write temperature coefficients
Date:   Wed, 17 Aug 2022 05:43:21 +0000
Message-ID: <20220817054321.6519-17-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220817054321.6519-1-farbere@amazon.com>
References: <20220817054321.6519-1-farbere@amazon.com>
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

This change adds debugfs to read and write TS coefficients - g, h, j and
cal5.

The coefficients can vary between product and product, so to calibrate
them it can be very useful to to be able to modify them on the fly.

e.g.

cat /sys/kernel/debug/940f23d0000.pvt/ts_coeff_cal5
4096

echo 83000 > sys/kernel/debug/940f23d0000.pvt/ts_coeff_g

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/hwmon/mr75203.c | 196 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 196 insertions(+)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 2898565afaab..ce34a44237e8 100644
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
@@ -127,6 +128,7 @@ struct pvt_device {
 	struct clk		*clk;
 	struct reset_control	*rst;
 	struct voltage_device	*vd;
+	struct dentry		*dbgfs_dir;
 	u32			t_num;
 	u32			p_num;
 	u32			v_num;
@@ -139,6 +141,198 @@ struct pvt_device {
 	u8			vm_ch_total;
 };
 
+static ssize_t pvt_ts_coeff_h_read(struct file *file,
+				   char __user *user_buf,
+				   size_t count, loff_t *ppos)
+{
+	struct pvt_device *pvt = file->private_data;
+	char buf[16];
+	unsigned int len;
+
+	len = sprintf(buf, "%u\n", pvt->ts_coeff_h);
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
+	pvt->ts_coeff_h = coeff;
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
+	len = sprintf(buf, "%u\n", pvt->ts_coeff_g);
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
+	pvt->ts_coeff_g = coeff;
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
+	len = sprintf(buf, "%d\n", pvt->ts_coeff_j);
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
+	pvt->ts_coeff_j = coeff;
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
+	len = sprintf(buf, "%u\n", pvt->ts_coeff_cal5);
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
+	pvt->ts_coeff_cal5 = coeff;
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
@@ -655,6 +849,8 @@ static int mr75203_probe(struct platform_device *pdev)
 		dev_dbg(dev, "ts-coeff: h = %u, g = %u, j = %d, cal5 = %u\n",
 			pvt->ts_coeff_h, pvt->ts_coeff_g, pvt->ts_coeff_j,
 			pvt->ts_coeff_cal5);
+
+		pvt_ts_dbgfs_create(pvt, dev);
 	}
 
 	if (pd_num) {
-- 
2.37.1

