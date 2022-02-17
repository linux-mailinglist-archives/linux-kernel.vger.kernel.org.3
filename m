Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA21C4B9873
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 06:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbiBQFwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 00:52:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiBQFwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 00:52:37 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7B91CFDA;
        Wed, 16 Feb 2022 21:52:22 -0800 (PST)
Received: from HP-EliteBook-840-G7.. (1-171-236-200.dynamic-ip.hinet.net [1.171.236.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D564C3FD17;
        Thu, 17 Feb 2022 05:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645077140;
        bh=IY+TPVDWwB1jLM1grLCv7XrZucC3ulJ/hC4gDmeTBYc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=KnD1jW1u/h9BvA6IG+V9nhwqr92+fzcBXtWru4+sto9k+K4IRfgkTd+Rt1k7hkojg
         GKhWzEA+TPSn5JLtET89AqJH4i8AWl4NTnkJhVEKBDGsbgQ4KaWPR9knwRSwXNcqed
         loQ65EDzrqiywP78q8C5xiC2TYQeC6s8I26C+pQo2LGFaJZi09QIiTYCleKemVxqET
         TYak/qf32XcF1dfu5ekkcSvc+ORlvb1sW+w3Kte95pzieve/bx/4byvA4VXHqXcMzd
         WFbyOJaq891vsXTUut5ctKX+W8kBQ9OtYAfLK4y+VU6VLt0p6yDHWMhkfGPTbgaXO5
         oqAcXHYyGPj5g==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org
Cc:     andy.shevchenko@gmail.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] iio: accel: adxl345: Add ACPI HID table
Date:   Thu, 17 Feb 2022 13:52:07 +0800
Message-Id: <20220217055208.2388929-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 boards may use ACPI HID "ADS0345" for adxl345 device.

Analog replied:
"ADS034X is not a valid PNP ID. ADS0345 would be.
I'm not aware that this ID is already taken.
Feel free to submit a mainline Linux input mailing list patch."

So add an ACPI match table for that accordingly.

Since ACPI device may not match to any I2C ID, use the name and type
directly from ACPI ID table in absence of I2C ID.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v4:
 - Drop "ADS0345:00" and use driver_date from ACPI table directly.

v3:
 - Convert the driver from input to iio.

v2:
 - Drop ACPI_PTR()
 - Drop redundant empty line and comma
 - Add info from vendor

 drivers/iio/accel/adxl345_i2c.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index a431cba216e69..cdcc3ef1f1d33 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -22,20 +22,32 @@ static const struct regmap_config adxl345_i2c_regmap_config = {
 static int adxl345_i2c_probe(struct i2c_client *client,
 			     const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
+	const struct acpi_device_id *acpi_id;
+	enum adxl345_device_type type;
+	const char *name;
 	struct regmap *regmap;
 
-	if (!id)
-		return -ENODEV;
+	if (id) {
+		type = id->driver_data;
+		name = id->name;
+	} else {
+		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
+		if (acpi_id) {
+			type = acpi_id->driver_data;
+			name = acpi_id->id;
+		} else
+			return -ENODEV;
+	}
 
 	regmap = devm_regmap_init_i2c(client, &adxl345_i2c_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Error initializing i2c regmap: %ld\n",
+		dev_err(dev, "Error initializing i2c regmap: %ld\n",
 			PTR_ERR(regmap));
 		return PTR_ERR(regmap);
 	}
 
-	return adxl345_core_probe(&client->dev, regmap, id->driver_data,
-				  id->name);
+	return adxl345_core_probe(&client->dev, regmap, type, name);
 }
 
 static const struct i2c_device_id adxl345_i2c_id[] = {
@@ -54,10 +66,17 @@ static const struct of_device_id adxl345_of_match[] = {
 
 MODULE_DEVICE_TABLE(of, adxl345_of_match);
 
+static const struct acpi_device_id adxl345_acpi_match[] = {
+	{ "ADS0345", ADXL345 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, adxl345_acpi_match);
+
 static struct i2c_driver adxl345_i2c_driver = {
 	.driver = {
 		.name	= "adxl345_i2c",
 		.of_match_table = adxl345_of_match,
+		.acpi_match_table = adxl345_acpi_match,
 	},
 	.probe		= adxl345_i2c_probe,
 	.id_table	= adxl345_i2c_id,
-- 
2.34.1

