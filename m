Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2964ADBAB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378647AbiBHOzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378595AbiBHOy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:54:59 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA399C061577;
        Tue,  8 Feb 2022 06:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644332098; x=1675868098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=5dRQGDipgzG85fnnJW6YhBgbg3GmCvCXADVQXynNwsQ=;
  b=DC5PpZrPNIF+ZCBv4d2LwlJgv+Qv/k7oaGpaTIM8kaN8zy9801I6IA2z
   A8jFXEXVn2y7gqJf7bEEX8/SSGu2Vvdqg40ONx2ki7MngO7I5Vnb3CS6p
   B7xzdaea88mWZ0s4UJfBym25CP6dtMlnw2ieoxOPut2EFIDkL2WWa01r+
   c=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Feb 2022 06:54:58 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 06:54:58 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 06:54:58 -0800
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 06:54:53 -0800
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH V5 3/6] mfd: pm8008: Add mfd cell struct to register LDOs
Date:   Tue, 8 Feb 2022 20:22:17 +0530
Message-ID: <1644331940-18986-4-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644331940-18986-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1644331940-18986-1-git-send-email-quic_c_skakit@quicinc.com>
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

Register mfd cell ID and name for each of the 7 pm8008
LDOs to probe them through mfd driver without needing
a separate compatible for regulator driver.

Also, add a different compatible for the mfd node that
contains regulators to make sure that the LDOs are
registered with the correct mfd device.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
---
Changes in V5:
 - Changes newly added from V5.

 drivers/mfd/qcom-pm8008.c | 59 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index c472d7f..e8569cc 100644
--- a/drivers/mfd/qcom-pm8008.c
+++ b/drivers/mfd/qcom-pm8008.c
@@ -8,6 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
@@ -27,6 +28,37 @@
 #define INT_EN_CLR_OFFSET		0x16
 #define INT_LATCHED_STS_OFFSET		0x18
 
+static const struct mfd_cell pm8008_regulator_devs[] = {
+	{
+		.name = "qcom,pm8008-regulators",
+		.id = 0,
+	},
+	{
+		.name = "qcom,pm8008-regulators",
+		.id = 1,
+	},
+	{
+		.name = "qcom,pm8008-regulators",
+		.id = 2,
+	},
+	{
+		.name = "qcom,pm8008-regulators",
+		.id = 3,
+	},
+	{
+		.name = "qcom,pm8008-regulators",
+		.id = 4,
+	},
+	{
+		.name = "qcom,pm8008-regulators",
+		.id = 5,
+	},
+	{
+		.name = "qcom,pm8008-regulators",
+		.id = 6,
+	},
+};
+
 enum {
 	PM8008_MISC,
 	PM8008_TEMP_ALARM,
@@ -35,6 +67,17 @@ enum {
 	PM8008_NUM_PERIPHS,
 };
 
+enum {
+	PM8008_INFRA,
+	PM8008_REGULATORS,
+};
+
+static const struct of_device_id pm8008_match[] = {
+	{ .compatible = "qcom,pm8008", .data = (void *)PM8008_INFRA},
+	{ .compatible = "qcom,pm8008-regulators", .data = (void *)PM8008_REGULATORS},
+	{ },
+};
+
 #define PM8008_PERIPH_0_BASE	0x900
 #define PM8008_PERIPH_1_BASE	0x2400
 #define PM8008_PERIPH_2_BASE	0xC000
@@ -221,6 +264,7 @@ static int pm8008_probe(struct i2c_client *client)
 {
 	int rc;
 	struct pm8008_data *chip;
+	const struct of_device_id *id;
 
 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
@@ -239,14 +283,19 @@ static int pm8008_probe(struct i2c_client *client)
 			dev_err(chip->dev, "Failed to probe irq periphs: %d\n", rc);
 	}
 
+	id = of_match_node(pm8008_match, chip->dev->of_node);
+	if (id->data == (void *)PM8008_REGULATORS) {
+		rc = mfd_add_devices(chip->dev, 0, pm8008_regulator_devs,
+				ARRAY_SIZE(pm8008_regulator_devs), NULL, 0, NULL);
+		if (rc) {
+			dev_err(chip->dev, "Failed to add children: %d\n", rc);
+			return rc;
+		}
+	}
+
 	return devm_of_platform_populate(chip->dev);
 }
 
-static const struct of_device_id pm8008_match[] = {
-	{ .compatible = "qcom,pm8008", },
-	{ },
-};
-
 static struct i2c_driver pm8008_mfd_driver = {
 	.driver = {
 		.name = "pm8008",
-- 
2.7.4

