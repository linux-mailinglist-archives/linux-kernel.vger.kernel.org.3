Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504DD51772E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 21:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiEBTOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiEBTNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:13:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43038B7F
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 12:10:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nlbR8-0003ac-Hq; Mon, 02 May 2022 21:10:22 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nlbR8-006aqc-VT; Mon, 02 May 2022 21:10:21 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nlbR6-0078EP-UV; Mon, 02 May 2022 21:10:20 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] mfd: rt4831: Improve error reporting for problems during .remove()
Date:   Mon,  2 May 2022 21:10:12 +0200
Message-Id: <20220502191012.53259-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1462; h=from:subject; bh=J7yM61IzJ6y2Qz8B7rs33aZNuDxBMY4H/8qggWvylnw=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBicCyRMXaBWCPSLCB5hGi2SiQXdf3auA+CaI0jiYdt fBWhFOqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYnAskQAKCRDB/BR4rcrsCVstB/ 93llZfkpm47zRULcdvMeDpKG2SuxknWfneXiREZXEOzueCO2hfrmuOZ/PGuqifZHJAVSvso5ZInz9T Z2G9w9uYCEVlLxAXyZGEDpnxZ6ePeGYAk3nahUBkUL67xVrmXY6O0dmmdkPUaLk6sgLPTJ+c7KD6co TTE2anHN2FT0NdnT/ov2ok8o6EpboYGq0qefRzcWDlZLrXvE9F01fZ4AlDMgjz8MNEAA7T05wGEzeS mZOwxYZn/hGIWKZq/OoLCqRmHA4+lQKu5gGW4io7yuoyZdxYrEkhoDUUz44DehHXK1/GGqK20Fi6GS 0ZsoqPFm1m25HDbyD0Ei7ahIu45FWj
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

Returning an error value in an i2c remove callback results in a generic
error message being emitted by the i2c core, but otherwise it doesn't make
a difference. The device goes away anyhow and the devm cleanups are
called.

So instead of triggering the generic i2c error message, emit a more helpful
message if a problem occurs and return 0 to suppress the generic message.

This patch is a preparation for making i2c remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/mfd/rt4831.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/rt4831.c b/drivers/mfd/rt4831.c
index b169781ac675..fb3bd788a3eb 100644
--- a/drivers/mfd/rt4831.c
+++ b/drivers/mfd/rt4831.c
@@ -90,9 +90,14 @@ static int rt4831_probe(struct i2c_client *client)
 static int rt4831_remove(struct i2c_client *client)
 {
 	struct regmap *regmap = dev_get_regmap(&client->dev, NULL);
+	int ret;
 
 	/* Disable WLED and DSV outputs */
-	return regmap_update_bits(regmap, RT4831_REG_ENABLE, RT4831_RESET_MASK, RT4831_RESET_MASK);
+	ret = regmap_update_bits(regmap, RT4831_REG_ENABLE, RT4831_RESET_MASK, RT4831_RESET_MASK);
+	if (ret)
+		dev_warn(&client->dev, "Failed to disable outputs (%pe)\n", ERR_PTR(ret));
+
+	return 0;
 }
 
 static const struct of_device_id __maybe_unused rt4831_of_match[] = {

base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
2.35.1

