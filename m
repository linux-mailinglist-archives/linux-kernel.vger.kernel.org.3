Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2C84814A9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 16:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240727AbhL2PpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 10:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240624AbhL2Po6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 10:44:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A419C061747
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 07:44:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8H-0006qO-8d; Wed, 29 Dec 2021 16:44:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8E-007KGv-BD; Wed, 29 Dec 2021 16:44:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8D-00012s-C3; Wed, 29 Dec 2021 16:44:49 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH v3 07/23] counter: microchip-tcb-capture: Convert to counter_priv() wrapper
Date:   Wed, 29 Dec 2021 16:44:25 +0100
Message-Id: <20211229154441.38045-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2839; h=from:subject; bh=g+9shAfdI+y9E4bonTCycgoVLFyAnN2LNJinmiWu6Z4=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzIImvJA3uZ/zFjqlOacr59iSzBNt2Kus4WzOXJ0b vq6ynxOJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYcyCJgAKCRDB/BR4rcrsCZjfB/ 49m3/C0ARKic8yteuHrcTtcA1Y+XIDFjuyTiKde0VQUVODqjQESWFRUOZvwXdIXlnSzXu5wV23pu8J 4v8nxapj2THiaLS4y0f3/8swLIWUhatOndqUDDA+cU00LoXIxnAoC3xwtGfsRyLjTAnN5LEyfPPCL7 mxsBa3wR3ZiEOyTHKKvajgPj0DZdhKSO7WC5wWPYevbiKgzKlCfNIMKupyvec6A1sz5y/R+UCHVNtw xmhRAVQN6GzMf6u/40f5gO7UzufrZE7LWLKkyB8bQ+Ydh+zGw6UhqK8ozDQ0UuVKiggCKECcGA7uH6 Aew6RBHusx6XLXpheBrtJx4HQh+uvA
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
 drivers/counter/microchip-tcb-capture.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index bb69f2e0ba93..1b56b7444668 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -72,7 +72,7 @@ static int mchp_tc_count_function_read(struct counter_device *counter,
 				       struct counter_count *count,
 				       enum counter_function *function)
 {
-	struct mchp_tc_data *const priv = counter->priv;
+	struct mchp_tc_data *const priv = counter_priv(counter);
 
 	if (priv->qdec_mode)
 		*function = COUNTER_FUNCTION_QUADRATURE_X4;
@@ -86,7 +86,7 @@ static int mchp_tc_count_function_write(struct counter_device *counter,
 					struct counter_count *count,
 					enum counter_function function)
 {
-	struct mchp_tc_data *const priv = counter->priv;
+	struct mchp_tc_data *const priv = counter_priv(counter);
 	u32 bmr, cmr;
 
 	regmap_read(priv->regmap, ATMEL_TC_BMR, &bmr);
@@ -148,7 +148,7 @@ static int mchp_tc_count_signal_read(struct counter_device *counter,
 				     struct counter_signal *signal,
 				     enum counter_signal_level *lvl)
 {
-	struct mchp_tc_data *const priv = counter->priv;
+	struct mchp_tc_data *const priv = counter_priv(counter);
 	bool sigstatus;
 	u32 sr;
 
@@ -169,7 +169,7 @@ static int mchp_tc_count_action_read(struct counter_device *counter,
 				     struct counter_synapse *synapse,
 				     enum counter_synapse_action *action)
 {
-	struct mchp_tc_data *const priv = counter->priv;
+	struct mchp_tc_data *const priv = counter_priv(counter);
 	u32 cmr;
 
 	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CMR), &cmr);
@@ -197,7 +197,7 @@ static int mchp_tc_count_action_write(struct counter_device *counter,
 				      struct counter_synapse *synapse,
 				      enum counter_synapse_action action)
 {
-	struct mchp_tc_data *const priv = counter->priv;
+	struct mchp_tc_data *const priv = counter_priv(counter);
 	u32 edge = ATMEL_TC_ETRGEDG_NONE;
 
 	/* QDEC mode is rising edge only */
@@ -230,7 +230,7 @@ static int mchp_tc_count_action_write(struct counter_device *counter,
 static int mchp_tc_count_read(struct counter_device *counter,
 			      struct counter_count *count, u64 *val)
 {
-	struct mchp_tc_data *const priv = counter->priv;
+	struct mchp_tc_data *const priv = counter_priv(counter);
 	u32 cnt;
 
 	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CV), &cnt);
-- 
2.34.1

