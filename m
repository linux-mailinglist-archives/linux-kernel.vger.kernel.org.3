Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F404E8B6F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 03:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiC1BCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 21:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237195AbiC1BCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 21:02:31 -0400
X-Greylist: delayed 621 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Mar 2022 18:00:50 PDT
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [IPv6:2a01:4f8:a0:821d::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A81AD4ECDB;
        Sun, 27 Mar 2022 18:00:50 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net [81.96.50.79])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 0028F140191;
        Mon, 28 Mar 2022 00:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1648428628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bu81eOdyE1PgdWCUxw1KdAZTJHOAI2JnAqP9I0MQSuA=;
        b=j21xTSslEESvLFxMs+EYDFVsJUlLWimEebt7444X37O+50OyAf8T8kI8m1zHxbZ4ijTdKA
        XlyhWJKvTeccvsoV10KyCGAiAWty0go0ucRBU+iA9MbScdKAjE854yCEQiyeXwvzzOO1VC
        2EQzHPHIsVPoEIUnKypWb7uB3cT8z70=
From:   Caleb Connolly <kc@postmarketos.org>
To:     Caleb Connolly <kc@postmarketos.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martijn@brixit.nl,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH 1/4] pinctrl/rockchip: support deferring other gpio params
Date:   Mon, 28 Mar 2022 01:50:02 +0100
Message-Id: <20220328005005.72492-2-kc@postmarketos.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328005005.72492-1-kc@postmarketos.org>
References: <20220328005005.72492-1-kc@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for deferring other params like PIN_CONFIG_INPUT_ENABLE.
This will be used to add support for PIN_CONFIG_INPUT_ENABLE to the
driver.

Fixes: e7165b1d ("pinctrl/rockchip: add a queue for deferred pin output settings on probe")
Fixes: 59dd178e ("gpio/rockchip: fetch deferred output settings on probe")
Signed-off-by: Caleb Connolly <kc@postmarketos.org>
---
 drivers/gpio/gpio-rockchip.c       | 24 ++++++++-----
 drivers/pinctrl/pinctrl-rockchip.c | 54 ++++++++++++++++--------------
 drivers/pinctrl/pinctrl-rockchip.h |  7 ++--
 3 files changed, 50 insertions(+), 35 deletions(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index 099e358d2491..bcf5214e3586 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -19,6 +19,7 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/regmap.h>
 
 #include "../pinctrl/core.h"
@@ -706,7 +707,7 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
 	struct device_node *pctlnp = of_get_parent(np);
 	struct pinctrl_dev *pctldev = NULL;
 	struct rockchip_pin_bank *bank = NULL;
-	struct rockchip_pin_output_deferred *cfg;
+	struct rockchip_pin_deferred *cfg;
 	static int gpio;
 	int id, ret;
 
@@ -747,15 +748,22 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	while (!list_empty(&bank->deferred_output)) {
-		cfg = list_first_entry(&bank->deferred_output,
-				       struct rockchip_pin_output_deferred, head);
+	while (!list_empty(&bank->deferred_pins)) {
+		cfg = list_first_entry(&bank->deferred_pins,
+				       struct rockchip_pin_deferred, head);
 		list_del(&cfg->head);
 
-		ret = rockchip_gpio_direction_output(&bank->gpio_chip, cfg->pin, cfg->arg);
-		if (ret)
-			dev_warn(dev, "setting output pin %u to %u failed\n", cfg->pin, cfg->arg);
-
+		switch (cfg->param) {
+		case PIN_CONFIG_OUTPUT:
+			ret = rockchip_gpio_direction_output(&bank->gpio_chip, cfg->pin, cfg->arg);
+			if (ret)
+				dev_warn(dev, "setting output pin %u to %u failed\n", cfg->pin,
+					 cfg->arg);
+			break;
+		default:
+			dev_warn(dev, "unknown deferred config param %d\n", cfg->param);
+			break;
+		}
 		kfree(cfg);
 	}
 
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index d8dd8415fa81..d54fc1cdf609 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -2095,19 +2095,20 @@ static bool rockchip_pinconf_pull_valid(struct rockchip_pin_ctrl *ctrl,
 	return false;
 }
 
-static int rockchip_pinconf_defer_output(struct rockchip_pin_bank *bank,
-					 unsigned int pin, u32 arg)
+static int rockchip_pinconf_defer_pin(struct rockchip_pin_bank *bank,
+					 unsigned int pin, u32 param, u32 arg)
 {
-	struct rockchip_pin_output_deferred *cfg;
+	struct rockchip_pin_deferred *cfg;
 
 	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
 	if (!cfg)
 		return -ENOMEM;
 
 	cfg->pin = pin;
+	cfg->param = param;
 	cfg->arg = arg;
 
-	list_add_tail(&cfg->head, &bank->deferred_output);
+	list_add_tail(&cfg->head, &bank->deferred_pins);
 
 	return 0;
 }
@@ -2128,6 +2129,25 @@ static int rockchip_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		param = pinconf_to_config_param(configs[i]);
 		arg = pinconf_to_config_argument(configs[i]);
 
+		if (param == (PIN_CONFIG_OUTPUT | PIN_CONFIG_INPUT_ENABLE)) {
+			/*
+			 * Check for gpio driver not being probed yet.
+			 * The lock makes sure that either gpio-probe has completed
+			 * or the gpio driver hasn't probed yet.
+			 */
+			mutex_lock(&bank->deferred_lock);
+			if (!gpio || !gpio->direction_output) {
+				rc = rockchip_pinconf_defer_pin(bank, pin - bank->pin_base, param,
+								arg);
+				mutex_unlock(&bank->deferred_lock);
+				if (rc)
+					return rc;
+
+				break;
+			}
+			mutex_unlock(&bank->deferred_lock);
+		}
+
 		switch (param) {
 		case PIN_CONFIG_BIAS_DISABLE:
 			rc =  rockchip_set_pull(bank, pin - bank->pin_base,
@@ -2156,22 +2176,6 @@ static int rockchip_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			if (rc != RK_FUNC_GPIO)
 				return -EINVAL;
 
-			/*
-			 * Check for gpio driver not being probed yet.
-			 * The lock makes sure that either gpio-probe has completed
-			 * or the gpio driver hasn't probed yet.
-			 */
-			mutex_lock(&bank->deferred_lock);
-			if (!gpio || !gpio->direction_output) {
-				rc = rockchip_pinconf_defer_output(bank, pin - bank->pin_base, arg);
-				mutex_unlock(&bank->deferred_lock);
-				if (rc)
-					return rc;
-
-				break;
-			}
-			mutex_unlock(&bank->deferred_lock);
-
 			rc = gpio->direction_output(gpio, pin - bank->pin_base,
 						    arg);
 			if (rc)
@@ -2485,7 +2489,7 @@ static int rockchip_pinctrl_register(struct platform_device *pdev,
 			pdesc++;
 		}
 
-		INIT_LIST_HEAD(&pin_bank->deferred_output);
+		INIT_LIST_HEAD(&pin_bank->deferred_pins);
 		mutex_init(&pin_bank->deferred_lock);
 	}
 
@@ -2746,7 +2750,7 @@ static int rockchip_pinctrl_remove(struct platform_device *pdev)
 {
 	struct rockchip_pinctrl *info = platform_get_drvdata(pdev);
 	struct rockchip_pin_bank *bank;
-	struct rockchip_pin_output_deferred *cfg;
+	struct rockchip_pin_deferred *cfg;
 	int i;
 
 	of_platform_depopulate(&pdev->dev);
@@ -2755,9 +2759,9 @@ static int rockchip_pinctrl_remove(struct platform_device *pdev)
 		bank = &info->ctrl->pin_banks[i];
 
 		mutex_lock(&bank->deferred_lock);
-		while (!list_empty(&bank->deferred_output)) {
-			cfg = list_first_entry(&bank->deferred_output,
-					       struct rockchip_pin_output_deferred, head);
+		while (!list_empty(&bank->deferred_pins)) {
+			cfg = list_first_entry(&bank->deferred_pins,
+					       struct rockchip_pin_deferred, head);
 			list_del(&cfg->head);
 			kfree(cfg);
 		}
diff --git a/drivers/pinctrl/pinctrl-rockchip.h b/drivers/pinctrl/pinctrl-rockchip.h
index 91f10279d084..98a01a616da6 100644
--- a/drivers/pinctrl/pinctrl-rockchip.h
+++ b/drivers/pinctrl/pinctrl-rockchip.h
@@ -171,7 +171,7 @@ struct rockchip_pin_bank {
 	u32				toggle_edge_mode;
 	u32				recalced_mask;
 	u32				route_mask;
-	struct list_head		deferred_output;
+	struct list_head		deferred_pins;
 	struct mutex			deferred_lock;
 };
 
@@ -247,9 +247,12 @@ struct rockchip_pin_config {
 	unsigned int		nconfigs;
 };
 
-struct rockchip_pin_output_deferred {
+enum pin_config_param;
+
+struct rockchip_pin_deferred {
 	struct list_head head;
 	unsigned int pin;
+	enum pin_config_param param;
 	u32 arg;
 };
 
-- 
2.35.1

