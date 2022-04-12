Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1EC4FD384
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 11:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382607AbiDLJfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389223AbiDLJXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:23:30 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268085371F;
        Tue, 12 Apr 2022 01:30:48 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g12-20020a17090a640c00b001cb59d7a57cso1416751pjj.1;
        Tue, 12 Apr 2022 01:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zIBPosMAgbB2iLSLb65e2fki5qW2rWW5YIt3KN8UYiE=;
        b=lU+RSHml5ogJw30N7Dr3+lxm5yOvxAh9UXTV5mSghYPFv7VPsv+/4Nd3jm4VT517QX
         dtyNRHGpw5WgNS01DCKj32ht9PWxAvpMVJdhmS4YXMAn0oIKgfRonCADZjNY5GGMLeMp
         TG6IyOVMdtHFN3QPzCk1RIJ68LUUb1BsJ4Rt/83zQAOQ6wsIZiNghJ7ZXc3KNVUZAi1B
         Bo2d87wQ3zV+3UCN6TSchOIAnO5T9PXoqU22D7fRKSeRikCyO/4SKezFCYoGb8PSpnpR
         o5K9vX2Loe48ni0rn4kQb9XC2RqHzhJ8oqvvBj2xFqoB1qrYw498y4JHiBn/ShIGztso
         YPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zIBPosMAgbB2iLSLb65e2fki5qW2rWW5YIt3KN8UYiE=;
        b=OYJB8B6Ji3JcXcPeNYVqB1m5+vqFKUhweK5Rz0uW2tmDfU5pL0WkQwwFZd06kd+8ol
         hhcaBJrluWNh/Qi9YsQdbg3BswrtxiaWOo2OKhRktipmOT2bT7NXuZ7LlAAtI5Wqrtd8
         ny5ljs1tyudbExdgIUFYrk0wPPfa+jhIG3gLPTXt5hY0HlOd87I6g34H2yW3yLIAyzPy
         UyL0urPnuGMYDHRe8I9PXDbWGV5vi2lpqz20dt8Tn0ZrJu/uw/PvbKuFu14Ym/CLM2Wi
         8dy1Zb2OOGqZ19oirVVPVZ+05w/NIIWXgRQPbD0rXje+xHld+/A/0MMjJYHoC4BDPURB
         CbZA==
X-Gm-Message-State: AOAM530xV4cQiTCcqFChYeWZ6EaVd+h/GVrKNVEnp12f2rb5rhcjte7x
        cUIb13D3u+9GPgi6sNIeo60=
X-Google-Smtp-Source: ABdhPJz74d87MjEnNJWjBPaDHdoKaveWj771z1rKM/fMObTm8wuoIP/lfmwYyX8X4XkN3pJNxUar9w==
X-Received: by 2002:a17:90a:cc0b:b0:1cb:8351:a47e with SMTP id b11-20020a17090acc0b00b001cb8351a47emr3760156pju.67.1649752247638;
        Tue, 12 Apr 2022 01:30:47 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id oo17-20020a17090b1c9100b001bf0ccc59c2sm2050299pjb.16.2022.04.12.01.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 01:30:47 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] power: supply: bq24190_charger: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Tue, 12 Apr 2022 08:30:44 +0000
Message-Id: <20220412083044.2532773-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Using pm_runtime_resume_and_get is more appropriate
for simplifing code

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/power/supply/bq24190_charger.c | 63 +++++++++-----------------
 1 file changed, 21 insertions(+), 42 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index aa1a589eb9f2..27f5c7648617 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -455,11 +455,9 @@ static ssize_t bq24190_sysfs_show(struct device *dev,
 	if (!info)
 		return -EINVAL;
 
-	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(bdi->dev);
+	ret = pm_runtime_resume_and_get(bdi->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = bq24190_read_mask(bdi, info->reg, info->mask, info->shift, &v);
 	if (ret)
@@ -490,11 +488,9 @@ static ssize_t bq24190_sysfs_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(bdi->dev);
+	ret = pm_runtime_resume_and_get(bdi->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = bq24190_write_mask(bdi, info->reg, info->mask, info->shift, v);
 	if (ret)
@@ -512,10 +508,9 @@ static int bq24190_set_otg_vbus(struct bq24190_dev_info *bdi, bool enable)
 	union power_supply_propval val = { .intval = bdi->charge_type };
 	int ret;
 
-	ret = pm_runtime_get_sync(bdi->dev);
+	ret = pm_runtime_resume_and_get(bdi->dev);
 	if (ret < 0) {
 		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", ret);
-		pm_runtime_put_noidle(bdi->dev);
 		return ret;
 	}
 
@@ -551,10 +546,9 @@ static int bq24190_vbus_is_enabled(struct regulator_dev *dev)
 	int ret;
 	u8 val;
 
-	ret = pm_runtime_get_sync(bdi->dev);
+	ret = pm_runtime_resume_and_get(bdi->dev);
 	if (ret < 0) {
 		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", ret);
-		pm_runtime_put_noidle(bdi->dev);
 		return ret;
 	}
 
@@ -1128,11 +1122,9 @@ static int bq24190_charger_get_property(struct power_supply *psy,
 
 	dev_dbg(bdi->dev, "prop: %d\n", psp);
 
-	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(bdi->dev);
+	ret = pm_runtime_resume_and_get(bdi->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CHARGE_TYPE:
@@ -1204,11 +1196,9 @@ static int bq24190_charger_set_property(struct power_supply *psy,
 
 	dev_dbg(bdi->dev, "prop: %d\n", psp);
 
-	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(bdi->dev);
+	ret = pm_runtime_resume_and_get(bdi->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
@@ -1477,11 +1467,9 @@ static int bq24190_battery_get_property(struct power_supply *psy,
 	dev_warn(bdi->dev, "warning: /sys/class/power_supply/bq24190-battery is deprecated\n");
 	dev_dbg(bdi->dev, "prop: %d\n", psp);
 
-	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(bdi->dev);
+	ret = pm_runtime_resume_and_get(bdi->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
@@ -1525,11 +1513,9 @@ static int bq24190_battery_set_property(struct power_supply *psy,
 	dev_warn(bdi->dev, "warning: /sys/class/power_supply/bq24190-battery is deprecated\n");
 	dev_dbg(bdi->dev, "prop: %d\n", psp);
 
-	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(bdi->dev);
+	ret = pm_runtime_resume_and_get(bdi->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
@@ -1683,10 +1669,9 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
 	int error;
 
 	bdi->irq_event = true;
-	error = pm_runtime_get_sync(bdi->dev);
+	error = pm_runtime_resume_and_get(bdi->dev);
 	if (error < 0) {
 		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
-		pm_runtime_put_noidle(bdi->dev);
 		return IRQ_NONE;
 	}
 	bq24190_check_status(bdi);
@@ -1921,11 +1906,9 @@ static int bq24190_remove(struct i2c_client *client)
 	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
 	int error;
 
-	error = pm_runtime_get_sync(bdi->dev);
-	if (error < 0) {
+	error = pm_runtime_resume_and_get(bdi->dev);
+	if (error < 0)
 		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
-		pm_runtime_put_noidle(bdi->dev);
-	}
 
 	bq24190_register_reset(bdi);
 	if (bdi->battery)
@@ -1982,11 +1965,9 @@ static __maybe_unused int bq24190_pm_suspend(struct device *dev)
 	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
 	int error;
 
-	error = pm_runtime_get_sync(bdi->dev);
-	if (error < 0) {
+	error = pm_runtime_resume_and_get(bdi->dev);
+	if (error < 0)
 		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
-		pm_runtime_put_noidle(bdi->dev);
-	}
 
 	bq24190_register_reset(bdi);
 
@@ -2007,11 +1988,9 @@ static __maybe_unused int bq24190_pm_resume(struct device *dev)
 	bdi->f_reg = 0;
 	bdi->ss_reg = BQ24190_REG_SS_VBUS_STAT_MASK; /* impossible state */
 
-	error = pm_runtime_get_sync(bdi->dev);
-	if (error < 0) {
+	error = pm_runtime_resume_and_get(bdi->dev);
+	if (error < 0)
 		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
-		pm_runtime_put_noidle(bdi->dev);
-	}
 
 	bq24190_register_reset(bdi);
 	bq24190_set_config(bdi);
-- 
2.25.1

