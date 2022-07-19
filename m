Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B2357960A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbiGSJSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237174AbiGSJSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:18:04 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8E8220CC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:18:00 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so582024wmm.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5CY2oTTeqFy5cStt397d3pGumay5g0vxYjseYWkjktA=;
        b=kWurz68eIwoxBR3NcGqLHBdZoVvcEshjwymNL9HQmnwgJKnemss0grF3domPzD2/xF
         Elt1OotTGPNu0pEBzmkbb3cMLHf4jMXgz06Ayl/jmQPJp4CJhg6PnDK+MQV1n/FpT0KQ
         wkJ8tyJAJUWbHzqYDM1TTIFAT9tHQrJ7BVDXibdFtuZ2VK9Ko6nKnBwNLyTljI33aAmS
         8bwJ1lyJdkk3arSXuuDIbCuxJIr/7JeVURxMEvOU/R9JihDi1tsjLBbLggGoIbR072jd
         dqdM7ce/f/41HF1RTugUe9PPCcUbwhCfl1uu2NhT6WU6saq4bcYzDayvqcFOePKXS5gK
         mbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5CY2oTTeqFy5cStt397d3pGumay5g0vxYjseYWkjktA=;
        b=mBsTsYMhHdsNyBQnz2CtrpOpOGUC2NUVpcBfoBW/Gu9GvEiDVPkLIDZSh3qzM7A7fj
         1/udZOQ2S33AVhtNAbqEB1sxhECApJiKP3pVMexwzraPr4ZA/+hK+74Mc6hbDCuX8upI
         ALWQB6qA8xJm9Y6XF1RFguA5/yvXNrutmmHusp5fAViYbV03XnFI1QMl4gfumEpwCZDl
         g6SD8IOpWsIKKh/uJYQvkwhLD2/rMhksGkFip3kelbNPs8uOzJeK0J/t6HJYXHqAxGHN
         naw2nUFVwm3ETpugy4GXzZyav+QaejJOPMC7bwfqQjhia2ABwExH5ExQ6APbjcie/upS
         c5MA==
X-Gm-Message-State: AJIora/4cHhROsjcAFN3C7gYlNGbwaMlnufdw3o+EFnanE3PtpPb0JwR
        ei16qlb+oMwRNE5da5XQSayiTA==
X-Google-Smtp-Source: AGRyM1uXkd+9Gh/vkOKczKnw76geB7gvx1DhiApNqxxi8Rd2o123mvcEkeOO3q1xtfCJYUzDXPiRJg==
X-Received: by 2002:a05:600c:3b07:b0:3a3:1433:10b5 with SMTP id m7-20020a05600c3b0700b003a3143310b5mr13059631wms.129.1658222279573;
        Tue, 19 Jul 2022 02:17:59 -0700 (PDT)
Received: from localhost.localdomain (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id bk19-20020a0560001d9300b0021d63fe0f03sm12944281wrb.12.2022.07.19.02.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 02:17:59 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.c, lee.jones@linaro.org, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 06/14] mfd: drivers: Add interrupts support to TI TPS65219 PMIC
Date:   Tue, 19 Jul 2022 11:17:34 +0200
Message-Id: <20220719091742.3221-7-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220719091742.3221-1-jneanne@baylibre.com>
References: <20220719091742.3221-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TPS65219 support for interrupts through regmap_irq_chip

Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 drivers/mfd/tps65219.c       | 217 ++++++++++++++++++++++++++++++++++-
 include/linux/mfd/tps65219.h | 113 ++++++++++++++++++
 2 files changed, 328 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
index 62677c26ed78..b01a62c09885 100644
--- a/drivers/mfd/tps65219.c
+++ b/drivers/mfd/tps65219.c
@@ -108,8 +108,73 @@ static void pmic_do_poweroff(void)
 	tps65219_soft_shutdown(tps);
 }
 
-static const struct mfd_cell tps65219_cells[] = {
-	{ .name = "tps65219-regulator", },
+static const struct resource tps65219_pwrbutton_resources[] = {
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_PB_FALLING_EDGE_DETECT, "falling"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_PB_RISING_EDGE_DETECT, "rising"),
+};
+
+static const struct resource tps65219_regulator_resources[] = {
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO3_SCG, "LDO3_SCG"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO3_OC, "LDO3_OC"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO3_UV, "LDO3_UV"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO4_SCG, "LDO4_SCG"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO4_OC, "LDO4_OC"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO4_UV, "LDO4_UV"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO1_SCG, "LDO1_SCG"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO1_OC, "LDO1_OC"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO1_UV, "LDO1_UV"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO2_SCG, "LDO2_SCG"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO2_OC, "LDO2_OC"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO2_UV, "LDO2_UV"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK3_SCG, "BUCK3_SCG"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK3_OC, "BUCK3_OC"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK3_NEG_OC, "BUCK3_NEG_OC"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK3_UV, "BUCK3_UV"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK1_SCG, "BUCK1_SCG"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK1_OC, "BUCK1_OC"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK1_NEG_OC, "BUCK1_NEG_OC"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK1_UV, "BUCK1_UV"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK2_SCG, "BUCK2_SCG"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK2_OC, "BUCK2_OC"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK2_NEG_OC, "BUCK2_NEG_OC"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK2_UV, "BUCK2_UV"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK1_RV, "BUCK1_RV"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK2_RV, "BUCK2_RV"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK3_RV, "BUCK3_RV"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO1_RV, "LDO1_RV"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO2_RV, "LDO2_RV"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO3_RV, "LDO3_RV"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO4_RV, "LDO4_RV"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK1_RV_SD, "BUCK1_RV_SD"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK2_RV_SD, "BUCK2_RV_SD"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK3_RV_SD, "BUCK3_RV_SD"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO1_RV_SD, "LDO1_RV_SD"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO2_RV_SD, "LDO2_RV_SD"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO3_RV_SD, "LDO3_RV_SD"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO4_RV_SD, "LDO4_RV_SD"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_TIMEOUT, "TIMEOUT"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_3_WARM, "SENSOR_3_WARM"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_2_WARM, "SENSOR_2_WARM"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_1_WARM, "SENSOR_1_WARM"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_0_WARM, "SENSOR_0_WARM"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_3_HOT, "SENSOR_3_HOT"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_2_HOT, "SENSOR_2_HOT"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_1_HOT, "SENSOR_1_HOT"),
+	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_0_HOT, "SENSOR_0_HOT"),
+};
+
+#define TPS65219_MAX_CELLS 2
+
+static const struct mfd_cell tps65219_regulator_cell = {
+	.name = "tps65219-regulator",
+	.resources = tps65219_regulator_resources,
+	.num_resources = ARRAY_SIZE(tps65219_regulator_resources),
+};
+
+static const struct mfd_cell tps65219_pwrbutton_cell = {
+	.name = "tps65219-pwrbutton",
+	.resources = tps65219_pwrbutton_resources,
+	.num_resources = ARRAY_SIZE(tps65219_pwrbutton_resources),
 };
 
 static const struct regmap_config tps65219_regmap_config = {
@@ -118,6 +183,147 @@ static const struct regmap_config tps65219_regmap_config = {
 	.max_register = TPS65219_REG_FACTORY_CONFIG_2,
 };
 
+/*
+ * Mapping of main IRQ register bits to sub-IRQ register offsets so that we can
+ * access corect sub-IRQ registers based on bits that are set in main IRQ
+ * register.
+ */
+/* Timeout Residual Voltage Shutdown */
+static unsigned int bit0_offsets[] = {TPS65219_TO_RV_POS};
+static unsigned int bit1_offsets[] = {TPS65219_RV_POS};	/* Residual Voltage */
+static unsigned int bit2_offsets[] = {TPS65219_SYS_POS};	/* System */
+static unsigned int bit3_offsets[] = {TPS65219_BUCK_1_2_POS};	/* Buck 1-2 */
+static unsigned int bit4_offsets[] = {TPS65219_BUCK_3_POS};	/* Buck 3 */
+static unsigned int bit5_offsets[] = {TPS65219_LDO_1_2_POS};	/* LDO 1-2 */
+static unsigned int bit6_offsets[] = {TPS65219_LDO_3_4_POS};	/* LDO 3-4 */
+static unsigned int bit7_offsets[] = {TPS65219_PB_POS};	/* Power Button */
+
+static struct regmap_irq_sub_irq_map tps65219_sub_irq_offsets[] = {
+	REGMAP_IRQ_MAIN_REG_OFFSET(bit0_offsets),
+	REGMAP_IRQ_MAIN_REG_OFFSET(bit1_offsets),
+	REGMAP_IRQ_MAIN_REG_OFFSET(bit2_offsets),
+	REGMAP_IRQ_MAIN_REG_OFFSET(bit3_offsets),
+	REGMAP_IRQ_MAIN_REG_OFFSET(bit4_offsets),
+	REGMAP_IRQ_MAIN_REG_OFFSET(bit5_offsets),
+	REGMAP_IRQ_MAIN_REG_OFFSET(bit6_offsets),
+	REGMAP_IRQ_MAIN_REG_OFFSET(bit7_offsets),
+};
+
+static struct regmap_irq tps65219_irqs[] = {
+	REGMAP_IRQ_REG(TPS65219_INT_LDO3_SCG, TPS65219_LDO_3_4_POS,
+		       TPS65219_INT_LDO3_SCG_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_LDO3_OC,
+		       TPS65219_LDO_3_4_POS, TPS65219_INT_LDO3_OC_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_LDO3_UV, TPS65219_LDO_3_4_POS,
+		       TPS65219_INT_LDO3_UV_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_LDO4_SCG, TPS65219_LDO_3_4_POS,
+		       TPS65219_INT_LDO4_SCG_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_LDO4_OC, TPS65219_LDO_3_4_POS,
+		       TPS65219_INT_LDO4_OC_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_LDO4_UV, TPS65219_LDO_3_4_POS,
+		       TPS65219_INT_LDO4_UV_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_LDO1_SCG,
+		       TPS65219_LDO_1_2_POS, TPS65219_INT_LDO1_SCG_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_LDO1_OC, TPS65219_LDO_1_2_POS,
+		       TPS65219_INT_LDO1_OC_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_LDO1_UV, TPS65219_LDO_1_2_POS,
+		       TPS65219_INT_LDO1_UV_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_LDO2_SCG, TPS65219_LDO_1_2_POS,
+		       TPS65219_INT_LDO2_SCG_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_LDO2_OC, TPS65219_LDO_1_2_POS,
+		       TPS65219_INT_LDO2_OC_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_LDO2_UV, TPS65219_LDO_1_2_POS,
+		       TPS65219_INT_LDO2_UV_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_BUCK3_SCG, TPS65219_BUCK_3_POS,
+		       TPS65219_INT_BUCK3_SCG_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_BUCK3_OC, TPS65219_BUCK_3_POS,
+		       TPS65219_INT_BUCK3_OC_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_BUCK3_NEG_OC, TPS65219_BUCK_3_POS,
+		       TPS65219_INT_BUCK3_NEG_OC_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_BUCK3_UV, TPS65219_BUCK_3_POS,
+		       TPS65219_INT_BUCK3_UV_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_BUCK2_SCG, TPS65219_BUCK_1_2_POS,
+		       TPS65219_INT_BUCK2_SCG_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_BUCK2_OC, TPS65219_BUCK_1_2_POS,
+		       TPS65219_INT_BUCK2_OC_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_BUCK2_NEG_OC, TPS65219_BUCK_1_2_POS,
+		       TPS65219_INT_BUCK2_NEG_OC_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_BUCK2_UV, TPS65219_BUCK_1_2_POS,
+		       TPS65219_INT_BUCK2_UV_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_BUCK1_SCG, TPS65219_BUCK_1_2_POS,
+		       TPS65219_INT_BUCK1_SCG_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_BUCK1_OC, TPS65219_BUCK_1_2_POS,
+		       TPS65219_INT_BUCK1_OC_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_BUCK1_NEG_OC, TPS65219_BUCK_1_2_POS,
+		       TPS65219_INT_BUCK1_NEG_OC_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_BUCK1_UV, TPS65219_BUCK_1_2_POS,
+		       TPS65219_INT_BUCK1_UV_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_SENSOR_3_WARM,
+		       TPS65219_SYS_POS, TPS65219_INT_SENSOR_3_WARM_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_SENSOR_2_WARM, TPS65219_SYS_POS,
+		       TPS65219_INT_SENSOR_2_WARM_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_SENSOR_1_WARM, TPS65219_SYS_POS,
+		       TPS65219_INT_SENSOR_1_WARM_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_SENSOR_0_WARM, TPS65219_SYS_POS,
+		       TPS65219_INT_SENSOR_0_WARM_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_SENSOR_3_HOT, TPS65219_SYS_POS,
+		       TPS65219_INT_SENSOR_3_HOT_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_SENSOR_2_HOT, TPS65219_SYS_POS,
+		       TPS65219_INT_SENSOR_2_HOT_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_SENSOR_1_HOT, TPS65219_SYS_POS,
+		       TPS65219_INT_SENSOR_1_HOT_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_SENSOR_0_HOT, TPS65219_SYS_POS,
+		       TPS65219_INT_SENSOR_0_HOT_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_BUCK1_RV, TPS65219_RV_POS,
+		       TPS65219_INT_BUCK1_RV_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_BUCK2_RV, TPS65219_RV_POS,
+		       TPS65219_INT_BUCK2_RV_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_BUCK3_RV, TPS65219_RV_POS,
+		       TPS65219_INT_BUCK3_RV_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_LDO1_RV, TPS65219_RV_POS,
+		       TPS65219_INT_LDO1_RV_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_LDO2_RV, TPS65219_RV_POS,
+		       TPS65219_INT_LDO2_RV_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_LDO3_RV, TPS65219_RV_POS,
+		       TPS65219_INT_LDO3_RV_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_LDO4_RV, TPS65219_RV_POS,
+		       TPS65219_INT_LDO4_RV_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_BUCK1_RV_SD,
+		       TPS65219_TO_RV_POS, TPS65219_INT_BUCK1_RV_SD_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_BUCK2_RV_SD,
+		       TPS65219_TO_RV_POS, TPS65219_INT_BUCK2_RV_SD_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_BUCK3_RV_SD, TPS65219_TO_RV_POS,
+		       TPS65219_INT_BUCK3_RV_SD_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_LDO1_RV_SD, TPS65219_TO_RV_POS,
+		       TPS65219_INT_LDO1_RV_SD_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_LDO2_RV_SD, TPS65219_TO_RV_POS,
+		       TPS65219_INT_LDO2_RV_SD_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_LDO3_RV_SD,
+		       TPS65219_TO_RV_POS, TPS65219_INT_LDO3_RV_SD_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_LDO4_RV_SD, TPS65219_TO_RV_POS,
+		       TPS65219_INT_LDO4_RV_SD_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_TIMEOUT, TPS65219_TO_RV_POS,
+		       TPS65219_INT_TIMEOUT_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_PB_FALLING_EDGE_DETECT,
+		       TPS65219_PB_POS, TPS65219_INT_PB_FALLING_EDGE_DET_MASK),
+	REGMAP_IRQ_REG(TPS65219_INT_PB_RISING_EDGE_DETECT, TPS65219_PB_POS,
+		       TPS65219_INT_PB_RISING_EDGE_DET_MASK),
+};
+
+static struct regmap_irq_chip tps65219_irq_chip = {
+	.name = "tps65219_irq",
+	.main_status = TPS65219_REG_INT_SOURCE,
+	.num_main_regs = 1,
+	.num_main_status_bits = 8,
+	.irqs = tps65219_irqs,
+	.num_irqs = ARRAY_SIZE(tps65219_irqs),
+	.status_base = TPS65219_REG_INT_LDO_3_4,
+	.ack_base = TPS65219_REG_INT_LDO_3_4,
+	.clear_ack = 1,
+	.num_regs = 8,
+	.sub_reg_offsets = &tps65219_sub_irq_offsets[0],
+};
+
 static const struct of_device_id of_tps65219_match_table[] = {
 	{ .compatible = "ti,tps65219", },
 	{}
@@ -138,6 +344,7 @@ static int tps65219_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, tps);
 	tps->dev = &client->dev;
+	tps->irq = client->irq;
 	tps->regmap = devm_regmap_init_i2c(client, &tps65219_regmap_config);
 	if (IS_ERR(tps->regmap)) {
 		ret = PTR_ERR(tps->regmap);
@@ -146,6 +353,12 @@ static int tps65219_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	ret = devm_regmap_add_irq_chip(&client->dev, tps->regmap, tps->irq,
+				       IRQF_ONESHOT, 0, &tps65219_irq_chip,
+				       &tps->irq_data);
+	if (ret)
+		return ret;
+
 	ret = regmap_read(tps->regmap, TPS65219_REG_TI_DEV_ID, &chipid);
 	if (ret) {
 		dev_err(tps->dev, "Failed to read device ID: %d\n", ret);
diff --git a/include/linux/mfd/tps65219.h b/include/linux/mfd/tps65219.h
index e9197ab8bc75..8cecaf9bc682 100644
--- a/include/linux/mfd/tps65219.h
+++ b/include/linux/mfd/tps65219.h
@@ -214,6 +214,104 @@
 #define TPS65219_INT_PB_RISING_EDGE_DET_MASK		BIT(1)
 #define TPS65219_INT_PB_REAL_TIME_STATUS_MASK		BIT(2)
 
+/* Masks for main IRQ register bits */
+enum {
+	TPS65219_INT_TIMEOUT_RV_SD,
+#define TPS65219_INT_TIMEOUT_RV_SD_MASK BIT(TPS65219_INT_TIMEOUT_RV_SD)
+	TPS65219_INT_RV,
+#define TPS65219_INT_RV_MASK BIT(TPS65219_INT_RV)
+	TPS65219_INT_SYSTEM,
+#define TPS65219_INT_SYSTEM_MASK BIT(TPS65219_INT_SYSTEM)
+	TPS65219_INT_BUCK_1_2,
+#define TPS65219_INT_BUCK_1_2_MASK BIT(TPS65219_INT_BUCK_1_2)
+	TPS65219_INT_BUCK_3,
+#define TPS65219_INT_BUCK_3_MASK BIT(TPS65219_INT_BUCK_3)
+	TPS65219_INT_LDO_1_2,
+#define TPS65219_INT_LDO_1_2_MASK BIT(TPS65219_INT_LDO_1_2)
+	TPS65219_INT_LDO_3_4,
+#define TPS65219_INT_LDO_3_4_MASK BIT(TPS65219_LDO_3_4)
+	TPS65219_INT_PB,
+#define TPS65219_INT_PB_MASK BIT(TPS65219_INT_PB)
+};
+
+/* Timeout Residual Voltage Shutdown */
+#define TPS65219_TO_RV_POS 6
+/* Residual Voltage */
+#define TPS65219_RV_POS 5
+/* System */
+#define TPS65219_SYS_POS 4
+/* Buck 1-2 */
+#define TPS65219_BUCK_1_2_POS 3
+/* Buck 3 */
+#define TPS65219_BUCK_3_POS 2
+/* LDO 1-2 */
+#define TPS65219_LDO_1_2_POS 1
+/* LDO 3-4 */
+#define TPS65219_LDO_3_4_POS 0
+/* Power Button */
+#define TPS65219_PB_POS 7
+
+/* IRQs */
+enum {
+	/* LDO3-4 register IRQs */
+	TPS65219_INT_LDO3_SCG,
+	TPS65219_INT_LDO3_OC,
+	TPS65219_INT_LDO3_UV,
+	TPS65219_INT_LDO4_SCG,
+	TPS65219_INT_LDO4_OC,
+	TPS65219_INT_LDO4_UV,
+	/* LDO1-2 */
+	TPS65219_INT_LDO1_SCG,
+	TPS65219_INT_LDO1_OC,
+	TPS65219_INT_LDO1_UV,
+	TPS65219_INT_LDO2_SCG,
+	TPS65219_INT_LDO2_OC,
+	TPS65219_INT_LDO2_UV,
+	/* BUCK3 */
+	TPS65219_INT_BUCK3_SCG,
+	TPS65219_INT_BUCK3_OC,
+	TPS65219_INT_BUCK3_NEG_OC,
+	TPS65219_INT_BUCK3_UV,
+	/* BUCK1-2 */
+	TPS65219_INT_BUCK1_SCG,
+	TPS65219_INT_BUCK1_OC,
+	TPS65219_INT_BUCK1_NEG_OC,
+	TPS65219_INT_BUCK1_UV,
+	TPS65219_INT_BUCK2_SCG,
+	TPS65219_INT_BUCK2_OC,
+	TPS65219_INT_BUCK2_NEG_OC,
+	TPS65219_INT_BUCK2_UV,
+	/* Thermal Sensor  */
+	TPS65219_INT_SENSOR_3_WARM,
+	TPS65219_INT_SENSOR_2_WARM,
+	TPS65219_INT_SENSOR_1_WARM,
+	TPS65219_INT_SENSOR_0_WARM,
+	TPS65219_INT_SENSOR_3_HOT,
+	TPS65219_INT_SENSOR_2_HOT,
+	TPS65219_INT_SENSOR_1_HOT,
+	TPS65219_INT_SENSOR_0_HOT,
+	/* Residual Voltage */
+	TPS65219_INT_BUCK1_RV,
+	TPS65219_INT_BUCK2_RV,
+	TPS65219_INT_BUCK3_RV,
+	TPS65219_INT_LDO1_RV,
+	TPS65219_INT_LDO2_RV,
+	TPS65219_INT_LDO3_RV,
+	TPS65219_INT_LDO4_RV,
+	/* Residual Voltage ShutDown */
+	TPS65219_INT_BUCK1_RV_SD,
+	TPS65219_INT_BUCK2_RV_SD,
+	TPS65219_INT_BUCK3_RV_SD,
+	TPS65219_INT_LDO1_RV_SD,
+	TPS65219_INT_LDO2_RV_SD,
+	TPS65219_INT_LDO3_RV_SD,
+	TPS65219_INT_LDO4_RV_SD,
+	TPS65219_INT_TIMEOUT,
+	/* Power Button */
+	TPS65219_INT_PB_FALLING_EDGE_DETECT,
+	TPS65219_INT_PB_RISING_EDGE_DETECT,
+};
+
 enum tps65219_regulator_id {
 	/* DCDC's */
 	TPS65219_BUCK_1,
@@ -235,6 +333,19 @@ enum tps65219_regulator_id {
 /* Number of total regulators available */
 #define TPS65219_NUM_REGULATOR		(TPS65219_NUM_DCDC + TPS65219_NUM_LDO)
 
+/* Define the TPS65219 IRQ numbers */
+enum tps65219_irqs {
+	/* INT source registers */
+	TPS65219_TO_RV_SD_SET_IRQ,
+	TPS65219_RV_SET_IRQ,
+	TPS65219_SYS_SET_IRQ,
+	TPS65219_BUCK_1_2_SET_IRQ,
+	TPS65219_BUCK_3_SET_IRQ,
+	TPS65219_LDO_1_2_SET_IRQ,
+	TPS65219_LDO_3_4_SET_IRQ,
+	TPS65219_PB_SET_IRQ,
+};
+
 /**
  * struct tps65219 - tps65219 sub-driver chip access routines
  *
@@ -243,6 +354,8 @@ enum tps65219_regulator_id {
 struct tps65219 {
 	struct device *dev;
 	unsigned int id;
+	int irq;
+	struct regmap_irq_chip_data *irq_data;
 	struct regulator_desc desc[TPS65219_NUM_REGULATOR];
 	struct regmap *regmap;
 	struct notifier_block nb;
-- 
2.17.1

