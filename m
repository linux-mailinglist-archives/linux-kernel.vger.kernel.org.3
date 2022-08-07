Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4280F58BB5B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 16:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbiHGOxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 10:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbiHGOxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 10:53:15 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D071A448
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 07:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659883980; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DG90t3myM/UGW+Xa4zE2jhg4qZfAFetzVaKv0EyBt5w=;
        b=xSgds//oJREwk0y54hRaPWujH58h/mIN9nKdMcCd4zzTpOYHNTAgtLPs8WS/azFsbtkowB
        ot7MpzjEddeXTO9YQryQw8zgjIDNefT4nxnOAYs2hLUbtkPwP1/3vW1tfXFG+/iAdoY29a
        Na9Zl6HXwLxs+s8SDQqAl34CPOrmZCk=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 01/28] mfd: 88pm80x: Remove #ifdef guards for PM related functions
Date:   Sun,  7 Aug 2022 16:52:20 +0200
Message-Id: <20220807145247.46107-2-paul@crapouillou.net>
In-Reply-To: <20220807145247.46107-1-paul@crapouillou.net>
References: <20220807145247.46107-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new EXPORT_GPL_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros
to handle the .suspend/.resume callbacks.

These macros allow the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards.

The advantage is then that these functions are now always compiled
independently of any Kconfig option, and thanks to that bugs and
regressions are easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mfd/88pm800.c | 2 +-
 drivers/mfd/88pm805.c | 2 +-
 drivers/mfd/88pm80x.c | 5 +----
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index eaf9845633b4..409f0996ae1d 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -599,7 +599,7 @@ static int pm800_remove(struct i2c_client *client)
 static struct i2c_driver pm800_driver = {
 	.driver = {
 		.name = "88PM800",
-		.pm = &pm80x_pm_ops,
+		.pm = pm_sleep_ptr(&pm80x_pm_ops),
 		},
 	.probe = pm800_probe,
 	.remove = pm800_remove,
diff --git a/drivers/mfd/88pm805.c b/drivers/mfd/88pm805.c
index ada6c513302b..724ac4947e6f 100644
--- a/drivers/mfd/88pm805.c
+++ b/drivers/mfd/88pm805.c
@@ -254,7 +254,7 @@ static int pm805_remove(struct i2c_client *client)
 static struct i2c_driver pm805_driver = {
 	.driver = {
 		.name = "88PM805",
-		.pm = &pm80x_pm_ops,
+		.pm = pm_sleep_ptr(&pm80x_pm_ops),
 		},
 	.probe = pm805_probe,
 	.remove = pm805_remove,
diff --git a/drivers/mfd/88pm80x.c b/drivers/mfd/88pm80x.c
index be036e7e787b..ac4f08565f29 100644
--- a/drivers/mfd/88pm80x.c
+++ b/drivers/mfd/88pm80x.c
@@ -129,7 +129,6 @@ int pm80x_deinit(void)
 }
 EXPORT_SYMBOL_GPL(pm80x_deinit);
 
-#ifdef CONFIG_PM_SLEEP
 static int pm80x_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -153,10 +152,8 @@ static int pm80x_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-SIMPLE_DEV_PM_OPS(pm80x_pm_ops, pm80x_suspend, pm80x_resume);
-EXPORT_SYMBOL_GPL(pm80x_pm_ops);
+EXPORT_GPL_SIMPLE_DEV_PM_OPS(pm80x_pm_ops, pm80x_suspend, pm80x_resume);
 
 MODULE_DESCRIPTION("I2C Driver for Marvell 88PM80x");
 MODULE_AUTHOR("Qiao Zhou <zhouqiao@marvell.com>");
-- 
2.35.1

