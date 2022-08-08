Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7864658CCF8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244330AbiHHRpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243584AbiHHRpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:45:03 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DC318386
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659980505; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p6dlhZlwLIf/lPMpMtYZKWAT+azhK3anbKwIEZa9zE8=;
        b=03XgveK0GjWwg7BQolE/xInBECCiB5X73Pq+lyMDyzLNIzRwQuZK5O21iVGRuxYFTrYsum
        mH050Rnq+FRWjRrvcrUNCNXWwbIG/VGpF9YTFXzgbIkoVsG7aKWrAqk1Qi+6QY6ykNNQzC
        Lwfc3aAGkhecQkdduWaGToSZ1/vGXIQ=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 19/30] mfd: max77620: Remove #ifdef guards for PM related functions
Date:   Mon,  8 Aug 2022 19:40:56 +0200
Message-Id: <20220808174107.38676-20-paul@crapouillou.net>
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

Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros
to handle the .suspend/.resume callbacks.

These macros allow the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mfd/max77620.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index a6661e07035b..42fa9c4b97aa 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -576,7 +576,6 @@ static int max77620_probe(struct i2c_client *client,
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int max77620_set_fps_period(struct max77620_chip *chip,
 				   int fps_id, int time_period)
 {
@@ -683,7 +682,6 @@ static int max77620_i2c_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct i2c_device_id max77620_id[] = {
 	{"max77620", MAX77620},
@@ -692,14 +690,13 @@ static const struct i2c_device_id max77620_id[] = {
 	{},
 };
 
-static const struct dev_pm_ops max77620_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(max77620_i2c_suspend, max77620_i2c_resume)
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(max77620_pm_ops,
+				max77620_i2c_suspend, max77620_i2c_resume);
 
 static struct i2c_driver max77620_driver = {
 	.driver = {
 		.name = "max77620",
-		.pm = &max77620_pm_ops,
+		.pm = pm_sleep_ptr(&max77620_pm_ops),
 	},
 	.probe = max77620_probe,
 	.id_table = max77620_id,
-- 
2.35.1

