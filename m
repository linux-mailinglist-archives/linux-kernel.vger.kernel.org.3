Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D478658F8FF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbiHKI0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbiHKI0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:26:43 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B9790806
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:26:42 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id D82AA240103
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:26:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1660206400; bh=IQQ5KDmcSz5WBtG8+8SvMOP9W1JF4P20u5LWb4UEqag=;
        h=Date:From:To:Cc:Subject:From;
        b=fhCfRwhbJCGxtFngRaQU08y4JxgX6a0bsZf0ASdaC4G6DgHnaeq7UnqccLgKRRYLn
         Fw2xReH9W5iwh1BMxG8CnQbLyULuykQ8eiaiKQUllxyH26luqjj8PEnpukkts11V6f
         wahguTTGXh7lKlqo+wSwouEYj0g7uUXIus5j4MEV/DTHxKtsnEL//afMjApviQrbsP
         pZ/LB0eDqoHc039uhXssO0p9CoG0M5QFCX5ivNREVhMnUDheHnMN96B4s7nUP3Wp4L
         k2Ec48T4PchGpRrLrPjB9kQfKuePDGPmrY6yVvPQBfdMg5hNOOb/SrUvDR/SGnsBGb
         0YUzCvUeScGcQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4M3Kf74vZwz6tnd;
        Thu, 11 Aug 2022 10:26:39 +0200 (CEST)
Date:   Thu, 11 Aug 2022 08:26:37 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH v3] hwmon: corsair-psu: add reporting of rail mode via debugfs
Message-ID: <YvS9PZKr0xqFqJny@monster.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reporting if the PSU is running in single or multi rail mode via
ocpmode debugfs entry. Also update the documentation and driver comments
accordingly.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
Changes in v3:
  - added more explanations in the driver

Changes in v2:
  - fixed spelling issues in commit message
---
 Documentation/hwmon/corsair-psu.rst |  5 +++--
 drivers/hwmon/corsair-psu.c         | 29 ++++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 3 deletions(-)

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
index 14389fd7afb8..c99e4c6afc2d 100644
--- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -55,6 +55,7 @@
 #define SECONDS_PER_DAY		(SECONDS_PER_HOUR * 24)
 #define RAIL_COUNT		3 /* 3v3 + 5v + 12v */
 #define TEMP_COUNT		2
+#define OCP_MULTI_RAIL		0x02
 
 #define PSU_CMD_SELECT_RAIL	0x00 /* expects length 2 */
 #define PSU_CMD_RAIL_VOLTS_HCRIT 0x40 /* the rest of the commands expect length 3 */
@@ -71,9 +72,10 @@
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
@@ -268,6 +270,7 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
 		break;
 	case PSU_CMD_TOTAL_UPTIME:
 	case PSU_CMD_UPTIME:
+	case PSU_CMD_OCPMODE:
 		*val = tmp;
 		break;
 	default:
@@ -660,6 +663,29 @@ static int product_show(struct seq_file *seqf, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(product);
 
+static int ocpmode_show(struct seq_file *seqf, void *unused)
+{
+	struct corsairpsu_data *priv = seqf->private;
+	long val;
+	int ret;
+
+	/*
+	 * The rail mode is switchable on the fly. The RAW interface can be used for this. But it
+	 * will not be included here, because I consider it somewhat dangerous for the health of the
+	 * PSU. The returned value can be a bogus one, if the PSU is in the process of switching and
+	 * getting of the value itself can also fail during this. Because of this every other value
+	 * than OCP_MULTI_RAIL can be considered as "single rail".
+	 */
+	ret = corsairpsu_get_value(priv, PSU_CMD_OCPMODE, 0, &val);
+	if (ret < 0)
+		seq_puts(seqf, "N/A\n");
+	else
+		seq_printf(seqf, "%s\n", (val == OCP_MULTI_RAIL) ? "multi rail" : "single rail");
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ocpmode);
+
 static void corsairpsu_debugfs_init(struct corsairpsu_data *priv)
 {
 	char name[32];
@@ -671,6 +697,7 @@ static void corsairpsu_debugfs_init(struct corsairpsu_data *priv)
 	debugfs_create_file("uptime_total", 0444, priv->debugfs, priv, &uptime_total_fops);
 	debugfs_create_file("vendor", 0444, priv->debugfs, priv, &vendor_fops);
 	debugfs_create_file("product", 0444, priv->debugfs, priv, &product_fops);
+	debugfs_create_file("ocpmode", 0444, priv->debugfs, priv, &ocpmode_fops);
 }
 
 #else
-- 
2.37.1

