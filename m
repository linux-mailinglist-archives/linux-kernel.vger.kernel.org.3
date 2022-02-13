Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65124B3B11
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 12:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbiBMLTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 06:19:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbiBMLTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 06:19:41 -0500
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637A25B3FB
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 03:19:35 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id JCuinPVRwHZHJJCuinOl1G; Sun, 13 Feb 2022 12:19:33 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 13 Feb 2022 12:19:33 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: max8997_charger: Use devm_work_autocancel()
Date:   Sun, 13 Feb 2022 12:19:31 +0100
Message-Id: <1404087e1f99dfb5e5d59ee29f477a2f2d960bb8.1644751133.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_work_autocancel() instead of hand writing it.
It saves a few lines of code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/power/supply/max8997_charger.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/max8997_charger.c
index 25207fe2aa68..127c73b0b3bd 100644
--- a/drivers/power/supply/max8997_charger.c
+++ b/drivers/power/supply/max8997_charger.c
@@ -14,6 +14,7 @@
 #include <linux/mfd/max8997.h>
 #include <linux/mfd/max8997-private.h>
 #include <linux/regulator/consumer.h>
+#include <linux/devm-helpers.h>
 
 /* MAX8997_REG_STATUS4 */
 #define DCINOK_SHIFT		1
@@ -94,13 +95,6 @@ static int max8997_battery_get_property(struct power_supply *psy,
 	return 0;
 }
 
-static void max8997_battery_extcon_evt_stop_work(void *data)
-{
-	struct charger_data *charger = data;
-
-	cancel_work_sync(&charger->extcon_work);
-}
-
 static void max8997_battery_extcon_evt_worker(struct work_struct *work)
 {
 	struct charger_data *charger =
@@ -255,8 +249,8 @@ static int max8997_battery_probe(struct platform_device *pdev)
 	}
 
 	if (!IS_ERR(charger->reg) && !IS_ERR_OR_NULL(charger->edev)) {
-		INIT_WORK(&charger->extcon_work, max8997_battery_extcon_evt_worker);
-		ret = devm_add_action(&pdev->dev, max8997_battery_extcon_evt_stop_work, charger);
+		ret = devm_work_autocancel(&pdev->dev, &charger->extcon_work,
+					   max8997_battery_extcon_evt_worker);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to add extcon evt stop action: %d\n", ret);
 			return ret;
-- 
2.32.0

