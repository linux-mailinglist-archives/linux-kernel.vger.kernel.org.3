Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FFE47FB80
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbhL0Jpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbhL0Jps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:45:48 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5C3C061401
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 01:45:45 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZU-0006YY-G3; Mon, 27 Dec 2021 10:45:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZT-006u98-PJ; Mon, 27 Dec 2021 10:45:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZS-0005VH-G1; Mon, 27 Dec 2021 10:45:34 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>
Subject: [PATCH v2 10/23] counter: ti-eqep: Convert to counter_priv() wrapper
Date:   Mon, 27 Dec 2021 10:45:13 +0100
Message-Id: <20211227094526.698714-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=6MqFV7t6dDAtqKVQ1JRjjyf0lybyIPEbXzIHZgEVAAQ=; m=O/hbHSowifJBTpUmrGb87d4c+26dGvtHSBxVMu37a1o=; p=6xJMhmvitr00TAkap6xN8YFZV105DGl6AsAsy7Kx9KI=; g=48b4db3d775ce4531c9e42ad8d8eae8077b5a5ab
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHJipAACgkQwfwUeK3K7AkoUQf9EYE i970WqSnejDtH4vQfdjYkrfjFXwXOEBSR784FWIJP1NJb9ViUIS239TSQw20KvhvPKU0QzIapbvX5 2Gmaq7HVVxf6mkJ2p8lrWuxFGpjYS/WtE9diZyzWttycbLgRAADrkzlZPERIGbSa6Zc3pKukkT/T0 mkJ9QcZlX9GLrZLVnsj3qJcKDFIrelsN85/s5UxhlkfRANvHzzMwu3MpVhVku1cwOw7zHCJTpjBnP 7PNNwuxT9xqmJYOeBW9Zc2eJwWevmok2+cCo/q6UFDCJ3KdBPp/RRm3h9mXmJSzwP5Itk2UQGQapk QI1Zx4bkfwVyFhBgR09/1JID9Qf5bUg==
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
 drivers/counter/ti-eqep.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 09817c953f9a..abeda966e7be 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -90,7 +90,7 @@ struct ti_eqep_cnt {
 static int ti_eqep_count_read(struct counter_device *counter,
 			      struct counter_count *count, u64 *val)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 	u32 cnt;
 
 	regmap_read(priv->regmap32, QPOSCNT, &cnt);
@@ -102,7 +102,7 @@ static int ti_eqep_count_read(struct counter_device *counter,
 static int ti_eqep_count_write(struct counter_device *counter,
 			       struct counter_count *count, u64 val)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 	u32 max;
 
 	regmap_read(priv->regmap32, QPOSMAX, &max);
@@ -116,7 +116,7 @@ static int ti_eqep_function_read(struct counter_device *counter,
 				 struct counter_count *count,
 				 enum counter_function *function)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 	u32 qdecctl;
 
 	regmap_read(priv->regmap16, QDECCTL, &qdecctl);
@@ -143,7 +143,7 @@ static int ti_eqep_function_write(struct counter_device *counter,
 				  struct counter_count *count,
 				  enum counter_function function)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 	enum ti_eqep_count_func qsrc;
 
 	switch (function) {
@@ -173,7 +173,7 @@ static int ti_eqep_action_read(struct counter_device *counter,
 			       struct counter_synapse *synapse,
 			       enum counter_synapse_action *action)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 	enum counter_function function;
 	u32 qdecctl;
 	int err;
@@ -245,7 +245,7 @@ static int ti_eqep_position_ceiling_read(struct counter_device *counter,
 					 struct counter_count *count,
 					 u64 *ceiling)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 	u32 qposmax;
 
 	regmap_read(priv->regmap32, QPOSMAX, &qposmax);
@@ -259,7 +259,7 @@ static int ti_eqep_position_ceiling_write(struct counter_device *counter,
 					  struct counter_count *count,
 					  u64 ceiling)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 
 	if (ceiling != (u32)ceiling)
 		return -ERANGE;
@@ -272,7 +272,7 @@ static int ti_eqep_position_ceiling_write(struct counter_device *counter,
 static int ti_eqep_position_enable_read(struct counter_device *counter,
 					struct counter_count *count, u8 *enable)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 	u32 qepctl;
 
 	regmap_read(priv->regmap16, QEPCTL, &qepctl);
@@ -285,7 +285,7 @@ static int ti_eqep_position_enable_read(struct counter_device *counter,
 static int ti_eqep_position_enable_write(struct counter_device *counter,
 					 struct counter_count *count, u8 enable)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 
 	regmap_write_bits(priv->regmap16, QEPCTL, QEPCTL_PHEN, enable ? -1 : 0);
 
-- 
2.33.0

