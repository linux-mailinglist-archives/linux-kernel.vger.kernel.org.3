Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9254F4DEC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1584132AbiDEX5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442202AbiDEPhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:37:08 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D5BF1EA7;
        Tue,  5 Apr 2022 06:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649166684; x=1680702684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=hMIn10jdMOZ3d+zm3mh/P4foFQUZ8FiHKOHW1rBiQyk=;
  b=KjFLfrB70J1Uc7rMVAQpTc0ojUYjsennUg7P6N9rjiPtJleyoig263ug
   w8w4Y8x5uuz1NoosSqb2az12PsGe23OYYmP20MVv3fdgdXp2lXgmL2isu
   YkBN69zLICYLEW4qkx1JT1gErd6PSpq37O0ATFLUEgJwUDA2AzE43I0m1
   Y=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Apr 2022 06:51:24 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 06:51:23 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Apr 2022 06:51:23 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Apr 2022 06:51:19 -0700
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
Subject: [PATCH V9 3/6] mfd: pm8008: Add mfd cell struct to register LDOs
Date:   Tue, 5 Apr 2022 19:20:30 +0530
Message-ID: <1649166633-25872-4-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649166633-25872-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1649166633-25872-1-git-send-email-quic_c_skakit@quicinc.com>
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

Add mfd cell struct to match with the "qcom,pm8008-regulator"
driver and a separate probe to add pm8008_regulator_devs.
This separate probe is required to ensure the regulators are
registered only with the mfd device which contains regulators.

Add the reset-gpio toggling in the pm8008_probe() to bring
pm8008 chip out of reset instead of doing it in DT node using
"output-high" property.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
---
Changes in V6:
 - Changed the mfd_cell struct to have only name of the regulator driver.
 - Using device_get_match_data() instead of of_match_node() to match data.
 - Fixed few nits.

Changes in V7:
 - Fixed minor errors.

Changes in V8:
 - Split the probe for infra and regulator devices
 - Add the reset-gpio toggling in the infra driver probe

Changes in V9:
 - Fixed nits.

 drivers/mfd/qcom-pm8008.c | 80 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index c472d7f..c7781ab 100644
--- a/drivers/mfd/qcom-pm8008.c
+++ b/drivers/mfd/qcom-pm8008.c
@@ -4,10 +4,12 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
@@ -27,6 +29,10 @@
 #define INT_EN_CLR_OFFSET		0x16
 #define INT_LATCHED_STS_OFFSET		0x18
 
+static const struct mfd_cell pm8008_regulator_devs[] = {
+	MFD_CELL_NAME("qcom,pm8008-regulators"),
+};
+
 enum {
 	PM8008_MISC,
 	PM8008_TEMP_ALARM,
@@ -57,6 +63,7 @@ enum {
 struct pm8008_data {
 	struct device *dev;
 	struct regmap *regmap;
+	struct gpio_desc *reset_gpio;
 	int irq;
 	struct regmap_irq_chip_data *irq_data;
 };
@@ -239,13 +246,44 @@ static int pm8008_probe(struct i2c_client *client)
 			dev_err(chip->dev, "Failed to probe irq periphs: %d\n", rc);
 	}
 
+	chip->reset_gpio = devm_gpiod_get(chip->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(chip->reset_gpio)) {
+		dev_err(chip->dev, "failed to acquire reset gpio\n");
+		return PTR_ERR(chip->reset_gpio);
+	}
+	gpiod_set_value(chip->reset_gpio, 1);
+
 	return devm_of_platform_populate(chip->dev);
 }
 
+static int pm8008_probe_regulators(struct i2c_client *client)
+{
+
+	int rc;
+	struct pm8008_data *chip;
+
+	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->dev = &client->dev;
+	chip->regmap = devm_regmap_init_i2c(client, &qcom_mfd_regmap_cfg);
+	if (!chip->regmap)
+		return -ENODEV;
+
+	rc = devm_mfd_add_devices(chip->dev, 0, pm8008_regulator_devs,
+			ARRAY_SIZE(pm8008_regulator_devs), NULL, 0, NULL);
+	if (rc)
+		dev_err(chip->dev, "Failed to add children: %d\n", rc);
+
+	return rc;
+}
+
 static const struct of_device_id pm8008_match[] = {
 	{ .compatible = "qcom,pm8008", },
-	{ },
+	{ }
 };
+MODULE_DEVICE_TABLE(of, pm8008_match);
 
 static struct i2c_driver pm8008_mfd_driver = {
 	.driver = {
@@ -254,7 +292,45 @@ static struct i2c_driver pm8008_mfd_driver = {
 	},
 	.probe_new = pm8008_probe,
 };
-module_i2c_driver(pm8008_mfd_driver);
+
+static const struct of_device_id pm8008_regulators_match[] = {
+	{ .compatible = "qcom,pm8008-regulators", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pm8008_regulators_match);
+
+static struct i2c_driver pm8008_regulators_driver = {
+	.driver = {
+		.name = "pm8008-regulators",
+		.of_match_table = pm8008_regulators_match,
+	},
+	.probe_new = pm8008_probe_regulators,
+};
+
+static int __init pm8008_i2c_init(void)
+{
+	int ret;
+
+	ret = i2c_add_driver(&pm8008_mfd_driver);
+	if (ret) {
+		pr_err("Failed to register driver for pm8008_infra: %d\n", ret);
+		return ret;
+	}
+
+	ret = i2c_add_driver(&pm8008_regulators_driver);
+	if (ret)
+		pr_err("Failed to register driver for pm8008_regulators: %d\n", ret);
+
+	return ret;
+}
+module_init(pm8008_i2c_init);
+
+static void __exit pm8008_i2c_exit(void)
+{
+	i2c_del_driver(&pm8008_mfd_driver);
+	i2c_del_driver(&pm8008_regulators_driver);
+}
+module_exit(pm8008_i2c_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("i2c:qcom-pm8008");
-- 
2.7.4

