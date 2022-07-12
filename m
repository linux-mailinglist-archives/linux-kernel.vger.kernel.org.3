Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5208C572642
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbiGLTqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiGLTqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:46:06 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB4CB41BF;
        Tue, 12 Jul 2022 12:36:01 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id z11so5634768qkz.13;
        Tue, 12 Jul 2022 12:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j0miCz7yO1Y2I8pvw032h1mnhQYjkHXsC5R5mX24dTg=;
        b=ssNxXzvV0G0LziJ8TgeFUSF1A2+yjhNpUXULxujFk/DGYAzb3gwgHqBQRj2mlV4BoI
         wgiUOKZYrd1BuHI1qq6hSzmyLsryQlWGr6IfWKqH9XNVLE2vSqqh9NBHG8+jco9GGEcF
         gvP7VRKUWk7JOsUcG1dBr3tF0zulaRvrEKPXv3gejCg25W2cc/0IGIWo/dJ/kKGXFZT+
         tH/zJYMck5VkogfVeyBP2iDrDFYWcbPWs5sSN0b2vYabVlGqW/XqJeTyNYs31/m5WE+6
         3ZCNYRkzo/3aQSx+eoS4G7w8NRjAkMs/bDWAZF0pQgyL3phxh+HoeGVXUs3gMcTvmj2z
         ECeg==
X-Gm-Message-State: AJIora+JtLPgSqZAReko+4G5ZXVIlD/JdYIDDEz1Yh8ZPDg/UJaLjjaX
        NsXU0QVM05XbI9jPBLwadWviBGoEB44=
X-Google-Smtp-Source: AGRyM1tmda6zGMVpOlj2P77rNbtj6+6NL5E1S8G9DyprdGvF0ZWAY8KoTARaJmN7LzkUuyxmFuXTDw==
X-Received: by 2002:a05:620a:2624:b0:6b5:965d:e043 with SMTP id z36-20020a05620a262400b006b5965de043mr6402036qko.236.1657654560623;
        Tue, 12 Jul 2022 12:36:00 -0700 (PDT)
Received: from mfe-desktop.dimonoffinc.intra (ipagstaticip-ad9375f2-382c-b511-8ac1-9541f69fe50f.sdsl.bell.ca. [142.116.33.166])
        by smtp.googlemail.com with ESMTPSA id u4-20020a37ab04000000b006b56a4400f6sm9395769qke.16.2022.07.12.12.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 12:36:00 -0700 (PDT)
From:   ferlandm@amotus.ca
To:     jdelvare@suse.com
Cc:     linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Ferland <ferlandm@amotus.ca>
Subject: [PATCH] hwmon: (mcp3021) improve driver support for newer hwmon interface
Date:   Tue, 12 Jul 2022 15:35:04 -0400
Message-Id: <20220712193504.1374656-1-ferlandm@amotus.ca>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Ferland <ferlandm@amotus.ca>

This driver is currently broken, it does not show the in0_input sysfs
file and also returns the following message on startup:

hwmon_device_register() is deprecated. Please convert the driver to
use hwmon_device_register_with_info().

This patch converts the driver and also cleans up the 'read' function.

Signed-off-by: Marc Ferland <ferlandm@amotus.ca>
---
 drivers/hwmon/mcp3021.c | 99 ++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 50 deletions(-)

diff --git a/drivers/hwmon/mcp3021.c b/drivers/hwmon/mcp3021.c
index ce2780768074..e093b1998296 100644
--- a/drivers/hwmon/mcp3021.c
+++ b/drivers/hwmon/mcp3021.c
@@ -7,7 +7,7 @@
  * Reworked by Sven Schuchmann <schuchmann@schleissheimer.de>
  * DT support added by Clemens Gruber <clemens.gruber@pqgruber.com>
  *
- * This driver export the value of analog input voltage to sysfs, the
+ * This driver exports the value of analog input voltage to sysfs, the
  * voltage unit is mV. Through the sysfs interface, lm-sensors tool
  * can also display the input voltage.
  */
@@ -45,19 +45,29 @@ enum chips {
  * Client data (each client gets its own)
  */
 struct mcp3021_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 	u32 vdd;        /* supply and reference voltage in millivolt */
 	u16 sar_shift;
 	u16 sar_mask;
 	u8 output_res;
 };
 
-static int mcp3021_read16(struct i2c_client *client)
+static inline u16 volts_from_reg(struct mcp3021_data *data, u16 val)
 {
-	struct mcp3021_data *data = i2c_get_clientdata(client);
-	int ret;
-	u16 reg;
+	return DIV_ROUND_CLOSEST(data->vdd * val, 1 << data->output_res);
+}
+
+static int mcp3021_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
+{
+	struct mcp3021_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	__be16 buf;
+	u16 reg;
+	int ret;
+
+	if (type != hwmon_in)
+		return -EOPNOTSUPP;
 
 	ret = i2c_master_recv(client, (char *)&buf, 2);
 	if (ret < 0)
@@ -74,39 +84,46 @@ static int mcp3021_read16(struct i2c_client *client)
 	 */
 	reg = (reg >> data->sar_shift) & data->sar_mask;
 
-	return reg;
-}
+	*val = volts_from_reg(data, reg);
 
-static inline u16 volts_from_reg(struct mcp3021_data *data, u16 val)
-{
-	return DIV_ROUND_CLOSEST(data->vdd * val, 1 << data->output_res);
+	return 0;
 }
 
-static ssize_t in0_input_show(struct device *dev,
-			      struct device_attribute *attr, char *buf)
+static umode_t mcp3021_is_visible(const void *_data,
+				  enum hwmon_sensor_types type,
+				  u32 attr, int channel)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct mcp3021_data *data = i2c_get_clientdata(client);
-	int reg, in_input;
+	if (type != hwmon_in)
+		return 0;
 
-	reg = mcp3021_read16(client);
-	if (reg < 0)
-		return reg;
+	if (attr != hwmon_in_input)
+		return 0;
 
-	in_input = volts_from_reg(data, reg);
-
-	return sprintf(buf, "%d\n", in_input);
+	return 0444;
 }
 
-static DEVICE_ATTR_RO(in0_input);
+static const struct hwmon_channel_info *mcp3021_info[] = {
+	HWMON_CHANNEL_INFO(in, HWMON_I_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops mcp3021_hwmon_ops = {
+	.is_visible = mcp3021_is_visible,
+	.read = mcp3021_read,
+};
+
+static const struct hwmon_chip_info mcp3021_chip_info = {
+	.ops = &mcp3021_hwmon_ops,
+	.info = mcp3021_info,
+};
 
 static const struct i2c_device_id mcp3021_id[];
 
 static int mcp3021_probe(struct i2c_client *client)
 {
-	int err;
 	struct mcp3021_data *data = NULL;
 	struct device_node *np = client->dev.of_node;
+	struct device *hwmon_dev;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
@@ -147,34 +164,17 @@ static int mcp3021_probe(struct i2c_client *client)
 		break;
 	}
 
+	data->client = client;
+
 	if (data->vdd > MCP3021_VDD_REF_MAX || data->vdd < MCP3021_VDD_REF_MIN)
 		return -EINVAL;
 
-	err = sysfs_create_file(&client->dev.kobj, &dev_attr_in0_input.attr);
-	if (err)
-		return err;
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove;
-	}
-
-	return 0;
-
-exit_remove:
-	sysfs_remove_file(&client->dev.kobj, &dev_attr_in0_input.attr);
-	return err;
-}
-
-static int mcp3021_remove(struct i2c_client *client)
-{
-	struct mcp3021_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_file(&client->dev.kobj, &dev_attr_in0_input.attr);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_info(&client->dev,
+							 client->name,
+							 data,
+							 &mcp3021_chip_info,
+							 NULL);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id mcp3021_id[] = {
@@ -199,7 +199,6 @@ static struct i2c_driver mcp3021_driver = {
 		.of_match_table = of_match_ptr(of_mcp3021_match),
 	},
 	.probe_new = mcp3021_probe,
-	.remove = mcp3021_remove,
 	.id_table = mcp3021_id,
 };
 

base-commit: 9f6ca00b5be47e471e9703e6b017e1e2cfa7f604
-- 
2.30.2

