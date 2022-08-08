Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E62158CCDD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243835AbiHHRmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244256AbiHHRlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:41:52 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9291E242
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659980496; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DrQfVq26IcEBKrFEtoBOOzSjXtsyVbn1/l3uB8Ev+4g=;
        b=VdTOuxe0og2OIj9Xu6F+oBZdblZC7WCpFX7/vTcR1IOigKhKm15Yy31mWBN6xDLfbFNJvd
        P5ZDY25RMAoP+7MX7U7ID6sh8wk6Dj7As/bWBBjksS1OlYIvfwGUOXgPhRti/SOJtcNc2e
        RCtKYZXYxvNF41mMG0lnv+jxc/iui7Q=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 02/30] mfd: 88pm80x: Remove #ifdef guards for PM related functions
Date:   Mon,  8 Aug 2022 19:40:39 +0200
Message-Id: <20220808174107.38676-3-paul@crapouillou.net>
In-Reply-To: <20220808174107.38676-1-paul@crapouillou.net>
References: <20220808174107.38676-1-paul@crapouillou.net>
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

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

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

