Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7736B4814B9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 16:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240827AbhL2PqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 10:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240619AbhL2PpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 10:45:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376A6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 07:45:04 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8N-0006qT-51; Wed, 29 Dec 2021 16:44:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8F-007KHE-Bs; Wed, 29 Dec 2021 16:44:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8E-000144-AW; Wed, 29 Dec 2021 16:44:50 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 12/23] counter: stm32-timer-cnt: Convert to counter_priv() wrapper
Date:   Wed, 29 Dec 2021 16:44:30 +0100
Message-Id: <20211229154441.38045-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3961; h=from:subject; bh=wdtKkluXMmzSj2wb5mCtiu7A85AS1CCPgxJ//4kVhbg=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzII43kwwwRodcPX7bEvfoLeNLmWXzuuZZVvYByRe IiHkw0WJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYcyCOAAKCRDB/BR4rcrsCbfvB/ 9GYkY5IfFHlZ8gE7GGmUcvU0cAHhCxX2T9XS59eBp3yO1/c4PMubdMIqYHrCOKyEm2SqIoyMqCc/9e cAOQRc1tyoP0hY57o4/pqdVHDMXPQg9MM8XaYUbupf6MVg8AhXd1VJUn6l5gRz4ijT0hFFg6n/9/qX NRTvE+XDCroKRJFBg88oCzfX3agNnvVKTEE6pYQl/Lvo82Um8gvlLCCr1jHjoIGv41r3qy7JUv9BEO tBt4qenVtPXcHRQZPo4VuFElSvjy75J8jEvENRYVbDWt7OUH5a9UvBUlDlTIvzs62Zhll6aeZDRbUQ gjxxrxCtGWa/hM6OtAD/VARE+4qBxv
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

