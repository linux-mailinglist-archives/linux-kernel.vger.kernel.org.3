Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B22455EDFE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiF1ToC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiF1Tnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:43:42 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11223BBD6;
        Tue, 28 Jun 2022 12:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1656444904; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2cxFk3POH1G+70dQzVB6iX87jrhQcrT/GWJ2/9NWyAg=;
        b=U/LkpYRKyEouw/RFIPSulE95izS8D0UrEn5ZywT6gdTqZfEdUbZKZ4Biij1HhUigPq637v
        PLeVVqPhLZ6zb7hnnk531ceAIBmFEUD7IFyRXmBQ9jG7SNyagqYaElrcydZcPyOk9g/Mzc
        IhGXt/fwVwHQOdKF38w/PesWq+ww5eE=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH 7/8] watchdog: tegra_wdt: Remove #ifdef guards for PM related functions
Date:   Tue, 28 Jun 2022 20:34:48 +0100
Message-Id: <20220628193449.160585-8-paul@crapouillou.net>
In-Reply-To: <20220628193449.160585-1-paul@crapouillou.net>
References: <20220628193449.160585-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros to
handle the .suspend/.resume callbacks.

These macros allow the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards. Not using #ifdef guards means that the code is
always compiled independently of any Kconfig option, and thanks to that
bugs and regressions are easier to catch.

While at it, the functions tegra_wdt_runtime_{suspend,resume} were
renamed to tegra_wdt_{suspend,resume}, as they are *not* runtime-PM
callbacks, but standard system suspend/resume callbacks.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org
---
 drivers/watchdog/tegra_wdt.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/tegra_wdt.c b/drivers/watchdog/tegra_wdt.c
index dfe06e506cad..d5de6c0657a5 100644
--- a/drivers/watchdog/tegra_wdt.c
+++ b/drivers/watchdog/tegra_wdt.c
@@ -230,8 +230,7 @@ static int tegra_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int tegra_wdt_runtime_suspend(struct device *dev)
+static int tegra_wdt_suspend(struct device *dev)
 {
 	struct tegra_wdt *wdt = dev_get_drvdata(dev);
 
@@ -241,7 +240,7 @@ static int tegra_wdt_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int tegra_wdt_runtime_resume(struct device *dev)
+static int tegra_wdt_resume(struct device *dev)
 {
 	struct tegra_wdt *wdt = dev_get_drvdata(dev);
 
@@ -250,7 +249,6 @@ static int tegra_wdt_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct of_device_id tegra_wdt_of_match[] = {
 	{ .compatible = "nvidia,tegra30-timer", },
@@ -258,16 +256,14 @@ static const struct of_device_id tegra_wdt_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tegra_wdt_of_match);
 
-static const struct dev_pm_ops tegra_wdt_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(tegra_wdt_runtime_suspend,
-				tegra_wdt_runtime_resume)
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(tegra_wdt_pm_ops,
+				tegra_wdt_suspend, tegra_wdt_resume);
 
 static struct platform_driver tegra_wdt_driver = {
 	.probe		= tegra_wdt_probe,
 	.driver		= {
 		.name	= "tegra-wdt",
-		.pm	= &tegra_wdt_pm_ops,
+		.pm	= pm_sleep_ptr(&tegra_wdt_pm_ops),
 		.of_match_table = tegra_wdt_of_match,
 	},
 };
-- 
2.35.1

