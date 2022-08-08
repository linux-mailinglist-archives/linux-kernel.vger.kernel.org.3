Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBEE58CD03
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243908AbiHHRsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244552AbiHHRqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:46:11 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9C417E32
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659980508; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/fNX/ttuDiI3uxQdqB3fB+Ou1WPOijArfObsH7/WKDQ=;
        b=Aj6iYilTBvfSNoiG4MIRuGyxzYbdc4uBYL/wbwxkFBrpGw1ZNz+nf/ZYb4/+LVIa+VqDr6
        ebI91VCTekf0NnrZBZ66QJsKjxehCWZ1uIGyyERyDypCjcMLa7omqn6/V6mK0rhBO6Zvyk
        v5R99uJLVo4SZuxWNk3tc6j/wUKz3rY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 28/30] mfd: tc3589x: Remove #ifdef guards for PM related functions
Date:   Mon,  8 Aug 2022 19:41:05 +0200
Message-Id: <20220808174107.38676-29-paul@crapouillou.net>
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
 drivers/mfd/tc3589x.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
index 13583cdb93b6..ab7e0f6f5489 100644
--- a/drivers/mfd/tc3589x.c
+++ b/drivers/mfd/tc3589x.c
@@ -438,7 +438,6 @@ static int tc3589x_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int tc3589x_suspend(struct device *dev)
 {
 	struct tc3589x *tc3589x = dev_get_drvdata(dev);
@@ -466,9 +465,9 @@ static int tc3589x_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(tc3589x_dev_pm_ops, tc3589x_suspend, tc3589x_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(tc3589x_dev_pm_ops,
+				tc3589x_suspend, tc3589x_resume);
 
 static const struct i2c_device_id tc3589x_id[] = {
 	{ "tc35890", TC3589X_TC35890 },
@@ -485,7 +484,7 @@ MODULE_DEVICE_TABLE(i2c, tc3589x_id);
 static struct i2c_driver tc3589x_driver = {
 	.driver = {
 		.name	= "tc3589x",
-		.pm	= &tc3589x_dev_pm_ops,
+		.pm	= pm_sleep_ptr(&tc3589x_dev_pm_ops),
 		.of_match_table = of_match_ptr(tc3589x_match),
 	},
 	.probe		= tc3589x_probe,
-- 
2.35.1

