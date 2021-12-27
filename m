Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A65E47FB8A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbhL0JqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbhL0Jpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:45:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E99C0613A1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 01:45:46 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZY-0006Ya-6K; Mon, 27 Dec 2021 10:45:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZT-006u9D-Ul; Mon, 27 Dec 2021 10:45:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZS-0005VX-R6; Mon, 27 Dec 2021 10:45:34 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 12/23] counter: stm32-timer-cnt: Convert to counter_priv() wrapper
Date:   Mon, 27 Dec 2021 10:45:15 +0100
Message-Id: <20211227094526.698714-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=jiIt05viV+/UoAbdZ4oWQf1/t5U/5n6JBm60zggyQaM=; m=O/hbHSowifJBTpUmrGb87d4c+26dGvtHSBxVMu37a1o=; p=sANTzUiR3cllbRFQ36wQwKYkkmtWDHQr3TlBm5aVrSs=; g=412a8aaa588e007ef2d19bf6acde944651719eda
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHJip0ACgkQwfwUeK3K7Amo9Af9EL3 ijoahGlA2rYq6RbVKCBZdcbseUsTfapwZ4sGo3p+ub/2c7R0j8eW/b0l8YcwzM2q3g3MUfJDihT3A K7vL3GY4usKHGCKSurLM6j9J0GgCyNflhzL8sG+Sh2cBrXCs9DW1GbIaS40RN5xgdwjgXT7CSsSzR 9y/rCAubbkaSWVZoydcu/C/aJ5oQmBmSNPhYqs0ySuoNvhBBsVtccRuU7BYtmm0hqx+Vr8tpVGfJ2 eOBlRvNvRiTtq++51B1tkOnoWQRYqksFinSfbyqlHb7SlziswGnbzgDNKNYroa9qy9VUSJnBY+NfE rhQ3J68U3xtiOmJA15E59ZjVqRut/8w==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a straight forward conversion to the new counter_priv() wrapper.

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
2.33.0

