Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9B24AAA37
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 17:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380387AbiBEQlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 11:41:12 -0500
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:60282 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244712AbiBEQlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 11:41:10 -0500
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id GO7YngGexxHdTGO7YnEdz2; Sat, 05 Feb 2022 17:41:09 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 05 Feb 2022 17:41:09 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: Simplify memory allocation
Date:   Sat,  5 Feb 2022 17:40:57 +0100
Message-Id: <c09fc0b84cb046ad31bc1da67607bf0e9fa07085.1644079229.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_bitmap_zalloc() instead of hand writing it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/power/supply/power_supply_hwmon.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index bffe6d84c429..a48aa4afb828 100644
--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -324,11 +324,6 @@ static const struct hwmon_chip_info power_supply_hwmon_chip_info = {
 	.info = power_supply_hwmon_info,
 };
 
-static void power_supply_hwmon_bitmap_free(void *data)
-{
-	bitmap_free(data);
-}
-
 int power_supply_add_hwmon_sysfs(struct power_supply *psy)
 {
 	const struct power_supply_desc *desc = psy->desc;
@@ -349,18 +344,14 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
 	}
 
 	psyhw->psy = psy;
-	psyhw->props = bitmap_zalloc(POWER_SUPPLY_PROP_TIME_TO_FULL_AVG + 1,
-				     GFP_KERNEL);
+	psyhw->props = devm_bitmap_zalloc(dev,
+					  POWER_SUPPLY_PROP_TIME_TO_FULL_AVG + 1,
+					  GFP_KERNEL);
 	if (!psyhw->props) {
 		ret = -ENOMEM;
 		goto error;
 	}
 
-	ret = devm_add_action_or_reset(dev, power_supply_hwmon_bitmap_free,
-			      psyhw->props);
-	if (ret)
-		goto error;
-
 	for (i = 0; i < desc->num_properties; i++) {
 		const enum power_supply_property prop = desc->properties[i];
 
-- 
2.32.0

