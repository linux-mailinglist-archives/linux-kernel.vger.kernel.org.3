Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12F7573166
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbiGMIn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbiGMInR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:43:17 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541B9EA149;
        Wed, 13 Jul 2022 01:43:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id z23so2057463eju.8;
        Wed, 13 Jul 2022 01:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uWtRAmBLtsazF/pLmP45VTNHSNoFHCEzm5WXW96RpTE=;
        b=HEMisfIyFpFrNW0h2/pTPWb3kvILB6Bc3/thWhhd0azh2fSvcAOKTDokiOQqFN/Etf
         ch4Y811oJQAe+nMGWba6pnaxIRhG3K3as2beeHmc2T+tfa9HfKL3+kDjbggmEL/s+4Kg
         R6HlWRDt+QHAaJX8TNCM5noXtMUa2tFPuddLnSYseMp7YFNECWFIFot+Q15rPawZYPbI
         6lE6b+wHo9l+2QgibuFF/vCouYELhgTRXof41l4qLp/KYlAJt3x5BwNhCyE06dbh1QiS
         e0cDvOFko0te1Avdoy0YeqlB6Tz0FV0mCLVOorF4pLltu4Z37ObiIuv2FTqKebLqorad
         KQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uWtRAmBLtsazF/pLmP45VTNHSNoFHCEzm5WXW96RpTE=;
        b=iBeMLnSTll4WWe/WdMOQYpyhpg0e/FluMXKmqHGAnkI+FtyBOEY7T2GmFEBliPOAXx
         zMaOZnApIMtehvVrIWcV4tOT53uSTQY1WdhTK5Y+ou6J1y2AFp7Rb4n4fwizPEMJwUH4
         8I+js096+amxrnF43NuaAtq3FkVbhcM1HkUnEd2I9cB5AnwBSyIrLLarrW/C5T8qYEI4
         ibR8UF6llaT8RE1As2H9SvtsHNNyhg8czY/ezxZsPINkSABzw9ogX7ZNeJf7VPypUGWw
         AoLSPc8c9lFrzyeFpYQAY1Ptn80m85jPSZ/G70Q4SbrmKD9oqqXZFGO/2wk96VrknI+k
         pPWQ==
X-Gm-Message-State: AJIora8ftT9JvYaA+f2Q7sTxDH8RuH1K1da0drR90nV8fky5eYMJg13F
        S1lVw8vOvCywf/vdStlhcDCm5kbpuVnfCATO
X-Google-Smtp-Source: AGRyM1sp584MxHxw3c4ex/TlTzPwXtlgRFXh7RcT9gyKFbMJJoU7iLWVxz5I3RveFKfRzZOL+RMwSw==
X-Received: by 2002:a17:907:3da0:b0:72b:47df:c1d7 with SMTP id he32-20020a1709073da000b0072b47dfc1d7mr2260949ejc.214.1657701788866;
        Wed, 13 Jul 2022 01:43:08 -0700 (PDT)
Received: from PCBABN.skidata.net ([2001:67c:2330:2014:7a45:c4ff:fe0f:c570])
        by smtp.gmail.com with ESMTPSA id pv5-20020a170907208500b0072af4af2f46sm4690173ejb.74.2022.07.13.01.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 01:43:08 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH] Input: tsc2007 - enable GPIO chips that can sleep
Date:   Wed, 13 Jul 2022 10:42:47 +0200
Message-Id: <20220713084247.3090353-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

This enables the usage of "can_sleep" GPIO chips as "pin up" GPIO.
This might be the case if the GPIO chip is an expander behind i2c.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 drivers/input/touchscreen/tsc2007.h      |  1 +
 drivers/input/touchscreen/tsc2007_core.c | 38 ++++++++++++++++++++----
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007.h b/drivers/input/touchscreen/tsc2007.h
index 69b08dd6c8df..29bd1ff22c72 100644
--- a/drivers/input/touchscreen/tsc2007.h
+++ b/drivers/input/touchscreen/tsc2007.h
@@ -78,6 +78,7 @@ struct tsc2007 {
 	bool			stopped;
 
 	int			(*get_pendown_state)(struct device *);
+	int			(*get_pendown_state_cansleep)(struct device *);
 	void			(*clear_penirq)(void);
 
 	struct mutex		mlock;
diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
index 3e871d182c40..0ad4c3c41297 100644
--- a/drivers/input/touchscreen/tsc2007_core.c
+++ b/drivers/input/touchscreen/tsc2007_core.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
@@ -108,6 +109,14 @@ bool tsc2007_is_pen_down(struct tsc2007 *ts)
 	return ts->get_pendown_state(&ts->client->dev);
 }
 
+bool tsc2007_is_pen_down_cansleep(struct tsc2007 *ts)
+{
+	if (!ts->get_pendown_state_cansleep)
+		return true;
+
+	return ts->get_pendown_state_cansleep(&ts->client->dev);
+}
+
 static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
 {
 	struct tsc2007 *ts = handle;
@@ -115,7 +124,7 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
 	struct ts_event tc;
 	u32 rt;
 
-	while (!ts->stopped && tsc2007_is_pen_down(ts)) {
+	while (!ts->stopped && tsc2007_is_pen_down_cansleep(ts)) {
 
 		/* pen is down, continue with the measurement */
 
@@ -125,7 +134,7 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
 
 		rt = tsc2007_calculate_resistance(ts, &tc);
 
-		if (!rt && !ts->get_pendown_state) {
+		if (!rt && !ts->get_pendown_state_cansleep) {
 			/*
 			 * If pressure reported is 0 and we don't have
 			 * callback to check pendown state, we have to
@@ -229,6 +238,14 @@ static int tsc2007_get_pendown_state_gpio(struct device *dev)
 	return gpiod_get_value(ts->gpiod);
 }
 
+static int tsc2007_get_pendown_state_gpio_cansleep(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct tsc2007 *ts = i2c_get_clientdata(client);
+
+	return gpiod_get_value_cansleep(ts->gpiod);
+}
+
 static int tsc2007_probe_properties(struct device *dev, struct tsc2007 *ts)
 {
 	u32 val32;
@@ -264,10 +281,21 @@ static int tsc2007_probe_properties(struct device *dev, struct tsc2007 *ts)
 	if (IS_ERR(ts->gpiod))
 		return PTR_ERR(ts->gpiod);
 
-	if (ts->gpiod)
-		ts->get_pendown_state = tsc2007_get_pendown_state_gpio;
-	else
+	if (ts->gpiod) {
+		/* to support detection during the hard IRQ, the GPIO chip is required to not sleep.
+		 * this might be the case if the GPIO is e.g. behind an i2c-based GPIO expander.
+		 * it is fine to sleep later in the soft IRQ, as it is threaded.
+		 */
+		ts->get_pendown_state_cansleep = tsc2007_get_pendown_state_gpio_cansleep;
+		if (gpiod_to_chip(ts->gpiod) && !gpiod_to_chip(ts->gpiod)->can_sleep) {
+			ts->get_pendown_state = tsc2007_get_pendown_state_gpio;
+		} else {
+			dev_dbg(dev, "Pen down GPIO chip can sleep\n");
+		}
+
+	} else {
 		dev_warn(dev, "Pen down GPIO is not specified in properties\n");
+	}
 
 	return 0;
 }
-- 
2.34.1

