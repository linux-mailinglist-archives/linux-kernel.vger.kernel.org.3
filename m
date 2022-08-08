Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEAF58CD01
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244011AbiHHRr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244514AbiHHRqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:46:04 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A17627D
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659980507; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z0TOf7NCTCNZLEJUd0n3YWp93p2MEOQ2XhRWmHJulpk=;
        b=rMgv++6XK2xdJknO31ryPaoawJDkx77mVzmGwzj1bCiQbqPpOKQuY7Snak2IVPYIeIcZTX
        J/6sWTX0o9bKJSo7eIPrlIm9B6LAPwIKxrng0Kwg4o6n0IuTTfMoytD0WULKBOEuD9zKN6
        h2ctYA8WDLGslUmH4V0KrHt1I7BVoQ0=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 26/30] mfd: stmfx: Remove #ifdef guards for PM related functions
Date:   Mon,  8 Aug 2022 19:41:03 +0200
Message-Id: <20220808174107.38676-27-paul@crapouillou.net>
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

V2: remove CONFIG_PM wrapper around fields in private struct

Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org

 drivers/mfd/stmfx.c       | 6 ++----
 include/linux/mfd/stmfx.h | 2 --
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index 122f96094410..94af27346669 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -476,7 +476,6 @@ static int stmfx_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int stmfx_suspend(struct device *dev)
 {
 	struct stmfx *stmfx = dev_get_drvdata(dev);
@@ -542,9 +541,8 @@ static int stmfx_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(stmfx_dev_pm_ops, stmfx_suspend, stmfx_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(stmfx_dev_pm_ops, stmfx_suspend, stmfx_resume);
 
 static const struct of_device_id stmfx_of_match[] = {
 	{ .compatible = "st,stmfx-0300", },
@@ -556,7 +554,7 @@ static struct i2c_driver stmfx_driver = {
 	.driver = {
 		.name = "stmfx-core",
 		.of_match_table = stmfx_of_match,
-		.pm = &stmfx_dev_pm_ops,
+		.pm = pm_sleep_ptr(&stmfx_dev_pm_ops),
 	},
 	.probe = stmfx_probe,
 	.remove = stmfx_remove,
diff --git a/include/linux/mfd/stmfx.h b/include/linux/mfd/stmfx.h
index 744dce63946e..967a2e486800 100644
--- a/include/linux/mfd/stmfx.h
+++ b/include/linux/mfd/stmfx.h
@@ -113,10 +113,8 @@ struct stmfx {
 	struct irq_domain *irq_domain;
 	struct mutex lock; /* IRQ bus lock */
 	u8 irq_src;
-#ifdef CONFIG_PM
 	u8 bkp_sysctrl;
 	u8 bkp_irqoutpin;
-#endif
 };
 
 int stmfx_function_enable(struct stmfx *stmfx, u32 func);
-- 
2.35.1

