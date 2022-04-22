Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C3C50B1EC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444969AbiDVHom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444951AbiDVHog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:44:36 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF4E506F9;
        Fri, 22 Apr 2022 00:41:44 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n18so9094365plg.5;
        Fri, 22 Apr 2022 00:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VpD4yFy85f6C68H5ezV9yCUomr5GyphpulX5PMC3cD0=;
        b=ELLGtchfujVWTM/NeC4LuN2XrCbrar4xH8mtZYbh6iHEbiO3i2P331R0nXpFx0rJqB
         LB66/Gj0ZhUs28v3LCC0n0vYSIZle0YwU8AGqFzNnuQxLlzfcPz+rMtehtlkbsKdmB6I
         s/P/48BtiQPjdzeEwzCniSaMenYGtvn2HTTKpGFsZRfeCl11ToBri4BQ617YxUabs47E
         46AsFNn36u+f5JbQtt0qlRsKnaIvhPSVptWhe/PcakfnwmhEzyvTqgydXzGxMJda4Cif
         UPhWuka4hHZz6pFozXizY24bhwUM5m08N/xwYFR9jfL/ok8H3jq5qe+87/oldVFSRsaI
         K80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VpD4yFy85f6C68H5ezV9yCUomr5GyphpulX5PMC3cD0=;
        b=FjoH1zJhz1QPXe+JD7FcQQ5WphGtIf+3hcuE/n6IJpvW/BDB1GQ0ELkUJP5eNy5pM6
         weoaTLwh0Jaan3lO7CZk6rNdtk5jVw0T0ydjYvW9QzDOQYN8SwBGxwZLQFcqA1d4Ujh6
         bTWymKAu/QcFW5fZlRkSDUSZ7Xu8gNEdPT2jlh+1Qz7mhKDqiIRCXMp76UZkNn2tJk4u
         37ha4HqSu2dAbYd5yKHof7cZInep4MCLoSuIxRsfY3wNp+kQcC9iVDU2zHXxZGpkA+hc
         +exIUThQQchX53/Ns8ZXRgXxwOD0nQgUa0i+3mWZ2RSSwnNcBByATE0ZTBbGZhEmZVe4
         HuGg==
X-Gm-Message-State: AOAM532prfGbzWmELk5RfqhsuSX8g7UUiwp+WmD94zkLgtQxUIl/qCVP
        4L+geQpqI8Nmh+8La37rPLc=
X-Google-Smtp-Source: ABdhPJwLtZzmH8WWk1SI5WNrEToyEpODLTsWuTHrKvy7fPUi+8uUypArOjGDOM/W8CKTV+DnBN7F0g==
X-Received: by 2002:a17:90a:930b:b0:1d5:684b:8e13 with SMTP id p11-20020a17090a930b00b001d5684b8e13mr3903809pjo.153.1650613303606;
        Fri, 22 Apr 2022 00:41:43 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id x17-20020a17090a531100b001cd4989feccsm5045870pjh.24.2022.04.22.00.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 00:41:42 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     sre@kernel.org, orsonzhai@gmail.com, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, chenyongzhi811@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: Add enable the primary charger interface
Date:   Fri, 22 Apr 2022 15:41:09 +0800
Message-Id: <20220422074109.1709106-1-gengcixi@gmail.com>
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
---
 drivers/power/supply/sc2731_charger.c | 50 +++++++++++++++++++++++++--
 include/linux/power_supply.h          |  1 +
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supply/sc2731_charger.c
index 9ac17cf7a126..64c79d5ea90f 100644
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
+	int ret;
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
+	u32 cur, enabled = 0;
 
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

