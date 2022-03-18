Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E5C4DD1B3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 01:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiCRANB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 20:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiCRAM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 20:12:59 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5B4141479;
        Thu, 17 Mar 2022 17:11:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 7A512E007A;
        Thu, 17 Mar 2022 17:11:11 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HS29Kj_9xdt9; Thu, 17 Mar 2022 17:11:10 -0700 (PDT)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To:     Hans de Goede <hdegoede@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/4] power: supply: max17042_battery: use ModelCfg refresh on max17055
Date:   Fri, 18 Mar 2022 01:10:46 +0100
Message-Id: <20220318001048.20922-3-sebastian.krzyszkowiak@puri.sm>
In-Reply-To: <20220318001048.20922-1-sebastian.krzyszkowiak@puri.sm>
References: <20220318001048.20922-1-sebastian.krzyszkowiak@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike other models, max17055 doesn't require cell characterization
data and operates on smaller amount of input variables (DesignCap,
VEmpty, IChgTerm and ModelCfg). Input data can already be filled in
by max17042_override_por_values, however model refresh bit has to be
set after adjusting input variables in order to make them apply.

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 drivers/power/supply/max17042_battery.c | 73 +++++++++++++++----------
 include/linux/power/max17042_battery.h  |  3 +
 2 files changed, 48 insertions(+), 28 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index c019d6c52363..c39250349a1d 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -806,6 +806,13 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
 	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055)) {
 		max17042_override_por(map, MAX17047_V_empty, config->vempty);
 	}
+
+	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055) {
+		max17042_override_por(map, MAX17055_ModelCfg, config->model_cfg);
+		// VChg is 1 by default, so allow it to be set to 0
+		regmap_update_bits(map, MAX17055_ModelCfg,
+				MAX17055_MODELCFG_VCHG_BIT, config->model_cfg);
+	}
 }
 
 static int max17042_init_chip(struct max17042_chip *chip)
@@ -814,44 +821,54 @@ static int max17042_init_chip(struct max17042_chip *chip)
 	int ret;
 
 	max17042_override_por_values(chip);
+
+	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055) {
+		regmap_write_bits(map, MAX17055_ModelCfg,
+				  MAX17055_MODELCFG_REFRESH_BIT, MAX17055_MODELCFG_REFRESH_BIT);
+	}
+
 	/* After Power up, the MAX17042 requires 500mS in order
 	 * to perform signal debouncing and initial SOC reporting
 	 */
 	msleep(500);
 
-	/* Initialize configuration */
-	max17042_write_config_regs(chip);
-
-	/* write cell characterization data */
-	ret = max17042_init_model(chip);
-	if (ret) {
-		dev_err(&chip->client->dev, "%s init failed\n",
-			__func__);
-		return -EIO;
-	}
+	if ((chip->chip_type == MAXIM_DEVICE_TYPE_MAX17042) ||
+	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17047) ||
+	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17050)) {
+		/* Initialize configuration */
+		max17042_write_config_regs(chip);
+
+		/* write cell characterization data */
+		ret = max17042_init_model(chip);
+		if (ret) {
+			dev_err(&chip->client->dev, "%s init failed\n",
+				__func__);
+			return -EIO;
+		}
 
-	ret = max17042_verify_model_lock(chip);
-	if (ret) {
-		dev_err(&chip->client->dev, "%s lock verify failed\n",
-			__func__);
-		return -EIO;
-	}
-	/* write custom parameters */
-	max17042_write_custom_regs(chip);
+		ret = max17042_verify_model_lock(chip);
+		if (ret) {
+			dev_err(&chip->client->dev, "%s lock verify failed\n",
+				__func__);
+			return -EIO;
+		}
+		/* write custom parameters */
+		max17042_write_custom_regs(chip);
 
-	/* update capacity params */
-	max17042_update_capacity_regs(chip);
+		/* update capacity params */
+		max17042_update_capacity_regs(chip);
 
-	/* delay must be atleast 350mS to allow VFSOC
-	 * to be calculated from the new configuration
-	 */
-	msleep(350);
+		/* delay must be at least 350mS to allow VFSOC
+		 * to be calculated from the new configuration
+		 */
+		msleep(350);
 
-	/* reset vfsoc0 reg */
-	max17042_reset_vfsoc0_reg(chip);
+		/* reset vfsoc0 reg */
+		max17042_reset_vfsoc0_reg(chip);
 
-	/* load new capacity params */
-	max17042_load_new_capacity_params(chip);
+		/* load new capacity params */
+		max17042_load_new_capacity_params(chip);
+	}
 
 	/* Init complete, Clear the POR bit */
 	regmap_update_bits(map, MAX17042_STATUS, STATUS_POR_BIT, 0x0);
diff --git a/include/linux/power/max17042_battery.h b/include/linux/power/max17042_battery.h
index c417abd2ab70..6943921cab5e 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -23,6 +23,8 @@
 
 #define MAX17042_CHARACTERIZATION_DATA_SIZE 48
 
+#define MAX17055_MODELCFG_REFRESH_BIT	BIT(15)
+
 enum max17042_register {
 	MAX17042_STATUS		= 0x00,
 	MAX17042_VALRT_Th	= 0x01,
@@ -208,6 +210,7 @@ struct max17042_config_data {
 	u16	full_soc_thresh;	/* 0x13 */
 	u16	design_cap;	/* 0x18 */
 	u16	ichgt_term;	/* 0x1E */
+	u16	model_cfg;	/* 0xDB */
 
 	/* MG3 config */
 	u16	at_rate;	/* 0x04 */
-- 
2.35.1

