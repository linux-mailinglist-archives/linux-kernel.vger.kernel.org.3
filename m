Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA6D4B66AA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbiBOIyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:54:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbiBOIyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:54:39 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D0B1160C1;
        Tue, 15 Feb 2022 00:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644915269; x=1676451269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=yLXUZ4iQ1/oqKxe8H64i+/qtCCxE2+S+ub6av7PPEYg=;
  b=vH00hGsguIMt7OyKHt+v6AyS9IER1yNnkj+0ci5aJqshFORd8bkxQ0vs
   9zavpUYcv+bcR+667JGC+4XKMMZSPTMBjqW/jCAL4kwdYbK7xXOsZL70X
   CXrrmirfpuN2GQvlSTOwJLETnm7qSJFR5Lb4Lo25A8TBAozsZFn9sizuS
   s=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Feb 2022 00:54:29 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 00:54:29 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Feb 2022 00:54:28 -0800
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 15 Feb 2022 00:54:24 -0800
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
Subject: [PATCH V6 3/6] mfd: pm8008: Add mfd cell struct to register LDOs
Date:   Tue, 15 Feb 2022 14:23:48 +0530
Message-ID: <1644915231-7308-4-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644915231-7308-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1644915231-7308-1-git-send-email-quic_c_skakit@quicinc.com>
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

Changes in V6:
 - Changed the mfd_cell struct to have only name of the regulator driver.
 - Using device_get_match_data() instead of of_match_node() to match data.
 - Fixed few nits.

 drivers/mfd/qcom-pm8008.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index c472d7f..a1cf8a9 100644
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
@@ -239,13 +250,24 @@ static int pm8008_probe(struct i2c_client *client)
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
+	{ .compatible = "qcom,pm8008", .data = (void *)PM8008_INFRA},
+	{ .compatible = "qcom,pm8008-regulators", .data = (void *)PM8008_REGULATORS},
 };
+MODULE_DEVICE_TABLE(of, pm8008_match)
 
 static struct i2c_driver pm8008_mfd_driver = {
 	.driver = {
-- 
2.7.4

