Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEEA58CCFA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244560AbiHHRqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244285AbiHHRpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:45:34 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD03F17AB8
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659980506; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZTOh/DJEKm5OORU+VL2HYVlTpdP0B/Y4xYOEC3z16sg=;
        b=1q+aAmNItDZxCOFuOinKDCk0Vjj1vG7X0m89jcE4xstThzpKA+0uGYPCqMcYnmj5WE13tW
        FPapqwsJo/dmJVsJY6PrlFX7w9kevidtORPCa5vocRexiwUXdszSHOmSOEfE9/9pt90APB
        8Nqi8F62HpDDt687BVrrKPGcVxd/zdI=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 23/30] mfd: max77686: Remove #ifdef guards for PM related functions
Date:   Mon,  8 Aug 2022 19:41:00 +0200
Message-Id: <20220808174107.38676-24-paul@crapouillou.net>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

 drivers/mfd/max77686.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
index 2ac64277fb84..f8e863f3fc95 100644
--- a/drivers/mfd/max77686.c
+++ b/drivers/mfd/max77686.c
@@ -226,7 +226,6 @@ static int max77686_i2c_probe(struct i2c_client *i2c)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int max77686_suspend(struct device *dev)
 {
 	struct i2c_client *i2c = to_i2c_client(dev);
@@ -261,14 +260,13 @@ static int max77686_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
-static SIMPLE_DEV_PM_OPS(max77686_pm, max77686_suspend, max77686_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(max77686_pm, max77686_suspend, max77686_resume);
 
 static struct i2c_driver max77686_i2c_driver = {
 	.driver = {
 		   .name = "max77686",
-		   .pm = &max77686_pm,
+		   .pm = pm_sleep_ptr(&max77686_pm),
 		   .of_match_table = max77686_pmic_dt_match,
 	},
 	.probe_new = max77686_i2c_probe,
-- 
2.35.1

