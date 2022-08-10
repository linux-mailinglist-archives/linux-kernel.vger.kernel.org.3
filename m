Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3AF58EDA6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbiHJNyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbiHJNyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:54:00 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617E16A4A3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:53:58 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id CD165240028
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:53:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1660139635; bh=Y41+tOHqoc+T16MMGISkHm9S39620DPWPJbzli5aIN8=;
        h=Date:From:To:Cc:Subject:From;
        b=IsRlT4wcE1kTZ958key6k9GpfByrDc217/+H9FknnHfQ3wP/d4jtfiQlPm+fVKzWM
         ZZ4ziwS6USfAC91VUq0cpE42U2BsgouQPKTjNkreJRjHrheJxD12wHul248QxalIbA
         v5H/dZ+TXhlQSXYpx04//DVcF03DC+aXBRkhBXwtPyZoD/Mw12imfHXPmqQy4tqlO5
         3HPe8kfZRUax/4cJHyyxUPQkYuJH62fFyj5ihWqE9XnDcPS8QyvaluE4yYAn9WxIl5
         nveURYarnhlW8vVWKE4F5BwXbA3F869nq3kz0m5UpvKc3jNmDgixMTdCnxRddcqMWk
         1DRjsCX/IhfvA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4M2ryB5rrxz6tmF;
        Wed, 10 Aug 2022 15:53:54 +0200 (CEST)
Date:   Wed, 10 Aug 2022 13:53:53 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH v2] hwmon: corsair-psu: add reporting of rail mode via debugfs
Message-ID: <YvO4cfx12Q9gcmPg@monster.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reporting if the PSU is running in single or multi rail mode via
ocpmode debugfs entry. Also update the documentation accordingly.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
Changes in v2:
  - fixed spelling issues in commit message
---
 Documentation/hwmon/corsair-psu.rst |  5 +++--
 drivers/hwmon/corsair-psu.c         | 21 ++++++++++++++++++++-
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
index e8378e7a1d8c..c3a76305c587 100644
--- a/Documentation/hwmon/corsair-psu.rst
+++ b/Documentation/hwmon/corsair-psu.rst
@@ -86,8 +86,9 @@ Debugfs entries
 ---------------
 
 =======================	========================================================
-uptime			Current uptime of the psu
+ocpmode                 Single or multi rail mode of the PCIe power connectors
+product                 Product name of the psu
+uptime			Session uptime of the psu
 uptime_total		Total uptime of the psu
 vendor			Vendor name of the psu
-product			Product name of the psu
 =======================	========================================================
diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
index 14389fd7afb8..9d103613db39 100644
--- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -71,9 +71,10 @@
 #define PSU_CMD_RAIL_WATTS	0x96
 #define PSU_CMD_VEND_STR	0x99
 #define PSU_CMD_PROD_STR	0x9A
-#define PSU_CMD_TOTAL_WATTS	0xEE
 #define PSU_CMD_TOTAL_UPTIME	0xD1
 #define PSU_CMD_UPTIME		0xD2
+#define PSU_CMD_OCPMODE		0xD8
+#define PSU_CMD_TOTAL_WATTS	0xEE
 #define PSU_CMD_INIT		0xFE
 
 #define L_IN_VOLTS		"v_in"
@@ -268,6 +269,7 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
 		break;
 	case PSU_CMD_TOTAL_UPTIME:
 	case PSU_CMD_UPTIME:
+	case PSU_CMD_OCPMODE:
 		*val = tmp;
 		break;
 	default:
@@ -660,6 +662,22 @@ static int product_show(struct seq_file *seqf, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(product);
 
+static int ocpmode_show(struct seq_file *seqf, void *unused)
+{
+	struct corsairpsu_data *priv = seqf->private;
+	long val;
+	int ret;
+
+	ret = corsairpsu_get_value(priv, PSU_CMD_OCPMODE, 0, &val);
+	if (ret < 0)
+		seq_puts(seqf, "N/A\n");
+	else
+		seq_printf(seqf, "%s\n", (val == 0x02) ? "multi rail" : "single rail");
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ocpmode);
+
 static void corsairpsu_debugfs_init(struct corsairpsu_data *priv)
 {
 	char name[32];
@@ -671,6 +689,7 @@ static void corsairpsu_debugfs_init(struct corsairpsu_data *priv)
 	debugfs_create_file("uptime_total", 0444, priv->debugfs, priv, &uptime_total_fops);
 	debugfs_create_file("vendor", 0444, priv->debugfs, priv, &vendor_fops);
 	debugfs_create_file("product", 0444, priv->debugfs, priv, &product_fops);
+	debugfs_create_file("ocpmode", 0444, priv->debugfs, priv, &ocpmode_fops);
 }
 
 #else
-- 
2.37.1

