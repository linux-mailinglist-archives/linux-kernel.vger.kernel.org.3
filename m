Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A86513445
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346738AbiD1M7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344020AbiD1M7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:59:38 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DED567D26;
        Thu, 28 Apr 2022 05:56:24 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m14-20020a17090a34ce00b001d5fe250e23so4307361pjf.3;
        Thu, 28 Apr 2022 05:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZwkjYsw9COPRHxP3kXlkswhs1cfcMm5Nckuu6rNtXY=;
        b=GasIFlTepYdUSfijEjEHH7eWRjZviLn+iGuGNwx18RArNN0LUR8SjDj52pHlZSQn3f
         GbhfgSCmvG2AbvVcOICcmvSdyNgU7H+FTqWnj71pNwYyHfthwKdV4hcTUHLdXCBVziD4
         AvokHz53kBwD+4HHZLHaTR9cKgiOMri4PqGlWIQJamN9BX2Asn43Q1WHtngwbvv2CeNb
         NMRsnNLn8eqcmRbm7QqDKQ+eCRz8dlMuUXZNZUwT1s5JpEOYFiYpqSfAfswPZSoCD4sa
         lKSD+hs8gzJ6fF+AFzFwelm4Y+x12BWOqec++h9GyLRSVNJmIfPqWFfX2Fb8uCtPjgD+
         B93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZwkjYsw9COPRHxP3kXlkswhs1cfcMm5Nckuu6rNtXY=;
        b=hcVAdWzprIiZBlDHt7F5T4AyFvvxOTnRmI4Wy7mdgZRK0dzD43Ln7v0IsbwLKy6rDc
         eqWi3fylWC2CruwzA3D5HDVyBUrFqsh3ujZXl0I0V8eAsyOSrh1vEVfNuwW04UJ9q73g
         GXcuTuc7UD0lCF/m21+/WPWg1QY/LKx/XmjrA7nRGCi5TDAbu0YXErBV1vl7mWWADFwe
         ulwdPdinP9E0aqUlejQQQlrIKCsWEp03ty8L6/LMQfkjjHg49/MScrqpbyNsjEb07/VN
         a7QJkMmyiTiJmRkgRyRHJjsfShvKhZjaS816Q21Yoou5KTwCmoksT0QdbVEXzH6qfg9G
         SkqQ==
X-Gm-Message-State: AOAM5315MSPPjZUieBCoHYAb3ZbOaD8nUzfQWRY049lHfd3xA12vSCS4
        bC4G9MYzSd1MAaMECmtY44XmnLFtBzt9QQ==
X-Google-Smtp-Source: ABdhPJyq3dZATm+OWfo0WJ/+F20liiW9Jy4UQKOGpdhYw6RaRE5xu2c6SI2RkvWpuzXtfEjeJPkGmQ==
X-Received: by 2002:a17:90a:1116:b0:1d9:a41a:d13d with SMTP id d22-20020a17090a111600b001d9a41ad13dmr17616356pja.206.1651150583928;
        Thu, 28 Apr 2022 05:56:23 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id x6-20020a17090a46c600b001d960eaed66sm6514061pjg.42.2022.04.28.05.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 05:56:23 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     sre@kernel.org, orsonzhai@gmail.com, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, chenyongzhi811@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] power: supply: Add enable the primary charger interface
Date:   Thu, 28 Apr 2022 20:56:10 +0800
Message-Id: <20220428125610.66647-1-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Yongzhi <Yongzhi.Chen@unisoc.com>

In the case of charging multiple charging ICs,the primary
charging IC often needs to be turned off in the fast
charging stage, and only using the charger pump to charge,
need to add a new power_supply_property attribute.

Signed-off-by: Chen Yongzhi <Yongzhi.Chen@unisoc.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/all/202204230206.9TgyhSb1-lkp@intel.com
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/power/supply/sc2731_charger.c | 52 +++++++++++++++++++++++++--
 include/linux/power_supply.h          |  1 +
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supply/sc2731_charger.c
index 9ac17cf7a126..c15f9b75e6a8 100644
--- a/drivers/power/supply/sc2731_charger.c
+++ b/drivers/power/supply/sc2731_charger.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2018 Spreadtrum Communications Inc.
+// Copyright (C) 2022 Spreadtrum Communications Inc.
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -146,6 +146,24 @@ static int sc2731_charger_get_status(struct sc2731_charger_info *info)
 	return POWER_SUPPLY_STATUS_CHARGING;
 }
 
+static int sc2731_charger_set_status(struct sc2731_charger_info *info, int val)
+{
+	int ret = 0;
+
+	if (!val && info->charging) {
+		sc2731_charger_stop_charge(info);
+		info->charging = false;
+	} else if (val && !info->charging) {
+		ret = sc2731_charger_start_charge(info);
+		if (ret)
+			dev_err(info->dev, "start charge failed\n");
+		else
+			info->charging = true;
+	}
+
+	return ret;
+}
+
 static int sc2731_charger_get_current(struct sc2731_charger_info *info,
 				      u32 *cur)
 {
@@ -204,7 +222,7 @@ sc2731_charger_usb_set_property(struct power_supply *psy,
 				const union power_supply_propval *val)
 {
 	struct sc2731_charger_info *info = power_supply_get_drvdata(psy);
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&info->lock);
 
@@ -214,6 +232,12 @@ sc2731_charger_usb_set_property(struct power_supply *psy,
 	}
 
 	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		ret = sc2731_charger_set_status(info, val->intval);
+		if (ret < 0)
+			dev_err(info->dev, "set charge status failed\n");
+		break;
+
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 		ret = sc2731_charger_set_current(info, val->intval / 1000);
 		if (ret < 0)
@@ -227,6 +251,15 @@ sc2731_charger_usb_set_property(struct power_supply *psy,
 			dev_err(info->dev, "set input current limit failed\n");
 		break;
 
+	case POWER_SUPPLY_PROP_CHARGE_ENABLED:
+		if (val->intval == true) {
+			ret = sc2731_charger_start_charge(info);
+			if (ret)
+				dev_err(info->dev, "start charge failed\n");
+		} else if (val->intval == false) {
+			sc2731_charger_stop_charge(info);
+		}
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -241,7 +274,7 @@ static int sc2731_charger_usb_get_property(struct power_supply *psy,
 {
 	struct sc2731_charger_info *info = power_supply_get_drvdata(psy);
 	int ret = 0;
-	u32 cur;
+	u32 cur, enabled;
 
 	mutex_lock(&info->lock);
 
@@ -277,6 +310,16 @@ static int sc2731_charger_usb_get_property(struct power_supply *psy,
 		}
 		break;
 
+	case POWER_SUPPLY_PROP_CHARGE_ENABLED:
+		ret = regmap_read(info->regmap, info->base + SC2731_CHG_CFG0, &enabled);
+		if (ret) {
+			dev_err(info->dev, "get sc2731 charge enabled failed\n");
+			goto out;
+		}
+
+		val->intval = enabled & SC2731_CHARGER_PD;
+
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -292,8 +335,10 @@ static int sc2731_charger_property_is_writeable(struct power_supply *psy,
 	int ret;
 
 	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+	case POWER_SUPPLY_PROP_CHARGE_ENABLED:
 		ret = 1;
 		break;
 
@@ -308,6 +353,7 @@ static enum power_supply_property sc2731_usb_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_CHARGE_ENABLED,
 };
 
 static const struct power_supply_desc sc2731_charger_desc = {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index cb380c1d9459..1dfe194d8a5e 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -167,6 +167,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
 	POWER_SUPPLY_PROP_CALIBRATE,
+	POWER_SUPPLY_PROP_CHARGE_ENABLED,
 	POWER_SUPPLY_PROP_MANUFACTURE_YEAR,
 	POWER_SUPPLY_PROP_MANUFACTURE_MONTH,
 	POWER_SUPPLY_PROP_MANUFACTURE_DAY,
-- 
2.25.1

