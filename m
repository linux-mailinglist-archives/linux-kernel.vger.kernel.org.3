Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6763847BE5A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236745AbhLUKqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbhLUKqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:46:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5512C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 02:46:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzcel-0005BN-V1; Tue, 21 Dec 2021 11:46:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzcei-005ng5-TZ; Tue, 21 Dec 2021 11:46:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzceh-0004CE-JM; Tue, 21 Dec 2021 11:46:03 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] counter: stm32-lptimer-cnt: Use container_of instead of struct counter_device::priv
Date:   Tue, 21 Dec 2021 11:45:44 +0100
Message-Id: <20211221104546.214066-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211221104546.214066-1-u.kleine-koenig@pengutronix.de>
References: <20211221104546.214066-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=1HOXp2/duyo6n/2D4QQ5RE3nJbn3xI4q4e0n+QcZL4o=; m=kIc7VsSS0WRvJXcgL7haggwSGZnZfnb/5UpfyeNoh+I=; p=bQvWuGWMnZ1NXlmcBpZTTro6PdXlihtuS79lnHsi8WA=; g=b00ec8495b7403537c3bc26005bb71ad27f8b411
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHBsEYACgkQwfwUeK3K7AkBRgf+I3T 09U/qrDBmUGLwlot6PnfpTnrDpXaZeHRO29u5clIrtVMauKmCzqEWxoIBCHse9BiJU9MZcnBNS5Qk sDFXPjn8IrKwIoTloWjEIzyzIF6x4MjX6n6w+NbeC2apl2vMKiYmOMJLF08vO9yfReXQVcnY9quhy HMDCm+xeFAt6h2axCGg7Og4arWLAXJrsdooewiS4ZdK1wHkWt6x9+rdO6x9sKhCndefH2vq/QEi5h CLrlHoTzc/mkUoC28ifXGCRyRIKUIOlLdwvKwmpKd3X3SFsUR8kNM+IXVa1chI9N+skNPsoezw0xJ XGp7KYwWM0A0EuB3rXXnHYQaeaJKeew==
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

	add/remove: 0/0 grow/shrink: 0/10 up/down: 0/-140 (-140)
	Function                                     old     new   delta
	stm32_lptim_cnt_read                         272     260     -12
	stm32_lptim_cnt_probe                        528     516     -12
	stm32_lptim_cnt_function_write               420     408     -12
	stm32_lptim_cnt_function_read                184     172     -12
	stm32_lptim_cnt_enable_write                 436     424     -12
	stm32_lptim_cnt_enable_read                  312     300     -12
	stm32_lptim_cnt_ceiling_write                368     356     -12
	stm32_lptim_cnt_ceiling_read                  84      72     -12
	stm32_lptim_cnt_action_read                  388     376     -12
	stm32_lptim_cnt_action_write                 576     544     -32
	Total: Before=6458, After=6318, chg -2.17%

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/stm32-lptimer-cnt.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index 5168833b1fdf..c6eb3071571f 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -30,6 +30,11 @@ struct stm32_lptim_cnt {
 	bool enabled;
 };
 
+static inline struct stm32_lptim_cnt *stm32_lptim_from_counter(struct counter_device *counter)
+{
+	return container_of(counter, struct stm32_lptim_cnt, counter);
+}
+
 static int stm32_lptim_is_enabled(struct stm32_lptim_cnt *priv)
 {
 	u32 val;
@@ -141,7 +146,7 @@ static const enum counter_synapse_action stm32_lptim_cnt_synapse_actions[] = {
 static int stm32_lptim_cnt_read(struct counter_device *counter,
 				struct counter_count *count, u64 *val)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = stm32_lptim_from_counter(counter);
 	u32 cnt;
 	int ret;
 
@@ -158,7 +163,7 @@ static int stm32_lptim_cnt_function_read(struct counter_device *counter,
 					 struct counter_count *count,
 					 enum counter_function *function)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = stm32_lptim_from_counter(counter);
 
 	if (!priv->quadrature_mode) {
 		*function = COUNTER_FUNCTION_INCREASE;
@@ -177,7 +182,7 @@ static int stm32_lptim_cnt_function_write(struct counter_device *counter,
 					  struct counter_count *count,
 					  enum counter_function function)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = stm32_lptim_from_counter(counter);
 
 	if (stm32_lptim_is_enabled(priv))
 		return -EBUSY;
@@ -200,7 +205,7 @@ static int stm32_lptim_cnt_enable_read(struct counter_device *counter,
 				       struct counter_count *count,
 				       u8 *enable)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = stm32_lptim_from_counter(counter);
 	int ret;
 
 	ret = stm32_lptim_is_enabled(priv);
@@ -216,7 +221,7 @@ static int stm32_lptim_cnt_enable_write(struct counter_device *counter,
 					struct counter_count *count,
 					u8 enable)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = stm32_lptim_from_counter(counter);
 	int ret;
 
 	/* Check nobody uses the timer, or already disabled/enabled */
@@ -241,7 +246,7 @@ static int stm32_lptim_cnt_ceiling_read(struct counter_device *counter,
 					struct counter_count *count,
 					u64 *ceiling)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = stm32_lptim_from_counter(counter);
 
 	*ceiling = priv->ceiling;
 
@@ -252,7 +257,7 @@ static int stm32_lptim_cnt_ceiling_write(struct counter_device *counter,
 					 struct counter_count *count,
 					 u64 ceiling)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = stm32_lptim_from_counter(counter);
 
 	if (stm32_lptim_is_enabled(priv))
 		return -EBUSY;
@@ -277,7 +282,7 @@ static int stm32_lptim_cnt_action_read(struct counter_device *counter,
 				       struct counter_synapse *synapse,
 				       enum counter_synapse_action *action)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = stm32_lptim_from_counter(counter);
 	enum counter_function function;
 	int err;
 
@@ -321,7 +326,7 @@ static int stm32_lptim_cnt_action_write(struct counter_device *counter,
 					struct counter_synapse *synapse,
 					enum counter_synapse_action action)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = stm32_lptim_from_counter(counter);
 	enum counter_function function;
 	int err;
 
@@ -438,7 +443,6 @@ static int stm32_lptim_cnt_probe(struct platform_device *pdev)
 	}
 	priv->counter.num_counts = 1;
 	priv->counter.signals = stm32_lptim_cnt_signals;
-	priv->counter.priv = priv;
 
 	platform_set_drvdata(pdev, priv);
 
-- 
2.33.0

