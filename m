Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B842481D7F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241210AbhL3PDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbhL3PDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:03:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE80C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:03:11 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxQ-0000cU-6N; Thu, 30 Dec 2021 16:03:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxN-007VL1-SG; Thu, 30 Dec 2021 16:03:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxM-0007i3-Lg; Thu, 30 Dec 2021 16:03:04 +0100
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
Subject: [PATCH v4 11/23] counter: stm32-lptimer-cnt: Convert to counter_priv() wrapper
Date:   Thu, 30 Dec 2021 16:02:48 +0100
Message-Id: <20211230150300.72196-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
References: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3728; h=from:subject; bh=HzpiF2hM7TUPP6R0Q8sjl1mleB8WWDqnHZa5zXo9C1Q=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzcmNMowiChMBSWxMR+GhqtTMOuc77XHdTRdcTAEG HfEiyxCJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYc3JjQAKCRDB/BR4rcrsCRZ+B/ 4yPolbyDT6/f2itAP6FVVWrMKwBy2ark9XYvvASOMVv/Bisr0fRnfJIOl5ecEUXay0yguUAh6CphIu rsYavJpz6QpPfm1ilX4jCiR+qBSZSFH7UOJOBAD0EcWpIZx2Ye6r9LAW7+TczDj7uke1LVcPLQkC2/ T8PisQ6c5P2UiSumHKLP4WZbJfYfPM5Tj91pvv8ONUrcRyCNAtwTDuqHjTMg6hSL2juojNJSFBFJAh K2eXmSCsF3qoXfPmP8oYwaOFD9pVSYtjmEscgZz+snPbK+ImcFN+MOhRAc25ov/srHOQGFIZvb0jCH ICExfnjQoB06yCVoDKiIYLb120xW1F
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
 drivers/counter/stm32-lptimer-cnt.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index 5168833b1fdf..9cf00e929cc0 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -141,7 +141,7 @@ static const enum counter_synapse_action stm32_lptim_cnt_synapse_actions[] = {
 static int stm32_lptim_cnt_read(struct counter_device *counter,
 				struct counter_count *count, u64 *val)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = counter_priv(counter);
 	u32 cnt;
 	int ret;
 
@@ -158,7 +158,7 @@ static int stm32_lptim_cnt_function_read(struct counter_device *counter,
 					 struct counter_count *count,
 					 enum counter_function *function)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = counter_priv(counter);
 
 	if (!priv->quadrature_mode) {
 		*function = COUNTER_FUNCTION_INCREASE;
@@ -177,7 +177,7 @@ static int stm32_lptim_cnt_function_write(struct counter_device *counter,
 					  struct counter_count *count,
 					  enum counter_function function)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = counter_priv(counter);
 
 	if (stm32_lptim_is_enabled(priv))
 		return -EBUSY;
@@ -200,7 +200,7 @@ static int stm32_lptim_cnt_enable_read(struct counter_device *counter,
 				       struct counter_count *count,
 				       u8 *enable)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = counter_priv(counter);
 	int ret;
 
 	ret = stm32_lptim_is_enabled(priv);
@@ -216,7 +216,7 @@ static int stm32_lptim_cnt_enable_write(struct counter_device *counter,
 					struct counter_count *count,
 					u8 enable)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = counter_priv(counter);
 	int ret;
 
 	/* Check nobody uses the timer, or already disabled/enabled */
@@ -241,7 +241,7 @@ static int stm32_lptim_cnt_ceiling_read(struct counter_device *counter,
 					struct counter_count *count,
 					u64 *ceiling)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = counter_priv(counter);
 
 	*ceiling = priv->ceiling;
 
@@ -252,7 +252,7 @@ static int stm32_lptim_cnt_ceiling_write(struct counter_device *counter,
 					 struct counter_count *count,
 					 u64 ceiling)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = counter_priv(counter);
 
 	if (stm32_lptim_is_enabled(priv))
 		return -EBUSY;
@@ -277,7 +277,7 @@ static int stm32_lptim_cnt_action_read(struct counter_device *counter,
 				       struct counter_synapse *synapse,
 				       enum counter_synapse_action *action)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = counter_priv(counter);
 	enum counter_function function;
 	int err;
 
@@ -321,7 +321,7 @@ static int stm32_lptim_cnt_action_write(struct counter_device *counter,
 					struct counter_synapse *synapse,
 					enum counter_synapse_action action)
 {
-	struct stm32_lptim_cnt *const priv = counter->priv;
+	struct stm32_lptim_cnt *const priv = counter_priv(counter);
 	enum counter_function function;
 	int err;
 
-- 
2.34.1

