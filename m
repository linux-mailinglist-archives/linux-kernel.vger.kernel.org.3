Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624FF500D71
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243378AbiDNMdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243366AbiDNMdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:33:42 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2A738DBA;
        Thu, 14 Apr 2022 05:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649939476; x=1681475476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=9DQByKwtwdgnOvqCSn20bztLHUzukxppsLyV8wP5/a4=;
  b=TsT/C6dmj52D5AUCuVcibW7jqZCqw47o5iV2+bAkeFLOM645RWjIhNJ5
   XG6RNOc9NEyz0N3zH0xboxfEEHPcjvtlkJBkLyrpfeOuVbMtQ/sgwhD+d
   gngfSZjndFEMg6VcIT8a2BSWeTZZnDJL4cK4ekqRA90gUrbTclHgeYJWL
   I=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Apr 2022 05:31:15 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 05:31:15 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 05:31:14 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 05:31:10 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH V10 5/9] mfd: pm8008: Use i2c_new_dummy_device() API
Date:   Thu, 14 Apr 2022 18:00:14 +0530
Message-ID: <1649939418-19861-6-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649939418-19861-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1649939418-19861-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use i2c_new_dummy_device() to register clients along with
the main mfd device.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
---
Changes in V10:
 - Implement i2c_new_dummy_device to register extra clients.

 drivers/mfd/qcom-pm8008.c       | 54 +++++++++++++++++++++++++++++++++--------
 include/linux/mfd/qcom_pm8008.h | 13 ++++++++++
 2 files changed, 57 insertions(+), 10 deletions(-)
 create mode 100644 include/linux/mfd/qcom_pm8008.h

diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index 97a72da..ca5240d 100644
--- a/drivers/mfd/qcom-pm8008.c
+++ b/drivers/mfd/qcom-pm8008.c
@@ -9,6 +9,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/mfd/qcom_pm8008.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
@@ -56,8 +57,10 @@ enum {
 #define PM8008_PERIPH_OFFSET(paddr)	(paddr - PM8008_PERIPH_0_BASE)
 
 struct pm8008_data {
+	bool ready;
 	struct device *dev;
-	struct regmap *regmap;
+	struct i2c_client *clients[PM8008_NUM_CLIENTS];
+	struct regmap *regmap[PM8008_NUM_CLIENTS];
 	struct gpio_desc *reset_gpio;
 	int irq;
 	struct regmap_irq_chip_data *irq_data;
@@ -152,9 +155,20 @@ static struct regmap_config qcom_mfd_regmap_cfg = {
 	.max_register	= 0xFFFF,
 };
 
+struct regmap *pm8008_get_regmap(struct pm8008_data *chip, u8 sid)
+{
+	if (!chip || !chip->ready) {
+		pr_err("pm8008 chip not initialized\n");
+		return NULL;
+	}
+
+	return chip->regmap[sid];
+}
+
 static int pm8008_init(struct pm8008_data *chip)
 {
 	int rc;
+	struct regmap *regmap = pm8008_get_regmap(chip, PM8008_INFRA_SID);
 
 	/*
 	 * Set TEMP_ALARM peripheral's TYPE so that the regmap-irq framework
@@ -162,19 +176,19 @@ static int pm8008_init(struct pm8008_data *chip)
 	 * This is required to enable the writing of TYPE registers in
 	 * regmap_irq_sync_unlock().
 	 */
-	rc = regmap_write(chip->regmap,
+	rc = regmap_write(regmap,
 			 (PM8008_TEMP_ALARM_ADDR | INT_SET_TYPE_OFFSET),
 			 BIT(0));
 	if (rc)
 		return rc;
 
 	/* Do the same for GPIO1 and GPIO2 peripherals */
-	rc = regmap_write(chip->regmap,
+	rc = regmap_write(regmap,
 			 (PM8008_GPIO1_ADDR | INT_SET_TYPE_OFFSET), BIT(0));
 	if (rc)
 		return rc;
 
-	rc = regmap_write(chip->regmap,
+	rc = regmap_write(regmap,
 			 (PM8008_GPIO2_ADDR | INT_SET_TYPE_OFFSET), BIT(0));
 
 	return rc;
@@ -186,6 +200,7 @@ static int pm8008_probe_irq_peripherals(struct pm8008_data *chip,
 	int rc, i;
 	struct regmap_irq_type *type;
 	struct regmap_irq_chip_data *irq_data;
+	struct regmap *regmap = pm8008_get_regmap(chip, PM8008_INFRA_SID);
 
 	rc = pm8008_init(chip);
 	if (rc) {
@@ -209,7 +224,7 @@ static int pm8008_probe_irq_peripherals(struct pm8008_data *chip,
 				IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
 	}
 
-	rc = devm_regmap_add_irq_chip(chip->dev, chip->regmap, client_irq,
+	rc = devm_regmap_add_irq_chip(chip->dev, regmap, client_irq,
 			IRQF_SHARED, 0, &pm8008_irq_chip, &irq_data);
 	if (rc) {
 		dev_err(chip->dev, "Failed to add IRQ chip: %d\n", rc);
@@ -221,19 +236,38 @@ static int pm8008_probe_irq_peripherals(struct pm8008_data *chip,
 
 static int pm8008_probe(struct i2c_client *client)
 {
-	int rc;
+	int rc, i;
 	struct pm8008_data *chip;
+	struct device_node *node = client->dev.of_node;
 
 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
 	chip->dev = &client->dev;
-	chip->regmap = devm_regmap_init_i2c(client, &qcom_mfd_regmap_cfg);
-	if (!chip->regmap)
-		return -ENODEV;
 
-	i2c_set_clientdata(client, chip);
+	for (i = 0; i < PM8008_NUM_CLIENTS; i++) {
+		if (i == 0) {
+			chip->clients[i] = client;
+		} else {
+			chip->clients[i] = i2c_new_dummy_device(client->adapter,
+								client->addr + i);
+			if (IS_ERR(chip->clients[i])) {
+				dev_err(&client->dev, "can't attach client %d\n", i);
+				return PTR_ERR(chip->clients[i]);
+			}
+			chip->clients[i]->dev.of_node = of_node_get(node);
+		}
+
+		chip->regmap[i] = devm_regmap_init_i2c(chip->clients[i],
+							&qcom_mfd_regmap_cfg);
+		if (!chip->regmap[i])
+			return -ENODEV;
+
+		i2c_set_clientdata(chip->clients[i], chip);
+	}
+
+	chip->ready = true;
 
 	if (of_property_read_bool(chip->dev->of_node, "interrupt-controller")) {
 		rc = pm8008_probe_irq_peripherals(chip, client->irq);
diff --git a/include/linux/mfd/qcom_pm8008.h b/include/linux/mfd/qcom_pm8008.h
new file mode 100644
index 0000000..bc64f01
--- /dev/null
+++ b/include/linux/mfd/qcom_pm8008.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __QCOM_PM8008_H__
+#define __QCOM_PM8008_H__
+
+#define PM8008_INFRA_SID	0
+#define PM8008_REGULATORS_SID	1
+
+#define PM8008_NUM_CLIENTS	2
+
+struct pm8008_data;
+struct regmap *pm8008_get_regmap(struct pm8008_data *chip, u8 sid);
+
+#endif
-- 
2.7.4

