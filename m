Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D76E47BE57
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhLUKqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbhLUKqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:46:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25EFC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 02:46:08 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzcei-0005BH-O6; Tue, 21 Dec 2021 11:46:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzcei-005ng2-F6; Tue, 21 Dec 2021 11:46:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzceh-0004C6-DM; Tue, 21 Dec 2021 11:46:03 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] counter: microchip-tcp-capture: Use container_of instead of struct counter_device::priv
Date:   Tue, 21 Dec 2021 11:45:43 +0100
Message-Id: <20211221104546.214066-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211221104546.214066-1-u.kleine-koenig@pengutronix.de>
References: <20211221104546.214066-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=+mGMCzcHVB52IvHhf9leKp6Y9DlWvz9ld0t8InuL0Q4=; m=m4jRnAmJlhgb59M+JVnjEsk6IMQPqWL9MFo6aBi4ZGA=; p=AXyjvzc03RwiiDbH4rGJn2dLLt6SLlipHOAxCyxAePg=; g=0118e46f757cd59c8cf911fec853a5b5c7162064
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHBsEIACgkQwfwUeK3K7AkrRAgAn5X rbIhFZqaAclK48bgp/jaTqoNE3hvRtJDGKyKqMCNUIFt394aZZ0H9VmwtJYsOD2eGk0csSWcqpJUK uNmPXRTbJMzwtvx4CEbleKsmcfTRQmQGbaSVL/4Zalh5vIQYcsjBp1ZHnV0YKBaVpoDMaUWxnAUBs EH3RWdkpc0qI8eCJJBeo2a5RjdbCgePbFurA8tkV7J3PX/cQWXpOOk7pstJyISzDtbmHaWWM7mj9f fgrMaZrTemxCV0HgyCn0AGZA3JAJ5lOvCdTn9dRdl1MZay7ZkFP+9DYaiMKXlIU/9tanMqzPu63s3 x/71Ax7/ii/XmTowtkYyseMrhpFVVHA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using counter->priv is a memory read and so more expensive than
container_of which is only an addition.

So container_of is expected to be a tad faster, it's type-safe, and
produces smaller code (ARCH=arm allmodconfig):

	add/remove: 0/0 grow/shrink: 1/6 up/down: 12/-68 (-56)
	Function                                     old     new   delta
	mchp_tc_count_function_write                1016    1028     +12
	mchp_tc_count_action_write                   204     196      -8
	mchp_tc_probe                               1376    1364     -12
	mchp_tc_count_signal_read                    360     348     -12
	mchp_tc_count_read                           264     252     -12
	mchp_tc_count_function_read                  108      96     -12
	mchp_tc_count_action_read                    392     380     -12
	Total: Before=5920, After=5864, chg -0.95%

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/microchip-tcb-capture.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 0ab1b2716784..031e79f5f06a 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -32,6 +32,11 @@ struct mchp_tc_data {
 	bool trig_inverted;
 };
 
+static inline struct mchp_tc_data *mchp_tc_from_counter(struct counter_device *counter)
+{
+	return container_of(counter, struct mchp_tc_data, counter);
+}
+
 static const enum counter_function mchp_tc_count_functions[] = {
 	COUNTER_FUNCTION_INCREASE,
 	COUNTER_FUNCTION_QUADRATURE_X4,
@@ -72,7 +77,7 @@ static int mchp_tc_count_function_read(struct counter_device *counter,
 				       struct counter_count *count,
 				       enum counter_function *function)
 {
-	struct mchp_tc_data *const priv = counter->priv;
+	struct mchp_tc_data *const priv = mchp_tc_from_counter(counter);
 
 	if (priv->qdec_mode)
 		*function = COUNTER_FUNCTION_QUADRATURE_X4;
@@ -86,7 +91,7 @@ static int mchp_tc_count_function_write(struct counter_device *counter,
 					struct counter_count *count,
 					enum counter_function function)
 {
-	struct mchp_tc_data *const priv = counter->priv;
+	struct mchp_tc_data *const priv = mchp_tc_from_counter(counter);
 	u32 bmr, cmr;
 
 	regmap_read(priv->regmap, ATMEL_TC_BMR, &bmr);
@@ -148,7 +153,7 @@ static int mchp_tc_count_signal_read(struct counter_device *counter,
 				     struct counter_signal *signal,
 				     enum counter_signal_level *lvl)
 {
-	struct mchp_tc_data *const priv = counter->priv;
+	struct mchp_tc_data *const priv = mchp_tc_from_counter(counter);
 	bool sigstatus;
 	u32 sr;
 
@@ -169,7 +174,7 @@ static int mchp_tc_count_action_read(struct counter_device *counter,
 				     struct counter_synapse *synapse,
 				     enum counter_synapse_action *action)
 {
-	struct mchp_tc_data *const priv = counter->priv;
+	struct mchp_tc_data *const priv = mchp_tc_from_counter(counter);
 	u32 cmr;
 
 	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CMR), &cmr);
@@ -197,7 +202,7 @@ static int mchp_tc_count_action_write(struct counter_device *counter,
 				      struct counter_synapse *synapse,
 				      enum counter_synapse_action action)
 {
-	struct mchp_tc_data *const priv = counter->priv;
+	struct mchp_tc_data *const priv = mchp_tc_from_counter(counter);
 	u32 edge = ATMEL_TC_ETRGEDG_NONE;
 
 	/* QDEC mode is rising edge only */
@@ -230,7 +235,7 @@ static int mchp_tc_count_action_write(struct counter_device *counter,
 static int mchp_tc_count_read(struct counter_device *counter,
 			      struct counter_count *count, u64 *val)
 {
-	struct mchp_tc_data *const priv = counter->priv;
+	struct mchp_tc_data *const priv = mchp_tc_from_counter(counter);
 	u32 cnt;
 
 	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CV), &cnt);
@@ -369,7 +374,6 @@ static int mchp_tc_probe(struct platform_device *pdev)
 	priv->counter.counts = mchp_tc_counts;
 	priv->counter.num_signals = ARRAY_SIZE(mchp_tc_count_signals);
 	priv->counter.signals = mchp_tc_count_signals;
-	priv->counter.priv = priv;
 
 	return devm_counter_register(&pdev->dev, &priv->counter);
 }
-- 
2.33.0

