Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EB75075A3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355409AbiDSQv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243093AbiDSQqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:46:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49ED3AA45;
        Tue, 19 Apr 2022 09:43:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39FE4B81BEF;
        Tue, 19 Apr 2022 16:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC2BC385A5;
        Tue, 19 Apr 2022 16:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650386637;
        bh=qlaYFyobKEQjnzQZM9MNp5qNQqkRYezyfa1kDOn31O4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IfCx1sYsItrvvOhd62OVGq73m59nNboCQp/gH4IxEBVU5zCvpQPCNPA7TuLYFXC6C
         LwaFif0SpZk4iKNSuUv5XERVH3Itoh7apK3zIBcowiSB/8aMiJR+86E55VqZMRViGM
         vxBgMMnsawZno/joMpTCd+ep1ROboUpME3CMorprNKBdA5wmg9bbhuyypuFsCjLW8G
         yE/u4h18EsDdKvT5ABnu1pHVnRKTIiK1fqnwH6cD1Nj0kuQJNcwzeZUE12odIw17Nr
         I4FoURlNeI1+CxCMlSZX0Yt4E6U9SjEz7W8MiBWwtf7IWB7ooRCN+I7IGpKqWmgJa2
         GROrW1/+TSmQA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     robert.jarzmik@free.fr, linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Tomas Cech <sleep_walker@suse.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Helge Deller <deller@gmx.de>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-input@vger.kernel.org,
        patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org, Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 39/48] power: tosa: simplify probe function
Date:   Tue, 19 Apr 2022 18:38:01 +0200
Message-Id: <20220419163810.2118169-40-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220419163810.2118169-1-arnd@kernel.org>
References: <20220419163810.2118169-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

We have three power supplies that need similar initialization.
As a preparation for the gpio lookup table conversion, split
out the initialization into a separate function.

Reviewed-by: Sebastian Reichel <sre@kernel.org>
Acked-by: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/supply/tosa_battery.c | 50 ++++++++++++++---------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/power/supply/tosa_battery.c b/drivers/power/supply/tosa_battery.c
index 32cc31cd4761..b26b0eca33e1 100644
--- a/drivers/power/supply/tosa_battery.c
+++ b/drivers/power/supply/tosa_battery.c
@@ -343,12 +343,24 @@ static int tosa_bat_resume(struct platform_device *dev)
 #define tosa_bat_resume NULL
 #endif
 
+static int tosa_power_supply_register(struct device *dev,
+			struct tosa_bat *bat,
+			const struct power_supply_desc *desc)
+{
+	struct power_supply_config cfg = {
+		.drv_data = bat,
+	};
+
+	mutex_init(&bat->work_lock);
+	bat->psy = power_supply_register(dev, desc, &cfg);
+
+	return PTR_ERR_OR_ZERO(bat->psy);
+}
+
+
 static int tosa_bat_probe(struct platform_device *dev)
 {
 	int ret;
-	struct power_supply_config main_psy_cfg = {},
-				   jacket_psy_cfg = {},
-				   bu_psy_cfg = {};
 
 	if (!machine_is_tosa())
 		return -ENODEV;
@@ -357,36 +369,22 @@ static int tosa_bat_probe(struct platform_device *dev)
 	if (ret)
 		return ret;
 
-	mutex_init(&tosa_bat_main.work_lock);
-	mutex_init(&tosa_bat_jacket.work_lock);
-
 	INIT_WORK(&bat_work, tosa_bat_work);
 
-	main_psy_cfg.drv_data = &tosa_bat_main;
-	tosa_bat_main.psy = power_supply_register(&dev->dev,
-						  &tosa_bat_main_desc,
-						  &main_psy_cfg);
-	if (IS_ERR(tosa_bat_main.psy)) {
-		ret = PTR_ERR(tosa_bat_main.psy);
+	ret = tosa_power_supply_register(&dev->dev, &tosa_bat_main,
+					 &tosa_bat_main_desc);
+	if (ret)
 		goto err_psy_reg_main;
-	}
 
-	jacket_psy_cfg.drv_data = &tosa_bat_jacket;
-	tosa_bat_jacket.psy = power_supply_register(&dev->dev,
-						    &tosa_bat_jacket_desc,
-						    &jacket_psy_cfg);
-	if (IS_ERR(tosa_bat_jacket.psy)) {
-		ret = PTR_ERR(tosa_bat_jacket.psy);
+	ret = tosa_power_supply_register(&dev->dev, &tosa_bat_jacket,
+					 &tosa_bat_jacket_desc);
+	if (ret)
 		goto err_psy_reg_jacket;
-	}
 
-	bu_psy_cfg.drv_data = &tosa_bat_bu;
-	tosa_bat_bu.psy = power_supply_register(&dev->dev, &tosa_bat_bu_desc,
-						&bu_psy_cfg);
-	if (IS_ERR(tosa_bat_bu.psy)) {
-		ret = PTR_ERR(tosa_bat_bu.psy);
+	ret = tosa_power_supply_register(&dev->dev, &tosa_bat_bu,
+					 &tosa_bat_bu_desc);
+	if (ret)
 		goto err_psy_reg_bu;
-	}
 
 	ret = request_irq(gpio_to_irq(TOSA_GPIO_BAT0_CRG),
 				tosa_bat_gpio_isr,
-- 
2.29.2

