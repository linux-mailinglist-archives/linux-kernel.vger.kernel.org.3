Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5D35A1055
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241690AbiHYMYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiHYMXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:23:47 -0400
X-Greylist: delayed 347 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 Aug 2022 05:23:44 PDT
Received: from mail.aboehler.at (mail.aboehler.at [IPv6:2a01:4f8:121:5012::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52FA2B273;
        Thu, 25 Aug 2022 05:23:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.aboehler.at (Postfix) with ESMTP id 6D68B3CC0D34;
        Thu, 25 Aug 2022 14:17:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aboehler.at
Received: from mail.aboehler.at ([127.0.0.1])
        by localhost (aboehler.at [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GqEPTD7q5yLm; Thu, 25 Aug 2022 14:17:52 +0200 (CEST)
Received: from x390y.lan (194-166-175-3.adsl.highway.telekom.at [194.166.175.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andreas@aboehler.at)
        by mail.aboehler.at (Postfix) with ESMTPSA id 5ECC33CC0293;
        Thu, 25 Aug 2022 14:17:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aboehler.at;
        s=default; t=1661429872;
        bh=O0sEC+U/QfY+SP3QEMdXzOiJP9TkB3o3aR4qtxie8UY=;
        h=From:To:Cc:Subject:Date:From;
        b=QAAbbOSgdODhh2cvaxoK7WZvLBdxT++CCEIo5FmX5kxtSTvVc1UDoRXzGUkejmCMz
         ex64sFSabblE9a0iElFO1qmw10/b91N9xegeRy2xHylsHg2lNGXrIT5KZfiO83wLY6
         cWOlghsOHMHuu/M9fiRpAG9VTQab67q6/x2p9Cfs=
From:   =?UTF-8?q?Andreas=20B=C3=B6hler?= <dev@aboehler.at>
Cc:     dev@aboehler.at, Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: tps23861: add support for initializing the chip
Date:   Thu, 25 Aug 2022 14:16:20 +0200
Message-Id: <20220825121620.20907-1-dev@aboehler.at>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tps23861 driver does not initialize the chip and relies on it being
in auto-mode by default. On some devices, these controllers default to
OFF-Mode and hence cannot be used at all.

This brings minimal support for initializing the controller in a user-
defined mode.

Tested on a TP-Link TL-SG2452P with 12x TI TPS23861 controllers.

Note: The DT bindings still need to be updated.

Usage:

tps23861@9 {
	compatible = "ti,tps23861";
	reg = <0x09>;

	port@0 {
		reg = <0>;
		mode = "auto";
		enable = <1>;
		poe_plus = <1>;
	};

	port@1 {
		reg = <1>;
		mode = "auto";
		enable = <1>;
		poe_plus = <1>;
	};

	port@2 {
		reg = <2>;
		mode = "auto";
		enable = <1>;
		poe_plus = <1>;
	};

	port@3 {
		reg = <3>;
		mode = "auto";
		enable = <1>;
		poe_plus = <1>;
	};
};

Signed-off-by: Andreas Böhler <dev@aboehler.at>
---
 drivers/hwmon/tps23861.c | 81 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
index 42762e87b014..27bf8716cf12 100644
--- a/drivers/hwmon/tps23861.c
+++ b/drivers/hwmon/tps23861.c
@@ -85,6 +85,8 @@
 #define PORT_DETECT_CAPACITANCE_INVALID_DELTA	11
 #define PORT_DETECT_CAPACITANCE_OUT_OF_RANGE	12
 #define POE_PLUS			0x40
+#define POE_PLUS_MASK(_port)	\
+	GENMASK(_port + 4, _port + 4)
 #define OPERATING_MODE			0x12
 #define OPERATING_MODE_OFF		0
 #define OPERATING_MODE_MANUAL		1
@@ -94,9 +96,22 @@
 #define OPERATING_MODE_PORT_2_MASK	GENMASK(3, 2)
 #define OPERATING_MODE_PORT_3_MASK	GENMASK(5, 4)
 #define OPERATING_MODE_PORT_4_MASK	GENMASK(7, 6)
+#define OPERATING_MODE_PORT(_mode, _port)	\
+	(_mode << (_port * 2))
 
+#define DISCONNECT_ENABLE		0x13
+#define DISCONNECT_ENABLE_MASK(_port)	\
+	GENMASK(_port, _port)
+#define DISCONNECT_MASK(_port)	\
+	(GENMASK(_port, _port) | GENMASK(_port + 4, _port + 4))
+
+#define DETECT_CLASS_ENABLE		0x14
 #define DETECT_CLASS_RESTART		0x18
 #define POWER_ENABLE			0x19
+#define POWER_ENABLE_ON_MASK(_port)	\
+	GENMASK(_port, _port)
+#define POWER_ENABLE_OFF_MASK(_port)	\
+	GENMASK(_port + 4, _port + 4)
 #define TPS23861_NUM_PORTS		4
 
 #define TPS23861_GENERAL_MASK_1		0x17
@@ -548,7 +563,16 @@ static int tps23861_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct tps23861_data *data;
 	struct device *hwmon_dev;
+	struct device_node *child;
 	u32 shunt_resistor;
+	u32 reg;
+	u32 temp;
+	const char *mode;
+	unsigned int poe_plusval;
+	unsigned int mode_val;
+	unsigned int power_val;
+	unsigned int enable_val;
+	unsigned int disconnect_enable_val;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -577,6 +601,63 @@ static int tps23861_probe(struct i2c_client *client)
 				TPS23861_GENERAL_MASK_1,
 				TPS23861_CURRENT_SHUNT_MASK);
 
+	regmap_read(data->regmap, POE_PLUS, &poe_plusval);
+	regmap_read(data->regmap, POWER_ENABLE, &power_val);
+	regmap_read(data->regmap, OPERATING_MODE, &mode_val);
+	regmap_read(data->regmap, DETECT_CLASS_ENABLE, &enable_val);
+	regmap_read(data->regmap, DISCONNECT_ENABLE, &disconnect_enable_val);
+
+	for_each_child_of_node(dev->of_node, child) {
+		if (of_property_read_u32(child, "reg", &reg))
+			continue;
+
+		if (reg > (TPS23861_NUM_PORTS - 1) || reg < 0)
+			continue;
+
+		if (!of_property_read_string(child, "mode", &mode)) {
+			if (!strncmp(mode, "manual", 6)) {
+				mode_val &= ~OPERATING_MODE_PORT(OPERATING_MODE_AUTO, reg);
+				mode_val |= OPERATING_MODE_PORT(OPERATING_MODE_MANUAL, reg);
+			} else if (!strncmp(mode, "semiauto", 8)) {
+				mode_val &= ~OPERATING_MODE_PORT(OPERATING_MODE_AUTO, reg);
+				mode_val |= OPERATING_MODE_PORT(OPERATING_MODE_SEMI, reg);
+			} else if (!strncmp(mode, "auto", 4))
+				mode_val |= OPERATING_MODE_PORT(OPERATING_MODE_AUTO, reg);
+			else
+				mode_val &= ~OPERATING_MODE_PORT(OPERATING_MODE_AUTO, reg);
+		}
+
+		if (!of_property_read_u32(child, "enable", &temp)) {
+			if (temp) {
+				enable_val |= DISCONNECT_MASK(reg);
+				disconnect_enable_val |= DISCONNECT_ENABLE_MASK(reg);
+			} else {
+				enable_val &= ~DISCONNECT_MASK(reg);
+				disconnect_enable_val &= ~DISCONNECT_ENABLE_MASK(reg);
+			}
+		}
+
+		if (!of_property_read_u32(child, "power", &temp)) {
+			if (temp)
+				power_val |= POWER_ENABLE_ON_MASK(reg);
+			else
+				power_val |= POWER_ENABLE_OFF_MASK(reg);
+		}
+
+		if (!of_property_read_u32(child, "poe_plus", &temp)) {
+			if (temp)
+				poe_plusval |= POE_PLUS_MASK(reg);
+			else
+				poe_plusval &= ~POE_PLUS_MASK(reg);
+		}
+	}
+
+	regmap_write(data->regmap, POE_PLUS, poe_plusval);
+	regmap_write(data->regmap, POWER_ENABLE, power_val);
+	regmap_write(data->regmap, OPERATING_MODE, mode_val);
+	regmap_write(data->regmap, DETECT_CLASS_ENABLE, enable_val);
+	regmap_write(data->regmap, DISCONNECT_ENABLE, disconnect_enable_val);
+
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
 							 data, &tps23861_chip_info,
 							 NULL);
-- 
2.37.2

