Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175E85B1136
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 02:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiIHAb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 20:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiIHAbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:31:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDC38B98C;
        Wed,  7 Sep 2022 17:31:14 -0700 (PDT)
Received: from jupiter.universe (dyndsl-095-033-158-249.ewe-ip-backbone.de [95.33.158.249])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1EA006601F72;
        Thu,  8 Sep 2022 01:31:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662597072;
        bh=IM+Bej5pINQkC3tmilDIvrNJfMrYRMJBQqOcyrnxP/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fWvrhLQPP83xRl+H7fKWhFDeSEmqd+n27MDvschXHdx3UrA8ngV1kztTnMArAIgEM
         hCG9tCsKZzhEKihG3YJTgX9vg64VdPylDT40HOcOVmHfzW796huy9fNTxNkKPmcKeV
         kMHLrFpbJaNMBiJpCuMF1MhDvURaYXJQmqMM424asRWsJptIQBjXq4bq40eLQ49Y5A
         6igVf7Ac562Bk/fDCkIceOLn8siR/3FutSDt+m0x+Q1FcNpF2poApm2gD1JwnW/Yy/
         m387zA5/FCQC4sy7Svm+pdB1aR7oJ+G7D7X5Yu/J964qYvPbq4mEUCtqzKolYt79JB
         pmN8zvsHJ+kcw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 5C75A48057D; Thu,  8 Sep 2022 02:31:09 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 01/13] mfd: rk808: convert to device managed resources
Date:   Thu,  8 Sep 2022 02:30:55 +0200
Message-Id: <20220908003107.220143-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220908003107.220143-1-sebastian.reichel@collabora.com>
References: <20220908003107.220143-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fully convert the driver to device managed resources.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/mfd/rk808.c | 66 +++++++++++++++------------------------------
 1 file changed, 22 insertions(+), 44 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 4142b638e5fa..c17fea1d48ca 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -527,13 +527,11 @@ static const struct regmap_irq_chip rk818_irq_chip = {
 	.init_ack_masked = true,
 };
 
-static struct i2c_client *rk808_i2c_client;
-
-static void rk808_pm_power_off(void)
+static int rk808_power_off(struct sys_off_data *data)
 {
+	struct rk808 *rk808 = data->cb_data;
 	int ret;
 	unsigned int reg, bit;
-	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
 
 	switch (rk808->variant) {
 	case RK805_ID:
@@ -554,16 +552,18 @@ static void rk808_pm_power_off(void)
 		bit = DEV_OFF;
 		break;
 	default:
-		return;
+		return NOTIFY_DONE;
 	}
 	ret = regmap_update_bits(rk808->regmap, reg, bit, bit);
 	if (ret)
-		dev_err(&rk808_i2c_client->dev, "Failed to shutdown device!\n");
+		dev_err(&rk808->i2c->dev, "Failed to shutdown device!\n");
+
+	return NOTIFY_DONE;
 }
 
-static int rk808_restart_notify(struct notifier_block *this, unsigned long mode, void *cmd)
+static int rk808_restart(struct sys_off_data *data)
 {
-	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
+	struct rk808 *rk808 = data->cb_data;
 	unsigned int reg, bit;
 	int ret;
 
@@ -579,16 +579,11 @@ static int rk808_restart_notify(struct notifier_block *this, unsigned long mode,
 	}
 	ret = regmap_update_bits(rk808->regmap, reg, bit, bit);
 	if (ret)
-		dev_err(&rk808_i2c_client->dev, "Failed to restart device!\n");
+		dev_err(&rk808->i2c->dev, "Failed to restart device!\n");
 
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block rk808_restart_handler = {
-	.notifier_call = rk808_restart_notify,
-	.priority = 192,
-};
-
 static void rk8xx_shutdown(struct i2c_client *client)
 {
 	struct rk808 *rk808 = i2c_get_clientdata(client);
@@ -725,9 +720,9 @@ static int rk808_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	ret = regmap_add_irq_chip(rk808->regmap, client->irq,
-				  IRQF_ONESHOT, -1,
-				  rk808->regmap_irq_chip, &rk808->irq_data);
+	ret = devm_regmap_add_irq_chip(&client->dev, rk808->regmap, client->irq,
+				       IRQF_ONESHOT, -1,
+				       rk808->regmap_irq_chip, &rk808->irq_data);
 	if (ret) {
 		dev_err(&client->dev, "Failed to add irq_chip %d\n", ret);
 		return ret;
@@ -751,17 +746,23 @@ static int rk808_probe(struct i2c_client *client,
 			      regmap_irq_get_domain(rk808->irq_data));
 	if (ret) {
 		dev_err(&client->dev, "failed to add MFD devices %d\n", ret);
-		goto err_irq;
+		return ret;
 	}
 
 	if (of_property_read_bool(np, "rockchip,system-power-controller")) {
-		rk808_i2c_client = client;
-		pm_power_off = rk808_pm_power_off;
+		ret = devm_register_sys_off_handler(&client->dev,
+				    SYS_OFF_MODE_POWER_OFF_PREPARE, SYS_OFF_PRIO_HIGH,
+				    &rk808_power_off, rk808);
+		if (ret)
+			return dev_err_probe(&client->dev, ret,
+					     "failed to register poweroff handler\n");
 
 		switch (rk808->variant) {
 		case RK809_ID:
 		case RK817_ID:
-			ret = register_restart_handler(&rk808_restart_handler);
+			ret = devm_register_sys_off_handler(&client->dev,
+							    SYS_OFF_MODE_RESTART, SYS_OFF_PRIO_HIGH,
+							    &rk808_restart, rk808);
 			if (ret)
 				dev_warn(&client->dev, "failed to register rst handler, %d\n", ret);
 			break;
@@ -771,28 +772,6 @@ static int rk808_probe(struct i2c_client *client,
 		}
 	}
 
-	return 0;
-
-err_irq:
-	regmap_del_irq_chip(client->irq, rk808->irq_data);
-	return ret;
-}
-
-static int rk808_remove(struct i2c_client *client)
-{
-	struct rk808 *rk808 = i2c_get_clientdata(client);
-
-	regmap_del_irq_chip(client->irq, rk808->irq_data);
-
-	/**
-	 * pm_power_off may points to a function from another module.
-	 * Check if the pointer is set by us and only then overwrite it.
-	 */
-	if (pm_power_off == rk808_pm_power_off)
-		pm_power_off = NULL;
-
-	unregister_restart_handler(&rk808_restart_handler);
-
 	return 0;
 }
 
@@ -850,7 +829,6 @@ static struct i2c_driver rk808_i2c_driver = {
 		.pm = &rk8xx_pm_ops,
 	},
 	.probe    = rk808_probe,
-	.remove   = rk808_remove,
 	.shutdown = rk8xx_shutdown,
 };
 
-- 
2.35.1

