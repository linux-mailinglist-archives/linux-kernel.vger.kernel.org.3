Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A0E4B5430
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355605AbiBNPHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:07:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350292AbiBNPHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:07:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A42BC5D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:07:27 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJcwk-0007C6-06; Mon, 14 Feb 2022 16:07:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJcwf-00GZDl-K1; Mon, 14 Feb 2022 16:07:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJcwe-0038vY-42; Mon, 14 Feb 2022 16:07:16 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mfd: stmfx: Improve error message triggered by regulator fault in .remove()
Date:   Mon, 14 Feb 2022 16:07:10 +0100
Message-Id: <20220214150710.312269-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1895; h=from:subject; bh=7otsfwH6fSTSNUg7D7PDPsJdAxvDx1C+OtM3X6y9WW4=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiCnAahVc9oU88f9z5+LdgQOM1K1huVzxH5a+FLmWY K9ojzgSJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYgpwGgAKCRDB/BR4rcrsCYhVB/ 9x07HzFdma9g0XNiJMNDxDayGfAdWxyIOGpO+YuzleN4hktHzAof+9Ev8LRGtv+sL0AUF8LjDgpfjc acuWNwW8TxaKvXq8jSkVwJBU8qGCGT9MeXJOzH37Od5J4ONBCrWObqSBRb5R4d9sJwwvmausAJuYJZ YnwV1Jq3GV33j+RRStbRBhXBIihNTgBEhWf2zabifTj8tnqmf/lfQCL2XABByq0dtcLIvkA7BdzNCN PwX2tXHjdtTjWRsnMwzr42WR++dtsQOw8KhHLBu3B9IJZidKwXGKTWsMo9ojObuKe1wHP1qwoR963I LUMZOkThhFh4FecJ13wIJXT+Un3oKK
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Returning a non-zero value in an i2c remove callback results in the i2c
core emitting a very generic error message ("remove failed (-ESOMETHING),
will be ignored") and as the message indicates not further error handling
is done.

Instead emit a more specific error message and then return zero in
.remove().

The long-term goal is to make the i2c remove prototype return void, making
all implementations return 0 is preparatory work for this change.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Changes since (implicit) v1:

 - put declaration of ret and assignment in two lines.
   (requested by Lee Jones)

 drivers/mfd/stmfx.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index e095a3930142..122f96094410 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -392,17 +392,22 @@ static int stmfx_chip_init(struct i2c_client *client)
 	return ret;
 }
 
-static int stmfx_chip_exit(struct i2c_client *client)
+static void stmfx_chip_exit(struct i2c_client *client)
 {
 	struct stmfx *stmfx = i2c_get_clientdata(client);
 
 	regmap_write(stmfx->map, STMFX_REG_IRQ_SRC_EN, 0);
 	regmap_write(stmfx->map, STMFX_REG_SYS_CTRL, 0);
 
-	if (stmfx->vdd)
-		return regulator_disable(stmfx->vdd);
+	if (stmfx->vdd) {
+		int ret;
 
+		ret = regulator_disable(stmfx->vdd);
+		if (ret)
+			dev_err(&client->dev,
+				"Failed to disable vdd regulator: %pe\n",
+				ERR_PTR(ret));
+	}
-	return 0;
 }
 
 static int stmfx_probe(struct i2c_client *client,
@@ -466,7 +471,9 @@ static int stmfx_remove(struct i2c_client *client)
 {
 	stmfx_irq_exit(client);
 
-	return stmfx_chip_exit(client);
+	stmfx_chip_exit(client);
+
+	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP

base-commit: dcb85f85fa6f142aae1fe86f399d4503d49f2b60
-- 
2.34.1

