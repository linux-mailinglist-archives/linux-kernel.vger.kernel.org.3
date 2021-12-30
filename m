Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF884481D81
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241388AbhL3PDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240690AbhL3PDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:03:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA27C061746
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:03:11 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxQ-0000cV-6X; Thu, 30 Dec 2021 16:03:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxO-007VL5-1q; Thu, 30 Dec 2021 16:03:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxM-0007iE-S9; Thu, 30 Dec 2021 16:03:04 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 12/23] counter: stm32-timer-cnt: Convert to counter_priv() wrapper
Date:   Thu, 30 Dec 2021 16:02:49 +0100
Message-Id: <20211230150300.72196-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
References: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3961; h=from:subject; bh=wdtKkluXMmzSj2wb5mCtiu7A85AS1CCPgxJ//4kVhbg=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzcmQ3kwwwRodcPX7bEvfoLeNLmWXzuuZZVvYByRe IiHkw0WJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYc3JkAAKCRDB/BR4rcrsCSv2B/ 92/msvY3pbDjYgT03YxKAkDGo7M5Ggbf51Q+fW148v+PFxEPt8DtfVJN5301oNu08mkbJzy3xpTnte OJTXwnY0HrQHH6GSvmZmGY8SbnzQZ+WcJwhMROuj+bLQSG1KuvAaDT90/W7Cj76oAkl1VbUslNrL5S 9PPTHBAB6zeMk0XlNJ0/V0c+NPTsm8ffsKuIvQyrU6Vy5HYW0yp1vb0BPl8UBiiisqcxpKelnGVFue bvLmznin0ojM5EPayORlPh+NVeCcjfbbbYdrSODUrCsXAaqBf3YNgjF3s7jZmC1jS5DtAeKcedcIpb 3CP0ROGge84JZxunWBut0/qZb3MILa
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a straight forward conversion to the new counter_priv() wrapper.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/stm32-timer-cnt.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 0546e932db0c..4b05b198a8d8 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -47,7 +47,7 @@ static const enum counter_function stm32_count_functions[] = {
 static int stm32_count_read(struct counter_device *counter,
 			    struct counter_count *count, u64 *val)
 {
-	struct stm32_timer_cnt *const priv = counter->priv;
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
 	u32 cnt;
 
 	regmap_read(priv->regmap, TIM_CNT, &cnt);
@@ -59,7 +59,7 @@ static int stm32_count_read(struct counter_device *counter,
 static int stm32_count_write(struct counter_device *counter,
 			     struct counter_count *count, const u64 val)
 {
-	struct stm32_timer_cnt *const priv = counter->priv;
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
 	u32 ceiling;
 
 	regmap_read(priv->regmap, TIM_ARR, &ceiling);
@@ -73,7 +73,7 @@ static int stm32_count_function_read(struct counter_device *counter,
 				     struct counter_count *count,
 				     enum counter_function *function)
 {
-	struct stm32_timer_cnt *const priv = counter->priv;
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
 	u32 smcr;
 
 	regmap_read(priv->regmap, TIM_SMCR, &smcr);
@@ -100,7 +100,7 @@ static int stm32_count_function_write(struct counter_device *counter,
 				      struct counter_count *count,
 				      enum counter_function function)
 {
-	struct stm32_timer_cnt *const priv = counter->priv;
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
 	u32 cr1, sms;
 
 	switch (function) {
@@ -140,7 +140,7 @@ static int stm32_count_direction_read(struct counter_device *counter,
 				      struct counter_count *count,
 				      enum counter_count_direction *direction)
 {
-	struct stm32_timer_cnt *const priv = counter->priv;
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
 	u32 cr1;
 
 	regmap_read(priv->regmap, TIM_CR1, &cr1);
@@ -153,7 +153,7 @@ static int stm32_count_direction_read(struct counter_device *counter,
 static int stm32_count_ceiling_read(struct counter_device *counter,
 				    struct counter_count *count, u64 *ceiling)
 {
-	struct stm32_timer_cnt *const priv = counter->priv;
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
 	u32 arr;
 
 	regmap_read(priv->regmap, TIM_ARR, &arr);
@@ -166,7 +166,7 @@ static int stm32_count_ceiling_read(struct counter_device *counter,
 static int stm32_count_ceiling_write(struct counter_device *counter,
 				     struct counter_count *count, u64 ceiling)
 {
-	struct stm32_timer_cnt *const priv = counter->priv;
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
 
 	if (ceiling > priv->max_arr)
 		return -ERANGE;
@@ -181,7 +181,7 @@ static int stm32_count_ceiling_write(struct counter_device *counter,
 static int stm32_count_enable_read(struct counter_device *counter,
 				   struct counter_count *count, u8 *enable)
 {
-	struct stm32_timer_cnt *const priv = counter->priv;
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
 	u32 cr1;
 
 	regmap_read(priv->regmap, TIM_CR1, &cr1);
@@ -194,7 +194,7 @@ static int stm32_count_enable_read(struct counter_device *counter,
 static int stm32_count_enable_write(struct counter_device *counter,
 				    struct counter_count *count, u8 enable)
 {
-	struct stm32_timer_cnt *const priv = counter->priv;
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
 	u32 cr1;
 
 	if (enable) {
-- 
2.34.1

