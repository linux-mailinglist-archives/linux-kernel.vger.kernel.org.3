Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FBF51361F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239625AbiD1OFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbiD1OFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:05:24 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74772AC05A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1651154530;
  x=1682690530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0o046V5LTb9auUauxaDjouuv4TSNo+wrm6kWHbr7gPE=;
  b=Gta0c6sIzcmGFNk0BYhwdhnR+FSuHHB/DJiG25sBXTxmWchPQQ/TH1h1
   bsPlNbNdGTZathZD9Ae6UBZcstZhufzou/71IG0oO2RaGYrinJQrI1tDs
   q3I74n6D0ShU/Af29uGy0mKajw9cd7ytmRo92AajdojQ430R3gdUPpSJT
   /KoN1LIKncAqxDuMT7qYlm4sBL4D+a4lUkuHKLIKT8bBPm/eg2yGwt+IP
   cJtrJPbkImOFZuQ2euC47OhwezbkPq4wZiH/hhJ62LznfCBXO25d7XCGW
   AWG9hhpJyfOlAUPLigLxV/f1JGUbS+TiauRvbPIWhGMaPW9qc0m8cv8sR
   A==;
From:   Rickard Andersson <rickaran@axis.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <yibin.gong@nxp.com>
CC:     <rickaran@axis.com>, <rickard314.andersson@gmail.com>,
        <perdo@axis.com>
Subject: [PATCH 2/5] regulator: pca9450: Make I2C Level Translator configurable
Date:   Thu, 28 Apr 2022 16:01:36 +0200
Message-ID: <20220428140139.7349-2-rickaran@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220428140139.7349-1-rickaran@axis.com>
References: <20220428140139.7349-1-rickaran@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail06w.axis.com (10.20.40.12) To se-mail03w.axis.com
 (10.20.40.9)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Per-Daniel Olsson <perdo@axis.com>

Make the I2C Level Translator included in PCA9450 configurable from
devicetree. The reset state is off. By setting nxp,i2c-lt-enable, the
I2C Level Translator will be enabled while in STANDBY or RUN state.

Signed-off-by: Per-Daniel Olsson <perdo@axis.com>
---
 drivers/regulator/pca9450-regulator.c | 11 +++++++++++
 include/linux/regulator/pca9450.h     |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 64e5f5f0cc84..87b4e6e29ba1 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -810,6 +810,17 @@ static int pca9450_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	if (of_property_read_bool(i2c->dev.of_node, "nxp,i2c-lt-enable")) {
+		/* Enable I2C Level Translator */
+		ret = regmap_update_bits(pca9450->regmap, PCA9450_REG_CONFIG2,
+					 I2C_LT_MASK, I2C_LT_ON_STANDBY_RUN);
+		if (ret) {
+			dev_err(&i2c->dev,
+				"Failed to enable I2C level translator\n");
+			return ret;
+		}
+	}
+
 	/*
 	 * The driver uses the LDO5CTRL_H register to control the LDO5 regulator.
 	 * This is only valid if the SD_VSEL input of the PMIC is high. Let's
diff --git a/include/linux/regulator/pca9450.h b/include/linux/regulator/pca9450.h
index 71902f41c919..3c01c2bf84f5 100644
--- a/include/linux/regulator/pca9450.h
+++ b/include/linux/regulator/pca9450.h
@@ -226,4 +226,11 @@ enum {
 #define WDOG_B_CFG_COLD_LDO12		0x80
 #define WDOG_B_CFG_COLD			0xC0
 
+/* PCA9450_REG_CONFIG2 bits */
+#define I2C_LT_MASK			0x03
+#define I2C_LT_FORCE_DISABLE		0x00
+#define I2C_LT_ON_STANDBY_RUN		0x01
+#define I2C_LT_ON_RUN			0x02
+#define I2C_LT_FORCE_ENABLE		0x03
+
 #endif /* __LINUX_REG_PCA9450_H__ */
-- 
2.20.1

