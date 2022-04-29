Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1871E514334
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 09:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355122AbiD2HZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 03:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352276AbiD2HZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 03:25:49 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C22BF53F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 00:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1651216952;
  x=1682752952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KYg1TXMzYJtMpoQ+QzW9RzF3s3X78aKAH5i5LPSuMRs=;
  b=O8bsbGdXumBrHocyqEhB+NlFs4H2Tb2Scg8L3DW8/SLFqJZVwNCL69c/
   ksOSXeQ40qx6Qu7jKdvQgBbtIKBJulzylRlL3hJoDUTcKZFJDBSGbW5IF
   XGxCNNsXl+K3hMvQMivybwFo8aRh7vXS4RisrzM3YO3yPs9zk62xHnPw/
   nhEKTYt4tQQxns7mLAYOPcVKl/DOjxMIx7oT0fAuI+XNRJZcjnKcJTfk5
   JyJkCI6R+Ro6P/82sFPmrG2ieTprCXWGnvPvzKIxx8wI3BqrD8ve9e+kc
   oDNZyRLH2SG75W1ACD8HmjaKcNfgKNPqdFWfApDA04yEFuHv+Cv7eWNpi
   A==;
From:   Rickard Andersson <rickaran@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rickaran@axis.com>, <rickard314.andersson@gmail.com>,
        <perdo@axis.com>
Subject: [PATCH v2 2/5] regulator: pca9450: Make I2C Level Translator configurable
Date:   Fri, 29 Apr 2022 09:22:08 +0200
Message-ID: <20220429072211.24957-2-rickaran@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220429072211.24957-1-rickaran@axis.com>
References: <20220429072211.24957-1-rickaran@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail03w.axis.com
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
Signed-off-by: Rickard x Andersson <rickaran@axis.com>
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

