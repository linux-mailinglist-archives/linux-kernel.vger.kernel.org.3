Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D781575C9F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiGOHp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiGOHp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:45:58 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C44B76E87;
        Fri, 15 Jul 2022 00:45:57 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g1so5221163edb.12;
        Fri, 15 Jul 2022 00:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lP3C2v/RKfZwIF2IGVeD+zS/CPCwKu55aN0wsgcjJrA=;
        b=K/F8+Z19myL5vSHXQ/qLel3FfPmG3nWN1zg9x5CJkDtMMLthOaGu6/V0UY92uxqS5Z
         jj8wpXDB0GEnb4MC6AJgwIsN4Nx9fIIjQJ6a5hwX6CE23MvE/qZKwiR1q4Macux8W5jp
         85BzspatryAqcu2XV2NAzUN4kzuqTB33XCek1U8LKpvwpxc11SyuY/jcE9kZLl10R27r
         +KRdGhMfZuuCLEX9glC+ACmjnOf40uP5xWTUnXLpTMSIS4koF9a5JqeoxcNSkHNFpX7b
         jb77c1B/biRDAoDrg7J80qsNksBAYKI2pUzfG6Qc9ZOEzqf4HkL4owqBV/D0fS3WUDQM
         P78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lP3C2v/RKfZwIF2IGVeD+zS/CPCwKu55aN0wsgcjJrA=;
        b=eeB3Xuqcj0XBIS5TIv0GKZimaZcdvfmEYl9++ItHZqVyrzktZq2OcV9BQ+bib/5OR9
         8Xjg1O0IOVFwvL/xmoRDg4r6B6omtfSGx3IM/xKDDWFEuzUr7jDNKx1PCit7rxCg8G9y
         c63XQuN5dCsas+pQ/hv+QiEoSPjgH3OkdcNYqV7ZYZlerTlMsFaHaM9Y5SPH3iahfNBf
         AzrT7nnINOLXkKr2olRzBSm/f9Q8+n+ArBv8GTHVsHlTpj8Lu8NKBByJeFnOOLwfXy8x
         XfHe1Hi0+q9eCf8gHtrUk6ty0d2hhTxGo3YLT1DVDY/Vhk3CIPRxSgbPN6WpN0sWVYsu
         4qhA==
X-Gm-Message-State: AJIora9mtEoDcMEaKx8k854JQldoTOcARKTyMd+RBay4Sq1YiAiQXtcW
        /9DyX6RwR5WF24JvuzkeShE5ljDfoHbmsQ==
X-Google-Smtp-Source: AGRyM1v5w/OsKbV+aZBk3tlDAoQKmpxBJ4KHlgssH8kmqQeUKy5Q2joEDnptZfpJE+xE3uNVFLi0kw==
X-Received: by 2002:aa7:cd86:0:b0:43a:26e3:d333 with SMTP id x6-20020aa7cd86000000b0043a26e3d333mr17557554edv.178.1657871155472;
        Fri, 15 Jul 2022 00:45:55 -0700 (PDT)
Received: from PCBABN.skidata.net ([2001:67c:2330:2014:7a45:c4ff:fe0f:c570])
        by smtp.gmail.com with ESMTPSA id n23-20020aa7c697000000b0043a71c376a2sm2351631edq.33.2022.07.15.00.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 00:45:54 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     christophe.jaillet@wanadoo.fr, richard.leitner@linux.dev,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        benjamin.bara@skidata.com
Subject: [PATCH v2] Input: tsc2007 - enable GPIO chips that can sleep
Date:   Fri, 15 Jul 2022 09:45:34 +0200
Message-Id: <20220715074534.3116678-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJpcXm6WkLt0pv7UYJ7K413j37ja9M++YUs9VzzaWqOWs1iGfg@mail.gmail.com>
References: <CAJpcXm6WkLt0pv7UYJ7K413j37ja9M++YUs9VzzaWqOWs1iGfg@mail.gmail.com>
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
 drivers/input/touchscreen/tsc2007_core.c | 34 ++++++++++++++++++++----
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007.h b/drivers/input/touchscreen/tsc2007.h
index 69b08dd6c8df..cdd90d727160 100644
--- a/drivers/input/touchscreen/tsc2007.h
+++ b/drivers/input/touchscreen/tsc2007.h
@@ -78,6 +78,7 @@ struct tsc2007 {
 	bool			stopped;
 
 	int			(*get_pendown_state)(struct device *);
+	int			(*get_pendown_state_cansleep)(struct device *dev);
 	void			(*clear_penirq)(void);
 
 	struct mutex		mlock;
diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
index 3e871d182c40..eba35ee1e28c 100644
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
 
+static bool tsc2007_is_pen_down_cansleep(struct tsc2007 *ts)
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
@@ -264,10 +281,17 @@ static int tsc2007_probe_properties(struct device *dev, struct tsc2007 *ts)
 	if (IS_ERR(ts->gpiod))
 		return PTR_ERR(ts->gpiod);
 
-	if (ts->gpiod)
-		ts->get_pendown_state = tsc2007_get_pendown_state_gpio;
-	else
+	if (ts->gpiod) {
+		ts->get_pendown_state_cansleep = tsc2007_get_pendown_state_gpio_cansleep;
+
+		/* pendown pin is read during hard irq -> gpio chip is not allowed to sleep */
+		if (gpiod_to_chip(ts->gpiod) && !gpiod_to_chip(ts->gpiod)->can_sleep)
+			ts->get_pendown_state = tsc2007_get_pendown_state_gpio;
+		else
+			dev_dbg(dev, "Pen down GPIO chip can sleep\n");
+	} else {
 		dev_warn(dev, "Pen down GPIO is not specified in properties\n");
+	}
 
 	return 0;
 }
-- 
2.34.1

