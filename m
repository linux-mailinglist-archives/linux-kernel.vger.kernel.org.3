Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8F74BB77F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbiBRLCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 06:02:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbiBRLB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:01:58 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3834815C1BD;
        Fri, 18 Feb 2022 03:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645182101; x=1676718101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=LEi7vbeM1BKwa9AtkQH1WTnrKGLg9p8WD9c/eKb0VGU=;
  b=Pvimo1rfphBpYPzR31cz89kIZ4pGte+VlzjUVv+kiJJ0uKIBepeEtQjP
   M7HmP/tEB7kY7q+eU8W65e1nMPR3gBG7DQMd2ukbkP+riycG5M9T82j5D
   69CvJJU2xuwoXQnfc4uQvscOj//NHXlUmhbXqlHa3Her8m/pJA5Y6vygw
   k=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Feb 2022 03:01:41 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 03:01:40 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 18 Feb 2022 03:01:40 -0800
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 18 Feb 2022 03:01:36 -0800
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH V7 2/5] mfd: pm8008: Add mfd cell struct to register LDOs
Date:   Fri, 18 Feb 2022 16:31:00 +0530
Message-ID: <1645182064-15843-3-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645182064-15843-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1645182064-15843-1-git-send-email-quic_c_skakit@quicinc.com>
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

Add mfd cell struct with regulator driver name to match
with the pm8008 regulator driver and probe the LDOs.

Also, add a different compatible for the mfd node that
contains regulators to make sure that the LDOs are
registered with the correct mfd device.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
---
Changes in V5:
 - Changes newly added from V5.

Changes in V6:
 - Changed the mfd_cell struct to have only name of the regulator driver.
 - Using device_get_match_data() instead of of_match_node() to match data.
 - Fixed few nits.

Changes in V7:
 - Fixed minor errors.

 drivers/mfd/qcom-pm8008.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index c472d7f..6cfb267 100644
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
@@ -27,6 +28,10 @@
 #define INT_EN_CLR_OFFSET		0x16
 #define INT_LATCHED_STS_OFFSET		0x18
 
+static const struct mfd_cell pm8008_regulator_devs[] = {
+	MFD_CELL_NAME("qcom,pm8008-regulators"),
+};
+
 enum {
 	PM8008_MISC,
 	PM8008_TEMP_ALARM,
@@ -35,6 +40,11 @@ enum {
 	PM8008_NUM_PERIPHS,
 };
 
+enum pm8008_type {
+	PM8008_INFRA,
+	PM8008_REGULATORS,
+};
+
 #define PM8008_PERIPH_0_BASE	0x900
 #define PM8008_PERIPH_1_BASE	0x2400
 #define PM8008_PERIPH_2_BASE	0xC000
@@ -221,6 +231,7 @@ static int pm8008_probe(struct i2c_client *client)
 {
 	int rc;
 	struct pm8008_data *chip;
+	enum pm8008_type type;
 
 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
@@ -239,13 +250,25 @@ static int pm8008_probe(struct i2c_client *client)
 			dev_err(chip->dev, "Failed to probe irq periphs: %d\n", rc);
 	}
 
+	type = (uintptr_t) device_get_match_data(chip->dev);
+	if (type == PM8008_REGULATORS) {
+		rc = devm_mfd_add_devices(chip->dev, 0, pm8008_regulator_devs,
+				ARRAY_SIZE(pm8008_regulator_devs), NULL, 0, NULL);
+		if (rc) {
+			dev_err(chip->dev, "Failed to add children: %d\n", rc);
+			return rc;
+		}
+	}
+
 	return devm_of_platform_populate(chip->dev);
 }
 
 static const struct of_device_id pm8008_match[] = {
-	{ .compatible = "qcom,pm8008", },
-	{ },
+	{ .compatible = "qcom,pm8008", .data = (void *)PM8008_INFRA },
+	{ .compatible = "qcom,pm8008-regulators", .data = (void *)PM8008_REGULATORS },
+	{ }
 };
+MODULE_DEVICE_TABLE(of, pm8008_match);
 
 static struct i2c_driver pm8008_mfd_driver = {
 	.driver = {
-- 
2.7.4

