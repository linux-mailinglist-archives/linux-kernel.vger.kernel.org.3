Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA75158CCF0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244324AbiHHRp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243791AbiHHRox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:44:53 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C86818B0D
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659980505; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0I+mSneVr477xNU9unTc0UxMGLtgIxgnptmVK+wu/7U=;
        b=NdfhkT4zPkFoFXPQfeTmdmzC8xHSFC57HtuRxWElV7h2veZRvFgK8Ae3w5xNLlNyDxK1WG
        aRjoikqMLXSxFWz9PAD/XxzuUx/d7oqKzcaoxDcL33EkSte/p9ICfCEqjQaqm4EdQrniTP
        rHgUJ9aKHN2ltEpNOI3F+RDCqzNPx0s=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        patches@opensource.cirrus.com
Subject: [PATCH v2 18/30] mfd: wm8994: Remove #ifdef guards for PM related functions
Date:   Mon,  8 Aug 2022 19:40:55 +0200
Message-Id: <20220808174107.38676-19-paul@crapouillou.net>
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

Use the new RUNTIME_PM_OPS() and pm_ptr() macros to handle the
.runtime_suspend/.runtime_resume callbacks.

These macros allow the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_PM is disabled, without having
to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Note that this driver should probably use the new
DEFINE_RUNTIME_DEV_PM_OPS() macro instead, which will provide
.suspend/.resume callbacks, pointing to pm_runtime_force_suspend() and
pm_runtime_force_resume() respectively; unless those callbacks really
aren't needed.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
Cc: patches@opensource.cirrus.com

 drivers/mfd/wm8994-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index 7b1d270722ba..a27a13b5ae1e 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -110,7 +110,6 @@ static const char *wm8958_main_supplies[] = {
 	"SPKVDD2",
 };
 
-#ifdef CONFIG_PM
 static int wm8994_suspend(struct device *dev)
 {
 	struct wm8994 *wm8994 = dev_get_drvdata(dev);
@@ -213,7 +212,6 @@ static int wm8994_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
 #ifdef CONFIG_REGULATOR
 static int wm8994_ldo_in_use(struct wm8994_pdata *pdata, int ldo)
@@ -676,13 +674,13 @@ static const struct i2c_device_id wm8994_i2c_id[] = {
 MODULE_DEVICE_TABLE(i2c, wm8994_i2c_id);
 
 static const struct dev_pm_ops wm8994_pm_ops = {
-	SET_RUNTIME_PM_OPS(wm8994_suspend, wm8994_resume, NULL)
+	RUNTIME_PM_OPS(wm8994_suspend, wm8994_resume, NULL)
 };
 
 static struct i2c_driver wm8994_i2c_driver = {
 	.driver = {
 		.name = "wm8994",
-		.pm = &wm8994_pm_ops,
+		.pm = pm_ptr(&wm8994_pm_ops),
 		.of_match_table = wm8994_of_match,
 	},
 	.probe = wm8994_i2c_probe,
-- 
2.35.1

