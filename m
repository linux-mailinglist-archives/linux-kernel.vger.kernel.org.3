Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B074247BE5B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbhLUKqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbhLUKqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:46:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCDCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 02:46:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzcel-0005BM-V2; Tue, 21 Dec 2021 11:46:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzcei-005ngA-QG; Tue, 21 Dec 2021 11:46:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzceh-0004CS-Ru; Tue, 21 Dec 2021 11:46:03 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] counter: stm32-timer-cnt: Use container_of instead of struct counter_device::priv
Date:   Tue, 21 Dec 2021 11:45:45 +0100
Message-Id: <20211221104546.214066-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211221104546.214066-1-u.kleine-koenig@pengutronix.de>
References: <20211221104546.214066-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=1Puab3XzxTVHN4jt651Xcm2ayt/NNTv3C4elozlzC2c=; m=/5nCYZ7WihDc/POXwyjyGoYCMmam3kFfXztb+Karnfk=; p=PcKDfqcYgcbKTwKZqW51cpBm6Qds+AfbyFYCjb3Ofbk=; g=1bfafced00b53cbf6f10ae27a2268b0e8968d011
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHBsEkACgkQwfwUeK3K7AmJKwgAmBL 8/QWoB+RYTBqLn7TQTv6QsEBT9f2ye7dhiiWn9EX0va0ygaWeyG0bvdx+3cFihsja5F6Xzt8FdlAf 3DSfrMwWSSvOfTDO+lXWfJySxktxhth1UX/XtB8S+FMQb7zBHlb1nM2VN0m7aeuuRMKCRgH/EchME 5Ch019QIQIIhpr7uPok7oBKDH59361kH76T69Zszld/dLkb4mLs94FrvaptA8kKjzzn14iwQcc3x3 OAhyXy7yYBY3xXyPZHF+Ldxe6qpPprHAQHIW72hU/qgYI0feQZdKSpN8ViJi9X2qheDRwagfCv8Kr tcqlsn9HP/pltFBp00WXKVN+z7o2q5Q==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using counter->priv is a memory read and so more expensive than
container_of which is only an addition. (In this case even a noop
because the offset is 0.)

So container_of is expected to be a tad faster, it's type-safe, and
produces smaller code (ARCH=arm allmodconfig):

	add/remove: 0/0 grow/shrink: 0/11 up/down: 0/-132 (-132)
	Function                                     old     new   delta
	stm32_timer_cnt_probe                        436     424     -12
	stm32_count_write                            312     300     -12
	stm32_count_read                             236     224     -12
	stm32_count_function_write                   492     480     -12
	stm32_count_function_read                    396     384     -12
	stm32_count_enable_write                     488     476     -12
	stm32_count_enable_read                      236     224     -12
	stm32_count_direction_read                   240     228     -12
	stm32_count_ceiling_write                    200     188     -12
	stm32_count_ceiling_read                     236     224     -12
	stm32_action_read                            492     480     -12
	Total: Before=5504, After=5372, chg -2.40%

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/stm32-timer-cnt.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 0546e932db0c..ac0bea6ce690 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -37,6 +37,11 @@ struct stm32_timer_cnt {
 	struct stm32_timer_regs bak;
 };
 
+static inline struct stm32_timer_cnt *stm32_count_from_counter(struct counter_device *counter)
+{
+	return container_of(counter, struct stm32_timer_cnt, counter);
+}
+
 static const enum counter_function stm32_count_functions[] = {
 	COUNTER_FUNCTION_INCREASE,
 	COUNTER_FUNCTION_QUADRATURE_X2_A,
@@ -47,7 +52,7 @@ static const enum counter_function stm32_count_functions[] = {
 static int stm32_count_read(struct counter_device *counter,
 			    struct counter_count *count, u64 *val)
 {
-	struct stm32_timer_cnt *const priv = counter->priv;
+	struct stm32_timer_cnt *const priv = stm32_count_from_counter(counter);
 	u32 cnt;
 
 	regmap_read(priv->regmap, TIM_CNT, &cnt);
@@ -59,7 +64,7 @@ static int stm32_count_read(struct counter_device *counter,
 static int stm32_count_write(struct counter_device *counter,
 			     struct counter_count *count, const u64 val)
 {
-	struct stm32_timer_cnt *const priv = counter->priv;
+	struct stm32_timer_cnt *const priv = stm32_count_from_counter(counter);
 	u32 ceiling;
 
 	regmap_read(priv->regmap, TIM_ARR, &ceiling);
@@ -73,7 +78,7 @@ static int stm32_count_function_read(struct counter_device *counter,
 				     struct counter_count *count,
 				     enum counter_function *function)
 {
-	struct stm32_timer_cnt *const priv = counter->priv;
+	struct stm32_timer_cnt *const priv = stm32_count_from_counter(counter);
 	u32 smcr;
 
 	regmap_read(priv->regmap, TIM_SMCR, &smcr);
@@ -100,7 +105,7 @@ static int stm32_count_function_write(struct counter_device *counter,
 				      struct counter_count *count,
 				      enum counter_function function)
 {
-	struct stm32_timer_cnt *const priv = counter->priv;
+	struct stm32_timer_cnt *const priv = stm32_count_from_counter(counter);
 	u32 cr1, sms;
 
 	switch (function) {
@@ -140,7 +145,7 @@ static int stm32_count_direction_read(struct counter_device *counter,
 				      struct counter_count *count,
 				      enum counter_count_direction *direction)
 {
-	struct stm32_timer_cnt *const priv = counter->priv;
+	struct stm32_timer_cnt *const priv = stm32_count_from_counter(counter);
 	u32 cr1;
 
 	regmap_read(priv->regmap, TIM_CR1, &cr1);
@@ -153,7 +158,7 @@ static int stm32_count_direction_read(struct counter_device *counter,
 static int stm32_count_ceiling_read(struct counter_device *counter,
 				    struct counter_count *count, u64 *ceiling)
 {
-	struct stm32_timer_cnt *const priv = counter->priv;
+	struct stm32_timer_cnt *const priv = stm32_count_from_counter(counter);
 	u32 arr;
 
 	regmap_read(priv->regmap, TIM_ARR, &arr);
@@ -166,7 +171,7 @@ static int stm32_count_ceiling_read(struct counter_device *counter,
 static int stm32_count_ceiling_write(struct counter_device *counter,
 				     struct counter_count *count, u64 ceiling)
 {
-	struct stm32_timer_cnt *const priv = counter->priv;
+	struct stm32_timer_cnt *const priv = stm32_count_from_counter(counter);
 
 	if (ceiling > priv->max_arr)
 		return -ERANGE;
@@ -181,7 +186,7 @@ static int stm32_count_ceiling_write(struct counter_device *counter,
 static int stm32_count_enable_read(struct counter_device *counter,
 				   struct counter_count *count, u8 *enable)
 {
-	struct stm32_timer_cnt *const priv = counter->priv;
+	struct stm32_timer_cnt *const priv = stm32_count_from_counter(counter);
 	u32 cr1;
 
 	regmap_read(priv->regmap, TIM_CR1, &cr1);
@@ -194,7 +199,7 @@ static int stm32_count_enable_read(struct counter_device *counter,
 static int stm32_count_enable_write(struct counter_device *counter,
 				    struct counter_count *count, u8 enable)
 {
-	struct stm32_timer_cnt *const priv = counter->priv;
+	struct stm32_timer_cnt *const priv = stm32_count_from_counter(counter);
 	u32 cr1;
 
 	if (enable) {
@@ -336,7 +341,6 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
 	priv->counter.num_counts = 1;
 	priv->counter.signals = stm32_signals;
 	priv->counter.num_signals = ARRAY_SIZE(stm32_signals);
-	priv->counter.priv = priv;
 
 	platform_set_drvdata(pdev, priv);
 
-- 
2.33.0

