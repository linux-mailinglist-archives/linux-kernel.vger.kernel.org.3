Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7326858CCED
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244229AbiHHRo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244113AbiHHRoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:44:18 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9075563B6
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659980504; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VklgnW+uBOCoO+RRy4aqJ12OaIfCdghjrJSE0/tnQoc=;
        b=zSYIwMp6uX0sRRviam+G6zhsFCB8ajQZck64q70qCnD2prhfZ+gjuumwAr7500d7vLLeKV
        5WDCGcM0TGcK/D/vHT6c4Pn3gV8zv0qSs1DSXf/ZTno45xY2JYMfw+WQ/+MhlzSq9lvNgK
        tJLFbBa/wABfSnRscA5ULM8eZU/3xTw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 16/30] mfd: tc6387xb: Remove #ifdef guards for PM related functions
Date:   Mon,  8 Aug 2022 19:40:53 +0200
Message-Id: <20220808174107.38676-17-paul@crapouillou.net>
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

Use the new pm_sleep_ptr() macro to handle the .suspend/.resume
callbacks.

This macro allow the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mfd/tc6387xb.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/tc6387xb.c b/drivers/mfd/tc6387xb.c
index e846e4d26b6e..5392da6ba7b0 100644
--- a/drivers/mfd/tc6387xb.c
+++ b/drivers/mfd/tc6387xb.c
@@ -40,7 +40,6 @@ static const struct resource tc6387xb_mmc_resources[] = {
 
 /*--------------------------------------------------------------------------*/
 
-#ifdef CONFIG_PM
 static int tc6387xb_suspend(struct platform_device *dev, pm_message_t state)
 {
 	struct tc6387xb *tc6387xb = platform_get_drvdata(dev);
@@ -67,10 +66,6 @@ static int tc6387xb_resume(struct platform_device *dev)
 
 	return 0;
 }
-#else
-#define tc6387xb_suspend  NULL
-#define tc6387xb_resume   NULL
-#endif
 
 /*--------------------------------------------------------------------------*/
 
@@ -220,8 +215,8 @@ static struct platform_driver tc6387xb_platform_driver = {
 	},
 	.probe		= tc6387xb_probe,
 	.remove		= tc6387xb_remove,
-	.suspend        = tc6387xb_suspend,
-	.resume         = tc6387xb_resume,
+	.suspend        = pm_sleep_ptr(tc6387xb_suspend),
+	.resume         = pm_sleep_ptr(tc6387xb_resume),
 };
 
 module_platform_driver(tc6387xb_platform_driver);
-- 
2.35.1

