Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E01053FDF1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243206AbiFGLv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbiFGLvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:51:05 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D86B2242;
        Tue,  7 Jun 2022 04:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654602664; x=1686138664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=I4jrwumUrij13W+J1MGIZxjSZuLNcXtb4APVTK6Gbwo=;
  b=TL/Er4BI+w6B89GPKjQ80bFAbfPDBQdvvom3F29SQTuuq17XEz2RQseV
   j/wBnlfwkZZQVf5lZtgzc7WExBRaqT5Bu0QkTik6tIxdcr589vATlFFSg
   YWRMiPWu9fOwpyssRl4c8BS0t41zO/wA+hS08T3O5abMf5G5ka9sAeeME
   w=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Jun 2022 04:51:03 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 04:51:03 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 04:51:02 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 04:50:58 -0700
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
Subject: [PATCH V14 5/9] mfd: pm8008: Remove the regmap member from pm8008_data struct
Date:   Tue, 7 Jun 2022 17:20:11 +0530
Message-ID: <1654602615-28849-6-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654602615-28849-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1654602615-28849-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

Remove the regmap member from pm8008_data struct as it is
not used outside of probe. Add a local variable for regmap
and pass it to the pm8008_probe_irq_peripherals()
API in pm8008_probe.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Changes in V14:
 - None.

Changes in V13:
 - None.

Changes in V12:
 - None.

Changes in V11:
 - New patch added from V11.

 drivers/mfd/qcom-pm8008.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index 5a670b0..569ffd50 100644
--- a/drivers/mfd/qcom-pm8008.c
+++ b/drivers/mfd/qcom-pm8008.c
@@ -57,7 +57,6 @@ enum {
 
 struct pm8008_data {
 	struct device *dev;
-	struct regmap *regmap;
 	int irq;
 	struct regmap_irq_chip_data *irq_data;
 };
@@ -151,7 +150,7 @@ static struct regmap_config qcom_mfd_regmap_cfg = {
 	.max_register	= 0xFFFF,
 };
 
-static int pm8008_init(struct pm8008_data *chip)
+static int pm8008_init(struct regmap *regmap)
 {
 	int rc;
 
@@ -161,32 +160,32 @@ static int pm8008_init(struct pm8008_data *chip)
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
 }
 
 static int pm8008_probe_irq_peripherals(struct pm8008_data *chip,
-					int client_irq)
+					struct regmap *regmap, int client_irq)
 {
 	int rc, i;
 	struct regmap_irq_type *type;
 	struct regmap_irq_chip_data *irq_data;
 
-	rc = pm8008_init(chip);
+	rc = pm8008_init(regmap);
 	if (rc) {
 		dev_err(chip->dev, "Init failed: %d\n", rc);
 		return rc;
@@ -208,7 +207,7 @@ static int pm8008_probe_irq_peripherals(struct pm8008_data *chip,
 				IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
 	}
 
-	rc = devm_regmap_add_irq_chip(chip->dev, chip->regmap, client_irq,
+	rc = devm_regmap_add_irq_chip(chip->dev, regmap, client_irq,
 			IRQF_SHARED, 0, &pm8008_irq_chip, &irq_data);
 	if (rc) {
 		dev_err(chip->dev, "Failed to add IRQ chip: %d\n", rc);
@@ -223,14 +222,15 @@ static int pm8008_probe(struct i2c_client *client)
 	int rc;
 	struct pm8008_data *chip;
 	struct gpio_desc *reset_gpio;
+	struct regmap *regmap;
 
 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
 	chip->dev = &client->dev;
-	chip->regmap = devm_regmap_init_i2c(client, &qcom_mfd_regmap_cfg);
-	if (!chip->regmap)
+	regmap = devm_regmap_init_i2c(client, &qcom_mfd_regmap_cfg);
+	if (!regmap)
 		return -ENODEV;
 
 	i2c_set_clientdata(client, chip);
@@ -240,7 +240,7 @@ static int pm8008_probe(struct i2c_client *client)
 		return PTR_ERR(reset_gpio);
 
 	if (of_property_read_bool(chip->dev->of_node, "interrupt-controller")) {
-		rc = pm8008_probe_irq_peripherals(chip, client->irq);
+		rc = pm8008_probe_irq_peripherals(chip, regmap, client->irq);
 		if (rc)
 			dev_err(chip->dev, "Failed to probe irq periphs: %d\n", rc);
 	}
-- 
2.7.4

