Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4768E4BBE67
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbiBRR3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:29:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238606AbiBRR3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:29:37 -0500
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr [80.12.242.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5352B4D80
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:29:20 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id L74GnW5saFTgbL74Hni9ks; Fri, 18 Feb 2022 18:29:17 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 18 Feb 2022 18:29:17 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Support Opensource <support.opensource@diasemi.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-input@vger.kernel.org
Subject: [PATCH] Input: da9063 - Use devm_delayed_work_autocancel()
Date:   Fri, 18 Feb 2022 18:29:13 +0100
Message-Id: <a76ac3f4c7aee205395b89b5b3f587e30a48df96.1645205312.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_delayed_work_autocancel() instead of hand-writing it.
This saves a few lines of code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/input/misc/da9063_onkey.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
index 79851923ee57..b14a389600c9 100644
--- a/drivers/input/misc/da9063_onkey.c
+++ b/drivers/input/misc/da9063_onkey.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2015  Dialog Semiconductor Ltd.
  */
 
+#include <linux/devm-helpers.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/input.h>
@@ -182,13 +183,6 @@ static irqreturn_t da9063_onkey_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void da9063_cancel_poll(void *data)
-{
-	struct da9063_onkey *onkey = data;
-
-	cancel_delayed_work_sync(&onkey->work);
-}
-
 static int da9063_onkey_probe(struct platform_device *pdev)
 {
 	struct da9063_onkey *onkey;
@@ -234,9 +228,8 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 
 	input_set_capability(onkey->input, EV_KEY, KEY_POWER);
 
-	INIT_DELAYED_WORK(&onkey->work, da9063_poll_on);
-
-	error = devm_add_action(&pdev->dev, da9063_cancel_poll, onkey);
+	error = devm_delayed_work_autocancel(&pdev->dev, &onkey->work,
+					     da9063_poll_on);
 	if (error) {
 		dev_err(&pdev->dev,
 			"Failed to add cancel poll action: %d\n",
-- 
2.32.0

