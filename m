Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A221D53FDF7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243312AbiFGLvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238507AbiFGLvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:51:42 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD06B2EB9;
        Tue,  7 Jun 2022 04:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654602668; x=1686138668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=XgBd6JvLdyIrK2Wh6XK+AaOvG2JfKR0kXcKPTzcVORw=;
  b=vgeQwkDr0yDZYOHeG8ggenHm2PdvHwxOUxzv/1IadUpkcT0Xm4yu+Kny
   kEzk/BzX8pFOWeQzxfFPnGu3ApiXINpg+UfjJgAZiv9tPMzbXwP/s9Sl4
   lddtNo+WgZCPXgcLqNSYkj/eBfakVMBlleZRSeP4Rg78VsCBKRkbycQgC
   Y=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Jun 2022 04:51:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 04:51:07 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 04:51:07 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 04:51:02 -0700
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
Subject: [PATCH V14 6/9] mfd: pm8008: Use i2c_new_dummy_device() API
Date:   Tue, 7 Jun 2022 17:20:12 +0530
Message-ID: <1654602615-28849-7-git-send-email-quic_c_skakit@quicinc.com>
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

Use i2c_new_dummy_device() to register pm8008-regulator
client present at a different address space, instead of
defining a separate DT node. This avoids calling the probe
twice for the same chip, once for each client pm8008-infra
and pm8008-regulator.

As a part of this define pm8008_regmap_init() to do regmap
init for both the clients and define pm8008_get_regmap() to
pass the regmap to the regulator driver.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Changes in V14:
 - None.

Changes in V13:
 - None.

Changes in V12:
 - Make chip as const in pm8008_get_regmap() definition.
 - Use EXPORT_SYMBOL_GPL() for pm8008_get_regmap.
 - Add linux/mfd/qcom_pm8008.h to avoid error.

Changes in V11:
 - Remove the for loop and register dummy directly as there are
   only 2 clients.
 - Define pm8008_regmap_init() API to do the redundant init part.

 drivers/mfd/qcom-pm8008.c       | 34 ++++++++++++++++++++++++++++++++--
 include/linux/mfd/qcom_pm8008.h |  9 +++++++++
 2 files changed, 41 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/mfd/qcom_pm8008.h

diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index 569ffd50..55e2a8e 100644
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
@@ -57,6 +58,7 @@ enum {
 
 struct pm8008_data {
 	struct device *dev;
+	struct regmap *regulators_regmap;
 	int irq;
 	struct regmap_irq_chip_data *irq_data;
 };
@@ -150,6 +152,12 @@ static struct regmap_config qcom_mfd_regmap_cfg = {
 	.max_register	= 0xFFFF,
 };
 
+struct regmap *pm8008_get_regmap(const struct pm8008_data *chip)
+{
+	return chip->regulators_regmap;
+}
+EXPORT_SYMBOL_GPL(pm8008_get_regmap);
+
 static int pm8008_init(struct regmap *regmap)
 {
 	int rc;
@@ -217,11 +225,25 @@ static int pm8008_probe_irq_peripherals(struct pm8008_data *chip,
 	return 0;
 }
 
+static struct regmap *pm8008_regmap_init(struct i2c_client *client,
+							struct pm8008_data *chip)
+{
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &qcom_mfd_regmap_cfg);
+	if (!regmap)
+		return NULL;
+
+	i2c_set_clientdata(client, chip);
+	return regmap;
+}
+
 static int pm8008_probe(struct i2c_client *client)
 {
 	int rc;
 	struct pm8008_data *chip;
 	struct gpio_desc *reset_gpio;
+	struct i2c_client *regulators_client;
 	struct regmap *regmap;
 
 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
@@ -229,11 +251,19 @@ static int pm8008_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	chip->dev = &client->dev;
-	regmap = devm_regmap_init_i2c(client, &qcom_mfd_regmap_cfg);
+	regmap = pm8008_regmap_init(client, chip);
 	if (!regmap)
 		return -ENODEV;
 
-	i2c_set_clientdata(client, chip);
+	regulators_client = i2c_new_dummy_device(client->adapter, client->addr + 1);
+	if (IS_ERR(regulators_client)) {
+		dev_err(&client->dev, "can't attach client\n");
+		return PTR_ERR(regulators_client);
+	}
+
+	chip->regulators_regmap = pm8008_regmap_init(regulators_client, chip);
+	if (!chip->regulators_regmap)
+		return -ENODEV;
 
 	reset_gpio = devm_gpiod_get(chip->dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(reset_gpio))
diff --git a/include/linux/mfd/qcom_pm8008.h b/include/linux/mfd/qcom_pm8008.h
new file mode 100644
index 0000000..3814bff
--- /dev/null
+++ b/include/linux/mfd/qcom_pm8008.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+#ifndef __QCOM_PM8008_H__
+#define __QCOM_PM8008_H__
+
+struct pm8008_data;
+struct regmap *pm8008_get_regmap(const struct pm8008_data *chip);
+
+#endif
-- 
2.7.4

