Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3084AB67B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345348AbiBGISs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345030AbiBGIR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:17:29 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766C0C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 00:17:28 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nGzDB-00062Y-7R; Mon, 07 Feb 2022 09:17:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nGzDA-00F3aj-1U; Mon, 07 Feb 2022 09:17:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nGzD8-00ANfg-FB; Mon, 07 Feb 2022 09:17:22 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] mfd: stmfx: Improve error message triggered by regulator fault in .remove()
Date:   Mon,  7 Feb 2022 09:17:09 +0100
Message-Id: <20220207081709.27288-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1766; h=from:subject; bh=U6+lWWPmvSZmtADyREDLbI8cQd9NgkKUAA+ihpaCGuw=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiANV/3LDMskuD9hlsssYfPrY5Z6oZAFdy4c2rVkVU pnTRxQKJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYgDVfwAKCRDB/BR4rcrsCVlKB/ 9QsGMhDj4Rd5PUIzXmFVPx16oPKv7K99HwhiaXM6mSvH56j+86WWKTQDpn/AA+yh2urc+WPNvU0UvW z3JDl21o+p+c0l2XJE5mHHJo4zRFhgTOoEY9HgjveFhCfnyzCgXBtufzdldY1CBWpp9QD2GG37u0zP fc7bSyxjUXiPXpXz2wI+BxSse3B29Aqw1cJEmAMGoiBWagOkuw2ss6KZZ0/QuMkI+yQcNPtlc4qQfD 1qxY6bnSRLqJziZhPnbnAgAuHnfeW9IkRk3AkSD3pQyPwWXVZYwMTb9SigWJAuefqVDa0nDCa7zVUG cFXnHBu3pCyiARsAP8sDfWWshTGxyV
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
 drivers/mfd/stmfx.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index e095a3930142..16631c675f2f 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -392,17 +392,21 @@ static int stmfx_chip_init(struct i2c_client *client)
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
+		int ret = regulator_disable(stmfx->vdd);
 
-	return 0;
+		if (ret)
+			dev_err(&client->dev,
+				"Failed to disable vdd regulator: %pe\n",
+				ERR_PTR(ret));
+	}
 }
 
 static int stmfx_probe(struct i2c_client *client,
@@ -466,7 +470,9 @@ static int stmfx_remove(struct i2c_client *client)
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

