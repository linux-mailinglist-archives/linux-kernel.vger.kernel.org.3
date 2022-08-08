Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB1658CCE7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244311AbiHHRoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244315AbiHHRna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:43:30 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DABBCA
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659980503; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DbwQc0Ju19xD2mWEaWAqDllFKFW7biQlR2zUxZczCrM=;
        b=G9DCQXebRw8jJ0alZ2d+6uTEOO0b3CzWVkoP+3R1hF5Gj57g+7nP+63NlGzKN5LhjtciYK
        Lguq/EZR4+mnjzyHyKBoRBaE4OweRVERJa3hIvcTm3SSyb7cFZYJHK+W6jjITiTxVVZltN
        gtf4Y1VMmTG/YRTD6ThaMviH5LyZAfg=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v2 12/30] mfd: intel_soc_pmic: Remove #ifdef guards for PM related functions
Date:   Mon,  8 Aug 2022 19:40:49 +0200
Message-Id: <20220808174107.38676-13-paul@crapouillou.net>
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
Cc: Andy Shevchenko <andy@kernel.org>

 drivers/mfd/intel_soc_pmic_core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_core.c b/drivers/mfd/intel_soc_pmic_core.c
index 5e8c94e008ed..96303aa87bc1 100644
--- a/drivers/mfd/intel_soc_pmic_core.c
+++ b/drivers/mfd/intel_soc_pmic_core.c
@@ -104,7 +104,6 @@ static void intel_soc_pmic_shutdown(struct i2c_client *i2c)
 	return;
 }
 
-#if defined(CONFIG_PM_SLEEP)
 static int intel_soc_pmic_suspend(struct device *dev)
 {
 	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
@@ -122,10 +121,9 @@ static int intel_soc_pmic_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(intel_soc_pmic_pm_ops, intel_soc_pmic_suspend,
-			 intel_soc_pmic_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(intel_soc_pmic_pm_ops, intel_soc_pmic_suspend,
+				intel_soc_pmic_resume);
 
 static const struct i2c_device_id intel_soc_pmic_i2c_id[] = {
 	{ }
@@ -143,7 +141,7 @@ MODULE_DEVICE_TABLE(acpi, intel_soc_pmic_acpi_match);
 static struct i2c_driver intel_soc_pmic_i2c_driver = {
 	.driver = {
 		.name = "intel_soc_pmic_i2c",
-		.pm = &intel_soc_pmic_pm_ops,
+		.pm = pm_sleep_ptr(&intel_soc_pmic_pm_ops),
 		.acpi_match_table = ACPI_PTR(intel_soc_pmic_acpi_match),
 	},
 	.probe = intel_soc_pmic_i2c_probe,
-- 
2.35.1

