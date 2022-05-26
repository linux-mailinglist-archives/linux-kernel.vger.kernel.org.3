Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49612534FC1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242878AbiEZNIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbiEZNIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:08:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5ADDCFE23
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:08:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nuDDg-0003LE-0n; Thu, 26 May 2022 15:08:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nuDDd-004gUa-Bb; Thu, 26 May 2022 15:08:00 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nuDDb-00CFyt-CR; Thu, 26 May 2022 15:07:59 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] extcon: fsa9480: Drop no-op remove function
Date:   Thu, 26 May 2022 15:07:54 +0200
Message-Id: <20220526130754.1587373-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1025; h=from:subject; bh=Tk/2up8nPEfEhVx9fKawfZp8/LoRbJ9elsSR3ZXzMho=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBij3um0DtWhTEOGyRL+Zwf6ANv0O6igfOb1KUVevoE ZseUeiaJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYo97pgAKCRDB/BR4rcrsCaLUCA CLvExZnPn6AgK/pykKc09Zr0YXr5gvVpQTxL2SgNWJB1A4lCSakOQledMV7p/L6hD0CH0HW4qK1vro z5lESD7Fm5uYw7b+h9rfywfhv8ys+emYpyKaNRwy0U02PUjqqHrpdYWmMA9eVmUpJeKP6RuJjphgp+ YrN0dAnTssaxMzJT0RpcOWquvlioa4YAXyNSbaTGBHKBnRJ7srsb5TJfUO50jUcaV9s4n75QIJh5qp cFOSdoqhBJinrPGfZ9YQMPd9GmxaTCxiX+kNRA9UyMcgBrV/lzGo3h3C3HH1+zvF2ZC7jQ57L65keK YAjfbzHBOD1yVZCYkeSX11O55F15Gn
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

A remove callback that just returns 0 is equivalent to no callback at all
as can be seen in i2c_device_remove(). So simplify accordingly.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/extcon/extcon-fsa9480.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/extcon/extcon-fsa9480.c b/drivers/extcon/extcon-fsa9480.c
index 08bdedbcdb0d..7cff66c29907 100644
--- a/drivers/extcon/extcon-fsa9480.c
+++ b/drivers/extcon/extcon-fsa9480.c
@@ -324,11 +324,6 @@ static int fsa9480_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int fsa9480_remove(struct i2c_client *client)
-{
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int fsa9480_suspend(struct device *dev)
 {
@@ -376,7 +371,6 @@ static struct i2c_driver fsa9480_i2c_driver = {
 		.of_match_table = fsa9480_of_match,
 	},
 	.probe			= fsa9480_probe,
-	.remove			= fsa9480_remove,
 	.id_table		= fsa9480_id,
 };
 

base-commit: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f
-- 
2.36.1

