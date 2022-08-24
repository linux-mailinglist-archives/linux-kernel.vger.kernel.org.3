Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706EA59F7A8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 12:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbiHXK1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 06:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236971AbiHXK0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:26:37 -0400
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr [80.12.242.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD8A82D17
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 03:25:19 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id QnZToXm7hBDYDQnZUoinzN; Wed, 24 Aug 2022 12:25:17 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 24 Aug 2022 12:25:17 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver@microchip.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] hwmon: (sparx5) Use devm_clk_get_enabled() helper
Date:   Wed, 24 Aug 2022 12:25:13 +0200
Message-Id: <cfe4c965074b5ecbe03830b05e038b4594c7b970.1661336689.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_clk_get_enabled() helper:
   - calls devm_clk_get()
   - calls clk_prepare_enable() and registers what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code, the error handling paths and avoid the need of
a dedicated function used with devm_add_action_or_reset().

Based on my test with allyesconfig, this reduces the .o size from:
   text	   data	    bss	    dec	    hex	filename
   2419	   1472	      0	   3891	    f33	drivers/hwmon/sparx5-temp.o
down to:
   2155	   1472	      0	   3627	    e2b	drivers/hwmon/sparx5-temp.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
devm_clk_get_enabled() is new and is part of 6.0-rc1
---
 drivers/hwmon/sparx5-temp.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/hwmon/sparx5-temp.c b/drivers/hwmon/sparx5-temp.c
index 98be48e3a22a..04fd8505e5d6 100644
--- a/drivers/hwmon/sparx5-temp.c
+++ b/drivers/hwmon/sparx5-temp.c
@@ -26,13 +26,6 @@ struct s5_hwmon {
 	struct clk *clk;
 };
 
-static void s5_temp_clk_disable(void *data)
-{
-	struct clk *clk = data;
-
-	clk_disable_unprepare(clk);
-}
-
 static void s5_temp_enable(struct s5_hwmon *hwmon)
 {
 	u32 val = readl(hwmon->base + TEMP_CFG);
@@ -113,7 +106,6 @@ static int s5_temp_probe(struct platform_device *pdev)
 {
 	struct device *hwmon_dev;
 	struct s5_hwmon *hwmon;
-	int ret;
 
 	hwmon = devm_kzalloc(&pdev->dev, sizeof(*hwmon), GFP_KERNEL);
 	if (!hwmon)
@@ -123,19 +115,10 @@ static int s5_temp_probe(struct platform_device *pdev)
 	if (IS_ERR(hwmon->base))
 		return PTR_ERR(hwmon->base);
 
-	hwmon->clk = devm_clk_get(&pdev->dev, NULL);
+	hwmon->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(hwmon->clk))
 		return PTR_ERR(hwmon->clk);
 
-	ret = clk_prepare_enable(hwmon->clk);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(&pdev->dev, s5_temp_clk_disable,
-				       hwmon->clk);
-	if (ret)
-		return ret;
-
 	s5_temp_enable(hwmon);
 
 	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
-- 
2.34.1

