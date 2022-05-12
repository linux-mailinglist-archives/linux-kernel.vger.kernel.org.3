Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F383524958
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352233AbiELJog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352206AbiELJob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:44:31 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03A9EAD2B;
        Thu, 12 May 2022 02:44:28 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 202so4103714pgc.9;
        Thu, 12 May 2022 02:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ihqvNRJwImzsOLrl3fxE6zMebem5b+EV0AECQRLqNQk=;
        b=COTfQBLUEjx07aJkBhxtHqjkf9N6ZR9iAwxuruHzNA3z1Qe1bTVmIVg+61R3eygp7A
         XKDsm3qSfKayt8PHc04UMg9gmYGMkhjI1069FUL27w9zO/615T/NWkFdQ0xfk+L1TXDS
         HRE07M6dV+ixjeOmhNna62fsLR25u5I/i2O1LFJGf3BOWLpDIMbSbwHJubQ6DL2ZiVmA
         3CKcmSsvlIW0LtHJHSyN2YIWS0eNLVFVR1BvU6GMXamUXUJBk5kbRF/nyzGfSetEO6+Y
         wivIcptXIECPEUFrC0LVhAY1Tccuu3n5Aiv27mp3tU1d0FiLlAmP5qdslrCVm82x2Lis
         Hz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ihqvNRJwImzsOLrl3fxE6zMebem5b+EV0AECQRLqNQk=;
        b=stxjL40WMUXnssqXUJwwJV74SCuU0zq/++ieAwScKVAxYcehLoV70l/8qakDeYWdOm
         PQa11csnGdyo4gt/ENi5r8Ea+hpP1M2SJ2lCypLiiSUf6qjiZjc3OlQksEsJjvxtBTAr
         Kdd03pto92rYqdWvtiDhkKjQrCkcpz2RRuCwE7WYC+UCNWe7lfhyzRDcUaV6LsCYbbWa
         MR77m3h5xvhk/Am7LEDDGjG1Zf0shSGM/QkqxraVl1BScgc8EFDJTvPfzJTRajuPt6MP
         ZeXzpNTbpL7oGoKuY/pEFsnxqXt/5koBqBkdR3qL0l0vm/iA1ntAy1QOZbKBN7LDgZcJ
         pL4w==
X-Gm-Message-State: AOAM531UL5z3AAmbp/XU+PhsuNfq/foqHuUzu2b2mdDBai2jKd7Ty3MD
        uweRiE/pNo9+ybx5zy3SkFU=
X-Google-Smtp-Source: ABdhPJz4HMYDsfitlJnQpZNXkkiQyofzdNHIYRvUPRioT1c/GBy8uzQ8DBgFmjrQxCaeIc4d6t4rrA==
X-Received: by 2002:a63:8749:0:b0:3c6:aa1d:bd3c with SMTP id i70-20020a638749000000b003c6aa1dbd3cmr17318160pge.403.1652348668074;
        Thu, 12 May 2022 02:44:28 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902e94500b0015e8d4eb222sm3412681pll.108.2022.05.12.02.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 02:44:27 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     sre@kernel.org, orsonzhai@gmail.com, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, chenyongzhi811@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3] power: supply: Add enable the primary charger interface
Date:   Thu, 12 May 2022 17:44:17 +0800
Message-Id: <20220512094417.3716654-1-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/power/supply/sc2731_charger.c | 48 +++++++++++++++++++++++++--
 include/linux/power_supply.h          |  1 +
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supply/sc2731_charger.c
index 9ac17cf7a126..170b7a30e9b9 100644
--- a/drivers/power/supply/sc2731_charger.c
+++ b/drivers/power/supply/sc2731_charger.c
@@ -146,6 +146,22 @@ static int sc2731_charger_get_status(struct sc2731_charger_info *info)
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
+		if (!ret)
+			info->charging = true;
+	}
+
+	return ret;
+}
+
 static int sc2731_charger_get_current(struct sc2731_charger_info *info,
 				      u32 *cur)
 {
@@ -204,7 +220,7 @@ sc2731_charger_usb_set_property(struct power_supply *psy,
 				const union power_supply_propval *val)
 {
 	struct sc2731_charger_info *info = power_supply_get_drvdata(psy);
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&info->lock);
 
@@ -214,6 +230,12 @@ sc2731_charger_usb_set_property(struct power_supply *psy,
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
@@ -227,6 +249,15 @@ sc2731_charger_usb_set_property(struct power_supply *psy,
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
@@ -241,7 +272,7 @@ static int sc2731_charger_usb_get_property(struct power_supply *psy,
 {
 	struct sc2731_charger_info *info = power_supply_get_drvdata(psy);
 	int ret = 0;
-	u32 cur;
+	u32 cur, enabled;
 
 	mutex_lock(&info->lock);
 
@@ -277,6 +308,16 @@ static int sc2731_charger_usb_get_property(struct power_supply *psy,
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
@@ -292,8 +333,10 @@ static int sc2731_charger_property_is_writeable(struct power_supply *psy,
 	int ret;
 
 	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+	case POWER_SUPPLY_PROP_CHARGE_ENABLED:
 		ret = 1;
 		break;
 
@@ -308,6 +351,7 @@ static enum power_supply_property sc2731_usb_props[] = {
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

